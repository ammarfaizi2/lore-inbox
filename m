Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVL3HoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVL3HoM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 02:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVL3HoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 02:44:12 -0500
Received: from thorn.pobox.com ([208.210.124.75]:30642 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751204AbVL3HoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 02:44:10 -0500
Date: Thu, 29 Dec 2005 23:44:01 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Cc: alan@redhat.com
Subject: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Message-ID: <20051230074401.GA7501@ip68-225-251-162.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds strict VM overcommit accounting to the mainline 2.4
kernel, thus allowing overcommit to be truly disabled. This feature
has been in 2.4-ac, Red Hat Enterprise Linux 3 (RHEL 3) vendor kernels,
and 2.6 for a long while.

Most of the code was merged from 2.4.27-pre2-pac1, as well as a hunk
from 2.4.22-ac4 for fs/exec.c that was missing from the -pac kernels.
(Without that, the patch was seriously broken.) I also added a 
fork-related accounting fix from the RHEL 3 kernel -- it turns out that
the exact same fix is also present in 2.6. Finally, I backported changes
to move_vma() from 2.6, so that do_munmap() does not need a 4th argument;
this avoids disrupting arch and driver code.

This patch is against 2.4.33-pre1, although it applies to 2.4.32 as well,
and that is where I did most of my testing. I'm hoping that it's not too
late to add this to mainline 2.4, although I realize that it might be.


Known problems/quirks of this patch:

+ The documentation (from -pac) mentions an overcommit mode 3, which does
  not appear to actually exist (as far as I can tell). This can be fixed
  in a future patch, and I'll probably do that soon.

+ Like -ac/-pac, but unlike RHEL 3 or mainline 2.6, this patch does not
  add Committed_AS to /proc/meminfo. IMO it's an insanely useful bit of
  information to have, so I'll have another patch very soon to add this.

Signed-off-by: Barry K. Nathan <barryn@pobox.com>


diff -ruN linux-2.4.33-pre1/Documentation/vm/overcommit-accounting linux-2.4.33-pre1-memA/Documentation/vm/overcommit-accounting
--- linux-2.4.33-pre1/Documentation/vm/overcommit-accounting	Wed Dec 31 16:00:00 1969
+++ linux-2.4.33-pre1-memA/Documentation/vm/overcommit-accounting	Thu Dec 29 20:39:30 2005
@@ -0,0 +1,70 @@
+* This describes the overcommit management facility in the latest kernel
+  tree (FIXME: actually it also describes the stuff that isnt yet done)
+
+The Linux kernel supports four overcommit handling modes
+
+0	-	Heuristic overcommit handling. Obvious overcommits of
+		address space are refused. Used for a typical system. It
+		ensures a seriously wild allocation fails while allowing
+		overcommit to reduce swap usage
+
+1	-	No overcommit handling. Appropriate for some scientific
+		applications
+
+2	-	(NEW) strict overcommit. The total address space commit
+		for the system is not permitted to exceed swap + half ram.
+		In almost all situations this means a process will not be
+		killed while accessing pages but only by malloc failures
+		that are reported back by the kernel mmap/brk code.
+
+3	-	(NEW) paranoid overcommit The total address space commit
+		for the system is not permitted to exceed swap. The machine
+		will never kill a process accessing pages it has mapped
+		except due to a bug (ie report it!)
+
+Gotchas
+-------
+
+The C language stack growth does an implicit mremap. If you want absolute
+guarantees and run close to the edge you MUST mmap your stack for the 
+largest size you think you will need. For typical stack usage is does
+not matter much but its a corner case if you really really care
+
+In modes 2 and 3 the MAP_NORESERVE flag is ignored. 
+
+
+How It Works
+------------
+
+The overcommit is based on the following rules
+
+For a file backed map
+	SHARED or READ-only	-	0 cost (the file is the map not swap)
+	PRIVATE WRITABLE	-	size of mapping per instance
+
+For an anonymous or /dev/zero map
+	SHARED			-	size of mapping
+	PRIVATE READ-only	-	0 cost (but of little use)
+	PRIVATE WRITABLE	-	size of mapping per instance
+
+Additional accounting
+	Pages made writable copies by mmap
+	shmfs memory drawn from the same pool
+
+Status
+------
+
+o	We account mmap memory mappings
+o	We account mprotect changes in commit
+o	We account mremap changes in size
+o	We account brk
+o	We account munmap
+o	We report the commit status in /proc
+o	Account and check on fork
+o	Review stack handling/building on exec
+o	SHMfs accounting
+o	Implement actual limit enforcement
+
+To Do
+-----
+o	Account ptrace pages (this is hard)
diff -ruN linux-2.4.33-pre1/arch/alpha/mm/fault.c linux-2.4.33-pre1-memA/arch/alpha/mm/fault.c
--- linux-2.4.33-pre1/arch/alpha/mm/fault.c	Thu Nov 28 15:53:08 2002
+++ linux-2.4.33-pre1-memA/arch/alpha/mm/fault.c	Thu Dec 29 20:39:30 2005
@@ -122,8 +122,6 @@
 		goto bad_area;
 	if (vma->vm_start <= address)
 		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
 	if (expand_stack(vma, address))
 		goto bad_area;
 /*
diff -ruN linux-2.4.33-pre1/arch/arm/mm/fault-common.c linux-2.4.33-pre1-memA/arch/arm/mm/fault-common.c
--- linux-2.4.33-pre1/arch/arm/mm/fault-common.c	Mon Aug 25 04:44:39 2003
+++ linux-2.4.33-pre1-memA/arch/arm/mm/fault-common.c	Thu Dec 29 20:39:30 2005
@@ -254,7 +254,7 @@
 	goto survive;
 
 check_stack:
-	if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr))
+	if (!expand_stack(vma, addr))
 		goto good_area;
 out:
 	return fault;
diff -ruN linux-2.4.33-pre1/arch/i386/mm/fault.c linux-2.4.33-pre1-memA/arch/i386/mm/fault.c
--- linux-2.4.33-pre1/arch/i386/mm/fault.c	Sat Aug  7 16:26:04 2004
+++ linux-2.4.33-pre1-memA/arch/i386/mm/fault.c	Thu Dec 29 20:39:30 2005
@@ -76,9 +76,7 @@
 	return 1;
 
 check_stack:
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, start) == 0)
+	if (!expand_stack(vma, start))
 		goto good_area;
 
 bad_area:
diff -ruN linux-2.4.33-pre1/arch/ia64/mm/fault.c linux-2.4.33-pre1-memA/arch/ia64/mm/fault.c
--- linux-2.4.33-pre1/arch/ia64/mm/fault.c	Wed Dec 28 05:06:03 2005
+++ linux-2.4.33-pre1-memA/arch/ia64/mm/fault.c	Thu Dec 29 20:39:30 2005
@@ -154,8 +154,6 @@
 
   check_expansion:
 	if (!(prev_vma && (prev_vma->vm_flags & VM_GROWSUP) && (address == prev_vma->vm_end))) {
-		if (!(vma->vm_flags & VM_GROWSDOWN))
-			goto bad_area;
 		if (rgn_index(address) != rgn_index(vma->vm_start)
 		    || rgn_offset(address) >= RGN_MAP_LIMIT)
 			goto bad_area;
diff -ruN linux-2.4.33-pre1/arch/mips/mm/fault.c linux-2.4.33-pre1-memA/arch/mips/mm/fault.c
--- linux-2.4.33-pre1/arch/mips/mm/fault.c	Mon Aug 25 04:44:40 2003
+++ linux-2.4.33-pre1-memA/arch/mips/mm/fault.c	Thu Dec 29 20:39:30 2005
@@ -112,8 +112,6 @@
 		goto bad_area;
 	if (vma->vm_start <= address)
 		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
 	if (expand_stack(vma, address))
 		goto bad_area;
 /*
diff -ruN linux-2.4.33-pre1/arch/mips64/mm/fault.c linux-2.4.33-pre1-memA/arch/mips64/mm/fault.c
--- linux-2.4.33-pre1/arch/mips64/mm/fault.c	Wed Feb 18 05:36:30 2004
+++ linux-2.4.33-pre1-memA/arch/mips64/mm/fault.c	Thu Dec 29 20:39:30 2005
@@ -135,8 +135,6 @@
 		goto bad_area;
 	if (vma->vm_start <= address)
 		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
 	if (expand_stack(vma, address))
 		goto bad_area;
 /*
diff -ruN linux-2.4.33-pre1/arch/ppc/mm/fault.c linux-2.4.33-pre1-memA/arch/ppc/mm/fault.c
--- linux-2.4.33-pre1/arch/ppc/mm/fault.c	Fri Nov 28 10:26:19 2003
+++ linux-2.4.33-pre1-memA/arch/ppc/mm/fault.c	Thu Dec 29 20:39:30 2005
@@ -141,42 +141,40 @@
 		goto bad_area;
 	if (vma->vm_start <= address)
 		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (!is_write)
-                goto bad_area;
-
-	/*
-	 * N.B. The rs6000/xcoff ABI allows programs to access up to
-	 * a few hundred bytes below the stack pointer.
-	 * The kernel signal delivery code writes up to about 1.5kB
-	 * below the stack pointer (r1) before decrementing it.
-	 * The exec code can write slightly over 640kB to the stack
-	 * before setting the user r1.  Thus we allow the stack to
-	 * expand to 1MB without further checks.
-	 */
-	if (address + 0x100000 < vma->vm_end) {
-		/* get user regs even if this fault is in kernel mode */
-		struct pt_regs *uregs = current->thread.regs;
-		if (uregs == NULL)
-			goto bad_area;
-
-		/*
-		 * A user-mode access to an address a long way below
-		 * the stack pointer is only valid if the instruction
-		 * is one which would update the stack pointer to the
-		 * address accessed if the instruction completed,
-		 * i.e. either stwu rs,n(r1) or stwux rs,r1,rb
-		 * (or the byte, halfword, float or double forms).
-		 *
-		 * If we don't check this then any write to the area
-		 * between the last mapped region and the stack will
-		 * expand the stack rather than segfaulting.
-		 */
-		if (address + 2048 < uregs->gpr[1]
-		    && (!user_mode(regs) || !store_updates_sp(regs)))
-			goto bad_area;
-	}
+ 	if (!is_write)
+                 goto bad_area;
+ 
+ 	/*
+ 	 * N.B. The rs6000/xcoff ABI allows programs to access up to
+ 	 * a few hundred bytes below the stack pointer.
+ 	 * The kernel signal delivery code writes up to about 1.5kB
+ 	 * below the stack pointer (r1) before decrementing it.
+ 	 * The exec code can write slightly over 640kB to the stack
+ 	 * before setting the user r1.  Thus we allow the stack to
+ 	 * expand to 1MB without further checks.
+ 	 */
+ 	if (address + 0x100000 < vma->vm_end) {
+ 		/* get user regs even if this fault is in kernel mode */
+ 		struct pt_regs *uregs = current->thread.regs;
+ 		if (uregs == NULL)
+ 			goto bad_area;
+ 
+ 		/*
+ 		 * A user-mode access to an address a long way below
+ 		 * the stack pointer is only valid if the instruction
+ 		 * is one which would update the stack pointer to the
+ 		 * address accessed if the instruction completed,
+ 		 * i.e. either stwu rs,n(r1) or stwux rs,r1,rb
+ 		 * (or the byte, halfword, float or double forms).
+ 		 *
+ 		 * If we don't check this then any write to the area
+ 		 * between the last mapped region and the stack will
+ 		 * expand the stack rather than segfaulting.
+ 		 */
+ 		if (address + 2048 < uregs->gpr[1]
+ 		    && (!user_mode(regs) || !store_updates_sp(regs)))
+ 			goto bad_area;
+ 	}
 	if (expand_stack(vma, address))
 		goto bad_area;
 
diff -ruN linux-2.4.33-pre1/arch/sh/mm/fault.c linux-2.4.33-pre1-memA/arch/sh/mm/fault.c
--- linux-2.4.33-pre1/arch/sh/mm/fault.c	Mon Aug 25 04:44:40 2003
+++ linux-2.4.33-pre1-memA/arch/sh/mm/fault.c	Thu Dec 29 20:39:30 2005
@@ -76,8 +76,6 @@
 	return 1;
 
 check_stack:
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
 	if (expand_stack(vma, start) == 0)
 		goto good_area;
 
diff -ruN linux-2.4.33-pre1/arch/sparc/mm/fault.c linux-2.4.33-pre1-memA/arch/sparc/mm/fault.c
--- linux-2.4.33-pre1/arch/sparc/mm/fault.c	Sat Aug  7 16:26:04 2004
+++ linux-2.4.33-pre1-memA/arch/sparc/mm/fault.c	Thu Dec 29 20:39:30 2005
@@ -268,8 +268,6 @@
 		goto bad_area;
 	if(vma->vm_start <= address)
 		goto good_area;
-	if(!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
 	if(expand_stack(vma, address))
 		goto bad_area;
 	/*
@@ -515,8 +513,6 @@
 		goto bad_area;
 	if(vma->vm_start <= address)
 		goto good_area;
-	if(!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
 	if(expand_stack(vma, address))
 		goto bad_area;
 good_area:
diff -ruN linux-2.4.33-pre1/arch/sparc64/mm/fault.c linux-2.4.33-pre1-memA/arch/sparc64/mm/fault.c
--- linux-2.4.33-pre1/arch/sparc64/mm/fault.c	Wed Dec 28 05:05:54 2005
+++ linux-2.4.33-pre1-memA/arch/sparc64/mm/fault.c	Thu Dec 29 20:39:30 2005
@@ -380,8 +380,6 @@
 
 	if (vma->vm_start <= address)
 		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
 	if (!(fault_code & FAULT_CODE_WRITE)) {
 		/* Non-faulting loads shouldn't expand stack. */
 		insn = get_fault_insn(regs, insn);
diff -ruN linux-2.4.33-pre1/fs/exec.c linux-2.4.33-pre1-memA/fs/exec.c
--- linux-2.4.33-pre1/fs/exec.c	Wed Dec 28 05:06:01 2005
+++ linux-2.4.33-pre1-memA/fs/exec.c	Thu Dec 29 20:39:30 2005
@@ -340,6 +340,12 @@
 	if (!mpnt) 
 		return -ENOMEM; 
 	
+	if (!vm_enough_memory((STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT))
+	{
+		kmem_cache_free(vm_area_cachep, mpnt);
+		return -ENOMEM;
+	}
+
 	down_write(&current->mm->mmap_sem);
 	{
 		mpnt->vm_mm = current->mm;
diff -ruN linux-2.4.33-pre1/fs/proc/proc_misc.c linux-2.4.33-pre1-memA/fs/proc/proc_misc.c
--- linux-2.4.33-pre1/fs/proc/proc_misc.c	Sat Aug  7 16:26:06 2004
+++ linux-2.4.33-pre1-memA/fs/proc/proc_misc.c	Thu Dec 29 20:39:30 2005
@@ -158,7 +158,11 @@
 	struct sysinfo i;
 	int len;
 	int pg_size ;
+	int committed;
 
+	/* FIXME: needs to be in headers */
+	extern atomic_t vm_committed_space;
+	
 /*
  * display in kilobytes.
  */
@@ -167,6 +171,7 @@
 	si_meminfo(&i);
 	si_swapinfo(&i);
 	pg_size = page_cache_size - i.bufferram;
+	committed = atomic_read(&vm_committed_space);
 
 	len = sprintf(page, "        total:    used:    free:  shared: buffers:  cached:\n"
 		"Mem:  %8Lu %8Lu %8Lu %8Lu %8Lu %8Lu\n"
diff -ruN linux-2.4.33-pre1/include/asm-x86_64/page.h linux-2.4.33-pre1-memA/include/asm-x86_64/page.h
--- linux-2.4.33-pre1/include/asm-x86_64/page.h	Mon Aug 25 04:44:44 2003
+++ linux-2.4.33-pre1-memA/include/asm-x86_64/page.h	Thu Dec 29 20:39:30 2005
@@ -148,7 +148,6 @@
 #define VM_DATA_DEFAULT_FLAGS \
 	((current->thread.flags & THREAD_IA32) ? vm_data_default_flags32 : \
 	  vm_data_default_flags) 
-#define VM_STACK_FLAGS	vm_stack_flags
 
 #endif /* __KERNEL__ */
 
diff -ruN linux-2.4.33-pre1/include/linux/mm.h linux-2.4.33-pre1-memA/include/linux/mm.h
--- linux-2.4.33-pre1/include/linux/mm.h	Wed Dec 28 05:06:01 2005
+++ linux-2.4.33-pre1-memA/include/linux/mm.h	Thu Dec 29 20:39:30 2005
@@ -104,8 +104,12 @@
 #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
 #define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
 
-#ifndef VM_STACK_FLAGS
-#define VM_STACK_FLAGS	0x00000177
+#define VM_ACCOUNT	0x00100000	/* Memory is a vm accounted object */
+
+#ifdef ARCH_STACK_GROWSUP
+#define VM_STACK_FLAGS	(VM_DATA_DEFAULT_FLAGS|VM_GROWSUP|VM_ACCOUNT)
+#else
+#define VM_STACK_FLAGS	(VM_DATA_DEFAULT_FLAGS|VM_GROWSDOWN|VM_ACCOUNT)
 #endif
 
 #define VM_READHINTMASK			(VM_SEQ_READ | VM_RAND_READ)
@@ -639,49 +643,9 @@
 
 	return gfp_mask;
 }
-	
-/* vma is the first one with  address < vma->vm_end,
- * and even  address < vma->vm_start. Have to extend vma. */
-static inline int expand_stack(struct vm_area_struct * vma, unsigned long address)
-{
-	unsigned long grow;
 
-	/*
-	 * vma->vm_start/vm_end cannot change under us because the caller
-	 * is required to hold the mmap_sem in read mode.  We need the
-	 * page_table_lock lock to serialize against concurrent expand_stacks.
-	 */
-	address &= PAGE_MASK;
- 	spin_lock(&vma->vm_mm->page_table_lock);
-
-	/* already expanded while we were spinning? */
-	if (vma->vm_start <= address) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
-		return 0;
-	}
-
-	grow = (vma->vm_start - address) >> PAGE_SHIFT;
-	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
-	    ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_AS].rlim_cur) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
-		return -ENOMEM;
-	}
-
-	if ((vma->vm_flags & VM_LOCKED) &&
-      	    ((vma->vm_mm->locked_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_MEMLOCK].rlim_cur) {
-		spin_unlock(&vma->vm_mm->page_table_lock);
-		return -ENOMEM;
-	}
-
-
-	vma->vm_start = address;
-	vma->vm_pgoff -= grow;
-	vma->vm_mm->total_vm += grow;
-	if (vma->vm_flags & VM_LOCKED)
-		vma->vm_mm->locked_vm += grow;
-	spin_unlock(&vma->vm_mm->page_table_lock);
-	return 0;
-}
+/* Do stack extension */
+extern int expand_stack(struct vm_area_struct * vma, unsigned long address);
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
 extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
diff -ruN linux-2.4.33-pre1/include/linux/mman.h linux-2.4.33-pre1-memA/include/linux/mman.h
--- linux-2.4.33-pre1/include/linux/mman.h	Tue Mar 14 18:21:56 2000
+++ linux-2.4.33-pre1-memA/include/linux/mman.h	Thu Dec 29 20:39:30 2005
@@ -6,4 +6,8 @@
 #define MREMAP_MAYMOVE	1
 #define MREMAP_FIXED	2
 
+extern int vm_enough_memory(long pages);
+extern void vm_unacct_memory(long pages);
+extern void vm_validate_enough(char *x);
+
 #endif /* _LINUX_MMAN_H */
diff -ruN linux-2.4.33-pre1/include/linux/sysctl.h linux-2.4.33-pre1-memA/include/linux/sysctl.h
--- linux-2.4.33-pre1/include/linux/sysctl.h	Thu Dec 29 20:35:57 2005
+++ linux-2.4.33-pre1-memA/include/linux/sysctl.h	Thu Dec 29 20:39:30 2005
@@ -159,6 +159,7 @@
 	VM_LAPTOP_MODE=21,	/* kernel in laptop flush mode */
 	VM_BLOCK_DUMP=22,	/* dump fs activity to log */
 	VM_ANON_LRU=23,		/* immediatly insert anon pages in the vm page lru */
+	VM_OVERCOMMIT_RATIO=24,	/* percent of RAM to allow overcommit in */
 };
 
 
