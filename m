Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWG0TSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWG0TSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbWG0TSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:18:51 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:36329 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751022AbWG0TSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:18:48 -0400
Message-ID: <44C91192.4090303@oracle.com>
Date: Thu, 27 Jul 2006 12:18:42 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net>
In-Reply-To: <20060724.231708.01289489.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I like this work a lot, as I've stated before.

Yeah, me too.  I think we're very close to having a workable system
here.  A few weeks of some restructuring and we all might be very happy.

> The data structures
> look like they will scale well and it takes care of all the limitations
> that networking in particular seems to have in this area.
> 
> I have to say that the user API is not the nicest in the world.  Yet,
> at the same time, I cannot think of a better one :)

I want to first focus on the event collection side of the API because I
think we can definitely do better there :).  I hope we all agree that
there is huge value in having one place where an application can wait
for notification from many different sources.  If we get the collection
side right we can later worry about generating events down the pipe from
subsystems in a way that works best for them.

I'll sort of ramble about my thoughts here.

The easy part is fixing up the somewhat obfuscated collection call.
Instead of coming in through a multiplexer that magically treats a void
* as a struct kevent_user_control followed by N ukevents (as specified
in the kevent_user_control!) we'd turn it into a more explicit
collection syscall:

	int kevent_getevents(int event_fd, struct ukevent *events,
		int min_events, int max_events,
		struct timeval *timeout);

This would look a lot less nutty in strace.  It lets apps specify if
there is some minimum number of events they'd like the opportunity to
process rather than waiting for the timeout to expire before the max
number arrives.  (the latter is what kevent_user_wait() does today).  We
can have the usual argument about whether *timeout is updated on a
partial wake-up :).

That'd be a fine syscall collection interface, but we should try hard to
explore being able to collect events without hitting the kernel.

Say we have a ring of event structs.  AIO has this today, but it sort of
gets it wrong because each event element doesn't specify whether it is
owned by the kernel or userspace.  (It really gets it wrong because it
doesn't flush_dcache_page() after updating the ring via kmap(), but
never mind that!  No one actually uses this mmap() AIO ring.)  In AIO
today there is also a control struct mapped along with the ring that has
head and tail pointers.  We don't want to bounce that cacheline around.
 net/socket/af_packet.c gets this right with it's tp_status member of
tpacket_hdr.

So as the kernel generates events in the ring it only produces an event
if the ownership field says that userspace has consumed it and in doing
so it sets the ownership field to tell userspace that an event is
waiting.  userspace and the kernel now each follow their index around
the ring as the ownership field lets them produce or consume the event
at their index.  Can someone tell me if the cache coherence costs of
this are extreme?  I'm hoping they're not.

So, great, glibc can now find pending events very quickly if they're
waiting in the ring and can fall back to the collection syscall if it
wants to wait and the ring is empty.  If it consumes events via the
syscall it increases its ring index by the number the syscall returned.

There's two things we should address: level events and the notion of
only submitting as much as fits in the ring.

epoll and kevent both have the notion of an event type that always
creates an event at the time of the collection syscall while the event
source is on a ready list.  Think of epoll calling ->poll(POLLOUT) for
an empty socket buffer at every sys_epoll_wait() call.  We can't have
some source constantly spewing into the ring :/.  We could fix this by
the API requiring that level events can *only* be collected through the
syscall interface.  userspace could call into the collection syscall
every N events collected through the ring, say.  N would be tuned to
amortize the syscall cost and still provide fairness or latency for the
level sources.  I'd be fine with that, especially when it's hidden off
in glibc.

Today AIO only allows submission of as many events as there are space in
the ring.  It mostly does this so its completion can drop an event in
the ring from any context.  If we back away from this so that we can
have long-lived source registration generate multiple edge events (and I
think we want to!), we have to be kind of careful.  A source could
generate an event while the ring is full.  The event could go in a list
but if userspace is collecting events in userspace the kernel won't be
told when there's space.  We'd first have to check this ready list when
later events are generated so that pending events on the list aren't
overlooked.  Userspace would also want to use the collection syscall as
the ring empties.  Neither seem hard.

So how does this sound?  It wouldn't take me long to build this off of
the current kevent patches.  We could see how it looks..

- z
