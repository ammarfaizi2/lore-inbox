Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318173AbSHWFnU>; Fri, 23 Aug 2002 01:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318202AbSHWFnU>; Fri, 23 Aug 2002 01:43:20 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:4606 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S318173AbSHWFnK>; Fri, 23 Aug 2002 01:43:10 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15717.52317.654149.636236@wombat.chubb.wattle.id.au>
Date: Fri, 23 Aug 2002 15:47:09 +1000
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org
Subject: Large block device patch, part 1 of 9
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
   This is the first of nine parts of the large block device patch.

This part just fixes printk() formats to allow sector_t to be either
32 or 64 bit.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.508   -> 1.509  
#	drivers/block/ps2esdi.c	1.44    -> 1.45   
#	  drivers/md/raid1.c	1.38    -> 1.39   
#	drivers/mtd/nftlcore.c	1.28    -> 1.29   
#	     fs/jbd/revoke.c	1.9     -> 1.10   
#	drivers/block/ll_rw_blk.c	1.98    -> 1.99   
#	drivers/block/floppy.c	1.35    -> 1.36   
#	  drivers/md/raid5.c	1.37    -> 1.38   
#	   drivers/scsi/sd.c	1.51    -> 1.52   
#	     drivers/md/md.c	1.92    -> 1.93   
#	   drivers/ide/ide.c	1.1     -> 1.2    
#	     fs/jbd/commit.c	1.12    -> 1.13   
#	drivers/ide/ide-disk.c	1.1     -> 1.2    
#	drivers/ide/ide-cd.c	1.1     -> 1.2    
#	 fs/reiserfs/super.c	1.51    -> 1.52   
#	drivers/md/multipath.c	1.32    -> 1.33   
#	drivers/block/genhd.c	1.27    -> 1.28   
#	    fs/ext3/ialloc.c	1.13    -> 1.14   
#	 drivers/scsi/scsi.c	1.34    -> 1.35   
#	  drivers/md/raid0.c	1.13    -> 1.14   
#	drivers/block/loop.c	1.54    -> 1.55   
#	fs/reiserfs/journal.c	1.53    -> 1.54   
#	fs/reiserfs/prints.c	1.19    -> 1.20   
#	    fs/isofs/inode.c	1.23    -> 1.24   
#	drivers/block/cciss.c	1.51    -> 1.52   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/23	peterc@numbat.chubb.wattle.id.au	1.509
# Adjust printk formats and arguments to allow block and sector numbers
# to be 64-bit, even on 32 bit platforms.
# --------------------------------------------
#
diff -Nru a/drivers/block/cciss.c b/drivers/block/cciss.c
--- a/drivers/block/cciss.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/block/cciss.c	Fri Aug 23 11:59:05 2002
@@ -175,8 +175,8 @@
                 drv = &h->drv[i];
 		if (drv->block_size == 0)
 			continue;
-                size = sprintf(buffer+len, "cciss/c%dd%d: blksz=%d nr_blocks=%d\n",
-                                ctlr, i, drv->block_size, drv->nr_blocks);
+                size = sprintf(buffer+len, "cciss/c%dd%d: blksz=%d nr_blocks=%llu\n",
+                                ctlr, i, drv->block_size, (unsigned long long)drv->nr_blocks);
                 pos += size; len += size;
         }
 
diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/block/floppy.c	Fri Aug 23 11:59:05 2002
@@ -2998,7 +2998,7 @@
 
 	if (usage_count == 0) {
 		printk("warning: usage count=0, CURRENT=%p exiting\n", CURRENT);
-		printk("sect=%ld flags=%lx\n", CURRENT->sector, CURRENT->flags);
+		printk("sect=%llu flags=%lx\n", (unsigned long long)CURRENT->sector, CURRENT->flags);
 		return;
 	}
 	if (fdc_busy){
diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/block/genhd.c	Fri Aug 23 11:59:05 2002
@@ -164,9 +164,9 @@
 		int minormask = (1<<sgp->minor_shift) - 1;
 		if ((n & minormask) && sgp->part[n].nr_sects == 0)
 			continue;
-		seq_printf(part, "%4d  %4d %10ld %s\n",
+		seq_printf(part, "%4d  %4d %10llu %s\n",
 			sgp->major, n + sgp->first_minor,
-			sgp->part[n].nr_sects >> 1 ,
+			(unsigned long long)sgp->part[n].nr_sects >> 1 ,
 			disk_name(sgp, n + sgp->first_minor, buf));
 	}
 
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/block/ll_rw_blk.c	Fri Aug 23 11:59:05 2002
@@ -558,7 +558,7 @@
 	} while (bit < __REQ_NR_BITS);
 
 	if (rq->flags & REQ_CMD)
