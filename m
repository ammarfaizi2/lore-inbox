Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287951AbSAMC6K>; Sat, 12 Jan 2002 21:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288007AbSAMC4G>; Sat, 12 Jan 2002 21:56:06 -0500
Received: from PHNX1-UBR2-4-hfc-0251-d1dae065.rdc1.az.coxatwork.com ([209.218.224.101]:55683
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S287994AbSAMCyh>; Sat, 12 Jan 2002 21:54:37 -0500
Message-ID: <006f01c19bdd$a4d5fe90$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Paul Bristow" <paul@paulbristow.net>
Subject: [CFT][PATCH] ide-floppy cleanups/media change detection (5/5)
Date: Sat, 12 Jan 2002 19:54:39 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 5 follows, implementing media change detection as follows:

The ide-floppy module will now cause media revalidation under these
circumstances:

- when media has been exchanged for different-sized media
- when media has been previously ejected using the CDROMEJECT ioctl
- when media has been previously formatted using the *FORMAT ioctl
- when media was not previously present

For these operations to happen properly, a small patch to ide-probe.c
(previously sent to Marcelo and queued for 2.4.18-preX) is required so that
the gendisk layer will treat ide-floppy devices as removable media devices.
In addition, if devfs is in use, a small (<20 lines) patch to
fs/partitions/check.c is required so that the devfs partition entries will
be kept in sync with the media when revalidations occur. Richard Gooch will
be including that patch in an upcoming devfs update patch.

--- linux-4/drivers/ide/ide-floppy.c Sat Jan 12 19:00:33 2002
+++ linux-5/drivers/ide/ide-floppy.c Sat Jan 12 19:12:31 2002
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/ide-floppy.c Version 0.97.sv Jan 14 2001
+ * linux/drivers/ide/ide-floppy.c Version 0.98.sv Jan 11 2002
  *
  * Copyright (C) 1996 - 1999 Gadi Oxman <gadio@netvision.net.il>
  * Copyright (C) 2000 - 2001 Paul Bristow <paul@paulbristow.net>
@@ -71,9 +71,12 @@
  *                       including set_bit patch from Rusty Russel
  * Ver 0.97  Jul 22 01   Merge 0.91-0.96 onto 0.9.sv for ac series
  * Ver 0.97.sv Aug 3 01  Backported from 2.4.7-ac3
+ * Ver 0.98.sv Jan 11 02 Implemented media change detection, removed large
+ *                       structures allocated on the stack, moved
lock/unlock
+ *                       code into a separate function
<kevin@labsysgrp.com>
  */

-#define IDEFLOPPY_VERSION "0.97.sv"
+#define IDEFLOPPY_VERSION "0.98.sv"

 #include <linux/config.h>
 #include <linux/module.h>
@@ -282,7 +285,8 @@
   * Device information
   */
  int blocks, block_size, bs_factor;   /* Current format */
- idefloppy_capacity_descriptor_t capacity;  /* Last format capacity */
+ idefloppy_capacity_descriptor_t capacity;  /* Current media capacity */
+ int capacity_invalid;                                   /* Is the current
capacity unusable? */
  idefloppy_flexible_disk_page_t flexible_disk_page; /* Copy of the flexible
disk page */
  int wp;       /* Write protect */
  int srfp;   /* Supports format progress report */
@@ -1359,22 +1363,14 @@
 }

 /*
- * Determine if a media is present in the floppy drive, and if so,
- * its LBA capacity.
+ *      Get the current capacity descriptor for the drive.
  */
