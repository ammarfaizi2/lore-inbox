Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWIIQKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWIIQKk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 12:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWIIQKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 12:10:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:22703 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964795AbWIIQKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 12:10:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pGEjFrMYt05fA+XGgC+XY3HHeY5qhYlN3jCRi3AqOGC+x9LZgR+hCUP0NT3w1ur3H0Um1TN8l6tfYGgTQbmffdWqPtqp+hgBERGDXNNfQ5qD5gTUCWmmxchuvmKUNaVxPlqAkg11LroATPZfGzJpADhZNnTk9mMeGyMBCu32ClY=
Message-ID: <a36005b50609090910o68d775afldc93b4647bb148b2@mail.gmail.com>
Date: Sat, 9 Sep 2006 09:10:35 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: [take14 0/3] kevent: Generic event handling mechanism.
Cc: "Ulrich Drepper" <drepper@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       "David Miller" <davem@davemloft.net>, "Andrew Morton" <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, "Zach Brown" <zach.brown@oracle.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Chase Venters" <chase.venters@clientec.com>
In-Reply-To: <20060831075852.GB21660@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11564996832717@2ka.mipt.ru> <44F208A5.4050308@redhat.com>
	 <20060831075852.GB21660@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> Sorry ofr long delay - I was on small vacations.

No vacation here, but travel nontheless.

> > - one point of critique which applied to many proposals over the years:
> >   multiplexer syscalls a bad, really bad. [...]
>
> Can you convince Christoph?
> I do not care about interfaces, but until several people agree on it, I
> will not change anything.

I hope that Linus and/or Andrew simply decree that multiplexers are
bad. glibc and probably strace are the two most affected programs so
their maintainers should have a say.  My opinion os clear.  Also for
analysis tools the multiplexers are bad since different numbers of
parameters are used and maybe even with different types.


> You completely miss AIO here (I talk not about POSIX AIO).

Sure, I should have mentioned it.  But I was assuming this all along.


> I use there only id provided by user, it is not his cookie, but it was
> done to make strucutre as small as possible.
> Think about size of the mapped buffer when there are several kevent
> queues - it is all mapped and thus pinned memory.
> It of course can be extended.

"It" being what?  The problem is that the structure of the ring buffer
elements cannot easily be changed later.  So we have to get it right
now which means being a bit pessimistic about future requirements.
Add padding, there will certainly be future uses which need more
space.


> > Next, the current interfaces once again fail to learn from a mistake we
> > made and which got corrected for the other interfaces.  We need to be
> > able to change the signal mask around the delay atomically.  Just like
> > we have ppoll for poll, pselect for select (and hopefully soon also
> > epoll_pwait for epoll_wait) we need to have this feature in the new
> > interfaces.
>
> We able to change kevents atomically.

I don't understand.  Or you don't understand.  I was talking about
changing the signal mask atomically around the wait call.  I.e., the
call needs an additional optional parameter specifying the signal mask
to use (for the kernel: two parameters, pointer and length).  This
parameter is not available in the version of the patch I looked at and
should be added if it's still missing in the latest version of the
patch.  Again, look at the difference between poll() and ppoll() and
do the same.


> Well, I rarely talk about what other people want, but if you strongly
> feel, that all posix crap is better than epoll interface, then I can not
> agree with you.

You miss the point entirely like DaveM before you.  What I ask for is
simply a uniform and well established form to tell an interface to use
the kevent notification mechanism and not sue signals etc.  Look at
the mail I sent in reply to DaveM's mail.


> It is possible to create additional one using any POSIX API you like,
> but I strongly insist on having possibility to use lightweight syscall
> interface too.

Again, missing the point.  We can without any significant change
enable POSIX interfaces and GNU extensions like the timer, AIO, the
async DNS code, etc use kevents.  For the latter, which is entirely
implemented at userlevel, we need interfaces to queue kevents from
userlevel.  I think this is already supported.  The other two
definitely benefit from using kevent notification and since they
are/will be handled in the kernel the completion events should be
queued in a kevent queue as specified in the sigevent structure passed
to the system call.


> Ring buffer _always_ has space for new events until queue is not filled.
> So if userspace do not read for too much time it's events and eventually
> tries to add new one, it will fail early.

Sorry, I don't understand this at all.

If the ring buffer always has enough room then events must be
preregistered.  Is this the case?  Seems very inflexible and who would
this work with event sources like timers which can trigger many times?

I hope you don't mean that ring buffers probably won't overflow since
programs have to handle events fast enough.  That's not acceptable.


> There is no overflow - I do not want to introduce another signal queue
> overflow crap here.
> And once again - no signals.

