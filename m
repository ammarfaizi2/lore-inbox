Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbUDEVlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbUDEVjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:39:00 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:10493 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S263370AbUDEV17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:27:59 -0400
Subject: Re: regression: oops with usb bcm203x bluetooth dongle 2.6.5
From: Soeren Sonnenburg <kernel@nn7.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1081199370.2843.20.camel@pegasus>
References: <1081196482.3591.5.camel@localhost>
	 <1081199370.2843.20.camel@pegasus>
Content-Type: text/plain
Message-Id: <1081200442.3591.38.camel@localhost>
Mime-Version: 1.0
Date: Mon, 05 Apr 2004 23:27:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-05 at 23:09, Marcel Holtmann wrote:
> Hi Soeren,
> 
> > This dongle used to work fine (at least till 2.6.3) and still does if I
> > remove the bcm203x kernel module and manually (or via hotplug) use the
> > bluefw program to upload the firmware.
> > 
> > This dongle gives me an oops on _insert_.
> > Mass storage devices/HID work fine.
> > 
> > This is on a ppc machine with xmon support compiled in. So if you need
> > more infos than this backtrace, please say so.
> > 
> > usb 1-1: new full speed USB device using address 5
> > Bluetooth: Broadcom Blutonium firmware driver ver 1.0
> > Bluetooth: HCI USB driver ver 2.5
> > drivers/usb/core/usb.c: registered new driver bcm203x
> > drivers/usb/core/usb.c: registered new driver hci_usb
> > usb 1-1: USB disconnect, address 5
> > usb 1-1: new full speed USB device using address 6
> > Oops: kernel access of bad area, sig: 11 [#1]
> > NIP: C0260554 LR: C02607F8 SP: EFEB9D00 REGS: efeb9c50 TRAP: 0301    Not tainted
> > MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > DAR: 00000004, DSISR: 40000000
> > TASK = c1aee000[5] 'khubd' Last syscall: -1
> > GPR00: C02607F8 EFEB9D00 C1AEE000 E9B51A2C EE5246AC 00000000 EC987A64 C046273C
> > GPR08: 00009032 00000008 00010C00 C04F9958 82008022
> > Call trace:
> > [c02607f8] usb_set_interface+0x94/0x164
> > [f2506ab4] hci_usb_probe+0x21c/0x48c [hci_usb]
> > [c0259f88] usb_probe_interface+0x80/0x98
> > [c01f5fac] bus_match+0x50/0x8c
> > [c01f6040] device_attach+0x58/0xbc
> > [c01f62c0] bus_add_device+0x7c/0xd8
> > [c01f4b60] device_add+0xb0/0x184
> > [c0260be4] usb_set_configuration+0x20c/0x25c
> > [c025b2c4] usb_new_device+0x2bc/0x3d4
> > [c025cd24] hub_port_connect_change+0x1a0/0x298
> > [c025d0f0] hub_events+0x2d4/0x354
> > [c025d1ac] hub_thread+0x3c/0xf4
> > [c000914c] kernel_thread+0x44/0x60
> 
> the bcm203x is only a firmware loader driver and after firmware load the
> device resets and should be driven by the hci_usb driver. Does it still
> oopses if you remove the hci_usb module from the module directory? What
> I don't understand is that the oops comes from the hci_usb driver.

The interesting thing is that it did _not_ oops when I remove
/sbin/hotplug (version 0.0.20040329-4). Also step by step modprobing
hci_usb / bcm203x does not cause any trouble (but does not work either,
even when rmmoding modprobing again for some time). It outputs:

modprobe bcm203x

Bluetooth: Broadcom Blutonium firmware driver ver 1.0
bcm203x_probe: Mini driver request failed
bcm203x: probe of 1-1:1.0 failed with error -5
usb 1-1: bulk timeout on ep1in
usbfs: USBDEVFS_BULK failed dev 3 ep 0x81 len 10 ret -110

So it seems the firmware is loaded or hci_usb is started while the
device is not yet ready.

Calling bluefw sometimes also timeouts but mostly works...

When the firmware is finally loaded bluetooth operates perfectly...

HTH,
Soeren

