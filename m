Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWD3RdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWD3RdI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWD3RdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:33:07 -0400
Received: from host157-96.pool873.interbusiness.it ([87.3.96.157]:45522 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751206AbWD3Rcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:32:46 -0400
Message-Id: <20060430173024.571940000@zion.home.lan>
References: <20060430172953.409399000@zion.home.lan>
User-Agent: quilt/0.44-1
Date: Sun, 30 Apr 2006 19:30:01 +0200
From: blaisorblade@yahoo.it
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 08/14] remap_file_pages protection support: use FAULT_SIGSEGV for protection checking
Content-Disposition: inline; filename=rfp/09-rfp-add-vm_fault_sigsegv.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Ingo Molnar <mingo@elte.hu>

This is the more intrusive patch, but it couldn't be reduced a lot, not even if
I limited the protection support to the bare minimum for Uml (and thus I left
the interface generic).

The arch handler used to check itself protection, now we must possibly move
that to the generic VM if the VMA is non-uniform, since vma protections are
totally unreliable in that case when a pte_file PTE has been set or a page is
installed.

So, we change the prototype of __handle_mm_fault() to inform it of the access
kind, so it does protection checking. handle_mm_fault() keeps its API, but has
the new VM_FAULT_SIGSEGV return value.

=== Issue 1 (trivial changes to do in every arch):
This value should be handled in every arch-specific fault handlers.

But we can get spurious BUG/oom killings only when the new functionality is
used.

=== Issue 2 (solved afterwards):
* Another problem I've just discovered is that PTRACE_POKETEXT access_process_vm
  on VM_MANYPROTS write-protected vma's won't work. This is handled in a
  specific patch.

=== Issue 3 (solved afterwards):
* Also, there is a (potential) problem: on VM_MANYPROTS vmas, in
  handle_pte_fault(), if the PTE is present we unconditionally return
  VM_FAULT_SIGSEGV, because the PTE was already up-to-date.

  This is removed in next patch, because it's wrong for 2 reasons:
  
  1) isn't thread safe - it's possible the fault occurred when the PTE was not
  installed and the PTE has been later installed by fault from another thread.

  2) This has proven to be a bit strict, at least for UML - so this may break
  other arches too (only for new functionality). At least, peculiar ones - this
  problem was due to handle_mm_fault() called for TLB faults rather than PTE
  faults. I'm leaving this note for reference, if any other arch does similar
  strange things.

=== Implementation and tradeoff notes:

* do_file_page installs the PTE and doesn't check the fault type, if it
  was wrong, then it'll do another fault and die only then. I've left this for
  now to exercise more the code, and it works anyway; beyond, this way the
  fast-path is potentially more efficient.

* I've made sure do_no_page to fault in pages with their *exact* permissions
  for non-uniform VMAs.

  Actually, the code already works so for shared vmas, since vma->vm_page_prot
  is (supposed to be) already writable when the VMA is. Hope this doesn't vary
  across different arches.

  However, for future possible handling of private mappings, this may be
  needed again.

* For checking, we simply reuse the standard protection_map, by creating a
  pte_t value with the vma->vm_page_prot protection and testing directly
  pte_{read,write,exec} on it.
  I use the physical frame number "0" to create the PTE, even if this isn't
  probably realistic, but I assume that pfn_pte() and the access macros will
  work anyway.

