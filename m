Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283770AbRK3TBL>; Fri, 30 Nov 2001 14:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283769AbRK3TAx>; Fri, 30 Nov 2001 14:00:53 -0500
Received: from mail2.home.nl ([213.51.129.226]:58567 "EHLO mail2.home.nl")
	by vger.kernel.org with ESMTP id <S280960AbRK3TAm>;
	Fri, 30 Nov 2001 14:00:42 -0500
Message-ID: <3C07D770.3010807@home.nl>
Date: Fri, 30 Nov 2001 20:01:04 +0100
From: Gertjan van Wingerde <gwingerde@home.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011123
X-Accept-Language: en-us
MIME-Version: 1.0
To: axboe@suse.de, torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: Compile fixes for 2.5.1-pre4
Content-Type: multipart/mixed;
 boundary="------------030402020901000306020006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030402020901000306020006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jens/Linux,

Please find attached a patch on 2.5.1-pre4 with compile fixes for:
	1. zftape code
	2. ISDN divert code
	3. Linear MD code
	4. RAID-0 MD code

	MvG/Best regards,

		Gertjan

--------------030402020901000306020006
Content-Type: text/plain;
 name="patch-2.5.1-pre4-fixes"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.5.1-pre4-fixes"

diff -u --recursive linux-2.5.1-preX/drivers/char/ftape/zftape/zftape-init.c linux-2.5.x/drivers/char/ftape/zftape/zftape-init.c
--- linux-2.5.1-preX/drivers/char/ftape/zftape/zftape-init.c	Fri Nov 30 19:31:00 2001
+++ linux-2.5.x/drivers/char/ftape/zftape/zftape-init.c	Fri Nov 30 19:47:19 2001
@@ -114,7 +114,7 @@
 	TRACE_FUN(ft_t_flow);
 
 	TRACE(ft_t_flow, "called for minor %d", MINOR(ino->i_rdev));
-	if ( test_and_set_bit(0,&busy_flag) )) {
+	if ( test_and_set_bit(0,&busy_flag) ) {
 		TRACE_ABORT(-EBUSY, ft_t_warn, "failed: already busy");
 	}
 	if ((MINOR(ino->i_rdev) & ~(ZFT_MINOR_OP_MASK | FTAPE_NO_REWIND))
diff -u --recursive linux-2.5.1-preX/drivers/isdn/divert/divert_procfs.c linux-2.5.x/drivers/isdn/divert/divert_procfs.c
--- linux-2.5.1-preX/drivers/isdn/divert/divert_procfs.c	Fri Nov 30 19:31:02 2001
+++ linux-2.5.x/drivers/isdn/divert/divert_procfs.c	Fri Nov 30 19:49:33 2001
@@ -58,7 +58,6 @@
 	else
 		divert_info_tail->next = ib;	/* follows existing messages */
 	divert_info_tail = ib;	/* new tail */
-	restore_flags(flags);
 
 	/* delete old entrys */
 	while (divert_info_head->next) {
@@ -70,7 +69,7 @@
 		} else
 			break;
 	}			/* divert_info_head->next */
-	spin_lock_irqrestore( &divert_info_lock, flags );
+	spin_unlock_irqrestore( &divert_info_lock, flags );
 	wake_up_interruptible(&(rd_queue));
 }				/* put_info_buffer */
 
@@ -163,14 +162,13 @@
 		inf->usage_cnt--;
 		inf = inf->next;
 	}
-	restore_flags(flags);
 	if (if_used <= 0)
 		while (divert_info_head) {
 			inf = divert_info_head;
 			divert_info_head = divert_info_head->next;
 			kfree(inf);
 		}
-	spin_unlock_irq( &divert_info_lock, flags );
+	spin_unlock_irqrestore( &divert_info_lock, flags );
 	return (0);
 }				/* isdn_divert_close */
 
diff -u --recursive linux-2.5.1-preX/drivers/md/linear.c linux-2.5.x/drivers/md/linear.c
--- linux-2.5.1-preX/drivers/md/linear.c	Sun Sep 30 21:26:06 2001
+++ linux-2.5.x/drivers/md/linear.c	Wed Nov 28 21:18:02 2001
@@ -119,22 +119,21 @@
 	return 0;
 }
 
