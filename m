Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287552AbSBCSKh>; Sun, 3 Feb 2002 13:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287513AbSBCSKW>; Sun, 3 Feb 2002 13:10:22 -0500
Received: from ns.caldera.de ([212.34.180.1]:63679 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S287516AbSBCSKF>;
	Sun, 3 Feb 2002 13:10:05 -0500
Date: Sun, 3 Feb 2002 19:09:58 +0100
From: Christoph Hellwig <hch@caldera.de>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] get rid of some blk.h cruft
Message-ID: <20020203190958.A1780@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>, axboe@suse.de,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

This is a first patch to get rid of the curft in <linux/blk.h>:

 o remove DEVICE_REQUEST definitions - never used in blk.h itself.
 o remove DEVICE_ON() - never used at all.
 o define LOCAL_END_REQUEST when we do not want end_request() instead
   of other hacks.
 o remove DEVICE_OFF() - only used in floppy driver, thus one now has
   a private end_request().
 o use private end_request() functions for drivers not providing
   randomness.
 o remove TIMEOUT_VALUE - only ever used in hd.c

Would you mind reviewing it and forward it to Linus?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.


diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/acorn/block/fd1772.c linux-vger/drivers/acorn/block/fd1772.c
--- /datenklo/ref/linux-vger/drivers/acorn/block/fd1772.c	Mon Dec 17 17:17:55 2001
+++ linux-vger/drivers/acorn/block/fd1772.c	Sun Feb  3 19:13:00 2002
@@ -373,6 +373,7 @@
 static void config_types(void);
 static int floppy_open(struct inode *inode, struct file *filp);
 static int floppy_release(struct inode *inode, struct file *filp);
+static void do_fd_request(request_queue_t *);
 
 /************************* End of Prototypes **************************/
 
@@ -1302,7 +1303,7 @@
 	}
 }
 
