Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTFXURU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 16:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTFXURU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 16:17:20 -0400
Received: from hera.cwi.nl ([192.16.191.8]:20368 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262427AbTFXURM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 16:17:12 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 24 Jun 2003 22:31:19 +0200 (MEST)
Message-Id: <UTC200306242031.h5OKVJL12231.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] loop.c - part 2 of N
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below a patch for loop.[ch], the 2nd in this series. It can be applied.

This does the following:

(i) IV value is current 512-byte sector relative to start of loop
container file. This is what all cryptoloop people have done, if I
am not mistaken. Andi or others - if you can demonstrate the need
for a more flexible setup an additional ioctl field may be needed.
I hope we can do without.

(ii) made some things static
(iii) made lo_offset a loff_t

(iv) added lo_sizelimit
If one wanted a (crypto)loop somewhere inside a container file,
the old code allowed a starting offset, but no size, so that
the cryptoloop always extended to the end of the container file.
This field allows one to select an arbitrary interval.
Note that this changes struct loop_info64.

(v) improve error handling of loop_init()
(vi) removed the unused typedef transfer_proc_t.
(vii) added a define for LO_CRYPT_CRYPTOAPI

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Tue Jun 24 12:03:06 2003
+++ b/drivers/block/loop.c	Tue Jun 24 20:10:43 2003
@@ -43,15 +43,6 @@
  * - Advisory locking is ignored here.
  * - Should use an own CAP_* category instead of CAP_SYS_ADMIN
  *
- * WARNING/FIXME:
- * - The block number as IV passing to low level transfer functions is broken:
- *   it passes the underlying device's block number instead of the
- *   offset. This makes it change for a given block when the file is
- *   moved/restored/copied and also doesn't work over NFS.
- * AV, Feb 12, 2000: we pass the logical block number now. It fixes the
- *   problem above. Encryption modules that used to rely on the old scheme
- *   should just call ->i_mapping->bmap() to calculate the physical block
- *   number.
  */
 
 #include <linux/config.h>
@@ -118,26 +109,26 @@
 	return 0;
 }
 
-static int xor_status(struct loop_device *lo, const struct loop_info64 *info)
+static int xor_init(struct loop_device *lo, const struct loop_info64 *info)
 {
 	if (info->lo_encrypt_key_size <= 0)
 		return -EINVAL;
 	return 0;
 }
 
