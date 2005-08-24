Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVHXVsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVHXVsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVHXVsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:48:22 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:10503 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932296AbVHXVsV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:48:21 -0400
Message-ID: <430CEB0F.9000004@vmware.com>
Date: Wed, 24 Aug 2005 14:47:59 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>
Subject: Re: [PATCH 1/5] Add pagetable allocation notifiers
References: <200508241841.j7OIf6q4001874@zach-dev.vmware.com> <20050824194816.GK7762@shell0.pdx.osdl.net>
In-Reply-To: <20050824194816.GK7762@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Aug 2005 21:48:18.0819 (UTC) FILETIME=[8A26F530:01C5A8F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>* Zachary Amsden (zach@vmware.com) wrote:
>  
>
>>--- linux-2.6.13.orig/arch/i386/mm/init.c	2005-08-24 09:31:05.000000000 -0700
>>+++ linux-2.6.13/arch/i386/mm/init.c	2005-08-24 09:31:31.000000000 -0700
>>@@ -79,6 +79,7 @@ static pte_t * __init one_page_table_ini
>> {
>> 	if (pmd_none(*pmd)) {
>> 		pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
>>+		SetPagePTE(virt_to_page(page_table));
>>    
>>
>
>Xen has this on one_md_table_init() as well for pmd.
>
>  
>
>> 		set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
>> 		if (page_table != pte_offset_kernel(pmd, 0))
>> 			BUG();	
>>Index: linux-2.6.13/arch/i386/mm/pageattr.c
>>===================================================================
>>--- linux-2.6.13.orig/arch/i386/mm/pageattr.c	2005-08-24 09:31:05.000000000 -0700
>>+++ linux-2.6.13/arch/i386/mm/pageattr.c	2005-08-24 09:31:31.000000000 -0700
>>@@ -52,8 +52,9 @@ static struct page *split_large_page(uns
>> 	address = __pa(address);
>> 	addr = address & LARGE_PAGE_MASK; 
>> 	pbase = (pte_t *)page_address(base);
>>+	SetPagePTE(virt_to_page(pbase));
>> 	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
>>-               set_pte(&pbase[i], pfn_pte(addr >> PAGE_SHIFT,
>>+		set_pte(&pbase[i], pfn_pte(addr >> PAGE_SHIFT,
>>    
>>
>
>No need to intersperse whitespace cleanups.
>
>  
>
>>                                           addr == address ? prot : PAGE_KERNEL));
>> 	}
>> 	return base;
>>@@ -146,6 +147,7 @@ __change_page_attr(struct page *page, pg
>> 		BUG_ON(!page_count(kpte_page));
>> 
>> 		if (cpu_has_pse && (page_count(kpte_page) == 1)) {
>>+			ClearPagePTE(virt_to_page(kpte));
>> 			list_add(&kpte_page->lru, &df_list);
>> 			revert_page(kpte_page, address);
>> 		}
>>Index: linux-2.6.13/arch/i386/mm/pgtable.c
>>===================================================================
>>--- linux-2.6.13.orig/arch/i386/mm/pgtable.c	2005-08-24 09:31:05.000000000 -0700
>>+++ linux-2.6.13/arch/i386/mm/pgtable.c	2005-08-24 09:40:22.000000000 -0700
>>@@ -209,6 +209,7 @@ void pgd_ctor(void *pgd, kmem_cache_t *c
>> 
>> 	if (PTRS_PER_PMD == 1) {
>> 		memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
>>+		SetPagePDE(virt_to_page(pgd));
>> 		spin_lock_irqsave(&pgd_lock, flags);
>> 	}
>> 
>>@@ -227,6 +228,7 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
>> {
>> 	unsigned long flags; /* can be called from interrupt context */
>> 
>>+	ClearPagePDE(virt_to_page(pgd));
>>    
>>
>
>This reminds me, Xen had some unconditional use of pgd_dtor I need
>to go back and look at.
>  
>

It looks quite unneeded:

void pgd_dtor(void *pgd, kmem_cache_t *cache, unsigned long unused)
{
        unsigned long flags; /* can be called from interrupt context */

        if (HAVE_SHARED_KERNEL_PMD)  <--- /* PAE */
                return;

        spin_lock_irqsave(&pgd_lock, flags);
        pgd_list_del(pgd);
        spin_unlock_irqrestore(&pgd_lock, flags);
}

Leaving the dtor conditional saves an indirect function call ;)

Zach