diff -ruN linux-2.4.33-pre1/kernel/fork.c linux-2.4.33-pre1-memA/kernel/fork.c
--- linux-2.4.33-pre1/kernel/fork.c	Wed Dec 28 05:06:01 2005
+++ linux-2.4.33-pre1-memA/kernel/fork.c	Thu Dec 29 20:39:30 2005
@@ -22,6 +22,7 @@
 #include <linux/namespace.h>
 #include <linux/personality.h>
 #include <linux/compiler.h>
+#include <linux/mman.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -146,6 +147,7 @@
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
 	int retval;
+	unsigned long charge;
 
 	flush_cache_mm(current->mm);
 	mm->locked_vm = 0;
@@ -174,6 +176,13 @@
 		retval = -ENOMEM;
 		if(mpnt->vm_flags & VM_DONTCOPY)
 			continue;
+		charge = 0;
+		if(mpnt->vm_flags & VM_ACCOUNT) {
+			unsigned int len = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
+			if(!vm_enough_memory(len))
+				goto fail_nomem;
+			charge = len;
+		}
 		tmp = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 		if (!tmp)
 			goto fail_nomem;
@@ -217,10 +226,12 @@
 	}
 	retval = 0;
 	build_mmap_rb(mm);
-
-fail_nomem:
+out:
 	flush_tlb_mm(current->mm);
 	return retval;