-		printk("sector %lu, nr/cnr %lu/%u\n", rq->sector,
+		printk("sector %llu, nr/cnr %lu/%u\n", (unsigned long long)rq->sector,
 						       rq->nr_sectors,
 						       rq->current_nr_sectors);
 
@@ -1672,10 +1672,10 @@
 			 * device, e.g., when mounting a device. */
 			printk(KERN_INFO
 			       "attempt to access beyond end of device\n");
-			printk(KERN_INFO "%s: rw=%ld, want=%ld, limit=%Lu\n",
+			printk(KERN_INFO "%s: rw=%ld, want=%Lu, limit=%Lu\n",
 			       bdevname(bio->bi_bdev),
 			       bio->bi_rw,
-			       sector + nr_sectors,
+			       (unsigned long long) sector + nr_sectors,
 			       (long long) maxsector);
 
 			set_bit(BIO_EOF, &bio->bi_flags);
@@ -1979,8 +1979,8 @@
 
 	req->errors = 0;
 	if (!uptodate)
-		printk("end_request: I/O error, dev %s, sector %lu\n",
-			kdevname(req->rq_dev), req->sector);
+		printk("end_request: I/O error, dev %s, sector %llu\n",
+			kdevname(req->rq_dev), (unsigned long long)req->sector);
 
 	total_nsect = 0;
 	while ((bio = req->bio)) {
diff -Nru a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/block/loop.c	Fri Aug 23 11:59:05 2002
@@ -218,7 +218,7 @@
 			 * The transfer failed, but we still write the data to
 			 * keep prepare/commit calls balanced.
 			 */
-			printk(KERN_ERR "loop: transfer error block %ld\n", index);
+			printk(KERN_ERR "loop: transfer error block %llu\n", (unsigned long long)index);
 			memset(kaddr + offset, 0, size);
 		}
 		if (aops->commit_write(file, page, offset, offset+size))
diff -Nru a/drivers/block/ps2esdi.c b/drivers/block/ps2esdi.c
--- a/drivers/block/ps2esdi.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/block/ps2esdi.c	Fri Aug 23 11:59:05 2002
@@ -540,7 +540,7 @@
 	/* is request is valid */ 
 	else {
 		printk("Grrr. error. ps2esdi_drives: %d, %lu %lu\n", ps2esdi_drives,
-		       CURRENT->sector, ps2esdi[minor(CURRENT->rq_dev)].nr_sects);
+		       (unsigned long)CURRENT->sector, (unsigned long)ps2esdi[minor(CURRENT->rq_dev)].nr_sects);
 		end_request(CURRENT, FAIL);
 	}
 
diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/ide/ide-cd.c	Fri Aug 23 11:59:05 2002
@@ -1173,7 +1173,7 @@
 	if (rq->current_nr_sectors < bio_sectors(rq->bio) &&
 	    (rq->sector % SECTORS_PER_FRAME) != 0) {
 		printk ("%s: cdrom_read_from_buffer: buffer botch (%ld)\n",
-			drive->name, rq->sector);
+			drive->name, (long)rq->sector);
 		cdrom_end_request(drive, 0);
 		return -1;
 	}
diff -Nru a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/ide/ide-disk.c	Fri Aug 23 11:59:05 2002
@@ -843,7 +843,7 @@
 				}
 			}
 			if (HWGROUP(drive) && HWGROUP(drive)->rq)
-				printk(", sector=%ld", HWGROUP(drive)->rq->sector);
+				printk(", sector=%llu", (unsigned long long)HWGROUP(drive)->rq->sector);
 		}
 	}
 #endif	/* FANCY_STATUS_DUMPS */
diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/ide/ide.c	Fri Aug 23 11:59:05 2002
@@ -832,7 +832,7 @@
 					}
 				}
 				if (HWGROUP(drive) && HWGROUP(drive)->rq)
-					printk(", sector=%ld", HWGROUP(drive)->rq->sector);
+					printk(", sector=%llu", (unsigned long long)HWGROUP(drive)->rq->sector);
 			}
 		}
 #endif	/* FANCY_STATUS_DUMPS */
diff -Nru a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/md/md.c	Fri Aug 23 11:59:05 2002
@@ -683,9 +683,9 @@
 
 static void print_rdev(mdk_rdev_t *rdev)
 {
-	printk(KERN_INFO "md: rdev %s, SZ:%08ld F:%d DN:%d ",
+	printk(KERN_INFO "md: rdev %s, SZ:%08llu F:%d DN:%d ",
 		bdev_partition_name(rdev->bdev),
-		rdev->size, rdev->faulty, rdev->desc_nr);
+		(unsigned long long)rdev->size, rdev->faulty, rdev->desc_nr);
 	if (rdev->sb) {
 		printk(KERN_INFO "md: rdev superblock:\n");
 		print_sb(rdev->sb);
@@ -784,8 +784,10 @@
 
 	sb_offset = calc_dev_sboffset(rdev->bdev);
 	if (rdev->sb_offset != sb_offset) {
-		printk(KERN_INFO "%s's sb offset has changed from %ld to %ld, skipping\n",
-		       bdev_partition_name(rdev->bdev), rdev->sb_offset, sb_offset);
+		printk(KERN_INFO "%s's sb offset has changed from %llu to %llu, skipping\n",
+		       bdev_partition_name(rdev->bdev), 
+		    (unsigned long long)rdev->sb_offset, 
+		    (unsigned long long)sb_offset);
 		goto skip;
 	}
 	/*
@@ -795,12 +797,14 @@
 	 */
 	size = calc_dev_size(rdev->bdev, rdev->mddev);
 	if (size != rdev->size) {
-		printk(KERN_INFO "%s's size has changed from %ld to %ld since import, skipping\n",
-		       bdev_partition_name(rdev->bdev), rdev->size, size);
+		printk(KERN_INFO "%s's size has changed from %llu to %llu since import, skipping\n",
+		       bdev_partition_name(rdev->bdev),
+		       (unsigned long long)rdev->size, 
+		       (unsigned long long)size);
 		goto skip;
 	}
 
-	printk(KERN_INFO "(write) %s's sb offset: %ld\n", bdev_partition_name(rdev->bdev), sb_offset);
+	printk(KERN_INFO "(write) %s's sb offset: %llu\n", bdev_partition_name(rdev->bdev), (unsigned long long)sb_offset);
 
 	if (!sync_page_io(rdev->bdev, sb_offset<<1, MD_SB_BYTES, rdev->sb_page, WRITE))
 		goto fail;
@@ -1267,9 +1271,9 @@
 		rdev->size = calc_dev_size(rdev->bdev, mddev);
 		if (rdev->size < mddev->chunk_size / 1024) {
 			printk(KERN_WARNING
-				"md: Dev %s smaller than chunk_size: %ldk < %dk\n",
+				"md: Dev %s smaller than chunk_size: %lluk < %dk\n",
 				bdev_partition_name(rdev->bdev),
-				rdev->size, mddev->chunk_size / 1024);
+				(unsigned long long)rdev->size, mddev->chunk_size / 1024);
 			return -EINVAL;
 		}
 	}
