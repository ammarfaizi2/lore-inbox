Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbVJMBXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVJMBXm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 21:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVJMBXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 21:23:42 -0400
Received: from gold.veritas.com ([143.127.12.110]:47637 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964854AbVJMBXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 21:23:41 -0400
Date: Thu, 13 Oct 2005 02:22:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: John Levon <levon@movementarian.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 20/21] mm: kill check_user_page_readable
In-Reply-To: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0510130221150.4343@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Oct 2005 01:23:40.0854 (UTC) FILETIME=[BE86C560:01C5CF94]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check_user_page_readable is a problematic variant of follow_page.  It's
used only by oprofile's i386 and arm backtrace code, at interrupt time,
to establish whether a userspace stackframe is currently readable.

This is problematic, because we want to push the page_table_lock down
inside follow_page, and later split it; whereas oprofile is doing a
spin_trylock on it (in the i386 case, forgotten in the arm case), and
needs that to pin perhaps two pages spanned by the stackframe (which
might be covered by different locks when we split).

I think oprofile is going about this in the wrong way: it doesn't need
to know the area is readable (neither i386 nor arm uses read protection
of user pages), it doesn't need to pin the memory, it should simply
__copy_from_user_inatomic, and see if that succeeds or not.  Sorry, but
I've not got around to devising the sparse __user annotations for this.

Then we can eliminate check_user_page_readable, and return to a single
follow_page without the __follow_page variants.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/arm/oprofile/backtrace.c  |   46 ++++++++---------------------------------
 arch/i386/oprofile/backtrace.c |   38 +++++++++++----------------------
 include/linux/mm.h             |    1 
 mm/memory.c                    |   29 +++----------------------
 4 files changed, 26 insertions(+), 88 deletions(-)

--- mm19/arch/arm/oprofile/backtrace.c	2005-08-29 00:41:01.000000000 +0100
+++ mm20/arch/arm/oprofile/backtrace.c	2005-10-11 23:58:43.000000000 +0100
@@ -49,42 +49,22 @@ static struct frame_tail* kernel_backtra
 
 static struct frame_tail* user_backtrace(struct frame_tail *tail)
 {
-	struct frame_tail buftail;
+	struct frame_tail buftail[2];
 
-	/* hardware pte might not be valid due to dirty/accessed bit emulation
-	 * so we use copy_from_user and benefit from exception fixups */
-	if (copy_from_user(&buftail, tail, sizeof(struct frame_tail)))
+	/* Also check accessibility of one struct frame_tail beyond */
+	if (!access_ok(VERIFY_READ, tail, sizeof(buftail)))
+		return NULL;
+	if (__copy_from_user_inatomic(buftail, tail, sizeof(buftail)))
 		return NULL;
 
-	oprofile_add_trace(buftail.lr);
+	oprofile_add_trace(buftail[0].lr);
 
 	/* frame pointers should strictly progress back up the stack
 	 * (towards higher addresses) */
-	if (tail >= buftail.fp)
+	if (tail >= buftail[0].fp)
 		return NULL;
 
-	return buftail.fp-1;
-}
-
-/* Compare two addresses and see if they're on the same page */
-#define CMP_ADDR_EQUAL(x,y,offset) ((((unsigned long) x) >> PAGE_SHIFT) \
-	== ((((unsigned long) y) + offset) >> PAGE_SHIFT))
-
-/* check that the page(s) containing the frame tail are present */
-static int pages_present(struct frame_tail *tail)
-{
-	struct mm_struct * mm = current->mm;
-
-	if (!check_user_page_readable(mm, (unsigned long)tail))
-		return 0;
-
-	if (CMP_ADDR_EQUAL(tail, tail, 8))
-		return 1;
-
-	if (!check_user_page_readable(mm, ((unsigned long)tail) + 8))
-		return 0;
-
-	return 1;
+	return buftail[0].fp-1;
 }
 
 /*
@@ -118,7 +98,6 @@ static int valid_kernel_stack(struct fra
 void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
 {
 	struct frame_tail *tail;
-	unsigned long last_address = 0;
 
 	tail = ((struct frame_tail *) regs->ARM_fp) - 1;
 
@@ -132,13 +111,6 @@ void arm_backtrace(struct pt_regs * cons
 		return;
 	}
 
-	while (depth-- && tail && !((unsigned long) tail & 3)) {
-		if ((!CMP_ADDR_EQUAL(last_address, tail, 0)
-			|| !CMP_ADDR_EQUAL(last_address, tail, 8))
-				&& !pages_present(tail))
-			return;
-		last_address = (unsigned long) tail;
+	while (depth-- && tail && !((unsigned long) tail & 3))
 		tail = user_backtrace(tail);
-	}
 }
-
--- mm19/arch/i386/oprofile/backtrace.c	2005-08-29 00:41:01.000000000 +0100
+++ mm20/arch/i386/oprofile/backtrace.c	2005-10-11 23:58:43.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <asm/ptrace.h>
+#include <asm/uaccess.h>
 
 struct frame_head {
 	struct frame_head * ebp;
@@ -21,26 +22,22 @@ struct frame_head {
 static struct frame_head *
 dump_backtrace(struct frame_head * head)
 {
-	oprofile_add_trace(head->ret);
+	struct frame_head bufhead[2];
 
-	/* frame pointers should strictly progress back up the stack
-	 * (towards higher addresses) */
-	if (head >= head->ebp)
+	/* Also check accessibility of one struct frame_head beyond */
+	if (!access_ok(VERIFY_READ, head, sizeof(bufhead)))
+		return NULL;
+	if (__copy_from_user_inatomic(bufhead, head, sizeof(bufhead)))
 		return NULL;
 
