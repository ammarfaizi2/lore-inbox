Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129692AbRANW7y>; Sun, 14 Jan 2001 17:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129664AbRANW7o>; Sun, 14 Jan 2001 17:59:44 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:42695 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S129523AbRANW71>; Sun, 14 Jan 2001 17:59:27 -0500
Message-ID: <3A62300E.91BE1D06@paulbristow.net>
Date: Mon, 15 Jan 2001 00:02:38 +0100
From: Paul Bristow <paul@paulbristow.net>
Organization: http://paulbristow.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] ide-floppy in 2.4.0 catches up to 2.2.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This patch is to bring the device support in the ide-floppy driver up to
the same as that in the 2.2.18 kernel.  

Specifically, it adds IOMEGA Clik! drive and Apple Powerbook internal
Zip support.  Starts to tidy up the code using macros for debug and
corrects the use of flags in set_bit functions so the driver should work
correctly on 64 bit architectures.

It should apply cleanly to the release 2.4.0.

The ATAPI format patch as in 2.4.0-ac4 will be in driver 0.97 in about
30 seconds.

This patch has been tested by many people.

Regards,

Paul Bristow

Linux IDE-Floppy Maintainer

http://paulbristow.net/linux/idefloppy.html

Patch follows:

--- linux-2.4.0/drivers/ide/ide-floppy.c        Sun Jan 14 23:44:42 2001
+++ linux/drivers/ide/ide-floppy.c      Sun Jan 14 23:46:56 2001
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
  * Many thanks to Lode Leroy <Lode.Leroy@www.ibase.be>, who tested so
many
  * ALPHA patches to this driver on an EASYSTOR LS-120 ATAPI floppy
drive.
  *
@@ -29,9 +36,20 @@
  * Ver 0.9   Jul  4 99   Fix a bug which might have caused the number
of
  *                        bytes requested on each interrupt to be zero.
  *                        Thanks to <shanos@es.co.nz> for pointing this
out.
+ * Ver 0.91  Dec 11 99   Added IOMEGA Clik! drive support by 
+ *           <paul@paulbristow.net>
+ * Ver 0.92  Oct 22 00   Paul Bristow became official maintainer for
this 
+ *           driver.  Included Powerbook internal zip kludge.
+ * Ver 0.93  Oct 24 00   Fixed bugs for Clik! drive
+ *                                             no disk on insert and
disk change now works
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
@@ -59,9 +78,10 @@
 /*
  *     The following are used to debug the driver.
  */
-#define IDEFLOPPY_DEBUG_LOG            0
 #define IDEFLOPPY_DEBUG_INFO           0
 #define IDEFLOPPY_DEBUG_BUGS           1
+/* #define IDEFLOPPY_DEBUG(fmt, args...) printk(KERN_INFO fmt, ## args)
*/
+#define IDEFLOPPY_DEBUG( fmt, args... )
 
 /*
  *     Some drives require a longer irq timeout.
@@ -104,7 +124,7 @@
        byte *current_position;                 /* Pointer into the
above buffer */
        void (*callback) (ide_drive_t *);       /* Called when this
packet command is completed */
        byte pc_buffer[IDEFLOPPY_PC_BUFFER_SIZE];       /* Temporary
buffer */
-       unsigned long flags;                    /* Status/Action bit
flags: long for set_bit */
+       unsigned long flags;                    /* Status/Action bit
flags : long for set_bit() */
 } idefloppy_pc_t;
 
 /*
@@ -237,7 +258,7 @@
        idefloppy_flexible_disk_page_t flexible_disk_page;      /* Copy
of the flexible disk page */
        int wp;                                                 /* Write
protect */
 
-       unsigned int flags;                     /* Status/Action flags
*/
+       unsigned long flags;                    /* Status/Action flags :
long for set_bit() */
 } idefloppy_floppy_t;
 
 /*
@@ -246,6 +267,8 @@
 #define IDEFLOPPY_DRQ_INTERRUPT                0       /* DRQ interrupt
device */
 #define IDEFLOPPY_MEDIA_CHANGED                1       /* Media may
have changed */
 #define IDEFLOPPY_USE_READ12           2       /* Use READ12/WRITE12 or
