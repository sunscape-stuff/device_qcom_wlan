#!/vendor/bin/sh
# Copyright (c) 2019, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#

runcon u:r:vendor_modprobe:s0 /vendor/bin/modprobe -a -d /vendor/lib/modules cnss2

if [ ! -f /vendor/lib/modules/qca_cld3_wlan.ko ]; then
	if lspci -kn |grep cnss_pci|grep ":1100";then
		setprop ro.vendor.wlan.chip qca6290
	elif lspci -kn |grep cnss_pci|grep ":003e";then
		setprop ro.vendor.wlan.chip qca6174
		setprop ro.vendor.wlan.aware false
		setprop ro.vendor.wlan.11ax false
		setprop ro.vendor.wlan.sta_plus_sta false
	elif lspci -kn |grep cnss_pci|grep ":1101";then
		setprop ro.vendor.wlan.chip qca6390
	elif lspci -kn |grep cnss_pci|grep ":1102";then
		setprop ro.vendor.wlan.chip qcn7605
		setprop ro.vendor.wlan.apf false
		setprop ro.vendor.wlan.11ax false
		setprop ro.vendor.wlan.aware false
	fi
else
	setprop ro.vendor.wlan.chip wlan
fi

runcon u:r:vendor_modprobe:s0 /vendor/bin/modprobe -a -d /vendor/lib/modules qca_cld3_$(getprop ro.vendor.wlan.chip)
setprop vendor.wlan.driver.status "ok"
