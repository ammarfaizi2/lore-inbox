Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWJFIgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWJFIgy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 04:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWJFIgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 04:36:54 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:52164 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751044AbWJFIgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 04:36:53 -0400
Date: Fri, 6 Oct 2006 12:36:20 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061006083620.GA28009@2ka.mipt.ru>
References: <115a6230591036@2ka.mipt.ru> <11587449471424@2ka.mipt.ru> <20060927150957.GA18116@2ka.mipt.ru> <a36005b50610032150x8233feqe556fd93bcb5dc73@mail.gmail.com> <20061004045527.GB32267@2ka.mipt.ru> <452363C5.1020505@redhat.com> <20061004074821.GA22688@2ka.mipt.ru> <4523ED6C.9080902@redhat.com> <20061005090214.GB1015@2ka.mipt.ru> <45251A83.9060901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45251A83.9060901@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 06 Oct 2006 12:36:24 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 07:45:23AM -0700, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> > And you can add/remove signal events using existing kevent api between
> > calls.
> 
> That's far more expensive than using a mask under control of the program.

In context you have cut, one updated signal mask between calls to event
delivery mechanism (using for example signal()), so it has exactly the
same price.
 
> > And creating special cases for usual events is bad.
> > There is unified way to deal with events in kevent -
> > add/remove/modify/wait on them, signals are just usual events.
> 
> How can this be unified?  The installment of the temporary signal mask
> is unlike the handling of signal for the purpose of reporting them
> through the signal queue.  It's equally completely new functionality.
> Don't kid yourself in thinking that because this is signal stuff, too,
> you're "unifying" something.  The way this signal mask is used has
> nothing whatsoever to do with the delivering signals via the event
> queue.  For the latter the signals always must be blocked (similar to
> sigwait's requirement).
> 
> As a result it means you want to introduce a new mechanism for the event
> queue instead of using the well known and often used method of
> optionally passing a signal mask to the syscall.  That's just insane.

I created it just because I think that POSIX workaround to add signals
into the syscall parameters is not good enough.
Exactly with the same logic I created kevent to drive AIO completeness,
to work with socket notifications and timers and so on.
All above (listio(), poll(), setitimer() and so on) are known and good 
interfaces, but practice shows that having one interface, which can 
easily work with all existing cases is much more convenient than having 
tons of them.

So, yes, I do introduce new mechanism to solve signal problem here, just
because I think all existing have some limitations or problems.

> > I think you wanted to say, that 'all event mechanism except the most
> > commonly used poll/select/epoll use timespec'.
> 
> Get your facts straight.  select uses timeval which is just the
> predecessor of of timespec.  And epoll is just (badly) designed after
> poll.  Fact is therefore that poll plus its spawn is the only interface
> using such a timeout method.

And it was designed very good, although it looks like we disagree a bit
here...

> > I designed it to be similar to poll(), it is really good interface.
> 
> Not many people agree.  All the interfaces designed (not derived) in the
> last years take a timespec parameter.
> 
> Plus, you chose to ignore all the nice things using a timespec allow you
> like absolute timeout modes etc.  See the clock_nanosleep()  interface
> for a way this can be useful.

You again cut my explanation on why just pure timeout is used.
We start a syscall, which can block forever, so we want to limit it's
time, and we add special parameter to show how long this syscall should
run. Timeout is not about how long we should sleep (which indeed can be
absolute), but how long syscall should run - which is related to the 
time syscall started.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖

-- 
	Evgeniy Polyakov
