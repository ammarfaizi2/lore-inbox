Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269358AbUIYQXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269358AbUIYQXj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 12:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269359AbUIYQXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 12:23:39 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:14309 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S269358AbUIYQXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 12:23:02 -0400
Date: Sat, 25 Sep 2004 18:22:52 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: heap-stack-gap for 2.6
Message-ID: <20040925162252.GN3309@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enforces a gap between heap and stack, both on the mmap side
(for heap) and on the growsdown page faults for stack. the gap is in
page units and it's sysctl configurable. Against CVS head.

This is needed for some critical app, that wants an higher degree of
protection against potential stack overflows from the kernel. This is
mostly a 32bit matter of course, since on 32bit those apps are using
a few gigs of heap and they get as near as they can to the stack (but if
something goes wrong a page fault must happen).


the default value of 1 avoids userspace apps like java to break, but
those apps will of course set by hand in the rc.d scripts a much higher
value. 1 is a sane default, if you want to tweak the default with
mainline inclusion that's fine with me. the sysctl can always be
disabled by setting it to 0 and then nobody will notice.

feature is fully enabled on x86* and ppc*. No idea about the ia64 and
s390x layouts but they've presumably a lot more address space not to
care about this (this is primarly needed on 32bit apps). 

I didn't check the topdown model, in theory it should be extended to
cover that too, this is only working for the legacy model right now
because those apps aren't going to use topdown anyways.

