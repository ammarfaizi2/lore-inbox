Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265346AbSKACuH>; Thu, 31 Oct 2002 21:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265584AbSKACuH>; Thu, 31 Oct 2002 21:50:07 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:50355 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265346AbSKACuE>;
	Thu, 31 Oct 2002 21:50:04 -0500
Date: Fri, 1 Nov 2002 02:56:14 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Matthew D. Hall" <mhall@free-market.net>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
Message-ID: <20021101025614.GD30865@bjl1.asuk.net>
References: <20021031154112.GB27801@bjl1.asuk.net> <Pine.LNX.4.44.0210311211160.1562-100000@blue1.dev.mcafeelabs.com> <20021031230215.GA29671@bjl1.asuk.net> <3DC1DEFB.6070206@free-market.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC1DEFB.6070206@free-market.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew D. Hall wrote:
> The API should present the notion of a general edge-triggered event 
> (e.g. I/O upon sockets, pipes, files, timers, etc.), and it should do so 
> simply.

Agreed.  Btw, earlier today I had misgivings about epoll, but since
I've had such positive response from Davide I think epoll has
potential to become that ideal interface...

> *  Unless every conceivable event is to be represented as a file (rather 
> unintuitive IMHO), his proposed interface fails to accomodate non-I/O 
> events (e.g. timers,  signals, directory updates, etc.).#

...apart from this one point!

> As much as I appreciate the UNIX Way, making everything a file is a
> massive oversimplification.  We can often stretch the definition far
> enough to make this work, but I'd be impressed to see how one
> intends to call, e.g., a timer a type of file.

If it has an fd, that is, if it has an index into file_table, then
it's a "file".  No other semantics are required for event purposes.

This seems quite weird and pointless at first, but actually fds are
quite useful: you can dup them and pass them between processes, and
they have a security model (you can't use someone else's fd unless
they've passed it to you).  Think of an fd as a handle to an arbitrary
object.

OTOH look at rt-signals: a complete mess, no kernel allocation
mechanism, libraries fight it out and don't always work.  Look at aio:
it has an aio_context_t - IMHO that should be an fd, not an opaque
number that cannot be transferred to another process or polled on.

However, despite all the goodness of fds, you're right.  Event queues
really need to deliver more info than which event and
read/write/hangup.  dnotify events should include what happened and
maybe the inode number.  futex events should include the address.
(rt-signals get close to this but fail due to pseudo-compatibility
with a braindead POSIX standard).

> *  There is a seemingly significant overhead in performing exactly one 
> callback per event.  Doesn't this prevent any kind of event coalescence? 

As you go on to say, this should be a matter for userspace.  My
concern is that kernel space should provide a flexible mechanism for a
variety of possible userspaces.

> *  The interface should allow the implementation to be highly extensible 
> without horrible code contortions within the kernel.  It is important to 
> be able to add new types of events as they become necessary.  The 
> interface should be general and simple enough to accomodate these 
> extensions.  Linux (really, UNIX) has failed to exercise this foresight 
> in the past, and that's why we have the current mess of varied 
> polling/triggering methods.

Agreed, agreed, agreed, agreed.  Fwiw, I now think these can all be
satisfied with some evolution of epoll, if that is permitted.

> *  I might be getting a bit utopian here, but IMHO the kernel should 
> move toward a completely edge-triggered event system.  The old 
> level-triggered interfaces should only wrap this paradigm.

Take a close look at how wait queues and notifier chains are used.
Some of the kernel is edge triggered already.  Admittedly, it's about
as clear as clay at times - some wait queues are used in an
edge-triggered way, others level-triggered.

> *  Might as well reiterate: simplicity.  FreeBSD's kevent solves nearly 
> all of the traditional problems, but it is gross.  And complicated. 

Could you explain what you find complicated and/or gross about kevent?
We should learn from their mistakes.

> There were clearly too many computer scientists and not enough 
> engineers on that team.

I am both ;)

> *  Only one queue per process or kernel thread.  Multiple queues per 
> flow of execution is just ugly and ultimately pointless.

Disagree.  You're right that it's technically not necessary to have
multiple queues, but in practice you can't always force an entire
program to funnel all its I/O through one library - that just doesn't
happen in reality.  And there is basically no cost to having multiple
queues.  Keyed off fds :)

That was a mistake made by rt-signals: assuming all the different bits
of code that use rt-signals will cooperate.  Theoretically solvable in
user space.  In reality, they don't know about each other.  Although
my code at least searches for a free rt-signal, that's not guaranteed
to work if another library assumes a fixed value.

The same problem occurs with the LDT.  Glibc wants to use it and so do I.
Conflict.

> Since the event notification is edge-triggered, I cannot see any
> reason for a significant performance degradation resulting from this
> policy.  I am not altogether convinced that this must be a strict
> policy, however; the issue of different userspace threads having
> different event queues inside the same task is interesting.

User space threads are often but not always built on top of a simple
scheduler which converts blocking system calls to queued non-blocking
system calls.  If done well, this is a form of virtualisation which
may even be nestable.

You'd expect the event queue mechanism to be included in the set of
blocking system calls which are converted, so multiple userspace
threads would "see" individual queues even though they are multiplexed
by the userspace scheduler.

This works great, until those threads expect mmap() to provide them
with their own separate zero-copy event queues :) So another reason to
need multiple queues from the kernel.

> *  No re-arming events.  They must be manually killed.

I would provide both options, like dnotify does: one-shot and
continuous.  There are occasions when one-shot is better for resource
usage - it depends what the event is monitoring.

> *  I'm sure everyone would agree that passing an opaque "user context" 
> pointer is necessary with each event.

It is not the end of the world to use an fd number and a table, but it
may improve thread scalability to use a pointer instead.

> *  Zero-copy event delivery (of course).

I think this is not critical for performance, but desirable anyway.  I
would take this further:

    1. zero-copy delivery
    2. zero system calls as long as the queue is non-empty
       (like the packet socket mmap interface)
    3. no fixed limit on the size of the queue at creation time

Neither epoll nor aio satisfy (3).  Luckily I have a nice design which
satisfies all these and is extensible in the ways we agree on.

> Some question marks:
> -  Should the kernel attempt to prune the queue of "cancelled" events 
> (hints later deemed irrelevant, untrue, or obsolete by newer events)?

Something is needed in the case of aio cancellations, but I think
that's different to what you mean.  Backtracking hints is quite
difficult to synchronise with userspace if done through mmap and no
system calls.  It's best not to bother.  Coalescing events, which can
have the effect of superceding events in some cases, is a possibility.
It's tricky but more worthwhile than backtracking.

For some kinds of event, such as round robin futex wakeups, it's
critically important that the _number_ of events seen by userspace is
the same as the number sent from the kernel.  In these cases, they are
not just hints, they are synchronisation tokens.  That adds some
excitement to coalescing in a shared memory buffer.

-- Jamie
