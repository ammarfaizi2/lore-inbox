Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310569AbSBRNOx>; Mon, 18 Feb 2002 08:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310570AbSBRNOn>; Mon, 18 Feb 2002 08:14:43 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16162 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310569AbSBRNOc>; Mon, 18 Feb 2002 08:14:32 -0500
Date: Mon, 18 Feb 2002 14:15:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
        rsf@us.ibm.com
Subject: Re: [TEST] page tables filling non-highmem
Message-ID: <20020218141545.P7940@athlon.random>
In-Reply-To: <20020215045106.GB26322@holomorphy.com> <20020218032644.GD3511@holomorphy.com> <20020218132757.K7940@athlon.random> <E16cnOQ-0000LC-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16cnOQ-0000LC-00@starship.berlin>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 01:59:42PM +0100, Daniel Phillips wrote:
> On February 18, 2002 01:27 pm, Andrea Arcangeli wrote:
> > Agreed, this is why I fighted with Linus and Marcelo trying to convince
> > them not to reintroduce the loop crap into the allocator that leads to
> > all sort of oom deadlocks because we lack the knowledge on the amount of
> > freeable pages (I even re-read the emails about such stuff in the thread
> > "VM tweaks" to be sure I was remembering right). OTOH, I really cannot
> > complain, they included so much stuff from my tree that even if we
> > disagreed on something at the end I don't mind :).  And this is probably
> > also why I don't like very much to restart those threads about oom
> > deadlocks, I know my way is the only right way (i.e. non deadlock prone)
> > possible, and I live with it just fine.
> >
> > The only way we can learn if a page or a mapping is freeable or not, is
> > by trying to free it and by checking if we failed or not. We cannot know
> > in another manner, only checking the size of the caches or the amount of
> > the swap still unused is totally meaningless and broken. That's
> > unfortunate but that's how all linux kernels I know of works, and what I
> > did in my tree at the moment is the only possible way to avoid deadlocks
> > without having to do a major rework on the accounting side.
> 
> Could you describe your page table deadlock-avoidance algorithm in more
> detail please?

There is nothing specific with the pagetables. If the lowmem was eat by
skb instead of ptes you'd deadlock the very same way. The kernel will
just see lots of cache in highmem and of swap available (not to tell the
kernel never knows how much of such cache is really freeable or how much
of the mappings are swappable and that's the very next problem that will
leads to the same deadlock) and it will think there's "freeable" memory
available and it will keep looping.  That's simply plain broken. The
only way if there's something freeable is to try to free it and if we
fail we say "oom". You cannot say if there's something freeable by
checking the cache size or the number of free swap pages, no-way.

If in 2.5 we want perfect accounting of freeable resources instead, fine
with me (that would math guarantee to never fail allocations if there's
at least one page freeable, while right now you only can calculate a
probabilistic measure), but it has to be _perfect_, and with 2.4 there
isn't such perfect accounting, so we definitely cannot rely on cache
size and swap available to know if to trigger oom or not. That's totally
broken and it will deadlock. I care about those minor theorical things
too, I want everything calculated and under control, I hate
approximations that can leads to deadlocks, and it pays off eventually.

Andrea
