Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVA0VDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVA0VDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVA0VBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:01:49 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:7359 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261176AbVA0Uqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:46:44 -0500
Date: Thu, 27 Jan 2005 12:46:20 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       spyro@f2s.com
Subject: [PATCH RFC] Change (some) TASK_SIZE to task_vtop(current)
Message-ID: <20050127204620.GA27380@taniwha.stupidest.org>
References: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com> <20050125164642.GA17927@taniwha.stupidest.org> <20050125165745.GA27433@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125165745.GA27433@krispykreme.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 03:57:45AM +1100, Anton Blanchard wrote:

> I dont particularly like it, but it would be better for that to be a
> separate cleanup patch. I want to maximise my changes of this going in
> soon :)

What about something like (just for the sake of initial feedback):


 arch/ia64/ia32/binfmt_elf32.c  |    2 +-
 arch/ia64/kernel/sys_ia64.c    |    6 +++---
 arch/ia64/kernel/unwind.c      |    4 ++--
 fs/binfmt_aout.c               |    2 +-
 fs/binfmt_elf.c                |   18 +++++++++---------
 fs/hugetlbfs/inode.c           |    6 +++---
 fs/namei.c                     |    6 +++---
 fs/namespace.c                 |    4 ++--
 include/asm-i386/processor.h   |    1 +
 include/asm-ia64/processor.h   |   10 +++-------
 include/asm-x86_64/processor.h |    1 +
 include/linux/mm.h             |    2 +-
 mm/memory.c                    |    2 +-
 mm/mmap.c                      |   24 ++++++++++++------------
 mm/mremap.c                    |    4 ++--
 mm/nommu.c                     |    2 +-
 16 files changed, 46 insertions(+), 48 deletions(-)

clearly this needs a cleanup, and breaking up but you get the idea...
(oh, changing TASK_SIZE globally isn't possible or desirable, only in
the places where it really isn't constant should it be done for now
IMO)


Index: cw-current/arch/ia64/ia32/binfmt_elf32.c
===================================================================
--- cw-current.orig/arch/ia64/ia32/binfmt_elf32.c	2005-01-27 11:49:38.385394249 -0800
+++ cw-current/arch/ia64/ia32/binfmt_elf32.c	2005-01-27 11:49:38.387394359 -0800
@@ -268,7 +268,7 @@
 	set_personality(PER_LINUX32);
 	current->thread.map_base  = IA32_PAGE_OFFSET/3;
 	current->thread.task_size = IA32_PAGE_OFFSET;	/* use what Linux/x86 uses... */
-	set_fs(USER_DS);				/* set addr limit for new TASK_SIZE */
+	set_fs(USER_DS);				/* set addr limit for process */
 }
 
 static unsigned long
Index: cw-current/arch/ia64/kernel/sys_ia64.c
===================================================================
--- cw-current.orig/arch/ia64/kernel/sys_ia64.c	2005-01-27 11:49:38.397394912 -0800
+++ cw-current/arch/ia64/kernel/sys_ia64.c	2005-01-27 11:49:38.399395022 -0800
@@ -41,7 +41,7 @@
 	if (!addr)
 		addr = mm->free_area_cache;
 
-	if (map_shared && (TASK_SIZE > 0xfffffffful))
+	if (map_shared && (task_vtop(current) > 0xfffffffful))
 		/*
 		 * For 64-bit tasks, align shared segments to 1MB to avoid potential
 		 * performance penalty due to virtual aliasing (see ASDM).  For 32-bit
@@ -55,7 +55,7 @@
 
 	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr || RGN_MAP_LIMIT - len < REGION_OFFSET(addr)) {
+		if (task_vtop(current) - len < addr || RGN_MAP_LIMIT - len < REGION_OFFSET(addr)) {
 			if (start_addr != TASK_UNMAPPED_BASE) {
 				/* Start a new search --- just in case we missed some holes.  */
 				addr = TASK_UNMAPPED_BASE;
