Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSHGAmi>; Tue, 6 Aug 2002 20:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSHGAmi>; Tue, 6 Aug 2002 20:42:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24845 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316592AbSHGAmh>;
	Tue, 6 Aug 2002 20:42:37 -0400
Message-ID: <3D506D43.890EA215@zip.com.au>
Date: Tue, 06 Aug 2002 17:43:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org, riel@surriel.com
Subject: Re: fix CONFIG_HIGHPTE
References: <20020806231522.GJ6256@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> Minimalistic fix. Perhaps rough at the edges but I can clean the
> ugliness ppl care about when they complain. 2.5.30 successfully booted
> & ran userspace on a 16-way NUMA-Q with 16GB of RAM with this patch
> and CONFIG_HIGHPTE enabled.

Thanks, Bill.  It doesn't seem any uglier than anything else highmem-related.

> ...
> +#define rmap_ptep_map(pte_paddr)                                       \
> +({                                                                     \
> +       unsigned long pfn = (unsigned long)(pte_paddr >> PAGE_SHIFT);   \
> +       unsigned long idx = __pte_offset(((unsigned long)pte_paddr));   \
> +       (pte_t *)kmap_atomic(pfn_to_page(pfn), KM_PTE2) + idx;          \
> +})

Could be an inline?

> +static inline rmap_ptep_map(pte_addr_t pte_paddr)
> +{
> +       return (pte_t *)pte_paddr;
> +}

Better try compiling that ;)

> ...
> --- 1.66/include/linux/mm.h     Thu Aug  1 12:30:06 2002
> +++ edited/include/linux/mm.h   Fri Aug  2 22:24:40 2002
> @@ -161,7 +161,7 @@
>         union {
>                 struct pte_chain * chain;       /* Reverse pte mapping pointer.
>                                          * protected by PG_chainlock */
> -               pte_t            * direct;
> +               pte_addr_t               direct;
>         } pte;

Four more bytes into struct page.  I bet that hurt.

> ...
>  struct pte_chain {
>         struct pte_chain * next;
> -       pte_t * ptep;
> +       pte_addr_t ptep;
>  };

We'll get fifteen pte_addr_t's per pte_chain on a P4 with the
array-of-pteps-per-pte_chain patch.

And we'll need that, to reduce load on KM_PTECHAIN.  Because
there's no point in pte_highmem without also having pte_chain_highmem,
yes?

Which means either going back to a custom allocator or teaching
slab about highmem and kmap_atomic.  (Probably a custom allocator;
internal fragmentation on 32/64/128 byte pte_chains won't be tooooo
bad, presumably).

We're piling more and more crap in there to support these pte_chains.
How much is too much?

Is it likely that large pages and/or shared pagetables would allow us to
place pagetables and pte_chains in the direct-mapped region, avoid all
this?
