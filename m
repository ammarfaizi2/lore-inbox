Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSEOOkO>; Wed, 15 May 2002 10:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316261AbSEOOkN>; Wed, 15 May 2002 10:40:13 -0400
Received: from imladris.infradead.org ([194.205.184.45]:23826 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316135AbSEOOkE>; Wed, 15 May 2002 10:40:04 -0400
Date: Wed, 15 May 2002 15:38:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup read/write
Message-ID: <20020515153841.A30869@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently sys_read/sys_pread and sys_write/sys_pwrite basically contain
lots of duplication of the same checks/code.

The patch below moves all that into vfs_read/vfs_write helpers that have
the same prototypes as the read/write file operations.  In addition I
have choosen to export these interfaces to module so people doing inkernel
file reading/writing can use these instead of duplicating the checks
(which is very likely to be done wrong).

The patch applies against 2.4 and 2.5 without changes.

--- linux-2.4.19-pre8-ac3/fs/read_write.c	Fri May  3 13:38:32 2002
+++ linux/fs/read_write.c	Wed May 15 17:19:47 2002
@@ -144,57 +144,107 @@
 }
 #endif
 
-asmlinkage ssize_t sys_read(unsigned int fd, char * buf, size_t count)
+ssize_t vfs_read(struct file *file, char *buf, size_t count, loff_t *pos)
 {
+	struct inode *inode = file->f_dentry->d_inode;
 	ssize_t ret;
-	struct file * file;
 
-	ret = -EBADF;
-	file = fget(fd);
-	if (file) {
-		if (file->f_mode & FMODE_READ) {
-			ret = locks_verify_area(FLOCK_VERIFY_READ, file->f_dentry->d_inode,
-						file, file->f_pos, count);
-			if (!ret) {
-				ssize_t (*read)(struct file *, char *, size_t, loff_t *);
-				ret = -EINVAL;
-				if (file->f_op && (read = file->f_op->read) != NULL)
-					ret = read(file, buf, count, &file->f_pos);
-			}
-		}
+	if (!(file->f_mode & FMODE_READ))
+		return -EBADF;
+	if (!file->f_op || !file->f_op->read)
+		return -EINVAL;
+	if (pos < 0)
+		return -EINVAL;
+
+	ret = locks_verify_area(FLOCK_VERIFY_READ, inode, file, *pos, count);
+	if (!ret) {
+		ret = file->f_op->read(file, buf, count, pos);
 		if (ret > 0)
 			dnotify_parent(file->f_dentry, DN_ACCESS);
+	}
+
+	return ret;
+}
+
+ssize_t vfs_write(struct file *file, const char *buf, size_t count, loff_t *pos)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	ssize_t ret;
+
+	if (!(file->f_mode & FMODE_WRITE))
+		return -EBADF;
+	if (!file->f_op || !file->f_op->write)
+		return -EINVAL;
+	if (pos < 0)
+		return -EINVAL;
+
+	ret = locks_verify_area(FLOCK_VERIFY_WRITE, inode, file, *pos, count);
+	if (!ret) {
+		ret = file->f_op->write(file, buf, count, pos);
+		if (ret > 0)
+			dnotify_parent(file->f_dentry, DN_MODIFY);
+	}
+
+	return ret;
+}
+
+asmlinkage ssize_t sys_read(unsigned int fd, char * buf, size_t count)
+{
+	struct file *file;
+	ssize_t ret = -EBADF;
+
+	file = fget(fd);
+	if (file) {
+		ret = vfs_read(file, buf, count, &file->f_pos);
 		fput(file);
 	}
+
 	return ret;
 }
 
 asmlinkage ssize_t sys_write(unsigned int fd, const char * buf, size_t count)
 {
-	ssize_t ret;
-	struct file * file;
+	struct file *file;
+	ssize_t ret = -EBADF;
 
-	ret = -EBADF;
 	file = fget(fd);
 	if (file) {
-		if (file->f_mode & FMODE_WRITE) {
-			struct inode *inode = file->f_dentry->d_inode;
-			ret = locks_verify_area(FLOCK_VERIFY_WRITE, inode, file,
-				file->f_pos, count);
-			if (!ret) {
-				ssize_t (*write)(struct file *, const char *, size_t, loff_t *);
-				ret = -EINVAL;
-				if (file->f_op && (write = file->f_op->write) != NULL)
-					ret = write(file, buf, count, &file->f_pos);
-			}
-		}
-		if (ret > 0)
-			dnotify_parent(file->f_dentry, DN_MODIFY);
+		ret = vfs_write(file, buf, count, &file->f_pos);
 		fput(file);
 	}
+
 	return ret;
 }
 
