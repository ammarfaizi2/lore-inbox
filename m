Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWHVISQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWHVISQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWHVISP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:18:15 -0400
Received: from sccrmhc15.comcast.net ([63.240.77.85]:50161 "EHLO
	sccrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S932066AbWHVISO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:18:14 -0400
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
From: Nicholas Miell <nmiell@comcast.net>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20060822072448.GA5126@2ka.mipt.ru>
References: <11561555871530@2ka.mipt.ru> <1156230051.8055.27.camel@entropy>
	 <20060822072448.GA5126@2ka.mipt.ru>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 01:17:52 -0700
Message-Id: <1156234672.8055.51.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 11:24 +0400, Evgeniy Polyakov wrote:
> On Tue, Aug 22, 2006 at 12:00:51AM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> > On Mon, 2006-08-21 at 14:19 +0400, Evgeniy Polyakov wrote:
> > > Generic event handling mechanism.
> > 
> > Since this is the sixth[1] event notification system that's getting
> > added to the kernel, could somebody please convince me that the
> > userspace API is right this time? (Evidently, the others weren't and are
> > now just backward compatibility bloat.)
> > 
> > Just looking at the proposed kevent API, it appears that the timer event
> > queuing mechanism can't be used for the queuing of POSIX.1b interval
> > timer events (i.e. via a SIGEV_KEVENT notification value in a struct
> > sigevent) because (being a very thin veneer over the internal kernel
> > timer system) you can't specify a clockid, the time value doesn't have
> > the flexibility of a struct itimerspec (no re-arm timeout or absolute
> > times), and there's no way to alter, disable or query a pending timer or
> > query a timer overrun count.
> > 
> > Overall, kevent timers appear to be inconvenient to use and limited
> > compared to POSIX interval timers (excepting the fact you can read their
> > expiry events out of a queue, of course).
>  
> Kevent timers are just trivial kevent user.
> But even as is it is not that bad solution.
> I, as user, do not want to know which timer is used  - I only need to
> get some signal when interval completed, especially I do not want to
> have some troubles when timer with given clockid has disappeared.
> Kevent timer can be trivially rearmed (acutally it is always rearmed 
> until one-shot flag is set).
> Of course it can be disabled by removing requested kevent.
> I can add possibility to alter timeout without removing kevent if there
> is strong requirement for that.
> 

Is any of this documented anywhere? I'd think that any new userspace
interfaces should have man pages explaining their use and some example
code before getting merged into the kernel to shake out any interface
problems.


> Timer notifications were designed not from committee point of view, when
> theoretical discussions end up in multi-megabyte documentation 99.9% of
> which can not be used without major brain surgery.

Do you have any technical objections to the POSIX.1b interval timer
design to back up your insults?

> I just implemented what I use, if you want more - say what you need.

I don't know what I need, I just know what POSIX already has, and your
extensions don't appear to be compatible with that model and
deliberately designing something that has no hope of ever getting into
the POSIX standard or serving as the basis for whatever comes out of the
standard committee seems rather stupid. (Especially considering that
Linux's only viable competitor has already shipped a unified event
queuing API that does fit into the existing POSIX design.)

Ulrich Drepper is probably better able to speak on this than I am,
considering that he's involved with POSIX and is probably going to be
involved in the Linux libc work, whatever it may be.

>  
> > [1] Previously: select, poll, AIO, epoll, and inotify. Did I miss any?
> 
> Let me guess - kevent, which can do all above and a lot of other things?
> And you forget netlink-based notificators - netlink, rtnetlink,
> gennetlink, connector and tons of accounting application based on them,
> kobject, kobject_uevent.
> There also filessytem based ones - sysfs, procfs, debugfs, relayfs.

OK, so with literally a dozen different interfaces to queue events to
userspace, all of which are apparently inadequate and in need of
replacement by kevent, don't you want to slow down a bit and make sure
that the kevent API is correct before it becomes permanent and then just
has to be replaced *again* ?


-- 
Nicholas Miell <nmiell@comcast.net>

