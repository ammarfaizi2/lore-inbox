Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319295AbSHVFE4>; Thu, 22 Aug 2002 01:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319296AbSHVFEz>; Thu, 22 Aug 2002 01:04:55 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:48122 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S319295AbSHVFEc>; Thu, 22 Aug 2002 01:04:32 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15716.29133.542866.358607@wombat.chubb.wattle.id.au>
Date: Thu, 22 Aug 2002 15:08:29 +1000
To: linux-kernel@vger.kernel.org
CC: viro@math.psu.edu
Subject: New large block-device patch for 2.5.31+bk
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	Here's the latest large-block device patch.  Expect more
changes as Al Viro continues his partition cleanup (I've just
converted int *xxx_sizes to sector_t *xxx_sizes; he's gradually
getting rid of xxx_sizes[] altogether --- and a good thing too!).

I think I've addressed all the comments I've received so far, except
for the request for something that works on 2.4.X.

The patch enables support for large (>2TB) block devices for all platforms
where sizeof(long)==8, and via a config option for power-PC and IA32.
It's been tested on IA64 and IA32 only.

Still to-do:  16-byte command support for SCSI.
Software RAID works iff each raid member is smaller than 2TB.

Changes:
	-- Use sector_t not int or long for partition start and size
	-- Adjust printk() formats to allow sector_t to be either 32
	   or 64 bit.
	-- Where the sector number cannot be >2^32, cast to long to
	   avoid 64-bit division and modulo operations (e.g., in the
	   floppy and cdrom code)
	-- bmap() takes and returns sector_t
	-- return -EFBIG if the BLKGETSIZE ioctl cannot represent the
	   size of the device
	-- Clean up the loop device error checking on losetup, to
	   return -EFBIG for too large a backing file.
	-- Add a few BUG_ON() commands where we do not expect
	   too-large requests.

Anyone using bitkeeper can pull these changes from
bk://gelato.unsw.edu.au:2023

Large disc testing courtesy of OSDL, www.osdl.org

diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/block/Config.help linux-2.5-lbd/drivers/block/Config.help
--- linux-2.5-import/drivers/block/Config.help	Fri Aug 16 13:24:09 2002
+++ linux-2.5-lbd/drivers/block/Config.help	Thu Aug 15 12:15:36 2002
@@ -258,3 +258,7 @@
   supported by this driver, and for further information on the use of
   this driver.
 
+CONFIG_LBD
+  Say Y here if you want to attach large (bigger than 2TB) discs to
+  your machine, or if you want to have a raid or loopback device
+  bigger than 2TB.  Otherwise say N.
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/block/Config.in linux-2.5-lbd/drivers/block/Config.in
--- linux-2.5-import/drivers/block/Config.in	Fri Aug 16 13:24:09 2002
+++ linux-2.5-lbd/drivers/block/Config.in	Thu Aug 15 12:15:36 2002
@@ -48,4 +48,7 @@
 fi
 dep_bool '  Initial RAM disk (initrd) support' CONFIG_BLK_DEV_INITRD $CONFIG_BLK_DEV_RAM
 
+if [ "$CONFIG_X86" = "y" -o "$CONFIG_PPC32" = "y" ]; then
+   bool 'Support for Large Block Devices' CONFIG_LBD
+fi
 endmenu
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/block/blkpg.c linux-2.5-lbd/drivers/block/blkpg.c
--- linux-2.5-import/drivers/block/blkpg.c	Fri Aug 16 13:24:09 2002
+++ linux-2.5-lbd/drivers/block/blkpg.c	Thu Aug 15 12:15:36 2002
@@ -68,19 +68,24 @@
 {
 	struct gendisk *g;
 	long long ppstart, pplength;
-	long pstart, plength;
 	int i;
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
 	struct hd_struct *part;
 
-	/* convert bytes to sectors, check for fit in a hd_struct */
+	/* convert bytes to sectors */
 	ppstart = (p->start >> 9);
 	pplength = (p->length >> 9);
-	pstart = ppstart;
-	plength = pplength;
-	if (pstart != ppstart || plength != pplength
-	    || pstart < 0 || plength < 0)
-		return -EINVAL;
+
+	/* check for fit in a hd_struct */ 
+	if (sizeof(sector_t) == sizeof(long) && 
+	    sizeof(long long) > sizeof(long)) {
+		long pstart, plength;
+		pstart = ppstart;
+		plength = pplength;
+		if (pstart != ppstart || plength != pplength
+		    || pstart < 0 || plength < 0)
+			return -EINVAL;
+	}
 
 	/* find the drive major */
 	g = get_gendisk(dev);
@@ -102,13 +107,13 @@
 
 	/* overlap? */
 	for (i = 1; i < (1<<g->minor_shift); i++)
-		if (!(pstart+plength <= part[i].start_sect ||
-		      pstart >= part[i].start_sect + part[i].nr_sects))
+		if (ppstart+pplength <= part[i].start_sect ||
+		      ppstart >= part[i].start_sect + part[i].nr_sects)
 			return -EBUSY;
 
 	/* all seems OK */
-	part[p->pno].start_sect = pstart;
-	part[p->pno].nr_sects = plength;
+	part[p->pno].start_sect = ppstart;
+	part[p->pno].nr_sects = pplength;
 	devfs_register_partitions (g, minor(dev), 0);
 	return 0;
 }
@@ -261,10 +266,17 @@
 			intval = bdev_hardsect_size(bdev);
 			return put_user(intval, (int *) arg);
 
-		case BLKGETSIZE:
+		case BLKGETSIZE: 
+		{
+			unsigned long ret;
 			/* size in sectors, works up to 2 TB */
 			ullval = bdev->bd_inode->i_size;
-			return put_user((unsigned long)(ullval >> 9), (unsigned long *) arg);
+			ret = ullval >> 9;
+			if ((u64)ret != (ullval >> 9))
+				return -EFBIG;
+			return put_user(ret, (unsigned long *) arg);
+		}
+		
 		case BLKGETSIZE64:
 			/* size in bytes */
 			ullval = bdev->bd_inode->i_size;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/block/cciss.c linux-2.5-lbd/drivers/block/cciss.c
--- linux-2.5-import/drivers/block/cciss.c	Fri Aug 16 13:24:09 2002
+++ linux-2.5-lbd/drivers/block/cciss.c	Thu Aug 15 12:15:36 2002
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
 
@@ -405,7 +405,7 @@
                 } else {
                         driver_geo.heads = 0xff;
                         driver_geo.sectors = 0x3f;
-                        driver_geo.cylinders = hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f);
+                        driver_geo.cylinders = (int)hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f);
                 }
                 driver_geo.start=
                         hba[ctlr]->hd[minor(inode->i_rdev)].start_sect;
@@ -753,6 +753,7 @@
          * on this controller to zero.  We will reread all of this data
          */
 	memset(hba[ctlr]->hd,         0, sizeof(struct hd_struct) * 256);
