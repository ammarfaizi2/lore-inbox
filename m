Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbTEBRDD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 13:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTEBRDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 13:03:03 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:43953 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263018AbTEBRCX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 13:02:23 -0400
Date: Fri, 2 May 2003 22:47:26 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reducing overheads in fget/fput
Message-ID: <20030502171726.GA1414@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030428165240.GA1105@in.ibm.com> <20030428193228.GP10374@parcelfarce.linux.theplanet.co.uk> <20030428195836.GD1105@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030428195836.GD1105@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 01:28:36AM +0530, Dipankar Sarma wrote:
> On Mon, Apr 28, 2003 at 08:32:28PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > You are.  Have a process share file table at the time of call and
> > have its sibling die in the middle.  Oops - condition that had
> > been true at time of fget_light() (->files->count > 1) is false
> > at the time we fput_light().  Have fun - we had just leaked a
> > reference to struct file.
> 
> That shouldn't be very difficult to fix. For the fget_light/fput_light
> pair in a syscall, we make the files->count == 1 check only once at the 
> beginning. Do you see a problem with that ?

Here is a patch that fixes that. I re-did the measurements with
Andrew's experiment (dd if=/dev/zero of=foo bs=1 count=1M).
[4CPU P3 xeon with 1MB L2 cache and 512MB ram]

kernel           sys time     std-dev
------------     --------     -------
UP - vanilla     2.104        0.028
SMP - vanilla    2.976        0.023
UP - file        1.867        0.019
SMP - file       2.719        0.026

Thanks
Dipankar


diff -urN linux-2.5.66-base/fs/file_table.c linux-2.5.66-file/fs/file_table.c
--- linux-2.5.66-base/fs/file_table.c	2003-03-25 03:29:55.000000000 +0530
+++ linux-2.5.66-file/fs/file_table.c	2003-05-02 21:23:27.000000000 +0530
@@ -147,6 +147,13 @@
 		__fput(file);
 }
 
+void fput_light(struct file * file, int flag)
+{
+	if (unlikely(flag))
+		if (atomic_dec_and_test(&file->f_count))
+			__fput(file);
+}
+
 /* __fput is called from task context when aio completion releases the last
  * last use of a struct file *.  Do not use otherwise.
  */
@@ -190,6 +197,34 @@
 	return file;
 }
 
+/*
+ * Lightweight file lookup - no refcnt increment if fd table isn't shared. 
+ * You can use this only if it is guranteed that the current task already 
+ * holds a refcnt to that file. That check has to be done at fget() only
+ * and a flag is returned to be passed to the corresponding fput_light().
+ * There must not be a cloning between an fget_light/fput_light pair.
+ */
+struct file *fget_light(unsigned int fd, int *flag)
+{
+	struct file *file;
+	struct files_struct *files = current->files;
+
+	*flag = 0;
+	if (likely((atomic_read(&files->count) == 1))) {
+		file = fcheck(fd);
+	} else {
+		read_lock(&files->file_lock);
+		file = fcheck(fd);
+		if (file) {
+			get_file(file);
+			*flag = 1;
+		}
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
+++ linux-2.5.66-file/fs/read_write.c	2003-05-02 13:42:53.000000000 +0530
@@ -115,9 +115,10 @@
 {
 	off_t retval;
 	struct file * file;
+	int flag;
 
 	retval = -EBADF;
-	file = fget(fd);
+	file = fget_light(fd, &flag);
 	if (!file)
 		goto bad;
 
@@ -128,7 +129,7 @@
 		if (res != (loff_t)retval)
 			retval = -EOVERFLOW;	/* LFS: should only happen on 32 bit platforms */
 	}
-	fput(file);
+	fput_light(file, flag);
 bad:
 	return retval;
 }
@@ -141,9 +142,10 @@
 	int retval;
 	struct file * file;
 	loff_t offset;
+	int flag;
 
 	retval = -EBADF;
-	file = fget(fd);
+	file = fget_light(fd, &flag);
 	if (!file)
 		goto bad;
 
@@ -161,7 +163,7 @@
 			retval = 0;
 	}
 out_putf:
