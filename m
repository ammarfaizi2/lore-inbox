Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751977AbWG1Fji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbWG1Fji (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 01:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbWG1Fji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 01:39:38 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:10710 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751285AbWG1Fjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 01:39:37 -0400
Date: Fri, 28 Jul 2006 09:39:12 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Zach Brown <zach.brown@oracle.com>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
Message-ID: <20060728053912.GC11210@2ka.mipt.ru>
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com> <20060727205806.GD16971@kvack.org> <44C933D2.4040406@oracle.com> <20060727220238.GE16971@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060727220238.GE16971@kvack.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 28 Jul 2006 09:39:14 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 06:02:38PM -0400, Benjamin LaHaise (bcrl@kvack.org) wrote:
> On Thu, Jul 27, 2006 at 02:44:50PM -0700, Zach Brown wrote:
> > 
> > >> 	int kevent_getevents(int event_fd, struct ukevent *events,
> > >> 		int min_events, int max_events,
> > >> 		struct timeval *timeout);
> > > 
> > > You've just reinvented io_getevents().
> > 
> > Well, that's certainly one inflammatory way to put it.  I would describe
> > it as suggesting that the kevents collection interface not lose the
> > nicer properties of io_getevents().
> 
> Perhaps, but there seems to be a lot of talk about introducing new APIs 
> where it isn't entirely clear that it is needed.  Sorry if that sounded 
> rather acerbic.

Except that kevent has completely different structures and it is
possible to have a lot of more types of event than AIO has and there is
no need to specially have bytes, offsets and so on.
Magic pointer returned from aio syscall is no pollable too.

> > > What exactly are we getting from 
> > > reinventing this (aside from breaking existing apps and creating more of 
> > > an API mess)?
> > 
> > A generic event collection interface that isn't so strongly bound to the
> > existing semantics of io_setup() and io_submit().  It can be a file
> > descriptor instead of a mysterious cookie/pointer to the mapped region,
> > to start.
> 
> Things were like that at one point in time, but file descriptors turn out 
> to introduce a huge gaping security hole with SUID programs.  The problem 
> is that any event context is closely tied to the address space of the 
> thread issuing the syscalls, and file descriptors do not have this close 
> binding.

It is true for all shared resources no matter if it is file descriptor or 
mapped area.

> > Sure, so maybe we experiment with these things in the context of the
> > kevent patches and maybe merge them back into the AIO paths if in the
> > end that's the right thing to do.  I see no problem with separating
> > development from the existing code.
> 
> Excellent!
> 
> > >> epoll and kevent both have the notion of an event type that always
> > >> creates an event at the time of the collection syscall while the event
> > >> source is on a ready list.  Think of epoll calling ->poll(POLLOUT) for
> > >> an empty socket buffer at every sys_epoll_wait() call.  We can't have
> > >> some source constantly spewing into the ring :/.  We could fix this by
> > >> the API requiring that level events can *only* be collected through the
> > >> syscall interface.  userspace could call into the collection syscall
> > >> every N events collected through the ring, say.  N would be tuned to
> > >> amortize the syscall cost and still provide fairness or latency for the
> > >> level sources.  I'd be fine with that, especially when it's hidden off
> > >> in glibc.
> > > 
> > > This is exactly why I think level triggered events are nasty.  It's 
> > > impossible to do cleanly without requiring a syscall.
> > 
> > I'm not convinced that it isn't possible to get a sufficiently clean
> > interface that involves the mix.
> 
> My arguement is that this approach introduces a slow path into the heavily 
> loaded server case.  If you can show me how to avoid that, I'd be happy to 
> see such an implementation. =-)

If I understand you correct you are talking about level triggering
events, which arrive continuously? Such events are handled by only one
kevent, if iti is ready, that means that at least one such event was
fired. One can add a number of fired events as a hints inside kevent.

> > > As soon as you allow queueing events up in kernel space, it becomes 
> > > necessary to do another syscall after pulling events out of the queue, 
> > > which is a waste of CPU cycles when you're under heavy load (exactly the 
> > > point at which you want the system to be its most efficient).
> > 
> > If we've just consumed a full ring worth of events, and done real work
> > with them, I'm not convinced that an empty syscall is going to be that
> > painful.  If we're really under load it might well return some newly
> > arrived events.  It becomes a mix of ring completions and syscall
> > completions.
> 
> Except that you're not usually pulling a full ring worth of events at a 
> time, more often just one.  One of the driving forces behind AIO use is 
> in realtime apps where you don't want to eat occasional spikes in the 
> latency of request processing, one just wants to eat the highest priority 
> event then work on the next.  By keeping each step small and managable, 
> the properties of the system are much easier to predict.  Yes, batching 
> can be helpful performance-wise, but it is somewhat opposite to the design 
> criteria that need to be considered.  The right way to cope with that may 
> be to have two different modes of operation that trade off one way or the 
> other on the batching question.

It is user who should decide either he wants one, all or at least one
eventt. kevent supports all types of requests, it's behaviour depends on
parameters.

> 		-ben

-- 
	Evgeniy Polyakov
