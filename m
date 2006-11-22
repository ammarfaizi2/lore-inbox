Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031491AbWKVKje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031491AbWKVKje (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031489AbWKVKjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:39:33 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:46026 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1755628AbWKVKjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:39:32 -0500
Date: Wed, 22 Nov 2006 13:38:28 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061122103828.GA11480@2ka.mipt.ru>
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4563FD53.7030307@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 22 Nov 2006 13:38:30 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 11:33:39PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >Threads are parked in syscalls - which one should be interrupted?
> 
> It doesn't matter, use the same policy you use when waking a thread in 
> case of an event.  This is not about waking a specific thread, it's 
> about not dropping the event notification.

Event notification is not dropped - thread was awakened, kernel task is
completed. Kernel does not know and should not have such knowledge about
the fact that selected thread was not good enough. If you want to wakeup
another thread - create another event, that is why I proposed userspace
notifications, which I actually do not like.
 
> >And what if there were no threads waiting in syscalls?
> 
> This is fine, do nothing.  It means that the other threads are about to 
> read the ring buffer and will pick up the event.
> 
> 
> The case which must be avoided is that of all threads being in the 
> kernel, one threads gets woken, and then is canceled.  Without notifying 
> the kernel about the cancellation and in the absence of further events 
> notifications the process is deadlocked.
> 
> A second case which should be avoided is that there is a thread waiting 
> when a thread gets canceled and there are one or more addition threads 
> around, but not in the kernel.  But those other threads might not get to 
> the ring buffer anytime soon, so handling the event is unnecessarily 
> delayed.

If those threads are not in the kernel, kernel can not wake hem up.
But if there is an event 'wake me up when thread has died' or something
like that, when new threads will try to sleep in syscall, they will be
immediately awakened, since that event will be ready.
 
> >It has completely nothing with syscall.
> >You register a timer to wait until 10:15 that is all.
> 
> That's a nonsense argument.  In this case you would not add any timeout 
> parameter at all.  Of course nobody would want that since it's simply 
> too slow.  Stop thinking about the absolute timeout as an exceptional 
> case, it might very well not be for some problems.

I repeate - timeout is needed to tell kernel the maximum possible
timeframe syscall can live. When you will tell me why you want syscall
to be interrupted when some absolute time is on the clock instead of
having special event for that, then ok.

I think I know why you want absolute time there - because glibc converts
most of the timeouts to absolute time since posix waiting
pthread_cond_timedwait() works only with it.

> Beside, I've already mentioned another case where a struct timespec* 
> parameter is needed.  There are even two different relative timeouts: 
> using the monotonis clock or using the realtime clock.   The latter is 
> affected by gettimeofday and ntp.

Kevent convert it to jiffies since it uses wait_event() and friends,
jiffies do not carry information about clocks to be used.
 
> >>>Kernel use relative timeouts.
> >>Look again.  This time at the implementation.  For FUTEX_LOCK_PI the 
> >>timeout is an absolute timeout.
> >
> >How come? It just uses timespec.
> 
> Correct, it's using the value passed in.
> 
> 
> >>The signal mask handling is orthogonal to all this and must be explicit. 
> >> In some cases explicit pthread_sigmask/sigprocmask calls.  But this is 
> >>not atomic if a signal must be masked/unmasked for the *_wait call. 
> >>This is why we have variants like pselect/ppoll/epoll_pwait which 
> >>explicitly and *atomically* change the signal mask for the duration of 
> >>the call.
> >
> >You probably missed kevent signal patch - signal will not be delivered
> >(in special cases) since it will not be copied into signal mask. System 
> >just will not know that it happend. Completely. Like putting it into
> >blocked mask.
> 
> 
> I don't really understand what you want to say here.
> 
> I looked over the patch and I don't think I miss anything.  You just 
> deliver the signal as an event.  No signal mask handling at all.  This 
> is exactly the problem.

Have you seen specific_send_sig_info():

	/* Short-circuit ignored signals.  */
	if (sig_ignored(p, sig)) {
		ret = 1;
		goto out;
	}
 
almost the same happens when signal is delivered using kevent (special
case) - pending mask is not updated.

> >But it is completely irrelevant with kevent signals - there is no race
> >for that case when signal is delivered through file descriptor.
> 
> Of course there is a race.  You might not want the signal delivered. 
> This is what the signal mask is for.  Of the other way around, as I've 
> said before.

Then ignore that event - there is no race between signal delivery and
other descriptors reading, and it _is_ when signal is delivered no
through the same queue but asynchronously with mask update.

> >It is much better to not know how thing works, then to not be possible
> >to understand how new things can work.
> 
> Well, this explains why you don't understand signal masks at all.

Nice :)
I at least try to do something to solve this problem, instead of blindly
saying the same again and again without even trying to hear and
understand what others say.

