Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131043AbRAOTrV>; Mon, 15 Jan 2001 14:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131079AbRAOTrG>; Mon, 15 Jan 2001 14:47:06 -0500
Received: from monza.monza.org ([209.102.105.34]:30227 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131043AbRAOTqq>;
	Mon, 15 Jan 2001 14:46:46 -0500
Date: Mon, 15 Jan 2001 11:46:25 -0800
From: Tim Wright <timw@splhi.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: timw@splhi.com, nigel@nrg.org, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
Message-ID: <20010115114625.A1896@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Andrew Morton <andrewm@uow.edu.au>, timw@splhi.com,
	nigel@nrg.org, "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-audio-dev@ginette.musique.umontreal.ca
In-Reply-To: <200101110519.VAA02784@pizda.ninka.net> <Pine.LNX.4.05.10101111233241.5936-100000@cosmic.nrg.org> <3A5F0706.6A8A8141@uow.edu.au>, <3A5F0706.6A8A8141@uow.edu.au>; <20010112071150.A1653@scutter.internal.splhi.com> <3A5FA8D0.A88BD7CA@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5FA8D0.A88BD7CA@uow.edu.au>; from andrewm@uow.edu.au on Sat, Jan 13, 2001 at 12:01:04PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 12:01:04PM +1100, Andrew Morton wrote:
> Tim Wright wrote:
[...]
> > p_lock(lock);
> > retry:
> > ...
> > if (condition where we need to sleep) {
> >     p_sema_v_lock(sema, lock);
> >     /* we got woken up */
> >     p_lock(lock);
> >     goto retry;
> > }
> > ...
> 
> That's an interesting concept.  How could this actually be used
> to protect a particular resource?  Do all users of that
> resource have to claim both the lock and the semaphore before
> they may access it?
> 

Ahh, I thought I might have been a tad terse in my explanation. No, the
idea here is that the spinlock guards the access to the data structure we're
concerned about. The sort of code I was thinking about would be where we need
to allocate a data structure. We attempt to grab it from the freelist, and if
successful, then everything is fine. Otherwise, we need to sleep waiting for
some resources to be freed up. So we atomically drop the lock and sleep on
the allocation semaphore. The freeing-up path is also protected by the same
lock, and would do something like 'if (there are sleepers) wake(sleepers)'.
This wakes up the sleeper who grabs the spinlock and retries the alloc. The
result is no races, but we don't spin or hold the lock for a long time.

It doesn't have to be an allocation. The same idea works for e.g. protecting
access to "buffer cache" (not necessarily Linux) data, and then atomically
releasing the lock and sleeping waiting for an I/O to happen.

> 
> There are a number of locks (such as pagecache_lock) which in the
> great majority of cases are held for a short period, but are 
> occasionally held for a long period.  So these locks are not
> a performance problem, they are not a scalability problem but
> they *are* a worst-case-latency problem.
> 

Understood. Whether the above metaphor works depends on whether or not the
"holding for a long time" case fits this pattern i.e. at this stage,
I'm not sufficiently familiar with the Linux VM code. I'm in the process
of rectifying that problem :-)

Regards,

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
