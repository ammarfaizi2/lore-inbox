Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVGZSoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVGZSoI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVGZSld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:41:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:654 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262013AbVGZSjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:39:20 -0400
Date: Tue, 26 Jul 2005 11:38:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Should activate_page()/__set_page_dirty_buffers() use _irqsave
 locking?
Message-Id: <20050726113817.147cc074.akpm@osdl.org>
In-Reply-To: <1122375384.7642.15.camel@localhost.localdomain>
References: <1122375384.7642.15.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie <rpurdie@rpsys.net> wrote:
>
> I've been experimenting with oprofile on an arm system without a PMU.
> Whenever I enable callgraphing I see a BUG from run_posix_cpu_timers()
> due to irqs being enabled when they should be disabled.
> 
> Tracing this back shows interrupts are enabled after the arm backtrace
> code completes. Further tracing reveals its the call to
> check_user_page_readable() (within an interrupt) that is causing the
> problem.
> 
> check_user_page_readable() can potentially result in calls to
> activate_page() (mm/swap.c) and __set_page_dirty_buffers()
> (fs/buffer.c). Both functions use *_lock_irq()/*_unlock_irq rather than
> the *_lock_irqsave/*_unlock_irqrestore counterparts.
> 
> Switching them to use the save/restore locks makes everything work. Is
> there a reason for not using these here? Would such a patch be accepted?
> 
> Both the arm and i386 backtrace code would seem to be vulnerable to this
> problem.

ow, yes, ug.

check_page_readable() won't actually call set_page_dirty() because it
passes in `write = 0'.  So it should be sufficient to use
spin_lock_irqsave() in mark_page_accessed().

But then again, that's fragile and obscure and it isn't even correct: if
someone calls check_page_readable(), that doesn't imply an actual read of
the page's contents.

So how about we add a new flag to __follow_page() telling it whether to
consider this as an access to the page contents?

diff -puN mm/memory.c~check_user_page_readable-deadlock-fix mm/memory.c
--- devel/mm/memory.c~check_user_page_readable-deadlock-fix	2005-07-26 11:34:38.000000000 -0700
+++ devel-akpm/mm/memory.c	2005-07-26 11:37:21.000000000 -0700
@@ -776,8 +776,8 @@ unsigned long zap_page_range(struct vm_a
  * Do a quick page-table lookup for a single page.
  * mm->page_table_lock must be held.
  */
-static struct page *
-__follow_page(struct mm_struct *mm, unsigned long address, int read, int write)
+static struct page *__follow_page(struct mm_struct *mm, unsigned long address,
+			int read, int write, int accessed)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -818,9 +818,11 @@ __follow_page(struct mm_struct *mm, unsi
 		pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
 			page = pfn_to_page(pfn);
-			if (write && !pte_dirty(pte) && !PageDirty(page))
-				set_page_dirty(page);
-			mark_page_accessed(page);
+			if (accessed) {
+				if (write && !pte_dirty(pte) &&!PageDirty(page))
+					set_page_dirty(page);
+				mark_page_accessed(page);
+			}
 			return page;
 		}
 	}
@@ -829,16 +831,14 @@ out:
 	return NULL;
 }
 
-struct page *
-follow_page(struct mm_struct *mm, unsigned long address, int write)
+struct page *follow_page(struct mm_struct *mm, unsigned long address, int write)
 {
-	return __follow_page(mm, address, /*read*/0, write);
+	return __follow_page(mm, address, 0, write, 1);
 }
 
-int
-check_user_page_readable(struct mm_struct *mm, unsigned long address)
+int check_user_page_readable(struct mm_struct *mm, unsigned long address)
 {
-	return __follow_page(mm, address, /*read*/1, /*write*/0) != NULL;
+	return __follow_page(mm, address, 1, 0, 0) != NULL;
 }
 EXPORT_SYMBOL(check_user_page_readable);
 
_

