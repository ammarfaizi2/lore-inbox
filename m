Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287641AbSAEKu6>; Sat, 5 Jan 2002 05:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287644AbSAEKuw>; Sat, 5 Jan 2002 05:50:52 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:15078 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S287641AbSAEKup>; Sat, 5 Jan 2002 05:50:45 -0500
Date: Sat, 5 Jan 2002 02:50:42 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: dwmw2@redhat.com, mtd@infradead.org, linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.2-pre8/drivers/mtd compilation fixes
Message-ID: <20020105025042.A23360@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch updates linux-2.5.2-pre8/drivers/mtd
to compile.  This entails some kdev_t fixes and other updates
for changes to the block device driver interface.

	In the case of one routine (ftl_reread_partitions), there was
a goto to a nonexistant label (goto leave), so I think there may have
been an incomplete patch applied to this subdirectory to begin with
(also, drivers/mtd/bootldr.c refers to a nonexistant "struct tag",
but that file is apparently not currently compiled anyhow).

	I only know that this patch makes the code compile.  I
have not tested it.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mtd.diffs"

--- linux-2.5.2-pre8/drivers/mtd/ftl.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/mtd/ftl.c	Sat Jan  5 02:37:28 2002
@@ -180,6 +180,7 @@
 static struct hd_struct ftl_hd[MINOR_NR(MAX_DEV, 0, 0)];
 static int ftl_sizes[MINOR_NR(MAX_DEV, 0, 0)];
 static int ftl_blocksizes[MINOR_NR(MAX_DEV, 0, 0)];
+static spinlock_t ftl_queue_lock = SPIN_LOCK_UNLOCKED;
 
 static struct gendisk ftl_gendisk = {
     major:		FTL_MAJOR,
@@ -195,7 +196,7 @@
 		     u_int cmd, u_long arg);
 static int ftl_open(struct inode *inode, struct file *file);
 static release_t ftl_close(struct inode *inode, struct file *file);
-static int ftl_reread_partitions(int minor);
+static int ftl_reread_partitions(kdev_t dev);
 
 static void ftl_erase_callback(struct erase_info *done);
 
