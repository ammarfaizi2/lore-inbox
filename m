Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUDCRDA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 12:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUDCRDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 12:03:00 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57275
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261425AbUDCRC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 12:02:57 -0500
Date: Sat, 3 Apr 2004 19:02:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040403170258.GH2307@dualathlon.random>
References: <20040402020022.GN18585@dualathlon.random> <20040402104334.A871@infradead.org> <20040402164634.GF21341@dualathlon.random> <20040402195927.A6659@infradead.org> <20040402192941.GP21341@dualathlon.random> <20040402205410.A7194@infradead.org> <20040402203514.GR21341@dualathlon.random> <20040403094058.A13091@infradead.org> <20040403152026.GE2307@dualathlon.random> <20040403155958.GF2307@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403155958.GF2307@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

can you try this potential fix too? (maybe you want to try this first
thing)

this is from Hugh's anobjramp patches.

I merged it once, then I got a crash report, so I backed it out since it
was working anyways, but it was due a merging error that it didn't work
correctly, the below version should be fine and it seems really needed.

I'll upload a new kernel with this applied.

--- x/arch/ppc/mm/pgtable.c.~1~	2004-02-20 17:26:33.000000000 +0100
+++ x/arch/ppc/mm/pgtable.c	2004-04-03 18:51:35.072468040 +0200
@@ -86,9 +86,14 @@ pte_t *pte_alloc_one_kernel(struct mm_st
 	extern int mem_init_done;
 	extern void *early_get_page(void);
 
-	if (mem_init_done)
+	if (mem_init_done) {
 		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_REPEAT);
-	else
+		if (pte) {
+			struct page *ptepage = virt_to_page(pte);
+			ptepage->mapping = (void *) mm;
+			ptepage->index = address & PMD_MASK;
+		}
+	} else
 		pte = (pte_t *)early_get_page();
 	if (pte)
 		clear_page(pte);
@@ -106,8 +111,11 @@ struct page *pte_alloc_one(struct mm_str
 #endif
 
 	pte = alloc_pages(flags, 0);
-	if (pte)
+	if (pte) {
+		pte->mapping = (void *) mm;
+		pte->index = address & PMD_MASK;
 		clear_highpage(pte);
+	}
 	return pte;
 }
 
@@ -116,6 +124,7 @@ void pte_free_kernel(pte_t *pte)
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
+	virt_to_page(pte)->mapping = NULL;
 	free_page((unsigned long)pte);
 }
 
@@ -124,6 +133,7 @@ void pte_free(struct page *pte)
 #ifdef CONFIG_SMP
 	hash_page_sync();
 #endif
+	pte->mapping = NULL;
 	__free_page(pte);
 }
 
