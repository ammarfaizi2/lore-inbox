Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263634AbUDFGtS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 02:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUDFGtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 02:49:18 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:34794 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S263634AbUDFGtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 02:49:07 -0400
Subject: Re: regression: oops with usb bcm203x bluetooth dongle 2.6.5
From: Soeren Sonnenburg <kernel@nn7.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1081207065.17215.6.camel@pegasus>
References: <1081196482.3591.5.camel@localhost>
	 <1081199370.2843.20.camel@pegasus>  <1081200442.3591.38.camel@localhost>
	 <1081201227.2843.27.camel@pegasus>  <1081201957.3590.49.camel@localhost>
	 <1081207065.17215.6.camel@pegasus>
Content-Type: text/plain
Message-Id: <1081234112.2042.2.camel@localhost>
Mime-Version: 1.0
Date: Tue, 06 Apr 2004 08:48:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 01:17, Marcel Holtmann wrote: 
> Hi Soeren,
> 
> > That is why I removed all the bluefw stuff in /etc/hotplug before
> > testing bluetooth again... but it still oopsed.
> 
> maybe you wanna try 2.6.5-mh1 from http://www.bluez.org/patches.html
Alright so I did zcat patch.gz | patch -p0  and a make && make
modules_install and rebooted in the new 2.6.5-mh1 kernel.

Same oops again (see below)!
To be 100% sure I renamed /sbin/bluefw to /sbin/bluefw.inactive (same
oops once again). Then I renamed /sbin/hotplug to /sbin/hotplug.inactive
and manually modprobe bcm203x and then hci_usb.

This time firmware is loaded without any trouble (but this is the very
very rare case it never worked again ...) and hci0 is there and seems to
work...

So I rmmod bcm203x firmware_class hci_usb and wondered what could go
wrong when I do the very same with hotplug ?

So I had a look at the hotplug script and tried to process command by
command manually. Args with which the firmware script is called:
ACTION: add
SYSFS: /sys
DEVPATH: /class/firmware/1-1
FIRMWARE: BCM2033-MD.hex

FIRMWARE_DIR=/usr/lib/hotplug/firmware

# mountpoint of sysfs
SYSFS=$(sed -n 's/^.* \([^ ]*\) sysfs .*$/\1/p' /proc/mounts)

# use /proc for 2.4 kernels
if [ "$SYSFS" = "" ]; then
    SYSFS=/proc
fi

#
# What to do with this firmware hotplug event?
#
case "$ACTION" in

add)
    if [ ! -e $SYSFS/$DEVPATH/loading ]; then
        sleep 1
    fi

    if [ -f "$FIRMWARE_DIR/$FIRMWARE" ]; then
        echo 1 > $SYSFS/$DEVPATH/loading
        cp "$FIRMWARE_DIR/$FIRMWARE" $SYSFS/$DEVPATH/data
        echo 0 > $SYSFS/$DEVPATH/loading
    else
        echo -1 > $SYSFS/$DEVPATH/loading
    fi

    ;;


I realized that when I use e.g

...
add)
    n=0;
    while [ $n -lt 10 ] && [ ! -e $SYSFS/$DEVPATH/loading ]; do
        sleep 1
        let n++
    done

    if [ -e $SYSFS/$DEVPATH/loading ]; then
        if [ -f "$FIRMWARE_DIR/$FIRMWARE" ]; then
            echo 1 > $SYSFS/$DEVPATH/loading
            cp "$FIRMWARE_DIR/$FIRMWARE" $SYSFS/$DEVPATH/data
            echo 0 > $SYSFS/$DEVPATH/loading
        else
            echo -1 > $SYSFS/$DEVPATH/loading
        fi
    fi

I don't get any more oopses.

But still firmware loading does not anymore work (without bluefw)

HTH,
Soeren.

devfs_mk_dev: could not append to parent for bluetooth/rfcomm/0
usb 1-1: new full speed USB device using address 2
Bluetooth: Broadcom Blutonium firmware driver ver 1.0
drivers/usb/core/usb.c: registered new driver bcm203x
usb 1-1: USB disconnect, address 2
usb 1-1: new full speed USB device using address 3
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C0260554 LR: C02607F8 SP: EFEB9D00 REGS: efeb9c50 TRAP: 0301    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000004, DSISR: 40000000
TASK = c1aee000[5] 'khubd' Last syscall: -1
GPR00: C02607F8 EFEB9D00 C1AEE000 EFCAE550 EE8B5CF4 00000000 EE874A90 C04622C4
GPR08: 00009032 00000017 00010C00 C04F9958 82008022
Call trace:
[c02607f8] usb_set_interface+0x94/0x164
[f2443ab4] hci_usb_probe+0x21c/0x48c [hci_usb]
[c0259f88] usb_probe_interface+0x80/0x98
[c01f5fac] bus_match+0x50/0x8c
[c01f6040] device_attach+0x58/0xbc
[c01f62c0] bus_add_device+0x7c/0xd8
[c01f4b60] device_add+0xb0/0x184
[c0260be4] usb_set_configuration+0x20c/0x25c
[c025b2c4] usb_new_device+0x2bc/0x3d4
[c025cd24] hub_port_connect_change+0x1a0/0x298
[c025d0f0] hub_events+0x2d4/0x354
[c025d1ac] hub_thread+0x3c/0xf4
[c000914c] kernel_thread+0x44/0x60


