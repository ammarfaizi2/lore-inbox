Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318501AbSIKIKf>; Wed, 11 Sep 2002 04:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318516AbSIKIKf>; Wed, 11 Sep 2002 04:10:35 -0400
Received: from packet.digeo.com ([12.110.80.53]:2448 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318501AbSIKIKR>;
	Wed, 11 Sep 2002 04:10:17 -0400
Message-ID: <3D7EFF0F.89F7D585@digeo.com>
Date: Wed, 11 Sep 2002 01:30:07 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Janet Morgan <janetmor@us.ibm.com>
Subject: [patch] readv/writev rework
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2002 08:14:54.0777 (UTC) FILETIME=[4F5EA290:01C2596B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Ripping out a few things for final review here....)



This is Janet Morgan's patch which converts the readv/writev code
to submit all segments for IO before waiting on them, rather than
submitting each segment separately.

This is a critical performance fix for O_DIRECT reads and writes.
Prior to this change, O_DIRECT vectored IO was forced to wait for
completion against each segment of the iovec rather than submitting all
segments and waiting on the lot.  ie: for ten segments, this code will
be ten times faster.

There will also be moderate improvements for buffered IO - smaller code
paths, plus writev() only takes i_sem once.

The patch ended up quite large unfortunately - turned out that the only
sane way to implement this without duplicating significant amounts of
code (the generic_file_write() bounds checking, all the O_DIRECT
handling, etc) was to redo generic_file_read() and generic_file_write()
to take an iovec/nr_segs pair rather than `buf, count'.

New exported functions generic_file_readv() and generic_file_writev()
have been added:

ssize_t generic_file_readv(struct file *filp, const struct iovec *iov,
unsigned long nr_segs, loff_t *ppos);
ssize_t generic_file_writev(struct file *file, const struct iovec *iov,
unsigned long nr_segs, loff_t * ppos);

If a driver does not use these in their file_operations then they will
continue to use the old readv/writev code, which sits in a loop calling
calls fops->read() or fops->write().

ext2, ext3, JFS and the blockdev driver are currently using this
capability.

Some coding cleanups were made in fs/read_write.c.  Mainly:

- pass "READ" or "WRITE" around to indicate the diretion of the
  operation, rather than the (confusing, inverted)
  VERIFY_READ/VERIFY_WRITE.

- Use the identifier `nr_segs' everywhere to indicate the iovec
  length rather than `count', which is often used to indicate the
  number of bytes in the syscall.  It was confusing the heck out of me.

- Some cleanups to the raw driver.

- Some additional generality in fs/direct_io.c: the core `struct dio'
  used to be a "populate-and-go" thing.  Janet has broken that up so
  you can initialise a struct dio once, then loop around feeding it
  more file segments, then wait on completion against everything.

- In a couple of places we needed to handle the situation where we
  knew, a-priori, that the user was going to get a short read or write.
  File size limit exceeded, read past i_size, etc.  We handled that by
  shortening the iovec in-place with iov_shorten().  Which is not
  particularly pretty, but neither were the alternatives.


The performance benefits are much, much greater than I expected.  Here
is Janet's report:


I used a derivative of one of the LTP dio tests and the raw interface
to get the following data points:

IO type:         Vector io patch is:

Random writev        8.7 times faster
Sequential writev    6.6 times faster

Random readv         not faster, but sys time improves 5x
Sequential readv     not faster, but sys time improves 5x

Random mixed I/O     5 times faster
Sequential mixed I/O 6.6 times faster

Each raw readv or writev was for 32K (4k x 8).  I used a disk attached to
an aic controller.

Please let me know if you'd like a different set of data or whether I
should repeat using O_DIRECT.

I've attached below the time and vmstat output for each test.
P.S. Test times between say "Random writev" and "Random readv" should
not be compared because I may have varied the number of times through
the main testloop.

---------------------------------------------------------------------------

Random writev

before patch:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  1  0      0 3772016   6564  61128   0   0     0   669 1176   346   0   0 100

real    0m14.254s
user    0m0.000s
sys     0m0.048s

after patch:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  1  0      0 3771980   6568  61128   0   0     0  5920 1195   376   0   0 100

real    0m1.628s
user    0m0.001s
sys     0m0.009s

---------------------------------------------------------------------------

Sequential writev

before patch:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  1  0      0 3771912   6620  61132   0   0     0   652 1170   330   0   0 100

real    0m14.853s
user    0m0.000s
sys     0m0.060s

after patch:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  1  0      0 3771852   6636  61132   0   0     0  4352 1143   278   0   0 100

real    0m2.238s
user    0m0.001s
sys     0m0.011s

---------------------------------------------------------------------------

Random readv

before patch:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  1  0      0 3771712   6732  61136   0   0 20012     0 6011 10012   0   4  96

real    0m4.760s
user    0m0.002s
sys     0m0.651s

after patch:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  1  0      0 3769908   7924  61500   0   0 21440     0 1678  1346   0   3  97

real    0m4.510s
user    0m0.002s
sys     0m0.125s

---------------------------------------------------------------------------

Sequential readv

before patch:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  1  0      0 3769340   7276  62832   0   0 20052     0 6020 10030   0   4  96

real    0m4.797s
user    0m0.001s
sys     0m0.684s

after patch:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  1  0      0 3769320   7244  62832   0   0 21344     0 1674  1338   0   2  98

real    0m4.545s
user    0m0.000s
sys     0m0.119s

----------------------------------------------------------------------------

Random mixed I/O

before patch:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  1  0      0 3770012   7884  61500   0   0   592   592 1303   596   0   2  98

real    0m16.237s
user    0m0.000s
sys     0m0.111s

after patch:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  1  0      0 3770044   7840  61500   0   0  3104  3104 1201   392   0   0 100

real    0m3.193s
user    0m0.001s
sys     0m0.017s

----------------------------------------------------------------------------

Sequential mixed I/O

before patch:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  1  0      0 3769232   7344  62832   0   0   640   648 1329   648   0   0 100

real    0m14.863s
user    0m0.003s
sys     0m0.106s

after patch:

procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  1  0      0 3769192   7384  62832   0   0  4192  4197 1274   540   0   0 100

real    0m2.256s
user    0m0.002s
sys     0m0.023s




 drivers/char/raw.c  |   54 ++++++++++++++-------
 fs/block_dev.c      |   52 ++++++++++++--------
 fs/direct-io.c      |  132 ++++++++++++++++++++++++++++++----------------------
 fs/ext2/file.c      |    2 
 fs/ext2/inode.c     |    8 +--
 fs/ext3/file.c      |   22 ++++----
 fs/ext3/inode.c     |   10 ++-
 fs/jfs/file.c       |    2 
 fs/jfs/inode.c      |    8 +--
 fs/read_write.c     |  109 +++++++++++++++++++++++++++---------------
 include/linux/fs.h  |   19 ++++---
 include/linux/uio.h |   15 +++++
 kernel/ksyms.c      |    4 +
 mm/filemap.c        |  108 ++++++++++++++++++++++++++++++++++--------
 14 files changed, 363 insertions(+), 182 deletions(-)

--- 2.5.34/drivers/char/raw.c~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/drivers/char/raw.c	Tue Sep 10 18:57:53 2002
@@ -201,25 +201,29 @@ out:
 }
 
 static ssize_t
