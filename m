Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288800AbSAELsy>; Sat, 5 Jan 2002 06:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288786AbSAELsq>; Sat, 5 Jan 2002 06:48:46 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:29700 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288781AbSAELsh>; Sat, 5 Jan 2002 06:48:37 -0500
Message-ID: <3C36E6E8.628BF0BF@zip.com.au>
Date: Sat, 05 Jan 2002 03:43:36 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, torrey.hoffman@myrio.com,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd kern  
 el panic woes
In-Reply-To: <3C2EB208.B2BA7CBF@zip.com.au> <Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>,
		<Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Dec 30, 2001 at 01:33:24AM -0500 <20011231010537.K1356@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> Note: I'm fine to introduce another way to notify the app about -ENOSPC,
> -ENOSPC on mmap is the most obvious one, but we could still allow the
> current "overcommit" behaviour with a kind of sigbus mentioned by
> Andrew (possibly not sigbus though, since it has just well defined
> semantics for MAP_SHARED, maybe they could be extended, anyways as said
> this is only a matter of API). My point is only that some API should be
> added because your mmap on sparse files are unreliable at the moment.
> 

The very least we can do is to return a sensible error code from msync().
At present, if you create a 200 meg mapping on a 100 meg disk, dirty it
all and run msync(MS_SYNC), the damn thing returns zero and you don't
know that you lost half your data.

The patch makes filemap_fdatasync() and filemap_fdatawait() return
an error code, and propagates that up through all callers, including 
fsync() and fdatasync().  Please review, especially the nfs and
generic_file_direct_IO() changes.

There's also a half-assed attempt to implement MS_ASYNC in here.
If anyone thinks that's not worth the effort, I won't be offended.



