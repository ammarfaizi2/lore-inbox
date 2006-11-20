Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966653AbWKTUbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966653AbWKTUbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966644AbWKTUbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:31:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50406 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966642AbWKTUbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:31:17 -0500
Message-ID: <4562102B.5010503@redhat.com>
Date: Mon, 20 Nov 2006 12:29:31 -0800
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
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru>
In-Reply-To: <20061120082500.GA25467@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> It is exactly how previous ring buffer (in mapped area though) was
> implemented.

Not any of those I saw.  The one I looked at always started again at 
index 0 to fill the ring buffer.  I'll wait for the next implementation.


>> That's something the application should be make a call about.  It's not 
>> always (or even mostly) the case that the ordering of the notification 
>> is important.  Furthermore, this would also require the kernel to 
>> enforce an ordering.  This is expensive on SMP machines.  A locally 
>> generated event (i.e., source and the thread reporting the event) can be 
>> delivered faster than an event created on another CPU.
> 
> How come? If signal was delivered earlier than data arrived, userspace
> should get signal before data - that is the rule. Ordering is maintained
> not for event insertion, but for marking them ready - it is atomic, so
> who first starts to mark even ready, that event will be read first from
> the ready queue.

This is as far as the kernel is concerned.  Queue them in the order they 
arrive.

I'm talking about the userlevel side.  *If* (and it needs to be verified 
that this has an advantage) a CPU creates an event for, e.g., a read 
event and then a number of threads could be notified about the event. 
When the kernel has to wake up a thread it'll look whether any thread is 
scheduled on the same CPU which generated the event.  Then the thread, 
upon waking up, can be told about the entry in the ring buffer which can 
be accessed first best (due to caching).  This entry needs not be the 
first available in the ring buffer but that's a problem the userlevel 
code has to worry about.


> Then I propose userspace notifications - each new thread can register
> 'wake me up when userspace event 1 is ready' and 'event 1' will be
> marked as ready by glibc when it removes the thread.

You don't want to have a channel like this.  The userlevel code doesn't 
know which threads are waiting in the kernel on the event queue.  And it 
seems to be much more complicated then simply have an kevent call which 
tells the kernel "wake up N or 1 more threads since I cannot handle it". 
  Basically a futex_wake()-like call.


>> Of course it does.  Just because you don't see a need for it for your 
>> applications right now it doesn't mean it's not a valid use.
> 
> Please explain why glibc AIO uses relatinve timeouts then :)

You are still completely focused on AIO.  We are talking here about a 
new generic event handling.  It is not tied to AIO.  We will add all 
kinds of events, e.g., hopefully futex support and many others.  And 
even for AIO it's relevant.

As I said, relative timeouts are unable to cope with settimeofday calls 
or ntp adjustments.  AIO is certainly usable in situations where 
timeouts are related to wall clock time.


> It has nothing with implementation - it is logic. Something starts and
> it has its maximum lifetime, but not something starts and should be
> stopped Jan 1, 2008.

It is an implementation detail.  Look at the PI futex support.  It has 
timeouts which can be cut short (or increased) due to wall clock changes.


>> The opposite case is equally impossible to emulate: unblocking a signal 
>> just for the duration of the syscall.  These are all possible and used 
>> cases.
>  
> Add and remove appropriate kevent - it is as simple as call for one
> function.

No, it's not.  The kevent stuff handles only the kevent handler (i.e., 
the replacement for calling the signal handler).  It cannot set signal 
masks.  I am talking about signal masks here.  And don't suggest "I can 
add another kevent feature where I can register signal masks".  This 
would be ridiculous since it's not an event source.  Just add the 
parameter and every base is covered and, at least equally important, we 
have symmetry between the event handling interfaces.


>> No, that's not what I mean.  There is no need for the special 
>> timer-related part of your patch.  Instead the existing POSIX timer 
>> syscalls should be modified to handle SIGEV_KEVENT notification.  Again, 
>> keep the interface as small as possible.  Plus, the POSIX timer 
>> interface is very flexible.  You don't want to duplicate all that 
>> functionality.
> 
> Interface is already there with kevent_ctl(KEVENT_ADD), I just created
> additional entry, which describes timers enqueue/dequeue callbacks

New multiplexers cases are additional syscalls.  This is unnecessary 
code.  Increased kernel interface and such.  We have the POSIX timer 
interfaces which are feature-rich and standardized *and* can be triviall 
extended (at least from the userlevel interface POV) to use event 
queues.  If you don't want to do this, fine, I'll try to get it made. 
But drop the timer part of your patches.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
