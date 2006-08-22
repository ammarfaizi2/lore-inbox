Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWHVURX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWHVURX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 16:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWHVURW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 16:17:22 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:17282 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751226AbWHVURU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 16:17:20 -0400
Date: Wed, 23 Aug 2006 00:16:46 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Nicholas Miell <nmiell@comcast.net>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060822201646.GC3476@2ka.mipt.ru>
References: <11561555871530@2ka.mipt.ru> <1156230051.8055.27.camel@entropy> <20060822072448.GA5126@2ka.mipt.ru> <1156234672.8055.51.camel@entropy> <20060822083711.GA26183@2ka.mipt.ru> <1156238988.8055.78.camel@entropy> <20060822100316.GA31820@2ka.mipt.ru> <1156276658.2476.21.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1156276658.2476.21.camel@entropy>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 23 Aug 2006 00:16:48 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 12:57:38PM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> On Tue, 2006-08-22 at 14:03 +0400, Evgeniy Polyakov wrote:
> > On Tue, Aug 22, 2006 at 02:29:48AM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> > > > > Is any of this documented anywhere? I'd think that any new userspace
> > > > > interfaces should have man pages explaining their use and some example
> > > > > code before getting merged into the kernel to shake out any interface
> > > > > problems.
> > > > 
> > > > There are two excellent articles on lwn.net
> > > 
> > > Google knows of one and it doesn't actually explain how to use kevents.
> > 
> > http://lwn.net/Articles/192964/
> > http://lwn.net/Articles/172844/
> > 
> > In the thread there were enough links to homepage where you can find
> > several examples of how to use kevents (and timers among others) with
> > old interfaces and new ones.
> > 
> 
> Oh, I found both of those. Neither of them told me what values I could
> use in a struct kevent_user_control or what they meant or what any of
> the fields in a struct ukevent or struct kevent_id meant or what I'm
> supposed to pass in kevent_get_event's "void* buf", or many other things
> that I don't remember now. 

Well, I think LWN has very good explaination of what all parameters
mean, but it is possible that there can be some white areas.
No one forbids to look into userspace examples, link to them was posted
a lot of times.

> In short, I'm stuck trying to reverse engineer from the source what the
> API is supposed to be (which might not even be what is actually
> implemented due to the as of yet unfound bug).
> 
> Of course, since you already know how all this stuff is supposed to
> work, you could maybe write it down somewhere?

I will write documantation, but as you can see some interfaces are
changed.

> 
> > > > I will ask just one question, do _you_ propose anything here?
> > > >  
> > > 
> > > struct sigevent sigev = {
> > > 	.sigev_notify = SIGEV_KEVENT,
> > > 	.sigev_kevent_fd = kev_fd,
> > > 	.sigev_value.sival_ptr = &MyCookie
> > > };
> > > 
> > > struct itimerspec its = {
> > > 	.it_value = { ... },
> > > 	.it_interval = { ... }
> > > };
> > > 
> > > struct timespec timeout = { .. };
> > > 
> > > struct ukevent events[max];
> > > 
> > > timer_t timer;
> > > 
> > > timer_create(CLOCK_MONOTONIC, &sigev, &timer);
> > > timer_settime(timer, 0, &its, NULL);
> > > 
> > > /* ... */
> > > 
> > > kevent_get_events(kev_fd, min, max, &timeout, events, 0);
> > > 
> > > 
> > > 
> > > Which isn't all that different from what Ulrich Drepper suggested and
> > > Solaris does right now. (timer_create would probably end up calling
> > > kevent_ctl itself, but it obviously can't do that unless kevents
> > > actually support real interval timers).
> > 
> > Ugh, rtsignals... Their's problems forced me to not implement
> > "interrupt"-like mechanism for kevents in addition to dequeueing.
> > 
> > Anyway, it seems you did not read the whole thread, homepage, lwn and
> > userpsace examples, so you do not understand what kevents are.
> > 
> > They are userspace requests which are returned back when they are ready.
> > It means that userspace must provide something to kernel and ask it to
> > notify when that "something" is ready. For example it can provide a
> > timeout value and ask kernel to fire a timer with it and inform
> > userspace when timeout has expired.
> > It does not matter what timer is used there - feel free to use
> > high-resolution one, usual timer, busyloop or anything else. Main issue 
> > that userspace request must be completed.
> > 
> > What you are trying to do is to put kevents under POSIX API.
> > That means that those kevents can not be read using
> > kevent_get_events(), basicaly because there are no user-known kevents,
> > i.e. user has not requested timer, so it should not receive it's
> > notifications (otherwise it will receive everything requested by other
> > threads and other issues, i.e. how to differentiate timer request made
> > by timer_create(), which is not supposed to be caught by
> > kevent_get_events()).
> > 
> 
> I have no idea what you're trying to say here. I've created a timer,
> specified which kevent queue I want it's expiry notification delivered
> to, and armed it. Where have I not specified enough information to
> request the reception of timer notifications?

