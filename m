Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318243AbSGQIVz>; Wed, 17 Jul 2002 04:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318242AbSGQIVy>; Wed, 17 Jul 2002 04:21:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21779 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318243AbSGQIVv>; Wed, 17 Jul 2002 04:21:51 -0400
Date: Wed, 17 Jul 2002 09:24:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/13] minimal rmap
Message-ID: <20020717092446.A4329@flint.arm.linux.org.uk>
References: <3D3500AA.131CE2EB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D3500AA.131CE2EB@zip.com.au>; from akpm@zip.com.au on Tue, Jul 16, 2002 at 10:29:14PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 10:29:14PM -0700, Andrew Morton wrote:

I'm puzzling over this difference:

> --- /dev/null	Thu Aug 30 13:30:55 2001
> +++ 2.5.26-akpm/include/asm-arm/proc-armv/rmap.h	Tue Jul 16 21:59:40 2002
>...
> +static inline void pgtable_add_rmap(pte_t * ptep, struct mm_struct * mm, unsigned long address)
> +{
> +	struct page * page = virt_to_page(ptep);
> +
> +	page->mm = mm;
> +	page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
> +}

and

> --- /dev/null	Thu Aug 30 13:30:55 2001
> +++ 2.5.26-akpm/include/asm-generic/rmap.h	Tue Jul 16 21:59:40 2002
> +static inline void pgtable_add_rmap(struct page * page, struct mm_struct * mm, unsigned long address)
> +{
> +#ifdef BROKEN_PPC_PTE_ALLOC_ONE
> +	/* OK, so PPC calls pte_alloc() before mem_map[] is setup ... ;( */
> +	extern int mem_init_done;
> +
> +	if (!mem_init_done)
> +		return;
> +#endif
> +	page->mapping = (void *)mm;
> +	page->index = address & ~((PTRS_PER_PTE * PAGE_SIZE) - 1);
> +}

Note that the ARM one seems to be using page->mm but everything else
uses page->mapping.

Also, this comment:

> + * ARM is different since hardware page tables are smaller than
> + * the page size and Linux uses a "duplicate" one with extra info.
> + * For rmap this means that the first 2 kB of a page are the hardware
> + * page tables and the last 2 kB are the software page tables.

is no longer true for 2.5 (although it is still true for 2.4.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

