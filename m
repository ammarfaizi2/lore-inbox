Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268223AbTBNHRb>; Fri, 14 Feb 2003 02:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268229AbTBNHRb>; Fri, 14 Feb 2003 02:17:31 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:52173 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP
	id <S268223AbTBNHR1>; Fri, 14 Feb 2003 02:17:27 -0500
Message-ID: <3E4C99E2.2B464DCB@verizon.net>
Date: Thu, 13 Feb 2003 23:25:22 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.59 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: jamie@shareable.org
Subject: [PATCH/RFC] make arch-independent syscalls <long>
Content-Type: multipart/mixed;
 boundary="------------44786D647ECD28B954E00890"
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [4.64.238.61] at Fri, 14 Feb 2003 01:27:13 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------44786D647ECD28B954E00890
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Based on a thread with Jamie Lokier[1,2], this patch converts
several syscalls from <int> to <long>.

Jamie's list included sys_epoll calls, but Davide has
already modified those.

The rest of Jamie's list was:
	sys_set_tid_address
	sys_futex
	sys_sched_setaffinity
	sys_sched_getaffinity
	sys_remap_file_pages
	sys_lookup_dcookie
	sys_pause
and my searching has only added
	old_readdir

Comments?

Thanks,
~Randy

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=104379012431181&w=2
or (same message)
[2] http://www.lkml.org/archive/2003/1/28/231/index.html
--------------44786D647ECD28B954E00890
Content-Type: text/plain; charset=us-ascii;
 name="syscalls-long-2560.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syscalls-long-2560.patch"

patch_name:	syscalls-long-2560.patch
patch_version:	2003-02-13.22:58:43
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	_
product:	Linux
product_versions: linux-2560
changelog:	_
URL:		_
requires:	_
conflicts:	_
diffstat:	=
 arch/x86_64/ia32/sys_ia32.c |    8 ++++----
 fs/dcookies.c               |    2 +-
 fs/readdir.c                |    2 +-
 include/linux/futex.h       |    2 +-
 include/linux/mm.h          |    2 +-
 kernel/fork.c               |    2 +-
 kernel/futex.c              |    2 +-
 kernel/sched.c              |    4 ++--
 kernel/signal.c             |    2 +-
 mm/fremap.c                 |    2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)


diff -Naur ./arch/x86_64/ia32/sys_ia32.c%LONG ./arch/x86_64/ia32/sys_ia32.c
--- ./arch/x86_64/ia32/sys_ia32.c%LONG	Mon Feb 10 10:38:29 2003
+++ ./arch/x86_64/ia32/sys_ia32.c	Thu Feb 13 22:15:24 2003
@@ -2205,8 +2205,8 @@
 	return -ENOSYS ;
 } 
 
-int sys_sched_getaffinity(pid_t pid, unsigned int len, unsigned long *new_mask_ptr); 
-int sys_sched_setaffinity(pid_t pid, unsigned int len, unsigned long *new_mask_ptr); 
+long sys_sched_getaffinity(pid_t pid, unsigned int len, unsigned long *new_mask_ptr); 
+long sys_sched_setaffinity(pid_t pid, unsigned int len, unsigned long *new_mask_ptr); 
 
 /* only works on LE */
 long sys32_sched_setaffinity(pid_t pid, unsigned int len,
@@ -2239,14 +2239,14 @@
 	return err;
 }
 
-extern int sys_futex(unsigned long uaddr, int op, int val, struct timespec *t); 
+extern long sys_futex(unsigned long uaddr, int op, int val, struct timespec *t); 
 
 asmlinkage long
 sys32_futex(unsigned long uaddr, int op, int val, struct compat_timespec *utime32)
 {
 	struct timespec t;
 	mm_segment_t oldfs = get_fs(); 
-	int err;
+	long err;
 
 	if (utime32) {
 		if (verify_area(VERIFY_READ, utime32, sizeof(*utime32)))
diff -Naur ./include/linux/futex.h%LONG ./include/linux/futex.h
--- ./include/linux/futex.h%LONG	Mon Feb 10 10:38:44 2003
+++ ./include/linux/futex.h	Thu Feb 13 21:25:29 2003
@@ -6,6 +6,6 @@
 #define FUTEX_WAKE (1)
 #define FUTEX_FD (2)
 
-extern asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime);
+extern asmlinkage long sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime);
 
 #endif
diff -Naur ./include/linux/mm.h%LONG ./include/linux/mm.h
--- ./include/linux/mm.h%LONG	Mon Feb 10 10:37:57 2003
+++ ./include/linux/mm.h	Thu Feb 13 21:47:06 2003
@@ -419,7 +419,7 @@
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
-extern int sys_remap_file_pages(unsigned long start, unsigned long size, unsigned long prot, unsigned long pgoff, unsigned long nonblock);
+extern long sys_remap_file_pages(unsigned long start, unsigned long size, unsigned long prot, unsigned long pgoff, unsigned long nonblock);
 
 
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address, int write);
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
@@ -80,7 +80,7 @@
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
@@ -715,7 +715,7 @@
 	p->flags = new_flags;
 }
 
-asmlinkage int sys_set_tid_address(int *tidptr)
+asmlinkage long sys_set_tid_address(int *tidptr)
 {
 	current->clear_child_tid = tidptr;
 
diff -Naur ./kernel/futex.c%LONG ./kernel/futex.c
--- ./kernel/futex.c%LONG	Mon Feb 10 10:38:05 2003
+++ ./kernel/futex.c	Thu Feb 13 21:31:22 2003
@@ -437,7 +437,7 @@
 	return ret;
 }
 
-asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime)
+asmlinkage long sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime)
 {
 	unsigned long pos_in_page;
 	int ret;
diff -Naur ./kernel/sched.c%LONG ./kernel/sched.c
--- ./kernel/sched.c%LONG	Mon Feb 10 10:38:49 2003
+++ ./kernel/sched.c	Thu Feb 13 22:16:05 2003
@@ -1773,7 +1773,7 @@
  * @len: length in bytes of the bitmask pointed to by user_mask_ptr
  * @user_mask_ptr: user-space pointer to the new cpu mask
  */
-asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
+asmlinkage long sys_sched_setaffinity(pid_t pid, unsigned int len,
 				      unsigned long *user_mask_ptr)
 {
 	unsigned long new_mask;
@@ -1825,7 +1825,7 @@
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
@@ -2168,7 +2168,7 @@
 
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

--------------44786D647ECD28B954E00890--