You can do it with kevent timer notifications. Easily.
I've even attached simple program for that.

> Also, differentiating timers made by timer_create() that aren't supposed
> to deliver events via kevent_get_events() is easy -- their .sigev_notify
> isn't SIGEV_KEVENT.

What should be returned to user? What should be placed into user's data,
into id? How user can determine that given event fires after which
initial value?
Finally, if you think that kevents should use different API for
different events, think about complicated userspace code which must know
tons of syscalls for the same task.

> > You could implement POSIX timer _fully_ on top of kevents, i.e. both
> > create and read, for example network AIO is implemented in that way -
> > there is a system calls aio_send()/aio_recv() and aio_sendfile() which
> > create kevent internally and then get it's readiness notifications over
> > provided callback, process data and finally remove kevent,
> > so POSIX timers could create timer kevent, wait until it is ready, in
> > completeness callback it would call signal delivering mechanism...
> > 
> 
> Yes, but that would be stupid. The kernel already has a fully functional
> POSIX timer implementation, so throwing it out to reimplement it using
> kevents would be a waste of effort, especially considering that your
> kevent timers can't fully express a POSIX interval timer.
> 
> Now, if there were some way for me to ask that an interval timer queue
> it's expiry notices into a kevent queue, that would combine the best of
> both worlds.

Just use kevents directly without POSIX timers at all.
It is possible to add there high-resolution timers.

> > But there are no reading mechanism in POSIX timers (I mean not reading
> > pending timeout values or remaining time), they use signals for 
> > completeness delivering... So where do you want to put kevent's
> > userspace there?
> > 
> 
> The goal of this proposal is to extend sigevent completions to include
> kevent queues along with signals and created threads, exactly because
> thread creation is too heavy and signals are a pain to use.

What you propose is completely new mechanism - it is implemented inside
kevent timer notifications expect that API does not match POSIX one.

> > What you are trying to achive is not POSIX timers in any way, you want
> > completely new machanism which has similar to POSIX API, and I give it to
> > you (well, with API which can be used not only with timers, but with any 
> > other type of notifications you like). 
> > You need clockid_t? Put it in raw.id[0] and make kevent_timer_enqueue()
> > callback select different type of timers.
> > What else?
> 
> No, it's still POSIX timers -- the vast majority of the API is the same,
> they just report their completion differently.

POSIX timers are just a API over in-kernel timers.
Kevent provides different and much more convenient API (since you want
to not use signals but kevent's queue), so where are those similar
things?
How will you change a timer from POSIX syscall, when it completely does
not know about kevents, there will be racess, so you need to
change POSIX API (it's internal part which works with timers).
If you are going to change internal part of POSIX timers implementatin
and add new syscall into your userspace program, you can just switch to
the new API entirely, since right now I do not see any major problems in
kevent timer implementation (expect that it does not use high-res
timers, which were not included into kernel when kevents were created).

> -- 
> Nicholas Miell <nmiell@comcast.net>

-- 
	Evgeniy Polyakov
