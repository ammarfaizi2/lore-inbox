Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757351AbWKWMUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351AbWKWMUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 07:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757267AbWKWMUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 07:20:40 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:65257 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1757178AbWKWMUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 07:20:38 -0500
Date: Thu, 23 Nov 2006 15:18:40 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061123121838.GC20294@2ka.mipt.ru>
References: <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com> <20061122103828.GA11480@2ka.mipt.ru> <4564CD97.20909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4564CD97.20909@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 23 Nov 2006 15:18:41 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 02:22:15PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> >I repeate - timeout is needed to tell kernel the maximum possible
> >timeframe syscall can live. When you will tell me why you want syscall
> >to be interrupted when some absolute time is on the clock instead of
> >having special event for that, then ok.
> 
> This goes together with...
> 
> 
> >I think I know why you want absolute time there - because glibc converts
> >most of the timeouts to absolute time since posix waiting
> >pthread_cond_timedwait() works only with it.
> 
> I did not make the decision to use absolute timeouts/deadlines.  This is 
> what is needed in many situations.  It's the more general way to specify 
> delays.  These are real-world requirements which were taken into account 
> when designing the interfaces.
> 
> For most cases I would agree that when doing AIO you need relative 
> timeouts.  But the event handling is not about AIO alone.  It's all 
> kinds of events and some/many are wall clock related.  And it is 
> definitely necessary in some situations to be able to interrupt if the 
> clock jumps ahead.  If a program deals with devices in the real world 
> this be crucial.  The new event handling must be generic enough to 
> accommodate all these uses and using struct timespec* plus eventually 
> flags does not add any measurable overhead so there is no reason to not 
> do it right.

Timeouts are not about AIO or any other event types (there are a lot of
them already as you can see), it is only about syscall itself.
Please point me to _any_ syscall out there which uses absolute time
(except settimeofday() and similar syscalls).
 
> >Kevent convert it to jiffies since it uses wait_event() and friends,
> >jiffies do not carry information about clocks to be used.
> 
> Then this points to a place in the implementation which needs changing. 
>  The interface cannot be restricted just because the implementation 
> currently allow this to be implemented.

Btw, do you propose to change all users of wait_event()?

Interface is not restricted, it is just different from what you want it
to be, and you did not show why it requires changes.

Btw, there are _no_ interfaces similar to 'wait event with absolute
times' in kernel.
 
> >	/* Short-circuit ignored signals.  */
> >	if (sig_ignored(p, sig)) {
> >		ret = 1;
> >		goto out;
> >	}
> > 
> >almost the same happens when signal is delivered using kevent (special
> >case) - pending mask is not updated.
> 
> Yes, and how do you set the signal mask atomically wrt to registering 
> and unregistering signals with kevent and the syscall itself?  You 
> cannot.  But this is exactly which is resolved by adding the signal mask 
> parameter.

kevent signal registering is atomic with respect to other kevent
syscalls: control syscalls are protected by mutex and waiting syscalls
work with queue, which is protected by appropriate lock.

> Programs which don't need the functionality simply pass a NULL pointer 
> and the cost is once again not measurable.  But don't restrict the 
> functionality just because you don't see a use for this in your small world.
> 
> Yes, we could (later again) add new syscalls.  But this is plain stupid. 
>  I would love to never have the epoll_wait or select syscall and just 
> have epoll_pwait and pselect since the functionality is a superset.  We 
> have a larger kernel ABI.  Here we can stop making the same mistake again.
> 
> For the userlevel side we might even have separate intterfaces, one with 
> one without signal mask parameter.  But that's userlevel, both functions 
> would use the same syscall.

Let me formulate signal problem here, please point me if it is correct
or not.

User registers some async signal notifications and calls poll() waiting
for some file descriptors to became ready. When it is interrupted there
is no knowledge about what really happend first - signal was delivered
or file descriptor was ready.

Is it correct?

In case it is, let me explain why this situation can not happen with
kevent: since signals are not delivered in the old way, but instead they
are queued into the same queue where file descriptors are, and queueing
is atomic, and pending signal mask is not updated, user will only read
one event after another, which automatically (since delivery is atomic)
means that what first was read, that was first happend.

So, why in the latter situation we need to specify signal mask, which
will block some signals from _async_ delivery, since there is _no_ async
delivery?

