Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267535AbUJNUQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267535AbUJNUQJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUJNUP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:15:59 -0400
Received: from palrel12.hp.com ([156.153.255.237]:61633 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S267535AbUJNUK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:10:27 -0400
Message-ID: <416EDD34.1020704@hpl.hp.com>
Date: Thu, 14 Oct 2004 13:10:28 -0700
From: Yasushi Saito <ysaito@hpl.hp.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: suparna@in.ibm.com, Janet Morgan <janetmor@us.ibm.com>, ysaito@hpl.hp.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2]  aio: add vectored I/O support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second part of the vectored I/O patch to libaio.
yaz

Signed-off-by: Yasushi Saito <ysaito@hpl.hp.com>

--- .pc/aio-vector.patch/fs/aio.c    2004-10-14 12:58:39 -07:00
+++ fs/aio.c    2004-10-14 12:58:40 -07:00
@@ -459,6 +459,8 @@ static inline void really_put_req(struct
     req->ki_obj.user = NULL;
     req->ki_dtor = NULL;
     req->private = NULL;
+    if (req->ki_slow_iov)
+        kfree(req->ki_slow_iov);
     kmem_cache_free(kiocb_cachep, req);
     ctx->reqs_active--;
 
@@ -1312,6 +1314,24 @@ asmlinkage long sys_io_destroy(aio_conte
     return -EINVAL;
 }
 
+static void
+aio_increment_iov(struct iovec **iov_ptr, unsigned long *nr_segs, 
size_t nr_bytes)
+{
+    struct iovec *iov = *iov_ptr;
+    while (nr_bytes > 0) {
+        if (iov->iov_len <= nr_bytes) {
+            nr_bytes -= iov->iov_len;
+            iov++;
+            (*nr_segs)--;
+        } else {
+            iov->iov_len -= nr_bytes;
+            iov->iov_base = (char*)iov->iov_base + nr_bytes;
+            break;
+        }
+    }
+    BUG_ON(*nr_segs >= 9999999);
+    *iov_ptr = iov;
+}
 /*
  * Default retry method for aio_read (also used for first time submit)
  * Responsible for updating iocb state as retries progress
@@ -1323,15 +1343,19 @@ static ssize_t aio_pread(struct kiocb *i
     struct inode *inode = mapping->host;
     ssize_t ret = 0;
 
-    ret = file->f_op->aio_read(iocb, iocb->ki_buf,
-        iocb->ki_left, iocb->ki_pos);
-
+     if (iocb->ki_nr_segs == 1) {
+         ret = file->f_op->aio_read(iocb, iocb->ki_iov[0].iov_base,
+                        iocb->ki_iov[0].iov_len,
+                        iocb->ki_pos);
+     } else {
+         ret = file->f_op->aio_readv(iocb);
+     }
     /*
      * Can't just depend on iocb->ki_left to determine
      * whether we are done. This may have been a short read.
      */
     if (ret > 0) {
-        iocb->ki_buf += ret;
+         aio_increment_iov(&iocb->ki_iov, &iocb->ki_nr_segs, ret);
         iocb->ki_left -= ret;
         /*
          * For pipes and sockets we return once we have
@@ -1360,11 +1384,16 @@ static ssize_t aio_pwrite(struct kiocb *
     struct file *file = iocb->ki_filp;
     ssize_t ret = 0;
 
-    ret = file->f_op->aio_write(iocb, iocb->ki_buf,
-        iocb->ki_left, iocb->ki_pos);
+     if (iocb->ki_nr_segs == 1) {
+         ret = file->f_op->aio_write(iocb, iocb->ki_iov[0].iov_base,
+                         iocb->ki_iov[0].iov_len,
+                         iocb->ki_pos);
+     } else {
+         ret = file->f_op->aio_writev(iocb);
+     }
 
     if (ret > 0) {
-        iocb->ki_buf += ret;
+         aio_increment_iov(&iocb->ki_iov, &iocb->ki_nr_segs, ret);
         iocb->ki_left -= ret;
 
         ret = -EIOCBRETRY;
@@ -1398,6 +1427,16 @@ static ssize_t aio_fsync(struct kiocb *i
     return ret;
 }
 
+static int aio_iov_access_ok(int mode, struct kiocb *kiocb)
+{
+     int i;
+     for (i = 0; i < kiocb->ki_nr_segs; i++)
+         if (unlikely(!access_ok(mode, kiocb->ki_iov[i].iov_base,
+                     kiocb->ki_iov[i].iov_len)))
+             return 0;
+     return 1;
+}
+
 /*
  * aio_setup_iocb:
  *    Performs the initial checks and aio retry method
@@ -1410,24 +1449,24 @@ ssize_t aio_setup_iocb(struct kiocb *kio
 
     switch (kiocb->ki_opcode) {
     case IOCB_CMD_PREAD:
+    case IOCB_CMD_PREADV:
         ret = -EBADF;
         if (unlikely(!(file->f_mode & FMODE_READ)))
             break;
         ret = -EFAULT;
-        if (unlikely(!access_ok(VERIFY_WRITE, kiocb->ki_buf,
-            kiocb->ki_left)))
+        if (unlikely(!aio_iov_access_ok(VERIFY_WRITE, kiocb)))
             break;
         ret = -EINVAL;
         if (file->f_op->aio_read)
             kiocb->ki_retry = aio_pread;
         break;
     case IOCB_CMD_PWRITE:
+    case IOCB_CMD_PWRITEV:
         ret = -EBADF;
         if (unlikely(!(file->f_mode & FMODE_WRITE)))
             break;
         ret = -EFAULT;
-        if (unlikely(!access_ok(VERIFY_READ, kiocb->ki_buf,
-            kiocb->ki_left)))
+        if (unlikely(!aio_iov_access_ok(VERIFY_READ, kiocb)))
             break;
         ret = -EINVAL;
         if (file->f_op->aio_write)
@@ -1495,16 +1534,6 @@ int fastcall io_submit_one(struct kioctx
         return -EINVAL;
     }
 
-    /* prevent overflows */
-    if (unlikely(
-        (iocb->aio_buf != (unsigned long)iocb->aio_buf) ||
-        (iocb->aio_nbytes != (size_t)iocb->aio_nbytes) ||
-        ((ssize_t)iocb->aio_nbytes < 0)
-       )) {
-        pr_debug("EINVAL: io_submit: overflow check\n");
-        return -EINVAL;
-    }
-
     file = fget(iocb->aio_fildes);
     if (unlikely(!file))
         return -EBADF;
@@ -1525,10 +1554,60 @@ int fastcall io_submit_one(struct kioctx
 
     req->ki_obj.user = user_iocb;
     req->ki_user_data = iocb->aio_data;
-    req->ki_pos = iocb->aio_offset;
-
-    req->ki_buf = (char __user *)(unsigned long)iocb->aio_buf;
-    req->ki_left = req->ki_nbytes = iocb->aio_nbytes;
+
+     req->ki_slow_iov = NULL;
+
+     switch (iocb->aio_lio_opcode) {
+     case IOCB_CMD_PREADV:
+         /* FALLTHROUGH */
+     case IOCB_CMD_PWRITEV:
+         ret = -EINVAL;
+         req->ki_pos = iocb->u.v.offset;
+         req->ki_nr_segs = iocb->u.v.nr;
+         req->ki_iov = &req->ki_fast_iov;
+         if (req->ki_nr_segs > 1) {
+             if (req->ki_nr_segs >= UIO_MAXIOV)
+                 goto out_put_req;
+             req->ki_slow_iov = kmalloc(sizeof(struct iovec) * 
req->ki_nr_segs, GFP_KERNEL);
+             req->ki_iov = req->ki_slow_iov;
+         }
+         ret = -EFAULT;
+         if (unlikely(copy_from_user(req->ki_iov, iocb->u.v.vec,
+                         sizeof(struct iovec) * req->ki_nr_segs)))
+             goto out_put_req;
+         /* Compute the total length; also make sure that the
+            length isn't ridiculuously large. */
+         {
+             int i;
+             ssize_t tot_len = 0;
+             ret = -EINVAL;
+             for (i = 0;  i < req->ki_nr_segs; i++) {
+                 ssize_t len = (ssize_t)req->ki_iov[i].iov_len;
+                 tot_len += len;
+                 if (len < 0 || tot_len < 0)   
+                     // overflow
+                     goto out_put_req;
+             }
+             req->ki_nbytes = tot_len;
+         }
+         break;
+     default:
+         /* prevent overflows */
+         ret = -EINVAL;
+         if (unlikely((iocb->u.c.buf != (unsigned long)iocb->u.c.buf) ||
+                  (iocb->u.c.nbytes != (size_t)iocb->u.c.nbytes) ||
+                  ((ssize_t)iocb->u.c.nbytes < 0))) {
+             pr_debug("EINVAL: io_submit: overflow check\n");
+             goto out_put_req;
+         }
+         req->ki_pos = iocb->u.c.offset;
+         req->ki_nr_segs = 1;
+         req->ki_iov = &req->ki_fast_iov;
+         req->ki_iov->iov_base = (char __user*)(unsigned 
long)iocb->u.c.buf;
+         req->ki_iov->iov_len = iocb->u.c.nbytes;
+         req->ki_nbytes = iocb->u.c.nbytes;
+     }
+     req->ki_left = req->ki_nbytes;
     req->ki_opcode = iocb->aio_lio_opcode;
     init_waitqueue_func_entry(&req->ki_wait, aio_wake_function);
     INIT_LIST_HEAD(&req->ki_wait.task_list);
--- .pc/aio-vector.patch/fs/bad_inode.c    2004-10-14 12:58:38 -07:00
+++ fs/bad_inode.c    2004-10-14 12:58:40 -07:00
@@ -55,6 +55,9 @@ static struct file_operations bad_file_o
     .writev        = EIO_ERROR,
     .sendfile    = EIO_ERROR,
     .sendpage    = EIO_ERROR,
+    .aio_readv    = EIO_ERROR,
+    .aio_writev    = EIO_ERROR,
+   
     .get_unmapped_area = EIO_ERROR,
 };
 
--- .pc/aio-vector.patch/fs/block_dev.c    2004-10-14 12:58:38 -07:00
+++ fs/block_dev.c    2004-10-14 12:58:40 -07:00
@@ -763,6 +763,10 @@ static ssize_t blkdev_file_aio_write(str
 
     return generic_file_aio_write_nolock(iocb, &local_iov, 1, 
&iocb->ki_pos);
 }
+static ssize_t blkdev_file_aio_writev(struct kiocb *iocb)
+{
+    return generic_file_aio_write_nolock(iocb, iocb->ki_iov, 
iocb->ki_nr_segs, &iocb->ki_pos);
+}
 
 static int block_ioctl(struct inode *inode, struct file *file, unsigned 
cmd,
             unsigned long arg)
@@ -788,6 +792,8 @@ struct file_operations def_blk_fops = {
     .write        = blkdev_file_write,
       .aio_read    = generic_file_aio_read,
       .aio_write    = blkdev_file_aio_write,
+      .aio_readv    = generic_file_aio_readv,
+      .aio_writev    = blkdev_file_aio_writev,
     .mmap        = generic_file_mmap,
     .fsync        = block_fsync,
     .ioctl        = block_ioctl,
--- .pc/aio-vector.patch/fs/ext2/file.c    2004-10-14 12:58:38 -07:00
+++ fs/ext2/file.c    2004-10-14 12:58:40 -07:00
@@ -45,6 +45,8 @@ struct file_operations ext2_file_operati
     .write        = generic_file_write,
     .aio_read    = generic_file_aio_read,
     .aio_write    = generic_file_aio_write,
+    .aio_readv    = generic_file_aio_readv,
+    .aio_writev    = generic_file_aio_writev,
     .ioctl        = ext2_ioctl,
     .mmap        = generic_file_mmap,
     .open        = generic_file_open,
--- .pc/aio-vector.patch/fs/ext3/file.c    2004-10-14 12:58:38 -07:00
+++ fs/ext3/file.c    2004-10-14 12:58:40 -07:00
@@ -58,14 +58,14 @@ static int ext3_open_file (struct inode
 }
 
 static ssize_t
-ext3_file_write(struct kiocb *iocb, const char __user *buf, size_t 
count, loff_t pos)
+ext3_file_writev(struct kiocb *iocb)
 {
     struct file *file = iocb->ki_filp;
     struct inode *inode = file->f_dentry->d_inode;
     ssize_t ret;
     int err;
 
-    ret = generic_file_aio_write(iocb, buf, count, pos);
+    ret = generic_file_aio_writev(iocb);
 
     /*
      * Skip flushing if there was an error, or if nothing was written.
@@ -115,12 +115,24 @@ force_commit:
     return ret;
 }
 
+static ssize_t
+ext3_file_write(struct kiocb *iocb, const char __user *buf, size_t 
count, loff_t pos)
+{
+        /* aio_write is a legacy interface. */
+        BUG_ON(buf != iocb->ki_iov[0].iov_base
+           || count != iocb->ki_iov[0].iov_len
+           || pos != iocb->ki_pos);
+    return ext3_file_writev(iocb);
+}
+
 struct file_operations ext3_file_operations = {
     .llseek        = generic_file_llseek,
     .read        = do_sync_read,
     .write        = do_sync_write,
     .aio_read    = generic_file_aio_read,
     .aio_write    = ext3_file_write,
+    .aio_readv    = generic_file_aio_readv,
+    .aio_writev    = ext3_file_writev,
     .readv        = generic_file_readv,
     .writev        = generic_file_writev,
     .ioctl        = ext3_ioctl,
--- .pc/aio-vector.patch/fs/jfs/file.c    2004-10-14 12:58:38 -07:00
+++ fs/jfs/file.c    2004-10-14 12:58:40 -07:00
@@ -110,6 +110,8 @@ struct file_operations jfs_file_operatio
     .read        = generic_file_read,
     .aio_read    = generic_file_aio_read,
     .aio_write    = generic_file_aio_write,
+    .aio_readv    = generic_file_aio_readv,
+    .aio_writev    = generic_file_aio_writev,
     .mmap        = generic_file_mmap,
     .readv        = generic_file_readv,
     .writev        = generic_file_writev,
--- .pc/aio-vector.patch/fs/nfs/direct.c    2004-10-14 12:58:38 -07:00
+++ fs/nfs/direct.c    2004-10-14 12:58:40 -07:00
@@ -448,11 +448,11 @@ nfs_direct_IO(int rw, struct kiocb *iocb
 }
 
 /**
- * nfs_file_direct_read - file direct read operation for NFS files
+ * nfs_file_direct_readv - file direct read operation for NFS files
  * @iocb: target I/O control block
- * @buf: user's buffer into which to read data
- * count: number of bytes to read
- * pos: byte offset in file where reading starts
+ *
+ * The iovec and its size is passed through iocb->ki_iov and 
iocb->ki_nr_segs.
+ * The read offset is passed through iocb->ki_pos.
  *
  * We use this function for direct reads instead of calling
  * generic_file_aio_read() in order to avoid gfar's check to see if
@@ -469,31 +469,31 @@ nfs_direct_IO(int rw, struct kiocb *iocb
  * cache.
  */
 ssize_t
-nfs_file_direct_read(struct kiocb *iocb, char __user *buf, size_t 
count, loff_t pos)
+nfs_file_direct_readv(struct kiocb *iocb)
 {
     ssize_t retval = -EINVAL;
-    loff_t *ppos = &iocb->ki_pos;
     struct file *file = iocb->ki_filp;
     struct nfs_open_context *ctx =
             (struct nfs_open_context *) file->private_data;
     struct dentry *dentry = file->f_dentry;
     struct address_space *mapping = file->f_mapping;
     struct inode *inode = mapping->host;
-    struct iovec iov = {
-        .iov_base = buf,
-        .iov_len = count,
-    };
+     const struct iovec *iov = iocb->ki_iov;
+     unsigned long nr_segs = iocb->ki_nr_segs;
+     size_t count = iov_length(iov, nr_segs);
+     int i;
 
     dprintk("nfs: direct read(%s/%s, %lu@%lu)\n",
         dentry->d_parent->d_name.name, dentry->d_name.name,
-        (unsigned long) count, (unsigned long) pos);
+        (unsigned long) count, (unsigned long) iocb->ki_pos);
 
     if (!is_sync_kiocb(iocb))
         goto out;
     if (count < 0)
         goto out;
     retval = -EFAULT;
-    if (!access_ok(VERIFY_WRITE, iov.iov_base, iov.iov_len))
+     for (i = 0; i < nr_segs; i++)
+         if (!access_ok(VERIFY_WRITE, iov[i].iov_base, iov[i].iov_len))
         goto out;
     retval = 0;
     if (!count)
@@ -507,20 +507,20 @@ nfs_file_direct_read(struct kiocb *iocb,
             goto out;
     }
 
-    retval = nfs_direct_read(inode, ctx, &iov, pos, 1);
+    retval = nfs_direct_read(inode, ctx, iov, iocb->ki_pos, nr_segs);
     if (retval > 0)
-        *ppos = pos + retval;
+            iocb->ki_pos += retval;
 
 out:
     return retval;
 }
 
 /**
- * nfs_file_direct_write - file direct write operation for NFS files
+ * nfs_file_direct_writev - file direct write operation for NFS files
  * @iocb: target I/O control block
- * @buf: user's buffer from which to write data
- * count: number of bytes to write
- * pos: byte offset in file where writing starts
+ * The iovec and its size is passed through iocb->ki_iov and 
iocb->ki_nr_segs.
+ *
+ * The read offset is passed through iocb->ki_pos.
  *
  * We use this function for direct writes instead of calling
  * generic_file_aio_write() in order to avoid taking the inode
@@ -541,10 +541,10 @@ out:
  * is no atomic O_APPEND write facility in the NFS protocol.
  */
 ssize_t
-nfs_file_direct_write(struct kiocb *iocb, const char __user *buf, 
size_t count, loff_t pos)
+nfs_file_direct_writev(struct kiocb *iocb)
 {
     ssize_t retval = -EINVAL;
-    loff_t *ppos = &iocb->ki_pos;
+     loff_t pos = iocb->ki_pos;
     unsigned long limit = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
     struct file *file = iocb->ki_filp;
     struct nfs_open_context *ctx =
@@ -552,10 +552,10 @@ nfs_file_direct_write(struct kiocb *iocb
     struct dentry *dentry = file->f_dentry;
     struct address_space *mapping = file->f_mapping;
     struct inode *inode = mapping->host;
-    struct iovec iov = {
-        .iov_base = (char __user *)buf,
-        .iov_len = count,
-    };
+     const struct iovec *iov = iocb->ki_iov;
+     unsigned long nr_segs = iocb->ki_nr_segs;
+     size_t count = iov_length(iov, nr_segs);
+     int i;
 
     dfprintk(VFS, "nfs: direct write(%s/%s(%ld), %lu@%lu)\n",
         dentry->d_parent->d_name.name, dentry->d_name.name,
@@ -568,7 +568,8 @@ nfs_file_direct_write(struct kiocb *iocb
         if (pos < 0)
         goto out;
     retval = -EFAULT;
-    if (!access_ok(VERIFY_READ, iov.iov_base, iov.iov_len))
+    for (i = 0; i < nr_segs; i++)
+        if (!access_ok(VERIFY_READ, iov[i].iov_base, iov[i].iov_len))
         goto out;
         if (file->f_error) {
                 retval = file->f_error;
@@ -596,11 +597,11 @@ nfs_file_direct_write(struct kiocb *iocb
             goto out;
     }
 
-    retval = nfs_direct_write(inode, ctx, &iov, pos, 1);
+    retval = nfs_direct_write(inode, ctx, iov, pos, nr_segs);
     if (mapping->nrpages)
         invalidate_inode_pages2(mapping);
     if (retval > 0)
-        *ppos = pos + retval;
+         iocb->ki_pos = pos + retval;
 
 out:
     return retval;
--- .pc/aio-vector.patch/fs/nfs/file.c    2004-10-14 12:58:38 -07:00
+++ fs/nfs/file.c    2004-10-14 12:58:40 -07:00
@@ -41,6 +41,8 @@ static int  nfs_file_mmap(struct file *,
 static ssize_t nfs_file_sendfile(struct file *, loff_t *, size_t, 
read_actor_t, void *);
 static ssize_t nfs_file_read(struct kiocb *, char __user *, size_t, 
loff_t);
 static ssize_t nfs_file_write(struct kiocb *, const char __user *, 
size_t, loff_t);
+static ssize_t nfs_file_readv(struct kiocb *);
+static ssize_t nfs_file_writev(struct kiocb *);
 static int  nfs_file_flush(struct file *);
 static int  nfs_fsync(struct file *, struct dentry *dentry, int datasync);
 static int nfs_check_flags(int flags);
@@ -51,6 +53,8 @@ struct file_operations nfs_file_operatio
     .write        = do_sync_write,
     .aio_read        = nfs_file_read,
     .aio_write        = nfs_file_write,
+    .aio_readv        = nfs_file_readv,
+    .aio_writev        = nfs_file_writev,
     .mmap        = nfs_file_mmap,
     .open        = nfs_file_open,
     .flush        = nfs_file_flush,
@@ -137,7 +141,7 @@ nfs_file_flush(struct file *file)
 }
 
 static ssize_t
-nfs_file_read(struct kiocb *iocb, char __user * buf, size_t count, 
loff_t pos)
+nfs_file_readv(struct kiocb *iocb)
 {
     struct dentry * dentry = iocb->ki_filp->f_dentry;
     struct inode * inode = dentry->d_inode;
@@ -145,18 +149,27 @@ nfs_file_read(struct kiocb *iocb, char _
 
 #ifdef CONFIG_NFS_DIRECTIO
     if (iocb->ki_filp->f_flags & O_DIRECT)
-        return nfs_file_direct_read(iocb, buf, count, pos);
+            return nfs_file_direct_readv(iocb);
 #endif
 
     dfprintk(VFS, "nfs: read(%s/%s, %lu@%lu)\n",
         dentry->d_parent->d_name.name, dentry->d_name.name,
-        (unsigned long) count, (unsigned long) pos);
+         (unsigned long)iov_length(iocb->ki_iov, iocb->ki_nr_segs),
+         (unsigned long)iocb->ki_pos);
 
     result = nfs_revalidate_inode(NFS_SERVER(inode), inode);
     if (!result)
-        result = generic_file_aio_read(iocb, buf, count, pos);
+            result = generic_file_aio_readv(iocb);
     return result;
 }
+static ssize_t
+nfs_file_read(struct kiocb *iocb, char __user * buf, size_t count, 
loff_t pos)
+{
+        BUG_ON(buf != iocb->ki_iov[0].iov_base
+           || count != iocb->ki_iov[0].iov_len
+           || pos != iocb->ki_pos);
+    return nfs_file_readv(iocb);
+}
 
 static ssize_t
 nfs_file_sendfile(struct file *filp, loff_t *ppos, size_t count,
@@ -257,20 +270,21 @@ struct address_space_operations nfs_file
  * Write to a file (through the page cache).
  */
 static ssize_t
-nfs_file_write(struct kiocb *iocb, const char __user *buf, size_t 
count, loff_t pos)
+nfs_file_writev(struct kiocb *iocb)
 {
     struct dentry * dentry = iocb->ki_filp->f_dentry;
     struct inode * inode = dentry->d_inode;
+    size_t count = iov_length(iocb->ki_iov, iocb->ki_nr_segs);
     ssize_t result;
 
 #ifdef CONFIG_NFS_DIRECTIO
     if (iocb->ki_filp->f_flags & O_DIRECT)
-        return nfs_file_direct_write(iocb, buf, count, pos);
+        return nfs_file_direct_writev(iocb);
 #endif
 
     dfprintk(VFS, "nfs: write(%s/%s(%ld), %lu@%lu)\n",
         dentry->d_parent->d_name.name, dentry->d_name.name,
-        inode->i_ino, (unsigned long) count, (unsigned long) pos);
+         inode->i_ino, (unsigned long)count, (unsigned long)iocb->ki_pos);
 
     result = -EBUSY;
     if (IS_SWAPFILE(inode))
@@ -283,13 +297,22 @@ nfs_file_write(struct kiocb *iocb, const
     if (!count)
         goto out;
 
-    result = generic_file_aio_write(iocb, buf, count, pos);
+    result = generic_file_aio_writev(iocb);
 out:
     return result;
 
 out_swapfile:
     printk(KERN_INFO "NFS: attempt to write to active swap file!\n");
     goto out;
+}
+
+static ssize_t
+nfs_file_write(struct kiocb *iocb, const char __user *buf, size_t 
count, loff_t pos)
+{
+        BUG_ON(buf != iocb->ki_iov[0].iov_base
+           || count != iocb->ki_iov[0].iov_len
+           || pos != iocb->ki_pos);
+    return nfs_file_writev(iocb);
 }
 
 static int do_getlk(struct file *filp, int cmd, struct file_lock *fl)
--- .pc/aio-vector.patch/fs/read_write.c    2004-10-14 12:58:38 -07:00
+++ fs/read_write.c    2004-10-14 12:58:40 -07:00
@@ -190,6 +190,10 @@ ssize_t do_sync_read(struct file *filp,
 
     init_sync_kiocb(&kiocb, filp);
     kiocb.ki_pos = *ppos;
+    kiocb.ki_iov = &kiocb.ki_fast_iov;
+    kiocb.ki_iov->iov_base = buf;
+    kiocb.ki_iov->iov_len = len;
+    kiocb.ki_nr_segs = 1;
     ret = filp->f_op->aio_read(&kiocb, buf, len, kiocb.ki_pos);
     if (-EIOCBQUEUED == ret)
         ret = wait_on_sync_kiocb(&kiocb);
@@ -234,6 +238,10 @@ ssize_t do_sync_write(struct file *filp,
 
     init_sync_kiocb(&kiocb, filp);
     kiocb.ki_pos = *ppos;
+    kiocb.ki_iov = &kiocb.ki_fast_iov;
+    kiocb.ki_iov->iov_base = (char __user*)buf;
+    kiocb.ki_iov->iov_len = len;
+    kiocb.ki_nr_segs = 1;
     ret = filp->f_op->aio_write(&kiocb, buf, len, kiocb.ki_pos);
     if (-EIOCBQUEUED == ret)
         ret = wait_on_sync_kiocb(&kiocb);
--- .pc/aio-vector.patch/fs/reiserfs/file.c    2004-10-14 12:58:38 -07:00
+++ fs/reiserfs/file.c    2004-10-14 12:58:40 -07:00
@@ -1380,6 +1380,11 @@ static ssize_t reiserfs_aio_write(struct
 {
     return generic_file_aio_write(iocb, buf, count, pos);
 }
+static ssize_t reiserfs_aio_writev(struct kiocb *iocb)
+{
+    return generic_file_aio_writev(iocb);
+}
+
 
 
 
@@ -1393,6 +1398,8 @@ struct file_operations reiserfs_file_ope
     .sendfile    = generic_file_sendfile,
     .aio_read   = generic_file_aio_read,
     .aio_write  = reiserfs_aio_write,
+    .aio_readv   = generic_file_aio_readv,
+    .aio_writev  = reiserfs_aio_writev,
 };
 
 
--- .pc/aio-vector.patch/include/linux/aio.h    2004-10-14 12:58:38 -07:00
+++ include/linux/aio.h    2004-10-14 12:58:40 -07:00
@@ -4,6 +4,7 @@
 #include <linux/list.h>
 #include <linux/workqueue.h>
 #include <linux/aio_abi.h>
+#include <linux/uio.h>
 
 #include <asm/atomic.h>
 
@@ -67,7 +68,20 @@ struct kiocb {
     /* State that we remember to be able to restart/retry  */
     unsigned short        ki_opcode;
     size_t            ki_nbytes;     /* copy of iocb->aio_nbytes */
-    char             __user *ki_buf;    /* remaining iocb->aio_buf */
+
+        /* Used for PREAD, PWRITE */
+        struct iovec            ki_fast_iov;
+
+     /* Used for PREADV and PWRITEV. iov is kmalloced. */
+        struct iovec            *ki_slow_iov;
+
+     /* ki_iov points to either &ki_short_iov or ki_long_iov,
+        depending on the value of ki_nr_segs. Its pointers are
+        incremented as more data is read or written
+        asynchronously. */
+     struct iovec            *ki_iov;
+        unsigned long           ki_nr_segs;     /* number of iovs left. */
+
     size_t            ki_left;     /* remaining bytes */
     wait_queue_t        ki_wait;
     long            ki_retried;     /* just for testing */
--- .pc/aio-vector.patch/include/linux/aio_abi.h    2004-10-14 12:58:38 
-07:00
+++ include/linux/aio_abi.h    2004-10-14 12:58:40 -07:00
@@ -41,6 +41,8 @@ enum {
      * IOCB_CMD_POLL = 5,
      */
     IOCB_CMD_NOOP = 6,
+    IOCB_CMD_PREADV = 7,
+    IOCB_CMD_PWRITEV = 8,
 };
 
 /* read() from /dev/aio returns these structures. */
@@ -65,6 +67,27 @@ struct io_event {
  * proper padding and aio_error abstraction
  */
 
+struct io_iocb_poll {
+    __u32 events;
+};
+
+struct io_iocb_sockaddr {
+    __u64    addr;
+    __u32    len;
+};
+
+struct io_iocb_common {
+    __u64    buf;
+    __u64    nbytes;
+    __s64      offset;
+};
+
+struct io_iocb_vector {
+    struct iovec  __user *vec;
+    __u32    nr;
+    __s64     offset;
+};
+
 struct iocb {
     /* these are internal to the kernel/libc. */
     __u64    aio_data;    /* data to be returned in event's data */
@@ -76,9 +99,12 @@ struct iocb {
     __s16    aio_reqprio;
     __u32    aio_fildes;
 
-    __u64    aio_buf;
-    __u64    aio_nbytes;
-    __s64    aio_offset;
+    union {
+        struct io_iocb_common c;
+        struct io_iocb_vector v;
+        struct io_iocb_poll poll;
+        struct io_iocb_sockaddr    saddr;
+    } u;
 
     /* extra parameters */
     __u64    aio_reserved2;    /* TODO: use this for a (struct sigevent 
*) */
--- .pc/aio-vector.patch/include/linux/fs.h    2004-10-14 12:58:38 -07:00
+++ include/linux/fs.h    2004-10-14 12:58:40 -07:00
@@ -967,6 +967,7 @@ struct file_operations {
     loff_t (*llseek) (struct file *, loff_t, int);
     ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
     ssize_t (*aio_read) (struct kiocb *, char __user *, size_t, loff_t);
+
     ssize_t (*write) (struct file *, const char __user *, size_t, 
loff_t *);
     ssize_t (*aio_write) (struct kiocb *, const char __user *, size_t, 
loff_t);
     int (*readdir) (struct file *, void *, filldir_t);
@@ -984,6 +985,10 @@ struct file_operations {
     ssize_t (*writev) (struct file *, const struct iovec *, unsigned 
long, loff_t *);
     ssize_t (*sendfile) (struct file *, loff_t *, size_t, read_actor_t, 
void *);
     ssize_t (*sendpage) (struct file *, struct page *, int, size_t, 
loff_t *, int);
+    /* For aio_readv and aio_writev, the iovec and offset are passed
+       through kiocb->ki_iov, ki_nr_segs, and ki_pos. */
+    ssize_t (*aio_readv) (struct kiocb *);
+        ssize_t (*aio_writev) (struct kiocb *);
     unsigned long (*get_unmapped_area)(struct file *, unsigned long, 
unsigned long, unsigned long, unsigned long);
     int (*check_flags)(int);
     int (*dir_notify)(struct file *filp, unsigned long arg);
@@ -1508,8 +1513,9 @@ extern ssize_t generic_file_read(struct
 int generic_write_checks(struct file *file, loff_t *pos, size_t *count, 
int isblk);
 extern ssize_t generic_file_write(struct file *, const char __user *, 
size_t, loff_t *);
 extern ssize_t generic_file_aio_read(struct kiocb *, char __user *, 
size_t, loff_t);
-extern ssize_t __generic_file_aio_read(struct kiocb *, const struct 
iovec *, unsigned long, loff_t *);
+extern ssize_t generic_file_aio_readv(struct kiocb *);
 extern ssize_t generic_file_aio_write(struct kiocb *, const char __user 
*, size_t, loff_t);
+extern ssize_t generic_file_aio_writev(struct kiocb *);
 extern ssize_t generic_file_aio_write_nolock(struct kiocb *, const 
struct iovec *,
         unsigned long, loff_t *);
 extern ssize_t generic_file_direct_write(struct kiocb *, const struct 
iovec *,
--- .pc/aio-vector.patch/include/linux/nfs_fs.h    2004-10-14 12:58:38 
-07:00
+++ include/linux/nfs_fs.h    2004-10-14 12:58:40 -07:00
@@ -337,10 +337,9 @@ static inline struct rpc_cred *nfs_file_
  */
 extern ssize_t nfs_direct_IO(int, struct kiocb *, const struct iovec *, 
loff_t,
             unsigned long);
-extern ssize_t nfs_file_direct_read(struct kiocb *iocb, char __user *buf,
-            size_t count, loff_t pos);
-extern ssize_t nfs_file_direct_write(struct kiocb *iocb, const char 
__user *buf,
-            size_t count, loff_t pos);
+/* iov, #iov, and offset are passed through iocb ki_iov, ki_pos. */
+extern ssize_t nfs_file_direct_readv(struct kiocb *iocb);
+extern ssize_t nfs_file_direct_writev(struct kiocb *iocb);
 
 /*
  * linux/fs/nfs/dir.c
--- .pc/aio-vector.patch/mm/filemap.c    2004-10-14 12:58:39 -07:00
+++ mm/filemap.c    2004-10-14 12:58:40 -07:00
@@ -998,7 +998,13 @@ generic_file_aio_read(struct kiocb *iocb
     BUG_ON(iocb->ki_pos != pos);
     return __generic_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
 }
+EXPORT_SYMBOL(generic_file_aio_readv);
 
+ssize_t
+generic_file_aio_readv(struct kiocb *iocb)
+{
+        return __generic_file_aio_read(iocb, iocb->ki_iov, 
iocb->ki_nr_segs, &iocb->ki_pos);
+}
 EXPORT_SYMBOL(generic_file_aio_read);
 
 ssize_t
@@ -2125,20 +2131,17 @@ generic_file_write_nolock(struct file *f
 
 EXPORT_SYMBOL(generic_file_write_nolock);
 
-ssize_t generic_file_aio_write(struct kiocb *iocb, const char __user *buf,
-                   size_t count, loff_t pos)
+EXPORT_SYMBOL(generic_file_aio_writev);
+ssize_t generic_file_aio_writev(struct kiocb *iocb)
 {
     struct file *file = iocb->ki_filp;
     struct address_space *mapping = file->f_mapping;
     struct inode *inode = mapping->host;
     ssize_t ret;
-    struct iovec local_iov = { .iov_base = (void __user *)buf,
-                    .iov_len = count };
-
-    BUG_ON(iocb->ki_pos != pos);
+     loff_t pos = iocb->ki_pos;
 
     down(&inode->i_sem);
-    ret = generic_file_aio_write_nolock(iocb, &local_iov, 1,
+    ret = generic_file_aio_write_nolock(iocb, iocb->ki_iov, 
iocb->ki_nr_segs,
                         &iocb->ki_pos);
     up(&inode->i_sem);
 
@@ -2151,7 +2154,17 @@ ssize_t generic_file_aio_write(struct ki
     }
     return ret;
 }
+
 EXPORT_SYMBOL(generic_file_aio_write);
+ssize_t generic_file_aio_write(struct kiocb *iocb, const char __user *buf,
+                   size_t count, loff_t pos)
+{
+        /* aio_write is a legacy interface. */
+        BUG_ON(buf != iocb->ki_iov[0].iov_base
+           || count != iocb->ki_iov[0].iov_len
+           || pos != iocb->ki_pos);
+    return generic_file_aio_writev(iocb);
+}
 
 ssize_t generic_file_write(struct file *file, const char __user *buf,
                size_t count, loff_t *ppos)
--- .pc/aio-vector.patch/net/socket.c    2004-10-14 12:58:38 -07:00
+++ net/socket.c    2004-10-14 12:58:40 -07:00
@@ -99,6 +99,8 @@ static ssize_t sock_aio_read(struct kioc
              size_t size, loff_t pos);
 static ssize_t sock_aio_write(struct kiocb *iocb, const char __user *buf,
               size_t size, loff_t pos);
+static ssize_t sock_aio_readv(struct kiocb *iocb);
+static ssize_t sock_aio_writev(struct kiocb *iocb);
 static int sock_mmap(struct file *file, struct vm_area_struct * vma);
 
 static int sock_close(struct inode *inode, struct file *file);
@@ -125,6 +127,8 @@ static struct file_operations socket_fil
     .llseek =    no_llseek,
     .aio_read =    sock_aio_read,
     .aio_write =    sock_aio_write,
+    .aio_readv =    sock_aio_readv,
+    .aio_writev =    sock_aio_writev,
     .poll =        sock_poll,
     .ioctl =    sock_ioctl,
     .mmap =        sock_mmap,
@@ -640,15 +644,15 @@ static void sock_aio_dtor(struct kiocb *
  *    area ubuf...ubuf+size-1 is writable before asking the protocol.
  */
 
-static ssize_t sock_aio_read(struct kiocb *iocb, char __user *ubuf,
-             size_t size, loff_t pos)
+static ssize_t sock_aio_readv(struct kiocb *iocb)
 {
     struct sock_iocb *x, siocb;
     struct socket *sock;
-    int flags;
+    const struct iovec *iov = iocb->ki_iov;
+    unsigned long nr_segs = iocb->ki_nr_segs;
 
-    if (pos != 0)
-        return -ESPIPE;
+    int flags;
+    size_t size = iov_length(iov, nr_segs);
     if (size==0)        /* Match SYS5 behaviour */
         return 0;
 
@@ -666,31 +670,46 @@ static ssize_t sock_aio_read(struct kioc
 
     x->async_msg.msg_name = NULL;
     x->async_msg.msg_namelen = 0;
-    x->async_msg.msg_iov = &x->async_iov;
-    x->async_msg.msg_iovlen = 1;
     x->async_msg.msg_control = NULL;
     x->async_msg.msg_controllen = 0;
-    x->async_iov.iov_base = ubuf;
-    x->async_iov.iov_len = size;
+    if (nr_segs == 1) {
+        // handle sock_aio_read that may pass iov on the stack.
+        x->async_msg.msg_iov = &x->async_iov;
+        x->async_msg.msg_iovlen = 1;
+        x->async_iov.iov_base = iov[0].iov_base;
+        x->async_iov.iov_len = iov[0].iov_len;
+    } else {
+        // we can assume that iov is held in iocb and not
+        // freed until x is freed.
+        x->async_msg.msg_iov = (struct iovec*)iov;
+        x->async_msg.msg_iovlen = nr_segs;
+    }
     flags = !(iocb->ki_filp->f_flags & O_NONBLOCK) ? 0 : MSG_DONTWAIT;
 
     return __sock_recvmsg(iocb, sock, &x->async_msg, size, flags);
 }
-
-
+static ssize_t sock_aio_read(struct kiocb *iocb, char __user *ubuf,
+             size_t size, loff_t pos)
+{
+        /* aio_read is a legacy interface. */
+        BUG_ON(ubuf != iocb->ki_iov[0].iov_base
+           || size != iocb->ki_iov[0].iov_len
+           || pos != iocb->ki_pos);
+    return sock_aio_readv(iocb);
+}
 /*
  *    Write data to a socket. We verify that the user area 
ubuf..ubuf+size-1
  *    is readable by the user process.
  */
 
-static ssize_t sock_aio_write(struct kiocb *iocb, const char __user *ubuf,
-              size_t size, loff_t pos)
+static ssize_t sock_aio_writev(struct kiocb *iocb)
 {
     struct sock_iocb *x, siocb;
     struct socket *sock;
-   
-    if (pos != 0)
-        return -ESPIPE;
+    struct iovec *iov = iocb->ki_iov;
+    unsigned long nr_segs = iocb->ki_nr_segs;
+
+    size_t size = iov_length(iov, nr_segs);
     if(size==0)        /* Match SYS5 behaviour */
         return 0;
 
@@ -708,17 +727,34 @@ static ssize_t sock_aio_write(struct kio
 
     x->async_msg.msg_name = NULL;
     x->async_msg.msg_namelen = 0;
-    x->async_msg.msg_iov = &x->async_iov;
-    x->async_msg.msg_iovlen = 1;
     x->async_msg.msg_control = NULL;
     x->async_msg.msg_controllen = 0;
     x->async_msg.msg_flags = !(iocb->ki_filp->f_flags & O_NONBLOCK) ? 0 
: MSG_DONTWAIT;
+    if (nr_segs == 1) {
+        // handle sock_aio_read that may pass iov on the stack.
+        x->async_msg.msg_iov = &x->async_iov;
+        x->async_msg.msg_iovlen = 1;
+        x->async_iov.iov_base = iov[0].iov_base;
+        x->async_iov.iov_len = iov[0].iov_len;
+    } else {
+        // we can assume that iov is held in iocb and not
+        // freed until x is freed.
+        x->async_msg.msg_iov = (struct iovec*)iov;
+        x->async_msg.msg_iovlen = nr_segs;
+    }
     if (sock->type == SOCK_SEQPACKET)
         x->async_msg.msg_flags |= MSG_EOR;
-    x->async_iov.iov_base = (void __user *)ubuf;
-    x->async_iov.iov_len = size;
    
     return __sock_sendmsg(iocb, sock, &x->async_msg, size);
+}
+static ssize_t sock_aio_write(struct kiocb *iocb, const char __user *ubuf,
+             size_t size, loff_t pos)
+{
+        /* aio_write is a legacy interface. */
+        BUG_ON(ubuf != iocb->ki_iov[0].iov_base
+           || size != iocb->ki_iov[0].iov_len
+           || pos != iocb->ki_pos);
+    return sock_aio_writev(iocb);
 }
 
 ssize_t sock_sendpage(struct file *file, struct page *page,