@@ -842,7 +843,7 @@
 
 static int ftl_open(struct inode *inode, struct file *file)
 {
-    int minor = MINOR(inode->i_rdev);
+    int minor = minor(inode->i_rdev);
     partition_t *partition;
 
     if (minor>>4 >= MAX_MTD_DEVICES)
@@ -878,7 +879,7 @@
 
 static release_t ftl_close(struct inode *inode, struct file *file)
 {
-    int minor = MINOR(inode->i_rdev);
+    int minor = minor(inode->i_rdev);
     partition_t *part = myparts[minor >> 4];
     int i;
     
@@ -1114,7 +1115,7 @@
 		     u_int cmd, u_long arg)
 {
     struct hd_geometry *geo = (struct hd_geometry *)arg;
-    int ret = 0, minor = MINOR(inode->i_rdev);
+    int ret = 0, minor = minor(inode->i_rdev);
     partition_t *part= myparts[minor >> 4];
     u_long sect;
 
@@ -1139,7 +1140,7 @@
 	ret = put_user((u64)ftl_hd[minor].nr_sects << 9, (u64 *)arg);
 	break;
     case BLKRRPART:
-	ret = ftl_reread_partitions(minor);
+	ret = ftl_reread_partitions(inode->i_rdev);
 	break;
     case BLKROSET:
     case BLKROGET:
@@ -1161,25 +1162,24 @@
 
 static int ftl_reread_partitions(kdev_t dev)
 {
-    int minor = MINOR(dev);
-    partition_t *part = myparts[minor >> 4];
+    partition_t *part = myparts[minor(dev) >> 4];
     int res;
 
-    DEBUG(0, "ftl_cs: ftl_reread_partition(%d)\n", minor);
+    DEBUG(0, "ftl_cs: ftl_reread_partition(%d)\n", minor(dev));
     if ((atomic_read(&part->open) > 1)) {
 	    return -EBUSY;
     }
 
     res = wipe_partitions(dev);
     if (res)
-	goto leave;
+       return res;
 
     scan_header(part);
 
-    register_disk(&ftl_gendisk, whole >> PART_BITS, MAX_PART,
+    register_disk(&ftl_gendisk, dev, MAX_PART,
 		  &ftl_blk_fops, le32_to_cpu(part->header.FormattedSize)/SECTOR_SIZE);
 
-    return res;
+    return 0;
 }
 
 /*======================================================================
@@ -1190,37 +1190,30 @@
 
 static void do_ftl_request(request_arg_t)
 {
-    int ret, minor;
+    int ret, index;
     partition_t *part;
 
     do {
       //	    sti();
 	INIT_REQUEST;
 
-	minor = MINOR(CURRENT->rq_dev);
+	index = minor(CURRENT->rq_dev);
 	
-	part = myparts[minor >> 4];
+	part = myparts[index >> 4];
 	if (part) {
 	  ret = 0;
 	  
-	  switch (CURRENT->cmd) {
-	  case READ:
+	  if (CURRENT->cmd == READ) {
 	    ret = ftl_read(part, CURRENT->buffer,
-			   CURRENT->sector+ftl_hd[minor].start_sect,
+			   CURRENT->sector+ftl_hd[index].start_sect,
 			   CURRENT->current_nr_sectors);
 	    if (ret) printk("ftl_read returned %d\n", ret);
-	    break;
-	    
-	  case WRITE:
+	  }
+	  else {
 	    ret = ftl_write(part, CURRENT->buffer,
-			    CURRENT->sector+ftl_hd[minor].start_sect,
+			    CURRENT->sector+ftl_hd[index].start_sect,
 			    CURRENT->current_nr_sectors);
 	    if (ret) printk("ftl_write returned %d\n", ret);
-	    break;
-	    
-	  default:
-	    panic("ftl_cs: unknown block command!\n");
-	    
 	  }
 	} else {
 	  ret = 1;
@@ -1294,7 +1287,7 @@
 		partition->state = FTL_FORMATTED;
 		atomic_set(&partition->open, 0);
 		myparts[device] = partition;
-		ftl_reread_partitions(device << 4);
+		ftl_reread_partitions(mk_kdev(FTL_MAJOR, device << 4));
 #ifdef PCMCIA_DEBUG
 		printk(KERN_INFO "ftl_cs: opening %d kb FTL partition\n",
 		       le32_to_cpu(partition->header.FormattedSize) >> 10);
@@ -1355,7 +1348,8 @@
     }
     blksize_size[FTL_MAJOR] = ftl_blocksizes;
     ftl_gendisk.major = FTL_MAJOR;
-    blk_init_queue(BLK_DEFAULT_QUEUE(FTL_MAJOR), &do_ftl_request);
+    blk_init_queue(BLK_DEFAULT_QUEUE(FTL_MAJOR), &do_ftl_request,
+		   &ftl_queue_lock);
     add_gendisk(&ftl_gendisk);
     
     register_mtd_user(&ftl_notifier);
@@ -1369,7 +1363,7 @@
 
     unregister_blkdev(FTL_MAJOR, "ftl");
     blk_cleanup_queue(BLK_DEFAULT_QUEUE(FTL_MAJOR));
-    bklk_clear(FTL_MAJOR);
+    blk_clear(FTL_MAJOR);
 
     del_gendisk(&ftl_gendisk);
 }
--- linux-2.5.2-pre8/drivers/mtd/mtdblock.c	Tue Nov 27 09:23:27 2001
+++ linux/drivers/mtd/mtdblock.c	Sat Jan  5 02:27:14 2002
@@ -31,6 +31,7 @@
 #else
 #define QUEUE_PLUGGED (blk_queue_plugged(QUEUE))
 #endif
+static spinlock_t mtdblock_queue_lock = SPIN_LOCK_UNLOCKED;
 
 #ifdef CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>
@@ -283,7 +284,7 @@
 	if (!inode)
 		return -EINVAL;
 	
-	dev = MINOR(inode->i_rdev);
+	dev = minor(inode->i_rdev);
 	if (dev >= MAX_MTD_DEVICES)
 		return -EINVAL;
 
@@ -373,7 +374,7 @@
 
 	invalidate_device(inode->i_rdev, 1);
 
-	dev = MINOR(inode->i_rdev);
+	dev = minor(inode->i_rdev);
 	mtdblk = mtdblks[dev];
 
 	down(&mtdblk->cache_sem);
@@ -412,26 +413,24 @@
 	struct request *req;
 	struct mtdblk_dev *mtdblk;
 	unsigned int res;
+	int err;
 
 	for (;;) {
 		INIT_REQUEST;
 		req = CURRENT;
-		spin_unlock_irq(&QUEUE->queue_lock);
-		mtdblk = mtdblks[MINOR(req->rq_dev)];
+		spin_unlock_irq(QUEUE->queue_lock);
+		mtdblk = mtdblks[minor(req->rq_dev)];
 		res = 0;
 
-		if (MINOR(req->rq_dev) >= MAX_MTD_DEVICES)
+		if (minor(req->rq_dev) >= MAX_MTD_DEVICES)
 			panic(__FUNCTION__": minor out of bound");
 
 		if ((req->sector + req->current_nr_sectors) > (mtdblk->mtd->size >> 9))
 			goto end_req;
 
 		// Handle the request
-		switch (req->cmd)
+		if (req->cmd == READ)
 		{
-			int err;
-
-			case READ:
 			down(&mtdblk->cache_sem);
 			err = do_cached_read (mtdblk, req->sector << 9, 
 					req->current_nr_sectors << 9,
@@ -439,13 +438,10 @@
 			up(&mtdblk->cache_sem);
 			if (!err)
 				res = 1;
-			break;
-
-			case WRITE:
-			// Read only device
-			if ( !(mtdblk->mtd->flags & MTD_WRITEABLE) ) 
-				break;
-
+		}
+		else if ( (mtdblk->mtd->flags & MTD_WRITEABLE) ) {
+			// Write request to writable device
+			
 			// Do the write
 			down(&mtdblk->cache_sem);
 			err = do_cached_write (mtdblk, req->sector << 9,
@@ -454,11 +450,10 @@
 			up(&mtdblk->cache_sem);
 			if (!err)
 				res = 1;
-			break;
 		}
 
 end_req:
-		spin_lock_irq(&QUEUE->queue_lock);
+		spin_lock_irq(QUEUE->queue_lock);
 		end_request(res);
 	}
 }
@@ -490,16 +485,16 @@
 	while (!leaving) {
 		add_wait_queue(&thr_wq, &wait);
 		set_current_state(TASK_INTERRUPTIBLE);
-		spin_lock_irq(&QUEUE->queue_lock);
+		spin_lock_irq(QUEUE->queue_lock);
 		if (QUEUE_EMPTY || QUEUE_PLUGGED) {
-			spin_unlock_irq(&QUEUE->queue_lock);
+			spin_unlock_irq(QUEUE->queue_lock);
 			schedule();
 			remove_wait_queue(&thr_wq, &wait); 
 		} else {
 			remove_wait_queue(&thr_wq, &wait); 
 			set_current_state(TASK_RUNNING);
 			handle_mtdblock_request();
-			spin_unlock_irq(&QUEUE->queue_lock);
+			spin_unlock_irq(QUEUE->queue_lock);
 		}
 	}
 
@@ -525,7 +520,7 @@
 {
 	struct mtdblk_dev *mtdblk;
 
-	mtdblk = mtdblks[MINOR(inode->i_rdev)];
+	mtdblk = mtdblks[minor(inode->i_rdev)];
 
 #ifdef PARANOIA
 	if (!mtdblk)
@@ -636,7 +631,8 @@
 	blksize_size[MAJOR_NR] = mtd_blksizes;
 	blk_size[MAJOR_NR] = mtd_sizes;
 	
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &mtdblock_request);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &mtdblock_request,
+		       &mtdblock_queue_lock);
 	kernel_thread (mtdblock_thread, NULL, CLONE_FS|CLONE_FILES|CLONE_SIGHAND);
 	return 0;
 }
--- linux-2.5.2-pre8/drivers/mtd/mtdblock_ro.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/mtd/mtdblock_ro.c	Sat Jan  5 02:27:14 2002
@@ -31,6 +31,7 @@
 #else
 #define RQFUNC_ARG request_queue_t *q
 #endif
+static spinlock_t mtdblock_queue_lock = SPIN_LOCK_UNLOCKED;
 
 #ifdef MTDBLOCK_DEBUG
 static int debug = MTDBLOCK_DEBUG;
@@ -52,7 +53,7 @@
 	if (inode == 0)
 		return -EINVAL;
 	
-	dev = MINOR(inode->i_rdev);
+	dev = minor(inode->i_rdev);
 	
 	mtd = get_mtd_device(NULL, dev);
 	if (!mtd)
@@ -81,7 +82,7 @@
    
 	invalidate_device(inode->i_rdev, 1);
 
-	dev = MINOR(inode->i_rdev);
+	dev = minor(inode->i_rdev);
 	mtd = __get_mtd_device(NULL, dev);
 
 	if (!mtd) {
@@ -105,6 +106,7 @@
    struct request *current_request;
    unsigned int res = 0;
    struct mtd_info *mtd;
+   size_t retlen;
 
    while (1)
    {
@@ -113,7 +115,7 @@
       INIT_REQUEST;
       current_request = CURRENT;
    
-      if (MINOR(current_request->rq_dev) >= MAX_MTD_DEVICES)
+      if (minor(current_request->rq_dev) >= MAX_MTD_DEVICES)
       {
 	 printk("mtd: Unsupported device!\n");
 	 end_request(0);
@@ -122,9 +124,10 @@
       
       // Grab our MTD structure
 
-      mtd = __get_mtd_device(NULL, MINOR(current_request->rq_dev));
+      mtd = __get_mtd_device(NULL, minor(current_request->rq_dev));
       if (!mtd) {
-	      printk("MTD device %d doesn't appear to exist any more\n", CURRENT_DEV);
+	      printk("MTD device %d:%d doesn't appear to exist any more\n",
+		     major(CURRENT_DEV), minor(CURRENT_DEV));
 	      end_request(0);
       }
 
@@ -139,7 +142,7 @@
       
       /* Remove the request we are handling from the request list so nobody messes
          with it */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)) && LINUX_VERSION_CODE < KERNEL_VERSION(2,5,1)
       /* Now drop the lock that the ll_rw_blk functions grabbed for us
          and process the request. This is necessary due to the extreme time
          we spend processing it. */
@@ -147,32 +150,19 @@
 #endif
 
       // Handle the request
-      switch (current_request->cmd)
+      if (current_request->cmd == READ)
       {
-         size_t retlen;
-
-	 case READ:
 	 if (MTD_READ(mtd,current_request->sector<<9, 
 		      current_request->nr_sectors << 9, 
 		      &retlen, current_request->buffer) == 0)
 	    res = 1;
 	 else
 	    res = 0;
-	 break;
-	 
-	 case WRITE:
-
-	 /* printk("mtdblock_request WRITE sector=%d(%d)\n",current_request->sector,
-		current_request->nr_sectors);
-	 */
-
-	 // Read only device
-	 if ((mtd->flags & MTD_CAP_RAM) == 0)
-	 {
+      } else if ((mtd->flags & MTD_CAP_RAM) == 0) {
+	    // Write to read only device
 	    res = 0;
-	    break;
-	 }
-
+      } else {
+	 // Write to writable device
 	 // Do the write
 	 if (MTD_WRITE(mtd,current_request->sector<<9, 
 		       current_request->nr_sectors << 9, 
@@ -180,16 +170,10 @@
 	    res = 1;
 	 else
 	    res = 0;
-	 break;
-	 
-	 // Shouldn't happen
-	 default:
-	 printk("mtd: unknown request\n");
-	 break;
       }
 
       // Grab the lock and re-thread the item onto the linked list
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)) && LINUX_VERSION_CODE < KERNEL_VERSION(2,5,1)
 	spin_lock_irq(&io_request_lock);
 #endif
 	end_request(res);
@@ -203,7 +187,7 @@
 {
 	struct mtd_info *mtd;
 
-	mtd = __get_mtd_device(NULL, MINOR(inode->i_rdev));
+	mtd = __get_mtd_device(NULL, minor(inode->i_rdev));
 
 	if (!mtd) return -EINVAL;
 
@@ -266,7 +250,8 @@
 	blksize_size[MAJOR_NR] = NULL;
 	blk_size[MAJOR_NR] = mtd_sizes;
 	
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &mtdblock_request);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &mtdblock_request,
+		       &mtdblock_queue_lock);
 	return 0;
 }
 
