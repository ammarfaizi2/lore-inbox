Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317980AbSGWHbR>; Tue, 23 Jul 2002 03:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317981AbSGWHbR>; Tue, 23 Jul 2002 03:31:17 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:12496 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317980AbSGWHbQ>; Tue, 23 Jul 2002 03:31:16 -0400
Date: Tue, 23 Jul 2002 09:34:22 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>, <kirk@braille.uwo.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc3-ac2
In-Reply-To: <200207230022.g6N0Mgh30698@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0207230925360.10993-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are compile errors with drivers/char/speakup/speakupmap:

The first one:

<--  snip  -->

...
ld -m elf_i386  -r -o char.o mem.o tty_io.o n_tty.o tty_ioctl.o raw.o
pty.o misc.o random.o vt.o vc_screen.o consolemap.o consolemap_deftbl.o
console.o selection.o serial.o keyboard.o speakup/speakupmap.o pc_keyb.o
sysrq.o rocket.o mxser.o moxa.o epca.o cyclades.o stallion.o istallion.o
ip2.o ip2main.o riscom8.o esp.o synclink.o n_hdlc.o specialix.o sx.o
generic_serial.o rio/rio.o atixlmouse.o logibusmouse.o lp.o joystick/js.o
busmouse.o dtlk.o n_r3964.o applicom.o sonypi.o msbusmouse.o qpmouse.o
pc110pad.o mk712.o rtc.o nvram.o toshiba.o i8k.o i810_rng.o amd768_rng.o
amd76x_pm.o tpqic02.o ftape/ftape.o speakup/spk.o ppdev.o pcwd.o
acquirewdt.o advantechwdt.o ib700wdt.o mixcomwd.o sbc60xxwdt.o
w83877f_wdt.o sc520_wdt.o wdt.o wdt_pci.o i810-tco.o machzwd.o
eurotechwdt.o alim7101_wdt.o sc1200wdt.o wafer5823wdt.o softdog.o
amd7xx_tco.o mwave/mwave.o
speakup/spk.o(.data+0xad80): multiple definition of `ctrl_map'
speakup/speakupmap.o(.data+0x300): first defined here
...

<--  snip  -->

drivers/char/Makefile includes speakup/speakupmap.o that was already
included in speakup/spk.o and the fix is simple:

--- drivers/char/Makefile.old	Tue Jul 23 09:20:29 2002
+++ drivers/char/Makefile	Tue Jul 23 09:20:54 2002
@@ -234,9 +234,6 @@
 ifeq ($(CONFIG_SPEAKUP),y)
 subdir-y += speakup
 obj-y += speakup/spk.o
-ifeq ($(CONFIG_SPEAKUP_KEYMAP),y)
-KEYMAP = speakup/speakupmap.o
-endif
 endif

 obj-$(CONFIG_H8) += h8.o


Unfortunately this only leads to the next problem:

<--  snip  -->

...
ld -m elf_i386  -r -o char.o mem.o tty_io.o n_tty.o tty_ioctl.o raw.o
pty.o misc.o random.o vt.o vc_screen.o consolemap.o consolemap_deftbl.o
console.o selection.o serial.o keyboard.o defkeymap.o pc_keyb.o sysrq.o
rocket.o mxser.o moxa.o epca.o cyclades.o stallion.o istallion.o ip2.o
ip2main.o riscom8.o esp.o synclink.o n_hdlc.o specialix.o sx.o
generic_serial.o rio/rio.o atixlmouse.o logibusmouse.o lp.o joystick/js.o
busmouse.o dtlk.o n_r3964.o applicom.o sonypi.o msbusmouse.o qpmouse.o
pc110pad.o mk712.o rtc.o nvram.o toshiba.o i8k.o i810_rng.o amd768_rng.o
amd76x_pm.o tpqic02.o ftape/ftape.o speakup/spk.o ppdev.o pcwd.o
acquirewdt.o advantechwdt.o ib700wdt.o mixcomwd.o sbc60xxwdt.o
w83877f_wdt.o sc520_wdt.o wdt.o wdt_pci.o i810-tco.o machzwd.o
eurotechwdt.o alim7101_wdt.o sc1200wdt.o wafer5823wdt.o softdog.o
amd7xx_tco.o mwave/mwave.o
speakup/spk.o(.data+0xad80): multiple definition of `ctrl_map'
defkeymap.o(.data+0x300): first defined here
...
speakup/spk.o(.data+0xb884): multiple definition of `func_buf'
defkeymap.o(.data+0xb04): first defined here
ld: Warning: size of symbol `func_buf' changed from 153 to 151 in
speakup/spk.o
...

<--  snip  -->


Two slightly different files defining the same symbols.  :-(


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

