Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWIKFnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWIKFnH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWIKFnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:43:07 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:62409 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964879AbWIKFnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:43:03 -0400
Date: Mon, 11 Sep 2006 09:42:17 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Ulrich Drepper <drepper@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take14 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060911054217.GA18907@2ka.mipt.ru>
References: <11564996832717@2ka.mipt.ru> <44F208A5.4050308@redhat.com> <20060831075852.GB21660@2ka.mipt.ru> <a36005b50609090910o68d775afldc93b4647bb148b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <a36005b50609090910o68d775afldc93b4647bb148b2@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 11 Sep 2006 09:42:19 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 09:10:35AM -0700, Ulrich Drepper (drepper@gmail.com) wrote:
> >> - one point of critique which applied to many proposals over the years:
> >>   multiplexer syscalls a bad, really bad. [...]
> >
> >Can you convince Christoph?
> >I do not care about interfaces, but until several people agree on it, I
> >will not change anything.
> 
> I hope that Linus and/or Andrew simply decree that multiplexers are
> bad. glibc and probably strace are the two most affected programs so
> their maintainers should have a say.  My opinion os clear.  Also for
> analysis tools the multiplexers are bad since different numbers of
> parameters are used and maybe even with different types.

Types are exactly the same, actually the whole set of operations
multiplexed in kevents is add/remove/modify. They really look and work 
very similar, so it is not that bad to multiplex them in one syscall.
But yes, we can extend it to 3 differently named ones, which will end up
just in waste of space in syscall tables.
 
> >I use there only id provided by user, it is not his cookie, but it was
> >done to make strucutre as small as possible.
> >Think about size of the mapped buffer when there are several kevent
> >queues - it is all mapped and thus pinned memory.
> >It of course can be extended.
> 
> "It" being what?  The problem is that the structure of the ring buffer
> elements cannot easily be changed later.  So we have to get it right
> now which means being a bit pessimistic about future requirements.
> Add padding, there will certainly be future uses which need more
> space.

"It" was/is a whole situation about mmaped buffer - we can extend it, no
problem, what fields you think needs to be added?

> >> Next, the current interfaces once again fail to learn from a mistake we
> >> made and which got corrected for the other interfaces.  We need to be
> >> able to change the signal mask around the delay atomically.  Just like
> >> we have ppoll for poll, pselect for select (and hopefully soon also
> >> epoll_pwait for epoll_wait) we need to have this feature in the new
> >> interfaces.
> >
> >We able to change kevents atomically.
> 
> I don't understand.  Or you don't understand.  I was talking about
> changing the signal mask atomically around the wait call.  I.e., the
> call needs an additional optional parameter specifying the signal mask
> to use (for the kernel: two parameters, pointer and length).  This
> parameter is not available in the version of the patch I looked at and
> should be added if it's still missing in the latest version of the
> patch.  Again, look at the difference between poll() and ppoll() and
> do the same.

You meant "atomically" with respect to signals, I meant about atomically
compared to simultaneous access.
Looking into ppol() I wonder what is the difference between doing the
same in userspace? There are no special locks, nothing special except
TIF_RESTORE_SIGMASK bit set, so what's the point of it not being done in
userspace?

> >Well, I rarely talk about what other people want, but if you strongly
> >feel, that all posix crap is better than epoll interface, then I can not
> >agree with you.
> 
> You miss the point entirely like DaveM before you.  What I ask for is
> simply a uniform and well established form to tell an interface to use
> the kevent notification mechanism and not sue signals etc.  Look at
> the mail I sent in reply to DaveM's mail.

There is special function in kevents which is used for kevents addition,
which can be called from everywhere (except modules since it is not
exported right now), so one can create _any_ interface he likes.
POSIX timer-look API is not what a lot of people want, since 
epoll/poll/select is completely different thing and exactly _that_ is
what majority of people use. So I create similar interface.
But there are no problem to implement any additional, is is simple.

> >It is possible to create additional one using any POSIX API you like,
> >but I strongly insist on having possibility to use lightweight syscall
> >interface too.
> 
> Again, missing the point.  We can without any significant change
> enable POSIX interfaces and GNU extensions like the timer, AIO, the
> async DNS code, etc use kevents.  For the latter, which is entirely
> implemented at userlevel, we need interfaces to queue kevents from
> userlevel.  I think this is already supported.  The other two
> definitely benefit from using kevent notification and since they
> are/will be handled in the kernel the completion events should be
> queued in a kevent queue as specified in the sigevent structure passed
> to the system call.