> >Add kevent signal and do not process that event.
> 
> That's not only a horrible hack, it does not work.  If I want to ignore 
> a signal for the duration of the call, while you have it occasionally 
> blocked for the rest of the program you would have to register the 
> kevent for the signal, unblock the signal, the kevent_wait call, reset 
> the mask, remove the kevent for the signal..  Otherwise it would not be 
> delivered to be ignored.  And then you have a race, the same race 
> pselect is designed to prevent.  In fact, you have two races.
> 
> There are other scenarios like this.  Fact is, signal mask handling is 
> necessary and it cannot be folded into the event handling, it's orthogonal.

You have too narrow look.
Look broader - pselect() has signal mask to prevent race between async
signal delivery and file descriptor readiness. With kevent both that
events are delivered through the same queue, so there is no race, so
kevent syscalls do not need that workaround for 20 years-old design,
which can not handle different than fd events.

> >Having special type of kevent signal is the same as putting signal into
> >blocked mask, but signal event will be marked as ready - to indicate
> >that condition was there.
> >There will not be any race in that case.
> 
> Nonsense on all counts.
>
>
> >I think I am a bit blind, probably parts of Leonids are still getting
> >into my brain, but there is one syscall called kevent_ctl() which adds
> >different events, including timer, signal, socket and others.
> 
> You are searching for callbacks and if none is found you return EINVAL. 
>  This is exactly the same as if you'd create separate syscalls. 
> Perhaps even worse, I really don't like demultiplexers, separate 
> syscalls are much cleaner.
> 
> Avoiding these callbacks would help reducing the kernel interface, 
> especially for this useless since inferior timer implementation.

You completely do not want to understand how kevent works and why they 
are needed, if you would try to think that there are different than 
yours opinions, then probably we could have some progress.

Those callbacks are neededto support different types of objects, which
can produce events, with the same interface.
 
> >I can replace with -ENOSYS if you like.
> 
> It's necessary since we must be able to distinguish the errors.

And what if user requests bogus event type - is it invalid condition or
normal, but not handled (thus enosys)?

> >No one asked and pain me to create kevent, but it is done.
> >Probably no the way some people wanted, but it always happend, 
> >it is really not that bad.
> 
> Nobody says that the work isn't appreciated.  But if you don't want it 
> to be critiqued, don't publish it.  If you don't want to mask any more 
> changes, fine, say so.  I'll find somebody else to do it or will do it 
> myself.

I greatly appreciate critics, really. But when it comes to 'this
sucks because it sucks, no matter if it is completely different way,
it still sucks because others sucked there too' I can not say it is 
critics, it becomes nonsence.

> I claim that I know a thing or two about interfaces of the runtime 
> programs expect to use.  And I know POSIX and the way the interfaces are 
> designed and how they interact.

Well, then I claim that I do not know 'thing or two about interfaces of
the runtime programs expect to use', but instead I write those programms
and I know my needs. And POSIX interfaces are the last one I prefer to
use.

We are on the different positions - theoretical thoughs about world
hapinness, and practical usage. I do not say that only one of that
approaches must exist, they both can live together, but it requires that
people from both sides not only tried to say, that other part is stupid
and do not know something or anything, but instead tried to listen and get 
into account that.
 
> >Ulrich, tell me the truth, will you kill me if I say that I have an entry 
> >in TODO to implement different AIO design (details for interested readers 
> >can be found in my blog), and then present it to community? :))
> 
> I don't care about the kernel implementation as long as the interface is 
> compatible with what I need for the POSIX AIO implementation.  The 
> currently proposed code is going in that direction.  Any implementation 
> which like Ben's old one does not allow POSIX AIO to be implemented I 
> will of oppose.

What if it will not be called POSIX AIO, but instead some kind of 'true
AIO' or 'real AIO' or maybe 'alternative AIO'? :)
It is quite sure that POSIX AIO interfaces will unlikely to be applied
there...

> >>Then define SIGEV_KEVENT as a value distinct from the other SIGEV_ 
> >>values.  In the code which handles setup of timers (the timer_create 
> >>syscall), recognize SIGEV_KEVENT and handle it appropriately.  I.e., 
> >>call into the code to register the event source, just like you'd do with 
> >>the current interface.  Then add the code to post an event to the event 
> >>queue where currently signals would be sent et voilà.
> >
> >Ok, I see.
> >It is doable and simple.
> >I will try to implement it tomorrow.
> 
> Thanks, that's progress.  And yes, I imagine it's not hard which is why 
> the currently proposed timer interface is so unnecessary.

It is the first techical but not political problem we cought in this
endless discussion, I separated it in different subthread already.
Let's try to think more about it there.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
