Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRCRJdu>; Sun, 18 Mar 2001 04:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRCRJdk>; Sun, 18 Mar 2001 04:33:40 -0500
Received: from gold.MUSKOKA.COM ([199.212.175.5]:52494 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S129143AbRCRJd0>;
	Sun, 18 Mar 2001 04:33:26 -0500
Message-ID: <3AB47DA4.795B609B@yahoo.com>
Date: Sun, 18 Mar 2001 04:19:32 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, andre@linux-ide.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] off-by-1 error in ide-probe (2.4.x)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potentially serious bug in ide-probe.c in which max_sectors
is set to 256 instead of 255.  I am surprised that this hasn't bit anyone
else yet.  Perhaps because you need a disk that is slow in comparison to 
the host in order for the queue to climb up to and then hit the 256, at
which point it then falls over.  

For example, with an old 700MB Maxtor on a "fast" 486, VL-bus, PIO, 
hdparm -c1 -m8 -u1, I could pretty much on demand generate the following 
error by multiple builds, or by the final linking of any big project:

   hdc: lost interrupt
   hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
   hdc: drive not ready for command
   <user space sees binary cruft in source files, etc etc...>

(Note that nothing in the status is really an error).  With the following 
patch, everything works as it should & no errors even under high load.
Patch is against 2.4.3pre2.

Paul.

--- drivers/ide/ide-probe.c~	Sat Mar 17 16:50:14 2001
+++ drivers/ide/ide-probe.c	Sat Mar 17 16:58:33 2001
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/ide-probe.c	Version 1.06	June 9, 2000
+ *  linux/drivers/ide/ide-probe.c	Version 1.07	March 18, 2001
  *
  *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
  */
@@ -25,6 +25,8 @@
  *			allowed for secondary flash card to be detectable
  *			 with new flag : drive->ata_flash : 1;
  * Version 1.06		stream line request queue and prep for cascade project.
+ * Version 1.07		max_sect <= 255; slower disks would get behind and
+ * 			then fall over when they get to 256.	Paul G.
  */
 
 #undef REALLY_SLOW_IO		/* most systems can safely undef this */
@@ -772,10 +774,10 @@
 	for (unit = 0; unit < minors; ++unit) {
 		*bs++ = BLOCK_SIZE;
 #ifdef CONFIG_BLK_DEV_PDC4030
-		*max_sect++ = ((hwif->chipset == ide_pdc4030) ? 127 : 256);
+		*max_sect++ = ((hwif->chipset == ide_pdc4030) ? 127 : 255);
 #else
 		/* IDE can do up to 128K per request. */
-		*max_sect++ = 256;
+		*max_sect++ = 255;
 #endif
 		*max_ra++ = MAX_READAHEAD;
 	}


