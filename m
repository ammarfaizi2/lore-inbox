Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVHXVSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVHXVSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVHXVSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:18:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932247AbVHXVSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:18:47 -0400
Date: Wed, 24 Aug 2005 14:18:26 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>
Subject: Re: [PATCH 1/5] Add pagetable allocation notifiers
Message-ID: <20050824211826.GO7762@shell0.pdx.osdl.net>
References: <200508241841.j7OIf6q4001874@zach-dev.vmware.com> <20050824194816.GK7762@shell0.pdx.osdl.net> <430CE30F.7050408@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430CE30F.7050408@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Chris Wright wrote:
> 
> >* Zachary Amsden (zach@vmware.com) wrote:
> > 
> >
> >>--- linux-2.6.13.orig/arch/i386/mm/init.c	2005-08-24 
> >>09:31:05.000000000 -0700
> >>+++ linux-2.6.13/arch/i386/mm/init.c	2005-08-24 09:31:31.000000000 -0700
> >>@@ -79,6 +79,7 @@ static pte_t * __init one_page_table_ini
> >>{
> >>	if (pmd_none(*pmd)) {
> >>		pte_t *page_table = (pte_t *) 
> >>		alloc_bootmem_low_pages(PAGE_SIZE);
> >>+		SetPagePTE(virt_to_page(page_table));
> >>   
> >>
> >
> >Xen has this on one_md_table_init() as well for pmd.
> 
> I'll add that in another patch.  It's easy to miss some of the init time 
> call sites (we don't actually depend on them for correctness).

You could just respin this patch.

> >>	spin_lock_irqsave(&pgd_lock, flags);
> >>	pgd_list_del(pgd);
> >>	spin_unlock_irqrestore(&pgd_lock, flags);
> >>@@ -244,13 +246,16 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> >>		pmd_t *pmd = kmem_cache_alloc(pmd_cache, GFP_KERNEL);
> >>		if (!pmd)
> >>			goto out_oom;
> >>+		SetPagePDE(virt_to_page(pmd));
> >>		set_pgd(&pgd[i], __pgd(1 + __pa(pmd)));
> >>	}
> >>	return pgd;
> >>
> >>out_oom:
> >>-	for (i--; i >= 0; i--)
> >>+	for (i--; i >= 0; i--) {
> >>+		ClearPagePDE(pfn_to_page(pgd_val(pgd[i]) >> PAGE_SHIFT));
> >>   
> >>
> >
> >Is that the right pfn?  That -1 throws me off.
> >
> > 
> >
> >>		kmem_cache_free(pmd_cache, (void *)__va(pgd_val(pgd[i])-1));
> >>+	}
> >>	kmem_cache_free(pgd_cache, pgd);
> >>	return NULL;
> >>}
> >>@@ -261,8 +266,10 @@ void pgd_free(pgd_t *pgd)
> >>
> >>	/* in the PAE case user pgd entries are overwritten before usage */
> >>	if (PTRS_PER_PMD > 1)
> >>-		for (i = 0; i < USER_PTRS_PER_PGD; ++i)
> >>-			kmem_cache_free(pmd_cache, (void 
> >>*)__va(pgd_val(pgd[i])-1));
> >>+		for (i = 0; i < USER_PTRS_PER_PGD; ++i) {
> >>+			ClearPagePDE(pfn_to_page(pgd_val(pgd[i]) >> 
> >>PAGE_SHIFT));
> >>+			kmem_cache_free(pmd_cache, (void 
> >>*)__va(pgd_val(pgd[i]) & PAGE_MASK));
> >>   
> >>
> >
> >Why the switch of kmem_cache_free call?
> 
> Because pgd_val(pgd[i])-1 is confusing.

Yes, I agree it is.  That's why I was wondering about the ClearPagePDE calls
which don't use them.

> Using (pgd_val(pgd[i]) - 
> _PAGE_PRESENT) would be better, but the +/- 1s all over the place here 
> could use some general cleanup as well.  I smell a cleanup fit coming 
> on.  Using (pgd_val(pgd[i]) & PAGE_MASK) is a less error prone way to 
> get the physical frame bits, since it is not wrong if you turn on PCD or 
> PWD.

Please save all that for later cleanup.  As it stands it's just a conversion
of one random call site, which should be dropped from the patch.

thanks,
-chris
