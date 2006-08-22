Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWHVIiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWHVIiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWHVIiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:38:07 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:9195 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751360AbWHVIiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:38:05 -0400
Date: Tue, 22 Aug 2006 12:37:11 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Nicholas Miell <nmiell@comcast.net>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060822083711.GA26183@2ka.mipt.ru>
References: <11561555871530@2ka.mipt.ru> <1156230051.8055.27.camel@entropy> <20060822072448.GA5126@2ka.mipt.ru> <1156234672.8055.51.camel@entropy>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1156234672.8055.51.camel@entropy>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 22 Aug 2006 12:37:16 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 01:17:52AM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> On Tue, 2006-08-22 at 11:24 +0400, Evgeniy Polyakov wrote:
> > On Tue, Aug 22, 2006 at 12:00:51AM -0700, Nicholas Miell (nmiell@comcast.net) wrote:
> > > On Mon, 2006-08-21 at 14:19 +0400, Evgeniy Polyakov wrote:
> > > > Generic event handling mechanism.
> > > 
> > > Since this is the sixth[1] event notification system that's getting
> > > added to the kernel, could somebody please convince me that the
> > > userspace API is right this time? (Evidently, the others weren't and are
> > > now just backward compatibility bloat.)
> > > 
> > > Just looking at the proposed kevent API, it appears that the timer event
> > > queuing mechanism can't be used for the queuing of POSIX.1b interval
> > > timer events (i.e. via a SIGEV_KEVENT notification value in a struct
> > > sigevent) because (being a very thin veneer over the internal kernel
> > > timer system) you can't specify a clockid, the time value doesn't have
> > > the flexibility of a struct itimerspec (no re-arm timeout or absolute
> > > times), and there's no way to alter, disable or query a pending timer or
> > > query a timer overrun count.
> > > 
> > > Overall, kevent timers appear to be inconvenient to use and limited
> > > compared to POSIX interval timers (excepting the fact you can read their
> > > expiry events out of a queue, of course).
> >  
> > Kevent timers are just trivial kevent user.
> > But even as is it is not that bad solution.
> > I, as user, do not want to know which timer is used  - I only need to
> > get some signal when interval completed, especially I do not want to
> > have some troubles when timer with given clockid has disappeared.
> > Kevent timer can be trivially rearmed (acutally it is always rearmed 
> > until one-shot flag is set).
> > Of course it can be disabled by removing requested kevent.
> > I can add possibility to alter timeout without removing kevent if there
> > is strong requirement for that.
> > 
> 
> Is any of this documented anywhere? I'd think that any new userspace
> interfaces should have man pages explaining their use and some example
> code before getting merged into the kernel to shake out any interface
> problems.

There are two excellent articles on lwn.net
 
> > Timer notifications were designed not from committee point of view, when
> > theoretical discussions end up in multi-megabyte documentation 99.9% of
> > which can not be used without major brain surgery.
> 
> Do you have any technical objections to the POSIX.1b interval timer
> design to back up your insults?

POSIX timers can have any design, but do not force others to use the
same.

> > I just implemented what I use, if you want more - say what you need.
> 
> I don't know what I need, I just know what POSIX already has, and your

And I do know what I need, that is why I do it.

> extensions don't appear to be compatible with that model and
> deliberately designing something that has no hope of ever getting into
> the POSIX standard or serving as the basis for whatever comes out of the
> standard committee seems rather stupid. (Especially considering that
> Linux's only viable competitor has already shipped a unified event
> queuing API that does fit into the existing POSIX design.)

I think I even know what it is :)

> Ulrich Drepper is probably better able to speak on this than I am,
> considering that he's involved with POSIX and is probably going to be
> involved in the Linux libc work, whatever it may be.

Feel free to use POSIX timers, but do not force others to it too.

> >  
> > > [1] Previously: select, poll, AIO, epoll, and inotify. Did I miss any?
> > 
> > Let me guess - kevent, which can do all above and a lot of other things?
> > And you forget netlink-based notificators - netlink, rtnetlink,
> > gennetlink, connector and tons of accounting application based on them,
> > kobject, kobject_uevent.
> > There also filessytem based ones - sysfs, procfs, debugfs, relayfs.
> 
> OK, so with literally a dozen different interfaces to queue events to
> userspace, all of which are apparently inadequate and in need of
> replacement by kevent, don't you want to slow down a bit and make sure
> that the kevent API is correct before it becomes permanent and then just
> has to be replaced *again* ?

I only though that license issues remains unresolved in that
linux-kernel@ flood, but not, I was wrong :)

I will ask just one question, do _you_ propose anything here?
 
> -- 
> Nicholas Miell <nmiell@comcast.net>

-- 
	Evgeniy Polyakov
