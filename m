Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267609AbRGNKiX>; Sat, 14 Jul 2001 06:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267610AbRGNKiP>; Sat, 14 Jul 2001 06:38:15 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:37128 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S267609AbRGNKhz>; Sat, 14 Jul 2001 06:37:55 -0400
Message-ID: <3B50213B.A826C259@t-online.de>
Date: Sat, 14 Jul 2001 12:38:51 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: paul@paulbristow.net, linux-kernel@vger.kernel.org
Subject: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
Content-Type: multipart/mixed;
 boundary="------------19769A3701474D7777CE5645"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------19769A3701474D7777CE5645
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
this fixes an Oops when accessing an IOMEGA PC card Clik! drive
(NULL pointer in get_flexible_disk_page).

Linus, please include if you like.

This is the original patch from the MAINTAINER
but he seems defunct since three weeks.

Regards, Gunther




--- linux246-orig/drivers/ide/ide-floppy.c      Fri Feb  9 20:30:23 2001
+++ linux/drivers/ide/ide-floppy.c      Sat Jul 14 12:07:40 2001
@@ -1,7 +1,8 @@
 /*
- * linux/drivers/ide/ide-floppy.c      Version 0.9     Jul   4, 1999
+ * linux/drivers/ide/ide-floppy.c      Version 0.96    Jan 7, 2001
  *
  * Copyright (C) 1996 - 1999 Gadi Oxman <gadio@netvision.net.il>
+ * Copyright (C) 2000 - 2001 Paul Bristow <paul@paulbristow.net>
  */

 /*
@@ -10,6 +11,12 @@
  * The driver currently doesn't have any fancy features, just the bare
  * minimum read/write support.
  *
+ * This driver supports the following IDE floppy drives:
+ *
+ * LS-120 SuperDisk
+ * Iomega Zip 100/250 
+ * Iomega PC Card Clik!/PocketZip
+ *
  * Many thanks to Lode Leroy <Lode.Leroy@www.ibase.be>, who tested so many
  * ALPHA patches to this driver on an EASYSTOR LS-120 ATAPI floppy drive.
  *
@@ -29,9 +36,20 @@
  * Ver 0.9   Jul  4 99   Fix a bug which might have caused the number of
  *                        bytes requested on each interrupt to be zero.
  *                        Thanks to <shanos@es.co.nz> for pointing this out.
+ * Ver 0.91  Dec 11 99   Added IOMEGA Clik! drive support by 
+ *           <paul@paulbristow.net>
+ * Ver 0.92  Oct 22 00   Paul Bristow became official maintainer for this 
+ *           driver.  Included Powerbook internal zip kludge.
+ * Ver 0.93  Oct 24 00   Fixed bugs for Clik! drive
+ *                                             no disk on insert and disk change now works
+ * Ver 0.94  Oct 27 00   Tidied up to remove strstr(Clik) everywhere
+ * Ver 0.95  Nov  7 00   Brought across to kernel 2.4
+ * Ver 0.96  Jan  7 01   Actually in line with release version of 2.4.0
+ *                       including set_bit patch from Rusty Russel
+ *           
  */

-#define IDEFLOPPY_VERSION "0.9"
+#define IDEFLOPPY_VERSION "0.96"

 #include <linux/config.h>
 #include <linux/module.h>
@@ -45,7 +63,7 @@
 #include <linux/major.h>
 #include <linux/errno.h>
 #include <linux/genhd.h>
-#include <linux/slab.h>
+#include <linux/malloc.h>
 #include <linux/cdrom.h>
 #include <linux/ide.h>

@@ -56,12 +74,14 @@
 #include <asm/unaligned.h>
 #include <asm/bitops.h>

+
 /*
  *     The following are used to debug the driver.
  */
-#define IDEFLOPPY_DEBUG_LOG            0
 #define IDEFLOPPY_DEBUG_INFO           0
 #define IDEFLOPPY_DEBUG_BUGS           1
+/* #define IDEFLOPPY_DEBUG(fmt, args...) printk(KERN_INFO fmt, ## args) */
+#define IDEFLOPPY_DEBUG( fmt, args... )

 /*
  *     Some drives require a longer irq timeout.
@@ -104,7 +124,7 @@
        byte *current_position;                 /* Pointer into the above buffer */
        void (*callback) (ide_drive_t *);       /* Called when this packet command is completed */
        byte pc_buffer[IDEFLOPPY_PC_BUFFER_SIZE];       /* Temporary buffer */
-       unsigned long flags;                    /* Status/Action bit flags: long for set_bit */
+       unsigned long flags;                    /* Status/Action bit flags : long for set_bit() */
 } idefloppy_pc_t;

 /*
@@ -181,6 +201,7 @@
        u8              reserved30[2];
 } idefloppy_flexible_disk_page_t;

+
 /*
  *     Format capacity
  */
@@ -237,7 +258,7 @@
        idefloppy_flexible_disk_page_t flexible_disk_page;      /* Copy of the flexible disk page */
        int wp;                                                 /* Write protect */

-       unsigned int flags;                     /* Status/Action flags */
+       unsigned long flags;                    /* Status/Action flags : long for set_bit() */
 } idefloppy_floppy_t;

 /*
@@ -246,6 +267,8 @@
 #define IDEFLOPPY_DRQ_INTERRUPT                0       /* DRQ interrupt device */
 #define IDEFLOPPY_MEDIA_CHANGED                1       /* Media may have changed */
 #define IDEFLOPPY_USE_READ12           2       /* Use READ12/WRITE12 or READ10/WRITE10 */
+#define IDEFLOPPY_CLIK_DRIVE      3       /* Avoid commands not supported in Clik drive */
+#define IDEFLOPPY_POWERBOOK_ZIP   4       /* Kludge for Apple Powerbook Zip drive */

 /*
  *     ATAPI floppy drive packet commands
@@ -621,9 +644,7 @@
        struct request *rq = hwgroup->rq;
        int error;

-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "Reached idefloppy_end_request\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "Reached idefloppy_end_request\n");

        switch (uptodate) {
                case 0: error = IDEFLOPPY_ERROR_GENERAL; break;
@@ -746,21 +767,19 @@
        idefloppy_floppy_t *floppy = drive->driver_data;

        floppy->sense_key = result->sense_key; floppy->asc = result->asc; floppy->ascq = result->ascq;
-#if IDEFLOPPY_DEBUG_LOG
-       if (floppy->failed_pc)
-               printk (KERN_INFO "ide-floppy: pc = %x, sense key = %x, asc = %x, ascq = %x\n",floppy->failed_pc->c[0],result->sense_key,result->asc,result->ascq);
-       else
-               printk (KERN_INFO "ide-floppy: sense key = %x, asc = %x, ascq = %x\n",result->sense_key,result->asc,result->ascq);
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  if (floppy->failed_pc) {
+    IDEFLOPPY_DEBUG("ide-floppy: pc = %x, sense key = %x, asc = %x, ascq = %x\n",floppy->failed_pc->c[0],result->sense_key,result->asc,result->ascq);
+  }
+  else {
+    IDEFLOPPY_DEBUG("ide-floppy: sense key = %x, asc = %x, ascq = %x\n",result->sense_key,result->asc,result->ascq);
+  }
 }

 static void idefloppy_request_sense_callback (ide_drive_t *drive)
 {
        idefloppy_floppy_t *floppy = drive->driver_data;

-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "ide-floppy: Reached idefloppy_request_sense_callback\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "ide-floppy: Reached idefloppy_request_sense_callback\n");
        if (!floppy->pc->error) {
                idefloppy_analyze_error (drive,(idefloppy_request_sense_result_t *) floppy->pc->buffer);
                idefloppy_end_request (1,HWGROUP (drive));
@@ -777,9 +796,7 @@
 {
        idefloppy_floppy_t *floppy = drive->driver_data;

-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "ide-floppy: Reached idefloppy_pc_callback\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "ide-floppy: Reached idefloppy_pc_callback\n");

        idefloppy_end_request (floppy->pc->error ? 0:1, HWGROUP(drive));
 }
@@ -840,9 +857,7 @@
        struct request *rq = pc->rq;
        unsigned int temp;

-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "ide-floppy: Reached idefloppy_pc_intr interrupt handler\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */       
+  IDEFLOPPY_DEBUG( "ide-floppy: Reached idefloppy_pc_intr interrupt handler\n");

 #ifdef CONFIG_BLK_DEV_IDEDMA
        if (test_bit (PC_DMA_IN_PROGRESS, &pc->flags)) {
@@ -852,26 +867,20 @@
                        pc->actually_transferred=pc->request_transfer;
                        idefloppy_update_buffers (drive, pc);
                }