Index: linux-2.5/arch/alpha/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/alpha/mm/fault.c,v
retrieving revision 1.15
diff -u -p -r1.15 fault.c
--- linux-2.5/arch/alpha/mm/fault.c	23 Sep 2004 05:59:47 -0000	1.15
+++ linux-2.5/arch/alpha/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -125,7 +125,7 @@ do_page_fault(unsigned long address, uns
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 
 	/* Ok, we have a good vm_area for this memory access, so
Index: linux-2.5/arch/arm/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/arm/mm/fault.c,v
retrieving revision 1.5
diff -u -p -r1.5 fault.c
--- linux-2.5/arch/arm/mm/fault.c	6 Aug 2004 23:06:02 -0000	1.5
+++ linux-2.5/arch/arm/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -208,7 +208,7 @@ survive:
 	goto survive;
 
 check_stack:
-	if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr))
+	if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr, NULL))
 		goto good_area;
 out:
 	return fault;
Index: linux-2.5/arch/arm26/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/arm26/mm/fault.c,v
retrieving revision 1.3
diff -u -p -r1.3 fault.c
--- linux-2.5/arch/arm26/mm/fault.c	7 Sep 2003 23:53:07 -0000	1.3
+++ linux-2.5/arch/arm26/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -197,7 +197,7 @@ survive:
 	goto survive;
 
 check_stack:
-	if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr))
+	if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr, NULL))
 		goto good_area;
 out:
 	return fault;
Index: linux-2.5/arch/cris/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/cris/mm/fault.c,v
retrieving revision 1.14
diff -u -p -r1.14 fault.c
--- linux-2.5/arch/cris/mm/fault.c	1 Jun 2004 15:52:29 -0000	1.14
+++ linux-2.5/arch/cris/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -207,7 +207,7 @@ do_page_fault(unsigned long address, str
 		if (address + PAGE_SIZE < rdusp())
 			goto bad_area;
 	}
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 
 	/*
Index: linux-2.5/arch/i386/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/i386/mm/fault.c,v
retrieving revision 1.40
diff -u -p -r1.40 fault.c
--- linux-2.5/arch/i386/mm/fault.c	8 Sep 2004 14:48:45 -0000	1.40
+++ linux-2.5/arch/i386/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -217,7 +217,7 @@ asmlinkage void do_page_fault(struct pt_
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev_vma;
 	unsigned long address;
 	unsigned long page;
 	int write;
@@ -308,7 +308,13 @@ asmlinkage void do_page_fault(struct pt_
 		if (address + 32 < regs->esp)
 			goto bad_area;
 	}
-	if (expand_stack(vma, address))
+	/*
+	 * find_vma_prev is just a bit slower, because it cannot
+	 * use the mmap_cache, so we run it only in the growsdown
+	 * slow path and we leave find_vma in the fast path.
+	 */
+	find_vma_prev(current->mm, address, &prev_vma);
+	if (expand_stack(vma, address, prev_vma))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
Index: linux-2.5/arch/ia64/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/ia64/mm/fault.c,v
retrieving revision 1.20
diff -u -p -r1.20 fault.c
--- linux-2.5/arch/ia64/mm/fault.c	8 Sep 2004 14:48:45 -0000	1.20
+++ linux-2.5/arch/ia64/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -164,7 +164,7 @@ ia64_do_page_fault (unsigned long addres
 		if (REGION_NUMBER(address) != REGION_NUMBER(vma->vm_start)
 		    || REGION_OFFSET(address) >= RGN_MAP_LIMIT)
 			goto bad_area;
-		if (expand_stack(vma, address))
+		if (expand_stack(vma, address, NULL /* FIXME? */))
 			goto bad_area;
 	} else {
 		vma = prev_vma;
Index: linux-2.5/arch/m68k/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/m68k/mm/fault.c,v
retrieving revision 1.6
diff -u -p -r1.6 fault.c
--- linux-2.5/arch/m68k/mm/fault.c	11 May 2004 14:54:30 -0000	1.6
+++ linux-2.5/arch/m68k/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -121,7 +121,7 @@ int do_page_fault(struct pt_regs *regs, 
 		if (address + 256 < rdusp())
 			goto map_err;
 	}
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto map_err;
 
 /*
Index: linux-2.5/arch/mips/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/mips/mm/fault.c,v
retrieving revision 1.12
diff -u -p -r1.12 fault.c
--- linux-2.5/arch/mips/mm/fault.c	8 Sep 2004 14:48:45 -0000	1.12
+++ linux-2.5/arch/mips/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -75,7 +75,7 @@ asmlinkage void do_page_fault(struct pt_
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
Index: linux-2.5/arch/parisc/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/parisc/mm/fault.c,v
retrieving revision 1.5
diff -u -p -r1.5 fault.c
--- linux-2.5/arch/parisc/mm/fault.c	13 Jan 2003 21:24:33 -0000	1.5
+++ linux-2.5/arch/parisc/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -196,7 +196,7 @@ good_area:
 
 check_expansion:
 	vma = prev_vma;
-	if (vma && (expand_stack(vma, address) == 0))
+	if (vma && (expand_stack(vma, address, NULL) == 0))
 		goto good_area;
 
 /*
Index: linux-2.5/arch/ppc/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/ppc/mm/fault.c,v
retrieving revision 1.22
diff -u -p -r1.22 fault.c
--- linux-2.5/arch/ppc/mm/fault.c	27 Jul 2004 04:02:20 -0000	1.22
+++ linux-2.5/arch/ppc/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -95,7 +95,7 @@ static int store_updates_sp(struct pt_re
 int do_page_fault(struct pt_regs *regs, unsigned long address,
 		  unsigned long error_code)
 {
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev_vma;
 	struct mm_struct *mm = current->mm;
 	siginfo_t info;
 	int code = SEGV_MAPERR;
@@ -175,7 +175,8 @@ int do_page_fault(struct pt_regs *regs, 
 		    && (!user_mode(regs) || !store_updates_sp(regs)))
 			goto bad_area;
 	}
-	if (expand_stack(vma, address))
+	find_vma_prev(mm, address, &prev_vma);
+	if (expand_stack(vma, address, prev_vma))
 		goto bad_area;
 
 good_area:
Index: linux-2.5/arch/ppc64/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/ppc64/mm/fault.c,v
retrieving revision 1.20
diff -u -p -r1.20 fault.c
--- linux-2.5/arch/ppc64/mm/fault.c	2 Aug 2004 17:11:09 -0000	1.20
+++ linux-2.5/arch/ppc64/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -86,7 +86,7 @@ static int store_updates_sp(struct pt_re
 int do_page_fault(struct pt_regs *regs, unsigned long address,
 		  unsigned long error_code)
 {
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev_vma;
 	struct mm_struct *mm = current->mm;
 	siginfo_t info;
 	unsigned long code = SEGV_MAPERR;
@@ -185,7 +185,8 @@ int do_page_fault(struct pt_regs *regs, 
 			goto bad_area;
 	}
 
-	if (expand_stack(vma, address))
+	find_vma_prev(mm, address, &prev_vma);
+	if (expand_stack(vma, address, prev_vma))
 		goto bad_area;
 
 good_area:
Index: linux-2.5/arch/ppc64/mm/hugetlbpage.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/ppc64/mm/hugetlbpage.c,v
retrieving revision 1.32
diff -u -p -r1.32 hugetlbpage.c
--- linux-2.5/arch/ppc64/mm/hugetlbpage.c	17 Sep 2004 18:59:04 -0000	1.32
+++ linux-2.5/arch/ppc64/mm/hugetlbpage.c	25 Sep 2004 02:41:06 -0000
@@ -496,6 +496,7 @@ unsigned long arch_get_unmapped_area(str
 full_search:
 	vma = find_vma(mm, addr);
 	while (TASK_SIZE - len >= addr) {
+		unsigned long __heap_stack_gap;
 		BUG_ON(vma && (addr >= vma->vm_end));
 
 		if (touches_hugepage_low_range(addr, len)) {
@@ -508,7 +509,13 @@ full_search:
 			vma = find_vma(mm, addr);
 			continue;
 		}
-		if (!vma || addr + len <= vma->vm_start) {
+		if (!vma)
+			goto got_it;
+		__heap_stack_gap = 0;
+		if (vma->vm_flags & VM_GROWSDOWN)
+			__heap_stack_gap = heap_stack_gap << PAGE_SHIFT;
+		if (addr + len + __heap_stack_gap <= vma->vm_start) {
+		got_it:
 			/*
 			 * Remember the place where we stopped the search:
 			 */
Index: linux-2.5/arch/s390/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/s390/mm/fault.c,v
retrieving revision 1.20
diff -u -p -r1.20 fault.c
--- linux-2.5/arch/s390/mm/fault.c	8 Sep 2004 14:48:45 -0000	1.20
+++ linux-2.5/arch/s390/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -225,7 +225,7 @@ do_exception(struct pt_regs *regs, unsig
                 goto good_area;
         if (!(vma->vm_flags & VM_GROWSDOWN))
                 goto bad_area;
-        if (expand_stack(vma, address))
+        if (expand_stack(vma, address, NULL /* FIXME? */))
                 goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
Index: linux-2.5/arch/sh/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/sh/mm/fault.c,v
retrieving revision 1.14
diff -u -p -r1.14 fault.c
--- linux-2.5/arch/sh/mm/fault.c	8 Sep 2004 14:48:45 -0000	1.14
+++ linux-2.5/arch/sh/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -69,7 +69,7 @@ asmlinkage void do_page_fault(struct pt_
 		goto good_area;
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
Index: linux-2.5/arch/sh64/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/sh64/mm/fault.c,v
retrieving revision 1.3
diff -u -p -r1.3 fault.c
--- linux-2.5/arch/sh64/mm/fault.c	8 Sep 2004 14:48:45 -0000	1.3
+++ linux-2.5/arch/sh64/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -188,7 +188,7 @@ asmlinkage void do_page_fault(struct pt_
 #endif
 		goto bad_area;
 	}
-	if (expand_stack(vma, address)) {
+	if (expand_stack(vma, address, NULL)) {
 #ifdef DEBUG_FAULT
 		print_task(tsk);
 		printk("%s:%d fault, address is 0x%08x PC %016Lx textaccess %d writeaccess %d\n",
Index: linux-2.5/arch/sparc/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/sparc/mm/fault.c,v
retrieving revision 1.19
diff -u -p -r1.19 fault.c
--- linux-2.5/arch/sparc/mm/fault.c	13 Jul 2004 18:02:33 -0000	1.19
+++ linux-2.5/arch/sparc/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -271,7 +271,7 @@ asmlinkage void do_sparc_fault(struct pt
 		goto good_area;
 	if(!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if(expand_stack(vma, address))
+	if(expand_stack(vma, address, NULL))
 		goto bad_area;
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
@@ -524,7 +524,7 @@ inline void force_user_fault(unsigned lo
 		goto good_area;
 	if(!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
-	if(expand_stack(vma, address))
+	if(expand_stack(vma, address, NULL))
 		goto bad_area;
 good_area:
 	info.si_code = SEGV_ACCERR;
Index: linux-2.5/arch/sparc64/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/sparc64/mm/fault.c,v
retrieving revision 1.22
diff -u -p -r1.22 fault.c
--- linux-2.5/arch/sparc64/mm/fault.c	2 Sep 2004 08:19:11 -0000	1.22
+++ linux-2.5/arch/sparc64/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -409,7 +409,7 @@ continue_fault:
 				goto bad_area;
 		}
 	}
-	if (expand_stack(vma, address))
+	if (expand_stack(vma, address, NULL))
 		goto bad_area;
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
Index: linux-2.5/arch/um/kernel/trap_kern.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/um/kernel/trap_kern.c,v
retrieving revision 1.10
diff -u -p -r1.10 trap_kern.c
--- linux-2.5/arch/um/kernel/trap_kern.c	24 Aug 2004 18:18:53 -0000	1.10
+++ linux-2.5/arch/um/kernel/trap_kern.c	25 Sep 2004 01:46:10 -0000
@@ -30,7 +30,7 @@ int handle_page_fault(unsigned long addr
 		      int is_write, int is_user, int *code_out)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma, *prev_vma;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
@@ -46,8 +46,11 @@ int handle_page_fault(unsigned long addr
 		goto good_area;
 	else if(!(vma->vm_flags & VM_GROWSDOWN)) 
 		goto out;
-	else if(expand_stack(vma, address)) 
-		goto out;
+	else {
+		find_vma_prev(mm, address, &prev_vma);
+		if(expand_stack(vma, address, prev_vma))
+			goto out;
+	}
 
  good_area:
 	*code_out = SEGV_ACCERR;
Index: linux-2.5/arch/x86_64/kernel/sys_x86_64.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/x86_64/kernel/sys_x86_64.c,v
retrieving revision 1.18
diff -u -p -r1.18 sys_x86_64.c
--- linux-2.5/arch/x86_64/kernel/sys_x86_64.c	31 May 2004 03:07:42 -0000	1.18
+++ linux-2.5/arch/x86_64/kernel/sys_x86_64.c	25 Sep 2004 02:40:56 -0000
@@ -119,6 +119,7 @@ arch_get_unmapped_area(struct file *filp
 
 full_search:
 	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
+		unsigned long __heap_stack_gap;
 		/* At this point:  (!vma || addr < vma->vm_end). */
 		if (end - len < addr) {
 			/*
@@ -131,7 +132,13 @@ full_search:
 			}
 			return -ENOMEM;
 		}
-		if (!vma || addr + len <= vma->vm_start) {
+		if (!vma)
+			goto got_it;
+		__heap_stack_gap = 0;
+		if (vma->vm_flags & VM_GROWSDOWN)
+			__heap_stack_gap = heap_stack_gap << PAGE_SHIFT;
+		if (addr + len + __heap_stack_gap <= vma->vm_start) {
+		got_it:
 			/*
 			 * Remember the place where we stopped the search:
 			 */
Index: linux-2.5/arch/x86_64/mm/fault.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/x86_64/mm/fault.c,v
retrieving revision 1.29
diff -u -p -r1.29 fault.c
--- linux-2.5/arch/x86_64/mm/fault.c	17 Sep 2004 19:00:12 -0000	1.29
+++ linux-2.5/arch/x86_64/mm/fault.c	25 Sep 2004 01:46:10 -0000
@@ -248,7 +248,7 @@ asmlinkage void do_page_fault(struct pt_
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev_vma;
 	unsigned long address;
 	const struct exception_table_entry *fixup;
 	int write;
@@ -349,7 +349,13 @@ asmlinkage void do_page_fault(struct pt_
 		if (address + 128 < regs->rsp)
 			goto bad_area;
 	}
-	if (expand_stack(vma, address))
+	/*
+	 * find_vma_prev is just a bit slower, because it cannot
+	 * use the mmap_cache, so we run it only in the growsdown
+	 * slow path and we leave find_vma in the fast path.
+	 */
+	find_vma_prev(current->mm, address, &prev_vma);
+	if (expand_stack(vma, address, prev_vma))
 		goto bad_area;
 /*
  * Ok, we have a good vm_area for this memory access, so
Index: linux-2.5/include/linux/mm.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/linux/mm.h,v
retrieving revision 1.190
diff -u -p -r1.190 mm.h
--- linux-2.5/include/linux/mm.h	3 Sep 2004 17:20:35 -0000	1.190
+++ linux-2.5/include/linux/mm.h	25 Sep 2004 02:32:38 -0000
@@ -730,7 +730,9 @@ void handle_ra_miss(struct address_space
 unsigned long max_sane_readahead(unsigned long nr);
 
 /* Do stack extension */
-extern int expand_stack(struct vm_area_struct * vma, unsigned long address);
+extern int heap_stack_gap;
+extern int expand_stack(struct vm_area_struct * vma, unsigned long address,
+			struct vm_area_struct * prev_vma);
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
 extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
Index: linux-2.5/include/linux/sysctl.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/linux/sysctl.h,v
retrieving revision 1.79
diff -u -p -r1.79 sysctl.h
--- linux-2.5/include/linux/sysctl.h	24 Aug 2004 18:12:13 -0000	1.79
+++ linux-2.5/include/linux/sysctl.h	25 Sep 2004 01:46:10 -0000
@@ -167,6 +167,7 @@ enum
 	VM_HUGETLB_GROUP=25,	/* permitted hugetlb group */
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
+ 	VM_HEAP_STACK_GAP=28,	/* int: page gap between heap and stack */
 };
 
 
Index: linux-2.5/kernel/sysctl.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/kernel/sysctl.c,v
retrieving revision 1.89
diff -u -p -r1.89 sysctl.c
--- linux-2.5/kernel/sysctl.c	24 Aug 2004 19:40:58 -0000	1.89
+++ linux-2.5/kernel/sysctl.c	25 Sep 2004 01:46:10 -0000
@@ -800,6 +800,14 @@ static ctl_table vm_table[] = {
 		.extra1		= &zero,
 	},
 #endif
+	{
+		.ctl_name	= VM_HEAP_STACK_GAP,
+		.procname	= "heap-stack-gap", 
+		.data		= &heap_stack_gap,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
Index: linux-2.5/mm/mmap.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/mmap.c,v
retrieving revision 1.145
diff -u -p -r1.145 mmap.c
--- linux-2.5/mm/mmap.c	3 Sep 2004 17:22:55 -0000	1.145
+++ linux-2.5/mm/mmap.c	25 Sep 2004 01:46:10 -0000
@@ -58,6 +58,7 @@ int sysctl_overcommit_memory = 0;	/* def
 int sysctl_overcommit_ratio = 50;	/* default is 50% */
 int sysctl_max_map_count = DEFAULT_MAX_MAP_COUNT;
 atomic_t vm_committed_space = ATOMIC_INIT(0);
+int heap_stack_gap = 1;
 
 EXPORT_SYMBOL(sysctl_overcommit_memory);
 EXPORT_SYMBOL(sysctl_overcommit_ratio);
@@ -1069,6 +1070,7 @@ arch_get_unmapped_area(struct file *filp
 full_search:
 	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
 		/* At this point:  (!vma || addr < vma->vm_end). */
+		unsigned long __heap_stack_gap;
 		if (TASK_SIZE - len < addr) {
 			/*
 			 * Start a new search - just in case we missed
@@ -1080,7 +1082,13 @@ full_search:
 			}
 			return -ENOMEM;
 		}
-		if (!vma || addr + len <= vma->vm_start) {
+		if (!vma)
+			goto got_it;
+		__heap_stack_gap = 0;
+		if (vma->vm_flags & VM_GROWSDOWN)
+			__heap_stack_gap = heap_stack_gap << PAGE_SHIFT;
+		if (addr + len + __heap_stack_gap <= vma->vm_start) {
+		got_it:
 			/*
 			 * Remember the place where we stopped the search:
 			 */
@@ -1315,13 +1323,17 @@ out:
 }
 
 #ifdef CONFIG_STACK_GROWSUP
-/*
- * vma is the first one with address > vma->vm_end.  Have to extend vma.
- */
-int expand_stack(struct vm_area_struct * vma, unsigned long address)
+int expand_stack(struct vm_area_struct * vma, unsigned long address,
+		 struct vm_area_struct * prev_vma)
 {
 	unsigned long grow;
 
+	/*
+	 * If you re-use the heap-stack-gap for a growsup stack you
+	 * should remove this WARN_ON.
+	 */
+	WARN_ON(prev_vma);
+
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
 
@@ -1373,7 +1385,7 @@ find_extend_vma(struct mm_struct *mm, un
 	vma = find_vma_prev(mm, addr, &prev);
 	if (vma && (vma->vm_start <= addr))
 		return vma;
-	if (!prev || expand_stack(prev, addr))
+	if (!prev || expand_stack(prev, addr, NULL))
 		return NULL;
 	if (prev->vm_flags & VM_LOCKED) {
 		make_pages_present(addr, prev->vm_end);
@@ -1384,7 +1396,8 @@ find_extend_vma(struct mm_struct *mm, un
 /*
  * vma is the first one with address < vma->vm_start.  Have to extend vma.
  */
-int expand_stack(struct vm_area_struct *vma, unsigned long address)
+int expand_stack(struct vm_area_struct *vma, unsigned long address,
+		 struct vm_area_struct *prev_vma)
 {
 	unsigned long grow;
 
@@ -1402,10 +1415,13 @@ int expand_stack(struct vm_area_struct *
 	 * anon_vma lock to serialize against concurrent expand_stacks.
 	 */
 	address &= PAGE_MASK;
+	if (prev_vma && unlikely(prev_vma->vm_end + (heap_stack_gap << PAGE_SHIFT) > address))
+		goto out_unlock;
 	grow = (vma->vm_start - address) >> PAGE_SHIFT;
 
 	/* Overcommit.. */
 	if (security_vm_enough_memory(grow)) {
+	out_unlock:
 		anon_vma_unlock(vma);
 		return -ENOMEM;
 	}
@@ -1430,7 +1446,7 @@ int expand_stack(struct vm_area_struct *
 struct vm_area_struct *
 find_extend_vma(struct mm_struct * mm, unsigned long addr)
 {
-	struct vm_area_struct * vma;
+	struct vm_area_struct * vma, * prev_vma;
 	unsigned long start;
 
 	addr &= PAGE_MASK;
@@ -1442,7 +1458,8 @@ find_extend_vma(struct mm_struct * mm, u
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		return NULL;
 	start = vma->vm_start;
-	if (expand_stack(vma, addr))
+	find_vma_prev(mm, addr, &prev_vma);
+	if (expand_stack(vma, addr, prev_vma))
 		return NULL;
 	if (vma->vm_flags & VM_LOCKED) {
 		make_pages_present(addr, start);