-void do_fd_request(request_queue_t* q)
+static void do_fd_request(request_queue_t* q)
 {
 	unsigned long flags;
 
@@ -1614,7 +1615,7 @@
 
 	blk_size[MAJOR_NR] = floppy_sizes;
 	blksize_size[MAJOR_NR] = floppy_blocksizes;
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_fd_request);
 
 	config_types();
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/acorn/block/mfmhd.c linux-vger/drivers/acorn/block/mfmhd.c
--- /datenklo/ref/linux-vger/drivers/acorn/block/mfmhd.c	Sun Jan 13 00:04:53 2002
+++ linux-vger/drivers/acorn/block/mfmhd.c	Sun Feb  3 19:13:37 2002
@@ -1441,7 +1441,7 @@
 	hdc63463_irqpolladdress	= mfm_IRQPollLoc;
 	hdc63463_irqpollmask	= irqmask;
 
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_mfm_request);
 	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB?) read ahread */
 
 	add_gendisk(&mfm_gendisk);
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/block/acsi.c linux-vger/drivers/block/acsi.c
--- /datenklo/ref/linux-vger/drivers/block/acsi.c	Sun Jan 13 00:05:05 2002
+++ linux-vger/drivers/block/acsi.c	Sun Feb  3 19:16:08 2002
@@ -1784,7 +1784,7 @@
 	phys_acsi_buffer = virt_to_phys( acsi_buffer );
 	STramMask = ATARIHW_PRESENT(EXTD_DMA) ? 0x00000000 : 0xff000000;
 	
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &acsi_lock);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_acsi_request, &acsi_lock);
 	read_ahead[MAJOR_NR] = 8;		/* 8 sector (4kB) read-ahead */
 	add_gendisk(&acsi_gendisk);
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/block/amiflop.c linux-vger/drivers/block/amiflop.c
--- /datenklo/ref/linux-vger/drivers/block/amiflop.c	Mon Dec 17 17:18:00 2001
+++ linux-vger/drivers/block/amiflop.c	Sun Feb  3 19:16:51 2002
@@ -1857,7 +1857,7 @@
 	post_write_timer.data = 0;
 	post_write_timer.function = post_write;
   
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &amiflop_lock);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_fd_request, &amiflop_lock);
 	blksize_size[MAJOR_NR] = floppy_blocksizes;
 	blk_size[MAJOR_NR] = floppy_sizes;
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/block/ataflop.c linux-vger/drivers/block/ataflop.c
--- /datenklo/ref/linux-vger/drivers/block/ataflop.c	Mon Dec 17 17:18:00 2001
+++ linux-vger/drivers/block/ataflop.c	Sun Feb  3 19:17:24 2002
@@ -2015,7 +2015,7 @@
 
 	blk_size[MAJOR_NR] = floppy_sizes;
 	blksize_size[MAJOR_NR] = floppy_blocksizes;
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &ataflop_lock);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_fd_request, &ataflop_lock);
 
 	printk(KERN_INFO "Atari floppy driver: max. %cD, %strack buffering\n",
 	       DriveType == 0 ? 'D' : DriveType == 1 ? 'H' : 'E',
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/block/cpqarray.c linux-vger/drivers/block/cpqarray.c
--- /datenklo/ref/linux-vger/drivers/block/cpqarray.c	Wed Jan 16 21:47:23 2002
+++ linux-vger/drivers/block/cpqarray.c	Sun Feb  3 21:19:54 2002
@@ -52,6 +52,7 @@
 MODULE_LICENSE("GPL");
 
 #define MAJOR_NR COMPAQ_SMART2_MAJOR
+#define LOCAL_END_REQUEST
 #include <linux/blk.h>
 #include <linux/blkdev.h>
 #include <linux/genhd.h>
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/block/floppy.c linux-vger/drivers/block/floppy.c
--- /datenklo/ref/linux-vger/drivers/block/floppy.c	Sun Jan 13 00:05:07 2002
+++ linux-vger/drivers/block/floppy.c	Sun Feb  3 21:02:47 2002
@@ -230,6 +230,7 @@
 
 static int irqdma_allocated;
 
+#define LOCAL_END_REQUEST
 #define MAJOR_NR FLOPPY_MAJOR
 
 #include <linux/blk.h>
@@ -2274,17 +2275,32 @@
  * =============================
  */
 
+static inline void end_request(struct request *req, int uptodate)
+{
+	kdev_t dev = req->rq_dev;
+
+	if (end_that_request_first(req, uptodate, req->hard_cur_sectors))
+		return;
+	add_blkdev_randomness(major(dev));
+	floppy_off(DEVICE_NR(dev));
+	blkdev_dequeue_request(req);
+	end_that_request_last(req);
+}
+
+
 /* new request_done. Can handle physical sectors which are smaller than a
  * logical buffer */
 static void request_done(int uptodate)
 {
+	struct request_queue *q = QUEUE;
+	struct request *req = elv_next_request(q);
 	unsigned long flags;
 	int block;
 
 	probing = 0;
 	reschedule_timeout(MAXTIMEOUT, "request done %d", uptodate);
 
-	if (QUEUE_EMPTY){
+	if (blk_queue_empty(q)) {
 		DPRINT("request list destroyed in floppy request done\n");
 		return;
 	}
@@ -2292,48 +2308,48 @@
 	if (uptodate){
 		/* maintain values for invalidation on geometry
 		 * change */
-		block = current_count_sectors + CURRENT->sector;
+		block = current_count_sectors + req->sector;
 		INFBOUND(DRS->maxblock, block);
 		if (block > _floppy->sect)
 			DRS->maxtrack = 1;
 
 		/* unlock chained buffers */
-		spin_lock_irqsave(QUEUE->queue_lock, flags);
-		while (current_count_sectors && !QUEUE_EMPTY &&
-		       current_count_sectors >= CURRENT->current_nr_sectors){
-			current_count_sectors -= CURRENT->current_nr_sectors;
-			CURRENT->nr_sectors -= CURRENT->current_nr_sectors;
-			CURRENT->sector += CURRENT->current_nr_sectors;
-			end_request(1);
+		spin_lock_irqsave(q->queue_lock, flags);
+		while (current_count_sectors && !blk_queue_empty(q) &&
+		       current_count_sectors >= req->current_nr_sectors){
+			current_count_sectors -= req->current_nr_sectors;
+			req->nr_sectors -= req->current_nr_sectors;
+			req->sector += req->current_nr_sectors;
+			end_request(req, 1);
 		}
-		spin_unlock_irqrestore(QUEUE->queue_lock, flags);
+		spin_unlock_irqrestore(q->queue_lock, flags);
 
-		if (current_count_sectors && !QUEUE_EMPTY){
+		if (current_count_sectors && !blk_queue_empty(q)) {
 			/* "unlock" last subsector */
-			CURRENT->buffer += current_count_sectors <<9;
-			CURRENT->current_nr_sectors -= current_count_sectors;
-			CURRENT->nr_sectors -= current_count_sectors;
-			CURRENT->sector += current_count_sectors;
+			req->buffer += current_count_sectors <<9;
+			req->current_nr_sectors -= current_count_sectors;
+			req->nr_sectors -= current_count_sectors;
+			req->sector += current_count_sectors;
 			return;
 		}
 
-		if (current_count_sectors && QUEUE_EMPTY)
+		if (current_count_sectors && blk_queue_empty(q))
 			DPRINT("request list destroyed in floppy request done\n");
 
 	} else {
-		if (rq_data_dir(CURRENT) == WRITE) {
+		if (rq_data_dir(req) == WRITE) {
 			/* record write error information */
 			DRWE->write_errors++;
 			if (DRWE->write_errors == 1) {
-				DRWE->first_error_sector = CURRENT->sector;
+				DRWE->first_error_sector = req->sector;
 				DRWE->first_error_generation = DRS->generation;
 			}
-			DRWE->last_error_sector = CURRENT->sector;
+			DRWE->last_error_sector = req->sector;
 			DRWE->last_error_generation = DRS->generation;
 		}
-		spin_lock_irqsave(QUEUE->queue_lock, flags);
-		end_request(0);
-		spin_unlock_irqrestore(QUEUE->queue_lock, flags);
+		spin_lock_irqsave(q->queue_lock, flags);
+		end_request(req, 0);
+		spin_unlock_irqrestore(q->queue_lock, flags);
 	}
 }
 
@@ -4170,7 +4186,7 @@
 
 	blk_size[MAJOR_NR] = floppy_sizes;
 	blksize_size[MAJOR_NR] = floppy_blocksizes;
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &floppy_lock);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_fd_request, &floppy_lock);
 	reschedule_timeout(MAXTIMEOUT, "floppy init", MAXTIMEOUT);
 	config_types();
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/block/paride/pcd.c linux-vger/drivers/block/paride/pcd.c
--- /datenklo/ref/linux-vger/drivers/block/paride/pcd.c	Sun Jan 13 00:05:10 2002
+++ linux-vger/drivers/block/paride/pcd.c	Sun Feb  3 19:34:24 2002
@@ -181,9 +181,7 @@
 
 #define MAJOR_NR	major
 #define DEVICE_NAME "PCD"
-#define DEVICE_REQUEST do_pcd_request
 #define DEVICE_NR(device) (minor(device))
-#define DEVICE_ON(device)
 #define DEVICE_OFF(device)
 
 #include <linux/blk.h>
@@ -357,7 +355,7 @@
 		}
 	}
 
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &pcd_lock);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_pcd_request, &pcd_lock);
 	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 
 	for (i=0;i<PCD_UNITS;i++) pcd_blocksizes[i] = 1024;
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/block/paride/pd.c linux-vger/drivers/block/paride/pd.c
--- /datenklo/ref/linux-vger/drivers/block/paride/pd.c	Sun Jan 13 00:05:10 2002
+++ linux-vger/drivers/block/paride/pd.c	Sun Feb  3 19:34:31 2002
@@ -205,9 +205,7 @@
 
 #define MAJOR_NR   major
 #define DEVICE_NAME "PD"
