Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275052AbTHGCAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 22:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275044AbTHGCAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 22:00:30 -0400
Received: from hera.cwi.nl ([192.16.191.8]:55493 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S275052AbTHGCAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 22:00:11 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 7 Aug 2003 03:59:56 +0200 (MEST)
Message-Id: <UTC200308070159.h771xup04247.aeb@smtp.cwi.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl, aebr@win.tue.nl
Subject: Re: [PATCH] ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
Cc: alan@lxorguk.ukuu.org.uk, andersen@codepoet.org,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From aebr@win.tue.nl  Thu Aug  7 03:54:02 2003

	Ha - and you didnt even tell me you had this patch out.

	Looks good.

	[will try to find the appropriate fragment of my patch again
	for comparison purposes]

Here it is:


diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Wed Aug  6 23:02:38 2003
+++ b/drivers/ide/ide-disk.c	Thu Aug  7 04:49:18 2003
@@ -85,11 +85,6 @@
 {
 	unsigned long lba_sects, chs_sects, head, tail;
 
-	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
-		printk("48-bit Drive: %llu \n", id->lba_capacity_2);
-		return 1;
-	}
-
 	/*
 	 * The ATA spec tells large drives to return
 	 * C/H/S = 16383/16/63 independent of their size.
@@ -811,7 +806,7 @@
 			} else {
 				u8 cur = hwif->INB(IDE_SELECT_REG);
 				if (cur & 0x40) {	/* using LBA? */
-					printk(", LBAsect=%ld", (unsigned long)
+					printk(", LBAsect=%lu", (unsigned long)
 					 ((cur&0xf)<<24)
 					 |(hwif->INB(IDE_HCYL_REG)<<16)
 					 |(hwif->INB(IDE_LCYL_REG)<<8)
@@ -981,8 +976,8 @@
 	args.tfRegister[IDE_SELECT_OFFSET]	= 0x40;
 	args.tfRegister[IDE_COMMAND_OFFSET]	= WIN_READ_NATIVE_MAX_EXT;
 	args.command_type			= ide_cmd_type_parser(&args);
-        /* submit command request */
-        ide_raw_taskfile(drive, &args, NULL);
+	/* submit command request */
+	ide_raw_taskfile(drive, &args, NULL);
 
 	/* if OK, compute maximum address value */
 	if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
@@ -1002,6 +997,8 @@
 /*
  * Sets maximum virtual LBA address of the drive.
  * Returns new maximum virtual LBA address (> 0) or 0 on failure.
+ *
+ * Must be immediately preceded by read_native_max.
  */
 static unsigned long
 idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
@@ -1031,6 +1028,7 @@
 	return addr_set;
 }
 
+/* Note: must be immediately preceded by read_native_max_ext */
 static unsigned long long
 idedisk_set_max_address_ext(ide_drive_t *drive, unsigned long long addr_req)
 {
@@ -1071,114 +1069,153 @@
 
 static unsigned long long
 sectors_to_MB(unsigned long long n) {
-	n <<= 9;			/* make it bytes */
-	do_div(n, 1000000);	 /* make it MB */
+	n <<= 9;		/* make it bytes */
+	do_div(n, 1000000);	/* make it MB */
 	return n;
 }
 
+static inline int
+idedisk_supports_lba(const struct hd_driveid *id)
+{
+	return (id->capability & 2);
+}
+
 /*
- * Tests if the drive supports Host Protected Area feature.
- * Returns true if supported, false otherwise.
+ * Bits 10 of command_set_1 and cfs_enable_1 must be equal,
+ * so on non-buggy drives we need test only one.
+ * However, we should also check whether these fields are valid.
  */
-static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
+static inline int
+idedisk_supports_host_protected_area(const struct hd_driveid *id)
 {
-	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
-	if (flag)
-		printk(KERN_INFO "%s: host protected area => %d\n", drive->name, flag);
-	return flag;
+	return (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
 }
 
 /*
- * Compute drive->capacity, the full capacity of the drive
- * Called with drive->id != NULL.
- *
- * To compute capacity, this uses either of
- *
- *    1. CHS value set by user       (whatever user sets will be trusted)
- *    2. LBA value from target drive (require new ATA feature)
- *    3. LBA value from system BIOS  (new one is OK, old one may break)
- *    4. CHS value from system BIOS  (traditional style)
- *
- * in above order (i.e., if value of higher priority is available,
- * reset will be ignored).
+ * The same here.
  */
-#define IDE_STROKE_LIMIT	(32000*1024*2)
-static void init_idedisk_capacity (ide_drive_t  *drive)
+static inline int
+idedisk_supports_lba48(const struct hd_driveid *id)
 {
-	struct hd_driveid *id = drive->id;
-	unsigned long capacity = drive->cyl * drive->head * drive->sect;
-	unsigned long set_max = idedisk_read_native_max_address(drive);
-	unsigned long long capacity_2 = capacity;
-	unsigned long long set_max_ext;
-
-	drive->capacity48 = 0;
-	drive->select.b.lba = 0;
+	return (id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400);
+}
 
-	(void) idedisk_supports_host_protected_area(drive);
+static inline unsigned long long
+lba48_capacity(const struct hd_driveid *id)
+{
+	return id->lba_capacity_2;
+}
 
-	if (id->cfs_enable_2 & 0x0400) {
-		capacity_2 = id->lba_capacity_2;
-		drive->head		= drive->bios_head = 255;
-		drive->sect		= drive->bios_sect = 63;
-		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
-		drive->select.b.lba	= 1;
-		set_max_ext = idedisk_read_native_max_address_ext(drive);
-		if (set_max_ext > capacity_2 && capacity_2 > IDE_STROKE_LIMIT) {
+/*
+ * See whether some part of the disk was set off as Host Protected Area.
+ * If so, report this, and possible enable access to it.
+ */
+static void
+do_add_hpa(ide_drive_t *drive) {
+	unsigned int capacity;
+	unsigned long set_max;
+
+	capacity = drive->capacity;
+	set_max = idedisk_read_native_max_address(drive);
+
+	if (set_max > capacity) {
+		/* Report */
+		printk(KERN_INFO "%s: Host Protected Area detected.\n"
+		       "    current capacity is %u sectors (%u MB)\n"
+		       "    native  capacity is %lu sectors (%lu MB)\n",
+		       drive->name, capacity,
+		       (capacity - capacity/625 + 974)/1950,
+		       set_max, (set_max - set_max/625 + 974)/1950);
 #ifdef CONFIG_IDEDISK_STROKE
-			set_max_ext = idedisk_read_native_max_address_ext(drive);
-			set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
-			if (set_max_ext) {
-				drive->capacity48 = capacity_2 = set_max_ext;
-				drive->cyl = (unsigned int) set_max_ext / (drive->head * drive->sect);
-				drive->select.b.lba = 1;
-				drive->id->lba_capacity_2 = capacity_2;
-                        }
-#else /* !CONFIG_IDEDISK_STROKE */
-			printk(KERN_INFO "%s: setmax_ext LBA %llu, native  %llu\n",
-				drive->name, set_max_ext, capacity_2);
-#endif /* CONFIG_IDEDISK_STROKE */
+		/* Raise limit */
+		set_max = idedisk_set_max_address(drive, set_max);
+		if (set_max) {
+			drive->capacity = set_max;
+			printk(KERN_INFO "%s: Host Protected Area Disabled\n",
+			       drive->name);
 		}
-		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
-		drive->bios_cyl		= drive->cyl;
-		drive->capacity48	= capacity_2;
-		drive->capacity		= (unsigned long) capacity_2;
-		return;
-	/* Determine capacity, and use LBA if the drive properly supports it */
-	} else if ((id->capability & 2) && lba_capacity_is_ok(id)) {
-		capacity = id->lba_capacity;
-		drive->cyl = capacity / (drive->head * drive->sect);
-		drive->select.b.lba = 1;
+#endif
 	}
+}
+
+static void
+do_add_hpa48(ide_drive_t *drive) {
+	unsigned long long set_max_ext;
 
-	if (set_max > capacity && capacity > IDE_STROKE_LIMIT) {
+	set_max_ext = idedisk_read_native_max_address_ext(drive);
+	if (set_max_ext > drive->capacity48) {
+		unsigned long long nativeMB, currentMB;
+
+		/* Report on additional space */
+		nativeMB = sectors_to_MB(set_max_ext);
+		currentMB = sectors_to_MB(drive->capacity48);
+		printk(KERN_INFO
+		       "%s: Host Protected Area detected.\n"
+		       "    current capacity is %llu sectors (%llu MB)\n"
+		       "    native  capacity is %llu sectors (%llu MB)\n",
+		       drive->name, drive->capacity48, currentMB,
+		       set_max_ext, nativeMB);
 #ifdef CONFIG_IDEDISK_STROKE
-		set_max = idedisk_read_native_max_address(drive);
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
+		/* Raise limit */
+		set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
+		if (set_max_ext) {
+			drive->capacity48 = set_max_ext;
+			printk(KERN_INFO
+			       "%s: Host Protected Area Disabled\n",
+			       drive->name);
+		}
+#endif
 	}
+}
 
-	drive->capacity = capacity;
+/*
+ * Compute drive->capacity, the amount accessible with CHS/LBA commands,
+ * and drive->capacity48, the amount accessible with LBA48 commands.
+ * Also sets drive->select.b.lba.
+ *
+ * Called with drive->id != NULL.
+ */
+static void init_idedisk_capacity(ide_drive_t *drive)
+{
+	struct hd_driveid *id;
+	unsigned long capacity;
+	unsigned long long capacity48;
+
+	id = drive->id;
+
+	if (idedisk_supports_lba48(id)) {
+		/* drive speaks 48-bit LBA */
+		drive->capacity48 = capacity48 = lba48_capacity(id);
+		capacity = capacity48;		/* truncate to 32 bits */
+		if (capacity == capacity48)
+			drive->capacity = capacity;
+		else
+			drive->capacity = 0xffffffff;
+		drive->select.b.lba = 1;
+	} else if (idedisk_supports_lba(id) && lba_capacity_is_ok(id)) {
+		/* drive speaks 28-bit LBA */
+		drive->capacity = capacity = id->lba_capacity;
+		drive->capacity48 = 0;
+		drive->select.b.lba = 1;
+	} else {
+		/* drive speaks CHS only */
+		capacity = drive->cyl * drive->head * drive->sect;
+		drive->capacity = capacity;
+		drive->capacity48 = 0;
+		drive->select.b.lba = 0;
+	}
 
-	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
-		drive->capacity48 = id->lba_capacity_2;
-		drive->head = 255;
-		drive->sect = 63;
-		drive->cyl = (unsigned long)(drive->capacity48) / (drive->head * drive->sect);
+	if (idedisk_supports_host_protected_area(id)) {
+		if (idedisk_supports_lba48(id))
+			do_add_hpa48(drive);
+		else
+			do_add_hpa(drive);
 	}
 }
 
 static sector_t idedisk_capacity (ide_drive_t *drive)
 {
-	if (drive->id->cfs_enable_2 & 0x0400)
+	if (idedisk_supports_lba48(drive->id))
 		return (drive->capacity48 - drive->sect0);
 	return (drive->capacity - drive->sect0);
 }
@@ -1469,7 +1506,7 @@
 	if (HWIF(drive)->addressing)
 		return 0;
 
-	if (!(drive->id->cfs_enable_2 & 0x0400))
+	if (!idedisk_supports_lba48(drive->id))
 		return -EIO;
 	drive->addressing = arg;
 	return 0;
@@ -1639,19 +1676,29 @@
 	 * by correcting bios_cyls:
 	 */
 	capacity = idedisk_capacity (drive);
-	if (!drive->forced_geom && drive->bios_sect && drive->bios_head) {
-		unsigned int cap0 = capacity;   /* truncate to 32 bits */
-		unsigned int cylsz, cyl;
-
-		if (cap0 != capacity)
-			drive->bios_cyl = 65535;
-		else {
-			cylsz = drive->bios_sect * drive->bios_head;
-			cyl = cap0 / cylsz;
-			if (cyl > 65535)
-				cyl = 65535;
-			if (cyl > drive->bios_cyl)
-				drive->bios_cyl = cyl;
+	if (!drive->forced_geom) {
+		int lba48 = idedisk_supports_lba48(id);
+
+		if (lba48) {
+			/* compatibility */
+			drive->bios_sect = 63;
+			drive->bios_head = 255;
+		}
+
+		if (drive->bios_sect && drive->bios_head) {
+			unsigned int cap0 = capacity; /* truncate to 32 bits */
+			unsigned int cylsz, cyl;
+
+			if (cap0 != capacity)
+				drive->bios_cyl = 65535;
+			else {
+				cylsz = drive->bios_sect * drive->bios_head;
+				cyl = cap0 / cylsz;
+				if (cyl > 65535)
+					cyl = 65535;
+				if (cyl > drive->bios_cyl || lba48)
+					drive->bios_cyl = cyl;
+			}
 		}
 	}
 	printk(KERN_INFO "%s: %llu sectors (%llu MB)",