+fail_nomem:
+	vm_unacct_memory(charge);
+	goto out;
 }
 
 spinlock_t mmlist_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;
diff -ruN linux-2.4.33-pre1/kernel/sysctl.c linux-2.4.33-pre1-memA/kernel/sysctl.c
--- linux-2.4.33-pre1/kernel/sysctl.c	Thu Dec 29 20:35:57 2005
+++ linux-2.4.33-pre1-memA/kernel/sysctl.c	Thu Dec 29 20:39:30 2005
@@ -45,6 +45,7 @@
 extern int C_A_D;
 extern int bdf_prm[], bdflush_min[], bdflush_max[];
 extern int sysctl_overcommit_memory;
+extern int sysctl_overcommit_ratio;
 extern int max_threads;
 extern atomic_t nr_queued_signals;
 extern int max_queued_signals;
@@ -301,6 +302,8 @@
 	 &bdflush_min, &bdflush_max},
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
+	{VM_OVERCOMMIT_RATIO, "overcommit_ratio", &sysctl_overcommit_ratio,
+	 sizeof(sysctl_overcommit_ratio), 0644, NULL, &proc_dointvec},
 	{VM_PAGERDAEMON, "kswapd",
 	 &pager_daemon, sizeof(pager_daemon_t), 0644, NULL, &proc_dointvec},
 	{VM_PGT_CACHE, "pagetable_cache", 
diff -ruN linux-2.4.33-pre1/mm/mlock.c linux-2.4.33-pre1-memA/mm/mlock.c
--- linux-2.4.33-pre1/mm/mlock.c	Mon Sep 17 15:30:23 2001
+++ linux-2.4.33-pre1-memA/mm/mlock.c	Thu Dec 29 20:39:30 2005
@@ -198,6 +198,7 @@
 	unsigned long lock_limit;
 	int error = -ENOMEM;
 
+	vm_validate_enough("entering sys_mlock");
 	down_write(&current->mm->mmap_sem);
 	len = PAGE_ALIGN(len + (start & ~PAGE_MASK));
 	start &= PAGE_MASK;
@@ -220,6 +221,7 @@
 	error = do_mlock(start, len, 1);
 out:
 	up_write(&current->mm->mmap_sem);
+	vm_validate_enough("exiting sys_mlock");
 	return error;
 }
 
