Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314318AbSEBJpq>; Thu, 2 May 2002 05:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314321AbSEBJpp>; Thu, 2 May 2002 05:45:45 -0400
Received: from [195.63.194.11] ([195.63.194.11]:38921 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314318AbSEBJpj>; Thu, 2 May 2002 05:45:39 -0400
Message-ID: <3CD0FC0E.5020108@evision-ventures.com>
Date: Thu, 02 May 2002 10:42:54 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.7
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060408050607000906060107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060408050607000906060107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Non IDE series:

- Fix some "header magic" related to IDE code in blk.h.

- Fix blk_clear to remove knowlenge about blk_dev[] about the device from the
   kernel as well.

- Fix mtd read only block device.

- Remove LOCAL_END_REQUEST alltogether from the places where it was "used".

--------------060408050607000906060107
Content-Type: text/plain;
 name="blkdev-2.5.12.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="blkdev-2.5.12.diff"

diff -ur linux-2.5.12/drivers/block/cpqarray.c linux/drivers/block/cpqarray.c
--- linux-2.5.12/drivers/block/cpqarray.c	2002-05-01 02:08:48.000000000 +0200
+++ linux/drivers/block/cpqarray.c	2002-05-02 03:32:42.000000000 +0200
@@ -52,7 +52,6 @@
 MODULE_LICENSE("GPL");
 
 #define MAJOR_NR COMPAQ_SMART2_MAJOR
-#define LOCAL_END_REQUEST
 #include <linux/blk.h>
 #include <linux/blkdev.h>
 #include <linux/genhd.h>
diff -ur linux-2.5.12/drivers/block/floppy.c linux/drivers/block/floppy.c
--- linux-2.5.12/drivers/block/floppy.c	2002-05-01 02:08:48.000000000 +0200
+++ linux/drivers/block/floppy.c	2002-05-02 03:31:23.000000000 +0200
@@ -230,9 +230,7 @@
 
 static int irqdma_allocated;
 
-#define LOCAL_END_REQUEST
 #define MAJOR_NR FLOPPY_MAJOR
-
 #include <linux/blk.h>
 #include <linux/blkpg.h>
 #include <linux/cdrom.h> /* for the compatibility eject ioctl */
@@ -2275,7 +2273,7 @@
  * =============================
  */
 
-static inline void end_request(struct request *req, int uptodate)
+static inline void fd_end_request(struct request *req, int uptodate)
 {
 	kdev_t dev = req->rq_dev;
 
@@ -2320,7 +2318,7 @@
 			current_count_sectors -= req->current_nr_sectors;
 			req->nr_sectors -= req->current_nr_sectors;
 			req->sector += req->current_nr_sectors;
-			end_request(req, 1);
+			fd_end_request(req, 1);
 		}
 		spin_unlock_irqrestore(q->queue_lock, flags);
 
@@ -2348,7 +2346,7 @@
 			DRWE->last_error_generation = DRS->generation;
 		}
 		spin_lock_irqsave(q->queue_lock, flags);
-		end_request(req, 0);
+		fd_end_request(req, 0);
 		spin_unlock_irqrestore(q->queue_lock, flags);
 	}
 }
diff -ur linux-2.5.12/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.12/drivers/ide/ide.c	2002-05-01 02:08:56.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-02 03:20:40.000000000 +0200
@@ -135,13 +135,14 @@
 #endif
 #include <linux/pci.h>
 #include <linux/delay.h>
-#include <linux/ide.h>
+#include <linux/blk.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/completion.h>
 #include <linux/reboot.h>
 #include <linux/cdrom.h>
 #include <linux/device.h>
 #include <linux/kmod.h>
