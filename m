Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261542AbSIXDee>; Mon, 23 Sep 2002 23:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261543AbSIXDee>; Mon, 23 Sep 2002 23:34:34 -0400
Received: from findaloan-online.cc ([216.209.85.42]:36868 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261542AbSIXDed>;
	Mon, 23 Sep 2002 23:34:33 -0400
Date: Mon, 23 Sep 2002 23:37:14 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@mac.com>,
       Ingo Molnar <mingo@elte.hu>, Larry McVoy <lm@bitmover.com>,
       Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923233714.B2880@mark.mielke.cc>
References: <987738530@toto.iv> <15759.53896.973330.270617@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15759.53896.973330.270617@wombat.chubb.wattle.id.au>; from peter@chubb.wattle.id.au on Tue, Sep 24, 2002 at 12:48:40PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 12:48:40PM +1000, Peter Chubb wrote:
> >>>>> "Mark" == Mark Mielke <mark@mark.mielke.cc> writes:
> Mark>     OS threads: 1) thread#1 invokes a system call 2) OS switches
> Mark> tasks to thread#2 and returns from blocking
> Mark>     user-space threads: 1) thread#1 invokes a system call 2)
> Mark> thread#1 returns from system call, EWOULDBLOCK 3) thread#1
> Mark> invokes poll(), select(), ioctl() to determine state 4) thread#1
> Mark> returns from system call 5) thread#1 switches stack pointer to
> Mark> be thread#2 upon determination that the resource thread#2 was
> Mark> waiting on is ready.
> No way!  THe Solaris M:N model notices when all threads belonging to a
> process have blocked, and wakes up the master thread, which can then
> create a new kernel thread if there are any user-mode threads that can
> do work.

As I said, far from accurate, and M:N is really a compromise between
the two approaches, it is not an extreme.

M:N really doesn't mean much at all except that it makes no guarantees
that each thread requires an OS thread, or that only one thread will
be active at any given time.

M:N makes no promises to be faster, although, as with any innovation
designed by engineers who take pride in their work, it is a method of
achieving a goal... that is, getting around costly system invocations
by optimizing system invocations in user space. Is it better? Maybe? 
Has it traditionally allowed standard applications that make use of
threads to perform better than if the application used only kernel
threads? Yes.

Can the rules be broken? I have not seen a single reason to show why
they cannot be broken. M:N is a necessity for kernels that have heavy
weight thread synchronization primitives, or heavy weight context
switching. Are the rules the same with thread synchronization primitives
that have the similar weight whether 1:1 or M:N? (i.e. FUTEX) Are the
rules the same if context switching in kernel space can be made cheaper,
if the scheduling issues can be addressed, or if M:N must rely on just as
many kernel invocations?

Is M:N really cheaper in your Solaris example, where a new thread is
created by the master thread on demand? If threads were sufficiently
light-weight, I do not see how you could consider a master thread
sitting on SIGIO/select()/poll()/ioctl() switching to a thread in the
pool could be cheaper than the kernel pulling a stopped thread into
the run queue.

This is one of those things where the 'proof is in the pudding'. It is
difficult to theorize anything as almost all theory on this subject is
based on comparing performance under a different set of rules. M:N was
necessary before as 1:1 was not feasible. Now that 1:1 may be reaching
the state of being feasible, the rules change, and previous attempts
at analyzing the data mean very little. Previous conclusions mean very
little.

I am one who wants to see what happens. Worst case, M:N
implementations can use the same enhancements that were designed for
1:1, and benefit. The most obviously example, that needs to be
mentioned once again, is FUTEX. By each application, it might benefit
1:1, or M:N, but as a kernel feature, it benefits anybody who can
invent a use for it.

Fast thread switching? This provides a benefit for M:N. In fact, I would
suspect that the people comparing the best 1:1 implementation with the best
M:N implementation will find that once all the patches are applied, the
race will be closer than most people thought, but that BOTH will perform
better on 2.5.x than either ever did on 2.4.x and earlier.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

