Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbTIGVvW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTIGVvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:51:22 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:17670 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261609AbTIGVvR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:51:17 -0400
Date: Sun, 7 Sep 2003 22:51:16 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: load_LDT_nolock jumped up in the profiles in test4-mm6
Message-ID: <20030907215116.GA20847@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19w7RE-0008b4-80*dfjaT/B/OAM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running wine under test4-mm6. A new entry has appeared on oprofile's
vmlinux output :

 c01133e0 183433    1.1259     13868     1.8282     load_LDT_nolock

(that's 1.12% of CPU time and 1.8% icache misses). It didn't even register a
sample in Linus' kernel.

Annotation :

    278                                :void load_LDT_nolock(mm_context_t *pc, int cpu)
    279  12064  0.0523  3304  0.3166   :{ /* load_LDT_nolock total: 245997  1.0662 18382  1.7615 */
    280    629  0.0027   222  0.0213   :        struct page **pages = pc->ldt_pages;
    281   1108  0.0048   327  0.0313   :        int count = pc->size;
    282                                :        int nr_pages, i;
    283                                :
    284    646  0.0028   203  0.0195   :        if (likely(!count)) {
    285     45 2.0e-04     8 7.7e-04   :                pages = &default_ldt_page;
    286    622  0.0027   175  0.0168   :                count = 5;
    287                                :        }
    288   1344  0.0058   475  0.0455   :        nr_pages = (count*LDT_ENTRY_SIZE + PAGE_SIZE-1) / PAGE_SIZE;
    289                                :
    290  69520  0.3013  4288  0.4109   :        for (i = 0; i < nr_pages; i++) {
    291                                :                __kunmap_atomic_type(KM_LDT_PAGE0 - i);
    292                                :                __kmap_atomic(pages[i], KM_LDT_PAGE0 - i);
    293                                :        }
    294                                :        set_ldt_desc(cpu, (void *)__kmap_atomic_vaddr(KM_LDT_PAGE0), count);
    295      1 4.3e-06     0 0.0e+00   :        load_LDT_desc();
    296  43320  0.1878  1041  0.0998   :}


and for the __kmap_atomic :

     61                                :        /*
     62                                :         * Performance optimization - do not flush if the new
     63                                :         * pte is the same as the old one:
     64                                :         */
     65  69716  0.3022  2601  0.2492   :        if (pte_val(*(kmap_pte-idx)) == pte_val(mk_pte(page, kmap_prot)))
     66                                :                return (void *) vaddr;
     67                                :#endif
     68    309  0.0013    29  0.0028   :        set_pte(kmap_pte-idx, mk_pte(page, kmap_prot));
     69   1568  0.0068    59  0.0057   :        __flush_tlb_one(vaddr);
     70                                :

Obviously, I do not have any of the high mem options on at all.

Is there a fix for the overhead ?

regards
john
