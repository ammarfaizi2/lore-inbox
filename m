Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285937AbRLYWw6>; Tue, 25 Dec 2001 17:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285944AbRLYWws>; Tue, 25 Dec 2001 17:52:48 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:56802 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S285937AbRLYWwe>;
	Tue, 25 Dec 2001 17:52:34 -0500
Date: Tue, 25 Dec 2001 23:52:31 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Andries.Brouwer@cwi.nl
cc: jlladono@pie.xtec.es, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x kernels, big ide disks and old bios
In-Reply-To: <UTC200112251638.QAA94646.aeb@cwi.nl>
Message-ID: <Pine.LNX.4.43.0112252340390.16675-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Dec 2001 Andries.Brouwer@cwi.nl wrote:
> : What I'm using is change the geometry after the boot and before any
> : partition besides root is mounted, I do this at the beginning of
> : checkroot.sh by calling "/sbin/setmax -d 0 /dev/hda"
> : This works ok for me, of course you can have other solutions.
>
> Good to hear that it works OK. Sooner or later setmax or something
> similar must become part of the standard kernel, but so far I've
> gotten almost no feedback. Can you give the disk manufacturer and model
> (mail aeb@cwi.nl)?

The kernel part is already there in Andre Hedrick's IDE-patches for
2.2.x and 2.4.x. I don't know why it's not in standard 2.4.x.

Patch below is for 2.4.x, extracted from Andre's code. Works For Me(tm).

Eric


--- linux/drivers/ide/ide-disk.c~	Fri Oct 27 08:35:48 2000
+++ linux/drivers/ide/ide-disk.c	Sun Jan  7 23:04:57 2001
@@ -513,24 +513,149 @@
 			current_capacity(drive));
 }

