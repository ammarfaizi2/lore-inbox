Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131887AbRCVHib>; Thu, 22 Mar 2001 02:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131899AbRCVHiV>; Thu, 22 Mar 2001 02:38:21 -0500
Received: from www.wen-online.de ([212.223.88.39]:20239 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131887AbRCVHiO>;
	Thu, 22 Mar 2001 02:38:14 -0500
Date: Thu, 22 Mar 2001 08:37:28 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: kswapd deadlock 2.4.3-pre6
In-Reply-To: <Pine.LNX.4.31.0103212217320.10817-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0103220821500.1478-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, Linus Torvalds wrote:

> On Wed, 21 Mar 2001, Linus Torvalds wrote:
> >
> > The deadlock implies that somebody scheduled with page_table_lock held.
> > Which would be really bad.
>
> ..and it is probably do_swap_page().
>
> Despite the name, "lookup_swap_cache()" does more than a lookup - it will
> wait for the page that it looked up. And we call it with the
> page_table_lock held in do_swap_page().

Darn, you're too quick.  (just figured it out and was about to report:)

Trace; c012785b <__lock_page+83/ac>
Trace; c012789b <lock_page+17/1c>
Trace; c01279a1 <__find_lock_page+81/f0>
Trace; c013008b <lookup_swap_cache+4b/164>
Trace; c0125362 <do_swap_page+12/1cc>
Trace; c012571f <handle_mm_fault+77/c4>
Trace; c01148b4 <do_page_fault+0/426>
Trace; c0114a17 <do_page_fault+163/426>
Trace; c01148b4 <do_page_fault+0/426>
Trace; c011581e <schedule+3e6/5ec>
Trace; c010908c <error_code+34/3c>

> Ho humm. Does the appended patch fix it for you? Looks obvious enough, but
> this bug is actually hidden on true SMP, and I'm too lazy to test with
> "num_cpus=1" or something..

I'm sure it will, but will be back in a few with confirmation.

>
> 		Linus
>
> -----
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
> @@ -1053,13 +1055,13 @@
>  	 * Must lock page before transferring our swap count to already
>  	 * obtained page count.
>  	 */
> -	spin_unlock(&mm->page_table_lock);
>  	lock_page(page);
> -	spin_lock(&mm->page_table_lock);
>
>  	/*
> -	 * Back out if somebody else faulted in this pte while we slept.
> +	 * Back out if somebody else faulted in this pte while we
> +	 * released the page table lock.
>  	 */
> +	spin_lock(&mm->page_table_lock);
>  	if (pte_present(*page_table)) {
>  		UnlockPage(page);
>  		page_cache_release(page);

(oh well, I had the right idea at least)

