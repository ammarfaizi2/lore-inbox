Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261931AbREOQgZ>; Tue, 15 May 2001 12:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbREOQgP>; Tue, 15 May 2001 12:36:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:62714 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261931AbREOQgM>;
	Tue, 15 May 2001 12:36:12 -0400
Date: Tue, 15 May 2001 12:36:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] turn device_init() into an initcall
In-Reply-To: <Pine.GSO.4.21.0105151148580.21081-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0105151231250.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, Alexander Viro wrote:

> ramdisks, etc.). Besides, it allows to start turning functions called
> from device_init() into initcalls, thus getting rid of ifdef dungpiles
> in them.

... and here's the next part. Takes parport_init() out of device_init().
Since we have no initcalls in parport/* we don't break the ordering.
Please, apply - it's incremental to previous.

diff -urN S5-pre2-init-0/drivers/Makefile S5-pre2-init/drivers/Makefile
--- S5-pre2-init-0/drivers/Makefile	Fri Feb 16 21:09:52 2001
+++ S5-pre2-init/drivers/Makefile	Tue May 15 12:15:41 2001
@@ -9,7 +9,7 @@
 mod-subdirs :=	dio mtd sbus video macintosh usb input telephony sgi i2o ide \
 		scsi md ieee1394 pnp isdn atm fc4 net/hamradio i2c acpi
 
-subdir-y :=	block char net parport sound misc media cdrom
+subdir-y :=	parport block char net sound misc media cdrom
 subdir-m :=	$(subdir-y)
 
 
diff -urN S5-pre2-init-0/drivers/block/genhd.c S5-pre2-init/drivers/block/genhd.c
--- S5-pre2-init-0/drivers/block/genhd.c	Tue May 15 12:15:13 2001
+++ S5-pre2-init/drivers/block/genhd.c	Tue May 15 12:18:29 2001
@@ -17,7 +17,6 @@
 #include <linux/blk.h>
 #include <linux/init.h>
 
-extern int parport_init(void);
 extern int chr_dev_init(void);
 extern int blk_dev_init(void);
 #ifdef CONFIG_BLK_DEV_DAC960
@@ -33,9 +32,6 @@
 
 int __init device_init(void)
 {
-#ifdef CONFIG_PARPORT
-	parport_init();
-#endif
 	chr_dev_init();
 	blk_dev_init();
 	sti();
diff -urN S5-pre2-init-0/drivers/parport/init.c S5-pre2-init/drivers/parport/init.c
--- S5-pre2-init-0/drivers/parport/init.c	Fri Feb 16 22:53:48 2001
+++ S5-pre2-init/drivers/parport/init.c	Tue May 15 12:26:44 2001
@@ -165,6 +165,8 @@
 	return 0;
 }
 
+__initcall(parport_init);
+
 #endif
 
 /* Exported symbols for modules. */

