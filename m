Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWFHQPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWFHQPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 12:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWFHQPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 12:15:09 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:35722 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964895AbWFHQPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 12:15:07 -0400
Message-ID: <44884BAC.7050909@comcast.net>
Date: Thu, 08 Jun 2006 12:09:16 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [REPOST][PATCH][RFC] Clean-up:  TASK_UNMAPPED_BASE and mmap_base
References: <44862CE3.7040406@comcast.net>
In-Reply-To: <44862CE3.7040406@comcast.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Reposting this with the attachment inline.

John Richard Moser wrote:
> This patch applies to 2.6.17-rc6 to replace several occurrences of
> TASK_UNMAPPED_BASE with current->mm->mmap_base, mm->mmap_base, or base,
> as appropriate.
> 
> I am not entirely sure what all of the code I messed with is doing, to
> be quite honest.  Code that seemed to be initializing a task and setting
> up the mmap() base I left with TASK_UNMAPPED_BASE; code that seemed to
> be trying to figure out what the mmap() base was I replaced with
> mm->mmap_base.
> 
> Because of this, I may have made a couple errors.  Could I get some
> comments on whether any of this is dirty and why?  I'll make appropriate
> changes and re-submit.  This only took 2 hours anyway.
> 
> 
> 
> ------------------------------------------------------------------------
diff -urNp linux-2.6.17-rc6/arch/alpha/kernel/osf_sys.c linux-2.6.17-rc6-fix_tub/arch/alpha/kernel/osf_sys.c
- --- linux-2.6.17-rc6/arch/alpha/kernel/osf_sys.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/alpha/kernel/osf_sys.c	2006-06-06 20:20:27.000000000 -0400
@@ -1279,8 +1279,8 @@ arch_get_unmapped_area(struct file *filp
 			return addr;
 	}

