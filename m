Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261228AbREXKde>; Thu, 24 May 2001 06:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261234AbREXKdY>; Thu, 24 May 2001 06:33:24 -0400
Received: from www.wen-online.de ([212.223.88.39]:2831 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261228AbREXKdI>;
	Thu, 24 May 2001 06:33:08 -0400
Date: Thu, 24 May 2001 12:32:42 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.33.0105240551450.311-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0105241123510.489-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001, Rik van Riel wrote:

> On Thu, 24 May 2001, Mike Galbraith wrote:
> > On Sun, 20 May 2001, Rik van Riel wrote:
> >
> > > Remember that inactive_clean pages are always immediately
> > > reclaimable by __alloc_pages(), if you measured a performance
> > > difference by freeing pages in a different way I'm pretty sure
> > > it's a side effect of something else.  What that something
> > > else is I'm curious to find out, but I'm pretty convinced that
> > > throwing away data early isn't the way to go.
> >
> > OK.. let's forget about throughput for a moment and consider
> > those annoying reports of 0 order allocations failing :)
>
> Those are ok.  All failing 0 order allocations are either
> atomic allocations or GFP_BUFFER allocations.  I guess we
> should just remove the printk()  ;)

Hmm.  The guy who's box locks up on him after a burst of these probably
doesn't think these failures are very OK ;-)  I don't think order 0
failing is cool at all.. ever.  A (long) while back, Linus specifically
mentioned worrying about atomic allocation reliability.

> > What do you think of the below (ignore the refill_inactive bit)
> > wrt allocator reliability under heavy stress?  The thing does
> > kick in and pump up zones even if I set the 'blood donor' level
> > to pages_min.
>
> > -		unsigned long water_mark;
> > +		unsigned long water_mark = 1 << order;
>
> Makes no sense at all since water_mark gets assigned not 10
> lines below.  ;)

That assignment was supposed to turn into +=.

> > +		if (direct_reclaim) {
> > +			int count;
> > +
> > +			/* If we're in bad shape.. */
> > +			if (z->free_pages < z->pages_low && z->inactive_clean_pages) {
>
> I'm not sure if we want to fill up the free list all the way
> to z->pages_low all the time, since "free memory is wasted
> memory".

Yes.  I'm just thinking of the burst of allocations with no reclaim
possible.

> The reason the current scheme only triggers when we reach
> z->pages_min and then goes all the way up to z->pages_low
> is memory defragmentation. Since we'll be doing direct

Ah.

> reclaim for just about every allocation in the system, it
> only happens occasionally that we throw away all the
> inactive_clean pages between z->pages_min and z->pages_low.

This one has me puzzled.  We're reluctant to release cleaned pages,
but at the same time, we reclaim if possible as soon as all zones
are below pages_high.

> > +				count = 4 * (1 << page_cluster);
> > +				/* reclaim a page for ourselves if we can afford to.. */
> > +				if (z->inactive_clean_pages > count)
> > +					page = reclaim_page(z);
> > +				if (z->inactive_clean_pages < 2 * count)
> > +					count = z->inactive_clean_pages / 2;
> > +			} else count = 0;
>
> What exactly is the reasoning behind this complex  "count"
> stuff? Is there a good reason for not just refilling the
> free list up to the target or until the inactive_clean list
> is depleted ?

Well, yes.  You didn't like the 50/50 split thingy I did before, so
I connected zones to a tricklecharger instead.

> > +			/*
> > +			 * and make a small donation to the reclaim challenged.
> > +			 *
> > +			 * We don't ever want a zone to reach the state where we
> > +			 * have nothing except reclaimable pages left.. not if
> > +			 * we can possibly do something to help prevent it.
> > +			 */
>
> This comment makes little sense

If not, then none of it does.  This situation is the ONLY thing I
was worried about.  free_pages + inactive_clean_pages > pages_min
does nothing about free_pages for those who can't reclaim if most
of that is inactive_clean_pages. IFF it's possible to be critical
on free_pages and still have clean pages, it does make sense.

> > +		if (z->inactive_clean_pages - z->free_pages > z->pages_low
> > +				&& waitqueue_active(&kreclaimd_wait))
> > +			wake_up_interruptible(&kreclaimd_wait);
>
> This doesn't make any sense to me at all.  Why wake up
> kreclaimd just because the difference between the number
> of inactive_clean pages and free pages is large ?

You had to get there with direct_reclaim not set was the thought.
Nobody gave the zone a transfusion, but there is a blood supply.
If nobody gets around to refilling the zone, kreclaimd will.

> Didn't we determine in our last exchange of email that
> it would be a good thing under most loads to keep as much
> inactive_clean memory around as possible and not waste^Wfree
> memory early ?

So why do we reclaim if we're just below pages_high?  The whole
point of this patch is to reclaim _less_ in the general case, but
to do so in a timely manner if we really need it.

> > -	/*
> > -	 * First, see if we have any zones with lots of free memory.
> > -	 *
> > -	 * We allocate free memory first because it doesn't contain
> > -	 * any data ... DUH!
> > -	 */
>
> We want to keep this.  Suppose we have one zone which is
> half filled with inactive_clean pages and one zone which
> has "too many" free pages.

Oops.

> Allocating from the first zone means we evict some piece
> of, potentially useful, data from the cache; allocating
> from the second zone means we can keep the data in memory
> and only fill up a currently unused page.
>
>
> > @@ -824,39 +824,17 @@
> >  #define DEF_PRIORITY (6)
> >  static int refill_inactive(unsigned int gfp_mask, int user)
> >  {
>
> I've heard all kinds of things about this part of the patch,
> except an explanation of why and how it is supposed to work ;)

You were supposed to ignore that bit.

It's supposed to cover the situation where kswapd is sleeping,
and you have a slew of little 'helper-bees' nibbling at the
problem.  Just reach out and grab what you _are going to_ grab
anyway and get it over with.  The loop makes absolutely no sense
to me, and removing it provides a performance increase 100% of
the time.  kswapd will come back really soon if it needs to, and
user tasks have no buisness looping around when they can either
get on with their allocation or hit the scheduling point in the
allocator.  Nothing they are doing is helping them in the least..
it's helping future allocations. IMHO, one time helping is enough.
In the opinion of my performance measurements, one time helping
is enough, and more than one is too many ;-).

> > @@ -976,8 +954,9 @@
> >  		 * We go to sleep for one second, but if it's needed
> >  		 * we'll be woken up earlier...
> >  		 */
> > -		if (!free_shortage() || !inactive_shortage()) {
> > -			interruptible_sleep_on_timeout(&kswapd_wait, HZ);
> > +		if (current->need_resched || !free_shortage() ||
> > +				!inactive_shortage()) {
> > +			interruptible_sleep_on_timeout(&kswapd_wait, HZ/10);
>
> Makes sense.  Integrated in my tree ;)

I managed to write 1 line that makes sense.  I'm improving eh?  :)

	-Mike

