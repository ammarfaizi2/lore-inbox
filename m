Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932755AbWEXPxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755AbWEXPxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 11:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbWEXPxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 11:53:52 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:54383 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S932753AbWEXPxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 11:53:51 -0400
Subject: Re: [PATCH 17/33] readahead: context based method
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060524133353.GA16508@mail.ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	 <20060524111905.586110688@localhost.localdomain>
	 <1148474268.10561.53.camel@lappy> <20060524133353.GA16508@mail.ustc.edu.cn>
Content-Type: text/plain
Date: Wed, 24 May 2006 17:53:36 +0200
Message-Id: <1148486016.10561.73.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 21:33 +0800, Wu Fengguang wrote:
> On Wed, May 24, 2006 at 02:37:48PM +0200, Peter Zijlstra wrote:
> > On Wed, 2006-05-24 at 19:13 +0800, Wu Fengguang wrote:
> > 
> > > +#define PAGE_REFCNT_0           0
> > > +#define PAGE_REFCNT_1           (1 << PG_referenced)
> > > +#define PAGE_REFCNT_2           (1 << PG_active)
> > > +#define PAGE_REFCNT_3           ((1 << PG_active) | (1 << PG_referenced))
> > > +#define PAGE_REFCNT_MASK        PAGE_REFCNT_3
> > > +
> > > +/*
> > > + * STATUS   REFERENCE COUNT
> > > + *  __                   0
> > > + *  _R       PAGE_REFCNT_1
> > > + *  A_       PAGE_REFCNT_2
> > > + *  AR       PAGE_REFCNT_3
> > > + *
> > > + *  A/R: Active / Referenced
> > > + */
> > > +static inline unsigned long page_refcnt(struct page *page)
> > > +{
> > > +        return page->flags & PAGE_REFCNT_MASK;
> > > +}
> > > +
> > > +/*
> > > + * STATUS   REFERENCE COUNT      TYPE
> > > + *  __                   0      fresh
> > > + *  _R       PAGE_REFCNT_1      stale
> > > + *  A_       PAGE_REFCNT_2      disturbed once
> > > + *  AR       PAGE_REFCNT_3      disturbed twice
> > > + *
> > > + *  A/R: Active / Referenced
> > > + */
> > > +static inline unsigned long cold_page_refcnt(struct page *page)
> > > +{
> > > +	if (!page || PageActive(page))
> > > +		return 0;
> > > +
> > > +	return page_refcnt(page);
> > > +}
> > > +
> > 
> > Why all of this if all you're ever going to use is cold_page_refcnt.
> 
> Well, the two functions have a long history...
> 
> There has been a PG_activate which makes the two functions quite
> different. It was later removed for fear of the behavior changes it
> introduced. However, there's still possibility that someone
> reintroduce similar flags in the future :)
> 
> > What about something like this:
> > 
> > static inline int cold_page_referenced(struct page *page)
> > {
> > 	if (!page || PageActive(page))
> > 		return 0;
> > 	return !!PageReferenced(page);
> > }
> 
> Ah, here's another theory: the algorithm uses reference count
> conceptually, so it may be better to retain the current form.

Reference count of what exactly, if you were to say of the page, I'd
have expected only the first function, page_refcnt().

What I don't exactly understand is why you specialise to the inactive
list. Why do you need that?

The reason I'm asking is that when I merge this with my page replacement
work, I need to find a generalised concept. cold_page_refcnt() would
become to mean something like: number of references for those pages that
are direct reclaim candidates. And honestly, that doesn't make a lot of
sense.

If you could explain the concept behind this, I'd be grateful.

Peter



