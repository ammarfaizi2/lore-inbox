Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129061AbQKOQRz>; Wed, 15 Nov 2000 11:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKOQRp>; Wed, 15 Nov 2000 11:17:45 -0500
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:38349 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S129061AbQKOQRa> convert rfc822-to-8bit; Wed, 15 Nov 2000 11:17:30 -0500
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
Message-ID: <C1256998.0056B37F.00@d12mta07.de.ibm.com>
Date: Wed, 15 Nov 2000 16:46:49 +0100
Subject: establish_pte and ipte
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



After the rework of the page management in 2.4.0-test10 I tried again if we
could make use of the "invalidate page table entry" (ipte) in the s390
backend. Thanks to the great work of you guys we are almost there. To be
able to do that we would like to make the establish_pte an architecture
dependent function. This way s390 could implement it in its own special way
(note: no flush_tlb_page because ipte already does it) :

static inline void ptep_invalidate_and_flush(pte_t *ptep, unsigned long
addr)
{
        if (pte_val(*ptep) & _PAGE_INVALID)
                return;
        __asm__ __volatile__ ("ipte %0,%1" : : "a" (ptep), "a" (addr) );
        pte_clear(ptep);
}

static inline void establish_pte(struct vm_area_struct * vma,
                                 unsigned long address,
                                 pte_t *page_table, pte_t entry)
{
        /* Note that there is a race condition if the new PTE is
         * also valid: Another CPU might try to access the page in
         * between the IPTE (setting the PTE invalid) and the store
         * (setting the PTE valid again).
         *
         * This doesn't matter, however, as the caller must hold
         * the mm semaphore; thus, if another CPU does if fact get
         * a page fault, the handler will spin until we have the
         * the PTE consistent again;  then, the page access will
         * simply be retried.
         */
        ptep_invalidate_and_flush(page_table, address);
        set_pte(page_table, entry);
}

Besides moving establish_pte we only need one more fix:

--- vmscan.c    2000/11/02 10:14:52     1.19
+++ vmscan.c    2000/11/13 18:41:25     1.20
@@ -195,8 +195,7 @@

        /* Put the swap entry into the pte after the page is in swapcache
*/
        mm->rss--;
-       set_pte(page_table, swp_entry_to_pte(entry));
-       flush_tlb_page(vma, address);
+       establish_pte(vma, address, page_table, swp_entry_to_pte(entry));
        spin_unlock(&mm->page_table_lock);

        /* OK, do a physical asynchronous write to swap.  */


In addition we are trying to get rid of flush_tlb_page at all. I did a
little experiment and made flush_tlb_page a nop and checked if all users of
flush_tlb_page do the flush with a prior mm operation. At the moment all
users do so on s390. Therefore s390 could define flush_tlb_page as a nop,
but that would be an ugly hack. As soon as some new use of flush_tlb_page
is invented the s390 backend might break. A far better solution would be to
integrate the flush operation into the prior mm operation (again this would
move code from the common code to the arch folders). An example from
filemap_sync_pte:

                if (!ptep_test_and_clear_dirty(ptep))
                        goto out;
                flush_page_to_ram(pte_page(pte));
                flush_cache_page(vma, address);
                flush_tlb_page(vma, address);

The flush_tlb_page is only used to make it known on all processors that the
dirty bit has been cleared. On s390 we will use the "set storage key
extended" (sske) instruction for ptep_test_and_clear_dirty which does
everything necessary. We do not need a flush_tlb_page on s390 in this case.
Therefore I would like to suggest that ptep_test_and_clear_dirty should do
the flushing. Same thing for ptep_get_and_clear.

Comments ?

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
