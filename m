Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135462AbRDMKg7>; Fri, 13 Apr 2001 06:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135463AbRDMKgt>; Fri, 13 Apr 2001 06:36:49 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:9488 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S135462AbRDMKgi>;
	Fri, 13 Apr 2001 06:36:38 -0400
Date: Fri, 13 Apr 2001 12:36:12 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: george anzinger <george@mvista.com>
Cc: Ben Greear <greearb@candelatech.com>, Bret Indrelee <bret@io.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: No 100 HZ timer!
Message-ID: <20010413123612.A30971@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.21.0104122258060.7396-100000@fnord.io.com> <3AD69D7F.36B2BA87@candelatech.com> <3AD6BBDD.D5BA23EE@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD6BBDD.D5BA23EE@mvista.com>; from george@mvista.com on Fri, Apr 13, 2001 at 01:42:05AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> > Wouldn't a heap be a good data structure for a list of timers?  Insertion
> > is log(n) and finding the one with the least time is O(1), ie pop off the
> > front....  It can be implemented in an array which should help cache
> > coherency and all those other things they talked about in school :)
> > 
> I must be missing something here.  You get log(n) from what?  B-trees? 
> How would you manage them to get the needed balance?  Stopping the world
> to re-balance is worse than the cascade.  I guess I need to read up on
> this stuff.  A good pointer would be much appreciated. 

Look for "priority queues" and "heaps".  In its simplest form, you use a
heap-ordered tree, which can be implemented using an array (that's
usually how it's presented), or having the objects in the heap point to
each other.

A heap-ordered tree is not as strictly ordered as, well, an ordered tree
:-)  The rule is: if A is the parent of B and C, then A expires earlier
than B, and A expires earlier than C.  There is no constraint on the
relative expiry times of B and C.

There is no "stop the world" to rebalance, which you may consider an
advantage over the present hierarchy of tables.  On the other hand, each
insertion or deletion operation takes O(log n) time, where n is the
number of items in the queue.  Although fairly fast, this bound can be
improved if you know the typical insertion/deletion patterns, to O(1)
for selected cases.  Also you should know that not all priority queues
are based on heap-ordered trees.

Linux' current hierarchy of tables is a good example of optimisation: it
is optimised for inserting and actually running short term timers, as
well as inserting and deleting (before running) long term timers.  These
extremes take O(1) for insertion, removal and expiry, including the
"stop the world" time.  This should be considered before and move to a
heap-based priority queue, which may turn out slower.

> Meanwhile, I keep thinking of a simple doubly linked list in time
> order.  To speed it up keep an array of pointers to the first N whole
> jiffie points and maybe pointers to coarser points beyond the first N. 
> Make N, say 512.  Build the pointers as needed.  This should give
> something like O(n/N) insertion and O(1) removal.

You've just described the same as the current implementation, but with
lists for longer term timers.  I.e. slower.  With your coarser points,
you have to sort the front elements of the coarse list into a fine one
from time to time.

The idea of having jiffie-point pointers into a data structure for fast
insertion is a good one for speeding up any data structure for that
common case, though.

-- Jamie
