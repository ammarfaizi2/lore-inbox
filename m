Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754882AbWKKWb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbWKKWb6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 17:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947324AbWKKWb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 17:31:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40847 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754879AbWKKWb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 17:31:56 -0500
Message-ID: <45564EA5.6020607@redhat.com>
Date: Sat, 11 Nov 2006 14:28:53 -0800
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
References: <11630606361046@2ka.mipt.ru>
In-Reply-To: <11630606361046@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> Generic event handling mechanism.
> [...]

Sorry for the delay again.  Kernel work is simply not my highest priority.

I've collected my comments on some parts of the patch.  I haven't gone 
through every part of the patch yet.  Sorry for the length.

===================

- basic ring buffer problem: the kevent_copy_ring_buffer function stores
   the event in the ring buffer without disregard of the current content.

   + if dequeued entries larger than number of ring buffer entries
     events immediately get overwritten without passing anything to
     userlevel

   + as with the old approach, the ring buffer is basically unusable with
     multiple threads/processes.  A thread calling kevent_wait might
     cause entries another thread is still working on to be overwritten.

Possible solution:

a) it would be possible to have a "used" flag in each ring buffer entry.
    That's too expensive, I guess.

b) kevent_wait needs another parameter which specifies the which is the
    last (i.e., least recently added) entry in the ring buffer.
    Everything between this entry and the current head (in ->kidx) is
    occupied.  If multiple threads arrive in kevent_wait the highest idx
    (with wrap around possibly lowest) is used.

    kevent_wait will not try to move more entries into the ring buffer
    if ->kidx and the higest index passed in to any kevent_wait call
    is equal (i.e., the ring buffer is full).

    There is one issue, though, and that is that a system call is needed
    to signal to the kernel that more entries in the ring buffer are
    processed and that they can be refilled.  This goes against the
    kernel filling the ring buffer automatically (see below)


Threads should be able to (not necessarily forced to) use the
interfaces like this:

- by default all threads are "parked" in the kevent_wait syscall.


- If an event occurs one thread might be woken (depending on the 'num'
   parameter)

- the woken thread(s) work on all the events in the ring buffer and
   then call kevent_wait() again.

This requires that the threads can independently call kevent_wait()
and that they can independently retrieve events from the ring buffer
without fear the entry gets overwritten before it is retrieved.
Atomically retrieving entries from the ring buffer can be implemented
at userlevel.  Either the ring buffer is writable and a field in each
ring buffer entry can be used as a 'handled' flag.  Obviously this can
be done with atomic compare-and-exchange.  If the ring buffer is not
writable then, as part of the userlevel wrapper around the event
handling interfaces, another array is created which contains the use
flags for each ring buffer entry.  This is less elegant and probably
slower.

===================

- implementing the kevent_wait syscall the proposed way means we are
   missing out on one possible optimization.  The ring buffer is
   currently only filled on kevent_wait calls.  I expect that in really
   high traffic situations requests are coming in at a higher rate than
   the can be processed.  At least for periods of time.  If such
   situations it would be nice to not have to call into the kernel at
   all.  If the kernel would deliver into the ring buffer on its own
   this would be possible.

   If the argument against this is that kevent_get_event should be
   possible the answer is...

===================

- the kevent_get_event syscall is not  needed at all.  All reporting
   should be done using a ring buffer.  There really is not reason to
   keep two interfaces around  which serve the same purpose.  Making
   the argument the kevent_get_event is so much easier to use is not
   valid.  The exposed interface to access the ring buffer will be easy,
   too.  In the OLS paper I more or wait hinted at the interfaces.  I
   think they should be like this (names are irrelevant):

ec_t ec_create(unsigned flags);
int ec_destroy(ec_t ec);
int ec_poll_event(ec_t ec, event_data_t *d);
int ec_wait_event(ec_t ec, event_data_t *d);
int ec_timedwait_event(ec_t ec, event_data_t *d, struct timespec *to);

The latter three interfaces are the interesting ones.  We have to get
the data out of the ring buffer as quickly as possible.  So the
interfaces require passing in a reference to an object which can hold
the data.  The 'poll' variant won't delay, the other two will.