Well, signals are the only asynchronous notification mechanism we
have.  But more to the point: why cannot there be overflows?


> You basically want to deliver the same event to several users.
> But how do you want to achive it with network buffers for example.
> When several threads reads from the same socket, they do not obtain the
> same data.

That's not what I am after.  I'm perfectly fine with waking only one
thread.  In fact, this is how it must be to avoid the trampling herd
effects.  But there is the problem that if the woken thread is not
working on the issue for which it was woken (e.g., if the thread got
canceled) then it must be able to wake another thread.  In affect,
there should be a syscall which causes a given number of other waiters
(make the number a parameter to the syscall) is woken.  They would
start running and if nothing is to be done go back to sleep.  The
wakeup interface is what is needed.


> min_nr is used to specify special case "wake up when at least one event
> is ready and get all ready ones".

I understand but when is this really necessary?  The nature of the
event queue will find many different types of events being reported
via them.  In such a situation a minimum count is not really useful.
I would argue this is unnecessary complexity which easily and more
flexible can be handled at userlevel.

> There are no "expected outstanding events", I think it can be a problem.
> Currently there is absolute maximum of events, which can not be
> increased in real-time.

That is a problem.  If we succeed in having a unified event mechanism
the number of outstanding events can be unbounded, only limited by the
systems capabilities.


> Each subsequent mmap will mmap existing buffers, first one mmap can
> create that buffer.

OK, so you have magic in mmap() calls using the kevent file
descriptor?  Seems OK but I will not export this as the interface
glibc exports.  All this should be abstracted out.


> >   Maybe the flags parameter isn't needed, it's just another way to make
> >   sure we won't regret the design later.  If the ring buffer can fill up
> >   and this is detected by the kernel (unlike what happens in take 14)
>
> Just a repeat - with current buffer implementation it can not happen -
> maximum  queue length is a limit for buffer size.

How can the buffer not fill up?  Where is the intformation stored in
case the userlevel code did not process the ring buffer entries in
time?


> >     int kevent_wait (int kfd, unsigned ringstate,
> >                      const struct timespec *timeout,
> >                      const sigset_t *sigmask)
>
> Yes, I agree, this is good syscall.
> Except signals (no signals, that's the rule) and variable sized timespec
> structure. What about putting there u64 number of nanoseconds?

Well, I've explained it already above and repeated during the
pselect/ppoll discussions.  The sigmask parameter is not to in any way
a signal that events should be sent using signals.  It is simply a way
to set the signal mask atomically around the delay to some other
value.  This is functionality which cannot be implemented at
userlevel.  Hence we now have pselect and ppoll system call.  The
kevent_wait syscall will need the same.


> What about following:
> userspace:
>  - check ring index, if it differs from stored in userspace, then there
>    are events between old stored index and new one just read.
>  - copy events
>  - call kevent_wait() or other method to show kernel that all events
>    upto provided in syscall numbers are processed, and thus kernel can
>    remove them and put there new ones.

This would require a system call to free ring buffer entries.  And
delaying the ack of an event (to avoid syscall overhead) means that
the ring buffer might fill up.

Having a userlevel-writable fields which indicated whether an entry in
the ring buffer is free would help to prevent these syscalls and allow
freeing up the entries.  These fields could be in the form of a bitmap
outside the actual ring buffer.

If a ring buffer is not wanted, then a simple writable buffer index
should be used.  This will require that all entries in the ring buffer
are processed in sequence but I don't consider this too much of a
limitation.  The kernel only ever reads this buffer index field.
Instead of making this field part of the mapping (which could be
read-only) the field index position could be passed to the kernel in
the syscall to create an kevent queue.


> kernelspace:
>  - when new kevent is added, it guarantees that there is a place for it
>    in kernel ring buffer

How?  Unless you severely want to limit the usefulness of kevents this
is not possible.  One example, already given above, are periodic
timers.


>  - when event is ready it is copied into mapped buffer and index of the
>    "last ready" is increased (it is fully atomic operation)
>  - when userspace calls kevent_wait() kernel get ring index from
>    syscall, searches for all events upto provided number and free them
>    (or rearm)

Yes, that's OK.  But in the fast path no kevent_wait syscall should be
needed.  If the index variable is exposed in the memory region
containing the ring buffer no syscall is needed in case the ring
buffer is not empty.

> As shown above it is already implemented.

How can you say that.  Just before you said the kevent_wait syscall is
not implemented.  This paragraph was all about how to use kevent_wait.
 I'll have to look at the latest code to see how the _wait syscall is
now implemented.