-#define DEVICE_REQUEST do_pd_request
 #define DEVICE_NR(device) (minor(device)>>PD_BITS)
-#define DEVICE_ON(device)
 #define DEVICE_OFF(device)
 
 #include <linux/blk.h>
@@ -395,7 +393,7 @@
                 return -1;
         }
 	q = BLK_DEFAULT_QUEUE(MAJOR_NR);
-	blk_init_queue(q, DEVICE_REQUEST, &pd_lock);
+	blk_init_queue(q, do_pd_request, &pd_lock);
 	blk_queue_max_sectors(q, cluster);
         read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
         
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/block/paride/pf.c linux-vger/drivers/block/paride/pf.c
--- /datenklo/ref/linux-vger/drivers/block/paride/pf.c	Mon Jan 21 22:47:28 2002
+++ linux-vger/drivers/block/paride/pf.c	Sun Feb  3 19:34:37 2002
@@ -201,9 +201,7 @@
 
 #define MAJOR_NR   major
 #define DEVICE_NAME "PF"
-#define DEVICE_REQUEST do_pf_request
 #define DEVICE_NR(device) minor(device)
-#define DEVICE_ON(device)
 #define DEVICE_OFF(device)
 
 #include <linux/blk.h>
@@ -360,7 +358,7 @@
                 return -1;
         }
 	q = BLK_DEFAULT_QUEUE(MAJOR_NR);
-	blk_init_queue(q, DEVICE_REQUEST, &pf_spin_lock);
+	blk_init_queue(q, do_pf_request, &pf_spin_lock);
 	blk_queue_max_phys_segments(q, cluster);
 	blk_queue_max_hw_segments(q, cluster);
         read_ahead[MAJOR_NR] = 8;       /* 8 sector (4kB) read ahead */
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/block/ps2esdi.c linux-vger/drivers/block/ps2esdi.c
--- /datenklo/ref/linux-vger/drivers/block/ps2esdi.c	Fri Jan 25 13:07:04 2002
+++ linux-vger/drivers/block/ps2esdi.c	Sun Feb  3 19:18:10 2002
@@ -176,7 +176,8 @@
 		return -1;
 	}
 	/* set up some global information - indicating device specific info */
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &ps2esdi_lock);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_ps2esdi_request,
+			&ps2esdi_lock);
 	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 
 	/* some minor housekeeping - setup the global gendisk structure */
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/block/swim3.c linux-vger/drivers/block/swim3.c
--- /datenklo/ref/linux-vger/drivers/block/swim3.c	Mon Dec 17 17:18:03 2001
+++ linux-vger/drivers/block/swim3.c	Sun Feb  3 19:18:32 2002
@@ -1032,7 +1032,8 @@
 			       MAJOR_NR);
 			return -EBUSY;
 		}
-		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,&swim3_lock);
+		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_fd_request,
+				&swim3_lock);
 		blksize_size[MAJOR_NR] = floppy_blocksizes;
 		blk_size[MAJOR_NR] = floppy_sizes;
 	}
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/block/swim_iop.c linux-vger/drivers/block/swim_iop.c
--- /datenklo/ref/linux-vger/drivers/block/swim_iop.c	Mon Dec 17 17:18:03 2001
+++ linux-vger/drivers/block/swim_iop.c	Sun Feb  3 19:18:52 2002
@@ -149,7 +149,8 @@
 		       MAJOR_NR);
 		return -EBUSY;
 	}
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &swim_iop_lock);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_fd_request,
+			&swim_iop_lock);
 	blksize_size[MAJOR_NR] = floppy_blocksizes;
 	blk_size[MAJOR_NR] = floppy_sizes;
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/block/xd.c linux-vger/drivers/block/xd.c
--- /datenklo/ref/linux-vger/drivers/block/xd.c	Sun Jan 13 00:05:09 2002
+++ linux-vger/drivers/block/xd.c	Sun Feb  3 19:19:12 2002
@@ -170,7 +170,7 @@
 		return -1;
 	}
 	devfs_handle = devfs_mk_dir (NULL, xd_gendisk.major_name, NULL);
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &xd_lock);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_xd_request, &xd_lock);
 	read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read ahead */
 	add_gendisk(&xd_gendisk);
 	xd_geninit();
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/cdrom/aztcd.c linux-vger/drivers/cdrom/aztcd.c
--- /datenklo/ref/linux-vger/drivers/cdrom/aztcd.c	Sun Jan 13 00:05:11 2002
+++ linux-vger/drivers/cdrom/aztcd.c	Sun Feb  3 19:19:36 2002
@@ -1925,7 +1925,7 @@
 		       MAJOR_NR);
 		return -EIO;
 	}
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &aztSpin);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_aztcd_request, &aztSpin);
 	blksize_size[MAJOR_NR] = aztcd_blocksizes;
 	read_ahead[MAJOR_NR] = 4;
 	register_disk(NULL, mk_kdev(MAJOR_NR, 0), 1, &azt_fops, 0);
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/cdrom/cdu31a.c linux-vger/drivers/cdrom/cdu31a.c
--- /datenklo/ref/linux-vger/drivers/cdrom/cdu31a.c	Sun Jan 13 00:05:12 2002
+++ linux-vger/drivers/cdrom/cdu31a.c	Sun Feb  3 19:19:52 2002
@@ -3440,7 +3440,7 @@
 		    strcmp("CD-ROM CDU31A", drive_config.product_id) == 0;
 
 		blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR),
