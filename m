Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265473AbUBBAwS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 19:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265536AbUBBAwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 19:52:18 -0500
Received: from nevyn.them.org ([66.93.172.17]:58500 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265473AbUBBAwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 19:52:14 -0500
Date: Sun, 1 Feb 2004 19:52:12 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
Message-ID: <20040202005212.GA26719@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>
References: <20040201032525.GA10254@nevyn.them.org> <Pine.LNX.4.58.0401312014420.2033@home.osdl.org> <20040201044331.GA27271@nevyn.them.org> <20040201051204.GB27271@nevyn.them.org> <Pine.LNX.4.58.0402011333020.2229@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402011333020.2229@home.osdl.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 01:41:48PM -0800, Linus Torvalds wrote:
> 
> 
> On Sun, 1 Feb 2004, Daniel Jacobowitz wrote:
> > 
> > Here you go.  The bug turns out not to be related directly to
> > CLONE_DETACHED.  Compile testcase with -DNOTHREAD to use fork (well,
> > clone, but without the fancy flags), without -DNOTHREAD to use
> > CLONE_DETACHED | CLONE_THREAD.
> 
> I don't think this bug has anything to do with anything else.
> 
> This program seems to show that PTRACE_KILL simply doesn't work.

> and the thing is, it looks like the signal handling changes have totally
> made the child ignore the "exit_code" thing, unless I'm seriously
> misreading something.

That may be (though I don't think so) but it reproduces without
PTRACE_KILL too.  Try the attached, which just replaced PTRACE_KILL
with PTRACE_CONT/tkill(pid, SIGKILL).  Still get zombies.  I haven't
tried reproducing entirely without ptrace yet.

> Roland, you know this code better than I do. Any comments?
> 
> I suspect the PTRACE_KILL logic should also do a
> 
> 	spin_lock_irqsave(child->sighand->siglock, flags);
> 	sigaddset(&child->pending->signal, SIGKILL);
> 	set_tsk_thread_flag(child, TIF_SIGPENDING);
> 	spin_unlock_irqrestore(child->sighand->siglock, flags);
> 
> 	ptrace_detach(child);
> 
> which would set the SIGKILL thing properly, but I suspect we had a good
> reason not to do it that way originally. 
> 
> Daniel?

I doubt there was a good reason.  This code hasn't changed in a hell of
a long time - it probably predates everything up there except sigaddset
:).

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
  ptrace (PTRACE_CONT, child2, 0, 0);
  syscall (SYS_tkill, child2, SIGKILL);
  ret = waitpid (child2, &wstat, __WALL);
#endif

  ptrace (PTRACE_CONT, child, 0, 0);
  syscall (SYS_tkill, child, SIGKILL);
  ret = waitpid (child, &wstat, __WALL);

#ifdef BUG
  ptrace (PTRACE_CONT, child2, 0, 0);
  syscall (SYS_tkill, child2, SIGKILL);
  ret = waitpid (child2, &wstat, __WALL);
#endif

  return 0;
}


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
