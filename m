Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271694AbRICPYm>; Mon, 3 Sep 2001 11:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271728AbRICPYZ>; Mon, 3 Sep 2001 11:24:25 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:1806 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271694AbRICPYD>; Mon, 3 Sep 2001 11:24:03 -0400
Date: Mon, 3 Sep 2001 17:24:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: expand_stack fix [was Re: 2.4.9aa3]
Message-ID: <20010903172445.N699@athlon.random>
In-Reply-To: <20010819080742.A725@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010819080742.A725@athlon.random>; from andrea@suse.de on Sun, Aug 19, 2001 at 08:07:42AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2001 at 08:07:42AM +0200, Andrea Arcangeli wrote:
> Only in 2.4.9aa2: 00_silent-stack-overflow-5
> Only in 2.4.9aa3: 00_silent-stack-overflow-6
> 
> 	Updated to run expand_stack always with the mm write semaphore acquired
> 	to fix the race conditions. Upgrading the semaphore during
> 	map_user_kiobuf was quite painful so I just disallowed to do direct I/O
> 	on a growsdown VMA (you can still do that as far as it doesn't need to
> 	be live extended on the fly).

Linus please include the attached patch to the next kernel, expand_stack
is totally broken at the moment, we cannot mess with the mm vma layout
if we don't hold the mmap_sem in write mode. I fixed only alpha and x86,
all other ports will have to be fixed the same way (in the meantime they
works but they're racy even on UP).

I considered implementing a read->write semaphore upgrade primitive but
it cannot be reliable (it needs a fail path) and so it would be only an
optimization when we're the only reader and we should implement anyways
the ugly slow path, so for now this version of the fix doesn't depend on
any new rwsem primitive (and expand_stack isn't an extremely fast path
so it looks an acceptable solution).

The patch also introduces a forced gap (sysctl configurable, 1 page by
default) between a growsdown vma and the previous vma to try not to
silenty overflow the heap with a stack overflow, of course if an huge
stack allocation happens (larger than a page) the heuristic will fail
but the sysctl can be used to increase the probability of a match). This
a feature that helps userspace programming. The reason this feature is
included in the patch is that the two patches were very controversial,
if you disklike the "gap" feature I can do the boring work of extract
the strict expand_stack fix but I hope you won't ask me to do so ;).

diff -urN 2.4.9/arch/alpha/mm/fault.c expand_stack/arch/alpha/mm/fault.c
--- 2.4.9/arch/alpha/mm/fault.c	Sun Apr  1 01:17:07 2001
+++ expand_stack/arch/alpha/mm/fault.c	Sun Aug 19 06:46:52 2001
@@ -113,16 +113,30 @@
 		goto vmalloc_fault;
 #endif
 
-	down_read(&mm->mmap_sem);
-	vma = find_vma(mm, address);
-	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
+	for (;;) {
+		int not_expanded;
+
+		down_read(&mm->mmap_sem);
+		vma = find_vma(mm, address);
+		if (!vma)
+			goto bad_area;
+		if (vma->vm_start <= address)
+			goto good_area;
+		if (!(vma->vm_flags & VM_GROWSDOWN))
+			goto bad_area;
+		up_read(&mm->mmap_sem);
+		down_write(&mm->mmap_sem);
+		vma = find_vma(mm, address);
+		if (!vma || vma->vm_start <= address || !(vma->vm_flags & VM_GROWSDOWN)) {
+			up_write(&mm->mmap_sem);
+			continue;
+		}
+		not_expanded = expand_stack(vma, address, NULL);
+		up_write(&mm->mmap_sem);
+		if (not_expanded)
+			goto bad_area_nosem;
+	}
+
 /*
  * Ok, we have a good vm_area for this memory access, so
  * we can handle it..
@@ -161,6 +175,7 @@
  */
 bad_area:
 	up_read(&mm->mmap_sem);