+
+/*
+ * Tests if the drive supports Host Protected Area feature.
+ * Returns true if supported, false otherwise.
+ */
+static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
+{
+ int flag = (drive->id->command_set_1 & 0x0400) ? 1 : 0;
+ printk("%s: host protected area => %d\n", drive->name, flag);
+ return flag;
+}
+
+/*
+ * Queries for true maximum capacity of the drive.
+ * Returns maximum LBA address (> 0) of the drive, 0 if failed.
+ */
+static unsigned long idedisk_read_native_max_address(ide_drive_t *drive)
+{
+ byte args[7];
+ unsigned long addr = 0;
+
+ printk("%s: checking for max native LBA...\n", drive->name);
+
+ /* Create IDE/ATA command request structure
+ *
+ * NOTE: I'm not sure if I can safely use IDE_*_OFFSET macro
+ * here...For real ATA command structure, offset for IDE
+ * command is 7, but in IDE driver, it needs to be at 0th
+ * index (same goes for IDE status offset below). Hmm...
+ */
+ args[0] = 0xf8; /* READ_NATIVE_MAX - see ATA spec */
+ args[IDE_FEATURE_OFFSET] = 0x00;
+ args[IDE_NSECTOR_OFFSET] = 0x00;
+ args[IDE_SECTOR_OFFSET] = 0x00;
+ args[IDE_LCYL_OFFSET] = 0x00;
+ args[IDE_HCYL_OFFSET] = 0x00;
+ args[IDE_SELECT_OFFSET] = 0x40;
+
+ /* submit command request - if OK, read current max LBA value */
+ if (ide_wait_cmd_task(drive, args) == 0) {
+ if ((args[0] & 0x01) == 0) {
+ addr = ((args[IDE_SELECT_OFFSET] & 0x0f) << 24)
+ | ((args[IDE_HCYL_OFFSET] ) << 16)
+ | ((args[IDE_LCYL_OFFSET] ) << 8)
+ | ((args[IDE_SECTOR_OFFSET] ));
+ }
+ }
+
+ printk("%s: max native LBA is %lu\n", drive->name, addr);
+
+ return addr;
+}
+
+/*
+ * Sets maximum virtual LBA address of the drive.
+ * Returns new maximum virtual LBA address (> 0) or 0 on failure.
+ */
+static unsigned long idedisk_set_max_address(ide_drive_t *drive,
+ unsigned long addr_req)
+{
+ byte args[7];
+ unsigned long addr_set = 0;
+
+ printk("%s: (un)clipping max LBA...\n", drive->name);
+
+ /* Create IDE/ATA command request structure
+ *
+ * NOTE: I'm not sure if I can safely use IDE_*_OFFSET macro
+ * here...For real ATA command structure, offset for IDE
+ * command is 7, but in IDE driver, it needs to be at 0th
+ * index (same goes for IDE status offset below). Hmm...
+ */
+ args[0] = 0xf9; /* SET_MAX - see ATA spec */
+ args[IDE_FEATURE_OFFSET] = 0x00;
+ args[IDE_NSECTOR_OFFSET] = 0x00;
+ args[IDE_SECTOR_OFFSET] = ((addr_req ) & 0xff);
+ args[IDE_LCYL_OFFSET] = ((addr_req >> 8) & 0xff);
+ args[IDE_HCYL_OFFSET] = ((addr_req >> 16) & 0xff);
+ args[IDE_SELECT_OFFSET] = ((addr_req >> 24) & 0x0f) | 0x40;
+
+ /* submit command request - if OK, read new max LBA value */
+ if (ide_wait_cmd_task(drive, args) == 0) {
+ if ((args[0] & 0x01) == 0) {
+ addr_set = ((args[IDE_SELECT_OFFSET] & 0x0f) << 24)
+ | ((args[IDE_HCYL_OFFSET] ) << 16)
+ | ((args[IDE_LCYL_OFFSET] ) << 8)
+ | ((args[IDE_SECTOR_OFFSET] ));
+ }
+ }
+
+ printk("%s: max LBA (un)clipped to %lu\n", drive->name, addr_set);
+
+ return addr_set;
+}
+
 /*
  * Compute drive->capacity, the full capacity of the drive
  * Called with drive->id != NULL.
+ *
+ * To compute capacity, this uses either of
+ *
+ * 1. CHS value set by user (whatever user sets will be trusted)
+ * 2. LBA value from target drive (require new ATA feature)
+ * 3. LBA value from system BIOS (new one is OK, old one may break)
+ * 4. CHS value from system BIOS (traditional style)
+ *
+ * in above order (i.e., if value of higher priority is available,
+ * rest of the values are ignored).
  */
 static void init_idedisk_capacity (ide_drive_t  *drive)
 {
+ unsigned long hd_max;
+ unsigned long hd_cap = drive->cyl * drive->head * drive->sect;
+ int is_lba = 0;
+
 	struct hd_driveid *id = drive->id;
-	unsigned long capacity = drive->cyl * drive->head * drive->sect;

-	drive->select.b.lba = 0;
+ /* Unless geometry is given by user, use autodetected value */
+ if (! drive->forced_geom) {
+ /* If BIOS LBA geometry is available, use it */
+ if ((id->capability & 2) && lba_capacity_is_ok(id)) {
+ hd_cap = id->lba_capacity;
+ is_lba = 1;
+ }

-	/* Determine capacity, and use LBA if the drive properly supports it */
-	if ((id->capability & 2) && lba_capacity_is_ok(id)) {
-		capacity = id->lba_capacity;
-		drive->cyl = capacity / (drive->head * drive->sect);
-		drive->select.b.lba = 1;
+ /* If new ATA feature is supported, try using it */
+ if (idedisk_supports_host_protected_area(drive)) {
+ hd_max = idedisk_read_native_max_address(drive);
+ hd_max = idedisk_set_max_address(drive, hd_max);
+
+ if (hd_max > 0) {
+ hd_cap = hd_max+1;
+ is_lba = 1;
+ }
+ }
 	}
-	drive->capacity = capacity;
+
+ printk("%s: lba = %d, cap = %lu\n", drive->name, is_lba, hd_cap);
+
+ /* update parameters with fetched results */
+ drive->select.b.lba = is_lba;
+ drive->capacity = hd_cap;
+ drive->cyl = hd_cap / (drive->head * drive->sect);
 }

 static unsigned long idedisk_capacity (ide_drive_t  *drive)

