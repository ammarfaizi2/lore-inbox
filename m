Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWHVJaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWHVJaS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 05:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWHVJaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 05:30:18 -0400
Received: from sccrmhc12.comcast.net ([63.240.77.82]:47745 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751262AbWHVJaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 05:30:17 -0400
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
From: Nicholas Miell <nmiell@comcast.net>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20060822083711.GA26183@2ka.mipt.ru>
References: <11561555871530@2ka.mipt.ru> <1156230051.8055.27.camel@entropy>
	 <20060822072448.GA5126@2ka.mipt.ru> <1156234672.8055.51.camel@entropy>
	 <20060822083711.GA26183@2ka.mipt.ru>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 02:29:48 -0700
Message-Id: <1156238988.8055.78.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 12:37 +0400, Evgeniy Polyakov wrote:
> On Tue, Aug 22, 2006 at 01:17:52AM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> > On Tue, 2006-08-22 at 11:24 +0400, Evgeniy Polyakov wrote:
> > > On Tue, Aug 22, 2006 at 12:00:51AM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> > > > On Mon, 2006-08-21 at 14:19 +0400, Evgeniy Polyakov wrote:
> > > > > Generic event handling mechanism.
> > > > 
> > > > Since this is the sixth[1] event notification system that's getting
> > > > added to the kernel, could somebody please convince me that the
> > > > userspace API is right this time? (Evidently, the others weren't and are
> > > > now just backward compatibility bloat.)
> > > > 
> > > > Just looking at the proposed kevent API, it appears that the timer event
> > > > queuing mechanism can't be used for the queuing of POSIX.1b interval
> > > > timer events (i.e. via a SIGEV_KEVENT notification value in a struct
> > > > sigevent) because (being a very thin veneer over the internal kernel
> > > > timer system) you can't specify a clockid, the time value doesn't have
> > > > the flexibility of a struct itimerspec (no re-arm timeout or absolute
> > > > times), and there's no way to alter, disable or query a pending timer or
> > > > query a timer overrun count.
> > > > 
> > > > Overall, kevent timers appear to be inconvenient to use and limited
> > > > compared to POSIX interval timers (excepting the fact you can read their
> > > > expiry events out of a queue, of course).
> > >  
> > > Kevent timers are just trivial kevent user.
> > > But even as is it is not that bad solution.
> > > I, as user, do not want to know which timer is used  - I only need to
> > > get some signal when interval completed, especially I do not want to
> > > have some troubles when timer with given clockid has disappeared.
> > > Kevent timer can be trivially rearmed (acutally it is always rearmed 
> > > until one-shot flag is set).
> > > Of course it can be disabled by removing requested kevent.
> > > I can add possibility to alter timeout without removing kevent if there
> > > is strong requirement for that.
> > > 
> > 
> > Is any of this documented anywhere? I'd think that any new userspace
> > interfaces should have man pages explaining their use and some example
> > code before getting merged into the kernel to shake out any interface
> > problems.
> 
> There are two excellent articles on lwn.net

Google knows of one and it doesn't actually explain how to use kevents.


> > 
> > OK, so with literally a dozen different interfaces to queue events to
> > userspace, all of which are apparently inadequate and in need of
> > replacement by kevent, don't you want to slow down a bit and make sure
> > that the kevent API is correct before it becomes permanent and then just
> > has to be replaced *again* ?
> 
> I only though that license issues remains unresolved in that
> linux-kernel@ flood, but not, I was wrong :)
> 
> I will ask just one question, do _you_ propose anything here?
>  

struct sigevent sigev = {
	.sigev_notify = SIGEV_KEVENT,
	.sigev_kevent_fd = kev_fd,
	.sigev_value.sival_ptr = &MyCookie
};

struct itimerspec its = {
	.it_value = { ... },
	.it_interval = { ... }
};

struct timespec timeout = { .. };

struct ukevent events[max];

timer_t timer;

timer_create(CLOCK_MONOTONIC, &sigev, &timer);
timer_settime(timer, 0, &its, NULL);

/* ... */

kevent_get_events(kev_fd, min, max, &timeout, events, 0);



Which isn't all that different from what Ulrich Drepper suggested and
Solaris does right now. (timer_create would probably end up calling
kevent_ctl itself, but it obviously can't do that unless kevents
actually support real interval timers).

-- 
Nicholas Miell <nmiell@comcast.net>