+bad_area_nosem:
 
 	if (user_mode(regs)) {
 		force_sig(SIGSEGV, current);
diff -urN 2.4.9/arch/arm/mm/fault-common.c expand_stack/arch/arm/mm/fault-common.c
--- 2.4.9/arch/arm/mm/fault-common.c	Thu Aug 16 22:03:23 2001
+++ expand_stack/arch/arm/mm/fault-common.c	Sun Aug 19 06:36:04 2001
@@ -229,7 +229,7 @@
 	goto survive;
 
 check_stack:
-	if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr))
+	if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr, NULL))
 		goto good_area;
 out:
 	return fault;
diff -urN 2.4.9/arch/cris/mm/fault.c expand_stack/arch/cris/mm/fault.c
--- 2.4.9/arch/cris/mm/fault.c	Sat Aug 11 08:03:54 2001
+++ expand_stack/arch/cris/mm/fault.c	Sun Aug 19 06:36:04 2001
@@ -284,7 +284,7 @@
 		if (address + PAGE_SIZE < rdusp())
 			goto bad_area;
 	}
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 
 	/*
diff -urN 2.4.9/arch/i386/mm/fault.c expand_stack/arch/i386/mm/fault.c
--- 2.4.9/arch/i386/mm/fault.c	Sat May 26 04:03:35 2001
+++ expand_stack/arch/i386/mm/fault.c	Sun Aug 19 06:49:37 2001
@@ -30,7 +30,7 @@
  */
 int __verify_write(const void * addr, unsigned long size)
 {
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev_vma;
 	unsigned long start = (unsigned long) addr;
 
 	if (!size)
@@ -70,7 +70,8 @@
 check_stack:
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, start) == 0)
+	find_vma_prev(current->mm, start, &prev_vma);
+	if (expand_stack(vma, start, prev_vma) == 0)
 		goto good_area;
 
 bad_area:
@@ -107,7 +108,7 @@
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev_vma;
 	unsigned long address;
 	unsigned long page;
 	unsigned long fixup;
@@ -149,27 +150,41 @@
 	if (in_interrupt() || !mm)
 		goto no_context;
 