@@ -227,11 +229,13 @@
 {
 	int ret;
 
+	vm_validate_enough("entering sys_munlock");
 	down_write(&current->mm->mmap_sem);
 	len = PAGE_ALIGN(len + (start & ~PAGE_MASK));
 	start &= PAGE_MASK;
 	ret = do_mlock(start, len, 0);
 	up_write(&current->mm->mmap_sem);
+	vm_validate_enough("exiting sys_munlock");
 	return ret;
 }
 
@@ -268,6 +272,8 @@
 	unsigned long lock_limit;
 	int ret = -EINVAL;
 
+	vm_validate_enough("entering sys_mlockall");
+
 	down_write(&current->mm->mmap_sem);
 	if (!flags || (flags & ~(MCL_CURRENT | MCL_FUTURE)))
 		goto out;
@@ -287,15 +293,18 @@
 	ret = do_mlockall(flags);
 out:
 	up_write(&current->mm->mmap_sem);
+	vm_validate_enough("exiting sys_mlockall");
 	return ret;
 }
 
 asmlinkage long sys_munlockall(void)
 {
 	int ret;
+	vm_validate_enough("entering sys_munlockall");
 
 	down_write(&current->mm->mmap_sem);
 	ret = do_mlockall(0);
 	up_write(&current->mm->mmap_sem);
+	vm_validate_enough("exiting sys_munlockall");
 	return ret;
 }
diff -ruN linux-2.4.33-pre1/mm/mmap.c linux-2.4.33-pre1-memA/mm/mmap.c
--- linux-2.4.33-pre1/mm/mmap.c	Wed Dec 28 05:06:01 2005
+++ linux-2.4.33-pre1-memA/mm/mmap.c	Thu Dec 29 20:39:30 2005
@@ -1,8 +1,25 @@
 /*
  *	linux/mm/mmap.c
- *
  * Written by obz.
+ *
+ *  Address space accounting code	<alan@redhat.com>
+ *  (c) Copyright 2002 Red Hat Inc, All Rights Reserved
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+ 
 #include <linux/slab.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
@@ -45,8 +62,10 @@
 	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
 };
 
-int sysctl_overcommit_memory;
+int sysctl_overcommit_memory = 0;	/* default is heuristic overcommit */
+int sysctl_overcommit_ratio = 50;	/* default is 50% */
 int max_map_count = DEFAULT_MAX_MAP_COUNT;
+atomic_t vm_committed_space = ATOMIC_INIT(0);
 
 /* Check that a process has enough memory to allocate a
  * new virtual mapping.
@@ -56,42 +75,107 @@
 	/* Stupid algorithm to decide if we have enough memory: while
 	 * simple, it hopefully works in most obvious cases.. Easy to
 	 * fool it, but this should catch most mistakes.
-	 */
-	/* 23/11/98 NJC: Somewhat less stupid version of algorithm,
+	 *
+	 * 23/11/98 NJC: Somewhat less stupid version of algorithm,
 	 * which tries to do "TheRightThing".  Instead of using half of
 	 * (buffers+cache), use the minimum values.  Allow an extra 2%
 	 * of num_physpages for safety margin.
+	 *
+	 * 2002/02/26 Alan Cox: Added two new modes that do real accounting
 	 */
