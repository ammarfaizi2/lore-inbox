Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263273AbTCUGDA>; Fri, 21 Mar 2003 01:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263278AbTCUGDA>; Fri, 21 Mar 2003 01:03:00 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:39146 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP
	id <S263273AbTCUGC5>; Fri, 21 Mar 2003 01:02:57 -0500
Message-ID: <3E7AAD0C.B8CB2926@verizon.net>
Date: Thu, 20 Mar 2003 22:11:24 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.65 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-kernel@vger.kernel.org, torvalds@transmeta.com, akpm@digeo.com,
       ak@suse.com, rml@tech9.net
Subject: [PATCH] arch-independent syscalls to return long
Content-Type: multipart/mixed;
 boundary="------------A26406E0EE3B7CDC42B411BA"
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [4.64.238.61] at Fri, 21 Mar 2003 00:13:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A26406E0EE3B7CDC42B411BA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I posted this about 1 month ago (as [RFC]), to no avail.
However, tonight Andi needs it for pause() [which is failing
on x86_64], and Robert Love mentioned converting the affinity
syscalls.  I had already done them, so here they are again.

Builds and boots.

Please apply.  Patch is to 2.5.65-current.

Thanks,
~Randy
--------------A26406E0EE3B7CDC42B411BA
Content-Type: text/plain; charset=us-ascii;
 name="syscalls-long-2565.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syscalls-long-2565.patch"

patch_name:	syscalls-long-2560.patch
patch_version:	2003-02-13.22:58:43
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	convert arch-independent syscalls to long return values;
product:	Linux
product_versions: 2.5.65
diffstat:	=
 arch/x86_64/ia32/sys_ia32.c |    4 ++--
 fs/dcookies.c               |    2 +-
 fs/readdir.c                |    2 +-
 include/linux/mm.h          |    2 +-
 kernel/fork.c               |    2 +-
 kernel/sched.c              |    4 ++--
 kernel/signal.c             |    2 +-
 mm/fremap.c                 |    2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)


diff -Naur ./arch/x86_64/ia32/sys_ia32.c%LONG ./arch/x86_64/ia32/sys_ia32.c
--- ./arch/x86_64/ia32/sys_ia32.c%LONG	Mon Feb 10 10:38:29 2003
+++ ./arch/x86_64/ia32/sys_ia32.c	Thu Feb 13 22:15:24 2003
@@ -2071,8 +2071,8 @@
 	return -ENOSYS ;
 } 
 
-int sys_sched_getaffinity(pid_t pid, unsigned int len, unsigned long *new_mask_ptr); 
-int sys_sched_setaffinity(pid_t pid, unsigned int len, unsigned long *new_mask_ptr); 
+long sys_sched_getaffinity(pid_t pid, unsigned int len, unsigned long *new_mask_ptr); 
+long sys_sched_setaffinity(pid_t pid, unsigned int len, unsigned long *new_mask_ptr); 
 
 /* only works on LE */
 long sys32_sched_setaffinity(pid_t pid, unsigned int len,
diff -Naur ./fs/dcookies.c%LONG ./fs/dcookies.c
--- ./fs/dcookies.c%LONG	Mon Feb 10 10:37:55 2003
+++ ./fs/dcookies.c	Thu Feb 13 21:40:48 2003
@@ -142,7 +142,7 @@
 /* And here is where the userspace process can look up the cookie value
  * to retrieve the path.
  */
-asmlinkage int sys_lookup_dcookie(u64 cookie64, char * buf, size_t len)
+asmlinkage long sys_lookup_dcookie(u64 cookie64, char * buf, size_t len)
 {
 	unsigned long cookie = (unsigned long)cookie64;
 	int err = -EINVAL;
diff -Naur ./fs/readdir.c%LONG ./fs/readdir.c
--- ./fs/readdir.c%LONG	Mon Feb 10 10:38:31 2003
+++ ./fs/readdir.c	Thu Feb 13 22:50:16 2003
@@ -85,7 +85,7 @@
 	return 0;
 }
 
-asmlinkage int old_readdir(unsigned int fd, void * dirent, unsigned int count)
+asmlinkage long old_readdir(unsigned int fd, void * dirent, unsigned int count)
 {
 	int error;
 	struct file * file;
diff -Naur ./kernel/fork.c%LONG ./kernel/fork.c
--- ./kernel/fork.c%LONG	Mon Feb 10 10:37:58 2003
+++ ./kernel/fork.c	Thu Feb 13 21:21:07 2003
@@ -736,7 +736,7 @@
 	p->flags = new_flags;
 }
 
-asmlinkage int sys_set_tid_address(int *tidptr)
+asmlinkage long sys_set_tid_address(int *tidptr)
 {
 	current->clear_child_tid = tidptr;
 
diff -Naur ./kernel/sched.c%LONG ./kernel/sched.c
--- ./kernel/sched.c%LONG	Mon Feb 10 10:38:49 2003
+++ ./kernel/sched.c	Thu Feb 13 22:16:05 2003
@@ -1902,7 +1902,7 @@
  * @len: length in bytes of the bitmask pointed to by user_mask_ptr
  * @user_mask_ptr: user-space pointer to the new cpu mask
  */
-asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
+asmlinkage long sys_sched_setaffinity(pid_t pid, unsigned int len,
 				      unsigned long *user_mask_ptr)
 {
 	unsigned long new_mask;
@@ -1954,7 +1954,7 @@
  * @len: length in bytes of the bitmask pointed to by user_mask_ptr
  * @user_mask_ptr: user-space pointer to hold the current cpu mask
  */
-asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
+asmlinkage long sys_sched_getaffinity(pid_t pid, unsigned int len,
 				      unsigned long *user_mask_ptr)
 {
 	unsigned int real_len;
diff -Naur ./kernel/signal.c%LONG ./kernel/signal.c
--- ./kernel/signal.c%LONG	Mon Feb 10 10:38:26 2003
+++ ./kernel/signal.c	Thu Feb 13 21:43:45 2003
@@ -2254,7 +2254,7 @@
 
 #ifndef HAVE_ARCH_SYS_PAUSE
 
-asmlinkage int
+asmlinkage long
 sys_pause(void)
 {
 	current->state = TASK_INTERRUPTIBLE;
diff -Naur ./mm/fremap.c%LONG ./mm/fremap.c
--- ./mm/fremap.c%LONG	Mon Feb 10 10:37:56 2003
+++ ./mm/fremap.c	Thu Feb 13 21:52:58 2003
@@ -110,7 +110,7 @@
  * or use PROT_NONE in the original linear mapping and add a special
  * SIGBUS pagefault handler to reinstall zapped mappings.
  */
-int sys_remap_file_pages(unsigned long start, unsigned long size,
+long sys_remap_file_pages(unsigned long start, unsigned long size,
 	unsigned long prot, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
--- ./include/linux/mm.h%LONG	Mon Mar 17 13:43:39 2003
+++ ./include/linux/mm.h	Thu Mar 20 21:48:00 2003
@@ -421,7 +421,7 @@
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
-extern int sys_remap_file_pages(unsigned long start, unsigned long size, unsigned long prot, unsigned long pgoff, unsigned long nonblock);
+extern long sys_remap_file_pages(unsigned long start, unsigned long size, unsigned long prot, unsigned long pgoff, unsigned long nonblock);
 
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,

--------------A26406E0EE3B7CDC42B411BA--