-	down_read(&mm->mmap_sem);
+	for (;;) {
+		int not_expanded;
 
-	vma = find_vma(mm, address);
-	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (error_code & 4) {
-		/*
-		 * accessing the stack below %esp is always a bug.
-		 * The "+ 32" is there due to some instructions (like
-		 * pusha) doing post-decrement on the stack and that
-		 * doesn't show up until later..
-		 */
-		if (address + 32 < regs->esp)
+		down_read(&mm->mmap_sem);
+
+		vma = find_vma(mm, address);
+		if (!vma)
+			goto bad_area;
+		if (vma->vm_start <= address)
+			goto good_area;
+		if (!(vma->vm_flags & VM_GROWSDOWN))
 			goto bad_area;
+		if (error_code & 4) {
+			/*
+			 * accessing the stack below %esp is always a bug.
+			 * The "+ 32" is there due to some instructions (like
+			 * pusha) doing post-decrement on the stack and that
+			 * doesn't show up until later..
+			 */
+			if (address + 32 < regs->esp)
+				goto bad_area;
+		}
+
+		up_read(&mm->mmap_sem);
+		down_write(&mm->mmap_sem);
+		vma = find_vma_prev(mm, address, &prev_vma);
+		if (!vma || vma->vm_start <= address || !(vma->vm_flags & VM_GROWSDOWN)) {
+			up_write(&mm->mmap_sem);
+			continue;
+		}
+		not_expanded = expand_stack(vma, address, prev_vma);
+		up_write(&mm->mmap_sem);
+		if (not_expanded)
+			goto bad_area_nosem;
 	}
-	if (expand_stack(vma, address))
-		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
  * we can handle it..
@@ -231,6 +246,7 @@
  */
 bad_area:
 	up_read(&mm->mmap_sem);
+bad_area_nosem:
 
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & 4) {
diff -urN 2.4.9/arch/ia64/mm/fault.c expand_stack/arch/ia64/mm/fault.c
--- 2.4.9/arch/ia64/mm/fault.c	Tue May  1 19:35:18 2001
+++ expand_stack/arch/ia64/mm/fault.c	Sun Aug 19 06:36:04 2001
@@ -122,7 +122,7 @@
 		if (rgn_index(address) != rgn_index(vma->vm_start)
 		    || rgn_offset(address) >= RGN_MAP_LIMIT)
 			goto bad_area;
-		if (expand_stack(vma, address))
+		if (expand_stack(vma, address, NULL))
 			goto bad_area;
 	} else {
 		vma = prev_vma;
diff -urN 2.4.9/arch/m68k/mm/fault.c expand_stack/arch/m68k/mm/fault.c
--- 2.4.9/arch/m68k/mm/fault.c	Sun Apr  1 01:17:08 2001
+++ expand_stack/arch/m68k/mm/fault.c	Sun Aug 19 06:36:04 2001
@@ -120,7 +120,7 @@
 		if (address + 256 < rdusp())
 			goto map_err;
 	}
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto map_err;
 
 /*
diff -urN 2.4.9/arch/mips/mm/fault.c expand_stack/arch/mips/mm/fault.c
--- 2.4.9/arch/mips/mm/fault.c	Sat Jul 21 00:04:05 2001
+++ expand_stack/arch/mips/mm/fault.c	Sun Aug 19 06:36:04 2001
@@ -80,7 +80,7 @@
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.9/arch/mips64/mm/fault.c expand_stack/arch/mips64/mm/fault.c
--- 2.4.9/arch/mips64/mm/fault.c	Sat Jul 21 00:04:07 2001
+++ expand_stack/arch/mips64/mm/fault.c	Sun Aug 19 06:36:04 2001
@@ -134,7 +134,7 @@
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.9/arch/ppc/mm/fault.c expand_stack/arch/ppc/mm/fault.c
--- 2.4.9/arch/ppc/mm/fault.c	Wed Jul  4 04:03:45 2001
+++ expand_stack/arch/ppc/mm/fault.c	Sun Aug 19 06:36:04 2001
@@ -64,7 +64,7 @@
 void do_page_fault(struct pt_regs *regs, unsigned long address,
 		   unsigned long error_code)
 {
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev_vma;
 	struct mm_struct *mm = current->mm;
 	siginfo_t info;
 	int code = SEGV_MAPERR;
@@ -104,14 +104,14 @@
 		return;
 	}
 	down_read(&mm->mmap_sem);
-	vma = find_vma(mm, address);
+	vma = find_vma_prev(mm, address, &prev_vma);
 	if (!vma)
 		goto bad_area;
 	if (vma->vm_start <= address)
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, prev_vma))
 		goto bad_area;
 
 good_area:
diff -urN 2.4.9/arch/s390/mm/fault.c expand_stack/arch/s390/mm/fault.c
--- 2.4.9/arch/s390/mm/fault.c	Sat Aug 11 08:03:59 2001
+++ expand_stack/arch/s390/mm/fault.c	Sun Aug 19 06:36:04 2001
@@ -122,7 +122,7 @@
                 goto good_area;
         if (!(vma->vm_flags & VM_GROWSDOWN))
                 goto bad_area;
-        if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
                 goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.9/arch/s390x/mm/fault.c expand_stack/arch/s390x/mm/fault.c
--- 2.4.9/arch/s390x/mm/fault.c	Sat Aug 11 08:04:00 2001
+++ expand_stack/arch/s390x/mm/fault.c	Sun Aug 19 06:36:04 2001
@@ -152,7 +152,7 @@
                 goto good_area;
         if (!(vma->vm_flags & VM_GROWSDOWN))
                 goto bad_area;
-        if (expand_stack(vma, address))
+        if (expand_stack(vma, address, NULL))
                 goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.9/arch/sh/mm/fault.c expand_stack/arch/sh/mm/fault.c
--- 2.4.9/arch/sh/mm/fault.c	Wed Jul  4 04:03:45 2001
+++ expand_stack/arch/sh/mm/fault.c	Sun Aug 19 06:36:04 2001
@@ -78,7 +78,7 @@
 check_stack:
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, start) == 0)
+	if (expand_stack(vma, start, NULL) == 0)
 		goto good_area;
 
 bad_area:
@@ -118,7 +118,7 @@
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.9/arch/sparc/mm/fault.c expand_stack/arch/sparc/mm/fault.c
--- 2.4.9/arch/sparc/mm/fault.c	Sat Aug 11 08:04:01 2001
+++ expand_stack/arch/sparc/mm/fault.c	Sun Aug 19 06:36:04 2001
@@ -238,7 +238,7 @@
 		goto good_area;
 	if(!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if(expand_stack(vma, address))
+	if(expand_stack(vma, address, NULL))
 		goto bad_area;
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
@@ -485,7 +485,7 @@
 		goto good_area;
 	if(!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if(expand_stack(vma, address))
+	if(expand_stack(vma, address, NULL))
 		goto bad_area;
 good_area:
 	info.si_code = SEGV_ACCERR;
diff -urN 2.4.9/arch/sparc64/mm/fault.c expand_stack/arch/sparc64/mm/fault.c
--- 2.4.9/arch/sparc64/mm/fault.c	Thu Aug 16 22:03:26 2001
+++ expand_stack/arch/sparc64/mm/fault.c	Sun Aug 19 06:36:04 2001
@@ -293,7 +293,7 @@
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.9/include/linux/mm.h expand_stack/include/linux/mm.h
--- 2.4.9/include/linux/mm.h	Fri Aug 17 05:02:27 2001
+++ expand_stack/include/linux/mm.h	Sun Aug 19 06:53:07 2001
@@ -553,13 +553,19 @@
 
 #define GFP_DMA		__GFP_DMA
 
+extern int heap_stack_gap;
+
 /* vma is the first one with  address < vma->vm_end,
  * and even  address < vma->vm_start. Have to extend vma. */