+	unsigned long free, allowed;
+	struct sysinfo i;
 
-	unsigned long free;
+	atomic_add(pages, &vm_committed_space);
 	
         /* Sometimes we want to use more memory than we have. */
-	if (sysctl_overcommit_memory)
-	    return 1;
+	if (sysctl_overcommit_memory == 1)
+		return 1;
+		
+	if (sysctl_overcommit_memory == 0)
+	{
+		/* The page cache contains buffer pages these days.. */
+		free = page_cache_size;
+		free += nr_free_pages();
+		free += nr_swap_pages;
+	
+		/*
+		 * This double-counts: the nrpages are both in the page-cache
+		 * and in the swapper space. At the same time, this compensates
+		 * for the swap-space over-allocation (ie "nr_swap_pages" being
+		 * too small.
+		 */
+		free += swapper_space.nrpages;
+	
+		/*
+		 * The code below doesn't account for free space in the inode
+		 * and dentry slab cache, slab cache fragmentation, inodes and
+		 * dentries which will become freeable under VM load, etc.
+		 * Lets just hope all these (complex) factors balance out...
+		 */
+		free += (dentry_stat.nr_unused * sizeof(struct dentry)) >> PAGE_SHIFT;
+		free += (inodes_stat.nr_unused * sizeof(struct inode)) >> PAGE_SHIFT;
+	
+		if(free > pages)
+			return 1;
+		atomic_sub(pages, &vm_committed_space);
+		return 0;
+	}
 
-	/* The page cache contains buffer pages these days.. */
-	free = page_cache_size;
-	free += nr_free_pages();
-	free += nr_swap_pages;
+	/* FIXME - need to add arch hooks to get the bits we need 
+	   without the higher overhead crap */
+	si_meminfo(&i);	
+	allowed = i.totalram * sysctl_overcommit_ratio / 100;
+	allowed += total_swap_pages;
+	
+	if(atomic_read(&vm_committed_space) < allowed)
+		return 1;
 
-	/*
-	 * This double-counts: the nrpages are both in the page-cache
-	 * and in the swapper space. At the same time, this compensates
-	 * for the swap-space over-allocation (ie "nr_swap_pages" being
-	 * too small.
-	 */
-	free += swapper_space.nrpages;
+	atomic_sub(pages, &vm_committed_space);
+	return 0;
+}
 
-	/*
-	 * The code below doesn't account for free space in the inode
-	 * and dentry slab cache, slab cache fragmentation, inodes and
-	 * dentries which will become freeable under VM load, etc.
-	 * Lets just hope all these (complex) factors balance out...
-	 */
-	free += (dentry_stat.nr_unused * sizeof(struct dentry)) >> PAGE_SHIFT;
-	free += (inodes_stat.nr_unused * sizeof(struct inode)) >> PAGE_SHIFT;
+void vm_unacct_memory(long pages)
+{	
+	atomic_sub(pages, &vm_committed_space);
+}
+
+/*
+ *	Don't even bother telling me the locking is wrong - its a test
+ *	routine and uniprocessor is quite sufficient..
+ *
+ *	To enable this debugging you must tweak the #if below, and build
+ *	with no SYS5 shared memory (thats not validated yet) and non SMP
+ */
+
+void vm_validate_enough(char *x)
+{
+#if 0
+	unsigned long count = 0UL;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	struct list_head *mmp;
+	unsigned long flags;
 
-	return free > pages;
+	spin_lock_irqsave(&mmlist_lock, flags);
+
+	list_for_each(mmp, &init_mm.mmlist)
+	{
+		mm = list_entry(mmp, struct mm_struct, mmlist);
+		for(vma = mm->mmap; vma!=NULL; vma=vma->vm_next)
+		{
+			if(vma->vm_flags & VM_ACCOUNT)
+				count += (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+		}
+	}	
+	if(count != atomic_read(&vm_committed_space))
+	{
+		printk("MM crappo accounting %s: %lu %ld.\n",
+			x, count, atomic_read(&vm_committed_space));
+		atomic_set(&vm_committed_space, count);
+	}
+	spin_unlock_irqrestore(&mmlist_lock, flags);
+#endif
 }
 
 /* Remove one vm structure from the inode's i_mapping address space. */
@@ -168,6 +252,7 @@
 	}
 
 	/* Check against rlimit.. */
+	/* FIXME: - this seems to be checked in do_brk.. */
 	rlim = current->rlim[RLIMIT_DATA].rlim_cur;
 	if (rlim < RLIM_INFINITY && brk - mm->start_data > rlim)
 		goto out;
@@ -176,10 +261,6 @@
 	if (find_vma_intersection(mm, oldbrk, newbrk+PAGE_SIZE))
 		goto out;
 
-	/* Check if we have enough memory.. */
-	if (!vm_enough_memory((newbrk-oldbrk) >> PAGE_SHIFT))
-		goto out;
-
 	/* Ok, looks good - let it rip. */
 	if (do_brk(oldbrk, newbrk-oldbrk) != oldbrk)
 		goto out;
@@ -400,7 +481,9 @@
 	int correct_wcount = 0;
 	int error;
 	rb_node_t ** rb_link, * rb_parent;
+	unsigned long charged = 0;
 
+	vm_validate_enough("entering do_mmap_pgoff");
 	if (file) {
 		if (!file->f_op || !file->f_op->mmap)
 			return -ENODEV;
@@ -500,11 +583,15 @@
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		return -ENOMEM;
 
-	/* Private writable mapping? Check memory availability.. */
-	if ((vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE &&
-	    !(flags & MAP_NORESERVE)				 &&
-	    !vm_enough_memory(len >> PAGE_SHIFT))
-		return -ENOMEM;
+	if (!(flags & MAP_NORESERVE) || sysctl_overcommit_memory > 1) {
+		if ((vm_flags & (VM_SHARED|VM_WRITE)) == VM_WRITE) {
+			/* Private writable mapping: check memory availability */
+			charged = len >> PAGE_SHIFT;
+			if (!vm_enough_memory(charged))
+				return -ENOMEM;
+			vm_flags |= VM_ACCOUNT;
+		}
+	}
 
 	/* Can we just expand an old anonymous mapping? */
 	if (!file && !(vm_flags & VM_SHARED) && rb_parent)
@@ -516,8 +603,9 @@
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
+	error = -ENOMEM;
 	if (!vma)
-		return -ENOMEM;
+		goto unacct_error;
 
 	vma->vm_mm = mm;
 	vma->vm_start = addr;
@@ -569,8 +657,7 @@
 		 * to update the tree pointers.
 		 */
 		addr = vma->vm_start;
-		stale_vma = find_vma_prepare(mm, addr, &prev,
-						&rb_link, &rb_parent);
+		stale_vma = find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 		/*
 		 * Make sure the lowlevel driver did its job right.
 		 */
@@ -591,6 +678,7 @@
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
 	}
+	vm_validate_enough("out from do_mmap_pgoff");
 	return addr;
 
 unmap_and_free_vma:
@@ -603,6 +691,10 @@
 	zap_page_range(mm, vma->vm_start, vma->vm_end - vma->vm_start);
 free_vma:
 	kmem_cache_free(vm_area_cachep, vma);
+unacct_error:
+	if(charged)
+		vm_unacct_memory(charged);
+	vm_validate_enough("error path from do_mmap_pgoff");
 	return error;
 }
 