+#include <linux/ide.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -1781,7 +1780,7 @@
 	for (h = 0; h < MAX_HWIFS; ++h) {
 		struct ata_channel *ch = &ide_hwifs[h];
 		if (ch->present && major == ch->major) {
-			int unit = DEVICE_NR(i_rdev);
+			int unit = minor(i_rdev) >> PARTN_BITS;
 			if (unit < MAX_DRIVES) {
 				struct ata_device *drive = &ch->drives[unit];
 				if (drive->present)
@@ -2201,8 +2187,6 @@
 	 */
 	unregister_blkdev(ch->major, ch->name);
 	kfree(blksize_size[ch->major]);
-	blk_dev[ch->major].data = NULL;
-	blk_dev[ch->major].queue = NULL;
 	blk_clear(ch->major);
 	gd = ch->gd;
 	if (gd) {
diff -ur linux-2.5.12/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.12/drivers/ide/ide-cd.c	2002-05-01 02:08:56.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-05-02 03:22:13.000000000 +0200
@@ -304,9 +304,10 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/errno.h>
+#include <linux/blk.h>
 #include <linux/cdrom.h>
-#include <linux/ide.h>
 #include <linux/completion.h>
+#include <linux/ide.h>
 
 #include <asm/irq.h>
 #include <asm/io.h>
diff -ur linux-2.5.12/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.12/drivers/ide/ide-probe.c	2002-05-01 02:08:44.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2002-05-02 03:15:06.000000000 +0200
@@ -840,7 +840,7 @@
 	struct ata_channel *ch = (struct ata_channel *)blk_dev[major(dev)].data;
 
 	/* FIXME: ALLERT: This discriminates between master and slave! */
-	return &ch->drives[DEVICE_NR(dev) & 1].queue;
+	return &ch->drives[(minor(dev) >> PARTN_BITS) & 1].queue;
 }
 
 static void channel_init(struct ata_channel *ch)
diff -ur linux-2.5.12/drivers/md/lvm.c linux/drivers/md/lvm.c
--- linux-2.5.12/drivers/md/lvm.c	2002-05-01 02:08:46.000000000 +0200
+++ linux/drivers/md/lvm.c	2002-05-02 03:55:34.000000000 +0200
@@ -192,7 +192,6 @@
 
 #define MAJOR_NR LVM_BLK_MAJOR
 #define DEVICE_OFF(device)
-#define LOCAL_END_REQUEST
 
 /* lvm_do_lv_create calls fsync_dev_lockfs()/unlockfs() */
 /* #define	LVM_VFS_ENHANCEMENT */
diff -ur linux-2.5.12/drivers/md/md.c linux/drivers/md/md.c
--- linux-2.5.12/drivers/md/md.c	2002-05-01 02:08:51.000000000 +0200
+++ linux/drivers/md/md.c	2002-05-02 02:55:39.000000000 +0200
@@ -4004,9 +4004,8 @@
 #endif
 
 	del_gendisk(&md_gendisk);
-	blk_dev[MAJOR_NR].queue = NULL;
 	blk_clear(MAJOR_NR);
-	
+
 	free_device_names();
 }
 #endif
diff -ur linux-2.5.12/drivers/mtd/mtdblock.c linux/drivers/mtd/mtdblock.c
--- linux-2.5.12/drivers/mtd/mtdblock.c	2002-05-01 02:08:55.000000000 +0200
+++ linux/drivers/mtd/mtdblock.c	2002-05-02 03:57:14.000000000 +0200
@@ -23,11 +23,7 @@
 #ifndef QUEUE_EMPTY
 #define QUEUE_EMPTY  (!CURRENT)
 #endif
-#if LINUX_VERSION_CODE < 0x20300
-#define QUEUE_PLUGGED (blk_dev[MAJOR_NR].plug_tq.sync)
-#else
 #define QUEUE_PLUGGED (blk_queue_plugged(QUEUE))
-#endif
 
 #ifdef CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>
diff -ur linux-2.5.12/drivers/mtd/mtdblock_ro.c linux/drivers/mtd/mtdblock_ro.c
--- linux-2.5.12/drivers/mtd/mtdblock_ro.c	2002-05-01 02:08:57.000000000 +0200
+++ linux/drivers/mtd/mtdblock_ro.c	2002-05-02 04:09:00.000000000 +0200
@@ -7,7 +7,7 @@
 
 #ifdef MTDBLOCK_DEBUG
 #define DEBUGLVL debug
-#endif							       
+#endif
 
 
 #include <linux/module.h>
@@ -16,7 +16,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/compatmac.h>
 
-#define LOCAL_END_REQUEST
 #define MAJOR_NR MTD_BLOCK_MAJOR
 #define DEVICE_NAME "mtdblock"
 #define DEVICE_NR(device) (device)
@@ -34,6 +33,7 @@
 MODULE_PARM(debug, "i");
 #endif
 
+static spinlock_t mtdro_lock;
 
 static int mtd_sizes[MAX_MTD_DEVICES];
 
@@ -106,7 +106,7 @@
 
 static void mtdblock_request(RQFUNC_ARG)
 {
-   struct request *current_request;
+   struct request *req;
    unsigned int res = 0;
    struct mtd_info *mtd;
 
@@ -115,50 +115,48 @@
       /* Grab the Request and unlink it from the request list, INIT_REQUEST
        	 will execute a return if we are done. */
       INIT_REQUEST;
-      current_request = CURRENT;
+      req = CURRENT;
    
-      if (minor(current_request->rq_dev) >= MAX_MTD_DEVICES)
+      if (minor(req->rq_dev) >= MAX_MTD_DEVICES)
       {
 	 printk("mtd: Unsupported device!\n");
-	 mtdblock_end_request(current_request, 0);
+	 mtdblock_end_request(req, 0);
 	 continue;
       }
       
       // Grab our MTD structure
 
-      mtd = __get_mtd_device(NULL, minor(current_request->rq_dev));
+      mtd = __get_mtd_device(NULL, minor(req->rq_dev));
       if (!mtd) {
 	      printk("MTD device %d doesn't appear to exist any more\n", CURRENT_DEV);
-	      mtdblock_end_request(current_request, 0);
+	      mtdblock_end_request(req, 0);
       }
 
-      if (current_request->sector << 9 > mtd->size ||
-	  (current_request->sector + current_request->nr_sectors) << 9 > mtd->size)
+      if (req->sector << 9 > mtd->size ||
+	  (req->sector + req->nr_sectors) << 9 > mtd->size)
       {
 	 printk("mtd: Attempt to read past end of device!\n");
-	 printk("size: %x, sector: %lx, nr_sectors %lx\n", mtd->size, current_request->sector, current_request->nr_sectors);
-	 mtdblock_end_request(current_request, 0);
+	 printk("size: %x, sector: %lx, nr_sectors %lx\n", mtd->size, req->sector, req->nr_sectors);
+	 mtdblock_end_request(req, 0);
 	 continue;
       }
       
       /* Remove the request we are handling from the request list so nobody messes
          with it */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
       /* Now drop the lock that the ll_rw_blk functions grabbed for us
          and process the request. This is necessary due to the extreme time
          we spend processing it. */
-      spin_unlock_irq(&io_request_lock);
-#endif
+      spin_unlock_irq(&mtdro_lock);
 
       // Handle the request
-      switch (current_request->cmd)
+      switch (rq_data_dir(req))
       {
          size_t retlen;
 
 	 case READ:
-	 if (MTD_READ(mtd,current_request->sector<<9, 
-		      current_request->nr_sectors << 9, 
-		      &retlen, current_request->buffer) == 0)
+	 if (MTD_READ(mtd,req->sector<<9, 
+		      req->nr_sectors << 9, 
+		      &retlen, req->buffer) == 0)
 	    res = 1;
 	 else
 	    res = 0;
@@ -166,8 +164,8 @@
 	 
 	 case WRITE:
 
-	 /* printk("mtdblock_request WRITE sector=%d(%d)\n",current_request->sector,
-		current_request->nr_sectors);
+	 /* printk("mtdblock_request WRITE sector=%d(%d)\n",req->sector,
+		req->nr_sectors);
 	 */
 
 	 // Read only device
@@ -178,9 +176,9 @@
 	 }
 
 	 // Do the write
-	 if (MTD_WRITE(mtd,current_request->sector<<9, 
-		       current_request->nr_sectors << 9, 
-		       &retlen, current_request->buffer) == 0)
+	 if (MTD_WRITE(mtd,req->sector<<9, 
+		       req->nr_sectors << 9, 
+		       &retlen, req->buffer) == 0)
 	    res = 1;
 	 else
 	    res = 0;
@@ -193,10 +191,8 @@
       }
 
       // Grab the lock and re-thread the item onto the linked list
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
-	spin_lock_irq(&io_request_lock);
-#endif
-	mtdblock_end_request(current_request, res);
+	spin_lock_irq(&mtdro_lock);
+	mtdblock_end_request(req, res);
    }
 }
 
