Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267738AbTBPWS1>; Sun, 16 Feb 2003 17:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267750AbTBPWS1>; Sun, 16 Feb 2003 17:18:27 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:32905 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267738AbTBPWSZ>; Sun, 16 Feb 2003 17:18:25 -0500
Date: Sun, 16 Feb 2003 14:28:09 -0800
Message-Id: <200302162228.h1GMS9F27701@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Signal/gdb oddity in 2.5.61
In-Reply-To: Linus Torvalds's message of  Sunday, 16 February 2003 11:18:16 -0800 <Pine.LNX.4.44.0302161117370.2874-100000@home.transmeta.com>
X-Fcc: ~/Mail/linus
Emacs: don't cry -- it won't help.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I call that a bug in gdb's "attach" code.  If you use strace or
suchlike on gdb to see what it's doing, you'll see that it does
PTRACE_CONT and passes SIGSTOP.  The old kernel treated SIGSTOP unlike
all other signals given to PTRACE_CONT, and just ignored it.  I
changed this for two reasons.

One is consistency.  Now all signals are treated alike by ptrace
tracing (except of course SIGKILL, which cannot be caught by ptrace).
Previously doing "signal SIGSTOP" in gdb would not behave as
advertised, but instead act like "cont".

Second is that it's the sane way for tracing SIGSTOP to behave in a
multithreaded program with the new flavor of threads.  When something
generates a SIGSTOP (kill, tkill, or PTRACE_ATTACH), the thread in
question stops to report to ptrace as for all other signals (save
SIGKILL).  When a stop signal with default action (e.g. SIGSTOP) is
passed to PTRACE_CONT, it performs the normal signal action, which is
to stop all the threads in the group.  In cases other than SIGSTOP,
gdb doesn't know until it passes it along to the program whether it
will ignore it, handle it, or stop the process--so gdb shouldn't do
anything different.  With this behavior, SIGSTOP can be treated like
the others rather than being a special case.

This is a slightly incompatible change in behavior, and I'm sorry I
forgot to mention it earlier.  But I think it's an acceptable and
appropriate change.  It is simple enough to fix gdb.  (What it
currently does is pretty odd: it knows that the first SIGSTOP was
caused by its PTRACE_ATTACH and so doesn't report it to the user, but
still records it such that the next PTRACE_CONT or PTRACE_SINGLESTEP
it does uses SIGSTOP instead of 0.)  A fixed gdb will work on older
kernels as it did before, because they treat SIGSTOP like 0 and the
fix will be to pass 0 instead of SIGSTOP when 0 is what gdb really
meant.  The gdb maintainers are already aware of the issue.

An old gdb on a new kernel is affected as reported.  But the only
failure mode is the minor annoyance of a spurious SIGSTOP report and
having to repeat the first cont or step/stepi command after an attach.
Users can work around this with "handle SIGSTOP nopass" (which has no
other practical effect, safe to put in your ~/.gdbinit).

This does break things like running an old gdb release's test suite
on a bleeding-edge kernel (only its "attach" test cases are affected).
But I think this is a worthwhile bit of suffering for progress.
There should be a fixed gdb available long before 2.5 is stable.


Thanks,
Roland
