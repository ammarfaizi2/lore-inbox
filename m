Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbVHZRCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbVHZRCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbVHZRB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:01:59 -0400
Received: from ppp-62-11-73-212.dialup.tiscali.it ([62.11.73.212]:27029 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965116AbVHZRBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:01:45 -0400
Subject: [patch 08/18] remap file pages protection support: use FAULT_SIGSEGV for protection checking
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 18:53:28 +0200
Message-Id: <20050826165328.1A92525461A@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Ingo Molnar <mingo@elte.hu>

This is the more intrusive patch, but it can't be reduced a lot, even if I
limit the protection support to the bare minimum for Uml.

The arch handler used to check itself protection, now we must possibly move
that to the generic VM if the VMA is non-uniform, since vma protections are
totally unreliable in that case (except in the ->nopage case).

So, we change the prototype of __handle_mm_fault() to inform it of the access
kind, so it does protection checking. handle_mm_fault() keeps its API, but has
the new VM_FAULT_SIGSEGV return value.

This value must be handled in every arch-specific fault handlers, otherwise we
might get spurious BUG()/oom killing. However, I've alleviated this need via
the previous "safety net" patch.

* do_file_page installs the PTE and doesn't check the fault type, if it
  was wrong, then it'll do another fault and die only then. I've left this for
  now to exercise more the code, and it works anyway; beyond, this way the
  fast-path is potentially more efficient.

* I've also changed do_no_pages to fault in pages with their *exact* permissions
  for non-uniform VMAs. There we mark pages as dirty even on read faults - I
  don't know if this can be skipped.

* For checking, we simply reuse the standard protection_map, by creating a
  pte_t value with the vma->vm_page_prot protection and testing directly
  pte_{read,write,exec} on it.

* I use the physical frame number "0" to create the PTE, even if this isn't
  probably realistic, but I assume that pfn_pte() and the access macros will
  work anyway.

* Also, there is a (potential) problem: on VM_NONUNIFORM vmas, in
  handle_pte_fault(), if the PTE is present we unconditionally return
  VM_FAULT_SIGSEGV, because the PTE was already up-to-date. This has proven to
  be a bit strict, at least for UML - so this may break other arches too (only
  for new functionality). At least, peculiar ones - this problem was due to
  handle_mm_fault() called for TLB faults rather than PTE faults.

* Another problem I've just discovered is that PTRACE_POKETEXT access_process_vm
  on VM_NONUNIFORM write-protected vma's won't work. This is handled in a
  specific patch.

Changes are included for the i386 and UML handler. It isn't enough to make UML
work, however, because UML has some peculiarities. Subsequent patches fix
this. x86_64 only contains the "silly" part (just handles VM_FAULT_SIGSEGV).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/mm/fault.c       |   19 ++++-
 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c |   19 ++++-
 linux-2.6.git-paolo/arch/x86_64/mm/fault.c     |    6 +
 linux-2.6.git-paolo/include/linux/mm.h         |   15 ++--
 linux-2.6.git-paolo/mm/memory.c                |   85 ++++++++++++++++++++-----
 5 files changed, 116 insertions(+), 28 deletions(-)

diff -puN arch/i386/mm/fault.c~rfp-add-vm_fault_sigsegv arch/i386/mm/fault.c
--- linux-2.6.git/arch/i386/mm/fault.c~rfp-add-vm_fault_sigsegv	2005-08-24 12:01:07.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/mm/fault.c	2005-08-24 12:01:07.000000000 +0200
@@ -219,6 +219,7 @@ fastcall void do_page_fault(struct pt_re
 	unsigned long address;
 	unsigned long page;
 	int write;
+	int access_mask = 0;
 	siginfo_t info;
 
 	/* get the address */
@@ -315,6 +316,14 @@ fastcall void do_page_fault(struct pt_re
 good_area:
 	info.si_code = SEGV_ACCERR;
 	write = 0;
+
+	/* If the PTE is not present, the vma protection are not accurate if
+	 * VM_NONUNIFORM; present PTE's are correct for VM_NONUNIFORM. */
+	if (unlikely(vma->vm_flags & VM_NONUNIFORM)) {
+		access_mask = write ? VM_WRITE : VM_READ;
+		goto handle_fault;
+	}
+
 	switch (error_code & 3) {
 		default:	/* 3: write, present */
 #ifdef TEST_VERIFY_AREA
@@ -334,13 +343,15 @@ good_area:
 				goto bad_area;
 	}
 
- survive:
+	access_mask = write ? VM_WRITE : 0;
+handle_fault:
 	/*
 	 * If for any reason at all we couldn't handle the fault,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	switch (handle_mm_fault(mm, vma, address, write)) {
+	switch (__handle_mm_fault(mm, vma, address, access_mask) &
+			(~VM_FAULT_WRITE)) {
 		case VM_FAULT_MINOR:
 			tsk->min_flt++;
 			break;
@@ -351,6 +362,8 @@ good_area:
 			goto do_sigbus;
 		case VM_FAULT_OOM:
 			goto out_of_memory;
+		case VM_FAULT_SIGSEGV:
+			goto bad_area;
 		default:
 			BUG();
 	}
@@ -479,7 +492,7 @@ out_of_memory:
 	if (tsk->pid == 1) {
 		yield();
 		down_read(&mm->mmap_sem);
-		goto survive;
+		goto handle_fault;
 	}
 	printk("VM: killing process %s\n", tsk->comm);
 	if (error_code & 4)
diff -puN arch/um/kernel/trap_kern.c~rfp-add-vm_fault_sigsegv arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~rfp-add-vm_fault_sigsegv	2005-08-24 12:01:07.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-08-24 12:01:07.000000000 +0200
@@ -37,6 +37,7 @@ int handle_page_fault(unsigned long addr
 	pmd_t *pmd;
 	pte_t *pte;
 	int err = -EFAULT;
+	int access_mask = 0;
 
 	*code_out = SEGV_MAPERR;
 	down_read(&mm->mmap_sem);
@@ -54,6 +55,13 @@ int handle_page_fault(unsigned long addr
 
 good_area:
 	*code_out = SEGV_ACCERR;
+	/* If the PTE is not present, the vma protection are not accurate if
+	 * VM_NONUNIFORM; present PTE's are correct for VM_NONUNIFORM. */
+	if (unlikely(vma->vm_flags & VM_NONUNIFORM)) {
+		access_mask = is_write ? VM_WRITE : VM_READ;
+		goto handle_fault;
+	}
+
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
 
@@ -61,9 +69,11 @@ good_area:
         if(!is_write && !(vma->vm_flags & (VM_READ | VM_EXEC)))
                 goto out;
 
+	access_mask = is_write ? VM_WRITE : 0;
 	do {
-survive:
-		switch (handle_mm_fault(mm, vma, address, is_write)){
+handle_fault:
+		switch (__handle_mm_fault(mm, vma, address, access_mask) &
+				(~VM_FAULT_WRITE)) {
 		case VM_FAULT_MINOR:
 			current->min_flt++;
 			break;
@@ -73,6 +83,9 @@ survive:
 		case VM_FAULT_SIGBUS:
 			err = -EACCES;
 			goto out;
+		case VM_FAULT_SIGSEGV:
+			err = -EFAULT;
+			goto out;
 		case VM_FAULT_OOM:
 			err = -ENOMEM;
 			goto out_of_memory;
@@ -101,7 +114,7 @@ out_of_memory:
 		up_read(&mm->mmap_sem);
 		yield();
 		down_read(&mm->mmap_sem);
-		goto survive;
+		goto handle_fault;
 	}
 	goto out;
 }
diff -puN arch/x86_64/mm/fault.c~rfp-add-vm_fault_sigsegv arch/x86_64/mm/fault.c
--- linux-2.6.git/arch/x86_64/mm/fault.c~rfp-add-vm_fault_sigsegv	2005-08-24 12:01:07.000000000 +0200
+++ linux-2.6.git-paolo/arch/x86_64/mm/fault.c	2005-08-24 12:01:07.000000000 +0200
@@ -445,8 +445,12 @@ good_area:
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
diff -puN include/linux/mm.h~rfp-add-vm_fault_sigsegv include/linux/mm.h
--- linux-2.6.git/include/linux/mm.h~rfp-add-vm_fault_sigsegv	2005-08-24 12:01:07.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/mm.h	2005-08-24 12:01:07.000000000 +0200
@@ -632,10 +632,11 @@ static inline int page_mapped(struct pag
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
@@ -717,11 +718,13 @@ extern pte_t *FASTCALL(pte_alloc_kernel(
 extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, unsigned long pgoff, pgprot_t prot);
-extern int __handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
+
+/* We reuse VM_READ, VM_WRITE and VM_EXEC for the @access_mask. */
+extern int __handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int access_mask);
 
 static inline int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long address, int write_access)
 {
-	return __handle_mm_fault(mm, vma, address, write_access) & (~VM_FAULT_WRITE);
+	return __handle_mm_fault(mm, vma, address, write_access ? VM_WRITE : 0) & (~VM_FAULT_WRITE);
 }
 
 extern int make_pages_present(unsigned long addr, unsigned long end);
diff -puN mm/memory.c~rfp-add-vm_fault_sigsegv mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-add-vm_fault_sigsegv	2005-08-24 12:01:07.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-24 12:02:44.000000000 +0200
@@ -877,6 +877,7 @@ untouched_anonymous_page(struct mm_struc
 	return 0;
 }
 
+/* Return number of faulted-in pages. */
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,
 		struct page **pages, struct vm_area_struct **vmas)
@@ -944,7 +945,7 @@ int get_user_pages(struct task_struct *t
 		}
 		spin_lock(&mm->page_table_lock);
 		do {
-			int write_access = write;
+			int write_access = write ? VM_WRITE : 0;
 			struct page *page;
 
 			cond_resched_lock(&mm->page_table_lock);
@@ -981,6 +982,7 @@ int get_user_pages(struct task_struct *t
 				case VM_FAULT_MAJOR:
 					tsk->maj_flt++;
 					break;
+				case VM_FAULT_SIGSEGV:
 				case VM_FAULT_SIGBUS:
 					return i ? i : -EFAULT;
 				case VM_FAULT_OOM:
@@ -1899,7 +1901,11 @@ retry:
 
 		flush_icache_page(vma, new_page);
 		entry = mk_pte(new_page, vma->vm_page_prot);
-		if (write_access)
+		/* With VM_NONUNIFORM, the VMA flags are invalid after a PTE has
+		 * been set (we can have a writeable VMA with a read-only PTE),
+		 * so we must set the *exact* permission on fault, and avoid
+		 * calling do_wp_page on write faults. */
+		if (write_access || unlikely(vma->vm_flags & VM_NONUNIFORM))
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
@@ -1928,13 +1934,32 @@ oom:
 	goto out;
 }
 
+static inline int check_perms(struct vm_area_struct * vma, int access_mask) {
+	if (unlikely(vma->vm_flags & VM_NONUNIFORM)) {
+		/* we used to check protections in arch handler, but with
+		 * VM_NONUNIFORM the check is skipped. */
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
  * nonlinear vmas.
  */
 static int do_file_page(struct mm_struct * mm, struct vm_area_struct * vma,
-	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd)
+	unsigned long address, int access_mask, pte_t *pte, pmd_t *pmd)
 {
 	unsigned long pgoff;
 	pgprot_t pgprot;
@@ -1943,12 +1968,17 @@ static int do_file_page(struct mm_struct
 	BUG_ON(!vma->vm_ops || !vma->vm_ops->nopage);
 	/*
 	 * Fall back to the linear mapping if the fs does not support
-	 * ->populate:
+	 * ->populate; in this case do the protection checks.
 	 */
 	if (!vma->vm_ops->populate ||
-			(write_access && !(vma->vm_flags & VM_SHARED))) {
+			((access_mask & VM_WRITE) && !(vma->vm_flags & VM_SHARED))) {
+		/* We're behaving as if pte_file was cleared, so check
+		 * protections like in handle_pte_fault. */
+		if (check_perms(vma, access_mask))
+			goto out_segv;
+
 		pte_clear(mm, address, pte);
-		return do_no_page(mm, vma, address, write_access, pte, pmd);
+		return do_no_page(mm, vma, address, access_mask & VM_WRITE, pte, pmd);
 	}
 
 	pgoff = pte_to_pgoff(*pte);
@@ -1963,6 +1993,10 @@ static int do_file_page(struct mm_struct
 	if (err)
 		return VM_FAULT_SIGBUS;
 	return VM_FAULT_MAJOR;
+out_segv:
+	pte_unmap(pte);
+	spin_unlock(&mm->page_table_lock);
+	return VM_FAULT_SIGSEGV;
 }
 
 /*
@@ -1988,43 +2022,64 @@ static int do_file_page(struct mm_struct
  */
 static inline int handle_pte_fault(struct mm_struct *mm,
 	struct vm_area_struct * vma, unsigned long address,
-	int write_access, pte_t *pte, pmd_t *pmd)
+	int access_mask, pte_t *pte, pmd_t *pmd)
 {
 	pte_t entry;
+	int err = VM_FAULT_SIGSEGV;
 
 	entry = *pte;
 	if (!pte_present(entry)) {
+		/* when pte_file(), the VMA protections are useless. Otherwise,
+		 * we used to check protections in arch handler, but with
+		 * VM_NONUNIFORM the check is skipped. */
+		if (!pte_file(entry) && check_perms(vma, access_mask))
+			goto out_segv;
+
 		/*
 		 * If it truly wasn't present, we know that kswapd
 		 * and the PTE updates will not touch it later. So
 		 * drop the lock.
 		 */
+		if (unlikely(pte_file(entry)))
+			return do_file_page(mm, vma, address, access_mask, pte, pmd);
+		access_mask &= VM_WRITE;
 		if (pte_none(entry))
-			return do_no_page(mm, vma, address, write_access, pte, pmd);
-		if (pte_file(entry))
-			return do_file_page(mm, vma, address, write_access, pte, pmd);
-		return do_swap_page(mm, vma, address, pte, pmd, entry, write_access);
+			return do_no_page(mm, vma, address, access_mask, pte, pmd);
+		return do_swap_page(mm, vma, address, pte, pmd, entry, access_mask);
 	}
 
-	if (write_access) {
+	/* VM_NONUNIFORM vma's have PTE's always installed with the correct
+	 * protection. So, generate a SIGSEGV if a fault is caught there. */
+	if (unlikely(vma->vm_flags & VM_NONUNIFORM))
+		goto out_segv;
+
+	/* We only need to know whether the fault is a write one.*/
+	access_mask &= VM_WRITE;
+
+	if (access_mask) {
 		if (!pte_write(entry))
 			return do_wp_page(mm, vma, address, pte, pmd, entry);
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
-	ptep_set_access_flags(vma, address, pte, entry, write_access);
+	ptep_set_access_flags(vma, address, pte, entry, access_mask);
 	update_mmu_cache(vma, address, entry);
 	lazy_mmu_prot_update(entry);
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_MINOR;
+
+out_segv:
+	pte_unmap(pte);
+	spin_unlock(&mm->page_table_lock);
+	return err;
 }
 
 /*
  * By the time we get here, we already hold the mm semaphore
  */
 int __handle_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
-		unsigned long address, int write_access)
+		unsigned long address, int access_mask)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -2057,7 +2112,7 @@ int __handle_mm_fault(struct mm_struct *
 	if (!pte)
 		goto oom;
 	
-	return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+	return handle_pte_fault(mm, vma, address, access_mask, pte, pmd);
 
  oom:
 	spin_unlock(&mm->page_table_lock);
_
