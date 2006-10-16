Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWJPKjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWJPKjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWJPKjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:39:51 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:61917 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751493AbWJPKjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:39:49 -0400
Date: Mon, 16 Oct 2006 14:38:48 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061016103848.GE17735@2ka.mipt.ru>
References: <20061004045527.GB32267@2ka.mipt.ru> <452363C5.1020505@redhat.com> <20061004074821.GA22688@2ka.mipt.ru> <4523ED6C.9080902@redhat.com> <20061005090214.GB1015@2ka.mipt.ru> <45251A83.9060901@redhat.com> <20061006083620.GA28009@2ka.mipt.ru> <4532B99B.9030403@redhat.com> <20061016072321.GA17735@2ka.mipt.ru> <45335814.6000903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45335814.6000903@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 16 Oct 2006 14:38:49 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 02:59:48AM -0700, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >One can set number of events before the syscall and do not remove them
> >after syscall. It can be updated if there is need for that.
> 
> Nobody doubts that it is possible.  But it is
> 
> a) potentially much expensive
> 
> and
> 
> b) an alien concept
> 
> to have the signal mask to set during the wait call implicitly. 
> Conceptually it doesn't even make sense.  This is no event to wait for. 
>  It a parameter for the specific wait call, just like the timeout.  And 
> I fortunately haven't seen you proposing to pass the timeout value 
> implicitly.

Because timeout has it's meaning for syscall processing, but signals are
completely separated objects. Why do you want to allow to queue signals
_and_ add 'temporal' signal mask for syscall? Just use one way - queue
them all.
 
> >>Not good enough?  It does exactly what it is supposed to do.  What can 
> >>there be "not good enough"?
> >
> >Not to move signals into special case of events. If poll() can not work
> >with them it does not mean, that they need to be specified as additional
> >syscall parameter, instead change poll() to work with them, which can be
> >easily done with kevents.
> 
> You still seem to be completely missing the point.  The signal mask is 
> no event to wait for.  It has nothing to do with this that ppoll() takes 
> the signal mask as a parameter.  The signal mask is a parameter for the 
> wait call just like the timeout, not more and not less.

That's where we have different opinioins (among others places :) - I do
not agree that signals are parameters for syscall, I insist that is is
usual events. ppoll() shows us that there is no difference between
signal reported as usual user - syscall returns and we can check if
something was changed (signal was delivered or even was fired), it does
not differ from the case when syscall returns and we check what event it
reports first - ready signal or some other event.
 
> >Do not mix warm and soft - waiting for some period is not equal to
> >syscall timeout. Waiting is possible with timer kevent user (although
> >only relative timeout, can be changed to support both, not a big
> >problem).
> 
> That's what I'm saying all the time.  Of course it can be supported. 
> But for this the timeout parameter must be a timespec pointer.  Whatever 
> you could possibly mean by "do not mix warm and soft" I cannot possibly 
> imagine.  Fact is that both relative and absolute timeouts are useful. 
> And that for absolute timeouts the change of the clock has to be taken 
> into account.

They are usefull for special waiting, but not for waiting when syscall
is called. The former is supported by timer notifications, the latter -
by syscall parameter. We can add support for absolute timer
notifications as addon to relative ones. But using there timeval
structure is not accessible, since it has different sizes on different
arches, so there will be problems with 32/64 arches like x86_64.
Instead it is possible to use u32/u32 structure for sec/nsec, like what
is used for relative timeouts.
 
> >I'm quite sure that absolute timeouts are very usefull, but not as in
> >the case of waiting for syscall completeness. In any way, kevent can be
> >extended to support absolute timeouts in it's timer notifications.
> 
> That's not the same.  If you argue that then the syscall should have no 
> timeout parameter at all.  Fact is that setting up a timer is not for 
> free.  Since the timeout is used all the time having a timeout parameter 
> is the right answer.  And if you do this then do it right just like 
> every other syscall other than poll: use a timespec object.  This gives 
> flexibility without measurable cost.

It does not introduce any flexibility, since syscall does not have a
parameter to specify absolute or relative timeout has been provided.
That's one.
I do argue that syscall must have timout parameter, since it is related
to syscall behaviour but not to events syscall is working with - which is
completely different things: syscall must be interrupted after some time
to allow to fail operation or perform other tasks, but timer event can
be fired in any time in the future, syscall should not care about
underlaying events. That's two.
You say "every other syscall other than poll" - but even aio_suspend()
and friends use relative timeouts (although glibc converts them into 
absolute to be used with pthread_cond_timedwait), so why do you propose 
to use wariable sized structure (even if it is transferred almost for 
free in syscall) instead of usual timeout specified in 
seconds/nanoseconds/anything? That's three.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
