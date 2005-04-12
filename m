Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263068AbVDLXdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbVDLXdE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbVDLX3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:29:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:432 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263076AbVDLX1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:27:17 -0400
Subject: Re: ext3 allocate-with-reservation latencies
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 12 Apr 2005 16:27:13 -0700
Message-Id: <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-12 at 12:18 +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, 2005-04-12 at 07:41, Mingming Cao wrote:
> 
> > > Note that this may improve average case latencies, but it's not likely
> > > to improve worst-case ones.  We still need a write lock to install a new
> > > window, and that's going to have to wait for us to finish finding a free
> > > bit even if that operation starts using a read lock.  
> > > 
> > Yes indeed. However nothing is free and there are always trade-offs.:) 
> > 
> > By worse case you mean multiple writes trying to allocate blocks around
> > same area?
> 
> It doesn't matter where they are; multiple new file opens will all be
> looking for a write lock.  You only need one long-held read lock and all
> the writers still block.  The worst-case latencies can't be properly
> solved with r/w locks --- those let the readers go more quickly
> (assuming they are in the majority), which helps the average case, but
> writers still have to wait for exclusive access.  We only really help
> them by dropping the lock entirely.
> 
> > Even if we take out the whole
> > reservation, we still possibility run into this kind of latency: the
> > bitmap on disk and on journal are extremely inconsistent so we need to
> > keep searching them both until we find a free bit on both map.
> 
> Quite possibly.  But as long as that code is running without locks, it's
> much easier to deal with those latencies: they won't impact other CPUs,
> cond_resched() is easier, and there's even CONFIG_PREEMPT.
> 

Okey, I agree.

> > > I'm not really sure what to do about worst-case here.  For that, we
> > > really do want to drop the lock entirely while we do the bitmap scan.
> 
> > Hmm...if we drop the lock entirely while scan the bitmap, assuming you
> > mean drop the read lock, then I am afraid we have to re-check the tree
> > (require a read or write lock ) to see if the new window space is still
> > there after the scan succeed.
> 
> Sure.  You basically start off with a provisional window, and then if
> necessary roll it forward just the same way you roll normal windows
> forward when they get to their end.  That means you can still drop the
> lock while you search for new space.  When you get there, reacquire the
> lock and check that the intervening space is still available.
> 
Please note that the bitmap scan does not only scan the provisional
window range, it will return the first free it on the bitmap start from
the start block of the provisional window until the end of the whole
block group.

So in the case the new window's neighbor is the same as the old one(that
means window is rolled forward), we only need roll forward once to find
it. Either we find a free bit inside the provisional window, or we find
a free bit out of it. In the first case we just roll window forward and
we are done. In the second case, it's possible the free bit is inside
someone else's window(which means we can't take that window) or it
inside the new space after a already reserved window. Either way we have
to lock up the whole tree to remove the old window and insert the new
window.

> That's really cheap for the common case.  The difficulty is when you
> have many parallel allocations hitting the same bg: they allocate
> provisional windows, find the same free area later on in the bg, and
> then stomp on each other as they try to move their windows there.
> 

> I wonder if there's not a simple solution for this --- mark the window
> as "provisional", and if any other task tries to allocate in the space
> immediately following such a window, it needs to block until that window
> is released.
> 

Sounds interesting. However that implies we need a write lock to mark
the window as provisional and block other files looking for windows near
it: we need to insert the provisional window into the tree and then mark
it as a temporary window, to really let other file notice this kind of
"hold".

I wonder if the benefit of read/write lock is worth all the hassles now.
If the new window's neighbor stays the same, we only need to roll
forward once.  If not, after a successful scan, we need to grab the
write lock, and make sure the window is still there. If we dropped the
lock without holding the new space, we have to search the whole tree
again to find out if the space is still there, we cannot use the
previous node returned by find_next_reservable_window() since the
previous node could be gone while we scan the bitmap without the lock.
Basically we do twice tree search(once for roll forward case) and twice
locking in the normal case. Also I am concerned about the possible
starvation on writers.

I am thinking, maybe back to the spin_lock is not that bad with the
"mark provisional" suggest you made? It allows us to mark the new space
as provisional if we find a new space(prevent other window searching run
into the same neighborhood). We could release the lock and scan the
bitmap without worry about the new space will be taking by others.  If
there is a free bit, then we could just clear the provisional bit and
simply return.(we don't have to re-grab the lock there). In the case the
the final new window is the one just rolled the old window forward, we
only need to grab the spin_lock once and move the window forward.  This
seems to me the simplest way to fix the latency that Lee reported, and
balanced  both average and worse cases. Is it still looks too bad to
you?

Thanks,

Mingming