-static inline int expand_stack(struct vm_area_struct * vma, unsigned long address)
+/* NOTE: expand_stack requires the mm semaphore in write mode */
+static inline int expand_stack(struct vm_area_struct * vma, unsigned long address,
+			       struct vm_area_struct * prev_vma)
 {
 	unsigned long grow;
 
 	address &= PAGE_MASK;
+	if (prev_vma && prev_vma->vm_end + (heap_stack_gap << PAGE_SHIFT) > address)
+		return -ENOMEM;
 	grow = (vma->vm_start - address) >> PAGE_SHIFT;
 	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
 	    ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_AS].rlim_cur)
diff -urN 2.4.9/include/linux/sysctl.h expand_stack/include/linux/sysctl.h
--- 2.4.9/include/linux/sysctl.h	Fri Aug 17 05:02:42 2001
+++ expand_stack/include/linux/sysctl.h	Sun Aug 19 06:36:04 2001
@@ -134,7 +134,8 @@
 	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
 	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
 	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
-	VM_PAGE_CLUSTER=10	/* int: set number of pages to swap together */
+	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
+	VM_HEAP_STACK_GAP=11,	/* int: page gap between heap and stack */
 };
 
 
diff -urN 2.4.9/kernel/ptrace.c expand_stack/kernel/ptrace.c
--- 2.4.9/kernel/ptrace.c	Sat Jul 21 00:04:34 2001
+++ expand_stack/kernel/ptrace.c	Sun Aug 19 06:50:41 2001
@@ -185,13 +185,13 @@
 	if (!mm)
 		return 0;
 
-	down_read(&mm->mmap_sem);
+	down_write(&mm->mmap_sem);
 	vma = find_extend_vma(mm, addr);
 	copied = 0;
 	if (vma)
 		copied = access_mm(mm, vma, addr, buf, len, write);
 
-	up_read(&mm->mmap_sem);
+	up_write(&mm->mmap_sem);
 	mmput(mm);
 	return copied;
 }