-rw_raw_dev(int rw, struct file *filp, char *buf, size_t size, loff_t *offp)
+rw_raw_dev(int rw, struct file *filp, const struct iovec *iov, unsigned long nr_segs, loff_t *offp)
 {
 	const int minor = minor(filp->f_dentry->d_inode->i_rdev);
 	struct block_device *bdev = raw_devices[minor].binding;
 	struct inode *inode = bdev->bd_inode;
+ 	size_t count = iov_length(iov, nr_segs); 
 	ssize_t ret = 0;
 
-	if (size == 0)
-		goto out;
-	ret = -EINVAL;
-	if (size < 0)
-		goto out;
-	ret = -ENXIO;
-	if (*offp >= inode->i_size)
-		goto out;
-
-	if (size + *offp > inode->i_size)
-		size = inode->i_size - *offp;
-	ret = generic_file_direct_IO(rw, inode, buf, *offp, size);
+	if (count == 0)
+		goto out;	
+
+	if ((ssize_t)count < 0)
+		return -EINVAL;	
+
+	if (*offp >= inode->i_size) 
+		return -ENXIO;
+
+	if (count + *offp > inode->i_size) {
+		count = inode->i_size - *offp;
+		nr_segs = iov_shorten((struct iovec *)iov, nr_segs, count);
+	}
+	ret = generic_file_direct_IO(rw, inode, iov, *offp, nr_segs);
+
 	if (ret > 0)
 		*offp += ret;
 out:
@@ -227,15 +231,31 @@ out:
 }
 
 static ssize_t
-raw_read(struct file *filp, char * buf, size_t size, loff_t *offp)
+raw_read(struct file *filp, char *buf, size_t size, loff_t *offp)
 {
-	return rw_raw_dev(READ, filp, buf, size, offp);
+	struct iovec local_iov = { .iov_base = buf, .iov_len = size};
+
+	return rw_raw_dev(READ, filp, &local_iov, 1, offp);
 }
 
 static ssize_t
 raw_write(struct file *filp, const char *buf, size_t size, loff_t *offp)
 {
-	return rw_raw_dev(WRITE, filp, (char *)buf, size, offp);
+	struct iovec local_iov = { .iov_base = buf, .iov_len = size};
+
+	return rw_raw_dev(WRITE, filp, &local_iov, 1, offp);
+}
+
+static ssize_t 
+raw_readv(struct file *filp, const struct iovec *iov, unsigned long nr_segs, loff_t *offp) 
+{
+	return rw_raw_dev(READ, filp, iov, nr_segs, offp);
+}
+
+static ssize_t 
+raw_writev(struct file *filp, const struct iovec *iov, unsigned long nr_segs, loff_t *offp) 
+{
+	return rw_raw_dev(WRITE, filp, iov, nr_segs, offp);
 }
 
 static struct file_operations raw_fops = {
@@ -244,6 +264,8 @@ static struct file_operations raw_fops =
 	.open	=	raw_open,
 	.release=	raw_release,
 	.ioctl	=	raw_ioctl,
+	.readv	= 	raw_readv,
+	.writev	= 	raw_writev,
 	.owner	=	THIS_MODULE,
 };
 
--- 2.5.34/fs/block_dev.c~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/fs/block_dev.c	Wed Sep 11 01:05:34 2002
@@ -116,11 +116,11 @@ blkdev_get_blocks(struct inode *inode, s
 }
 
 static int
-blkdev_direct_IO(int rw, struct inode *inode, char *buf,
-			loff_t offset, size_t count)
+blkdev_direct_IO(int rw, struct inode *inode, const struct iovec *iov,
+			loff_t offset, unsigned long nr_segs)
 {
-	return generic_direct_IO(rw, inode, buf, offset,
-				count, blkdev_get_blocks);
+	return generic_direct_IO(rw, inode, iov, offset,
+				nr_segs, blkdev_get_blocks);
 }
 
 static int blkdev_writepage(struct page * page)
