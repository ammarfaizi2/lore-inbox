Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbTBQAuv>; Sun, 16 Feb 2003 19:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbTBQAuv>; Sun, 16 Feb 2003 19:50:51 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27811 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S266736AbTBQAuu>; Sun, 16 Feb 2003 19:50:50 -0500
Date: Sun, 16 Feb 2003 17:00:36 -0800
Message-Id: <200302170100.h1H10aQ28610@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Daniel Jacobowitz <dan@debian.org>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Signal/gdb oddity in 2.5.61
In-Reply-To: Daniel Jacobowitz's message of  Sunday, 16 February 2003 18:27:52 -0500 <20030216232751.GA7687@nevyn.them.org>
X-Zippy-Says: With this weapon I can expose fictional characters and bring about
   sweeping reforms!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That said, I've still got two issues with your change.  For one thing,
> the version of GDB that Russell was running, you'll note, was 5.0.  A
> lot of people haven't upgraded GDB in years, and have some dispute with
> the present version that means they don't want to upgrade.  I've only
> just stopped seeing people using 4.18.  In conversation with Russell
> I've already encountered another reason he doesn't want to upgrade. 

Anyone who wants to use an old gdb with a new kernel can use "handle
SIGSTOP nopass".  Is that a real imposition?  Anyway, aside from the test
suite, it only affects gdb users in a way that may confuse them for a few
seconds but doesn't prevent them from debugging normally.

> And I'm also concerned that other programs may use it.

Other programs may use PTRACE_CONT with SIGSTOP and expect it to act like
PTRACE_CONT with 0?  It's certainly possible.  But since the quirk with
SIGSTOP was so counterintuitive to begin with, it seems unlikely to me that
someone would have expected that behavior in particular.  Some programs
like strace are written to treat all signals the same and pass them through
to PTRACE_CONT (actually PTRACE_SYSCALL); they will now cause an endless
stream of SIGSTOP stops until someone uses SIGCONT, instead of swallowing
the SIGSTOP--now they do for SIGSTOP what they've always done for SIGTSTP
et al.

> I've also got a conceptual issue with your change.  Continuing a
> process normally overrides a pending stop.  Why shouldn't this be true
> with ptrace too?  It used to be - not in the POSIX sense, since we
> wouldn't override things like SIGTSTP, but the point holds.

I don't think that point holds at all.  It was never consistent with the
SIGCONT sense of continuing, which does discard SIGTSTP et al as well and
moreover clears all pending stop signals regardless of which one you
continued in response to.  I think it is specious to talk about a single
"continuing a process" conceptual action.  There is SIGCONT, which has its
set of semantics.  There is PTRACE_CONT/PTRACE_SYSCALL/PTRACE_SINGLESTEP,
which has its set of semantics (the three are the same for what we're
discussing here and I'll just say PTRACE_CONT to mean all of them).

PTRACE_CONT has never "overridden a pending stop".  If someone has called
kill (or now tkill) with SIGSTOP or another stop signal since the task
stopped the first time (reported to ptrace), then one of those pending
stops happens right away and the others remain pending.  SIGCONT clears all
pending stop signals, i.e. overrides a pending stop, and always has.
PTRACE_CONT has never done so.

If you want to play word games, I'd say that the stop for the ptrace report
has already happened and is not pending, and the stop for the SIGSTOP (or
other stop signal with default action) given as argument to PTRACE_CONT has
not happened until the ptrace call requested it, and so is not pending.

As well as not matching the facts, I don't think it's even desireable to
have a single notion of "continue a process".  SIGCONT has pretty
strange and hairy semantics mandated by POSIX (e.g. it now includes
resuming all threads, and all the resumption semantics are magic
generation-time semantics unlike most signal effects).  The purpose of
ptrace is to trace exactly what's going on, so it should interact with
other semantics as little as possible.  By the nature of the facility,
it perturbs the process by stopping it.  But you don't want it to
involve all sorts of other semantics implicitly--then you are perturbing
more than you have to.  PTRACE_CONT resumes a single thread (unlike
SIGCONT), and the useful model for it is to pick up exactly where things
left off when the thread stopped except as explicitly changed by the
ptrace calls (including the PTRACE_CONT argument).  If the PTRACE_CONT
argument matches the signal that caused the ptrace stop, then it should
do what it would have done in the absence of ptrace (which for a stop
signal is to stop the whole process, aka thread group).  If you want a
change in what it was doing, such as to continue regardless of a signal
saying to stop, then you can indicate that explicitly by given
PTRACE_CONT a different argument (i.e. 0).

I don't have any strenuous objection to reintroducing the special case for
SIGSTOP.  Not changing exactly what was seen before just for the sake of
precise compatibility is always a reasonable argument.  But I really cannot
see any defensible claim that the old semantics were somehow more
consistent, comprehensible, or useful than the new ones.

Perhaps the greatest net happiness would be if we call this a "bug
compatibility mode" feature that is disabled by setting PTRACE_O_TRACEGOOD
(an option Dan and I have privately discussed adding to regularize the
ptrace event reporting interface).  That way nothing changes for old
programs, and programs using new features Dan and I are working on get the
cleaner and consistent behavior for all signals.


Thanks,
Roland
