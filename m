Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWG0WCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWG0WCx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 18:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWG0WCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 18:02:53 -0400
Received: from kanga.kvack.org ([66.96.29.28]:47747 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751358AbWG0WCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 18:02:52 -0400
Date: Thu, 27 Jul 2006 18:02:38 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: David Miller <davem@davemloft.net>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
Message-ID: <20060727220238.GE16971@kvack.org>
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com> <20060727205806.GD16971@kvack.org> <44C933D2.4040406@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C933D2.4040406@oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 02:44:50PM -0700, Zach Brown wrote:
> 
> >> 	int kevent_getevents(int event_fd, struct ukevent *events,
> >> 		int min_events, int max_events,
> >> 		struct timeval *timeout);
> > 
> > You've just reinvented io_getevents().
> 
> Well, that's certainly one inflammatory way to put it.  I would describe
> it as suggesting that the kevents collection interface not lose the
> nicer properties of io_getevents().

Perhaps, but there seems to be a lot of talk about introducing new APIs 
where it isn't entirely clear that it is needed.  Sorry if that sounded 
rather acerbic.

> > What exactly are we getting from 
> > reinventing this (aside from breaking existing apps and creating more of 
> > an API mess)?
> 
> A generic event collection interface that isn't so strongly bound to the
> existing semantics of io_setup() and io_submit().  It can be a file
> descriptor instead of a mysterious cookie/pointer to the mapped region,
> to start.

Things were like that at one point in time, but file descriptors turn out 
to introduce a huge gaping security hole with SUID programs.  The problem 
is that any event context is closely tied to the address space of the 
thread issuing the syscalls, and file descriptors do not have this close 
binding.

> Sure, so maybe we experiment with these things in the context of the
> kevent patches and maybe merge them back into the AIO paths if in the
> end that's the right thing to do.  I see no problem with separating
> development from the existing code.

Excellent!

> >> epoll and kevent both have the notion of an event type that always
> >> creates an event at the time of the collection syscall while the event
> >> source is on a ready list.  Think of epoll calling ->poll(POLLOUT) for
> >> an empty socket buffer at every sys_epoll_wait() call.  We can't have
> >> some source constantly spewing into the ring :/.  We could fix this by
> >> the API requiring that level events can *only* be collected through the
> >> syscall interface.  userspace could call into the collection syscall
> >> every N events collected through the ring, say.  N would be tuned to
> >> amortize the syscall cost and still provide fairness or latency for the
> >> level sources.  I'd be fine with that, especially when it's hidden off
> >> in glibc.
> > 
> > This is exactly why I think level triggered events are nasty.  It's 
> > impossible to do cleanly without requiring a syscall.
> 
> I'm not convinced that it isn't possible to get a sufficiently clean
> interface that involves the mix.

My arguement is that this approach introduces a slow path into the heavily 
loaded server case.  If you can show me how to avoid that, I'd be happy to 
see such an implementation. =-)

> > As soon as you allow queueing events up in kernel space, it becomes 
> > necessary to do another syscall after pulling events out of the queue, 
> > which is a waste of CPU cycles when you're under heavy load (exactly the 
> > point at which you want the system to be its most efficient).
> 
> If we've just consumed a full ring worth of events, and done real work
> with them, I'm not convinced that an empty syscall is going to be that
> painful.  If we're really under load it might well return some newly
> arrived events.  It becomes a mix of ring completions and syscall
> completions.

Except that you're not usually pulling a full ring worth of events at a 
time, more often just one.  One of the driving forces behind AIO use is 
in realtime apps where you don't want to eat occasional spikes in the 
latency of request processing, one just wants to eat the highest priority 
event then work on the next.  By keeping each step small and managable, 
the properties of the system are much easier to predict.  Yes, batching 
can be helpful performance-wise, but it is somewhat opposite to the design 
criteria that need to be considered.  The right way to cope with that may 
be to have two different modes of operation that trade off one way or the 
other on the batching question.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