-#if IDEFLOPPY_DEBUG_LOG
-               printk (KERN_INFO "ide-floppy: DMA finished\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */
+    IDEFLOPPY_DEBUG( "ide-floppy: DMA finished\n");
        }
 #endif /* CONFIG_BLK_DEV_IDEDMA */

        status.all = GET_STAT();                                        /* Clear the interrupt */

        if (!status.b.drq) {                                            /* No more interrupts */
-#if IDEFLOPPY_DEBUG_LOG
-               printk (KERN_INFO "Packet command completed, %d bytes transferred\n", pc->actually_transferred);
-#endif /* IDEFLOPPY_DEBUG_LOG */
+    IDEFLOPPY_DEBUG( "Packet command completed, %d bytes transferred\n", pc->actually_transferred);
                clear_bit (PC_DMA_IN_PROGRESS, &pc->flags);

                ide__sti();     /* local CPU only */

                if (status.b.check || test_bit (PC_DMA_ERROR, &pc->flags)) {    /* Error detected */
-#if IDEFLOPPY_DEBUG_LOG
-                       printk (KERN_INFO "ide-floppy: %s: I/O error\n",drive->name);
-#endif /* IDEFLOPPY_DEBUG_LOG */
+      IDEFLOPPY_DEBUG( "ide-floppy: %s: I/O error\n",drive->name);
                        rq->errors++;
                        if (pc->c[0] == IDEFLOPPY_REQUEST_SENSE_CMD) {
                                printk (KERN_ERR "ide-floppy: I/O error in request sense command\n");
@@ -915,9 +924,7 @@
                                ide_set_handler (drive,&idefloppy_pc_intr,IDEFLOPPY_WAIT_CMD, NULL);
                                return ide_started;
                        }
-#if IDEFLOPPY_DEBUG_LOG
-                       printk (KERN_NOTICE "ide-floppy: The floppy wants to send us more data than expected - allowing transfer\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */
+      IDEFLOPPY_DEBUG( "ide-floppy: The floppy wants to send us more data than expected - allowing transfer\n");
                }
        }
        if (test_bit (PC_WRITING, &pc->flags)) {
@@ -983,7 +990,7 @@
                 *      a legitimate error code was received.
                 */
                if (!test_bit (PC_ABORT, &pc->flags)) {
-                       printk (KERN_ERR "ide-floppy: %s: I/O error, pc = %2x, key = %2x, asc = %2x, ascq = %2x\n",
+      IDEFLOPPY_DEBUG( "ide-floppy: %s: I/O error, pc = %2x, key = %2x, asc = %2x, ascq = %2x\n",
                                drive->name, pc->c[0], floppy->sense_key, floppy->asc, floppy->ascq);
                        pc->error = IDEFLOPPY_ERROR_GENERAL;            /* Giving up */
                }
@@ -991,9 +998,7 @@
                pc->callback(drive);
                return ide_stopped;
        }
-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "Retry number - %d\n",pc->retries);
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "Retry number - %d\n",pc->retries);

        pc->retries++;
        pc->actually_transferred=0;                                     /* We haven't transferred any data yet */
@@ -1034,9 +1039,7 @@

 static void idefloppy_rw_callback (ide_drive_t *drive)
 {
-#if IDEFLOPPY_DEBUG_LOG        
-       printk (KERN_INFO "ide-floppy: Reached idefloppy_rw_callback\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "ide-floppy: Reached idefloppy_rw_callback\n");

        idefloppy_end_request(1, HWGROUP(drive));
        return;
@@ -1044,9 +1047,7 @@

 static void idefloppy_create_prevent_cmd (idefloppy_pc_t *pc, int prevent)
 {
-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "ide-floppy: creating prevent removal command, prevent = %d\n", prevent);
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "ide-floppy: creating prevent removal command, prevent = %d\n", prevent);

        idefloppy_init_pc (pc);
        pc->c[0] = IDEFLOPPY_PREVENT_REMOVAL_CMD;
@@ -1106,10 +1107,8 @@
        int block = sector / floppy->bs_factor;
        int blocks = rq->nr_sectors / floppy->bs_factor;

-#if IDEFLOPPY_DEBUG_LOG
-       printk ("create_rw1%d_cmd: block == %d, blocks == %d\n",
+  IDEFLOPPY_DEBUG( "create_rw1%d_cmd: block == %d, blocks == %d\n",
                2 * test_bit (IDEFLOPPY_USE_READ12, &floppy->flags), block, blocks);
-#endif /* IDEFLOPPY_DEBUG_LOG */

        idefloppy_init_pc (pc);
        if (test_bit (IDEFLOPPY_USE_READ12, &floppy->flags)) {
@@ -1139,10 +1138,8 @@
        idefloppy_floppy_t *floppy = drive->driver_data;
        idefloppy_pc_t *pc;

-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "rq_status: %d, rq_dev: %u, cmd: %d, errors: %d\n",rq->rq_status,(unsigned int) rq->rq_dev,rq->cmd,rq->errors);
-       printk (KERN_INFO "sector: %ld, nr_sectors: %ld, current_nr_sectors: %ld\n",rq->sector,rq->nr_sectors,rq->current_nr_sectors);
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "rq_status: %d, rq_dev: %u, cmd: %d, errors: %d\n",rq->rq_status,(unsigned int) rq->rq_dev,rq->cmd,rq->errors);
+  IDEFLOPPY_DEBUG( "sector: %ld, nr_sectors: %ld, current_nr_sectors: %ld\n",rq->sector,rq->nr_sectors,rq->current_nr_sectors);

        if (rq->errors >= ERROR_MAX) {
                if (floppy->failed_pc != NULL)
@@ -1235,6 +1232,7 @@
        return 0;
 }

+
 /*
  *     Determine if a media is present in the floppy drive, and if so,
  *     its LBA capacity.
@@ -1263,48 +1261,68 @@
        for (i = 0; i < descriptors; i++, descriptor++) {
                blocks = descriptor->blocks = ntohl (descriptor->blocks);
                length = descriptor->length = ntohs (descriptor->length);
-               if (!i && descriptor->dc == CAPACITY_CURRENT) {
-                       if (memcmp (descriptor, &floppy->capacity, sizeof (idefloppy_capacity_descriptor_t))) {
-                               printk (KERN_INFO "%s: %dkB, %d blocks, %d sector size, %s \n",
-                                       drive->name, blocks * length / 1024, blocks, length,
-                                       drive->using_dma ? ", DMA":"");
-                       }
-                       floppy->capacity = *descriptor;
+    if (!i) {
+       switch (descriptor->dc) {
+               case CAPACITY_UNFORMATTED: /* Clik! drive returns this instead of CAPACITY_CURRENT */
+                       if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) 
+                               break; /* If it is not a clik drive, break out (maintains previous driver behaviour) */
+               case CAPACITY_CURRENT: /* Normal Zip/LS-120 disks */
+                       if (memcmp (descriptor, &floppy->capacity, sizeof (idefloppy_capacity_descriptor_t)))
+                               printk (KERN_INFO "%s: %dkB, %d blocks, %d sector size\n", drive->name, blocks * length / 1024, blocks, length);
+                       floppy->capacity = *descriptor;
                        if (!length || length % 512)
-                               printk (KERN_ERR "%s: %d bytes block size not supported\n", drive->name, length);
+                               printk (KERN_NOTICE "%s: %d bytes block size not supported\n", drive->name, length);            
                        else {
                                floppy->blocks = blocks;
                                floppy->block_size = length;
                                if ((floppy->bs_factor = length / 512) != 1)
                                        printk (KERN_NOTICE "%s: warning: non 512 bytes block size not fully supported\n", drive->name);
-                               rc = 0;
-                       }
+                               rc = 0;
+                       }
+                       break;
+               case CAPACITY_NO_CARTRIDGE: 
+                       /* This is a KERN_ERR so it appears on screen for the user to see */
+                       printk (KERN_ERR "%s: No disk in drive\n", drive->name);
+                                       break;    
+               case CAPACITY_INVALID: 
+                       printk (KERN_ERR "%s: Invalid capacity for disk in drive\n", drive->name);
+                                       break;    
                }
-#if IDEFLOPPY_DEBUG_INFO
-               if (!i) printk (KERN_INFO "Descriptor 0 Code: %d\n", descriptor->dc);
-               printk (KERN_INFO "Descriptor %d: %dkB, %d blocks, %d sector size\n", i, blocks * length / 1024, blocks, length);
-#endif /* IDEFLOPPY_DEBUG_INFO */
        }
+    if (!i) {
+       IDEFLOPPY_DEBUG( "Descriptor 0 Code: %d\n", descriptor->dc);
+    }
+    IDEFLOPPY_DEBUG( "Descriptor %d: %dkB, %d blocks, %d sector size\n", i, blocks * length / 1024, blocks, length);
+  }
+  
+  /* Clik! disk does not support get_flexible_disk_page */
+       if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) 
        (void) idefloppy_get_flexible_disk_page (drive);
+
        drive->part[0].nr_sects = floppy->blocks * floppy->bs_factor;
        return rc;
 }

+
 /*
  *     Our special ide-floppy ioctl's.
  *
- *     Currently there aren't any ioctl's.
+ *      Supports eject command 
  */
 static int idefloppy_ioctl (ide_drive_t *drive, struct inode *inode, struct file *file,
                                 unsigned int cmd, unsigned long arg)
 {
        idefloppy_pc_t pc;
+  idefloppy_floppy_t *floppy = drive->driver_data;

        if (cmd == CDROMEJECT) {
                if (drive->usage > 1)
                        return -EBUSY;
+    /* The IOMEGA Clik! Drive doesn't support this command - no room for an eject mechanism */
+               if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
                idefloppy_create_prevent_cmd (&pc, 0);
                (void) idefloppy_queue_pc_tail (drive, &pc);
+    }
                idefloppy_create_start_stop_cmd (&pc, 2);
                (void) idefloppy_queue_pc_tail (drive, &pc);
                return 0;
@@ -1320,20 +1338,24 @@
        idefloppy_floppy_t *floppy = drive->driver_data;
        idefloppy_pc_t pc;

-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "Reached idefloppy_open\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "Reached idefloppy_open\n");

        MOD_INC_USE_COUNT;
        if (drive->usage == 1) {
+    IDEFLOPPY_DEBUG( "Testing if unit is ready...\n");
                idefloppy_create_test_unit_ready_cmd(&pc);
                if (idefloppy_queue_pc_tail(drive, &pc)) {
+      IDEFLOPPY_DEBUG( "Not ready, issuing start command\n");
                        idefloppy_create_start_stop_cmd (&pc, 1);
                        (void) idefloppy_queue_pc_tail (drive, &pc);
+    } else
+    { 
+           IDEFLOPPY_DEBUG( "Yes unit is ready\n");
                }
                if (idefloppy_get_capacity (drive)) {
                        drive->usage--;
                        MOD_DEC_USE_COUNT;
+      IDEFLOPPY_DEBUG( "I/O Error Getting Capacity\n");
                        return -EIO;
                }
                if (floppy->wp && (filp->f_mode & 2)) {
@@ -1342,8 +1364,11 @@
                        return -EROFS;
                }
                set_bit (IDEFLOPPY_MEDIA_CHANGED, &floppy->flags);
+    /* IOMEGA Clik! drives do not support lock/unlock commands - no room for mechanism */
+               if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
                idefloppy_create_prevent_cmd (&pc, 1);
                (void) idefloppy_queue_pc_tail (drive, &pc);
+    }
                check_disk_change(inode->i_rdev);
        }
        return 0;
