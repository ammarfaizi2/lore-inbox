Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261846AbSIXXTr>; Tue, 24 Sep 2002 19:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbSIXXTr>; Tue, 24 Sep 2002 19:19:47 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:38274 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S261846AbSIXXTp>; Tue, 24 Sep 2002 19:19:45 -0400
Date: Tue, 24 Sep 2002 16:21:44 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Ingo Molnar <mingo@elte.hu>,
       Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020924232144.GA3785@gnuppy.monkey.org>
References: <Pine.LNX.3.96.1020922093417.6569A-100000@gatekeeper.tmr.com> <m1u1khkgt7.fsf@frodo.biederman.org> <20020923001125.GA1983@gnuppy.monkey.org> <m1fzvzjrr2.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1fzvzjrr2.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 10:07:29AM -0600, Eric W. Biederman wrote:
> If they have any sense they also have an incremental GC algorithm.  That
> the GC thread can sit around all day and executing.  If they are actually
> using a stop and collect algorithm there are real issues.  Though I would
> love to see the Java guys justify a copy collector...

They have that and other crazy things. Thread local storage facilities, etc...

> > regular boundary in the compiled code block.
> Agreed, but what was this talk earlier about safe points?

It's needed to deal with exceptions and GC.

> >  It's for that reason that
> > you have to some kind of OS level threading support to get the ucontext.
> 
> I don't quite follow the need and I'm not certain you do either.  A full
> GC pass is very expensive.  So saving a threads context in user space

But you haven't read the code and the supporting white papers for this
JIT compiler otherwise you wouldn't be whining about this. HotSpot is
no whimp when it comes to these issues. Compilers execute code, code is
stored some where and does memory allocation. Geez.

> should not be a big deal.  It is very minor compared to the rest
> of the work going on.  Especially in a language like java where practically
> everything lives on the heap.

Then you need to look at the compilation architecture of HotSpot. It's pretty
different than your picture of it and is gross oversimplification. Hell,
I don't know what much of it does since it's so freaking large.

> The thing that sounds sensible to me is that before a threads makes a blocking
> call it can be certain to save relevant bits of information to the stack.  But
> x86 is easy what to do with the pointer heavy architectures where pushing
> all of the registers onto the stack starts getting expensive is an entirely
> different question.

Dude, you have not been reading this thread... Nothing valuable is at syscall
time per thread, those are external symbol calls that contain nothing of value
to the GC. It's allowed to execute at that point so any allocated chunk of memory
is going to be properly shoved some where known to the GC.

The stuff that's of value to maintain the correctness of this is within executing
code blocks in the method dictionary... move the program counter to a specific
place, funny execution stuff that I haven't looked at yet since I was pretty happy
about getting the threading glue to the OS working, etc...

> But beyond that.  The most sensible algorithm I can see is a
> generational incremental collector where each thread has it's own
> local heap, and does it's own local garbage collection. And only the
> boundary where the local heap meets the global heap needs to collected
> by the collector for all threads.  This preserves a lot of cache
> locality as well as circumventing the whole ucontext issue.

Which HotSpot has...Read the papers... Thread local storage exists.

This isn't a just a GC library isolated from a compiler. This a very sophisticated
compiler with a heavy threading infrastructure and you have to take into account
various kinds of interaction with the GC. It is non-trivial stuff.

> If getting the registers is really a bottle neck in the garbage
> collector I suspect it can probably share some generic primitives
> with user mode linux.

It can be if you have to send a single to each thread to get the ucontext.

> If support really needs to happen I suspect this case is close
> enough to what that user mode linux is doing that someone should
> look at how the same mechanism to get the register state can be
> shared.

With a non-PTRACE interface to those ucontexts...

bill