> >>There are other scenarios like this.  Fact is, signal mask handling is 
> >>necessary and it cannot be folded into the event handling, it's 
> >>orthogonal.
> >
> >You have too narrow look.
> >Look broader - pselect() has signal mask to prevent race between async
> >signal delivery and file descriptor readiness. With kevent both that
> >events are delivered through the same queue, so there is no race, so
> >kevent syscalls do not need that workaround for 20 years-old design,
> >which can not handle different than fd events.
> 
> Your failure to understand to signal model leads to wrong conclusions. 
> There are races, several of them, and you cannot do anything without 
> signal mask parameters.  I've explained this before.

Please refer to my above explaination, point me in that example what we
are talking about. It seems we do not understand each other.
 
> >>Avoiding these callbacks would help reducing the kernel interface, 
> >>especially for this useless since inferior timer implementation.
> >
> >You completely do not want to understand how kevent works and why they 
> >are needed, if you would try to think that there are different than 
> >yours opinions, then probably we could have some progress.
> 
> I think I know very well how they work meanwhile.

If that would be true, I would be very happy. Definitely.
 
> >Those callbacks are neededto support different types of objects, which
> >can produce events, with the same interface.
> 
> Yes, but it is not necessary to expose all the different types in the 
> userlevel APIs.  That's the issue.  Reduce the exposure of kernel 
> functionality to userlevel APIs.
> 
> If you integrate the timer handling into the POSIX timer syscalls the 
> callbacks in your timer patch might not need be there.  At least the 
> enqueue callback, if I remember correctly.  All enqueue operations are 
> initiated by timer_create calls which can call the function directly. 
> Removing the callback from the list used by add_ctl will reduce the 
> exposed interface.

I posted a patch to implement kevent support for posix timers, it is
quite simple in existing model. No need to remove anything, that allows
to have flexibility and create different usage models others than what
is required by fairly small part of the users.

> >>>I can replace with -ENOSYS if you like.
> >>It's necessary since we must be able to distinguish the errors.
> >
> >And what if user requests bogus event type - is it invalid condition or
> >normal, but not handled (thus enosys)?
> 
> It's ENOSYS.  Just like for system calls.  You cannot distinguish 
> completely invalid values from values which are correct only on later 
> kernels.  But: the first use is a bug while the later is not a bug and 
> needed to write robust and well performing apps.  The former's problems 
> therefore are unimportant.

I implemented it to return -enosys for the case, when event type is
smaller than maximum allowed and no subsystem is registered, and -einval 
for the case, when requested type is higher.

> >Well, then I claim that I do not know 'thing or two about interfaces of
> >the runtime programs expect to use', but instead I write those programms
> >and I know my needs. And POSIX interfaces are the last one I prefer to
> >use.
> 
> Well, there it is.  You look out for yourself while I make sure that all 
> the bases I can think of are covered.
> 
> Again, if you don't want to work on the generalization, fine.  That's 
> your right.  Nobody will think bad of you for doing this.  But don't 
> expect that a) I'll not try to change it and b) I'll not object to the 
> changes being accepted as they are.

It is not about generalization, but about those who do practical work
and those who prefer to spread theoretical thoughts, which result in
several month of unused empty discussions.

> >What if it will not be called POSIX AIO, but instead some kind of 'true
> >AIO' or 'real AIO' or maybe 'alternative AIO'? :)
> >It is quite sure that POSIX AIO interfaces will unlikely to be applied
> >there...
> 
> Programmers don't like specialized OS-specific interfaces.  AIO users 
> who put up with libaio are rare.  The same will happen with any other 
> approach.  The Samba use is symptomatic: they need portability even if 
> this costs a minute percentage of performance compared to a highly 
> specialized implementation.

Do not say for everyone - it is not a some kind of feodalism with the
only opinion allowed - respect those who do not like/do not want what 
you propose them to use.

> There might be some aspects of POSIX AIO which could be implemented 
> better on Linux.  But the important part in the name is the 'P'.

I will create completely different model, POSIX completely is not
designed for that - that model allows to specify set of tasks performed
on object completely asycnhronous to user before object is returned -
for example specify destination socket and filename, so async sendfile
will asynchronously open file, transfer it to remote destination and
probably even close (or return file descriptor). The same can be applied
to aio read/write.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