@@ -1352,16 +1377,18 @@
 static void idefloppy_release (struct inode *inode, struct file *filp, ide_drive_t *drive)
 {
        idefloppy_pc_t pc;
+  idefloppy_floppy_t *floppy = drive->driver_data;

-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "Reached idefloppy_release\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "Reached idefloppy_release\n");

        if (!drive->usage) {
                invalidate_buffers (inode->i_rdev);
+    /* IOMEGA Clik! drives do not support lock/unlock commands */
+               if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
                idefloppy_create_prevent_cmd (&pc, 0);
                (void) idefloppy_queue_pc_tail (drive, &pc);
        }
+  }
        MOD_DEC_USE_COUNT;
 }

@@ -1559,6 +1586,17 @@
                for (i = 0; i < 1 << PARTN_BITS; i++)
                        max_sectors[major][minor + i] = 64;
        }
+  /*
+   *      Guess what?  The IOMEGA Clik! drive also needs the
+   *      above fix.  It makes nasty clicking noises without
+   *      it, so please don't remove this.
+   */
+  if (strcmp(drive->id->model, "IOMEGA Clik! 40 CZ ATAPI") == 0)
+  {
+    for (i = 0; i < 1 << PARTN_BITS; i++)
+      max_sectors[major][minor + i] = 64;
+    set_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags);
+  }

        (void) idefloppy_get_capacity (drive);
        idefloppy_add_settings(drive);
@@ -1597,6 +1635,7 @@

 #endif /* CONFIG_PROC_FS */

+
 /*
  *     IDE subdriver functions, registered with ide.c
  */
@@ -1629,6 +1668,7 @@
        NULL
 };

+
 /*
  *     idefloppy_init will register the driver for each floppy.
  */
@@ -1665,12 +1705,16 @@
        return 0;
 }

+
 #ifdef MODULE
+/* Initialisation code for loading the driver as a modules */
 int init_module (void)
 {
        return idefloppy_init ();
 }