@@ -787,6 +787,14 @@ static int blkdev_reread_part(struct blo
 	return res;
 }
 
+static ssize_t blkdev_file_write(struct file *file, const char *buf,
+				   size_t count, loff_t *ppos)
+{
+	struct iovec local_iov = { .iov_base = (void *)buf, .iov_len = count };
+
+	return generic_file_write_nolock(file, &local_iov, 1, ppos);
+}
+
 static int blkdev_ioctl(struct inode *inode, struct file *file, unsigned cmd,
 			unsigned long arg)
 {
@@ -832,26 +840,28 @@ static int blkdev_ioctl(struct inode *in
 }
 
 struct address_space_operations def_blk_aops = {
-	readpage: blkdev_readpage,
-	writepage: blkdev_writepage,
-	sync_page: block_sync_page,
-	prepare_write: blkdev_prepare_write,
-	commit_write: blkdev_commit_write,
-	writepages: generic_writepages,
-	vm_writeback: generic_vm_writeback,
-	direct_IO: blkdev_direct_IO,
+	.readpage	= blkdev_readpage,
+	.writepage	= blkdev_writepage,
+	.sync_page	= block_sync_page,
+	.prepare_write	= blkdev_prepare_write,
+	.commit_write	= blkdev_commit_write,
+	.writepages	= generic_writepages,
+	.vm_writeback	= generic_vm_writeback,
+	.direct_IO	= blkdev_direct_IO,
 };
 
 struct file_operations def_blk_fops = {
-	open:		blkdev_open,
-	release:	blkdev_close,
-	llseek:		block_llseek,
-	read:		generic_file_read,
-	write:		generic_file_write_nolock,
-	mmap:		generic_file_mmap,
-	fsync:		block_fsync,
-	ioctl:		blkdev_ioctl,
-	sendfile:	generic_file_sendfile,
+	.open		= blkdev_open,
+	.release	= blkdev_close,
+	.llseek		= block_llseek,
+	.read		= generic_file_read,
+	.write		= blkdev_file_write,
+	.mmap		= generic_file_mmap,
+	.fsync		= block_fsync,
+	.ioctl		= blkdev_ioctl,
+	.readv		= generic_file_readv,
+	.writev		= generic_file_writev,
+	.sendfile	= generic_file_sendfile,
 };
 
 int ioctl_by_bdev(struct block_device *bdev, unsigned cmd, unsigned long arg)
--- 2.5.34/fs/direct-io.c~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/fs/direct-io.c	Tue Sep 10 18:57:53 2002
@@ -75,7 +75,7 @@ struct dio {
  */
 static inline unsigned dio_pages_present(struct dio *dio)
 {
-	return dio->head - dio->tail;
+	return dio->tail - dio->head;
 }
 
 /*
@@ -265,6 +265,10 @@ static int dio_bio_complete(struct dio *
 static int dio_await_completion(struct dio *dio)
 {
 	int ret = 0;
+
+	if (dio->bio)
+		dio_bio_submit(dio);
+
 	while (atomic_read(&dio->bio_count)) {
 		struct bio *bio = dio_await_one(dio);
 		int ret2;
@@ -523,29 +527,16 @@ out:
 	return ret;
 }
 
-/*
- * The main direct-IO function.  This is a library function for use by
- * filesystem drivers.
- */
 int
-generic_direct_IO(int rw, struct inode *inode, char *buf, loff_t offset,
-			size_t count, get_blocks_t get_blocks)
+direct_io_worker(int rw, struct inode *inode, const struct iovec *iov, 
+	loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks)
 {
 	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocksize_mask = (1 << blkbits) - 1;
-	const unsigned long user_addr = (unsigned long)buf;
-	int ret;
-	int ret2;
+	unsigned long user_addr; 
+	int seg, ret2, ret = 0;
 	struct dio dio;
-	size_t bytes;
-
-	/* Check the memory alignment.  Blocks cannot straddle pages */
-	if ((user_addr & blocksize_mask) || (count & blocksize_mask)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	size_t bytes, tot_bytes = 0;
 
-	/* BIO submission state */
 	dio.bio = NULL;
 	dio.bvec = NULL;
 	dio.inode = inode;
@@ -553,31 +544,13 @@ generic_direct_IO(int rw, struct inode *
 	dio.blkbits = blkbits;
 	dio.block_in_file = offset >> blkbits;
 	dio.blocks_available = 0;
-	dio.final_block_in_request = (offset + count) >> blkbits;
 
-	/* Index into the first page of the first block */
-	dio.first_block_in_page = (user_addr & (PAGE_SIZE - 1)) >> blkbits;
 	dio.boundary = 0;
 	dio.reap_counter = 0;
 	dio.get_blocks = get_blocks;
 	dio.last_block_in_bio = -1;
 	dio.next_block_in_bio = -1;
 
-	/* Page fetching state */
-	dio.curr_page = 0;
-	bytes = count;
-	dio.total_pages = 0;
-	if (user_addr & (PAGE_SIZE - 1)) {
-		dio.total_pages++;
-		bytes -= PAGE_SIZE - (user_addr & (PAGE_SIZE - 1));
-	}
-
-	dio.total_pages += (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
-	dio.curr_user_address = user_addr;
-
-	/* Page queue */
-	dio.head = 0;
-	dio.tail = 0;
 	dio.page_errors = 0;
 
 	/* BIO completion state */
@@ -586,38 +559,75 @@ generic_direct_IO(int rw, struct inode *
 	dio.bio_list = NULL;
 	dio.waiter = NULL;
 
-	ret = do_direct_IO(&dio);
+	for (seg = 0; seg < nr_segs; seg++) {
+		user_addr = (unsigned long)iov[seg].iov_base;
+		bytes = iov[seg].iov_len;
+
+		/* Index into the first page of the first block */
+		dio.first_block_in_page = (user_addr & (PAGE_SIZE - 1)) >> blkbits;
+		dio.final_block_in_request = dio.block_in_file + (bytes >> blkbits);
+		/* Page fetching state */
+		dio.head = 0;
+		dio.tail = 0;
+		dio.curr_page = 0;
+
+		dio.total_pages = 0;
+		if (user_addr & (PAGE_SIZE-1)) {
+			dio.total_pages++;
+			bytes -= PAGE_SIZE - (user_addr & (PAGE_SIZE - 1));
+		}
+		dio.total_pages += (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
+		dio.curr_user_address = user_addr;
+	
+		ret = do_direct_IO(&dio);
+
+		if (ret) {
+			dio_cleanup(&dio);
+			break;
+		}
+
+		tot_bytes += iov[seg].iov_len - ((dio.final_block_in_request -
+					dio.block_in_file) << blkbits);
+
+	} /* end iovec loop */
 
-	if (dio.bio)
-		dio_bio_submit(&dio);
-	if (ret)
-		dio_cleanup(&dio);
 	ret2 = dio_await_completion(&dio);
 	if (ret == 0)
 		ret = ret2;
 	if (ret == 0)
 		ret = dio.page_errors;
 	if (ret == 0)
-		ret = count - ((dio.final_block_in_request -
-				dio.block_in_file) << blkbits);
-out:
+		ret = tot_bytes; 
+
 	return ret;
 }
 
-ssize_t
-generic_file_direct_IO(int rw, struct inode *inode, char *buf,
-			loff_t offset, size_t count)
+/*
+ * This is a library function for use by filesystem drivers.
+ */
+int
+generic_direct_IO(int rw, struct inode *inode, const struct iovec *iov, 
+	loff_t offset, unsigned long nr_segs, get_blocks_t get_blocks)
 {
+	int seg;
+	size_t size;
+	unsigned long addr;
 	struct address_space *mapping = inode->i_mapping;
-	unsigned blocksize_mask;
-	ssize_t retval;
+	unsigned blocksize_mask = (1 << inode->i_blkbits) - 1;
+	ssize_t retval = -EINVAL;
 
-	blocksize_mask = (1 << inode->i_blkbits) - 1;
-	if ((offset & blocksize_mask) || (count & blocksize_mask)) {
-		retval = -EINVAL;
+	if (offset & blocksize_mask) {
 		goto out;
 	}
 
+	/* Check the memory alignment.  Blocks cannot straddle pages */
+	for (seg = 0; seg < nr_segs; seg++) {
+		addr = (unsigned long)iov[seg].iov_base;
+		size = iov[seg].iov_len;
+		if ((addr & blocksize_mask) || (size & blocksize_mask)) 
+			goto out;	
+	}
+
 	if (mapping->nrpages) {
 		retval = filemap_fdatawrite(mapping);
 		if (retval == 0)
@@ -625,9 +635,21 @@ generic_file_direct_IO(int rw, struct in
 		if (retval)
 			goto out;
 	}
-	retval = mapping->a_ops->direct_IO(rw, inode, buf, offset, count);
+
+	retval = direct_io_worker(rw, inode, iov, offset, nr_segs, get_blocks);
+out:
+	return retval;
+}
+
+ssize_t
+generic_file_direct_IO(int rw, struct inode *inode, const struct iovec *iov, 
+	loff_t offset, unsigned long nr_segs)
+{
+	struct address_space *mapping = inode->i_mapping;
+	ssize_t retval;
+
+	retval = mapping->a_ops->direct_IO(rw, inode, iov, offset, nr_segs);
 	if (inode->i_mapping->nrpages)
 		invalidate_inode_pages2(inode->i_mapping);
-out:
 	return retval;
 }
--- 2.5.34/fs/ext2/file.c~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/fs/ext2/file.c	Tue Sep 10 18:57:53 2002
@@ -46,6 +46,8 @@ struct file_operations ext2_file_operati
 	.open		= generic_file_open,
 	.release	= ext2_release_file,
 	.fsync		= ext2_sync_file,
+	.readv		= generic_file_readv,
+	.writev		= generic_file_writev,
 	.sendfile	= generic_file_sendfile,
 };
 
--- 2.5.34/fs/ext2/inode.c~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/fs/ext2/inode.c	Wed Sep 11 01:05:16 2002
@@ -619,11 +619,11 @@ ext2_get_blocks(struct inode *inode, sec
 }
 
 static int
-ext2_direct_IO(int rw, struct inode *inode, char *buf,
-			loff_t offset, size_t count)
+ext2_direct_IO(int rw, struct inode *inode, const struct iovec *iov,
+			loff_t offset, unsigned long nr_segs)
 {
-	return generic_direct_IO(rw, inode, buf,
-				offset, count, ext2_get_blocks);
+	return generic_direct_IO(rw, inode, iov,
+				offset, nr_segs, ext2_get_blocks);
 }
 
 static int
--- 2.5.34/fs/jfs/file.c~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/fs/jfs/file.c	Tue Sep 10 18:57:53 2002
@@ -108,6 +108,8 @@ struct file_operations jfs_file_operatio
 	.write		= generic_file_write,
 	.read		= generic_file_read,
 	.mmap		= generic_file_mmap,
+	.readv		= generic_file_readv,
+	.writev		= generic_file_writev,
  	.sendfile	= generic_file_sendfile,
 	.fsync		= jfs_fsync,
 };
--- 2.5.34/fs/jfs/inode.c~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/fs/jfs/inode.c	Wed Sep 11 01:05:16 2002
@@ -309,11 +309,11 @@ static int jfs_bmap(struct address_space
 	return generic_block_bmap(mapping, block, jfs_get_block);
 }
 
-static int jfs_direct_IO(int rw, struct inode *inode, char *buf,
-			loff_t offset, size_t count)
+static int jfs_direct_IO(int rw, struct inode *inode, const struct iovec *iov, 
+			loff_t offset, unsigned long nr_segs)
 {
-	return generic_direct_IO(rw, inode, buf,
-				offset, count, jfs_get_blocks);
+	return generic_direct_IO(rw, inode, iov,
+				offset, nr_segs, jfs_get_blocks);
 }
 
 struct address_space_operations jfs_aops = {
--- 2.5.34/fs/read_write.c~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/fs/read_write.c	Tue Sep 10 18:57:53 2002
@@ -286,9 +286,29 @@ asmlinkage ssize_t sys_pwrite64(unsigned
 	return ret;
 }
 
+/*
+ * Reduce an iovec's length in-place.  Return the resulting number of segments
+ */
+unsigned long iov_shorten(struct iovec *iov, unsigned long nr_segs, size_t to)
+{
+	unsigned long seg = 0;
+	size_t len = 0;
+
+	while (seg < nr_segs) {
+		seg++;
+		if (len + iov->iov_len >= to) {
+			iov->iov_len = to - len;
+			break;
+		}
+		len += iov->iov_len;
+		iov++;
+	}
+	return seg;
+}
+
 static ssize_t do_readv_writev(int type, struct file *file,
 			       const struct iovec * vector,
-			       unsigned long count)
+			       unsigned long nr_segs)
 {
 	typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
 	typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
@@ -296,73 +316,86 @@ static ssize_t do_readv_writev(int type,
 	size_t tot_len;
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov=iovstack;
-	ssize_t ret, i;
+	ssize_t ret = -EINVAL;
+	int seg;
 	io_fn_t fn;
 	iov_fn_t fnv;
 	struct inode *inode;
 
 	/*
+	 * SuS says "The readv() function *may* fail if the iovcnt argument
+	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
+	 * traditionally returned -EINVAL for zero segments, so...
+	 */
+	if (nr_segs == 0)
+		goto out;
+
+	/*
 	 * First get the "struct iovec" from user memory and
 	 * verify all the pointers
 	 */
-	ret = 0;
-	if (!count)
-		goto out_nofree;
-	ret = -EINVAL;
-	if (count > UIO_MAXIOV)
-		goto out_nofree;
+	if ((nr_segs > UIO_MAXIOV) || (nr_segs <= 0))
+		goto out;
 	if (!file->f_op)
-		goto out_nofree;
-	if (count > UIO_FASTIOV) {
+		goto out;
+	if (nr_segs > UIO_FASTIOV) {
 		ret = -ENOMEM;
-		iov = kmalloc(count*sizeof(struct iovec), GFP_KERNEL);
+		iov = kmalloc(nr_segs*sizeof(struct iovec), GFP_KERNEL);
 		if (!iov)
-			goto out_nofree;
+			goto out;
 	}
 	ret = -EFAULT;
-	if (copy_from_user(iov, vector, count*sizeof(*vector)))
+	if (copy_from_user(iov, vector, nr_segs*sizeof(*vector)))
 		goto out;
 
 	/*
 	 * Single unix specification:
-	 * We should -EINVAL if an element length is not >= 0 and fitting an ssize_t
-	 * The total length is fitting an ssize_t
+	 * We should -EINVAL if an element length is not >= 0 and fitting an
+	 * ssize_t.  The total length is fitting an ssize_t
 	 *
 	 * Be careful here because iov_len is a size_t not an ssize_t
 	 */
-	 
 	tot_len = 0;
 	ret = -EINVAL;
-	for (i = 0 ; i < count ; i++) {
+	for (seg = 0 ; seg < nr_segs; seg++) {
 		ssize_t tmp = tot_len;
-		ssize_t len = (ssize_t)iov[i].iov_len;
+		ssize_t len = (ssize_t)iov[seg].iov_len;
 		if (len < 0)	/* size_t not fitting an ssize_t .. */
 			goto out;
 		tot_len += len;
 		if (tot_len < tmp) /* maths overflow on the ssize_t */
 			goto out;
 	}
+	if (tot_len == 0) {
+		ret = 0;
+		goto out;
+	}
 
 	inode = file->f_dentry->d_inode;
 	/* VERIFY_WRITE actually means a read, as we write to user space */
-	ret = locks_verify_area((type == VERIFY_WRITE
+	ret = locks_verify_area((type == READ 
 				 ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE),
 				inode, file, file->f_pos, tot_len);
-	if (ret) goto out;
+	if (ret)
+		goto out;
 
-	fnv = (type == VERIFY_WRITE ? file->f_op->readv : file->f_op->writev);
+	fnv = NULL;
+	if (type == READ) {
+		fn = file->f_op->read;
+		fnv = file->f_op->readv;
+	} else {
+		fn = (io_fn_t)file->f_op->write;
+		fnv = file->f_op->writev;
+	}
 	if (fnv) {
-		ret = fnv(file, iov, count, &file->f_pos);
+		ret = fnv(file, iov, nr_segs, &file->f_pos);
 		goto out;
 	}
 
-	/* VERIFY_WRITE actually means a read, as we write to user space */
-	fn = (type == VERIFY_WRITE ? file->f_op->read :
-	      (io_fn_t) file->f_op->write);
-
+	/* Do it by hand, with file-ops */
 	ret = 0;
 	vector = iov;
-	while (count > 0) {
+	while (nr_segs > 0) {
 		void * base;
 		size_t len;
 		ssize_t nr;
@@ -370,7 +403,7 @@ static ssize_t do_readv_writev(int type,
 		base = vector->iov_base;
 		len = vector->iov_len;
 		vector++;
-		count--;
+		nr_segs--;
 
 		nr = fn(file, base, len, &file->f_pos);
 
@@ -382,20 +415,18 @@ static ssize_t do_readv_writev(int type,
 		if (nr != len)
 			break;
 	}
-
 out:
 	if (iov != iovstack)
 		kfree(iov);
-out_nofree:
-	/* VERIFY_WRITE actually means a read, as we write to user space */
-	if ((ret + (type == VERIFY_WRITE)) > 0)
+	if ((ret + (type == READ)) > 0)
 		dnotify_parent(file->f_dentry,
-			(type == VERIFY_WRITE) ? DN_MODIFY : DN_ACCESS);
+				(type == READ) ? DN_MODIFY : DN_ACCESS);
 	return ret;
 }
 
-asmlinkage ssize_t sys_readv(unsigned long fd, const struct iovec * vector,
-			     unsigned long count)
+
+asmlinkage ssize_t
+sys_readv(unsigned long fd, const struct iovec *vector, unsigned long nr_segs)
 {
 	struct file * file;
 	ssize_t ret;
@@ -409,7 +440,7 @@ asmlinkage ssize_t sys_readv(unsigned lo
 	    (file->f_op->readv || file->f_op->read)) {
 		ret = security_ops->file_permission (file, MAY_READ);
 		if (!ret)
-			ret = do_readv_writev(VERIFY_WRITE, file, vector, count);
+			ret = do_readv_writev(READ, file, vector, nr_segs);
 	}
 	fput(file);
 
@@ -417,8 +448,8 @@ bad_file:
 	return ret;
 }
 
-asmlinkage ssize_t sys_writev(unsigned long fd, const struct iovec * vector,
-			      unsigned long count)
+asmlinkage ssize_t
+sys_writev(unsigned long fd, const struct iovec * vector, unsigned long nr_segs)
 {
 	struct file * file;
 	ssize_t ret;
@@ -432,7 +463,7 @@ asmlinkage ssize_t sys_writev(unsigned l
 	    (file->f_op->writev || file->f_op->write)) {
 		ret = security_ops->file_permission (file, MAY_WRITE);
 		if (!ret)
-			ret = do_readv_writev(VERIFY_READ, file, vector, count);
+			ret = do_readv_writev(WRITE, file, vector, nr_segs);
 	}
 	fput(file);
 
--- 2.5.34/include/linux/fs.h~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/include/linux/fs.h	Wed Sep 11 01:05:18 2002
@@ -307,8 +307,7 @@ struct address_space_operations {
 	int (*bmap)(struct address_space *, long);
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
-	int (*direct_IO)(int, struct inode *, char *buf,
-				loff_t offset, size_t count);
+	int (*direct_IO)(int, struct inode *, const struct iovec *iov, loff_t offset, unsigned long nr_segs);
 };
 
 struct backing_dev_info;
@@ -1245,14 +1244,18 @@ extern int generic_file_mmap(struct file
 extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
 extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
-extern ssize_t generic_file_write_nolock(struct file *, const char *, size_t, loff_t *);
+ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
+				unsigned long nr_segs, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, struct file *, loff_t *, size_t);
 extern void do_generic_file_read(struct file *, loff_t *, read_descriptor_t *, read_actor_t);
-ssize_t generic_file_direct_IO(int rw, struct inode *inode, char *buf,
-				loff_t offset, size_t count);
-int generic_direct_IO(int rw, struct inode *inode, char *buf,
-			loff_t offset, size_t count, get_blocks_t *get_blocks);
-
+extern ssize_t generic_file_direct_IO(int rw, struct inode *inode, 
+	const struct iovec *iov, loff_t offset, unsigned long nr_segs);
+extern int generic_direct_IO(int rw, struct inode *inode, const struct iovec 
+	*iov, loff_t offset, unsigned long nr_segs, get_blocks_t *get_blocks);
+extern ssize_t generic_file_readv(struct file *filp, const struct iovec *iov, 
+	unsigned long nr_segs, loff_t *ppos);
+ssize_t generic_file_writev(struct file *filp, const struct iovec *iov, 
+			unsigned long nr_segs, loff_t *ppos);
 extern loff_t no_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t remote_llseek(struct file *file, loff_t offset, int origin);
--- 2.5.34/kernel/ksyms.c~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/kernel/ksyms.c	Wed Sep 11 01:05:23 2002
@@ -42,6 +42,7 @@
 #include <linux/highuid.h>
 #include <linux/brlock.h>
 #include <linux/fs.h>
+#include <linux/uio.h>
 #include <linux/tty.h>
 #include <linux/in6.h>
 #include <linux/completion.h>
@@ -344,6 +345,9 @@ EXPORT_SYMBOL(register_disk);
 EXPORT_SYMBOL(read_dev_sector);
 EXPORT_SYMBOL(init_buffer);
 EXPORT_SYMBOL_GPL(generic_file_direct_IO);
+EXPORT_SYMBOL(generic_file_readv);
+EXPORT_SYMBOL(generic_file_writev);
+EXPORT_SYMBOL(iov_shorten);
 
 /* tty routines */
 EXPORT_SYMBOL(tty_hangup);
--- 2.5.34/mm/filemap.c~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/mm/filemap.c	Wed Sep 11 01:05:21 2002
@@ -18,6 +18,7 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
+#include <linux/uio.h>
 #include <linux/iobuf.h>
 #include <linux/hash.h>
 #include <linux/writeback.h>
@@ -1121,14 +1122,18 @@ success:
  * This is the "read()" routine for all filesystems
  * that can use the page cache directly.
  */
-ssize_t
-generic_file_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
+static ssize_t
+__generic_file_read(struct file *filp, const struct iovec *iov,
+		unsigned long nr_segs, loff_t *ppos)
 {
 	ssize_t retval;
+	unsigned long seg;
+	size_t count = iov_length(iov, nr_segs);
 
 	if ((ssize_t) count < 0)
 		return -EINVAL;
 
+	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
 	if (filp->f_flags & O_DIRECT) {
 		loff_t pos = *ppos, size;
 		struct address_space *mapping;
@@ -1141,10 +1146,13 @@ generic_file_read(struct file *filp, cha
 			goto out; /* skip atime */
 		size = inode->i_size;
 		if (pos < size) {
-			if (pos + count > size)
+			if (pos + count > size) {
 				count = size - pos;
-			retval = generic_file_direct_IO(READ, inode,
-							buf, pos, count);
+				nr_segs = iov_shorten((struct iovec *)iov,
+							nr_segs, count);
+			}
+			retval = generic_file_direct_IO(READ, inode, 
+					iov, pos, nr_segs);
 			if (retval > 0)
 				*ppos = pos + retval;
 		}
@@ -1152,27 +1160,42 @@ generic_file_read(struct file *filp, cha
 		goto out;
 	}
 
-	retval = -EFAULT;
-	if (access_ok(VERIFY_WRITE, buf, count)) {
-		retval = 0;
+	for (seg = 0; seg < nr_segs; seg++) {
+		if (!access_ok(VERIFY_WRITE,iov[seg].iov_base,iov[seg].iov_len))
+			return -EFAULT;
+	}
 
-		if (count) {
+	retval = 0;
+	if (count) {
+		for (seg = 0; seg < nr_segs; seg++) {
 			read_descriptor_t desc;
 
 			desc.written = 0;
-			desc.count = count;
-			desc.buf = buf;
+			desc.buf = iov[seg].iov_base;
+			desc.count = iov[seg].iov_len;
+			if (desc.count == 0)
+				continue;
 			desc.error = 0;
 			do_generic_file_read(filp,ppos,&desc,file_read_actor);
-			retval = desc.written;
-			if (!retval)
+			retval += desc.written;
+			if (!retval) {
 				retval = desc.error;
+				break;
+			}
 		}
 	}
 out:
 	return retval;
 }
 
+ssize_t
+generic_file_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
+{
+	struct iovec local_iov = { .iov_base = buf, .iov_len = count };
+
+	return __generic_file_read(filp, &local_iov, 1, ppos);
+}
+
 static int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
 {
 	ssize_t written;
@@ -1926,11 +1949,14 @@ filemap_copy_from_user(struct page *page
  * it for writing by marking it dirty.
  *							okir@monad.swb.de
  */
-ssize_t generic_file_write_nolock(struct file *file, const char *buf,
-				  size_t count, loff_t *ppos)
+ssize_t
+generic_file_write_nolock(struct file *file, const struct iovec *iov,
+				unsigned long nr_segs, loff_t *ppos)
 {
 	struct address_space * mapping = file->f_dentry->d_inode->i_mapping;
 	struct address_space_operations *a_ops = mapping->a_ops;
+	const size_t ocount = iov_length(iov, nr_segs);
+	size_t count =	ocount;
 	struct inode 	*inode = mapping->host;
 	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
 	long		status = 0;
@@ -1942,12 +1968,19 @@ ssize_t generic_file_write_nolock(struct
 	unsigned	bytes;
 	time_t		time_now;
 	struct pagevec	lru_pvec;
+	struct iovec	*cur_iov;
+	unsigned	iov_bytes;	/* Cumulative count to the end of the
+					   current iovec */
+	unsigned long	seg;
+	char		*buf;
 
 	if (unlikely((ssize_t)count < 0))
 		return -EINVAL;
 
-	if (unlikely(!access_ok(VERIFY_READ, buf, count)))
-		return -EFAULT;
+	for (seg = 0; seg < nr_segs; seg++) {
+		if (!access_ok(VERIFY_READ,iov[seg].iov_base,iov[seg].iov_len))
+			return -EFAULT;
+	}
 
 	pos = *ppos;
 	if (unlikely(pos < 0))
@@ -2045,9 +2078,13 @@ ssize_t generic_file_write_nolock(struct
 		mark_inode_dirty_sync(inode);
 	}
 
+	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
 	if (unlikely(file->f_flags & O_DIRECT)) {
-		written = generic_file_direct_IO(WRITE, inode,
-						(char *)buf, pos, count);
+		if (count != ocount)
+			nr_segs = iov_shorten((struct iovec *)iov,
+						nr_segs, count);
+		written = generic_file_direct_IO(WRITE, inode, 
+					iov, pos, nr_segs);
 		if (written > 0) {
 			loff_t end = pos + written;
 			if (end > inode->i_size && !S_ISBLK(inode->i_mode)) {
@@ -2065,6 +2102,9 @@ ssize_t generic_file_write_nolock(struct
 		goto out_status;
 	}
 
+	cur_iov = (struct iovec *)iov;
+	iov_bytes = cur_iov->iov_len;
+	buf = cur_iov->iov_base;
 	do {
 		unsigned long index;
 		unsigned long offset;
@@ -2075,6 +2115,8 @@ ssize_t generic_file_write_nolock(struct
 		bytes = PAGE_CACHE_SIZE - offset;
 		if (bytes > count)
 			bytes = count;
+		if (bytes + written > iov_bytes)
+			bytes = iov_bytes - written;
 
 		/*
 		 * Bring in the user page that we will copy from _first_.
@@ -2084,7 +2126,7 @@ ssize_t generic_file_write_nolock(struct
 		 */
 		fault_in_pages_readable(buf, bytes);
 
-		page = __grab_cache_page(mapping, index, &cached_page, &lru_pvec);
+		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
 		if (!page) {
 			status = -ENOMEM;
 			break;
@@ -2115,6 +2157,11 @@ ssize_t generic_file_write_nolock(struct
 				count -= status;
 				pos += status;
 				buf += status;
+				if (written == iov_bytes && count) {
+					cur_iov++;
+					iov_bytes += cur_iov->iov_len;
+					buf = cur_iov->iov_base;
+				}
 			}
 		}
 		if (!PageReferenced(page))
@@ -2151,10 +2198,29 @@ ssize_t generic_file_write(struct file *
 {
 	struct inode	*inode = file->f_dentry->d_inode->i_mapping->host;
 	int		err;
+	struct iovec local_iov = { .iov_base = (void *)buf, .iov_len = count };
 
 	down(&inode->i_sem);
-	err = generic_file_write_nolock(file, buf, count, ppos);
+	err = generic_file_write_nolock(file, &local_iov, 1, ppos);
 	up(&inode->i_sem);
 
 	return err;
 }
+
+ssize_t generic_file_readv(struct file *filp, const struct iovec *iov,
+			unsigned long nr_segs, loff_t *ppos)
+{
+	return __generic_file_read(filp, iov, nr_segs, ppos);
+}
+
+ssize_t generic_file_writev(struct file *file, const struct iovec *iov,
+			unsigned long nr_segs, loff_t * ppos) 
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	ssize_t ret;
+
+	down(&inode->i_sem);
+	ret = generic_file_write_nolock(file, iov, nr_segs, ppos);
+	up(&inode->i_sem);
+	return ret;
+}
--- 2.5.34/fs/ext3/inode.c~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/fs/ext3/inode.c	Wed Sep 11 01:05:31 2002
@@ -1399,13 +1399,15 @@ static int ext3_releasepage(struct page 
  * If the O_DIRECT write is intantiating holes inside i_size and the machine
  * crashes then stale disk data _may_ be exposed inside the file.
  */
-static int ext3_direct_IO(int rw, struct inode *inode, char *buf,
-			loff_t offset, size_t count)
+static int ext3_direct_IO(int rw, struct inode *inode,
+			const struct iovec *iov, loff_t offset,
+			unsigned long nr_segs)
 {
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	handle_t *handle = NULL;
 	int ret;
 	int orphan = 0;
+	size_t count = iov_length(iov, nr_segs);
 
 	if (rw == WRITE) {
 		loff_t final_size = offset + count;
@@ -1428,8 +1430,8 @@ static int ext3_direct_IO(int rw, struct
 		}
 	}
 
-	ret = generic_direct_IO(rw, inode, buf, offset,
-				count, ext3_direct_io_get_blocks);
+	ret = generic_direct_IO(rw, inode, iov, offset,
+				nr_segs, ext3_direct_io_get_blocks);
 
 out_stop:
 	if (handle) {
--- 2.5.34/include/linux/uio.h~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/include/linux/uio.h	Tue Sep 10 18:57:53 2002
@@ -34,4 +34,19 @@ struct iovec
                                 /* Beg pardon: BSD has 1024 --ANK */
 #endif
 
+/*
+ * Total number of bytes covered by an iovec
+ */
+static inline size_t iov_length(const struct iovec *iov, unsigned long nr_segs)
+{
+	unsigned long seg;
+	size_t ret = 0;
+
+	for (seg = 0; seg < nr_segs; seg++)
+		ret += iov[seg].iov_len;
+	return ret;
+}
+
+unsigned long iov_shorten(struct iovec *iov, unsigned long nr_segs, size_t to);
+
 #endif
--- 2.5.34/fs/ext3/file.c~readv-writev	Tue Sep 10 18:57:53 2002
+++ 2.5.34-akpm/fs/ext3/file.c	Tue Sep 10 18:57:53 2002
@@ -76,19 +76,21 @@ ext3_file_write(struct file *file, const
 }
 
 struct file_operations ext3_file_operations = {
-	.llseek		= generic_file_llseek,	/* BKL held */
-	.read		= generic_file_read,	/* BKL not held.  Don't need */
-	.write		= ext3_file_write,	/* BKL not held.  Don't need */
-	.ioctl		= ext3_ioctl,		/* BKL held */
+	.llseek		= generic_file_llseek,
+	.read		= generic_file_read,
+	.write		= ext3_file_write,
+	.readv		= generic_file_readv,
+	.writev		= generic_file_writev,
+	.ioctl		= ext3_ioctl,
 	.mmap		= generic_file_mmap,
-	.open		= ext3_open_file,		/* BKL not held.  Don't need */
-	.release	= ext3_release_file,	/* BKL not held.  Don't need */
-	.fsync		= ext3_sync_file,		/* BKL held */
-	.sendfile	= generic_file_sendfile,	/* BKL not held.  Don't need */
+	.open		= ext3_open_file,
+	.release	= ext3_release_file,
+	.fsync		= ext3_sync_file,
+	.sendfile	= generic_file_sendfile,
 };
 
 struct inode_operations ext3_file_inode_operations = {
-	.truncate	= ext3_truncate,		/* BKL held */
-	.setattr	= ext3_setattr,		/* BKL held */
+	.truncate	= ext3_truncate,
+	.setattr	= ext3_setattr,
 };
 

.