@@ -2111,8 +2115,9 @@
 	size = calc_dev_size(rdev->bdev, mddev);
 
 	if (size < mddev->size) {
-		printk(KERN_WARNING "md%d: disk size %d blocks < array size %ld\n",
-				mdidx(mddev), size, mddev->size);
+		printk(KERN_WARNING "md%d: disk size %llu blocks < array size %llu\n",
+				mdidx(mddev), (unsigned long long)size, 
+				(unsigned long long)mddev->size);
 		err = -ENOSPC;
 		goto abort_export;
 	}
@@ -2767,10 +2772,10 @@
 
 		if (!list_empty(&mddev->disks)) {
 			if (mddev->pers)
-				sz += sprintf(page + sz, "\n      %d blocks",
-						 md_size[mdidx(mddev)]);
+				sz += sprintf(page + sz, "\n      %llu blocks",
+						 (unsigned long long)md_size[mdidx(mddev)]);
 			else
-				sz += sprintf(page + sz, "\n      %d blocks", size);
+				sz += sprintf(page + sz, "\n      %llu blocks", (unsigned long long)size);
 		}
 
 		if (!mddev->pers) {
diff -Nru a/drivers/md/multipath.c b/drivers/md/multipath.c
--- a/drivers/md/multipath.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/md/multipath.c	Fri Aug 23 11:59:05 2002
@@ -138,8 +138,8 @@
 	conf = mddev_to_conf(mp_bh->mddev);
 	bdev = conf->multipaths[mp_bh->path].bdev;
 	md_error (mp_bh->mddev, bdev);
-	printk(KERN_ERR "multipath: %s: rescheduling sector %lu\n", 
-		 bdev_partition_name(bdev), bio->bi_sector);
+	printk(KERN_ERR "multipath: %s: rescheduling sector %llu\n", 
+		 bdev_partition_name(bdev), (unsigned long long)bio->bi_sector);
 	multipath_reschedule_retry(mp_bh);
 	return;
 }
@@ -340,10 +340,10 @@
 }
 
 #define IO_ERROR KERN_ALERT \
-"multipath: %s: unrecoverable IO read error for block %lu\n"
+"multipath: %s: unrecoverable IO read error for block %llu\n"
 
 #define REDIRECT_SECTOR KERN_ERR \
-"multipath: %s: redirecting sector %lu to another IO path\n"
+"multipath: %s: redirecting sector %llu to another IO path\n"
 
 /*
  * This is a kernel thread which:
@@ -377,11 +377,11 @@
 		multipath_map (mddev, &bio->bi_bdev);
 		if (bio->bi_bdev == bdev) {
 			printk(IO_ERROR,
-				bdev_partition_name(bio->bi_bdev), bio->bi_sector);
+				bdev_partition_name(bio->bi_bdev), (unsigned long long)bio->bi_sector);
 			multipath_end_bh_io(mp_bh, 0);
 		} else {
 			printk(REDIRECT_SECTOR,
-				bdev_partition_name(bio->bi_bdev), bio->bi_sector);
+				bdev_partition_name(bio->bi_bdev), (unsigned long long)bio->bi_sector);
 			generic_make_request(bio);
 		}
 	}
diff -Nru a/drivers/md/raid0.c b/drivers/md/raid0.c
--- a/drivers/md/raid0.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/md/raid0.c	Fri Aug 23 11:59:05 2002
@@ -46,9 +46,9 @@
 		printk("raid0: looking at %s\n", bdev_partition_name(rdev1->bdev));
 		c = 0;
 		ITERATE_RDEV(mddev,rdev2,tmp2) {
-			printk("raid0:   comparing %s(%ld) with %s(%ld)\n",
-			       bdev_partition_name(rdev1->bdev), rdev1->size,
-			       bdev_partition_name(rdev2->bdev), rdev2->size);
+			printk("raid0:   comparing %s(%llu) with %s(%llu)\n",
+			       bdev_partition_name(rdev1->bdev), (unsigned long long)rdev1->size,
+			       bdev_partition_name(rdev2->bdev), (unsigned long long)rdev2->size);
 			if (rdev2 == rdev1) {
 				printk("raid0:   END\n");
 				break;
@@ -135,7 +135,8 @@
 				c++;
 				if (!smallest || (rdev->size <smallest->size)) {
 					smallest = rdev;
-					printk("  (%ld) is smallest!.\n", rdev->size);
+					printk("  (%llu) is smallest!.\n", 
+					       (unsigned long long)rdev->size);
 				}
 			} else
 				printk(" nope.\n");
@@ -176,16 +177,21 @@
 	if (create_strip_zones (mddev)) 
 		goto out_free_conf;
 
-	printk("raid0 : md_size is %d blocks.\n", md_size[mdidx(mddev)]);
+	printk("raid0 : md_size is %llu blocks.\n", (unsigned long long)md_size[mdidx(mddev)]);
 	printk("raid0 : conf->smallest->size is %ld blocks.\n", conf->smallest->size);
-	nb_zone = md_size[mdidx(mddev)]/conf->smallest->size +
-			(md_size[mdidx(mddev)] % conf->smallest->size ? 1 : 0);
+	{
+#if __GNUC__ < 3 /* work around bug in gcc 2.9[56] */
+		volatile 
+#endif
+		  sector_t sz = md_size[mdidx(mddev)];
+		unsigned round = sector_div(sz, conf->smallest->size);
+		nb_zone = sz + (round ? 1 : 0);
+	}
 	printk("raid0 : nb_zone is %ld.\n", nb_zone);
 	conf->nr_zones = nb_zone;
 
 	printk("raid0 : Allocating %ld bytes for hash.\n",
 				nb_zone*sizeof(struct raid0_hash));
