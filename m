Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbTDAUNj>; Tue, 1 Apr 2003 15:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262840AbTDAUNj>; Tue, 1 Apr 2003 15:13:39 -0500
Received: from to-telus.redhat.com ([207.219.125.105]:58105 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S262835AbTDAUND>; Tue, 1 Apr 2003 15:13:03 -0500
Date: Tue, 1 Apr 2003 15:24:24 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Janet Morgan <janetmor@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, akpm@digeo.com,
       suparna@in.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/2] Retry based aio read - filesystem read changes
Message-ID: <20030401152424.A26513@redhat.com>
References: <20030305144754.A1600@in.ibm.com> <20030305150026.B1627@in.ibm.com> <20030305024254.7f154afc.akpm@digeo.com> <20030305174452.A1882@in.ibm.com> <3E8889B4.FB716506@us.ibm.com> <20030331191123.GB13178@holomorphy.com> <20030331141629.I20730@redhat.com> <3E88920A.BB8987D3@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E88920A.BB8987D3@us.ibm.com>; from janetmor@us.ibm.com on Mon, Mar 31, 2003 at 11:07:55AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 11:07:55AM -0800, Janet Morgan wrote:
> Can you post the patch you're referring to?

Something like this...  It also converts the async rw ops into vectored  
form.

		-ben


 drivers/char/raw.c       |   23 ------
 fs/adfs/file.c           |    4 -
 fs/affs/file.c           |   19 -----
 fs/afs/file.c            |    2 
 fs/aio.c                 |  127 ++++++++++++++++++++++++-----------
 fs/befs/linuxvfs.c       |    4 -
 fs/bfs/file.c            |    4 -
 fs/block_dev.c           |   18 +----
 fs/cifs/cifsfs.c         |    4 -
 fs/direct-io.c           |   10 +-
 fs/ext2/file.c           |    4 -
 fs/ext2/inode.c          |    4 -
 fs/ext3/file.c           |   14 +--
 fs/ext3/inode.c          |    4 -
 fs/fat/file.c            |   15 +---
 fs/freevxfs/vxfs_inode.c |    2 
 fs/hpfs/file.c           |   14 ---
 fs/hpfs/inode.c          |    2 
 fs/jffs/inode-v23.c      |    4 -
 fs/jffs2/file.c          |    4 -
 fs/jfs/file.c            |    4 -
 fs/minix/file.c          |    4 -
 fs/nfs/file.c            |   31 +++-----
 fs/nfs/write.c           |    4 -
 fs/ntfs/aops.c           |    2 
 fs/ntfs/file.c           |    4 -
 fs/qnx4/file.c           |    4 -
 fs/ramfs/inode.c         |    4 -
 fs/read_write.c          |  166 +++++++++++++++++++++++------------------------
 fs/reiserfs/file.c       |    4 -
 fs/smbfs/file.c          |   20 ++---
 fs/sysv/file.c           |    4 -
 fs/udf/file.c            |   18 ++---
 fs/ufs/file.c            |    4 -
 include/linux/aio.h      |   67 ++++++++++++++++--
 include/linux/fs.h       |   32 +++------
 include/net/sock.h       |   14 ++-
 kernel/ksyms.c           |    5 -
 mm/filemap.c             |  145 ++++++++---------------------------------
 net/socket.c             |   67 ++++++++----------
 40 files changed, 400 insertions(+), 485 deletions(-)
diff -purN linux-2.5/drivers/char/raw.c aio-2.5/drivers/char/raw.c
--- linux-2.5/drivers/char/raw.c	Tue Apr  1 15:17:26 2003
+++ aio-2.5/drivers/char/raw.c	Mon Mar 24 15:39:48 2003
@@ -220,33 +220,12 @@ out:
 	return err;
 }
 
-static ssize_t raw_file_write(struct file *file, const char *buf,
-				   size_t count, loff_t *ppos)
-{
-	struct iovec local_iov = { .iov_base = (void *)buf, .iov_len = count };
-
-	return generic_file_write_nolock(file, &local_iov, 1, ppos);
-}
-
-static ssize_t raw_file_aio_write(struct kiocb *iocb, const char *buf,
-					size_t count, loff_t pos)
-{
-	struct iovec local_iov = { .iov_base = (void *)buf, .iov_len = count };
-
-	return generic_file_aio_write_nolock(iocb, &local_iov, 1, &iocb->ki_pos);
-}
-
-
 static struct file_operations raw_fops = {
-	.read	=	generic_file_read,
 	.aio_read = 	generic_file_aio_read,
-	.write	=	raw_file_write,
-	.aio_write = 	raw_file_aio_write,
+	.aio_write = 	generic_file_aio_write_nolock,
 	.open	=	raw_open,
 	.release=	raw_release,
 	.ioctl	=	raw_ioctl,
-	.readv	= 	generic_file_readv,
-	.writev	= 	generic_file_writev,
 	.owner	=	THIS_MODULE,
 };
 
diff -purN linux-2.5/fs/adfs/file.c aio-2.5/fs/adfs/file.c
--- linux-2.5/fs/adfs/file.c	Tue Apr  1 15:17:53 2003
+++ aio-2.5/fs/adfs/file.c	Mon Mar 24 11:25:00 2003
@@ -31,11 +31,11 @@
 #include "adfs.h"
 
 struct file_operations adfs_file_operations = {
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= generic_file_aio_write,
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
 	.mmap		= generic_file_mmap,
 	.fsync		= file_fsync,
-	.write		= generic_file_write,
 	.sendfile	= generic_file_sendfile,
 };
 
