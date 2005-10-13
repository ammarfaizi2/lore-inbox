Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbVJMAyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVJMAyY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVJMAyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:54:24 -0400
Received: from gold.veritas.com ([143.127.12.110]:27154 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932483AbVJMAyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:54:23 -0400
Date: Thu, 13 Oct 2005 01:53:38 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/21] mm: ia64 use expand_upwards
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130152240.4060@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 00:54:23.0102 (UTC) FILETIME=[A6D319E0:01C5CF90]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 has expand_backing_store function for growing its Register Backing
Store vma upwards.  But more complete code for this purpose is found in
the CONFIG_STACK_GROWSUP part of mm/mmap.c.  Uglify its #ifdefs further
to provide expand_upwards for ia64 as well as expand_stack for parisc.

The Register Backing Store vma should be marked VM_ACCOUNT.  Implement
the intention of growing it only a page at a time, instead of passing an
address outside of the vma to handle_mm_fault, with unknown consequences.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/ia64/mm/fault.c |   34 +++++++---------------------------
 arch/ia64/mm/init.c  |    2 +-
 include/linux/mm.h   |    3 ++-
 mm/mmap.c            |   17 ++++++++++++++---
 4 files changed, 24 insertions(+), 32 deletions(-)

--- mm07/arch/ia64/mm/fault.c	2005-09-30 11:58:53.000000000 +0100
+++ mm08/arch/ia64/mm/fault.c	2005-10-11 23:55:38.000000000 +0100
@@ -20,32 +20,6 @@
 extern void die (char *, struct pt_regs *, long);
 
 /*
- * This routine is analogous to expand_stack() but instead grows the
- * register backing store (which grows towards higher addresses).
- * Since the register backing store is access sequentially, we
- * disallow growing the RBS by more than a page at a time.  Note that
- * the VM_GROWSUP flag can be set on any VM area but that's fine
- * because the total process size is still limited by RLIMIT_STACK and
- * RLIMIT_AS.
- */
-static inline long
-expand_backing_store (struct vm_area_struct *vma, unsigned long address)
-{
-	unsigned long grow;
-
-	grow = PAGE_SIZE >> PAGE_SHIFT;
-	if (address - vma->vm_start > current->signal->rlim[RLIMIT_STACK].rlim_cur
-	    || (((vma->vm_mm->total_vm + grow) << PAGE_SHIFT) > current->signal->rlim[RLIMIT_AS].rlim_cur))
-		return -ENOMEM;
-	vma->vm_end += PAGE_SIZE;
-	vma->vm_mm->total_vm += grow;
-	if (vma->vm_flags & VM_LOCKED)
-		vma->vm_mm->locked_vm += grow;
-	vm_stat_account(vma->vm_mm, vma->vm_flags, vma->vm_file, grow);
-	return 0;
-}
-
-/*
  * Return TRUE if ADDRESS points at a page in the kernel's mapped segment
  * (inside region 5, on ia64) and that page is present.
  */
@@ -185,7 +159,13 @@ ia64_do_page_fault (unsigned long addres
 		if (REGION_NUMBER(address) != REGION_NUMBER(vma->vm_start)
 		    || REGION_OFFSET(address) >= RGN_MAP_LIMIT)
 			goto bad_area;
-		if (expand_backing_store(vma, address))
+		/* 
+		 * Since the register backing store is accessed sequentially,
+		 * we disallow growing it by more than a page at a time.
+		 */
+		if (address > vma->vm_end + PAGE_SIZE - sizeof(long))
+			goto bad_area;
+		if (expand_upwards(vma, address))
 			goto bad_area;
 	}
 	goto good_area;
--- mm07/arch/ia64/mm/init.c	2005-09-21 12:16:14.000000000 +0100
+++ mm08/arch/ia64/mm/init.c	2005-10-11 23:55:38.000000000 +0100
@@ -158,7 +158,7 @@ ia64_init_addr_space (void)
 		vma->vm_start = current->thread.rbs_bot & PAGE_MASK;
 		vma->vm_end = vma->vm_start + PAGE_SIZE;
 		vma->vm_page_prot = protection_map[VM_DATA_DEFAULT_FLAGS & 0x7];
-		vma->vm_flags = VM_DATA_DEFAULT_FLAGS | VM_GROWSUP;
+		vma->vm_flags = VM_DATA_DEFAULT_FLAGS|VM_GROWSUP|VM_ACCOUNT;
 		down_write(&current->mm->mmap_sem);
 		if (insert_vm_struct(current->mm, vma)) {
 			up_write(&current->mm->mmap_sem);
--- mm07/include/linux/mm.h	2005-10-11 23:54:33.000000000 +0100
+++ mm08/include/linux/mm.h	2005-10-11 23:55:38.000000000 +0100
@@ -904,7 +904,8 @@ void handle_ra_miss(struct address_space
 unsigned long max_sane_readahead(unsigned long nr);
 
 /* Do stack extension */
-extern int expand_stack(struct vm_area_struct * vma, unsigned long address);
+extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
+extern int expand_upwards(struct vm_area_struct *vma, unsigned long address);
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
 extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
--- mm07/mm/mmap.c	2005-10-11 23:54:33.000000000 +0100
+++ mm08/mm/mmap.c	2005-10-11 23:55:38.000000000 +0100
@@ -1504,11 +1504,15 @@ static int acct_stack_growth(struct vm_a
 	return 0;
 }
 
-#ifdef CONFIG_STACK_GROWSUP
+#if defined(CONFIG_STACK_GROWSUP) || defined(CONFIG_IA64)
 /*
- * vma is the first one with address > vma->vm_end.  Have to extend vma.
+ * PA-RISC uses this for its stack; IA64 for its Register Backing Store.
+ * vma is the last one with address > vma->vm_end.  Have to extend vma.
  */
-int expand_stack(struct vm_area_struct * vma, unsigned long address)
+#ifdef CONFIG_STACK_GROWSUP
+static inline
+#endif
+int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 {
 	int error;
 
@@ -1546,6 +1550,13 @@ int expand_stack(struct vm_area_struct *
 	anon_vma_unlock(vma);
 	return error;
 }
+#endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
+
+#ifdef CONFIG_STACK_GROWSUP
+int expand_stack(struct vm_area_struct *vma, unsigned long address)
+{
+	return expand_upwards(vma, address);
+}
 
 struct vm_area_struct *
 find_extend_vma(struct mm_struct *mm, unsigned long addr)
