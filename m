Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbVCJBZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbVCJBZQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVCJBXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:23:16 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:5583
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262526AbVCJBDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 20:03:19 -0500
Date: Wed, 9 Mar 2005 17:02:24 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: hugh@veritas.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: [PATCH 0/15] ptwalk: pagetable walker cleanup
Message-Id: <20050309170224.3f368c98.davem@davemloft.net>
In-Reply-To: <1110415184.32524.128.camel@gaston>
References: <Pine.LNX.4.61.0503092201070.6070@goblin.wat.veritas.com>
	<1110415184.32524.128.camel@gaston>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005 11:39:44 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> There are some other bugs introduced by set_pte_at() caused by latent
> bugs in the PTE walkers that 'drop' part of the address along the way,
> notably the vmalloc.c ones are bogus, thus breaking ppc/ppc64 in subtle
> ways. Before I send patches, I'd rather check if it's not all fixed by
> your patches first :)

Ben, I fixed vmalloc and the other cases when I pushed the set_pte_at()
changes to Linus.  Here is the changeset that fixes them, and it's certainly
in Linus's tree:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/26 20:51:23-08:00 davem@nuts.davemloft.net 
#   [MM]: Pass correct address down to bottom of page table iterators.
#   
#   Some routines, namely zeromap_pte_range, remap_pte_range,
#   change_pte_range, unmap_area_pte, and map_area_pte, were
#   using a chopped off address.  This causes bogus addresses
#   to be passed into set_pte_at() and friends, resulting
#   in missed TLB flushes and other nasties.
#   
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# mm/vmalloc.c
#   2005/02/26 20:50:16-08:00 davem@nuts.davemloft.net +13 -9
#   [MM]: Pass correct address down to bottom of page table iterators.
# 
# mm/mprotect.c
#   2005/02/26 20:50:16-08:00 davem@nuts.davemloft.net +10 -7
#   [MM]: Pass correct address down to bottom of page table iterators.
# 
# mm/memory.c
#   2005/02/26 20:50:16-08:00 davem@nuts.davemloft.net +7 -5
#   [MM]: Pass correct address down to bottom of page table iterators.
# 
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	2005-03-09 17:09:47 -08:00
+++ b/mm/memory.c	2005-03-09 17:09:47 -08:00
@@ -992,16 +992,17 @@
 			      unsigned long address,
 			      unsigned long size, pgprot_t prot)
 {
-	unsigned long end;
+	unsigned long base, end;
 
+	base = address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
 		end = PMD_SIZE;
 	do {
-		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(address), prot));
+		pte_t zero_pte = pte_wrprotect(mk_pte(ZERO_PAGE(base+address), prot));
 		BUG_ON(!pte_none(*pte));
-		set_pte_at(mm, address, pte, zero_pte);
+		set_pte_at(mm, base+address, pte, zero_pte);
 		address += PAGE_SIZE;
 		pte++;
 	} while (address && (address < end));
@@ -1106,8 +1107,9 @@
 		unsigned long address, unsigned long size,
 		unsigned long pfn, pgprot_t prot)
 {
-	unsigned long end;
+	unsigned long base, end;
 
+	base = address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -1115,7 +1117,7 @@
 	do {
 		BUG_ON(!pte_none(*pte));
 		if (!pfn_valid(pfn) || PageReserved(pfn_to_page(pfn)))
-			set_pte_at(mm, address, pte, pfn_pte(pfn, prot));
+			set_pte_at(mm, base+address, pte, pfn_pte(pfn, prot));
 		address += PAGE_SIZE;
 		pfn++;
 		pte++;
diff -Nru a/mm/mprotect.c b/mm/mprotect.c
--- a/mm/mprotect.c	2005-03-09 17:09:47 -08:00
+++ b/mm/mprotect.c	2005-03-09 17:09:47 -08:00
@@ -30,7 +30,7 @@
 		unsigned long size, pgprot_t newprot)
 {
 	pte_t * pte;
-	unsigned long end;
+	unsigned long base, end;
 
 	if (pmd_none(*pmd))
 		return;
@@ -40,6 +40,7 @@
 		return;
 	}
 	pte = pte_offset_map(pmd, address);
+	base = address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -52,8 +53,8 @@
 			 * bits by wiping the pte and then setting the new pte
 			 * into place.
 			 */
-			entry = ptep_get_and_clear(mm, address, pte);
-			set_pte_at(mm, address, pte, pte_modify(entry, newprot));
+			entry = ptep_get_and_clear(mm, base + address, pte);
+			set_pte_at(mm, base + address, pte, pte_modify(entry, newprot));
 		}
 		address += PAGE_SIZE;
 		pte++;
