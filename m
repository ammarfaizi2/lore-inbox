Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbUDBBb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbUDBBbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:31:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:46729 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263523AbUDBBaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:30:17 -0500
Date: Thu, 1 Apr 2004 17:30:14 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401173014.Z22989@build.pdx.osdl.net>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040402011804.GL18585@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040402011804.GL18585@dualathlon.random>; from andrea@suse.de on Fri, Apr 02, 2004 at 03:18:04AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrea Arcangeli (andrea@suse.de) wrote:
> please elaborate how can you account for shmget(SHM_HUGETLB) with the
> rlimit. The rlimit is just about the _address_space_ mlocked, there's no
> way to account for something _outside_ the address space with the rlimit,
> period. If you attempt doing that, _that_ will be THE true hack(tm) ;).

Heh ;-)  OK, here's the patch.  When you setup the vmas for the huge pages
account for them, when you tear them down, account for that as well.
It's very possible that I've missed the obvious, but it at least pasts
simple tests with SHM_HUGETLB, and also allows gpg to mlock when i set
the users mlock rlimit to 8 pages.

I recall the problem that I had.  That's with normal pages and SHM_LOCK.
With this method of locking, it's trivial to mess up the accounting for
mm->locked_vm.

Patch below is from around 2.6.3, but still seems to apply ok.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== arch/i386/mm/hugetlbpage.c 1.21 vs edited =====
--- 1.21/arch/i386/mm/hugetlbpage.c	Tue Dec 30 12:49:10 2003
+++ edited/arch/i386/mm/hugetlbpage.c	Fri Feb 27 18:41:35 2004
@@ -106,6 +106,7 @@
 	pte_t entry;
 
 	mm->rss += (HPAGE_SIZE / PAGE_SIZE);
+	mm->locked_vm += (HPAGE_SIZE / PAGE_SIZE);
 	if (write_access) {
 		entry =
 		    pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
@@ -316,6 +317,7 @@
 		pte_clear(pte);
 	}
 	mm->rss -= (end - start) >> PAGE_SHIFT;
+	mm->locked_vm -= (end -start) >> PAGE_SHIFT;
 	flush_tlb_range(vma, start, end);
 }
 
@@ -524,7 +526,16 @@
 
 int is_hugepage_mem_enough(size_t size)
 {
-	return (size + ~HPAGE_MASK)/HPAGE_SIZE <= htlbpagemem;
+	unsigned long lock_limit, locked;
+	struct mm_struct *mm = current->mm;
+	long htlbpagesize = (size + ~HPAGE_MASK)/HPAGE_SIZE;
+
+	locked = mm->locked_vm >> PAGE_SHIFT;
+	locked += htlbpagesize << (HPAGE_SHIFT - PAGE_SHIFT);
+	lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur >> PAGE_SHIFT;
+
+	return ((locked <= lock_limit || capable(CAP_IPC_LOCK)) &&
+		(size + ~HPAGE_MASK)/HPAGE_SIZE <= htlbpagemem);
 }
 
 /*
===== fs/hugetlbfs/inode.c 1.24 vs edited =====
--- 1.24/fs/hugetlbfs/inode.c	Fri Feb  6 19:23:17 2004
+++ edited/fs/hugetlbfs/inode.c	Fri Feb 27 18:49:17 2004
@@ -694,7 +697,7 @@
 	struct qstr quick_string;
 	char buf[16];
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_mlock())
 		return ERR_PTR(-EPERM);
  
 	if (!is_hugepage_mem_enough(size))
===== include/asm-alpha/resource.h 1.1 vs edited =====
--- 1.1/include/asm-alpha/resource.h	Thu Feb 15 13:25:56 2001
+++ edited/include/asm-alpha/resource.h	Thu Feb 26 16:45:32 2004
@@ -39,7 +39,7 @@
     {INR_OPEN, INR_OPEN},			/* RLIMIT_NOFILE */	\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_AS */		\
     {LONG_MAX, LONG_MAX},			/* RLIMIT_NPROC */	\
-    {LONG_MAX, LONG_MAX},			/* RLIMIT_MEMLOCK */	\
+    {PAGE_SIZE,PAGE_SIZE},			/* RLIMIT_MEMLOCK */	\
     {LONG_MAX, LONG_MAX},                       /* RLIMIT_LOCKS */      \
 }
 
