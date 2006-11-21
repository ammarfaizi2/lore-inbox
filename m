Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031236AbWKURuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031236AbWKURuc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 12:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031223AbWKURuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 12:50:32 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:59558 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S966971AbWKURua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 12:50:30 -0500
Date: Tue, 21 Nov 2006 20:43:34 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061121174334.GA25518@2ka.mipt.ru>
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45633049.2000209@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 21 Nov 2006 20:43:35 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 08:58:49AM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >>You don't want to have a channel like this.  The userlevel code doesn't 
> >>know which threads are waiting in the kernel on the event queue.  And it 
> >>seems to be much more complicated then simply have an kevent call which 
> >>tells the kernel "wake up N or 1 more threads since I cannot handle it". 
> >> Basically a futex_wake()-like call.
> >
> >Kernel does not know about any threads which waits for events, it only
> >has queue of events, it can only wake those who was parked in
> >kevent_get_events() or kevent_wait(), but syscall will return only when
> >condition it waits on is true, i.e. when there is new event in the ready
> >queue and/or ring buffer has empty slots, but kernel will wake them up
> >in any case if those conditions are true.
> >
> >How should it know which syscall should be interrupted when special syscall
> >is called?
> 
> It's not about interrupting any threads.
>
> The issue is that the wakeup of a thread from the kevent_wait call 
> constitutes an "event notification".  If, as it should be, only one 
> thread is woken than this information mustn't get lost.  If the woken 
> thread cannot work on the events it got notified for, then it must tell 
> the kernel about it so that, *if* there are other threads waiting in 
> kevent_wait, one of those other threads can be woken.
> 
> What is needed is a simple "wake another thread waiting on this event 
> queue" syscall.  Yes, in theory we could open an additional pipe with 
> each event queue and use it for waking threads, but this is influencing 
> the ABI through the use of a file descriptor.  It's much better to have 
> an explicit way to do this.

Threads are parked in syscalls - which one should be interrupted?
And what if there were no threads waiting in syscalls?

> >No AIO, but syscall.
> >Only syscall time matters.
> >Syscall starts, it sould be sometime stopped. When it should be stopped?
> >It should be stopped after some time after it was started!
> >
> >I still do not understand how will you use absolute timeout values
> >there. Please exaplain.
> 
> What is there to explain?  If you are waiting for events which must 
> coincide with real-world events you'll naturally will want to formulate 
> something like "wait for X until 10:15h".  You cannot formulate this 
> correctly with relative timeouts since the realtime clock might be adjusted.

It has completely nothing with syscall.
You register a timer to wait until 10:15 that is all.

You do not ask to sleep in read() until some time, because read() has
nothing in common with that time and event.

But actually it becomes stupid discussion, don't you think?
What do you think about putting there timespec and a small warning in
dmesg about absolute timeout? When someone will report it I will
publically say that you were right and it is correct to have possibility
to have absolute timeouts for syscalls? :)
 
> >futex_wait() uses relative timeouts:
> > static int futex_wait(u32 __user *uaddr, u32 val, unsigned long time)
> >
> >Kernel use relative timeouts.
> 
> Look again.  This time at the implementation.  For FUTEX_LOCK_PI the 
> timeout is an absolute timeout.

How come? It just uses timespec.

> >We have not have such symmetry.
> >Other event handling interfaces can not work with events, which do not
> >have file descriptor behind them. Kevent can and works.
> >Signals are just usual events.
> >
> >You request to get events - and you get them.
> >You request to not get events during syscall - you remove events.
> 
> None of this matches what I'm talking about.  If you want to block a 
> signal for the duration of the kevent_wait call this is nothing you can 
> do by registering an event.
> 
> Registering events has nothing to do with signal masks.  They are not 
> modified.  It is the program's responsibility to set the mask up 
> correctly.  Just like sigwaitinfo() etc expect all signals which are 
> waited on to be blocked.
> 
> The signal mask handling is orthogonal to all this and must be explicit. 
>  In some cases explicit pthread_sigmask/sigprocmask calls.  But this is 
> not atomic if a signal must be masked/unmasked for the *_wait call. 
> This is why we have variants like pselect/ppoll/epoll_pwait which 
> explicitly and *atomically* change the signal mask for the duration of 
> the call.

You probably missed kevent signal patch - signal will not be delivered
(in special cases) since it will not be copied into signal mask. System 
just will not know that it happend. Completely. Like putting it into
blocked mask.

> >Btw, please point me to the discussion about real life usefullness of
> >that parameter for epoll. I read thread where sys_pepoll() was
> >intruduced, but except some theoretical handwaving about possible
> >usefullness there are no real signs of that requirement.
> 
> Don't search for epoll_pwait, it's not widely used yet.  Search for 
> pselect, which is standardized.  You'll find plenty of uses of that 
> interface.  The number is certainly depressed in the moment since until 
> recently there was no correct implementation on Linux.  And the 
> interface is mostly used in real-time contexts where signals are more 
> commonly used.

