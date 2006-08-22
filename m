Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWHVVNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWHVVNk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 17:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWHVVNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 17:13:40 -0400
Received: from alnrmhc11.comcast.net ([204.127.225.91]:25265 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751049AbWHVVNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 17:13:36 -0400
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
From: Nicholas Miell <nmiell@comcast.net>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20060822201646.GC3476@2ka.mipt.ru>
References: <11561555871530@2ka.mipt.ru> <1156230051.8055.27.camel@entropy>
	 <20060822072448.GA5126@2ka.mipt.ru> <1156234672.8055.51.camel@entropy>
	 <20060822083711.GA26183@2ka.mipt.ru> <1156238988.8055.78.camel@entropy>
	 <20060822100316.GA31820@2ka.mipt.ru> <1156276658.2476.21.camel@entropy>
	 <20060822201646.GC3476@2ka.mipt.ru>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 14:13:02 -0700
Message-Id: <1156281182.2476.63.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 00:16 +0400, Evgeniy Polyakov wrote:
> On Tue, Aug 22, 2006 at 12:57:38PM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> > On Tue, 2006-08-22 at 14:03 +0400, Evgeniy Polyakov wrote:
> > Of course, since you already know how all this stuff is supposed to
> > work, you could maybe write it down somewhere?
> 
> I will write documantation, but as you can see some interfaces are
> changed.

Thanks; rapidly changing interfaces need good documentation even more
than stable interfaces simply because reverse engineering the intended
API from a changing implementation becomes even more difficult.

> > > > > I will ask just one question, do _you_ propose anything here?
> > > > 
> > > > struct sigevent sigev = {
> > > > 	.sigev_notify = SIGEV_KEVENT,
> > > > 	.sigev_kevent_fd = kev_fd,
> > > > 	.sigev_value.sival_ptr = &MyCookie
> > > > };
> > > > 
> > > > struct itimerspec its = {
> > > > 	.it_value = { ... },
> > > > 	.it_interval = { ... }
> > > > };
> > > > 
> > > > struct timespec timeout = { .. };
> > > > 
> > > > struct ukevent events[max];
> > > > 
> > > > timer_t timer;
> > > > 
> > > > timer_create(CLOCK_MONOTONIC, &sigev, &timer);
> > > > timer_settime(timer, 0, &its, NULL);
> > > > 
> > > > /* ... */
> > > > 
> > > > kevent_get_events(kev_fd, min, max, &timeout, events, 0);
> > > > 
> > > > 
> > > > 
> > > > Which isn't all that different from what Ulrich Drepper suggested and
> > > > Solaris does right now. (timer_create would probably end up calling
> > > > kevent_ctl itself, but it obviously can't do that unless kevents
> > > > actually support real interval timers).
> > > 
> > > Ugh, rtsignals... Their's problems forced me to not implement
> > > "interrupt"-like mechanism for kevents in addition to dequeueing.
> > > 
> > > Anyway, it seems you did not read the whole thread, homepage, lwn and
> > > userpsace examples, so you do not understand what kevents are.
> > > 
> > > They are userspace requests which are returned back when they are ready.
> > > It means that userspace must provide something to kernel and ask it to
> > > notify when that "something" is ready. For example it can provide a
> > > timeout value and ask kernel to fire a timer with it and inform
> > > userspace when timeout has expired.
> > > It does not matter what timer is used there - feel free to use
> > > high-resolution one, usual timer, busyloop or anything else. Main issue 
> > > that userspace request must be completed.
> > > 
> > > What you are trying to do is to put kevents under POSIX API.
> > > That means that those kevents can not be read using
> > > kevent_get_events(), basicaly because there are no user-known kevents,
> > > i.e. user has not requested timer, so it should not receive it's
> > > notifications (otherwise it will receive everything requested by other
> > > threads and other issues, i.e. how to differentiate timer request made
> > > by timer_create(), which is not supposed to be caught by
> > > kevent_get_events()). 
> > 
> > I have no idea what you're trying to say here. I've created a timer,
> > specified which kevent queue I want it's expiry notification delivered
> > to, and armed it. Where have I not specified enough information to
> > request the reception of timer notifications?
> 
> You can do it with kevent timer notifications. Easily.
> I've even attached simple program for that.

You forgot to attach the program.

> > Also, differentiating timers made by timer_create() that aren't supposed
> > to deliver events via kevent_get_events() is easy -- their .sigev_notify
> > isn't SIGEV_KEVENT.
> 
> What should be returned to user? 
> What should be placed into user's data, into id? 

The cookie I passed in -- in this example, it was &MyCookie.

> How user can determine that given event fires after which
> initial value?

I don't know what this means.

> Finally, if you think that kevents should use different API for
> different events, think about complicated userspace code which must know
> tons of syscalls for the same task.

I don't think cramming everything together into the same syscall is any
better. In fact, a series of discrete, easy-to-understand function calls
is a hell of a lot easier to deal with than a single call that takes an
array of large multi-purpose structures, especially when most of those
function calls have standard specified behavior.

In fact, I doubt anything will *ever* use kevents directly -- it's
either going to be something like libevent which wraps this stuff
portably or the app's own portability layer or GLib's event loop or
something else that abstracts away the fact that nobody can agree on
what the primitives for a unified event loop should be. There's nothing
like another layer of indirection to solve your problems.

> > > You could implement POSIX timer _fully_ on top of kevents, i.e. both
> > > create and read, for example network AIO is implemented in that way -
> > > there is a system calls aio_send()/aio_recv() and aio_sendfile() which
> > > create kevent internally and then get it's readiness notifications over
> > > provided callback, process data and finally remove kevent,
> > > so POSIX timers could create timer kevent, wait until it is ready, in
> > > completeness callback it would call signal delivering mechanism...
> > 
> > Yes, but that would be stupid. The kernel already has a fully functional
> > POSIX timer implementation, so throwing it out to reimplement it using
> > kevents would be a waste of effort, especially considering that your
> > kevent timers can't fully express a POSIX interval timer.
> > 
> > Now, if there were some way for me to ask that an interval timer queue
> > it's expiry notices into a kevent queue, that would combine the best of
> > both worlds.
> 
> Just use kevents directly without POSIX timers at all.
> It is possible to add there high-resolution timers.

So the existing kevent API is currently incomplete?

> > > But there are no reading mechanism in POSIX timers (I mean not reading
> > > pending timeout values or remaining time), they use signals for 
> > > completeness delivering... So where do you want to put kevent's
> > > userspace there?
> > 
> > The goal of this proposal is to extend sigevent completions to include
> > kevent queues along with signals and created threads, exactly because
> > thread creation is too heavy and signals are a pain to use.
> 
> What you propose is completely new mechanism - it is implemented inside
> kevent timer notifications expect that API does not match POSIX one.

A completely new delivery mechanism, yes. The rest of the API for timer
creation, arming, query, destruction, etc. remains the same.

This is opposed to the completely new mechanism for delivery, creation,
arming, query, destruction, etc. that is the currently proposed kevents
timer interface.

> > > What you are trying to achive is not POSIX timers in any way, you want
> > > completely new machanism which has similar to POSIX API, and I give it to
> > > you (well, with API which can be used not only with timers, but with any 
> > > other type of notifications you like). 
> > > You need clockid_t? Put it in raw.id[0] and make kevent_timer_enqueue()
> > > callback select different type of timers.
> > > What else?
> > 
> > No, it's still POSIX timers -- the vast majority of the API is the same,
> > they just report their completion differently.
> 
> POSIX timers are just a API over in-kernel timers.
> Kevent provides different and much more convenient API (since you want
> to not use signals but kevent's queue), so where are those similar
> things?

I don't think you have established the kevent timer API's convenience
yet (beyond the fact that it doesn't use signals, which everybody
wants).

> How will you change a timer from POSIX syscall, when it completely does
> not know about kevents, there will be racess, so you need to
> change POSIX API (it's internal part which works with timers).

Yes, the kernel's POSIX timer implementation will need to be altered so
that it can queue timer completion events to a kevent queue.

> If you are going to change internal part of POSIX timers implementatin
> and add new syscall into your userspace program, you can just switch to
> the new API entirely, since right now I do not see any major problems in
> kevent timer implementation (expect that it does not use high-res
> timers, which were not included into kernel when kevents were created).

Switching an entire program away from POSIX interval timers would be
more work then the modifications necessary to switch only it's timer
delivery mechanism, especially when the new timer system doesn't have
documentation and isn't as functional as the old.

And of course you don't see any major problems in the kevent timer
implementation -- if you did, you would have fixed them already.
However, that doesn't mean that they don't exist.

-- 
Nicholas Miell <nmiell@comcast.net>

