Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSF1QAp>; Fri, 28 Jun 2002 12:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317461AbSF1QAo>; Fri, 28 Jun 2002 12:00:44 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22536 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317458AbSF1QAn>; Fri, 28 Jun 2002 12:00:43 -0400
Date: Fri, 28 Jun 2002 12:01:33 -0400
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: vm fixes for 2.4.19rc1
Message-ID: <20020628160133.GA1729@inspiron.ols.wavesec.org>
References: <20020627201413.GD1457@inspiron.ols.wavesec.org> <Pine.LNX.4.21.0206272241230.1023-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0206272241230.1023-100000@localhost.localdomain>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2002 at 11:28:46PM +0100, Hugh Dickins wrote:
> On Thu, 27 Jun 2002, Andrea Arcangeli wrote:
> > I will make a full vm update for 2.5 [in small pieces based on post-Andrew
> > split of the monolithic patch] in the next days anyways):
> 
> Great!
> 
> > diff -urNp 2.4.19rc1/mm/page_alloc.c 2.4.19rc1aa1/mm/page_alloc.c
> > --- 2.4.19rc1/mm/page_alloc.c	Tue Jun 25 23:56:23 2002
> > +++ 2.4.19rc1aa1/mm/page_alloc.c	Wed Jun 26 00:55:35 2002
> > @@ -82,8 +82,11 @@ static void __free_pages_ok (struct page
> >  	/* Yes, think what happens when other parts of the kernel take 
> >  	 * a reference to a page in order to pin it for io. -ben
> >  	 */
> > -	if (PageLRU(page))
> > +	if (PageLRU(page)) {
> > +		if (unlikely(in_interrupt()))
> > +			BUG();
> >  		lru_cache_del(page);
> > +	}
> > 
> > this adds a debugging check just in case.
> 
> Well, of course I like this patch, having proposed it months ago.
> But the evidence for needing it seems to have died down, and I
> don't think -rc is the right time for adding a BUG() where you
> can almost always get away with such bad behaviour - I intended
> it for a diagnostic aid in the early stages of a release -
> but I'm happy to go whichever way Marcelo decides on it.

it's up to Marcelo as you say, personally I prefer it to go in for
robusteness.

> > @@ -91,6 +94,8 @@ static void __free_pages_ok (struct page
> >  		BUG();
> >  	if (!VALID_PAGE(page))
> >  		BUG();
> > +	if (PageSwapCache(page))
> > +		BUG();
> > 
> > This resurrects a valid debugging check dropped in rc1.
> 
> Sorry, Andrea, perhaps I should have copied you explicitly on my
> patch which dropped that check.  It is a valid check, yes, but it's
> a waste of space and time: remember that PageSwapCache(page) just
> checks whether page->mapping == &swapper_space (used to be a bitflag,
> yes, but not since last Autumn), and the BUG() you can just see above
> was if page->mapping was set at all.  One day, yes, PageSwapCache may
> become bitflag test again: then would be the time to add the test back.
> 
> > @@ -280,10 +285,12 @@ static struct page * balance_classzone(z
> >  						BUG();
> >  					if (!VALID_PAGE(page))
> >  						BUG();
> > +					if (PageSwapCache(page))
> > +						BUG();
> > 
> > same as above. a page with page->mapping set cannot be freed, if it
> > happens it's a bug that we want to trap.
> 
> As you say, same as above: again the BUG() you can just see at the top
> was on a test for whether page->mapping is set, so PageSwapCache test
> again redundant.  If compiler optimized it away, I'd leave it: but no.

ok.

> > diff -urNp 2.4.19rc1/mm/swap_state.c 2.4.19rc1aa1/mm/swap_state.c
> > --- 2.4.19rc1/mm/swap_state.c	Tue Jan 22 12:55:27 2002
> > +++ 2.4.19rc1aa1/mm/swap_state.c	Wed Jun 26 00:48:13 2002
> > @@ -95,11 +95,8 @@ int add_to_swap_cache(struct page *page,
> >   */
> >  void __delete_from_swap_cache(struct page *page)
> >  {
> > -	if (!PageLocked(page))
> > -		BUG();
> >  	if (!PageSwapCache(page))
> >  		BUG();
> > -	ClearPageDirty(page);
> >  	__remove_inode_page(page);
> >  	INC_CACHE_INFO(del_total);
> >  }
> > 
> > Here I play risky for a rc1, but it made perfect sense to me,
> 
> Yes and yes.  My comment when I weakened the __remove_inode_page BUG
> was "Remove the prior ClearPageDirty?  maybe but not without deeper
> thought: let stay for now."  I've not given it deep enough thought,
> and I'm not convinced you have yet: need to consider the peculiarities
> of mm/shmem.c, and the way clearing the flag lets the page be dirtied

mm/shmem.c looked trivial too, just grep for __delete_from_swap_cache and
delete_from_swap_cache. they all correctly set the dirty bit on the page
afterwards. Infact we shouldn't only remove the clearpagedirty, we
should replace it with a setpagedirty above, just the opposite :), then
we can drop various setpagedirty after delete_from_swap_cache.

> on to a list later.  My _guess_ is that it's fine to remove that
> ClearPageDirty in 2.4, but 2.5 a rather different case; but it
> seems to me a risky cleanup, not -rc material.  (But, sorry,
> maybe I'm just advertizing the shallowness of _my_ thought.)

well, the other PG_swap_cache cleanups that happened in rc1 weren't
strictly necessary too, but I'm fine to postpone the above one. I will
just take care of those bits for next -aa according to the corrections
you made. thanks,

> > @@ -114,9 +111,6 @@ void delete_from_swap_cache(struct page 
> >  {
> >  	swp_entry_t entry;
> >  
> > -	if (!PageLocked(page))
> > -		BUG();
> > -
> >  	block_flushpage(page, 0);
> >  
> >  	entry.val = page->index;
> > 
> > dropped also two pagelocked checks because there execute unconditionally
> > paths that checks the pagelocked bit at the lower layer.
> 
> I don't mind that removal if you leave the !PageLocked BUG test in
> __delete_from_swap_cache, but you've proposed to remove that one too?

Andrea