--- linux-2.5.2-pre8/drivers/mtd/mtdchar.c	Thu Oct  4 15:14:59 2001
+++ linux/drivers/mtd/mtdchar.c	Sat Jan  5 02:27:14 2002
@@ -60,7 +60,7 @@
 
 static int mtd_open(struct inode *inode, struct file *file)
 {
-	int minor = MINOR(inode->i_rdev);
+	int minor = minor(inode->i_rdev);
 	int devnum = minor >> 1;
 	struct mtd_info *mtd;
 
--- linux-2.5.2-pre8/drivers/mtd/nftlcore.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/mtd/nftlcore.c	Sat Jan  5 02:27:14 2002
@@ -55,6 +55,7 @@
 
 static int nftl_sizes[256];
 static int nftl_blocksizes[256];
+static spinlock_t nftl_queue_lock = SPIN_LOCK_UNLOCKED;
 
 /* .. for the Linux partition table handling. */
 struct hd_struct part_table[256];
@@ -156,7 +157,7 @@
 #if LINUX_VERSION_CODE < 0x20328
 	resetup_one_dev(&nftl_gendisk, firstfree);
 #else
-	grok_partitions(MKDEV(MAJOR_NR,firstfree<<NFTL_PARTN_BITS),
+	grok_partitions(mk_kdev(MAJOR_NR,firstfree<<NFTL_PARTN_BITS),
 			nftl->nr_sects);
 #endif
 }
@@ -779,7 +780,7 @@
 	struct NFTLrecord *nftl;
 	int res;
 
-	nftl = NFTLs[MINOR(inode->i_rdev) >> NFTL_PARTN_BITS];
+	nftl = NFTLs[minor(inode->i_rdev) >> NFTL_PARTN_BITS];
 
 	if (!nftl) return -EINVAL;
 
@@ -845,7 +846,7 @@
 		
 		/* We can do this because the generic code knows not to
 		   touch the request at the head of the queue */
-		spin_unlock_irq(&QUEUE->queue_lock);
+		spin_unlock_irq(QUEUE->queue_lock);
 
 		DEBUG(MTD_DEBUG_LEVEL2, "NFTL_request\n");
 		DEBUG(MTD_DEBUG_LEVEL3,
@@ -853,7 +854,7 @@
 		      (req->cmd == READ) ? "Read " : "Write",
 		      req->sector, req->current_nr_sectors);
 
-		dev = MINOR(req->rq_dev);
+		dev = minor(req->rq_dev);
 		block = req->sector;
 		nsect = req->current_nr_sectors;
 		buffer = req->buffer;
@@ -875,7 +876,7 @@
 		if (block + nsect > part_table[dev].nr_sects) {
 			/* access past the end of device */
 			printk("nftl%c%d: bad access: block = %d, count = %d\n",
-			       (MINOR(req->rq_dev)>>6)+'a', dev & 0xf, block, nsect);
+			       (minor(req->rq_dev)>>6)+'a', dev & 0xf, block, nsect);
 			up(&nftl->mutex);
 			res = 0; /* fail */
 			goto repeat;
@@ -898,7 +899,7 @@
 			DEBUG(MTD_DEBUG_LEVEL2,"NFTL read request completed OK\n");
 			up(&nftl->mutex);
 			goto repeat;
-		} else if (req->cmd == WRITE) {
+		} else {
 			DEBUG(MTD_DEBUG_LEVEL2, "NFTL write request of 0x%x sectors @ %x "
 			      "(req->nr_sectors == %lx)\n", nsect, block,
 			      req->nr_sectors);
@@ -918,22 +919,17 @@
 #endif /* CONFIG_NFTL_RW */
 			up(&nftl->mutex);
 			goto repeat;
-		} else {
-			DEBUG(MTD_DEBUG_LEVEL0, "NFTL unknown request\n");
-			up(&nftl->mutex);
-			res = 0;
-			goto repeat;
 		}
 	repeat: 
 		DEBUG(MTD_DEBUG_LEVEL3, "end_request(%d)\n", res);
