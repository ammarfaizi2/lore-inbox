Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275980AbRJKKaX>; Thu, 11 Oct 2001 06:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275981AbRJKKaN>; Thu, 11 Oct 2001 06:30:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:42475 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S275980AbRJKKaA>;
	Thu, 11 Oct 2001 06:30:00 -0400
Date: Thu, 11 Oct 2001 16:04:29 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011011160429.A23161@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011010.164628.39155290.davem@redhat.com> David S. Miller wrote:
>    From: Victor Yodaiken <yodaiken@fsmlabs.com>
>    Date: Wed, 10 Oct 2001 16:24:19 -0600
>    
>    In general you're right, and always its better to 
>    reduce contention than to come up with silly algorithms for 
>    reducing the cost of contention,

> I want to second this and remind people that the "cost" of spinlocks
> is mostly not "spinning idly waiting for lock", rather the big cost
> is shuffling the dirty cacheline ownership between the processors.

Absolutely. Even reader-writer locks with read-mostly situations
can result in painful degradation because of the dirty cacheline
bouncing around.


> Any scheme involving shared data which is written (the read counts
> in the various "lockless" schemes are examples) have the same "cost"
> assosciated with them.
> In short, I see no performance gain from the lockless algorithms
> even in the places where they can be applied.

I think it depends on the lockless algorithm. If it requires you
to write to cachelines with same level of sharing as earlier
locking algorithm, it is no good. On the other hand, if you
use schemes that minimizes or ideally has no writes to shared 
data for maintaining readers, it should result in performance gains.


> I spent some time oogling over lockless algorithms a few years ago,
> but I stopped once I realized where the true costs were.  In my view,
> the lockless algorithms perhaps are a win in parallel processing
> environments (in fact, the supercomputing field is where a lot of the
> lockless algorithm research comes from) but not in the kinds of places
> and with the kinds of data structure usage the Linux kernel has.

I would agree to the extent that lockless algorithms cannot be used as 
a wholesale replacement for spin-waiting locks. However in key areas where
performance is critical, lockless techniques can be applied provided
they don't come with the same problems as locking.

I would point to Read-Copy Update as a lockless mutual exclusion
where you don't have to maintain global reader counts and other
shared cachelines. We have been experimenting with a few
places in the linux kernel where lookups can be speeded up
by not having any writes to shared cachelines.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