I do not object against additional interfaces, no problem,
implementation is really simple. But I strongly object against removing
existing interface, it is there not for the furniture, but since it is
the most convenient way (in my opinion) to use existing (supported by 
kevent) event notifications. If we need additional interfaces, it is
really simple to add them, just use kevent_user_add_ukevent(), which
requires struct ukevent, which desctribe requested notification, and
struct kevent_user, which is those queue where you want to put your
events and which will be checked when events are ready.
 
> >Ring buffer _always_ has space for new events until queue is not filled.
> >So if userspace do not read for too much time it's events and eventually
> >tries to add new one, it will fail early.
> 
> Sorry, I don't understand this at all.
> 
> If the ring buffer always has enough room then events must be
> preregistered.  Is this the case?  Seems very inflexible and who would
> this work with event sources like timers which can trigger many times?

Ready event is only placed once into the buffer, even if timer has fired
many times, how would it look if we put there a notification each time
new data has arrived in network instead of marking KEVENT_SOCKET_RECV
event as ready? It can eat the whole memory, if for each one byte packet
we put there 12 bytes of event.
There is a limit of maximum allowed events in one kevent queue, when
this limit is reached, no new events can be added from userspace until
all previously commited are removed, so that moment is used as limit
factor for mapped buffer - it can grow until maximum allowed number of
events can be placed there.
Such method can look like unconvenient, but I doubt that buffer overflow
scenario (what happens with rt-signals) is really much nicier...

> I hope you don't mean that ring buffers probably won't overflow since
> programs have to handle events fast enough.  That's not acceptable.

:)
 
> >There is no overflow - I do not want to introduce another signal queue
> >overflow crap here.
> >And once again - no signals.
> 
> Well, signals are the only asynchronous notification mechanism we
> have.  But more to the point: why cannot there be overflows?

Kevent queue is limited (for purpose of mapped buffer), so mapped buffer
will grow until it can host maximum number of events (it is 4096 right
now), when such situation happens (i.e. queue is full), no new event can
be added, so no events can be put into the mapped buffer, and it can not
overflow.

> >You basically want to deliver the same event to several users.
> >But how do you want to achive it with network buffers for example.
> >When several threads reads from the same socket, they do not obtain the
> >same data.
> 
> That's not what I am after.  I'm perfectly fine with waking only one
> thread.  In fact, this is how it must be to avoid the trampling herd
> effects.  But there is the problem that if the woken thread is not
> working on the issue for which it was woken (e.g., if the thread got
> canceled) then it must be able to wake another thread.  In affect,
> there should be a syscall which causes a given number of other waiters
> (make the number a parameter to the syscall) is woken.  They would
> start running and if nothing is to be done go back to sleep.  The
> wakeup interface is what is needed.

You look to the problem from some strange and it looks like wrong angle.
There is one queue of events, and that queue does not and can not know
who will read it. It just exists and hosts ready events, if there are
several threads which can access it, how can it detect which one will do
it? How recv() syscall will wake up exactly those thread, which is
supposed to receive the data, but not those one which is supposed to
print info into syslog that data has arrived?
 
> >min_nr is used to specify special case "wake up when at least one event
> >is ready and get all ready ones".
> 
> I understand but when is this really necessary?  The nature of the
> event queue will find many different types of events being reported
> via them.  In such a situation a minimum count is not really useful.
> I would argue this is unnecessary complexity which easily and more
> flexible can be handled at userlevel.

Consider situation when you have web server. Connected user do not want
to wait until 10 other users have connected (or some timeout), 
so server would be awakened and started to process them.
>From the other point, consider someone who writes data asynchronously,
it is much beter to wake him up when several writes are completed, but
not each time one write is ready.

> >There are no "expected outstanding events", I think it can be a problem.
> >Currently there is absolute maximum of events, which can not be
> >increased in real-time.
> 
> That is a problem.  If we succeed in having a unified event mechanism
> the number of outstanding events can be unbounded, only limited by the
> systems capabilities.

Then I will remove mapped buffer implementation, since unbounded pinned
memory is not what we want. Buffer overflow is not the case - recall
rt-signals overflow and recovery.
 
> >Each subsequent mmap will mmap existing buffers, first one mmap can
> >create that buffer.
> 
> OK, so you have magic in mmap() calls using the kevent file
> descriptor?  Seems OK but I will not export this as the interface
> glibc exports.  All this should be abstracted out.

