Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269485AbUJLGVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269485AbUJLGVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269477AbUJLGVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:21:47 -0400
Received: from mail.renesas.com ([202.234.163.13]:19867 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S269485AbUJLGS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:18:58 -0400
Date: Tue, 12 Oct 2004 15:18:39 +0900 (JST)
Message-Id: <20041012.151839.55828533.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc4] [m32r] Remove obsolete system calls
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

This patch is for removing obsolete system calls from m32r kernel, such as 
old_mmap and old_select.

	* arch/m32r/kernel/entry.S:
	- Remove an obsolete system call, old_mmap, from the syscall table.

	* arch/m32r/kernel/sys_m32r.c:
	- Remove obsolete system calls, old_mmap() and old_select().
	- do_mmap2() is renamed to sys_mmap2().

Regards,


* CAUTION (for m32r users):
  The new kernel (applied this patch) does not have a backward
  compatibility. The new kernel and old library pair does not work.

  So, those who want to use the new kernel must use a new version of 
  glibc (the GNU C library), which uses the "mmap2(_NR_mmap2)" syscall
  for __mmap() instead of the "old_mmap(__NR_mmap)".

  The new glibc package, libc6_2.3.2.ds1-16.0.3_m32r.deb, is provided 
  on the following site, please apt-get/download it and upgrade.

    http://debian.linux-m32r.org/dists/03_cambrian/main/binary-m32r/


From: Christoph Hellwig <hch@lst.de>
Subject: remaining m32r issues
Date: Sat, 2 Oct 2004 18:00:36 +0200
> We're getting close to 2.6.9, aka the first release with official m32r
> support.  So could you please remove the obsolete syscalls from the
> default config so we don't have to support them forever?

OK. We, Linux/M32R project, decided to remove obsolete syscall support
from the m32r kernel.

From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.6.9-rc1-mm3] [m32r] Modify sys_ipc() to remove useless iBCS2 support code
Date: Mon, 6 Sep 2004 18:03:15 +0100
> > 
> > The useless iBCS2 supporting code is removed.
> > 
> > However, according to old_ syscalls, I would like to keep backward-
> > compatibility for a while, due to some old deb packages and 
> > executables for m32r.  
> > I'm struggling to rebuild and replace old packages to new ones.
> > http://debian.linux-m32r.org/
> 
> Please keep support for those as a separate patch, or at least as a 
> COFIG_ option that's marked deprecated (with a date that it's scheduled
> to be removed for)


Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/entry.S    |    3 +-
 arch/m32r/kernel/sys_m32r.c |   63 +-------------------------------------------
 2 files changed, 4 insertions(+), 62 deletions(-)


diff -ruNp a/arch/m32r/kernel/entry.S b/arch/m32r/kernel/entry.S
--- a/arch/m32r/kernel/entry.S	2004-10-05 12:39:12.000000000 +0900
+++ b/arch/m32r/kernel/entry.S	2004-10-08 10:04:56.000000000 +0900
@@ -3,6 +3,7 @@
  *
  *  Copyright (c) 2001, 2002  Hirokazu Takata, Hitoshi Yamamoto, H. Kondo
  *  Copyright (c) 2003  Hitoshi Yamamoto
+ *  Copyright (c) 2004  Hirokazu Takata <takata at linux-m32r.org>
  *
  *  Taken from i386 version.
  *    Copyright (C) 1991, 1992  Linus Torvalds
@@ -798,7 +799,7 @@ ENTRY(sys_call_table)
 	.long sys_swapon
 	.long sys_reboot
 	.long old_readdir
-	.long old_mmap			/* 90 */
+	.long sys_ni_syscall		/* 90 - old_mmap syscall holder */
 	.long sys_munmap
 	.long sys_truncate
 	.long sys_ftruncate
diff -ruNp a/arch/m32r/kernel/sys_m32r.c b/arch/m32r/kernel/sys_m32r.c
--- a/arch/m32r/kernel/sys_m32r.c	2004-10-01 11:14:54.000000000 +0900
+++ b/arch/m32r/kernel/sys_m32r.c	2004-10-08 11:47:20.000000000 +0900
@@ -7,8 +7,6 @@
  * Taken from i386 version.
  */
 
-/* $Id$ */
-
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
@@ -88,10 +86,9 @@ sys_pipe(unsigned long r0, unsigned long
 	return error;
 }
 
-static inline long do_mmap2(
-	unsigned long addr, unsigned long len,
+asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags,
-	int fd, unsigned long pgoff)
+	unsigned long fd, unsigned long pgoff)
 {
 	int error = -EBADF;
 	struct file *file = NULL;
@@ -113,62 +110,6 @@ out:
 	return error;
 }
 
-asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
-	unsigned long prot, unsigned long flags,
-	unsigned long fd, unsigned long pgoff)
-{
-	return do_mmap2(addr, len, prot, flags, fd, pgoff);
-}
-
-/*
- * Perform the select(nd, in, out, ex, tv) and mmap() system
- * calls. Linux/M32R didn't use to be able to handle more than
- * 4 system call parameters, so these system calls used a memory
- * block for parameter passing..
- */
-
-struct mmap_arg_struct {
-	unsigned long addr;
-	unsigned long len;
-	unsigned long prot;
-	unsigned long flags;
-	unsigned long fd;
-	unsigned long offset;
-};
-
-asmlinkage int old_mmap(struct mmap_arg_struct *arg)
-{
-	struct mmap_arg_struct a;
-	int err = -EFAULT;
-
-	if (copy_from_user(&a, arg, sizeof(a)))
-		goto out;
-
-	err = -EINVAL;
-	if (a.offset & ~PAGE_MASK)
-		goto out;
-	err = do_mmap2(a.addr, a.len, a.prot, a.flags, a.fd,
-		a.offset>>PAGE_SHIFT);
-out:
-	return err;
-}
-
-struct sel_arg_struct {
-	unsigned long n;
-	fd_set __user *inp, *outp, *exp;
-	struct timeval __user *tvp;
-};
-
-asmlinkage int old_select(struct sel_arg_struct __user *arg)
-{
-	struct sel_arg_struct a;
-
-	if (copy_from_user(&a, arg, sizeof(a)))
-		return -EFAULT;
-	/* sys_select() does the appropriate kernel locking */
-	return sys_select(a.n, a.inp, a.outp, a.exp, a.tvp);
-}
-
 /*
  * sys_ipc() is the de-multiplexer for the SysV IPC calls..
  *

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
