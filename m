Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVAHQBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVAHQBk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 11:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVAHQBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 11:01:40 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31877 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261199AbVAHQBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 11:01:19 -0500
Date: Sat, 8 Jan 2005 16:00:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Martin Josefsson <gandalf@wlug.westbo.se>
cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Swapoff inifinite loops on 2.6.10-bk (was: .6.10-bk8 swapoff
    after resume)
In-Reply-To: <1105080812.1087.37.camel@tux.rsn.bth.se>
Message-ID: <Pine.LNX.4.44.0501081547260.2688-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2005, Martin Josefsson wrote:
> 
> No suspend or resume involved, just a normal boot.
> 
> Steps to reproduce:
> 
> 1. fill memory so it swaps
> 2. stop memory hog
> 3. swapoff -a
> 
> I'm pretty sure it's an infinite loop, I left it like that while
> shaving. It produces the same sound over and over again as the head
> seeks back in order to try again and again...

You're right, and yes, I could then reproduce it.  Looks like I'd only
been testing on 3levels (HIGHMEM64G), and this only happens on 2levels.

Patch below, please verify it fixes your problems.  And please, could
someone else check I haven't screwed up swapoff on 4levels (x86_64)?
>From the likeness of the code at all levels I'd expect it to be fine,
but there's nothing like a real test - thanks...

The 4level mods have caused 2level swapoff to miss entries and hang.
There's probably a one-line fix for that, but the error is really caused
by previous awkwardness - each mask applied on two levels, an "address"
that's an offset plus an "offset" that's an address.  Simplify the four
levels to behave in the same address/next/end way and the bug vanishes.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.10-bk11/mm/swapfile.c	2005-01-07 16:15:12.000000000 +0000
+++ linux/mm/swapfile.c	2005-01-07 20:58:38.933209800 +0000
@@ -442,12 +442,11 @@ unuse_pte(struct vm_area_struct *vma, un
 }
 
 /* vma->vm_mm->page_table_lock is held */
-static unsigned long unuse_pmd(struct vm_area_struct * vma, pmd_t *dir,
-	unsigned long address, unsigned long size, unsigned long offset,
+static unsigned long unuse_pmd(struct vm_area_struct *vma, pmd_t *dir,
+	unsigned long address, unsigned long end,
 	swp_entry_t entry, struct page *page)
 {
-	pte_t * pte;
-	unsigned long end;
+	pte_t *pte;
 	pte_t swp_pte = swp_entry_to_pte(entry);
 
 	if (pmd_none(*dir))
@@ -458,18 +457,13 @@ static unsigned long unuse_pmd(struct vm
 		return 0;
 	}
 	pte = pte_offset_map(dir, address);
-	offset += address & PMD_MASK;
-	address &= ~PMD_MASK;
-	end = address + size;
-	if (end > PMD_SIZE)
-		end = PMD_SIZE;
 	do {
 		/*
 		 * swapoff spends a _lot_ of time in this loop!
 		 * Test inline before going to call unuse_pte.
 		 */
 		if (unlikely(pte_same(*pte, swp_pte))) {
-			unuse_pte(vma, offset + address, pte, entry, page);
+			unuse_pte(vma, address, pte, entry, page);
 			pte_unmap(pte);
 
 			/*
@@ -479,22 +473,22 @@ static unsigned long unuse_pmd(struct vm
 			activate_page(page);
 
 			/* add 1 since address may be 0 */
-			return 1 + offset + address;
+			return 1 + address;
 		}
 		address += PAGE_SIZE;
 		pte++;
-	} while (address && (address < end));
+	} while (address < end);
 	pte_unmap(pte - 1);
 	return 0;
 }
 
 /* vma->vm_mm->page_table_lock is held */