-			       DEVICE_REQUEST,
+			       do_cdu31a_request,
 			       &cdu31a_lock);
 		read_ahead[MAJOR_NR] = CDU31A_READAHEAD;
 		cdu31a_block_size = 1024;	/* 1kB default block size */
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/cdrom/cm206.c linux-vger/drivers/cdrom/cm206.c
--- /datenklo/ref/linux-vger/drivers/cdrom/cm206.c	Sun Jan 13 00:05:12 2002
+++ linux-vger/drivers/cdrom/cm206.c	Sun Feb  3 19:20:11 2002
@@ -1500,7 +1500,7 @@
 		return -EIO;
 	}
 	devfs_plain_cdrom(&cm206_info, &cm206_bdops);
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_cm206_request,
 		       &cm206_lock);
 	blksize_size[MAJOR_NR] = cm206_blocksizes;
 	read_ahead[MAJOR_NR] = 16;	/* reads ahead what? */
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/cdrom/gscd.c linux-vger/drivers/cdrom/gscd.c
--- /datenklo/ref/linux-vger/drivers/cdrom/gscd.c	Sun Jan 13 00:05:12 2002
+++ linux-vger/drivers/cdrom/gscd.c	Sun Feb  3 19:20:39 2002
@@ -1020,7 +1020,7 @@
 	devfs_register(NULL, "gscd", DEVFS_FL_DEFAULT, MAJOR_NR, 0,
 		       S_IFBLK | S_IRUGO | S_IWUGO, &gscd_fops, NULL);
 
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &gscd_lock);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_gscd_request, &gscd_lock);
 	blksize_size[MAJOR_NR] = gscd_blocksizes;
 	read_ahead[MAJOR_NR] = 4;
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/cdrom/mcd.c linux-vger/drivers/cdrom/mcd.c
--- /datenklo/ref/linux-vger/drivers/cdrom/mcd.c	Sun Jan 13 00:05:12 2002
+++ linux-vger/drivers/cdrom/mcd.c	Sun Feb  3 19:20:59 2002
@@ -1073,7 +1073,7 @@
 	}
 
 	blksize_size[MAJOR_NR] = mcd_blocksizes;
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_mcd_request,
 		       &mcd_spinlock);
 	read_ahead[MAJOR_NR] = 4;
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/cdrom/mcdx.c linux-vger/drivers/cdrom/mcdx.c
--- /datenklo/ref/linux-vger/drivers/cdrom/mcdx.c	Sun Jan 13 00:05:14 2002
+++ linux-vger/drivers/cdrom/mcdx.c	Sun Feb  3 19:21:11 2002
@@ -1182,7 +1182,7 @@
 		return 1;
 	}
 
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_mcdx_request,
 		       &mcdx_lock);
 	read_ahead[MAJOR_NR] = READ_AHEAD;
 	blksize_size[MAJOR_NR] = mcdx_blocksizes;
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/cdrom/optcd.c linux-vger/drivers/cdrom/optcd.c
--- /datenklo/ref/linux-vger/drivers/cdrom/optcd.c	Sun Jan 13 00:05:14 2002
+++ linux-vger/drivers/cdrom/optcd.c	Sun Feb  3 19:21:29 2002
@@ -2060,7 +2060,7 @@
 	devfs_register (NULL, "optcd", DEVFS_FL_DEFAULT, MAJOR_NR, 0,
 			S_IFBLK | S_IRUGO | S_IWUGO, &opt_fops, NULL);
 	blksize_size[MAJOR_NR] = &blksize;
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_optcd_request,
 		       &optcd_lock);
 	read_ahead[MAJOR_NR] = 4;
 	request_region(optcd_port, 4, "optcd");
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/cdrom/sbpcd.c linux-vger/drivers/cdrom/sbpcd.c
--- /datenklo/ref/linux-vger/drivers/cdrom/sbpcd.c	Sun Jan 13 00:05:15 2002
+++ linux-vger/drivers/cdrom/sbpcd.c	Sun Feb  3 19:22:11 2002
@@ -5864,7 +5864,7 @@
 		goto init_done;
 #endif /* MODULE */
 	}
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DO_SBPCD_REQUEST);
 #ifdef DONT_MERGE_REQUESTS
 	(BLK_DEFAULT_QUEUE(MAJOR_NR))->back_merge_fn = dont_bh_merge_fn;
 	(BLK_DEFAULT_QUEUE(MAJOR_NR))->front_merge_fn = dont_bh_merge_fn;
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/cdrom/sjcd.c linux-vger/drivers/cdrom/sjcd.c
--- /datenklo/ref/linux-vger/drivers/cdrom/sjcd.c	Sun Jan 13 00:05:16 2002
+++ linux-vger/drivers/cdrom/sjcd.c	Sun Feb  3 19:22:28 2002
@@ -1694,7 +1694,7 @@
 		return (-EIO);
 	}
 
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,&sjcd_lock);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_sjcd_request, &sjcd_lock);
 	read_ahead[MAJOR_NR] = 4;
 	register_disk(NULL, mk_kdev(MAJOR_NR, 0), 1, &sjcd_fops, 0);
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/cdrom/sonycd535.c linux-vger/drivers/cdrom/sonycd535.c
--- /datenklo/ref/linux-vger/drivers/cdrom/sonycd535.c	Sun Jan 13 00:05:22 2002
+++ linux-vger/drivers/cdrom/sonycd535.c	Sun Feb  3 19:22:53 2002
@@ -1596,7 +1596,9 @@
 							MAJOR_NR, CDU535_MESSAGE_NAME);
 					return -EIO;
 				}
-				blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &sonycd535_lock);
+				blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR),
+						do_cdu535_request,
+						&sonycd535_lock);
 				blksize_size[MAJOR_NR] = &sonycd535_block_size;
 				read_ahead[MAJOR_NR] = 8;	/* 8 sector (4kB) read-ahead */
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/ide/hd.c linux-vger/drivers/ide/hd.c
--- /datenklo/ref/linux-vger/drivers/ide/hd.c	Sun Jan 13 00:05:40 2002
+++ linux-vger/drivers/ide/hd.c	Sun Feb  3 19:29:18 2002
@@ -66,6 +66,7 @@
 
 static int revalidate_hddisk(kdev_t, int);
 
