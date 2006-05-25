Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWEYB0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWEYB0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWEYB0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:26:04 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:6880 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S964811AbWEYB0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:26:02 -0400
Message-ID: <348520355.07663@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 25 May 2006 09:25:56 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/33] readahead: context based method
Message-ID: <20060525012556.GA6111@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <20060524111905.586110688@localhost.localdomain> <1148474268.10561.53.camel@lappy> <20060524133353.GA16508@mail.ustc.edu.cn> <1148486016.10561.73.camel@lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148486016.10561.73.camel@lappy>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 05:53:36PM +0200, Peter Zijlstra wrote:
> On Wed, 2006-05-24 at 21:33 +0800, Wu Fengguang wrote:
> > On Wed, May 24, 2006 at 02:37:48PM +0200, Peter Zijlstra wrote:
> > > On Wed, 2006-05-24 at 19:13 +0800, Wu Fengguang wrote:
> > > 
> > > > +#define PAGE_REFCNT_0           0
> > > > +#define PAGE_REFCNT_1           (1 << PG_referenced)
> > > > +#define PAGE_REFCNT_2           (1 << PG_active)
> > > > +#define PAGE_REFCNT_3           ((1 << PG_active) | (1 << PG_referenced))
> > > > +#define PAGE_REFCNT_MASK        PAGE_REFCNT_3
> > > > +
> > > > +/*
> > > > + * STATUS   REFERENCE COUNT
> > > > + *  __                   0
> > > > + *  _R       PAGE_REFCNT_1
> > > > + *  A_       PAGE_REFCNT_2
> > > > + *  AR       PAGE_REFCNT_3
> > > > + *
> > > > + *  A/R: Active / Referenced
> > > > + */
> > > > +static inline unsigned long page_refcnt(struct page *page)
> > > > +{
> > > > +        return page->flags & PAGE_REFCNT_MASK;
> > > > +}
> > > > +
> > > > +/*
> > > > + * STATUS   REFERENCE COUNT      TYPE
> > > > + *  __                   0      fresh
> > > > + *  _R       PAGE_REFCNT_1      stale
> > > > + *  A_       PAGE_REFCNT_2      disturbed once
> > > > + *  AR       PAGE_REFCNT_3      disturbed twice
> > > > + *
> > > > + *  A/R: Active / Referenced
> > > > + */
> > > > +static inline unsigned long cold_page_refcnt(struct page *page)
> > > > +{
> > > > +	if (!page || PageActive(page))
> > > > +		return 0;
> > > > +
> > > > +	return page_refcnt(page);
> > > > +}
> > > > +
> > > 
> > > Why all of this if all you're ever going to use is cold_page_refcnt.
> > 
> > Well, the two functions have a long history...
> > 
> > There has been a PG_activate which makes the two functions quite
> > different. It was later removed for fear of the behavior changes it
> > introduced. However, there's still possibility that someone
> > reintroduce similar flags in the future :)
> > 
> > > What about something like this:
> > > 
> > > static inline int cold_page_referenced(struct page *page)
> > > {
> > > 	if (!page || PageActive(page))
> > > 		return 0;
> > > 	return !!PageReferenced(page);
> > > }
> > 
> > Ah, here's another theory: the algorithm uses reference count
> > conceptually, so it may be better to retain the current form.
> 
> Reference count of what exactly, if you were to say of the page, I'd
> have expected only the first function, page_refcnt().
> 
> What I don't exactly understand is why you specialise to the inactive
> list. Why do you need that?
> 
> The reason I'm asking is that when I merge this with my page replacement
> work, I need to find a generalised concept. cold_page_refcnt() would
> become to mean something like: number of references for those pages that
> are direct reclaim candidates. And honestly, that doesn't make a lot of
> sense.
> 
> If you could explain the concept behind this, I'd be grateful.

Good question, and sorry for mentioning this...

There are some background info here:

        [DISTURBS] section of
        http://marc.theaimsgroup.com/?l=linux-kernel&m=112678976802381&w=2

        [DELAYED ACTIVATION] section of
        http://marc.theaimsgroup.com/?l=linux-kernel&m=112679176611006&w=2

It involves a tricky situation where there are two sequential readers
that come close enough, so that the follower retouched the pages
visited by the leader:

          chunk 1         chunk 2               chunk 3
        ==========  =============-------  --------------------
                       follower ^                     leader ^

It is all ok if the revisited pages still stay in the inactive list,
these pages will act as measurement of len(inactive list)/speed(leader).
But if the revisited pages(marked by '=') are sent to active list
immediately, the measurement will no longer be as accurate. The trace
is 'disturbed'. In this case, using page_refcnt() can be aggressive
and unsafe from thrashing, while cold_page_refcnt() can be conservative.

So either one of page_refcnt()/cold_page_refcnt() should be ok, as
long as we know the consequence of this situation.  After all, it is
really uncommon to see much invocation of the context based method,
and even rare for this kind of situation to happen.

Regards,
Wu