Yes, I use private area created when kevent file descriptor was
allocated.

> >>   Maybe the flags parameter isn't needed, it's just another way to make
> >>   sure we won't regret the design later.  If the ring buffer can fill up
> >>   and this is detected by the kernel (unlike what happens in take 14)
> >
> >Just a repeat - with current buffer implementation it can not happen -
> >maximum  queue length is a limit for buffer size.
> 
> How can the buffer not fill up?  Where is the intformation stored in
> case the userlevel code did not process the ring buffer entries in
> time?

Buffer can be filled completely, but there is no possibility to have an
overflow, since maximum number of events is a limiting factor for buffer
size.
 
> >>     int kevent_wait (int kfd, unsigned ringstate,
> >>                      const struct timespec *timeout,
> >>                      const sigset_t *sigmask)
> >
> >Yes, I agree, this is good syscall.
> >Except signals (no signals, that's the rule) and variable sized timespec
> >structure. What about putting there u64 number of nanoseconds?
> 
> Well, I've explained it already above and repeated during the
> pselect/ppoll discussions.  The sigmask parameter is not to in any way
> a signal that events should be sent using signals.  It is simply a way
> to set the signal mask atomically around the delay to some other
> value.  This is functionality which cannot be implemented at
> userlevel.  Hence we now have pselect and ppoll system call.  The
> kevent_wait syscall will need the same.

What I see in sys_ppol() is just change of the mask and call for usual
poll(), there are no locks and no special tricks.

> >What about following:
> >userspace:
> > - check ring index, if it differs from stored in userspace, then there
> >   are events between old stored index and new one just read.
> > - copy events
> > - call kevent_wait() or other method to show kernel that all events
> >   upto provided in syscall numbers are processed, and thus kernel can
> >   remove them and put there new ones.
> 
> This would require a system call to free ring buffer entries.  And
> delaying the ack of an event (to avoid syscall overhead) means that
> the ring buffer might fill up.
> 
> Having a userlevel-writable fields which indicated whether an entry in
> the ring buffer is free would help to prevent these syscalls and allow
> freeing up the entries.  These fields could be in the form of a bitmap
> outside the actual ring buffer.

I added kevent_wait() exactly for that.
I's parameters allow to complete events, although it is not possible to
complete some event in the middle of set of ready events, only from the
begining.

> If a ring buffer is not wanted, then a simple writable buffer index
> should be used.  This will require that all entries in the ring buffer
> are processed in sequence but I don't consider this too much of a
> limitation.  The kernel only ever reads this buffer index field.
> Instead of making this field part of the mapping (which could be
> read-only) the field index position could be passed to the kernel in
> the syscall to create an kevent queue.
> 
> 
> >kernelspace:
> > - when new kevent is added, it guarantees that there is a place for it
> >   in kernel ring buffer
> 
> How?  Unless you severely want to limit the usefulness of kevents this
> is not possible.  One example, already given above, are periodic
> timers.

Periodic timer is added only once from userspace. And it is marked as
ready when it fires first time. If userspace has missed that it was
fired several times before it was read, than it is userspace's problem -
I put a last timer's ready time into ret_data so userspace can check
how many times this event would be marked as ready.
The same can be applied to other such way triggered events.

> > - when event is ready it is copied into mapped buffer and index of the
> >   "last ready" is increased (it is fully atomic operation)
> > - when userspace calls kevent_wait() kernel get ring index from
> >   syscall, searches for all events upto provided number and free them
> >   (or rearm)
> 
> Yes, that's OK.  But in the fast path no kevent_wait syscall should be
> needed.  If the index variable is exposed in the memory region
> containing the ring buffer no syscall is needed in case the ring
> buffer is not empty.

We need to inform kernel that some events have been processed by
userspace and thus can be rearmed (i.e. mapped as not ready, so 
rearming work could map them as ready again: like received data or
timer timout) or freed - kevent_wait() both
waits and commits (or it does not wait, if events are ready, or
does not commit if provided number of events is zero).

Commiting through writable mapping is not the best way I think, it
introduces a lot of problems with damaged by error events, with
unability to sleep on that variable and so on.

> >As shown above it is already implemented.
> 
> How can you say that.  Just before you said the kevent_wait syscall is
> not implemented.  This paragraph was all about how to use kevent_wait.
> I'll have to look at the latest code to see how the _wait syscall is
> now implemented.

Kevent development is quite fast :)
kevent_wait() is already implemented in the take14 patchset.

-- 
	Evgeniy Polyakov