-
 	conf->hash_table = vmalloc (sizeof (struct raid0_hash)*nb_zone);
 	if (!conf->hash_table)
 		goto out_free_zone_conf;
@@ -312,7 +318,7 @@
 	return 1;
 
 bad_map:
-	printk ("raid0_make_request bug: can't convert block across chunks or bigger than %dk %ld %d\n", chunk_size, bio->bi_sector, bio->bi_size >> 10);
+	printk ("raid0_make_request bug: can't convert block across chunks or bigger than %dk %llu %d\n", chunk_size, (unsigned long long)bio->bi_sector, bio->bi_size >> 10);
 	goto outerr;
 bad_hash:
 	printk("raid0_make_request bug: hash==NULL for block %ld\n", block);
diff -Nru a/drivers/md/raid1.c b/drivers/md/raid1.c
--- a/drivers/md/raid1.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/md/raid1.c	Fri Aug 23 11:59:05 2002
@@ -292,8 +292,8 @@
 		/*
 		 * oops, read error:
 		 */
-		printk(KERN_ERR "raid1: %s: rescheduling sector %lu\n",
-			bdev_partition_name(conf->mirrors[mirror].bdev), r1_bio->sector);
+		printk(KERN_ERR "raid1: %s: rescheduling sector %llu\n",
+			bdev_partition_name(conf->mirrors[mirror].bdev), (unsigned long long)r1_bio->sector);
 		reschedule_retry(r1_bio);
 		return;
 	}
@@ -836,10 +836,10 @@
 }
 
 #define IO_ERROR KERN_ALERT \
-"raid1: %s: unrecoverable I/O read error for block %lu\n"
+"raid1: %s: unrecoverable I/O read error for block %llu\n"
 
 #define REDIRECT_SECTOR KERN_ERR \
-"raid1: %s: redirecting sector %lu to another mirror\n"
+"raid1: %s: redirecting sector %llu to another mirror\n"
 
 static void end_sync_read(struct bio *bio)
 {
@@ -906,7 +906,7 @@
 		 * There is no point trying a read-for-reconstruct as
 		 * reconstruct is about to be aborted
 		 */
-		printk(IO_ERROR, bdev_partition_name(bio->bi_bdev), r1_bio->sector);
+		printk(IO_ERROR, bdev_partition_name(bio->bi_bdev), (unsigned long long)r1_bio->sector);
 		md_done_sync(mddev, r1_bio->master_bio->bi_size >> 9, 0);
 		resume_device(conf);
 		put_buf(r1_bio);
@@ -949,7 +949,7 @@
 		 * Nowhere to write this to... I guess we
 		 * must be done
 		 */
-		printk(IO_ERROR, bdev_partition_name(bio->bi_bdev), r1_bio->sector);
+		printk(IO_ERROR, bdev_partition_name(bio->bi_bdev), (unsigned long long)r1_bio->sector);
 		md_done_sync(mddev, r1_bio->master_bio->bi_size >> 9, 0);
 		resume_device(conf);
 		put_buf(r1_bio);
@@ -1005,12 +1005,12 @@
 			bdev = bio->bi_bdev;
 			map(mddev, &bio->bi_bdev);
 			if (bio->bi_bdev == bdev) {
-				printk(IO_ERROR, bdev_partition_name(bio->bi_bdev), r1_bio->sector);
+				printk(IO_ERROR, bdev_partition_name(bio->bi_bdev), (unsigned long long)r1_bio->sector);
 				raid_end_bio_io(r1_bio, 0);
 				break;
 			}
 			printk(REDIRECT_SECTOR,
-				bdev_partition_name(bio->bi_bdev), r1_bio->sector);
+				bdev_partition_name(bio->bi_bdev), (unsigned long long)r1_bio->sector);
 			bio->bi_sector = r1_bio->sector;
 			bio->bi_rw = r1_bio->cmd;
 
