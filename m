Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbTD1Qij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 12:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTD1Qij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 12:38:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:14540 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261195AbTD1Qid
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 12:38:33 -0400
Date: Mon, 28 Apr 2003 22:22:40 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] reducing overheads in fget/fput
Message-ID: <20030428165240.GA1105@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometime in the recent past there were complaints about smp overheads doubling
system time taken for a 1MB "dd" from /dev/zero. This
path is very sensitive to fget()/fput() costs predominantly from
acquiring the rwlock in files_struct and atomic increment/decrement
of file->f_count (I experimented to determine this). It seems that 
this can be avoided in some of the most common cases resulting in 
significant benefits.

The idea is that if we are not sharing the file descriptor table,
there is no need to increase the struct file refcnt or even
take the files_struct reader-writer lock while lookup up
an fd. open/close gurantees that atleast one refcount for file
struct is held and while forking (but not sharing fd table),
an additional refcount is added for the child for each open
fd. By avoiding both the rwlock and atomic operation on
file->f_count, we shave off about 0.35 seconds of system time
from the following simple test -

time dd if=/dev/zero of=foo bs=1 count=1M

Results on a 4-CPU P3 Xeon box with 512MB memory 1MB L2 cache -
(sys time in seconds)

kernel           sys time     std-dev
------------     --------     -------
UP - vanilla     2.032        0.018
SMP - vanilla    2.996        0.013
UP - file        1.991        0.034
SMP - file       2.646        0.042

I have included my experimental patch here (not meant for inclusion).
I added fget_light() and fput_light() which avoid the rwlock and
->f_count if the fd table is not shared. It seems safe provided
you are using fget_light() and fput_light() within the same
system call and are not forking after an fget_light(). To test it
I modified some common syscalls in fs/read_write.c.
It of course doesn't optimize the case when we share fd tables using 
CLONE_FILES. That case can probably be optimized using an old RCU-based 
patch that we have.

Does this approach make sense ? Or am I missing some big gotcha
somewhere ? Oh, btw the patch survives LTP.

Thanks
Dipankar



diff -urN linux-2.5.66-base/fs/file_table.c linux-2.5.66-file/fs/file_table.c
--- linux-2.5.66-base/fs/file_table.c	2003-03-25 03:29:55.000000000 +0530
+++ linux-2.5.66-file/fs/file_table.c	2003-04-28 15:36:01.000000000 +0530
@@ -147,6 +147,15 @@
 		__fput(file);
 }
 
+void fput_light(struct file * file)
+{
+	struct files_struct *files = current->files;
+
+	if (unlikely(atomic_read(&files->count) != 1))
+		if (atomic_dec_and_test(&file->f_count))
+			__fput(file);
+}
+
 /* __fput is called from task context when aio completion releases the last
  * last use of a struct file *.  Do not use otherwise.
  */
@@ -190,6 +199,29 @@
 	return file;
 }
 
+/*
+ * Lightweight file lookup - no refcnt increment if fd table isn't shared. 
+ * You can use this only if it is guranteed that the current task already 
+ * holds a refcnt to that file
+ */
+struct file *fget_light(unsigned int fd)
+{
+	struct file *file;
+	struct files_struct *files = current->files;
+
+	if (likely((atomic_read(&files->count) == 1))) {
+		file = fcheck(fd);
+	} else {
+		read_lock(&files->file_lock);
+		file = fcheck(fd);
+		if (file)
+			get_file(file);
+		read_unlock(&files->file_lock);
+	}
+	return file;
+}
+
+
 void put_filp(struct file *file)
 {
 	if (atomic_dec_and_test(&file->f_count)) {
diff -urN linux-2.5.66-base/fs/read_write.c linux-2.5.66-file/fs/read_write.c
--- linux-2.5.66-base/fs/read_write.c	2003-03-25 03:30:51.000000000 +0530
+++ linux-2.5.66-file/fs/read_write.c	2003-04-28 12:14:34.000000000 +0530
@@ -117,7 +117,7 @@
 	struct file * file;
 
 	retval = -EBADF;
-	file = fget(fd);
+	file = fget_light(fd);
 	if (!file)
 		goto bad;
 
@@ -128,7 +128,7 @@
 		if (res != (loff_t)retval)
 			retval = -EOVERFLOW;	/* LFS: should only happen on 32 bit platforms */
 	}
-	fput(file);
+	fput_light(file);
 bad:
 	return retval;
 }