+        memset(hba[ctlr]->sizes,      0, sizeof(hba[0]->sizes[0]) * 256);
         memset(hba[ctlr]->drv,        0, sizeof(drive_info_struct)
 						* CISS_MAX_LUN);
         /*
@@ -1191,7 +1192,7 @@
 			total_size = 0;
 			block_size = BLOCK_SIZE;
 	}	
-	printk(KERN_INFO "      blocks= %d block_size= %d\n", 
+	printk(KERN_INFO "      blocks= %u block_size= %d\n", 
 					total_size, block_size);
 	/* Execute the command to read the disk geometry */
 	memset(inq_buff, 0, sizeof(InquiryData_struct));
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/block/cciss.h linux-2.5-lbd/drivers/block/cciss.h
--- linux-2.5-import/drivers/block/cciss.h	Fri Aug 16 13:24:09 2002
+++ linux-2.5-lbd/drivers/block/cciss.h	Thu Aug 15 12:15:36 2002
@@ -29,7 +29,7 @@
 {
  	__u32   LunID;	
 	int 	usage_count;
-	int 	nr_blocks;
+	sector_t nr_blocks;
 	int	block_size;
 	int 	heads;
 	int	sectors;
@@ -85,7 +85,7 @@
 	char names[12 * NWD];
 	   // indexed by minor numbers
 	struct hd_struct hd[256];
-	int		 sizes[256];
+	sector_t	 sizes[256];
 #ifdef CONFIG_CISS_SCSI_TAPE
 	void *scsi_ctlr; /* ptr to structure containing scsi related stuff */
 #endif
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/block/floppy.c linux-2.5-lbd/drivers/block/floppy.c
--- linux-2.5-import/drivers/block/floppy.c	Fri Aug 16 13:24:09 2002
+++ linux-2.5-lbd/drivers/block/floppy.c	Thu Aug 15 12:15:36 2002
@@ -489,7 +489,7 @@
  */
 static struct floppy_struct user_params[N_DRIVE];
 
-static int floppy_sizes[256];
+static sector_t floppy_sizes[256];
 
 /*
  * The driver is trying to determine the correct media format
@@ -2664,8 +2664,10 @@
 
 	max_sector = _floppy->sect * _floppy->head;
 
-	TRACK = CURRENT->sector / max_sector;
-	fsector_t = CURRENT->sector % max_sector;
+	/* There can't be more than 2^16 (minimum max int) sectors on 
+	   a floppy, for goodness sake! */
+	TRACK = (int)CURRENT->sector / max_sector;
+	fsector_t = (int)CURRENT->sector % max_sector;
 	if (_floppy->track && TRACK >= _floppy->track) {
 		if (CURRENT->current_nr_sectors & 1) {
 			current_count_sectors = 1;
@@ -2998,7 +3000,7 @@
 
 	if (usage_count == 0) {
 		printk("warning: usage count=0, CURRENT=%p exiting\n", CURRENT);
-		printk("sect=%ld flags=%lx\n", CURRENT->sector, CURRENT->flags);
+		printk("sect=%llu flags=%lx\n", (unsigned long long)CURRENT->sector, CURRENT->flags);
 		return;
 	}
 	if (fdc_busy){
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/block/genhd.c linux-2.5-lbd/drivers/block/genhd.c
--- linux-2.5-import/drivers/block/genhd.c	Fri Aug 16 13:24:09 2002
+++ linux-2.5-lbd/drivers/block/genhd.c	Thu Aug 22 11:17:31 2002
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
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/block/ll_rw_blk.c linux-2.5-lbd/drivers/block/ll_rw_blk.c
--- linux-2.5-import/drivers/block/ll_rw_blk.c	Fri Aug 16 13:24:09 2002
+++ linux-2.5-lbd/drivers/block/ll_rw_blk.c	Thu Aug 15 12:15:36 2002
@@ -70,10 +70,10 @@
  *
  * if (!blk_size[MAJOR]) then no minor size checking is done.
  */
-int * blk_size[MAX_BLKDEV];
+sector_t * blk_size[MAX_BLKDEV];
 
 /*
- * How many reqeusts do we allocate per queue,
+ * How many requests do we allocate per queue,
  * and how many do we "batch" on freeing them?
  */
 int queue_nr_requests, batch_requests;
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/block/loop.c linux-2.5-lbd/drivers/block/loop.c
--- linux-2.5-import/drivers/block/loop.c	Fri Aug 16 13:24:09 2002
+++ linux-2.5-lbd/drivers/block/loop.c	Thu Aug 22 11:52:32 2002
@@ -83,14 +83,14 @@
 
 static int max_loop = 8;
 static struct loop_device *loop_dev;
-static int *loop_sizes;
+static sector_t *loop_sizes;
 static devfs_handle_t devfs_handle;      /*  For the directory */
 
 /*
  * Transfer functions
  */
 static int transfer_none(struct loop_device *lo, int cmd, char *raw_buf,
-			 char *loop_buf, int size, int real_block)
+			 char *loop_buf, int size, sector_t real_block)
 {
 	if (raw_buf != loop_buf) {
 		if (cmd == READ)
@@ -103,7 +103,7 @@
 }
 
 static int transfer_xor(struct loop_device *lo, int cmd, char *raw_buf,
-			char *loop_buf, int size, int real_block)
+			char *loop_buf, int size, sector_t real_block)
 {
 	char	*in, *out, *key;
 	int	i, keysize;
@@ -154,24 +154,31 @@
 	&xor_funcs  
 };
 
-#define MAX_DISK_SIZE 1024*1024*1024
 
-static unsigned long
-compute_loop_size(struct loop_device *lo, struct dentry * lo_dentry)
+static int figure_loop_size(struct loop_device *lo)
 {
-	loff_t size = lo_dentry->d_inode->i_mapping->host->i_size;
-	return (size - lo->lo_offset) >> BLOCK_SIZE_BITS;
-}
+	loff_t size = lo->lo_backing_file->f_dentry->d_inode->i_mapping->host->i_size;
+	sector_t x;
 
-static void figure_loop_size(struct loop_device *lo)
-{
-	loop_sizes[lo->lo_number] = compute_loop_size(lo,
-					lo->lo_backing_file->f_dentry);
-					
+	/*
+	 * Unfortunately, if we want to do I/O on the device,
+	 * the number of 512-byte sectors has to fit into a sector_t.
+	 */
+	size = (size - lo->lo_offset) >> 9;
+	x = (sector_t)size;
+	if ((loff_t)x != size)
+		return -EFBIG;
+	/*
+	 * Convert sectors to blocks
+	 */
+	size >>= (BLOCK_SIZE_BITS - 9);
+
+	loop_sizes[lo->lo_number] = (sector_t)size;
+	return 0;					
 }
 
 static inline int lo_do_transfer(struct loop_device *lo, int cmd, char *rbuf,
-				 char *lbuf, int size, int rblock)
+				 char *lbuf, int size, sector_t rblock)
 {
 	if (!lo->transfer)
 		return 0;
@@ -187,18 +194,18 @@
 	struct address_space_operations *aops = mapping->a_ops;
 	struct page *page;
 	char *kaddr, *data;
-	unsigned long index;
+	pgoff_t index;
 	unsigned size, offset;
 	int len;
 	int ret = 0;
 
 	down(&mapping->host->i_sem);
 	index = pos >> PAGE_CACHE_SHIFT;
-	offset = pos & (PAGE_CACHE_SIZE - 1);
+	offset = pos & ((pgoff_t)PAGE_CACHE_SIZE - 1);
 	data = kmap(bvec->bv_page) + bvec->bv_offset;
 	len = bvec->bv_len;
 	while (len > 0) {
-		int IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
+		sector_t IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
 		int transfer_result;
 
 		size = PAGE_CACHE_SIZE - offset;
@@ -218,7 +225,7 @@
 			 * The transfer failed, but we still write the data to
 			 * keep prepare/commit calls balanced.
 			 */
-			printk(KERN_ERR "loop: transfer error block %ld\n", index);
+			printk(KERN_ERR "loop: transfer error block %llu\n", (unsigned long long)index);
 			memset(kaddr + offset, 0, size);
 		}
 		if (aops->commit_write(file, page, offset, offset+size))
@@ -704,7 +711,11 @@
 	lo->lo_backing_file = file;
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
-	figure_loop_size(lo);
+	if (figure_loop_size(lo)) {
+		error = -EFBIG;
+		fput(file);
+		goto out_putf;
+	}
 	lo->old_gfp_mask = inode->i_mapping->gfp_mask;
 	inode->i_mapping->gfp_mask = GFP_NOIO;
 
@@ -800,6 +811,7 @@
 	struct loop_info info; 
 	int err;
 	unsigned int type;
+	loff_t offset;
 
 	if (lo->lo_encrypt_key_size && lo->lo_key_owner != current->uid && 
 	    !capable(CAP_SYS_ADMIN))
@@ -815,13 +827,23 @@
 		return -EINVAL;
 	if (type == LO_CRYPT_XOR && info.lo_encrypt_key_size == 0)
 		return -EINVAL;
+
 	err = loop_release_xfer(lo);
 	if (!err) 
 		err = loop_init_xfer(lo, type, &info);
+
+	offset = lo->lo_offset;
+	if (offset != info.lo_offset) {
+		lo->lo_offset = info.lo_offset;
+		if (figure_loop_size(lo)){
+			err = -EFBIG;
+			lo->lo_offset = offset;
+		}
+	}
+
 	if (err)
 		return err;	
 
-	lo->lo_offset = info.lo_offset;
 	strncpy(lo->lo_name, info.lo_name, LO_NAME_SIZE);
 
 	lo->transfer = xfer_funcs[type]->transfer;
@@ -834,7 +856,7 @@
 		       info.lo_encrypt_key_size);
 		lo->lo_key_owner = current->uid; 
 	}	
-	figure_loop_size(lo);
+
 	return 0;
 }
 
@@ -901,18 +923,25 @@
 		err = loop_get_status(lo, (struct loop_info *) arg);
 		break;
 	case BLKGETSIZE:
+	{
+		unsigned long val;
 		if (lo->lo_state != Lo_bound) {
 			err = -ENXIO;
 			break;
 		}
-		err = put_user((unsigned long) loop_sizes[lo->lo_number] << 1, (unsigned long *) arg);
+		val = loop_sizes[lo->lo_number] << 1;
+		if ((sector_t)val  != loop_sizes[lo->lo_number] << 1)
+			err = -EFBIG;
+		else
+			err = put_user(val, (unsigned long *) arg);
 		break;
+	}
 	case BLKGETSIZE64:
 		if (lo->lo_state != Lo_bound) {
 			err = -ENXIO;
 			break;
 		}
-		err = put_user((u64)loop_sizes[lo->lo_number] << 10, (u64*)arg);
+		err = put_user(((u64)loop_sizes[lo->lo_number]) << 10, (u64*)arg);
 		break;
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
@@ -1045,7 +1074,7 @@
 	if (!loop_dev)
 		return -ENOMEM;
 
-	loop_sizes = kmalloc(max_loop * sizeof(int), GFP_KERNEL);
+	loop_sizes = kmalloc(max_loop * sizeof(loop_sizes[0]), GFP_KERNEL);
 	if (!loop_sizes)
 		goto out_mem;
 
@@ -1054,7 +1083,7 @@
 
 	for (i = 0; i < max_loop; i++) {
 		struct loop_device *lo = &loop_dev[i];
-		memset(lo, 0, sizeof(struct loop_device));
+		memset(lo, 0, sizeof(*lo));
 		init_MUTEX(&lo->lo_ctl_mutex);
 		init_MUTEX_LOCKED(&lo->lo_sem);
 		init_MUTEX_LOCKED(&lo->lo_bh_mutex);
@@ -1062,7 +1091,7 @@
 		spin_lock_init(&lo->lo_lock);
 	}
 
-	memset(loop_sizes, 0, max_loop * sizeof(int));
+	memset(loop_sizes, 0, max_loop * sizeof(*loop_sizes));
 	blk_size[MAJOR_NR] = loop_sizes;
 	for (i = 0; i < max_loop; i++)
 		register_disk(NULL, mk_kdev(MAJOR_NR, i), 1, &lo_fops, 0);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/block/nbd.c linux-2.5-lbd/drivers/block/nbd.c
--- linux-2.5-import/drivers/block/nbd.c	Fri Aug 16 13:24:09 2002
+++ linux-2.5-lbd/drivers/block/nbd.c	Thu Aug 15 12:15:36 2002
@@ -59,7 +59,7 @@
 
 static int nbd_blksizes[MAX_NBD];
 static int nbd_blksize_bits[MAX_NBD];