diff -Nru a/drivers/md/raid5.c b/drivers/md/raid5.c
--- a/drivers/md/raid5.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/md/raid5.c	Fri Aug 23 11:59:05 2002
@@ -195,8 +195,8 @@
 
 		if (dev->toread || dev->towrite || dev->written ||
 		    test_bit(R5_LOCKED, &dev->flags)) {
-			printk("sector=%lx i=%d %p %p %p %d\n",
-			       sh->sector, i, dev->toread,
+			printk("sector=%llx i=%d %p %p %p %d\n",
+			       (unsigned long long)sh->sector, i, dev->toread,
 			       dev->towrite, dev->written,
 			       test_bit(R5_LOCKED, &dev->flags));
 			BUG();
@@ -675,7 +675,7 @@
 		if (test_bit(R5_UPTODATE, &sh->dev[i].flags))
 			ptr[count++] = p;
 		else
-			printk("compute_block() %d, stripe %lu, %d not present\n", dd_idx, sh->sector, i);
+			printk("compute_block() %d, stripe %llu, %d not present\n", dd_idx, (unsigned long long)sh->sector, i);
 
 		check_xor();
 	}
diff -Nru a/drivers/mtd/nftlcore.c b/drivers/mtd/nftlcore.c
--- a/drivers/mtd/nftlcore.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/mtd/nftlcore.c	Fri Aug 23 11:59:05 2002
@@ -824,9 +824,9 @@
 
 		DEBUG(MTD_DEBUG_LEVEL2, "NFTL_request\n");
 		DEBUG(MTD_DEBUG_LEVEL3,
-		      "NFTL %s request, from sector 0x%04lx for %d sectors\n",
+		      "NFTL %s request, from sector 0x%04llx for %d sectors\n",
 		      (req->cmd == READ) ? "Read " : "Write",
-		      req->sector, req->current_nr_sectors);
+		      (unsigned long long)req->sector, req->current_nr_sectors);
 
 		dev = minor(req->rq_dev);
 		block = req->sector;
