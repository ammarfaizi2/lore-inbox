Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266635AbUGPWRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266635AbUGPWRC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 18:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUGPWRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 18:17:02 -0400
Received: from palrel10.hp.com ([156.153.255.245]:2739 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S266635AbUGPWQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 18:16:25 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kXZgj/V/Bn"
Content-Transfer-Encoding: 7bit
Message-ID: <16632.21429.257483.650452@napali.hpl.hp.com>
Date: Fri, 16 Jul 2004 15:16:21 -0700
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: fix for unkillable zombie task
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kXZgj/V/Bn
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Linus,

I got a bugreport where a ptrace'd task would end up in an unkillable
zombie state if the (real) parent of the task happened to ignore
SIGCHLD.  The patch below should fix the problem.  I attached a
self-contained test program.  If the bug is present, you should
see:

 FAILURE: child PID seems to be still around!

at the end (and there will be an unkillable zombie).

	--david

This patch fixes a problem where a ptrace'd task would end up in an
unkillable zombie state if the (real) parent happens to ignore
SIGCHLD.

The problem was due to the fact that while the task is being ptraced,
it may not be considered detached, since nobody may have tried to do
do_notify_parent(p, SIGCHLD) before the task got ptrace'd.  If the
task exits while being ptraced, the ptracing task collects the exiting
task's status via wait_task_zombie(), which restores the real parent
and then attempts to send SIGCHLD to the real parent.  However, since
the real parent ignores SIGCHLD, this "fails" and exit_signal gets
reset to -1.  When returning from do_notify_parent(),
wait_task_zombie() failed to notice that the task is now detached and
should be released.  Since it failed to notice that, it never did the
release_task() and that's how we ended up with the unkillable zombie.

Signed-off-by: davidm@hpl.hp.com

===== kernel/exit.c 1.141 vs edited =====
--- 1.141/kernel/exit.c	2004-07-06 19:32:23 -07:00
+++ edited/kernel/exit.c	2004-07-16 14:50:16 -07:00
@@ -1027,6 +1027,13 @@
 			else {
 				do_notify_parent(p, p->exit_signal);
 				write_unlock_irq(&tasklist_lock);
+				/* do_notify_parent() may have noticed
+				   that the real parent didn't care
+				   about SIGCHLD and may have reset
+				   exit_signal to -1.  If so, release
+				   task now.  */
+				if (p->exit_signal == -1)
+					release_task(p);
 			}
 			p = NULL;
 		}


--kXZgj/V/Bn
Content-Type: text/plain
Content-Description: test-detached.c
Content-Disposition: inline;
	filename="test-detached.c"
Content-Transfer-Encoding: 7bit

/* Copyright (C) 2004 Hewlett-Packard Development Co, LLC
     Contributed by David Mosberger-Tang <davidm@hpl.hp.com>

     This program tests if a self-reaping task correctly gets released
     if it exits while being ptraced by another program.  As of Linux
     kernel v2.6.7, the task incorrectly remains in an unkillable
     zombie state.
*/

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <sys/ptrace.h>
#include <sys/wait.h>

#ifndef PTRACE_EVENT_FORK
# define PTRACE_EVENT_FORK       1
# define PTRACE_EVENT_VFORK      2
# define PTRACE_EVENT_CLONE      3
# define PTRACE_EVENT_EXEC       4
# define PTRACE_EVENT_VFORK_DONE 5
# define PTRACE_EVENT_EXIT       6

# define PTRACE_SETOPTIONS       0x4200
# define PTRACE_GETEVENTMSG      0x4201

# define PTRACE_O_TRACESYSGOOD   0x00000001
# define PTRACE_O_TRACEFORK      0x00000002
# define PTRACE_O_TRACEVFORK     0x00000004
# define PTRACE_O_TRACECLONE     0x00000008
# define PTRACE_O_TRACEEXEC      0x00000010
# define PTRACE_O_TRACEVFORKDONE 0x00000020
# define PTRACE_O_TRACEEXIT      0x00000040
#endif

