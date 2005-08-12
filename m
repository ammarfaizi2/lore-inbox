Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVHLR4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVHLR4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVHLRyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:54:52 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:22711 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1750781AbVHLRyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:54:21 -0400
Subject: [patch 19/39] remap file pages protection support: use FAULT_SIGSEGV for protection checking
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 19:32:22 +0200
Message-Id: <20050812173222.3F6DF24E7F2@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

The arch handler used to check itself protection, now we must possibly move
that to the generic VM if the VMA is non-uniform.

For now, do_file_page installs the PTE and doesn't check the fault type, if it
was wrong, then it'll do another fault and die only then. I've left this for
now to exercise more the code (and it works anyway).

I've also changed do_no_pages to fault in pages with their *exact* permissions
for non-uniform VMAs.

The approach for checking is a bit clumsy because we are given a
VM_{READ,WRITE,EXEC} mask so we do *strict* checking. For instance, a VM_EXEC
mapping (which won't have VM_READ in vma->vm_flags) would give a fault on
read.

To fix that properly, we should get a pgprot mask and test
pte_read()/write/exec; for now I workaround that in the i386/UML handler, I
have patches for fixing that subsequently.

Also, there is a (potential) problem: on VM_NONUNIFORM vmas, in
handle_pte_fault(), if the PTE is present we return VM_FAULT_SIGSEGV. This has
proven to be a bit strict, at least for UML - so this may break other arches
too (only for new functionality). At least, peculiar ones - this problem was
due to handle_mm_fault() called for TLB faults rather than PTE faults.

Another problem I've just discovered is that PTRACE_POKETEXT access_process_vm
on VM_NONUNIFORM write-protected vma's won't work. That's not a big problem.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/mm/fault.c |   28 +++++++--
 linux-2.6.git-paolo/include/linux/mm.h   |   11 +++
 linux-2.6.git-paolo/mm/memory.c          |   96 ++++++++++++++++++++++++-------
 3 files changed, 108 insertions(+), 27 deletions(-)

diff -puN arch/i386/mm/fault.c~rfp-fault-sigsegv-2 arch/i386/mm/fault.c
--- linux-2.6.git/arch/i386/mm/fault.c~rfp-fault-sigsegv-2	2005-08-11 14:21:01.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/mm/fault.c	2005-08-11 16:12:46.000000000 +0200
@@ -219,6 +219,7 @@ fastcall void do_page_fault(struct pt_re
 	unsigned long address;
 	unsigned long page;
 	int write;
+	int access_mask = 0;
 	siginfo_t info;
 
 	/* get the address */
@@ -324,23 +325,24 @@ good_area:
 			/* fall through */
 		case 2:		/* write, not present */
 			if (!(vma->vm_flags & VM_WRITE))
-				goto bad_area;
+				goto bad_area_prot;
 			write++;
 			break;
-		case 1:		/* read, present */
+		case 1:		/* read, present - when does this happen? Maybe for NX exceptions? */
 			goto bad_area;
 		case 0:		/* read, not present */
 			if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
-				goto bad_area;
+				goto bad_area_prot;
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
+	switch (__handle_mm_fault(mm, vma, address, access_mask)) {
 		case VM_FAULT_MINOR:
 			tsk->min_flt++;
 			break;
@@ -368,6 +370,20 @@ good_area:
 	up_read(&mm->mmap_sem);
 	return;
 
+	/* If the PTE is not present, the vma protection are not accurate if
+	 * VM_NONUNIFORM; present PTE's are correct for VM_NONUNIFORM and were
+	 * already handled otherwise. */
+bad_area_prot:
+	if (unlikely(vma->vm_flags & VM_NONUNIFORM)) {
+		access_mask = write ? VM_WRITE : 0;
+		/* Otherwise, on a legitimate read fault on a page mapped as
+		 * exec-only, we get problems. Probably, we should lower
+		 * requirements... we should always test just
+		 * pte_read/write/exec, on vma->vm_page_prot! This way is
+		 * cumbersome. However, for now things should work for i386. */
+		access_mask |= vma->vm_flags & VM_EXEC ? VM_EXEC : VM_READ;
+		goto handle_fault;
+	}
 /*
  * Something tried to access memory that isn't in our memory map..
  * Fix it, but check if it's kernel or user first..
@@ -481,7 +497,7 @@ out_of_memory:
 	if (tsk->pid == 1) {
 		yield();
 		down_read(&mm->mmap_sem);
-		goto survive;
+		goto handle_fault;
 	}
 	printk("VM: killing process %s\n", tsk->comm);
 	if (error_code & 4)
diff -puN mm/memory.c~rfp-fault-sigsegv-2 mm/memory.c
--- linux-2.6.git/mm/memory.c~rfp-fault-sigsegv-2	2005-08-11 14:21:01.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-11 22:46:49.000000000 +0200
@@ -877,6 +877,7 @@ untouched_anonymous_page(struct mm_struc
 	return 0;
 }
 
+/* Return number of faulted-in pages. */
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,
 		struct page **pages, struct vm_area_struct **vmas)
@@ -965,6 +966,7 @@ int get_user_pages(struct task_struct *t
 				case VM_FAULT_MAJOR:
 					tsk->maj_flt++;
 					break;
+				case VM_FAULT_SIGSEGV:
 				case VM_FAULT_SIGBUS:
 					return i ? i : -EFAULT;
 				case VM_FAULT_OOM:
@@ -1888,7 +1890,11 @@ retry:
 
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
@@ -1923,7 +1929,7 @@ oom:
  * nonlinear vmas.
  */
 static int do_file_page(struct mm_struct * mm, struct vm_area_struct * vma,
-	unsigned long address, int write_access, pte_t *pte, pmd_t *pmd)
+	unsigned long address, int access_mask, pte_t *pte, pmd_t *pmd)
 {
 	unsigned long pgoff;
 	pgprot_t pgprot;
@@ -1932,12 +1938,23 @@ static int do_file_page(struct mm_struct
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
+		if (unlikely(vma->vm_flags & VM_NONUNIFORM)) {
+			if ((access_mask & VM_WRITE) > (vma->vm_flags & VM_WRITE))
+				goto out_segv;
+			if ((access_mask & VM_READ) > (vma->vm_flags & VM_READ))
+				goto out_segv;
+			if ((access_mask & VM_EXEC) > (vma->vm_flags & VM_EXEC))
+				goto out_segv;
+		}
+
 		pte_clear(mm, address, pte);
-		return do_no_page(mm, vma, address, write_access, pte, pmd);
+		return do_no_page(mm, vma, address, access_mask & VM_WRITE, pte, pmd);
 	}
 
 	pgoff = pte_to_pgoff(*pte);
@@ -1952,6 +1969,10 @@ static int do_file_page(struct mm_struct
 	if (err)
 		return VM_FAULT_SIGBUS;
 	return VM_FAULT_MAJOR;
+out_segv:
+	pte_unmap(pte);
+	spin_unlock(&mm->page_table_lock);
+	return VM_FAULT_SIGSEGV;
 }
 
 /*
@@ -1977,56 +1998,91 @@ static int do_file_page(struct mm_struct
  */
 static inline int handle_pte_fault(struct mm_struct *mm,
 	struct vm_area_struct * vma, unsigned long address,
-	int write_access, pte_t *pte, pmd_t *pmd)
+	int access_mask, pte_t *pte, pmd_t *pmd)
 {
 	pte_t entry;
 
 	entry = *pte;
 	if (!pte_present(entry)) {
+		/* when pte_file(), the VMA protections are useless. Otherwise,
+		 * we used to check protections in arch handler, but with
+		 * VM_NONUNIFORM the check is skipped. */
+		if (unlikely(vma->vm_flags & VM_NONUNIFORM) && !pte_file(entry)) {
+			if ((access_mask & VM_WRITE) > (vma->vm_flags & VM_WRITE))
+				goto out_segv;
+			if ((access_mask & VM_READ) > (vma->vm_flags & VM_READ))
+				goto out_segv;
+			if ((access_mask & VM_EXEC) > (vma->vm_flags & VM_EXEC))
+				goto out_segv;
+		}
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
 
+	/* VM_NONUNIFORM vma's have PTE's always installed with the correct
+	 * protection. */
+	if (unlikely(vma->vm_flags & VM_NONUNIFORM))
+		goto out_segv;
+
 	/*
 	 * Generate a SIGSEGV if a PROT_NONE page is accessed; this is handled
 	 * in arch-specific code if the whole VMA has PROT_NONE, and here if
 	 * just this pte has PROT_NONE (which can be done only with
-	 * remap_file_pages).
+	 * remap_file_pages). Without remap_file_pages, PROT_NONE pages cannot
+	 * be installed.
+	 * However, I strongly suspect that the above check will make this
+	 * unnecessary.
 	 */
-	if (pgprot_val(pte_to_pgprot(entry)) == pgprot_val(__P000)) {
-		pte_unmap(pte);
-		spin_unlock(&mm->page_table_lock);
-		return VM_FAULT_SIGSEGV;
+	if (unlikely(pgprot_val(pte_to_pgprot(entry)) == pgprot_val(__S000))) {
+		if (vma->vm_flags & VM_NONUNIFORM) {
+			printk(KERN_DEBUG "The first handle_pte_fault test didn't work:\n");
+			dump_stack();
+			goto out_segv;
+		} else {
+			printk(KERN_ALERT "PROT_NONE mapping in UNIFORM VMA!\n");
+			WARN_ON(1);
+			goto out_segv;
+		}
 	}
 
-	if (write_access) {
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
+	return VM_FAULT_SIGSEGV;
 }
 
 /*
  * By the time we get here, we already hold the mm semaphore
  */
-int handle_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
-		unsigned long address, int write_access)
+int __handle_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
+		unsigned long address, int access_mask)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -2059,7 +2115,7 @@ int handle_mm_fault(struct mm_struct *mm
 	if (!pte)
 		goto oom;
 	
-	return handle_pte_fault(mm, vma, address, write_access, pte, pmd);
+	return handle_pte_fault(mm, vma, address, access_mask, pte, pmd);
 
  oom:
 	spin_unlock(&mm->page_table_lock);
diff -puN include/linux/mm.h~rfp-fault-sigsegv-2 include/linux/mm.h
--- linux-2.6.git/include/linux/mm.h~rfp-fault-sigsegv-2	2005-08-11 14:21:01.000000000 +0200
+++ linux-2.6.git-paolo/include/linux/mm.h	2005-08-11 14:21:01.000000000 +0200
@@ -712,7 +712,16 @@ extern pte_t *FASTCALL(pte_alloc_kernel(
 extern pte_t *FASTCALL(pte_alloc_map(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, unsigned long pgoff, pgprot_t prot);
-extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
+
+/* We reuse VM_READ, VM_WRITE and VM_EXEC for the @access_mask. */
+extern int __handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int access_mask);
+
+static inline int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma,
+		unsigned long address, int write_access)
+{
+	return __handle_mm_fault(mm, vma, address, write_access ? VM_WRITE : 0);
+}
+
 extern int make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 void install_arg_page(struct vm_area_struct *, struct page *, unsigned long);
_