===== include/asm-arm/resource.h 1.1 vs edited =====
--- 1.1/include/asm-arm/resource.h	Thu Feb 15 13:26:06 2001
+++ edited/include/asm-arm/resource.h	Thu Feb 26 16:45:33 2004
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ 0,             0             },	\
 	{ INR_OPEN,      INR_OPEN      },	\
-	{ RLIM_INFINITY, RLIM_INFINITY },	\
+	{ PAGE_SIZE,     PAGE_SIZE     },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 	{ RLIM_INFINITY, RLIM_INFINITY },	\
 }
===== include/asm-cris/resource.h 1.1 vs edited =====
--- 1.1/include/asm-cris/resource.h	Thu Feb 22 09:58:11 2001
+++ edited/include/asm-cris/resource.h	Thu Feb 26 16:45:33 2004
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },               \
+	{     PAGE_SIZE,     PAGE_SIZE },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
===== include/asm-i386/resource.h 1.1 vs edited =====
--- 1.1/include/asm-i386/resource.h	Thu Feb 15 13:25:53 2001
+++ edited/include/asm-i386/resource.h	Thu Feb 26 16:45:34 2004
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
 }
===== include/asm-ia64/resource.h 1.3 vs edited =====
--- 1.3/include/asm-ia64/resource.h	Fri Jan 30 18:49:24 2004
+++ edited/include/asm-ia64/resource.h	Thu Feb 26 16:45:34 2004
@@ -44,7 +44,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
===== include/asm-m68k/resource.h 1.2 vs edited =====
--- 1.2/include/asm-m68k/resource.h	Thu May  9 08:21:01 2002
+++ edited/include/asm-m68k/resource.h	Thu Feb 26 16:45:35 2004
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
 }
===== include/asm-mips/resource.h 1.3 vs edited =====
--- 1.3/include/asm-mips/resource.h	Fri Aug  8 14:44:42 2003
+++ edited/include/asm-mips/resource.h	Thu Feb 26 16:45:35 2004
@@ -52,7 +52,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ 0,             0             },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
 
===== include/asm-parisc/resource.h 1.1 vs edited =====
--- 1.1/include/asm-parisc/resource.h	Thu Feb 15 13:26:11 2001
+++ edited/include/asm-parisc/resource.h	Thu Feb 26 16:46:33 2004
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
===== include/asm-ppc/resource.h 1.3 vs edited =====
--- 1.3/include/asm-ppc/resource.h	Fri Sep 20 01:20:44 2002
+++ edited/include/asm-ppc/resource.h	Thu Feb 26 16:46:34 2004
@@ -34,7 +34,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
===== include/asm-ppc64/resource.h 1.1 vs edited =====
--- 1.1/include/asm-ppc64/resource.h	Wed Feb 20 00:14:56 2002
+++ edited/include/asm-ppc64/resource.h	Thu Feb 26 16:47:52 2004
@@ -43,7 +43,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
===== include/asm-s390/resource.h 1.2 vs edited =====
--- 1.2/include/asm-s390/resource.h	Tue Feb 13 06:13:44 2001
+++ edited/include/asm-s390/resource.h	Thu Feb 26 16:47:53 2004
@@ -45,7 +45,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{ INR_OPEN, INR_OPEN },                         \
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
===== include/asm-sh/resource.h 1.1 vs edited =====
--- 1.1/include/asm-sh/resource.h	Thu Feb 15 13:26:07 2001
+++ edited/include/asm-sh/resource.h	Thu Feb 26 16:48:15 2004
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 }
===== include/asm-sparc/resource.h 1.1 vs edited =====
--- 1.1/include/asm-sparc/resource.h	Thu Feb 15 13:25:58 2001
+++ edited/include/asm-sparc/resource.h	Thu Feb 26 16:48:16 2004
@@ -42,7 +42,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {PAGE_SIZE,     PAGE_SIZE },	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY}	\
 }
===== include/asm-sparc64/resource.h 1.1 vs edited =====
--- 1.1/include/asm-sparc64/resource.h	Thu Feb 15 13:26:02 2001
+++ edited/include/asm-sparc64/resource.h	Thu Feb 26 16:48:17 2004
@@ -41,7 +41,7 @@
     {       0, RLIM_INFINITY},		\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {INR_OPEN, INR_OPEN}, {0, 0},	\
