Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVCUWfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVCUWfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVCUWd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:33:58 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:54760
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262016AbVCUW2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:28:15 -0500
Date: Mon, 21 Mar 2005 14:26:50 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050321142650.7364fac1.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005 20:52:44 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

Hugh, I'm getting some problems on sparc64 here:

> +static inline void free_pgd_range(struct mmu_gather *tlb,
> +			unsigned long addr, unsigned long end,
> +			unsigned long floor, unsigned long ceiling)
>  {
>  	pgd_t *pgd;
>  	unsigned long next;
> +	unsigned long start;
>  
> +	addr &= PMD_MASK;
> +	if (addr < floor) {
> +		addr += PMD_SIZE;
> +		if (!addr)
> +			return;
> +	}
> +	ceiling &= PMD_MASK;
> +	if (addr > ceiling - 1)
> +		return;
> +
> +	start = addr;
>  	pgd = pgd_offset(tlb->mm, addr);
>  	do {
>  		next = pgd_addr_end(addr, end);
>  		if (pgd_none_or_clear_bad(pgd))
>  			continue;
> -		clear_pud_range(tlb, pgd, addr, next);
> +		free_pud_range(tlb, pgd, addr, next, floor, ceiling);
>  	} while (pgd++, addr = next, addr != end);
> +
> +	if (!tlb_is_full_mm(tlb))
> +		flush_tlb_pgtables(tlb->mm, start, end);
> +}

flush_tlb_pgtables() on sparc64 has a BUG() check which
is basically:

	BUG((long)start > (long)end);

This catches two cases of bogus arguments:

1) start --> end straddles sparc64 address space hole
2) start > end

With your changes, this triggers on even the first user
process execution.  Specifically I get the first
trap with start=0x70800000 and end=0x70188000.  (these
addresses are in the region where generally 32-bit tasks
get their non-fixed mmap() requests satisfied, so these
are probably shared library chunks).

I think the VMA gathering optimization one level up in
free_pgtables() has some logic error in it.   Maybe...

I'll try to figure out what exactly is going on, but
perhaps you can spot it before me. :-)