- -	/* Next, try allocating at TASK_UNMAPPED_BASE.  */
- -	addr = arch_get_unmapped_area_1 (PAGE_ALIGN(TASK_UNMAPPED_BASE),
+	/* Next, try allocating at current->mm->mmap_base.  */
+	addr = arch_get_unmapped_area_1 (PAGE_ALIGN(current->mm->mmap_base),
 					 len, limit);
 	if (addr != (unsigned long) -ENOMEM)
 		return addr;
diff -urNp linux-2.6.17-rc6/arch/arm/mm/mmap.c linux-2.6.17-rc6-fix_tub/arch/arm/mm/mmap.c
- --- linux-2.6.17-rc6/arch/arm/mm/mmap.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/arm/mm/mmap.c	2006-06-06 20:31:59.000000000 -0400
@@ -76,7 +76,7 @@ arch_get_unmapped_area(struct file *filp
 	if (len > mm->cached_hole_size) {
 	        start_addr = addr = mm->free_area_cache;
 	} else {
- -	        start_addr = addr = TASK_UNMAPPED_BASE;
+	        start_addr = addr = mm->mmap_base;
 	        mm->cached_hole_size = 0;
 	}

@@ -93,8 +93,8 @@ full_search:
 			 * Start a new search - just in case we missed
 			 * some holes.
 			 */
- -			if (start_addr != TASK_UNMAPPED_BASE) {
- -				start_addr = addr = TASK_UNMAPPED_BASE;
+			if (start_addr != mm->mmap_base) {
+				start_addr = addr = mm->mmap_base;
 				mm->cached_hole_size = 0;
 				goto full_search;
 			}
diff -urNp linux-2.6.17-rc6/arch/i386/mm/hugetlbpage.c linux-2.6.17-rc6-fix_tub/arch/i386/mm/hugetlbpage.c
- --- linux-2.6.17-rc6/arch/i386/mm/hugetlbpage.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/i386/mm/hugetlbpage.c	2006-06-06 20:44:53.000000000 -0400
@@ -126,7 +126,7 @@ static unsigned long hugetlb_get_unmappe
 	if (len > mm->cached_hole_size) {
 	        start_addr = mm->free_area_cache;
 	} else {
- -	        start_addr = TASK_UNMAPPED_BASE;
+	        start_addr = mm->mmap_base;
 	        mm->cached_hole_size = 0;
 	}

@@ -140,8 +140,8 @@ full_search:
 			 * Start a new search - just in case we missed
 			 * some holes.
 			 */
- -			if (start_addr != TASK_UNMAPPED_BASE) {
- -				start_addr = TASK_UNMAPPED_BASE;
+			if (start_addr != mm->mmap_base) {
+				start_addr = mm->mmap_base;
 				mm->cached_hole_size = 0;
 				goto full_search;
 			}
@@ -232,7 +232,7 @@ fail:
 	 * can happen with large stack limits and large mmap()
 	 * allocations.
 	 */
- -	mm->free_area_cache = TASK_UNMAPPED_BASE;
+	mm->free_area_cache = base;
 	mm->cached_hole_size = ~0UL;
 	addr = hugetlb_get_unmapped_area_bottomup(file, addr0,
 			len, pgoff, flags);
diff -urNp linux-2.6.17-rc6/arch/ia64/kernel/sys_ia64.c linux-2.6.17-rc6-fix_tub/arch/ia64/kernel/sys_ia64.c
- --- linux-2.6.17-rc6/arch/ia64/kernel/sys_ia64.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/ia64/kernel/sys_ia64.c	2006-06-06 20:52:09.000000000 -0400
@@ -56,9 +56,9 @@ arch_get_unmapped_area (struct file *fil
 	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
 		if (TASK_SIZE - len < addr || RGN_MAP_LIMIT - len < REGION_OFFSET(addr)) {
- -			if (start_addr != TASK_UNMAPPED_BASE) {
+			if (start_addr != mm->mmap_base) {
 				/* Start a new search --- just in case we missed some holes.  */
- -				addr = TASK_UNMAPPED_BASE;
+				addr = mm->mmap_base;
 				goto full_search;
 			}
 			return -ENOMEM;
diff -urNp linux-2.6.17-rc6/arch/mips/kernel/syscall.c linux-2.6.17-rc6-fix_tub/arch/mips/kernel/syscall.c
- --- linux-2.6.17-rc6/arch/mips/kernel/syscall.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/mips/kernel/syscall.c	2006-06-06 20:53:45.000000000 -0400
@@ -99,7 +99,7 @@ unsigned long arch_get_unmapped_area(str
 		    (!vmm || addr + len <= vmm->vm_start))
 			return addr;
 	}
- -	addr = TASK_UNMAPPED_BASE;
+	addr = current->mm->mmap_base;
 	if (do_color_align)
 		addr = COLOUR_ALIGN(addr, pgoff);
 	else
diff -urNp linux-2.6.17-rc6/arch/parisc/kernel/sys_parisc.c linux-2.6.17-rc6-fix_tub/arch/parisc/kernel/sys_parisc.c
- --- linux-2.6.17-rc6/arch/parisc/kernel/sys_parisc.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/parisc/kernel/sys_parisc.c	2006-06-06 20:20:27.000000000 -0400
@@ -105,7 +105,7 @@ unsigned long arch_get_unmapped_area(str
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 	if (!addr)
- -		addr = TASK_UNMAPPED_BASE;
+		addr = current->mm->mmap_base;

 	if (filp) {
 		addr = get_shared_area(filp->f_mapping, addr, len, pgoff);
diff -urNp linux-2.6.17-rc6/arch/powerpc/mm/hugetlbpage.c linux-2.6.17-rc6-fix_tub/arch/powerpc/mm/hugetlbpage.c
- --- linux-2.6.17-rc6/arch/powerpc/mm/hugetlbpage.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/powerpc/mm/hugetlbpage.c	2006-06-06 20:56:21.000000000 -0400
@@ -573,7 +573,7 @@ unsigned long arch_get_unmapped_area(str
 	if (len > mm->cached_hole_size) {
 	        start_addr = addr = mm->free_area_cache;
 	} else {
- -	        start_addr = addr = TASK_UNMAPPED_BASE;
+	        start_addr = addr = mm->mmap_base;
 	        mm->cached_hole_size = 0;
 	}

@@ -606,8 +606,8 @@ full_search:
 	}

 	/* Make sure we didn't miss any holes */
- -	if (start_addr != TASK_UNMAPPED_BASE) {
- -		start_addr = addr = TASK_UNMAPPED_BASE;
+	if (start_addr != mm->mmap_base) {
+		start_addr = addr = mm->mmap_base;
 		mm->cached_hole_size = 0;
 		goto full_search;
 	}
@@ -721,7 +721,7 @@ fail:
 	 * can happen with large stack limits and large mmap()
 	 * allocations.
 	 */
- -	mm->free_area_cache = TASK_UNMAPPED_BASE;
+	mm->free_area_cache = base;
 	mm->cached_hole_size = ~0UL;
 	addr = arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
 	/*
diff -urNp linux-2.6.17-rc6/arch/powerpc/mm/slb.c linux-2.6.17-rc6-fix_tub/arch/powerpc/mm/slb.c
- --- linux-2.6.17-rc6/arch/powerpc/mm/slb.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/powerpc/mm/slb.c	2006-06-06 21:06:24.000000000 -0400
@@ -128,11 +128,11 @@ void switch_slb(struct task_struct *tsk,

 	/*
 	 * preload some userspace segments into the SLB.
+	 *
+	 * I'm pretty sure the task's mmap base is correct
+	 * for its processor mode (32/64 bit) --JM
 	 */
- -	if (test_tsk_thread_flag(tsk, TIF_32BIT))
- -		unmapped_base = TASK_UNMAPPED_BASE_USER32;
- -	else
- -		unmapped_base = TASK_UNMAPPED_BASE_USER64;
+	unmapped_base = mm->mmap_base;

 	if (is_kernel_addr(pc))
 		return;
diff -urNp linux-2.6.17-rc6/arch/powerpc/mm/stab.c linux-2.6.17-rc6-fix_tub/arch/powerpc/mm/stab.c
- --- linux-2.6.17-rc6/arch/powerpc/mm/stab.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/powerpc/mm/stab.c	2006-06-06 21:07:39.000000000 -0400
@@ -204,11 +204,12 @@ void switch_stab(struct task_struct *tsk
 	get_paca()->pgdir = mm->pgd;
 #endif /* CONFIG_PPC_64K_PAGES */

- -	/* Now preload some entries for the new task */
- -	if (test_tsk_thread_flag(tsk, TIF_32BIT))
- -		unmapped_base = TASK_UNMAPPED_BASE_USER32;
- -	else
- -		unmapped_base = TASK_UNMAPPED_BASE_USER64;
+	/*
+	 *  Now preload some entries for the new task
+	 *
+	 *  The task's current mmap base is probably right.
+	 */
+	unmapped_base = mm->mmap_base;

 	__ste_allocate(pc, mm);

diff -urNp linux-2.6.17-rc6/arch/sh/kernel/sys_sh.c linux-2.6.17-rc6-fix_tub/arch/sh/kernel/sys_sh.c
- --- linux-2.6.17-rc6/arch/sh/kernel/sys_sh.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/sh/kernel/sys_sh.c	2006-06-06 21:13:39.000000000 -0400
@@ -81,7 +81,7 @@ unsigned long arch_get_unmapped_area(str
 	}
 	if (len <= mm->cached_hole_size) {
 	        mm->cached_hole_size = 0;
- -		mm->free_area_cache = TASK_UNMAPPED_BASE;
+		mm->free_area_cache = mm->mmap_base;
 	}
 	if (flags & MAP_PRIVATE)
 		addr = PAGE_ALIGN(mm->free_area_cache);
@@ -97,8 +97,8 @@ full_search:
 			 * Start a new search - just in case we missed
 			 * some holes.
 			 */
- -			if (start_addr != TASK_UNMAPPED_BASE) {
- -				start_addr = addr = TASK_UNMAPPED_BASE;
+			if (start_addr != mm->mmap_base) {
+				start_addr = addr = mm->mmap_base;
 				mm->cached_hole_size = 0;
 				goto full_search;
 			}
diff -urNp linux-2.6.17-rc6/arch/sh64/kernel/sys_sh64.c linux-2.6.17-rc6-fix_tub/arch/sh64/kernel/sys_sh64.c
- --- linux-2.6.17-rc6/arch/sh64/kernel/sys_sh64.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/sh64/kernel/sys_sh64.c	2006-06-06 20:20:27.000000000 -0400
@@ -112,7 +112,7 @@ unsigned long arch_get_unmapped_area(str
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 	if (!addr)
- -		addr = TASK_UNMAPPED_BASE;
+		addr = current->mm->mmap_base;

 	if (flags & MAP_PRIVATE)
 		addr = PAGE_ALIGN(addr);
diff -urNp linux-2.6.17-rc6/arch/sparc/kernel/sys_sparc.c linux-2.6.17-rc6-fix_tub/arch/sparc/kernel/sys_sparc.c
- --- linux-2.6.17-rc6/arch/sparc/kernel/sys_sparc.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/sparc/kernel/sys_sparc.c	2006-06-06 20:20:27.000000000 -0400
@@ -56,7 +56,7 @@ unsigned long arch_get_unmapped_area(str
 	if (ARCH_SUN4C_SUN4 && len > 0x20000000)
 		return -ENOMEM;
 	if (!addr)
- -		addr = TASK_UNMAPPED_BASE;
+		addr = current->mm->mmap_base;

 	if (flags & MAP_SHARED)
 		addr = COLOUR_ALIGN(addr);
diff -urNp linux-2.6.17-rc6/arch/sparc64/kernel/sys_sparc.c linux-2.6.17-rc6-fix_tub/arch/sparc64/kernel/sys_sparc.c
- --- linux-2.6.17-rc6/arch/sparc64/kernel/sys_sparc.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/sparc64/kernel/sys_sparc.c	2006-06-06 21:16:27.000000000 -0400
@@ -155,7 +155,7 @@ unsigned long arch_get_unmapped_area(str
 	if (len > mm->cached_hole_size) {
 	        start_addr = addr = mm->free_area_cache;
 	} else {
- -	        start_addr = addr = TASK_UNMAPPED_BASE;
+	        start_addr = addr = mm->mmap_base;
 	        mm->cached_hole_size = 0;
 	}

@@ -175,8 +175,8 @@ full_search:
 			vma = find_vma(mm, VA_EXCLUDE_END);
 		}
 		if (unlikely(task_size < addr)) {
- -			if (start_addr != TASK_UNMAPPED_BASE) {
- -				start_addr = addr = TASK_UNMAPPED_BASE;
+			if (start_addr != mm->mmap_base) {
+				start_addr = addr = mm->mmap_base;
 				mm->cached_hole_size = 0;
 				goto full_search;
 			}
@@ -302,7 +302,7 @@ bottomup:
 	 * allocations.
 	 */
 	mm->cached_hole_size = ~0UL;
- -  	mm->free_area_cache = TASK_UNMAPPED_BASE;
+  	mm->free_area_cache = mm->mmap_base;
 	addr = arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
 	/*
 	 * Restore the topdown base:
diff -urNp linux-2.6.17-rc6/arch/sparc64/mm/hugetlbpage.c linux-2.6.17-rc6-fix_tub/arch/sparc64/mm/hugetlbpage.c
- --- linux-2.6.17-rc6/arch/sparc64/mm/hugetlbpage.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/sparc64/mm/hugetlbpage.c	2006-06-06 21:18:03.000000000 -0400
@@ -47,7 +47,7 @@ static unsigned long hugetlb_get_unmappe
 	if (len > mm->cached_hole_size) {
 	        start_addr = addr = mm->free_area_cache;
 	} else {
- -	        start_addr = addr = TASK_UNMAPPED_BASE;
+	        start_addr = addr = mm->mmap_base;
 	        mm->cached_hole_size = 0;
 	}

@@ -64,8 +64,8 @@ full_search:
 			vma = find_vma(mm, VA_EXCLUDE_END);
 		}
 		if (unlikely(task_size < addr)) {
- -			if (start_addr != TASK_UNMAPPED_BASE) {
- -				start_addr = addr = TASK_UNMAPPED_BASE;
+			if (start_addr != mm->mmap_base) {
+				start_addr = addr = mm->mmap_base;
 				mm->cached_hole_size = 0;
 				goto full_search;
 			}
@@ -149,7 +149,7 @@ bottomup:
 	 * allocations.
 	 */
 	mm->cached_hole_size = ~0UL;
- -  	mm->free_area_cache = TASK_UNMAPPED_BASE;
+  	mm->free_area_cache = mm->mmap_base;
 	addr = arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
 	/*
 	 * Restore the topdown base:
diff -urNp linux-2.6.17-rc6/arch/x86_64/kernel/sys_x86_64.c linux-2.6.17-rc6-fix_tub/arch/x86_64/kernel/sys_x86_64.c
- --- linux-2.6.17-rc6/arch/x86_64/kernel/sys_x86_64.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/arch/x86_64/kernel/sys_x86_64.c	2006-06-06 21:22:39.000000000 -0400
@@ -79,7 +79,7 @@ static void find_start_end(unsigned long
 		*begin = 0x40000000;
 		*end = 0x80000000;		
 	} else {
- -		*begin = TASK_UNMAPPED_BASE;
+		*begin = current->mm->mmap_base;
 		*end = TASK_SIZE;
 	}
 }
diff -urNp linux-2.6.17-rc6/fs/hugetlbfs/inode.c linux-2.6.17-rc6-fix_tub/fs/hugetlbfs/inode.c
- --- linux-2.6.17-rc6/fs/hugetlbfs/inode.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/fs/hugetlbfs/inode.c	2006-06-06 21:23:38.000000000 -0400
@@ -133,7 +133,7 @@ hugetlb_get_unmapped_area(struct file *f
 	start_addr = mm->free_area_cache;

 	if (len <= mm->cached_hole_size)
- -		start_addr = TASK_UNMAPPED_BASE;
+		start_addr = mm->mmap_base;

 full_search:
 	addr = ALIGN(start_addr, HPAGE_SIZE);
@@ -145,8 +145,8 @@ full_search:
 			 * Start a new search - just in case we missed
 			 * some holes.
 			 */
- -			if (start_addr != TASK_UNMAPPED_BASE) {
- -				start_addr = TASK_UNMAPPED_BASE;
+			if (start_addr != mm->mmap_base) {
+				start_addr = mm->mmap_base;
 				goto full_search;
 			}
 			return -ENOMEM;
diff -urNp linux-2.6.17-rc6/kernel/fork.c linux-2.6.17-rc6-fix_tub/kernel/fork.c
- --- linux-2.6.17-rc6/kernel/fork.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/kernel/fork.c	2006-06-06 20:20:27.000000000 -0400
@@ -324,7 +324,7 @@ static struct mm_struct * mm_init(struct
 	spin_lock_init(&mm->page_table_lock);
 	rwlock_init(&mm->ioctx_list_lock);
 	mm->ioctx_list = NULL;
- -	mm->free_area_cache = TASK_UNMAPPED_BASE;
+	mm->free_area_cache = mm->mmap_base;
 	mm->cached_hole_size = ~0UL;

 	if (likely(!mm_alloc_pgd(mm))) {
diff -urNp linux-2.6.17-rc6/mm/mmap.c linux-2.6.17-rc6-fix_tub/mm/mmap.c
- --- linux-2.6.17-rc6/mm/mmap.c	2006-06-06 19:37:52.000000000 -0400
+++ linux-2.6.17-rc6-fix_tub/mm/mmap.c	2006-06-06 21:25:48.000000000 -0400
@@ -1188,7 +1188,7 @@ arch_get_unmapped_area(struct file *filp
 	if (len > mm->cached_hole_size) {
 	        start_addr = addr = mm->free_area_cache;
 	} else {
- -	        start_addr = addr = TASK_UNMAPPED_BASE;
+	        start_addr = addr = mm->mmap_base;
 	        mm->cached_hole_size = 0;
 	}

@@ -1200,8 +1200,8 @@ full_search:
 			 * Start a new search - just in case we missed
 			 * some holes.
 			 */
- -			if (start_addr != TASK_UNMAPPED_BASE) {
- -				addr = TASK_UNMAPPED_BASE;
+			if (start_addr != mm->mmap_base) {
+				addr = mm->mmap_base;
 			        start_addr = addr;
 				mm->cached_hole_size = 0;
 				goto full_search;
@@ -1227,7 +1227,7 @@ void arch_unmap_area(struct mm_struct *m
 	/*
 	 * Is this a new hole at the lowest possible address?
 	 */
- -	if (addr >= TASK_UNMAPPED_BASE && addr < mm->free_area_cache) {
+	if (addr >= mm->mmap_base && addr < mm->free_area_cache) {
 		mm->free_area_cache = addr;
 		mm->cached_hole_size = ~0UL;
 	}
@@ -1309,7 +1309,7 @@ bottomup:
 	 * allocations.
 	 */
 	mm->cached_hole_size = ~0UL;
- -  	mm->free_area_cache = TASK_UNMAPPED_BASE;
+  	mm->free_area_cache = mm->mmap_base;
 	addr = arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
 	/*
 	 * Restore the topdown base:
> --- END
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRIhLqgs1xW0HCTEFAQI0pQ/+KivmGjMgmB8CAh1W6SCwG+iaJsjIv0id
z0+9928fW0iuu/4znsEqAnQS4Ye6qFdGdn0r6ZWpMoVjbwih2qLGFx3PHcQitrD5
0FY7JKA8LfGVZpeWJyvDzi1dTRwTeRZbGecrJXOI1xt6AaitkrZuFVGma210FelF
F/7dyy8lh+W2Ji0+T3UegVIw/JtGCOAdK2SXDFQfZnybRrsrHFBFABRzh+XBF0MU
7DdQjVlxyI+T5/AfcWMnMHm+boC9lXj94x+o/Mx6E37MVItWHwuwksTbNvM1T2o7
rP4Elc6o8xiFsxeung+PNPD2yOVljsZQpRNhWwCGwVwZWZSIxfj/Mqq8WdGm4yS+
PJrwahXcI2kTnIoC0/WgwKZHt6J2yGNMnzSYRKKcGsH61JFJ3XsRb3nRXy4QLytF
FRLscwMogapb/dqwA7vC6G1NZEZzJqQFuhJfnFRoOaFLbrQSfIsC4o+du1OCI21p
jTG9kl9xdAzX+Af6/4nF//jS/oe/BbHLxunoBPcMaqTS3W9/WpU23yXz5A/+5cwE
FPmEuirwzVuTXvPlb8MGCXNstPxW0YWRToJxHQS+5TONLuQ3xYSD6G2QXkbDRPG1
JZ7URGTXeoiw5Qea9TCarbbzFEL4GiwL/Pspa6QM1HRKiu5wlQ3CWM5oyTBu3ZLV
1zfe8thYUlM=
=4fLB
-----END PGP SIGNATURE-----
