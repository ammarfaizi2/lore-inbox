Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265596AbTFRXDp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265599AbTFRXDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:03:45 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:30474 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S265596AbTFRXDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:03:14 -0400
Subject: [Patch] Fix O_DIRECT races in 2.4
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Cc: "Marcelo W. Tosatti" <marcelo@conectiva.com.br>,
       Andrew Morton <akpm@digeo.com>, Stephen Tweedie <sct@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Andrea Arcangeli <andrea@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055978226.3281.231.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Jun 2003 00:17:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've found a few races in O_DIRECT in 2.4.  There are multiple places
where races can occur, mostly affecting sparse files or truncate:

O_DIRECT reads against buffered writes:
        Read with O_DIRECT to a sparse area, then submit a buffered
        write to the same area.  The file flush that the O_DIRECT read
        does initially can happen before the write, so you end up with
        newly written data in the area which has not yet been flushed to
        disk by the time the direct read is serviced.  Stale data from
        the disk can be returned.
        
O_DIRECT writes against buffered reads:
        Similar to the above, submit an O_DIRECT write into a sparse
        region of a file then read from that region while the write is
        still in progress.  The write doesn't lock pages in the page
        cache so there's no synchronisation against the read: stale data
        can be returned.
        
O_DIRECT IOs against truncate:
        Submit direct IO against a file then truncate it while the IO is
        in progress.  Writes are OK because direct writes currently hold
        i_sem, but reads don't --- the data blocks can be deallocated,
        reallocated to somebody else, and we potentially get to read
        that other data.  The i_sem on writes is actually a problem ---
        it prevents multiple threads from submitting parallel direct IOs
        at once, as the semaphore effectively serialises these IOs
        synchronously.

The patch below fixes this by:

* Prevent direct IO into sparse regions of a file.
        For reads, zeros are filled in anyway; for writes, fall back to
        buffered IO followed by fdatasync().
        
* Lock against truncate.
        Add a new, rwsem (i_alloc_sem) to guard against deallocation of
        data blocks while a direct IO is in progress: held in shared
        mode for the duration of all direct IOs, taken exclusively for
        truncate.
        
* Guard all direct IO getblk()s with i_sem
        The direct IO read path takes an extra i_sem, which means we
        can't look up data blocks which are still in the process of
        being filled in by a buffered write.  
        
But also

* Drop i_sem for the actual direct IO, once we've done the getblk()
lookups.
        Allows multiple direct IOs to be in progress against a file at
        once.
        
Holding i_sem just for the getblk() ensures that direct writes beyond
EOF are still consistent even with O_APPEND, while still allowing
parallelism in the IOs once we've mapped the file blocks.  The bulk of
the race prevention is in preventing IO to sparse regions and dealing
with the truncate locking.

--Stephen



--- linux-2.4-odirect/fs/buffer.c.=K0000=.orig
+++ linux-2.4-odirect/fs/buffer.c
@@ -436,26 +436,18 @@ out:
 	return ret;
 }
 
