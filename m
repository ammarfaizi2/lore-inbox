Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSLAQuN>; Sun, 1 Dec 2002 11:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSLAQuN>; Sun, 1 Dec 2002 11:50:13 -0500
Received: from mail.wincom.net ([209.216.129.3]:61713 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id <S261914AbSLAQuM>;
	Sun, 1 Dec 2002 11:50:12 -0500
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Dec 102 11:54:41 -0500
Subject: Got DC10+ VFL Video Capture board working
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3dea3f71.59f5.0@wincom.net>
X-User-Info: 24.57.83.120
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After much goofing around, I've managed to get a Zoran-based DC10+ video capture
board working with 2.4.20rc4.

Key points: 

1) There doesn't seem to be any way to do this with the vanilla kernel. Trying
to compile in all the VFL devices won't compile (there's a problem with the
bttv driver - and unresolved symbol of some sort) and it seems the zoran driver
is dependant on a module called i2c-old that is only built with the bttv driver?


2) Building the current CVS (which doesn't seem to have been altered in months)
for the driver-zoran project from mjpeg.sourceforge.net produced modules that
worked. A brief visual comparison between them and the .c files in the kernel
source didn't reveal any differences more obvious than some kernel version #ifdefs
in the driver-zoran versions of the drivers - they're the same code, or at least
_very_ similar.

3) I had to build the bttv kernel driver as a module to get the i2c-old.o module
built.

4) I then wrote a rc script that did:

    modprobe i2c-old
    modprobe saa7110
    modprobe adv7175
    modprobe zoran

and this presented the following dmesg output:

i2c: initialized
Zoran ZR36060 + ZR36057/67 MJPEG board driver version 0.9
PCI: Found IRQ 11 for device 00:0e.0
MJPEG[0]: Zoran ZR36067 (rev 2) irq: 11, memory: 0xdd800000
MJPEG[0]: subsystem vendor=0x1031 id=0x7efe
MJPEG[0]: Initializing i2c bus...
saa7110_attach: SAA7110A version 1 at 0x9c, status=0xf0
MJPEG[0]: i2c attach 04
adv7176_attach: adv7176 rev. 1 at 0x56
DC10plus[0]: i2c attach 05
DC10plus[0] card detected
DC10plus[0]: Zoran ZR36060 (rev 1)
MJPEG: 1 card(s) found
MJPEG: using 2 V4L buffers of size 128 KB
DC10plus[0]: Initializing card[0], zr=e0988600
DC10plus[0]: enable_jpg IDLE
DC10plus[0]: Testing interrupts...
DC10plus[0]: interrupts received: GIRQ1:49 queue_state=0/0/0/0
DC10plus[0]: procfs entry /proc/zoran0 allocated. data=e0988600

5) My _guess_ as to what is happening is that:

   a) The zoran/DC10+ stuff depends on the i2c-old code
   b) It also depends on saa7110 and adv7175
   c) When you check the DC10+ option in make config, these dependancies are
not being resolved, and one or more of them don't make it into the kernel when
one attempts to compile DC10+ in monolithic
   d) There may be differences between the driver code in the MJPEG CVS and
the current vanilla kernel

6) As such, to get this working should require:
   a) Sync up the current MJPEG cvs to the current kernel 
   b) Ensure that checking DC10+ gets you:
      i)   i2c-old.o
      ii)  saa7110.o
      iii) adv7175.o
      iv)  zoran.o
   in that order.

Is there someone to carry this forward?

Thanks!

DG


