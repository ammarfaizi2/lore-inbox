Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVAIUwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVAIUwn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 15:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVAIUwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 15:52:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:54940 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261781AbVAIUwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 15:52:38 -0500
Date: Sun, 9 Jan 2005 12:52:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: chrisw@osdl.org, clameter@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes for prep_zero_page
Message-Id: <20050109125212.330c34c1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0501090812220.13639@montezuma.fsmlabs.com>
References: <20050108010629.M469@build.pdx.osdl.net>
	<20050109014519.412688f6.akpm@osdl.org>
	<Pine.LNX.4.61.0501090812220.13639@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> On Sun, 9 Jan 2005, Andrew Morton wrote:
> 
> > Well it's doing clear_highpage() before __alloc_pages() has called
> > kernel_map_pages(), so CONFIG_DEBUG_PAGEALLOC is quite kaput.
> > 
> > So the current __GFP_ZERO buglist is:
> > 
> > 1: Breaks CONFIG_DEBUG_PAGEALLOC
> > 
> > 2: Breaks the cache aliasing protection for anonymous pages
> > 
> > 3: prep_zero_page() uses KM_USER0 so __GFP_ZERO from IRQ context will
> >    cause rare memory corruption.
> 
> The following should take care of 1 and 3. I opted to unmap the pages 
> again after the clear page so that it remains isolated and we don't have 
> to make additional checks to see if we should unmap the pages.
> 
> Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>
> 
> Index: linux-2.6.10-mm2/include/linux/highmem.h
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.10-mm2/include/linux/highmem.h,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 highmem.h
> --- linux-2.6.10-mm2/include/linux/highmem.h	9 Jan 2005 04:51:52 -0000	1.1.1.1
> +++ linux-2.6.10-mm2/include/linux/highmem.h	9 Jan 2005 15:32:17 -0000
> @@ -50,6 +50,18 @@ static inline void clear_highpage(struct
>  	kunmap_atomic(kaddr, KM_USER0);
>  }
>  
> +static inline void clear_irq_highpage(struct page *page)
> +{
> +	char *kaddr;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	kaddr = kmap_atomic(page, KM_IRQ0);
> +	clear_page(kaddr);
> +	kunmap_atomic(kaddr, KM_IRQ0);
> +	local_irq_restore(flags);
> +}
> +

This won't work right if someone tries to allocate memory while holding a
KM_IRQ0 atomic kmap.

It would be quite bizarre for anyone to be allocating highmem pages from
IRQ context anyway, but as a generic mechanism this really should work as
expected in all contexts.  That means a new kmap slot.

>  /*
>   * Same but also flushes aliased cache contents to RAM.
>   */
> Index: linux-2.6.10-mm2/mm/page_alloc.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.10-mm2/mm/page_alloc.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 page_alloc.c
> --- linux-2.6.10-mm2/mm/page_alloc.c	9 Jan 2005 04:52:40 -0000	1.1.1.1
> +++ linux-2.6.10-mm2/mm/page_alloc.c	9 Jan 2005 15:46:00 -0000
> @@ -691,10 +691,17 @@ perthread_pages_alloc(void)
>   */
>  static inline void prep_zero_page(struct page *page, int order)
>  {
> -	int i;
> +	int i, nr_pages = (1 << order);
> +	int context = in_interrupt();
>  
> -	for(i = 0; i < (1 << order); i++)
> -		clear_highpage(page + i);
> +	kernel_map_pages(page, nr_pages, 1);
> +	for(i = 0; i < nr_pages; i++) {
> +		if (likely(!context))
> +			clear_highpage(page + i);
> +		else
> +			clear_irq_highpage(page + i);
> +	}
> +	kernel_map_pages(page, nr_pages, 0);
>  }

Can't we simply move the page zeroing to the very end of __alloc_pages()?

