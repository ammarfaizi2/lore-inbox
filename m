Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272399AbRIKLXh>; Tue, 11 Sep 2001 07:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272401AbRIKLX3>; Tue, 11 Sep 2001 07:23:29 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:4381 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272399AbRIKLXT>; Tue, 11 Sep 2001 07:23:19 -0400
Date: Tue, 11 Sep 2001 13:24:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Dike <jdike@karaya.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: expand_stack fix [was Re: 2.4.9aa3]
Message-ID: <20010911132405.Q715@athlon.random>
In-Reply-To: <20010908180416.Z11329@athlon.random> <200109090423.XAA03403@ccure.karaya.com> <20010909055038.M11329@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010909055038.M11329@athlon.random>; from andrea@suse.de on Sun, Sep 09, 2001 at 05:50:38AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2001 at 05:50:38AM +0200, Andrea Arcangeli wrote:
> On Sat, Sep 08, 2001 at 11:23:38PM -0500, Jeff Dike wrote:
> > andrea@suse.de said:
> > > My fix for the race doesn't drop the usability of GROWSDOWN that could
> > > otherwise break userspace programs. I guess at least uml uses
> > > growsdown vma file backed. Jeff? 
> > 
> > No.  In neither the host kernel or UML is there a vma that's file backed and
> > growsdown.
> > 
> > UML process stacks are marked growsdown in UML and are file backed on the host,
> > but that's not the same thing.
> 
> ok, so I guess you're doing the growsdown by hand in the uml sigsegv
> handler.
> 
> So it's probably fine to allow GROWSDOWN only on anon vmas per Linus's
> suggestion. I can attempt to change the race fix that way.

Here it is against pre[78], in short it forbids MAP_GROWSDOWN (/GROWSUP
even if GROWSUP is basically a noop but checking for it too was nocost
and it makes sense) for file backed mmaps, and it so avoids the vma
pgoff race in expand_stack, plus it fixes a few more bits in
expand_stack.  See the comment above expand_stack for the locking
details. Plus as usual it adds the sysctl configurable gap of pages
between a growsdown vma and its previous vma to help userspace
reliability. It also reads vma->vm_start after expand_stack in
find_extend_vma.

this is running on my desktop for one day happily and no app triggered
the new -EINVAL in mmap yet.

diff -urN 2.4.10pre8/arch/alpha/mm/fault.c expand_stack/arch/alpha/mm/fault.c
--- 2.4.10pre8/arch/alpha/mm/fault.c	Sun Apr  1 01:17:07 2001
+++ expand_stack/arch/alpha/mm/fault.c	Tue Sep 11 05:03:56 2001
@@ -121,7 +121,7 @@
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.10pre8/arch/arm/mm/fault-common.c expand_stack/arch/arm/mm/fault-common.c
--- 2.4.10pre8/arch/arm/mm/fault-common.c	Thu Aug 16 22:03:23 2001
+++ expand_stack/arch/arm/mm/fault-common.c	Tue Sep 11 05:03:56 2001
@@ -229,7 +229,7 @@
 	goto survive;
 
 check_stack:
-	if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr))
+	if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr, NULL))
 		goto good_area;
 out:
 	return fault;
