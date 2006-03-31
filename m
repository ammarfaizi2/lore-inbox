Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWCaLyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWCaLyP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 06:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWCaLyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 06:54:15 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:58561 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751328AbWCaLyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 06:54:14 -0500
Date: Fri, 31 Mar 2006 13:54:12 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: "Unimplemented system call" wrong?
Message-ID: <Pine.LNX.4.61.0603311340040.18342@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


in the kernel log, I found this message the other day:
Mar 30 10:06:30 localhost kernel: Unimplemented SPARC system call 139

Looking it up in arch/sparc64/kernel/systbls.S shows that 139 maps to 
compat_sys_stat64.

arch/sparc64/kernel/sys_sparc32.c contains a cp_compat_stat64() function 
which is called from compat_sys_stat64(); here's a little excerpt:

int cp_compat_stat64(struct kstat *stat, struct compat_stat64 __user 
*statbuf)
{
        int err;

        err  = put_user(huge_encode_dev(stat->dev), &statbuf->st_dev);
        err |= put_user(stat->ino, &statbuf->st_ino);
        err |= put_user(stat->mode, &statbuf->st_mode);
        ...
        return err;
}

I seriously doubt that put_user() can return -ENOSYS (the kernel would be 
pretty useless then). I rather think someone borked the error reporting 
here by ORing error values. Let's imagine that

  err  = put_user(huge_enc...    returns ENOENT
  err |= put_user(stat->in...    returns EINTR
  err |= put_user(stat->mo...    returns EPIPE

ENOENT/EINTR/EPIPE may be dumb for put_user too, but it shows the problem 
with |. err is now 00100110 in binary (sign omitted). ENOSYS. Although it 
should have been, preferably ENOENT (in this example case).

Here are two patches (varying in coding style) that try to resolve this issue.
There are many more places within the kernel that use the |= technique.
Any thoughts on the issue?

--- arch/sparc64/kernel/sys_sparc32.c~	2006-01-29 10:59:36.000000000 +0100
+++ arch/sparc64/kernel/sys_sparc32.c	2006-03-31 13:50:47.046525000 +0200
@@ -345,23 +345,40 @@ int cp_compat_stat(struct kstat *stat, s
 		return -EOVERFLOW;
 
 	err  = put_user(old_encode_dev(stat->dev), &statbuf->st_dev);
-	err |= put_user(stat->ino, &statbuf->st_ino);
-	err |= put_user(stat->mode, &statbuf->st_mode);
-	err |= put_user(stat->nlink, &statbuf->st_nlink);
-	err |= put_user(high2lowuid(stat->uid), &statbuf->st_uid);
-	err |= put_user(high2lowgid(stat->gid), &statbuf->st_gid);
-	err |= put_user(old_encode_dev(stat->rdev), &statbuf->st_rdev);
-	err |= put_user(stat->size, &statbuf->st_size);
-	err |= put_user(stat->atime.tv_sec, &statbuf->st_atime);
-	err |= put_user(stat->atime.tv_nsec, &statbuf->st_atime_nsec);
-	err |= put_user(stat->mtime.tv_sec, &statbuf->st_mtime);
-	err |= put_user(stat->mtime.tv_nsec, &statbuf->st_mtime_nsec);
-	err |= put_user(stat->ctime.tv_sec, &statbuf->st_ctime);
-	err |= put_user(stat->ctime.tv_nsec, &statbuf->st_ctime_nsec);
-	err |= put_user(stat->blksize, &statbuf->st_blksize);
-	err |= put_user(stat->blocks, &statbuf->st_blocks);
-	err |= put_user(0, &statbuf->__unused4[0]);
-	err |= put_user(0, &statbuf->__unused4[1]);
+        if(err != 0) return err;
+	err = put_user(stat->ino, &statbuf->st_ino);
+        if(err != 0) return err;
+	err = put_user(stat->mode, &statbuf->st_mode);
+        if(err != 0) return err;
+	err = put_user(stat->nlink, &statbuf->st_nlink);
+        if(err != 0) return err;
+	err = put_user(high2lowuid(stat->uid), &statbuf->st_uid);
+        if(err != 0) return err;
+	err = put_user(high2lowgid(stat->gid), &statbuf->st_gid);
+        if(err != 0) return err;
+	err = put_user(old_encode_dev(stat->rdev), &statbuf->st_rdev);
+        if(err != 0) return err;
+	err = put_user(stat->size, &statbuf->st_size);
+        if(err != 0) return err;
+	err = put_user(stat->atime.tv_sec, &statbuf->st_atime);
+        if(err != 0) return err;
+	err = put_user(stat->atime.tv_nsec, &statbuf->st_atime_nsec);
+        if(err != 0) return err;
+	err = put_user(stat->mtime.tv_sec, &statbuf->st_mtime);
+        if(err != 0) return err;
+	err = put_user(stat->mtime.tv_nsec, &statbuf->st_mtime_nsec);
+        if(err != 0) return err;
+	err = put_user(stat->ctime.tv_sec, &statbuf->st_ctime);
+        if(err != 0) return err;
+	err = put_user(stat->ctime.tv_nsec, &statbuf->st_ctime_nsec);
+        if(err != 0) return err;
+	err = put_user(stat->blksize, &statbuf->st_blksize);
+        if(err != 0) return err;
+	err = put_user(stat->blocks, &statbuf->st_blocks);
+        if(err != 0) return err;
+	err = put_user(0, &statbuf->__unused4[0]);
+        if(err != 0) return err;
+	err = put_user(0, &statbuf->__unused4[1]);
 
 	return err;
 }
@@ -370,27 +387,47 @@ int cp_compat_stat64(struct kstat *stat,
 {
 	int err;
 
-	err  = put_user(huge_encode_dev(stat->dev), &statbuf->st_dev);
-	err |= put_user(stat->ino, &statbuf->st_ino);
-	err |= put_user(stat->mode, &statbuf->st_mode);
-	err |= put_user(stat->nlink, &statbuf->st_nlink);
-	err |= put_user(stat->uid, &statbuf->st_uid);
-	err |= put_user(stat->gid, &statbuf->st_gid);
-	err |= put_user(huge_encode_dev(stat->rdev), &statbuf->st_rdev);
-	err |= put_user(0, (unsigned long __user *) &statbuf->__pad3[0]);
-	err |= put_user(stat->size, &statbuf->st_size);
-	err |= put_user(stat->blksize, &statbuf->st_blksize);
-	err |= put_user(0, (unsigned int __user *) &statbuf->__pad4[0]);
-	err |= put_user(0, (unsigned int __user *) &statbuf->__pad4[4]);
-	err |= put_user(stat->blocks, &statbuf->st_blocks);
-	err |= put_user(stat->atime.tv_sec, &statbuf->st_atime);
-	err |= put_user(stat->atime.tv_nsec, &statbuf->st_atime_nsec);
-	err |= put_user(stat->mtime.tv_sec, &statbuf->st_mtime);
-	err |= put_user(stat->mtime.tv_nsec, &statbuf->st_mtime_nsec);
-	err |= put_user(stat->ctime.tv_sec, &statbuf->st_ctime);
-	err |= put_user(stat->ctime.tv_nsec, &statbuf->st_ctime_nsec);
-	err |= put_user(0, &statbuf->__unused4);
-	err |= put_user(0, &statbuf->__unused5);
+	err = put_user(huge_encode_dev(stat->dev), &statbuf->st_dev);
+        if(err != 0) return err;
+	err = put_user(stat->ino, &statbuf->st_ino);
+        if(err != 0) return err;
+	err = put_user(stat->mode, &statbuf->st_mode);
+        if(err != 0) return err;
+	err = put_user(stat->nlink, &statbuf->st_nlink);
+        if(err != 0) return err;
+	err = put_user(stat->uid, &statbuf->st_uid);
+        if(err != 0) return err;
+	err = put_user(stat->gid, &statbuf->st_gid);
+        if(err != 0) return err;
+	err = put_user(huge_encode_dev(stat->rdev), &statbuf->st_rdev);
+        if(err != 0) return err;
+	err = put_user(0, (unsigned long __user *) &statbuf->__pad3[0]);
+        if(err != 0) return err;
+	err = put_user(stat->size, &statbuf->st_size);
+        if(err != 0) return err;
+	err = put_user(stat->blksize, &statbuf->st_blksize);
+        if(err != 0) return err;
+	err = put_user(0, (unsigned int __user *) &statbuf->__pad4[0]);
+        if(err != 0) return err;
+	err = put_user(0, (unsigned int __user *) &statbuf->__pad4[4]);
+        if(err != 0) return err;
+	err = put_user(stat->blocks, &statbuf->st_blocks);
+        if(err != 0) return err;
+	err = put_user(stat->atime.tv_sec, &statbuf->st_atime);
+        if(err != 0) return err;
+	err = put_user(stat->atime.tv_nsec, &statbuf->st_atime_nsec);
+        if(err != 0) return err;
+	err = put_user(stat->mtime.tv_sec, &statbuf->st_mtime);
+        if(err != 0) return err;
+	err = put_user(stat->mtime.tv_nsec, &statbuf->st_mtime_nsec);
+        if(err != 0) return err;
+	err = put_user(stat->ctime.tv_sec, &statbuf->st_ctime);
+        if(err != 0) return err;
+	err = put_user(stat->ctime.tv_nsec, &statbuf->st_ctime_nsec);
+        if(err != 0) return err;
+	err = put_user(0, &statbuf->__unused4);
+        if(err != 0) return err;
+	err = put_user(0, &statbuf->__unused5);
 
 	return err;
 }
#<<eof>>

--- arch/sparc64/kernel/sys_sparc32.c~	2006-01-29 10:59:36.000000000 +0100
+++ arch/sparc64/kernel/sys_sparc32.c	2006-03-31 13:52:24.366525000 +0200
@@ -344,24 +344,25 @@ int cp_compat_stat(struct kstat *stat, s
 	    !old_valid_dev(stat->rdev))
 		return -EOVERFLOW;
 
-	err  = put_user(old_encode_dev(stat->dev), &statbuf->st_dev);
-	err |= put_user(stat->ino, &statbuf->st_ino);
-	err |= put_user(stat->mode, &statbuf->st_mode);
-	err |= put_user(stat->nlink, &statbuf->st_nlink);
-	err |= put_user(high2lowuid(stat->uid), &statbuf->st_uid);
-	err |= put_user(high2lowgid(stat->gid), &statbuf->st_gid);
-	err |= put_user(old_encode_dev(stat->rdev), &statbuf->st_rdev);
-	err |= put_user(stat->size, &statbuf->st_size);
-	err |= put_user(stat->atime.tv_sec, &statbuf->st_atime);
-	err |= put_user(stat->atime.tv_nsec, &statbuf->st_atime_nsec);
-	err |= put_user(stat->mtime.tv_sec, &statbuf->st_mtime);
-	err |= put_user(stat->mtime.tv_nsec, &statbuf->st_mtime_nsec);
-	err |= put_user(stat->ctime.tv_sec, &statbuf->st_ctime);
-	err |= put_user(stat->ctime.tv_nsec, &statbuf->st_ctime_nsec);
-	err |= put_user(stat->blksize, &statbuf->st_blksize);
-	err |= put_user(stat->blocks, &statbuf->st_blocks);
-	err |= put_user(0, &statbuf->__unused4[0]);
-	err |= put_user(0, &statbuf->__unused4[1]);
+	if((err = put_user(old_encode_dev(stat->dev), &statbuf->st_dev)) == 0)
+	if((err = put_user(stat->ino, &statbuf->st_ino)) == 0)
+	if((err = put_user(stat->mode, &statbuf->st_mode) == 0)
+	if((err = put_user(stat->nlink, &statbuf->st_nlink) == 0)
+	if((err = put_user(high2lowuid(stat->uid), &statbuf->st_uid) == 0)
+	if((err = put_user(high2lowgid(stat->gid), &statbuf->st_gid) == 0)
+	if((err = put_user(old_encode_dev(stat->rdev), &statbuf->st_rdev) == 0)
+	if((err = put_user(stat->size, &statbuf->st_size) == 0)
+	if((err = put_user(stat->atime.tv_sec, &statbuf->st_atime) == 0)
+	if((err = put_user(stat->atime.tv_nsec, &statbuf->st_atime_nsec) == 0)
+	if((err = put_user(stat->mtime.tv_sec, &statbuf->st_mtime) == 0)
+	if((err = put_user(stat->mtime.tv_nsec, &statbuf->st_mtime_nsec) == 0)
+	if((err = put_user(stat->ctime.tv_sec, &statbuf->st_ctime) == 0)
+	if((err = put_user(stat->ctime.tv_nsec, &statbuf->st_ctime_nsec) == 0)
+	if((err = put_user(stat->blksize, &statbuf->st_blksize) == 0)
+	if((err = put_user(stat->blocks, &statbuf->st_blocks) == 0)
+	if((err = put_user(0, &statbuf->__unused4[0]) == 0)
+	if((err = put_user(0, &statbuf->__unused4[1]) == 0)
+            return 0;
 
 	return err;
 }
@@ -370,27 +371,28 @@ int cp_compat_stat64(struct kstat *stat,
 {
 	int err;
 
-	err  = put_user(huge_encode_dev(stat->dev), &statbuf->st_dev);
-	err |= put_user(stat->ino, &statbuf->st_ino);
-	err |= put_user(stat->mode, &statbuf->st_mode);
-	err |= put_user(stat->nlink, &statbuf->st_nlink);
-	err |= put_user(stat->uid, &statbuf->st_uid);
-	err |= put_user(stat->gid, &statbuf->st_gid);
-	err |= put_user(huge_encode_dev(stat->rdev), &statbuf->st_rdev);
-	err |= put_user(0, (unsigned long __user *) &statbuf->__pad3[0]);
-	err |= put_user(stat->size, &statbuf->st_size);
-	err |= put_user(stat->blksize, &statbuf->st_blksize);
-	err |= put_user(0, (unsigned int __user *) &statbuf->__pad4[0]);
-	err |= put_user(0, (unsigned int __user *) &statbuf->__pad4[4]);
-	err |= put_user(stat->blocks, &statbuf->st_blocks);
-	err |= put_user(stat->atime.tv_sec, &statbuf->st_atime);
-	err |= put_user(stat->atime.tv_nsec, &statbuf->st_atime_nsec);
-	err |= put_user(stat->mtime.tv_sec, &statbuf->st_mtime);
-	err |= put_user(stat->mtime.tv_nsec, &statbuf->st_mtime_nsec);
-	err |= put_user(stat->ctime.tv_sec, &statbuf->st_ctime);
-	err |= put_user(stat->ctime.tv_nsec, &statbuf->st_ctime_nsec);
-	err |= put_user(0, &statbuf->__unused4);
-	err |= put_user(0, &statbuf->__unused5);
+	if((err = put_user(huge_encode_dev(stat->dev), &statbuf->st_dev) == 0)
+	if((err = put_user(stat->ino, &statbuf->st_ino) == 0)
+	if((err = put_user(stat->mode, &statbuf->st_mode) == 0)
+	if((err = put_user(stat->nlink, &statbuf->st_nlink) == 0)
+	if((err = put_user(stat->uid, &statbuf->st_uid) == 0)
+	if((err = put_user(stat->gid, &statbuf->st_gid) == 0)
+	if((err = put_user(huge_encode_dev(stat->rdev), &statbuf->st_rdev) == 0)
+	if((err = put_user(0, (unsigned long __user *) &statbuf->__pad3[0]) == 0)
+	if((err = put_user(stat->size, &statbuf->st_size) == 0)
+	if((err = put_user(stat->blksize, &statbuf->st_blksize) == 0)
+	if((err = put_user(0, (unsigned int __user *) &statbuf->__pad4[0]) == 0)
+	if((err = put_user(0, (unsigned int __user *) &statbuf->__pad4[4]) == 0)
+	if((err = put_user(stat->blocks, &statbuf->st_blocks) == 0)
+	if((err = put_user(stat->atime.tv_sec, &statbuf->st_atime) == 0)
+	if((err = put_user(stat->atime.tv_nsec, &statbuf->st_atime_nsec) == 0)
+	if((err = put_user(stat->mtime.tv_sec, &statbuf->st_mtime) == 0)
+	if((err = put_user(stat->mtime.tv_nsec, &statbuf->st_mtime_nsec) == 0)
+	if((err = put_user(stat->ctime.tv_sec, &statbuf->st_ctime) == 0)
+	if((err = put_user(stat->ctime.tv_nsec, &statbuf->st_ctime_nsec) == 0)
+	if((err = put_user(0, &statbuf->__unused4) == 0)
+	if((err = put_user(0, &statbuf->__unused5) == 0)
+            return 0;
 
 	return err;
 }
#<<eof>>

Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
