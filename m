Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWHAPzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWHAPzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 11:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWHAPzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 11:55:36 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:11222 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932535AbWHAPzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 11:55:36 -0400
Subject: Re: [patch 1/2] mm: speculative get_page
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060801193203.GA191@oleg>
References: <20060801193203.GA191@oleg>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 10:55:29 -0500
Message-Id: <1154447729.10401.16.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 23:32 +0400, Oleg Nesterov wrote:
> Nick Piggin wrote:
> >
> > --- linux-2.6.orig/mm/vmscan.c
> > +++ linux-2.6/mm/vmscan.c
> > @@ -380,6 +380,8 @@ int remove_mapping(struct address_space 
> >  	if (!mapping)
> >  		return 0;		/* truncate got there first */
> >
> > +	SetPageNoNewRefs(page);
> > +	smp_wmb();
> >  	write_lock_irq(&mapping->tree_lock);
> >
> 
> Is it enough?
> 
> PG_nonewrefs could be already set by another add_to_page_cache()/remove_mapping(),
> and it will be cleared when we take ->tree_lock.

Isn't the page locked when calling remove_mapping()?  It looks like
SetPageNoNewRefs & ClearPageNoNewRefs are called in safe places.  Either
the page is locked, or it's newly allocated.  I could have missed
something, though.

>  For example:
> 
> CPU_0					CPU_1					CPU_3
> 
> add_to_page_cache:
> 
>     SetPageNoNewRefs();
>     write_lock_irq(->tree_lock);

      SetPageLocked(page);

>     ...
>     write_unlock_irq(->tree_lock);
> 
> 					remove_mapping:
> 	
> 					    SetPageNoNewRefs();
> 
>     ClearPageNoNewRefs();
> 					    write_lock_irq(->tree_lock);
> 
> 					    check page_count()
> 
> 										page_cache_get_speculative:
> 
> 										    increment page_count()
> 
> 										    no PG_nonewrefs => return
> 
> Oleg.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