-static int nbd_sizes[MAX_NBD];
+static sector_t nbd_sizes[MAX_NBD];
 static u64 nbd_bytesizes[MAX_NBD];
 
 static struct nbd_device nbd_dev[MAX_NBD];
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/block/ps2esdi.c linux-2.5-lbd/drivers/block/ps2esdi.c
--- linux-2.5-import/drivers/block/ps2esdi.c	Fri Aug 16 13:24:09 2002
+++ linux-2.5-lbd/drivers/block/ps2esdi.c	Thu Aug 15 12:15:36 2002
@@ -108,6 +108,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(ps2esdi_int);
 
 static int no_int_yet;
+static sector_t ps2esdi_sizes[MAX_HD << 6];
 static int ps2esdi_drives;
 static struct hd_struct ps2esdi[MAX_HD << 6];
 static u_short io_base;
@@ -540,7 +541,7 @@
 	/* is request is valid */ 
 	else {
 		printk("Grrr. error. ps2esdi_drives: %d, %lu %lu\n", ps2esdi_drives,
-		       CURRENT->sector, ps2esdi[minor(CURRENT->rq_dev)].nr_sects);
+		       (unsigned long)CURRENT->sector, (unsigned long)ps2esdi[minor(CURRENT->rq_dev)].nr_sects);
 		end_request(CURRENT, FAIL);
 	}
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/block/rd.c linux-2.5-lbd/drivers/block/rd.c
--- linux-2.5-import/drivers/block/rd.c	Fri Aug 16 13:24:09 2002
+++ linux-2.5-lbd/drivers/block/rd.c	Thu Aug 15 12:15:36 2002
@@ -77,7 +77,7 @@
  */
 
 static unsigned long rd_length[NUM_RAMDISKS];	/* Size of RAM disks in bytes   */
-static int rd_kbsize[NUM_RAMDISKS];	/* Size in blocks of 1024 bytes */
+static sector_t rd_kbsize[NUM_RAMDISKS];	/* Size in blocks of 1024 bytes */
 static devfs_handle_t devfs_handle;
 static struct block_device *rd_bdev[NUM_RAMDISKS];/* Protected device data */
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/ide/ide-cd.c linux-2.5-lbd/drivers/ide/ide-cd.c
--- linux-2.5-import/drivers/ide/ide-cd.c	Mon Aug 19 13:07:06 2002
+++ linux-2.5-lbd/drivers/ide/ide-cd.c	Thu Aug 22 11:17:31 2002
@@ -1173,7 +1173,7 @@
 	if (rq->current_nr_sectors < bio_sectors(rq->bio) &&
 	    (rq->sector % SECTORS_PER_FRAME) != 0) {
 		printk ("%s: cdrom_read_from_buffer: buffer botch (%ld)\n",
-			drive->name, rq->sector);
+			drive->name, (long)rq->sector);
 		cdrom_end_request(drive, 0);
 		return -1;
 	}
@@ -2784,11 +2784,13 @@
 static int ll_10byte_cmd_build(request_queue_t *q, struct request *rq)
 {
 	int hard_sect = queue_hardsect_size(q);
-	sector_t block = rq->hard_sector / (hard_sect >> 9);
+	unsigned block = (long)rq->hard_sector / (hard_sect >> 9);
 	unsigned long blocks = rq->hard_nr_sectors / (hard_sect >> 9);
 
 	if (!(rq->flags & REQ_CMD))
 		return 0;
+
+	BUG_ON(sizeof(rq->hard_sector) > 4 && (rq->hard_sector >> 32));
 
 	if (rq->hard_nr_sectors != rq->nr_sectors) {
 		printk(KERN_ERR "ide-cd: hard_nr_sectors differs from nr_sectors! %lu %lu\n",
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/ide/ide-disk.c linux-2.5-lbd/drivers/ide/ide-disk.c
--- linux-2.5-import/drivers/ide/ide-disk.c	Mon Aug 19 13:07:06 2002
+++ linux-2.5-lbd/drivers/ide/ide-disk.c	Thu Aug 22 11:17:02 2002
@@ -843,7 +843,7 @@
 				}
 			}
 			if (HWGROUP(drive) && HWGROUP(drive)->rq)
-				printk(", sector=%ld", HWGROUP(drive)->rq->sector);
+				printk(", sector=%llu", (unsigned long long)HWGROUP(drive)->rq->sector);
 		}
 	}
 #endif	/* FANCY_STATUS_DUMPS */
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/ide/ide-floppy.c linux-2.5-lbd/drivers/ide/ide-floppy.c
--- linux-2.5-import/drivers/ide/ide-floppy.c	Mon Aug 19 13:07:06 2002
+++ linux-2.5-lbd/drivers/ide/ide-floppy.c	Thu Aug 22 11:10:29 2002
@@ -1379,7 +1379,7 @@
 		return ide_stopped;
 	}
 	if (rq->flags & REQ_CMD) {
-		if ((rq->sector % floppy->bs_factor) ||
+		if (((long)rq->sector % floppy->bs_factor) ||
 		    (rq->nr_sectors % floppy->bs_factor)) {
 			printk("%s: unsupported r/w request size\n",
 				drive->name);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/ide/ide.c linux-2.5-lbd/drivers/ide/ide.c
--- linux-2.5-import/drivers/ide/ide.c	Mon Aug 19 13:07:06 2002
+++ linux-2.5-lbd/drivers/ide/ide.c	Thu Aug 22 11:17:31 2002
@@ -832,7 +832,7 @@
 					}
 				}
 				if (HWGROUP(drive) && HWGROUP(drive)->rq)
-					printk(", sector=%ld", HWGROUP(drive)->rq->sector);
+					printk(", sector=%llu", (unsigned long long)HWGROUP(drive)->rq->sector);
 			}
 		}
 #endif	/* FANCY_STATUS_DUMPS */
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/ieee1394/sbp2.c linux-2.5-lbd/drivers/ieee1394/sbp2.c
--- linux-2.5-import/drivers/ieee1394/sbp2.c	Fri Aug 16 13:24:25 2002
+++ linux-2.5-lbd/drivers/ieee1394/sbp2.c	Thu Aug 15 12:15:40 2002
@@ -3105,12 +3105,13 @@
 
 	heads = 64;
 	sectors = 32;
-	cylinders = disk->capacity / (heads * sectors);
+	cylinders = (int)disk->capacity / (heads * sectors);
+	
 
 	if (cylinders > 1024) {
 		heads = 255;
 		sectors = 63;
-		cylinders = disk->capacity / (heads * sectors);
+		cylinders = (int)disk->capacity / (heads * sectors);
 	}
 
 	geom[0] = heads;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/md/linear.c linux-2.5-lbd/drivers/md/linear.c
--- linux-2.5-import/drivers/md/linear.c	Fri Aug 16 13:24:34 2002
+++ linux-2.5-lbd/drivers/md/linear.c	Thu Aug 15 12:15:41 2002
@@ -72,10 +72,12 @@
 		goto out;
 	}
 
-	nb_zone = conf->nr_zones =
-		md_size[mdidx(mddev)] / conf->smallest->size +
-		((md_size[mdidx(mddev)] % conf->smallest->size) ? 1 : 0);
-  
+	{
+		sector_t sz = md_size[mdidx(mddev)];
+		unsigned round = sector_div(sz, conf->smallest->size);
+		nb_zone = conf->nr_zones = sz + (round ? 1 : 0);
+	}
+			
 	conf->hash_table = kmalloc (sizeof (struct linear_hash) * nb_zone,
 					GFP_KERNEL);
 	if (!conf->hash_table)
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/md/lvm.c linux-2.5-lbd/drivers/md/lvm.c
--- linux-2.5-import/drivers/md/lvm.c	Fri Aug 16 13:24:34 2002
+++ linux-2.5-lbd/drivers/md/lvm.c	Thu Aug 15 12:15:41 2002
@@ -370,7 +370,7 @@
 /* gendisk structures */
 static struct hd_struct lvm_hd_struct[MAX_LV];
 static int lvm_blocksizes[MAX_LV];
-static int lvm_size[MAX_LV];
+static sector_t lvm_size[MAX_LV];
 
 static struct gendisk lvm_gendisk =
 {
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/md/md.c linux-2.5-lbd/drivers/md/md.c
--- linux-2.5-import/drivers/md/md.c	Mon Aug 19 13:07:08 2002
+++ linux-2.5-lbd/drivers/md/md.c	Thu Aug 22 13:02:07 2002
@@ -111,7 +111,7 @@
 static void md_recover_arrays(void);
 static mdk_thread_t *md_recovery_thread;
 
-int md_size[MAX_MD_DEVS];
+sector_t md_size[MAX_MD_DEVS];
 
 static struct block_device_operations md_fops;
 static devfs_handle_t devfs_handle;
@@ -300,35 +300,35 @@
 	return dname->name;
 }
 
-static unsigned int calc_dev_sboffset(struct block_device *bdev)
+static sector_t calc_dev_sboffset(struct block_device *bdev)
 {
-	unsigned int size = bdev->bd_inode->i_size >> BLOCK_SIZE_BITS;
+	sector_t size = bdev->bd_inode->i_size >> BLOCK_SIZE_BITS;
 	return MD_NEW_SIZE_BLOCKS(size);
 }
 
-static unsigned int calc_dev_size(struct block_device *bdev, mddev_t *mddev)
+static sector_t calc_dev_size(struct block_device *bdev, mddev_t *mddev)
 {
-	unsigned int size;
+	sector_t size;
 
 	if (mddev->persistent)
 		size = calc_dev_sboffset(bdev);
 	else
 		size = bdev->bd_inode->i_size >> BLOCK_SIZE_BITS;
 	if (mddev->chunk_size)
-		size &= ~(mddev->chunk_size/1024 - 1);
+		size &= ~((sector_t)mddev->chunk_size/1024 - 1);
 	return size;
 }
 
