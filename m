Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136308AbREGRNr>; Mon, 7 May 2001 13:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136314AbREGRNi>; Mon, 7 May 2001 13:13:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:18952 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136308AbREGRNU>; Mon, 7 May 2001 13:13:20 -0400
Date: Mon, 7 May 2001 10:12:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
In-Reply-To: <E14wmbg-0003b3-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105071003330.12733-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 May 2001, Alan Cox wrote:
> 
> That is nice. I hadn't thought about doing it that way. It still has the problem
> if %cr2 is corrupted by a vmalloc fault but it cleans up my other code paths
> nicely.

See about "corruption" in previous email. It doesn't exist.

For better debugging, we should probably walk the whole init_mm page table
tree when we take the fault, so this patch does that too: it
unconditionally copies the init_mm page table entries into the current
page table, while at the same time checking that they exist (including the
very last level that we didn't use to check at all).

This means that if you access one page past a vmalloc'ed area, you will
get a nice oops instead of endless page faults that will fix up the page
tables with mappings that already exist.

Untested.

In particular, does anybody have a buggy Pentium to test with the F0 0F
lock-up bug? It _should_ be caught with the error-code test (it's a
protection fault, not a non-present fault and thus the F0 0F case never
enters the vmalloc path), but it's been several years since the thing..

If anybody has such a beast, please try this kernel patch _and_ running
the F0 0F bug-producing program (search for it on the 'net - it must be
out there somewhere) to verify that the code still correctly handles that
case.

		Linus

-----
--- v2.4.4/linux/arch/i386/mm/fault.c	Mon Mar 19 12:35:09 2001
+++ linux/arch/i386/mm/fault.c	Mon May  7 10:01:37 2001
@@ -127,8 +127,12 @@
 	 * be in an interrupt or a critical region, and should
 	 * only copy the information from the master page table,
 	 * nothing more.
+	 *
+	 * This verifies that the fault happens in kernel space
+	 * (error_code & 4) == 0, and that the fault was not a
+	 * protection error (error_code & 1) == 0.
 	 */
-	if (address >= TASK_SIZE)
+	if (address >= TASK_SIZE && !(error_code & 5))
 		goto vmalloc_fault;
 
 	mm = tsk->mm;
@@ -224,7 +228,6 @@
 bad_area:
 	up_read(&mm->mmap_sem);
 
-bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & 4) {
 		tsk->thread.cr2 = address;
@@ -322,27 +325,32 @@
 		/*
 		 * Synchronize this task's top level page-table
 		 * with the 'reference' page table.
+		 *
+		 * Do _not_ use "tsk" here. We might be inside
+		 * an interrupt in the middle of a task switch..
 		 */
 		int offset = __pgd_offset(address);
 		pgd_t *pgd, *pgd_k;
 		pmd_t *pmd, *pmd_k;
+		pte_t *pte_k;
 
-		pgd = tsk->active_mm->pgd + offset;
+		asm("movl %%cr3,%0":"=r" (pgd));
+		pgd = offset + (pgd_t *)__va(pgd);
 		pgd_k = init_mm.pgd + offset;
 
-		if (!pgd_present(*pgd)) {
-			if (!pgd_present(*pgd_k))
-				goto bad_area_nosemaphore;
-			set_pgd(pgd, *pgd_k);
-			return;
-		}
-
+		if (!pgd_present(*pgd_k))
+			goto no_context;
+		set_pgd(pgd, *pgd_k);
+		
 		pmd = pmd_offset(pgd, address);
 		pmd_k = pmd_offset(pgd_k, address);
-
-		if (pmd_present(*pmd) || !pmd_present(*pmd_k))
-			goto bad_area_nosemaphore;
+		if (!pmd_present(*pmd_k))
+			goto no_context;
 		set_pmd(pmd, *pmd_k);
+
+		pte_k = pte_offset(pmd_k, address);
+		if (!pte_present(*pte_k))
+			goto no_context;
 		return;
 	}
 }