@@ -255,6 +251,7 @@
 {
 	int i;
 
+	spin_lock_init(&mtdro_lock);
 	if (register_blkdev(MAJOR_NR,DEVICE_NAME,&mtd_fops)) {
 		printk(KERN_NOTICE "Can't allocate major number %d for Memory Technology Devices.\n",
 		       MTD_BLOCK_MAJOR);
@@ -270,7 +267,7 @@
 	blksize_size[MAJOR_NR] = NULL;
 	blk_size[MAJOR_NR] = mtd_sizes;
 	
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &mtdblock_request);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &mtdblock_request, &mtdro_lock);
 	return 0;
 }
 
diff -ur linux-2.5.12/drivers/s390/block/dasd_int.h linux/drivers/s390/block/dasd_int.h
--- linux-2.5.12/drivers/s390/block/dasd_int.h	2002-05-01 02:09:00.000000000 +0200
+++ linux/drivers/s390/block/dasd_int.h	2002-05-02 02:46:23.000000000 +0200
@@ -61,47 +61,6 @@
 #include <asm/todclk.h>
 #include <asm/debug.h>
 
-/* Kernel Version Compatibility section */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,98))
-typedef struct request *request_queue_t;
-#define block_device_operations file_operations
-#define __setup(x,y) struct dasd_device_t
-#define devfs_register_blkdev(major,name,ops) register_blkdev(major,name,ops)
-#define register_disk(dd,dev,partn,ops,size) \
-do { \
-	dd->sizes[MINOR(dev)] = size >> 1; \
-	resetup_one_dev(dd,MINOR(dev)>>DASD_PARTN_BITS); \
-} while(0)
-#define init_waitqueue_head(x) do { *x = NULL; } while(0)
-#define blk_cleanup_queue(x) do {} while(0)
-#define blk_init_queue(x...) do {} while(0)
-#define blk_queue_headactive(x...) do {} while(0)
-#define blk_queue_make_request(x) do {} while(0)
-#define list_empty(x) (0)
-#define INIT_BLK_DEV(d_major,d_request_fn,d_queue_fn,d_current) \
-do { \
-        blk_dev[d_major].request_fn = d_request_fn; \
-        blk_dev[d_major].queue = d_queue_fn; \
-        blk_dev[d_major].current_request = d_current; \
-} while(0)
-#define INIT_GENDISK(D_MAJOR,D_NAME,D_PARTN_BITS,D_PER_MAJOR) \
-	major:D_MAJOR, \
-	major_name:D_NAME, \
-	minor_shift:D_PARTN_BITS, \
-	max_nr:D_PER_MAJOR, \
-	nr_real:D_PER_MAJOR,
-static inline struct request * 
-dasd_next_request( request_queue_t *queue ) 
-{
-    return *queue;
-}
-static inline void 
-dasd_dequeue_request( request_queue_t * q, struct request *req )
-{
-        *q = req->next;
-        req->next = NULL;
-}
-#else
 #define INIT_BLK_DEV(d_major,d_request_fn,d_queue_fn,d_current) \
 do { \
         blk_dev[d_major].queue = d_queue_fn; \
@@ -111,18 +70,17 @@
 	major_name:D_NAME, \
 	minor_shift:D_PARTN_BITS, \
 	nr_real:D_PER_MAJOR, \
-        fops:&dasd_device_operations, 
-static inline struct request * 
-dasd_next_request( request_queue_t *queue ) 
+        fops:&dasd_device_operations,
+static inline struct request *
+dasd_next_request( request_queue_t *queue )
 {
         return elv_next_request(queue);
 }
-static inline void 
+static inline void
 dasd_dequeue_request( request_queue_t * q, struct request *req )
 {
         blkdev_dequeue_request (req);
 }
-#endif
 
 /* dasd_range_t are used for dynamic device att-/detachment */
 typedef struct dasd_devreg_t {
diff -ur linux-2.5.12/drivers/s390/block/xpram.c linux/drivers/s390/block/xpram.c
--- linux-2.5.12/drivers/s390/block/xpram.c	2002-05-01 02:09:00.000000000 +0200
+++ linux/drivers/s390/block/xpram.c	2002-05-02 02:48:12.000000000 +0200
@@ -1016,13 +1016,9 @@
 	 * arrays if it uses the default values.
 	 */
 
-#if (XPRAM_VERSION == 22)
-	blk_dev[major].request_fn = xpram_request;
-#elif (XPRAM_VERSION == 24)
 	q = BLK_DEFAULT_QUEUE (major);
 	blk_init_queue (q, xpram_request);
 	blk_queue_hardsect_size(q, xpram_hardsect);
-#endif /* V22/V24 */
 
 	/* we want to have XPRAM_UNUSED blocks security buffer between devices */
 	mem_usable=xpram_mem_avail-(XPRAM_UNUSED*(xpram_devs-1));
@@ -1148,9 +1144,6 @@
 	blksize_size[major] = NULL;
  fail_malloc_devices:
  fail_malloc:
-#if (XPRAM_VERSION == 22)
-	blk_dev[major].request_fn = NULL;
-#endif /* V22 */
 	/* ???	unregister_chrdev(major, "xpram"); */
 	unregister_blkdev(major, "xpram");
 	return result;
@@ -1180,9 +1173,6 @@
 
 	/* first of all, reset all the data structures */
 
-#if (XPRAM_VERSION == 22)
-	blk_dev[major].request_fn = NULL;
-#endif /* V22 */
 	kfree(blksize_size[major]);
 	kfree(xpram_offsets);
 	blk_clear(major);
diff -ur linux-2.5.12/drivers/s390/char/tapedefs.h linux/drivers/s390/char/tapedefs.h
--- linux-2.5.12/drivers/s390/char/tapedefs.h	2002-05-01 02:08:47.000000000 +0200
+++ linux/drivers/s390/char/tapedefs.h	2002-05-02 02:42:19.000000000 +0200
@@ -33,44 +33,17 @@
 #define TAPEBLOCK_RETRIES 20     // number of retries, when a block-dev request fails.
 
 
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
 #define INIT_BLK_DEV(d_major,d_request_fn,d_queue_fn,d_current) \
 do { \
         blk_dev[d_major].queue = d_queue_fn; \
 } while(0)
-static inline struct request * 
-tape_next_request( request_queue_t *queue ) 
+static inline struct request *
+tape_next_request( request_queue_t *queue )
 {
         return elv_next_request(queue);
 }
-static inline void 
+static inline void
 tape_dequeue_request( request_queue_t * q, struct request *req )
 {
         blkdev_dequeue_request (req);
 }
-#else 
-#define s390_dev_info_t dev_info_t
-typedef struct request *request_queue_t;
-#ifndef init_waitqueue_head
-#define init_waitqueue_head(x) do { *x = NULL; } while(0)
-#endif
-#define blk_init_queue(x,y) do {} while(0)
-#define blk_queue_headactive(x,y) do {} while(0)
-#define INIT_BLK_DEV(d_major,d_request_fn,d_queue_fn,d_current) \
-do { \
-        blk_dev[d_major].request_fn = d_request_fn; \
-        blk_dev[d_major].queue = d_queue_fn; \
-        blk_dev[d_major].current_request = d_current; \
-} while(0)
-static inline struct request *
-tape_next_request( request_queue_t *queue ) 
-{
-    return *queue;
-}
-static inline void 
-tape_dequeue_request( request_queue_t * q, struct request *req )
-{
-        *q = req->next;
-        req->next = NULL;
-}
-#endif 
diff -ur linux-2.5.12/drivers/scsi/sr.c linux/drivers/scsi/sr.c
--- linux-2.5.12/drivers/scsi/sr.c	2002-05-01 02:08:50.000000000 +0200
+++ linux/drivers/scsi/sr.c	2002-05-02 03:26:11.000000000 +0200
@@ -49,7 +49,6 @@
 #include <asm/uaccess.h>
 
 #define MAJOR_NR SCSI_CDROM_MAJOR
-#define LOCAL_END_REQUEST
 #include <linux/blk.h>
 #include "scsi.h"
 #include "hosts.h"
diff -ur linux-2.5.12/include/linux/blkdev.h linux/include/linux/blkdev.h
--- linux-2.5.12/include/linux/blkdev.h	2002-05-01 02:08:49.000000000 +0200
+++ linux/include/linux/blkdev.h	2002-05-02 02:55:24.000000000 +0200
@@ -336,6 +336,8 @@
 	blk_size_in_bytes[major] = NULL;
 #endif
 	blksize_size[major] = NULL;
+	blk_dev[major].queue = NULL;
+
 }
 
 extern inline int queue_hardsect_size(request_queue_t *q)
diff -ur linux-2.5.12/include/linux/blk.h linux/include/linux/blk.h
--- linux-2.5.12/include/linux/blk.h	2002-05-01 02:08:51.000000000 +0200
+++ linux/include/linux/blk.h	2002-05-02 04:17:46.000000000 +0200
@@ -97,19 +97,14 @@
 } while (0)
 
 #define elv_add_request(q, rq, back) _elv_add_request((q), (rq), (back), 1)
