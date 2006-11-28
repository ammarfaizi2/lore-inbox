Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935858AbWK1LEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935858AbWK1LEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 06:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935853AbWK1LEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 06:04:15 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:21453 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S935858AbWK1LEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 06:04:14 -0500
Date: Tue, 28 Nov 2006 14:00:47 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061128110047.GG15083@2ka.mipt.ru>
References: <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com> <20061122103828.GA11480@2ka.mipt.ru> <4564CD97.20909@redhat.com> <20061123121838.GC20294@2ka.mipt.ru> <45661F50.9020007@redhat.com> <20061124105725.GD13600@2ka.mipt.ru> <456B3895.9090207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <456B3895.9090207@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 28 Nov 2006 14:00:49 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 11:12:21AM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >It just sets hrtimer with abs time and sleeps - it can achieve the same
> >goals using similar to wait_event() mechanism.
> 
> I don't follow.  Of course it is somehow possible to wait until an 
> absolute deadline.  But it's not part of the parameter list and hence 
> easily and _quickly_ usable.

I just described how it is implemented in futex. I will create the same
approach - hrtimer which will wakeup wait_event() with infinite timeout.
 
> >>>Btw, do you propose to change all users of wait_event()?
> >>Which users?
> >
> >Any users which use wait_event() or schedule_timeout(). Futex for
> >example - it perfectly ok lives with relative timeouts provided to
> >schedule_timeout() - the same (roughly saying of course) is done in kevent.
> 
> No, it does not live perfectly OK with relative timeouts.  The userlevel 
> implementation is actually wrong because of this in subtle ways.  Some 
> futex interfaces take absolute timeouts and they have to be interrupted 
> if the realtime clock is set forward.
> 
> Also, the calls are complicated and slow because the userlevel wrapper 
> has to call clock_gettime/gettimeofday before each futex syscall.  If 
> the kernel would accept absolute timeouts as well we would save a 
> syscall and have actually a correct implementation.

It is only done for LOCK_PI case, which was specially created to have
absolute timeout, i.e. futex does not need it, but there is an option.

I will extend waiting syscalls to have timespec and absolute timeout,
I'm just want to stop this (I hope you agree) stupid endless arguing
about completely unimportant thing.
 
> >I think I said already several times that absolute timeouts are not
> >related to syscall execution process. But you seems to not hear me and
> >insist.
> 
> Because you're wrong.  For your use cases it might not be but it's not 
> true in general.  And your interface is preventing it from being 
> implemented forever.

Because I'm right and it will not be used :)
Well, it does not matter anymore, right?
 
> >Ok, I will change waiting syscalls to have 'flags' parameter and 'struct
> >timespec' as timeout parameter. Special bit in flags will result in
> >additional timer setup which will fire after absolute timeout and will
> >wake up those who wait...
> 
> Thanks a lot.

No problem - I always like to spend couple of month arguing about taste
and 'right-from-my-point-of-view' theories - doesn't it the best way to
waste the time?

...

> >Having sigmask parameter is the same as creating kevent signal delivery.
> 
> No, no, no.  Not at all.

I've dropped a lot, but let me describe signal mask problem in few
words: signal mask provided in sys_pselect() and friends is a mask of
signals, which will be put into blocked mask in the task structure in
kernel. When new signal is going to be delivered, signal number is being
checked if it is in blocked mask, and if so, signal is not put into
pending mask of signals, which ends up in not being delivered to
userspace. Kevent (with special flag) does exactly the same - but it
does not update blocked mask, but instead adds another check if signal
is in kevent set of requests, in that case signal is delivered to
userspace through kevent queue.

It is _exactly_ the same behaviour from userspace point of view
concerning race of delivery signal versus file descriptor readyness.
Exactly.

Here is code snippet:
specific_send_sig_info()
{
	...
	/* Short-circuit ignored signals.  */
	if (sig_ignored(t, sig))
		goto out;
	...
	ret = send_signal(sig, info, t, &t->pending);
	if (!ret && !sigismember(&t->blocked, sig))
		signal_wake_up(t, sig == SIGKILL);
#ifdef CONFIG_KEVENT_SIGNAL
	/*
	 * Kevent allows to deliver signals through kevent queue,
	 * it is possible to setup kevent to not deliver
	 * signal through the usual way, in that case send_signal()
	 * returns 1 and signal is delivered only through kevent queue.
	 * We simulate successfull delivery notification through this hack:
	 */
	 if (ret == 1)
	 	ret = 0;
#endif
out:
	return ret;
}

> >>Surely you don't suggest keeping your original timer patch?
> >
> >Of course not - kevent timers are more scalable than posix timers (the 
> >latter uses idr, which is slower than balanced binary tree, since it
> >looks like it uses similar to radix tree algo), POSIX interface is 
> >much-much-much more unconvenient to use than simple add/wait.
> 
> I assume you misread the question.  You agree to drop the patch and then 
>  go on listing things why you think it's better to keep them.  I don't 
> think these arguments are in any way sufficient.  The interface is 
> already too big and this is 100% duplicate functionality.  If there are 
> performance problems with the POSIX timer implementation (and I have yet 
> to see indications) it should be fixed instead of worked around.

I do _not_ agree to drop kevent timer patch (not posix timer), since
from my point of view it is much more convenient interface, it is more
scalable, it is generic enough to be used with other kevent methods.

But anyway, we can spend awfull lot of time arguing about taste, which
is definitely _NOT_ what we want. So, there are two worlds - posix
timers and usual timers, accessible from userspace, first one through
create_timer() and friends, second one with kevent interface.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