@@ -745,6 +837,130 @@
 	return NULL;
 }
 
+/* vma is the first one with  address < vma->vm_end,
+ * and even  address < vma->vm_start. Have to extend vma. */
+
+#ifdef ARCH_STACK_GROWSUP
+static inline int expand_stack(struct vm_area_struct * vma, unsigned long address)
+{
+	unsigned long grow;
+
+	if (!(vma->vm_flags & VM_GROWSUP))
+		return -EFAULT;
+
+	vm_validate_enough("entering expand_stack");
+
+	/*
+	 * vma->vm_start/vm_end cannot change under us because the caller
+	 * is required to hold the mmap_sem in read mode.  We need the
+	 * page_table_lock lock to serialize against concurrent expand_stacks.
+	 */
+ 	spin_lock(&vma->vm_mm->page_table_lock);
+
+	address += 4 + PAGE_SIZE - 1;
+	address &= PAGE_MASK;
+
+	/* already expanded while we were spinning? */
+	if (vma->vm_start <= address) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		return 0;
+	}
+
+	grow = (address - vma->vm_end) >> PAGE_SHIFT;
+
+	/* Overcommit... */
+	if (!vm_enough_memory(grow)) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		return -ENOMEM;
+	}
+
+	if (address - vma->vm_start > current->rlim[RLIMIT_STACK].rlim_cur ||
+	    ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_AS].rlim_cur) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		vm_unacct_memory(grow);
+		vm_validate_enough("exiting expand_stack - FAIL");
+		return -ENOMEM;
+	}
+
+	if ((vma->vm_flags & VM_LOCKED) &&
+      	    ((vma->vm_mm->locked_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_MEMLOCK].rlim_cur) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		vm_unacct_memory(grow);
+		vm_validate_enough("exiting expand_stack - FAIL");
+		return -ENOMEM;
+	}
+
+
+	vma->vm_end = address;
+	vma->vm_mm->total_vm += grow;
+	if (vma->vm_flags & VM_LOCKED)
+		vma->vm_mm->locked_vm += grow;
+	spin_unlock(&vma->vm_mm->page_table_lock);
+	vm_validate_enough("exiting expand_stack");
+	return 0;
+}
+#else
+
+int expand_stack(struct vm_area_struct * vma, unsigned long address)
+{
+	unsigned long grow;
+
+	if (!(vma->vm_flags & VM_GROWSDOWN))
+		return -EFAULT;
+
+	vm_validate_enough("entering expand_stack");
+
+	/*
+	 * vma->vm_start/vm_end cannot change under us because the caller
+	 * is required to hold the mmap_sem in read mode.  We need the
+	 * page_table_lock lock to serialize against concurrent expand_stacks.
+	 */
+	address &= PAGE_MASK;
+ 	spin_lock(&vma->vm_mm->page_table_lock);
+
+	/* already expanded while we were spinning? */
+	if (vma->vm_start <= address) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		return 0;
+	}
+
+	grow = (vma->vm_start - address) >> PAGE_SHIFT;
+
+	/* Overcommit... */
+	if (!vm_enough_memory(grow)) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		return -ENOMEM;
+	}
+
+	if (vma->vm_end - address > current->rlim[RLIMIT_STACK].rlim_cur ||
+	    ((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_AS].rlim_cur) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		vm_unacct_memory(grow);
+		vm_validate_enough("exiting expand_stack - FAIL");
+		return -ENOMEM;
+	}
+
+	if ((vma->vm_flags & VM_LOCKED) &&
+      	    ((vma->vm_mm->locked_vm + grow) << PAGE_SHIFT) > current->rlim[RLIMIT_MEMLOCK].rlim_cur) {
+		spin_unlock(&vma->vm_mm->page_table_lock);
+		vm_unacct_memory(grow);
+		vm_validate_enough("exiting expand_stack - FAIL");
+		return -ENOMEM;
+	}
+
+
+	vma->vm_start = address;
+	vma->vm_pgoff -= grow;
+	vma->vm_mm->total_vm += grow;
+	if (vma->vm_flags & VM_LOCKED)
+		vma->vm_mm->locked_vm += grow;
+	spin_unlock(&vma->vm_mm->page_table_lock);
+	vm_validate_enough("exiting expand_stack");
+	return 0;
+}
+
+#endif
+
 struct vm_area_struct * find_extend_vma(struct mm_struct * mm, unsigned long addr)
 {
 	struct vm_area_struct * vma;
@@ -800,6 +1016,8 @@
 	area->vm_mm->total_vm -= len >> PAGE_SHIFT;
 	if (area->vm_flags & VM_LOCKED)
 		area->vm_mm->locked_vm -= len >> PAGE_SHIFT;
+	if (area->vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(len >> PAGE_SHIFT);
 
 	/* Unmapping the whole area. */
 	if (addr == area->vm_start && end == area->vm_end) {
@@ -931,6 +1149,8 @@
 {
 	struct vm_area_struct *mpnt, *prev, **npp, *free, *extra;
 
+	vm_validate_enough("entering do_munmap");
+
 	if ((addr & ~PAGE_MASK) || addr >= TASK_SIZE || len > TASK_SIZE-addr)
 		return -EINVAL;
 
@@ -997,6 +1217,7 @@
 		    (file = mpnt->vm_file) != NULL) {
 			atomic_dec(&file->f_dentry->d_inode->i_writecount);
 		}
+
 		remove_shared_vm_struct(mpnt);
 		mm->map_count--;
 
@@ -1016,6 +1237,7 @@
 		kmem_cache_free(vm_area_cachep, extra);
 
 	free_pgtables(mm, prev, addr, addr+len);
+	vm_validate_enough("exit -ok- do_munmap");
 
 	return 0;
 }
@@ -1052,6 +1274,9 @@
 	unsigned long flags;
 	rb_node_t ** rb_link, * rb_parent;
 
+	vm_validate_enough("entering do_brk");
+
+
 	len = PAGE_ALIGN(len);
 	if (!len)
 		return addr;
@@ -1097,7 +1322,7 @@
 	if (!vm_enough_memory(len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	flags = VM_DATA_DEFAULT_FLAGS | mm->def_flags;
+	flags = VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags; 
 
 	/* Can we just expand an old anonymous mapping? */
 	if (rb_parent && vma_merge(mm, prev, rb_parent, addr, addr + len, flags))
@@ -1108,8 +1333,11 @@
 	 */
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!vma)
+	{
+		/* We accounted this address space - undo it */
+		vm_unacct_memory(len >> PAGE_SHIFT);
 		return -ENOMEM;
-
+	}
 	vma->vm_mm = mm;
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
@@ -1128,6 +1356,9 @@
 		mm->locked_vm += len >> PAGE_SHIFT;
 		make_pages_present(addr, addr + len);
 	}
+
+	vm_validate_enough("exiting do_brk");
+
 	return addr;
 }
 
@@ -1169,6 +1400,10 @@
 		unsigned long end = mpnt->vm_end;
 		unsigned long size = end - start;
 
+		/* If the VMA has been charged for, account for its removal */
+		if (mpnt->vm_flags & VM_ACCOUNT)
+			vm_unacct_memory(size >> PAGE_SHIFT);
+	
 		if (mpnt->vm_ops) {
 			if (mpnt->vm_ops->close)
 				mpnt->vm_ops->close(mpnt);
@@ -1187,8 +1422,9 @@
 		BUG();
 
 	clear_page_tables(mm, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
-
 	flush_tlb_mm(mm);
+	vm_validate_enough("exiting exit_mmap");
+
 }
 
 /* Insert vm structure into process list sorted by address
diff -ruN linux-2.4.33-pre1/mm/mprotect.c linux-2.4.33-pre1-memA/mm/mprotect.c
--- linux-2.4.33-pre1/mm/mprotect.c	Fri Nov 28 10:26:21 2003
+++ linux-2.4.33-pre1-memA/mm/mprotect.c	Thu Dec 29 20:39:30 2005
@@ -2,6 +2,23 @@
  *	linux/mm/mprotect.c
  *
  *  (C) Copyright 1994 Linus Torvalds
+ *
+ *  Address space accounting code	<alan@redhat.com>
+ *  (c) Copyright 2002 Red Hat Inc, All Rights Reserved
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
@@ -241,11 +258,28 @@
 {
 	pgprot_t newprot;
 	int error;
+	unsigned long charged = 0;
 
 	if (newflags == vma->vm_flags) {
 		*pprev = vma;
 		return 0;
 	}
+
+	/*
+	 * If we make a private mapping writable we increase our commit;
+	 * but (without finer accounting) cannot reduce our commit if we
+	 * make it unwritable again.
+	 *
+	 * FIXME? We haven't defined a VM_NORESERVE flag, so mprotecting
+	 * a MAP_NORESERVE private mapping to writable will now reserve.
+	 */
+	if ((newflags & VM_WRITE) &&
+	    !(vma->vm_flags & (VM_ACCOUNT|VM_WRITE|VM_SHARED))) {
+		charged = (end - start) >> PAGE_SHIFT;
+		if (!vm_enough_memory(charged))
+			return -ENOMEM;
+		newflags |= VM_ACCOUNT;
+	}
 	newprot = protection_map[newflags & 0xf];
 	if (start == vma->vm_start) {
 		if (end == vma->vm_end)
@@ -256,10 +290,10 @@
 		error = mprotect_fixup_end(vma, pprev, start, newflags, newprot);
 	else
 		error = mprotect_fixup_middle(vma, pprev, start, end, newflags, newprot);
-
-	if (error)
+	if (error) {
+		vm_unacct_memory(charged);
 		return error;
-
+	}
 	change_protection(start, end, newprot);
 	return 0;
 }
@@ -270,6 +304,8 @@
 	struct vm_area_struct * vma, * next, * prev;
 	int error = -EINVAL;
 
+	vm_validate_enough("entering mprotect");
+
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
 	len = PAGE_ALIGN(len);
@@ -333,5 +369,6 @@
 	}
 out:
 	up_write(&current->mm->mmap_sem);
+	vm_validate_enough("exiting mprotect");
 	return error;
 }
