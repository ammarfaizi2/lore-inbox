Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWCNWKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWCNWKc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWCNWKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:10:31 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3852 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964790AbWCNWKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:10:30 -0500
Date: Tue, 14 Mar 2006 22:10:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nickolay <nickolay@protei.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uncachable access to physical pages(ARM, xScale)
Message-ID: <20060314221020.GA3166@flint.arm.linux.org.uk>
Mail-Followup-To: Nickolay <nickolay@protei.ru>,
	linux-kernel@vger.kernel.org
References: <4417364C.6020609@protei.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4417364C.6020609@protei.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 12:31:56AM +0300, Nickolay wrote:
> I was trying directly unset L_PTE_CACHEABLE | L_PTE_BUFFERABLE flags from
> pte(see below), but it doesn't working, and i has problem with cache 
> cogerency between userland and kernelspace:
> 
> pgd_t *pgd;
> pmd_t *pmd;
> pte_t *pte;
> 
> /* find pte */
> addr = page_address(my_page);
> pgd = pgd_offset_k(addr & PAGE_MASK);
> pmd = pmd_offset(pgd, addr & PAGE_MASK);
> pte = pte_offset_kernel(pmd, addr & PAGE_MASK);
> 
> /* ok, we get pte, now unset L_PTE_CACHEABLE and
>    L_PTE_BUFFERABLE flags
> */
> pte_val(*pte) &= ~(L_PTE_CACHEABLE|L_PTE_BUFFERABLE);
> 
> The problem descriprion simple, kernel at some time doesn't see
> data, which userland writes to shared buffer, without inserting
> flush_cache_all after each operation with shared buffer from kernel.

Rather than just assuming that there are page tables there, if you
added the usual checks which the kernel typically does, you might
get a clue as to what's going on.

You'll find that the PMD is not valid as far as the Linux page table
walking goes - that's because we don't use a set of individual page
mappings to setup the kernel mapping of the page.  In turn, that
means that there is no individual control over the status of pages
allocated by alloc_pages.

To solve your problem, you need to look at the ARM DMA mmap extension
and use that instead.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
