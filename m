Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129374AbQKHORT>; Wed, 8 Nov 2000 09:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQKHORK>; Wed, 8 Nov 2000 09:17:10 -0500
Received: from h12-001.tokyu-net.catv.ne.jp ([202.221.12.1]:23356 "EHLO
	research.imasy.or.jp") by vger.kernel.org with ESMTP
	id <S129374AbQKHOQy>; Wed, 8 Nov 2000 09:16:54 -0500
Date: Wed, 8 Nov 2000 23:16:42 +0900
Message-Id: <200011081416.eA8EGg001886@research.imasy.or.jp>
From: Taisuke Yamada <tai@imasy.or.jp>
To: linux-kernel@vger.kernel.org
Subject: Patch: Using clipped IDE disk larger than 32GB with old BIOS
X-Mailer: mnews [version 1.22PL4] 2000-05/28(Sun)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

Last weekend, I bought new 45GB Maxtor IDE disk for my old
Tekram mainboard (P6L40-A4X, Award BIOS 4.5x), and noticed
I can't get Linux to recognize more than 32GB.

In fact, it didn't even boot without clipping the capacity of
the disk. And once clipped, Linux just never sees past 32GB border.

So I then looked into past discussion, and found several articles
on this issue. Now I'm back again with the patch to fix the problem.

Following patch should work with 2.2.18pre17 with latest IDE driver
patch from http://www.linux-ide.org/ already applied. As I'm using
other patches (such as reiserfs) also, you might need minor fix to
apply it cleanly (shouldn't be a problem as they don't touch IDE
code anyway).

This patch uses READ NATIVE MAX ADDRESS and SET MAX ADDRESS command
to figure out real disk capacity. These commands are supported by
many (most?) of today's IDE/ATA drives. With this patch, you should
be able to support IDE/ATA disk up to size of ~128GB, even if you
are using old BIOS which require disk capacity clipping.

# I might consider adding support for even newer 48-bit LBA
# extension (which I read in ATA spec). This will push the
# limit up to 128PB (wow!).

As a final note, as I'm not a kernel expert (this is my first attempt
to send kernel patch), so you should better look into the patch before
applying. It worked for me, so may work for you. Good luck.

--- cut here --- cut here --- cut here --- cut here --- cut here ---
*** linux-2.2.18pre17-ide-reiserfs-i2c/drivers/block/ide-disk.c    Sun Nov  5 11:25:48 2000
--- linux-2.2.18pre17-ide-reiserfs-i2c.tai/drivers/block/ide-disk.c    Wed Nov  8 22:28:51 2000
***************
*** 523,545 ****
  }
  
  /*
   * Compute drive->capacity, the full capacity of the drive
   * Called with drive->id != NULL.
   */
  static void init_idedisk_capacity (ide_drive_t  *drive)
  {
      struct hd_driveid *id = drive->id;
-     unsigned long capacity = drive->cyl * drive->head * drive->sect;
  
!     drive->select.b.lba = 0;
  
!     /* Determine capacity, and use LBA if the drive properly supports it */
!     if ((id->capability & 2) && lba_capacity_is_ok(id)) {
!         capacity = id->lba_capacity;
!         drive->cyl = capacity / (drive->head * drive->sect);
!         drive->select.b.lba = 1;
      }
!     drive->capacity = capacity;
  }
  
  static unsigned long idedisk_capacity (ide_drive_t  *drive)