+
+/* Cleanup code for removing the driver module */
 void cleanup_module (void)
 {
        ide_drive_t *drive;
--------------19769A3701474D7777CE5645
Content-Type: application/octet-stream;
 name="gmpatch-245+idefloppy-clik-bristow"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="gmpatch-245+idefloppy-clik-bristow"

LS0tIGxpbnV4MjQ2LW9yaWcvZHJpdmVycy9pZGUvaWRlLWZsb3BweS5jCUZyaSBGZWIgIDkg
MjA6MzA6MjMgMjAwMQorKysgbGludXgvZHJpdmVycy9pZGUvaWRlLWZsb3BweS5jCVNhdCBK
dWwgMTQgMTI6MDc6NDAgMjAwMQpAQCAtMSw3ICsxLDggQEAKIC8qCi0gKiBsaW51eC9kcml2
ZXJzL2lkZS9pZGUtZmxvcHB5LmMJVmVyc2lvbiAwLjkJSnVsICAgNCwgMTk5OQorICogbGlu
dXgvZHJpdmVycy9pZGUvaWRlLWZsb3BweS5jCVZlcnNpb24gMC45NglKYW4gNywgMjAwMQog
ICoKICAqIENvcHlyaWdodCAoQykgMTk5NiAtIDE5OTkgR2FkaSBPeG1hbiA8Z2FkaW9AbmV0
dmlzaW9uLm5ldC5pbD4KKyAqIENvcHlyaWdodCAoQykgMjAwMCAtIDIwMDEgUGF1bCBCcmlz
dG93IDxwYXVsQHBhdWxicmlzdG93Lm5ldD4KICAqLwogCiAvKgpAQCAtMTAsNiArMTEsMTIg
QEAKICAqIFRoZSBkcml2ZXIgY3VycmVudGx5IGRvZXNuJ3QgaGF2ZSBhbnkgZmFuY3kgZmVh
dHVyZXMsIGp1c3QgdGhlIGJhcmUKICAqIG1pbmltdW0gcmVhZC93cml0ZSBzdXBwb3J0Lgog
ICoKKyAqIFRoaXMgZHJpdmVyIHN1cHBvcnRzIHRoZSBmb2xsb3dpbmcgSURFIGZsb3BweSBk
cml2ZXM6CisgKgorICogTFMtMTIwIFN1cGVyRGlzaworICogSW9tZWdhIFppcCAxMDAvMjUw
IAorICogSW9tZWdhIFBDIENhcmQgQ2xpayEvUG9ja2V0WmlwCisgKgogICogTWFueSB0aGFu
a3MgdG8gTG9kZSBMZXJveSA8TG9kZS5MZXJveUB3d3cuaWJhc2UuYmU+LCB3aG8gdGVzdGVk
IHNvIG1hbnkKICAqIEFMUEhBIHBhdGNoZXMgdG8gdGhpcyBkcml2ZXIgb24gYW4gRUFTWVNU
T1IgTFMtMTIwIEFUQVBJIGZsb3BweSBkcml2ZS4KICAqCkBAIC0yOSw5ICszNiwyMCBAQAog
ICogVmVyIDAuOSAgIEp1bCAgNCA5OSAgIEZpeCBhIGJ1ZyB3aGljaCBtaWdodCBoYXZlIGNh
dXNlZCB0aGUgbnVtYmVyIG9mCiAgKiAgICAgICAgICAgICAgICAgICAgICAgIGJ5dGVzIHJl
cXVlc3RlZCBvbiBlYWNoIGludGVycnVwdCB0byBiZSB6ZXJvLgogICogICAgICAgICAgICAg
ICAgICAgICAgICBUaGFua3MgdG8gPHNoYW5vc0Blcy5jby5uej4gZm9yIHBvaW50aW5nIHRo
aXMgb3V0LgorICogVmVyIDAuOTEgIERlYyAxMSA5OSAgIEFkZGVkIElPTUVHQSBDbGlrISBk
cml2ZSBzdXBwb3J0IGJ5IAorICogICAgICAgICAgIDxwYXVsQHBhdWxicmlzdG93Lm5ldD4K
KyAqIFZlciAwLjkyICBPY3QgMjIgMDAgICBQYXVsIEJyaXN0b3cgYmVjYW1lIG9mZmljaWFs
IG1haW50YWluZXIgZm9yIHRoaXMgCisgKiAgICAgICAgICAgZHJpdmVyLiAgSW5jbHVkZWQg
UG93ZXJib29rIGludGVybmFsIHppcCBrbHVkZ2UuCisgKiBWZXIgMC45MyAgT2N0IDI0IDAw
ICAgRml4ZWQgYnVncyBmb3IgQ2xpayEgZHJpdmUKKyAqCQkJCQkJbm8gZGlzayBvbiBpbnNl
cnQgYW5kIGRpc2sgY2hhbmdlIG5vdyB3b3JrcworICogVmVyIDAuOTQgIE9jdCAyNyAwMCAg
IFRpZGllZCB1cCB0byByZW1vdmUgc3Ryc3RyKENsaWspIGV2ZXJ5d2hlcmUKKyAqIFZlciAw
Ljk1ICBOb3YgIDcgMDAgICBCcm91Z2h0IGFjcm9zcyB0byBrZXJuZWwgMi40CisgKiBWZXIg
MC45NiAgSmFuICA3IDAxICAgQWN0dWFsbHkgaW4gbGluZSB3aXRoIHJlbGVhc2UgdmVyc2lv
biBvZiAyLjQuMAorICogICAgICAgICAgICAgICAgICAgICAgIGluY2x1ZGluZyBzZXRfYml0
IHBhdGNoIGZyb20gUnVzdHkgUnVzc2VsCisgKiAgICAgICAgICAgCiAgKi8KIAotI2RlZmlu
ZSBJREVGTE9QUFlfVkVSU0lPTiAiMC45IgorI2RlZmluZSBJREVGTE9QUFlfVkVSU0lPTiAi
MC45NiIKIAogI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPgogI2luY2x1ZGUgPGxpbnV4L21v
ZHVsZS5oPgpAQCAtNDUsNyArNjMsNyBAQAogI2luY2x1ZGUgPGxpbnV4L21ham9yLmg+CiAj
aW5jbHVkZSA8bGludXgvZXJybm8uaD4KICNpbmNsdWRlIDxsaW51eC9nZW5oZC5oPgotI2lu
Y2x1ZGUgPGxpbnV4L3NsYWIuaD4KKyNpbmNsdWRlIDxsaW51eC9tYWxsb2MuaD4KICNpbmNs
dWRlIDxsaW51eC9jZHJvbS5oPgogI2luY2x1ZGUgPGxpbnV4L2lkZS5oPgogCkBAIC01Niwx
MiArNzQsMTQgQEAKICNpbmNsdWRlIDxhc20vdW5hbGlnbmVkLmg+CiAjaW5jbHVkZSA8YXNt
L2JpdG9wcy5oPgogCisKIC8qCiAgKglUaGUgZm9sbG93aW5nIGFyZSB1c2VkIHRvIGRlYnVn
IHRoZSBkcml2ZXIuCiAgKi8KLSNkZWZpbmUgSURFRkxPUFBZX0RFQlVHX0xPRwkJMAogI2Rl
ZmluZSBJREVGTE9QUFlfREVCVUdfSU5GTwkJMAogI2RlZmluZSBJREVGTE9QUFlfREVCVUdf
QlVHUwkJMQorLyogI2RlZmluZSBJREVGTE9QUFlfREVCVUcoZm10LCBhcmdzLi4uKSBwcmlu
dGsoS0VSTl9JTkZPIGZtdCwgIyMgYXJncykgKi8KKyNkZWZpbmUgSURFRkxPUFBZX0RFQlVH
KCBmbXQsIGFyZ3MuLi4gKQogCiAvKgogICoJU29tZSBkcml2ZXMgcmVxdWlyZSBhIGxvbmdl
ciBpcnEgdGltZW91dC4KQEAgLTEwNCw3ICsxMjQsNyBAQAogCWJ5dGUgKmN1cnJlbnRfcG9z
aXRpb247CQkJLyogUG9pbnRlciBpbnRvIHRoZSBhYm92ZSBidWZmZXIgKi8KIAl2b2lkICgq
Y2FsbGJhY2spIChpZGVfZHJpdmVfdCAqKTsJLyogQ2FsbGVkIHdoZW4gdGhpcyBwYWNrZXQg
Y29tbWFuZCBpcyBjb21wbGV0ZWQgKi8KIAlieXRlIHBjX2J1ZmZlcltJREVGTE9QUFlfUENf
QlVGRkVSX1NJWkVdOwkvKiBUZW1wb3JhcnkgYnVmZmVyICovCi0JdW5zaWduZWQgbG9uZyBm
bGFnczsJCQkvKiBTdGF0dXMvQWN0aW9uIGJpdCBmbGFnczogbG9uZyBmb3Igc2V0X2JpdCAq
LworCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CQkJLyogU3RhdHVzL0FjdGlvbiBiaXQgZmxhZ3Mg
OiBsb25nIGZvciBzZXRfYml0KCkgKi8KIH0gaWRlZmxvcHB5X3BjX3Q7CiAKIC8qCkBAIC0x
ODEsNiArMjAxLDcgQEAKIAl1OAkJcmVzZXJ2ZWQzMFsyXTsKIH0gaWRlZmxvcHB5X2ZsZXhp
YmxlX2Rpc2tfcGFnZV90OwogIAorCiAvKgogICoJRm9ybWF0IGNhcGFjaXR5CiAgKi8KQEAg
LTIzNyw3ICsyNTgsNyBAQAogCWlkZWZsb3BweV9mbGV4aWJsZV9kaXNrX3BhZ2VfdCBmbGV4
aWJsZV9kaXNrX3BhZ2U7CS8qIENvcHkgb2YgdGhlIGZsZXhpYmxlIGRpc2sgcGFnZSAqLwog
CWludCB3cDsJCQkJCQkJLyogV3JpdGUgcHJvdGVjdCAqLwogCi0JdW5zaWduZWQgaW50IGZs
YWdzOwkJCS8qIFN0YXR1cy9BY3Rpb24gZmxhZ3MgKi8KKwl1bnNpZ25lZCBsb25nIGZsYWdz
OwkJCS8qIFN0YXR1cy9BY3Rpb24gZmxhZ3MgOiBsb25nIGZvciBzZXRfYml0KCkgKi8KIH0g
aWRlZmxvcHB5X2Zsb3BweV90OwogCiAvKgpAQCAtMjQ2LDYgKzI2Nyw4IEBACiAjZGVmaW5l
IElERUZMT1BQWV9EUlFfSU5URVJSVVBUCQkwCS8qIERSUSBpbnRlcnJ1cHQgZGV2aWNlICov
CiAjZGVmaW5lIElERUZMT1BQWV9NRURJQV9DSEFOR0VECQkxCS8qIE1lZGlhIG1heSBoYXZl
IGNoYW5nZWQgKi8KICNkZWZpbmUgSURFRkxPUFBZX1VTRV9SRUFEMTIJCTIJLyogVXNlIFJF
QUQxMi9XUklURTEyIG9yIFJFQUQxMC9XUklURTEwICovCisjZGVmaW5lIElERUZMT1BQWV9D
TElLX0RSSVZFICAgICAgMyAgICAgICAvKiBBdm9pZCBjb21tYW5kcyBub3Qgc3VwcG9ydGVk
IGluIENsaWsgZHJpdmUgKi8KKyNkZWZpbmUgSURFRkxPUFBZX1BPV0VSQk9PS19aSVAgICA0
ICAgICAgIC8qIEtsdWRnZSBmb3IgQXBwbGUgUG93ZXJib29rIFppcCBkcml2ZSAqLwogCiAv
KgogICoJQVRBUEkgZmxvcHB5IGRyaXZlIHBhY2tldCBjb21tYW5kcwpAQCAtNjIxLDkgKzY0
NCw3IEBACiAJc3RydWN0IHJlcXVlc3QgKnJxID0gaHdncm91cC0+cnE7CiAJaW50IGVycm9y
OwogCi0jaWYgSURFRkxPUFBZX0RFQlVHX0xPRwotCXByaW50ayAoS0VSTl9JTkZPICJSZWFj
aGVkIGlkZWZsb3BweV9lbmRfcmVxdWVzdFxuIik7Ci0jZW5kaWYgLyogSURFRkxPUFBZX0RF
QlVHX0xPRyAqLworICBJREVGTE9QUFlfREVCVUcoICJSZWFjaGVkIGlkZWZsb3BweV9lbmRf
cmVxdWVzdFxuIik7CiAKIAlzd2l0Y2ggKHVwdG9kYXRlKSB7CiAJCWNhc2UgMDogZXJyb3Ig
PSBJREVGTE9QUFlfRVJST1JfR0VORVJBTDsgYnJlYWs7CkBAIC03NDYsMjEgKzc2NywxOSBA
QAogCWlkZWZsb3BweV9mbG9wcHlfdCAqZmxvcHB5ID0gZHJpdmUtPmRyaXZlcl9kYXRhOwog
CiAJZmxvcHB5LT5zZW5zZV9rZXkgPSByZXN1bHQtPnNlbnNlX2tleTsgZmxvcHB5LT5hc2Mg
PSByZXN1bHQtPmFzYzsgZmxvcHB5LT5hc2NxID0gcmVzdWx0LT5hc2NxOwotI2lmIElERUZM
T1BQWV9ERUJVR19MT0cKLQlpZiAoZmxvcHB5LT5mYWlsZWRfcGMpCi0JCXByaW50ayAoS0VS
Tl9JTkZPICJpZGUtZmxvcHB5OiBwYyA9ICV4LCBzZW5zZSBrZXkgPSAleCwgYXNjID0gJXgs
IGFzY3EgPSAleFxuIixmbG9wcHktPmZhaWxlZF9wYy0+Y1swXSxyZXN1bHQtPnNlbnNlX2tl
eSxyZXN1bHQtPmFzYyxyZXN1bHQtPmFzY3EpOwotCWVsc2UKLQkJcHJpbnRrIChLRVJOX0lO
Rk8gImlkZS1mbG9wcHk6IHNlbnNlIGtleSA9ICV4LCBhc2MgPSAleCwgYXNjcSA9ICV4XG4i
LHJlc3VsdC0+c2Vuc2Vfa2V5LHJlc3VsdC0+YXNjLHJlc3VsdC0+YXNjcSk7Ci0jZW5kaWYg
LyogSURFRkxPUFBZX0RFQlVHX0xPRyAqLworICBpZiAoZmxvcHB5LT5mYWlsZWRfcGMpIHsK
KyAgICBJREVGTE9QUFlfREVCVUcoImlkZS1mbG9wcHk6IHBjID0gJXgsIHNlbnNlIGtleSA9
ICV4LCBhc2MgPSAleCwgYXNjcSA9ICV4XG4iLGZsb3BweS0+ZmFpbGVkX3BjLT5jWzBdLHJl
c3VsdC0+c2Vuc2Vfa2V5LHJlc3VsdC0+YXNjLHJlc3VsdC0+YXNjcSk7CisgIH0KKyAgZWxz
ZSB7CisgICAgSURFRkxPUFBZX0RFQlVHKCJpZGUtZmxvcHB5OiBzZW5zZSBrZXkgPSAleCwg
YXNjID0gJXgsIGFzY3EgPSAleFxuIixyZXN1bHQtPnNlbnNlX2tleSxyZXN1bHQtPmFzYyxy
ZXN1bHQtPmFzY3EpOworICB9CiB9CiAKIHN0YXRpYyB2b2lkIGlkZWZsb3BweV9yZXF1ZXN0
X3NlbnNlX2NhbGxiYWNrIChpZGVfZHJpdmVfdCAqZHJpdmUpCiB7CiAJaWRlZmxvcHB5X2Zs
b3BweV90ICpmbG9wcHkgPSBkcml2ZS0+ZHJpdmVyX2RhdGE7CiAKLSNpZiBJREVGTE9QUFlf
REVCVUdfTE9HCi0JcHJpbnRrIChLRVJOX0lORk8gImlkZS1mbG9wcHk6IFJlYWNoZWQgaWRl
ZmxvcHB5X3JlcXVlc3Rfc2Vuc2VfY2FsbGJhY2tcbiIpOwotI2VuZGlmIC8qIElERUZMT1BQ
WV9ERUJVR19MT0cgKi8KKyAgSURFRkxPUFBZX0RFQlVHKCAiaWRlLWZsb3BweTogUmVhY2hl
ZCBpZGVmbG9wcHlfcmVxdWVzdF9zZW5zZV9jYWxsYmFja1xuIik7CiAJaWYgKCFmbG9wcHkt
PnBjLT5lcnJvcikgewogCQlpZGVmbG9wcHlfYW5hbHl6ZV9lcnJvciAoZHJpdmUsKGlkZWZs
b3BweV9yZXF1ZXN0X3NlbnNlX3Jlc3VsdF90ICopIGZsb3BweS0+cGMtPmJ1ZmZlcik7CiAJ
CWlkZWZsb3BweV9lbmRfcmVxdWVzdCAoMSxIV0dST1VQIChkcml2ZSkpOwpAQCAtNzc3LDkg
Kzc5Niw3IEBACiB7CiAJaWRlZmxvcHB5X2Zsb3BweV90ICpmbG9wcHkgPSBkcml2ZS0+ZHJp
dmVyX2RhdGE7CiAJCi0jaWYgSURFRkxPUFBZX0RFQlVHX0xPRwotCXByaW50ayAoS0VSTl9J
TkZPICJpZGUtZmxvcHB5OiBSZWFjaGVkIGlkZWZsb3BweV9wY19jYWxsYmFja1xuIik7Ci0j
ZW5kaWYgLyogSURFRkxPUFBZX0RFQlVHX0xPRyAqLworICBJREVGTE9QUFlfREVCVUcoICJp
ZGUtZmxvcHB5OiBSZWFjaGVkIGlkZWZsb3BweV9wY19jYWxsYmFja1xuIik7CiAKIAlpZGVm
bG9wcHlfZW5kX3JlcXVlc3QgKGZsb3BweS0+cGMtPmVycm9yID8gMDoxLCBIV0dST1VQKGRy
aXZlKSk7CiB9CkBAIC04NDAsOSArODU3LDcgQEAKIAlzdHJ1Y3QgcmVxdWVzdCAqcnEgPSBw
Yy0+cnE7CiAJdW5zaWduZWQgaW50IHRlbXA7CiAKLSNpZiBJREVGTE9QUFlfREVCVUdfTE9H
Ci0JcHJpbnRrIChLRVJOX0lORk8gImlkZS1mbG9wcHk6IFJlYWNoZWQgaWRlZmxvcHB5X3Bj
X2ludHIgaW50ZXJydXB0IGhhbmRsZXJcbiIpOwotI2VuZGlmIC8qIElERUZMT1BQWV9ERUJV
R19MT0cgKi8JCisgIElERUZMT1BQWV9ERUJVRyggImlkZS1mbG9wcHk6IFJlYWNoZWQgaWRl
ZmxvcHB5X3BjX2ludHIgaW50ZXJydXB0IGhhbmRsZXJcbiIpOwogCiAjaWZkZWYgQ09ORklH
X0JMS19ERVZfSURFRE1BCiAJaWYgKHRlc3RfYml0IChQQ19ETUFfSU5fUFJPR1JFU1MsICZw
Yy0+ZmxhZ3MpKSB7CkBAIC04NTIsMjYgKzg2NywyMCBAQAogCQkJcGMtPmFjdHVhbGx5X3Ry
YW5zZmVycmVkPXBjLT5yZXF1ZXN0X3RyYW5zZmVyOwogCQkJaWRlZmxvcHB5X3VwZGF0ZV9i
dWZmZXJzIChkcml2ZSwgcGMpOwogCQl9Ci0jaWYgSURFRkxPUFBZX0RFQlVHX0xPRwotCQlw
cmludGsgKEtFUk5fSU5GTyAiaWRlLWZsb3BweTogRE1BIGZpbmlzaGVkXG4iKTsKLSNlbmRp
ZiAvKiBJREVGTE9QUFlfREVCVUdfTE9HICovCisgICAgSURFRkxPUFBZX0RFQlVHKCAiaWRl
LWZsb3BweTogRE1BIGZpbmlzaGVkXG4iKTsKIAl9CiAjZW5kaWYgLyogQ09ORklHX0JMS19E
RVZfSURFRE1BICovCiAKIAlzdGF0dXMuYWxsID0gR0VUX1NUQVQoKTsJCQkJCS8qIENsZWFy
IHRoZSBpbnRlcnJ1cHQgKi8KIAogCWlmICghc3RhdHVzLmIuZHJxKSB7CQkJCQkJLyogTm8g
bW9yZSBpbnRlcnJ1cHRzICovCi0jaWYgSURFRkxPUFBZX0RFQlVHX0xPRwotCQlwcmludGsg
KEtFUk5fSU5GTyAiUGFja2V0IGNvbW1hbmQgY29tcGxldGVkLCAlZCBieXRlcyB0cmFuc2Zl
cnJlZFxuIiwgcGMtPmFjdHVhbGx5X3RyYW5zZmVycmVkKTsKLSNlbmRpZiAvKiBJREVGTE9Q
UFlfREVCVUdfTE9HICovCisgICAgSURFRkxPUFBZX0RFQlVHKCAiUGFja2V0IGNvbW1hbmQg
Y29tcGxldGVkLCAlZCBieXRlcyB0cmFuc2ZlcnJlZFxuIiwgcGMtPmFjdHVhbGx5X3RyYW5z
ZmVycmVkKTsKIAkJY2xlYXJfYml0IChQQ19ETUFfSU5fUFJPR1JFU1MsICZwYy0+ZmxhZ3Mp
OwogCiAJCWlkZV9fc3RpKCk7CS8qIGxvY2FsIENQVSBvbmx5ICovCiAKIAkJaWYgKHN0YXR1
cy5iLmNoZWNrIHx8IHRlc3RfYml0IChQQ19ETUFfRVJST1IsICZwYy0+ZmxhZ3MpKSB7CS8q
IEVycm9yIGRldGVjdGVkICovCi0jaWYgSURFRkxPUFBZX0RFQlVHX0xPRwotCQkJcHJpbnRr
IChLRVJOX0lORk8gImlkZS1mbG9wcHk6ICVzOiBJL08gZXJyb3JcbiIsZHJpdmUtPm5hbWUp
OwotI2VuZGlmIC8qIElERUZMT1BQWV9ERUJVR19MT0cgKi8KKyAgICAgIElERUZMT1BQWV9E
RUJVRyggImlkZS1mbG9wcHk6ICVzOiBJL08gZXJyb3JcbiIsZHJpdmUtPm5hbWUpOwogCQkJ
cnEtPmVycm9ycysrOwogCQkJaWYgKHBjLT5jWzBdID09IElERUZMT1BQWV9SRVFVRVNUX1NF
TlNFX0NNRCkgewogCQkJCXByaW50ayAoS0VSTl9FUlIgImlkZS1mbG9wcHk6IEkvTyBlcnJv
ciBpbiByZXF1ZXN0IHNlbnNlIGNvbW1hbmRcbiIpOwpAQCAtOTE1LDkgKzkyNCw3IEBACiAJ
CQkJaWRlX3NldF9oYW5kbGVyIChkcml2ZSwmaWRlZmxvcHB5X3BjX2ludHIsSURFRkxPUFBZ
X1dBSVRfQ01ELCBOVUxMKTsKIAkJCQlyZXR1cm4gaWRlX3N0YXJ0ZWQ7CiAJCQl9Ci0jaWYg
SURFRkxPUFBZX0RFQlVHX0xPRwotCQkJcHJpbnRrIChLRVJOX05PVElDRSAiaWRlLWZsb3Bw
eTogVGhlIGZsb3BweSB3YW50cyB0byBzZW5kIHVzIG1vcmUgZGF0YSB0aGFuIGV4cGVjdGVk
IC0gYWxsb3dpbmcgdHJhbnNmZXJcbiIpOwotI2VuZGlmIC8qIElERUZMT1BQWV9ERUJVR19M
T0cgKi8KKyAgICAgIElERUZMT1BQWV9ERUJVRyggImlkZS1mbG9wcHk6IFRoZSBmbG9wcHkg
d2FudHMgdG8gc2VuZCB1cyBtb3JlIGRhdGEgdGhhbiBleHBlY3RlZCAtIGFsbG93aW5nIHRy
YW5zZmVyXG4iKTsKIAkJfQogCX0KIAlpZiAodGVzdF9iaXQgKFBDX1dSSVRJTkcsICZwYy0+
ZmxhZ3MpKSB7CkBAIC05ODMsNyArOTkwLDcgQEAKIAkJICoJYSBsZWdpdGltYXRlIGVycm9y
IGNvZGUgd2FzIHJlY2VpdmVkLgogCQkgKi8KIAkJaWYgKCF0ZXN0X2JpdCAoUENfQUJPUlQs
ICZwYy0+ZmxhZ3MpKSB7Ci0JCQlwcmludGsgKEtFUk5fRVJSICJpZGUtZmxvcHB5OiAlczog
SS9PIGVycm9yLCBwYyA9ICUyeCwga2V5ID0gJTJ4LCBhc2MgPSAlMngsIGFzY3EgPSAlMnhc
biIsCisgICAgICBJREVGTE9QUFlfREVCVUcoICJpZGUtZmxvcHB5OiAlczogSS9PIGVycm9y
LCBwYyA9ICUyeCwga2V5ID0gJTJ4LCBhc2MgPSAlMngsIGFzY3EgPSAlMnhcbiIsCiAJCQkJ
ZHJpdmUtPm5hbWUsIHBjLT5jWzBdLCBmbG9wcHktPnNlbnNlX2tleSwgZmxvcHB5LT5hc2Ms
IGZsb3BweS0+YXNjcSk7CiAJCQlwYy0+ZXJyb3IgPSBJREVGTE9QUFlfRVJST1JfR0VORVJB
TDsJCS8qIEdpdmluZyB1cCAqLwogCQl9CkBAIC05OTEsOSArOTk4LDcgQEAKIAkJcGMtPmNh
bGxiYWNrKGRyaXZlKTsKIAkJcmV0dXJuIGlkZV9zdG9wcGVkOwogCX0KLSNpZiBJREVGTE9Q
UFlfREVCVUdfTE9HCi0JcHJpbnRrIChLRVJOX0lORk8gIlJldHJ5IG51bWJlciAtICVkXG4i
LHBjLT5yZXRyaWVzKTsKLSNlbmRpZiAvKiBJREVGTE9QUFlfREVCVUdfTE9HICovCisgIElE
RUZMT1BQWV9ERUJVRyggIlJldHJ5IG51bWJlciAtICVkXG4iLHBjLT5yZXRyaWVzKTsKIAog
CXBjLT5yZXRyaWVzKys7CiAJcGMtPmFjdHVhbGx5X3RyYW5zZmVycmVkPTA7CQkJCQkvKiBX
ZSBoYXZlbid0IHRyYW5zZmVycmVkIGFueSBkYXRhIHlldCAqLwpAQCAtMTAzNCw5ICsxMDM5
LDcgQEAKIAogc3RhdGljIHZvaWQgaWRlZmxvcHB5X3J3X2NhbGxiYWNrIChpZGVfZHJpdmVf
dCAqZHJpdmUpCiB7Ci0jaWYgSURFRkxPUFBZX0RFQlVHX0xPRwkKLQlwcmludGsgKEtFUk5f
SU5GTyAiaWRlLWZsb3BweTogUmVhY2hlZCBpZGVmbG9wcHlfcndfY2FsbGJhY2tcbiIpOwot
I2VuZGlmIC8qIElERUZMT1BQWV9ERUJVR19MT0cgKi8KKyAgSURFRkxPUFBZX0RFQlVHKCAi
aWRlLWZsb3BweTogUmVhY2hlZCBpZGVmbG9wcHlfcndfY2FsbGJhY2tcbiIpOwogCiAJaWRl
ZmxvcHB5X2VuZF9yZXF1ZXN0KDEsIEhXR1JPVVAoZHJpdmUpKTsKIAlyZXR1cm47CkBAIC0x
MDQ0LDkgKzEwNDcsNyBAQAogCiBzdGF0aWMgdm9pZCBpZGVmbG9wcHlfY3JlYXRlX3ByZXZl
bnRfY21kIChpZGVmbG9wcHlfcGNfdCAqcGMsIGludCBwcmV2ZW50KQogewotI2lmIElERUZM
T1BQWV9ERUJVR19MT0cKLQlwcmludGsgKEtFUk5fSU5GTyAiaWRlLWZsb3BweTogY3JlYXRp
bmcgcHJldmVudCByZW1vdmFsIGNvbW1hbmQsIHByZXZlbnQgPSAlZFxuIiwgcHJldmVudCk7
Ci0jZW5kaWYgLyogSURFRkxPUFBZX0RFQlVHX0xPRyAqLworICBJREVGTE9QUFlfREVCVUco
ICJpZGUtZmxvcHB5OiBjcmVhdGluZyBwcmV2ZW50IHJlbW92YWwgY29tbWFuZCwgcHJldmVu
dCA9ICVkXG4iLCBwcmV2ZW50KTsKIAogCWlkZWZsb3BweV9pbml0X3BjIChwYyk7CiAJcGMt
PmNbMF0gPSBJREVGTE9QUFlfUFJFVkVOVF9SRU1PVkFMX0NNRDsKQEAgLTExMDYsMTAgKzEx
MDcsOCBAQAogCWludCBibG9jayA9IHNlY3RvciAvIGZsb3BweS0+YnNfZmFjdG9yOwogCWlu
dCBibG9ja3MgPSBycS0+bnJfc2VjdG9ycyAvIGZsb3BweS0+YnNfZmFjdG9yOwogCQotI2lm
IElERUZMT1BQWV9ERUJVR19MT0cKLQlwcmludGsgKCJjcmVhdGVfcncxJWRfY21kOiBibG9j
ayA9PSAlZCwgYmxvY2tzID09ICVkXG4iLAorICBJREVGTE9QUFlfREVCVUcoICJjcmVhdGVf
cncxJWRfY21kOiBibG9jayA9PSAlZCwgYmxvY2tzID09ICVkXG4iLAogCQkyICogdGVzdF9i
aXQgKElERUZMT1BQWV9VU0VfUkVBRDEyLCAmZmxvcHB5LT5mbGFncyksIGJsb2NrLCBibG9j
a3MpOwotI2VuZGlmIC8qIElERUZMT1BQWV9ERUJVR19MT0cgKi8KIAogCWlkZWZsb3BweV9p
bml0X3BjIChwYyk7CiAJaWYgKHRlc3RfYml0IChJREVGTE9QUFlfVVNFX1JFQUQxMiwgJmZs
b3BweS0+ZmxhZ3MpKSB7CkBAIC0xMTM5LDEwICsxMTM4LDggQEAKIAlpZGVmbG9wcHlfZmxv
cHB5X3QgKmZsb3BweSA9IGRyaXZlLT5kcml2ZXJfZGF0YTsKIAlpZGVmbG9wcHlfcGNfdCAq
cGM7CiAKLSNpZiBJREVGTE9QUFlfREVCVUdfTE9HCi0JcHJpbnRrIChLRVJOX0lORk8gInJx
X3N0YXR1czogJWQsIHJxX2RldjogJXUsIGNtZDogJWQsIGVycm9yczogJWRcbiIscnEtPnJx
X3N0YXR1cywodW5zaWduZWQgaW50KSBycS0+cnFfZGV2LHJxLT5jbWQscnEtPmVycm9ycyk7
Ci0JcHJpbnRrIChLRVJOX0lORk8gInNlY3RvcjogJWxkLCBucl9zZWN0b3JzOiAlbGQsIGN1
cnJlbnRfbnJfc2VjdG9yczogJWxkXG4iLHJxLT5zZWN0b3IscnEtPm5yX3NlY3RvcnMscnEt
PmN1cnJlbnRfbnJfc2VjdG9ycyk7Ci0jZW5kaWYgLyogSURFRkxPUFBZX0RFQlVHX0xPRyAq
LworICBJREVGTE9QUFlfREVCVUcoICJycV9zdGF0dXM6ICVkLCBycV9kZXY6ICV1LCBjbWQ6
ICVkLCBlcnJvcnM6ICVkXG4iLHJxLT5ycV9zdGF0dXMsKHVuc2lnbmVkIGludCkgcnEtPnJx
X2RldixycS0+Y21kLHJxLT5lcnJvcnMpOworICBJREVGTE9QUFlfREVCVUcoICJzZWN0b3I6
ICVsZCwgbnJfc2VjdG9yczogJWxkLCBjdXJyZW50X25yX3NlY3RvcnM6ICVsZFxuIixycS0+
c2VjdG9yLHJxLT5ucl9zZWN0b3JzLHJxLT5jdXJyZW50X25yX3NlY3RvcnMpOwogCiAJaWYg
KHJxLT5lcnJvcnMgPj0gRVJST1JfTUFYKSB7CiAJCWlmIChmbG9wcHktPmZhaWxlZF9wYyAh
PSBOVUxMKQpAQCAtMTIzNSw2ICsxMjMyLDcgQEAKIAlyZXR1cm4gMDsKIH0KIAorCiAvKgog
ICoJRGV0ZXJtaW5lIGlmIGEgbWVkaWEgaXMgcHJlc2VudCBpbiB0aGUgZmxvcHB5IGRyaXZl
LCBhbmQgaWYgc28sCiAgKglpdHMgTEJBIGNhcGFjaXR5LgpAQCAtMTI2Myw0OCArMTI2MSw2
OCBAQAogCWZvciAoaSA9IDA7IGkgPCBkZXNjcmlwdG9yczsgaSsrLCBkZXNjcmlwdG9yKysp
IHsKIAkJYmxvY2tzID0gZGVzY3JpcHRvci0+YmxvY2tzID0gbnRvaGwgKGRlc2NyaXB0b3It
PmJsb2Nrcyk7CiAJCWxlbmd0aCA9IGRlc2NyaXB0b3ItPmxlbmd0aCA9IG50b2hzIChkZXNj
cmlwdG9yLT5sZW5ndGgpOwotCQlpZiAoIWkgJiYgZGVzY3JpcHRvci0+ZGMgPT0gQ0FQQUNJ
VFlfQ1VSUkVOVCkgewotCQkJaWYgKG1lbWNtcCAoZGVzY3JpcHRvciwgJmZsb3BweS0+Y2Fw
YWNpdHksIHNpemVvZiAoaWRlZmxvcHB5X2NhcGFjaXR5X2Rlc2NyaXB0b3JfdCkpKSB7Ci0J
CQkJcHJpbnRrIChLRVJOX0lORk8gIiVzOiAlZGtCLCAlZCBibG9ja3MsICVkIHNlY3RvciBz
aXplLCAlcyBcbiIsCi0JCQkJCWRyaXZlLT5uYW1lLCBibG9ja3MgKiBsZW5ndGggLyAxMDI0
LCBibG9ja3MsIGxlbmd0aCwKLQkJCQkJZHJpdmUtPnVzaW5nX2RtYSA/ICIsIERNQSI6IiIp
OwotCQkJfQotCQkJZmxvcHB5LT5jYXBhY2l0eSA9ICpkZXNjcmlwdG9yOworICAgIGlmICgh
aSkgeworICAgIAlzd2l0Y2ggKGRlc2NyaXB0b3ItPmRjKSB7CisgICAgCQljYXNlIENBUEFD
SVRZX1VORk9STUFUVEVEOiAvKiBDbGlrISBkcml2ZSByZXR1cm5zIHRoaXMgaW5zdGVhZCBv
ZiBDQVBBQ0lUWV9DVVJSRU5UICovCisgICAgCQkJaWYgKCF0ZXN0X2JpdChJREVGTE9QUFlf
Q0xJS19EUklWRSwgJmZsb3BweS0+ZmxhZ3MpKSAKKyAgICAJCQkJYnJlYWs7IC8qIElmIGl0
IGlzIG5vdCBhIGNsaWsgZHJpdmUsIGJyZWFrIG91dCAobWFpbnRhaW5zIHByZXZpb3VzIGRy
aXZlciBiZWhhdmlvdXIpICovCisgICAgCQljYXNlIENBUEFDSVRZX0NVUlJFTlQ6IC8qIE5v
cm1hbCBaaXAvTFMtMTIwIGRpc2tzICovCisgCQkJaWYgKG1lbWNtcCAoZGVzY3JpcHRvciwg
JmZsb3BweS0+Y2FwYWNpdHksIHNpemVvZiAoaWRlZmxvcHB5X2NhcGFjaXR5X2Rlc2NyaXB0
b3JfdCkpKQorIAkJCQlwcmludGsgKEtFUk5fSU5GTyAiJXM6ICVka0IsICVkIGJsb2Nrcywg
JWQgc2VjdG9yIHNpemVcbiIsIGRyaXZlLT5uYW1lLCBibG9ja3MgKiBsZW5ndGggLyAxMDI0
LCBibG9ja3MsIGxlbmd0aCk7CisgCQkJZmxvcHB5LT5jYXBhY2l0eSA9ICpkZXNjcmlwdG9y
OwogCQkJaWYgKCFsZW5ndGggfHwgbGVuZ3RoICUgNTEyKQotCQkJCXByaW50ayAoS0VSTl9F
UlIgIiVzOiAlZCBieXRlcyBibG9jayBzaXplIG5vdCBzdXBwb3J0ZWRcbiIsIGRyaXZlLT5u
YW1lLCBsZW5ndGgpOworCQkJCXByaW50ayAoS0VSTl9OT1RJQ0UgIiVzOiAlZCBieXRlcyBi
bG9jayBzaXplIG5vdCBzdXBwb3J0ZWRcbiIsIGRyaXZlLT5uYW1lLCBsZW5ndGgpOyAJCQog
CQkJZWxzZSB7CiAJCQkJZmxvcHB5LT5ibG9ja3MgPSBibG9ja3M7CiAJCQkJZmxvcHB5LT5i
bG9ja19zaXplID0gbGVuZ3RoOwogCQkJCWlmICgoZmxvcHB5LT5ic19mYWN0b3IgPSBsZW5n
dGggLyA1MTIpICE9IDEpCiAJCQkJCXByaW50ayAoS0VSTl9OT1RJQ0UgIiVzOiB3YXJuaW5n
OiBub24gNTEyIGJ5dGVzIGJsb2NrIHNpemUgbm90IGZ1bGx5IHN1cHBvcnRlZFxuIiwgZHJp
dmUtPm5hbWUpOwotCQkJCXJjID0gMDsKLQkJCX0KKyAJCQkJcmMgPSAwOworIAkJCX0KKyAg
ICAJCQlicmVhazsKKyAgICAJCWNhc2UgQ0FQQUNJVFlfTk9fQ0FSVFJJREdFOiAKKyAgICAJ
CQkvKiBUaGlzIGlzIGEgS0VSTl9FUlIgc28gaXQgYXBwZWFycyBvbiBzY3JlZW4gZm9yIHRo
ZSB1c2VyIHRvIHNlZSAqLworICAgIAkJCXByaW50ayAoS0VSTl9FUlIgIiVzOiBObyBkaXNr
IGluIGRyaXZlXG4iLCBkcml2ZS0+bmFtZSk7CisJCQkJCWJyZWFrOwkgIAorICAgIAkJY2Fz
ZSBDQVBBQ0lUWV9JTlZBTElEOiAKKyAgICAJCQlwcmludGsgKEtFUk5fRVJSICIlczogSW52
YWxpZCBjYXBhY2l0eSBmb3IgZGlzayBpbiBkcml2ZVxuIiwgZHJpdmUtPm5hbWUpOworCQkJ
CQlicmVhazsJICAKIAkJfQotI2lmIElERUZMT1BQWV9ERUJVR19JTkZPCi0JCWlmICghaSkg
cHJpbnRrIChLRVJOX0lORk8gIkRlc2NyaXB0b3IgMCBDb2RlOiAlZFxuIiwgZGVzY3JpcHRv
ci0+ZGMpOwotCQlwcmludGsgKEtFUk5fSU5GTyAiRGVzY3JpcHRvciAlZDogJWRrQiwgJWQg
YmxvY2tzLCAlZCBzZWN0b3Igc2l6ZVxuIiwgaSwgYmxvY2tzICogbGVuZ3RoIC8gMTAyNCwg
YmxvY2tzLCBsZW5ndGgpOwotI2VuZGlmIC8qIElERUZMT1BQWV9ERUJVR19JTkZPICovCiAJ
fQorICAgIGlmICghaSkgeworICAgIAlJREVGTE9QUFlfREVCVUcoICJEZXNjcmlwdG9yIDAg
Q29kZTogJWRcbiIsIGRlc2NyaXB0b3ItPmRjKTsKKyAgICB9CisgICAgSURFRkxPUFBZX0RF
QlVHKCAiRGVzY3JpcHRvciAlZDogJWRrQiwgJWQgYmxvY2tzLCAlZCBzZWN0b3Igc2l6ZVxu
IiwgaSwgYmxvY2tzICogbGVuZ3RoIC8gMTAyNCwgYmxvY2tzLCBsZW5ndGgpOworICB9Cisg
IAorICAvKiBDbGlrISBkaXNrIGRvZXMgbm90IHN1cHBvcnQgZ2V0X2ZsZXhpYmxlX2Rpc2tf
cGFnZSAqLworCWlmICghdGVzdF9iaXQoSURFRkxPUFBZX0NMSUtfRFJJVkUsICZmbG9wcHkt
PmZsYWdzKSkgCiAJKHZvaWQpIGlkZWZsb3BweV9nZXRfZmxleGlibGVfZGlza19wYWdlIChk
cml2ZSk7CisKIAlkcml2ZS0+cGFydFswXS5ucl9zZWN0cyA9IGZsb3BweS0+YmxvY2tzICog
ZmxvcHB5LT5ic19mYWN0b3I7CiAJcmV0dXJuIHJjOwogfQogCisKIC8qCiAgKglPdXIgc3Bl
Y2lhbCBpZGUtZmxvcHB5IGlvY3RsJ3MuCiAgKgotICoJQ3VycmVudGx5IHRoZXJlIGFyZW4n
dCBhbnkgaW9jdGwncy4KKyAqICAgICAgU3VwcG9ydHMgZWplY3QgY29tbWFuZCAKICAqLwog
c3RhdGljIGludCBpZGVmbG9wcHlfaW9jdGwgKGlkZV9kcml2ZV90ICpkcml2ZSwgc3RydWN0
IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUsCiAJCQkJIHVuc2lnbmVkIGludCBj
bWQsIHVuc2lnbmVkIGxvbmcgYXJnKQogewogCWlkZWZsb3BweV9wY190IHBjOworICBpZGVm
bG9wcHlfZmxvcHB5X3QgKmZsb3BweSA9IGRyaXZlLT5kcml2ZXJfZGF0YTsKIAogCWlmIChj
bWQgPT0gQ0RST01FSkVDVCkgewogCQlpZiAoZHJpdmUtPnVzYWdlID4gMSkKIAkJCXJldHVy
biAtRUJVU1k7CisgICAgLyogVGhlIElPTUVHQSBDbGlrISBEcml2ZSBkb2Vzbid0IHN1cHBv
cnQgdGhpcyBjb21tYW5kIC0gbm8gcm9vbSBmb3IgYW4gZWplY3QgbWVjaGFuaXNtICovCisJ
CWlmICghdGVzdF9iaXQoSURFRkxPUFBZX0NMSUtfRFJJVkUsICZmbG9wcHktPmZsYWdzKSkg
ewogCQlpZGVmbG9wcHlfY3JlYXRlX3ByZXZlbnRfY21kICgmcGMsIDApOwogCQkodm9pZCkg
aWRlZmxvcHB5X3F1ZXVlX3BjX3RhaWwgKGRyaXZlLCAmcGMpOworICAgIH0KIAkJaWRlZmxv
cHB5X2NyZWF0ZV9zdGFydF9zdG9wX2NtZCAoJnBjLCAyKTsKIAkJKHZvaWQpIGlkZWZsb3Bw
eV9xdWV1ZV9wY190YWlsIChkcml2ZSwgJnBjKTsKIAkJcmV0dXJuIDA7CkBAIC0xMzIwLDIw
ICsxMzM4LDI0IEBACiAJaWRlZmxvcHB5X2Zsb3BweV90ICpmbG9wcHkgPSBkcml2ZS0+ZHJp
dmVyX2RhdGE7CiAJaWRlZmxvcHB5X3BjX3QgcGM7CiAJCi0jaWYgSURFRkxPUFBZX0RFQlVH
X0xPRwotCXByaW50ayAoS0VSTl9JTkZPICJSZWFjaGVkIGlkZWZsb3BweV9vcGVuXG4iKTsK
LSNlbmRpZiAvKiBJREVGTE9QUFlfREVCVUdfTE9HICovCisgIElERUZMT1BQWV9ERUJVRygg
IlJlYWNoZWQgaWRlZmxvcHB5X29wZW5cbiIpOwogCiAJTU9EX0lOQ19VU0VfQ09VTlQ7CiAJ
aWYgKGRyaXZlLT51c2FnZSA9PSAxKSB7CisgICAgSURFRkxPUFBZX0RFQlVHKCAiVGVzdGlu
ZyBpZiB1bml0IGlzIHJlYWR5Li4uXG4iKTsKIAkJaWRlZmxvcHB5X2NyZWF0ZV90ZXN0X3Vu
aXRfcmVhZHlfY21kKCZwYyk7CiAJCWlmIChpZGVmbG9wcHlfcXVldWVfcGNfdGFpbChkcml2
ZSwgJnBjKSkgeworICAgICAgSURFRkxPUFBZX0RFQlVHKCAiTm90IHJlYWR5LCBpc3N1aW5n
IHN0YXJ0IGNvbW1hbmRcbiIpOwogCQkJaWRlZmxvcHB5X2NyZWF0ZV9zdGFydF9zdG9wX2Nt
ZCAoJnBjLCAxKTsKIAkJCSh2b2lkKSBpZGVmbG9wcHlfcXVldWVfcGNfdGFpbCAoZHJpdmUs
ICZwYyk7CisgICAgfSBlbHNlCisgICAgeyAKKwkgICAgSURFRkxPUFBZX0RFQlVHKCAiWWVz
IHVuaXQgaXMgcmVhZHlcbiIpOwogCQl9CiAJCWlmIChpZGVmbG9wcHlfZ2V0X2NhcGFjaXR5
IChkcml2ZSkpIHsKIAkJCWRyaXZlLT51c2FnZS0tOwogCQkJTU9EX0RFQ19VU0VfQ09VTlQ7
CisgICAgICBJREVGTE9QUFlfREVCVUcoICJJL08gRXJyb3IgR2V0dGluZyBDYXBhY2l0eVxu
Iik7CiAJCQlyZXR1cm4gLUVJTzsKIAkJfQogCQlpZiAoZmxvcHB5LT53cCAmJiAoZmlscC0+
Zl9tb2RlICYgMikpIHsKQEAgLTEzNDIsOCArMTM2NCwxMSBAQAogCQkJcmV0dXJuIC1FUk9G
UzsKIAkJfQkJCiAJCXNldF9iaXQgKElERUZMT1BQWV9NRURJQV9DSEFOR0VELCAmZmxvcHB5
LT5mbGFncyk7CisgICAgLyogSU9NRUdBIENsaWshIGRyaXZlcyBkbyBub3Qgc3VwcG9ydCBs
b2NrL3VubG9jayBjb21tYW5kcyAtIG5vIHJvb20gZm9yIG1lY2hhbmlzbSAqLworCQlpZiAo
IXRlc3RfYml0KElERUZMT1BQWV9DTElLX0RSSVZFLCAmZmxvcHB5LT5mbGFncykpIHsKIAkJ
aWRlZmxvcHB5X2NyZWF0ZV9wcmV2ZW50X2NtZCAoJnBjLCAxKTsKIAkJKHZvaWQpIGlkZWZs
b3BweV9xdWV1ZV9wY190YWlsIChkcml2ZSwgJnBjKTsKKyAgICB9CiAJCWNoZWNrX2Rpc2tf
Y2hhbmdlKGlub2RlLT5pX3JkZXYpOwogCX0KIAlyZXR1cm4gMDsKQEAgLTEzNTIsMTYgKzEz
NzcsMTggQEAKIHN0YXRpYyB2b2lkIGlkZWZsb3BweV9yZWxlYXNlIChzdHJ1Y3QgaW5vZGUg
Kmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlscCwgaWRlX2RyaXZlX3QgKmRyaXZlKQogewogCWlk
ZWZsb3BweV9wY190IHBjOworICBpZGVmbG9wcHlfZmxvcHB5X3QgKmZsb3BweSA9IGRyaXZl
LT5kcml2ZXJfZGF0YTsKIAkKLSNpZiBJREVGTE9QUFlfREVCVUdfTE9HCi0JcHJpbnRrIChL
RVJOX0lORk8gIlJlYWNoZWQgaWRlZmxvcHB5X3JlbGVhc2VcbiIpOwotI2VuZGlmIC8qIElE
RUZMT1BQWV9ERUJVR19MT0cgKi8KKyAgSURFRkxPUFBZX0RFQlVHKCAiUmVhY2hlZCBpZGVm
bG9wcHlfcmVsZWFzZVxuIik7CiAKIAlpZiAoIWRyaXZlLT51c2FnZSkgewogCQlpbnZhbGlk
YXRlX2J1ZmZlcnMgKGlub2RlLT5pX3JkZXYpOworICAgIC8qIElPTUVHQSBDbGlrISBkcml2
ZXMgZG8gbm90IHN1cHBvcnQgbG9jay91bmxvY2sgY29tbWFuZHMgKi8KKwkJaWYgKCF0ZXN0
X2JpdChJREVGTE9QUFlfQ0xJS19EUklWRSwgJmZsb3BweS0+ZmxhZ3MpKSB7CiAJCWlkZWZs
b3BweV9jcmVhdGVfcHJldmVudF9jbWQgKCZwYywgMCk7CiAJCSh2b2lkKSBpZGVmbG9wcHlf
cXVldWVfcGNfdGFpbCAoZHJpdmUsICZwYyk7CiAJfQorICB9CiAJTU9EX0RFQ19VU0VfQ09V
TlQ7CiB9CiAKQEAgLTE1NTksNiArMTU4NiwxNyBAQAogCQlmb3IgKGkgPSAwOyBpIDwgMSA8
PCBQQVJUTl9CSVRTOyBpKyspCiAJCQltYXhfc2VjdG9yc1ttYWpvcl1bbWlub3IgKyBpXSA9
IDY0OwogCX0KKyAgLyoKKyAgICogICAgICBHdWVzcyB3aGF0PyAgVGhlIElPTUVHQSBDbGlr
ISBkcml2ZSBhbHNvIG5lZWRzIHRoZQorICAgKiAgICAgIGFib3ZlIGZpeC4gIEl0IG1ha2Vz
IG5hc3R5IGNsaWNraW5nIG5vaXNlcyB3aXRob3V0CisgICAqICAgICAgaXQsIHNvIHBsZWFz
ZSBkb24ndCByZW1vdmUgdGhpcy4KKyAgICovCisgIGlmIChzdHJjbXAoZHJpdmUtPmlkLT5t
b2RlbCwgIklPTUVHQSBDbGlrISA0MCBDWiBBVEFQSSIpID09IDApCisgIHsKKyAgICBmb3Ig
KGkgPSAwOyBpIDwgMSA8PCBQQVJUTl9CSVRTOyBpKyspCisgICAgICBtYXhfc2VjdG9yc1tt
YWpvcl1bbWlub3IgKyBpXSA9IDY0OworICAgIHNldF9iaXQoSURFRkxPUFBZX0NMSUtfRFJJ
VkUsICZmbG9wcHktPmZsYWdzKTsKKyAgfQogCiAJKHZvaWQpIGlkZWZsb3BweV9nZXRfY2Fw
YWNpdHkgKGRyaXZlKTsKIAlpZGVmbG9wcHlfYWRkX3NldHRpbmdzKGRyaXZlKTsKQEAgLTE1
OTcsNiArMTYzNSw3IEBACiAKICNlbmRpZgkvKiBDT05GSUdfUFJPQ19GUyAqLwogCisKIC8q
CiAgKglJREUgc3ViZHJpdmVyIGZ1bmN0aW9ucywgcmVnaXN0ZXJlZCB3aXRoIGlkZS5jCiAg
Ki8KQEAgLTE2MjksNiArMTY2OCw3IEBACiAJTlVMTAogfTsKIAorCiAvKgogICoJaWRlZmxv
cHB5X2luaXQgd2lsbCByZWdpc3RlciB0aGUgZHJpdmVyIGZvciBlYWNoIGZsb3BweS4KICAq
LwpAQCAtMTY2NSwxMiArMTcwNSwxNiBAQAogCXJldHVybiAwOwogfQogCisKICNpZmRlZiBN
T0RVTEUKKy8qIEluaXRpYWxpc2F0aW9uIGNvZGUgZm9yIGxvYWRpbmcgdGhlIGRyaXZlciBh
cyBhIG1vZHVsZXMgKi8KIGludCBpbml0X21vZHVsZSAodm9pZCkKIHsKIAlyZXR1cm4gaWRl
ZmxvcHB5X2luaXQgKCk7CiB9CiAKKworLyogQ2xlYW51cCBjb2RlIGZvciByZW1vdmluZyB0
aGUgZHJpdmVyIG1vZHVsZSAqLwogdm9pZCBjbGVhbnVwX21vZHVsZSAodm9pZCkKIHsKIAlp
ZGVfZHJpdmVfdCAqZHJpdmU7Cg==
--------------19769A3701474D7777CE5645--

