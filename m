Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVLSQWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVLSQWz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVLSQWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:22:55 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42149 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964816AbVLSQWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:22:55 -0500
Date: Mon, 19 Dec 2005 17:22:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20051219162204.GA8160@elte.hu>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219042248.GG23384@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> >     $ ./test-mutex V 16 10             $ ./test-mutex V 16 10
> >     8 CPUs, running 16 tasks.          8 CPUs, running 16 tasks.
> >     checking VFS performance.          checking VFS performance.
> >     avg loops/sec:      34713          avg loops/sec:      84153
> >     CPU utilization:    63%            CPU utilization:    22%
> > 
> >    i.e. in this workload, the mutex based kernel was 2.4 times faster 
> >    than the semaphore based kernel, _and_ it also had 2.8 times less CPU 
> >    utilization. (In terms of 'ops per CPU cycle', the semaphore kernel 
> >    performed 551 ops/sec per 1% of CPU time used, while the mutex kernel 
> >    performed 3825 ops/sec per 1% of CPU time used - it was 6.9 times 
> >    more efficient.)
> 
> Do you have an idea where this big difference comes from? It doesn't 
> look it's from the fast path which is essentially the same.  Do the 
> mutexes have that much better scheduling behaviour than semaphores? It 
> is a bit hard to believe.

yes, generic mutexes have that much better scheduling in this workload.  
[ And no, there's no secret speedup magic hidden in the scheduler ;) ] 
See my other reply to Linus about why there's such a difference.

> I would perhaps understand your numbers if you used adaptive mutexes 
> or similar that spin for a bit, but just for pure sleeping locks it 
> seems weird. After all the scheduler should work in the same way for 
> both.

hm, i'm not so sure about adaptive mutexes - i'm a bit uneasy about 
wasting cycles on spinning, it will inevitably cause wasted resources in 
some workloads. I think the right approach is to make scheduling fast 
and cheap, and to improve the queueing/wakeup logic of kernel code.

but by all means feel free to experiment with adaptive mutexes, all the 
mutex logic is located in kernel/mutex.c, and it is well-suited for 
rapid prototyping of new locking logic.

	Ingo
