Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbUBXUFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbUBXUFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:05:36 -0500
Received: from ns.suse.de ([195.135.220.2]:45724 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262423AbUBXUFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:05:18 -0500
Subject: [FIX] CONFIG_REGPARM breaks non-asmlinkage syscalls
From: Andreas Gruenbacher <agruen@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
Content-Type: multipart/mixed; boundary="=-zKTmwfnOtV72PjlonjlV"
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1077653156.3101.327.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 24 Feb 2004 21:05:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zKTmwfnOtV72PjlonjlV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

with CONFIG_REGPARM=y, syscalls must be declared asmlinkage or else
calling them will fail. Current gcc unfortunately does not warn about
this. (I have already told one of our compiler developers.) Attached is
a fix that adds a few missing declarations.

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

--=-zKTmwfnOtV72PjlonjlV
Content-Disposition: attachment; filename=regparm-fix.diff
Content-Type: text/x-patch; name=regparm-fix.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6.3/arch/ia64/ia32/sys_ia32.c
===================================================================
--- linux-2.6.3.orig/arch/ia64/ia32/sys_ia32.c
+++ linux-2.6.3/arch/ia64/ia32/sys_ia32.c
@@ -2990,7 +2990,7 @@ sys32_timer_create(u32 clock, struct sig
 	return err;
 }
 
-extern long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
+extern asmlinkage long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
 
 long sys32_fadvise64_64(int fd, __u32 offset_low, __u32 offset_high, 
 			__u32 len_low, __u32 len_high, int advice)
Index: linux-2.6.3/arch/x86_64/ia32/sys_ia32.c
===================================================================
--- linux-2.6.3.orig/arch/x86_64/ia32/sys_ia32.c
+++ linux-2.6.3/arch/x86_64/ia32/sys_ia32.c
@@ -1895,7 +1895,7 @@ sys32_timer_create(u32 clock, struct sig
 	return err; 
 } 
 
-extern long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
+extern asmlinkage long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
 
 long sys32_fadvise64_64(int fd, __u32 offset_low, __u32 offset_high, 
 			__u32 len_low, __u32 len_high, int advice)
Index: linux-2.6.3/include/linux/mm.h
===================================================================
--- linux-2.6.3.orig/include/linux/mm.h
+++ linux-2.6.3/include/linux/mm.h
@@ -455,8 +455,8 @@ extern int install_file_pte(struct mm_st
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
-extern long sys_remap_file_pages(unsigned long start, unsigned long size, unsigned long prot, unsigned long pgoff, unsigned long nonblock);
-extern long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
+extern asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size, unsigned long prot, unsigned long pgoff, unsigned long nonblock);
+extern asmlinkage long sys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice);
 void put_dirty_page(struct task_struct *tsk, struct page *page,
 			unsigned long address, pgprot_t prot);
 
Index: linux-2.6.3/include/linux/shm.h
===================================================================
--- linux-2.6.3.orig/include/linux/shm.h
+++ linux-2.6.3/include/linux/shm.h
@@ -90,7 +90,7 @@ struct shmid_kernel /* private to the ke
 #define SHM_LOCKED      02000   /* segment will not be swapped */
 #define SHM_HUGETLB     04000   /* segment will use huge TLB pages */
 
-long sys_shmat (int shmid, char __user *shmaddr, int shmflg, unsigned long *addr);
+asmlinkage long sys_shmat (int shmid, char __user *shmaddr, int shmflg, unsigned long *addr);
 asmlinkage long sys_shmget (key_t key, size_t size, int flag);
 asmlinkage long sys_shmdt (char __user *shmaddr);
 asmlinkage long sys_shmctl (int shmid, int cmd, struct shmid_ds __user *buf);
Index: linux-2.6.3/mm/fremap.c
===================================================================
--- linux-2.6.3.orig/mm/fremap.c
+++ linux-2.6.3/mm/fremap.c
@@ -155,7 +155,7 @@ err_unlock:
  * protection is used. Arbitrary protections might be implemented in the
  * future.
  */
-long sys_remap_file_pages(unsigned long start, unsigned long size,
+asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 	unsigned long __prot, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;

--=-zKTmwfnOtV72PjlonjlV--

