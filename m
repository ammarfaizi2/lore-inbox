Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318121AbSG2UIM>; Mon, 29 Jul 2002 16:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSG2UIM>; Mon, 29 Jul 2002 16:08:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318121AbSG2UIK>; Mon, 29 Jul 2002 16:08:10 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] vfs_read/vfs_write small bug fix (2.5.29)
Date: Mon, 29 Jul 2002 20:11:03 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ai47gn$1dh$1@penguin.transmeta.com>
References: <200207291825.g6TIPj026021@eng2.beaverton.ibm.com>
X-Trace: palladium.transmeta.com 1027973463 25108 127.0.0.1 (29 Jul 2002 20:11:03 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 29 Jul 2002 20:11:03 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200207291825.g6TIPj026021@eng2.beaverton.ibm.com>,
Badari Pulavarty  <pbadari@us.ibm.com> wrote:
>
>Here is a patch to fix small bug in for vfs_read/vfs_write.

Hmm. The patch is bogus, but that's not your fault, looking at the code
the patch is no more bogus than the existing code already is.

The fact is, the test for a negative "pos" should not be in
vfs_read/write at all, since it can only happen for pread/pwrite.

And pread/pwrite do not even _take_ a "loff_t" argument, they take a
"off_t", and yet we've just happily claiming they do a loff_t, which
means that they shouldn't work at all unless by pure changce user space
happens to put a zero in memory in the right place.

Cristoph, I think you're the one that did this re-org. I think the code
is wrong, and the right fix is something along these lines (untested,
you get brownie-points for testing against some standards test).

		Linus


----
===== fs/read_write.c 1.12 vs edited =====
--- 1.12/fs/read_write.c	Sat Jul 27 08:21:19 2002
+++ edited/fs/read_write.c	Mon Jul 29 12:51:09 2002
@@ -185,8 +185,6 @@
 		return -EBADF;
 	if (!file->f_op || !file->f_op->read)
 		return -EINVAL;
-	if (pos < 0)
-		return -EINVAL;
 
 	ret = locks_verify_area(FLOCK_VERIFY_READ, inode, file, *pos, count);
 	if (!ret) {
@@ -210,8 +208,6 @@
 		return -EBADF;
 	if (!file->f_op || !file->f_op->write)
 		return -EINVAL;
-	if (pos < 0)
-		return -EINVAL;
 
 	ret = locks_verify_area(FLOCK_VERIFY_WRITE, inode, file, *pos, count);
 	if (!ret) {
@@ -255,14 +251,18 @@
 }
 
 asmlinkage ssize_t sys_pread(unsigned int fd, char *buf,
-			     size_t count, loff_t pos)
+			     size_t count, off_t pos)
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
 
+	if (pos < 0)
+		return -EINVAL;
+
 	file = fget(fd);
 	if (file) {
-		ret = vfs_read(file, buf, count, &pos);
+		loff_t lpos = pos;
+		ret = vfs_read(file, buf, count, &lpos);
 		fput(file);
 	}
 
@@ -270,14 +270,18 @@
 }
 
 asmlinkage ssize_t sys_pwrite(unsigned int fd, const char *buf,
-			      size_t count, loff_t pos)
+			      size_t count, off_t pos)
 {
 	struct file *file;
 	ssize_t ret = -EBADF;
 
+	if (pos < 0)
+		return -EINVAL;
+
 	file = fget(fd);
 	if (file) {
-		ret = vfs_write(file, buf, count, &pos);
+		loff_t lpos = pos;
+		ret = vfs_write(file, buf, count, &lpos);
 		fput(file);
 	}
 