We need separate create and destroy functions since there will always
be a userlevel component of the data structures.  The create variant
can allocate the ring buffer and the other memory needed ('handled'
flags, tail pointers, ...) and destroy free all resources.

These interfaces are fast and easy to use.  At least as easy as the
kevent_get_event syscall.  And all transparently implemented on top of
the ring buffer.  So, please let's drop the unneeded syscall.

===================

- another optimization I am thinking about is optimizing the thread
   wakeup and ring buffer use for cache line use.  I.e., if we know
   an event was queued on a specific CPU then the wakeup function
   should take this into account.  I.e., if any of the threads
   waiting was/will be scheduled on the same CPU it should be
   preferred.

   With the current simple form of a ring buffer this isn't sufficient,
   though.  Reading all entries in the ring buffer until finding the
   one written by the CPU in question is not helpful.  We'd need a
   mechanism to point the thread to the entry in question.  One
   possibility to do this is to return the ring buffer entry as the
   return value of the kevent_wait() syscall.  This works fine if the
   thread only works for one event (which I guess will be 99.999% of
   all uses).  An extension could be to extend the ukevent structure to
   contain an index of the next entry written the same CPU.

   Another problem this entails is false sharing of the ring buffer
   entries.  This would probably require to pad the ukevent structure
   to 64 bytes.  It's not that much more, 40 bytes so far, it's
   also more future-safe.  The alternative is to allocate have per-CPU
   regions in the ring buffer.  With hotplug CPUs this is just plain
   silly.

   I think this optimization has the potential to help quite a bit,
   especially for large machines.

===================

- we absolutely need an interface to signal the kernel that a thread,
   just woken from kevent_wait, cannot handle the events.  I.e., the
   events are in the ring buffer but all the other threads are in the
   kernel in their kevent_wait calls.  The new syscall would wake up
   one or more threads to handle the events.

   This syscall is for instance necessary if the thread calling
   kevent_wait is canceled.  It might also be needed when a thread
   requested more than one event and realizes processing an entry
   takes a long time and that another thread might work on the other
   items in the meantime.


   Al Viro pointed out another possible solution which also could solve
   the "handled" flag problem and concurrency in use of the ring buffer.

   The idea is to require the kevent_wait() syscall to signal which entry
   in the ring buffer is handled or not handled.  This means:

   + the kernel knows at any time which entries in the buffer are free
     and which are not

   + concurrent filling of the ring buffer is no problem anymore since
     entries are not discarded until told

   + by not waiting for event (num parameter == 0) the syscall can be
     used to discard entries to free up the ring buffer before continuing
     to work on more entries.  And, as per the requirement above, it can
     be used to tell the kernel that certain entries are *NOT* handled
     and need to be sent to another thread.  This would be useful in the
     thread cancellation case.

   This seems like a nice approach.

===================

- why no syscall to create kevent queue?  With dynamic /dev this might
   be a problem and it's really not much additional code.  What about
   programs which want to use these interfaces before /dev is set up?

===================

- still: the syscall should use a struct timespec* timeout parameter
   and not nanosecs.  There are at least three timeout modes which
   are wanted:

   + relative, unconditionally wait that long

   + relative, aborted in case of large enough settimeofday() or NTP
     adjustment

   + absolute timeout.  Probably even with selecting which clock ot use.
     This mode requires a timespec value parameter


   We have all this code already in the futex syscall.  It just needs to
   be generalized or copied and adjusted.

===================

- still: no signal mask parameter in the kevent_wait (and get_event)
   syscall.  Regardless of what one thinks about signals, they are used
   and integrating the kevent interface into existing code requires
   this functionality.  And it's not only about receiving signals.
   The signal mask parameter can also be used to _prevent_ signals from
   being delivered in that time.

===================

- the KEVENT_REQ_WAKEUP_ONE functionality is good and needed.  But I
   would reverse the default.  I cannot see many places where you want
   all threads to be woken.  Introduce KEVENT_REQ_WAKEUP_ALL instead.

===================

- there is really no reason to invent yet another timer implementation.
   We have the POSIX timers which are feature rich and nicely
   implemented.  All that is needed is to implement SIGEV_KEVENT as a
   notification mechanism.  The timer is registered as part of the
   timer_create() syscalls.

===================


I haven't yet looked at the other event sources.  I think the above is
enough for now.


-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