-		spin_lock_irq(&QUEUE->queue_lock);
+		spin_lock_irq(QUEUE->queue_lock);
 		end_request(res);
 	}
 }
 
 static int nftl_open(struct inode *ip, struct file *fp)
 {
-	int nftlnum = MINOR(ip->i_rdev) >> NFTL_PARTN_BITS;
+	int nftlnum = minor(ip->i_rdev) >> NFTL_PARTN_BITS;
 	struct NFTLrecord *thisNFTL;
 	thisNFTL = NFTLs[nftlnum];
 
@@ -947,7 +943,7 @@
 #endif
 	if (!thisNFTL) {
 		DEBUG(MTD_DEBUG_LEVEL2,"ENODEV: thisNFTL = %d, minor = %d, ip = %p, fp = %p\n", 
-		      nftlnum, ip->i_rdev, ip, fp);
+		      nftlnum, minor(ip->i_rdev), ip, fp);
 		return -ENODEV;
 	}
 
@@ -967,7 +963,7 @@
 {
 	struct NFTLrecord *thisNFTL;
 
-	thisNFTL = NFTLs[MINOR(inode->i_rdev) / 16];
+	thisNFTL = NFTLs[minor(inode->i_rdev) / 16];
 
 	DEBUG(MTD_DEBUG_LEVEL2, "NFTL_release\n");
 
@@ -1027,7 +1023,8 @@
 		printk("unable to register NFTL block device on major %d\n", MAJOR_NR);
 		return -EBUSY;
 	} else {
-		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &nftl_request);
+		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &nftl_request,
+			       &nftl_queue_lock);
 
 		/* set block size to 1kB each */
 		for (i = 0; i < 256; i++) {
--- linux-2.5.2-pre8/drivers/mtd/chips/amd_flash.c	Thu Oct  4 15:14:59 2001
+++ linux/drivers/mtd/chips/amd_flash.c	Sat Jan  5 02:27:14 2002
@@ -22,6 +22,7 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/flashchip.h>
+#include <linux/interrupt.h>
 
 /* There's no limit. It exists only to avoid realloc. */
 #define MAX_AMD_CHIPS 8
--- linux-2.5.2-pre8/drivers/mtd/devices/blkmtd.c	Fri Jan  4 19:40:37 2002
+++ linux/drivers/mtd/devices/blkmtd.c	Sat Jan  5 02:27:14 2002
@@ -55,7 +55,7 @@
 #include <linux/pagemap.h>
 #include <linux/iobuf.h>
 #include <linux/slab.h>
-#include <linux/pagemap.h>
+#include <linux/blkdev.h>
 #include <linux/mtd/compatmac.h>
 #include <linux/mtd/mtd.h>
 
@@ -463,7 +463,7 @@
 
   /* check page alignment of start and length */
   DEBUG(2, "blkmtd: erase: dev = `%s' from = %d len = %ld\n",
-	bdevname(rawdevice->binding->bd_dev), from, len);
+	bdevname(to_kdev_t(rawdevice->binding->bd_dev)), from, len);
   if(from % PAGE_SIZE) {
     printk("blkmtd: erase: addr not page aligned (addr = %d)\n", from);
     instr->state = MTD_ERASE_FAILED;
@@ -553,7 +553,8 @@
   *retlen = 0;
 
   DEBUG(2, "blkmtd: read: dev = `%s' from = %ld len = %d buf = %p\n",
-	bdevname(rawdevice->binding->bd_dev), (long int)from, len, buf);
+	bdevname(to_kdev_t(rawdevice->binding->bd_dev)),
+	(long int)from, len, buf);
 
   pagenr = from >> PAGE_SHIFT;
   offset = from - (pagenr << PAGE_SHIFT);