-static int idefloppy_get_capacity (ide_drive_t *drive)
-{
- idefloppy_floppy_t *floppy = drive->driver_data;
+static int idefloppy_get_current_capacity_descriptor (ide_drive_t *drive,
idefloppy_capacity_descriptor_t *descriptor) {
  idefloppy_pc_t *pc;
  idefloppy_capacity_header_t *header;
- idefloppy_capacity_descriptor_t *descriptor;
- int i, descriptors, rc = 1, blocks, length;
+ idefloppy_floppy_t *floppy = drive->driver_data;
+ int rc = 1;

- drive->bios_cyl = 0;
- drive->bios_head = drive->bios_sect = 0;
- floppy->blocks = floppy->bs_factor = 0;
- drive->part[0].nr_sects = 0;
-
  if ((pc = (idefloppy_pc_t *) kmalloc (sizeof (idefloppy_pc_t),
GFP_KERNEL)) == NULL) {
   printk (KERN_ERR "ide-floppy: %s: Can't allocate a packet command
structure\n", drive->name);
   return 1;
@@ -1383,50 +1379,70 @@
  idefloppy_create_read_capacity_cmd (pc);
  if (idefloppy_queue_pc_tail (drive, pc)) {
   printk (KERN_ERR "ide-floppy: Can't get floppy parameters\n");
-  kfree (pc);
-  return 1;
+ } else {
+  header = (idefloppy_capacity_header_t *) pc->buffer;
+  *descriptor = *((idefloppy_capacity_descriptor_t *) (header + 1));
+  descriptor->blocks = ntohl(descriptor->blocks);
+  descriptor->length = ntohs(descriptor->length);
+/* Clik! drive returns CAPACITY_UNFORMATTED instead of CAPACITY_CURRENT */
+  if ((descriptor->dc == CAPACITY_UNFORMATTED) &&
test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags))
+   descriptor->dc = CAPACITY_CURRENT;
+  rc = 0;
  }
- header = (idefloppy_capacity_header_t *) pc->buffer;
- descriptors = header->length / sizeof (idefloppy_capacity_descriptor_t);
- descriptor = (idefloppy_capacity_descriptor_t *) (header + 1);
-
- for (i = 0; i < descriptors; i++, descriptor++) {
-                blocks = descriptor->blocks = ntohl (descriptor->blocks);
-                length = descriptor->length = ntohs (descriptor->length);
+ kfree (pc);
+ return rc;
+}

-  if (!i)
-  {
-           switch (descriptor->dc) {
-                case CAPACITY_UNFORMATTED: /* Clik! drive returns this
instead of CAPACITY_CURRENT */
-                        if (!test_bit(IDEFLOPPY_CLIK_DRIVE,
&floppy->flags))
-                                break; /* If it is not a clik drive, break
out (maintains previous driver behaviour) */
-                case CAPACITY_CURRENT: /* Normal Zip/LS-120 disks */
-                        if (memcmp (descriptor, &floppy->capacity, sizeof
(idefloppy_capacity_descriptor_t)))
-                                printk (KERN_INFO "%s: %dkB, %d blocks, %d
sector size\n", drive->name, blocks * length / 1024, blocks, length);
-                        floppy->capacity = *descriptor;
-                        if (!length || length % 512)
-                                printk (KERN_NOTICE "%s: %d bytes block
size not supported\n", drive->name, length);
-                        else {
-                                floppy->blocks = blocks;
-                                floppy->block_size = length;
-                                if ((floppy->bs_factor = length / 512) !=
1)
-                                        printk (KERN_NOTICE "%s: warning:
non 512 bytes block size not fully supported\n", drive->name);
-                                rc = 0;
-                        }
-                        break;
-                case CAPACITY_NO_CARTRIDGE:
-                        /* This is a KERN_ERR so it appears on screen for
the user to see */
-                        printk (KERN_ERR "%s: No disk in drive\n",
drive->name);
-                                        break;
-                case CAPACITY_INVALID:
-                        printk (KERN_ERR "%s: Invalid capacity for disk in
drive\n", drive->name);
-                                        break;
-  }
-  }
-  if (!i) {
-  IDEFLOPPY_DEBUG( "Descriptor 0 Code: %d\n", descriptor->dc);
-  }
-  IDEFLOPPY_DEBUG( "Descriptor %d: %dkB, %d blocks, %d sector size\n", i,
blocks * length / 1024, blocks, length);
+/*
+ * Determine if a media is present in the floppy drive, and if so,
+ * its LBA capacity.
+ */
+static int idefloppy_update_capacity (ide_drive_t *drive,
idefloppy_capacity_descriptor_t *descriptor, int quiet)
+{
+ idefloppy_floppy_t *floppy = drive->driver_data;
+
+/* If capacity descriptor has not changed, return previous "valid" status.
*/
+ if (!memcmp(descriptor, &floppy->capacity, sizeof
(idefloppy_capacity_descriptor_t))) {
+  return floppy->capacity_invalid;
+ }
+
+/* Assume unusable capacity unless proven otherwise */
+ floppy->capacity_invalid = 1;
+ switch (descriptor->dc) {
+ case CAPACITY_UNFORMATTED:
+  break;
+ case CAPACITY_NO_CARTRIDGE:
+  /* This is a KERN_ERR so it appears on screen for the user to see */
+  if (!quiet)
+   printk (KERN_ERR "%s: No disk in drive\n", drive->name);
+  break;
+ case CAPACITY_INVALID:
+  if (!quiet)
+   printk (KERN_ERR "%s: Invalid capacity for disk in drive\n",
drive->name);
+  break;
+ case CAPACITY_CURRENT:
+  if (!quiet)
+   printk (KERN_INFO "%s: %dkB, %d blocks, %d sector size\n", drive->name,
descriptor->blocks * descriptor->length / 1024, descriptor->blocks,
descriptor->length);
+  if (!descriptor->length || descriptor->length % 512) {
+   if (!quiet)
+    printk (KERN_NOTICE "%s: %d bytes block size not supported\n",
drive->name, descriptor->length);
+  } else
+   floppy->capacity_invalid = 0;
+  break;
+ }
+
+ floppy->capacity = *descriptor;
+
+ if (!floppy->capacity_invalid) {
+  floppy->blocks = descriptor->blocks;
+  floppy->block_size = descriptor->length;
+  if ((floppy->bs_factor = (descriptor->length / 512)) != 1)
+   if (!quiet)
+    printk (KERN_NOTICE "%s: warning: non 512 bytes block size not fully
supported\n", drive->name);
+  drive->part[0].nr_sects = floppy->blocks * floppy->bs_factor;
+ } else {
+  floppy->blocks = floppy->block_size = floppy->bs_factor = 0;
+  drive->part[0].nr_sects = 0;
  }

  /* Clik! disk does not support get_flexible_disk_page */
@@ -1435,9 +1451,7 @@
   (void) idefloppy_get_flexible_disk_page (drive);
  }

- drive->part[0].nr_sects = floppy->blocks * floppy->bs_factor;
- kfree (pc);
- return rc;
+ return floppy->capacity_invalid;
 }

 /*
@@ -1563,6 +1577,7 @@
  int length;
  int flags;
  idefloppy_pc_t *pc;
+ idefloppy_floppy_t *floppy = drive->driver_data;

  if (get_user(blocks, arg)
      || get_user(length, arg+1)
@@ -1583,6 +1598,7 @@
   kfree (pc);
                 return (-EIO);
         }
+ set_bit (IDEFLOPPY_MEDIA_CHANGED, &floppy->flags);
  kfree (pc);
  return (0);
 }
@@ -1692,6 +1708,7 @@
   memset (pc, 0, sizeof (idefloppy_pc_t));
   idefloppy_create_start_stop_cmd (pc, 2);
   (void) idefloppy_queue_pc_tail (drive, pc);
+  set_bit (IDEFLOPPY_MEDIA_CHANGED, &floppy->flags);
   kfree (pc);
   return 0;
  case CDROM_LOCKDOOR:
@@ -1758,6 +1775,7 @@
 {
  idefloppy_floppy_t *floppy = drive->driver_data;
  idefloppy_pc_t *pc;
+ idefloppy_capacity_descriptor_t descriptor;

 #if IDEFLOPPY_DEBUG_LOG
  printk (KERN_INFO "Reached idefloppy_open\n");
@@ -1779,7 +1797,8 @@
    (void) idefloppy_queue_pc_tail (drive, pc);
   }

-  if (idefloppy_get_capacity (drive)
+  (void) idefloppy_get_current_capacity_descriptor (drive, &descriptor);
+  if (idefloppy_update_capacity (drive, &descriptor, 0)
      && (filp->f_flags & O_NDELAY) == 0
       /*
       ** Allow O_NDELAY to open a drive without a disk, or with
@@ -1799,7 +1818,6 @@
    MOD_DEC_USE_COUNT;
    return -EROFS;
   }
-  set_bit (IDEFLOPPY_MEDIA_CHANGED, &floppy->flags);
   (void) idefloppy_lockunlock (drive, 1);
   check_disk_change(inode->i_rdev);
   kfree (pc);
@@ -1833,13 +1851,29 @@
 }

 /*
- * Check media change. Use a simple algorithm for now.
+ * Check media change.
+ *      The media change bit may already have been set by an eject or
+ *      format ioctl. If not, check the current media capacity, and if
+ *      it is different than what we last saw, the media has been changed
:-)
+ *      Otherwise return "no change", because we have no way to identify
+ *      individual media.
  */
 static int idefloppy_media_change (ide_drive_t *drive)
 {
  idefloppy_floppy_t *floppy = drive->driver_data;
+ idefloppy_capacity_descriptor_t descriptor;
+ int media_changed;

- return test_and_clear_bit (IDEFLOPPY_MEDIA_CHANGED, &floppy->flags);
+ media_changed = test_and_clear_bit (IDEFLOPPY_MEDIA_CHANGED,
&floppy->flags);
+
+ if (!idefloppy_get_current_capacity_descriptor (drive, &descriptor)) {
+  if (memcmp (&descriptor, &floppy->capacity,
sizeof(idefloppy_capacity_descriptor_t))) {
+   (void) idefloppy_update_capacity (drive, &descriptor, 0);
+   media_changed = 1;
+  }
+ }
+
+ return media_changed;
 }

 /*
@@ -2001,6 +2035,7 @@
  struct idefloppy_id_gcw gcw;
  int major = HWIF(drive)->major, i;
  int minor = drive->select.b.unit << PARTN_BITS;
+ idefloppy_capacity_descriptor_t descriptor;

  *((unsigned short *) &gcw) = drive->id->config;
  drive->driver_data = floppy;
@@ -2040,7 +2075,8 @@
  }


- (void) idefloppy_get_capacity (drive);
+ (void) idefloppy_get_current_capacity_descriptor (drive, &descriptor);
+ (void) idefloppy_update_capacity (drive, &descriptor, 1);
  idefloppy_add_settings(drive);
  for (i = 0; i < MAX_DRIVES; ++i) {
   ide_hwif_t *hwif = HWIF(drive);