diff -Nru a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/scsi/scsi.c	Fri Aug 23 11:59:05 2002
@@ -2370,16 +2370,16 @@
 		for (SDpnt = shpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
 			for (SCpnt = SDpnt->device_queue; SCpnt; SCpnt = SCpnt->next) {
 				/*  (0) h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result %d %x      */
-				printk(KERN_INFO "(%3d) %2d:%1d:%2d:%2d (%6s %4ld %4ld %4ld %4x %1d) (%1d %1d 0x%2x) (%4d %4d %4d) 0x%2.2x 0x%2.2x 0x%8.8x\n",
+				printk(KERN_INFO "(%3d) %2d:%1d:%2d:%2d (%6s %4llu %4ld %4ld %4x %1d) (%1d %1d 0x%2x) (%4d %4d %4d) 0x%2.2x 0x%2.2x 0x%8.8x\n",
 				       i++,
 
 				       SCpnt->host->host_no,
 				       SCpnt->channel,
-				       SCpnt->target,
-				       SCpnt->lun,
+                                       SCpnt->target,
+                                       SCpnt->lun,
 
-				       kdevname(SCpnt->request->rq_dev),
-				       SCpnt->request->sector,
+                                       kdevname(SCpnt->request->rq_dev),
+                                       (unsigned long long)SCpnt->request->sector,
 				       SCpnt->request->nr_sectors,
 				       (long)SCpnt->request->current_nr_sectors,
 				       SCpnt->request->rq_status,
diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Fri Aug 23 11:59:05 2002
+++ b/drivers/scsi/sd.c	Fri Aug 23 11:59:05 2002
@@ -315,8 +315,8 @@
 	block = SCpnt->request->sector;
 	this_count = SCpnt->request_bufflen >> 9;
 
-	SCSI_LOG_HLQUEUE(1, printk("sd_command_init: dsk_nr=%d, block=%d, "
-			    "count=%d\n", dsk_nr, block, this_count));
+	SCSI_LOG_HLQUEUE(1, printk("sd_command_init: dsk_nr=%d, block=%llu, "
+			    "count=%d\n", dsk_nr, (unsigned long long)block, this_count));
 
 	sdp = SCpnt->device;
 	/* >>>>> the "(part_nr & 0xf)" excludes 15th partition, why?? */
@@ -339,8 +339,8 @@
 		return 0;
 	}
 	SCSI_LOG_HLQUEUE(2, sd_dskname(dsk_nr, nbuff));
-	SCSI_LOG_HLQUEUE(2, printk("%s : [part_nr=%d], block=%d\n",
-				   nbuff, part_nr, block));
+	SCSI_LOG_HLQUEUE(2, printk("%s : [part_nr=%d], block=%llu\n",
+				   nbuff, part_nr, (unsigned long long)block));
 
 	/*
 	 * If we have a 1K hardware sectorsize, prevent access to single
@@ -991,24 +991,31 @@
 		 * Jacques Gelinas (Jacques@solucorp.qc.ca)
 		 */
 		int hard_sector = sector_size;
-		int sz = sdkp->capacity * (hard_sector/256);
+		sector_t sz = sdkp->capacity * (hard_sector/256);
 		request_queue_t *queue = &sdp->request_queue;
+		sector_t mb;
 
 		blk_queue_hardsect_size(queue, hard_sector);
+		/* avoid 64-bit division on 32-bit platforms */
+		mb = sz >> 1;
+		sector_div(sz, 1250);
+		mb -= sz - 974;
+		sector_div(mb, 1950);
+
 		printk(KERN_NOTICE "SCSI device %s: "
-		       "%d %d-byte hdwr sectors (%d MB)\n",
-		       diskname, sdkp->capacity,
-		       hard_sector, (sz/2 - sz/1250 + 974)/1950);
+		       "%llu %d-byte hdwr sectors (%llu MB)\n",
+		       diskname, (unsigned long long)sdkp->capacity,
+		       hard_sector, (unsigned long long)mb);
 	}
 
 	/* Rescale capacity to 512-byte units */
 	if (sector_size == 4096)
 		sdkp->capacity <<= 3;
-	if (sector_size == 2048)
+	else if (sector_size == 2048)
 		sdkp->capacity <<= 2;
-	if (sector_size == 1024)
+	else if (sector_size == 1024)
 		sdkp->capacity <<= 1;
-	if (sector_size == 256)
+	else if (sector_size == 256)
 		sdkp->capacity >>= 1;
 
 	sdkp->device->sector_size = sector_size;
diff -Nru a/fs/ext3/ialloc.c b/fs/ext3/ialloc.c
--- a/fs/ext3/ialloc.c	Fri Aug 23 11:59:05 2002
+++ b/fs/ext3/ialloc.c	Fri Aug 23 11:59:05 2002
@@ -479,9 +479,10 @@
 			!(inode = iget(sb, ino)) || is_bad_inode(inode) ||
 			NEXT_ORPHAN(inode) > max_ino) {
 		ext3_warning(sb, __FUNCTION__,
-			     "bad orphan inode %ld!  e2fsck was run?\n", ino);
-		printk(KERN_NOTICE "ext3_test_bit(bit=%d, block=%ld) = %d\n",
-			bit, bitmap_bh->b_blocknr,
+			     "bad orphan inode %lu!  e2fsck was run?\n", (unsigned long)ino);
+		printk(KERN_NOTICE "ext3_test_bit(bit=%d, block=%llu) = %d\n",
+		       bit, 
+			(unsigned long long)bitmap_bh->b_blocknr, 
 			ext3_test_bit(bit, bitmap_bh->b_data));
 		printk(KERN_NOTICE "inode=%p\n", inode);
 		if (inode) {
diff -Nru a/fs/isofs/inode.c b/fs/isofs/inode.c
--- a/fs/isofs/inode.c	Fri Aug 23 11:59:05 2002
+++ b/fs/isofs/inode.c	Fri Aug 23 11:59:05 2002
@@ -970,7 +970,7 @@
 		 */
 		if (b_off > ((inode->i_size + PAGE_CACHE_SIZE - 1) >> ISOFS_BUFFER_BITS(inode))) {
 			printk("isofs_get_blocks: block >= EOF (%ld, %ld)\n",
-			       iblock, (unsigned long) inode->i_size);
+			       (long)iblock, (unsigned long) inode->i_size);
 			goto abort;
 		}
 		
@@ -992,7 +992,7 @@
 				if (++section > 100) {
 					printk("isofs_get_blocks: More than 100 file sections ?!?, aborting...\n");
 					printk("isofs_get_blocks: ino=%lu block=%ld firstext=%u sect_size=%u nextino=%lu\n",
-					       inode->i_ino, iblock, firstext, (unsigned) sect_size, nextino);
+					       inode->i_ino, (long)iblock, firstext, (unsigned) sect_size, nextino);
 					goto abort;
 				}
 			}
diff -Nru a/fs/jbd/commit.c b/fs/jbd/commit.c
--- a/fs/jbd/commit.c	Fri Aug 23 11:59:05 2002
+++ b/fs/jbd/commit.c	Fri Aug 23 11:59:05 2002
@@ -355,8 +355,8 @@
 			}
 			
 			bh = jh2bh(descriptor);
-			jbd_debug(4, "JBD: got buffer %ld (%p)\n",
-				bh->b_blocknr, bh->b_data);
+			jbd_debug(4, "JBD: got buffer %llu (%p)\n",
+				(unsigned long long)bh->b_blocknr, bh->b_data);
 			header = (journal_header_t *)&bh->b_data[0];
 			header->h_magic     = htonl(JFS_MAGIC_NUMBER);
 			header->h_blocktype = htonl(JFS_DESCRIPTOR_BLOCK);