diff -urN 2.4.10pre8/arch/cris/mm/fault.c expand_stack/arch/cris/mm/fault.c
--- 2.4.10pre8/arch/cris/mm/fault.c	Sat Aug 11 08:03:54 2001
+++ expand_stack/arch/cris/mm/fault.c	Tue Sep 11 05:03:56 2001
@@ -284,7 +284,7 @@
 		if (address + PAGE_SIZE < rdusp())
 			goto bad_area;
 	}
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 
 	/*
diff -urN 2.4.10pre8/arch/i386/mm/fault.c expand_stack/arch/i386/mm/fault.c
--- 2.4.10pre8/arch/i386/mm/fault.c	Tue Sep 11 04:09:20 2001
+++ expand_stack/arch/i386/mm/fault.c	Tue Sep 11 05:03:56 2001
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
@@ -168,7 +169,8 @@
 		if (address + 32 < regs->esp)
 			goto bad_area;
 	}
-	if (expand_stack(vma, address))
+	find_vma_prev(mm, address, &prev_vma);
+	if (expand_stack(vma, address, prev_vma))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.10pre8/arch/ia64/mm/fault.c expand_stack/arch/ia64/mm/fault.c
--- 2.4.10pre8/arch/ia64/mm/fault.c	Tue May  1 19:35:18 2001
+++ expand_stack/arch/ia64/mm/fault.c	Tue Sep 11 05:03:56 2001
@@ -122,7 +122,7 @@
 		if (rgn_index(address) != rgn_index(vma->vm_start)
 		    || rgn_offset(address) >= RGN_MAP_LIMIT)
 			goto bad_area;
-		if (expand_stack(vma, address))
+		if (expand_stack(vma, address, NULL))
 			goto bad_area;
 	} else {
 		vma = prev_vma;
diff -urN 2.4.10pre8/arch/m68k/mm/fault.c expand_stack/arch/m68k/mm/fault.c
--- 2.4.10pre8/arch/m68k/mm/fault.c	Sun Apr  1 01:17:08 2001
+++ expand_stack/arch/m68k/mm/fault.c	Tue Sep 11 05:03:56 2001
@@ -120,7 +120,7 @@
 		if (address + 256 < rdusp())
 			goto map_err;
 	}
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto map_err;
 
 /*
diff -urN 2.4.10pre8/arch/mips/mm/fault.c expand_stack/arch/mips/mm/fault.c
--- 2.4.10pre8/arch/mips/mm/fault.c	Sat Jul 21 00:04:05 2001
+++ expand_stack/arch/mips/mm/fault.c	Tue Sep 11 05:03:56 2001
@@ -80,7 +80,7 @@
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.10pre8/arch/mips64/mm/fault.c expand_stack/arch/mips64/mm/fault.c
--- 2.4.10pre8/arch/mips64/mm/fault.c	Tue Sep 11 04:09:24 2001
+++ expand_stack/arch/mips64/mm/fault.c	Tue Sep 11 05:03:56 2001
@@ -132,7 +132,7 @@
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.10pre8/arch/ppc/mm/fault.c expand_stack/arch/ppc/mm/fault.c
--- 2.4.10pre8/arch/ppc/mm/fault.c	Wed Jul  4 04:03:45 2001
+++ expand_stack/arch/ppc/mm/fault.c	Tue Sep 11 05:03:56 2001
@@ -64,7 +64,7 @@
 void do_page_fault(struct pt_regs *regs, unsigned long address,
 		   unsigned long error_code)
 {
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev_vma;
 	struct mm_struct *mm = current->mm;
 	siginfo_t info;
 	int code = SEGV_MAPERR;
@@ -111,7 +111,8 @@
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	vma = find_vma_prev(mm, address, &prev_vma);
+	if (expand_stack(vma, address, prev_vma))
 		goto bad_area;
 
 good_area:
diff -urN 2.4.10pre8/arch/s390/mm/fault.c expand_stack/arch/s390/mm/fault.c
--- 2.4.10pre8/arch/s390/mm/fault.c	Sat Aug 11 08:03:59 2001
+++ expand_stack/arch/s390/mm/fault.c	Tue Sep 11 05:03:56 2001
@@ -122,7 +122,7 @@
                 goto good_area;
         if (!(vma->vm_flags & VM_GROWSDOWN))
                 goto bad_area;
-        if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
                 goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.10pre8/arch/s390x/mm/fault.c expand_stack/arch/s390x/mm/fault.c
--- 2.4.10pre8/arch/s390x/mm/fault.c	Sat Aug 11 08:04:00 2001
+++ expand_stack/arch/s390x/mm/fault.c	Tue Sep 11 05:03:56 2001
@@ -152,7 +152,7 @@
                 goto good_area;
         if (!(vma->vm_flags & VM_GROWSDOWN))
                 goto bad_area;
-        if (expand_stack(vma, address))
+        if (expand_stack(vma, address, NULL))
                 goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.10pre8/arch/sh/mm/fault.c expand_stack/arch/sh/mm/fault.c
--- 2.4.10pre8/arch/sh/mm/fault.c	Tue Sep 11 04:09:28 2001
+++ expand_stack/arch/sh/mm/fault.c	Tue Sep 11 05:03:56 2001
@@ -74,7 +74,7 @@
 check_stack:
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, start) == 0)
+	if (expand_stack(vma, start, NULL) == 0)
 		goto good_area;
 
 bad_area:
@@ -114,7 +114,7 @@
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.10pre8/arch/sparc/mm/fault.c expand_stack/arch/sparc/mm/fault.c
--- 2.4.10pre8/arch/sparc/mm/fault.c	Sat Aug 11 08:04:01 2001
+++ expand_stack/arch/sparc/mm/fault.c	Tue Sep 11 05:03:56 2001
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
diff -urN 2.4.10pre8/arch/sparc64/mm/fault.c expand_stack/arch/sparc64/mm/fault.c
--- 2.4.10pre8/arch/sparc64/mm/fault.c	Tue Sep 11 04:09:29 2001
+++ expand_stack/arch/sparc64/mm/fault.c	Tue Sep 11 05:03:56 2001
@@ -340,7 +340,7 @@
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
diff -urN 2.4.10pre8/include/linux/mm.h expand_stack/include/linux/mm.h
--- 2.4.10pre8/include/linux/mm.h	Tue Sep 11 04:10:02 2001
+++ expand_stack/include/linux/mm.h	Tue Sep 11 05:03:56 2001
@@ -556,25 +556,42 @@
 
 #define GFP_DMA		__GFP_DMA
 
-/* vma is the first one with  address < vma->vm_end,
- * and even  address < vma->vm_start. Have to extend vma. */
-static inline int expand_stack(struct vm_area_struct * vma, unsigned long address)
+extern int heap_stack_gap;
+
+/*
+ * vma is the first one with  address < vma->vm_end,
+ * and even  address < vma->vm_start. Have to extend vma.
+ *
+ * Locking: vm_start can decrease under you if you only hold
+ * the read semaphore, you either need the write semaphore
+ * or both the read semaphore and the page_table_lock acquired
+ * if you want vm_start consistent. vm_end and the vma layout
+ * are just consistent with only the read semaphore acquired
+ * instead.
+ */
+static inline int expand_stack(struct vm_area_struct * vma, unsigned long address,
+			       struct vm_area_struct * prev_vma)
 {
 	unsigned long grow;
+	int err = -ENOMEM;
 
 	address &= PAGE_MASK;
+	if (prev_vma && prev_vma->vm_end + (heap_stack_gap << PAGE_SHIFT) > address)
+		goto out;
+	spin_lock(&vma->vm_mm->page_table_lock);
 	grow = (vma->vm_start - address) >> PAGE_SHIFT;
 	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
 	    ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_AS].rlim_cur)