-    {RLIM_INFINITY, RLIM_INFINITY},	\
+    {PAGE_SIZE,     PAGE_SIZE },	\
     {RLIM_INFINITY, RLIM_INFINITY},	\
     {RLIM_INFINITY, RLIM_INFINITY}	\
 }
===== include/asm-x86_64/resource.h 1.1 vs edited =====
--- 1.1/include/asm-x86_64/resource.h	Wed Feb 13 16:05:42 2002
+++ edited/include/asm-x86_64/resource.h	Thu Feb 26 16:48:19 2004
@@ -37,7 +37,7 @@
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
 	{             0,             0 },		\
 	{      INR_OPEN,     INR_OPEN  },		\
-	{ RLIM_INFINITY, RLIM_INFINITY },		\
+	{     PAGE_SIZE,     PAGE_SIZE },		\
 	{ RLIM_INFINITY, RLIM_INFINITY },		\
         { RLIM_INFINITY, RLIM_INFINITY },		\
 }
===== include/linux/mm.h 1.64 vs edited =====
--- 1.64/include/linux/mm.h	Fri Feb  6 10:08:10 2004
+++ edited/include/linux/mm.h	Thu Feb 26 16:51:18 2004
@@ -427,7 +427,7 @@
 struct page *shmem_nopage(struct vm_area_struct * vma,
 			unsigned long address, int *type);
 struct file *shmem_file_setup(char * name, loff_t size, unsigned long flags);
-void shmem_lock(struct file * file, int lock);
+int shmem_lock(struct file * file, int lock);
 int shmem_zero_setup(struct vm_area_struct *);
 
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
@@ -575,6 +575,17 @@
 	if (!vma->vm_file && vma->vm_flags == vm_flags)
 		return 1;
 #endif
+	return 0;
+}
+
+/* mlock can just return an instant EPERM if the caller has no
+   permission to do any memory locking. */
+static inline int can_do_mlock(void)
+{
+	if (capable(CAP_IPC_LOCK))
+		return 1;
+	if (current->rlim[RLIMIT_MEMLOCK].rlim_cur != 0)
+		return 1;
 	return 0;
 }
 