+#define TIMEOUT_VALUE	(6*HZ)
 #define	HD_DELAY	0
 
 #define MAX_ERRORS     16	/* Max read/write errors/sector */
@@ -835,7 +836,7 @@
 		printk("hd: unable to get major %d for hard disk\n",MAJOR_NR);
 		return -1;
 	}
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST, &hd_lock);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), do_hd_request, &hd_lock);
 	blk_queue_max_sectors(BLK_DEFAULT_QUEUE(MAJOR_NR), 255);
 	read_ahead[MAJOR_NR] = 8;		/* 8 sector (4kB) read-ahead */
 	add_gendisk(&hd_gendisk);
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/mtd/ftl.c linux-vger/drivers/mtd/ftl.c
--- /datenklo/ref/linux-vger/drivers/mtd/ftl.c	Sun Jan 13 00:06:07 2002
+++ linux-vger/drivers/mtd/ftl.c	Sun Feb  3 19:34:50 2002
@@ -95,8 +95,6 @@
 /* Funky stuff for setting up a block device */
 #define MAJOR_NR		FTL_MAJOR
 #define DEVICE_NAME		"ftl"
-#define DEVICE_REQUEST		do_ftl_request
-#define DEVICE_ON(device)
 #define DEVICE_OFF(device)
 
 #define DEVICE_NR(minor)	((minor)>>5)
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/mtd/mtdblock.c linux-vger/drivers/mtd/mtdblock.c
--- /datenklo/ref/linux-vger/drivers/mtd/mtdblock.c	Mon Jan 21 22:48:21 2002
+++ linux-vger/drivers/mtd/mtdblock.c	Sun Feb  3 21:11:10 2002
@@ -16,11 +16,8 @@
 
 #define MAJOR_NR MTD_BLOCK_MAJOR
 #define DEVICE_NAME "mtdblock"
-#define DEVICE_REQUEST mtdblock_request
 #define DEVICE_NR(device) (device)
-#define DEVICE_ON(device)
-#define DEVICE_OFF(device)
-#define DEVICE_NO_RANDOM
+#define LOCAL_END_REQUEST
 #include <linux/blk.h>
 /* for old kernels... */
 #ifndef QUEUE_EMPTY
@@ -459,7 +456,11 @@
 
 end_req:
 		spin_lock_irq(&QUEUE->queue_lock);
-		end_request(res);
+		if (!end_that_request_first(req, uptodate, req->hard_cur_sectors)) {
+			blkdev_dequeue_request(req);
+			end_that_request_last(req);
+		}
+
 	}
 }
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/mtd/mtdblock_ro.c linux-vger/drivers/mtd/mtdblock_ro.c
--- /datenklo/ref/linux-vger/drivers/mtd/mtdblock_ro.c	Sat Oct 27 22:15:21 2001
+++ linux-vger/drivers/mtd/mtdblock_ro.c	Sun Feb  3 21:09:49 2002
@@ -16,13 +16,10 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/compatmac.h>
 
+#define LOCAL_END_REQUEST
 #define MAJOR_NR MTD_BLOCK_MAJOR
 #define DEVICE_NAME "mtdblock"
-#define DEVICE_REQUEST mtdblock_request
 #define DEVICE_NR(device) (device)
-#define DEVICE_ON(device)
-#define DEVICE_OFF(device)
-#define DEVICE_NO_RANDOM
 #include <linux/blk.h>
 
 #if LINUX_VERSION_CODE < 0x20300
@@ -97,8 +94,15 @@
 	DEBUG(1, "ok\n");
 
 	release_return(0);
-}  
+}
 
+static inline void mtdblock_end_request(struct request *req, int uptodate)
+{
+	if (end_that_request_first(req, uptodate, req->hard_cur_sectors))
+		return;
+	blkdev_dequeue_request(req);
+	end_that_request_last(req);
+}
 
 static void mtdblock_request(RQFUNC_ARG)
 {
@@ -116,7 +120,7 @@
       if (MINOR(current_request->rq_dev) >= MAX_MTD_DEVICES)
       {
 	 printk("mtd: Unsupported device!\n");
-	 end_request(0);
+	 mtdblock_end_request(current_request, 0);
 	 continue;
       }
       
@@ -125,7 +129,7 @@
       mtd = __get_mtd_device(NULL, MINOR(current_request->rq_dev));
       if (!mtd) {
 	      printk("MTD device %d doesn't appear to exist any more\n", CURRENT_DEV);
-	      end_request(0);
+	      mtdblock_end_request(current_request, 0);
       }
 
       if (current_request->sector << 9 > mtd->size ||
@@ -133,7 +137,7 @@
       {
 	 printk("mtd: Attempt to read past end of device!\n");
 	 printk("size: %x, sector: %lx, nr_sectors %lx\n", mtd->size, current_request->sector, current_request->nr_sectors);
-	 end_request(0);
+	 mtdblock_end_request(current_request, 0);
 	 continue;
       }
       
@@ -192,7 +196,7 @@
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
 	spin_lock_irq(&io_request_lock);
 #endif
-	end_request(res);
+	mtdblock_end_request(current_request, res);
    }
 }
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/mtd/nftlcore.c linux-vger/drivers/mtd/nftlcore.c
--- /datenklo/ref/linux-vger/drivers/mtd/nftlcore.c	Sun Jan 13 00:06:08 2002
+++ linux-vger/drivers/mtd/nftlcore.c	Sun Feb  3 19:23:35 2002
@@ -40,7 +40,6 @@
 
 /* NFTL block device stuff */
 #define MAJOR_NR NFTL_MAJOR
