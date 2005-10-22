Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVJVQXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVJVQXV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 12:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVJVQXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 12:23:21 -0400
Received: from silver.veritas.com ([143.127.12.111]:38037 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932246AbVJVQXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 12:23:20 -0400
Date: Sat, 22 Oct 2005 17:22:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] mm: arm ready for split ptlock
In-Reply-To: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Oct 2005 16:23:20.0575 (UTC) FILETIME=[EAAA48F0:01C5D724]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare arm for the split page_table_lock: three issues.

Signal handling's preserve and restore of iwmmxt context currently
involves reading and writing that context to and from user space, while
holding page_table_lock to secure the user page(s) against kswapd.  If
we split the lock, then the structure might span two pages, secured by
different locks.  That would be manageable; but it seems simpler just
to read into and write from a kernel stack buffer, copying that out and
in without locking (the structure is 160 bytes in size, and here we're
near the top of the kernel stack).  Or would the overhead be noticeable?

arm_syscall's cmpxchg emulation use pte_offset_map_lock, instead of
pte_offset_map and mm-wide page_table_lock; and strictly, it should now
also take mmap_sem before descending to pmd, to guard against another
thread munmapping, and the page table pulled out beneath this thread.

Updated two comments in fault-armv.c.  adjust_pte is interesting, since
its modification of a pte in one part of the mm depends on the lock held
when calling update_mmu_cache for a pte in some other part of that mm.
This can't be done with a split page_table_lock (and we've already taken
the lowest lock in the hierarchy here): so we'll have to disable split
on arm, unless CONFIG_CPU_CACHE_VIPT to ensures adjust_pte never used.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
Note: this is RMK's first sighting of this patch: he may not approve.

 arch/arm/kernel/signal.c |   96 ++++++++---------------------------------------
 arch/arm/kernel/traps.c  |   14 ++++--
 arch/arm/mm/fault-armv.c |    7 ++-
 3 files changed, 33 insertions(+), 84 deletions(-)

--- mm1/arch/arm/kernel/signal.c	2005-10-11 12:07:07.000000000 +0100
+++ mm2/arch/arm/kernel/signal.c	2005-10-22 14:06:15.000000000 +0100
@@ -139,93 +139,33 @@ struct iwmmxt_sigframe {
 	unsigned long	storage[0x98/4];
 };
 
-static int page_present(struct mm_struct *mm, void __user *uptr, int wr)
-{
-	unsigned long addr = (unsigned long)uptr;
-	pgd_t *pgd = pgd_offset(mm, addr);
-	if (pgd_present(*pgd)) {
-		pmd_t *pmd = pmd_offset(pgd, addr);
-		if (pmd_present(*pmd)) {
-			pte_t *pte = pte_offset_map(pmd, addr);
-			return (pte_present(*pte) && (!wr || pte_write(*pte)));
-		}
-	}
-	return 0;
-}
-
-static int copy_locked(void __user *uptr, void *kptr, size_t size, int write,
-		       void (*copyfn)(void *, void __user *))
-{
-	unsigned char v, __user *userptr = uptr;
-	int err = 0;
-
-	do {
-		struct mm_struct *mm;
-
-		if (write) {
-			__put_user_error(0, userptr, err);
-			__put_user_error(0, userptr + size - 1, err);
-		} else {
-			__get_user_error(v, userptr, err);
-			__get_user_error(v, userptr + size - 1, err);
-		}
-
-		if (err)
-			break;
-
-		mm = current->mm;
-		spin_lock(&mm->page_table_lock);
-		if (page_present(mm, userptr, write) &&
-		    page_present(mm, userptr + size - 1, write)) {
-		    	copyfn(kptr, uptr);
-		} else
-			err = 1;
-		spin_unlock(&mm->page_table_lock);
-	} while (err);
-
-	return err;
-}
-
 static int preserve_iwmmxt_context(struct iwmmxt_sigframe *frame)
 {
-	int err = 0;
+	char kbuf[sizeof(*frame) + 8];
+	struct iwmmxt_sigframe *kframe;
 
 	/* the iWMMXt context must be 64 bit aligned */
-	WARN_ON((unsigned long)frame & 7);
-
-	__put_user_error(IWMMXT_MAGIC0, &frame->magic0, err);
-	__put_user_error(IWMMXT_MAGIC1, &frame->magic1, err);
-
-	/*
-	 * iwmmxt_task_copy() doesn't check user permissions.
-	 * Let's do a dummy write on the upper boundary to ensure
-	 * access to user mem is OK all way up.
-	 */
-	err |= copy_locked(&frame->storage, current_thread_info(),
-			   sizeof(frame->storage), 1, iwmmxt_task_copy);
-	return err;
+	kframe = (struct iwmmxt_sigframe *)((unsigned long)(kbuf + 8) & ~7);
+	kframe->magic0 = IWMMXT_MAGIC0;
+	kframe->magic1 = IWMMXT_MAGIC1;
+	iwmmxt_task_copy(current_thread_info(), &kframe->storage);
+	return __copy_to_user(frame, kframe, sizeof(*frame));
 }
 
 static int restore_iwmmxt_context(struct iwmmxt_sigframe *frame)
 {
-	unsigned long magic0, magic1;
-	int err = 0;
+	char kbuf[sizeof(*frame) + 8];
+	struct iwmmxt_sigframe *kframe;
 
-	/* the iWMMXt context is 64 bit aligned */
-	WARN_ON((unsigned long)frame & 7);
-
-	/*
-	 * Validate iWMMXt context signature.
-	 * Also, iwmmxt_task_restore() doesn't check user permissions.
-	 * Let's do a dummy write on the upper boundary to ensure
-	 * access to user mem is OK all way up.
-	 */
-	__get_user_error(magic0, &frame->magic0, err);
-	__get_user_error(magic1, &frame->magic1, err);
-	if (!err && magic0 == IWMMXT_MAGIC0 && magic1 == IWMMXT_MAGIC1)
-		err = copy_locked(&frame->storage, current_thread_info(),
-				  sizeof(frame->storage), 0, iwmmxt_task_restore);
-	return err;
+	/* the iWMMXt context must be 64 bit aligned */
+	kframe = (struct iwmmxt_sigframe *)((unsigned long)(kbuf + 8) & ~7);
+	if (__copy_from_user(kframe, frame, sizeof(*frame)))
+		return -1;
+	if (kframe->magic0 != IWMMXT_MAGIC0 ||
+	    kframe->magic1 != IWMMXT_MAGIC1)
+		return -1;
+	iwmmxt_task_restore(current_thread_info(), &kframe->storage);
+	return 0;
 }
 
 #endif
