Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWAZT6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWAZT6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWAZT6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:58:38 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:28759 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751393AbWAZT6h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:58:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lcVZZl1t1yxORihqo3LyAOsDufap8AlU8Wc6Gy9gtxQpAlexZ0E+fV8odGuV8LpwiwRBYJYzTUX7G4NJ+rhH1zY5EBgDTTHMEsEzeSt8WtlDor4G8QTZQucGHFBK24XZ+zW9BUpvHfpF3oU2s5da3JiSNwfBwMKHBOxHN75YHXo=
Message-ID: <6bffcb0e0601261158q60451d76l@mail.gmail.com>
Date: Thu, 26 Jan 2006 20:58:36 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.16-rc1-mm3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43D92754.4090007@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060124232406.50abccd1.akpm@osdl.org>
	 <6bffcb0e0601250340x6ca48af0w@mail.gmail.com>
	 <43D7A047.3070004@yahoo.com.au>
	 <6bffcb0e0601261102j7e0a5d5av@mail.gmail.com>
	 <43D92754.4090007@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/01/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
[snip]
> Thanks, it confirms my suspicions.
>
> Can you try the following patch, please?
> It appears the warnings were brought out by my improvement to
> the put_page_testzero debugging code (which previously did not
> check that we might be attempting to free a constituent compound
> page).
>
> Can you test the following patch please?
>
> --
> SUSE Labs, Novell Inc.
>
>
> Index: linux-2.6/include/linux/mm.h
> ===================================================================
> --- linux-2.6.orig/include/linux/mm.h
> +++ linux-2.6/include/linux/mm.h
> @@ -15,6 +15,7 @@
>  #include <linux/prio_tree.h>
>  #include <linux/fs.h>
>  #include <linux/mutex.h>
> +#include <linux/kallsyms.h>
>
>  struct mempolicy;
>  struct anon_vma;
> @@ -264,6 +265,8 @@ struct page {
>         void *virtual;                  /* Kernel virtual address (NULL if
>                                            not kmapped, ie. highmem) */
>  #endif /* WANT_PAGE_VIRTUAL */
> +
> +       void *debug;
>  };
>
>  #define page_private(page)             ((page)->private)
> @@ -294,8 +297,14 @@ struct page {
>   */
>  static inline int put_page_testzero(struct page *page)
>  {
> -       BUG_ON(atomic_read(&page->_count) == 0);
> -       return atomic_dec_and_test(&page->_count);
> +       if (unlikely(atomic_read(&page->_count) == 0)) {
> +               printk(KERN_WARNING "put_page_testzero found free page (flags = %lx)\n", page->flags);
> +               if (page->debug)
> +                       print_symbol(KERN_WARNING "nopage is %s\n", (unsigned long)page->debug);
> +               WARN_ON(1);
> +               return 0;
> +       } else
> +               return atomic_dec_and_test(&page->_count);
>  }
>
>  /*
> Index: linux-2.6/mm/memory.c
> ===================================================================
> --- linux-2.6.orig/mm/memory.c
> +++ linux-2.6/mm/memory.c
> @@ -2056,6 +2056,8 @@ retry:
>         if (new_page == NOPAGE_OOM)
>                 return VM_FAULT_OOM;
>
> +       new_page->debug = (struct address_space *)vma->vm_ops->nopage;
> +
>         /*
>          * Should we do an early C-O-W break?
>          */
> Index: linux-2.6/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.orig/mm/page_alloc.c
> +++ linux-2.6/mm/page_alloc.c
> @@ -521,6 +521,8 @@ static int prep_new_page(struct page *pa
>         if (PageReserved(page))
>                 return 1;
>
> +       page->debug = NULL;
> +
>         page->flags &= ~(1 << PG_uptodate | 1 << PG_error |
>                         1 << PG_referenced | 1 << PG_arch_1 |
>                         1 << PG_checked | 1 << PG_mappedtodisk);
>
>
>

I have tried this patch, here is dmesg:
http://www.stardust.webpages.pl/files/mm/2.6.16-rc1-mm3/mm-dmesg

Regards,
Michal Piotrowski
