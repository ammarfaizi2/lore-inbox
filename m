Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751918AbWCNVcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbWCNVcd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWCNVcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:32:32 -0500
Received: from ns.protei.ru ([195.239.28.26]:20746 "EHLO mail.protei.ru")
	by vger.kernel.org with ESMTP id S1751918AbWCNVcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:32:31 -0500
Message-ID: <4417364C.6020609@protei.ru>
Date: Wed, 15 Mar 2006 00:31:56 +0300
From: Nickolay <nickolay@protei.ru>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: uncachable access to physical pages(ARM, xScale)
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guys!

I want to change pgprot(unset L_PTE_CACHEABLE and L_PTE_BUFFERABLE) for
several pages, allocated by alloc_pages, in kernel VM, because this memory
used for sharing data between kernelspace and userland(via .mmap).
For userland VM, i done that successul next way:
vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
remap_pfn_range(...);

but for kernelspace VM i has some trouble.

I was trying directly unset L_PTE_CACHEABLE | L_PTE_BUFFERABLE flags from
pte(see below), but it doesn't working, and i has problem with cache 
cogerency
between userland and kernelspace:

pgd_t *pgd;
pmd_t *pmd;
pte_t *pte;

/* find pte */
addr = page_address(my_page);
pgd = pgd_offset_k(addr & PAGE_MASK);
pmd = pmd_offset(pgd, addr & PAGE_MASK);
pte = pte_offset_kernel(pmd, addr & PAGE_MASK);

/* ok, we get pte, now unset L_PTE_CACHEABLE and
    L_PTE_BUFFERABLE flags
*/
pte_val(*pte) &= ~(L_PTE_CACHEABLE|L_PTE_BUFFERABLE);

The problem descriprion simple, kernel at some time doesn't see
data, which userland writes to shared buffer, without inserting
flush_cache_all after each operation with shared buffer from kernel.

thanks,

Nickolay.
