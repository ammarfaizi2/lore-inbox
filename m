Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933791AbWKTADs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933791AbWKTADs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 19:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933795AbWKTADs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 19:03:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61910 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933791AbWKTADr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 19:03:47 -0500
Message-ID: <4560F07B.10608@redhat.com>
Date: Sun, 19 Nov 2006 16:02:03 -0800
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
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru>
In-Reply-To: <20061113105458.GA8182@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
>> Possible solution:
>>
>> a) it would be possible to have a "used" flag in each ring buffer entry.
>>    That's too expensive, I guess.
>>
>> b) kevent_wait needs another parameter which specifies the which is the
>>    last (i.e., least recently added) entry in the ring buffer.
>>    Everything between this entry and the current head (in ->kidx) is
>>    occupied.  If multiple threads arrive in kevent_wait the highest idx
>>    (with wrap around possibly lowest) is used.
>>
>>    kevent_wait will not try to move more entries into the ring buffer
>>    if ->kidx and the higest index passed in to any kevent_wait call
>>    is equal (i.e., the ring buffer is full).
>>
>>    There is one issue, though, and that is that a system call is needed
>>    to signal to the kernel that more entries in the ring buffer are
>>    processed and that they can be refilled.  This goes against the
>>    kernel filling the ring buffer automatically (see below)
> 
> If thread calls kevent_wait() it means it has processed previous entries, 
> one can call kevent_wait() with $num parameter as zero, which
> means that thread does not want any new events, so nothing will be
> copied.

This doesn't solve the problem.  You could only request new events when 
all previously reported events are processed.  Plus: how do you report 
events if the you don't allow get_event pass them on?


> Writable ring buffer does not sound too good to me - what if one thread
> will overwrite the whole ring buffer so kernel's indexes can be screwed?

Agreed, there are problems.  This is why I suggested the ring buffer can 
be a structured.  Parts of it might be read-only, other parts 
read/write.  I don't necessarily think the 'used' flag is the right way. 
  And front/tail pointer solution seems to be better.


> Ring buffer processed not in FIFO order is wrong idea

Not necessarily, see my comments about CPU affinity in the previous mail.


> - ring buffer can
> be potentially very big and searching there for the entry, which was
> been marked as 'free' by userspace is not a solution at all - userspace
> in that case must provide ukevent so fast tree search would be used,
> (and although it is already possible) it requires userspace to make
> additional syscalls which is not what we want.

It is not necessary.  I've proposed to only have a fron and tail 
pointer.  The tail pointer is maintained by the application and passed 
to the kernel explicitly or via shared memory.  The kernel maintains the 
front pointer.  No tree needed.


