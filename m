Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275029AbTHQGS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 02:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275279AbTHQGRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 02:17:22 -0400
Received: from codepoet.org ([166.70.99.138]:60047 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S275029AbTHQGOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 02:14:00 -0400
Date: Sun, 17 Aug 2003 00:14:02 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 7/8 Backport recent 2.6 IDE updates to 2.4.x
Message-ID: <20030817061402.GH17621@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the IDE driver to use "capacity64" (describing
the size of the variable) rather than "capacity48" (which
describes that 48 bit addressing is in use).  We really do not
care, in this context, what addressing happens to be in use.
This patch then eliminates the artifical distinction between
the old "capacity" and "capacity48" variables.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- linux/include/linux/ide.h.orig	2003-08-16 18:55:02.000000000 -0600
+++ linux/include/linux/ide.h	2003-08-16 21:03:26.000000000 -0600
@@ -785,8 +785,7 @@
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 
-	u32		capacity;	/* total number of sectors */
-	u64		capacity48;	/* total number of sectors */
+	u64		capacity64;	/* total number of sectors */
 
 	int		last_lun;	/* last logical unit */
 	int		forced_lun;	/* if hdxlun was given at boot */
--- linux/drivers/ide/ide-disk.c.orig	2003-08-16 20:56:49.000000000 -0600
+++ linux/drivers/ide/ide-disk.c	2003-08-16 21:04:04.000000000 -0600
@@ -1152,53 +1152,33 @@
 	return (id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400);
 }
 
-static inline void idedisk_check_hpa_lba28(ide_drive_t *drive)
+static inline void idedisk_check_hpa(ide_drive_t *drive)
 {
-	unsigned long capacity, set_max;
+	unsigned long long capacity, set_max;
+	int lba48 = idedisk_supports_lba48(drive->id);
 
-	capacity = drive->capacity;
-	set_max = idedisk_read_native_max_address(drive);
+	capacity = drive->capacity64;
+	if (lba48)
+		set_max = idedisk_read_native_max_address_ext(drive);
+	else
+		set_max = idedisk_read_native_max_address(drive);
 
 	if (set_max <= capacity)
 		return;
 
 	printk(KERN_INFO "%s: Host Protected Area detected.\n"
-			 "\tcurrent capacity is %ld sectors (%ld MB)\n"
-			 "\tnative  capacity is %ld sectors (%ld MB)\n",
+			 "\tcurrent capacity is %llu sectors (%llu MB)\n"
+			 "\tnative  capacity is %llu sectors (%llu MB)\n",
 			 drive->name,
-			 capacity, (capacity - capacity/625 + 974)/1950,
-			 set_max, (set_max - set_max/625 + 974)/1950);
+			 capacity, sectors_to_MB(capacity),
+			 set_max, sectors_to_MB(set_max));
 #ifdef CONFIG_IDEDISK_STROKE
-	set_max = idedisk_set_max_address(drive, set_max);
+	if (lba48)
+		set_max = idedisk_set_max_address_ext(drive, set_max);
+	else
+		set_max = idedisk_set_max_address(drive, set_max);
 	if (set_max) {
-		drive->capacity = set_max;
-		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
-				 drive->name);
-	}
-#endif
-}
-
-static inline void idedisk_check_hpa_lba48(ide_drive_t *drive)
-{
-	unsigned long long capacity_2, set_max_ext;
-
-	capacity_2 = drive->capacity48;
-	set_max_ext = idedisk_read_native_max_address_ext(drive);
-
-	if (set_max_ext <= capacity_2)
-		return;
-
-	printk(KERN_INFO "%s: Host Protected Area detected.\n"
-			 "\tcurrent capacity is %lld sectors (%lld MB)\n"
-			 "\tnative  capacity is %lld sectors (%lld MB)\n",
-			 drive->name,
-			 capacity_2, sectors_to_MB(capacity_2),
-			 set_max_ext, sectors_to_MB(set_max_ext));
-#ifdef CONFIG_IDEDISK_STROKE
-	set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
-	if (set_max_ext) {
-		drive->capacity48 = set_max_ext;
-		drive->capacity = (unsigned long) set_max_ext;
+		drive->capacity64 = set_max;
 		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
 				 drive->name);
 	}
@@ -1231,27 +1211,24 @@
 	if (idedisk_supports_lba48(id)) {
 		/* drive speaks 48-bit LBA */
 		drive->select.b.lba = 1;
-		drive->capacity48 = id->lba_capacity_2;
-		drive->capacity = (unsigned long) drive->capacity48;
+		drive->capacity64 = id->lba_capacity_2;
 		if (hpa)
-			idedisk_check_hpa_lba48(drive);
+			idedisk_check_hpa(drive);
 	} else if ((id->capability & 2) && lba_capacity_is_ok(id)) {
 		/* drive speaks 28-bit LBA */
 		drive->select.b.lba = 1;
-		drive->capacity = id->lba_capacity;
+		drive->capacity64 = id->lba_capacity;
 		if (hpa)
-			idedisk_check_hpa_lba28(drive);
+			idedisk_check_hpa(drive);
 	} else {
 		/* drive speaks boring old 28-bit CHS */
-		drive->capacity = drive->cyl * drive->head * drive->sect;
+		drive->capacity64 = drive->cyl * drive->head * drive->sect;
 	}
 }
 
 static u64 idedisk_capacity (ide_drive_t *drive)
 {
-	if (idedisk_supports_lba48(drive->id))
-		return (drive->capacity48 - drive->sect0);
-	return (drive->capacity - drive->sect0);
+	return drive->capacity64 - drive->sect0;
 }
 
 static ide_startstop_t idedisk_special (ide_drive_t *drive)
