Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161216AbWASONE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbWASONE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 09:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbWASOND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 09:13:03 -0500
Received: from mail.suse.de ([195.135.220.2]:60292 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161216AbWASONC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 09:13:02 -0500
Date: Thu, 19 Jan 2006 15:13:00 +0100
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: pageattr remove __put_page
Message-ID: <20060119141300.GE958@wotan.suse.de>
References: <20060117150356.7421.27313.sendpatchset@linux.site> <20060118190028.7047ade2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118190028.7047ade2.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 07:00:28PM -0800, Andrew Morton wrote:
> Nick Piggin <npiggin@suse.de> wrote:
> >
> > Stop using __put_page and page_count in i386 pageattr.c
> > 
> 
> who, where, what, why, when??  The patch appears to ascribe some special
> significance to page->private, but you don't tell us what it is.  And if
> that's not obvious from reading the patch, it won't be obvious to people
> who are later reading the code.
> 
> iow: you owe us a nice comment, please.
> 

OK sure, I'll redo it.

> > 
> > Index: linux-2.6/arch/i386/mm/pageattr.c
> > ===================================================================
> > --- linux-2.6.orig/arch/i386/mm/pageattr.c
> > +++ linux-2.6/arch/i386/mm/pageattr.c
> > @@ -51,6 +51,9 @@ static struct page *split_large_page(uns
> >  	if (!base) 
> >  		return NULL;
> >  
> > +	SetPagePrivate(base);
> > +	page_private(base) = 0;
> 
> A "function call" as an lval give me hiccups.  Use set_page_private(p, v),
> please.
> 

Hmm yes of course. That makes it pretty ugly.

> >  	address = __pa(address);
> >  	addr = address & LARGE_PAGE_MASK; 
> >  	pbase = (pte_t *)page_address(base);
> > @@ -143,11 +146,12 @@ __change_page_attr(struct page *page, pg
> >  				return -ENOMEM;
> >  			set_pmd_pte(kpte,address,mk_pte(split, ref_prot));
> >  			kpte_page = split;
> > -		}	
> > -		get_page(kpte_page);
> > +		}
> > +		page_private(kpte_page)++;
> 
> Ditto, really.   If we're going to be nice about this it should be
> 
> 	set_page_private(page, page_private(page) + 1);
> 
> > +		page_private(kpte_page)--;
> 
> Ditto.
> 
> 
> Or we just forget about page_private() and go back to using page->private -
> page_private() was rather a stopgap thing.
> 

Could we? We can do anonymous unions now, right?

