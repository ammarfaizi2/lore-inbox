Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161276AbWBVAOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161276AbWBVAOe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWBVAOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:14:34 -0500
Received: from ozlabs.org ([203.10.76.45]:26825 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161267AbWBVAOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:14:33 -0500
Date: Wed, 22 Feb 2006 11:13:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: IA64 non-contiguous memory space bugs
Message-ID: <20060222001359.GA23574@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite some time ago, I found (by inspection) an ia64 specific bug
related to its non-contiguous user address space.  I've never done
anything about it, because I don't have an ia64 to test on - but
somebody should fix it.  Recently I've spotted another possible bug,
also by inspection - I don't know enough about ia64 to tell if it's a
real problem or not.

First bug (confirmed many months ago by Chris Wedgwood) - you can get
weird effects if you attempt to mmap() something into one of the
address space gaps.  The ia64 outer wrapper for mmap2() tries to
prevent it, but doesn't do a good enough job, it's still possible
indirectly with shmat() and maybe mremap().  Basic trouble is that
most of the checks applied by the generic code assume that everything
between 0 and TASK_SIZE is valid.  Patch below addresses this, or did
- quite likely it's bitrotted since I wrote it.

Second problem is in the hugepage logic in free_pgtables()
(mm/memory.c).  As far as I can tell it's complete crap, and only
works by accident, for different accidental reasons on ppc64 and ia64,
the only archs that have a non-trivial is_hugepage_only_range().
Except that I'm not sure it does entirely work by accident on ia64:
suppose a process has a hugepage mapping that begins some way after
the beginning of the hugepage address range.  Before
hugetlb_free_pgd_range() gets called on that area, it will be called
on the next normal page VMA down - but with an end address at the
beginning of the hugepage VMA and so extending into the hugepage
address range.  I don't really understand the ia64 pagetable mapping
stuff well enough to tell if that's dangerous or not.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

Index: working-2.6/mm/mremap.c
===================================================================
--- working-2.6.orig/mm/mremap.c	2004-08-30 10:23:00.000000000 +1000
+++ working-2.6/mm/mremap.c	2004-09-24 15:02:18.169776624 +1000
@@ -274,7 +274,7 @@
 		if (!(flags & MREMAP_MAYMOVE))
 			goto out;
 
-		if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
+		if (! GOOD_TASK_VM_RANGE(new_addr, new_len))
 			goto out;
 
 		/* Check if the location we're moving into overlaps the
@@ -351,6 +351,8 @@
 	    !((flags & MREMAP_FIXED) && (addr != new_addr)) &&
 	    (old_len != new_len || !(flags & MREMAP_MAYMOVE))) {
 		unsigned long max_addr = TASK_SIZE;
+		if (max_addr > REGION_MAX(vma->vm_start))
+			max_addr = REGION_MAX(vma->vm_start);
 		if (vma->vm_next)
 			max_addr = vma->vm_next->vm_start;
 		/* can we just expand the current mapping? */
Index: working-2.6/mm/mmap.c
===================================================================
--- working-2.6.orig/mm/mmap.c	2004-09-07 10:38:00.000000000 +1000
+++ working-2.6/mm/mmap.c	2004-09-24 15:02:18.170776472 +1000
@@ -1209,7 +1209,7 @@
 	if (flags & MAP_FIXED) {
 		unsigned long ret;
 
-		if (addr > TASK_SIZE - len)
+		if (! GOOD_TASK_VM_RANGE(addr, len))
 			return -ENOMEM;
 		if (addr & ~PAGE_MASK)
 			return -EINVAL;
@@ -1658,7 +1658,7 @@
 	unsigned long end;
 	struct vm_area_struct *mpnt, *prev, *last;
 
-	if ((start & ~PAGE_MASK) || start > TASK_SIZE || len > TASK_SIZE-start)
+	if ((start & ~PAGE_MASK) || !GOOD_TASK_VM_RANGE(start, len))
 		return -EINVAL;
 
 	if ((len = PAGE_ALIGN(len)) == 0)
@@ -1749,7 +1749,7 @@
 	if (!len)
 		return addr;
 
-	if ((addr + len) > TASK_SIZE || (addr + len) < addr)
+	if (! GOOD_TASK_VM_RANGE(addr, len))
 		return -EINVAL;
 
 	/*
Index: working-2.6/include/asm-ia64/page.h
===================================================================
--- working-2.6.orig/include/asm-ia64/page.h	2004-09-10 13:26:27.000000000 +1000
+++ working-2.6/include/asm-ia64/page.h	2004-09-24 15:02:18.171776320 +1000
@@ -123,6 +123,8 @@
 #define REGION_SIZE		REGION_NUMBER(1)
 #define REGION_KERNEL		7
 
+#define REGION_MAX(x)	((REGION_NUMBER(x)<<61) + RGN_MAP_LIMIT)
+
 #ifdef CONFIG_HUGETLB_PAGE
 # define htlbpage_to_page(x)	((REGION_NUMBER(x) << 61)				\
 				 | (REGION_OFFSET(x) >> (HPAGE_SHIFT-PAGE_SHIFT)))
Index: working-2.6/include/linux/mm.h
===================================================================
--- working-2.6.orig/include/linux/mm.h	2004-09-07 10:38:00.000000000 +1000
+++ working-2.6/include/linux/mm.h	2004-09-24 15:02:18.172776168 +1000
@@ -41,6 +41,13 @@
 #define MM_VM_SIZE(mm)	TASK_SIZE
 #endif
 
+#ifndef REGION_MAX
+#define REGION_MAX(addr)	TASK_SIZE
+#endif
+
+#define GOOD_TASK_VM_RANGE(addr, len) \
+	( ((addr)+(len) >= (addr)) || ((addr)+(len) <= TASK_SIZE) \
+	  || ((addr)+(len) <= REGION_MAX(addr)) )
 /*
  * Linux kernel virtual memory manager primitives.
  * The idea being to have a "virtual" mm in the same way
Index: working-2.6/fs/binfmt_elf.c
===================================================================
--- working-2.6.orig/fs/binfmt_elf.c	2004-09-24 10:14:10.000000000 +1000
+++ working-2.6/fs/binfmt_elf.c	2004-09-24 15:02:18.174775864 +1000
@@ -81,7 +81,8 @@
 		.min_coredump	= ELF_EXEC_PAGESIZE
 };
 
-#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
+#define BAD_ADDR(x)	(((unsigned long)(x) > TASK_SIZE) \
+		 || ((unsigned long)(x) >= REGION_MAX((unsigned long)x)) )
 
 static int set_brk(unsigned long start, unsigned long end)
 {
@@ -370,8 +371,8 @@
 	     * <= p_memsize so it is only necessary to check p_memsz.
 	     */
 	    k = load_addr + eppnt->p_vaddr;
-	    if (k > TASK_SIZE || eppnt->p_filesz > eppnt->p_memsz ||
-		eppnt->p_memsz > TASK_SIZE || TASK_SIZE - eppnt->p_memsz < k) {
+	    if ((eppnt->p_filesz > eppnt->p_memsz) ||
+		! GOOD_TASK_VM_RANGE(k, eppnt->p_memsz)) {
 	        error = -ENOMEM;
 		goto out_close;
 	    }
@@ -798,9 +799,8 @@
 		 * allowed task size. Note that p_filesz must always be
 		 * <= p_memsz so it is only necessary to check p_memsz.
 		 */
-		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
-		    elf_ppnt->p_memsz > TASK_SIZE ||
-		    TASK_SIZE - elf_ppnt->p_memsz < k) {
+		if (elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
+		    ! GOOD_TASK_VM_RANGE(k, elf_ppnt->p_memsz)) {
 			/* set_brk can never work.  Avoid overflows.  */
 			send_sig(SIGKILL, current, 0);
 			goto out_free_dentry;
Index: working-2.6/arch/ia64/kernel/sys_ia64.c
===================================================================
--- working-2.6.orig/arch/ia64/kernel/sys_ia64.c	2004-08-09 09:51:26.000000000 +1000
+++ working-2.6/arch/ia64/kernel/sys_ia64.c	2004-09-24 15:02:18.175775712 +1000
@@ -211,17 +211,6 @@
 		goto out;
 	}
 
-	/*
-	 * Don't permit mappings into unmapped space, the virtual page table of a region,
-	 * or across a region boundary.  Note: RGN_MAP_LIMIT is equal to 2^n-PAGE_SIZE
-	 * (for some integer n <= 61) and len > 0.
-	 */
-	roff = REGION_OFFSET(addr);
-	if ((len > RGN_MAP_LIMIT) || (roff > (RGN_MAP_LIMIT - len))) {
-		addr = -EINVAL;
-		goto out;
-	}
-
 	down_write(&current->mm->mmap_sem);
 	addr = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
 	up_write(&current->mm->mmap_sem);


----- End forwarded message -----

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
