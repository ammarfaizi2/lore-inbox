Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422951AbWHZRpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422951AbWHZRpA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422945AbWHZRov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:44:51 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:37499 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1422973AbWHZRmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:42:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=suDOI9eWLoZja1VgZ6Ntgp/rFsL8LAyv/p7ZGhi4gxqmseyb4690kr/Xw5eJqZ84kB0sclJA8cLIJTnQ8YWBpEaSVhey0m1a03IzxwTawevCIiQdhrCgRaTTd3jFhnc8Iqe8Nvj+A2TuFTmwuCIA3xmFzHZGSyuz87sKkk47zvw=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH RFP-V4 09/13] RFP prot support: use FAULT_SIGSEGV for protection checking
Date: Sat, 26 Aug 2006 19:42:39 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <20060826174239.14790.77251.stgit@memento.home.lan>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
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
  was wrong, then it'll do another fault and die only then. However next patch
  removes this peculiarity.

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

Changes are included for the i386, x86_64 and UML handler.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/i386/mm/fault.c   |   10 ++++++++++
 arch/um/kernel/trap.c  |   10 +++++++++-
 arch/x86_64/mm/fault.c |   13 ++++++++++++-
 include/linux/mm.h     |   15 +++++++++------
 mm/memory.c            |   47 +++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 83 insertions(+), 12 deletions(-)

diff --git a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
index f727946..e358998 100644
--- a/arch/i386/mm/fault.c
+++ b/arch/i386/mm/fault.c
@@ -434,6 +434,14 @@ fastcall void __kprobes do_page_fault(st
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
@@ -470,6 +478,8 @@ #endif
 			goto do_sigbus;
 		case VM_FAULT_OOM:
 			goto out_of_memory;
+		case VM_FAULT_SIGSEGV:
+			goto bad_area;
 		default:
 			BUG();
 	}
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index ac70fa5..563feb4 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
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
diff --git a/arch/x86_64/mm/fault.c b/arch/x86_64/mm/fault.c
index ac8ea66..7eec080 100644
--- a/arch/x86_64/mm/fault.c
+++ b/arch/x86_64/mm/fault.c
@@ -459,6 +459,12 @@ asmlinkage void __kprobes do_page_fault(
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
@@ -474,6 +480,7 @@ good_area:
 				goto bad_area;
 	}
 
+handle_fault:
 	/*
 	 * If for any reason at all we couldn't handle the fault,
 	 * make sure we exit gracefully rather than endlessly redo
@@ -488,8 +495,12 @@ good_area:
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
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 66de7a7..67fe661 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -636,10 +636,11 @@ #define NOPAGE_OOM	((struct page *) (-1)
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
@@ -745,14 +746,16 @@ extern int install_page(struct mm_struct
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
diff --git a/mm/memory.c b/mm/memory.c
index a87526e..e86f6ab 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -972,6 +972,7 @@ no_page_table:
 	return page;
 }
 
+/* Return number of faulted-in pages. */
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,
 		struct page **pages, struct vm_area_struct **vmas)
@@ -1075,6 +1076,7 @@ int get_user_pages(struct task_struct *t
 				case VM_FAULT_MAJOR:
 					tsk->maj_flt++;
 					break;
+				case VM_FAULT_SIGSEGV:
 				case VM_FAULT_SIGBUS:
 					return i ? i : -EFAULT;
 				case VM_FAULT_OOM:
@@ -2182,6 +2184,8 @@ retry:
 	/* Only go through if we didn't race with anybody else... */
 	if (pte_none(*page_table)) {
 		flush_icache_page(vma, new_page);
+		/* This already sets the PTE to be rw if appropriate, except for
+		 * private COW pages. */
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
@@ -2211,6 +2215,25 @@ oom:
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
@@ -2268,14 +2291,21 @@ static int do_file_page(struct mm_struct
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
@@ -2294,6 +2324,12 @@ static inline int handle_pte_fault(struc
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
@@ -2318,13 +2354,16 @@ static inline int handle_pte_fault(struc
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
@@ -2336,7 +2375,7 @@ int __handle_mm_fault(struct mm_struct *
 	count_vm_event(PGFAULT);
 
 	if (unlikely(is_vm_hugetlb_page(vma)))
-		return hugetlb_fault(mm, vma, address, write_access);
+		return hugetlb_fault(mm, vma, address, access_mask & VM_WRITE);
 
 	pgd = pgd_offset(mm, address);
 	pud = pud_alloc(mm, pgd, address);
@@ -2349,7 +2388,7 @@ int __handle_mm_fault(struct mm_struct *
 	if (!pte)
 		return VM_FAULT_OOM;
 
-	return handle_pte_fault(mm, vma, address, pte, pmd, write_access);
+	return handle_pte_fault(mm, vma, address, pte, pmd, access_mask);
 }
 
 EXPORT_SYMBOL_GPL(__handle_mm_fault);
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