-	return head->ebp;
-}
-
-/* check that the page(s) containing the frame head are present */
-static int pages_present(struct frame_head * head)
-{
-	struct mm_struct * mm = current->mm;
+	oprofile_add_trace(bufhead[0].ret);
 
-	/* FIXME: only necessary once per page */
-	if (!check_user_page_readable(mm, (unsigned long)head))
-		return 0;
+	/* frame pointers should strictly progress back up the stack
+	 * (towards higher addresses) */
+	if (head >= bufhead[0].ebp)
+		return NULL;
 
-	return check_user_page_readable(mm, (unsigned long)(head + 1));
+	return bufhead[0].ebp;
 }
 
 /*
@@ -97,15 +94,6 @@ x86_backtrace(struct pt_regs * const reg
 		return;
 	}
 
-#ifdef CONFIG_SMP
-	if (!spin_trylock(&current->mm->page_table_lock))
-		return;
-#endif
-
-	while (depth-- && head && pages_present(head))
+	while (depth-- && head)
 		head = dump_backtrace(head);
-
-#ifdef CONFIG_SMP
-	spin_unlock(&current->mm->page_table_lock);
-#endif
 }
--- mm19/include/linux/mm.h	2005-10-11 23:57:59.000000000 +0100
+++ mm20/include/linux/mm.h	2005-10-11 23:58:43.000000000 +0100
@@ -952,7 +952,6 @@ extern struct page * vmalloc_to_page(voi
 extern unsigned long vmalloc_to_pfn(void *addr);
 extern struct page * follow_page(struct mm_struct *mm, unsigned long address,
 		int write);
-extern int check_user_page_readable(struct mm_struct *mm, unsigned long address);
 int remap_pfn_range(struct vm_area_struct *, unsigned long,
 		unsigned long, unsigned long, pgprot_t);
 
--- mm19/mm/memory.c	2005-10-11 23:57:59.000000000 +0100
+++ mm20/mm/memory.c	2005-10-11 23:58:43.000000000 +0100
@@ -809,8 +809,7 @@ unsigned long zap_page_range(struct vm_a
  * Do a quick page-table lookup for a single page.
  * mm->page_table_lock must be held.
  */
-static struct page *__follow_page(struct mm_struct *mm, unsigned long address,
-			int read, int write, int accessed)
+struct page *follow_page(struct mm_struct *mm, unsigned long address, int write)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -846,16 +845,12 @@ static struct page *__follow_page(struct
 	if (pte_present(pte)) {
 		if (write && !pte_write(pte))
 			goto out;
-		if (read && !pte_read(pte))
-			goto out;
 		pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			page = pfn_to_page(pfn);
-			if (accessed) {
-				if (write && !pte_dirty(pte) &&!PageDirty(page))
-					set_page_dirty(page);
-				mark_page_accessed(page);
-			}
+			if (write && !pte_dirty(pte) &&!PageDirty(page))
+				set_page_dirty(page);
+			mark_page_accessed(page);
 			return page;
 		}
 	}
@@ -864,22 +859,6 @@ out:
 	return NULL;
 }
 
-inline struct page *
-follow_page(struct mm_struct *mm, unsigned long address, int write)
-{
-	return __follow_page(mm, address, 0, write, 1);
-}
-
-/*
- * check_user_page_readable() can be called frm niterrupt context by oprofile,
- * so we need to avoid taking any non-irq-safe locks
- */
-int check_user_page_readable(struct mm_struct *mm, unsigned long address)
-{
-	return __follow_page(mm, address, 1, 0, 0) != NULL;
-}
-EXPORT_SYMBOL(check_user_page_readable);
-
 static inline int
 untouched_anonymous_page(struct mm_struct* mm, struct vm_area_struct *vma,
 			 unsigned long address)