+asmlinkage ssize_t sys_pread(unsigned int fd, char *buf,
+			     size_t count, loff_t pos)
+{
+	struct file *file;
+	ssize_t ret = -EBADF;
+
+	file = fget(fd);
+	if (file) {
+		ret = vfs_read(file, buf, count, &pos);
+		fput(file);
+	}
+
+	return ret;
+}
+
+asmlinkage ssize_t sys_pwrite(unsigned int fd, const char *buf,
+			      size_t count, loff_t pos)
+{
+	struct file *file;
+	ssize_t ret = -EBADF;
+
+	file = fget(fd);
+	if (file) {
+		ret = vfs_write(file, buf, count, &pos);
+		fput(file);
+	}
+
+	return ret;
+}
 
 static ssize_t do_readv_writev(int type, struct file *file,
 			       const struct iovec * vector,
@@ -337,70 +387,3 @@
 bad_file:
 	return ret;
 }
-
-/* From the Single Unix Spec: pread & pwrite act like lseek to pos + op +
-   lseek back to original location.  They fail just like lseek does on
-   non-seekable files.  */
-
-asmlinkage ssize_t sys_pread(unsigned int fd, char * buf,
-			     size_t count, loff_t pos)
-{
-	ssize_t ret;
-	struct file * file;
-	ssize_t (*read)(struct file *, char *, size_t, loff_t *);
-
-	ret = -EBADF;
-	file = fget(fd);
-	if (!file)
-		goto bad_file;
-	if (!(file->f_mode & FMODE_READ))
-		goto out;
-	ret = locks_verify_area(FLOCK_VERIFY_READ, file->f_dentry->d_inode,
-				file, pos, count);
-	if (ret)
-		goto out;
-	ret = -EINVAL;
-	if (!file->f_op || !(read = file->f_op->read))
-		goto out;
-	if (pos < 0)
-		goto out;
-	ret = read(file, buf, count, &pos);
-	if (ret > 0)
-		dnotify_parent(file->f_dentry, DN_ACCESS);
-out:
-	fput(file);
-bad_file:
-	return ret;
-}
-
-asmlinkage ssize_t sys_pwrite(unsigned int fd, const char * buf,
-			      size_t count, loff_t pos)
-{
-	ssize_t ret;
-	struct file * file;
-	ssize_t (*write)(struct file *, const char *, size_t, loff_t *);
-
-	ret = -EBADF;
-	file = fget(fd);
-	if (!file)
-		goto bad_file;
-	if (!(file->f_mode & FMODE_WRITE))
-		goto out;
-	ret = locks_verify_area(FLOCK_VERIFY_WRITE, file->f_dentry->d_inode,
-				file, pos, count);
-	if (ret)
-		goto out;
-	ret = -EINVAL;
-	if (!file->f_op || !(write = file->f_op->write))
-		goto out;
-	if (pos < 0)
-		goto out;
-
-	ret = write(file, buf, count, &pos);
-	if (ret > 0)
-		dnotify_parent(file->f_dentry, DN_MODIFY);
-out:
-	fput(file);
-bad_file:
-	return ret;
-}
--- linux-2.4.19-pre8-ac3/kernel/ksyms.c	Tue May 14 16:52:11 2002
+++ linux/kernel/ksyms.c	Wed May 15 17:31:10 2002
@@ -242,6 +242,8 @@
 EXPORT_SYMBOL(find_inode_number);
 EXPORT_SYMBOL(is_subdir);
 EXPORT_SYMBOL(get_unused_fd);
+EXPORT_SYMBOL(vfs_read);
+EXPORT_SYMBOL(vfs_write);
 EXPORT_SYMBOL(vfs_create);
 EXPORT_SYMBOL(vfs_mkdir);
 EXPORT_SYMBOL(vfs_mknod);
--- linux-2.4.19-pre8-ac3/include/linux/fs.h	Tue May 14 16:52:10 2002
+++ linux/include/linux/fs.h	Wed May 15 17:27:52 2002
@@ -821,6 +821,9 @@
 extern int vfs_unlink(struct inode *, struct dentry *);
 extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *);
 
+extern ssize_t vfs_read(struct file *, char *, size_t, loff_t *);
+extern ssize_t vfs_write(struct file *, const char *, size_t, loff_t *);
+
 /*
  * File types
  */