-struct loop_func_table none_funcs = {
+static struct loop_func_table none_funcs = {
 	.number = LO_CRYPT_NONE,
 	.transfer = transfer_none,
 }; 	
 
-struct loop_func_table xor_funcs = {
+static struct loop_func_table xor_funcs = {
 	.number = LO_CRYPT_XOR,
 	.transfer = transfer_xor,
-	.init = xor_status
+	.init = xor_init
 }; 	
 
 /* xfer_funcs[0] is special - its release function is never called */
-struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
+static struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
 	&none_funcs,
 	&xor_funcs
 };
@@ -145,13 +136,21 @@
 static int
 figure_loop_size(struct loop_device *lo)
 {
-	loff_t size = lo->lo_backing_file->f_dentry->d_inode->i_mapping->host->i_size;
+	loff_t size, offset, loopsize;
 	sector_t x;
+
+	/* Compute loopsize in bytes */
+	size = lo->lo_backing_file->f_dentry->d_inode->i_mapping->host->i_size;
+	offset = lo->lo_offset;
+	loopsize = size - offset;
+	if (lo->lo_sizelimit > 0 && lo->lo_sizelimit < loopsize)
+		loopsize = lo->lo_sizelimit;
+
 	/*
 	 * Unfortunately, if we want to do I/O on the device,
 	 * the number of 512-byte sectors has to fit into a sector_t.
 	 */
-	size = (size - lo->lo_offset) >> 9;
+	size = loopsize >> 9;
 	x = (sector_t)size;
 
 	if ((loff_t)x != size)
@@ -190,9 +189,11 @@
 	data = kmap(bvec->bv_page) + bvec->bv_offset;
 	len = bvec->bv_len;
 	while (len > 0) {
-		sector_t IV = index * (PAGE_CACHE_SIZE/bsize) + offset/bsize;
+		sector_t IV;
 		int transfer_result;
 
+		IV = ((sector_t)index << (PAGE_CACHE_SHIFT - 9))+(offset >> 9);
+
 		size = PAGE_CACHE_SIZE - offset;
 		if (size > len)
 			size = len;
@@ -203,7 +204,8 @@
 		if (aops->prepare_write(file, page, offset, offset+size))
 			goto unlock;
 		kaddr = kmap(page);
-		transfer_result = lo_do_transfer(lo, WRITE, kaddr + offset, data, size, IV);
+		transfer_result = lo_do_transfer(lo, WRITE, kaddr + offset,
+						 data, size, IV);
 		if (transfer_result) {
 			/*
 			 * The transfer failed, but we still write the data to
@@ -272,7 +274,9 @@
 	unsigned long count = desc->count;
 	struct lo_read_data *p = (struct lo_read_data*)desc->buf;
 	struct loop_device *lo = p->lo;
-	int IV = page->index * (PAGE_CACHE_SIZE/p->bsize) + offset/p->bsize;
+	sector_t IV;
+
+	IV = ((sector_t) page->index << (PAGE_CACHE_SHIFT - 9))+(offset >> 9);
 
 	if (size > count)
 		size = count;
@@ -327,20 +331,6 @@
 	return ret;
 }
 
-static inline unsigned long
-loop_get_iv(struct loop_device *lo, unsigned long sector)
-{
-	int bs = lo->lo_blocksize;
-	unsigned long offset, IV;
-
-	IV = sector / (bs >> 9) + lo->lo_offset / bs;
-	offset = ((sector % (bs >> 9)) << 9) + lo->lo_offset % bs;
-	if (offset >= bs)
-		IV++;
-
-	return IV;
-}
-
 static int do_bio_filebacked(struct loop_device *lo, struct bio *bio)
 {
 	loff_t pos;
@@ -504,11 +494,13 @@
 static int loop_transfer_bio(struct loop_device *lo,
 			     struct bio *to_bio, struct bio *from_bio)
 {
-	unsigned long IV = loop_get_iv(lo, from_bio->bi_sector);
+	sector_t IV;
 	struct bio_vec *from_bvec, *to_bvec;
 	char *vto, *vfrom;
 	int ret = 0, i;
 
+	IV = from_bio->bi_sector + (lo->lo_offset >> 9);
+
 	__bio_for_each_segment(from_bvec, from_bio, i, 0) {
 		to_bvec = &to_bio->bi_io_vec[i];
 
@@ -728,6 +720,7 @@
 	lo->lo_backing_file = file;
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
+	lo->lo_sizelimit = 0;
 	if (figure_loop_size(lo)) {
 		error = -EFBIG;
 		fput(file);
@@ -842,6 +835,7 @@
 	lo->lo_device = NULL;
 	lo->lo_encryption = NULL;
 	lo->lo_offset = 0;
+	lo->lo_sizelimit = 0;
 	lo->lo_encrypt_key_size = 0;
 	lo->lo_flags = 0;
 	lo->lo_queue.queuedata = NULL;
@@ -890,8 +884,10 @@
 	if (err)
 		return err;
 
-	if (lo->lo_offset != info->lo_offset) {
+	if (lo->lo_offset != info->lo_offset ||
+	    lo->lo_sizelimit != info->lo_sizelimit) {
 		lo->lo_offset = info->lo_offset;
+		lo->lo_sizelimit = info->lo_sizelimit;
 		if (figure_loop_size(lo))
 			return -EFBIG;
 	}
@@ -933,6 +929,7 @@
 	info->lo_inode = stat.ino;
 	info->lo_rdevice = lo->lo_device ? stat.rdev : stat.dev;
 	info->lo_offset = lo->lo_offset;
+	info->lo_sizelimit = lo->lo_sizelimit;
 	info->lo_flags = lo->lo_flags;
 	strlcpy(info->lo_name, lo->lo_name, LO_NAME_SIZE);
 	info->lo_encrypt_type =
@@ -948,11 +945,13 @@
 static void
 loop_info64_from_old(const struct loop_info *info, struct loop_info64 *info64)
 {
+	memset(info64, 0, sizeof(*info64));
 	info64->lo_number = info->lo_number;
 	info64->lo_device = info->lo_device;
 	info64->lo_inode = info->lo_inode;
 	info64->lo_rdevice = info->lo_rdevice;
 	info64->lo_offset = info->lo_offset;
+	info64->lo_sizelimit = 0;
 	info64->lo_encrypt_type = info->lo_encrypt_type;
 	info64->lo_encrypt_key_size = info->lo_encrypt_key_size;
 	info64->lo_flags = info->lo_flags;
@@ -965,6 +964,7 @@
 static int
 loop_info64_to_old(const struct loop_info64 *info64, struct loop_info *info)
 {
+	memset(info, 0, sizeof(*info));
 	info->lo_number = info64->lo_number;
 	info->lo_device = info64->lo_device;
 	info->lo_inode = info64->lo_inode;
@@ -1152,7 +1152,7 @@
 {
 	int	i;
 
-	if ((max_loop < 1) || (max_loop > 256)) {
+	if (max_loop < 1 || max_loop > 256) {
 		printk(KERN_WARNING "loop: invalid max_loop (must be between"
 				    " 1 and 256), using default (8)\n");
 		max_loop = 8;
@@ -1161,22 +1161,22 @@
 	if (register_blkdev(LOOP_MAJOR, "loop"))
 		return -EIO;
 
-	devfs_mk_dir("loop");
-
 	loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
 	if (!loop_dev)
-		return -ENOMEM;
+		goto out_mem1;
 
 	disks = kmalloc(max_loop * sizeof(struct gendisk *), GFP_KERNEL);
 	if (!disks)
-		goto out_mem;
+		goto out_mem2;
 
 	for (i = 0; i < max_loop; i++) {
 		disks[i] = alloc_disk(1);
 		if (!disks[i])
-			goto out_mem2;
+			goto out_mem3;
 	}
 
+	devfs_mk_dir("loop");
+
 	for (i = 0; i < max_loop; i++) {
 		struct loop_device *lo = &loop_dev[i];
 		struct gendisk *disk = disks[i];
@@ -1198,12 +1198,14 @@
 	printk(KERN_INFO "loop: loaded (max %d devices)\n", max_loop);
 	return 0;
 
-out_mem2:
+out_mem3:
 	while (i--)
 		put_disk(disks[i]);
 	kfree(disks);
-out_mem:
+out_mem2:
 	kfree(loop_dev);
+out_mem1:
+	unregister_blkdev(LOOP_MAJOR, "loop");
 	printk(KERN_ERR "loop: ran out of memory\n");
 	return -ENOMEM;
 }
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/loop.h b/include/linux/loop.h
--- a/include/linux/loop.h	Tue Jun 24 12:03:06 2003
+++ b/include/linux/loop.h	Tue Jun 24 19:15:44 2003
@@ -30,7 +30,8 @@
 struct loop_device {
 	int		lo_number;
 	int		lo_refcnt;
-	int		lo_offset;
+	loff_t		lo_offset;
+	loff_t		lo_sizelimit;
 	int		lo_flags;
 	int		(*transfer)(struct loop_device *, int cmd,
 				    char *raw_buf, char *loop_buf, int size,
@@ -64,10 +65,6 @@
 	request_queue_t		lo_queue;
 };
 
-typedef	int (* transfer_proc_t)(struct loop_device *, int cmd,
-				char *raw_buf, char *loop_buf, int size,
-				int real_block);
-
 #endif /* __KERNEL__ */
 
 /*
@@ -96,13 +93,14 @@
 };
 
 struct loop_info64 {
-	__u64		   lo_device; 		/* ioctl r/o */
-	__u64		   lo_inode; 		/* ioctl r/o */
-	__u64		   lo_rdevice; 		/* ioctl r/o */
+	__u64		   lo_device;			/* ioctl r/o */
+	__u64		   lo_inode;			/* ioctl r/o */
+	__u64		   lo_rdevice;			/* ioctl r/o */
 	__u64		   lo_offset;
-	__u32		   lo_number;		/* ioctl r/o */
+	__u64		   lo_sizelimit;/* bytes, 0 == max available */
+	__u32		   lo_number;			/* ioctl r/o */
 	__u32		   lo_encrypt_type;
-	__u32		   lo_encrypt_key_size; 	/* ioctl w/o */
+	__u32		   lo_encrypt_key_size;		/* ioctl w/o */
 	__u32		   lo_flags;			/* ioctl r/o */
 	__u8		   lo_name[LO_NAME_SIZE];
 	__u8		   lo_encrypt_key[LO_KEY_SIZE]; /* ioctl w/o */
@@ -113,21 +111,22 @@
  * Loop filter types
  */
 
-#define LO_CRYPT_NONE	  0
-#define LO_CRYPT_XOR	  1
-#define LO_CRYPT_DES	  2
-#define LO_CRYPT_FISH2    3    /* Brand new Twofish encryption */
-#define LO_CRYPT_BLOW     4
-#define LO_CRYPT_CAST128  5
-#define LO_CRYPT_IDEA     6
-#define LO_CRYPT_DUMMY    9
-#define LO_CRYPT_SKIPJACK 10
-#define MAX_LO_CRYPT	20
+#define LO_CRYPT_NONE		0
+#define LO_CRYPT_XOR		1
+#define LO_CRYPT_DES		2
+#define LO_CRYPT_FISH2		3    /* Twofish encryption */
+#define LO_CRYPT_BLOW		4
+#define LO_CRYPT_CAST128	5
+#define LO_CRYPT_IDEA		6
+#define LO_CRYPT_DUMMY		9
+#define LO_CRYPT_SKIPJACK	10
+#define LO_CRYPT_CRYPTOAPI	18
+#define MAX_LO_CRYPT		20
 
 #ifdef __KERNEL__
 /* Support for loadable transfer modules */
 struct loop_func_table {
-	int number; 	/* filter type */ 
+	int number;	/* filter type */ 
 	int (*transfer)(struct loop_device *lo, int cmd, char *raw_buf,
 			char *loop_buf, int size, sector_t real_block);
 	int (*init)(struct loop_device *, const struct loop_info64 *); 