-#define DEVICE_REQUEST nftl_request
 #define DEVICE_OFF(device)
 
 
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/s390/block/xpram.c linux-vger/drivers/s390/block/xpram.c
--- /datenklo/ref/linux-vger/drivers/s390/block/xpram.c	Wed Jan 16 21:47:51 2002
+++ linux-vger/drivers/s390/block/xpram.c	Sun Feb  3 21:12:38 2002
@@ -97,8 +97,7 @@
 #define DEVICE_NR(device) MINOR(device)   /* xpram has no partition bits */
 #define DEVICE_NAME "xpram"               /* name for messaging */
 #define DEVICE_INTR xpram_intrptr         /* pointer to the bottom half */
-#define DEVICE_NO_RANDOM                  /* no entropy to contribute */
-#define DEVICE_OFF(d)                     /* do-nothing */
+#define LOCAL_END_REQUEST
 
 #include <linux/blk.h>
 
@@ -147,10 +146,6 @@
 
 #define DEVICE_OFF(d) /* do-nothing */
 
-#define DEVICE_REQUEST *xpram_dummy_device_request  /* dummy function variable 
-						     * to prevent warnings 
-						     */#include <linux/blk.h>
-
 #include "xpram.h"        /* local definitions */
 #endif /* V22 */
 
@@ -749,6 +744,16 @@
  * Block-driver specific functions
  */
 
+static inline void end_request(int uptodate)
+{
+	struct request *req = CURRENT;
+
+	if (end_that_request_first(req, uptodate, req->hard_cur_sectors))
+		return;
+	blkdev_dequeue_request(req);
+	end_that_request_last(req);
+}
+
 void xpram_request(request_queue_t * queue)
 {
 	Xpram_Dev *device;
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/sbus/char/jsflash.c linux-vger/drivers/sbus/char/jsflash.c
--- /datenklo/ref/linux-vger/drivers/sbus/char/jsflash.c	Wed Dec 12 22:02:39 2001
+++ linux-vger/drivers/sbus/char/jsflash.c	Sun Feb  3 21:16:21 2002
@@ -43,11 +43,8 @@
 #define MAJOR_NR	JSFD_MAJOR
 
 #define DEVICE_NAME "jsfd"
-#define DEVICE_REQUEST jsfd_do_request
 #define DEVICE_NR(device) (MINOR(device))
-#define DEVICE_ON(device)
-#define DEVICE_OFF(device)
-#define DEVICE_NO_RANDOM
+#define LOCAL_END_REQUEST
 
 #include <linux/blk.h>
 
@@ -199,6 +196,14 @@
 	}
 }
 
+static inline void jfsd_end_request(struct request *req, int uptodate)
+{
+	if (!end_that_request_first(req, uptodate, req->hard_cur_sectors)) {
+		blkdev_dequeue_request(req);
+		end_that_request_last(req);
+	}
+}
+
 static void jsfd_do_request(request_queue_t *q)
 {
 	struct request *req;
@@ -206,6 +211,7 @@
 	struct jsfd_part *jdp;
 	unsigned long offset;
 	size_t len;
+	int uptodate;
 
 	for (;;) {
 		INIT_REQUEST;	/* if (QUEUE_EMPTY) return; */
@@ -213,7 +219,7 @@
 
 		dev = MINOR(req->rq_dev);
 		if (dev >= JSF_MAX || (dev & JSF_PART_MASK) >= JSF_NPART) {
-			end_request(0);
+			jfsd_end_request(req, 0);
 			continue;
 		}
 		jdp = &jsf0.dv[dev & JSF_PART_MASK];
@@ -221,31 +227,31 @@
 		offset = req->sector << 9;
 		len = req->current_nr_sectors << 9;
 		if ((offset + len) > jdp->dsize) {
-               		end_request(0);
+               		jfsd_end_request(req, 0);
 			continue;
 		}
 
 		if (req->cmd == WRITE) {
 			printk(KERN_ERR "jsfd: write\n");
-			end_request(0);
+			jfsd_end_request(req, 0);
 			continue;
 		}
 		if (req->cmd != READ) {
 			printk(KERN_ERR "jsfd: bad req->cmd %d\n", req->cmd);
-			end_request(0);
+			jfsd_end_request(req, 0);
 			continue;
 		}
 
 		if ((jdp->dbase & 0xff000000) != 0x20000000) {
 			printk(KERN_ERR "jsfd: bad base %x\n", (int)jdp->dbase);
-			end_request(0);
+			jfsd_end_request(req, 0);
 			continue;
 		}
 
 /* printk("jsfd%d: read buf %p off %x len %x\n", dev, req->buffer, (int)offset, (int)len); */ /* P3 */
 		jsfd_read(req->buffer, jdp->dbase + offset, len);
 
-		end_request(1);
+		jfsd_end_request(req, 1);
 	}
 }
 