@@ -206,7 +206,7 @@
 
 	/* Careful about overflows.. */
 	len = PAGE_ALIGN(len);
-	if (!len || len > TASK_SIZE) {
+	if (!len || len > task_vtop(current)) {
 		addr = -EINVAL;
 		goto out;
 	}
Index: cw-current/arch/ia64/kernel/unwind.c
===================================================================
--- cw-current.orig/arch/ia64/kernel/unwind.c	2005-01-27 11:49:38.410395630 -0800
+++ cw-current/arch/ia64/kernel/unwind.c	2005-01-27 11:49:38.413395796 -0800
@@ -1787,7 +1787,7 @@
 		      case UNW_INSN_LOAD:
 #ifdef UNW_DEBUG
 			if ((s[val] & (local_cpu_data->unimpl_va_mask | 0x7)) != 0
-			    || s[val] < TASK_SIZE)
+			    || s[val] < task_vtop(current))
 			{
 				UNW_DPRINT(0, "unwind.%s: rejecting bad psp=0x%lx\n",
 					   __FUNCTION__, s[val]);
@@ -1821,7 +1821,7 @@
 	struct unw_script *scr;
 	unsigned long flags = 0;
 
-	if ((info->ip & (local_cpu_data->unimpl_va_mask | 0xf)) || info->ip < TASK_SIZE) {
+	if ((info->ip & (local_cpu_data->unimpl_va_mask | 0xf)) || info->ip < task_vtop(current)) {
 		/* don't let obviously bad addresses pollute the cache */
 		/* FIXME: should really be level 0 but it occurs too often. KAO */
 		UNW_DPRINT(1, "unwind.%s: rejecting bad ip=0x%lx\n", __FUNCTION__, info->ip);
Index: cw-current/fs/binfmt_aout.c
===================================================================
--- cw-current.orig/fs/binfmt_aout.c	2005-01-27 11:49:38.423396349 -0800
+++ cw-current/fs/binfmt_aout.c	2005-01-27 11:49:38.425396459 -0800
@@ -43,7 +43,7 @@
 	.min_coredump	= PAGE_SIZE
 };
 
-#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)
+#define BAD_ADDR(x)	((unsigned long)(x) >= task_vtop(current))
 
 static int set_brk(unsigned long start, unsigned long end)
 {
Index: cw-current/fs/binfmt_elf.c
===================================================================
--- cw-current.orig/fs/binfmt_elf.c	2005-01-27 11:49:38.436397067 -0800
+++ cw-current/fs/binfmt_elf.c	2005-01-27 11:49:38.439397233 -0800
@@ -85,7 +85,7 @@
 		.min_coredump	= ELF_EXEC_PAGESIZE
 };
 
-#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
+#define BAD_ADDR(x)	((unsigned long)(x) > task_vtop(current))
 
 static int set_brk(unsigned long start, unsigned long end)
 {
@@ -389,8 +389,8 @@
 	     * <= p_memsize so it is only necessary to check p_memsz.
 	     */
 	    k = load_addr + eppnt->p_vaddr;
-	    if (k > TASK_SIZE || eppnt->p_filesz > eppnt->p_memsz ||
-		eppnt->p_memsz > TASK_SIZE || TASK_SIZE - eppnt->p_memsz < k) {
+	    if (k > task_vtop(current) || eppnt->p_filesz > eppnt->p_memsz ||
+		eppnt->p_memsz > task_vtop(current) || task_vtop(current) - eppnt->p_memsz < k) {
 	        error = -ENOMEM;
 		goto out_close;
 	    }
@@ -643,14 +643,14 @@
 			 *
 			 * However, SET_PERSONALITY is NOT allowed to switch
 			 * this task into the new images's memory mapping
-			 * policy - that is, TASK_SIZE must still evaluate to
+			 * policy - that is, task_vtop(current) must still evaluate to
 			 * that which is appropriate to the execing application.
-			 * This is because exit_mmap() needs to have TASK_SIZE
+			 * This is because exit_mmap() needs to have task_vtop(current)
 			 * evaluate to the size of the old image.
 			 *
 			 * So if (say) a 64-bit application is execing a 32-bit
 			 * application it is the architecture's responsibility
-			 * to defer changing the value of TASK_SIZE until the
+			 * to defer changing the value of task_vtop(current) until the
 			 * switch really is going to happen - do this in
 			 * flush_thread().	- akpm
 			 */
@@ -852,9 +852,9 @@
 		 * allowed task size. Note that p_filesz must always be
 		 * <= p_memsz so it is only necessary to check p_memsz.
 		 */
-		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
-		    elf_ppnt->p_memsz > TASK_SIZE ||
-		    TASK_SIZE - elf_ppnt->p_memsz < k) {
+		if (k > task_vtop(current) || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
+		    elf_ppnt->p_memsz > task_vtop(current) ||
+		    task_vtop(current) - elf_ppnt->p_memsz < k) {
 			/* set_brk can never work.  Avoid overflows.  */
 			send_sig(SIGKILL, current, 0);
 			goto out_free_dentry;
Index: cw-current/fs/hugetlbfs/inode.c
===================================================================
--- cw-current.orig/fs/hugetlbfs/inode.c	2005-01-27 11:49:38.475399223 -0800
+++ cw-current/fs/hugetlbfs/inode.c	2005-01-27 11:49:38.477399333 -0800
@@ -109,13 +109,13 @@
 
 	if (len & ~HPAGE_MASK)
 		return -EINVAL;
-	if (len > TASK_SIZE)
+	if (len > task_vtop(current))
 		return -ENOMEM;
 
 	if (addr) {
 		addr = ALIGN(addr, HPAGE_SIZE);
 		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
+		if (task_vtop(current) - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
@@ -127,7 +127,7 @@
 
 	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr) {
+		if (task_vtop(current) - len < addr) {
 			/*
 			 * Start a new search - just in case we missed
 			 * some holes.
Index: cw-current/fs/namei.c
===================================================================
--- cw-current.orig/fs/namei.c	2005-01-27 11:49:38.452397951 -0800
+++ cw-current/fs/namei.c	2005-01-27 11:49:38.454398062 -0800
@@ -117,10 +117,10 @@
 	unsigned long len = PATH_MAX;
 
 	if (!segment_eq(get_fs(), KERNEL_DS)) {
-		if ((unsigned long) filename >= TASK_SIZE)
+		if ((unsigned long) filename >= task_vtop(current))
 			return -EFAULT;
-		if (TASK_SIZE - (unsigned long) filename < PATH_MAX)
-			len = TASK_SIZE - (unsigned long) filename;
+		if (task_vtop(current) - (unsigned long) filename < PATH_MAX)
+			len = task_vtop(current) - (unsigned long) filename;
 	}
 
 	retval = strncpy_from_user(page, filename, len);
Index: cw-current/fs/namespace.c
===================================================================
--- cw-current.orig/fs/namespace.c	2005-01-27 11:49:38.465398670 -0800
+++ cw-current/fs/namespace.c	2005-01-27 11:49:38.467398780 -0800
@@ -975,8 +975,8 @@
 	 * gave us is valid.  Just in case, we'll zero
 	 * the remainder of the page.
 	 */
-	/* copy_from_user cannot cross TASK_SIZE ! */
-	size = TASK_SIZE - (unsigned long)data;
+	/* copy_from_user cannot cross task_vtop(current) ! */
+	size = task_vtop(current) - (unsigned long)data;
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
Index: cw-current/include/asm-i386/processor.h
===================================================================
--- cw-current.orig/include/asm-i386/processor.h	2005-01-27 11:49:38.486399830 -0800
+++ cw-current/include/asm-i386/processor.h	2005-01-27 11:49:38.489399996 -0800
@@ -300,6 +300,7 @@
  * User space process size: 3GB (default).
  */
 #define TASK_SIZE	(PAGE_OFFSET)
+#define task_vtop(t)	(TASK_SIZE)
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
Index: cw-current/include/asm-ia64/processor.h
===================================================================
--- cw-current.orig/include/asm-ia64/processor.h	2005-01-27 11:49:38.516401488 -0800
+++ cw-current/include/asm-ia64/processor.h	2005-01-27 11:49:38.518401599 -0800
@@ -34,13 +34,9 @@
 #define DEFAULT_MAP_BASE	__IA64_UL_CONST(0x2000000000000000)
 #define DEFAULT_TASK_SIZE	__IA64_UL_CONST(0xa000000000000000)
 
-/*
- * TASK_SIZE really is a mis-named.  It really is the maximum user
- * space address (plus one).  On IA-64, there are five regions of 2TB
- * each (assuming 8KB page size), for a total of 8TB of user virtual
- * address space.
- */
-#define TASK_SIZE		(current->thread.task_size)
+/* Top user vaddr */
+#define task_vtop(t)		(t->thread.task_size)
+#define TASK_SIZE		(task_vtop(current))
 
 /*
  * MM_VM_SIZE(mm) gives the maximum address (plus 1) which may contain a mapping for
Index: cw-current/include/asm-x86_64/processor.h
===================================================================
--- cw-current.orig/include/asm-x86_64/processor.h	2005-01-27 11:49:38.527402096 -0800
+++ cw-current/include/asm-x86_64/processor.h	2005-01-27 11:49:38.529402207 -0800
@@ -163,6 +163,7 @@
  * User space process size. 47bits.
  */
 #define TASK_SIZE	(0x800000000000)
+#define task_vtop(t)	(TASK_SIZE)
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
Index: cw-current/include/linux/mm.h
===================================================================
--- cw-current.orig/include/linux/mm.h	2005-01-27 11:49:38.542402925 -0800
+++ cw-current/include/linux/mm.h	2005-01-27 11:49:38.545403091 -0800
@@ -38,7 +38,7 @@
 #include <asm/atomic.h>
 
 #ifndef MM_VM_SIZE
-#define MM_VM_SIZE(mm)	TASK_SIZE
+#define MM_VM_SIZE(mm)	task_vtop(current)
 #endif
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
Index: cw-current/mm/memory.c
===================================================================
--- cw-current.orig/mm/memory.c	2005-01-27 11:49:38.559403865 -0800
+++ cw-current/mm/memory.c	2005-01-27 11:49:38.561403975 -0800
@@ -894,7 +894,7 @@
 			pte_t *pte;
 			if (write) /* user gate pages are read-only */
 				return i ? : -EFAULT;
-			if (pg > TASK_SIZE)
+			if (pg > task_vtop(current))
 				pgd = pgd_offset_k(pg);
 			else
 				pgd = pgd_offset_gate(mm, pg);
Index: cw-current/mm/mmap.c
===================================================================
--- cw-current.orig/mm/mmap.c	2005-01-27 11:49:38.574404694 -0800
+++ cw-current/mm/mmap.c	2005-01-27 11:49:38.577404860 -0800
@@ -901,7 +901,7 @@
 
 	/* Careful about overflows.. */
 	len = PAGE_ALIGN(len);
-	if (!len || len > TASK_SIZE)
+	if (!len || len > task_vtop(current))
 		return -EINVAL;
 
 	/* offset overflow? */
@@ -1163,13 +1163,13 @@
 	struct vm_area_struct *vma;
 	unsigned long start_addr;
 
-	if (len > TASK_SIZE)
+	if (len > task_vtop(current))
 		return -ENOMEM;
 
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
+		if (task_vtop(current) - len >= addr &&
 		    (!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
@@ -1178,7 +1178,7 @@
 full_search:
 	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr) {
+		if (task_vtop(current) - len < addr) {
 			/*
 			 * Start a new search - just in case we missed
 			 * some holes.
@@ -1227,7 +1227,7 @@
 	int first_time = 1;
 
 	/* requested length too big for entire address space */
-	if (len > TASK_SIZE)
+	if (len > task_vtop(current))
 		return -ENOMEM;
 
 	/* dont allow allocations above current base */
@@ -1238,7 +1238,7 @@
 	if (addr) {
 		addr = PAGE_ALIGN(addr);
 		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
+		if (task_vtop(current) - len >= addr &&
 				(!vma || addr + len <= vma->vm_start))
 			return addr;
 	}
@@ -1318,7 +1318,7 @@
 	if (flags & MAP_FIXED) {
 		unsigned long ret;
 
-		if (addr > TASK_SIZE - len)
+		if (addr > task_vtop(current) - len)
 			return -ENOMEM;
 		if (addr & ~PAGE_MASK)
 			return -EINVAL;
@@ -1612,8 +1612,8 @@
 	unsigned long last = end + PGDIR_SIZE - 1;
 	struct mm_struct *mm = tlb->mm;
 
-	if (last > TASK_SIZE || last < end)
-		last = TASK_SIZE;
+	if (last > task_vtop(current) || last < end)
+		last = task_vtop(current);
 
 	if (!prev) {
 		prev = mm->mmap;
@@ -1796,7 +1796,7 @@
 	unsigned long end;
 	struct vm_area_struct *mpnt, *prev, *last;
 
-	if ((start & ~PAGE_MASK) || start > TASK_SIZE || len > TASK_SIZE-start)
+	if ((start & ~PAGE_MASK) || start > task_vtop(current) || len > task_vtop(current)-start)
 		return -EINVAL;
 
 	if ((len = PAGE_ALIGN(len)) == 0)
@@ -1897,7 +1897,7 @@
 	if (!len)
 		return addr;
 
-	if ((addr + len) > TASK_SIZE || (addr + len) < addr)
+	if ((addr + len) > task_vtop(current) || (addr + len) < addr)
 		return -EINVAL;
 
 	/*
@@ -1996,7 +1996,7 @@
 	vm_unacct_memory(nr_accounted);
 	BUG_ON(mm->map_count);	/* This is just debugging */
 	clear_page_range(tlb, FIRST_USER_PGD_NR * PGDIR_SIZE,
-			(TASK_SIZE + PGDIR_SIZE - 1) & PGDIR_MASK);
+			(task_vtop(current) + PGDIR_SIZE - 1) & PGDIR_MASK);
 	
 	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
 
Index: cw-current/mm/mremap.c
===================================================================
--- cw-current.orig/mm/mremap.c	2005-01-27 11:49:38.586405357 -0800
+++ cw-current/mm/mremap.c	2005-01-27 11:49:38.587405412 -0800
@@ -300,7 +300,7 @@
 		if (!(flags & MREMAP_MAYMOVE))
 			goto out;
 
-		if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
+		if (new_len > task_vtop(current) || new_addr > task_vtop(current) - new_len)
 			goto out;
 
 		/* Check if the location we're moving into overlaps the
@@ -376,7 +376,7 @@
 	if (old_len == vma->vm_end - addr &&
 	    !((flags & MREMAP_FIXED) && (addr != new_addr)) &&
 	    (old_len != new_len || !(flags & MREMAP_MAYMOVE))) {
-		unsigned long max_addr = TASK_SIZE;
+		unsigned long max_addr = task_vtop(current);
 		if (vma->vm_next)
 			max_addr = vma->vm_next->vm_start;
 		/* can we just expand the current mapping? */
Index: cw-current/mm/nommu.c
===================================================================
--- cw-current.orig/mm/nommu.c	2005-01-27 11:49:38.596405910 -0800
+++ cw-current/mm/nommu.c	2005-01-27 11:49:38.598406020 -0800
@@ -405,7 +405,7 @@
 	if (PAGE_ALIGN(len) == 0)
 		return addr;
 
-	if (len > TASK_SIZE)
+	if (len > task_vtop(current))
 		return -EINVAL;
 
 	/* offset overflow? */