-	fput(file);
+	fput_light(file, flag);
 bad:
 	return retval;
 }
@@ -251,11 +253,12 @@
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
+	int flag;
 
-	file = fget(fd);
+	file = fget_light(fd, &flag);
 	if (file) {
 		ret = vfs_read(file, buf, count, &file->f_pos);
-		fput(file);
+		fput_light(file, flag);
 	}
 
 	return ret;
@@ -265,11 +268,12 @@
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
+	int flag;
 
-	file = fget(fd);
+	file = fget_light(fd, &flag);
 	if (file) {
 		ret = vfs_write(file, buf, count, &file->f_pos);
-		fput(file);
+		fput_light(file, flag);
 	}
 
 	return ret;
@@ -280,14 +284,15 @@
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
+	int flag;
 
 	if (pos < 0)
 		return -EINVAL;
 
-	file = fget(fd);
+	file = fget_light(fd, &flag);
 	if (file) {
 		ret = vfs_read(file, buf, count, &pos);
-		fput(file);
+		fput_light(file, flag);
 	}
 
 	return ret;
@@ -298,14 +303,15 @@
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
+	int flag;
 
 	if (pos < 0)
 		return -EINVAL;
 
-	file = fget(fd);
+	file = fget_light(fd, &flag);
 	if (file) {
 		ret = vfs_write(file, buf, count, &pos);
-		fput(file);
+		fput_light(file, flag);
 	}
 
 	return ret;
@@ -479,11 +485,12 @@
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
+	int flag;
 
-	file = fget(fd);
+	file = fget_light(fd, &flag);
 	if (file) {
 		ret = vfs_readv(file, vec, vlen, &file->f_pos);
-		fput(file);
+		fput_light(file, flag);
 	}
 
 	return ret;
@@ -494,11 +501,12 @@
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
+	int flag;
 
-	file = fget(fd);
+	file = fget_light(fd, &flag);
 	if (file) {
 		ret = vfs_writev(file, vec, vlen, &file->f_pos);
-		fput(file);
+		fput_light(file, flag);
 	}
 
 	return ret;
@@ -511,12 +519,13 @@
 	struct inode * in_inode, * out_inode;
 	loff_t pos;
 	ssize_t retval;
+	int flag_in, flag_out;
 
 	/*
 	 * Get input file, and verify that it is ok..
 	 */
 	retval = -EBADF;
-	in_file = fget(in_fd);
+	in_file = fget_light(in_fd, &flag_in);
 	if (!in_file)
 		goto out;
 	if (!(in_file->f_mode & FMODE_READ))
@@ -539,7 +548,7 @@
 	 * Get output file, and verify that it is ok..
 	 */
 	retval = -EBADF;
-	out_file = fget(out_fd);
+	out_file = fget_light(out_fd, &flag_out);
 	if (!out_file)
 		goto fput_in;
 	if (!(out_file->f_mode & FMODE_WRITE))
@@ -579,9 +588,9 @@
 		retval = -EOVERFLOW;
 
 fput_out:
-	fput(out_file);
+	fput_light(out_file, flag_out);
 fput_in:
-	fput(in_file);
+	fput_light(in_file, flag_in);
 out:
 	return retval;
 }
diff -urN linux-2.5.66-base/include/linux/file.h linux-2.5.66-file/include/linux/file.h
--- linux-2.5.66-base/include/linux/file.h	2003-03-25 03:29:52.000000000 +0530
+++ linux-2.5.66-file/include/linux/file.h	2003-05-02 13:43:31.000000000 +0530
@@ -35,7 +35,9 @@
 
 extern void FASTCALL(__fput(struct file *));
 extern void FASTCALL(fput(struct file *));
+extern void FASTCALL(fput_light(struct file *, int));
 extern struct file * FASTCALL(fget(unsigned int fd));
+extern struct file * FASTCALL(fget_light(unsigned int fd, int *flag));
 extern void FASTCALL(set_close_on_exec(unsigned int fd, int flag));
 extern void put_filp(struct file *);
 extern int get_unused_fd(void);