I found this:

... document a pselect() call intended to
remove the race condition that is present when one wants
to wait on either a signal or some file descriptor.
(See also Stevens, Unix Network Programming, Volume 1, 2nd Ed.,
1998, p. 168 and the pselect.2 man page released today.)
Glibc 2.0 has a bad version (wrong number of parameters)
and glibc 2.1 a better version, but the whole purpose
of pselect is to avoid the race, and glibc cannot do that,
one needs kernel support. 


But it is completely irrelevant with kevent signals - there is no race
for that case when signal is delivered through file descriptor.

> >What is the ground research or extended explaination about
> >blocking/unblocking some signals during syscall execution?
> 
> Why is this even a question?  Have you done programming with signals? 
> You hatred of signals makes me think this isn't the case.

It is much better to not know how thing works, then to not be possible
to understand how new things can work.

> You might want to unblock a signal on a *_wait call if it can be used to 
> interrupt the wait but you don't want this to happen during when the 
> thread is working on a request.

Add kevent signal and do not process that event.

> You might want to block a signal, for instance, around a sigwaitinfo 
> call or, in this case, a kevent_wait call where the signal might be 
> delivered to the queue.

Having special type of kevent signal is the same as putting signal into
blocked mask, but signal event will be marked as ready - to indicate
that condition was there.
There will not be any race in that case.

> There are countless possibilities.  Signals are very flexible.

That is why we want to get them through synchronous queue? :)

> >There are _no_ additional syscalls.
> >I just introduced new case for event type.
> 
> Which is a new syscall.  All demultiplexer cases are no syscalls. 

I think I am a bit blind, probably parts of Leonids are still getting
into my brain, but there is one syscall called kevent_ctl() which adds
different events, including timer, signal, socket and others.

> Which, BTW, implies that unrecognized types should actually cause a 
> ENOSYS return value (this affects kevent_break).  We've been over this 
> many times.  If EINVAL is return this case cannot be distinguished from 
> invalid parameters.  This is crucial for future extensions where 
> userland (esp glibc) needs to be able to determine whether a new feature 
> is supported on the system.

I can replace with -ENOSYS if you like.

> >You _need_ it to be done, since any kernel kevent user must have
> >enqueue/dequeue/callback callbacks. It is just an implementation of that
> >callbacks.
> 
> I don't question that.  But there is no need to add the callback.  It 

No one asked and pain me to create kevent, but it is done.
Probably no the way some people wanted, but it always happend, 
it is really not that bad.

Kevent subsystem operates with structures which can be added into
completely different objects in the system - inodes, files - anything.
And to say to that object about new events there are special callbacks -
enqueue and dequeue. Callback which has extremely unusual name 'callback'
is invoked when object, where event is linked, has something to report -
new data, fired alarm or anything else, so it calls kevent's ->callback
and if return value is positive, kevent is marked as ready.
It allows to have event with different sets of interests for the same
type of the main object - for example socket can have read and write
callbacks.

So you must have them.
As you probably saw, kevent_timer_callback() just returns 1.

> extends the kernel ABI/API.  And for what?  A vastly inferior timer 
> implementation compared to the POSIX timers.  And this while all that 
> needs to be done is to extend the POSIX timer code slightly to handle 
> SIGEV_KEVENT in addition to the other notification methods currently 
> used.  If you do it right then the code can be shared with the file AIO 
> code which currently is circulated as well and which uses parts of the 
> POSIX timer infrastructure.

Ulrich, tell me the truth, will you kill me if I say that I have an entry 
in TODO to implement different AIO design (details for interested readers 
can be found in my blog), and then present it to community? :))
 
> >Btw, how POSIX API should be extended to allow to queue events - queue
> >is required (which is created when user calls kevent_init() or
> >previoisly opened /dev/kevent), how should it be accessed, since it is
> >just a file descriptor in process task_struct.
> 
> I've explained this multiple times.  The struct sigevent structure needs 
> to be extended to get a new part in the union.  Something like
> 
>   struct {
>     int kevent_fd;
>     void *data;
>   } _sigev_kevent;
> 
> Then define SIGEV_KEVENT as a value distinct from the other SIGEV_ 
> values.  In the code which handles setup of timers (the timer_create 
> syscall), recognize SIGEV_KEVENT and handle it appropriately.  I.e., 
> call into the code to register the event source, just like you'd do with 
> the current interface.  Then add the code to post an event to the event 
> queue where currently signals would be sent et voilà.

Ok, I see.
It is doable and simple.
I will try to implement it tomorrow.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