-asmlinkage long sys_fdatasync(unsigned int fd)
+int do_fdatasync(struct file *file)
 {
-	struct file * file;
-	struct dentry * dentry;
-	struct inode * inode;
 	int ret, err;
+	struct dentry *dentry;
+	struct inode *inode;
 
-	ret = -EBADF;
-	file = fget(fd);
-	if (!file)
-		goto out;
-
+	if (unlikely(!file->f_op || !file->f_op->fsync))
+		return -EINVAL;
+	
 	dentry = file->f_dentry;
 	inode = dentry->d_inode;
 
-	ret = -EINVAL;
-	if (!file->f_op || !file->f_op->fsync)
-		goto out_putf;
-
-	down(&inode->i_sem);
 	ret = filemap_fdatasync(inode->i_mapping);
 	err = file->f_op->fsync(file, dentry, 1);
 	if (err && !ret)
@@ -463,6 +455,23 @@ asmlinkage long sys_fdatasync(unsigned i
 	err = filemap_fdatawait(inode->i_mapping);
 	if (err && !ret)
 		ret = err;
+	return ret;
+}
+
+asmlinkage long sys_fdatasync(unsigned int fd)
+{
+	struct file * file;
+	struct inode *inode;
+	int ret;
+
+	ret = -EBADF;
+	file = fget(fd);
+	if (!file)
+		goto out;
+
+	inode = file->f_dentry->d_inode;
+	down(&inode->i_sem);
+	ret = do_fdatasync(file);
 	up(&inode->i_sem);
 
 out_putf:
@@ -2106,7 +2115,8 @@ int generic_direct_IO(int rw, struct ino
 	int i, nr_blocks, retval;
 	unsigned long * blocks = iobuf->blocks;
 	int length;
-
+	int beyond_eof = 0;
+	
 	length = iobuf->length;
 	nr_blocks = length / blocksize;
 	/* build the blocklist */
@@ -2117,13 +2127,20 @@ int generic_direct_IO(int rw, struct ino
 		bh.b_dev = inode->i_dev;
 		bh.b_size = blocksize;
 
-		retval = get_block(inode, blocknr, &bh, rw == READ ? 0 : 1);
+		if (((loff_t) blocknr) * blocksize >= inode->i_size)
+			beyond_eof = 1;
+
+		/* Only allow get_block to create new blocks if we are safely
+		   beyond EOF.  O_DIRECT is unsafe inside sparse files. */
+		retval = get_block(inode, blocknr, &bh, 
+				   ((rw != READ) && beyond_eof));
+
 		if (retval) {
 			if (!i)
 				/* report error to userspace */
 				goto out;
 			else
-				/* do short I/O utill 'i' */
+				/* do short I/O until 'i' */
 				break;
 		}
 
@@ -2139,14 +2156,20 @@ int generic_direct_IO(int rw, struct ino
 			if (buffer_new(&bh))
 				unmap_underlying_metadata(&bh);
 			if (!buffer_mapped(&bh))
-				BUG();
+				/* upper layers need to pass the error on or
+				 * fall back to buffered IO. */
+				return -ENOTBLK;
 		}
 		blocks[i] = bh.b_blocknr;
 	}
 
 	/* patch length to handle short I/O */
 	iobuf->length = i * blocksize;
+	if (!beyond_eof)
+		up(&inode->i_sem);
 	retval = brw_kiovec(rw, 1, &iobuf, inode->i_dev, iobuf->blocks, blocksize);
+	if (!beyond_eof)
+		down(&inode->i_sem);
 	/* restore orig length */
 	iobuf->length = length;
  out:
--- linux-2.4-odirect/fs/inode.c.=K0000=.orig
+++ linux-2.4-odirect/fs/inode.c
@@ -150,6 +150,7 @@ void inode_init_once(struct inode *inode
 	INIT_LIST_HEAD(&inode->i_devices);
 	sema_init(&inode->i_sem, 1);
 	sema_init(&inode->i_zombie, 1);
+	init_rwsem(&inode->i_alloc_sem);
 	spin_lock_init(&inode->i_data.i_shared_lock);
 }
 
--- linux-2.4-odirect/fs/open.c.=K0000=.orig
+++ linux-2.4-odirect/fs/open.c
@@ -105,11 +105,13 @@ int do_truncate(struct dentry *dentry, l
 	if (length < 0)
 		return -EINVAL;
 
+	down_write(&inode->i_alloc_sem);
 	down(&inode->i_sem);
 	newattrs.ia_size = length;
 	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
 	error = notify_change(dentry, &newattrs);
 	up(&inode->i_sem);
+	up_write(&inode->i_alloc_sem);
 	return error;
 }
 
--- linux-2.4-odirect/include/linux/fs.h.=K0000=.orig
+++ linux-2.4-odirect/include/linux/fs.h
@@ -456,6 +456,7 @@ struct inode {
 	unsigned long		i_blocks;
 	unsigned long		i_version;
 	struct semaphore	i_sem;
+	struct rw_semaphore	i_alloc_sem;
 	struct semaphore	i_zombie;
 	struct inode_operations	*i_op;
 	struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
@@ -1268,6 +1269,7 @@ static inline int fsync_inode_data_buffe
 	return fsync_buffers_list(&inode->i_dirty_data_buffers);
 }
 extern int inode_has_buffers(struct inode *);
+extern int do_fdatasync(struct file *);
 extern int filemap_fdatasync(struct address_space *);
 extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(kdev_t dev, int wait);
--- linux-2.4-odirect/mm/filemap.c.=K0000=.orig
+++ linux-2.4-odirect/mm/filemap.c
@@ -1545,6 +1545,12 @@ no_cached_page:
 	UPDATE_ATIME(inode);
 }
 
+/*
+ * i_sem and i_alloc_sem should be held already.  i_sem may be dropped
+ * later once we've mapped the new IO.  i_alloc_sem is kept until the IO
+ * completes.
+ */
+
 static ssize_t generic_file_direct_IO(int rw, struct file * filp, char * buf, size_t count, loff_t offset)
 {
 	ssize_t retval;
@@ -1699,12 +1705,16 @@ ssize_t generic_file_read(struct file * 
 		retval = 0;
 		if (!count)
 			goto out; /* skip atime */
+		down_read(&inode->i_alloc_sem);
+		down(&inode->i_sem);
 		size = inode->i_size;
 		if (pos < size) {
 			retval = generic_file_direct_IO(READ, filp, buf, count, pos);
 			if (retval > 0)
 				*ppos = pos + retval;
 		}
+		up(&inode->i_sem);
+		up_read(&inode->i_alloc_sem);
 		UPDATE_ATIME(filp->f_dentry->d_inode);
 		goto out;
 	}
@@ -2944,44 +2954,18 @@ inline void remove_suid(struct inode *in
 }
 
 /*
- * Write to a file through the page cache. 
- *
- * We currently put everything into the page cache prior to writing it.
- * This is not a problem when writing full pages. With partial pages,
- * however, we first have to read the data into the cache, then
- * dirty the page, and finally schedule it for writing. Alternatively, we
- * could write-through just the portion of data that would go into that
- * page, but that would kill performance for applications that write data
- * line by line, and it's prone to race conditions.
- *
- * Note that this routine doesn't try to keep track of dirty pages. Each
- * file system has to do this all by itself, unfortunately.
- *							okir@monad.swb.de
+ * precheck_file_write():
+ * Check the conditions on a file descriptor prior to beginning a write
+ * on it.  Contains the common precheck code for both buffered and direct
+ * IO.
  */
-ssize_t
-generic_file_write(struct file *file,const char *buf,size_t count, loff_t *ppos)
+static int precheck_file_write(struct file *file, struct inode *inode,
+			       size_t *count, loff_t *ppos)
 {
-	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
-	struct inode	*inode = mapping->host;
-	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
-	loff_t		pos;
-	struct page	*page, *cached_page;
-	ssize_t		written;
-	long		status = 0;
 	ssize_t		err;
-	unsigned	bytes;
-
-	if ((ssize_t) count < 0)
-		return -EINVAL;
-
-	if (!access_ok(VERIFY_READ, buf, count))
-		return -EFAULT;
-
-	cached_page = NULL;
-
-	down(&inode->i_sem);
-
-	pos = *ppos;
+	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
+	loff_t		pos = *ppos;
+	
 	err = -EINVAL;
 	if (pos < 0)
 		goto out;
@@ -2992,11 +2976,9 @@ generic_file_write(struct file *file,con
 		goto out;
 	}
 
-	written = 0;
-
 	/* FIXME: this is for backwards compatibility with 2.4 */
 	if (!S_ISBLK(inode->i_mode) && file->f_flags & O_APPEND)
-		pos = inode->i_size;
+		*ppos = pos = inode->i_size;
 
 	/*
 	 * Check whether we've reached the file size limit.
@@ -3008,23 +2990,23 @@ generic_file_write(struct file *file,con
 			send_sig(SIGXFSZ, current, 0);
 			goto out;
 		}
-		if (pos > 0xFFFFFFFFULL || count > limit - (u32)pos) {
+		if (pos > 0xFFFFFFFFULL || *count > limit - (u32)pos) {
 			/* send_sig(SIGXFSZ, current, 0); */
-			count = limit - (u32)pos;
+			*count = limit - (u32)pos;
 		}
 	}
 
 	/*
 	 *	LFS rule 
 	 */
-	if ( pos + count > MAX_NON_LFS && !(file->f_flags&O_LARGEFILE)) {
+	if ( pos + *count > MAX_NON_LFS && !(file->f_flags&O_LARGEFILE)) {
 		if (pos >= MAX_NON_LFS) {
 			send_sig(SIGXFSZ, current, 0);
 			goto out;
 		}
-		if (count > MAX_NON_LFS - (u32)pos) {
+		if (*count > MAX_NON_LFS - (u32)pos) {
 			/* send_sig(SIGXFSZ, current, 0); */
-			count = MAX_NON_LFS - (u32)pos;
+			*count = MAX_NON_LFS - (u32)pos;
 		}
 	}
 
@@ -3041,7 +3023,7 @@ generic_file_write(struct file *file,con
 	if (!S_ISBLK(inode->i_mode)) {
 		if (pos >= inode->i_sb->s_maxbytes)
 		{
-			if (count || pos > inode->i_sb->s_maxbytes) {
+			if (*count || pos > inode->i_sb->s_maxbytes) {
 				send_sig(SIGXFSZ, current, 0);
 				err = -EFBIG;
 				goto out;
@@ -3049,35 +3031,71 @@ generic_file_write(struct file *file,con
 			/* zero-length writes at ->s_maxbytes are OK */
 		}
 
-		if (pos + count > inode->i_sb->s_maxbytes)
-			count = inode->i_sb->s_maxbytes - pos;
+		if (pos + *count > inode->i_sb->s_maxbytes)
+			*count = inode->i_sb->s_maxbytes - pos;
 	} else {
 		if (is_read_only(inode->i_rdev)) {
 			err = -EPERM;
 			goto out;
 		}
 		if (pos >= inode->i_size) {
-			if (count || pos > inode->i_size) {
+			if (*count || pos > inode->i_size) {
 				err = -ENOSPC;
 				goto out;
 			}
 		}
 
-		if (pos + count > inode->i_size)
-			count = inode->i_size - pos;
+		if (pos + *count > inode->i_size)
+			*count = inode->i_size - pos;
 	}
 
 	err = 0;
-	if (count == 0)
+	if (*count == 0)
 		goto out;
 
 	remove_suid(inode);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty_sync(inode);
+	
+out:
+	return err;
+}
 
-	if (file->f_flags & O_DIRECT)
-		goto o_direct;
+/*
+ * Write to a file through the page cache. 
+ *
+ * We currently put everything into the page cache prior to writing it.
+ * This is not a problem when writing full pages. With partial pages,
+ * however, we first have to read the data into the cache, then
+ * dirty the page, and finally schedule it for writing. Alternatively, we
+ * could write-through just the portion of data that would go into that
+ * page, but that would kill performance for applications that write data
+ * line by line, and it's prone to race conditions.
+ *
+ * Note that this routine doesn't try to keep track of dirty pages. Each
+ * file system has to do this all by itself, unfortunately.
+ *							okir@monad.swb.de
+ */
+ssize_t
+do_generic_file_write(struct file *file,const char *buf,size_t count, loff_t *ppos)
+{
+	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+	struct inode	*inode = mapping->host;
+	loff_t		pos;
+	struct page	*page, *cached_page;
+	ssize_t		written;
+	long		status = 0;
+	int		err;
+	unsigned	bytes;
 
+	cached_page = NULL;
+	pos = *ppos;
+	written = 0;
+	
+	err = precheck_file_write(file, inode, &count, &pos);
+	if (err != 0 || count == 0)
+		goto out;
+	
 	do {
 		unsigned long index, offset;
 		long page_fault;
@@ -3155,11 +3173,9 @@ done:
 			status = generic_osync_inode(inode, OSYNC_METADATA|OSYNC_DATA);
 	}
 	
-out_status:	
 	err = written ? written : status;
 out:
 
-	up(&inode->i_sem);
 	return err;
 fail_write:
 	status = -EFAULT;
@@ -3176,8 +3192,28 @@ sync_failure:
 	if (pos + bytes > inode->i_size)
 		vmtruncate(inode, inode->i_size);
 	goto done;
+}
+
+ssize_t
+do_generic_direct_write(struct file *file,const char *buf,size_t count, loff_t *ppos)
+{
+	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
+	struct inode	*inode = mapping->host;
+	loff_t		pos;
+	ssize_t		written;
+	long		status = 0;
+	int		err;
+
+	pos = *ppos;
+	written = 0;
+	
+	err = precheck_file_write(file, inode, &count, &pos);
+	if (err != 0 || count == 0)
+		goto out;
+	
+	if (!file->f_flags & O_DIRECT)
+		BUG();
 
-o_direct:
 	written = generic_file_direct_IO(WRITE, file, (char *) buf, count, pos);
 	if (written > 0) {
 		loff_t end = pos + written;
@@ -3194,7 +3230,57 @@ o_direct:
 	 */
 	if (written >= 0 && file->f_flags & O_SYNC)
 		status = generic_osync_inode(inode, OSYNC_METADATA);
-	goto out_status;
+
+	err = written ? written : status;
+out:
+	return err;
+}
+
+static int do_odirect_fallback(struct file *file, struct inode *inode,
+			       const char *buf, size_t count, loff_t *ppos)
+{
+	int ret, err;
+
+	down(&inode->i_sem);
+	ret = do_generic_file_write(file, buf, count, ppos);
+	if (ret > 0) {
+		err = do_fdatasync(file);
+		if (err)
+			ret = err;
+	}
+	up(&inode->i_sem);
+	return ret;
+}
+
+ssize_t
+generic_file_write(struct file *file,const char *buf,size_t count, loff_t *ppos)
+{
+	struct inode	*inode = file->f_dentry->d_inode->i_mapping->host;
+	int		err;
+
+	if ((ssize_t) count < 0)
+		return -EINVAL;
+
+	if (!access_ok(VERIFY_READ, buf, count))
+		return -EFAULT;
+
+	if (file->f_flags & O_DIRECT) {
+		/* do_generic_direct_write may drop i_sem during the
+		   actual IO */
+		down_read(&inode->i_alloc_sem);
+		down(&inode->i_sem);
+		err = do_generic_direct_write(file, buf, count, ppos);
+		up(&inode->i_sem);
+		up_read(&inode->i_alloc_sem);
+		if (unlikely(err == -ENOTBLK))
+			err = do_odirect_fallback(file, inode, buf, count, ppos);
+	} else {
+		down(&inode->i_sem);
+		err = do_generic_file_write(file, buf, count, ppos);
+		up(&inode->i_sem);
+	}
+
+	return err;
 }
 
 void __init page_cache_init(unsigned long mempages)


