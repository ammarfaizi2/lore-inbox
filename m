Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261158AbREORY7>; Tue, 15 May 2001 13:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261165AbREORYt>; Tue, 15 May 2001 13:24:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64674 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261155AbREORGb>;
	Tue, 15 May 2001 13:06:31 -0400
Date: Tue, 15 May 2001 13:06:30 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] turn device_init() into an initcall
In-Reply-To: <Pine.GSO.4.21.0105151231250.21081-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0105151254020.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, Alexander Viro wrote:

> 
> 
> On Tue, 15 May 2001, Alexander Viro wrote:
> 
> > ramdisks, etc.). Besides, it allows to start turning functions called
> > from device_init() into initcalls, thus getting rid of ifdef dungpiles
> > in them.
> 
> ... and here's the next part. Takes parport_init() out of device_init().
> Since we have no initcalls in parport/* we don't break the ordering.
> Please, apply - it's incremental to previous.

One more - chr_dev_init() becomes initcall. However, I'd really like
to see this one reviewed from the ordering POV. It may break things -
we might need to move some stuff around. FWIW it works for me, but I don't
have a lot of hardware, so that doesn't say much.

Folks, please look into that - previous patches allow to turn device
initialization into initcalls and it's a Good Thing(tm). Just look
at device_init(), chr_dev_init() and blk_dev_init() - each of them is
a hive of ifdefs.

Linus, your comments?
							Al


diff -urN S5-pre2-init-1/drivers/Makefile S5-pre2-init/drivers/Makefile
--- S5-pre2-init-1/drivers/Makefile	Tue May 15 12:36:34 2001
+++ S5-pre2-init/drivers/Makefile	Tue May 15 12:51:55 2001
@@ -9,7 +9,7 @@
 mod-subdirs :=	dio mtd sbus video macintosh usb input telephony sgi i2o ide \
 		scsi md ieee1394 pnp isdn atm fc4 net/hamradio i2c acpi
 
-subdir-y :=	parport block char net sound misc media cdrom
+subdir-y :=	parport char block net sound misc media cdrom
 subdir-m :=	$(subdir-y)
 
 
diff -urN S5-pre2-init-1/drivers/block/genhd.c S5-pre2-init/drivers/block/genhd.c
--- S5-pre2-init-1/drivers/block/genhd.c	Tue May 15 12:36:34 2001
+++ S5-pre2-init/drivers/block/genhd.c	Tue May 15 12:52:21 2001
@@ -17,7 +17,6 @@
 #include <linux/blk.h>
 #include <linux/init.h>
 
-extern int chr_dev_init(void);
 extern int blk_dev_init(void);
 #ifdef CONFIG_BLK_DEV_DAC960
 extern void DAC960_Initialize(void);
@@ -32,7 +31,6 @@
 
 int __init device_init(void)
 {
-	chr_dev_init();
 	blk_dev_init();
 	sti();
 #ifdef CONFIG_I2O
diff -urN S5-pre2-init-1/drivers/char/Makefile S5-pre2-init/drivers/char/Makefile
--- S5-pre2-init-1/drivers/char/Makefile	Sat Apr 28 02:12:49 2001
+++ S5-pre2-init/drivers/char/Makefile	Tue May 15 12:52:48 2001
@@ -16,7 +16,7 @@
 
 O_TARGET := char.o
 
-obj-y	 += tty_io.o n_tty.o tty_ioctl.o mem.o raw.o pty.o misc.o random.o
+obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o raw.o pty.o misc.o random.o
 
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
diff -urN S5-pre2-init-1/drivers/char/mem.c S5-pre2-init/drivers/char/mem.c
--- S5-pre2-init-1/drivers/char/mem.c	Sat Apr 28 02:12:50 2001
+++ S5-pre2-init/drivers/char/mem.c	Tue May 15 12:53:17 2001
@@ -653,3 +653,5 @@
 #endif
 	return 0;
 }
+
+__initcall(chr_dev_init);