> As a solution I can create folowing scheme:
> there are two syscalls (or one with a switch) which get events and
> commits them.
> 
> kevent_wait() becomes a syscall which waits until number of events or
> one of them becomes ready and just copies them into ring buffer and
> returns. kevent_wait() will fail with special error code when ring
> buffer is full.
> 
> kevent_commit() frees requested number of events _from the beginning_,
> i.e. from special index, visible from userspace. Userspace can create
> special counters for events (and even put them into read-only ring 
> buffer overwriting some fields of kevent, especially if we will increase
> it's size) and only call kevent_commit() when all events have zero usage
> counter.

Right, that's basically the front/tail pointer implementation.  That 
would work.  You just have to make sure that the kevent_wait() call 
takes the current front pointer/index as a parameter.  This way if the 
buffer gets filled between the thread checking the ring buffer (and 
finding it empty) and the syscall being handled the thread is not suspended.


> I disagree that having possibility to have holes in the ring buffer is a
> good idea at all - it requires much more complex protocol, which will
> fill and reuse that holes, and the main disavantge - it requires to
> transfer much more information from userspace to kernelspace to free the
> ring entry in the hole - in that case it is already possible just to
> call kevent_ctl(KEVENT_REMOVE) and do not wash the brain with new
> approach at all.

Well, it would require more data transport of we'd use writable shared 
memory.  But I agree, it's far too complicated and might not scale with 
growing ring buffer sizes.


>> - implementing the kevent_wait syscall the proposed way means we are
>>   missing out on one possible optimization.  The ring buffer is
>>   currently only filled on kevent_wait calls.  I expect that in really
>>   high traffic situations requests are coming in at a higher rate than
>>   the can be processed.  At least for periods of time.  If such
>>   situations it would be nice to not have to call into the kernel at
>>   all.  If the kernel would deliver into the ring buffer on its own
>>   this would be possible.
> 
> Well, it can be done on behalf of workqueue or dedicated thread which
> will bring up appropriate mm context,

I think it should be done.  It's potentially a huge advantage.


> although it means that userspace
> can not handle the load it requested, which is a bad sign...

I don't understand.  What is not supposed to work?  There is nothing 
which cannot work with automatic posting since the get_event() call does 
nothing but copying the event data over and wake a thread.


>> - the kevent_get_event syscall is not  needed at all.  All reporting
>>   should be done using a ring buffer.  There really is not reason to
>>   keep two interfaces around  which serve the same purpose.  Making
>>   the argument the kevent_get_event is so much easier to use is not
>>   valid.  The exposed interface to access the ring buffer will be easy,
>>   too.  In the OLS paper I more or wait hinted at the interfaces.  I
>>   think they should be like this (names are irrelevant):
> 
> Well, kevent_get_events() _is_ much easier to use. And actually having
> only that interface it is possible to implement ring buffer with any
> kind or protocol for its controlling - userspace can have a wrapper
> which will call kevent_get_events() with pointer which shows to the
> place in the shared ring buffer where to place new events, that wrapper
> can handle essentially any kind of flags/parameters which are suitable
> for that ring buffer implementation.

That's far too slow.  The whole point behind the ring buffer is speed. 
And emulation would defeat the purpose.


> But since we started to implement ring buffer as a additional feature of
> kevent, let's find the way all people will be happy with before removing
> something which was proven to work correctly.

The get_event interface is basically the userlevel interface the runtime 
(glibc probably) would provide.  Programmers don't see the complexity.

I'm concerned about the get_event interface holding the kernel 
implementation back.  For instance, automatic filling the ring buffer. 
This would not be possible if the program is free to mix 
kevent_get_event and kevent_wait calls freely.  If you do away with the 
get_event syscall the automatic ring buffer filling is possible and a 
logical extension.


> 
> The last three are exactly kevent_get_events() with different set of
> parameters - it is possible to get events without sleeping, it is
> possible to wait until at least something is ready and it is possible to
> sleep for timeout.

Exactly.  But these interfaces should be implemented at userlevel, not 
at the syscall level.  It's not necessary.  The kernel interface should 
be kept as small as possible and the get_event syscall is pure duplication.


> They all already imeplemented. Just all above, and it was done several
> months ago already. No need to reinvent what is already there.
> Even if we will decide to remove kevent_get_events() in favour of ring
> buffer-only implementation, winting-for-event syscall will be
> essentially kevent_get_events() without pointer to the place where to
> put events.

Right, but this limitation of the interface is important.  It means the 
interface of the kernel is smaller: fewer possibilities for problems and 
fewer constraints if in future something should be changed (and smaller 
kernel).


> I agree that having special syscall to initialize kevent is a good idea,
> and initial kevent implementation had it, but it was removed due to API
> cleanup work by Cristoph Hellwing.

Well, he is wrong.  If, for instance, init or any of the programs which 
start first wants to use the syscall it couldn't because /dev isn't 
mounted.  The program might use libraries and therefore not have any 
influence on whether the kevent stuff is used or not.

Yes, the /dev interface is useful for some/many other kernel interfaces. 
  But this is a core interface.  For the same reason epoll_create is a 
syscall.


> Do you have _any_ kind of benchmarks with epoll() which would show that
> it is feasible? ukevent is one cache line (well, 2 cache lines on old
> CPUs), which can be setup way too far away from the time when it is
> ready, and CPU which origianlly set that up can be busy, so we will lose
> performance waiting until CPU becomes free instead of calling other
> thread on different CPU.

If the period between the generation of the event (e.g., incoming 
network traffic or sent data) and the delivery of the event by waking a 
thread is too long, it makes not too much sense.  But if the L2 cache 
hasn't hasn't been flushed it might be a big advantage.

I think it's reasonable to only have the last queued entry for a CPU 
handled special.  And note, this is only ever a hint.  If an event entry 
was created by the kernel in one CPU but none of the threads which wait 
to be waken is on that CPU, nothing has to be done.

No, I don't have a benchmark.  But it is likely quite easily possible to 
  create a synthetic benachmark.  Maybe with pipes.


> It is possible to specify CPU id in kevent (not in ukevent, i.e. not
> in shared by userspace structure, but in it's kernel representation),
> and then check if currently active CPU is the same or not, but what if
> it is not the same CPU?

Nothing special.  It's up to the userlevel wrapper code.  The CPU number 
would only be a hint.


> Entry order is important, since application can
> take advantage of synchronization, so idea to skip some entries is bad.

That's something the application should be make a call about.  It's not 
always (or even mostly) the case that the ordering of the notification 
is important.  Furthermore, this would also require the kernel to 
enforce an ordering.  This is expensive on SMP machines.  A locally 
generated event (i.e., source and the thread reporting the event) can be 
delivered faster than an event created on another CPU.


> It is management task - kernel should not even know about someone has
> died and can not process events it requested.

But the kernel has to be involed.


> Userspace can open a control pipe (and setup a kevent handler for it) 
> and glibc will write there a byte thus awakening some other thread.
> It can be done in userspace and should be done in userspace.

That's invasive.  The problem is that no userlevel interface should have 
to implicitly keep file descriptors open.  This would mean the 
application would be influenced since suddenly a file descriptor is not 
available anymore.  Yes, applications shouldn't care but they 
unfortunately sometimes do.


> Will we discuss it for death?
> 
> Kevent does not need to have absolute timeout.

Of course it does.  Just because you don't see a need for it for your 
applications right now it doesn't mean it's not a valid use.


> Because timeout specified there is always related to the start of
> syscall, since it is a timeout which specifies maximum time frame
> syscall can live.

That's your current implementation.  There is absolutely no reason 
whatsoever why this couldn't be changed.
> I created kevent_signal notifications - it allows user to setup any set
> of interested signals before call to kevent_get_events() and friends.
> 
> No need to solve a problem with operation way when there is tactical and
> strategical ones

Of course there is a need and I explained it before.  Getting signal 
notifications is in no way the same as changing the signal mask 
temporarily.  You cannot correctly emulate the case where you want to 
block a signal while in the call as reenable it afterwards.  Receiving 
the signal as an event and then artificially raising it is not the same. 
  Especially timing-wise, the signal kevent might not be seen long after 
the syscall returns because other entries are worked on first.

The opposite case is equally impossible to emulate: unblocking a signal 
just for the duration of the syscall.  These are all possible and used 
cases.


>> - the KEVENT_REQ_WAKEUP_ONE functionality is good and needed.  But I
>>   would reverse the default.  I cannot see many places where you want
>>   all threads to be woken.  Introduce KEVENT_REQ_WAKEUP_ALL instead.
> 
> I.e. to wake up only first thread always and in addon those threads
> which have specified flag set? Ok, will put into todo foer the next
> release.

It's a flag for an event.  So the threads won't have the flag set.  If 
an event is delivered with the flag set, wake all threads.  Otherwise 
just one.


>> - there is really no reason to invent yet another timer implementation.
>>   We have the POSIX timers which are feature rich and nicely
>>   implemented.  All that is needed is to implement SIGEV_KEVENT as a
>>   notification mechanism.  The timer is registered as part of the
>>   timer_create() syscalls.
> 
> Feel free to add any interface you like - it is as simple as call for
> kevent_user_add_ukevent() in userspace.

No, that's not what I mean.  There is no need for the special 
timer-related part of your patch.  Instead the existing POSIX timer 
syscalls should be modified to handle SIGEV_KEVENT notification.  Again, 
keep the interface as small as possible.  Plus, the POSIX timer 
interface is very flexible.  You don't want to duplicate all that 
functionality.


> And I almost silently stay behind with the fact that it is possbile to
> implement _all_ above ring buffer things in userspace with
> kevent_get_events() and this functionality is there for almost a year :)

Again, this defeats the purpose completely.  The ring buffer is the 
faster interface, especially when coupled with asynchronous filling of 
ring buffer (i.e., without a syscal).


> Let's solve problem in order of theirs appearance - what do you think
> about above interface for ring buffer?

Looks better, yes.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