-		return -ENOMEM;
-	spin_lock(&vma->vm_mm->page_table_lock);
+		goto out_unlock;
 	vma->vm_start = address;
-	vma->vm_pgoff -= grow;
 	vma->vm_mm->total_vm += grow;
 	if (vma->vm_flags & VM_LOCKED)
 		vma->vm_mm->locked_vm += grow;
+	err = 0;
+ out_unlock:
 	spin_unlock(&vma->vm_mm->page_table_lock);
-	return 0;
+ out:
+	return err;
 }
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
diff -urN 2.4.10pre8/include/linux/sysctl.h expand_stack/include/linux/sysctl.h
--- 2.4.10pre8/include/linux/sysctl.h	Tue Sep 11 04:10:02 2001
+++ expand_stack/include/linux/sysctl.h	Tue Sep 11 05:03:56 2001
@@ -135,7 +135,8 @@
 	VM_PAGECACHE=7,		/* struct: Set cache memory thresholds */
 	VM_PAGERDAEMON=8,	/* struct: Control kswapd behaviour */
 	VM_PGT_CACHE=9,		/* struct: Set page table cache parameters */
-	VM_PAGE_CLUSTER=10	/* int: set number of pages to swap together */
+	VM_PAGE_CLUSTER=10,	/* int: set number of pages to swap together */
+	VM_HEAP_STACK_GAP=11,	/* int: page gap between heap and stack */
 };
 
 
