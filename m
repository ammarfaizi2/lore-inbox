Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVLTQRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVLTQRi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 11:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVLTQRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 11:17:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:22154 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750781AbVLTQRh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 11:17:37 -0500
Subject: [RFC][PATCH] New iovec support & VFS changes
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>, hch@lst.de, akpm@osdl.org,
       davem@redhat.com, Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-bIKcRhVSOpZACkQ9AmEx"
Date: Tue, 20 Dec 2005 08:18:07 -0800
Message-Id: <1135095487.19193.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bIKcRhVSOpZACkQ9AmEx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I was trying to add support for preadv()/pwritev() for threaded
databases. Currently the patch is in -mm tree.

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-
rc5/2.6.15-rc5-mm3/broken-out/support-for-preadv-pwritev.patch

This needs a new set of system calls. Ulrich Drepper pointed out
that, instead of adding a system call for the limited functionality
it provides, why not we add new iovec interface as follows (offset-per-
segment) which provides greater functionality & flexibility.

+struct niovec
+{
+	void __user *iov_base;
+	__kernel_size_t iov_len;
+	__kernel_loff_t iov_off; /* NEW */
+};

In order to support this, we need to change all the file_operations
(readv/writev) and its helper functions to take this new structure.

I took a stab at doing it and I want feedback on whether this is
acceptable. All the patch does - is to make kernel use new structure,
but the existing syscalls like readv()/writev() still deals with
original one to keep the compatibility. (pipes and sockets need 
changing too - which I have not addressed yet).

Is this the right approach ?