@@ -66,7 +67,7 @@
 		 unsigned long size, pgprot_t newprot)
 {
 	pmd_t * pmd;
-	unsigned long end;
+	unsigned long base, end;
 
 	if (pud_none(*pud))
 		return;
@@ -76,12 +77,13 @@
 		return;
 	}
 	pmd = pmd_offset(pud, address);
+	base = address & PUD_MASK;
 	address &= ~PUD_MASK;
 	end = address + size;
 	if (end > PUD_SIZE)
 		end = PUD_SIZE;
 	do {
-		change_pte_range(mm, pmd, address, end - address, newprot);
+		change_pte_range(mm, pmd, base + address, end - address, newprot);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address && (address < end));
@@ -92,7 +94,7 @@
 		 unsigned long size, pgprot_t newprot)
 {
 	pud_t * pud;
-	unsigned long end;
+	unsigned long base, end;
 
 	if (pgd_none(*pgd))
 		return;
@@ -102,12 +104,13 @@
 		return;
 	}
 	pud = pud_offset(pgd, address);
+	base = address & PGDIR_MASK;
 	address &= ~PGDIR_MASK;
 	end = address + size;
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 	do {
-		change_pmd_range(mm, pud, address, end - address, newprot);
+		change_pmd_range(mm, pud, base + address, end - address, newprot);
 		address = (address + PUD_SIZE) & PUD_MASK;
 		pud++;
 	} while (address && (address < end));
diff -Nru a/mm/vmalloc.c b/mm/vmalloc.c
--- a/mm/vmalloc.c	2005-03-09 17:09:47 -08:00
+++ b/mm/vmalloc.c	2005-03-09 17:09:47 -08:00
@@ -26,7 +26,7 @@
 static void unmap_area_pte(pmd_t *pmd, unsigned long address,
 				  unsigned long size)
 {
-	unsigned long end;
+	unsigned long base, end;
 	pte_t *pte;
 
 	if (pmd_none(*pmd))
@@ -38,6 +38,7 @@
 	}
 
 	pte = pte_offset_kernel(pmd, address);
+	base = address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -45,7 +46,7 @@
 
 	do {
 		pte_t page;
-		page = ptep_get_and_clear(&init_mm, address, pte);
+		page = ptep_get_and_clear(&init_mm, base + address, pte);
 		address += PAGE_SIZE;
 		pte++;
 		if (pte_none(page))
@@ -59,7 +60,7 @@
 static void unmap_area_pmd(pud_t *pud, unsigned long address,
 				  unsigned long size)
 {
-	unsigned long end;
+	unsigned long base, end;
 	pmd_t *pmd;
 
 	if (pud_none(*pud))
@@ -71,13 +72,14 @@
 	}
 
 	pmd = pmd_offset(pud, address);
+	base = address & PUD_MASK;
 	address &= ~PUD_MASK;
 	end = address + size;
 	if (end > PUD_SIZE)
 		end = PUD_SIZE;
 
 	do {
-		unmap_area_pte(pmd, address, end - address);
+		unmap_area_pte(pmd, base + address, end - address);
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;
 	} while (address < end);
@@ -87,7 +89,7 @@
 			   unsigned long size)
 {
 	pud_t *pud;
-	unsigned long end;
+	unsigned long base, end;
 
 	if (pgd_none(*pgd))
 		return;
@@ -98,13 +100,14 @@
 	}
 
 	pud = pud_offset(pgd, address);
+	base = address & PGDIR_MASK;
 	address &= ~PGDIR_MASK;
 	end = address + size;
 	if (end > PGDIR_SIZE)
 		end = PGDIR_SIZE;
 
 	do {
-		unmap_area_pmd(pud, address, end - address);
+		unmap_area_pmd(pud, base + address, end - address);
 		address = (address + PUD_SIZE) & PUD_MASK;
 		pud++;
 	} while (address && (address < end));
@@ -114,8 +117,9 @@
 			       unsigned long size, pgprot_t prot,
 			       struct page ***pages)
 {
-	unsigned long end;
+	unsigned long base, end;
 
+	base = address & PMD_MASK;
 	address &= ~PMD_MASK;
 	end = address + size;
 	if (end > PMD_SIZE)
@@ -127,7 +131,7 @@
 		if (!page)
 			return -ENOMEM;
 
-		set_pte_at(&init_mm, address, pte, mk_pte(page, prot));
+		set_pte_at(&init_mm, base + address, pte, mk_pte(page, prot));
 		address += PAGE_SIZE;
 		pte++;
 		(*pages)++;
@@ -151,7 +155,7 @@
 		pte_t * pte = pte_alloc_kernel(&init_mm, pmd, base + address);
 		if (!pte)
 			return -ENOMEM;
-		if (map_area_pte(pte, address, end - address, prot, pages))
+		if (map_area_pte(pte, base + address, end - address, prot, pages))
 			return -ENOMEM;
 		address = (address + PMD_SIZE) & PMD_MASK;
 		pmd++;

