Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318237AbSHWFss>; Fri, 23 Aug 2002 01:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318252AbSHWFss>; Fri, 23 Aug 2002 01:48:48 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:7678 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S318237AbSHWFsm>; Fri, 23 Aug 2002 01:48:42 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15717.52654.129024.480975@wombat.chubb.wattle.id.au>
Date: Fri, 23 Aug 2002 15:52:46 +1000
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Large Block device patch part 4 of 9
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 this part fixes the loop, network block and ram devices to allow
large block numbers.

The only iffy part is that the interface to the transform functions
changes depending on the kernel config (sector_t could be 32 or 64
bits).

Not sure -- it may be better always to use a 64-bit type --- what do
you think?

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.511   -> 1.512  
#	 drivers/block/nbd.c	1.33    -> 1.34   
#	include/linux/loop.h	1.8     -> 1.9    
#	drivers/block/loop.c	1.56    -> 1.57   
#	  drivers/block/rd.c	1.45    -> 1.46   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/23	peterc@numbat.chubb.wattle.id.au	1.512
# Fix loop, network block and ram device to allow larger block offsets.
# --------------------------------------------
#
diff -Nru a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Fri Aug 23 14:46:35 2002
+++ b/drivers/block/loop.c	Fri Aug 23 14:46:35 2002
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
 
@@ -1052,7 +1074,7 @@
 	if (!loop_dev)
 		return -ENOMEM;
 
-	loop_sizes = kmalloc(max_loop * sizeof(int), GFP_KERNEL);
+	loop_sizes = kmalloc(max_loop * sizeof(loop_sizes[0]), GFP_KERNEL);
 	if (!loop_sizes)
 		goto out_mem;
 
@@ -1061,7 +1083,7 @@
 
 	for (i = 0; i < max_loop; i++) {
 		struct loop_device *lo = &loop_dev[i];
-		memset(lo, 0, sizeof(struct loop_device));
+		memset(lo, 0, sizeof(*lo));
 		init_MUTEX(&lo->lo_ctl_mutex);
 		init_MUTEX_LOCKED(&lo->lo_sem);
 		init_MUTEX_LOCKED(&lo->lo_bh_mutex);
@@ -1069,7 +1091,7 @@
 		spin_lock_init(&lo->lo_lock);
 	}
 
-	memset(loop_sizes, 0, max_loop * sizeof(int));
+	memset(loop_sizes, 0, max_loop * sizeof(*loop_sizes));
 	blk_size[MAJOR_NR] = loop_sizes;
 	for (i = 0; i < max_loop; i++)
 		register_disk(NULL, mk_kdev(MAJOR_NR, i), 1, &lo_fops, 0);
diff -Nru a/drivers/block/nbd.c b/drivers/block/nbd.c
--- a/drivers/block/nbd.c	Fri Aug 23 14:46:35 2002
+++ b/drivers/block/nbd.c	Fri Aug 23 14:46:35 2002
@@ -59,7 +59,7 @@
 
 static int nbd_blksizes[MAX_NBD];
 static int nbd_blksize_bits[MAX_NBD];
-static int nbd_sizes[MAX_NBD];
+static sector_t nbd_sizes[MAX_NBD];
 static u64 nbd_bytesizes[MAX_NBD];
 
 static struct nbd_device nbd_dev[MAX_NBD];
diff -Nru a/drivers/block/rd.c b/drivers/block/rd.c
--- a/drivers/block/rd.c	Fri Aug 23 14:46:35 2002
+++ b/drivers/block/rd.c	Fri Aug 23 14:46:35 2002
@@ -77,7 +77,7 @@
  */
 
 static unsigned long rd_length[NUM_RAMDISKS];	/* Size of RAM disks in bytes   */
-static int rd_kbsize[NUM_RAMDISKS];	/* Size in blocks of 1024 bytes */
+static sector_t rd_kbsize[NUM_RAMDISKS];	/* Size in blocks of 1024 bytes */
 static devfs_handle_t devfs_handle;
 static struct block_device *rd_bdev[NUM_RAMDISKS];/* Protected device data */
 
diff -Nru a/include/linux/loop.h b/include/linux/loop.h
--- a/include/linux/loop.h	Fri Aug 23 14:46:35 2002
+++ b/include/linux/loop.h	Fri Aug 23 14:46:35 2002
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