-static int linear_make_request (mddev_t *mddev,
-			int rw, struct buffer_head * bh)
+static int linear_make_request (mddev_t *mddev, int rw, struct bio *bio)
 {
         linear_conf_t *conf = mddev_to_conf(mddev);
         struct linear_hash *hash;
         dev_info_t *tmp_dev;
         long block;
 
-	block = bh->b_rsector >> 1;
+	block = bio->bi_sector >> 1;
 	hash = conf->hash_table + (block / conf->smallest->size);
   
 	if (block >= (hash->dev0->size + hash->dev0->offset)) {
 		if (!hash->dev1) {
 			printk ("linear_make_request : hash->dev1==NULL for block %ld\n",
 						block);
-			buffer_IO_error(bh);
+			bio_io_error(bio);
 			return 0;
 		}
 		tmp_dev = hash->dev1;
@@ -144,11 +143,11 @@
 	if (block >= (tmp_dev->size + tmp_dev->offset)
 				|| block < tmp_dev->offset) {
 		printk ("linear_make_request: Block %ld out of bounds on dev %s size %ld offset %ld\n", block, kdevname(tmp_dev->dev), tmp_dev->size, tmp_dev->offset);
-		buffer_IO_error(bh);
+		bio_io_error(bio);
 		return 0;
 	}
-	bh->b_rdev = tmp_dev->dev;
-	bh->b_rsector = bh->b_rsector - (tmp_dev->offset << 1);
+	bio->bi_dev = tmp_dev->dev;
+	bio->bi_sector = bio->bi_sector - (tmp_dev->offset << 1);
 
 	return 1;
 }
diff -u --recursive linux-2.5.1-preX/drivers/md/raid0.c linux-2.5.x/drivers/md/raid0.c
--- linux-2.5.1-preX/drivers/md/raid0.c	Sun Sep 30 21:26:06 2001
+++ linux-2.5.x/drivers/md/raid0.c	Thu Nov 29 19:27:53 2001
@@ -223,8 +223,7 @@
  * Of course, those facts may not be valid anymore (and surely won't...)
  * Hey guys, there's some work out there ;-)
  */
-static int raid0_make_request (mddev_t *mddev,
-			       int rw, struct buffer_head * bh)
+static int raid0_make_request (mddev_t *mddev, int rw, struct bio *bio)
 {
 	unsigned int sect_in_chunk, chunksize_bits,  chunk_size;
 	raid0_conf_t *conf = mddev_to_conf(mddev);
@@ -235,11 +234,11 @@
 
 	chunk_size = mddev->param.chunk_size >> 10;
 	chunksize_bits = ffz(~chunk_size);
-	block = bh->b_rsector >> 1;
+	block = bio->bi_sector >> 1;
 	hash = conf->hash_table + block / conf->smallest->size;
 
 	/* Sanity check */
-	if (chunk_size < (block % chunk_size) + (bh->b_size >> 10))
+	if (chunk_size < (block % chunk_size) + (bio->bi_size >> 10))
 		goto bad_map;
  
 	if (!hash)
@@ -255,7 +254,7 @@
 	} else
 		zone = hash->zone0;
     
-	sect_in_chunk = bh->b_rsector & ((chunk_size<<1) -1);
+	sect_in_chunk = bio->bi_sector & ((chunk_size<<1) -1);
 	chunk = (block - zone->zone_offset) / (zone->nb_dev << chunksize_bits);
 	tmp_dev = zone->dev[(block >> chunksize_bits) % zone->nb_dev];
 	rsect = (((chunk << chunksize_bits) + zone->dev_offset)<<1)
@@ -265,8 +264,8 @@
 	 * The new BH_Lock semantics in ll_rw_blk.c guarantee that this
 	 * is the only IO operation happening on this bh.
 	 */
-	bh->b_rdev = tmp_dev->dev;
-	bh->b_rsector = rsect;
+	bio->bi_dev = tmp_dev->dev;
+	bio->bi_sector = rsect;
 
 	/*
 	 * Let the main block layer submit the IO and resolve recursion:
@@ -274,7 +273,7 @@
 	return 1;
 
 bad_map:
-	printk ("raid0_make_request bug: can't convert block across chunks or bigger than %dk %ld %d\n", chunk_size, bh->b_rsector, bh->b_size >> 10);
+	printk ("raid0_make_request bug: can't convert block across chunks or bigger than %dk %ld %d\n", chunk_size, bio->bi_sector, bio->bi_size >> 10);
 	goto outerr;
 bad_hash:
 	printk("raid0_make_request bug: hash==NULL for block %ld\n", block);
@@ -285,7 +284,7 @@
 bad_zone1:
 	printk ("raid0_make_request bug: hash->zone1==NULL for block %ld\n", block);
  outerr:
-	buffer_IO_error(bh);
+	bio_io_error(bio);
 	return 0;
 }
 			   

--------------030402020901000306020006--

