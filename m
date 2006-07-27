Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWG0Voz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWG0Voz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWG0Voz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:44:55 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:61421 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751185AbWG0Voy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:44:54 -0400
Message-ID: <44C933D2.4040406@oracle.com>
Date: Thu, 27 Jul 2006 14:44:50 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: David Miller <davem@davemloft.net>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com> <20060727205806.GD16971@kvack.org>
In-Reply-To: <20060727205806.GD16971@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> 	int kevent_getevents(int event_fd, struct ukevent *events,
>> 		int min_events, int max_events,
>> 		struct timeval *timeout);
> 
> You've just reinvented io_getevents().

Well, that's certainly one inflammatory way to put it.  I would describe
it as suggesting that the kevents collection interface not lose the
nicer properties of io_getevents().

> What exactly are we getting from 
> reinventing this (aside from breaking existing apps and creating more of 
> an API mess)?

A generic event collection interface that isn't so strongly bound to the
existing semantics of io_setup() and io_submit().  It can be a file
descriptor instead of a mysterious cookie/pointer to the mapped region,
to start.

> incompat bits for changing the structure layout.  As for bouncing the 
> cacheline of head/tail around, I don't think it matters on real machines, 
> as the multithreaded/SMP case will hit that cacheline bouncing if the 
> user is sharing the event ring between multiple threads on multiple CPUs.  
> The only way around that is to use multiple event rings, say one per node, 
> at which point you have to do load balancing of io requests explicitely 
> between queues (which might be worth it).

Sure, so maybe we experiment with these things in the context of the
kevent patches and maybe merge them back into the AIO paths if in the
end that's the right thing to do.  I see no problem with separating
development from the existing code.

>> epoll and kevent both have the notion of an event type that always
>> creates an event at the time of the collection syscall while the event
>> source is on a ready list.  Think of epoll calling ->poll(POLLOUT) for
>> an empty socket buffer at every sys_epoll_wait() call.  We can't have
>> some source constantly spewing into the ring :/.  We could fix this by
>> the API requiring that level events can *only* be collected through the
>> syscall interface.  userspace could call into the collection syscall
>> every N events collected through the ring, say.  N would be tuned to
>> amortize the syscall cost and still provide fairness or latency for the
>> level sources.  I'd be fine with that, especially when it's hidden off
>> in glibc.
> 
> This is exactly why I think level triggered events are nasty.  It's 
> impossible to do cleanly without requiring a syscall.

I'm not convinced that it isn't possible to get a sufficiently clean
interface that involves the mix.

> As soon as you allow queueing events up in kernel space, it becomes 
> necessary to do another syscall after pulling events out of the queue, 
> which is a waste of CPU cycles when you're under heavy load (exactly the 
> point at which you want the system to be its most efficient).

If we've just consumed a full ring worth of events, and done real work
with them, I'm not convinced that an empty syscall is going to be that
painful.  If we're really under load it might well return some newly
arrived events.  It becomes a mix of ring completions and syscall
completions.

- z