READ10/WRITE10 */
+#define IDEFLOPPY_CLIK_DRIVE      3       /* Avoid commands not
supported in Clik drive */
+#define IDEFLOPPY_POWERBOOK_ZIP   4       /* Kludge for Apple Powerbook
Zip drive */
 
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
 
        floppy->sense_key = result->sense_key; floppy->asc =
result->asc; floppy->ascq = result->ascq;
-#if IDEFLOPPY_DEBUG_LOG
-       if (floppy->failed_pc)
-               printk (KERN_INFO "ide-floppy: pc = %x, sense key = %x,
asc = %x, ascq =
%x\n",floppy->failed_pc->c[0],result->sense_key,result->asc,result->ascq);
-       else
-               printk (KERN_INFO "ide-floppy: sense key = %x, asc = %x,
ascq = %x\n",result->sense_key,result->asc,result->ascq);
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  if (floppy->failed_pc) {
+    IDEFLOPPY_DEBUG("ide-floppy: pc = %x, sense key = %x, asc = %x,
ascq =
%x\n",floppy->failed_pc->c[0],result->sense_key,result->asc,result->ascq);
+  }
+  else {
+    IDEFLOPPY_DEBUG("ide-floppy: sense key = %x, asc = %x, ascq =
%x\n",result->sense_key,result->asc,result->ascq);
+  }
 }
 
 static void idefloppy_request_sense_callback (ide_drive_t *drive)
 {
        idefloppy_floppy_t *floppy = drive->driver_data;
 
-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "ide-floppy: Reached
idefloppy_request_sense_callback\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "ide-floppy: Reached
idefloppy_request_sense_callback\n");
        if (!floppy->pc->error) {
                idefloppy_analyze_error
(drive,(idefloppy_request_sense_result_t *) floppy->pc->buffer);
                idefloppy_end_request (1,HWGROUP (drive));
@@ -777,9 +796,7 @@
 {
        idefloppy_floppy_t *floppy = drive->driver_data;
        
-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "ide-floppy: Reached
idefloppy_pc_callback\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "ide-floppy: Reached idefloppy_pc_callback\n");
 
        idefloppy_end_request (floppy->pc->error ? 0:1, HWGROUP(drive));
 }
@@ -840,9 +857,7 @@
        struct request *rq = pc->rq;
        unsigned int temp;
 
-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "ide-floppy: Reached idefloppy_pc_intr
interrupt handler\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */       
+  IDEFLOPPY_DEBUG( "ide-floppy: Reached idefloppy_pc_intr interrupt
handler\n");
 
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
 
        status.all = GET_STAT();                                       
/* Clear the interrupt */
 
        if (!status.b.drq) {                                           
/* No more interrupts */
-#if IDEFLOPPY_DEBUG_LOG
-               printk (KERN_INFO "Packet command completed, %d bytes
transferred\n", pc->actually_transferred);
-#endif /* IDEFLOPPY_DEBUG_LOG */
+    IDEFLOPPY_DEBUG( "Packet command completed, %d bytes
transferred\n", pc->actually_transferred);
                clear_bit (PC_DMA_IN_PROGRESS, &pc->flags);
 
                ide__sti();     /* local CPU only */
 
                if (status.b.check || test_bit (PC_DMA_ERROR,
&pc->flags)) {    /* Error detected */
-#if IDEFLOPPY_DEBUG_LOG
-                       printk (KERN_INFO "ide-floppy: %s: I/O
error\n",drive->name);
-#endif /* IDEFLOPPY_DEBUG_LOG */
+      IDEFLOPPY_DEBUG( "ide-floppy: %s: I/O error\n",drive->name);
                        rq->errors++;
                        if (pc->c[0] == IDEFLOPPY_REQUEST_SENSE_CMD) {
                                printk (KERN_ERR "ide-floppy: I/O error
in request sense command\n");
@@ -915,9 +924,7 @@
                                ide_set_handler
(drive,&idefloppy_pc_intr,IDEFLOPPY_WAIT_CMD, NULL);
                                return ide_started;
                        }
-#if IDEFLOPPY_DEBUG_LOG
-                       printk (KERN_NOTICE "ide-floppy: The floppy
wants to send us more data than expected - allowing transfer\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */
+      IDEFLOPPY_DEBUG( "ide-floppy: The floppy wants to send us more
data than expected - allowing transfer\n");
                }
        }
        if (test_bit (PC_WRITING, &pc->flags)) {
@@ -983,7 +990,7 @@
                 *      a legitimate error code was received.
                 */
                if (!test_bit (PC_ABORT, &pc->flags)) {
-                       printk (KERN_ERR "ide-floppy: %s: I/O error, pc
= %2x, key = %2x, asc = %2x, ascq = %2x\n",
+      IDEFLOPPY_DEBUG( "ide-floppy: %s: I/O error, pc = %2x, key = %2x,
asc = %2x, ascq = %2x\n",
                                drive->name, pc->c[0],
floppy->sense_key, floppy->asc, floppy->ascq);
                        pc->error = IDEFLOPPY_ERROR_GENERAL;           
/* Giving up */
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
        pc->actually_transferred=0;                                    
/* We haven't transferred any data yet */
@@ -1034,9 +1039,7 @@
 
 static void idefloppy_rw_callback (ide_drive_t *drive)
 {
-#if IDEFLOPPY_DEBUG_LOG        
-       printk (KERN_INFO "ide-floppy: Reached
idefloppy_rw_callback\n");
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "ide-floppy: Reached idefloppy_rw_callback\n");
 
        idefloppy_end_request(1, HWGROUP(drive));
        return;
@@ -1044,9 +1047,7 @@
 
 static void idefloppy_create_prevent_cmd (idefloppy_pc_t *pc, int
prevent)
 {
-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "ide-floppy: creating prevent removal command,
prevent = %d\n", prevent);
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "ide-floppy: creating prevent removal command,
prevent = %d\n", prevent);
 
        idefloppy_init_pc (pc);
        pc->c[0] = IDEFLOPPY_PREVENT_REMOVAL_CMD;
@@ -1106,10 +1107,8 @@
        int block = sector / floppy->bs_factor;
        int blocks = rq->nr_sectors / floppy->bs_factor;
        
-#if IDEFLOPPY_DEBUG_LOG
-       printk ("create_rw1%d_cmd: block == %d, blocks == %d\n",
+  IDEFLOPPY_DEBUG( "create_rw1%d_cmd: block == %d, blocks == %d\n",
                2 * test_bit (IDEFLOPPY_USE_READ12, &floppy->flags),
block, blocks);
-#endif /* IDEFLOPPY_DEBUG_LOG */
 
        idefloppy_init_pc (pc);
        if (test_bit (IDEFLOPPY_USE_READ12, &floppy->flags)) {
@@ -1139,10 +1138,8 @@
        idefloppy_floppy_t *floppy = drive->driver_data;
        idefloppy_pc_t *pc;
 
-#if IDEFLOPPY_DEBUG_LOG
-       printk (KERN_INFO "rq_status: %d, rq_dev: %u, cmd: %d, errors:
%d\n",rq->rq_status,(unsigned int) rq->rq_dev,rq->cmd,rq->errors);
-       printk (KERN_INFO "sector: %ld, nr_sectors: %ld,
current_nr_sectors:
%ld\n",rq->sector,rq->nr_sectors,rq->current_nr_sectors);
-#endif /* IDEFLOPPY_DEBUG_LOG */
+  IDEFLOPPY_DEBUG( "rq_status: %d, rq_dev: %u, cmd: %d, errors:
%d\n",rq->rq_status,(unsigned int) rq->rq_dev,rq->cmd,rq->errors);
+  IDEFLOPPY_DEBUG( "sector: %ld, nr_sectors: %ld, current_nr_sectors:
%ld\n",rq->sector,rq->nr_sectors,rq->current_nr_sectors);
 
        if (rq->errors >= ERROR_MAX) {
                if (floppy->failed_pc != NULL)
@@ -1263,15 +1261,17 @@
        for (i = 0; i < descriptors; i++, descriptor++) {
                blocks = descriptor->blocks = ntohl
(descriptor->blocks);
                length = descriptor->length = ntohs
(descriptor->length);
-               if (!i && descriptor->dc == CAPACITY_CURRENT) {
-                       if (memcmp (descriptor, &floppy->capacity,
sizeof (idefloppy_capacity_descriptor_t))) {
-                               printk (KERN_INFO "%s: %dkB, %d blocks,
%d sector size, %s \n",
-                                       drive->name, blocks * length /
1024, blocks, length,
-                                       drive->using_dma ? ", DMA":"");
-                       }
+    if (!i) {
+       switch (descriptor->dc) {
+               case CAPACITY_UNFORMATTED: /* Clik! drive returns this
instead of CAPACITY_CURRENT */
+                       if (!test_bit(IDEFLOPPY_CLIK_DRIVE,
&floppy->flags)) 
+                               break; /* If it is not a clik drive,
break out (maintains previous driver behaviour) */
+               case CAPACITY_CURRENT: /* Normal Zip/LS-120 disks */
+                       if (memcmp (descriptor, &floppy->capacity,
sizeof (idefloppy_capacity_descriptor_t)))
+                               printk (KERN_INFO "%s: %dkB, %d blocks,
%d sector size\n", drive->name, blocks * length / 1024, blocks, length);
                        floppy->capacity = *descriptor;
                        if (!length || length % 512)
-                               printk (KERN_ERR "%s: %d bytes block
size not supported\n", drive->name, length);
+                               printk (KERN_NOTICE "%s: %d bytes block
size not supported\n", drive->name, length);            
                        else {
                                floppy->blocks = blocks;
                                floppy->block_size = length;
@@ -1279,13 +1279,26 @@
                                        printk (KERN_NOTICE "%s:
warning: non 512 bytes block size not fully supported\n", drive->name);
                                rc = 0;
                        }
+                       break;
+               case CAPACITY_NO_CARTRIDGE: 
+                       /* This is a KERN_ERR so it appears on screen
for the user to see */
+                       printk (KERN_ERR "%s: No disk in drive\n",
drive->name);
+                                       break;    
+               case CAPACITY_INVALID: 
+                       printk (KERN_ERR "%s: Invalid capacity for disk
in drive\n", drive->name);
+                                       break;    
+               }
                }
-#if IDEFLOPPY_DEBUG_INFO
-               if (!i) printk (KERN_INFO "Descriptor 0 Code: %d\n",
descriptor->dc);
-               printk (KERN_INFO "Descriptor %d: %dkB, %d blocks, %d
sector size\n", i, blocks * length / 1024, blocks, length);
-#endif /* IDEFLOPPY_DEBUG_INFO */
+    if (!i) {
+       IDEFLOPPY_DEBUG( "Descriptor 0 Code: %d\n", descriptor->dc);
        }
+    IDEFLOPPY_DEBUG( "Descriptor %d: %dkB, %d blocks, %d sector
size\n", i, blocks * length / 1024, blocks, length);
+  }
+  
+  /* Clik! disk does not support get_flexible_disk_page */
+       if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) 
        (void) idefloppy_get_flexible_disk_page (drive);
+
        drive->part[0].nr_sects = floppy->blocks * floppy->bs_factor;
        return rc;
 }
@@ -1293,18 +1307,22 @@
 /*
  *     Our special ide-floppy ioctl's.
  *
- *     Currently there aren't any ioctl's.
+ *      Supports eject command 
  */
 static int idefloppy_ioctl (ide_drive_t *drive, struct inode *inode,
struct file *file,
                                 unsigned int cmd, unsigned long arg)
 {
        idefloppy_pc_t pc;
+  idefloppy_floppy_t *floppy = drive->driver_data;
 
        if (cmd == CDROMEJECT) {
                if (drive->usage > 1)
                        return -EBUSY;
+    /* The IOMEGA Clik! Drive doesn't support this command - no room
for an eject mechanism */
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
+    /* IOMEGA Clik! drives do not support lock/unlock commands - no
room for mechanism */
+               if (!test_bit(IDEFLOPPY_CLIK_DRIVE, &floppy->flags)) {
                idefloppy_create_prevent_cmd (&pc, 1);
                (void) idefloppy_queue_pc_tail (drive, &pc);
+    }
                check_disk_change(inode->i_rdev);
        }
        return 0;
@@ -1352,16 +1377,18 @@
 static void idefloppy_release (struct inode *inode, struct file *filp,
ide_drive_t *drive)
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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
