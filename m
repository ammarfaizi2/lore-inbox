Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUBAFMO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 00:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbUBAFMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 00:12:14 -0500
Received: from nevyn.them.org ([66.93.172.17]:22915 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265215AbUBAFMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 00:12:05 -0500
Date: Sun, 1 Feb 2004 00:12:04 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
Message-ID: <20040201051204.GB27271@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>
References: <20040201032525.GA10254@nevyn.them.org> <Pine.LNX.4.58.0401312014420.2033@home.osdl.org> <20040201044331.GA27271@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201044331.GA27271@nevyn.them.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 11:43:31PM -0500, Daniel Jacobowitz wrote:
> The only two kernels I've tried were 2.6.0-test7 and 2.6.2-rc3, by the
> way - same behavior in both.  I'll try to write a single program
> testcase for this.

Here you go.  The bug turns out not to be related directly to
CLONE_DETACHED.  Compile testcase with -DNOTHREAD to use fork (well,
clone, but without the fancy flags), without -DNOTHREAD to use
CLONE_DETACHED | CLONE_THREAD.

In either mode, compile with -DBUG to kill and reap the parent before
the child.  I get a variety of unkillable processes, hangs, and
unkilled parents; sometimes in the -DNOTHREAD case the parent simply is
not stopped by the PTRACE_KILL (remains in S state).  If you kill -9 it
from a terminal it becomes a zombie despite the fact that its parent is
in waitpid for it.

You may need to fiddle a little bit to get this to compile depending on
your distribution of choice, it assumes some constants from
<linux/ptrace.h> that require 2.6 headers... should work on any 2.6
kernel.

/* -DBUG to kill the parent before the child -> hang.  */
/* -DNOTHREAD to us fork instead of clone.  */

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <signal.h>
#include <sys/ptrace.h>
#include <sched.h>
#include <sys/wait.h>
#include <linux/ptrace.h>

int stack_one[8192], stack_two[8192];

int thread_func_two()
{
  write (1, "Thread 2\n", 9);
  while (1)
    sleep (1);
}

int thread_func_one()
{
  int ret;
  char retstr[10];

  write (1, "Thread 1\n", 9);

  ptrace (PTRACE_TRACEME, 0, 0, 0);

  write (1, "Thread 1 signalling\n", 20);

  syscall (SYS_tkill, getpid (), SIGUSR1);

  write (1, "Thread 1 cloning\n", 17);

  ret = clone (thread_func_two, stack_two + 8192,
#ifdef NOTHREAD
	SIGCHLD,
#else
	CLONE_DETACHED | CLONE_THREAD | CLONE_SIGHAND | CLONE_VM | CLONE_FS,
#endif
	NULL);
  sprintf (retstr, "= %d\n", ret);
  write (1, retstr, strlen (retstr));

  write (1, "Thread 1 sleeping\n", 18);

  while (1)
    sleep (1);
}

int main()
{
  int ret, wstat;
  int child = fork(), child2 = 0;

  if (child == 0)
    return thread_func_one();

  ptrace (PTRACE_SETOPTIONS, child, 0, PTRACE_O_TRACECLONE | PTRACE_O_TRACEFORK);
  ret = waitpid (child, &wstat, __WALL);

  ptrace (PTRACE_CONT, child, 0, 0);
  ret = waitpid (child, &wstat, __WALL);
  ptrace (PTRACE_GETEVENTMSG, child, 0, &child2);
  ret = waitpid (child2, &wstat, __WALL);

  ptrace (PTRACE_CONT, child, 0, 0);
  ptrace (PTRACE_CONT, child2, 0, 0);

#ifndef BUG
  ptrace (PTRACE_KILL, child2, 0, 0);
  ret = waitpid (child2, &wstat, __WALL);
#endif

  ptrace (PTRACE_KILL, child, 0, 0);
  ret = waitpid (child, &wstat, __WALL);

#ifdef BUG
  ptrace (PTRACE_KILL, child2, 0, 0);
  ret = waitpid (child2, &wstat, __WALL);
#endif

  return 0;
}

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