--- mm1/arch/arm/kernel/traps.c	2005-10-17 12:05:08.000000000 +0100
+++ mm2/arch/arm/kernel/traps.c	2005-10-22 14:06:15.000000000 +0100
@@ -481,29 +481,33 @@ asmlinkage int arm_syscall(int no, struc
 		unsigned long addr = regs->ARM_r2;
 		struct mm_struct *mm = current->mm;
 		pgd_t *pgd; pmd_t *pmd; pte_t *pte;
+		spinlock_t *ptl;
 
 		regs->ARM_cpsr &= ~PSR_C_BIT;
-		spin_lock(&mm->page_table_lock);
+		down_read(&mm->mmap_sem);
 		pgd = pgd_offset(mm, addr);
 		if (!pgd_present(*pgd))
 			goto bad_access;
 		pmd = pmd_offset(pgd, addr);
 		if (!pmd_present(*pmd))
 			goto bad_access;
-		pte = pte_offset_map(pmd, addr);
-		if (!pte_present(*pte) || !pte_write(*pte))
+		pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+		if (!pte_present(*pte) || !pte_write(*pte)) {
+			pte_unmap_unlock(pte, ptl);
 			goto bad_access;
+		}
 		val = *(unsigned long *)addr;
 		val -= regs->ARM_r0;
 		if (val == 0) {
 			*(unsigned long *)addr = regs->ARM_r1;
 			regs->ARM_cpsr |= PSR_C_BIT;
 		}
-		spin_unlock(&mm->page_table_lock);
+		pte_unmap_unlock(pte, ptl);
+		up_read(&mm->mmap_sem);
 		return val;
 
 		bad_access:
-		spin_unlock(&mm->page_table_lock);
+		up_read(&mm->mmap_sem);
 		/* simulate a write access fault */
 		do_DataAbort(addr, 15 + (1 << 11), regs);
 		return -1;
--- mm1/arch/arm/mm/fault-armv.c	2005-08-29 00:41:01.000000000 +0100
+++ mm2/arch/arm/mm/fault-armv.c	2005-10-22 14:06:16.000000000 +0100
@@ -26,6 +26,11 @@ static unsigned long shared_pte_mask = L
 /*
  * We take the easy way out of this problem - we make the
  * PTE uncacheable.  However, we leave the write buffer on.
+ *
+ * Note that the pte lock held when calling update_mmu_cache must also
+ * guard the pte (somewhere else in the same mm) that we modify here.
+ * Therefore those configurations which might call adjust_pte (those
+ * without CONFIG_CPU_CACHE_VIPT) cannot support split page_table_lock.
  */
 static int adjust_pte(struct vm_area_struct *vma, unsigned long address)
 {
@@ -127,7 +132,7 @@ void __flush_dcache_page(struct address_
  *  2. If we have multiple shared mappings of the same space in
  *     an object, we need to deal with the cache aliasing issues.
  *
- * Note that the page_table_lock will be held.
+ * Note that the pte lock will be held.
  */
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr, pte_t pte)
 {
