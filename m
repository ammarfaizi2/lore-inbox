Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281147AbRKTQJF>; Tue, 20 Nov 2001 11:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281153AbRKTQIq>; Tue, 20 Nov 2001 11:08:46 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:27114 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281147AbRKTQIg>; Tue, 20 Nov 2001 11:08:36 -0500
Date: Tue, 20 Nov 2001 10:08:12 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Jeff Long <jeffwlong@hotmail.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Re: Zombies with 2.4.15pre5 (exit.c)
Message-ID: <41490000.1006272492@baldur>
In-Reply-To: <F207EKzlO329qhXbGE400017908@hotmail.com>
In-Reply-To: <F207EKzlO329qhXbGE400017908@hotmail.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Saturday, November 17, 2001 03:45:49 +0000 Jeff Long
<jeffwlong@hotmail.com> wrote:

> Running 2.4.15pre5 (UP) on i386, running UML 2.4.14-2.
> UML processes create threads on the host system that don't
> die.  Threads are stuck at do_exit( ), so I backed out the
> patch to kernel/exit.c @ 539 (in 2.4.15pre5 patch):
> 
>   p->state = TASK_DEAD;
> 
> and things work fine.  I do not see zombies with anything
> other than UML processes/native threads.

The intent of the original patch was to make the task unfindable to other
waiters, which fixed a race condition in sys_wait4().  My assumption was
that the task was about to be cleaned up in release_task().  What I missed
was that there are a couple of code paths that don't release the task, but
assume it'll be cleaned up later.

The patch below should fix the problem.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

-----------------------

--- linux-2.4.15-pre7/kernel/exit.c	Tue Nov 20 10:00:26 2001
+++ linux-2.4.15-pre7-patch/kernel/exit.c	Tue Nov 20 09:57:48 2001
@@ -544,8 +544,11 @@
 				retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
 				if (!retval && stat_addr)
 					retval = put_user(p->exit_code, stat_addr);
-				if (retval)
+				if (retval) {
+					/* Reset state. We're not cleaning up yet */
+					p->state = TASK_ZOMBIE;
 					goto end_wait4; 
+				}
 				retval = p->pid;
 				if (p->p_opptr != p->p_pptr) {
 					write_lock_irq(&tasklist_lock);
@@ -553,6 +556,8 @@
 					p->p_pptr = p->p_opptr;
 					SET_LINKS(p);
 					do_notify_parent(p, SIGCHLD);
+					/* Reset state. We're not cleaning up yet */
+					p->state = TASK_ZOMBIE;
 					write_unlock_irq(&tasklist_lock);
 				} else
 					release_task(p);

