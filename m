Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVCZPxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVCZPxR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 10:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVCZPxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 10:53:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61960 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261151AbVCZPxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 10:53:07 -0500
Date: Sat, 26 Mar 2005 15:52:54 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
Message-ID: <20050326155254.E12809@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, davem@davemloft.net,
	tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <20050325212234.F12715@flint.arm.linux.org.uk> <4244C3B7.4020409@yahoo.com.au> <20050326113530.A12809@flint.arm.linux.org.uk> <424566E0.80001@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <424566E0.80001@yahoo.com.au>; from nickpiggin@yahoo.com.au on Sun, Mar 27, 2005 at 12:42:56AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 12:42:56AM +1100, Nick Piggin wrote:
> OK, thanks that would be good. You could well be right in your analysis.
> May I suggest a possible avenue of investigation:

Yes, this patch seems to also be required, otherwise I see:

free_pgtables : floor 40015000 ceiling 4001b000
free_pgd_range: floor 40015000 ceiling 4001b000 addr 40015000 end 40016000
free_pgtables : floor 40015000 ceiling 4001b000
free_pgd_range: floor 40015000 ceiling 4001b000 addr 40015000 end 40016000
free_pgtables : floor 40015000 ceiling 4001b000
free_pgd_range: floor 40015000 ceiling 4001b000 addr 40015000 end 40016000
free_pgtables : floor 00000000 ceiling 00000000
free_pgd_range: floor 00000000 ceiling 40000000 addr 00008000 end 0001d000
free_pud_range: floor 00000000 ceiling 40000000 addr 00000000 end 00200000
free_pmd_range: floor 00000000 ceiling 40000000 addr 00000000 end 00200000
free_pgd_range: floor 00000000 ceiling bef4e000 addr 40000000 end 4012d000
free_pud_range: floor 00000000 ceiling bef4e000 addr 40000000 end 40200000
free_pmd_range: floor 00000000 ceiling bef4e000 addr 40000000 end 40200000
free_pgd_range: floor 00000000 ceiling 00000000 addr bef4e000 end bef63000
free_pud_range: floor 00000000 ceiling 00000000 addr bee00000 end bf000000
free_pmd_range: floor 00000000 ceiling 00000000 addr bee00000 end bf000000
exit_mmap: nr_ptes -1

The above is with my fix to ARMs get_pgd_slow, which shows that we
accidentally freed the first entry in the L1 page table.  With my
fix and your patch, low-vectored ARMs work again.

I don't think it'll be invasive to push my get_pgd_slow() fix before
these freepgt patches appear.  For the record, this is the patch I'm
using at present.  With a bit more effort, I could probably eliminate
pmd_alloc (and therefore the unnecessary spinlocking) here.

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/arch/arm/mm/mm-armv.c linux/arch/arm/mm/mm-armv.c
--- orig/arch/arm/mm/mm-armv.c	Sat Mar 19 11:20:01 2005
+++ linux/arch/arm/mm/mm-armv.c	Sat Mar 26 15:51:57 2005
@@ -160,6 +160,8 @@ pgd_t *get_pgd_slow(struct mm_struct *mm
 	init_pgd = pgd_offset_k(0);
 
 	if (!vectors_high()) {
+		struct page *new;
+
 		/*
 		 * This lock is here just to satisfy pmd_alloc and pte_lock
 		 */
@@ -170,12 +172,16 @@ pgd_t *get_pgd_slow(struct mm_struct *mm
 		 * contains the machine vectors.
 		 */
 		new_pmd = pmd_alloc(mm, new_pgd, 0);
+		spin_unlock(&mm->page_table_lock);
 		if (!new_pmd)
 			goto no_pmd;
 
-		new_pte = pte_alloc_map(mm, new_pmd, 0);
-		if (!new_pte)
+		new = pte_alloc_one(mm, 0);
+		if (!new)
 			goto no_pte;
+		inc_page_state(nr_page_table_pages);
+		pmd_populate(mm, new_pmd, new);
+		new_pte = pte_offset_map(new_pmd, 0);
 
 		init_pmd = pmd_offset(init_pgd, 0);
 		init_pte = pte_offset_map_nested(init_pmd, 0);
@@ -197,16 +203,9 @@ pgd_t *get_pgd_slow(struct mm_struct *mm
 	return new_pgd;
 
 no_pte:
-	spin_unlock(&mm->page_table_lock);
 	pmd_free(new_pmd);
-	free_pages((unsigned long)new_pgd, 2);
-	return NULL;
-
 no_pmd:
-	spin_unlock(&mm->page_table_lock);
 	free_pages((unsigned long)new_pgd, 2);
-	return NULL;
-
 no_pgd:
 	return NULL;
 }


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