diff -urN 2.4.9/kernel/sysctl.c expand_stack/kernel/sysctl.c
--- 2.4.9/kernel/sysctl.c	Sat Aug 11 08:04:32 2001
+++ expand_stack/kernel/sysctl.c	Sun Aug 19 06:36:04 2001
@@ -270,6 +270,8 @@
 	 &pgt_cache_water, 2*sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster", 
 	 &page_cluster, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_HEAP_STACK_GAP, "heap-stack-gap", 
+	 &heap_stack_gap, sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}
 };
 
diff -urN 2.4.9/mm/memory.c expand_stack/mm/memory.c
--- 2.4.9/mm/memory.c	Thu Aug 16 22:03:41 2001
+++ expand_stack/mm/memory.c	Sun Aug 19 06:50:58 2001
@@ -442,7 +442,7 @@
 	unsigned long		ptr, end;
 	int			err;
 	struct mm_struct *	mm;
-	struct vm_area_struct *	vma = 0;
+	struct vm_area_struct *	vma;
 	struct page *		map;
 	int			i;
 	int			datain = (rw == READ);
@@ -468,20 +468,25 @@
 	iobuf->length = len;
 	
 	i = 0;
+	vma = NULL;
 	
 	/* 
 	 * First of all, try to fault in all of the necessary pages
 	 */
 	while (ptr < end) {
 		if (!vma || ptr >= vma->vm_end) {
-			vma = find_vma(current->mm, ptr);
+			vma = find_vma(mm, ptr);
 			if (!vma) 
 				goto out_unlock;
 			if (vma->vm_start > ptr) {
+#if 0 /* upgrading the lock is an horrible mess here so just disable the feature for now */
 				if (!(vma->vm_flags & VM_GROWSDOWN))
 					goto out_unlock;
-				if (expand_stack(vma, ptr))
+				if (expand_stack(vma, ptr, prev_vma))
 					goto out_unlock;
+#else
+				goto out_unlock;
+#endif
 			}
 			if (((datain) && (!(vma->vm_flags & VM_WRITE))) ||
 					(!(vma->vm_flags & VM_READ))) {
diff -urN 2.4.9/mm/mmap.c expand_stack/mm/mmap.c
--- 2.4.9/mm/mmap.c	Sat May 26 04:03:50 2001
+++ expand_stack/mm/mmap.c	Sun Aug 19 06:36:04 2001
@@ -38,6 +38,7 @@
 };
 
 int sysctl_overcommit_memory;
+int heap_stack_gap = 1;
 
 /* Check that a process has enough memory to allocate a
  * new virtual mapping.
@@ -411,9 +412,15 @@
 
 	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
+		unsigned long __heap_stack_gap;
 		if (TASK_SIZE - len < addr)
 			return -ENOMEM;
-		if (!vma || addr + len <= vma->vm_start)
+		if (!vma)
+			return addr;
+		__heap_stack_gap = 0;
+		if (vma->vm_flags & VM_GROWSDOWN)
+			__heap_stack_gap = heap_stack_gap << PAGE_SHIFT;
+		if (addr + len + __heap_stack_gap <= vma->vm_start)
 			return addr;
 		addr = vma->vm_end;
 	}
@@ -532,11 +539,11 @@
 
 struct vm_area_struct * find_extend_vma(struct mm_struct * mm, unsigned long addr)
 {
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev_vma;
 	unsigned long start;
 
 	addr &= PAGE_MASK;
-	vma = find_vma(mm,addr);
+	vma = find_vma_prev(mm,addr, &prev_vma);
 	if (!vma)
 		return NULL;
 	if (vma->vm_start <= addr)
@@ -544,7 +551,7 @@
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		return NULL;
 	start = vma->vm_start;
-	if (expand_stack(vma, addr))
+	if (expand_stack(vma, addr, prev_vma))
 		return NULL;
 	if (vma->vm_flags & VM_LOCKED) {
 		make_pages_present(addr, start);

Andrea
