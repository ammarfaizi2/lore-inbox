Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031096AbWKURC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031096AbWKURC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 12:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031200AbWKURC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 12:02:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57048 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1031096AbWKURCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 12:02:55 -0500
Message-ID: <45633049.2000209@redhat.com>
Date: Tue, 21 Nov 2006 08:58:49 -0800
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
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru>
In-Reply-To: <20061121095302.GA15210@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
>> You don't want to have a channel like this.  The userlevel code doesn't 
>> know which threads are waiting in the kernel on the event queue.  And it 
>> seems to be much more complicated then simply have an kevent call which 
>> tells the kernel "wake up N or 1 more threads since I cannot handle it". 
>>  Basically a futex_wake()-like call.
> 
> Kernel does not know about any threads which waits for events, it only
> has queue of events, it can only wake those who was parked in
> kevent_get_events() or kevent_wait(), but syscall will return only when
> condition it waits on is true, i.e. when there is new event in the ready
> queue and/or ring buffer has empty slots, but kernel will wake them up
> in any case if those conditions are true.
> 
> How should it know which syscall should be interrupted when special syscall
> is called?

It's not about interrupting any threads.

The issue is that the wakeup of a thread from the kevent_wait call 
constitutes an "event notification".  If, as it should be, only one 
thread is woken than this information mustn't get lost.  If the woken 
thread cannot work on the events it got notified for, then it must tell 
the kernel about it so that, *if* there are other threads waiting in 
kevent_wait, one of those other threads can be woken.

What is needed is a simple "wake another thread waiting on this event 
queue" syscall.  Yes, in theory we could open an additional pipe with 
each event queue and use it for waking threads, but this is influencing 
the ABI through the use of a file descriptor.  It's much better to have 
an explicit way to do this.


> No AIO, but syscall.
> Only syscall time matters.
> Syscall starts, it sould be sometime stopped. When it should be stopped?
> It should be stopped after some time after it was started!
> 
> I still do not understand how will you use absolute timeout values
> there. Please exaplain.

What is there to explain?  If you are waiting for events which must 
coincide with real-world events you'll naturally will want to formulate 
something like "wait for X until 10:15h".  You cannot formulate this 
correctly with relative timeouts since the realtime clock might be adjusted.


> futex_wait() uses relative timeouts:
>  static int futex_wait(u32 __user *uaddr, u32 val, unsigned long time)
> 
> Kernel use relative timeouts.

Look again.  This time at the implementation.  For FUTEX_LOCK_PI the 
timeout is an absolute timeout.

> We have not have such symmetry.
> Other event handling interfaces can not work with events, which do not
> have file descriptor behind them. Kevent can and works.
> Signals are just usual events.
> 
> You request to get events - and you get them.
> You request to not get events during syscall - you remove events.

None of this matches what I'm talking about.  If you want to block a 
signal for the duration of the kevent_wait call this is nothing you can 
do by registering an event.

Registering events has nothing to do with signal masks.  They are not 
modified.  It is the program's responsibility to set the mask up 
correctly.  Just like sigwaitinfo() etc expect all signals which are 
waited on to be blocked.

The signal mask handling is orthogonal to all this and must be explicit. 
  In some cases explicit pthread_sigmask/sigprocmask calls.  But this is 
not atomic if a signal must be masked/unmasked for the *_wait call. 
This is why we have variants like pselect/ppoll/epoll_pwait which 
explicitly and *atomically* change the signal mask for the duration of 
the call.


> Btw, please point me to the discussion about real life usefullness of
> that parameter for epoll. I read thread where sys_pepoll() was
> intruduced, but except some theoretical handwaving about possible
> usefullness there are no real signs of that requirement.

Don't search for epoll_pwait, it's not widely used yet.  Search for 
pselect, which is standardized.  You'll find plenty of uses of that 
interface.  The number is certainly depressed in the moment since until 
recently there was no correct implementation on Linux.  And the 
interface is mostly used in real-time contexts where signals are more 
commonly used.


> What is the ground research or extended explaination about
> blocking/unblocking some signals during syscall execution?

Why is this even a question?  Have you done programming with signals? 
You hatred of signals makes me think this isn't the case.

You might want to unblock a signal on a *_wait call if it can be used to 
interrupt the wait but you don't want this to happen during when the 
thread is working on a request.

You might want to block a signal, for instance, around a sigwaitinfo 
call or, in this case, a kevent_wait call where the signal might be 
delivered to the queue.

There are countless possibilities.  Signals are very flexible.


> There are _no_ additional syscalls.
> I just introduced new case for event type.

Which is a new syscall.  All demultiplexer cases are no syscalls. 
Which, BTW, implies that unrecognized types should actually cause a 
ENOSYS return value (this affects kevent_break).  We've been over this 
many times.  If EINVAL is return this case cannot be distinguished from 
invalid parameters.  This is crucial for future extensions where 
userland (esp glibc) needs to be able to determine whether a new feature 
is supported on the system.


> You _need_ it to be done, since any kernel kevent user must have
> enqueue/dequeue/callback callbacks. It is just an implementation of that
> callbacks.

I don't question that.  But there is no need to add the callback.  It 
extends the kernel ABI/API.  And for what?  A vastly inferior timer 
implementation compared to the POSIX timers.  And this while all that 
needs to be done is to extend the POSIX timer code slightly to handle 
SIGEV_KEVENT in addition to the other notification methods currently 
used.  If you do it right then the code can be shared with the file AIO 
code which currently is circulated as well and which uses parts of the 
POSIX timer infrastructure.


> Btw, how POSIX API should be extended to allow to queue events - queue
> is required (which is created when user calls kevent_init() or
> previoisly opened /dev/kevent), how should it be accessed, since it is
> just a file descriptor in process task_struct.

I've explained this multiple times.  The struct sigevent structure needs 
to be extended to get a new part in the union.  Something like

   struct {
     int kevent_fd;
     void *data;
   } _sigev_kevent;

Then define SIGEV_KEVENT as a value distinct from the other SIGEV_ 
values.  In the code which handles setup of timers (the timer_create 
syscall), recognize SIGEV_KEVENT and handle it appropriately.  I.e., 
call into the code to register the event source, just like you'd do with 
the current interface.  Then add the code to post an event to the event 
queue where currently signals would be sent et voilà.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