diff -ruN linux-2.4.33-pre1/mm/mremap.c linux-2.4.33-pre1-memA/mm/mremap.c
--- linux-2.4.33-pre1/mm/mremap.c	Wed Dec 28 05:06:01 2005
+++ linux-2.4.33-pre1-memA/mm/mremap.c	Thu Dec 29 20:39:30 2005
@@ -2,6 +2,23 @@
  *	linux/mm/remap.c
  *
  *	(C) Copyright 1996 Linus Torvalds
+ *
+ *	Address space accounting code	<alan@redhat.com>
+ *	(c) Copyright 2002 Red Hat Inc, All Rights Reserved
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
 #include <linux/slab.h>
@@ -13,8 +30,6 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 
-extern int vm_enough_memory(long pages);
-
 static inline pte_t *get_one_pte(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t * pgd;
@@ -133,6 +148,9 @@
 	struct mm_struct * mm = vma->vm_mm;
 	struct vm_area_struct * new_vma, * next, * prev;
 	int allocated_vma;
+	unsigned long excess = 0;
+	int split = 0;
+
 
 	new_vma = NULL;
 	next = find_vma_prev(mm, new_addr, &prev);
@@ -187,7 +205,7 @@
 			*new_vma = *vma;
 			new_vma->vm_start = new_addr;
 			new_vma->vm_end = new_addr+new_len;
-			new_vma->vm_pgoff += (addr-vma->vm_start) >> PAGE_SHIFT;
+			new_vma->vm_pgoff += (addr - vma->vm_start) >> PAGE_SHIFT;
 			new_vma->vm_raend = 0;
 			if (new_vma->vm_file)
 				get_file(new_vma->vm_file);
@@ -197,9 +215,35 @@
 		}
 
 		/* XXX: possible errors masked, mapping might remain */
-		do_munmap(current->mm, addr, old_len);
+		/* Conceal VM_ACCOUNT so old reservation is not undone */
+		if (vma->vm_flags & VM_ACCOUNT) {
+			vma->vm_flags &= ~VM_ACCOUNT;
+			excess = vma->vm_end - vma->vm_start - old_len;
+			if (addr > vma->vm_start &&
+			    addr + old_len < vma->vm_end)
+				split = 1;
+		}
 
+		/*
+		 * if we failed to move page tables we still do total_vm
+		 * increment since do_munmap() will decrement it by
+		 * old_len == new_len
+		 */
 		current->mm->total_vm += new_len >> PAGE_SHIFT;
