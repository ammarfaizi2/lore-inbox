Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287955AbSAMCy2>; Sat, 12 Jan 2002 21:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287951AbSAMCyU>; Sat, 12 Jan 2002 21:54:20 -0500
Received: from PHNX1-UBR2-4-hfc-0251-d1dae065.rdc1.az.coxatwork.com ([209.218.224.101]:52611
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S287965AbSAMCyN>; Sat, 12 Jan 2002 21:54:13 -0500
Message-ID: <006301c19bdd$a2acdd00$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Paul Bristow" <paul@paulbristow.net>
Subject: [CFT][PATCH] ide-floppy cleanups/media change detection (3/5)
Date: Sat, 12 Jan 2002 19:54:36 -0700
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

Patch 3 follows:

diff -X dontdiff -urN linux-2/drivers/ide/ide-floppy.c
linux-3/drivers/ide/ide-floppy.c
--- linux-2/drivers/ide/ide-floppy.c Sat Jan 12 16:48:05 2002
+++ linux-3/drivers/ide/ide-floppy.c Sat Jan 12 17:26:13 2002
@@ -1284,17 +1284,23 @@
 static int idefloppy_get_flexible_disk_page (ide_drive_t *drive)
 {
  idefloppy_floppy_t *floppy = drive->driver_data;
- idefloppy_pc_t pc;
+ idefloppy_pc_t *pc;
  idefloppy_mode_parameter_header_t *header;
  idefloppy_flexible_disk_page_t *page;
  int capacity, lba_capacity;

- idefloppy_create_mode_sense_cmd (&pc, IDEFLOPPY_FLEXIBLE_DISK_PAGE,
MODE_SENSE_CURRENT);
- if (idefloppy_queue_pc_tail (drive,&pc)) {
+ if ((pc = (idefloppy_pc_t *) kmalloc (sizeof (idefloppy_pc_t),
GFP_KERNEL)) == NULL) {
+  printk (KERN_ERR "ide-floppy: %s: Can't allocate a packet command
structure\n", drive->name);
+  return 1;
+ }
+ memset (pc, 0, sizeof (idefloppy_pc_t));
+ idefloppy_create_mode_sense_cmd (pc, IDEFLOPPY_FLEXIBLE_DISK_PAGE,
MODE_SENSE_CURRENT);
+ if (idefloppy_queue_pc_tail (drive,pc)) {
   printk (KERN_ERR "ide-floppy: Can't get flexible disk page
parameters\n");
+  kfree (pc);
   return 1;
  }
- header = (idefloppy_mode_parameter_header_t *) pc.buffer;
+ header = (idefloppy_mode_parameter_header_t *) pc->buffer;
  floppy->wp = header->wp;
  page = (idefloppy_flexible_disk_page_t *) (header + 1);

@@ -1319,28 +1325,36 @@
    drive->name, lba_capacity, capacity);
   floppy->blocks = floppy->block_size ? capacity / floppy->block_size : 0;
  }
+ kfree (pc);
  return 0;
 }

 static int idefloppy_get_capability_page(ide_drive_t *drive)
 {
  idefloppy_floppy_t *floppy = drive->driver_data;
- idefloppy_pc_t pc;
+ idefloppy_pc_t *pc;
  idefloppy_mode_parameter_header_t *header;
  idefloppy_capabilities_page_t *page;

+ if ((pc = (idefloppy_pc_t *) kmalloc (sizeof (idefloppy_pc_t),
GFP_KERNEL)) == NULL) {
+  printk (KERN_ERR "ide-floppy: %s: Can't allocate a packet command
structure\n", drive->name);
+  return 1;
+ }
+ memset (pc, 0, sizeof (idefloppy_pc_t));
  floppy->srfp=0;
- idefloppy_create_mode_sense_cmd (&pc, IDEFLOPPY_CAPABILITIES_PAGE,
+ idefloppy_create_mode_sense_cmd (pc, IDEFLOPPY_CAPABILITIES_PAGE,
        MODE_SENSE_CURRENT);

- set_bit(PC_SUPPRESS_ERROR, &pc.flags);
- if (idefloppy_queue_pc_tail (drive,&pc)) {
+ set_bit(PC_SUPPRESS_ERROR, &pc->flags);
+ if (idefloppy_queue_pc_tail (drive,pc)) {
+  kfree (pc);
   return 1;
  }

- header = (idefloppy_mode_parameter_header_t *) pc.buffer;
+ header = (idefloppy_mode_parameter_header_t *) pc->buffer;
  page= (idefloppy_capabilities_page_t *)(header+1);
  floppy->srfp=page->srfp;
+ kfree (pc);
  return (0);
 }

@@ -1351,7 +1365,7 @@
 static int idefloppy_get_capacity (ide_drive_t *drive)
 {
  idefloppy_floppy_t *floppy = drive->driver_data;
- idefloppy_pc_t pc;
+ idefloppy_pc_t *pc;
  idefloppy_capacity_header_t *header;
  idefloppy_capacity_descriptor_t *descriptor;
  int i, descriptors, rc = 1, blocks, length;
@@ -1361,12 +1375,18 @@
  floppy->blocks = floppy->bs_factor = 0;
  drive->part[0].nr_sects = 0;

- idefloppy_create_read_capacity_cmd (&pc);
- if (idefloppy_queue_pc_tail (drive, &pc)) {
+ if ((pc = (idefloppy_pc_t *) kmalloc (sizeof (idefloppy_pc_t),
GFP_KERNEL)) == NULL) {
+  printk (KERN_ERR "ide-floppy: %s: Can't allocate a packet command
structure\n", drive->name);
+  return 1;
+ }
+ memset (pc, 0, sizeof (idefloppy_pc_t));
+ idefloppy_create_read_capacity_cmd (pc);
+ if (idefloppy_queue_pc_tail (drive, pc)) {
   printk (KERN_ERR "ide-floppy: Can't get floppy parameters\n");
+  kfree (pc);
   return 1;
  }
- header = (idefloppy_capacity_header_t *) pc.buffer;
+ header = (idefloppy_capacity_header_t *) pc->buffer;
  descriptors = header->length / sizeof (idefloppy_capacity_descriptor_t);
  descriptor = (idefloppy_capacity_descriptor_t *) (header + 1);

@@ -1416,6 +1436,7 @@
  }

  drive->part[0].nr_sects = floppy->blocks * floppy->bs_factor;
+ kfree (pc);
  return rc;
 }

@@ -1445,7 +1466,7 @@
          struct file *file,
          int *arg) /* Cheater */
 {
-        idefloppy_pc_t pc;
+        idefloppy_pc_t *pc;
  idefloppy_capacity_header_t *header;
         idefloppy_capacity_descriptor_t *descriptor;
  int i, descriptors, blocks, length;
@@ -1459,12 +1480,18 @@
  if (u_array_size <= 0)
   return (-EINVAL);

- idefloppy_create_read_capacity_cmd (&pc);
- if (idefloppy_queue_pc_tail (drive, &pc)) {
+ if ((pc = (idefloppy_pc_t *) kmalloc (sizeof (idefloppy_pc_t),
GFP_KERNEL)) == NULL) {
+  printk (KERN_ERR "ide-floppy: %s: Can't allocate a packet command
structure\n", drive->name);
+  return (-EIO);
+ }
+ memset (pc, 0, sizeof (idefloppy_pc_t));
+ idefloppy_create_read_capacity_cmd (pc);
+ if (idefloppy_queue_pc_tail (drive, pc)) {
   printk (KERN_ERR "ide-floppy: Can't get floppy parameters\n");
+  kfree (pc);
                 return (-EIO);
         }
-        header = (idefloppy_capacity_header_t *) pc.buffer;
+        header = (idefloppy_capacity_header_t *) pc->buffer;
         descriptors = header->length /
   sizeof (idefloppy_capacity_descriptor_t);
  descriptor = (idefloppy_capacity_descriptor_t *) (header + 1);
@@ -1488,19 +1515,26 @@
   blocks = ntohl (descriptor->blocks);
   length = ntohs (descriptor->length);

-  if (put_user(blocks, argp))
+  if (put_user(blocks, argp)) {
+   kfree (pc);
    return (-EFAULT);
+  }
   ++argp;

-  if (put_user(length, argp))
+  if (put_user(length, argp)) {
+   kfree (pc);
    return (-EFAULT);
+  }
   ++argp;

   ++u_index;
  }

- if (put_user(u_index, arg))
+ if (put_user(u_index, arg)) {
+  kfree (pc);
   return (-EFAULT);
+ }
+ kfree (pc);
  return (0);
 }

@@ -1528,7 +1562,7 @@
  int blocks;
  int length;
  int flags;
- idefloppy_pc_t pc;
+ idefloppy_pc_t *pc;

  if (get_user(blocks, arg)
      || get_user(length, arg+1)
@@ -1538,11 +1572,18 @@
  }

  (void) idefloppy_get_capability_page (drive); /* Get the SFRP bit */
- idefloppy_create_format_unit_cmd(&pc, blocks, length, flags);
- if (idefloppy_queue_pc_tail (drive, &pc))
+ if ((pc = (idefloppy_pc_t *) kmalloc (sizeof (idefloppy_pc_t),
GFP_KERNEL)) == NULL) {
+  printk (KERN_ERR "ide-floppy: %s: Can't allocate a packet command
structure\n", drive->name);
+  return (-EIO);
+ }
+ memset (pc, 0, sizeof (idefloppy_pc_t));
+ idefloppy_create_format_unit_cmd(pc, blocks, length, flags);
+ if (idefloppy_queue_pc_tail (drive, pc))
  {
+  kfree (pc);
                 return (-EIO);
         }
+ kfree (pc);
  return (0);
 }

@@ -1562,14 +1603,20 @@
       int *arg)
 {
  idefloppy_floppy_t *floppy = drive->driver_data;
- idefloppy_pc_t pc;
+ idefloppy_pc_t *pc;
  int progress_indication=0x10000;

  if (floppy->srfp)
  {
-  idefloppy_create_request_sense_cmd(&pc);
-  if (idefloppy_queue_pc_tail (drive, &pc))
+  if ((pc = (idefloppy_pc_t *) kmalloc (sizeof (idefloppy_pc_t),
GFP_KERNEL)) == NULL) {
+   printk (KERN_ERR "ide-floppy: %s: Can't allocate a packet command
structure\n", drive->name);
+   return (-EIO);
+  }
+  memset (pc, 0, sizeof (idefloppy_pc_t));
+  idefloppy_create_request_sense_cmd(pc);
+  if (idefloppy_queue_pc_tail (drive, pc))
   {
+   kfree (pc);
    return (-EIO);
   }

@@ -1580,6 +1627,7 @@
   }
   /* Else assume format_unit has finished, and we're
   ** at 0x10000 */
+  kfree (pc);
  }
  else
  {
@@ -1607,7 +1655,7 @@
 static int idefloppy_ioctl (ide_drive_t *drive, struct inode *inode, struct
file *file,
      unsigned int cmd, unsigned long arg)
 {
- idefloppy_pc_t pc;
+ idefloppy_pc_t *pc;
  idefloppy_floppy_t *floppy = drive->driver_data;
  int prevent = (arg) ? 1 : 0;

@@ -1619,15 +1667,21 @@
   if (drive->usage > 1)
    return -EBUSY;

+  if ((pc = (idefloppy_pc_t *) kmalloc (sizeof (idefloppy_pc_t),
GFP_KERNEL)) == NULL) {
+   printk (KERN_ERR "ide-floppy: %s: Can't allocate a packet command
structure\n", drive->name);
+   return (-EIO);
+  }
+  memset (pc, 0, sizeof (idefloppy_pc_t));
   /* The IOMEGA Clik! Drive doesn't support this command - no room for an
eject mechanism */
                 if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
-   idefloppy_create_prevent_cmd (&pc, prevent);
-   (void) idefloppy_queue_pc_tail (drive, &pc);
+   idefloppy_create_prevent_cmd (pc, prevent);
+   (void) idefloppy_queue_pc_tail (drive, pc);
   }
   if (cmd == CDROMEJECT) {
-   idefloppy_create_start_stop_cmd (&pc, 2);
-   (void) idefloppy_queue_pc_tail (drive, &pc);
+   idefloppy_create_start_stop_cmd (pc, 2);
+   (void) idefloppy_queue_pc_tail (drive, pc);
   }
+  kfree (pc);
   return 0;
  case IDEFLOPPY_IOCTL_FORMAT_SUPPORTED:
   return (0);
@@ -1687,7 +1741,7 @@
 static int idefloppy_open (struct inode *inode, struct file *filp,
ide_drive_t *drive)
 {
  idefloppy_floppy_t *floppy = drive->driver_data;
- idefloppy_pc_t pc;
+ idefloppy_pc_t *pc;

 #if IDEFLOPPY_DEBUG_LOG
  printk (KERN_INFO "Reached idefloppy_open\n");
@@ -1698,10 +1752,15 @@
   clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
   /* Just in case */

-  idefloppy_create_test_unit_ready_cmd(&pc);
-  if (idefloppy_queue_pc_tail(drive, &pc)) {
-   idefloppy_create_start_stop_cmd (&pc, 1);
-   (void) idefloppy_queue_pc_tail (drive, &pc);
+  if ((pc = (idefloppy_pc_t *) kmalloc (sizeof (idefloppy_pc_t),
GFP_KERNEL)) == NULL) {
+   printk (KERN_ERR "ide-floppy: %s: Can't allocate a packet command
structure\n", drive->name);
+   return (-EIO);
+  }
+  memset (pc, 0, sizeof (idefloppy_pc_t));
+  idefloppy_create_test_unit_ready_cmd(pc);
+  if (idefloppy_queue_pc_tail(drive, pc)) {
+   idefloppy_create_start_stop_cmd (pc, 1);
+   (void) idefloppy_queue_pc_tail (drive, pc);
   }

   if (idefloppy_get_capacity (drive)
@@ -1713,22 +1772,25 @@
       */
       ) {
    drive->usage--;
+   kfree (pc);
    MOD_DEC_USE_COUNT;
    return -EIO;
   }

   if (floppy->wp && (filp->f_mode & 2)) {
    drive->usage--;
+   kfree (pc);
    MOD_DEC_USE_COUNT;
    return -EROFS;
   }
   set_bit (IDEFLOPPY_MEDIA_CHANGED, &floppy->flags);
   /* IOMEGA Clik! drives do not support lock/unlock commands */
                 if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
-   idefloppy_create_prevent_cmd (&pc, 1);
-   (void) idefloppy_queue_pc_tail (drive, &pc);
+   idefloppy_create_prevent_cmd (pc, 1);
+   (void) idefloppy_queue_pc_tail (drive, pc);
   }
   check_disk_change(inode->i_rdev);
+  kfree (pc);
  }
  else if (test_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags))
  {
@@ -1741,7 +1803,7 @@

 static void idefloppy_release (struct inode *inode, struct file *filp,
ide_drive_t *drive)
 {
- idefloppy_pc_t pc;
+ idefloppy_pc_t *pc;

 #if IDEFLOPPY_DEBUG_LOG
  printk (KERN_INFO "Reached idefloppy_release\n");
@@ -1754,8 +1816,14 @@

   /* IOMEGA Clik! drives do not support lock/unlock commands */
                 if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
-   idefloppy_create_prevent_cmd (&pc, 0);
-   (void) idefloppy_queue_pc_tail (drive, &pc);
+   if ((pc = (idefloppy_pc_t *) kmalloc (sizeof (idefloppy_pc_t),
GFP_KERNEL)) == NULL) {
+    printk (KERN_ERR "ide-floppy: %s: Can't allocate a packet command
structure\n", drive->name);
+   } else {
+    memset (pc, 0, sizeof (idefloppy_pc_t));
+    idefloppy_create_prevent_cmd (pc, 0);
+    (void) idefloppy_queue_pc_tail (drive, pc);
+    kfree (pc);
+   }
   }

   clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);