@@ -623,7 +624,8 @@
 
   *retlen = 0;
   DEBUG(2, "blkmtd: write: dev = `%s' to = %ld len = %d buf = %p\n",
-	bdevname(rawdevice->binding->bd_dev), (long int)to, len, buf);
+	bdevname(to_kdev_t(rawdevice->binding->bd_dev)),
+	(long int)to, len, buf);
 
   /* handle readonly and out of range numbers */
 
@@ -891,10 +893,10 @@
   }
   rdev = inode->i_rdev;
   //filp_close(file, NULL);
+  maj = major(rdev);
+  min = minor(rdev);
   DEBUG(1, "blkmtd: found a block device major = %d, minor = %d\n",
-	 MAJOR(rdev), MINOR(rdev));
-  maj = MAJOR(rdev);
-  min = MINOR(rdev);
+	maj, min);
 
   if(maj == MTD_BLOCK_MAJOR) {
     printk("blkmtd: attempting to use an MTD device as a block device\n");
@@ -935,7 +937,7 @@
   }
   memset(rawdevice, 0, sizeof(mtd_raw_dev_data_t));
   // get the block device
-  rawdevice->binding = bdget(kdev_t_to_nr(MKDEV(maj, min)));
+  rawdevice->binding = bdget(MKDEV(maj, min));
   err = blkdev_get(rawdevice->binding, mode, 0, BDEV_RAW);
   if (err) {
     goto init_err;

--SLDf9lqlvOQaIe6s--
