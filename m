Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265750AbSKFQFw>; Wed, 6 Nov 2002 11:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265757AbSKFQFv>; Wed, 6 Nov 2002 11:05:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42764 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265750AbSKFQFt>; Wed, 6 Nov 2002 11:05:49 -0500
Date: Wed, 6 Nov 2002 08:12:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46
In-Reply-To: <1036599549.9803.49.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211060758440.2545-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Nov 2002, Alan Cox wrote:
>
> On Wed, 2002-11-06 at 15:45, Linus Torvalds wrote:
> > It's clearly stupid in the long run to depend on the TSC synchronization.
> > We should consider different CPU's to be different clock-domains, and just
> > synchronize them using the primitives we already have (hey, people can use
> > ntp to synchronize over networks quite well, and that's without the kind
> > of synchronization primitives that we have within the same box).
> 
> NTP synchronization assumes the clock runs at approximately the same
> speed and that you can 'bend' ticklength to avoid backward steps. Thats
> a really cool idea for the x440 but I wonder how practical it is when we
> have CPU's that keep changing speeds and not always notifying us about
> it either.

Note that you have a _lot_ more flexibility than NTP thanks to the strong 
synchronization that we actually do have between CPU's in the end.

The synchronization just isn't strong enough to allow us to believe that 
the TSC is exactly the _same_. But it is certainly string enough that we 
should be able to do a really good job.

Of course, if the TSC changes speed without telling us, we have problems. 

But that has nothing to do witht he synchronization protocol itself: we 
have problems with that even on a single CPU on laptops right now. Does it 
mean that gettimeofday() gets confused? Sure as hell. But it doesn't get 
any _worse_ from being done separately on multiple CPU's.

(And it _does_ get slightly better. On multiple CPU's with per-CPU time
structures at least you _can_ handle the case where one CPU runs at a
different speed, so at least you could handle the case where one CPU is
slowed down explicitly much better than we can right now).

As an example of something that is simpler in the MP/NUMA world than in 
NTP: we see the processes migrating, and we can fairly trivially do things 
like

 - every gettimeofday() will always save the value we return, along with a 
   sequence number (which is mainly read-only, so it's ok to share among 
   CPU's)

 - every "settimeofday()" will increase the sequence number

 - when the next gettimeofday happens, we can check the sequence number 
   and the old gettimeofday, and verify that we get monotonic behaviour in 
   the absense of explicit date setting. This allows us to handle small 
   problems gracefully ("return the old time + 1 ns" to make it 
   monotonic even when we screw up), _and_ it will also act as a big clue
   for us that we should try to synchronize - so that we basically never 
   need to worry about "should I check the clocks" (where "basically 
   never" may be "we check the clocks every minute or so if nothing else 
   happens")

Basically, I think NTP itself would be _way_ overkill between CPU's, I 
wasn't really suggesting we use NTP as the main mechanism at that level. I 
just suspect that a lot of the data structures and info that we already 
have to have for NTP might be used as help.

		Linus