diff -purN linux-2.5/fs/affs/file.c aio-2.5/fs/affs/file.c
--- linux-2.5/fs/affs/file.c	Tue Apr  1 15:17:53 2003
+++ aio-2.5/fs/affs/file.c	Mon Mar 24 11:25:00 2003
@@ -39,14 +39,13 @@ static int affs_grow_extcache(struct ino
 static struct buffer_head *affs_alloc_extblock(struct inode *inode, struct buffer_head *bh, u32 ext);
 static inline struct buffer_head *affs_get_extblock(struct inode *inode, u32 ext);
 static struct buffer_head *affs_get_extblock_slow(struct inode *inode, u32 ext);
-static ssize_t affs_file_write(struct file *filp, const char *buf, size_t count, loff_t *ppos);
 static int affs_file_open(struct inode *inode, struct file *filp);
 static int affs_file_release(struct inode *inode, struct file *filp);
 
 struct file_operations affs_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= affs_file_write,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.open		= affs_file_open,
 	.release	= affs_file_release,
@@ -490,20 +489,6 @@ affs_getemptyblk_ino(struct inode *inode
 	return ERR_PTR(err);
 }
 
-static ssize_t
-affs_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
-{
-	ssize_t retval;
-
-	retval = generic_file_write (file, buf, count, ppos);
-	if (retval >0) {
-		struct inode *inode = file->f_dentry->d_inode;
-		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-		mark_inode_dirty(inode);
-	}
-	return retval;
-}
-
 static int
 affs_do_readpage_ofs(struct file *file, struct page *page, unsigned from, unsigned to)
 {
diff -purN linux-2.5/fs/afs/file.c aio-2.5/fs/afs/file.c
--- linux-2.5/fs/afs/file.c	Tue Apr  1 15:17:53 2003
+++ aio-2.5/fs/afs/file.c	Mon Mar 24 11:25:00 2003
@@ -35,7 +35,7 @@ struct inode_operations afs_file_inode_o
 };
 
 struct file_operations afs_file_file_operations = {
-	.read		= generic_file_read,
+	.aio_read	= generic_file_aio_read,
 	.write		= afs_file_write,
 	.mmap		= generic_file_readonly_mmap,
 #if 0
diff -purN linux-2.5/fs/aio.c aio-2.5/fs/aio.c
--- linux-2.5/fs/aio.c	Tue Mar 25 16:50:38 2003
+++ aio-2.5/fs/aio.c	Mon Mar 31 14:41:41 2003
@@ -64,7 +64,7 @@ static void aio_kick_handler(void *);
  */
 static int __init aio_setup(void)
 {
-	kiocb_cachep = kmem_cache_create("kiocb", sizeof(struct kiocb),
+	kiocb_cachep = kmem_cache_create("kiocb", sizeof(struct sync_iocb),
 				0, SLAB_HWCACHE_ALIGN, NULL, NULL);
 	if (!kiocb_cachep)
 		panic("unable to create kiocb cache\n");
@@ -148,7 +148,7 @@ static int aio_setup_ring(struct kioctx 
 
 	dprintk("mmap address: 0x%08lx\n", info->mmap_base);
 	info->nr_pages = get_user_pages(current, ctx->mm,
-					info->mmap_base, info->mmap_size, 
+					info->mmap_base, nr_pages, 
 					1, 0, info->ring_pages, NULL);
 	up_write(&ctx->mm->mmap_sem);
 
@@ -790,6 +790,20 @@ static inline void set_timeout(long star
 	add_timer(&to->timer);
 }
 
+static inline void update_ts(struct timespec *ts, long jiffies)
+{
+	struct timespec tmp;
+	jiffies_to_timespec(jiffies, &tmp);
+	ts->tv_sec -= tmp.tv_sec;
+	ts->tv_nsec -= tmp.tv_nsec;
+	if (ts->tv_nsec < 0) {
+		ts->tv_nsec += 1000000000;
+		ts->tv_sec -= 1;
+	}
+	if (ts->tv_sec < 0)
+		ts->tv_sec = ts->tv_nsec = 0;
+}
+
 static inline void clear_timeout(struct timeout *to)
 {
 	del_timer_sync(&to->timer);
@@ -807,6 +821,7 @@ static int read_events(struct kioctx *ct
 	int			i = 0;
 	struct io_event		ent;
 	struct timeout		to;
+	struct timespec		ts;
 
 	/* needed to zero any padding within an entry (there shouldn't be 
 	 * any, but C is fun!
@@ -844,7 +859,6 @@ static int read_events(struct kioctx *ct
 
 	init_timeout(&to);
 	if (timeout) {
-		struct timespec	ts;
 		ret = -EFAULT;
 		if (unlikely(copy_from_user(&ts, timeout, sizeof(ts))))
 			goto out;
@@ -890,8 +904,12 @@ static int read_events(struct kioctx *ct
 		i ++;
 	}
 
-	if (timeout)
+	if (timeout) {
 		clear_timeout(&to);
+		update_ts(&ts, jiffies - start_jiffies);
+		if (copy_to_user(timeout, &ts, sizeof(ts)))
+			ret = -EFAULT;
+	}
 out:
 	return i ? i : ret;
 }
@@ -984,6 +1002,63 @@ asmlinkage long sys_io_destroy(aio_conte
 	return -EINVAL;
 }
 
+static ssize_t rw_issue(struct rw_iocb *rw, struct file *file,
+		        struct iocb *iocb, ssize_t (*op)(struct rw_iocb *))
+{
+	ssize_t ret;
+
+	if (unlikely(NULL == op))
+		return -EINVAL;
+	if (unlikely(!(file->f_mode &
+			(rw->rw == WRITE ? FMODE_WRITE : FMODE_READ))))
+		return -EBADF;
+	if (unlikely(!access_ok((rw->rw == WRITE ? VERIFY_READ : VERIFY_WRITE),
+				rw->rw_local_iov.iov_base,
+				rw->rw_local_iov.iov_len)))
+		return -EFAULT;
+
+	rw->rw_local_iov.iov_base = (char *)(unsigned long)iocb->aio_buf;
+	rw->rw_local_iov.iov_len = iocb->aio_nbytes;
+	rw->rw_nsegs = 1;
+	rw->rw_iov = &rw->rw_local_iov;
+	rw->rw_pos = iocb->aio_offset;
+
+	ret = op(rw);
+	if (-EIOCBQUEUED != ret)
+		aio_complete(&rw->kiocb, ret, 0);
+	return 0;
+}
+
+static ssize_t io_submit_pread(struct kiocb *kiocb, struct file *file,
+			       struct iocb *iocb)
+{
+	struct rw_iocb *rw = kiocb_to_rw_iocb(kiocb);
+	rw->rw = READ;
+	return rw_issue(rw, file, iocb, file->f_op->aio_read);
+}
+
+static ssize_t io_submit_pwrite(struct kiocb *kiocb, struct file *file,
+				struct iocb *iocb)
+{
+	struct rw_iocb *rw = (struct rw_iocb *)kiocb;
+	rw->rw = WRITE;
+	return rw_issue(rw, file, iocb, file->f_op->aio_write);
+}
+static ssize_t io_submit_fsync(struct kiocb *kiocb, struct file *file,
+			       int dsync)
+{
+	struct fsync_iocb *fsync_iocb = kiocb_to_fsync_iocb(kiocb);
+	ssize_t ret = -EINVAL;
+	fsync_iocb->dsync = dsync;
+	if (NULL != file->f_op->aio_fsync) {
+		ret = file->f_op->aio_fsync(fsync_iocb);
+		if (-EIOCBQUEUED != ret)
+			aio_complete(&fsync_iocb->kiocb, ret, 0);
+		ret = 0;
+	}
+	return ret;
+}
+
 static int FASTCALL(io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
 				  struct iocb *iocb));
 static int io_submit_one(struct kioctx *ctx, struct iocb *user_iocb,
@@ -992,7 +1067,6 @@ static int io_submit_one(struct kioctx *
 	struct kiocb *req;
 	struct file *file;
 	ssize_t ret;
-	char *buf;
 
 	/* enforce forwards compatibility on users */
 	if (unlikely(iocb->aio_reserved1 || iocb->aio_reserved2 ||
@@ -1031,57 +1105,30 @@ static int io_submit_one(struct kioctx *
 
 	req->ki_user_obj = user_iocb;
 	req->ki_user_data = iocb->aio_data;
-	req->ki_pos = iocb->aio_offset;
-
-	buf = (char *)(unsigned long)iocb->aio_buf;
 
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
-		ret = -EBADF;
-		if (unlikely(!(file->f_mode & FMODE_READ)))
-			goto out_put_req;
-		ret = -EFAULT;
-		if (unlikely(!access_ok(VERIFY_WRITE, buf, iocb->aio_nbytes)))
-			goto out_put_req;
-		ret = -EINVAL;
-		if (file->f_op->aio_read)
-			ret = file->f_op->aio_read(req, buf,
-					iocb->aio_nbytes, req->ki_pos);
+		ret = io_submit_pread(req, file, iocb);
 		break;
 	case IOCB_CMD_PWRITE:
-		ret = -EBADF;
-		if (unlikely(!(file->f_mode & FMODE_WRITE)))
-			goto out_put_req;
-		ret = -EFAULT;
-		if (unlikely(!access_ok(VERIFY_READ, buf, iocb->aio_nbytes)))
-			goto out_put_req;
-		ret = -EINVAL;
-		if (file->f_op->aio_write)
-			ret = file->f_op->aio_write(req, buf,
-					iocb->aio_nbytes, req->ki_pos);
+		ret = io_submit_pwrite(req, file, iocb);
 		break;
 	case IOCB_CMD_FDSYNC:
-		ret = -EINVAL;
-		if (file->f_op->aio_fsync)
-			ret = file->f_op->aio_fsync(req, 1);
+		ret = io_submit_fsync(req, file, 1);
 		break;
 	case IOCB_CMD_FSYNC:
-		ret = -EINVAL;
-		if (file->f_op->aio_fsync)
-			ret = file->f_op->aio_fsync(req, 0);
+		ret = io_submit_fsync(req, file, 0);
 		break;
 	default:
 		dprintk("EINVAL: io_submit: no operation provided\n");
 		ret = -EINVAL;
 	}
 
-	if (likely(-EIOCBQUEUED == ret))
-		return 0;
-	aio_complete(req, ret, 0);
-	return 0;
-
+	if (-EIOCBQUEUED == ret)
+		ret = 0;
 out_put_req:
-	aio_put_req(req);
+	if (ret)
+		aio_put_req(req);
 	return ret;
 }
 
diff -purN linux-2.5/fs/befs/linuxvfs.c aio-2.5/fs/befs/linuxvfs.c
--- linux-2.5/fs/befs/linuxvfs.c	Tue Apr  1 15:17:53 2003
+++ aio-2.5/fs/befs/linuxvfs.c	Mon Mar 24 11:25:00 2003
@@ -73,7 +73,7 @@ struct inode_operations befs_dir_inode_o
 
 struct file_operations befs_file_operations = {
 	.llseek		= default_llseek,
-	.read		= generic_file_read,
+	.aio_read	= generic_file_aio_read,
 	.mmap		= generic_file_readonly_mmap,
 };
 
@@ -89,7 +89,7 @@ static struct inode_operations befs_syml
 };
 
 /* 
- * Called by generic_file_read() to read a page of data
+ * Called by generic_file_aio_read() to read a page of data
  * 
  * In turn, simply calls a generic block read function and
  * passes it the address of befs_get_block, for mapping file
diff -purN linux-2.5/fs/bfs/file.c aio-2.5/fs/bfs/file.c
--- linux-2.5/fs/bfs/file.c	Tue Apr  1 15:17:53 2003
+++ aio-2.5/fs/bfs/file.c	Mon Mar 24 11:25:00 2003
@@ -19,8 +19,8 @@
 
 struct file_operations bfs_file_operations = {
 	.llseek 	= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.sendfile	= generic_file_sendfile,
 };
diff -purN linux-2.5/fs/block_dev.c aio-2.5/fs/block_dev.c
--- linux-2.5/fs/block_dev.c	Tue Apr  1 15:17:52 2003
+++ aio-2.5/fs/block_dev.c	Mon Mar 24 17:25:12 2003
@@ -118,10 +118,10 @@ blkdev_get_blocks(struct inode *inode, s
 }
 
 static int
-blkdev_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
+blkdev_direct_IO(int rw, struct rw_iocb *iocb, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs)
 {
-	struct file *file = iocb->ki_filp;
+	struct file *file = iocb->kiocb.ki_filp;
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
 	return blockdev_direct_IO(rw, iocb, inode, inode->i_bdev, iov, offset,
@@ -694,14 +694,6 @@ int blkdev_close(struct inode * inode, s
 	return blkdev_put(inode->i_bdev, BDEV_FILE);
 }
 
-static ssize_t blkdev_file_write(struct file *file, const char *buf,
-				   size_t count, loff_t *ppos)
-{
-	struct iovec local_iov = { .iov_base = (void *)buf, .iov_len = count };
-
-	return generic_file_write_nolock(file, &local_iov, 1, ppos);
-}
-
 struct address_space_operations def_blk_aops = {
 	.readpage	= blkdev_readpage,
 	.writepage	= blkdev_writepage,
@@ -716,13 +708,11 @@ struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_close,
 	.llseek		= block_llseek,
-	.read		= generic_file_read,
-	.write		= blkdev_file_write,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= generic_file_aio_write_nolock,
 	.mmap		= generic_file_mmap,
 	.fsync		= block_fsync,
 	.ioctl		= blkdev_ioctl,
-	.readv		= generic_file_readv,
-	.writev		= generic_file_writev,
 	.sendfile	= generic_file_sendfile,
 };
 
diff -purN linux-2.5/fs/cifs/cifsfs.c aio-2.5/fs/cifs/cifsfs.c
--- linux-2.5/fs/cifs/cifsfs.c	Tue Apr  1 15:17:53 2003
+++ aio-2.5/fs/cifs/cifsfs.c	Mon Mar 24 11:25:00 2003
@@ -316,8 +316,8 @@ struct inode_operations cifs_symlink_ino
 };
 
 struct file_operations cifs_file_ops = {
-	.read = generic_file_read,
-	.write = generic_file_write, 
+	.aio_read = generic_file_aio_read,
+	.aio_write = generic_file_aio_write, 
 	.open = cifs_open,
 	.release = cifs_close,
 	.lock = cifs_lock,
diff -purN linux-2.5/fs/direct-io.c aio-2.5/fs/direct-io.c
--- linux-2.5/fs/direct-io.c	Tue Apr  1 15:17:52 2003
+++ aio-2.5/fs/direct-io.c	Mon Mar 24 17:26:02 2003
@@ -113,7 +113,7 @@ struct dio {
 	struct task_struct *waiter;	/* waiting task (NULL if none) */
 
 	/* AIO related stuff */
-	struct kiocb *iocb;		/* kiocb */
+	struct rw_iocb *iocb;		/* kiocb */
 	int is_async;			/* is IO async ? */
 	int result;			/* IO result */
 };
@@ -200,7 +200,7 @@ static void finished_one_bio(struct dio 
 {
 	if (atomic_dec_and_test(&dio->bio_count)) {
 		if(dio->is_async) {
-			aio_complete(dio->iocb, dio->result, 0);
+			aio_complete(&dio->iocb->kiocb, dio->result, 0);
 			kfree(dio);
 		}
 	}
@@ -822,7 +822,7 @@ out:
 }
 
 static int
-direct_io_worker(int rw, struct kiocb *iocb, struct inode *inode, 
+direct_io_worker(int rw, struct rw_iocb *iocb, struct inode *inode, 
 	const struct iovec *iov, loff_t offset, unsigned long nr_segs, 
 	unsigned blkbits, get_blocks_t get_blocks)
 {
@@ -836,7 +836,7 @@ direct_io_worker(int rw, struct kiocb *i
 	dio = kmalloc(sizeof(*dio), GFP_KERNEL);
 	if (!dio)
 		return -ENOMEM;
-	dio->is_async = !is_sync_kiocb(iocb);
+	dio->is_async = !is_sync_kiocb(&iocb->kiocb);
 
 	dio->bio = NULL;
 	dio->inode = inode;
@@ -960,7 +960,7 @@ direct_io_worker(int rw, struct kiocb *i
  * This is a library function for use by filesystem drivers.
  */
 int
-blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode, 
+blockdev_direct_IO(int rw, struct rw_iocb *iocb, struct inode *inode, 
 	struct block_device *bdev, const struct iovec *iov, loff_t offset, 
 	unsigned long nr_segs, get_blocks_t get_blocks)
 {
diff -purN linux-2.5/fs/ext2/file.c aio-2.5/fs/ext2/file.c
--- linux-2.5/fs/ext2/file.c	Tue Apr  1 15:17:53 2003
+++ aio-2.5/fs/ext2/file.c	Mon Mar 24 15:39:52 2003
@@ -41,8 +41,6 @@ static int ext2_release_file (struct ino
  */
 struct file_operations ext2_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
 	.ioctl		= ext2_ioctl,
@@ -50,8 +48,6 @@ struct file_operations ext2_file_operati
 	.open		= generic_file_open,
 	.release	= ext2_release_file,
 	.fsync		= ext2_sync_file,
-	.readv		= generic_file_readv,
-	.writev		= generic_file_writev,
 	.sendfile	= generic_file_sendfile,
 };
 
diff -purN linux-2.5/fs/ext2/inode.c aio-2.5/fs/ext2/inode.c
--- linux-2.5/fs/ext2/inode.c	Tue Apr  1 15:17:53 2003
+++ aio-2.5/fs/ext2/inode.c	Mon Mar 24 17:26:06 2003
@@ -650,10 +650,10 @@ ext2_get_blocks(struct inode *inode, sec
 }
 
 static int
-ext2_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
+ext2_direct_IO(int rw, struct rw_iocb *iocb, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs)
 {
-	struct file *file = iocb->ki_filp;
+	struct file *file = iocb->kiocb.ki_filp;
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
 	return blockdev_direct_IO(rw, iocb, inode, inode->i_sb->s_bdev, iov,
diff -purN linux-2.5/fs/ext3/file.c aio-2.5/fs/ext3/file.c
--- linux-2.5/fs/ext3/file.c	Tue Apr  1 15:17:53 2003
+++ aio-2.5/fs/ext3/file.c	Mon Mar 24 17:26:09 2003
@@ -56,13 +56,13 @@ static int ext3_open_file (struct inode 
 }
 
 static ssize_t
-ext3_file_write(struct kiocb *iocb, const char *buf, size_t count, loff_t pos)
+ext3_file_write(struct rw_iocb *iocb)
 {
-	struct file *file = iocb->ki_filp;
+	struct file *file = iocb->kiocb.ki_filp;
 	struct inode *inode = file->f_dentry->d_inode;
 	int ret, err;
 
-	ret = generic_file_aio_write(iocb, buf, count, pos);
+	ret = generic_file_aio_write(iocb);
 
 	/*
 	 * Skip flushing if there was an error, or if nothing was written.
@@ -114,12 +114,8 @@ force_commit:
 
 struct file_operations ext3_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= do_sync_read,
-	.write		= do_sync_write,
-	.aio_read		= generic_file_aio_read,
-	.aio_write		= ext3_file_write,
-	.readv		= generic_file_readv,
-	.writev		= generic_file_writev,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= ext3_file_write,
 	.ioctl		= ext3_ioctl,
 	.mmap		= generic_file_mmap,
 	.open		= ext3_open_file,
diff -purN linux-2.5/fs/ext3/inode.c aio-2.5/fs/ext3/inode.c
--- linux-2.5/fs/ext3/inode.c	Tue Apr  1 15:17:53 2003
+++ aio-2.5/fs/ext3/inode.c	Mon Mar 24 17:26:13 2003
@@ -1426,11 +1426,11 @@ static int ext3_releasepage(struct page 
  * If the O_DIRECT write is intantiating holes inside i_size and the machine
  * crashes then stale disk data _may_ be exposed inside the file.
  */
-static int ext3_direct_IO(int rw, struct kiocb *iocb,
+static int ext3_direct_IO(int rw, struct rw_iocb *iocb,
 			const struct iovec *iov, loff_t offset,
 			unsigned long nr_segs)
 {
-	struct file *file = iocb->ki_filp;
+	struct file *file = iocb->kiocb.ki_filp;
 	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	handle_t *handle = NULL;
diff -purN linux-2.5/fs/fat/file.c aio-2.5/fs/fat/file.c
--- linux-2.5/fs/fat/file.c	Tue Apr  1 15:17:54 2003
+++ aio-2.5/fs/fat/file.c	Mon Mar 24 17:54:55 2003
@@ -11,13 +11,12 @@
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 
-static ssize_t fat_file_write(struct file *filp, const char *buf, size_t count,
-			      loff_t *ppos);
+static ssize_t fat_file_write(struct rw_iocb *iocb);
 
 struct file_operations fat_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= fat_file_write,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= fat_file_write,
 	.mmap		= generic_file_mmap,
 	.fsync		= file_fsync,
 	.sendfile	= generic_file_sendfile,
@@ -65,14 +64,14 @@ int fat_get_block(struct inode *inode, s
 	return 0;
 }
 
-static ssize_t fat_file_write(struct file *filp, const char *buf, size_t count,
-			      loff_t *ppos)
+static ssize_t fat_file_write(struct rw_iocb *iocb)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct file *filp = iocb->kiocb.ki_filp;
 	int retval;
 
-	retval = generic_file_write(filp, buf, count, ppos);
+	retval = generic_file_aio_write(iocb);
 	if (retval > 0) {
+		struct inode *inode = filp->f_dentry->d_inode;
 		inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 		mark_inode_dirty(inode);
diff -purN linux-2.5/fs/freevxfs/vxfs_inode.c aio-2.5/fs/freevxfs/vxfs_inode.c
--- linux-2.5/fs/freevxfs/vxfs_inode.c	Tue Apr  1 15:17:55 2003
+++ aio-2.5/fs/freevxfs/vxfs_inode.c	Mon Mar 24 11:25:00 2003
@@ -51,7 +51,7 @@ extern struct inode_operations vxfs_imme
 static struct file_operations vxfs_file_operations = {
 	.open =			generic_file_open,
 	.llseek =		generic_file_llseek,
-	.read =			generic_file_read,
+	.aio_read =		generic_file_aio_read,
 	.mmap =			generic_file_mmap,
 	.sendfile =		generic_file_sendfile,
 };
diff -purN linux-2.5/fs/hpfs/file.c aio-2.5/fs/hpfs/file.c
--- linux-2.5/fs/hpfs/file.c	Tue Apr  1 15:17:55 2003
+++ aio-2.5/fs/hpfs/file.c	Mon Mar 24 11:25:00 2003
@@ -123,17 +123,3 @@ struct address_space_operations hpfs_aop
 	.commit_write = generic_commit_write,
 	.bmap = _hpfs_bmap
 };
-
-ssize_t hpfs_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
-{
-	ssize_t retval;
-
-	retval = generic_file_write(file, buf, count, ppos);
-	if (retval > 0) {
-		struct inode *inode = file->f_dentry->d_inode;
-		inode->i_mtime = CURRENT_TIME;
-		hpfs_i(inode)->i_dirty = 1;
-	}
-	return retval;
-}
-
diff -purN linux-2.5/fs/hpfs/inode.c aio-2.5/fs/hpfs/inode.c
--- linux-2.5/fs/hpfs/inode.c	Tue Apr  1 15:17:55 2003
+++ aio-2.5/fs/hpfs/inode.c	Mon Mar 24 11:25:00 2003
@@ -15,7 +15,7 @@
 static struct file_operations hpfs_file_ops =
 {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
+	.aio_read	= generic_file_aio_read,
 	.write		= hpfs_file_write,
 	.mmap		= generic_file_mmap,
 	.open		= hpfs_open,
diff -purN linux-2.5/fs/jffs/inode-v23.c aio-2.5/fs/jffs/inode-v23.c
--- linux-2.5/fs/jffs/inode-v23.c	Tue Apr  1 15:17:55 2003
+++ aio-2.5/fs/jffs/inode-v23.c	Mon Mar 24 11:25:00 2003
@@ -1639,8 +1639,8 @@ static struct file_operations jffs_file_
 {
 	.open		= generic_file_open,
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= generic_file_aio_write,
 	.ioctl		= jffs_ioctl,
 	.mmap		= generic_file_readonly_mmap,
 	.fsync		= jffs_fsync,
diff -purN linux-2.5/fs/jffs2/file.c aio-2.5/fs/jffs2/file.c
--- linux-2.5/fs/jffs2/file.c	Tue Apr  1 15:17:55 2003
+++ aio-2.5/fs/jffs2/file.c	Mon Mar 24 11:46:18 2003
@@ -55,8 +55,8 @@ struct file_operations jffs2_file_operat
 {
 	.llseek =	generic_file_llseek,
 	.open =		generic_file_open,
-	.read =		generic_file_read,
-	.write =	generic_file_write,
+	.aio_read =	generic_file_aio_read,
+	.aio_write =	generic_file_aio_write,
 	.ioctl =	jffs2_ioctl,
 	.mmap =		generic_file_readonly_mmap,
 	.fsync =	jffs2_fsync,
diff -purN linux-2.5/fs/jfs/file.c aio-2.5/fs/jfs/file.c
--- linux-2.5/fs/jfs/file.c	Tue Apr  1 15:17:55 2003
+++ aio-2.5/fs/jfs/file.c	Mon Mar 24 15:40:01 2003
@@ -100,13 +100,9 @@ struct inode_operations jfs_file_inode_o
 struct file_operations jfs_file_operations = {
 	.open		= jfs_open,
 	.llseek		= generic_file_llseek,
-	.write		= generic_file_write,
-	.read		= generic_file_read,
 	.aio_read	= generic_file_aio_read,
 	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
-	.readv		= generic_file_readv,
-	.writev		= generic_file_writev,
  	.sendfile	= generic_file_sendfile,
 	.fsync		= jfs_fsync,
 	.release	= jfs_release,
diff -purN linux-2.5/fs/minix/file.c aio-2.5/fs/minix/file.c
--- linux-2.5/fs/minix/file.c	Tue Apr  1 15:17:55 2003
+++ aio-2.5/fs/minix/file.c	Mon Mar 24 11:25:00 2003
@@ -17,8 +17,8 @@ int minix_sync_file(struct file *, struc
 
 struct file_operations minix_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.fsync		= minix_sync_file,
 	.sendfile	= generic_file_sendfile,
diff -purN linux-2.5/fs/nfs/file.c aio-2.5/fs/nfs/file.c
--- linux-2.5/fs/nfs/file.c	Tue Apr  1 15:17:56 2003
+++ aio-2.5/fs/nfs/file.c	Mon Mar 24 17:26:18 2003
@@ -36,17 +36,15 @@
 
 static int  nfs_file_mmap(struct file *, struct vm_area_struct *);
 static ssize_t nfs_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
-static ssize_t nfs_file_read(struct kiocb *, char *, size_t, loff_t);
-static ssize_t nfs_file_write(struct kiocb *, const char *, size_t, loff_t);
+static ssize_t nfs_file_read(struct rw_iocb *);
+static ssize_t nfs_file_write(struct rw_iocb *);
 static int  nfs_file_flush(struct file *);
 static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
 
 struct file_operations nfs_file_operations = {
 	.llseek		= remote_llseek,
-	.read		= do_sync_read,
-	.write		= do_sync_write,
-	.aio_read		= nfs_file_read,
-	.aio_write		= nfs_file_write,
+	.aio_read	= nfs_file_read,
+	.aio_write	= nfs_file_write,
 	.mmap		= nfs_file_mmap,
 	.open		= nfs_open,
 	.flush		= nfs_file_flush,
@@ -88,19 +86,19 @@ nfs_file_flush(struct file *file)
 }
 
 static ssize_t
-nfs_file_read(struct kiocb *iocb, char * buf, size_t count, loff_t pos)
+nfs_file_read(struct rw_iocb *iocb)
 {
-	struct dentry * dentry = iocb->ki_filp->f_dentry;
+	struct dentry * dentry = iocb->kiocb.ki_filp->f_dentry;
 	struct inode * inode = dentry->d_inode;
 	ssize_t result;
 
 	dfprintk(VFS, "nfs: read(%s/%s, %lu@%lu)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name,
-		(unsigned long) count, (unsigned long) pos);
+		(unsigned long)iocb->rw_iov->iov_len, (unsigned long)iocb->rw_pos);
 
 	result = nfs_revalidate_inode(NFS_SERVER(inode), inode);
 	if (!result)
-		result = generic_file_aio_read(iocb, buf, count, pos);
+		result = generic_file_aio_read(iocb);
 	return result;
 }
 
@@ -202,15 +200,16 @@ struct address_space_operations nfs_file
  * Write to a file (through the page cache).
  */
 static ssize_t
-nfs_file_write(struct kiocb *iocb, const char *buf, size_t count, loff_t pos)
+nfs_file_write(struct rw_iocb *iocb)
 {
-	struct dentry * dentry = iocb->ki_filp->f_dentry;
+	struct dentry * dentry = iocb->kiocb.ki_filp->f_dentry;
 	struct inode * inode = dentry->d_inode;
 	ssize_t result;
 
 	dfprintk(VFS, "nfs: write(%s/%s(%ld), %lu@%lu)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name,
-		inode->i_ino, (unsigned long) count, (unsigned long) pos);
+		inode->i_ino, (unsigned long)iocb->rw_iov->iov_len,
+		(unsigned long)iocb->rw_pos);
 
 	result = -EBUSY;
 	if (IS_SWAPFILE(inode))
@@ -219,11 +218,7 @@ nfs_file_write(struct kiocb *iocb, const
 	if (result)
 		goto out;
 
-	result = count;
-	if (!count)
-		goto out;
-
-	result = generic_file_aio_write(iocb, buf, count, pos);
+	result = generic_file_aio_write(iocb);
 out:
 	return result;
 
diff -purN linux-2.5/fs/nfs/write.c aio-2.5/fs/nfs/write.c
--- linux-2.5/fs/nfs/write.c	Tue Apr  1 15:17:56 2003
+++ aio-2.5/fs/nfs/write.c	Mon Mar 24 11:25:01 2003
@@ -28,7 +28,7 @@
  *
  *  -	A write request is in progress.
  *  -	A user process is in generic_file_write/nfs_update_page
- *  -	A user process is in generic_file_read
+ *  -	A user process is in generic_file_aio_read
  *
  * Also note that because of the way pages are invalidated in
  * nfs_revalidate_inode, the following assertions hold:
@@ -645,7 +645,7 @@ nfs_flush_incompatible(struct file *file
 /*
  * Update and possibly write a cached page of an NFS file.
  *
- * XXX: Keep an eye on generic_file_read to make sure it doesn't do bad
+ * XXX: Keep an eye on generic_file_aio_read to make sure it doesn't do bad
  * things with a page scheduled for an RPC call (e.g. invalidate it).
  */
 int
diff -purN linux-2.5/fs/ntfs/aops.c aio-2.5/fs/ntfs/aops.c
--- linux-2.5/fs/ntfs/aops.c	Tue Apr  1 15:17:56 2003
+++ aio-2.5/fs/ntfs/aops.c	Mon Mar 24 11:25:01 2003
@@ -157,7 +157,7 @@ still_busy:
  * unlocking it.
  *
  * We only enforce allocated_size limit because i_size is checked for in
- * generic_file_read().
+ * generic_file_aio_read().
  *
  * Return 0 on success and -errno on error.
  *
diff -purN linux-2.5/fs/ntfs/file.c aio-2.5/fs/ntfs/file.c
--- linux-2.5/fs/ntfs/file.c	Tue Apr  1 15:17:56 2003
+++ aio-2.5/fs/ntfs/file.c	Mon Mar 24 11:46:18 2003
@@ -50,9 +50,9 @@ static int ntfs_file_open(struct inode *
 
 struct file_operations ntfs_file_ops = {
 	.llseek		= generic_file_llseek,	/* Seek inside file. */
-	.read		= generic_file_read,	/* Read from file. */
+	.aio_read	= generic_file_aio_read,/* Read from file. */
 #ifdef NTFS_RW
-	.write		= generic_file_write,	/* Write to a file. */
+	.aio_write	= generic_file_aio_write,/* Write to a file. */
 #endif
 	.mmap		= generic_file_mmap,	/* Mmap file. */
 	.sendfile	= generic_file_sendfile,/* Zero-copy data send with the
diff -purN linux-2.5/fs/qnx4/file.c aio-2.5/fs/qnx4/file.c
--- linux-2.5/fs/qnx4/file.c	Tue Apr  1 15:17:56 2003
+++ aio-2.5/fs/qnx4/file.c	Mon Mar 24 11:25:01 2003
@@ -25,11 +25,11 @@
 struct file_operations qnx4_file_operations =
 {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
+	.aio_read	= generic_file_aio_read,
 	.mmap		= generic_file_mmap,
 	.sendfile	= generic_file_sendfile,
 #ifdef CONFIG_QNX4FS_RW
-	.write		= generic_file_write,
+	.aio_write	= generic_file_aio_write,
 	.fsync		= qnx4_sync_file,
 #endif
 };
diff -purN linux-2.5/fs/ramfs/inode.c aio-2.5/fs/ramfs/inode.c
--- linux-2.5/fs/ramfs/inode.c	Tue Apr  1 15:17:56 2003
+++ aio-2.5/fs/ramfs/inode.c	Mon Mar 24 11:25:01 2003
@@ -141,8 +141,8 @@ static struct address_space_operations r
 };
 
 static struct file_operations ramfs_file_operations = {
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.fsync		= simple_sync_file,
 	.sendfile	= generic_file_sendfile,
diff -purN linux-2.5/fs/read_write.c aio-2.5/fs/read_write.c
--- linux-2.5/fs/read_write.c	Tue Mar 25 16:50:38 2003
+++ aio-2.5/fs/read_write.c	Tue Mar 25 16:17:41 2003
@@ -18,7 +18,7 @@
 
 struct file_operations generic_ro_fops = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
+	.aio_read	= generic_file_aio_read,
 	.mmap		= generic_file_readonly_mmap,
 	.sendfile	= generic_file_sendfile,
 };
@@ -167,28 +167,44 @@ bad:
 }
 #endif
 
-ssize_t do_sync_read(struct file *filp, char *buf, size_t len, loff_t *ppos)
+static ssize_t do_sync_rwv(struct file *filp, char *buf, size_t tot_len,
+			   struct iovec *iov, unsigned nr_segs, loff_t *ppos,
+			   ssize_t (*op)(struct rw_iocb *), int rw)
 {
-	struct kiocb kiocb;
+	struct sync_iocb sync_iocb;
+	struct rw_iocb *iocb = kiocb_to_rw_iocb(&sync_iocb.kiocb);
 	ssize_t ret;
 
-	init_sync_kiocb(&kiocb, filp);
-	kiocb.ki_pos = *ppos;
-	ret = filp->f_op->aio_read(&kiocb, buf, len, kiocb.ki_pos);
+	init_sync_kiocb(&iocb->kiocb, filp);
+	iocb->rw = rw;
+	iocb->rw_pos = *ppos;
+	iocb->rw_nsegs = nr_segs;
+	iocb->rw_iov = (NULL == iov) ? &iocb->rw_local_iov : iov;
+	iocb->rw_local_iov.iov_base = buf;
+	iocb->rw_local_iov.iov_len = tot_len;
+	
+	ret = op(iocb);
 	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&kiocb);
-	*ppos = kiocb.ki_pos;
+		ret = wait_on_sync_kiocb(&iocb->kiocb);
+	*ppos = iocb->rw_pos;
 	return ret;
 }
 
+ssize_t do_sync_rw(struct file *filp, char *buf, size_t count, loff_t *ppos,
+		   ssize_t (*op)(struct rw_iocb *), int rw)
+{
+	return do_sync_rwv(filp, buf, count, NULL, 1, ppos, op, rw);
+}
+
 ssize_t vfs_read(struct file *file, char *buf, size_t count, loff_t *pos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	ssize_t ret;
 
-	if (!(file->f_mode & FMODE_READ))
+	if (unlikely(!(file->f_mode & FMODE_READ)))
 		return -EBADF;
-	if (!file->f_op || (!file->f_op->read && !file->f_op->aio_read))
+	if (unlikely(!file->f_op ||
+		     (!file->f_op->read && !file->f_op->aio_read)))
 		return -EINVAL;
 
 	ret = locks_verify_area(FLOCK_VERIFY_READ, inode, file, *pos, count);
@@ -198,7 +214,8 @@ ssize_t vfs_read(struct file *file, char
 			if (file->f_op->read)
 				ret = file->f_op->read(file, buf, count, pos);
 			else
-				ret = do_sync_read(file, buf, count, pos);
+				ret = do_sync_rw(file, buf, count, pos,
+						 file->f_op->aio_read, READ);
 			if (ret > 0)
 				dnotify_parent(file->f_dentry, DN_ACCESS);
 		}
@@ -207,28 +224,15 @@ ssize_t vfs_read(struct file *file, char
 	return ret;
 }
 
-ssize_t do_sync_write(struct file *filp, const char *buf, size_t len, loff_t *ppos)
-{
-	struct kiocb kiocb;
-	ssize_t ret;
-
-	init_sync_kiocb(&kiocb, filp);
-	kiocb.ki_pos = *ppos;
-	ret = filp->f_op->aio_write(&kiocb, buf, len, kiocb.ki_pos);
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&kiocb);
-	*ppos = kiocb.ki_pos;
-	return ret;
-}
-
 ssize_t vfs_write(struct file *file, const char *buf, size_t count, loff_t *pos)
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	ssize_t ret;
 
-	if (!(file->f_mode & FMODE_WRITE))
+	if (unlikely(!(file->f_mode & FMODE_WRITE)))
 		return -EBADF;
-	if (!file->f_op || (!file->f_op->write && !file->f_op->aio_write))
+	if (unlikely(!file->f_op ||
+		     (!file->f_op->write && !file->f_op->aio_write)))
 		return -EINVAL;
 
 	ret = locks_verify_area(FLOCK_VERIFY_WRITE, inode, file, *pos, count);
@@ -238,7 +242,8 @@ ssize_t vfs_write(struct file *file, con
 			if (file->f_op->write)
 				ret = file->f_op->write(file, buf, count, pos);
 			else
-				ret = do_sync_write(file, buf, count, pos);
+				ret = do_sync_rw(file, (char *)buf, count, pos,
+						 file->f_op->aio_write, WRITE);
 			if (ret > 0)
 				dnotify_parent(file->f_dentry, DN_MODIFY);
 		}
@@ -331,29 +336,58 @@ unsigned long iov_shorten(struct iovec *
 	return seg;
 }
 
-static ssize_t do_readv_writev(int type, struct file *file,
+ssize_t compat_rwv(struct file *file, const struct iovec *vector,
+		   unsigned long nr_segs, loff_t *ppos,
+		   ssize_t (*fn)(struct file *, char *, size_t, loff_t *))
+{
+	ssize_t ret = 0;
+
+	if (NULL == fn)
+		return -EINVAL;
+
+	/* Do it by hand, with file-ops */
+	for (; nr_segs > 0; vector++, nr_segs--) {
+		void *base = vector->iov_base;
+		size_t len = vector->iov_len;
+		ssize_t nr = fn(file, base, len, ppos);
+
+		if (nr < 0) {
+			if (!ret)
+				ret = nr;
+			break;
+		}
+		ret += nr;
+		if (nr != len)
+			break;
+	}
+	return ret;
+}
+
+static ssize_t do_readv_writev(int fmode, int type, struct file *file,
 			       const struct iovec * vector,
 			       unsigned long nr_segs, loff_t *pos)
 {
 	typedef ssize_t (*io_fn_t)(struct file *, char *, size_t, loff_t *);
 	typedef ssize_t (*iov_fn_t)(struct file *, const struct iovec *, unsigned long, loff_t *);
+	typedef ssize_t (*ioa_fn_t)(struct rw_iocb *);
 
-	size_t tot_len;
+	size_t tot_len = 0;
 	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov=iovstack;
-	ssize_t ret;
+	struct iovec *iov = iovstack;
+	ssize_t ret = 0;
 	int seg;
 	io_fn_t fn;
 	iov_fn_t fnv;
-	struct inode *inode;
+	ioa_fn_t fna;
 
+	if (!(file->f_mode & fmode))
+		return -EBADF;
 	/*
 	 * SuS says "The readv() function *may* fail if the iovcnt argument
 	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
 	 * traditionally returned zero for zero segments, so...
 	 */
-	ret = 0;
-	if (nr_segs == 0)
+	if (unlikely(nr_segs == 0))
 		goto out;
 
 	/*
@@ -365,6 +399,7 @@ static ssize_t do_readv_writev(int type,
 		goto out;
 	if (!file->f_op)
 		goto out;
+
 	if (nr_segs > UIO_FASTIOV) {
 		ret = -ENOMEM;
 		iov = kmalloc(nr_segs*sizeof(struct iovec), GFP_KERNEL);
@@ -382,7 +417,6 @@ static ssize_t do_readv_writev(int type,
 	 *
 	 * Be careful here because iov_len is a size_t not an ssize_t
 	 */
-	tot_len = 0;
 	ret = -EINVAL;
 	for (seg = 0 ; seg < nr_segs; seg++) {
 		ssize_t tmp = tot_len;
@@ -393,55 +427,32 @@ static ssize_t do_readv_writev(int type,
 		if (tot_len < tmp) /* maths overflow on the ssize_t */
 			goto out;
 	}
-	if (tot_len == 0) {
-		ret = 0;
+	ret = 0;
+	if (tot_len == 0)
 		goto out;
-	}
 
-	inode = file->f_dentry->d_inode;
 	/* VERIFY_WRITE actually means a read, as we write to user space */
 	ret = locks_verify_area((type == READ 
 				 ? FLOCK_VERIFY_READ : FLOCK_VERIFY_WRITE),
-				inode, file, *pos, tot_len);
+				file->f_dentry->d_inode, file, *pos, tot_len);
 	if (ret)
 		goto out;
 
-	fnv = NULL;
 	if (type == READ) {
 		fn = file->f_op->read;
 		fnv = file->f_op->readv;
+		fna = file->f_op->aio_read;
 	} else {
 		fn = (io_fn_t)file->f_op->write;
 		fnv = file->f_op->writev;
+		fna = file->f_op->aio_write;
 	}
-	if (fnv) {
+	if (fnv)
 		ret = fnv(file, iov, nr_segs, pos);
-		goto out;
-	}
-
-	/* Do it by hand, with file-ops */
-	ret = 0;
-	vector = iov;
-	while (nr_segs > 0) {
-		void * base;
-		size_t len;
-		ssize_t nr;
-
-		base = vector->iov_base;
-		len = vector->iov_len;
-		vector++;
-		nr_segs--;
-
-		nr = fn(file, base, len, pos);
-
-		if (nr < 0) {
-			if (!ret) ret = nr;
-			break;
-		}
-		ret += nr;
-		if (nr != len)
-			break;
-	}
+	else if (fna)
+		ret = do_sync_rwv(file, NULL, tot_len, iov, nr_segs, pos, fna, type);
+	else
+		ret = compat_rwv(file, iov, nr_segs, pos, fn);
 out:
 	if (iov != iovstack)
 		kfree(iov);
@@ -454,23 +465,13 @@ out:
 ssize_t vfs_readv(struct file *file, const struct iovec *vec,
 		  unsigned long vlen, loff_t *pos)
 {
-	if (!(file->f_mode & FMODE_READ))
-		return -EBADF;
-	if (!file->f_op || (!file->f_op->readv && !file->f_op->read))
-		return -EINVAL;
-
-	return do_readv_writev(READ, file, vec, vlen, pos);
+	return do_readv_writev(FMODE_READ, READ, file, vec, vlen, pos);
 }
 
 ssize_t vfs_writev(struct file *file, const struct iovec *vec,
 		   unsigned long vlen, loff_t *pos)
 {
-	if (!(file->f_mode & FMODE_WRITE))
-		return -EBADF;
-	if (!file->f_op || (!file->f_op->writev && !file->f_op->write))
-		return -EINVAL;
-
-	return do_readv_writev(WRITE, file, vec, vlen, pos);
+	return do_readv_writev(FMODE_WRITE, WRITE, file, vec, vlen, pos);
 }
 
 
@@ -622,5 +623,4 @@ asmlinkage ssize_t sys_sendfile64(int ou
 	return do_sendfile(out_fd, in_fd, NULL, count, 0);
 }
 
-EXPORT_SYMBOL(do_sync_read);
-EXPORT_SYMBOL(do_sync_write);
+EXPORT_SYMBOL(do_sync_rw);
diff -purN linux-2.5/fs/reiserfs/file.c aio-2.5/fs/reiserfs/file.c
--- linux-2.5/fs/reiserfs/file.c	Tue Apr  1 15:17:56 2003
+++ aio-2.5/fs/reiserfs/file.c	Mon Mar 24 11:25:01 2003
@@ -141,8 +141,8 @@ out:
 }
 
 struct file_operations reiserfs_file_operations = {
-    .read	= generic_file_read,
-    .write	= generic_file_write,
+    .aio_read	= generic_file_aio_read,
+    .aio_write	= generic_file_aio_write,
     .ioctl	= reiserfs_ioctl,
     .mmap	= generic_file_mmap,
     .release	= reiserfs_file_release,
diff -purN linux-2.5/fs/smbfs/file.c aio-2.5/fs/smbfs/file.c
--- linux-2.5/fs/smbfs/file.c	Tue Apr  1 15:17:56 2003
+++ aio-2.5/fs/smbfs/file.c	Mon Mar 24 11:46:18 2003
@@ -216,13 +216,13 @@ smb_updatepage(struct file *file, struct
 }
 
 static ssize_t
-smb_file_read(struct file * file, char * buf, size_t count, loff_t *ppos)
+smb_file_read(struct kiocb *iocb, char *buf, size_t count, loff_t pos)
 {
-	struct dentry * dentry = file->f_dentry;
+	struct dentry * dentry = iocb->ki_filp->f_dentry;
 	ssize_t	status;
 
 	VERBOSE("file %s/%s, count=%lu@%lu\n", DENTRY_PATH(dentry),
-		(unsigned long) count, (unsigned long) *ppos);
+		(unsigned long) count, (unsigned long) pos);
 
 	status = smb_revalidate_inode(dentry);
 	if (status) {
@@ -235,7 +235,7 @@ smb_file_read(struct file * file, char *
 		(long)dentry->d_inode->i_size,
 		dentry->d_inode->i_flags, dentry->d_inode->i_atime);
 
-	status = generic_file_read(file, buf, count, ppos);
+	status = generic_file_aio_read(iocb, buf, count, pos);
 out:
 	return status;
 }
@@ -298,14 +298,14 @@ struct address_space_operations smb_file
  * Write to a file (through the page cache).
  */
 static ssize_t
-smb_file_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+smb_file_write(struct kiocb *iocb, const char *buf, size_t count, loff_t pos)
 {
-	struct dentry * dentry = file->f_dentry;
+	struct dentry * dentry = iocb->ki_filp->f_dentry;
 	ssize_t	result;
 
 	VERBOSE("file %s/%s, count=%lu@%lu\n",
 		DENTRY_PATH(dentry),
-		(unsigned long) count, (unsigned long) *ppos);
+		(unsigned long) count, (unsigned long) pos);
 
 	result = smb_revalidate_inode(dentry);
 	if (result) {
@@ -319,7 +319,7 @@ smb_file_write(struct file *file, const 
 		goto out;
 
 	if (count > 0) {
-		result = generic_file_write(file, buf, count, ppos);
+		result = generic_file_aio_write(iocb, buf, count, pos);
 		VERBOSE("pos=%ld, size=%ld, mtime=%ld, atime=%ld\n",
 			(long) file->f_pos, (long) dentry->d_inode->i_size,
 			dentry->d_inode->i_mtime, dentry->d_inode->i_atime);
@@ -384,8 +384,8 @@ smb_file_permission(struct inode *inode,
 struct file_operations smb_file_operations =
 {
 	.llseek		= remote_llseek,
-	.read		= smb_file_read,
-	.write		= smb_file_write,
+	.aio_read	= smb_file_read,
+	.aio_write	= smb_file_write,
 	.ioctl		= smb_ioctl,
 	.mmap		= smb_file_mmap,
 	.open		= smb_file_open,
diff -purN linux-2.5/fs/sysv/file.c aio-2.5/fs/sysv/file.c
--- linux-2.5/fs/sysv/file.c	Tue Apr  1 15:17:57 2003
+++ aio-2.5/fs/sysv/file.c	Mon Mar 24 11:25:05 2003
@@ -21,8 +21,8 @@
  */
 struct file_operations sysv_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.fsync		= sysv_sync_file,
 	.sendfile	= generic_file_sendfile,
diff -purN linux-2.5/fs/udf/file.c aio-2.5/fs/udf/file.c
--- linux-2.5/fs/udf/file.c	Tue Apr  1 15:17:57 2003
+++ aio-2.5/fs/udf/file.c	Mon Mar 24 11:25:05 2003
@@ -109,19 +109,17 @@ struct address_space_operations udf_adin
 	.commit_write		= udf_adinicb_commit_write,
 };
 
-static ssize_t udf_file_write(struct file * file, const char * buf,
-	size_t count, loff_t *ppos)
+static ssize_t udf_file_write(struct kiocb *iocb, const char * buf,
+			      size_t count, loff_t pos)
 {
 	ssize_t retval;
-	struct inode *inode = file->f_dentry->d_inode;
-	int err, pos;
+	struct inode *inode = iocb->ki_filp->f_dentry->d_inode;
+	int err;
 
 	if (UDF_I_ALLOCTYPE(inode) == ICBTAG_FLAG_AD_IN_ICB)
 	{
-		if (file->f_flags & O_APPEND)
+		if (iocb->ki_filp->f_flags & O_APPEND)
 			pos = inode->i_size;
-		else
-			pos = *ppos;
 
 		if (inode->i_sb->s_blocksize < (udf_file_entry_alloc_offset(inode) +
 			pos + count))
@@ -142,7 +140,7 @@ static ssize_t udf_file_write(struct fil
 		}
 	}
 
-	retval = generic_file_write(file, buf, count, ppos);
+	retval = generic_file_aio_write(iocb, buf, count, pos);
 
 	if (retval > 0)
 		mark_inode_dirty(inode);
@@ -275,11 +273,11 @@ static int udf_open_file(struct inode * 
 }
 
 struct file_operations udf_file_operations = {
-	.read			= generic_file_read,
+	.aio_read		= generic_file_aio_read,
+	.aio_write		= udf_file_write,
 	.ioctl			= udf_ioctl,
 	.open			= udf_open_file,
 	.mmap			= generic_file_mmap,
-	.write			= udf_file_write,
 	.release		= udf_release_file,
 	.fsync			= udf_fsync_file,
 	.sendfile		= generic_file_sendfile,
diff -purN linux-2.5/fs/ufs/file.c aio-2.5/fs/ufs/file.c
--- linux-2.5/fs/ufs/file.c	Tue Apr  1 15:17:57 2003
+++ aio-2.5/fs/ufs/file.c	Mon Mar 24 11:25:05 2003
@@ -43,8 +43,8 @@
  
 struct file_operations ufs_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read		= generic_file_read,
-	.write		= generic_file_write,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= generic_file_aio_write,
 	.mmap		= generic_file_mmap,
 	.open           = generic_file_open,
 	.sendfile	= generic_file_sendfile,
diff -purN linux-2.5/include/linux/aio.h aio-2.5/include/linux/aio.h
--- linux-2.5/include/linux/aio.h	Tue Apr  1 15:18:08 2003
+++ aio-2.5/include/linux/aio.h	Tue Mar 25 15:35:56 2003
@@ -4,6 +4,7 @@
 #include <linux/list.h>
 #include <linux/workqueue.h>
 #include <linux/aio_abi.h>
+#include <linux/uio.h>
 
 #include <asm/atomic.h>
 
@@ -61,22 +62,68 @@ struct kiocb {
 
 	void			*ki_user_obj;	/* pointer to userland's iocb */
 	__u64			ki_user_data;	/* user's data for completion */
-	loff_t			ki_pos;
 
-	char			private[KIOCB_PRIVATE_SIZE];
+	long			private[0];	/* KIOCB_PRIVATE_SIZE alloc'd */
 };
 
-#define is_sync_kiocb(iocb)	((iocb)->ki_key == KIOCB_SYNC_KEY)
+struct rw_iocb {
+	struct kiocb	kiocb;
+	loff_t		rw_pos;
+	unsigned long	rw_nsegs;
+
+	struct iovec	*rw_iov;
+	struct iovec	rw_local_iov;
+
+	unsigned	rw : 2,			/* READ or WRITE */
+			rw_have_i_sem : 1;	/* true if we hold i_sem */
+};
+
+struct fsync_iocb {
+	struct kiocb	kiocb;
+	unsigned	dsync;
+};
+
+struct sync_iocb {
+	union {
+	struct kiocb		kiocb;
+	struct rw_iocb		rw_iocb;
+	struct fsync_iocb	fsync_iocb;
+	};
+	char		private[KIOCB_PRIVATE_SIZE];
+};
+
+typedef union {
+	struct kiocb		kiocb;
+	struct rw_iocb		rw_iocb;
+	struct sync_iocb	sync_iocb;
+} iocb_t;
+
+static inline struct rw_iocb *kiocb_to_rw_iocb(struct kiocb *iocb)
+{
+	return (struct rw_iocb *)iocb;
+}
+
+static inline struct fsync_iocb *kiocb_to_fsync_iocb(struct kiocb *iocb)
+{
+	return (struct fsync_iocb *)iocb;
+}
+
+static inline int is_sync_kiocb(struct kiocb *iocb)
+{
+	return iocb->ki_key == KIOCB_SYNC_KEY;
+}
+
 #define init_sync_kiocb(x, filp)			\
 	do {						\
+		struct kiocb *__iocb = (x);		\
 		struct task_struct *tsk = current;	\
-		(x)->ki_flags = 0;			\
-		(x)->ki_users = 1;			\
-		(x)->ki_key = KIOCB_SYNC_KEY;		\
-		(x)->ki_filp = (filp);			\
-		(x)->ki_ctx = &tsk->active_mm->default_kioctx;	\
-		(x)->ki_cancel = NULL;			\
-		(x)->ki_user_obj = tsk;			\
+		__iocb->ki_flags = 0;			\
+		__iocb->ki_users = 1;			\
+		__iocb->ki_key = KIOCB_SYNC_KEY;	\
+		__iocb->ki_filp = (filp);		\
+		__iocb->ki_ctx = &tsk->active_mm->default_kioctx;\
+		__iocb->ki_cancel = NULL;		\
+		__iocb->ki_user_obj = tsk;		\
 	} while (0)
 
 #define AIO_RING_MAGIC			0xa10a10a1
diff -purN linux-2.5/include/linux/fs.h aio-2.5/include/linux/fs.h
--- linux-2.5/include/linux/fs.h	Tue Mar 25 16:38:50 2003
+++ aio-2.5/include/linux/fs.h	Tue Mar 25 15:29:13 2003
@@ -21,6 +21,8 @@
 #include <linux/kobject.h>
 #include <asm/atomic.h>
 
+struct rw_iocb;
+struct fsync_iocb;
 struct iovec;
 struct nameidata;
 struct pipe_inode_info;
@@ -305,7 +307,7 @@ struct address_space_operations {
 	sector_t (*bmap)(struct address_space *, sector_t);
 	int (*invalidatepage) (struct page *, unsigned long);
 	int (*releasepage) (struct page *, int);
-	int (*direct_IO)(int, struct kiocb *, const struct iovec *iov,
+	int (*direct_IO)(int, struct rw_iocb *, const struct iovec *iov,
 			loff_t offset, unsigned long nr_segs);
 };
 
@@ -706,9 +708,9 @@ struct file_operations {
 	struct module *owner;
 	loff_t (*llseek) (struct file *, loff_t, int);
 	ssize_t (*read) (struct file *, char *, size_t, loff_t *);
-	ssize_t (*aio_read) (struct kiocb *, char *, size_t, loff_t);
+	ssize_t (*aio_read) (struct rw_iocb *);
 	ssize_t (*write) (struct file *, const char *, size_t, loff_t *);
-	ssize_t (*aio_write) (struct kiocb *, const char *, size_t, loff_t);
+	ssize_t (*aio_write) (struct rw_iocb *);
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
@@ -717,7 +719,7 @@ struct file_operations {
 	int (*flush) (struct file *);
 	int (*release) (struct inode *, struct file *);
 	int (*fsync) (struct file *, struct dentry *, int datasync);
-	int (*aio_fsync) (struct kiocb *, int datasync);
+	int (*aio_fsync) (struct fsync_iocb *);
 	int (*fasync) (int, struct file *, int);
 	int (*lock) (struct file *, int, struct file_lock *);
 	ssize_t (*readv) (struct file *, const struct iovec *, unsigned long, loff_t *);
@@ -1200,32 +1202,22 @@ extern int generic_file_mmap(struct file
 extern int generic_file_readonly_mmap(struct file *, struct vm_area_struct *);
 extern int file_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
 extern int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size);
-extern ssize_t generic_file_read(struct file *, char *, size_t, loff_t *);
 int generic_write_checks(struct inode *inode, struct file *file,
 			loff_t *pos, size_t *count, int isblk);
-extern ssize_t generic_file_write(struct file *, const char *, size_t, loff_t *);
-extern ssize_t generic_file_aio_read(struct kiocb *, char *, size_t, loff_t);
-extern ssize_t generic_file_aio_write(struct kiocb *, const char *, size_t, loff_t);
-extern ssize_t generic_file_aio_write_nolock(struct kiocb *, const struct iovec *,
-				unsigned long, loff_t *);
-extern ssize_t do_sync_read(struct file *filp, char *buf, size_t len, loff_t *ppos);
-extern ssize_t do_sync_write(struct file *filp, const char *buf, size_t len, loff_t *ppos);
-ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos);
+extern ssize_t generic_file_aio_read(struct rw_iocb *);
+extern ssize_t generic_file_aio_write(struct rw_iocb *);
+extern ssize_t generic_file_aio_write_nolock(struct rw_iocb *);
+extern ssize_t FASTCALL(do_sync_rw(struct file *filp, char *buf, size_t len, loff_t *ppos, ssize_t (*op)(struct rw_iocb *), int type));
 extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void *);
 extern void do_generic_mapping_read(struct address_space *, struct file_ra_state *, struct file *,
 				    loff_t *, read_descriptor_t *, read_actor_t);
 extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
-extern ssize_t generic_file_direct_IO(int rw, struct kiocb *iocb,
+extern ssize_t generic_file_direct_IO(int rw, struct rw_iocb *iocb,
 	const struct iovec *iov, loff_t offset, unsigned long nr_segs);
-extern int blockdev_direct_IO(int rw, struct kiocb *iocb, struct inode *inode, 
+extern int blockdev_direct_IO(int rw, struct rw_iocb *iocb, struct inode *inode, 
 	struct block_device *bdev, const struct iovec *iov, loff_t offset, 
 	unsigned long nr_segs, get_blocks_t *get_blocks);
-extern ssize_t generic_file_readv(struct file *filp, const struct iovec *iov, 
-	unsigned long nr_segs, loff_t *ppos);
-ssize_t generic_file_writev(struct file *filp, const struct iovec *iov, 
-			unsigned long nr_segs, loff_t *ppos);
 extern loff_t no_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t generic_file_llseek(struct file *file, loff_t offset, int origin);
 extern loff_t remote_llseek(struct file *file, loff_t offset, int origin);
diff -purN linux-2.5/include/net/sock.h aio-2.5/include/net/sock.h
--- linux-2.5/include/net/sock.h	Tue Apr  1 15:18:12 2003
+++ aio-2.5/include/net/sock.h	Mon Mar 24 17:26:21 2003
@@ -302,6 +302,7 @@ static __inline__ void sock_prot_dec_use
 
 /* sock_iocb: used to kick off async processing of socket ios */
 struct sock_iocb {
+	struct rw_iocb		iocb;
 	struct list_head	list;
 
 	int			flags;
@@ -310,18 +311,23 @@ struct sock_iocb {
 	struct sock		*sk;
 	struct scm_cookie	*scm;
 	struct msghdr		*msg, async_msg;
-	struct iovec		async_iov;
 };
 
 static inline struct sock_iocb *kiocb_to_siocb(struct kiocb *iocb)
 {
-	BUG_ON(sizeof(struct sock_iocb) > KIOCB_PRIVATE_SIZE);
-	return (struct sock_iocb *)iocb->private;
+	BUG_ON(sizeof(struct sock_iocb) > sizeof(iocb_t));
+	return (struct sock_iocb *)iocb;
+}
+
+static inline struct sock_iocb *rw_iocb_to_siocb(struct rw_iocb *iocb)
+{
+	BUG_ON(sizeof(struct sock_iocb) > sizeof(iocb_t));
+	return (struct sock_iocb *)iocb;
 }
 
 static inline struct kiocb *siocb_to_kiocb(struct sock_iocb *si)
 {
-	return container_of((void *)si, struct kiocb, private);
+	return &si->iocb.kiocb;
 }
 
 struct socket_alloc {
diff -purN linux-2.5/kernel/ksyms.c aio-2.5/kernel/ksyms.c
--- linux-2.5/kernel/ksyms.c	Tue Apr  1 15:18:13 2003
+++ aio-2.5/kernel/ksyms.c	Mon Mar 24 12:13:45 2003
@@ -226,12 +226,9 @@ EXPORT_SYMBOL(cont_prepare_write);
 EXPORT_SYMBOL(generic_commit_write);
 EXPORT_SYMBOL(block_truncate_page);
 EXPORT_SYMBOL(generic_block_bmap);
-EXPORT_SYMBOL(generic_file_read);
 EXPORT_SYMBOL(generic_file_sendfile);
 EXPORT_SYMBOL(do_generic_mapping_read);
 EXPORT_SYMBOL(file_ra_state_init);
-EXPORT_SYMBOL(generic_file_write);
-EXPORT_SYMBOL(generic_file_write_nolock);
 EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_file_readonly_mmap);
 EXPORT_SYMBOL(generic_ro_fops);
@@ -356,8 +353,6 @@ EXPORT_SYMBOL(ioctl_by_bdev);
 EXPORT_SYMBOL(read_dev_sector);
 EXPORT_SYMBOL(init_buffer);
 EXPORT_SYMBOL_GPL(generic_file_direct_IO);
-EXPORT_SYMBOL(generic_file_readv);
-EXPORT_SYMBOL(generic_file_writev);
 EXPORT_SYMBOL(iov_shorten);
 EXPORT_SYMBOL_GPL(default_backing_dev_info);
 
diff -purN linux-2.5/mm/filemap.c aio-2.5/mm/filemap.c
--- linux-2.5/mm/filemap.c	Tue Apr  1 15:18:14 2003
+++ aio-2.5/mm/filemap.c	Mon Mar 24 17:24:19 2003
@@ -711,18 +711,16 @@ success:
  * This is the "read()" routine for all filesystems
  * that can use the page cache directly.
  */
-static ssize_t
-__generic_file_aio_read(struct kiocb *iocb, const struct iovec *iov,
-		unsigned long nr_segs, loff_t *ppos)
+ssize_t generic_file_aio_read(struct rw_iocb *iocb)
 {
-	struct file *filp = iocb->ki_filp;
+	struct file *filp = iocb->kiocb.ki_filp;
 	ssize_t retval;
-	unsigned long seg;
+	unsigned long seg, nr_segs = iocb->rw_nsegs;
 	size_t count;
 
 	count = 0;
 	for (seg = 0; seg < nr_segs; seg++) {
-		const struct iovec *iv = &iov[seg];
+		const struct iovec *iv = &iocb->rw_iov[seg];
 
 		/*
 		 * If any segment has a negative length, or the cumulative
@@ -742,7 +740,7 @@ __generic_file_aio_read(struct kiocb *io
 
 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
 	if (filp->f_flags & O_DIRECT) {
-		loff_t pos = *ppos, size;
+		loff_t pos = iocb->rw_pos, size;
 		struct address_space *mapping;
 		struct inode *inode;
 
@@ -754,11 +752,11 @@ __generic_file_aio_read(struct kiocb *io
 		size = inode->i_size;
 		if (pos < size) {
 			retval = generic_file_direct_IO(READ, iocb,
-						iov, pos, nr_segs);
-			if (retval >= 0 && !is_sync_kiocb(iocb))
+						iocb->rw_iov, pos, nr_segs);
+			if (retval >= 0 && !is_sync_kiocb(&iocb->kiocb))
 				retval = -EIOCBQUEUED;
 			if (retval > 0)
-				*ppos = pos + retval;
+				iocb->rw_pos = pos + retval;
 		}
 		UPDATE_ATIME(filp->f_dentry->d_inode);
 		goto out;
@@ -770,12 +768,12 @@ __generic_file_aio_read(struct kiocb *io
 			read_descriptor_t desc;
 
 			desc.written = 0;
-			desc.buf = iov[seg].iov_base;
-			desc.count = iov[seg].iov_len;
+			desc.buf = iocb->rw_iov[seg].iov_base;
+			desc.count = iocb->rw_iov[seg].iov_len;
 			if (desc.count == 0)
 				continue;
 			desc.error = 0;
-			do_generic_file_read(filp,ppos,&desc,file_read_actor);
+			do_generic_file_read(filp,&iocb->rw_pos,&desc,file_read_actor);
 			retval += desc.written;
 			if (!retval) {
 				retval = desc.error;
@@ -787,30 +785,8 @@ out:
 	return retval;
 }
 
-ssize_t
-generic_file_aio_read(struct kiocb *iocb, char *buf, size_t count, loff_t pos)
-{
-	struct iovec local_iov = { .iov_base = buf, .iov_len = count };
-
-	BUG_ON(iocb->ki_pos != pos);
-	return __generic_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
-}
 EXPORT_SYMBOL(generic_file_aio_read);
 
-ssize_t
-generic_file_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
-{
-	struct iovec local_iov = { .iov_base = buf, .iov_len = count };
-	struct kiocb kiocb;
-	ssize_t ret;
-
-	init_sync_kiocb(&kiocb, filp);
-	ret = __generic_file_aio_read(&kiocb, &local_iov, 1, ppos);
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&kiocb);
-	return ret;
-}
-
 int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
 {
 	ssize_t written;
@@ -1572,11 +1548,9 @@ EXPORT_SYMBOL(generic_write_checks);
  * it for writing by marking it dirty.
  *							okir@monad.swb.de
  */
-ssize_t
-generic_file_aio_write_nolock(struct kiocb *iocb, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos)
+ssize_t generic_file_aio_write_nolock(struct rw_iocb *iocb)
 {
-	struct file *file = iocb->ki_filp;
+	struct file *file = iocb->kiocb.ki_filp;
 	struct address_space * mapping = file->f_dentry->d_inode->i_mapping;
 	struct address_space_operations *a_ops = mapping->a_ops;
 	size_t ocount;		/* original count */
@@ -1591,14 +1565,14 @@ generic_file_aio_write_nolock(struct kio
 	ssize_t		err;
 	size_t		bytes;
 	struct pagevec	lru_pvec;
-	const struct iovec *cur_iov = iov; /* current iovec */
+	const struct iovec *cur_iov = iocb->rw_iov; /* current iovec */
 	size_t		iov_base = 0;	   /* offset in the current iovec */
-	unsigned long	seg;
+	unsigned long	seg, nr_segs = iocb->rw_nsegs;
 	char		*buf;
 
 	ocount = 0;
 	for (seg = 0; seg < nr_segs; seg++) {
-		const struct iovec *iv = &iov[seg];
+		const struct iovec *iv = &iocb->rw_iov[seg];
 
 		/*
 		 * If any segment has a negative length, or the cumulative
@@ -1617,7 +1591,7 @@ generic_file_aio_write_nolock(struct kio
 	}
 
 	count = ocount;
-	pos = *ppos;
+	pos = iocb->rw_pos;
 	pagevec_init(&lru_pvec, 0);
 
 	/* We can write back this queue in page reclaim */
@@ -1638,17 +1612,17 @@ generic_file_aio_write_nolock(struct kio
 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
 	if (unlikely(file->f_flags & O_DIRECT)) {
 		if (count != ocount)
-			nr_segs = iov_shorten((struct iovec *)iov,
+			nr_segs = iov_shorten(iocb->rw_iov,
 						nr_segs, count);
 		written = generic_file_direct_IO(WRITE, iocb,
-					iov, pos, nr_segs);
+					iocb->rw_iov, pos, nr_segs);
 		if (written > 0) {
 			loff_t end = pos + written;
 			if (end > inode->i_size && !isblk) {
 				inode->i_size = end;
 				mark_inode_dirty(inode);
 			}
-			*ppos = end;
+			iocb->rw_pos = end;
 		}
 		/*
 		 * Sync the fs metadata but not the minor inode changes and
@@ -1656,12 +1630,12 @@ generic_file_aio_write_nolock(struct kio
 		 */
 		if (written >= 0 && file->f_flags & O_SYNC)
 			status = generic_osync_inode(inode, OSYNC_METADATA);
-		if (written >= 0 && !is_sync_kiocb(iocb))
+		if (written >= 0 && !is_sync_kiocb(&iocb->kiocb))
 			written = -EIOCBQUEUED;
 		goto out_status;
 	}
 
-	buf = iov->iov_base;
+	buf = iocb->rw_iov->iov_base;
 	do {
 		unsigned long index;
 		unsigned long offset;
@@ -1732,7 +1706,7 @@ generic_file_aio_write_nolock(struct kio
 		balance_dirty_pages_ratelimited(mapping);
 		cond_resched();
 	} while (count);
-	*ppos = pos;
+	iocb->rw_pos = pos;
 
 	if (cached_page)
 		page_cache_release(cached_page);
@@ -1754,84 +1728,23 @@ out:
 	return err;
 }
 
-ssize_t
-generic_file_write_nolock(struct file *file, const struct iovec *iov,
-				unsigned long nr_segs, loff_t *ppos)
-{
-	struct kiocb kiocb;
-	ssize_t ret;
-
-	init_sync_kiocb(&kiocb, file);
-	ret = generic_file_aio_write_nolock(&kiocb, iov, nr_segs, ppos);
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&kiocb);
-	return ret;
-}
-
-ssize_t generic_file_aio_write(struct kiocb *iocb, const char *buf,
-			       size_t count, loff_t pos)
+ssize_t generic_file_aio_write(struct rw_iocb *iocb)
 {
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 	ssize_t err;
-	struct iovec local_iov = { .iov_base = (void *)buf, .iov_len = count };
-
-	BUG_ON(iocb->ki_pos != pos);
-
-	down(&inode->i_sem);
-	err = generic_file_aio_write_nolock(iocb, &local_iov, 1, 
-						&iocb->ki_pos);
-	up(&inode->i_sem);
 
+	down(&iocb->kiocb.ki_filp->f_dentry->d_inode->i_sem);
+	err = generic_file_aio_write_nolock(iocb);
+	up(&iocb->kiocb.ki_filp->f_dentry->d_inode->i_sem);
 	return err;
 }
 EXPORT_SYMBOL(generic_file_aio_write);
 EXPORT_SYMBOL(generic_file_aio_write_nolock);
 
-ssize_t generic_file_write(struct file *file, const char *buf,
-			   size_t count, loff_t *ppos)
-{
-	struct inode	*inode = file->f_dentry->d_inode->i_mapping->host;
-	ssize_t		err;
-	struct iovec local_iov = { .iov_base = (void *)buf, .iov_len = count };
-
-	down(&inode->i_sem);
-	err = generic_file_write_nolock(file, &local_iov, 1, ppos);
-	up(&inode->i_sem);
-
-	return err;
-}
-
-ssize_t generic_file_readv(struct file *filp, const struct iovec *iov,
-			unsigned long nr_segs, loff_t *ppos)
-{
-	struct kiocb kiocb;
-	ssize_t ret;
-
-	init_sync_kiocb(&kiocb, filp);
-	ret = __generic_file_aio_read(&kiocb, iov, nr_segs, ppos);
-	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&kiocb);
-	return ret;
-}
-
-ssize_t generic_file_writev(struct file *file, const struct iovec *iov,
-			unsigned long nr_segs, loff_t * ppos) 
-{
-	struct inode *inode = file->f_dentry->d_inode;
-	ssize_t ret;
-
-	down(&inode->i_sem);
-	ret = generic_file_write_nolock(file, iov, nr_segs, ppos);
-	up(&inode->i_sem);
-	return ret;
-}
-
 ssize_t
-generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
+generic_file_direct_IO(int rw, struct rw_iocb *iocb, const struct iovec *iov,
 	loff_t offset, unsigned long nr_segs)
 {
-	struct file *file = iocb->ki_filp;
+	struct file *file = iocb->kiocb.ki_filp;
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
 	ssize_t retval;
 
diff -purN linux-2.5/net/socket.c aio-2.5/net/socket.c
--- linux-2.5/net/socket.c	Tue Apr  1 15:18:19 2003
+++ aio-2.5/net/socket.c	Tue Mar 25 14:29:33 2003
@@ -95,10 +95,8 @@
 #include <linux/netfilter.h>
 
 static int sock_no_open(struct inode *irrelevant, struct file *dontcare);
-static ssize_t sock_aio_read(struct kiocb *iocb, char *buf,
-			 size_t size, loff_t pos);
-static ssize_t sock_aio_write(struct kiocb *iocb, const char *buf,
-			  size_t size, loff_t pos);
+static ssize_t sock_aio_read(struct rw_iocb *iocb);
+static ssize_t sock_aio_write(struct rw_iocb *iocb);
 static int sock_mmap(struct file *file, struct vm_area_struct * vma);
 
 static int sock_close(struct inode *inode, struct file *file);
@@ -528,6 +526,7 @@ static inline int __sock_sendmsg(struct 
 	si->scm = NULL;
 	si->msg = msg;
 	si->size = size;
+	si->flags = 0;
 
 	err = security_socket_sendmsg(sock, msg, size);
 	if (err)
@@ -538,13 +537,14 @@ static inline int __sock_sendmsg(struct 
 
 int sock_sendmsg(struct socket *sock, struct msghdr *msg, int size)
 {
-	struct kiocb iocb;
+	struct sync_iocb iocb;
 	int ret;
 
-	init_sync_kiocb(&iocb, NULL);
-	ret = __sock_sendmsg(&iocb, sock, msg, size);
+	init_sync_kiocb(&iocb.kiocb, NULL);
+	
+	ret = __sock_sendmsg(&iocb.kiocb, sock, msg, size);
 	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&iocb);
+		ret = wait_on_sync_kiocb(&iocb.kiocb);
 	return ret;
 }
 
@@ -569,13 +569,13 @@ static inline int __sock_recvmsg(struct 
 
 int sock_recvmsg(struct socket *sock, struct msghdr *msg, int size, int flags)
 {
-	struct kiocb iocb;
+	struct sync_iocb iocb;
 	int ret;
 
-        init_sync_kiocb(&iocb, NULL);
-	ret = __sock_recvmsg(&iocb, sock, msg, size, flags);
+        init_sync_kiocb(&iocb.kiocb, NULL);
+	ret = __sock_recvmsg(&iocb.kiocb, sock, msg, size, flags);
 	if (-EIOCBQUEUED == ret)
-		ret = wait_on_sync_kiocb(&iocb);
+		ret = wait_on_sync_kiocb(&iocb.kiocb);
 	return ret;
 }
 
@@ -584,31 +584,29 @@ int sock_recvmsg(struct socket *sock, st
  *	area ubuf...ubuf+size-1 is writable before asking the protocol.
  */
 
-static ssize_t sock_aio_read(struct kiocb *iocb, char *ubuf,
-			 size_t size, loff_t pos)
+static ssize_t sock_aio_read(struct rw_iocb *iocb)
 {
-	struct sock_iocb *x = kiocb_to_siocb(iocb);
+	struct sock_iocb *x = rw_iocb_to_siocb(iocb);
 	struct socket *sock;
 	int flags;
 
-	if (pos != 0)
+	if (x->iocb.rw_pos != 0)
 		return -ESPIPE;
-	if (size==0)		/* Match SYS5 behaviour */
+	if (0 == x->iocb.rw_local_iov.iov_len)
 		return 0;
 
-	sock = SOCKET_I(iocb->ki_filp->f_dentry->d_inode); 
+	sock = SOCKET_I(x->iocb.kiocb.ki_filp->f_dentry->d_inode); 
 
 	x->async_msg.msg_name = NULL;
 	x->async_msg.msg_namelen = 0;
-	x->async_msg.msg_iov = &x->async_iov;
-	x->async_msg.msg_iovlen = 1;
+	x->async_msg.msg_iov = x->iocb.rw_iov;
+	x->async_msg.msg_iovlen = x->iocb.rw_nsegs;
 	x->async_msg.msg_control = NULL;
 	x->async_msg.msg_controllen = 0;
-	x->async_iov.iov_base = ubuf;
-	x->async_iov.iov_len = size;
-	flags = !(iocb->ki_filp->f_flags & O_NONBLOCK) ? 0 : MSG_DONTWAIT;
+	flags = !(x->iocb.kiocb.ki_filp->f_flags & O_NONBLOCK) ? 0 : MSG_DONTWAIT;
 
-	return __sock_recvmsg(iocb, sock, &x->async_msg, size, flags);
+	return __sock_recvmsg(&x->iocb.kiocb, sock, &x->async_msg,
+			      x->iocb.rw_local_iov.iov_len, flags);
 }
 
 
@@ -617,32 +615,29 @@ static ssize_t sock_aio_read(struct kioc
  *	is readable by the user process.
  */
 
-static ssize_t sock_aio_write(struct kiocb *iocb, const char *ubuf,
-			  size_t size, loff_t pos)
+static ssize_t sock_aio_write(struct rw_iocb *iocb)
 {
-	struct sock_iocb *x = kiocb_to_siocb(iocb);
+	struct sock_iocb *x = rw_iocb_to_siocb(iocb);
 	struct socket *sock;
 	
-	if (pos != 0)
+	if (x->iocb.rw_pos != 0)
 		return -ESPIPE;
-	if(size==0)		/* Match SYS5 behaviour */
+	if (0 == x->iocb.rw_local_iov.iov_len)
 		return 0;
 
-	sock = SOCKET_I(iocb->ki_filp->f_dentry->d_inode); 
+	sock = SOCKET_I(x->iocb.kiocb.ki_filp->f_dentry->d_inode); 
 
 	x->async_msg.msg_name = NULL;
 	x->async_msg.msg_namelen = 0;
-	x->async_msg.msg_iov = &x->async_iov;
-	x->async_msg.msg_iovlen = 1;
+	x->async_msg.msg_iov = x->iocb.rw_iov;
+	x->async_msg.msg_iovlen = x->iocb.rw_nsegs;
 	x->async_msg.msg_control = NULL;
 	x->async_msg.msg_controllen = 0;
-	x->async_msg.msg_flags = !(iocb->ki_filp->f_flags & O_NONBLOCK) ? 0 : MSG_DONTWAIT;
+	x->async_msg.msg_flags = !(x->iocb.kiocb.ki_filp->f_flags & O_NONBLOCK) ? 0 : MSG_DONTWAIT;
 	if (sock->type == SOCK_SEQPACKET)
 		x->async_msg.msg_flags |= MSG_EOR;
-	x->async_iov.iov_base = (void *)ubuf;
-	x->async_iov.iov_len = size;
 	
-	return __sock_sendmsg(iocb, sock, &x->async_msg, size);
+	return __sock_sendmsg(&iocb->kiocb, sock, &x->async_msg, x->iocb.rw_local_iov.iov_len);
 }
 
 ssize_t sock_sendpage(struct file *file, struct page *page,
