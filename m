Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271552AbRHZUgH>; Sun, 26 Aug 2001 16:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271555AbRHZUf6>; Sun, 26 Aug 2001 16:35:58 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:13834 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271552AbRHZUfl>; Sun, 26 Aug 2001 16:35:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Victor Yodaiken <yodaiken@fsmlabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sun, 26 Aug 2001 22:42:21 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20010826125911.A20805@hq2>
In-Reply-To: <20010826125911.A20805@hq2>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010826203551Z16190-32383+1506@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Victor

On August 26, 2001 08:59 pm, Victor Yodaiken wrote:
> On Sun, Aug 26, 2001 at 06:54:55PM +0200, Daniel Phillips wrote:
> > But it's a very interesting idea: instead of performing readahead in 
> > generic_file_read the user thread would calculate the readahead window
> > information and pass it off to a kernel thread dedicated to readahead.
> > This thread can make an informed, global decision on how much IO to
> > submit.  The user thread benefits by avoiding some stalls due to
> > readahead->readpage, as well as avoiding thrashing due to excessive
> > readahead.
> 
> And scheduling gets even more complex as we try to account for work done
> in this thread on behalf of other processes.

We already have kernel threads doing IO work on behalf of other processes, 
bdflush is an example.  Granted, it's output, not input, but is there a 
difference as far as accounting goes?

> And, of course, we have all sorts of wacky merge problems
> 	Process		Kthread
> 	----------------------------
> 	read block 1
> 			schedules to read block 2 readahead
> 	read block 2 
> 	not in cache so
> 	send to ll_rw
> 	get it.
> 	exit
> 			getting through the backlog, don't see block 2 anywhere
> 			so do the readahead not knowing that it's already been
> 			read, used, and discarded

Very unlikely, having been used the block (page) is simply left on the 
inactive queue, not freed.  In any event, the object of the exercise is for 
readahead to run ahead of demand - your example shows what happens when we 
get a traffic jam.

> Sound like it could keep you busy for a while.

The existing code handles this situation just fine.

> BTW: maybe I'm oversimplifying, but since read-ahead is an optimization
> trading memory space for time, why doesn't it just turn off when there's
> a shortage of free memory?
> 		num_pages = (num_requestd_pages +  (there_is_a_boatload_of_free_space? 
readahead: 0)

When the system is running under load there's *always* a shortage of free 
memory.  Yes, for sure we need automatic throttling on readahead.  First we 
need a good way of estimating the amount of memory we can reasonably devote 
to readahead.  It's not completely obvious how to do that.  (Look at all the 
difficulty coming up with an accurate way of determining memory_full, a 
similar problem.)

On the way towards coming up with a reliable automatic readahead throttling 
mechanism we can do two really easy, useful things:

  1) Let the user set the per-file limit manually
  2) Automagically cap readahead-in-flight as some user-supplied fraction
     of memory

A port to the linus tree of an -ac patch for (1) was obligingly supplied by 
Craig Hagan in the "very slow parallel read performance" thread.  For (2) 
there's some slight difficulty in accounting accurately for 
readahead-in-flight.  What I'm considering doing at the moment is creating a 
separate lru_list dedicated to readahead pages, then the accounting becomes 
trivial - it's just the length of the list.  At the same time, this provides 
a simple mechanism for elevating the priority of as-yet-unused readahead 
pages over used-once pages, which as Rik helpfully pointed out, allows us to 
pack as much as twice as many readahead pages into cache before we hit the 
thrash point.

Welcome to the vm tag-team mudwrestling championships ;-)

--
Daniel
