Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131950AbRCVJC0>; Thu, 22 Mar 2001 04:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131952AbRCVJCQ>; Thu, 22 Mar 2001 04:02:16 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:36100 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131950AbRCVJCJ>; Thu, 22 Mar 2001 04:02:09 -0500
Date: Thu, 22 Mar 2001 04:17:50 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: kswapd deadlock 2.4.3-pre6
In-Reply-To: <Pine.LNX.4.31.0103212217320.10817-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0103220411070.3306-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Mar 2001, Linus Torvalds wrote:

> diff -u --recursive --new-file pre6/linux/mm/memory.c linux/mm/memory.c
> --- pre6/linux/mm/memory.c	Tue Mar 20 23:13:03 2001
> +++ linux/mm/memory.c	Wed Mar 21 22:21:27 2001
> @@ -1031,18 +1031,20 @@
>  	struct vm_area_struct * vma, unsigned long address,
>  	pte_t * page_table, swp_entry_t entry, int write_access)
>  {
> -	struct page *page = lookup_swap_cache(entry);
> +	struct page *page;
>  	pte_t pte;
> 
> +	spin_unlock(&mm->page_table_lock);
> +	page = lookup_swap_cache(entry);
>  	if (!page) {
> -		spin_unlock(&mm->page_table_lock);
>  		lock_kernel();
>  		swapin_readahead(entry);
>  		page = read_swap_cache(entry);
>  		unlock_kernel();
> -		spin_lock(&mm->page_table_lock);
> -		if (!page)
> +		if (!page) {
> +			spin_lock(&mm->page_table_lock);
>  			return -1;
> +		}
> 
>  		flush_page_to_ram(page);
>  		flush_icache_page(vma, page);

Are you sure flush_page_to_ram()/flush_icache_page() without
page_table_lock held is ok for all archs? 

Looking at arch/mips/mm/r2300.c:

static void r3k_flush_cache_page(struct vm_area_struct *vma,
                                   unsigned long page)
{
        struct mm_struct *mm = vma->vm_mm;

	...
               if ((physpage = get_phys_page(page, vma->vm_mm)))   <--------
                        r3k_flush_icache_range(physpage, PAGE_SIZE);
	...
}


static inline unsigned long get_phys_page (unsigned long addr,
                                           struct mm_struct *mm)
{
        pgd_t *pgd;
        pmd_t *pmd;
        pte_t *pte;
        unsigned long physpage;

        pgd = pgd_offset(mm, addr);
        pmd = pmd_offset(pgd, addr);
        pte = pte_offset(pmd, addr);

        if((physpage = pte_val(*pte)) & _PAGE_VALID) 
                return KSEG1ADDR(physpage & PAGE_MASK);
        else
                return 0;
	...
}