@@ -661,7 +667,7 @@
 	blksize_size[JSFD_MAJOR] = jsfd_blksizes;
 	blk_size[JSFD_MAJOR] = jsfd_sizes;
 
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), jsfd_do_request);
 	for (i = 0; i < JSF_MAX; i++) {
 		if ((i & JSF_PART_MASK) >= JSF_NPART) continue;
 		jsf = &jsf0;	/* actually, &jsfv[i >> JSF_PART_BITS] */
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/scsi/sd.c linux-vger/drivers/scsi/sd.c
--- /datenklo/ref/linux-vger/drivers/scsi/sd.c	Sun Jan 13 00:07:22 2002
+++ linux-vger/drivers/scsi/sd.c	Sun Feb  3 21:18:07 2002
@@ -50,6 +50,7 @@
 #include <asm/io.h>
 
 #define MAJOR_NR SCSI_DISK0_MAJOR
+#define LOCAL_END_REQUEST
 #include <linux/blk.h>
 #include <linux/blkpg.h>
 #include "scsi.h"
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/drivers/scsi/sr.c linux-vger/drivers/scsi/sr.c
--- /datenklo/ref/linux-vger/drivers/scsi/sr.c	Fri Jan 25 13:10:50 2002
+++ linux-vger/drivers/scsi/sr.c	Sun Feb  3 21:18:27 2002
@@ -49,6 +49,7 @@
 #include <asm/uaccess.h>
 
 #define MAJOR_NR SCSI_CDROM_MAJOR
+#define LOCAL_END_REQUEST
 #include <linux/blk.h>
 #include "scsi.h"
 #include "hosts.h"
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/err.log linux-vger/err.log
--- /datenklo/ref/linux-vger/err.log	Thu Jan  1 01:00:00 1970
+++ linux-vger/err.log	Sun Feb  3 21:44:22 2002
@@ -0,0 +1 @@
+md5sum: WARNING: 9 of 13 computed checksums did NOT match
diff -uNr -Xdontdiff /datenklo/ref/linux-vger/include/linux/blk.h linux-vger/include/linux/blk.h
--- /datenklo/ref/linux-vger/include/linux/blk.h	Fri Jan 25 13:15:15 2002
+++ linux-vger/include/linux/blk.h	Sun Feb  3 21:25:23 2002
@@ -99,9 +99,6 @@
 	
 #if defined(MAJOR_NR) || defined(IDE_DRIVER)
 
-#undef DEVICE_ON
-#undef DEVICE_OFF
-
 /*
  * Add entries as needed.
  */
@@ -116,13 +113,11 @@
 /* ram disk */
 #define DEVICE_NAME "ramdisk"
 #define DEVICE_NR(device) (minor(device))
-#define DEVICE_NO_RANDOM
 
 #elif (MAJOR_NR == Z2RAM_MAJOR)
 
 /* Zorro II Ram */
 #define DEVICE_NAME "Z2RAM"
-#define DEVICE_REQUEST do_z2_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == FLOPPY_MAJOR)
@@ -131,30 +126,24 @@
 
 #define DEVICE_NAME "floppy"
 #define DEVICE_INTR do_floppy
-#define DEVICE_REQUEST do_fd_request
 #define DEVICE_NR(device) ( (minor(device) & 3) | ((minor(device) & 0x80 ) >> 5 ))
-#define DEVICE_OFF(device) floppy_off(DEVICE_NR(device))
 
 #elif (MAJOR_NR == HD_MAJOR)
 
 /* Hard disk:  timeout is 6 seconds. */
 #define DEVICE_NAME "hard disk"
 #define DEVICE_INTR do_hd
-#define TIMEOUT_VALUE (6*HZ)
-#define DEVICE_REQUEST do_hd_request
 #define DEVICE_NR(device) (minor(device)>>6)
 
 #elif (SCSI_DISK_MAJOR(MAJOR_NR))
 
 #define DEVICE_NAME "scsidisk"
-#define TIMEOUT_VALUE (2*HZ)
 #define DEVICE_NR(device) (((major(device) & SD_MAJOR_MASK) << (8 - 4)) + (minor(device) >> 4))
 
 /* Kludge to use the same number for both char and block major numbers */
 #elif  (MAJOR_NR == MD_MAJOR) && defined(MD_DRIVER)
 
 #define DEVICE_NAME "Multiple devices driver"
-#define DEVICE_REQUEST do_md_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == SCSI_TAPE_MAJOR)
@@ -168,8 +157,6 @@
 #define DEVICE_NAME "onstream" 
 #define DEVICE_INTR do_osst
 #define DEVICE_NR(device) (minor(device) & 0x7f) 
-#define DEVICE_ON(device) 
-#define DEVICE_OFF(device) 
 
 #elif (MAJOR_NR == SCSI_CDROM_MAJOR)
 
@@ -179,163 +166,129 @@
 #elif (MAJOR_NR == XT_DISK_MAJOR)
 
 #define DEVICE_NAME "xt disk"
-#define DEVICE_REQUEST do_xd_request
 #define DEVICE_NR(device) (minor(device) >> 6)
 
 #elif (MAJOR_NR == PS2ESDI_MAJOR)
 
 #define DEVICE_NAME "PS/2 ESDI"
-#define DEVICE_REQUEST do_ps2esdi_request
 #define DEVICE_NR(device) (minor(device) >> 6)
 
 #elif (MAJOR_NR == CDU31A_CDROM_MAJOR)
 
 #define DEVICE_NAME "CDU31A"
-#define DEVICE_REQUEST do_cdu31a_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == ACSI_MAJOR) && (defined(CONFIG_ATARI_ACSI) || defined(CONFIG_ATARI_ACSI_MODULE))
 
 #define DEVICE_NAME "ACSI"
 #define DEVICE_INTR do_acsi
-#define DEVICE_REQUEST do_acsi_request
 #define DEVICE_NR(device) (minor(device) >> 4)
 
 #elif (MAJOR_NR == MITSUMI_CDROM_MAJOR)
 
 #define DEVICE_NAME "Mitsumi CD-ROM"
 /* #define DEVICE_INTR do_mcd */
-#define DEVICE_REQUEST do_mcd_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == MITSUMI_X_CDROM_MAJOR)
 
 #define DEVICE_NAME "Mitsumi CD-ROM"
 /* #define DEVICE_INTR do_mcdx */
-#define DEVICE_REQUEST do_mcdx_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == MATSUSHITA_CDROM_MAJOR)
 
 #define DEVICE_NAME "Matsushita CD-ROM controller #1"
-#define DEVICE_REQUEST do_sbpcd_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == MATSUSHITA_CDROM2_MAJOR)
 
 #define DEVICE_NAME "Matsushita CD-ROM controller #2"
-#define DEVICE_REQUEST do_sbpcd2_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == MATSUSHITA_CDROM3_MAJOR)
 
 #define DEVICE_NAME "Matsushita CD-ROM controller #3"
-#define DEVICE_REQUEST do_sbpcd3_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == MATSUSHITA_CDROM4_MAJOR)
 
 #define DEVICE_NAME "Matsushita CD-ROM controller #4"
-#define DEVICE_REQUEST do_sbpcd4_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == AZTECH_CDROM_MAJOR)
 
 #define DEVICE_NAME "Aztech CD-ROM"
-#define DEVICE_REQUEST do_aztcd_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == CDU535_CDROM_MAJOR)
 
 #define DEVICE_NAME "SONY-CDU535"
 #define DEVICE_INTR do_cdu535
-#define DEVICE_REQUEST do_cdu535_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == GOLDSTAR_CDROM_MAJOR)
 
 #define DEVICE_NAME "Goldstar R420"
-#define DEVICE_REQUEST do_gscd_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == CM206_CDROM_MAJOR)
 #define DEVICE_NAME "Philips/LMS CD-ROM cm206"
-#define DEVICE_REQUEST do_cm206_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == OPTICS_CDROM_MAJOR)
 
 #define DEVICE_NAME "DOLPHIN 8000AT CD-ROM"
-#define DEVICE_REQUEST do_optcd_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == SANYO_CDROM_MAJOR)
 
 #define DEVICE_NAME "Sanyo H94A CD-ROM"
-#define DEVICE_REQUEST do_sjcd_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == APBLOCK_MAJOR)
 
 #define DEVICE_NAME "apblock"
-#define DEVICE_REQUEST ap_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == DDV_MAJOR)
 
 #define DEVICE_NAME "ddv"
-#define DEVICE_REQUEST ddv_request
 #define DEVICE_NR(device) (minor(device)>>PARTN_BITS)
 
 #elif (MAJOR_NR == MFM_ACORN_MAJOR)
 
 #define DEVICE_NAME "mfm disk"
 #define DEVICE_INTR do_mfm
-#define DEVICE_REQUEST do_mfm_request
 #define DEVICE_NR(device) (minor(device) >> 6)
 
 #elif (MAJOR_NR == NBD_MAJOR)
 
 #define DEVICE_NAME "nbd"
-#define DEVICE_REQUEST do_nbd_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == MDISK_MAJOR)
 
 #define DEVICE_NAME "mdisk"
-#define DEVICE_REQUEST mdisk_request
 #define DEVICE_NR(device) (minor(device))
 
 #elif (MAJOR_NR == DASD_MAJOR)
 
 #define DEVICE_NAME "dasd"
-#define DEVICE_REQUEST do_dasd_request
 #define DEVICE_NR(device) (minor(device) >> PARTN_BITS)
 
 #elif (MAJOR_NR == I2O_MAJOR)
 
 #define DEVICE_NAME "I2O block"
-#define DEVICE_REQUEST i2ob_request
 #define DEVICE_NR(device) (minor(device)>>4)
 
 #elif (MAJOR_NR == COMPAQ_SMART2_MAJOR)
 
 #define DEVICE_NAME "ida"
-#define TIMEOUT_VALUE (25*HZ)
-#define DEVICE_REQUEST do_ida_request
 #define DEVICE_NR(device) (minor(device) >> 4)
 
 #endif /* MAJOR_NR == whatever */
 
-/* provide DEVICE_xxx defaults, if not explicitly defined
- * above in the MAJOR_NR==xxx if-elif tree */
-#ifndef DEVICE_ON
-#define DEVICE_ON(device) do {} while (0)
-#endif
-#ifndef DEVICE_OFF
-#define DEVICE_OFF(device) do {} while (0)
-#endif
-
 #if (MAJOR_NR != SCSI_TAPE_MAJOR) && (MAJOR_NR != OSST_MAJOR)
 #if !defined(IDE_DRIVER)
 
@@ -348,8 +301,6 @@
 #ifndef QUEUE_EMPTY
 #define QUEUE_EMPTY blk_queue_empty(QUEUE)
 #endif
-
-
 #ifndef DEVICE_NAME
 #define DEVICE_NAME "unknown"
 #endif
@@ -362,10 +313,6 @@
 
 #define SET_INTR(x) (DEVICE_INTR = (x))
 
-#ifdef DEVICE_REQUEST
-static void (DEVICE_REQUEST)(request_queue_t *);
-#endif 
-  
 #ifdef DEVICE_INTR
 #define CLEAR_INTR SET_INTR(NULL)
 #else
@@ -384,11 +331,10 @@
 
 #endif /* !defined(IDE_DRIVER) */
 
-
-#ifndef LOCAL_END_REQUEST	/* If we have our own end_request, we do not want to include this mess */
-
-#if ! SCSI_BLK_MAJOR(MAJOR_NR) && (MAJOR_NR != COMPAQ_SMART2_MAJOR)
-
+/*
+ * If we have our own end_request, we do not want to include this mess
+ */
+#ifndef LOCAL_END_REQUEST
 static inline void end_request(int uptodate)
 {
 	struct request *req = CURRENT;
@@ -396,17 +342,11 @@
 	if (end_that_request_first(req, uptodate, CURRENT->hard_cur_sectors))
 		return;
 
-#ifndef DEVICE_NO_RANDOM
 	add_blkdev_randomness(major(req->rq_dev));
-#endif
-	DEVICE_OFF(req->rq_dev);
 	blkdev_dequeue_request(req);
 	end_that_request_last(req);
 }
-
-#endif /* ! SCSI_BLK_MAJOR(MAJOR_NR) */
-#endif /* LOCAL_END_REQUEST */
-
+#endif /* !LOCAL_END_REQUEST */
 #endif /* (MAJOR_NR != SCSI_TAPE_MAJOR) */
 #endif /* defined(MAJOR_NR) || defined(IDE_DRIVER) */
 
