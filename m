Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271974AbRH2OHQ>; Wed, 29 Aug 2001 10:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271975AbRH2OHH>; Wed, 29 Aug 2001 10:07:07 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:61691 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S271974AbRH2OGv>; Wed, 29 Aug 2001 10:06:51 -0400
Date: Wed, 29 Aug 2001 15:07:11 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Christian Borntraeger <CBORNTRA@de.ibm.com>
cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: VM: Bad swap entry 0044cb00
In-Reply-To: <OFC1BB9C0E.DA740D8A-ONC1256AB7.003AF644@de.ibm.com>
Message-ID: <Pine.LNX.4.21.0108291506200.2236-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2001, Christian Borntraeger wrote:
> 00030a9c T zap_page_range
> 00030da4 t follow_page
> 
> Out of Memory: Killed process 6667 (_18411Y45_s).
> swap_free from 80030d00: Bad swap entry 0a2c2600
> Out of Memory: Killed process 7374 (_18411Y46_s).
> Out of Memory: Killed process 7401 (_18411Y85_s).
> swap_free from 80030d00: Bad swap entry 0a0b0600
> 
> I will make do a listing of the kernel (S/390-assembler) of
> zap_page_range and if possible find out the line of the C-Code.

No need to look for that line, swap_free() is indeed called from
free_pte(), nested several inlines down within zap_page_range().

That was very helpful info, thank you: it helped to concentrate me
to realize my own stupidity.  You made it perfectly clear that you
are using 2.4.7, therefore (unless you already applied it by hand)
you don't have the very relevant 2.4.8 patch to do_swap_page() by
Jeremy Linton and Linus.

If you'd prefer not to upgrade to 2.4.8 or 2.4.9 right now, please
apply patch below and test again.  It should fix some of your "Out
of Memory" kills (which may have been mistaken, see first pte_same
test below, from Jeremy), and hopefully stop your "Bad swap entry"s
(see second pte_same test below, from Linus): if not present but
not same, old code would have inserted wrong page in page table, and
swap_freed it, leading to error from the later swap_free in free_pte().

But keep yesterday's testing patch in too, in case you find
problems still (as Adrian Bunk reported on 2.4.9-ac2).

Hugh

--- linux-2.4.7/mm/memory.c	Thu Jul 12 17:05:22 2001
+++ linux/mm/memory.c	Wed Aug 29 14:19:39 2001
@@ -1091,9 +1091,10 @@
  */
 static int do_swap_page(struct mm_struct * mm,
 	struct vm_area_struct * vma, unsigned long address,
-	pte_t * page_table, swp_entry_t entry, int write_access)
+	pte_t * page_table, pte_t orig_pte, int write_access)
 {
 	struct page *page;
+	swp_entry_t entry = pte_to_swp_entry(orig_pte);
 	pte_t pte;
 
 	spin_unlock(&mm->page_table_lock);
@@ -1105,7 +1106,11 @@
 		unlock_kernel();
 		if (!page) {
 			spin_lock(&mm->page_table_lock);
-			return -1;
+			/*
+			 * Back out if somebody else faulted in this pte while
+			 * we released the page table lock.
+			 */
+			return pte_same(*page_table, orig_pte) ? -1 : 1;
 		}
 	}
 
@@ -1121,7 +1126,7 @@
 	 * released the page table lock.
 	 */
 	spin_lock(&mm->page_table_lock);
-	if (pte_present(*page_table)) {
+	if (!pte_same(*page_table, orig_pte)) {
 		UnlockPage(page);
 		page_cache_release(page);
 		return 1;
@@ -1284,7 +1289,7 @@
 		 */
 		if (pte_none(entry))
 			return do_no_page(mm, vma, address, write_access, pte);
-		return do_swap_page(mm, vma, address, pte, pte_to_swp_entry(entry), write_access);
+		return do_swap_page(mm, vma, address, pte, entry, write_access);
 	}
 
 	if (write_access) {