diff -urN 2.4.10pre8/kernel/sysctl.c expand_stack/kernel/sysctl.c
--- 2.4.10pre8/kernel/sysctl.c	Tue Sep 11 04:10:03 2001
+++ expand_stack/kernel/sysctl.c	Tue Sep 11 05:03:56 2001
@@ -268,6 +268,8 @@
 	 &pgt_cache_water, 2*sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_PAGE_CLUSTER, "page-cluster", 
 	 &page_cluster, sizeof(int), 0644, NULL, &proc_dointvec},
+	{VM_HEAP_STACK_GAP, "heap-stack-gap", 
+	 &heap_stack_gap, sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}
 };
 
diff -urN 2.4.10pre8/mm/memory.c expand_stack/mm/memory.c
--- 2.4.10pre8/mm/memory.c	Tue Sep 11 04:10:03 2001
+++ expand_stack/mm/memory.c	Tue Sep 11 05:04:11 2001
@@ -442,7 +442,7 @@
 	unsigned long		ptr, end;
 	int			err;
 	struct mm_struct *	mm;
-	struct vm_area_struct *	vma = 0;
+	struct vm_area_struct *	vma, * prev_vma;
 	struct page *		map;
 	int			i;
 	int			datain = (rw == READ);
@@ -468,19 +468,21 @@
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
 				if (!(vma->vm_flags & VM_GROWSDOWN))
 					goto out_unlock;
-				if (expand_stack(vma, ptr))
+				find_vma_prev(mm, ptr, &prev_vma);
+				if (expand_stack(vma, ptr, prev_vma))
 					goto out_unlock;
 			}
 			if (((datain) && (!(vma->vm_flags & VM_WRITE))) ||
diff -urN 2.4.10pre8/mm/mmap.c expand_stack/mm/mmap.c
--- 2.4.10pre8/mm/mmap.c	Sat May 26 04:03:50 2001
+++ expand_stack/mm/mmap.c	Tue Sep 11 05:03:56 2001
@@ -38,6 +38,7 @@
 };
 
 int sysctl_overcommit_memory;
+int heap_stack_gap = 1;
 
 /* Check that a process has enough memory to allocate a
  * new virtual mapping.
@@ -292,7 +293,6 @@
 	}
 
 	/* Clear old maps */
-	error = -ENOMEM;
 	if (do_munmap(mm, addr, len))
 		return -ENOMEM;
 
@@ -337,6 +337,9 @@
 	vma->vm_raend = 0;
 
 	if (file) {
+		error = -EINVAL;
+		if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
+			goto free_vma;
 		if (vm_flags & VM_DENYWRITE) {
 			error = deny_write_access(file);
 			if (error)
@@ -411,9 +414,15 @@
 
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
@@ -532,7 +541,7 @@
 
 struct vm_area_struct * find_extend_vma(struct mm_struct * mm, unsigned long addr)
 {
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev_vma;
 	unsigned long start;
 
 	addr &= PAGE_MASK;
@@ -543,9 +552,10 @@
 		return vma;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		return NULL;
-	start = vma->vm_start;
-	if (expand_stack(vma, addr))
+	find_vma_prev(mm, addr, &prev_vma);
+	if (expand_stack(vma, addr, prev_vma))
 		return NULL;
+	start = vma->vm_start;
 	if (vma->vm_flags & VM_LOCKED) {
 		make_pages_present(addr, start);
 	}

Andrea
