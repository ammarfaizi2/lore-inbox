Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbTBPXSN>; Sun, 16 Feb 2003 18:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267098AbTBPXSN>; Sun, 16 Feb 2003 18:18:13 -0500
Received: from crack.them.org ([65.125.64.184]:51900 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S266968AbTBPXSM>;
	Sun, 16 Feb 2003 18:18:12 -0500
Date: Sun, 16 Feb 2003 18:27:52 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Signal/gdb oddity in 2.5.61
Message-ID: <20030216232751.GA7687@nevyn.them.org>
Mail-Followup-To: Roland McGrath <roland@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302161117370.2874-100000@home.transmeta.com> <200302162228.h1GMS9F27701@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302162228.h1GMS9F27701@magilla.sf.frob.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 02:28:09PM -0800, Roland McGrath wrote:
> This is a slightly incompatible change in behavior, and I'm sorry I
> forgot to mention it earlier.  But I think it's an acceptable and
> appropriate change.  It is simple enough to fix gdb.  (What it
> currently does is pretty odd: it knows that the first SIGSTOP was
> caused by its PTRACE_ATTACH and so doesn't report it to the user, but
> still records it such that the next PTRACE_CONT or PTRACE_SINGLESTEP
> it does uses SIGSTOP instead of 0.)  A fixed gdb will work on older
> kernels as it did before, because they treat SIGSTOP like 0 and the
> fix will be to pass 0 instead of SIGSTOP when 0 is what gdb really
> meant.  The gdb maintainers are already aware of the issue.

(Meaning you told someone at Red Hat?  It didn't come up on the GDB
list, where some of us GDB maintainers get our information...)

> An old gdb on a new kernel is affected as reported.  But the only
> failure mode is the minor annoyance of a spurious SIGSTOP report and
> having to repeat the first cont or step/stepi command after an attach.
> Users can work around this with "handle SIGSTOP nopass" (which has no
> other practical effect, safe to put in your ~/.gdbinit).
> 
> This does break things like running an old gdb release's test suite
> on a bleeding-edge kernel (only its "attach" test cases are affected).
> But I think this is a worthwhile bit of suffering for progress.
> There should be a fixed gdb available long before 2.5 is stable.

So that's why CVS gdb's had failures in attach.exp for some time.  I
wish whoever you spoke to about it would go ahead and actually fix the
problem in GDB.  It seems like a GDB bug.  I think it will be a little
tricky to fix, but certainly not overly complex.

That said, I've still got two issues with your change.  For one thing,
the version of GDB that Russell was running, you'll note, was 5.0.  A
lot of people haven't upgraded GDB in years, and have some dispute with
the present version that means they don't want to upgrade.  I've only
just stopped seeing people using 4.18.  In conversation with Russell
I've already encountered another reason he doesn't want to upgrade. 
And I'm also concerned that other programs may use it.

I've also got a conceptual issue with your change.  Continuing a
process normally overrides a pending stop.  Why shouldn't this be true
with ptrace too?  It used to be - not in the POSIX sense, since we
wouldn't override things like SIGTSTP, but the point holds.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
