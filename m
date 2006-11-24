Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755680AbWKXK6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755680AbWKXK6u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 05:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757388AbWKXK6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 05:58:50 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:7606 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1756249AbWKXK6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 05:58:49 -0500
Date: Fri, 24 Nov 2006 13:57:25 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061124105725.GD13600@2ka.mipt.ru>
References: <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com> <20061122103828.GA11480@2ka.mipt.ru> <4564CD97.20909@redhat.com> <20061123121838.GC20294@2ka.mipt.ru> <45661F50.9020007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45661F50.9020007@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Nov 2006 13:57:26 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 02:23:12PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >On Wed, Nov 22, 2006 at 02:22:15PM -0800, Ulrich Drepper 
> >(drepper@redhat.com) wrote:
> >Timeouts are not about AIO or any other event types (there are a lot of
> >them already as you can see), it is only about syscall itself.
> >Please point me to _any_ syscall out there which uses absolute time
> >(except settimeofday() and similar syscalls).
> 
> futex(FUTEX_LOCK_PI).

It just sets hrtimer with abs time and sleeps - it can achieve the same
goals using similar to wait_event() mechanism.
 
> >Btw, do you propose to change all users of wait_event()?
> 
> Which users?

Any users which use wait_event() or schedule_timeout(). Futex for
example - it perfectly ok lives with relative timeouts provided to
schedule_timeout() - the same (roughly saying of course) is done in kevent.

> >Interface is not restricted, it is just different from what you want it
> >to be, and you did not show why it requires changes.
> 
> No, it is restricted because I cannot express something like an absolute 
> timeout/deadline.  If the parameter would be a struct timespec* then at 
> any time we can implement either relative timeouts w/ and w/out 
> observance of settimeofday/ntp and absolute timeouts.  This is what 
> makes the interface generic and unrestricted while your current version 
> cannot be used for the latter.

I think I said already several times that absolute timeouts are not
related to syscall execution process. But you seems to not hear me and
insist.

Ok, I will change waiting syscalls to have 'flags' parameter and 'struct
timespec' as timeout parameter. Special bit in flags will result in
additional timer setup which will fire after absolute timeout and will
wake up those who wait...
 
> >kevent signal registering is atomic with respect to other kevent
> >syscalls: control syscalls are protected by mutex and waiting syscalls
> >work with queue, which is protected by appropriate lock.
> 
> It is about atomicity wrt to the signal mask manipulation which would 
> have to precede the kevent_wait call and the call itself (and 
> registering a signal for kevent delivery).  This is not atomic.

If signal mask is updated from userspace it should be done through
kevent - add/remove different kevent signals. Signal mask of pending
signals is not updated for special kevent signals.

> >Let me formulate signal problem here, please point me if it is correct
> >or not.
> 
> There are a myriad of different scenarios, it makes no sense to pick 
> one.  The interface must be generic to cover them all, I don't know how 
> often I have to repeat this.

The whole signal mask was added by POSXI exactly for that single
practical race in the event dispatching mechanism, which can not handle
other types of events like signals.
 
> >User registers some async signal notifications and calls poll() waiting
> >for some file descriptors to became ready. When it is interrupted there
> >is no knowledge about what really happend first - signal was delivered
> >or file descriptor was ready.
> 
> The order is unimportant.  You change the signal mask, for instance, if 
> the time when a thread is waiting in poll() is the only time when a 
> signal can be handled.  Or vice versa, it's the time when signals are 
> not wanted.  And these are per-thread decisions.
> 
> Signal handlers and kevent registrations for signals are process-wide 
> decisions.  And furthermore: with kevent delivered signals there is no 
> signal mask anymore (at least you seem to not check it).  Even if this 
> would be done it doesn't change the fact that you cannot use signals the 
> way many programs want to.

There is major contradiction here - you say that programmers will use
old-style signal delivery and want me to add signal mask to prevent that
delivery, so signals would be in blocked mask, when I say that current kevent 
signal delivery does not update pending signal mask, which is the same as
putting signals into blocked mask, you say that it is not what is
required.

> Fact is that without a signal queue you cannot implement the above 
> cases.  You cannot block/unblock a signal for a specific thread.  You 
> also cannot work together with signals which cannot be delivered through 
> kevent.  This is the case for existing code in a program which happens 
> to use also kevent and it is the case if there is more than one possible 
> recipient.  With kevent signals can be attached to one kevent queue only 
> but the recipients (different threads or only different parts of a 
> program) need not use the same kevent queue.

Signal queue is replaced with kevent queue, and it is in sync with all
other kevents.
Programmers which want to use kevents will use kevents (if miracle will
happend and we agree that kevent is good for inclusion), and programmers
will know how kevent signal delivery works.

> I've said from the start that you cannot possibly expect that programs 
> are not using signal delivery in the current form.  And the complete 
> loss of blocking signals for individual threads makes the kevent-based 
> signal delivery incomplete (in a non-fixable form) anyway.

Having sigmask parameter is the same as creating kevent signal delivery.

And, btw, programmers can change signal mask before calling syscall,
since in the syscall there is a gap between start and sigprocmask()
call.

> >In case it is, let me explain why this situation can not happen with
> >kevent: since signals are not delivered in the old way, but instead they
> >are queued into the same queue where file descriptors are, and queueing
> >is atomic, and pending signal mask is not updated, user will only read
> >one event after another, which automatically (since delivery is atomic)
> >means that what first was read, that was first happend.
> 
> This really has nothing to do with the problem.

It is the only practical example of the need for that signal mask.
And it can be perfectly handled by kevent.

> >I posted a patch to implement kevent support for posix timers, it is
> >quite simple in existing model. No need to remove anything,
> 
> Surely you don't suggest keeping your original timer patch?

Of course not - kevent timers are more scalable than posix timers (the 
latter uses idr, which is slower than balanced binary tree, since it
looks like it uses similar to radix tree algo), POSIX interface is 
much-much-much more unconvenient to use than simple add/wait.
 
> >I implemented it to return -enosys for the case, when event type is
> >smaller than maximum allowed and no subsystem is registered, and -einval 
> >for the case, when requested type is higher.
> 
> What is the "maximum allowed"?  ENOSYS must be returned for all values 
> which could potentially in future be used as a valid type value.  If you 
> limit the values which are treated this way you are setting a fixed 
> upper limit for the type values which _ever_ can be used.

Upper limit is for current version - when new type is added limit is
increased - just like maximum number of syscalls.
Ok, I will use -ENOSYS for all cases.
 
> >It is not about generalization, but about those who do practical work
> >and those who prefer to spread theoretical thoughts, which result in
> >several month of unused empty discussions.
> 
> I've told you, then don't work on these parts.  I'll get the changes I 
> think are needed implemented by somebody else or I'll do it myself.  If 
> you say that only those you implement something have a say in the way 
> this is done then this is fine with me.  But you have to realize that 
> you're not the one who will make all the final decisions.

Because our void discussion seems to never end, which puts kevent into
hung state - I definitely prefer final words made by kernel maintainers 
about inclusion or declining of the kevents, but they keep silence since
they look for not only my decision as author, but also different
opinions of the potential users.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
