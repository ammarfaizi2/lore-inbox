Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275046AbTHQGPN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 02:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275470AbTHQGOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 02:14:34 -0400
Received: from codepoet.org ([166.70.99.138]:57999 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S275046AbTHQGNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 02:13:37 -0400
Date: Sun, 17 Aug 2003 00:13:39 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 5/8 Backport recent 2.6 IDE updates to 2.4.x
Message-ID: <20030817061338.GF17621@codepoet.org>
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

This patch continues the massive simplification of IDE drive
capacity detection.  This also implements the final version of my
patch to fix CONFIG_IDEDISK_STROKE, which is currently broken in
2.4.x.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- linux/drivers/ide/ide-disk.c.orig	2003-08-16 20:45:14.000000000 -0600
+++ linux/drivers/ide/ide-disk.c	2003-08-16 20:51:58.000000000 -0600
@@ -1139,16 +1139,56 @@
 	return n;
 }
 
-/*
- * Tests if the drive supports Host Protected Area feature.
- * Returns true if supported, false otherwise.
- */
-static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
+static inline void idedisk_check_hpa_lba28(ide_drive_t *drive)
 {
-	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
-	if (flag)
-		printk("%s: host protected area => %d\n", drive->name, flag);
-	return flag;
+	unsigned long capacity, set_max;
+
+	capacity = drive->id->lba_capacity;
+	set_max = idedisk_read_native_max_address(drive);
+
+	if (set_max <= capacity)
+		return;
+
+	printk(KERN_INFO "%s: Host Protected Area detected.\n"
+			 "\tcurrent capacity is %ld sectors (%ld MB)\n"
+			 "\tnative  capacity is %ld sectors (%ld MB)\n",
+			 drive->name,
+			 capacity, (capacity - capacity/625 + 974)/1950,
+			 set_max, (set_max - set_max/625 + 974)/1950);
+#ifdef CONFIG_IDEDISK_STROKE
+	set_max = idedisk_set_max_address(drive, set_max);
+	if (set_max) {
+		drive->id->lba_capacity = set_max;
+		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
+				 drive->name);
+	}
+#endif
+}
+
+static inline void idedisk_check_hpa_lba48(ide_drive_t *drive)
+{
+	unsigned long long capacity_2, set_max_ext;
+
+	capacity_2 = drive->id->lba_capacity_2;
+	set_max_ext = idedisk_read_native_max_address_ext(drive);
+
+	if (set_max_ext <= capacity_2)
+		return;
+
+	printk(KERN_INFO "%s: Host Protected Area detected.\n"
+			 "\tcurrent capacity is %lld sectors (%lld MB)\n"
+			 "\tnative  capacity is %lld sectors (%lld MB)\n",
+			 drive->name,
+			 capacity_2, sectors_to_MB(capacity_2),
+			 set_max_ext, sectors_to_MB(set_max_ext));
+#ifdef CONFIG_IDEDISK_STROKE
+	set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
+	if (set_max_ext) {
+		drive->id->lba_capacity_2 = set_max_ext;
+		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
+				 drive->name);
+	}
+#endif
 }
 
 /*
@@ -1165,64 +1205,43 @@
  * in above order (i.e., if value of higher priority is available,
  * reset will be ignored).
  */
-#define IDE_STROKE_LIMIT	(32000*1024*2)
 static void init_idedisk_capacity (ide_drive_t  *drive)
 {
 	struct hd_driveid *id = drive->id;
-	unsigned long capacity, set_max;
-	unsigned long long capacity_2, set_max_ext;
-
-	capacity_2 = capacity = drive->cyl * drive->head * drive->sect;
+	/*
+	 * If this drive supports the Host Protected Area feature set,
+	 * then we may need to change our opinion about the drive's capacity.
+	 */
+	int hpa = (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
 
-	(void) idedisk_supports_host_protected_area(drive);
+	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
+		/* drive speaks 48-bit LBA */
+		unsigned long long capacity_2;
 
-	if (id->cfs_enable_2 & 0x0400) {
+		drive->select.b.lba = 1;
+		if (hpa)
+			idedisk_check_hpa_lba48(drive);
 		capacity_2 = id->lba_capacity_2;
 		drive->head		= drive->bios_head = 255;
 		drive->sect		= drive->bios_sect = 63;
-		drive->select.b.lba	= 1;
-		set_max_ext = idedisk_read_native_max_address_ext(drive);
-		if (set_max_ext > capacity_2 && capacity_2 > IDE_STROKE_LIMIT) {
-#ifdef CONFIG_IDEDISK_STROKE
-			set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
-			if (set_max_ext)
-				id->lba_capacity_2 = capacity_2 = set_max_ext;
-#else /* !CONFIG_IDEDISK_STROKE */
-			printk(KERN_INFO "%s: setmax_ext LBA %llu, native  %llu\n",
-				drive->name, set_max_ext, capacity_2);
-#endif /* CONFIG_IDEDISK_STROKE */
-		}
 		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
 		drive->bios_cyl		= drive->cyl;
 		drive->capacity48	= capacity_2;
 		drive->capacity		= (unsigned long) capacity_2;
-		return;
-	/* Determine capacity, and use LBA if the drive properly supports it */
 	} else if ((id->capability & 2) && lba_capacity_is_ok(id)) {
+		/* drive speaks 28-bit LBA */
+		unsigned long capacity;
+
+		drive->select.b.lba = 1;
+		if (hpa)
+			idedisk_check_hpa_lba28(drive);
 		capacity = id->lba_capacity;
 		drive->cyl = capacity / (drive->head * drive->sect);
-		drive->select.b.lba = 1;
-	} else {
 		drive->capacity = capacity;
-		return;
-	}
-
-	set_max = idedisk_read_native_max_address(drive);
-	if (set_max > capacity && capacity > IDE_STROKE_LIMIT) {
-#ifdef CONFIG_IDEDISK_STROKE
-		set_max = idedisk_set_max_address(drive, set_max);
-		if (set_max) {
-			drive->capacity = capacity = set_max;
-			drive->cyl = set_max / (drive->head * drive->sect);
-			drive->select.b.lba = 1;
-			drive->id->lba_capacity = capacity;
-		}
-#else /* !CONFIG_IDEDISK_STROKE */
-		printk(KERN_INFO "%s: setmax LBA %lu, native  %lu\n",
-			drive->name, set_max, capacity);
-#endif /* CONFIG_IDEDISK_STROKE */
+	} else {
+		/* drive speaks boring old 28-bit CHS */
+		drive->capacity = drive->cyl * drive->head * drive->sect;
 	}
-	drive->capacity = capacity;
 }
 
 static u64 idedisk_capacity (ide_drive_t *drive)