-static unsigned long unuse_pud(struct vm_area_struct * vma, pud_t *pud,
-        unsigned long address, unsigned long size, unsigned long offset,
+static unsigned long unuse_pud(struct vm_area_struct *vma, pud_t *pud,
+        unsigned long address, unsigned long end,
 	swp_entry_t entry, struct page *page)
 {
-	pmd_t * pmd;
-	unsigned long end;
+	pmd_t *pmd;
+	unsigned long next;
 	unsigned long foundaddr;
 
 	if (pud_none(*pud))
@@ -505,33 +499,27 @@ static unsigned long unuse_pud(struct vm
 		return 0;
 	}
 	pmd = pmd_offset(pud, address);
-	offset += address & PUD_MASK;
-	address &= ~PUD_MASK;
-	end = address + size;
-	if (end > PUD_SIZE)
-		end = PUD_SIZE;
-	if (address >= end)
-		BUG();
 	do {
-		foundaddr = unuse_pmd(vma, pmd, address, end - address,
-						offset, entry, page);
+		next = (address + PMD_SIZE) & PMD_MASK;
+		if (next > end || !next)
+			next = end;
+		foundaddr = unuse_pmd(vma, pmd, address, next, entry, page);
 		if (foundaddr)
 			return foundaddr;
-		address = (address + PMD_SIZE) & PMD_MASK;
+		address = next;
 		pmd++;
-	} while (address && (address < end));
+	} while (address < end);
 	return 0;
 }
 
 /* vma->vm_mm->page_table_lock is held */
-static unsigned long unuse_pgd(struct vm_area_struct * vma, pgd_t *pgd,
-	unsigned long address, unsigned long size,
+static unsigned long unuse_pgd(struct vm_area_struct *vma, pgd_t *pgd,
+	unsigned long address, unsigned long end,
 	swp_entry_t entry, struct page *page)
 {
-	pud_t * pud;
-	unsigned long offset;
+	pud_t *pud;
+	unsigned long next;
 	unsigned long foundaddr;
-	unsigned long end;
 
 	if (pgd_none(*pgd))
 		return 0;
@@ -541,54 +529,48 @@ static unsigned long unuse_pgd(struct vm
 		return 0;
 	}
 	pud = pud_offset(pgd, address);
-	offset = address & PGDIR_MASK;
-	address &= ~PGDIR_MASK;
-	end = address + size;
-	if (end > PGDIR_SIZE)
-		end = PGDIR_SIZE;
-	BUG_ON (address >= end);
 	do {
-		foundaddr = unuse_pud(vma, pud, address, end - address,
-					        offset, entry, page);
+		next = (address + PUD_SIZE) & PUD_MASK;
+		if (next > end || !next)
+			next = end;
+		foundaddr = unuse_pud(vma, pud, address, next, entry, page);
 		if (foundaddr)
 			return foundaddr;
-		address = (address + PUD_SIZE) & PUD_MASK;
+		address = next;
 		pud++;
-	} while (address && (address < end));
+	} while (address < end);
 	return 0;
 }
 
 /* vma->vm_mm->page_table_lock is held */
-static unsigned long unuse_vma(struct vm_area_struct * vma,
+static unsigned long unuse_vma(struct vm_area_struct *vma,
 	swp_entry_t entry, struct page *page)
 {
 	pgd_t *pgd;
-	unsigned long start, end, next;
+	unsigned long address, next, end;
 	unsigned long foundaddr;
-	int i;
 
 	if (page->mapping) {
-		start = page_address_in_vma(page, vma);
-		if (start == -EFAULT)
+		address = page_address_in_vma(page, vma);
+		if (address == -EFAULT)
 			return 0;
 		else
-			end = start + PAGE_SIZE;
+			end = address + PAGE_SIZE;
 	} else {
-		start = vma->vm_start;
+		address = vma->vm_start;
 		end = vma->vm_end;
 	}
-	pgd = pgd_offset(vma->vm_mm, start);
-	for (i = pgd_index(start); i <= pgd_index(end-1); i++) {
-		next = (start + PGDIR_SIZE) & PGDIR_MASK;
-		if (next > end || next <= start)
+	pgd = pgd_offset(vma->vm_mm, address);
+	do {
+		next = (address + PGDIR_SIZE) & PGDIR_MASK;
+		if (next > end || !next)
 			next = end;
-		foundaddr = unuse_pgd(vma, pgd, start, next - start, entry, page);
+		foundaddr = unuse_pgd(vma, pgd, address, next, entry, page);
 		if (foundaddr)
 			return foundaddr;
-		start = next;
-		i++;
+		address = next;
 		pgd++;
-	}
+	} while (address < end);
 	return 0;
 }
 