Please DO NOT apply (I haven't tested it at all).

Thanks,
Badari



--=-bIKcRhVSOpZACkQ9AmEx
Content-Disposition: attachment; filename=niovec.patch
Content-Type: text/x-patch; name=niovec.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Narup -X dontdiff linux-2.6.15-rc5/fs/direct-io.c linux-2.6.15-rc5.vec/fs/direct-io.c
--- linux-2.6.15-rc5/fs/direct-io.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5.vec/fs/direct-io.c	2005-12-19 13:23:18.000000000 -0800
@@ -934,7 +934,7 @@ out:
  */
 static ssize_t
 direct_io_worker(int rw, struct kiocb *iocb, struct inode *inode, 
-	const struct iovec *iov, loff_t offset, unsigned long nr_segs, 
+	const struct niovec *iov, loff_t offset, unsigned long nr_segs, 
 	unsigned blkbits, get_blocks_t get_blocks, dio_iodone_t end_io,
 	struct dio *dio)
 {
@@ -1162,7 +1162,7 @@ direct_io_worker(int rw, struct kiocb *i
  */
 ssize_t
 __blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode,
-	struct block_device *bdev, const struct iovec *iov, loff_t offset, 
+	struct block_device *bdev, const struct niovec *iov, loff_t offset, 
 	unsigned long nr_segs, get_blocks_t get_blocks, dio_iodone_t end_io,
 	int dio_lock_type)
 {
diff -Narup -X dontdiff linux-2.6.15-rc5/fs/read_write.c linux-2.6.15-rc5.vec/fs/read_write.c
--- linux-2.6.15-rc5/fs/read_write.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5.vec/fs/read_write.c	2005-12-19 12:53:42.000000000 -0800
@@ -405,7 +405,7 @@ asmlinkage ssize_t sys_pwrite64(unsigned
 /*
  * Reduce an iovec's length in-place.  Return the resulting number of segments
  */
-unsigned long iov_shorten(struct iovec *iov, unsigned long nr_segs, size_t to)
+unsigned long iov_shorten(struct niovec *iov, unsigned long nr_segs, size_t to)
 {
 	unsigned long seg = 0;
 	size_t len = 0;
@@ -424,6 +424,20 @@ unsigned long iov_shorten(struct iovec *
 
 EXPORT_SYMBOL(iov_shorten);
 
+static int copy_from_user_iovec(struct niovec *iov, 
+			       const struct iovec __user * uvector,
+			       unsigned long nr_segs)
+{
+	while (nr_segs--) {
+		if (copy_from_user(iov, uvector, sizeof(struct iovec)))
+			return -EFAULT;
+
+		iov++;
+		uvector++;
+	}
+	return 0;
+}
+
 /* A write operation does a read from user space and vice versa */
 #define vrfy_dir(type) ((type) == READ ? VERIFY_WRITE : VERIFY_READ)
 
@@ -432,15 +446,16 @@ static ssize_t do_readv_writev(int type,
 			       unsigned long nr_segs, loff_t *pos)
 {
 	typedef ssize_t (*io_fn_t)(struct file *, char __user *, size_t, loff_t *);
-	typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
+	typedef ssize_t (*iov_fn_t)(struct file *, const struct niovec *, unsigned long, loff_t *);
 
 	size_t tot_len;
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov=iovstack, *vector;
+	struct niovec iovstack[UIO_FASTIOV];
+	struct niovec *iov=iovstack, *vector;
 	ssize_t ret;
 	int seg;
 	io_fn_t fn;
 	iov_fn_t fnv;
+	loff_t opos;
 
 	/*
 	 * SuS says "The readv() function *may* fail if the iovcnt argument
@@ -462,12 +477,12 @@ static ssize_t do_readv_writev(int type,
 		goto out;
 	if (nr_segs > UIO_FASTIOV) {
 		ret = -ENOMEM;
-		iov = kmalloc(nr_segs*sizeof(struct iovec), GFP_KERNEL);
+		iov = kmalloc(nr_segs*sizeof(struct niovec), GFP_KERNEL);
 		if (!iov)
 			goto out;
 	}
-	ret = -EFAULT;
-	if (copy_from_user(iov, uvector, nr_segs*sizeof(*uvector)))
+	ret = copy_from_user_iovec(iov, uvector, nr_segs);
+	if (ret)
 		goto out;
 
 	/*
@@ -478,6 +493,7 @@ static ssize_t do_readv_writev(int type,
 	 * Be careful here because iov_len is a size_t not an ssize_t
 	 */
 	tot_len = 0;
+	opos = *pos;
 	ret = -EINVAL;
 	for (seg = 0; seg < nr_segs; seg++) {
 		void __user *buf = iov[seg].iov_base;
@@ -487,7 +503,9 @@ static ssize_t do_readv_writev(int type,
 			goto out;
 		if (unlikely(!access_ok(vrfy_dir(type), buf, len)))
 			goto Efault;
+		iov[seg].iov_off = opos;
 		tot_len += len;
+		opos += len;
 		if ((ssize_t)tot_len < 0) /* maths overflow on the ssize_t */
 			goto out;
 	}
diff -Narup -X dontdiff linux-2.6.15-rc5/include/linux/fs.h linux-2.6.15-rc5.vec/include/linux/fs.h
--- linux-2.6.15-rc5/include/linux/fs.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5.vec/include/linux/fs.h	2005-12-19 12:03:25.000000000 -0800
@@ -226,6 +226,7 @@ extern int dir_notify_enable;
 #include <asm/byteorder.h>
 
 struct iovec;
+struct niovec;
 struct nameidata;
 struct kiocb;
 struct pipe_inode_info;
@@ -333,7 +334,7 @@ struct address_space_operations {
 	sector_t (*bmap)(struct address_space *, sector_t);
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, gfp_t);
-	ssize_t (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
+	ssize_t (*direct_IO)(int, struct kiocb *, const struct niovec *iov,
 			loff_t offset, unsigned long nr_segs);
 	struct page* (*get_xip_page)(struct address_space *, sector_t,
 			int);
@@ -987,8 +988,8 @@ struct file_operations {
 	int (*aio_fsync) (struct kiocb *, int datasync);
 	int (*fasync) (int, struct file *, int);
 	int (*lock) (struct file *, int, struct file_lock *);
-	ssize_t (*readv) (struct file *, const struct iovec *, unsigned long, loff_t *);
-	ssize_t (*writev) (struct file *, const struct iovec *, unsigned long, loff_t *);
+	ssize_t (*readv) (struct file *, const struct niovec *, unsigned long, loff_t *);
+	ssize_t (*writev) (struct file *, const struct niovec *, unsigned long, loff_t *);
 	ssize_t (*sendfile) (struct file *, loff_t *, size_t, read_actor_t, void *);
 	ssize_t (*sendpage) (struct file *, struct page *, int, size_t, loff_t *, int);
 	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
@@ -1522,17 +1523,17 @@ extern ssize_t generic_file_read(struct 
 int generic_write_checks(struct file *file, loff_t *pos, size_t *count, int isblk);
 extern ssize_t generic_file_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t generic_file_aio_read(struct kiocb *, char __user *, size_t, loff_t);
-extern ssize_t __generic_file_aio_read(struct kiocb *, const struct iovec *, unsigned long, loff_t *);
+extern ssize_t __generic_file_aio_read(struct kiocb *, const struct niovec *, unsigned long, loff_t *);
 extern ssize_t generic_file_aio_write(struct kiocb *, const char __user *, size_t, loff_t);
-extern ssize_t generic_file_aio_write_nolock(struct kiocb *, const struct iovec *,
+extern ssize_t generic_file_aio_write_nolock(struct kiocb *, const struct niovec *,
 		unsigned long, loff_t *);
-extern ssize_t generic_file_direct_write(struct kiocb *, const struct iovec *,
+extern ssize_t generic_file_direct_write(struct kiocb *, const struct niovec *,
 		unsigned long *, loff_t, loff_t *, size_t, size_t);
-extern ssize_t generic_file_buffered_write(struct kiocb *, const struct iovec *,
+extern ssize_t generic_file_buffered_write(struct kiocb *, const struct niovec *,
 		unsigned long, loff_t, loff_t *, size_t, ssize_t);
 extern ssize_t do_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos);
 extern ssize_t do_sync_write(struct file *filp, const char __user *buf, size_t len, loff_t *ppos);
-ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
+ssize_t generic_file_write_nolock(struct file *file, const struct niovec *iov,
 				unsigned long nr_segs, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
 extern void do_generic_mapping_read(struct address_space *mapping,
@@ -1540,9 +1541,9 @@ extern void do_generic_mapping_read(stru
 				    loff_t *, read_descriptor_t *, read_actor_t);
 extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
-extern ssize_t generic_file_readv(struct file *filp, const struct iovec *iov, 
+extern ssize_t generic_file_readv(struct file *filp, const struct niovec *iov, 
 	unsigned long nr_segs, loff_t *ppos);
-ssize_t generic_file_writev(struct file *filp, const struct iovec *iov, 
+ssize_t generic_file_writev(struct file *filp, const struct niovec *iov, 
 			unsigned long nr_segs, loff_t *ppos);
 extern loff_t no_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int origin);
@@ -1580,7 +1581,7 @@ static inline void do_generic_file_read(
 }
 
 ssize_t __blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode,
-	struct block_device *bdev, const struct iovec *iov, loff_t offset,
+	struct block_device *bdev, const struct niovec *iov, loff_t offset,
 	unsigned long nr_segs, get_blocks_t get_blocks, dio_iodone_t end_io,
 	int lock_type);
 
@@ -1591,7 +1592,7 @@ enum {
 };
 
 static inline ssize_t blockdev_direct_IO(int rw, struct kiocb *iocb,
-	struct inode *inode, struct block_device *bdev, const struct iovec *iov,
+	struct inode *inode, struct block_device *bdev, const struct niovec *iov,
 	loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks,
 	dio_iodone_t end_io)
 {
@@ -1600,7 +1601,7 @@ static inline ssize_t blockdev_direct_IO
 }
 
 static inline ssize_t blockdev_direct_IO_no_locking(int rw, struct kiocb *iocb,
-	struct inode *inode, struct block_device *bdev, const struct iovec *iov,
+	struct inode *inode, struct block_device *bdev, const struct niovec *iov,
 	loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks,
 	dio_iodone_t end_io)
 {
@@ -1609,7 +1610,7 @@ static inline ssize_t blockdev_direct_IO
 }
 
 static inline ssize_t blockdev_direct_IO_own_locking(int rw, struct kiocb *iocb,
-	struct inode *inode, struct block_device *bdev, const struct iovec *iov,
+	struct inode *inode, struct block_device *bdev, const struct niovec *iov,
 	loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks,
 	dio_iodone_t end_io)
 {
diff -Narup -X dontdiff linux-2.6.15-rc5/include/linux/uio.h linux-2.6.15-rc5.vec/include/linux/uio.h
--- linux-2.6.15-rc5/include/linux/uio.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5.vec/include/linux/uio.h	2005-12-19 12:51:19.000000000 -0800
@@ -23,6 +23,14 @@ struct iovec
 	__kernel_size_t iov_len; /* Must be size_t (1003.1g) */
 };
 
+
+struct niovec
+{
+	void __user *iov_base;	
+	__kernel_size_t iov_len; 
+	__kernel_loff_t iov_off;
+};
+
 #ifdef __KERNEL__
 
 struct kvec {
@@ -51,7 +59,7 @@ struct kvec {
  * segment lengths have been validated.  Because the individual lengths can
  * overflow a size_t when added together.
  */
-static inline size_t iov_length(const struct iovec *iov, unsigned long nr_segs)
+static inline size_t iov_length(const struct niovec *iov, unsigned long nr_segs)
 {
 	unsigned long seg;
 	size_t ret = 0;
@@ -61,6 +69,6 @@ static inline size_t iov_length(const st
 	return ret;
 }
 
-unsigned long iov_shorten(struct iovec *iov, unsigned long nr_segs, size_t to);
+unsigned long iov_shorten(struct niovec *iov, unsigned long nr_segs, size_t to);
 
 #endif
diff -Narup -X dontdiff linux-2.6.15-rc5/mm/filemap.c linux-2.6.15-rc5.vec/mm/filemap.c
--- linux-2.6.15-rc5/mm/filemap.c	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5.vec/mm/filemap.c	2005-12-19 12:50:53.000000000 -0800
@@ -38,7 +38,7 @@
 #include <asm/mman.h>
 
 static ssize_t
-generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
+generic_file_direct_IO(int rw, struct kiocb *iocb, const struct niovec *iov,
 	loff_t offset, unsigned long nr_segs);
 
 /*
@@ -965,7 +965,7 @@ success:
  * that can use the page cache directly.
  */
 ssize_t
-__generic_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
+__generic_file_aio_read(struct kiocb *iocb, const struct niovec *iov,
 		unsigned long nr_segs, loff_t *ppos)
 {
 	struct file *filp = iocb->ki_filp;
@@ -975,7 +975,7 @@ __generic_file_aio_read(struct kiocb *io
 
 	count = 0;
 	for (seg = 0; seg < nr_segs; seg++) {
-		const struct iovec *iv = &iov[seg];
+		const struct niovec *iv = &iov[seg];
 
 		/*
 		 * If any segment has a negative length, or the cumulative
@@ -1045,7 +1045,7 @@ EXPORT_SYMBOL(__generic_file_aio_read);
 ssize_t
 generic_file_aio_read(struct kiocb *iocb, char __user *buf, size_t count, loff_t pos)
 {
-	struct iovec local_iov = { .iov_base = buf, .iov_len = count };
+	struct niovec local_iov = { .iov_base = buf, .iov_len = count };
 
 	BUG_ON(iocb->ki_pos != pos);
 	return __generic_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
@@ -1056,7 +1056,7 @@ EXPORT_SYMBOL(generic_file_aio_read);
 ssize_t
 generic_file_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
 {
-	struct iovec local_iov = { .iov_base = buf, .iov_len = count };
+	struct niovec local_iov = { .iov_base = buf, .iov_len = count };
 	struct kiocb kiocb;
 	ssize_t ret;
 
@@ -1727,7 +1727,7 @@ EXPORT_SYMBOL(remove_suid);
 
 size_t
 __filemap_copy_from_user_iovec(char *vaddr, 
-			const struct iovec *iov, size_t base, size_t bytes)
+			const struct niovec *iov, size_t base, size_t bytes)
 {
 	size_t copied = 0, left = 0;
 
@@ -1833,7 +1833,7 @@ inline int generic_write_checks(struct f
 EXPORT_SYMBOL(generic_write_checks);
 
 ssize_t
-generic_file_direct_write(struct kiocb *iocb, const struct iovec *iov,
+generic_file_direct_write(struct kiocb *iocb, const struct niovec *iov,
 		unsigned long *nr_segs, loff_t pos, loff_t *ppos,
 		size_t count, size_t ocount)
 {
@@ -1843,7 +1843,7 @@ generic_file_direct_write(struct kiocb *
 	ssize_t		written;
 
 	if (count != ocount)
-		*nr_segs = iov_shorten((struct iovec *)iov, *nr_segs, count);
+		*nr_segs = iov_shorten((struct niovec *)iov, *nr_segs, count);
 
 	written = generic_file_direct_IO(WRITE, iocb, iov, pos, *nr_segs);
 	if (written > 0) {
@@ -1873,7 +1873,7 @@ generic_file_direct_write(struct kiocb *
 EXPORT_SYMBOL(generic_file_direct_write);
 
 ssize_t
-generic_file_buffered_write(struct kiocb *iocb, const struct iovec *iov,
+generic_file_buffered_write(struct kiocb *iocb, const struct niovec *iov,
 		unsigned long nr_segs, loff_t pos, loff_t *ppos,
 		size_t count, ssize_t written)
 {
@@ -1886,7 +1886,7 @@ generic_file_buffered_write(struct kiocb
 	struct page	*cached_page = NULL;
 	size_t		bytes;
 	struct pagevec	lru_pvec;
-	const struct iovec *cur_iov = iov; /* current iovec */
+	const struct niovec *cur_iov = iov; /* current iovec */
 	size_t		iov_base = 0;	   /* offset in the current iovec */
 	char __user	*buf;
 
@@ -2013,7 +2013,7 @@ generic_file_buffered_write(struct kiocb
 EXPORT_SYMBOL(generic_file_buffered_write);
 
 static ssize_t
-__generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
+__generic_file_aio_write_nolock(struct kiocb *iocb, const struct niovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
 {
 	struct file *file = iocb->ki_filp;
@@ -2028,7 +2028,7 @@ __generic_file_aio_write_nolock(struct k
 
 	ocount = 0;
 	for (seg = 0; seg < nr_segs; seg++) {
-		const struct iovec *iv = &iov[seg];
+		const struct niovec *iv = &iov[seg];
 
 		/*
 		 * If any segment has a negative length, or the cumulative
@@ -2091,7 +2091,7 @@ out:
 EXPORT_SYMBOL(generic_file_aio_write_nolock);
 
 ssize_t
-generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
+generic_file_aio_write_nolock(struct kiocb *iocb, const struct niovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
 {
 	struct file *file = iocb->ki_filp;
@@ -2113,7 +2113,7 @@ generic_file_aio_write_nolock(struct kio
 }
 
 static ssize_t
-__generic_file_write_nolock(struct file *file, const struct iovec *iov,
+__generic_file_write_nolock(struct file *file, const struct niovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
 {
 	struct kiocb kiocb;
@@ -2127,7 +2127,7 @@ __generic_file_write_nolock(struct file 
 }
 
 ssize_t
-generic_file_write_nolock(struct file *file, const struct iovec *iov,
+generic_file_write_nolock(struct file *file, const struct niovec *iov,
 				unsigned long nr_segs, loff_t *ppos)
 {
 	struct kiocb kiocb;
@@ -2148,7 +2148,7 @@ ssize_t generic_file_aio_write(struct ki
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	ssize_t ret;
-	struct iovec local_iov = { .iov_base = (void __user *)buf,
+	struct niovec local_iov = { .iov_base = (void __user *)buf,
 					.iov_len = count };
 
 	BUG_ON(iocb->ki_pos != pos);
@@ -2175,7 +2175,7 @@ ssize_t generic_file_write(struct file *
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
 	ssize_t	ret;
-	struct iovec local_iov = { .iov_base = (void __user *)buf,
+	struct niovec local_iov = { .iov_base = (void __user *)buf,
 					.iov_len = count };
 
 	down(&inode->i_sem);
@@ -2193,7 +2193,7 @@ ssize_t generic_file_write(struct file *
 }
 EXPORT_SYMBOL(generic_file_write);
 
-ssize_t generic_file_readv(struct file *filp, const struct iovec *iov,
+ssize_t generic_file_readv(struct file *filp, const struct niovec *iov,
 			unsigned long nr_segs, loff_t *ppos)
 {
 	struct kiocb kiocb;
@@ -2207,7 +2207,7 @@ ssize_t generic_file_readv(struct file *
 }
 EXPORT_SYMBOL(generic_file_readv);
 
-ssize_t generic_file_writev(struct file *file, const struct iovec *iov,
+ssize_t generic_file_writev(struct file *file, const struct niovec *iov,
 			unsigned long nr_segs, loff_t *ppos)
 {
 	struct address_space *mapping = file->f_mapping;
@@ -2234,7 +2234,7 @@ EXPORT_SYMBOL(generic_file_writev);
  * went wrong during pagecache shootdown.
  */
 static ssize_t
-generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
+generic_file_direct_IO(int rw, struct kiocb *iocb, const struct niovec *iov,
 	loff_t offset, unsigned long nr_segs)
 {
 	struct file *file = iocb->ki_filp;
diff -Narup -X dontdiff linux-2.6.15-rc5/mm/filemap.h linux-2.6.15-rc5.vec/mm/filemap.h
--- linux-2.6.15-rc5/mm/filemap.h	2005-12-03 21:10:42.000000000 -0800
+++ linux-2.6.15-rc5.vec/mm/filemap.h	2005-12-19 13:22:40.000000000 -0800
@@ -17,7 +17,7 @@
 
 size_t
 __filemap_copy_from_user_iovec(char *vaddr,
-			       const struct iovec *iov,
+			       const struct niovec *iov,
 			       size_t base,
 			       size_t bytes);
 
@@ -54,7 +54,7 @@ filemap_copy_from_user(struct page *page
  */
 static inline size_t
 filemap_copy_from_user_iovec(struct page *page, unsigned long offset,
-			const struct iovec *iov, size_t base, size_t bytes)
+			const struct niovec *iov, size_t base, size_t bytes)
 {
 	char *kaddr;
 	size_t copied;
@@ -73,9 +73,9 @@ filemap_copy_from_user_iovec(struct page
 }
 
 static inline void
-filemap_set_next_iovec(const struct iovec **iovp, size_t *basep, size_t bytes)
+filemap_set_next_iovec(const struct niovec **iovp, size_t *basep, size_t bytes)
 {
-	const struct iovec *iov = *iovp;
+	const struct niovec *iov = *iovp;
 	size_t base = *basep;
 
 	while (bytes) {

--=-bIKcRhVSOpZACkQ9AmEx--

