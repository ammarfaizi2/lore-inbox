Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030815AbWKUKIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030815AbWKUKIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 05:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030813AbWKUKIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 05:08:07 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:15010 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1030808AbWKUKIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 05:08:04 -0500
Date: Tue, 21 Nov 2006 12:53:02 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
Message-ID: <20061121095302.GA15210@2ka.mipt.ru>
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4562102B.5010503@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 21 Nov 2006 12:53:02 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 12:29:31PM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >It is exactly how previous ring buffer (in mapped area though) was
> >implemented.
> 
> Not any of those I saw.  The one I looked at always started again at 
> index 0 to fill the ring buffer.  I'll wait for the next implementation.

That what I'm talking about - there are at least 4 (!) different ring
buffer implementations, most of them were not even looked at.
But new version is ready, I will complete testing stage and will relese
'take25' soon today.

For those who like 'real-world benchmark and so on' I created a patch
for the latest stable lighttpd version and test it with kevent.
 
> >>That's something the application should be make a call about.  It's not 
> >>always (or even mostly) the case that the ordering of the notification 
> >>is important.  Furthermore, this would also require the kernel to 
> >>enforce an ordering.  This is expensive on SMP machines.  A locally 
> >>generated event (i.e., source and the thread reporting the event) can be 
> >>delivered faster than an event created on another CPU.
> >
> >How come? If signal was delivered earlier than data arrived, userspace
> >should get signal before data - that is the rule. Ordering is maintained
> >not for event insertion, but for marking them ready - it is atomic, so
> >who first starts to mark even ready, that event will be read first from
> >the ready queue.
> 
> This is as far as the kernel is concerned.  Queue them in the order they 
> arrive.
> 
> I'm talking about the userlevel side.  *If* (and it needs to be verified 
> that this has an advantage) a CPU creates an event for, e.g., a read 
> event and then a number of threads could be notified about the event. 
> When the kernel has to wake up a thread it'll look whether any thread is 
> scheduled on the same CPU which generated the event.  Then the thread, 
> upon waking up, can be told about the entry in the ring buffer which can 
> be accessed first best (due to caching).  This entry needs not be the 
> first available in the ring buffer but that's a problem the userlevel 
> code has to worry about.

Ok, I've understood.
 
> >Then I propose userspace notifications - each new thread can register
> >'wake me up when userspace event 1 is ready' and 'event 1' will be
> >marked as ready by glibc when it removes the thread.
> 
> You don't want to have a channel like this.  The userlevel code doesn't 
> know which threads are waiting in the kernel on the event queue.  And it 
> seems to be much more complicated then simply have an kevent call which 
> tells the kernel "wake up N or 1 more threads since I cannot handle it". 
>  Basically a futex_wake()-like call.

Kernel does not know about any threads which waits for events, it only
has queue of events, it can only wake those who was parked in
kevent_get_events() or kevent_wait(), but syscall will return only when
condition it waits on is true, i.e. when there is new event in the ready
queue and/or ring buffer has empty slots, but kernel will wake them up
in any case if those conditions are true.

How should it know which syscall should be interrupted when special syscall
is called?
 
> >>Of course it does.  Just because you don't see a need for it for your 
> >>applications right now it doesn't mean it's not a valid use.
> >
> >Please explain why glibc AIO uses relatinve timeouts then :)
> 
> You are still completely focused on AIO.  We are talking here about a 
> new generic event handling.  It is not tied to AIO.  We will add all 
> kinds of events, e.g., hopefully futex support and many others.  And 
> even for AIO it's relevant.
> 
> As I said, relative timeouts are unable to cope with settimeofday calls 
> or ntp adjustments.  AIO is certainly usable in situations where 
> timeouts are related to wall clock time.

No AIO, but syscall.
Only syscall time matters.
Syscall starts, it sould be sometime stopped. When it should be stopped?
It should be stopped after some time after it was started!

I still do not understand how will you use absolute timeout values
there. Please exaplain.

> >It has nothing with implementation - it is logic. Something starts and
> >it has its maximum lifetime, but not something starts and should be
> >stopped Jan 1, 2008.
> 
> It is an implementation detail.  Look at the PI futex support.  It has 
> timeouts which can be cut short (or increased) due to wall clock changes.

futex_wait() uses relative timeouts:
 static int futex_wait(u32 __user *uaddr, u32 val, unsigned long time)

Kernel use relative timeouts.

Only special syscalls, which work with absolute time, have absolute
timeouts (like settimeofday).

> >>The opposite case is equally impossible to emulate: unblocking a signal 
> >>just for the duration of the syscall.  These are all possible and used 
> >>cases.
> > 
> >Add and remove appropriate kevent - it is as simple as call for one
> >function.
> 
> No, it's not.  The kevent stuff handles only the kevent handler (i.e., 
> the replacement for calling the signal handler).  It cannot set signal 
> masks.  I am talking about signal masks here.  And don't suggest "I can 
> add another kevent feature where I can register signal masks".  This 
> would be ridiculous since it's not an event source.  Just add the 
> parameter and every base is covered and, at least equally important, we 
> have symmetry between the event handling interfaces.
 
We have not have such symmetry.
Other event handling interfaces can not work with events, which do not
have file descriptor behind them. Kevent can and works.
Signals are just usual events.

You request to get events - and you get them.
You request to not get events during syscall - you remove events.

Btw, please point me to the discussion about real life usefullness of
that parameter for epoll. I read thread where sys_pepoll() was
intruduced, but except some theoretical handwaving about possible
usefullness there are no real signs of that requirement.

What is the ground research or extended explaination about
blocking/unblocking some signals during syscall execution?

> >>No, that's not what I mean.  There is no need for the special 
> >>timer-related part of your patch.  Instead the existing POSIX timer 
> >>syscalls should be modified to handle SIGEV_KEVENT notification.  Again, 
> >>keep the interface as small as possible.  Plus, the POSIX timer 
> >>interface is very flexible.  You don't want to duplicate all that 
> >>functionality.
> >
> >Interface is already there with kevent_ctl(KEVENT_ADD), I just created
> >additional entry, which describes timers enqueue/dequeue callbacks
> 
> New multiplexers cases are additional syscalls.  This is unnecessary 
> code.  Increased kernel interface and such.  We have the POSIX timer 
> interfaces which are feature-rich and standardized *and* can be triviall 
> extended (at least from the userlevel interface POV) to use event 
> queues.  If you don't want to do this, fine, I'll try to get it made. 
> But drop the timer part of your patches.

There are _no_ additional syscalls.
I just introduced new case for event type.
You _need_ it to be done, since any kernel kevent user must have
enqueue/dequeue/callback callbacks. It is just an implementation of that
callbacks.
I made the work, one can create any interfaces (additional syscalls or
anything else) on top of that.

Due to the fact that kevent was designed as generic event handling
mechanism it is possible to work will all types of events using the same
interface, which was created 10 month ago: kevent add, remove and so
on... There is nothing special for timers there - it is separate file
which does _not_ have any interfaces accessible outside kevent core (i.e.
syscalls or exported symbols).

Btw, how POSIX API should be extended to allow to queue events - queue
is required (which is created when user calls kevent_init() or
previoisly opened /dev/kevent), how should it be accessed, since it is
just a file descriptor in process task_struct.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
