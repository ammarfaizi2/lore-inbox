Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290103AbSBNF7z>; Thu, 14 Feb 2002 00:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289850AbSBNF7p>; Thu, 14 Feb 2002 00:59:45 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:26333 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290232AbSBNF73>; Thu, 14 Feb 2002 00:59:29 -0500
Date: Thu, 14 Feb 2002 11:30:53 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>,
        William Lee Irwin III <wli@holomorphy.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
Message-ID: <20020214113053.B1641@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <3C639060.A68A42CA@zip.com.au> <3C6791C0.63CA2677@zip.com.au>, <3C6791C0.63CA2677@zip.com.au>; <20020211230537.A8661@in.ibm.com> <3C681AF4.689A28E4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C681AF4.689A28E4@zip.com.au>; from akpm@zip.com.au on Mon, Feb 11, 2002 at 11:26:44AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 11:26:44AM -0800, Andrew Morton wrote:
> Suparna Bhattacharya wrote:
> > 
> > ...
> > > *  When a process wants a new request:
> > > *
> > > *    b) If free_requests == 0, the requester sleeps in FIFO manner.
> > > *
> > > *    b) If 0 <  free_requests < batch_requests and there are waiters,
> > > *       we still take a request non-blockingly.  This provides batching.
> > 
> > For a caller who just got an exclusive wakeup on the request queue,
> > this enables the woken up task to do batching and not sleep again on the
> > next request it needs. However since we use the same logic for new callers,
> > don't we still have those starvation issues ?
> 
> Let's think of `incoming' tasks and `outgoing' ones.  The incoming
> tasks are running tasks which are making new requests, and the
> outgoing ones are tasks which were on the waitqueue, and which are
> in the process of being woken and granted a request.
> 
> Your concern is that incoming tasks can still steal all the requests
> away from the sleepers.   And sure, they can, until all requests are
> gone.  At which time the incoming tasks get to wait their turn on
> the waitqueue.  And generally, the problem is with writes, where we tend
> to have a few threads performing a large number of requests.
> 
> Another scenario is where incoming tasks just take a handful of requests,
> and their rate of taking equals the rate of request freeing, and the
> free_request threshold remains greater than zero, less than batch_nr_requests.
> This steady state could conceivably happen with the correct number of
> threads performing O_SYNC/fsync writes, for example.  I'll see if I can
> find a way to make this happen.

Thanks for the explanation. (I was off-line for a couple of days so
didn't get to respond earlier) This is closest to the case that I
was concerned about. Perhaps with merging/write-clustering at higher 
levels the number of requests might be less, but that is secondary.  
What was worrying me is that even when the rate of request taking 
is greater than the rate of request freeing, couldn't we have every 
1 out of N incoming tasks picking up a just freed up request, thus 
starving the waiters ? (The rest N-1 incoming tasks might get to
wait their turn, where N:1 is the ratio of request taking to request
freeing)

> 
> The final scenario is where there are many outgoing tasks, so they
> compete, and each gets an insufficiently large number of requests.
> I suspect this is indeed happening with the current kernel's wake-all
> code.  But the wake-one change makes this unlikely.
> 
> When an outgoing task is woken, we know there are 32 free requests on the
> queue.  There's an assumption (or design) here that the outgoing task
> will be able to get a decent number of those requests.  This works.  It
> may fail if there are a massive number of CPUs.  But we need to increase
> the overall request queue size anyway - 128 is too small.

Yes, especially when the system has sufficient resources to increase
the request queue size, one might as well queue up on the request 
queue, rather than the wait queue, and minimize those context switches.

> 
> Under heavy load, the general operating mode for this code is that 
> damn near every task is asleep.  So most work is done by outgoing threads.
> 
> BTW, I suspect the request batching isn't super-important.  It'll
> certainly decrease the context switch rate very much.  But from a
> request-merging point of view it's unlikely to make much difference.
> 
> -