static pid_t child_pid;

static int
child (void)
{
  printf ("[%d] child sending SIGINT to self\n", getpid ());
  kill (getpid (), SIGINT);
  return -3;
}

static int
parent (void)
{
  struct sigaction act;
  int ret;

  printf ("[%d] parent starting\n", getpid ());

  /* ignore SIGCHLD */
  memset (&act, 0, sizeof (act));
  act.sa_handler = SIG_IGN;
  act.sa_flags = SA_NOCLDSTOP | SA_NOCLDWAIT;
  sigaction(SIGCHLD, &act, NULL);

  child_pid = fork ();
  if (child_pid == 0)
    exit (child ());

  printf ("[%d] forked child %d\n", getpid (), child_pid);
  //  sleep (1);

  ret = wait (NULL);
  if (ret == -1)
    printf ("[%d] wait() failed as expected: %s\n",
	    getpid (), strerror (errno));
  printf ("[%d] parent exiting\n", getpid ());
  return 0;
}

static int
controller (void)
{
  int status, pending_sig, event;
  pid_t pid;

  printf ("[%d] controller starting\n", getpid ());

  while (1)
    {
      pending_sig = 0;
      pid = wait4 (-1, &status, 0, 0);
      if (pid == -1)
	{
	  if (errno == EINTR)
	    continue;

	  printf ("[%d] wait4() failed (errno=%d)\n", getpid (), errno);
	}
      if (WIFSTOPPED (status))
	{
	  if (WSTOPSIG (status) == SIGTRAP)
	    {
	      pending_sig = 0;	/* don't propagate signal */
	      event = (status >> 16) & 0xffff;
	      switch (event)
		{
		case PTRACE_EVENT_FORK:
		  {
		    long new_pid;
		    ptrace (PTRACE_GETEVENTMSG, pid, NULL, &new_pid);
		    printf ("[%d] got new pid %ld\n", getpid (), new_pid);
		    child_pid = new_pid;
		  }
		  break;

		case 0:
		  printf ("[%d] setting TRACEFORK option for %d\n",
			  getpid (), pid);
		  ptrace (PTRACE_SETOPTIONS, pid, NULL,
			  (unsigned long) PTRACE_O_TRACEFORK);
		  break;

		default:
		  printf ("[%d] got unexpected event 0x%x\n",
			  getpid (), event);
		  break;
		}
	    }
	  else if (WSTOPSIG (status) == SIGSTOP)
	    {
	      printf ("[%d] ignoring SIGSTOP for pid %d\n", getpid (), pid);
	      pending_sig = 0;
	    }
	  else
	    {
	      pending_sig = WSTOPSIG (status);

	      printf ("[%d] pid %d got signal %d\n",
		      getpid (), pid, pending_sig);
	      if (pending_sig == SIGSEGV)
		exit (-1);
	    }
	}
      else if (WIFEXITED (status))
	{
	  printf ("[%d] pid %d exit status %d\n",
		  getpid (), pid, WEXITSTATUS (status));
	  break;
	}
      else if (WIFSIGNALED (status))
	{
	  printf ("[%d] pid %d terminated by signal %d\n",
		  getpid (), pid, WTERMSIG (status));
	}
      else
	printf ("[%d] Duh?\n", getpid ());

      ptrace (PTRACE_CONT, pid, 0, pending_sig);	/* continue */
    }
  printf ("[%d] controller exiting\n", getpid ());

  if (kill (child_pid, SIGTERM) != -1)
    {
      printf ("FAILURE: child %d seems to be still around!\n", child_pid);
      return -1;
    }
  return 0;
}

int
main (int argc, char **argv)
{
  pid_t parent_pid;

  parent_pid = fork ();
  if (parent_pid == 0)
    {
      ptrace (PTRACE_TRACEME, 0, 0, 0);
      kill (getpid (), SIGTRAP);	/* since we don't do execve()... */
      exit (parent ());
    }
  return controller ();
}

--kXZgj/V/Bn--
