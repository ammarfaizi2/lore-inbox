Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275550AbTHQGQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 02:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275464AbTHQGOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 02:14:09 -0400
Received: from codepoet.org ([166.70.99.138]:56463 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S275044AbTHQGN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 02:13:26 -0400
Date: Sun, 17 Aug 2003 00:13:29 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 4/8 Backport recent 2.6 IDE updates to 2.4.x
Message-ID: <20030817061328.GE17621@codepoet.org>
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

This patch massively simplifies IDE drive capacity calculation.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--- linux/drivers/ide/ide-disk.c.orig	2003-08-16 20:42:04.000000000 -0600
+++ linux/drivers/ide/ide-disk.c	2003-08-16 20:45:14.000000000 -0600
@@ -1169,13 +1169,10 @@
 static void init_idedisk_capacity (ide_drive_t  *drive)
 {
 	struct hd_driveid *id = drive->id;
-	unsigned long capacity = drive->cyl * drive->head * drive->sect;
-	unsigned long set_max = idedisk_read_native_max_address(drive);
-	unsigned long long capacity_2 = capacity;
-	unsigned long long set_max_ext;
+	unsigned long capacity, set_max;
+	unsigned long long capacity_2, set_max_ext;
 
-	drive->capacity48 = 0;
-	drive->select.b.lba = 0;
+	capacity_2 = capacity = drive->cyl * drive->head * drive->sect;
 
 	(void) idedisk_supports_host_protected_area(drive);
 
@@ -1183,19 +1180,13 @@
 		capacity_2 = id->lba_capacity_2;
 		drive->head		= drive->bios_head = 255;
 		drive->sect		= drive->bios_sect = 63;
-		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
 		drive->select.b.lba	= 1;
 		set_max_ext = idedisk_read_native_max_address_ext(drive);
 		if (set_max_ext > capacity_2 && capacity_2 > IDE_STROKE_LIMIT) {
 #ifdef CONFIG_IDEDISK_STROKE
-			set_max_ext = idedisk_read_native_max_address_ext(drive);
 			set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
-			if (set_max_ext) {
-				drive->capacity48 = capacity_2 = set_max_ext;
-				drive->cyl = (unsigned int) set_max_ext / (drive->head * drive->sect);
-				drive->select.b.lba = 1;
-				drive->id->lba_capacity_2 = capacity_2;
-                        }
+			if (set_max_ext)
+				id->lba_capacity_2 = capacity_2 = set_max_ext;
 #else /* !CONFIG_IDEDISK_STROKE */
 			printk(KERN_INFO "%s: setmax_ext LBA %llu, native  %llu\n",
 				drive->name, set_max_ext, capacity_2);
@@ -1211,11 +1202,14 @@
 		capacity = id->lba_capacity;
 		drive->cyl = capacity / (drive->head * drive->sect);
 		drive->select.b.lba = 1;
+	} else {
+		drive->capacity = capacity;
+		return;
 	}
 
+	set_max = idedisk_read_native_max_address(drive);
 	if (set_max > capacity && capacity > IDE_STROKE_LIMIT) {
 #ifdef CONFIG_IDEDISK_STROKE
-		set_max = idedisk_read_native_max_address(drive);
 		set_max = idedisk_set_max_address(drive, set_max);
 		if (set_max) {
 			drive->capacity = capacity = set_max;
@@ -1228,15 +1222,7 @@
 			drive->name, set_max, capacity);
 #endif /* CONFIG_IDEDISK_STROKE */
 	}
-
 	drive->capacity = capacity;
-
-	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
-		drive->capacity48 = id->lba_capacity_2;
-		drive->head = 255;
-		drive->sect = 63;
-		drive->cyl = (unsigned long)(drive->capacity48) / (drive->head * drive->sect);
-	}
 }
 
 static u64 idedisk_capacity (ide_drive_t *drive)
