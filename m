Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbUKBTCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbUKBTCE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbUKBTCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:02:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57807 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261332AbUKBTBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:01:44 -0500
Date: Tue, 2 Nov 2004 14:02:18 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: "John W. Linville" <linville@tuxdriver.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 expertise needed re: BUG() at pageattr:107
In-Reply-To: <20041101155921.C30292@tuxdriver.com>
Message-ID: <Pine.LNX.4.44.0411021353400.8117-100000@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 1 Nov 2004, John W. Linville wrote:

> The x86_64 version of pageattr.c contains the following definition
> of revert_page():
> 
> static void revert_page(unsigned long address, pgprot_t ref_prot)
> {
>        pgd_t *pgd;
>        pmd_t *pmd;
>        pte_t large_pte;
> 
>        pgd = pgd_offset_k(address);
>        pmd = pmd_offset(pgd, address);
>        BUG_ON(pmd_val(*pmd) & _PAGE_PSE);
>        pgprot_val(ref_prot) |= _PAGE_PSE;
>        large_pte = mk_pte_phys(__pa(address) & LARGE_PAGE_MASK, ref_prot);
>        set_pte((pte_t *)pmd, large_pte);
> }
> 
> Please notice the BUG_ON() (originally at line pageattr.c:107).
> I notice that the x86 version of revert_page() has no similar check.
> 
> Would someone please explain:
> 
> 	a) why is this a bug?;

In this code path, a pmd is 'reverted' to point to a 2MB/4MB span of 
physical memory. This memory had previously been split from a 2MB/4MB 
span into 4KB segments, adding a pte table in the process, by calling 
change_page_attr. Thus, when it is reverted back it should not be pointing 
to the 2MB/4MB sapn. 


> 	b) what is likely to have triggered it?; and,

not sure, but i think when the page splits the count should be increased 
in the pte page, not the pmd page. as follows:

--- linux/arch/i386/mm/pageattr.c.orig	Tue Nov  2 13:48:39 2004
+++ linux/arch/i386/mm/pageattr.c	Tue Nov  2 13:49:02 2004
@@ -126,7 +126,7 @@ __change_page_attr(struct page *page, pg
 			struct page *split = split_large_page(address, prot); 
 			if (!split)
 				return -ENOMEM;
-			get_page(kpte_page);
+			get_page(split);
 			set_pmd_pte(kpte,address,mk_pte(split, PAGE_KERNEL));
 		}	
 	} else if ((pte_val(*kpte) & _PAGE_PSE) == 0) { 
--- 2.6-10-28-04/arch/x86_64/mm/pageattr.c.orig	Tue Nov  2 13:41:34 2004
+++ 2.6-10-28-04/arch/x86_64/mm/pageattr.c	Tue Nov  2 13:48:28 2004
@@ -134,7 +134,7 @@ __change_page_attr(unsigned long address
 			struct page *split = split_large_page(address, prot, ref_prot); 
 			if (!split)
 				return -ENOMEM;
-			get_page(kpte_page);
+			get_page(split);
 			set_pte(kpte,mk_pte(split, ref_prot));
 		}	
 	} else if ((kpte_flags & _PAGE_PSE) == 0) { 


> 	c) why is x86_64 different from x86?

This should be a BUG condition on x86 as well.

-Jason