--- linux-2.4.18-pre1/include/linux/fs.h	Fri Dec 21 11:19:23 2001
+++ linux-akpm/include/linux/fs.h	Sat Jan  5 03:21:07 2002
@@ -1212,8 +1212,8 @@ extern int osync_inode_data_buffers(stru
 extern int fsync_inode_buffers(struct inode *);
 extern int fsync_inode_data_buffers(struct inode *);
 extern int inode_has_buffers(struct inode *);
-extern void filemap_fdatasync(struct address_space *);
-extern void filemap_fdatawait(struct address_space *);
+extern int filemap_fdatasync(struct address_space *);
+extern int filemap_fdatawait(struct address_space *);
 extern void sync_supers(kdev_t);
 extern int bmap(struct inode *, int);
 extern int notify_change(struct dentry *, struct iattr *);
--- linux-2.4.18-pre1/mm/filemap.c	Wed Dec 26 11:47:41 2001
+++ linux-akpm/mm/filemap.c	Sat Jan  5 03:23:09 2002
@@ -582,8 +582,9 @@ EXPORT_SYMBOL(fail_writepage);
  *      @mapping: address space structure to write
  *
  */
-void filemap_fdatasync(struct address_space * mapping)
+int filemap_fdatasync(struct address_space * mapping)
 {
+	int ret = 0;
 	int (*writepage)(struct page *) = mapping->a_ops->writepage;
 
 	spin_lock(&pagecache_lock);
@@ -603,8 +604,11 @@ void filemap_fdatasync(struct address_sp
 		lock_page(page);
 
 		if (PageDirty(page)) {
+			int err;
 			ClearPageDirty(page);
-			writepage(page);
+			err = writepage(page);
+			if (err && !ret)
+				ret = err;
 		} else
 			UnlockPage(page);
 
@@ -612,6 +616,7 @@ void filemap_fdatasync(struct address_sp
 		spin_lock(&pagecache_lock);
 	}
 	spin_unlock(&pagecache_lock);
+	return ret;
 }
 
 /**
@@ -621,8 +626,10 @@ void filemap_fdatasync(struct address_sp
  *      @mapping: address space structure to wait for
  *
  */
-void filemap_fdatawait(struct address_space * mapping)
+int filemap_fdatawait(struct address_space * mapping)
 {
+	int ret = 0;
+
 	spin_lock(&pagecache_lock);
 
         while (!list_empty(&mapping->locked_pages)) {
@@ -638,11 +645,14 @@ void filemap_fdatawait(struct address_sp
 		spin_unlock(&pagecache_lock);
 
 		___wait_on_page(page);
+		if (PageError(page))
+			ret = -EIO;
 
 		page_cache_release(page);
 		spin_lock(&pagecache_lock);
 	}
 	spin_unlock(&pagecache_lock);
+	return ret;
 }
 
 /*
@@ -1519,12 +1529,14 @@ static ssize_t generic_file_direct_IO(in
 		goto out_free;
 
 	/*
-	 * Flush to disk exlusively the _data_, metadata must remains
+	 * Flush to disk exclusively the _data_, metadata must remain
 	 * completly asynchronous or performance will go to /dev/null.
 	 */
-	filemap_fdatasync(mapping);
-	retval = fsync_inode_data_buffers(inode);
-	filemap_fdatawait(mapping);
+	retval = filemap_fdatasync(mapping);
+	if (retval == 0)
+		retval = fsync_inode_data_buffers(inode);
+	if (retval == 0)
+		retval = filemap_fdatawait(mapping);
 	if (retval < 0)
 		goto out_free;
 
@@ -2141,26 +2153,41 @@ int generic_file_mmap(struct file * file
  * The msync() system call.
  */
 
+/*
+ * We attempt to implement MS_ASYNC, but it's lame.  There needs to be a way
+ * of starting async writeout of the metadata and inode.
+ */
 static int msync_interval(struct vm_area_struct * vma,
 	unsigned long start, unsigned long end, int flags)
 {
+	int ret = 0;
 	struct file * file = vma->vm_file;
+
 	if (file && (vma->vm_flags & VM_SHARED)) {
-		int error;
-		error = filemap_sync(vma, start, end-start, flags);
+		/* filemap_sync() cannot fail */
+		ret = filemap_sync(vma, start, end-start, flags);
 
-		if (!error && (flags & MS_SYNC)) {
+		if (flags & (MS_SYNC|MS_ASYNC)) {
 			struct inode * inode = file->f_dentry->d_inode;
+
 			down(&inode->i_sem);
-			filemap_fdatasync(inode->i_mapping);
-			if (file->f_op && file->f_op->fsync)
-				error = file->f_op->fsync(file, file->f_dentry, 1);
-			filemap_fdatawait(inode->i_mapping);
+			ret = filemap_fdatasync(inode->i_mapping);
+			if (flags & MS_SYNC) {
+				int err;
+
+				if (file->f_op && file->f_op->fsync) {
+					err = file->f_op->fsync(file, file->f_dentry, 1);
+					if (err && !ret)
+						ret = err;
+				}
+				err = filemap_fdatawait(inode->i_mapping);
+				if (err && !ret)
+					ret = err;
+			}
 			up(&inode->i_sem);
 		}
-		return error;
 	}
-	return 0;
+	return ret;
 }
 
 asmlinkage long sys_msync(unsigned long start, size_t len, int flags)
--- linux-2.4.18-pre1/fs/block_dev.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/fs/block_dev.c	Sat Jan  5 03:21:07 2002
@@ -171,11 +171,15 @@ static loff_t block_llseek(struct file *
 
 static int __block_fsync(struct inode * inode)
 {
-	int ret;
+	int ret, err;
 
-	filemap_fdatasync(inode->i_mapping);
-	ret = sync_buffers(inode->i_rdev, 1);
-	filemap_fdatawait(inode->i_mapping);
+	ret = filemap_fdatasync(inode->i_mapping);
+	err = sync_buffers(inode->i_rdev, 1);
+	if (err && !ret)
+		ret = err;
+	err = filemap_fdatawait(inode->i_mapping);
+	if (err && !ret)
+		ret = err;
 
 	return ret;
 }
--- linux-2.4.18-pre1/fs/buffer.c	Fri Dec 21 11:19:14 2001
+++ linux-akpm/fs/buffer.c	Sat Jan  5 03:21:07 2002
@@ -401,9 +401,9 @@ asmlinkage long sys_fsync(unsigned int f
 	struct file * file;
 	struct dentry * dentry;
 	struct inode * inode;
-	int err;
+	int ret, err;
 
-	err = -EBADF;
+	ret = -EBADF;
 	file = fget(fd);
 	if (!file)
 		goto out;
@@ -411,21 +411,27 @@ asmlinkage long sys_fsync(unsigned int f
 	dentry = file->f_dentry;
 	inode = dentry->d_inode;
 
-	err = -EINVAL;
-	if (!file->f_op || !file->f_op->fsync)
+	ret = -EINVAL;
+	if (!file->f_op || !file->f_op->fsync) {
+		/* Why?  We can still call filemap_fdatasync */
 		goto out_putf;
+	}
 
 	/* We need to protect against concurrent writers.. */
 	down(&inode->i_sem);
-	filemap_fdatasync(inode->i_mapping);
+	ret = filemap_fdatasync(inode->i_mapping);
 	err = file->f_op->fsync(file, dentry, 0);
-	filemap_fdatawait(inode->i_mapping);
+	if (err && !ret)
+		ret = err;
+	err = filemap_fdatawait(inode->i_mapping);
+	if (err && !ret)
+		ret = err;
 	up(&inode->i_sem);
 
 out_putf:
 	fput(file);
 out:
-	return err;
+	return ret;
 }
 
 asmlinkage long sys_fdatasync(unsigned int fd)
@@ -433,9 +439,9 @@ asmlinkage long sys_fdatasync(unsigned i
 	struct file * file;
 	struct dentry * dentry;
 	struct inode * inode;
-	int err;
+	int ret, err;
 
-	err = -EBADF;
+	ret = -EBADF;
 	file = fget(fd);
 	if (!file)
 		goto out;
@@ -443,14 +449,18 @@ asmlinkage long sys_fdatasync(unsigned i
 	dentry = file->f_dentry;
 	inode = dentry->d_inode;
 
-	err = -EINVAL;
+	ret = -EINVAL;
 	if (!file->f_op || !file->f_op->fsync)
 		goto out_putf;
 
 	down(&inode->i_sem);
-	filemap_fdatasync(inode->i_mapping);
+	ret = filemap_fdatasync(inode->i_mapping);
 	err = file->f_op->fsync(file, dentry, 1);
-	filemap_fdatawait(inode->i_mapping);
+	if (err && !ret)
+		ret = err;
+	err = filemap_fdatawait(inode->i_mapping);
+	if (err && !ret)
+		ret = err;
 	up(&inode->i_sem);
 
 out_putf:
--- linux-2.4.18-pre1/fs/nfs/file.c	Wed Dec 26 11:47:41 2001
+++ linux-akpm/fs/nfs/file.c	Sat Jan  5 03:21:07 2002
@@ -244,6 +244,7 @@ nfs_lock(struct file *filp, int cmd, str
 {
 	struct inode * inode = filp->f_dentry->d_inode;
 	int	status = 0;
+	int	status2;
 
 	dprintk("NFS: nfs_lock(f=%4x/%ld, t=%x, fl=%x, r=%Ld:%Ld)\n",
 			inode->i_dev, inode->i_ino,
@@ -278,11 +279,18 @@ nfs_lock(struct file *filp, int cmd, str
 	 * Flush all pending writes before doing anything
 	 * with locks..
 	 */
-	filemap_fdatasync(inode->i_mapping);
+	/*
+	 * Shouldn't filemap_fdatasync/wait be inside i_sem?
+	 */
+	status = filemap_fdatasync(inode->i_mapping);
 	down(&inode->i_sem);
-	status = nfs_wb_all(inode);
+	status2 = nfs_wb_all(inode);
+	if (status2 && !status)
+		status = status2;
 	up(&inode->i_sem);
-	filemap_fdatawait(inode->i_mapping);
+	status2 = filemap_fdatawait(inode->i_mapping);
+	if (status2 && !status)
+		status = status2;
 	if (status < 0)
 		return status;
 
@@ -300,11 +308,17 @@ nfs_lock(struct file *filp, int cmd, str
 	 */
  out_ok:
 	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
-		filemap_fdatasync(inode->i_mapping);
+		status2 = filemap_fdatasync(inode->i_mapping);
+		if (status2 && !status)
+			status = status2;
 		down(&inode->i_sem);
-		nfs_wb_all(inode);      /* we may have slept */
+		status2 = nfs_wb_all(inode);      /* we may have slept */
+		if (status2 && !status)
+			status2 = status;
 		up(&inode->i_sem);
-		filemap_fdatawait(inode->i_mapping);
+		status2 = filemap_fdatawait(inode->i_mapping);
+		if (status2 && !status)
+			status = status2;
 		nfs_zap_caches(inode);
 	}
 	return status;