diff -Nru a/fs/jbd/revoke.c b/fs/jbd/revoke.c
--- a/fs/jbd/revoke.c	Fri Aug 23 11:59:05 2002
+++ b/fs/jbd/revoke.c	Fri Aug 23 11:59:05 2002
@@ -388,7 +388,7 @@
 		record = find_revoke_record(journal, bh->b_blocknr);
 		if (record) {
 			jbd_debug(4, "cancelled existing revoke on "
-				  "blocknr %lu\n", bh->b_blocknr);
+				  "blocknr %llu\n", (u64)bh->b_blocknr);
 			list_del(&record->hash);
 			kmem_cache_free(revoke_record_cache, record);
 			did_revoke = 1;
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Fri Aug 23 11:59:05 2002
+++ b/fs/reiserfs/journal.c	Fri Aug 23 11:59:05 2002
@@ -1017,15 +1017,15 @@
     ** is not marked JDirty_wait
     */
     if ((!was_jwait) && !buffer_locked(saved_bh)) {
-printk("journal-813: BAD! buffer %lu %cdirty %cjwait, not in a newer tranasction\n", saved_bh->b_blocknr,
+printk("journal-813: BAD! buffer %llu %cdirty %cjwait, not in a newer tranasction\n", (unsigned long long)saved_bh->b_blocknr,
         was_dirty ? ' ' : '!', was_jwait ? ' ' : '!') ;
     }
     /* kupdate_one_transaction waits on the buffers it is writing, so we
     ** should never see locked buffers here
     */
     if (buffer_locked(saved_bh)) {
-      printk("clm-2083: locked buffer %lu in flush_journal_list\n", 
-              saved_bh->b_blocknr) ;
+      printk("clm-2083: locked buffer %llu in flush_journal_list\n", 
+              (unsigned long long)saved_bh->b_blocknr) ;
       wait_on_buffer(saved_bh) ;
       if (!buffer_uptodate(saved_bh)) {
         reiserfs_panic(s, "journal-923: buffer write failed\n") ;
@@ -1038,8 +1038,8 @@
       submit_logged_buffer(saved_bh) ;
       count++ ;
     } else {
-      printk("clm-2082: Unable to flush buffer %lu in flush_journal_list\n",
-              saved_bh->b_blocknr) ;
+      printk("clm-2082: Unable to flush buffer %llu in flush_journal_list\n",
+              (unsigned long long)saved_bh->b_blocknr) ;
     }
 free_cnode:
     last = cn ;
@@ -2364,7 +2364,7 @@
   ** could get to disk too early.  NOT GOOD.
   */
   if (!prepared || buffer_locked(bh)) {
-    printk("journal-1777: buffer %lu bad state %cPREPARED %cLOCKED %cDIRTY %cJDIRTY_WAIT\n", bh->b_blocknr, prepared ? ' ' : '!', 
+    printk("journal-1777: buffer %llu bad state %cPREPARED %cLOCKED %cDIRTY %cJDIRTY_WAIT\n", (unsigned long long)bh->b_blocknr, prepared ? ' ' : '!', 
                             buffer_locked(bh) ? ' ' : '!',
 			    buffer_dirty(bh) ? ' ' : '!',
 			    buffer_journal_dirty(bh) ? ' ' : '!') ;
diff -Nru a/fs/reiserfs/prints.c b/fs/reiserfs/prints.c
--- a/fs/reiserfs/prints.c	Fri Aug 23 11:59:05 2002
+++ b/fs/reiserfs/prints.c	Fri Aug 23 11:59:05 2002
@@ -139,8 +139,8 @@
 
 static void sprintf_buffer_head (char * buf, struct buffer_head * bh) 
 {
-  sprintf (buf, "dev %s, size %d, blocknr %ld, count %d, state 0x%lx, page %p, (%s, %s, %s)",
-	   bdevname (bh->b_bdev), bh->b_size, bh->b_blocknr,
+  sprintf (buf, "dev %s, size %d, blocknr %llu, count %d, state 0x%lx, page %p, (%s, %s, %s)",
+	   bdevname (bh->b_bdev), bh->b_size, (unsigned long long)bh->b_blocknr,
 	   atomic_read (&(bh->b_count)),
 	   bh->b_state, bh->b_page,
 	   buffer_uptodate (bh) ? "UPTODATE" : "!UPTODATE",
@@ -367,7 +367,7 @@
     if (tb) {
 	while (tb->insert_size[h]) {
 	    bh = PATH_H_PBUFFER (path, h);
-	    printk ("block %lu (level=%d), position %d\n", bh ? bh->b_blocknr : 0,
+	    printk ("block %llu (level=%d), position %d\n", bh ? (unsigned long long)bh->b_blocknr : 0LL,
 		    bh ? B_LEVEL (bh) : 0, PATH_H_POSITION (path, h));
 	    h ++;
 	}
@@ -377,8 +377,8 @@
       printk ("Offset    Bh     (b_blocknr, b_count) Position Nr_item\n");
       while ( offset > ILLEGAL_PATH_ELEMENT_OFFSET ) {
 	  bh = PATH_OFFSET_PBUFFER (path, offset);
-	  printk ("%6d %10p (%9lu, %7d) %8d %7d\n", offset, 
-		  bh, bh ? bh->b_blocknr : 0, bh ? atomic_read (&(bh->b_count)) : 0,
+	  printk ("%6d %10p (%9llu, %7d) %8d %7d\n", offset, 
+		  bh, bh ? (unsigned long long)bh->b_blocknr : 0LL, bh ? atomic_read (&(bh->b_count)) : 0,
 		  PATH_OFFSET_POSITION (path, offset), bh ? B_NR_ITEMS (bh) : -1);
 	  
 	  offset --;
@@ -510,8 +510,8 @@
 	return 1;
     }
 
-    printk ("%s\'s super block is in block %ld\n", bdevname (bh->b_bdev), 
-            bh->b_blocknr);
+    printk ("%s\'s super block is in block %llu\n", bdevname (bh->b_bdev), 
+            (unsigned long long)bh->b_blocknr);
     printk ("Reiserfs version %s\n", version );
     printk ("Block count %u\n", sb_block_count(rs));
     printk ("Blocksize %d\n", sb_blocksize(rs));
@@ -547,8 +547,8 @@
     if (memcmp(desc->j_magic, JOURNAL_DESC_MAGIC, 8))
 	return 1;
 
-    printk ("Desc block %lu (j_trans_id %d, j_mount_id %d, j_len %d)",
-	    bh->b_blocknr, desc->j_trans_id, desc->j_mount_id, desc->j_len);
+    printk ("Desc block %llu (j_trans_id %d, j_mount_id %d, j_len %d)",
+	    (unsigned long long)bh->b_blocknr, desc->j_trans_id, desc->j_mount_id, desc->j_len);
 
     return 0;
 }
@@ -573,7 +573,7 @@
 	if (print_internal (bh, first, last))
 	    if (print_super_block (bh))
 		if (print_desc_block (bh))
-		    printk ("Block %ld contains unformatted data\n", bh->b_blocknr);
+		    printk ("Block %llu contains unformatted data\n", (unsigned long long)bh->b_blocknr);
 }
 
 
@@ -608,19 +608,19 @@
 	    tbFh = 0;
 	}
 	sprintf (print_tb_buf + strlen (print_tb_buf),
-		 "* %d * %3ld(%2d) * %3ld(%2d) * %3ld(%2d) * %5ld * %5ld * %5ld * %5ld * %5ld *\n",
+		 "* %d * %3lld(%2d) * %3lld(%2d) * %3lld(%2d) * %5lld * %5lld * %5lld * %5lld * %5lld *\n",
 		 h, 
-		 (tbSh) ? (tbSh->b_blocknr):(-1),
+		 (tbSh) ? (long long)(tbSh->b_blocknr):(-1LL),
 		 (tbSh) ? atomic_read (&(tbSh->b_count)) : -1,
-		 (tb->L[h]) ? (tb->L[h]->b_blocknr):(-1),
+		 (tb->L[h]) ? (long long)(tb->L[h]->b_blocknr):(-1LL),
 		 (tb->L[h]) ? atomic_read (&(tb->L[h]->b_count)) : -1,
-		 (tb->R[h]) ? (tb->R[h]->b_blocknr):(-1),
+		 (tb->R[h]) ? (long long)(tb->R[h]->b_blocknr):(-1LL),
 		 (tb->R[h]) ? atomic_read (&(tb->R[h]->b_count)) : -1,
-		 (tbFh) ? (tbFh->b_blocknr):(-1),
-		 (tb->FL[h]) ? (tb->FL[h]->b_blocknr):(-1),
-		 (tb->FR[h]) ? (tb->FR[h]->b_blocknr):(-1),
-		 (tb->CFL[h]) ? (tb->CFL[h]->b_blocknr):(-1),
-		 (tb->CFR[h]) ? (tb->CFR[h]->b_blocknr):(-1));
+		 (tbFh) ? (long long)(tbFh->b_blocknr):(-1LL),
+		 (tb->FL[h]) ? (long long)(tb->FL[h]->b_blocknr):(-1LL),
+		 (tb->FR[h]) ? (long long)(tb->FR[h]->b_blocknr):(-1LL),
+		 (tb->CFL[h]) ? (long long)(tb->CFL[h]->b_blocknr):(-1LL),
+		 (tb->CFR[h]) ? (long long)(tb->CFR[h]->b_blocknr):(-1LL));
     }
 
     sprintf (print_tb_buf + strlen (print_tb_buf), 
@@ -647,7 +647,7 @@
     h = 0;
     for (i = 0; i < sizeof (tb->FEB) / sizeof (tb->FEB[0]); i ++)
 	sprintf (print_tb_buf + strlen (print_tb_buf),
-		 "%p (%lu %d)%s", tb->FEB[i], tb->FEB[i] ? tb->FEB[i]->b_blocknr : 0,
+		 "%p (%llu %d)%s", tb->FEB[i], tb->FEB[i] ? (unsigned long long)tb->FEB[i]->b_blocknr : 0ULL,
 		 tb->FEB[i] ? atomic_read (&(tb->FEB[i]->b_count)) : 0, 
 		 (i == sizeof (tb->FEB) / sizeof (tb->FEB[0]) - 1) ? "\n" : ", ");
 
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Fri Aug 23 11:59:05 2002
+++ b/fs/reiserfs/super.c	Fri Aug 23 11:59:05 2002
@@ -838,8 +838,8 @@
     rs = (struct reiserfs_super_block *)bh->b_data;
     if (sb_blocksize(rs) != s->s_blocksize) {
 	printk ("sh-2011: read_super_block: "
-		"can't find a reiserfs filesystem on (dev %s, block %lu, size %lu)\n",
-		reiserfs_bdevname (s), bh->b_blocknr, s->s_blocksize);
+		"can't find a reiserfs filesystem on (dev %s, block %Lu, size %lu)\n",
+		reiserfs_bdevname (s), (unsigned long long)bh->b_blocknr, s->s_blocksize);
 	brelse (bh);
 	return 1;
     }
