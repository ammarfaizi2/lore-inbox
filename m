Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287571AbSASV7K>; Sat, 19 Jan 2002 16:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287545AbSASV7A>; Sat, 19 Jan 2002 16:59:00 -0500
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:53764 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S287535AbSASV6q>;
	Sat, 19 Jan 2002 16:58:46 -0500
Date: Sat, 19 Jan 2002 16:58:42 -0500 (EST)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
cc: Andre Hedrick <andre@linux-ide.org>
Subject: [PATCH] Andre's IDE Patch (1/7)
Message-ID: <Pine.LNX.4.33.0201191457490.14950-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first of seven patches against 2.4.18-pre4, beginning the breakup
of Andre Hedrick's IDE patch into smaller chunks.  This group of seven
patches is ~2000 lines long and consists of about one fifth of the entire
IDE patch.  None of these patches include anything related to Taskfile I/O
yet, and all of them have been successfully compiled.  Patches 2, 3, and 7
have also all been booted.  Patch 2, which deals with drivers/ide/hpt366.c
also correctly located my on-board HPT370, however I couldn't test any
drives on it since I don't have any hooked up to that controller.
These aren't being sent to Marcelo yet, just because I want to make sure
there are no major objections/problems with them.  I'm standing by with
the brown paper bag just in case I screw something up, so the delay will
hopefully flesh out any problems with any of this first batch of patches.

Description of patch 1:
Very simple patch, touches 4 files of which only two get compiled.
Updates CREDITS and MAINTAINERS with correct contact info, and adds some
ifdef/ifndef's to drivers/ide/ide-cd.h and drivers/ide/ide-geometry.c

Regards,
Rob Radez

diff -ruN linux-2.4.18-pre3/CREDITS linux-2.4.18-pre3-ide-rr/CREDITS
--- linux-2.4.18-pre3/CREDITS	Thu Jan 10 17:04:42 2002
+++ linux-2.4.18-pre3-ide-rr/CREDITS	Mon Jan 14 18:28:54 2002
@@ -586,6 +586,13 @@
 S: University of Michigan
 S: Ann Arbor, MI

+N: Michael Cornwell
+E: cornwell@acm.org
+D: Original designer and co-author of ATA Taskfile
+D: Kernel module SMART utilities
+S: Santa Cruz, California
+S: USA
+
 N: Kees Cook
 E: cook@cpoint.net
 W: http://outflux.net/
@@ -1184,22 +1191,19 @@

 N: Andre Hedrick
 E: andre@linux-ide.org
-E: andre@aslab.com
-E: andre@suse.com
+E: andre@linuxdiskcert.org
 W: http://www.linux-ide.org/
+W: http://www.linuxdiskcert.org/
 D: Random SMP kernel hacker...
 D: Uniform Multi-Platform E-IDE driver
 D: Active-ATA-Chipset maddness..........
-D: Ultra DMA 100/66/33
-D: ATA-Disconnect
+D: Ultra DMA 133/100/66/33 w/48-bit Addressing
+D: ATA-Disconnect, ATA-TCQ
 D: ATA-Smart Kernel Daemon
+D: Serial ATA
+D: ATA Command Block and Taskfile
 S: Linux ATA Development (LAD)
 S: Concord, CA
-S: ASL, Inc. 1-877-ASL-3535
-S: 1757 Houret Court, Milpitas, CA 95035
-S: SuSE Linux, Inc.
-S: 580 Second Street, Suite 210  Oakland, CA  94607
-S: USA

 N: Jochen Hein
 E: jochen@jochen.org
diff -ruN linux-2.4.18-pre3/drivers/ide/ide-cd.h linux-2.4.18-pre3-ide-rr/drivers/ide/ide-cd.h
--- linux-2.4.18-pre3/drivers/ide/ide-cd.h	Thu Nov 22 14:46:58 2001
+++ linux-2.4.18-pre3-ide-rr/drivers/ide/ide-cd.h	Mon Jan 14 18:29:06 2002
@@ -38,7 +38,9 @@
 /************************************************************************/

 #define SECTOR_BITS 		9
+#ifndef SECTOR_SIZE
 #define SECTOR_SIZE		(1 << SECTOR_BITS)
+#endif
 #define SECTORS_PER_FRAME	(CD_FRAMESIZE >> SECTOR_BITS)
 #define SECTOR_BUFFER_SIZE	(CD_FRAMESIZE * 32)
 #define SECTORS_BUFFER		(SECTOR_BUFFER_SIZE >> SECTOR_BITS)
diff -ruN linux-2.4.18-pre3/drivers/ide/ide-geometry.c linux-2.4.18-pre3-ide-rr/drivers/ide/ide-geometry.c
--- linux-2.4.18-pre3/drivers/ide/ide-geometry.c	Fri Nov  9 17:23:34 2001
+++ linux-2.4.18-pre3-ide-rr/drivers/ide/ide-geometry.c	Mon Jan 14 18:29:06 2002
@@ -6,6 +6,8 @@
 #include <linux/mc146818rtc.h>
 #include <asm/io.h>

+#ifdef CONFIG_BLK_DEV_IDE
+
 /*
  * We query CMOS about hard disks : it could be that we have a SCSI/ESDI/etc
  * controller that is BIOS compatible with ST-506, and thus showing up in our
@@ -40,7 +42,11 @@
  * Consequently, also the former "drive->present = 1" below was a mistake.
  *
  * Eventually the entire routine below should be removed.
+ *
+ * 17-OCT-2000 rjohnson@analogic.com Added spin-locks for reading CMOS
+ * chip.
  */
+
 void probe_cmos_for_drives (ide_hwif_t *hwif)
 {
 #ifdef __i386__
@@ -80,9 +86,10 @@
 	}
 #endif
 }
+#endif /* CONFIG_BLK_DEV_IDE */


-#ifdef CONFIG_BLK_DEV_IDE
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)

 extern ide_drive_t * get_info_ptr(kdev_t);
 extern unsigned long current_capacity (ide_drive_t *);
@@ -214,4 +221,4 @@
 		       drive->bios_cyl, drive->bios_head, drive->bios_sect);
 	return ret;
 }
-#endif /* CONFIG_BLK_DEV_IDE */
+#endif /* defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE) */
diff -ruN linux-2.4.18-pre3/MAINTAINERS linux-2.4.18-pre3-ide-rr/MAINTAINERS
--- linux-2.4.18-pre3/MAINTAINERS	Thu Jan 10 17:04:42 2002
+++ linux-2.4.18-pre3-ide-rr/MAINTAINERS	Mon Jan 14 18:28:55 2002
@@ -706,12 +706,12 @@
 IDE DRIVER [GENERAL]
 P:	Andre Hedrick
 M:	andre@linux-ide.org
-M:	andre@aslab.com
-M:	andre@suse.com
+M:	andre@linuxdiskcert.org
 L:	linux-kernel@vger.kernel.org
 W:	http://www.kernel.org/pub/linux/kernel/people/hedrick/
 W:	http://www.linux-ide.org/
-S:	Supported
+W:	http://www.linuxdiskcert.org/
+S:	Maintained

 IDE/ATAPI CDROM DRIVER
 P:	Jens Axboe







