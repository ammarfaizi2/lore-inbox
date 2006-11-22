Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756957AbWKVHeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756957AbWKVHeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 02:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756961AbWKVHeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 02:34:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9436 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1756956AbWKVHeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 02:34:17 -0500
Message-ID: <4563FD53.7030307@redhat.com>
Date: Tue, 21 Nov 2006 23:33:39 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru>
In-Reply-To: <20061121174334.GA25518@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> Threads are parked in syscalls - which one should be interrupted?

It doesn't matter, use the same policy you use when waking a thread in 
case of an event.  This is not about waking a specific thread, it's 
about not dropping the event notification.


> And what if there were no threads waiting in syscalls?

This is fine, do nothing.  It means that the other threads are about to 
read the ring buffer and will pick up the event.


The case which must be avoided is that of all threads being in the 
kernel, one threads gets woken, and then is canceled.  Without notifying 
the kernel about the cancellation and in the absence of further events 
notifications the process is deadlocked.

A second case which should be avoided is that there is a thread waiting 
when a thread gets canceled and there are one or more addition threads 
around, but not in the kernel.  But those other threads might not get to 
the ring buffer anytime soon, so handling the event is unnecessarily 
delayed.


> It has completely nothing with syscall.
> You register a timer to wait until 10:15 that is all.

That's a nonsense argument.  In this case you would not add any timeout 
parameter at all.  Of course nobody would want that since it's simply 
too slow.  Stop thinking about the absolute timeout as an exceptional 
case, it might very well not be for some problems.

Beside, I've already mentioned another case where a struct timespec* 
parameter is needed.  There are even two different relative timeouts: 
using the monotonis clock or using the realtime clock.   The latter is 
affected by gettimeofday and ntp.


>>> Kernel use relative timeouts.
>> Look again.  This time at the implementation.  For FUTEX_LOCK_PI the 
>> timeout is an absolute timeout.
> 
> How come? It just uses timespec.

Correct, it's using the value passed in.


>> The signal mask handling is orthogonal to all this and must be explicit. 
>>  In some cases explicit pthread_sigmask/sigprocmask calls.  But this is 
>> not atomic if a signal must be masked/unmasked for the *_wait call. 
>> This is why we have variants like pselect/ppoll/epoll_pwait which 
>> explicitly and *atomically* change the signal mask for the duration of 
>> the call.
> 
> You probably missed kevent signal patch - signal will not be delivered
> (in special cases) since it will not be copied into signal mask. System 
> just will not know that it happend. Completely. Like putting it into
> blocked mask.


I don't really understand what you want to say here.

I looked over the patch and I don't think I miss anything.  You just 
deliver the signal as an event.  No signal mask handling at all.  This 
is exactly the problem.


> But it is completely irrelevant with kevent signals - there is no race
> for that case when signal is delivered through file descriptor.

Of course there is a race.  You might not want the signal delivered. 
This is what the signal mask is for.  Of the other way around, as I've 
said before.


> It is much better to not know how thing works, then to not be possible
> to understand how new things can work.

Well, this explains why you don't understand signal masks at all.


> Add kevent signal and do not process that event.

That's not only a horrible hack, it does not work.  If I want to ignore 
a signal for the duration of the call, while you have it occasionally 
blocked for the rest of the program you would have to register the 
kevent for the signal, unblock the signal, the kevent_wait call, reset 
the mask, remove the kevent for the signal..  Otherwise it would not be 
delivered to be ignored.  And then you have a race, the same race 
pselect is designed to prevent.  In fact, you have two races.

There are other scenarios like this.  Fact is, signal mask handling is 
necessary and it cannot be folded into the event handling, it's orthogonal.


> Having special type of kevent signal is the same as putting signal into
> blocked mask, but signal event will be marked as ready - to indicate
> that condition was there.
> There will not be any race in that case.

Nonsense on all counts.


> I think I am a bit blind, probably parts of Leonids are still getting
> into my brain, but there is one syscall called kevent_ctl() which adds
> different events, including timer, signal, socket and others.

You are searching for callbacks and if none is found you return EINVAL. 
  This is exactly the same as if you'd create separate syscalls. 
Perhaps even worse, I really don't like demultiplexers, separate 
syscalls are much cleaner.

Avoiding these callbacks would help reducing the kernel interface, 
especially for this useless since inferior timer implementation.


> I can replace with -ENOSYS if you like.

It's necessary since we must be able to distinguish the errors.


> No one asked and pain me to create kevent, but it is done.
> Probably no the way some people wanted, but it always happend, 
> it is really not that bad.

Nobody says that the work isn't appreciated.  But if you don't want it 
to be critiqued, don't publish it.  If you don't want to mask any more 
changes, fine, say so.  I'll find somebody else to do it or will do it 
myself.

I claim that I know a thing or two about interfaces of the runtime 
programs expect to use.  And I know POSIX and the way the interfaces are 
designed and how they interact.


> Ulrich, tell me the truth, will you kill me if I say that I have an entry 
> in TODO to implement different AIO design (details for interested readers 
> can be found in my blog), and then present it to community? :))

I don't care about the kernel implementation as long as the interface is 
compatible with what I need for the POSIX AIO implementation.  The 
currently proposed code is going in that direction.  Any implementation 
which like Ben's old one does not allow POSIX AIO to be implemented I 
will of oppose.


>> Then define SIGEV_KEVENT as a value distinct from the other SIGEV_ 
>> values.  In the code which handles setup of timers (the timer_create 
>> syscall), recognize SIGEV_KEVENT and handle it appropriately.  I.e., 
>> call into the code to register the event source, just like you'd do with 
>> the current interface.  Then add the code to post an event to the event 
>> queue where currently signals would be sent et voilà.
> 
> Ok, I see.
> It is doable and simple.
> I will try to implement it tomorrow.

Thanks, that's progress.  And yes, I imagine it's not hard which is why 
the currently proposed timer interface is so unnecessary.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
