Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751967AbWG0UHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbWG0UHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWG0UHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:07:12 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:60085 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751967AbWG0UHJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:07:09 -0400
Date: Fri, 28 Jul 2006 00:06:56 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Zach Brown <zach.brown@oracle.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
Message-ID: <20060727200655.GA4586@2ka.mipt.ru>
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44C91192.4090303@oracle.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 28 Jul 2006 00:06:58 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 12:18:42PM -0700, Zach Brown (zach.brown@oracle.com) wrote:
> > I have to say that the user API is not the nicest in the world.  Yet,
> > at the same time, I cannot think of a better one :)
> 
> I want to first focus on the event collection side of the API because I
> think we can definitely do better there :).  I hope we all agree that
> there is huge value in having one place where an application can wait
> for notification from many different sources.  If we get the collection
> side right we can later worry about generating events down the pipe from
> subsystems in a way that works best for them.
> 
> I'll sort of ramble about my thoughts here.
> 
> The easy part is fixing up the somewhat obfuscated collection call.
> Instead of coming in through a multiplexer that magically treats a void
> * as a struct kevent_user_control followed by N ukevents (as specified
> in the kevent_user_control!) we'd turn it into a more explicit
> collection syscall:
> 
> 	int kevent_getevents(int event_fd, struct ukevent *events,
> 		int min_events, int max_events,
> 		struct timeval *timeout);

I used only one syscall for all operations, above syscall is
essentially what kevent_user_wait() does.

> This would look a lot less nutty in strace.  It lets apps specify if
> there is some minimum number of events they'd like the opportunity to
> process rather than waiting for the timeout to expire before the max
> number arrives.  (the latter is what kevent_user_wait() does today).  We
> can have the usual argument about whether *timeout is updated on a
> partial wake-up :).

Sure it can be moved as a different syscall.

> That'd be a fine syscall collection interface, but we should try hard to
> explore being able to collect events without hitting the kernel.
> 
> Say we have a ring of event structs.  AIO has this today, but it sort of
> gets it wrong because each event element doesn't specify whether it is
> owned by the kernel or userspace.  (It really gets it wrong because it
> doesn't flush_dcache_page() after updating the ring via kmap(), but
> never mind that!  No one actually uses this mmap() AIO ring.)  In AIO
> today there is also a control struct mapped along with the ring that has
> head and tail pointers.  We don't want to bounce that cacheline around.
>  net/socket/af_packet.c gets this right with it's tp_status member of
> tpacket_hdr.

When kevent is ready, it is supposed to be "moved" into the userspace,
if it is ready or not is detected through it's list entry for given
list(or just dequeue it).
So there is no need to have a ring of all kevents and select ready from
them (actually kevent has a list of all kevents, and it is possible to
scan it and select for ready ones, but special ready list was created to
speed that process up).

> So as the kernel generates events in the ring it only produces an event
> if the ownership field says that userspace has consumed it and in doing
> so it sets the ownership field to tell userspace that an event is
> waiting.  userspace and the kernel now each follow their index around
> the ring as the ownership field lets them produce or consume the event
> at their index.  Can someone tell me if the cache coherence costs of
> this are extreme?  I'm hoping they're not.
> 
> So, great, glibc can now find pending events very quickly if they're
> waiting in the ring and can fall back to the collection syscall if it
> wants to wait and the ring is empty.  If it consumes events via the
> syscall it increases its ring index by the number the syscall returned.

It can get pending event from ready list - no need to scan the whole
ring. If one wants to wait on special kevent, it is possible to get it
from "main" list and check it's state.
But do we really need that functionality? If user created several
kevents, it was not done just for the sake of kevent creation - user
wants them back, so why he will wait only on special one?
I had an idea about priorities for the kevents, and it can be
implemented as several ready lists though.

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

Hmm, it looks like I'm lost here...
Each kevent can be modified and even reused at any time, no matter if it
is in the ready list or not.

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

There is no problem with lists lengths - when kevent is added, and
queue length is enough, it is autmatically means that all lists will
accept that kevent, since all kevents live simultaneously in several
rings. There are no event generators - only existing, i.e. requested
kevents are confirmed to be ready or not, so system behaves axactly how
user asked it to work with provided requests.
For example inotify will allocate and add to the ring new events each
time they fire, but kevent works in a different way (it's inode
notification) - it checks if there are events for inode creation/removal
and that events are marked as ready - thus no allocations, no problems
with queues -system scales well and does not eat resources, but it has a
problem, that not very much info can be delivered to user when event is
ready (for example no filenames, only inode number can be transferred).

> So how does this sound?  It wouldn't take me long to build this off of
> the current kevent patches.  We could see how it looks..

I especially like idea about world happinness in a week or so :)

> - z

-- 
	Evgeniy Polyakov
