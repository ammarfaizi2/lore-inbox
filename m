Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWBIOwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWBIOwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 09:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWBIOwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 09:52:07 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:12969 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932504AbWBIOwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 09:52:06 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v22
Date: Fri, 10 Feb 2006 01:51:40 +1100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       ck list <ck@vds.kolivas.org>, linux-mm@kvack.org,
       Nick Piggin <npiggin@suse.de>, Paul Jackson <pj@sgi.com>
References: <200602092339.49719.kernel@kolivas.org> <43EB43B9.5040001@yahoo.com.au>
In-Reply-To: <43EB43B9.5040001@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602100151.40894.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 00:29, Nick Piggin wrote:
> busy Con Kolivas wrote:
> > +	/* Swap prefetching is delayed if any watermark is low */
> > +	delay_swap_prefetch();
> > +
> > +	return 0;
> >  }
>
> Do we really need to delay here? We do the watermark check anyway and it
> would eliminate a hot cacheline bouncing site and further reduce impact
> on vm code.

Ack 

> > +	struct radix_tree_root	swap_tree;	/* Lookup tree of pages */
>
> Umm... what is swap_tree for, exactly?

To avoid ...

/me looks around

It's because...

/me scratches head

wtf..

/me comes up with the answer

legacy that must die

> > +	__set_bit(0, &swapped.busy);
> > +}
> > +
>
> Test this first so you don't bounce the cacheline around in page
> reclaim too much.

Ack

> > +		if (list_empty(&swapped.list))
> > +			wake_up_process(kprefetchd_task);
>
> Move this wake up outside the swapped.lock to keep lock hold times down.

Ack

> > +	if (unlikely(!spin_trylock_irqsave(&swapped.lock, flags)))
> > +		return;
>
> You never really hold swapped.lock long do you? By the time you disable
> interrupts and hit the cacheline here, if it is contended you may as
> well wait the few extra cycles for it to become unlocked no?

It just seemed to be a lousy time to be taking a lock originally but I dropped 
the other trylocks so I may as well here.

> > +	page = __alloc_pages(GFP_HIGHUSER & ~__GFP_WAIT, 0, zonelist);
>
> We have an alloc_pages_node for this.

Ack

> The whole function reminds me of read_swap_cache_async. I wonder if there
> could be some sharing, or at least format it similarly and use things like
> find_get_page rather than open coding?

The reason the name is similar is because of starting with that function as my 
codebase. Originally I started hacking it to share but it just got so ugly 
and did too much that it seemed nicer and less intrusive to have a unique and 
smaller function.

> > +		if (z->pages_high * 3 > free) {
> > +			node_clear(node, sp_stat.prefetch_nodes);
> > +			continue;
> > +		}
>
> This ignores the reserve ratio stuff.

Urgh

> Doing this in pagevecs should improve icache utilisation and locking
> efficiency. However at this stage you probably don't need to worry about
> that.

You got my vote about not worrying..

> > +	if (mru) {
> > +		spin_lock(&swapped.lock);
> > +			if (likely(mru))
>
> Why do you need to retest mru here?

Brain fart. Was thinking about locking.

> The list manipulation in this routine is a bit ugly. You should be able to
> do basically the whole thing without touching .next or .prev (except maybe
> to find the initial entry) shouldn't you?

Well that's the point of the mru list_head, because if the initial entry is 
dropped (and it almost always will by being prefetched), and we start 
skipping entries because of nodes not suited to prefetching, we don't have 
the head at the most recent entry.

> > +	sys_ioprio_set(IOPRIO_WHO_PROCESS, 0, IOPRIO_CLASS_IDLE);
> > +
>
> What happens if your app suddenly faults the page while it is being
> read in? Gets stuck with low prio still, I guess.

Yes it does. It might get washed in with readahead or get merged with the 
other requests too.

> Probably not a big deal.
>
> Can you make it delay prefetch if the swap device is busy as well?

Delay prefetch happens if we are faulting in or out pages already. It just 
doesn't test the device data itself; that seemed like overkill.

Thanks!

Cheers,
Con
