Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261697AbSIXQSW>; Tue, 24 Sep 2002 12:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbSIXQSW>; Tue, 24 Sep 2002 12:18:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3930 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261697AbSIXQSV>; Tue, 24 Sep 2002 12:18:21 -0400
To: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Ingo Molnar <mingo@elte.hu>,
       Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
References: <Pine.LNX.3.96.1020922093417.6569A-100000@gatekeeper.tmr.com>
	<m1u1khkgt7.fsf@frodo.biederman.org>
	<20020923001125.GA1983@gnuppy.monkey.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Sep 2002 10:07:29 -0600
In-Reply-To: <20020923001125.GA1983@gnuppy.monkey.org>
Message-ID: <m1fzvzjrr2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (Hui) <billh@gnuppy.monkey.org> writes:

> On Sun, Sep 22, 2002 at 12:41:40PM -0600, Eric W. Biederman wrote:
> > They are talking about an incremental GC routine so it does not need to stop
> > all threads simultaneously.  Threads only need to be stopped when the GC is
> gather
> 
> > a root set.  This is what the safe points are for right?  And it does
> > not need to be 100% accurate in finding all of the garbage.  The
> > collector just needs to not make mistakes in the other direction.
> 
> There's a mixture of GC algorithms in HotSpot including generational and I
> believe a traditional mark/sweep. GC isn't my expertise per se.

If they have any sense they also have an incremental GC algorithm.  That
the GC thread can sit around all day and executing.  If they are actually
using a stop and collect algorithm there are real issues.  Though I would
love to see the Java guys justify a copy collector...

> Think, you have a compiled code block and you suspend/interrupt threads when
> you either start hitting the stack yellow guard or by a periodic GC thread...
> 
> That can happen anytime, so you can't just expect things to drop onto a
> regular boundary in the compiled code block.

Agreed, but what was this talk earlier about safe points?

>  It's for that reason that
> you have to some kind of OS level threading support to get the ucontext.

I don't quite follow the need and I'm not certain you do either.  A full
GC pass is very expensive.  So saving a threads context in user space
should not be a big deal.  It is very minor compared to the rest
of the work going on.  Especially in a language like java where practically
everything lives on the heap.

The thing that sounds sensible to me is that before a threads makes a blocking
call it can be certain to save relevant bits of information to the stack.  But
x86 is easy what to do with the pointer heavy architectures where pushing
all of the registers onto the stack starts getting expensive is an entirely
different question.

But beyond that.  The most sensible algorithm I can see is a
generational incremental collector where each thread has it's own
local heap, and does it's own local garbage collection. And only the
boundary where the local heap meets the global heap needs to collected
by the collector for all threads.  This preserves a lot of cache
locality as well as circumventing the whole ucontext issue.

If getting the registers is really a bottle neck in the garbage
collector I suspect it can probably share some generic primitives
with user mode linux.

If support really needs to happen I suspect this case is close
enough to what that user mode linux is doing that someone should
look at how the same mechanism to get the register state can be
shared.

Eric
