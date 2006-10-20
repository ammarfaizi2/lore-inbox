Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992461AbWJTDCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992461AbWJTDCL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 23:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992464AbWJTDCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 23:02:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5064
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S2992461AbWJTDCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 23:02:09 -0400
Date: Thu, 19 Oct 2006 20:02:11 -0700 (PDT)
Message-Id: <20061019.200211.88476455.davem@davemloft.net>
To: zyf.zeroos@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: about flush TLB during unmapping a page in memory
 subsystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <4df04b840610191947r2b48c2ddo45f0cd94d94a614b@mail.gmail.com>
References: <4df04b840610191947r2b48c2ddo45f0cd94d94a614b@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "yunfeng zhang" <zyf.zeroos@gmail.com>
Date: Fri, 20 Oct 2006 10:47:49 +0800

> In rmap.c::try_to_unmap_one of 2.6.16.29, there are some code snippets
> 
> .....
> /* Nuke the page table entry. */
> flush_cache_page(vma, address, page_to_pfn(page));
> pteval = ptep_clear_flush(vma, address, pte);
> // >>> The above line is expanded as below
> // >>> pte_t __pte;
> // >>> __pte = ptep_get_and_clear((__vma)->vm_mm, __address, __ptep);
> // >>> flush_tlb_page(__vma, __address);
> // >>> __pte;
> 
> /* Move the dirty bit to the physical page now the pte is gone. */
> if (pte_dirty(pteval))
>         set_page_dirty(page);
> .....
> 
> 
> It seems that they only can work on UP system.
> 
> On SMP, let's suppose the pte was clean, after A CPU executed
> ptep_get_and_clear,
> B CPU makes the pte dirty, which will make a fatal error to A CPU since it gets
> a stale pte, isn't right?

B can't make it dirty because it's been cleared to zero
and flush_tlb_page() has removed the TLB cached copy of
the PTE.  B can therefore only see the new cleared PTE.
