Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTEMUQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbTEMUQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:16:04 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:49793 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id S262482AbTEMUP5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:15:57 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm4
References: <20030512225504.4baca409.akpm@digeo.com>
	<87vfwf8h2n.fsf@lapper.ihatent.com>
	<20030513001135.2395860a.akpm@digeo.com>
	<87n0hr8edh.fsf@lapper.ihatent.com>
	<20030513011232.67c300d0.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 13 May 2003 22:28:43 +0200
In-Reply-To: <20030513011232.67c300d0.akpm@digeo.com>
Message-ID: <87addq7fr8.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton <akpm@digeo.com> writes:

> Alexander Hoogerhuis <alexh@ihatent.com> wrote:
> >
> > kernel/built-in.o(.text+0x1005): In function `schedule':
> >  : undefined reference to `active_load_balance'
> 
> I don't quite see how that can happen.  Tried a `make clean'?

Quoth Dr. Frankesteen: "It's alive!". Helge's oneliner in shced.h did
the trick. After patching in a custom DSDT, this is my leftover list
of things that go boom on recent kernels:

* During shutdown, whilst stopping hotplug and unloading usb hub
  drivers, machine freezes hard. Last printout is something along
  these lines:

        "usb-ohci 02:0e.2, address 3", or some such.

  Then the machine becomes a doorstop.

* Synaptics touchpad driver as of 2.5.69 does not recognise the "tap
  to click" functionality, and doesn't seem parse it's boot param to
  enable it, I get it to work by hardcoding the PARM-line in
  driver/input/mouse/psmouse.c to a "1". This might very well boil
  down to user error (PEBKAC) on the boot time parm, but the auto
  detection that worked up to .69 is b0rken.

* Insertion of my Palm cradle in the USB ports will result in this one
  once the cradle tries to go active (this one is from -mm2, present
  in -mm3 too):

Unable to handle kernel paging request at virtual address 8d3274f0
 printing eip:
f0a1c6ba
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<f0a1c6ba>]    Tainted: PF  VLI
EFLAGS: 00010203
EIP is at usb_serial_probe+0x5e/0xdfd [usbserial]
eax: 064b1129   ebx: f0a21714   ecx: f0a21598   edx: ebac4400
esi: 00000000   edi: 00000000   ebp: dd9e9eb8   esp: dd9e9e00
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 6353, threadinfo=dd9e8000 task=da240710)
Stack: efe92b64 dd9e9e20 00000246 c029761b 00000246 fffffff4 ed796980 ed562a80
       dd9e9e58 00000000 00000000 00000000 00000000 ed7969ec 000041ed 00000000
       dd9e9e5c ebac4400 edf85500 000000d0 ed7969ec 000041ed 00000000 dd9e9e6c
Call Trace:
 [<c01662e9>] d_instantiate+0x67/0x7b
 [<c0183a53>] sysfs_create+0x64/0x7e
 [<c01842d7>] sysfs_create_dir+0xa8/0xd6
 [<f0a21598>] usb_serial_driver+0x78/0x88 [usbserial]
 [<f0a21538>] usb_serial_driver+0x18/0x88 [usbserial]
 [<f0a21520>] usb_serial_driver+0x0/0x88 [usbserial]
 [<f088009a>] usb_device_probe+0x8c/0xac [usbcore]
 [<f0a214e0>] +0x0/0x40 [usbserial]
 [<f0a214e0>] +0x0/0x40 [usbserial]
 [<f0a21538>] usb_serial_driver+0x18/0x88 [usbserial]
 [<c01ef5a9>] bus_match+0x43/0x6e
 [<f0a21538>] usb_serial_driver+0x18/0x88 [usbserial]
 [<f0899298>] usb_bus_type+0x98/0xe0 [usbcore]
 [<f0a21538>] usb_serial_driver+0x18/0x88 [usbserial]
 [<c01ef6ab>] driver_attach+0x5c/0x60
 [<f0a21538>] usb_serial_driver+0x18/0x88 [usbserial]
 [<f0899244>] usb_bus_type+0x44/0xe0 [usbcore]
 [<f0a21538>] usb_serial_driver+0x18/0x88 [usbserial]
 [<c01ef979>] bus_add_driver+0xb1/0xc6
 [<f0a21538>] usb_serial_driver+0x18/0x88 [usbserial]
 [<f0899200>] usb_bus_type+0x0/0xe0 [usbcore]
 [<f0a21520>] usb_serial_driver+0x0/0x88 [usbserial]
 [<f0a21900>] +0x0/0x200 [usbserial]
 [<c01efd97>] driver_register+0x31/0x35
 [<f0a21538>] usb_serial_driver+0x18/0x88 [usbserial]
 [<f0a215c4>] usb_serial_tty_driver+0x4/0x120 [usbserial]
 [<c01dd77e>] tty_register_driver+0x17d/0x289
 [<f08801b7>] usb_register+0x6b/0xa6 [usbcore]
 [<f0a21538>] usb_serial_driver+0x18/0x88 [usbserial]
 [<f0a1d534>] usb_serial_register+0x4e/0xa0 [usbserial]
 [<f0a1ef60>] +0x5e0/0x998 [usbserial]
 [<f08330f3>] +0xf3/0x13f [usbserial]
 [<f0a21520>] usb_serial_driver+0x0/0x88 [usbserial]
 [<c0131624>] sys_init_module+0x133/0x209
 [<f0a21900>] +0x0/0x200 [usbserial]
 [<c010ae57>] syscall_call+0x7/0xb
 
Code: 00 00 00 c7 45 84 00 00 00 00 c7 85 78 ff ff ff 00 00 00 00 89 55 8c c7 85 74 ff ff ff 00 00 00 00 8b 03 0f 18 00 15 81 fb a8 15 <a2> f0 74 32 8d 4b ec 89 4d 84 8b 41 0c 89 44 24 04 8b 45 08 89
 <6>usb 2-1: USB disconnect, address 3

* On -mm3 under some loads mplayer can get very erratic, and after
  playing a videostream for about 10-15 mins it gets progressivly more
  prone to stalling. Moving the mousepointer into the window, and wiggling
  it a bit restores it for a while.

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+wVV4CQ1pa+gRoggRAsE/AJ9Zx3MXrgbQwtsXer+4aBK7RbE9cQCePe/S
ywXMXOVr8cvgOdN2eknAJnk=
=CyEy
-----END PGP SIGNATURE-----