@@ -143,7 +143,7 @@
 	loff_t offset;
 
 	retval = -EBADF;
-	file = fget(fd);
+	file = fget_light(fd);
 	if (!file)
 		goto bad;
 
@@ -161,7 +161,7 @@
 			retval = 0;
 	}
 out_putf:
-	fput(file);
+	fput_light(file);
 bad:
 	return retval;
 }
@@ -252,10 +252,10 @@
 	struct file *file;
 	ssize_t ret = -EBADF;
 
-	file = fget(fd);
+	file = fget_light(fd);
 	if (file) {
 		ret = vfs_read(file, buf, count, &file->f_pos);
-		fput(file);
+		fput_light(file);
 	}
 
 	return ret;
@@ -266,10 +266,10 @@
 	struct file *file;
 	ssize_t ret = -EBADF;
 
-	file = fget(fd);
+	file = fget_light(fd);
 	if (file) {
 		ret = vfs_write(file, buf, count, &file->f_pos);
-		fput(file);
+		fput_light(file);
 	}
 
 	return ret;
@@ -284,10 +284,10 @@
 	if (pos < 0)
 		return -EINVAL;
 
-	file = fget(fd);
+	file = fget_light(fd);
 	if (file) {
 		ret = vfs_read(file, buf, count, &pos);
-		fput(file);
+		fput_light(file);
 	}
 
 	return ret;
@@ -302,10 +302,10 @@
 	if (pos < 0)
 		return -EINVAL;
 
-	file = fget(fd);
+	file = fget_light(fd);
 	if (file) {
 		ret = vfs_write(file, buf, count, &pos);
-		fput(file);
+		fput_light(file);
 	}
 
 	return ret;
@@ -480,10 +480,10 @@
 	struct file *file;
 	ssize_t ret = -EBADF;
 
-	file = fget(fd);
+	file = fget_light(fd);
 	if (file) {
 		ret = vfs_readv(file, vec, vlen, &file->f_pos);
-		fput(file);
+		fput_light(file);
 	}
 
 	return ret;
@@ -495,10 +495,10 @@
 	struct file *file;
 	ssize_t ret = -EBADF;
 
-	file = fget(fd);
+	file = fget_light(fd);
 	if (file) {
 		ret = vfs_writev(file, vec, vlen, &file->f_pos);
-		fput(file);
+		fput_light(file);
 	}
 
 	return ret;
@@ -516,7 +516,7 @@
 	 * Get input file, and verify that it is ok..
 	 */
 	retval = -EBADF;
-	in_file = fget(in_fd);
+	in_file = fget_light(in_fd);
 	if (!in_file)
 		goto out;
 	if (!(in_file->f_mode & FMODE_READ))
@@ -539,7 +539,7 @@
 	 * Get output file, and verify that it is ok..
 	 */
 	retval = -EBADF;
-	out_file = fget(out_fd);
+	out_file = fget_light(out_fd);
 	if (!out_file)
 		goto fput_in;
 	if (!(out_file->f_mode & FMODE_WRITE))
@@ -579,9 +579,9 @@
 		retval = -EOVERFLOW;
 
 fput_out:
-	fput(out_file);
+	fput_light(out_file);
 fput_in:
-	fput(in_file);
+	fput_light(in_file);
 out:
 	return retval;
 }
diff -urN linux-2.5.66-base/include/linux/file.h linux-2.5.66-file/include/linux/file.h
--- linux-2.5.66-base/include/linux/file.h	2003-03-25 03:29:52.000000000 +0530
+++ linux-2.5.66-file/include/linux/file.h	2003-04-28 12:15:21.000000000 +0530
@@ -35,7 +35,9 @@
 
 extern void FASTCALL(__fput(struct file *));
 extern void FASTCALL(fput(struct file *));
+extern void FASTCALL(fput_light(struct file *));
 extern struct file * FASTCALL(fget(unsigned int fd));
+extern struct file * FASTCALL(fget_light(unsigned int fd));
 extern void FASTCALL(set_close_on_exec(unsigned int fd, int flag));
 extern void put_filp(struct file *);
 extern int get_unused_fd(void);
