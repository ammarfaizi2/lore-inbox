Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVCFTij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVCFTij (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 14:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVCFTij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 14:38:39 -0500
Received: from nevyn.them.org ([66.93.172.17]:52135 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261478AbVCFTic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 14:38:32 -0500
Date: Sun, 6 Mar 2005 14:38:41 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Cc: Andrew Cagney <cagney@redhat.com>
Subject: More trouble with i386 EFLAGS and ptrace
Message-ID: <20050306193840.GA26114@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, Andrew Cagney <cagney@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the changes to preserve eflags when single-stepping don't work
right with signals.  Take this test case:

<snip>
#include <signal.h>
#include <unistd.h>

volatile int done;

void handler (int sig)
{
  done = 1;
}

int main()
{
  while (1)
    {
      done = 0;
      signal (SIGALRM, handler);
      alarm (1);
      while (!done);
    }
}
<snip>

And this GDB session:

(gdb) b 18
Breakpoint 1 at 0x804840d: file test.c, line 18.
(gdb) r
Starting program: /home/drow/eflags/test

Breakpoint 1, main () at test.c:18
18            while (!done);
(gdb) p/x $eflags
$1 = 0x200217
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x08048414 in main () at test.c:18
18            while (!done);
(gdb) p/x $eflags
$2 = 0x200302

There's an implied delay before the "c" which is long enough for the signal
handler to become pending.

The reason this happens is that when the inferior hits a breakpoint, the
first thing GDB will do is remove the breakpoint, single-step past it, and
reinsert it.  So GDB does a PTRACE_SINGLESTEP, and the kernel invokes the
signal handler (without single-step - good so far).  When the signal handler
returns, we've lost track of the fact that ptrace set the single-step flag,
however.  So the single-step completes and returns SIGTRAP to GDB.  GDB is
expecting a SIGTRAP and reinserts the breakpoint.  Then it resumes the
inferior, but now the trap flag is set in $eflags.  So, oops, the continue
acts like a step instead.

What to do?  We need to know when we restore the trap bit in sigreturn
whether it was set by ptrace or by the application (possibly including by
the signal handler).

Andrew, serious kudos for GDB's sigstep.exp, which uncovered this problem
(through a much more complicated test - I may add the smaller one).

-- 
Daniel Jacobowitz
CodeSourcery, LLC
