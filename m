Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272484AbRIRQLN>; Tue, 18 Sep 2001 12:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272473AbRIRQLE>; Tue, 18 Sep 2001 12:11:04 -0400
Received: from [213.37.2.230] ([213.37.2.230]:5617 "EHLO
	villaverde.madritel.es") by vger.kernel.org with ESMTP
	id <S272472AbRIRQKx>; Tue, 18 Sep 2001 12:10:53 -0400
Message-ID: <001401c1405b$7ce0e680$802625d5@madritel.es>
From: "Javier Vizcaino" <javizca@mi.madritel.es>
To: <fero@drama.obuda.kando.hu>, <linux-nvidia@lists.surfsouth.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: virtual terminal output to wrong destination
Date: Tue, 18 Sep 2001 18:03:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PROBLEM: virtual terminal output to wrong destination

Hi.

The following can range from two simultaneous bugs in two differente
kernel modules, to something missing in the switching of virtual
terminals (Alt+Fx), till to something the human mind can't, and
shouldn't, understand.

Briefly, these are the two modules affected:
-mgacon.c: 25 lines text virtual terminal on text monochrome adapters.
-hgafb.c: framebuffer virtual terminal on Hercules monochrome graphic
adapters.
In both cases, virtual terminal output towards these cards appear on
other in a situation that follows.

What I have is:
-SuSE 7.0 with kernel 2.4.7.
-Primary: S3 AGP (no fb).
-Secondary: Matrox Mystique 220 PCI (using fb, module matroxfb_base).
-Other: clone Hercules MDA ISA (using mdacon, and hgafb (fb)).
-19" (AGP) and 14" (PCI) color monitors, and a monochrome monitor (ISA).
-tty1 to tty6 will be conventional text vt's on S3 AGP (no framebuffer),
tty7 wil be for X (not used here), tty8 to tty11 will be framebuffer
vt's, and tty12 will be for mdacon (text 25 lines).
-Modules to load will be matroxfb_base, mdacon and hgafb; these last two
have the problems (virtual terminal output appears on Matrox).
As reported by ver_linux:
Linux capricho 2.4.7 #15 Tue Sep 18 10:34:16 CEST 2001 i686 unknown
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.24
util-linux             2.10m
mount                  2.10m
modutils               2.4.2
e2fsprogs              1.18
PPP                    2.3.11
Linux C Library        x   1 root     root      4071014 Dec 30  2000
/lib/libc.so.6
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         matroxfb_base matroxfb_DAC1064 matroxfb_accel
fbcon-cfb24 matroxfb_misc fbcon-cfb32 fbcon-cfb8 fbcon-cfb16 ide-floppy
ntfs vfat fat analog ns558 gameport evdev joydev c-qcam hgafb fbcon-hga
msp3400 tuner tvaudio bttv saa5249 eeprom w83781d i2c-proc i2c-viapro
i2c-dev i2c-algo-bit i2c-core parport_pc plip parport 3c59x irtty 3c509
irda dsbr100 videodev keybdev mousedev hid input uhci usbcore serial

Configuration:
-On /etc/lilo.conf (framebuffer tty's):
...
  append ="... video=vc:8-11"
...
-On /etc/inittab (all tty's):
...
1:123:respawn:/sbin/mingetty --noclear tty1
2:123:respawn:/sbin/mingetty tty2
3:123:respawn:/sbin/mingetty tty3
4:123:respawn:/sbin/mingetty tty4
5:123:respawn:/sbin/mingetty tty5
6:123:respawn:/sbin/mingetty tty6
8:123:respawn:/sbin/mingetty tty8
9:123:respawn:/sbin/mingetty tty9
10:123:respawn:/sbin/mingetty tty10
11:123:respawn:/sbin/mingetty tty11
12:123:respawn:/sbin/mingetty tty12
...
-On /etc/modules.conf (options for mdacon and matroxfb):
...
options mdacon mda_first_vc=12 mda_last_vc=12
options matroxfb_base dev=0 vesa=0x10C
...

How to reproduce both bugs follow (I describe them separately, since I
don't know a common thing for both failures).

******************************************************************

--------------BUG ON mdacon.c--------------

To show the bug:
-1). 'modprobe mdacon': text vt tty12 25 lines on MDA monitor. I can
log in there (Alt+F12).
-2). 'modprobe matroxfb_base' (with or without con2fb): fb vt's (tty8
to tty11) on Matrox. I can log in as well (Alt+F8 to Alt+F11).
-3). Alt+F12 to return to vt on MDA: text appears in Matrox monitor,
instead of going to MDA monitor. Cursor moves on the MDA monitor;
rest is black. Letters appear on Matrox monitor with one space in
between, surely because mdacon sending the text attribute byte.

So mdacon seems not to know where its output should appear.

******************************************************************

--------------BUG ON hgafb.c--------------

Here it is intended to make coexist framebuffer vt's on Matrox and
Hercules.

I built two files to assign tty's to fb's (see above line on
/etc/lilo.conf):
-fbh:
modprobe hgafb
con2fb /dev/fb0 /dev/tty10
con2fb /dev/fb0 /dev/tty11
-fbm:
modprobe matroxfb_base
con2fb /dev/fb1 /dev/tty8
con2fb /dev/fb1 /dev/tty9
and proceeded step by step as follows, starting on MDA (fbh and fbm
executed from tty1 on S3 AGP).

1) Execute fbh. tty10 and tty11 appear on MDA monitor, and I can log
into both (well, I must guess 'login: ' appears, but 'password: ' does
appear).

2) Execute fbm. tty8 and tty9 appear on Matrox monitor, and I can also
log in.

3) Check lsmod: both groups of fb modules (matroxfb/hgafb and others)
appear.

4) But now going back to MDA vt's tty10 and tty11 (Alt+F10, Alt+F11),
MDA monitor does not change, and a mess appears in Matrox monitor:
output
goes erroneously there, MDA commands make no sense for Matrox, and what
appears is many colored rectangles.

5) Matrox vt's still appear normally on Matrox monitor (Alt+F8, Alt+F9).

So hgafb seems not to know where its output should appear.

If trying in opposite order, Matrox then MDA (rebooting, and with two
other similar files exchanging fb0<->fb1) all output goes to Matrox
monitor (hgafb messed).

******************************************************************


HTH.

Greetings, Javier Vizcaino.

************************************
Javier Vizcaino  javizca@mi.madritel.es
Starting point:        (-1)^(-1) = -1
Applying logarithms: (-1)*ln(-1) = ln(-1)
Since ln(-1)<>0, dividing:    -1 = 1

