Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130214AbQKRUB6>; Sat, 18 Nov 2000 15:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131026AbQKRUBi>; Sat, 18 Nov 2000 15:01:38 -0500
Received: from h14-130.tokyu-net.catv.ne.jp ([202.221.14.130]:2432 "EHLO
	research.imasy.or.jp") by vger.kernel.org with ESMTP
	id <S130214AbQKRUB2>; Sat, 18 Nov 2000 15:01:28 -0500
Date: Sun, 19 Nov 2000 04:30:34 +0900
Message-Id: <200011181930.eAIJUYA01883@research.imasy.or.jp>
From: Taisuke Yamada <tai@imasy.or.jp>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org, tai@imasy.or.jp
Subject: [PATCH] Large "clipped" IDE disk support for 2.4 when using old BIOS
X-Mailer: mnews [version 1.22PL4] 2000-05/28(Sun)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

Earlier this month, I had sent in a patch to 2.2.18pre17 (with
IDE-patch from http://www.linux-ide.org/ applied) to add support
for IDE disk larger than 32GB, even if the disk required "clipping"
to reduce apparent disk size due to BIOS limitation.

BIOS known to have this limitation is Award 4.51 (and before) and
it seems many mainboards with not-so-great vendor support still use it.

Now I'm moving to 2.4-based system, and so ported the patch to
2.4-test10. It also applies cleanly to 2.4-test11.

With this patch, you will be able to use disk capacity above
32GB (or 2GB/8GB depending on how clipping take effect), and
still be able to boot off from the disk because you can leave
the "clipping" turned on.

>From my experience, this patch works with both software and
hardware clipping (or jumpering). This is probably because
hardware jumper works as a flag to the disk to enable software
clipping on hardware reset. But I'm not sure if this applies to
all disks.

By the way, is it safe for me to use IDE_*_OFFSET macro as a index
for IDE task command buffer? I couldn't use IDE_COMMAND_OFFSET (== 7),
and had to specify 0 because that's what ide_cmd function requires.

Anyway, here's the patch. Hope it works well on other systems...

--- cut here --- cut here --- cut here --- cut here --- cut here ---
--- linux/drivers/ide/ide-disk.c.orig    Sun Nov 19 03:17:57 2000
+++ linux/drivers/ide/ide-disk.c    Sun Nov 19 03:22:43 2000
@@ -514,23 +514,147 @@
 }
 
 /*
+ * Tests if the drive supports Host Protected Area feature.
+ * Returns true if supported, false otherwise.
+ */
+static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
+{
+    int flag = (drive->id->command_set_1 & 0x0a) ? 1 : 0;
+    printk("%s: host protected area => %d\n", drive->name, flag);
+    return flag;
+}
+
+/*
+ * Queries for true maximum capacity of the drive.
+ * Returns maximum LBA address (> 0) of the drive, 0 if failed.
+ */
+static unsigned long idedisk_read_native_max_address(ide_drive_t *drive)
+{
+    byte args[7];
+    unsigned long addr = 0;
+
+    printk("%s: checking for max native LBA...\n", drive->name);
+
+    /* Create IDE/ATA command request structure
+     *
+     * NOTE: I'm not sure if I can safely use IDE_*_OFFSET macro
+     *       here...For real ATA command structure, offset for IDE
+     *       command is 7, but in IDE driver, it needs to be at 0th
+     *       index (same goes for IDE status offset below). Hmm...
+     */
+    args[0]                  = 0xf8; /* READ_NATIVE_MAX - see ATA spec */
+    args[IDE_FEATURE_OFFSET] = 0x00;
+    args[IDE_NSECTOR_OFFSET] = 0x00;
+    args[IDE_SECTOR_OFFSET]  = 0x00;
+    args[IDE_LCYL_OFFSET]    = 0x00;
+    args[IDE_HCYL_OFFSET]    = 0x00;
+    args[IDE_SELECT_OFFSET]  = 0x40;
+
+    /* submit command request - if OK, read current max LBA value */
+    if (ide_wait_cmd_task(drive, args) == 0) {
+        if ((args[0] & 0x01) == 0) {
+            addr = ((args[IDE_SELECT_OFFSET] & 0x0f) << 24)
+                 | ((args[IDE_HCYL_OFFSET]         ) << 16)
+                 | ((args[IDE_LCYL_OFFSET]         ) <<  8)
+                 | ((args[IDE_SECTOR_OFFSET]       ));
+        }
+    }
+
+    printk("%s: max native LBA is %lu\n", drive->name, addr);
+
+    return addr;
+}
+
+/*
+ * Sets maximum virtual LBA address of the drive.
+ * Returns new maximum virtual LBA address (> 0) or 0 on failure.
+ */
+static unsigned long idedisk_set_max_address(ide_drive_t  *drive,
+                         unsigned long addr_req)
+{
+    byte args[7];
+    unsigned long addr_set = 0;
+
+    printk("%s: (un)clipping max LBA...\n", drive->name);
+
+    /* Create IDE/ATA command request structure
+     *
+     * NOTE: I'm not sure if I can safely use IDE_*_OFFSET macro
+     *       here...For real ATA command structure, offset for IDE
+     *       command is 7, but in IDE driver, it needs to be at 0th
+     *       index (same goes for IDE status offset below). Hmm...
+     */
+    args[0]                  = 0xf9; /* SET_MAX - see ATA spec */
+    args[IDE_FEATURE_OFFSET] = 0x00;
+    args[IDE_NSECTOR_OFFSET] = 0x00;
+    args[IDE_SECTOR_OFFSET]  = ((addr_req      ) & 0xff);
+    args[IDE_LCYL_OFFSET]    = ((addr_req >>  8) & 0xff);
+    args[IDE_HCYL_OFFSET]    = ((addr_req >> 16) & 0xff);
+    args[IDE_SELECT_OFFSET]  = ((addr_req >> 24) & 0x0f) | 0x40;
+
+    /* submit command request - if OK, read new max LBA value */
+    if (ide_wait_cmd_task(drive, args) == 0) {
+        if ((args[0] & 0x01) == 0) {
+            addr_set = ((args[IDE_SELECT_OFFSET] & 0x0f) << 24)
+                 | ((args[IDE_HCYL_OFFSET]         ) << 16)
+                 | ((args[IDE_LCYL_OFFSET]         ) <<  8)
+                 | ((args[IDE_SECTOR_OFFSET]       ));
+        }
+    }
+
+    printk("%s: max LBA (un)clipped to %lu\n", drive->name, addr_set);
+
+    return addr_set;
+}
+
+/*
  * Compute drive->capacity, the full capacity of the drive
  * Called with drive->id != NULL.
+ *
+ * To compute capacity, this uses either of
+ *
+ *    1. CHS value set by user       (whatever user sets will be trusted)
+ *    2. LBA value from target drive (require new ATA feature)
+ *    3. LBA value from system BIOS  (new one is OK, old one may break)
+ *    4. CHS value from system BIOS  (traditional style)
+ *
+ * in above order (i.e., if value of higher priority is available,
+ * rest of the values are ignored).
  */
 static void init_idedisk_capacity (ide_drive_t  *drive)
 {
+    unsigned long      hd_max;
+    unsigned long      hd_cap = drive->cyl * drive->head * drive->sect;
+    int                is_lba = 0;
+
     struct hd_driveid *id = drive->id;
-    unsigned long capacity = drive->cyl * drive->head * drive->sect;
 
-    drive->select.b.lba = 0;
+    /* Unless geometry is given by user, use autodetected value */
+    if (! drive->forced_geom) {
+        /* If BIOS LBA geometry is available, use it */
+        if ((id->capability & 2) && lba_capacity_is_ok(id)) {
+            hd_cap = id->lba_capacity;
+            is_lba = 1;
+        }
 
-    /* Determine capacity, and use LBA if the drive properly supports it */
-    if ((id->capability & 2) && lba_capacity_is_ok(id)) {
-        capacity = id->lba_capacity;
-        drive->cyl = capacity / (drive->head * drive->sect);
-        drive->select.b.lba = 1;
+        /* If new ATA feature is supported, try using it */
+        if (idedisk_supports_host_protected_area(drive)) {
+            hd_max = idedisk_read_native_max_address(drive);
+            hd_max = idedisk_set_max_address(drive, hd_max);
+
+            if (hd_max > 0) {
+                hd_cap = hd_max;
+                is_lba = 1;
+            }
+        }
     }
-    drive->capacity = capacity;
+
+    printk("%s: lba = %d, cap = %lu\n", drive->name, is_lba, hd_cap);
+
+    /* update parameters with fetched results */
+    drive->select.b.lba = is_lba;
+    drive->capacity     = hd_cap;
+    drive->cyl          = hd_cap / (drive->head * drive->sect);
 }
 
 static unsigned long idedisk_capacity (ide_drive_t  *drive)
--- cut here --- cut here --- cut here --- cut here --- cut here ---

--
Taisuke Yamada <tai@imasy.or.jp>
PGP fingerprint = 6B 57 1B ED 65 4C 7D AE  57 1B 49 A7 F7 C8 23 46
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
