Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSGAM0r>; Mon, 1 Jul 2002 08:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSGAM0q>; Mon, 1 Jul 2002 08:26:46 -0400
Received: from imailg1.svr.pol.co.uk ([195.92.195.179]:63557 "EHLO
	imailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S315491AbSGAM0p>; Mon, 1 Jul 2002 08:26:45 -0400
Message-Id: <200207011229.g61CT8e07385@blake.inputplus.co.uk>
To: Brad Hards <bhards@bigpond.net.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18. 
In-Reply-To: Message from Brad Hards <bhards@bigpond.net.au> 
   of "Mon, 01 Jul 2002 21:24:20 +1000." <200207012124.20330.bhards@bigpond.net.au> 
Date: Mon, 01 Jul 2002 13:29:08 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Brad,

> > For example, typing `swa' rapidly produces `swaw'.
>
> What is the event interface (dev/input/eventX) showing for this type
> of input?

I was previously unaware of /dev/input/* and unfortunately I get ENODEV
for all of the event* files in there.

However, adding printk()s to usbkbd.c:usb_kbd_irq() gives

     1  new: 00 00 16 00 00 00 00 00 s
     2  old: 00 00 00 00 00 00 00 00
     3  leds: 0 newleds: 0 open: 1
     4  new: 00 00 1a 16 00 00 00 00 ws
     5  old: 00 00 16 00 00 00 00 00 s
     6  leds: 0 newleds: 0 open: 1
     7  new: 00 00 01 01 01 01 01 01 ErrorRollover
     8  old: 00 00 1a 16 00 00 00 00 ws
     9  leds: 0 newleds: 0 open: 1
    10  new: 00 00 04 1a 00 00 00 00 aw
    11  old: 00 00 01 01 01 01 01 01 ErrorRollover
    12  leds: 0 newleds: 0 open: 1
    13  new: 00 00 04 00 00 00 00 00 a
    14  old: 00 00 04 1a 00 00 00 00 aw
    15  leds: 0 newleds: 0 open: 1
    16  new: 00 00 00 00 00 00 00 00
    17  old: 00 00 04 00 00 00 00 00 a
    18  leds: 0 newleds: 0 open: 1

usb_kbd_irq() ignores the possibility of ErrorRollover so its
comparision of old and new at #10 generates the extra `w'.  (The `s',
etc., at the end of some lines is my interpretation of the data.)

This is the device.

    T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
    D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
    P:  Vendor=0472 ProdID=0065 Rev= 1.00
    S:  Manufacturer=Chicony 
    S:  Product=PFU-65 USB Keyboard
    C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
    I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=keyboard
    E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl= 24ms

    $ od -t x1 /proc/bus/usb/002/003 
    0000000 12 01 10 01 00 00 00 08 72 04 65 00 00 01 03 04
    0000020 00 01 09 02 22 00 01 01 04 e0 00 09 04 00 00 01
    0000040 03 01 01 00 09 21 00 01 00 01 22 41 00 07 05 81
    0000060 03 08 00 18
    0000064

> >     keys produces
> >     rty    rtty
> >     yui    yuui
> >     tyu    tyuy
> >     swa    swaw
> >     jhg    jhgh
> >
> > But other won't show the problem, e.g. `zxc', `asd', and `qwe'.
> >
> > My theory is that usbkbd.o doesn't cope with ErrorRollover which is
> > being generated, unlike hid.o which didn't used to but does now.
>
> Err, how do you reconcile that with only seeing it on some keys?

The keyboard matrix.  It can cope with `qwe' all being pressed at once,
but not `swa'.  It realises it can't give a reliable answer and
generates ErrorRollover as the USB spec. suggests.

> BTW: usbkbd isn't meant for real work. You should use full HID.

I'll try and use hid.o instead, usbkbd.o was just picked by this Red Hat
7.2 system on adding the keyboard.  However, I'd still be interested in
confirming if it is a problem with usbkbd.c or Happy Hacker's
interpretation of the spec.

Cheers,


Ralph.

