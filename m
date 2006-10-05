Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWJEI6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWJEI6g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWJEI6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:58:36 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:7634 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751523AbWJEI6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:58:35 -0400
Date: Thu, 5 Oct 2006 12:57:50 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take19 1/4] kevent: Core files.
Message-ID: <20061005085750.GA1015@2ka.mipt.ru>
References: <11587449471424@2ka.mipt.ru> <1158744950130@2ka.mipt.ru> <a36005b50610032334n50e66198rdfef30e4ccf545c8@mail.gmail.com> <20061004064855.GA1981@2ka.mipt.ru> <a36005b50610041057g67dcaf73wd48d9fef88187ec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <a36005b50610041057g67dcaf73wd48d9fef88187ec6@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 05 Oct 2006 12:57:52 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 10:57:32AM -0700, Ulrich Drepper (drepper@gmail.com) wrote:
> On 10/3/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >http://tservice.net.ru/~s0mbre/archive/kevent/evserver_kevent.c
> >http://tservice.net.ru/~s0mbre/archive/kevent/evtest.c
> 
> These are simple programs which by themselves have problems.  For
> instance, I consider a very bad idea to hardcode the size of the ring
> buffer.  Specifying macros in the header file counts as hardcoding.
> Systems grow over time and so will the demand of connections.  I have
> no problem with the kernel hardcoding the value internally (or having
> a /proc entry to select it) but programs should be able to dynamically
> learn about the value so they don't have to be recompiled.

Well, it is possible to create /sys/proc entry for that, and even now 
userspace can grow mapping ring until it is forbiden by kernel, which
means limit is reached.

Actually the whole idea with global limit of kevents does not sound very
good to me, but it is required to remove overflow in mapped buffer.

> But more problematic is that I don't see how the interfaces can be
> efficiently used in multi-threaded (or multi-process) programs.  How
> would multiple threads using the same kevent queue and running in the
> same kevent_get_events() loop work out?  How do they guarantee that
> each request is only handled once?

kqueue_dequeue_ready() is atomic and this function removes kevent from
ready queue so other thread can not get it.

> From what I see now this means a second data structure is needed to
> keep track of the state of each entry.  But even then, how do we even
> recognized used ring buffer entries?
> 
> For instance, assume two threads.  Both call get_events, one event is
> reported, both threads are woken up (which is another thing to
> consider, more later).  One thread uses ring buffer entry, the other
> goes back to sleep in get_events.  Now, how does the kernel know when
> the other thread is done working on the ring buffer entry?  There
> might be lots of entries coming in overflowing the entire buffer.
> Heck, you don't even need two threads for this scenario.

Are you talking about mapped buffer or syscall interface?
The former has special syscall kevent_wait(), which reports number of
'processed' events and first processed number, so kernel can remove all
appropriate events. The latter is described above -
kqueue_dequeue_ready() is atomic, so that event will be removed from the
ready queue and optionally from the whole kevent tree.

It is possible to work with both interfaces at the same time, since
mapped buffer contains a copy of the event, which is potentially freed
and processed by other thread. 

Actually I do not like idea of mapped ring anyway, since if application 
uses a lot of events, it will batch them into big chunks, so syscall 
overhead is negligible, if application uses small number of events, 
syscalls will be rare and will not hurt performance.

> When I was thinking about this (and discussing it in Ottawa) I was
> always assuming that we have a status field in the ring buffer entry
> which lets the userlevel code indicate whether the entry is free again
> or not.  This requires a writable mapping, yes, and potentially causes
> cache line ping-pong.  I think Zach mentioned he has some ideas about
> this.

As far as I can see, there are no other ideas on how to implement ring
buffer, so I did it like I wanted. It has some limitation indeed, but
since I do not see any other code, how can I say what is better or
worse?
 
> As for the multiple thread wakeup, I mentioned this before.  We have
> to avoid the trampling herd problem.  We cannot wakeup all waiters.
> But we also cannot assume that, without protocols, waking up just one
> for each available entry is sufficient.  So the first question is:
> what is the current policy?

It is a good practice to _not_ share the same queue between a lot of
threads. Currently all waiters are awakened.

> >AIO was removed from patchset by request of Cristoph.
> >Timers, network AIO, fs AIO, socket nortifications and poll/select
> >events work well with existing structures.
> 
> Well, excuse me if I don't take your word for it.  I agree, the AIO
> code should not be submitted along with this.  The same for any other
> code using the event handling.  But we need to check whether the
> interface is generic enough to accomodate them in a way which actually
> makes sense.  Again, think highly threaded processes or multiple
> processes sharing the same event queue.

You missed the point.
I implemented _all_ above and it does work.
Although it was removed from submission patchset.
You can find all patches on kevent homepage, they were posted to lkml@
and netdev@ too many times to miss them.
 
> >It is even possible to create variable sized kevents - each kevent
> >contain pointer to user's data, which can be considered as pointer to
> >additional area (it's size kernel implementation for given kevent type
> >can determine from other parameters or use predefined one and fetch
> >additional data in ->enqueue() callback).
> 
> That sounds interesting and certainly helps with securing the
> interface for the future.  But if there is anything we can do to avoid
> unnecessary costs we should do it, even if this means investigation
> all this further.

Ulrich, do _you_ have any ideas on how to change data structures?
Not talks about investigations and the like, but real design which
covers today's and tomorrow's needs?

Existing structures were not taken from the universe, but are result of
quite long thoughts about requests for AIO/epoll and networking
development...

-- 
	Evgeniy Polyakov