+
+		if (do_munmap(mm, addr, old_len) < 0) {
+			/* OOM: unable to split vma, just get accounts right */
+			vm_unacct_memory(excess >> PAGE_SHIFT);
+			excess = 0;
+		}
+
+		/* Restore VM_ACCOUNT if one or two pieces of vma left */
+		if (excess) {
+			vma->vm_flags |= VM_ACCOUNT;
+			if (split)
+				vma->vm_next->vm_flags |= VM_ACCOUNT;
+		}
+
 		if (vm_locked) {
 			current->mm->locked_vm += new_len >> PAGE_SHIFT;
 			if (new_len > old_len)
@@ -227,6 +271,7 @@
 {
 	struct vm_area_struct *vma;
 	unsigned long ret = -EINVAL;
+	unsigned long charged = 0;
 
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
 		goto out;
@@ -281,6 +326,7 @@
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
+	 * do_munmap does all the needed commit accounting
 	 */
 	if (old_len >= new_len) {
 		ret = do_munmap(current->mm, addr+new_len, old_len - new_len);
@@ -316,11 +362,12 @@
 	if ((current->mm->total_vm << PAGE_SHIFT) + (new_len - old_len)
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		goto out;
-	/* Private writable mapping? Check memory availability.. */
-	if ((vma->vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE &&
-	    !(flags & MAP_NORESERVE)				 &&
-	    !vm_enough_memory((new_len - old_len) >> PAGE_SHIFT))
-		goto out;
+
+	if (vma->vm_flags & VM_ACCOUNT) {
+		charged = (new_len - old_len) >> PAGE_SHIFT;
+		if(!vm_enough_memory(charged))
+			goto out_nc;
+	}
 
 	/* old_len exactly to the end of the area..
 	 * And we're not relocating the area.
@@ -344,6 +391,7 @@
 						   addr + new_len);
 			}
 			ret = addr;
+			vm_validate_enough("mremap path1");
 			goto out;
 		}
 	}
@@ -367,6 +415,12 @@
 		ret = move_vma(vma, addr, old_len, new_len, new_addr);
 	}
 out:
+	if(ret & ~PAGE_MASK)
+	{
+		vm_unacct_memory(charged);
+		vm_validate_enough("mremap error path");
+	}
+out_nc:
 	return ret;
 }
 
@@ -376,8 +430,10 @@
 {
 	unsigned long ret;
 
+	vm_validate_enough("entry to mremap");
 	down_write(&current->mm->mmap_sem);
 	ret = do_mremap(addr, old_len, new_len, flags, new_addr);
 	up_write(&current->mm->mmap_sem);
+	vm_validate_enough("exit from mremap");
 	return ret;
 }
diff -ruN linux-2.4.33-pre1/mm/shmem.c linux-2.4.33-pre1-memA/mm/shmem.c
--- linux-2.4.33-pre1/mm/shmem.c	Wed Dec 28 05:05:58 2005
+++ linux-2.4.33-pre1-memA/mm/shmem.c	Thu Dec 29 20:39:30 2005
@@ -24,6 +24,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/swap.h>
 #include <linux/pagemap.h>
@@ -395,10 +396,20 @@
 {
 	struct inode *inode = dentry->d_inode;
 	struct page *page = NULL;
+	long change = 0;
 	int error;
 
-	if (attr->ia_valid & ATTR_SIZE) {
-		if (attr->ia_size < inode->i_size) {
+	if ((attr->ia_valid & ATTR_SIZE) && (attr->ia_size <= SHMEM_MAX_BYTES)) {
+		/*
+	 	 * Account swap file usage based on new file size,
+		 * but just let vmtruncate fail on out-of-range sizes.
+	 	 */
+		change = VM_ACCT(attr->ia_size) - VM_ACCT(inode->i_size);
+		if (change > 0) {
+			if (!vm_enough_memory(change))
+				return -ENOMEM;
+		} else if (attr->ia_size < inode->i_size) {
+			vm_unacct_memory(-change);
 			/*
 			 * If truncating down to a partial page, then
 			 * if that page is already allocated, hold it
@@ -432,6 +443,8 @@
 		error = inode_setattr(inode, attr);
 	if (page)
 		page_cache_release(page);
+	if (error)
+		vm_unacct_memory(change);
 	return error;
 }
 
@@ -444,6 +457,7 @@
 		spin_lock(&shmem_ilock);
 		list_del(&info->list);
 		spin_unlock(&shmem_ilock);
+		vm_unacct_memory(VM_ACCT(inode->i_size));
 		inode->i_size = 0;
 		shmem_truncate(inode);
 	}
@@ -974,6 +988,7 @@
 	loff_t		pos;
 	unsigned long	written;
 	ssize_t		err;
+	loff_t		maxpos;
 
 	if ((ssize_t) count < 0)
 		return -EINVAL;
@@ -990,6 +1005,15 @@
 	if (err || !count)
 		goto out;
 
+	maxpos = inode->i_size;
+	if (maxpos < pos + count) {
+		maxpos = pos + count;
+		if (!vm_enough_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size))) {
+			err = -ENOMEM;
+			goto out;
+		}
+	}
+
 	remove_suid(inode);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 
@@ -998,12 +1022,15 @@
 		unsigned long bytes, index, offset;
 		char *kaddr;
 		int left;
+		int deactivate = 1;
 
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
-		if (bytes > count)
+		if (bytes > count) {
 			bytes = count;
+			deactivate = 0;
+		}
 
 		/*
 		 * We don't hold page lock across copy from user -
@@ -1028,6 +1055,12 @@
 		flush_dcache_page(page);
 		SetPageDirty(page);
 		SetPageReferenced(page);
+#ifdef PG_inactive_dirty
+		if (deactivate)
+			deactivate_page(page);
+		else
+			mark_page_accessed(page);
+#endif
 		page_cache_release(page);
 
 		if (left) {
@@ -1041,6 +1074,10 @@
 	*ppos = pos;
 	if (written)
 		err = written;
+
+	/* Short writes give back address space */
+	if (inode->i_size != maxpos)
+		vm_unacct_memory(VM_ACCT(maxpos) - VM_ACCT(inode->i_size));
 out:
 	up(&inode->i_sem);
 	return err;
@@ -1364,8 +1401,13 @@
 		memcpy(info, symname, len);
 		inode->i_op = &shmem_symlink_inline_operations;
 	} else {
+		if (!vm_enough_memory(VM_ACCT(1))) {
+			iput(inode);
+			return -ENOMEM;
+		}
 		error = shmem_getpage(inode, 0, &page, SGP_WRITE);
 		if (error) {
+			vm_unacct_memory(VM_ACCT(1));
 			iput(inode);
 			return error;
 		}
@@ -1684,7 +1726,6 @@
 	struct inode *inode;
 	struct dentry *dentry, *root;
 	struct qstr this;
-	int vm_enough_memory(long pages);
 
 	if (IS_ERR(shm_mnt))
 		return (void *)shm_mnt;
@@ -1695,13 +1736,14 @@
 	if (!vm_enough_memory(VM_ACCT(size)))
 		return ERR_PTR(-ENOMEM);
 
+	error = -ENOMEM;
 	this.name = name;
 	this.len = strlen(name);
 	this.hash = 0; /* will go */
 	root = shm_mnt->mnt_root;
 	dentry = d_alloc(root, &this);
 	if (!dentry)
-		return ERR_PTR(-ENOMEM);
+		goto put_memory;
 
 	error = -ENFILE;
 	file = get_empty_filp();
@@ -1726,6 +1768,8 @@
 	put_filp(file);
 put_dentry:
 	dput(dentry);
+put_memory:
+	vm_unacct_memory(VM_ACCT(size));
 	return ERR_PTR(error);
 }
 