-	
-#if defined(MAJOR_NR) || defined(IDE_DRIVER)
+
+#if defined(MAJOR_NR)
 
 /*
  * Add entries as needed.
  */
 
-#ifdef IDE_DRIVER
-
-#define DEVICE_NR(device)	(minor(device) >> PARTN_BITS)
-#define DEVICE_NAME "ide"
-
-#elif (MAJOR_NR == RAMDISK_MAJOR)
+#if (MAJOR_NR == RAMDISK_MAJOR)
 
 /* ram disk */
 #define DEVICE_NAME "ramdisk"
@@ -291,7 +286,6 @@
 #endif /* MAJOR_NR == whatever */
 
 #if (MAJOR_NR != SCSI_TAPE_MAJOR) && (MAJOR_NR != OSST_MAJOR)
-#if !defined(IDE_DRIVER)
 
 #ifndef CURRENT
 #define CURRENT elv_next_request(&blk_dev[MAJOR_NR].request_queue)
@@ -330,12 +324,9 @@
 	if (!CURRENT->bio)					\
 		panic(DEVICE_NAME ": no bio");			\
 
-#endif /* !defined(IDE_DRIVER) */
-
 /*
- * If we have our own end_request, we do not want to include this mess
+ * Default end request handler for "legacy" drivers.
  */
