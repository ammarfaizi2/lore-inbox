Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWG0U65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWG0U65 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWG0U6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:58:24 -0400
Received: from kanga.kvack.org ([66.96.29.28]:2433 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751034AbWG0U6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:58:20 -0400
Date: Thu, 27 Jul 2006 16:58:06 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: David Miller <davem@davemloft.net>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
Message-ID: <20060727205806.GD16971@kvack.org>
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C91192.4090303@oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 12:18:42PM -0700, Zach Brown wrote:
> The easy part is fixing up the somewhat obfuscated collection call.
> Instead of coming in through a multiplexer that magically treats a void
> * as a struct kevent_user_control followed by N ukevents (as specified
> in the kevent_user_control!) we'd turn it into a more explicit
> collection syscall:
> 
> 	int kevent_getevents(int event_fd, struct ukevent *events,
> 		int min_events, int max_events,
> 		struct timeval *timeout);

You've just reinvented io_getevents().  What exactly are we getting from 
reinventing this (aside from breaking existing apps and creating more of 
an API mess)?

> Say we have a ring of event structs.  AIO has this today, but it sort of
> gets it wrong because each event element doesn't specify whether it is
> owned by the kernel or userspace.  (It really gets it wrong because it
> doesn't flush_dcache_page() after updating the ring via kmap(), but
> never mind that!  No one actually uses this mmap() AIO ring.)  In AIO
> today there is also a control struct mapped along with the ring that has
> head and tail pointers.  We don't want to bounce that cacheline around.
>  net/socket/af_packet.c gets this right with it's tp_status member of
> tpacket_hdr.

That could be rev'd in the mmap() ring buffer, as there are compat and 
incompat bits for changing the structure layout.  As for bouncing the 
cacheline of head/tail around, I don't think it matters on real machines, 
as the multithreaded/SMP case will hit that cacheline bouncing if the 
user is sharing the event ring between multiple threads on multiple CPUs.  
The only way around that is to use multiple event rings, say one per node, 
at which point you have to do load balancing of io requests explicitely 
between queues (which might be worth it).

> So, great, glibc can now find pending events very quickly if they're
> waiting in the ring and can fall back to the collection syscall if it
> wants to wait and the ring is empty.  If it consumes events via the
> syscall it increases its ring index by the number the syscall returned.
> 
> There's two things we should address: level events and the notion of
> only submitting as much as fits in the ring.
> 
> epoll and kevent both have the notion of an event type that always
> creates an event at the time of the collection syscall while the event
> source is on a ready list.  Think of epoll calling ->poll(POLLOUT) for
> an empty socket buffer at every sys_epoll_wait() call.  We can't have
> some source constantly spewing into the ring :/.  We could fix this by
> the API requiring that level events can *only* be collected through the
> syscall interface.  userspace could call into the collection syscall
> every N events collected through the ring, say.  N would be tuned to
> amortize the syscall cost and still provide fairness or latency for the
> level sources.  I'd be fine with that, especially when it's hidden off
> in glibc.

This is exactly why I think level triggered events are nasty.  It's 
impossible to do cleanly without requiring a syscall.

> Today AIO only allows submission of as many events as there are space in
> the ring.  It mostly does this so its completion can drop an event in
> the ring from any context.  If we back away from this so that we can
> have long-lived source registration generate multiple edge events (and I
> think we want to!), we have to be kind of careful.  A source could
> generate an event while the ring is full.  The event could go in a list
> but if userspace is collecting events in userspace the kernel won't be
> told when there's space.  We'd first have to check this ready list when
> later events are generated so that pending events on the list aren't
> overlooked.  Userspace would also want to use the collection syscall as
> the ring empties.  Neither seem hard.

As soon as you allow queueing events up in kernel space, it becomes 
necessary to do another syscall after pulling events out of the queue, 
which is a waste of CPU cycles when you're under heavy load (exactly the 
point at which you want the system to be its most efficient).  Given that 
growing the ring buffer is easy enough to do, I'm not sure that the hit 
is worth it.  At some point there has to be some form of flow control 
involved, and it is much better if it is explicitely obvious where this 
happens (as opposed to signal queues and our wonderful OOM handling).

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