-static unsigned int zoned_raid_size(mddev_t *mddev)
+static sector_t zoned_raid_size(mddev_t *mddev)
 {
-	unsigned int mask;
+	sector_t mask;
 	mdk_rdev_t * rdev;
 	struct list_head *tmp;
 
 	/*
 	 * do size and offset calculations.
 	 */
-	mask = ~(mddev->chunk_size/1024 - 1);
+	mask = ~((sector_t)mddev->chunk_size/1024 - 1);
 
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		rdev->size &= mask;
@@ -418,7 +418,7 @@
 
 static int read_disk_sb(mdk_rdev_t * rdev)
 {
-	unsigned long sb_offset;
+	sector_t sb_offset;
 
 	if (!rdev->sb) {
 		MD_BUG();
@@ -594,10 +594,10 @@
 		MD_BUG();
 	free_disk_sb(rdev);
 	list_del_init(&rdev->same_set);
-	unlock_rdev(rdev);
 #ifndef MODULE
 	md_autodetect_dev(rdev->bdev->bd_dev);
 #endif
+	unlock_rdev(rdev);
 	rdev->faulty = 0;
 	kfree(rdev);
 }
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
@@ -767,7 +767,8 @@
 
 static int write_disk_sb(mdk_rdev_t * rdev)
 {
-	unsigned long sb_offset, size;
+	sector_t sb_offset;
+	sector_t size;
 
 	if (!rdev->sb) {
 		MD_BUG();
@@ -784,8 +785,10 @@
 
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
@@ -795,12 +798,14 @@
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
@@ -990,7 +995,7 @@
 {
 	int err;
 	mdk_rdev_t *rdev;
-	unsigned int size;
+	sector_t size;
 
 	rdev = (mdk_rdev_t *) kmalloc(sizeof(*rdev), GFP_KERNEL);
 	if (!rdev) {
@@ -1267,9 +1272,9 @@
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
@@ -1945,7 +1950,7 @@
 
 static int add_new_disk(mddev_t * mddev, mdu_disk_info_t *info)
 {
-	int size;
+	sector_t size;
 	mdk_rdev_t *rdev;
 	dev_t dev;
 	dev = MKDEV(info->major,info->minor);
@@ -2111,8 +2116,9 @@
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
@@ -2434,9 +2440,9 @@
 		}
 
 		default:
-			printk(KERN_WARNING "md: %s(pid %d) used obsolete MD ioctl, "
-			       "upgrade your software to use new ictls.\n",
-			       current->comm, current->pid);
+			printk(KERN_WARNING "md: %s(pid %d) used obsolete MD ioctl, %x"
+			       "upgrade your software to use new ioctls.\n",
+			       current->comm, current->pid, cmd);
 			err = -EINVAL;
 			goto abort_unlock;
 	}
@@ -2733,7 +2739,8 @@
 static int md_status_read_proc(char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int sz = 0, j, size;
+	int sz = 0, j;
+	sector_t size;
 	struct list_head *tmp, *tmp2;
 	mdk_rdev_t *rdev;
 	mddev_t *mddev;
@@ -2767,10 +2774,10 @@
 
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/md/multipath.c linux-2.5-lbd/drivers/md/multipath.c
--- linux-2.5-import/drivers/md/multipath.c	Fri Aug 16 13:24:34 2002
+++ linux-2.5-lbd/drivers/md/multipath.c	Thu Aug 15 12:15:41 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/md/raid0.c linux-2.5-lbd/drivers/md/raid0.c
--- linux-2.5-import/drivers/md/raid0.c	Fri Aug 16 13:24:34 2002
+++ linux-2.5-lbd/drivers/md/raid0.c	Thu Aug 22 13:53:33 2002
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
@@ -87,7 +87,7 @@
 	cnt = 0;
 	smallest = NULL;
 	ITERATE_RDEV(mddev, rdev1, tmp1) {
-		int j = rdev1->sb->this_disk.raid_disk;
+		int j = rdev1->raid_disk;
 
 		if (j < 0 || j >= mddev->raid_disks) {
 			printk("raid0: bad disk number %d - aborting!\n", j);
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/md/raid1.c linux-2.5-lbd/drivers/md/raid1.c
--- linux-2.5-import/drivers/md/raid1.c	Fri Aug 16 13:24:34 2002
+++ linux-2.5-lbd/drivers/md/raid1.c	Thu Aug 15 12:15:41 2002
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
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/md/raid5.c linux-2.5-lbd/drivers/md/raid5.c
--- linux-2.5-import/drivers/md/raid5.c	Fri Aug 16 13:24:34 2002
+++ linux-2.5-lbd/drivers/md/raid5.c	Thu Aug 15 12:15:41 2002
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
@@ -416,7 +416,7 @@
 }
 
 
-static unsigned long compute_blocknr(struct stripe_head *sh, int i);
+static sector_t compute_blocknr(struct stripe_head *sh, int i);
 	
 static void raid5_build_block (struct stripe_head *sh, int i)
 {
@@ -675,7 +675,7 @@
 		if (test_bit(R5_UPTODATE, &sh->dev[i].flags))
 			ptr[count++] = p;
 		else
-			printk("compute_block() %d, stripe %lu, %d not present\n", dd_idx, sh->sector, i);
+			printk("compute_block() %d, stripe %llu, %d not present\n", dd_idx, (unsigned long long)sh->sector, i);
 
 		check_xor();
 	}
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/mtd/devices/blkmtd.c linux-2.5-lbd/drivers/mtd/devices/blkmtd.c
--- linux-2.5-import/drivers/mtd/devices/blkmtd.c	Fri Aug 16 13:24:38 2002
+++ linux-2.5-lbd/drivers/mtd/devices/blkmtd.c	Thu Aug 15 12:15:42 2002
@@ -163,9 +163,10 @@
 static int blkmtd_readpage(mtd_raw_dev_data_t *rawdevice, struct page *page)
 {  
   int err;
-  int sectornr, sectors, i;
+  sector_t sectornr;
+  int sectors, i;
   struct kiobuf *iobuf;
-  unsigned long *blocks;
+  sector_t *blocks;
 
   if(!rawdevice) {
     printk("blkmtd: readpage: PANIC file->private_data == NULL\n");
@@ -224,7 +225,7 @@
 
   /* Pre 2.4.4 doesn't have space for the block list in the kiobuf */ 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
-  blocks = kmalloc(KIO_MAX_SECTORS * sizeof(unsigned long));
+  blocks = kmalloc(KIO_MAX_SECTORS * sizeof(*blocks));
   if(blocks == NULL) {
     printk("blkmtd: cant allocate iobuf blocks\n");
     free_kiovec(1, &iobuf);
@@ -240,7 +241,7 @@
   iobuf->length = PAGE_SIZE;
   iobuf->locked = 1;
   iobuf->maplist[0] = page;
-  sectornr = page->index << (PAGE_SHIFT - rawdevice->sector_bits);
+  sectornr = (sector_t)page->index << (PAGE_SHIFT - rawdevice->sector_bits);
   sectors = 1 << (PAGE_SHIFT - rawdevice->sector_bits);
   if(rawdevice->partial_last_page && page->index == rawdevice->partial_last_page) {
     DEBUG(3, "blkmtd: handling partial last page\n");
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/mtd/mtdblock.c linux-2.5-lbd/drivers/mtd/mtdblock.c
--- linux-2.5-import/drivers/mtd/mtdblock.c	Fri Aug 16 13:24:37 2002
+++ linux-2.5-lbd/drivers/mtd/mtdblock.c	Thu Aug 15 12:15:42 2002
@@ -46,7 +46,7 @@
 
 static spinlock_t mtdblks_lock;
 
-static int mtd_sizes[MAX_MTD_DEVICES];
+static sector_t mtd_sizes[MAX_MTD_DEVICES];
 
 /*
  * Cache stuff...
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/mtd/nftlcore.c linux-2.5-lbd/drivers/mtd/nftlcore.c
--- linux-2.5-import/drivers/mtd/nftlcore.c	Fri Aug 16 13:24:37 2002
+++ linux-2.5-lbd/drivers/mtd/nftlcore.c	Thu Aug 15 12:15:42 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/scsi/scsi.c linux-2.5-lbd/drivers/scsi/scsi.c
--- linux-2.5-import/drivers/scsi/scsi.c	Fri Aug 16 13:25:16 2002
+++ linux-2.5-lbd/drivers/scsi/scsi.c	Thu Aug 15 12:15:47 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/scsi/sd.c linux-2.5-lbd/drivers/scsi/sd.c
--- linux-2.5-import/drivers/scsi/sd.c	Fri Aug 16 13:25:17 2002
+++ linux-2.5-lbd/drivers/scsi/sd.c	Thu Aug 22 11:17:23 2002
@@ -298,7 +298,8 @@
  **/
 static int sd_init_command(Scsi_Cmnd * SCpnt)
 {
-	int dsk_nr, part_nr, block, this_count;
+	int dsk_nr, part_nr, this_count;
+	sector_t block;
 	Scsi_Device *sdp;
 #if CONFIG_SCSI_LOGGING
 	char nbuff[6];
@@ -315,8 +316,8 @@
 	block = SCpnt->request->sector;
 	this_count = SCpnt->request_bufflen >> 9;
 
-	SCSI_LOG_HLQUEUE(1, printk("sd_command_init: dsk_nr=%d, block=%d, "
-			    "count=%d\n", dsk_nr, block, this_count));
+	SCSI_LOG_HLQUEUE(1, printk("sd_command_init: dsk_nr=%d, block=%llu, "
+			    "count=%d\n", dsk_nr, (unsigned long long)block, this_count));
 
 	sdp = SCpnt->device;
 	/* >>>>> the "(part_nr & 0xf)" excludes 15th partition, why?? */
@@ -339,8 +340,8 @@
 		return 0;
 	}
 	SCSI_LOG_HLQUEUE(2, sd_dskname(dsk_nr, nbuff));
-	SCSI_LOG_HLQUEUE(2, printk("%s : [part_nr=%d], block=%d\n",
-				   nbuff, part_nr, block));
+	SCSI_LOG_HLQUEUE(2, printk("%s : [part_nr=%d], block=%llu\n",
+				   nbuff, part_nr, (unsigned long long)block));
 
 	/*
 	 * If we have a 1K hardware sectorsize, prevent access to single
@@ -611,8 +612,8 @@
 	int result = SCpnt->result;
 	int this_count = SCpnt->bufflen >> 9;
 	int good_sectors = (result == 0 ? this_count : 0);
-	int block_sectors = 1;
-	long error_sector;
+	sector_t block_sectors = 1;
+	sector_t error_sector;
 #if CONFIG_SCSI_LOGGING
 	char nbuff[6];
 
@@ -947,7 +948,7 @@
 		    SRpnt->sr_sense_buffer[2] == NOT_READY)
 			sdp->changed = 1;
 
-		/* Either no media are present but the drive didnt tell us,
+		/* Either no media are present but the drive didn't tell us,
 		   or they are present but the read capacity command fails */
 		/* sdkp->media_present = 0; -- not always correct */
 		sdkp->capacity = 0x200000; /* 1 GB - random */
@@ -955,7 +956,7 @@
 		return;
 	}
 
-	sdkp->capacity = 1 + ((buffer[0] << 24) |
+	sdkp->capacity = 1 + (((sector_t)buffer[0] << 24) |
 			      (buffer[1] << 16) |
 			      (buffer[2] << 8) |
 			      buffer[3]);
@@ -991,24 +992,31 @@
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/scsi/sd.h linux-2.5-lbd/drivers/scsi/sd.h
--- linux-2.5-import/drivers/scsi/sd.h	Fri Aug 16 13:25:17 2002
+++ linux-2.5-lbd/drivers/scsi/sd.h	Thu Aug 15 12:15:47 2002
@@ -23,7 +23,7 @@
 extern struct hd_struct *sd;
 
 typedef struct scsi_disk {
-	unsigned capacity;		/* size in 512-byte sectors */
+	sector_t capacity;		/* size in 512-byte sectors */
 	Scsi_Device *device;
 	unsigned char media_present;
 	unsigned char write_prot;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/drivers/scsi/sr.c linux-2.5-lbd/drivers/scsi/sr.c
--- linux-2.5-import/drivers/scsi/sr.c	Fri Aug 16 13:25:17 2002
+++ linux-2.5-lbd/drivers/scsi/sr.c	Thu Aug 15 12:15:47 2002
@@ -88,7 +88,7 @@
 };
 
 Scsi_CD *scsi_CDs;
-static int *sr_sizes;
+static sector_t *sr_sizes;
 
 static int sr_open(struct cdrom_device_info *, int);
 void get_sectorsize(int);
@@ -324,7 +324,7 @@
 	/*
 	 * request doesn't start on hw block boundary, add scatter pads
 	 */
-	if ((SCpnt->request->sector % (s_size >> 9)) || (SCpnt->request_bufflen % s_size)) {
+	if (((unsigned int)SCpnt->request->sector % (s_size >> 9)) || (SCpnt->request_bufflen % s_size)) {
 		printk("sr: unaligned transfer\n");
 		return 0;
 	}
@@ -340,7 +340,7 @@
 	SCpnt->cmnd[1] = (SCpnt->device->scsi_level <= SCSI_2) ?
 			 ((SCpnt->lun << 5) & 0xe0) : 0;
 
-	block = SCpnt->request->sector / (s_size >> 9);
+	block = (unsigned int)SCpnt->request->sector / (s_size >> 9);
 
 	if (this_count > 0xffff)
 		this_count = 0xffff;
@@ -715,10 +715,10 @@
 		goto cleanup_dev;
 	memset(scsi_CDs, 0, sr_template.dev_max * sizeof(Scsi_CD));
 
-	sr_sizes = kmalloc(sr_template.dev_max * sizeof(int), GFP_ATOMIC);
+	sr_sizes = kmalloc(sr_template.dev_max * sizeof(sr_sizes[0]), GFP_ATOMIC);
 	if (!sr_sizes)
 		goto cleanup_cds;
-	memset(sr_sizes, 0, sr_template.dev_max * sizeof(int));
+	memset(sr_sizes, 0, sr_template.dev_max * sizeof(sr_sizes[0]));
 	return 0;
 
 cleanup_cds:
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/adfs/inode.c linux-2.5-lbd/fs/adfs/inode.c
--- linux-2.5-import/fs/adfs/inode.c	Fri Aug 16 13:25:59 2002
+++ linux-2.5-lbd/fs/adfs/inode.c	Thu Aug 15 12:15:51 2002
@@ -67,7 +67,7 @@
 		&ADFS_I(page->mapping->host)->mmu_private);
 }
 
-static int _adfs_bmap(struct address_space *mapping, long block)
+static sector_t _adfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, adfs_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/affs/file.c linux-2.5-lbd/fs/affs/file.c
--- linux-2.5-import/fs/affs/file.c	Fri Aug 16 13:26:03 2002
+++ linux-2.5-lbd/fs/affs/file.c	Thu Aug 15 12:15:51 2002
@@ -337,10 +337,11 @@
 	struct buffer_head	*ext_bh;
 	u32			 ext;
 
-	pr_debug("AFFS: get_block(%u, %ld)\n", (u32)inode->i_ino, block);
+	pr_debug("AFFS: get_block(%u, %lu)\n", (u32)inode->i_ino, (unsigned long)block);
 
-	if (block < 0)
-		goto err_small;
+
+	if (block > (sector_t)0x7fffffffUL)
+		BUG();
 
 	if (block >= AFFS_I(inode)->i_blkcnt) {
 		if (block > AFFS_I(inode)->i_blkcnt || !create)
@@ -351,12 +352,12 @@
 	//lock cache
 	affs_lock_ext(inode);
 
-	ext = block / AFFS_SB(sb)->s_hashsize;
+	ext = (u32)block / AFFS_SB(sb)->s_hashsize;
 	block -= ext * AFFS_SB(sb)->s_hashsize;
 	ext_bh = affs_get_extblock(inode, ext);
 	if (IS_ERR(ext_bh))
 		goto err_ext;
-	map_bh(bh_result, sb, be32_to_cpu(AFFS_BLOCK(sb, ext_bh, block)));
+	map_bh(bh_result, sb, (sector_t)be32_to_cpu(AFFS_BLOCK(sb, ext_bh, block)));
 
 	if (create) {
 		u32 blocknr = affs_alloc_block(inode, ext_bh->b_blocknr);
@@ -421,7 +422,7 @@
 	return cont_prepare_write(page, from, to, affs_get_block,
 		&AFFS_I(page->mapping->host)->mmu_private);
 }
-static int _affs_bmap(struct address_space *mapping, long block)
+static sector_t _affs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,affs_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/affs/inode.c linux-2.5-lbd/fs/affs/inode.c
--- linux-2.5-import/fs/affs/inode.c	Fri Aug 16 13:26:03 2002
+++ linux-2.5-lbd/fs/affs/inode.c	Thu Aug 15 12:15:51 2002
@@ -416,7 +416,7 @@
 	}
 	affs_fix_checksum(sb, bh);
 	mark_buffer_dirty_inode(bh, inode);
-	dentry->d_fsdata = (void *)bh->b_blocknr;
+	dentry->d_fsdata = (void *)(long)bh->b_blocknr;
 
 	affs_lock_dir(dir);
 	retval = affs_insert_hash(dir, bh);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/bfs/file.c linux-2.5-lbd/fs/bfs/file.c
--- linux-2.5-import/fs/bfs/file.c	Fri Aug 16 13:26:03 2002
+++ linux-2.5-lbd/fs/bfs/file.c	Thu Aug 15 12:15:51 2002
@@ -145,7 +145,7 @@
 	return block_prepare_write(page, from, to, bfs_get_block);
 }
 
-static int bfs_bmap(struct address_space *mapping, long block)
+static sector_t bfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, bfs_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/buffer.c linux-2.5-lbd/fs/buffer.c
--- linux-2.5-import/fs/buffer.c	Fri Aug 16 13:25:57 2002
+++ linux-2.5-lbd/fs/buffer.c	Thu Aug 15 12:15:51 2002
@@ -1818,7 +1818,7 @@
 		unsigned from, unsigned to, get_block_t *get_block)
 {
 	unsigned block_start, block_end;
-	unsigned long block;
+	sector_t block;
 	int err = 0;
 	unsigned blocksize, bbits;
 	struct buffer_head *bh, *head, *wait[2], **wait_bh=wait;
@@ -1835,7 +1835,7 @@
 	head = page_buffers(page);
 
 	bbits = inode->i_blkbits;
-	block = page->index << (PAGE_CACHE_SHIFT - bbits);
+	block = (sector_t)page->index << (PAGE_CACHE_SHIFT - bbits);
 
 	for(bh = head, block_start = 0; bh != head || !block_start;
 	    block++, block_start=block_end, bh = bh->b_this_page) {
@@ -1966,7 +1966,7 @@
 int block_read_full_page(struct page *page, get_block_t *get_block)
 {
 	struct inode *inode = page->mapping->host;
-	unsigned long iblock, lblock;
+	sector_t iblock, lblock;
 	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
 	unsigned int blocksize, blocks;
 	int nr, i;
@@ -1981,7 +1981,7 @@
 	head = page_buffers(page);
 
 	blocks = PAGE_CACHE_SIZE >> inode->i_blkbits;
-	iblock = page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
+	iblock = (sector_t)page->index << (PAGE_CACHE_SHIFT - inode->i_blkbits);
 	lblock = (inode->i_size+blocksize-1) >> inode->i_blkbits;
 	bh = head;
 	nr = 0;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/efs/inode.c linux-2.5-lbd/fs/efs/inode.c
--- linux-2.5-import/fs/efs/inode.c	Fri Aug 16 13:26:04 2002
+++ linux-2.5-lbd/fs/efs/inode.c	Thu Aug 15 12:15:51 2002
@@ -19,7 +19,7 @@
 {
 	return block_read_full_page(page,efs_get_block);
 }
-static int _efs_bmap(struct address_space *mapping, long block)
+static sector_t _efs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,efs_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/ext2/inode.c linux-2.5-lbd/fs/ext2/inode.c
--- linux-2.5-import/fs/ext2/inode.c	Fri Aug 16 13:26:04 2002
+++ linux-2.5-lbd/fs/ext2/inode.c	Thu Aug 15 12:15:51 2002
@@ -601,7 +601,7 @@
 	return block_prepare_write(page,from,to,ext2_get_block);
 }
 
-static int ext2_bmap(struct address_space *mapping, long block)
+static sector_t ext2_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,ext2_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/ext3/ialloc.c linux-2.5-lbd/fs/ext3/ialloc.c
--- linux-2.5-import/fs/ext3/ialloc.c	Fri Aug 16 13:26:04 2002
+++ linux-2.5-lbd/fs/ext3/ialloc.c	Thu Aug 15 12:15:51 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/ext3/inode.c linux-2.5-lbd/fs/ext3/inode.c
--- linux-2.5-import/fs/ext3/inode.c	Fri Aug 16 13:26:04 2002
+++ linux-2.5-lbd/fs/ext3/inode.c	Thu Aug 15 12:15:51 2002
@@ -1167,7 +1167,7 @@
  * So, if we see any bmap calls here on a modified, data-journaled file,
  * take extra steps to flush any blocks which might be in the cache. 
  */
-static int ext3_bmap(struct address_space *mapping, long block)
+static sector_t ext3_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
 	journal_t *journal;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/fat/file.c linux-2.5-lbd/fs/fat/file.c
--- linux-2.5-import/fs/fat/file.c	Fri Aug 16 13:26:04 2002
+++ linux-2.5-lbd/fs/fat/file.c	Thu Aug 15 12:15:51 2002
@@ -59,7 +59,7 @@
 		BUG();
 		return -EIO;
 	}
-	if (!(iblock % MSDOS_SB(sb)->cluster_size)) {
+	if (!((unsigned long)iblock % MSDOS_SB(sb)->cluster_size)) {
 		int error;
 
 		error = fat_add_cluster(inode);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/fat/inode.c linux-2.5-lbd/fs/fat/inode.c
--- linux-2.5-import/fs/fat/inode.c	Fri Aug 16 13:26:04 2002
+++ linux-2.5-lbd/fs/fat/inode.c	Thu Aug 15 12:15:51 2002
@@ -987,7 +987,7 @@
 	return cont_prepare_write(page,from,to,fat_get_block,
 		&MSDOS_I(page->mapping->host)->mmu_private);
 }
-static int _fat_bmap(struct address_space *mapping, long block)
+static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,fat_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/freevxfs/vxfs_subr.c linux-2.5-lbd/fs/freevxfs/vxfs_subr.c
--- linux-2.5-import/fs/freevxfs/vxfs_subr.c	Fri Aug 16 13:26:05 2002
+++ linux-2.5-lbd/fs/freevxfs/vxfs_subr.c	Thu Aug 15 12:15:51 2002
@@ -43,7 +43,7 @@
 
 
 static int		vxfs_readpage(struct file *, struct page *);
-static int		vxfs_bmap(struct address_space *, long);
+static sector_t		vxfs_bmap(struct address_space *, sector_t);
 
 struct address_space_operations vxfs_aops = {
 	.readpage =		vxfs_readpage,
@@ -186,8 +186,8 @@
  * Locking status:
  *   We are under the bkl.
  */
-static int
-vxfs_bmap(struct address_space *mapping, long block)
+static sector_t
+vxfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, vxfs_getblk);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/hfs/inode.c linux-2.5-lbd/fs/hfs/inode.c
--- linux-2.5-import/fs/hfs/inode.c	Fri Aug 16 13:26:05 2002
+++ linux-2.5-lbd/fs/hfs/inode.c	Thu Aug 15 12:15:51 2002
@@ -242,7 +242,7 @@
 	return cont_prepare_write(page,from,to,hfs_get_block,
 		&HFS_I(page->mapping->host)->mmu_private);
 }
-static int hfs_bmap(struct address_space *mapping, long block)
+static sector_t hfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,hfs_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/hpfs/file.c linux-2.5-lbd/fs/hpfs/file.c
--- linux-2.5-import/fs/hpfs/file.c	Fri Aug 16 13:26:05 2002
+++ linux-2.5-lbd/fs/hpfs/file.c	Thu Aug 15 12:15:51 2002
@@ -111,7 +111,7 @@
 	return cont_prepare_write(page,from,to,hpfs_get_block,
 		&hpfs_i(page->mapping->host)->mmu_private);
 }
-static int _hpfs_bmap(struct address_space *mapping, long block)
+static sector_t _hpfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,hpfs_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/inode.c linux-2.5-lbd/fs/inode.c
--- linux-2.5-import/fs/inode.c	Fri Aug 16 13:25:57 2002
+++ linux-2.5-lbd/fs/inode.c	Thu Aug 15 12:15:51 2002
@@ -917,9 +917,9 @@
  *	file.
  */
  
-int bmap(struct inode * inode, int block)
+sector_t bmap(struct inode * inode, sector_t block)
 {
-	int res = 0;
+	sector_t res = 0;
 	if (inode->i_mapping->a_ops->bmap)
 		res = inode->i_mapping->a_ops->bmap(inode->i_mapping, block);
 	return res;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/isofs/inode.c linux-2.5-lbd/fs/isofs/inode.c
--- linux-2.5-import/fs/isofs/inode.c	Fri Aug 16 13:26:06 2002
+++ linux-2.5-lbd/fs/isofs/inode.c	Thu Aug 15 12:15:51 2002
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
@@ -1044,9 +1044,9 @@
 	return 0;
 }
 
-struct buffer_head *isofs_bread(struct inode *inode, unsigned int block)
+struct buffer_head *isofs_bread(struct inode *inode, sector_t block)
 {
-	unsigned int blknr = isofs_bmap(inode, block);
+	sector_t blknr = isofs_bmap(inode, block);
 	if (!blknr)
 		return NULL;
 	return sb_bread(inode->i_sb, blknr);
@@ -1057,7 +1057,7 @@
 	return block_read_full_page(page,isofs_get_block);
 }
 
-static int _isofs_bmap(struct address_space *mapping, long block)
+static sector_t _isofs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,isofs_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/jbd/commit.c linux-2.5-lbd/fs/jbd/commit.c
--- linux-2.5-import/fs/jbd/commit.c	Fri Aug 16 13:26:06 2002
+++ linux-2.5-lbd/fs/jbd/commit.c	Thu Aug 15 12:15:51 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/jbd/revoke.c linux-2.5-lbd/fs/jbd/revoke.c
--- linux-2.5-import/fs/jbd/revoke.c	Fri Aug 16 13:26:06 2002
+++ linux-2.5-lbd/fs/jbd/revoke.c	Thu Aug 15 12:15:51 2002
@@ -388,7 +388,7 @@
 		record = find_revoke_record(journal, bh->b_blocknr);
 		if (record) {
 			jbd_debug(4, "cancelled existing revoke on "
-				  "blocknr %lu\n", bh->b_blocknr);
+				  "blocknr %llu\n", (u64)bh->b_blocknr);
 			list_del(&record->hash);
 			kmem_cache_free(revoke_record_cache, record);
 			did_revoke = 1;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/jfs/inode.c linux-2.5-lbd/fs/jfs/inode.c
--- linux-2.5-import/fs/jfs/inode.c	Fri Aug 16 13:26:06 2002
+++ linux-2.5-lbd/fs/jfs/inode.c	Thu Aug 15 12:15:52 2002
@@ -282,7 +282,7 @@
 	return block_prepare_write(page, from, to, jfs_get_block);
 }
 
-static int jfs_bmap(struct address_space *mapping, long block)
+static sector_t jfs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, jfs_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/jfs/jfs_metapage.c linux-2.5-lbd/fs/jfs/jfs_metapage.c
--- linux-2.5-import/fs/jfs/jfs_metapage.c	Fri Aug 16 13:26:07 2002
+++ linux-2.5-lbd/fs/jfs/jfs_metapage.c	Thu Aug 15 12:15:52 2002
@@ -256,7 +256,7 @@
 	return block_prepare_write(page, from, to, direct_get_block);
 }
 
-static int direct_bmap(struct address_space *mapping, long block)
+static sector_t direct_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping, block, direct_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/minix/inode.c linux-2.5-lbd/fs/minix/inode.c
--- linux-2.5-import/fs/minix/inode.c	Fri Aug 16 13:26:08 2002
+++ linux-2.5-lbd/fs/minix/inode.c	Thu Aug 15 12:15:52 2002
@@ -328,7 +328,7 @@
 {
 	return block_prepare_write(page,from,to,minix_get_block);
 }
-static int minix_bmap(struct address_space *mapping, long block)
+static sector_t minix_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,minix_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/partitions/acorn.c linux-2.5-lbd/fs/partitions/acorn.c
--- linux-2.5-import/fs/partitions/acorn.c	Fri Aug 16 13:26:10 2002
+++ linux-2.5-lbd/fs/partitions/acorn.c	Thu Aug 15 12:16:10 2002
@@ -17,10 +17,10 @@
 
 static struct adfs_discrecord *
 adfs_partition(struct parsed_partitions *state, char *name, char *data,
-	       unsigned long first_sector, int slot)
+	       sector_t first_sector, int slot)
 {
 	struct adfs_discrecord *dr;
-	unsigned int nr_sects;
+	sector_t nr_sects;
 
 	if (adfs_checkbblk(data))
 		return NULL;
@@ -42,7 +42,7 @@
 #ifdef CONFIG_ACORN_PARTITION_RISCIX
 static int
 riscix_partition(struct parsed_partitions *state, struct block_device *bdev,
-		unsigned long first_sect, int slot, unsigned long nr_sects)
+		sector_t first_sect, int slot, sector_t nr_sects)
 {
 	Sector sect;
 	struct riscix_record *rr;
@@ -55,7 +55,7 @@
 
 
 	if (rr->magic == RISCIX_MAGIC) {
-		unsigned long size = nr_sects > 2 ? 2 : nr_sects;
+		sector_t size = nr_sects > 2 ? 2 : nr_sects;
 		int part;
 
 		printk(" <");
@@ -83,11 +83,11 @@
 
 static int
 linux_partition(struct parsed_partitions *state, struct block_device *bdev,
-		unsigned long first_sect, int slot, unsigned long nr_sects)
+		sector_t first_sect, int slot, sector_t nr_sects)
 {
 	Sector sect;
 	struct linux_part *linuxp;
-	unsigned long size = nr_sects > 2 ? 2 : nr_sects;
+	sector_t size = nr_sects > 2 ? 2 : nr_sects;
 
 	printk(" [Linux]");
 
@@ -117,7 +117,7 @@
 static int
 adfspart_check_CUMANA(struct parsed_partitions *state, struct block_device *bdev)
 {
-	unsigned long first_sector = 0;
+	sector_t first_sector = 0;
 	unsigned int start_blk = 0;
 	Sector sect;
 	unsigned char *data;
@@ -209,7 +209,8 @@
 static int
 adfspart_check_ADFS(struct parsed_partitions *state, struct block_device *bdev)
 {
-	unsigned long start_sect, nr_sects, sectscyl, heads;
+	sector_t start_sect, nr_sects, sectscyl;
+	unsigned heads;
 	Sector sect;
 	unsigned char *data;
 	struct adfs_discrecord *dr;
@@ -268,7 +269,7 @@
 #endif
 
 #ifdef CONFIG_ACORN_PARTITION_ICS
-static int adfspart_check_ICSLinux(struct block_device *bdev, unsigned long block)
+static int adfspart_check_ICSLinux(struct block_device *bdev, sector_t block)
 {
 	Sector sect;
 	unsigned char *data = read_dev_sector(bdev, block, &sect);
@@ -306,7 +307,7 @@
 	/*
 	 * Try ICS style partitions - sector 0 contains partition info.
 	 */
-	data = read_dev_sector(bdev, 0, &sect);
+	data = read_dev_sector(bdev, (sector_t)0, &sect);
 	if (!data)
 	    	return -1;
 
@@ -374,7 +375,7 @@
 	int slot = 1;
 	int i;
 
-	data = read_dev_sector(bdev, 0, &sect);
+	data = read_dev_sector(bdev, (sector_t)0, &sect);
 	if (!data)
 		return -1;
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/partitions/check.c linux-2.5-lbd/fs/partitions/check.c
--- linux-2.5-import/fs/partitions/check.c	Fri Aug 16 13:26:10 2002
+++ linux-2.5-lbd/fs/partitions/check.c	Fri Aug 16 09:51:56 2002
@@ -415,14 +415,14 @@
  */
 
 void register_disk(struct gendisk *gdev, kdev_t dev, unsigned minors,
-	struct block_device_operations *ops, long size)
+	struct block_device_operations *ops, sector_t size)
 {
 	if (!gdev)
 		return;
 	grok_partitions(dev, size);
 }
 
-void grok_partitions(kdev_t dev, long size)
+void grok_partitions(kdev_t dev, sector_t size)
 {
 	struct block_device *bdev;
 	struct gendisk *g = get_gendisk(dev);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/partitions/check.h linux-2.5-lbd/fs/partitions/check.h
--- linux-2.5-import/fs/partitions/check.h	Fri Aug 16 13:26:10 2002
+++ linux-2.5-lbd/fs/partitions/check.h	Thu Aug 15 12:16:16 2002
@@ -5,14 +5,13 @@
  * add_gd_partition adds a partitions details to the devices partition
  * description.
  */
-
 enum { MAX_PART = 256 };
 
 struct parsed_partitions {
 	char name[40];
 	struct {
-		unsigned long from;
-		unsigned long size;
+		sector_t from;
+		sector_t size;
 		int flags;
 	} parts[MAX_PART];
 	int next;
@@ -20,7 +19,7 @@
 };
 
 static inline void
-put_partition(struct parsed_partitions *p, int n, int from, int size)
+put_partition(struct parsed_partitions *p, int n, sector_t from, sector_t size)
 {
 	if (n < p->limit) {
 		p->parts[n].from = from;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/partitions/efi.c linux-2.5-lbd/fs/partitions/efi.c
--- linux-2.5-import/fs/partitions/efi.c	Fri Aug 16 13:26:10 2002
+++ linux-2.5-lbd/fs/partitions/efi.c	Thu Aug 15 12:16:16 2002
@@ -629,6 +629,7 @@
 	kfree(gpt);
 	printk("\n");
 	return 1;
+
 }
 
 /*
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/partitions/sun.c linux-2.5-lbd/fs/partitions/sun.c
--- linux-2.5-import/fs/partitions/sun.c	Fri Aug 16 13:26:11 2002
+++ linux-2.5-lbd/fs/partitions/sun.c	Thu Aug 15 12:16:16 2002
@@ -63,7 +63,7 @@
 	/* All Sun disks have 8 partition entries */
 	spc = be16_to_cpu(label->ntrks) * be16_to_cpu(label->nsect);
 	for(i=0; i < 8; i++, p++) {
-		unsigned long st_sector;
+		sector_t st_sector;
 		int num_sectors;
 
 		st_sector = be32_to_cpu(p->start_cylinder) * spc;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/qnx4/inode.c linux-2.5-lbd/fs/qnx4/inode.c
--- linux-2.5-import/fs/qnx4/inode.c	Fri Aug 16 13:26:11 2002
+++ linux-2.5-lbd/fs/qnx4/inode.c	Thu Aug 15 12:16:16 2002
@@ -444,7 +444,7 @@
 	return cont_prepare_write(page, from, to, qnx4_get_block,
 				  &qnx4_inode->mmu_private);
 }
-static int qnx4_bmap(struct address_space *mapping, long block)
+static sector_t qnx4_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,qnx4_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/reiserfs/inode.c linux-2.5-lbd/fs/reiserfs/inode.c
--- linux-2.5-import/fs/reiserfs/inode.c	Fri Aug 16 13:26:11 2002
+++ linux-2.5-lbd/fs/reiserfs/inode.c	Thu Aug 15 12:16:36 2002
@@ -2045,7 +2045,7 @@
 }
 
 
-static int reiserfs_aop_bmap(struct address_space *as, long block) {
+static sector_t reiserfs_aop_bmap(struct address_space *as, sector_t block) {
   return generic_block_bmap(as, block, reiserfs_bmap) ;
 }
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/reiserfs/journal.c linux-2.5-lbd/fs/reiserfs/journal.c
--- linux-2.5-import/fs/reiserfs/journal.c	Fri Aug 16 13:26:11 2002
+++ linux-2.5-lbd/fs/reiserfs/journal.c	Thu Aug 15 12:16:36 2002
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
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/reiserfs/prints.c linux-2.5-lbd/fs/reiserfs/prints.c
--- linux-2.5-import/fs/reiserfs/prints.c	Fri Aug 16 13:26:11 2002
+++ linux-2.5-lbd/fs/reiserfs/prints.c	Thu Aug 15 12:16:36 2002
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
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/reiserfs/super.c linux-2.5-lbd/fs/reiserfs/super.c
--- linux-2.5-import/fs/reiserfs/super.c	Fri Aug 16 13:26:11 2002
+++ linux-2.5-lbd/fs/reiserfs/super.c	Thu Aug 15 12:16:36 2002
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
@@ -902,7 +902,7 @@
     ll_rw_block(READ, 1, &(SB_AP_BITMAP(s)[i])) ;
     wait_on_buffer(SB_AP_BITMAP(s)[i]) ;
     if (!buffer_uptodate(SB_AP_BITMAP(s)[i])) {
-      printk("reread_meta_blocks, error reading bitmap block number %d at %ld\n", i, SB_AP_BITMAP(s)[i]->b_blocknr) ;
+      printk("reread_meta_blocks, error reading bitmap block number %d at %lld\n", i, (long long)SB_AP_BITMAP(s)[i]->b_blocknr) ;
       return 1 ;
     }
   }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/sysv/itree.c linux-2.5-lbd/fs/sysv/itree.c
--- linux-2.5-import/fs/sysv/itree.c	Fri Aug 16 13:26:12 2002
+++ linux-2.5-lbd/fs/sysv/itree.c	Thu Aug 15 12:16:36 2002
@@ -459,7 +459,7 @@
 {
 	return block_prepare_write(page,from,to,get_block);
 }
-static int sysv_bmap(struct address_space *mapping, long block)
+static sector_t sysv_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/udf/inode.c linux-2.5-lbd/fs/udf/inode.c
--- linux-2.5-import/fs/udf/inode.c	Fri Aug 16 13:26:12 2002
+++ linux-2.5-lbd/fs/udf/inode.c	Thu Aug 15 12:16:36 2002
@@ -146,7 +146,7 @@
 	return block_prepare_write(page, from, to, udf_get_block);
 }
 
-static int udf_bmap(struct address_space *mapping, long block)
+static sector_t udf_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,udf_get_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/fs/ufs/inode.c linux-2.5-lbd/fs/ufs/inode.c
--- linux-2.5-import/fs/ufs/inode.c	Wed Aug 21 11:07:48 2002
+++ linux-2.5-lbd/fs/ufs/inode.c	Thu Aug 22 08:47:12 2002
@@ -457,7 +457,7 @@
 {
 	return block_prepare_write(page,from,to,ufs_getfrag_block);
 }
-static int ufs_bmap(struct address_space *mapping, long block)
+static sector_t ufs_bmap(struct address_space *mapping, sector_t block)
 {
 	return generic_block_bmap(mapping,block,ufs_getfrag_block);
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-i386/types.h linux-2.5-lbd/include/asm-i386/types.h
--- linux-2.5-import/include/asm-i386/types.h	Fri Aug 16 13:26:23 2002
+++ linux-2.5-lbd/include/asm-i386/types.h	Thu Aug 15 12:16:39 2002
@@ -52,6 +52,11 @@
 #endif
 typedef u64 dma64_addr_t;
 
+#ifdef CONFIG_LBD
+typedef u64 sector_t;
+#define HAVE_SECTOR_T
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/asm-ppc/types.h linux-2.5-lbd/include/asm-ppc/types.h
--- linux-2.5-import/include/asm-ppc/types.h	Fri Aug 16 13:26:38 2002
+++ linux-2.5-lbd/include/asm-ppc/types.h	Thu Aug 15 12:16:43 2002
@@ -48,6 +48,11 @@
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
+#ifdef CONFIG_LBD
+typedef u64 sector_t;
+#define HAVE_SECTOR_T
+#endif
+
 #endif /* __KERNEL__ */
 
 /*
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/blkdev.h linux-2.5-lbd/include/linux/blkdev.h
--- linux-2.5-import/include/linux/blkdev.h	Mon Aug 19 13:07:08 2002
+++ linux-2.5-lbd/include/linux/blkdev.h	Thu Aug 22 08:47:12 2002
@@ -37,7 +37,7 @@
 	int errors;
 	sector_t sector;
 	unsigned long nr_sectors;
-	unsigned long hard_sector;	/* the hard_* are block layer
+	sector_t hard_sector;		/* the hard_* are block layer
 					 * internals, no driver should
 					 * touch them
 					 */
@@ -281,10 +281,10 @@
 
 extern struct sec_size * blk_sec[MAX_BLKDEV];
 extern struct blk_dev_struct blk_dev[MAX_BLKDEV];
-extern void grok_partitions(kdev_t dev, long size);
+extern void grok_partitions(kdev_t dev, sector_t size);
 extern int wipe_partitions(kdev_t dev);
-extern void register_disk(struct gendisk *dev, kdev_t first, unsigned minors, struct block_device_operations *ops, long size);
 extern void check_partition(struct gendisk *disk, struct block_device *bdev);
+extern void register_disk(struct gendisk *dev, kdev_t first, unsigned minors, struct block_device_operations *ops, sector_t size);
 extern void generic_make_request(struct bio *bio);
 extern inline request_queue_t *bdev_get_queue(struct block_device *bdev);
 extern void blk_put_request(struct request *);
@@ -344,7 +344,7 @@
 extern void blk_queue_free_tags(request_queue_t *);
 extern void blk_queue_invalidate_tags(request_queue_t *);
 
-extern int * blk_size[MAX_BLKDEV];	/* in units of 1024 bytes */
+extern sector_t *blk_size[MAX_BLKDEV];	/* in units of 1024 bytes */
 
 #define MAX_PHYS_SEGMENTS 128
 #define MAX_HW_SEGMENTS 128
@@ -403,5 +403,21 @@
 {
 	page_cache_release(p.v);
 }
+
+#ifdef CONFIG_LBD
+# include <asm/div64.h>
+# define sector_div(a, b) do_div(a, b)
+#else
+# define sector_div(n, b)( \
+{ \
+	int _res; \
+	_res = (n) % (b); \
+	(n) /= (b); \
+	_res; \
+} \
+)
+#endif 
+ 
+
 
 #endif
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/fs.h linux-2.5-lbd/include/linux/fs.h
--- linux-2.5-import/include/linux/fs.h	Wed Aug 21 11:07:49 2002
+++ linux-2.5-lbd/include/linux/fs.h	Thu Aug 22 08:47:12 2002
@@ -304,7 +304,7 @@
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
-	int (*bmap)(struct address_space *, long);
+	sector_t (*bmap)(struct address_space *, sector_t);
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
 	int (*direct_IO)(int, struct inode *, char *buf,
@@ -355,7 +355,7 @@
 	int			bd_holders;
 	struct block_device *	bd_contains;
 	unsigned		bd_block_size;
-	unsigned long		bd_offset;
+	sector_t		bd_offset;
 	unsigned		bd_part_count;
 	int			bd_invalidated;
 };
@@ -1138,7 +1138,7 @@
 extern int filemap_fdatawrite(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(void);
-extern int bmap(struct inode *, int);
+extern sector_t bmap(struct inode *, sector_t);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int);
 extern int vfs_permission(struct inode *, int);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/genhd.h linux-2.5-lbd/include/linux/genhd.h
--- linux-2.5-import/include/linux/genhd.h	Fri Aug 16 13:26:57 2002
+++ linux-2.5-lbd/include/linux/genhd.h	Thu Aug 15 12:16:47 2002
@@ -59,8 +59,8 @@
 #  include <linux/devfs_fs_kernel.h>
 
 struct hd_struct {
-	unsigned long start_sect;
-	unsigned long nr_sects;
+	sector_t start_sect;
+	sector_t nr_sects;
 	devfs_handle_t de;              /* primary (master) devfs entry  */
 	int number;                     /* stupid old code wastes space  */
 	struct device hd_driverfs_dev;  /* support driverfs hiearchy     */
@@ -90,7 +90,7 @@
 extern void add_gendisk(struct gendisk *gp);
 extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(kdev_t dev);
-static inline unsigned long get_start_sect(struct block_device *bdev)
+static inline sector_t get_start_sect(struct block_device *bdev)
 {
 	return bdev->bd_offset;
 }
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/iso_fs.h linux-2.5-lbd/include/linux/iso_fs.h
--- linux-2.5-import/include/linux/iso_fs.h	Fri Aug 16 13:26:58 2002
+++ linux-2.5-lbd/include/linux/iso_fs.h	Thu Aug 15 12:16:48 2002
@@ -230,7 +230,7 @@
 int get_acorn_filename(struct iso_directory_record *, char *, struct inode *);
 
 extern struct dentry *isofs_lookup(struct inode *, struct dentry *);
-extern struct buffer_head *isofs_bread(struct inode *, unsigned int);
+extern struct buffer_head *isofs_bread(struct inode *, sector_t);
 extern int isofs_get_blocks(struct inode *, sector_t, struct buffer_head **, unsigned long);
 
 extern struct inode_operations isofs_dir_inode_operations;
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/loop.h linux-2.5-lbd/include/linux/loop.h
--- linux-2.5-import/include/linux/loop.h	Fri Aug 16 13:26:59 2002
+++ linux-2.5-lbd/include/linux/loop.h	Thu Aug 15 12:16:48 2002
@@ -33,7 +33,7 @@
 	int		lo_flags;
 	int		(*transfer)(struct loop_device *, int cmd,
 				    char *raw_buf, char *loop_buf, int size,
-				    int real_block);
+				    sector_t real_block);
 	char		lo_name[LO_NAME_SIZE];
 	char		lo_encrypt_key[LO_KEY_SIZE];
 	__u32           lo_init[2];
@@ -121,7 +121,7 @@
 struct loop_func_table {
 	int number; 	/* filter type */ 
 	int (*transfer)(struct loop_device *lo, int cmd, char *raw_buf,
-			char *loop_buf, int size, int real_block);
+			char *loop_buf, int size, sector_t real_block);
 	int (*init)(struct loop_device *, struct loop_info *); 
 	/* release is called from loop_unregister_transfer or clr_fd */
 	int (*release)(struct loop_device *); 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/raid/md.h linux-2.5-lbd/include/linux/raid/md.h
--- linux-2.5-import/include/linux/raid/md.h	Fri Aug 16 13:27:06 2002
+++ linux-2.5-lbd/include/linux/raid/md.h	Thu Aug 15 12:16:49 2002
@@ -60,7 +60,7 @@
 #define MD_MINOR_VERSION                90
 #define MD_PATCHLEVEL_VERSION           0
 
-extern int md_size[MAX_MD_DEVS];
+extern sector_t md_size[MAX_MD_DEVS];
 extern struct hd_struct md_hd_struct[MAX_MD_DEVS];
 
 extern char * partition_name (kdev_t dev);
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/raid/md_k.h linux-2.5-lbd/include/linux/raid/md_k.h
--- linux-2.5-import/include/linux/raid/md_k.h	Fri Aug 16 13:27:06 2002
+++ linux-2.5-lbd/include/linux/raid/md_k.h	Thu Aug 15 12:16:49 2002
@@ -144,7 +144,7 @@
 {
 	struct list_head same_set;	/* RAID devices within the same set */
 
-	unsigned long size;		/* Device size (in blocks) */
+	sector_t size;			/* Device size (in blocks) */
 	mddev_t *mddev;			/* RAID array if running */
 	unsigned long last_events;	/* IO event timestamp */
 
@@ -152,7 +152,7 @@
 
 	struct page	*sb_page;
 	mdp_super_t	*sb;
-	unsigned long	sb_offset;
+	sector_t	sb_offset;
 
 	int alias_device;		/* device alias to the same disk */
 	int faulty;			/* if faulty do not issue IO requests */
@@ -348,5 +348,5 @@
 	__wait_disk_event(wq, condition);				\
 } while (0)
 
-#endif 
+#endif
 
diff -Nur --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5-import/include/linux/types.h linux-2.5-lbd/include/linux/types.h
--- linux-2.5-import/include/linux/types.h	Fri Aug 16 13:27:04 2002
+++ linux-2.5-lbd/include/linux/types.h	Thu Aug 15 12:16:49 2002
@@ -117,13 +117,11 @@
 #endif
 
 /*
- * transition to 64-bit sector_t, possibly making it an option...
+ * The type used for indexing onto a disc or disc partition.
+ * If required, asm/types.h can override it and define
+ * HAVE_SECTOR_T
  */
-#undef BLK_64BIT_SECTOR
-
-#ifdef BLK_64BIT_SECTOR
-typedef u64 sector_t;
-#else
+#ifndef HAVE_SECTOR_T
 typedef unsigned long sector_t;
 #endif
 