-#ifndef LOCAL_END_REQUEST
 static inline void end_request(int uptodate)
 {
 	struct request *req = CURRENT;
@@ -347,8 +338,7 @@
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
 }
-#endif /* !LOCAL_END_REQUEST */
 #endif /* (MAJOR_NR != SCSI_TAPE_MAJOR) */
-#endif /* defined(MAJOR_NR) || defined(IDE_DRIVER) */
+#endif /* defined(MAJOR_NR) */
 
 #endif /* _BLK_H */
diff -ur linux-2.5.12/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.12/include/linux/ide.h	2002-05-01 02:08:49.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-02 04:18:23.000000000 +0200
@@ -642,13 +640,6 @@
 extern struct ata_channel ide_hwifs[];		/* master data repository */
 extern int noautodma;
 
-/*
- * We need blk.h, but we replace its end_request by our own version.
- */
-#define IDE_DRIVER		/* Toggle some magic bits in blk.h */
-#define LOCAL_END_REQUEST	/* Don't generate end_request in blk.h */
-#include <linux/blk.h>
-
 extern int __ide_end_request(struct ata_device *, struct request *, int, int);
 extern int ide_end_request(struct ata_device *drive, struct request *, int);
 
diff -ur linux-2.5.12/include/linux/nbd.h linux/include/linux/nbd.h
--- linux-2.5.12/include/linux/nbd.h	2002-05-01 02:09:01.000000000 +0200
+++ linux/include/linux/nbd.h	2002-05-02 04:22:03.000000000 +0200
@@ -25,8 +25,6 @@
 #include <linux/locks.h>
 #include <asm/semaphore.h>
 
-#define LOCAL_END_REQUEST
-
 #include <linux/blk.h>
 
 #ifdef PARANOIA

--------------060408050607000906060107--

