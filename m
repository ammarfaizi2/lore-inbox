Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161182AbWASDAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbWASDAq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161181AbWASDAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:00:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32418 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161182AbWASDAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:00:45 -0500
Date: Wed, 18 Jan 2006 19:00:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-kernel@vger.kernel.org, npiggin@suse.de
Subject: Re: [patch] i386: pageattr remove __put_page
Message-Id: <20060118190028.7047ade2.akpm@osdl.org>
In-Reply-To: <20060117150356.7421.27313.sendpatchset@linux.site>
References: <20060117150356.7421.27313.sendpatchset@linux.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:
>
> Stop using __put_page and page_count in i386 pageattr.c
> 

who, where, what, why, when??  The patch appears to ascribe some special
significance to page->private, but you don't tell us what it is.  And if
that's not obvious from reading the patch, it won't be obvious to people
who are later reading the code.

iow: you owe us a nice comment, please.

> 
> Index: linux-2.6/arch/i386/mm/pageattr.c
> ===================================================================
> --- linux-2.6.orig/arch/i386/mm/pageattr.c
> +++ linux-2.6/arch/i386/mm/pageattr.c
> @@ -51,6 +51,9 @@ static struct page *split_large_page(uns
>  	if (!base) 
>  		return NULL;
>  
> +	SetPagePrivate(base);
> +	page_private(base) = 0;

A "function call" as an lval give me hiccups.  Use set_page_private(p, v),
please.

>  	address = __pa(address);
>  	addr = address & LARGE_PAGE_MASK; 
>  	pbase = (pte_t *)page_address(base);
> @@ -143,11 +146,12 @@ __change_page_attr(struct page *page, pg
>  				return -ENOMEM;
>  			set_pmd_pte(kpte,address,mk_pte(split, ref_prot));
>  			kpte_page = split;
> -		}	
> -		get_page(kpte_page);
> +		}
> +		page_private(kpte_page)++;

Ditto, really.   If we're going to be nice about this it should be

	set_page_private(page, page_private(page) + 1);

> +		page_private(kpte_page)--;

Ditto.


Or we just forget about page_private() and go back to using page->private -
page_private() was rather a stopgap thing.

Then again, we perform unnatural acts upon the pageframe so regularly that
I suspect the abstraction might prove useful in the future..
