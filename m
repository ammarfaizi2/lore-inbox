Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbSJQOqN>; Thu, 17 Oct 2002 10:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261489AbSJQOqN>; Thu, 17 Oct 2002 10:46:13 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:40453 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261483AbSJQOqL>; Thu, 17 Oct 2002 10:46:11 -0400
Date: Thu, 17 Oct 2002 15:52:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: torvalds@transmeta.com, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove LSM file_llseek hook
Message-ID: <20021017155207.A28782@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	torvalds@transmeta.com, greg@kroah.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the initial discussion LSM folks agreed on this, the
rationale is that lsseek itself makes no sense to
project as mmap() and pread/pwrite() allow access to any
area of the file anyway.

--- 1.19/fs/read_write.c	Thu Oct 10 23:36:26 2002
+++ edited/fs/read_write.c	Thu Oct 17 16:40:28 2002
@@ -121,12 +121,6 @@
 	if (!file)
 		goto bad;
 
-	retval = security_ops->file_llseek(file);
-	if (retval) {
-		fput(file);
-		goto bad;
-	}
-
 	retval = -EINVAL;
 	if (origin <= 2) {
 		loff_t res = llseek(file, offset, origin);
@@ -152,10 +146,6 @@
 	file = fget(fd);
 	if (!file)
 		goto bad;
-
-	retval = security_ops->file_llseek(file);
-	if (retval)
-		goto out_putf;
 
 	retval = -EINVAL;
 	if (origin > 2)
--- 1.4/include/linux/security.h	Tue Oct  8 11:20:18 2002
+++ edited/include/linux/security.h	Thu Oct 17 16:40:44 2002
@@ -376,10 +376,6 @@
  * @file_free_security:
  *	Deallocate and free any security structures stored in file->f_security.
  *	@file contains the file structure being modified.
- * @file_llseek:
- *	Check permission before re-positioning the file offset in @file.
- *	@file contains the file structure being modified.
- *	Return 0 if permission is granted.
  * @file_ioctl:
  *	@file contains the file structure.
  *	@cmd contains the operation to perform.
@@ -790,7 +786,6 @@
 	int (*file_permission) (struct file * file, int mask);
 	int (*file_alloc_security) (struct file * file);
 	void (*file_free_security) (struct file * file);
-	int (*file_llseek) (struct file * file);
 	int (*file_ioctl) (struct file * file, unsigned int cmd,
 			   unsigned long arg);
 	int (*file_mmap) (struct file * file,
--- 1.6/security/capability.c	Tue Oct  8 11:01:30 2002
+++ edited/security/capability.c	Thu Oct 17 16:41:03 2002
@@ -442,11 +442,6 @@
 	return;
 }
 
-static int cap_file_llseek (struct file *file)
-{
-	return 0;
-}
-
 static int cap_file_ioctl (struct file *file, unsigned int command,
 			   unsigned long arg)
 {
@@ -787,7 +782,6 @@
 	.file_permission =		cap_file_permission,
 	.file_alloc_security =		cap_file_alloc_security,
 	.file_free_security =		cap_file_free_security,
-	.file_llseek =			cap_file_llseek,
 	.file_ioctl =			cap_file_ioctl,
 	.file_mmap =			cap_file_mmap,
 	.file_mprotect =		cap_file_mprotect,
--- 1.7/security/dummy.c	Tue Oct  8 11:01:30 2002
+++ edited/security/dummy.c	Thu Oct 17 16:41:06 2002
@@ -344,11 +344,6 @@
 	return;
 }
 
-static int dummy_file_llseek (struct file *file)
-{
-	return 0;
-}
-
 static int dummy_file_ioctl (struct file *file, unsigned int command,
 			     unsigned long arg)
 {
@@ -602,7 +597,6 @@
 	.file_permission =		dummy_file_permission,
 	.file_alloc_security =		dummy_file_alloc_security,
 	.file_free_security =		dummy_file_free_security,
-	.file_llseek =			dummy_file_llseek,
 	.file_ioctl =			dummy_file_ioctl,
 	.file_mmap =			dummy_file_mmap,
 	.file_mprotect =		dummy_file_mprotect,