--- 523,676 ----
  }
  
  /*
+  * Tests if the drive supports Host Protected Area feature.
+  * Returns true if supported, false otherwise.
+  */
+ static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
+ {
+     int flag = (drive->id->command_set_1 & 0x0a) ? 1 : 0;
+     printk("%s: host protected area => %d\n", drive->name, flag);
+     return flag;
+ }
+ 
+ /*
+  * Queries for true maximum capacity of the drive.
+  * Returns maximum LBA address (> 0) of the drive, 0 if failed.
+  */
+ static unsigned long idedisk_read_native_max_address(ide_drive_t *drive)
+ {
+     ide_task_t    args;
+     unsigned long addr = 0;
+ 
+     printk("%s: checking for max native LBA...\n", drive->name);
+ 
+     /* Create IDE/ATA command request structure */
+     memset(&args, 0, HDIO_DRIVE_TASK_HDR_SIZE);
+     args.tfRegister[IDE_FEATURE_OFFSET] = 0x00;
+     args.tfRegister[IDE_NSECTOR_OFFSET] = 0x00;
+     args.tfRegister[IDE_SECTOR_OFFSET]  = 0x00;
+     args.tfRegister[IDE_LCYL_OFFSET]    = 0x00;
+     args.tfRegister[IDE_HCYL_OFFSET]    = 0x00;
+     args.tfRegister[IDE_SELECT_OFFSET]  = 0x40;
+     args.tfRegister[IDE_COMMAND_OFFSET] = WIN_READ_NATIVE_MAX;
+ 
+     /* NOTE: I need to call parser function to
+      *       initialize internal pointer to handler function */
+     if ((args.command_type =
+          ide_cmd_type_parser(&args)) == IDE_DRIVE_TASK_INVALID) {
+         return addr;
+     }
+ 
+     /* submit command request */
+     ide_wait_cmd_task(drive, args.command_type, &args, NULL);
+ 
+     /* if OK, compute maximum address value */
+     if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
+         addr = ((args.tfRegister[IDE_SELECT_OFFSET] & 0x0f) << 24)
+              | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
+              | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
+              | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+     }
+ 
+     printk("%s: max native LBA is %lu\n", drive->name, addr);
+ 
+     return addr;
+ }
+ 
+ /*
+  * Sets maximum virtual LBA address of the drive.
+  * Returns new maximum virtual LBA address (> 0) or 0 on failure.
+  */
+ static unsigned long idedisk_set_max_address(ide_drive_t  *drive,
+                          unsigned long addr_req)
+ {
+     ide_task_t    args;
+     unsigned long addr_set = 0;
+ 
+     printk("%s: (un)clipping max LBA...\n", drive->name);
+ 
+     /* Create IDE/ATA command request structure */
+     memset(&args, 0, HDIO_DRIVE_TASK_HDR_SIZE);
+     args.tfRegister[IDE_FEATURE_OFFSET] = 0x00;
+     args.tfRegister[IDE_NSECTOR_OFFSET] = 0x00;
+     args.tfRegister[IDE_SECTOR_OFFSET]  = ((addr_req >>  0) & 0xff);
+     args.tfRegister[IDE_LCYL_OFFSET]    = ((addr_req >>  8) & 0xff);
+     args.tfRegister[IDE_HCYL_OFFSET]    = ((addr_req >> 16) & 0xff);
+     args.tfRegister[IDE_SELECT_OFFSET]  = ((addr_req >> 24) & 0x0f) | 0x40;
+     args.tfRegister[IDE_COMMAND_OFFSET] = WIN_SET_MAX;
+ 
+     /* NOTE: I need to call parser function to
+      *       initialize internal pointer to handler function */
+     if ((args.command_type =
+          ide_cmd_type_parser(&args)) == IDE_DRIVE_TASK_INVALID) {
+         return addr_set;
+     }
+ 
+     /* submit command request */
+     ide_wait_cmd_task(drive, args.command_type, &args, NULL);
+ 
+     /* if OK, read new maximum address value */
+     if ((args.tfRegister[IDE_STATUS_OFFSET] & 0x01) == 0) {
+         addr_set = ((args.tfRegister[IDE_SELECT_OFFSET] & 0x0f) << 24)
+              | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
+              | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
+              | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+     }
+ 
+     printk("%s: max LBA (un)clipped to %lu\n", drive->name, addr_set);
+ 
+     return addr_set;
+ }
+ 
+ /*
   * Compute drive->capacity, the full capacity of the drive
   * Called with drive->id != NULL.
+  *
+  * To compute capacity, this uses either of
+  *
+  *    1. CHS value set by user       (whatever user sets will be trusted)
+  *    2. LBA value from target drive (require new ATA feature)
+  *    3. LBA value from system BIOS  (new one is OK, old one may break)
+  *    4. CHS value from system BIOS  (traditional style)
+  *
+  * in above order (i.e., if value of higher priority is available,
+  * reset will be ignored).
   */
  static void init_idedisk_capacity (ide_drive_t  *drive)
  {
+     unsigned long      hd_max;
+     unsigned long      hd_cap = drive->cyl * drive->head * drive->sect;
+     int                is_lba = 0;
+ 
      struct hd_driveid *id = drive->id;
  
!     /* Unless geometry is given by user, use autodetected value */
!     if (! drive->forced_geom) {
!         /* If valid BIOS LBA geometry is available, use it */
!         if ((id->capability & 2) && lba_capacity_is_ok(id)) {
!             hd_cap = id->lba_capacity;
!             is_lba = 1;
!         }
  
!         /* If the drive supports new ATA feature, try it */
!         if (idedisk_supports_host_protected_area(drive)) {
!             hd_max = idedisk_read_native_max_address(drive);
!             hd_max = idedisk_set_max_address(drive, hd_max);
! 
!             if (hd_max > 0) {
!                 hd_cap = hd_max;
!                 is_lba = 1;
!             }
!         }
      }
! 
!     printk("%s: lba = %d, cap = %lu\n", drive->name, is_lba, hd_cap);
! 
! #if 1 /* ifdef-out this part for "dry-run" - tai@imasy.or.jp */
!     drive->select.b.lba = is_lba;
!     drive->capacity     = hd_cap;
!     drive->cyl          = hd_cap / (drive->head * drive->sect);
! #endif
  }
  
  static unsigned long idedisk_capacity (ide_drive_t  *drive)
--- cut here --- cut here --- cut here --- cut here --- cut here ---

--
T. Yamada <tai@imasy.or.jp> (http://www.imasy.or.jp/~tai/index.html.{ja,en})
PGP fingerprint = 6B 57 1B ED 65 4C 7D AE  57 1B 49 A7 F7 C8 23 46
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
