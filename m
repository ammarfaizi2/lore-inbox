Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129769AbRBPKpd>; Fri, 16 Feb 2001 05:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130037AbRBPKpX>; Fri, 16 Feb 2001 05:45:23 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:57605 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129769AbRBPKpK>; Fri, 16 Feb 2001 05:45:10 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A8D02E3.486049DA@yahoo.com>
Date: Fri, 16 Feb 2001 05:37:23 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.4.2-pre3 i486)
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] hd.c needs max_sectors set
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Yet more fixes from the OCD - Obsolete Cruft Department ]

Couldn't figure out why my el-lame-o testbox was generating random I/O 
errors on large writes.  I first suspected another booger cut loose in 
the disk and generated the typical storm of errors since it has some 
hundred or so bad blocks already...  :)

I've supplied a similar fix for drivers/block/xd.c (untested, but
compiles & is straightforward).  I'm tempted to just mark xd.c 
with CONFIG_OBSOLETE anyway.  Anybody really see using this in 2.4.x, 
even if just as a boot device for a closet box?

Paul.

--- drivers/ide/hd.c~	Thu Feb 15 03:33:12 2001
+++ drivers/ide/hd.c	Thu Feb 15 06:55:28 2001
@@ -22,6 +22,9 @@
  *  This is now a lightweight ST-506 driver. (Paul Gortmaker)
  *
  *  Modified 1995 Russell King for ARM processor.
+ *
+ *  Bugfix: max_sectors must be <= 255 or the wheels tend to come
+ *  off in a hurry once you queue things up - Paul G. 02/2001
  */
   
 /*
@@ -106,6 +109,7 @@
 static int hd_sizes[MAX_HD<<6];
 static int hd_blocksizes[MAX_HD<<6];
 static int hd_hardsectsizes[MAX_HD<<6];
+static int hd_maxsect[MAX_HD<<6];
 
 static struct timer_list device_timer;
 
@@ -732,9 +736,11 @@
 	for(drive=0; drive < (MAX_HD << 6); drive++) {
 		hd_blocksizes[drive] = 1024;
 		hd_hardsectsizes[drive] = 512;
+		hd_maxsect[drive]=255;
 	}
 	blksize_size[MAJOR_NR] = hd_blocksizes;
 	hardsect_size[MAJOR_NR] = hd_hardsectsizes;
+	max_sectors[MAJOR_NR] = hd_maxsect;
 
 #ifdef __i386__
 	if (!NR_HD) {
--- drivers/block/xd.c~	Mon Nov 20 04:16:39 2000
+++ drivers/block/xd.c	Fri Feb 16 05:22:03 2001
@@ -28,6 +28,9 @@
  *   Recovered DMA access. Abridged messages. Added support for DTC5051CX,
  *   WD1002-27X & XEBEC controllers. Driver uses now some jumper settings.
  *   Extended ioctl() support.
+ *
+ * Bugfix: 15/02/01, Paul G. - inform queue layer of tiny xd_maxsect.
+ *
  */
 
 #include <linux/module.h>
@@ -118,6 +121,7 @@
 static struct hd_struct xd_struct[XD_MAXDRIVES << 6];
 static int xd_sizes[XD_MAXDRIVES << 6], xd_access[XD_MAXDRIVES];
 static int xd_blocksizes[XD_MAXDRIVES << 6];
+static int xd_maxsect[XD_MAXDRIVES << 6];
 
 extern struct block_device_operations xd_fops;
 
@@ -241,6 +245,10 @@
 		else
 			printk("xd: unable to get IRQ%d\n",xd_irq);
 	}
+
+	/* xd_maxsectors depends on controller - so set after detection */
+	for(i=0; i<(XD_MAXDRIVES << 6); i++) xd_maxsect[i] = xd_maxsectors;
+	max_sectors[MAJOR_NR] = xd_maxsect;
 
 	for (i = 0; i < xd_drives; i++) {
 		xd_valid[i] = 1;



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