Changes are included for the i386, x86_64 and UML handler. It isn't enough to
make UML work, however, because UML has some peculiarities. Subsequent patches
fix this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.git.orig/arch/i386/mm/fault.c
+++ linux-2.6.git/arch/i386/mm/fault.c
@@ -397,6 +397,14 @@ fastcall void __kprobes do_page_fault(st
 good_area:
 	si_code = SEGV_ACCERR;
 	write = 0;
+
+	/* If the PTE is not present, the vma protection are not accurate if
+	 * VM_MANYPROTS; present PTE's are correct for VM_MANYPROTS. */
+	if (unlikely(vma->vm_flags & VM_MANYPROTS)) {
+		write = error_code & 2;
+		goto survive;
+	}
+
 	switch (error_code & 3) {
 		default:	/* 3: write, present */
 #ifdef TEST_VERIFY_AREA
@@ -433,6 +441,8 @@ good_area:
 			goto do_sigbus;
 		case VM_FAULT_OOM:
 			goto out_of_memory;
+		case VM_FAULT_SIGSEGV:
+			goto bad_area;
 		default:
 			BUG();
 	}
Index: linux-2.6.git/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/kernel/trap_kern.c
+++ linux-2.6.git/arch/um/kernel/trap_kern.c
@@ -68,6 +68,11 @@ int handle_page_fault(unsigned long addr
 
 good_area:
 	*code_out = SEGV_ACCERR;
+	/* If the PTE is not present, the vma protection are not accurate if
+	 * VM_MANYPROTS; present PTE's are correct for VM_MANYPROTS. */
+	if (unlikely(vma->vm_flags & VM_MANYPROTS))
+		goto survive;
+
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
 
@@ -77,7 +82,7 @@ good_area:
 
 	do {
 survive:
-		switch (handle_mm_fault(mm, vma, address, is_write)){
+		switch (handle_mm_fault(mm, vma, address, is_write)) {
 		case VM_FAULT_MINOR:
 			current->min_flt++;
 			break;
@@ -87,6 +92,9 @@ survive:
 		case VM_FAULT_SIGBUS:
 			err = -EACCES;
 			goto out;
+		case VM_FAULT_SIGSEGV:
+			err = -EFAULT;
+			goto out;
 		case VM_FAULT_OOM:
 			err = -ENOMEM;
 			goto out_of_memory;
Index: linux-2.6.git/include/linux/mm.h
===================================================================
--- linux-2.6.git.orig/include/linux/mm.h
+++ linux-2.6.git/include/linux/mm.h
@@ -623,10 +623,11 @@ static inline int page_mapped(struct pag
  * Used to decide whether a process gets delivered SIGBUS or
  * just gets major/minor fault counters bumped up.
  */
-#define VM_FAULT_OOM	0x00
-#define VM_FAULT_SIGBUS	0x01
-#define VM_FAULT_MINOR	0x02
-#define VM_FAULT_MAJOR	0x03
+#define VM_FAULT_OOM		0x00
+#define VM_FAULT_SIGBUS		0x01
+#define VM_FAULT_MINOR		0x02
+#define VM_FAULT_MAJOR		0x03
+#define VM_FAULT_SIGSEGV	0x04
 
 /* 
  * Special case for get_user_pages.
@@ -732,14 +733,16 @@ extern int install_page(struct mm_struct
 extern int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, unsigned long pgoff, pgprot_t prot);
 
 #ifdef CONFIG_MMU
+
+/* We reuse VM_READ, VM_WRITE and VM_EXEC for the @access_mask. */
 extern int __handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma,
-			unsigned long address, int write_access);
+			unsigned long address, int access_mask);
 
 static inline int handle_mm_fault(struct mm_struct *mm,
 			struct vm_area_struct *vma, unsigned long address,
 			int write_access)
 {
-	return __handle_mm_fault(mm, vma, address, write_access) &
+	return __handle_mm_fault(mm, vma, address, write_access ? VM_WRITE : VM_READ) &
 				(~VM_FAULT_WRITE);
 }
 #else
Index: linux-2.6.git/mm/memory.c
===================================================================
--- linux-2.6.git.orig/mm/memory.c
+++ linux-2.6.git/mm/memory.c
@@ -959,6 +959,7 @@ no_page_table:
 	return page;
 }
 
+/* Return number of faulted-in pages. */
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,
 		struct page **pages, struct vm_area_struct **vmas)
@@ -1062,6 +1063,7 @@ int get_user_pages(struct task_struct *t
 				case VM_FAULT_MAJOR:
 					tsk->maj_flt++;
 					break;
+				case VM_FAULT_SIGSEGV:
 				case VM_FAULT_SIGBUS:
 					return i ? i : -EFAULT;
 				case VM_FAULT_OOM:
@@ -2117,6 +2119,8 @@ retry:
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
 		flush_icache_page(vma, new_page);
+		/* This already sets the PTE to be rw if appropriate, except for
+		 * private COW pages. */
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
@@ -2146,6 +2150,25 @@ oom:
 	return VM_FAULT_OOM;
 }
 
+static inline int check_perms(struct vm_area_struct * vma, int access_mask) {
+	if (unlikely(vma->vm_flags & VM_MANYPROTS)) {
+		/* we used to check protections in arch handler, but with
+		 * VM_MANYPROTS the check is skipped. */
+		/* access_mask contains the type of the access, vm_flags are the
+		 * declared protections, pte has the protection which will be
+		 * given to the PTE's in that area. */
+		pte_t pte = pfn_pte(0UL, vma->vm_page_prot);
+		if ((access_mask & VM_WRITE) && !pte_write(pte))
+			goto err;
+		if ((access_mask & VM_READ)  && !pte_read(pte))
+			goto err;
+		if ((access_mask & VM_EXEC)  && !pte_exec(pte))
+			goto err;
+	}
+	return 0;
+err:
+	return -EPERM;
+}
 /*
  * Fault of a previously existing named mapping. Repopulate the pte
  * from the encoded file_pte if possible. This enables swappable
@@ -2203,14 +2226,21 @@ static int do_file_page(struct mm_struct
  */
 static inline int handle_pte_fault(struct mm_struct *mm,
 		struct vm_area_struct *vma, unsigned long address,
-		pte_t *pte, pmd_t *pmd, int write_access)
+		pte_t *pte, pmd_t *pmd, int access_mask)
 {
 	pte_t entry;
 	pte_t old_entry;
 	spinlock_t *ptl;
+	int write_access = access_mask & VM_WRITE;
 
 	old_entry = entry = *pte;
 	if (!pte_present(entry)) {
+		/* when pte_file(), the VMA protections are useless.  Otherwise,
+		 * we need to check VM_MANYPROTS, because in that case the arch
+		 * fault handler skips the VMA protection check. */
+		if (!pte_file(entry) && check_perms(vma, access_mask))
+			goto out_segv;
+
 		if (pte_none(entry)) {
 			if (!vma->vm_ops || !vma->vm_ops->nopage)
 				return do_anonymous_page(mm, vma, address,
@@ -2229,6 +2259,12 @@ static inline int handle_pte_fault(struc
 	spin_lock(ptl);
 	if (unlikely(!pte_same(*pte, entry)))
 		goto unlock;
+
+	/* VM_MANYPROTS vma's have PTE's always installed with the correct
+	 * protection. So, generate a SIGSEGV if a fault is caught there. */
+	if (unlikely(vma->vm_flags & VM_MANYPROTS))
+		goto out_segv;
+
 	if (write_access) {
 		if (!pte_write(entry))
 			return do_wp_page(mm, vma, address,
@@ -2253,13 +2289,16 @@ static inline int handle_pte_fault(struc
 unlock:
 	pte_unmap_unlock(pte, ptl);
 	return VM_FAULT_MINOR;
+out_segv:
+	pte_unmap_unlock(pte, ptl);
+	return VM_FAULT_SIGSEGV;
 }
 
 /*
  * By the time we get here, we already hold the mm semaphore
  */
 int __handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long address, int write_access)
+		unsigned long address, int access_mask)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -2271,7 +2310,7 @@ int __handle_mm_fault(struct mm_struct *
 	inc_page_state(pgfault);
 
 	if (unlikely(is_vm_hugetlb_page(vma)))
-		return hugetlb_fault(mm, vma, address, write_access);
+		return hugetlb_fault(mm, vma, address, access_mask & VM_WRITE);
 
 	pgd = pgd_offset(mm, address);
 	pud = pud_alloc(mm, pgd, address);
@@ -2284,7 +2323,7 @@ int __handle_mm_fault(struct mm_struct *
 	if (!pte)
 		return VM_FAULT_OOM;
 
-	return handle_pte_fault(mm, vma, address, pte, pmd, write_access);
+	return handle_pte_fault(mm, vma, address, pte, pmd, access_mask);
 }
 
 EXPORT_SYMBOL_GPL(__handle_mm_fault);
Index: linux-2.6.git/arch/x86_64/mm/fault.c
===================================================================
--- linux-2.6.git.orig/arch/x86_64/mm/fault.c
+++ linux-2.6.git/arch/x86_64/mm/fault.c
@@ -423,6 +423,12 @@ asmlinkage void __kprobes do_page_fault(
 good_area:
 	info.si_code = SEGV_ACCERR;
 	write = 0;
+
+	if (unlikely(vma->vm_flags & VM_MANYPROTS)) {
+		write = error_code & PF_PROT;
+		goto handle_fault;
+	}
+
 	switch (error_code & (PF_PROT|PF_WRITE)) {
 		default:	/* 3: write, present */
 			/* fall through */
@@ -438,6 +444,7 @@ good_area:
 				goto bad_area;
 	}
 
+handle_fault:
 	/*
 	 * If for any reason at all we couldn't handle the fault,
 	 * make sure we exit gracefully rather than endlessly redo
@@ -452,8 +459,12 @@ good_area:
 		break;
 	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
-	default:
+	case VM_FAULT_OOM:
 		goto out_of_memory;
+	case VM_FAULT_SIGSEGV:
+		goto bad_area;
+	default:
+		BUG();
 	}
 
 	up_read(&mm->mmap_sem);

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