===== ipc/shm.c 1.40 vs edited =====
--- 1.40/ipc/shm.c	Mon Sep  8 15:08:14 2003
+++ edited/ipc/shm.c	Wed Mar  3 11:55:17 2004
@@ -502,10 +502,8 @@
 	case SHM_LOCK:
 	case SHM_UNLOCK:
 	{
-/* Allow superuser to lock segment in memory */
-/* Should the pages be faulted in here or leave it to user? */
-/* need to determine interaction with current->swappable */
-		if (!capable(CAP_IPC_LOCK)) {
+		/* Allow superuser to lock segment in memory */
+		if (!can_do_mlock()) {
 			err = -EPERM;
 			goto out;
 		}
@@ -524,8 +522,11 @@
 			goto out_unlock;
 		
 		if(cmd==SHM_LOCK) {
-			if (!is_file_hugepages(shp->shm_file))
-				shmem_lock(shp->shm_file, 1);
+			if (!is_file_hugepages(shp->shm_file)) {
+				err = shmem_lock(shp->shm_file, 1);
+				if (err)
+					goto out_unlock;
+			}
 			shp->shm_flags |= SHM_LOCKED;
 		} else {
 			if (!is_file_hugepages(shp->shm_file))
===== mm/mlock.c 1.7 vs edited =====
--- 1.7/mm/mlock.c	Fri Oct 17 07:43:50 2003
+++ edited/mm/mlock.c	Fri Feb 27 15:10:33 2004
@@ -57,7 +57,7 @@
 	struct vm_area_struct * vma, * next;
 	int error;
 
-	if (on && !capable(CAP_IPC_LOCK))
+	if (on && !can_do_mlock())
 		return -EPERM;
 	len = PAGE_ALIGN(len);
 	end = start + len;
@@ -115,9 +115,9 @@
 	lock_limit >>= PAGE_SHIFT;
 
 	/* check against resource limits */
-	if (locked <= lock_limit)
+	if (locked <= lock_limit || capable(CAP_IPC_LOCK))
 		error = do_mlock(start, len, 1);
 	up_write(&current->mm->mmap_sem);
 	return error;
 }
 
@@ -139,7 +141,7 @@
 	unsigned int def_flags;
 	struct vm_area_struct * vma;
 
-	if (!capable(CAP_IPC_LOCK))
+	if (!can_do_mlock())
 		return -EPERM;
 
 	def_flags = 0;
@@ -174,7 +176,7 @@
 	lock_limit >>= PAGE_SHIFT;
 
 	ret = -ENOMEM;
-	if (current->mm->total_vm <= lock_limit)
+	if (current->mm->total_vm <= lock_limit || capable(CAP_IPC_LOCK))
 		ret = do_mlockall(flags);
 out:
 	up_write(&current->mm->mmap_sem);
===== mm/mmap.c 1.64 vs edited =====
--- 1.64/mm/mmap.c	Mon Feb 16 11:49:56 2004
+++ edited/mm/mmap.c	Thu Feb 26 17:45:14 2004
@@ -512,15 +512,17 @@
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED) {
-		if (!capable(CAP_IPC_LOCK))
+		if (!can_do_mlock())
 			return -EPERM;
 		vm_flags |= VM_LOCKED;
 	}
 	/* mlock MCL_FUTURE? */
 	if (vm_flags & VM_LOCKED) {
-		unsigned long locked = mm->locked_vm << PAGE_SHIFT;
+		unsigned long locked, lock_limit;
+		locked = mm->locked_vm << PAGE_SHIFT;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += len;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			return -EAGAIN;
 	}
 
@@ -1331,13 +1333,18 @@
 	if ((addr + len) > TASK_SIZE || (addr + len) < addr)
 		return -EINVAL;
 
+	if ((addr + len) > TASK_SIZE || (addr + len) < addr)
+		return -EINVAL;
+
 	/*
 	 * mlock MCL_FUTURE?
 	 */
 	if (mm->def_flags & VM_LOCKED) {
-		unsigned long locked = mm->locked_vm << PAGE_SHIFT;
+		unsigned long locked, lock_limit;
+		locked = mm->locked_vm << PAGE_SHIFT;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += len;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			return -EAGAIN;
 	}
 
===== mm/mremap.c 1.31 vs edited =====
--- 1.31/mm/mremap.c	Tue Feb 17 23:14:50 2004
+++ edited/mm/mremap.c	Thu Feb 26 16:48:24 2004
@@ -387,10 +387,12 @@
 			goto out;
 	}
 	if (vma->vm_flags & VM_LOCKED) {
-		unsigned long locked = current->mm->locked_vm << PAGE_SHIFT;
+		unsigned long locked, lock_limit;
+		locked = current->mm->locked_vm << PAGE_SHIFT;
+		lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
 		locked += new_len - old_len;
 		ret = -EAGAIN;
-		if (locked > current->rlim[RLIMIT_MEMLOCK].rlim_cur)
+		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
 			goto out;
 	}
 	ret = -ENOMEM;
===== mm/shmem.c 1.63 vs edited =====
--- 1.63/mm/shmem.c	Thu Feb  5 16:08:09 2004
+++ edited/mm/shmem.c	Fri Feb 27 19:40:42 2004
@@ -1046,17 +1046,38 @@
 	return 0;
 }
 
-void shmem_lock(struct file *file, int lock)
+int shmem_lock(struct file *file, int lock)
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct mm_struct *mm = current->mm;
+	unsigned long lock_limit, locked;
+	int retval = -ENOMEM;
 
 	spin_lock(&info->lock);
-	if (lock)
+	if (lock) {
+		if (!(info->flags & VM_LOCKED)) {
+			locked = inode->i_size >> PAGE_SHIFT;
+			locked += mm->locked_vm;
+			lock_limit = current->rlim[RLIMIT_MEMLOCK].rlim_cur;
+			lock_limit >>= PAGE_SHIFT;
+			if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+				goto out_nomem;
+			mm->locked_vm = locked;
+		}
 		info->flags |= VM_LOCKED;
-	else
+	}
+	if (!lock) {
+		if ((info->flags & VM_LOCKED) && mm) {
+			locked = inode->i_size >> PAGE_SHIFT;
+			mm->locked_vm -= locked;
+		}
 		info->flags &= ~VM_LOCKED;
+	}
+	retval = 0;
+out_nomem:
 	spin_unlock(&info->lock);
+	return retval;
 }
 
 static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
