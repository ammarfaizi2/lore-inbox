Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279708AbRKFQAe>; Tue, 6 Nov 2001 11:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279728AbRKFQAY>; Tue, 6 Nov 2001 11:00:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40182 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S279708AbRKFQAI>; Tue, 6 Nov 2001 11:00:08 -0500
Date: Tue, 06 Nov 2001 10:00:04 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix race condition in wait with thread groups
Message-ID: <30540000.1005062403@baldur>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is code in sys_wait4() that makes a task wait for the children of all
members of the thread group.  This code has a race condition when more than
one task in a thread group calls wait.  Once it has picked a zomebie task
to return it drops the tasklist lock before it calls release_task().  This
allows another task to select the same zombie to clean up.

My fix for this race condition is to set the zombie task's state to a
different value before the tasklist lock is released.  This means no other
waiting task will select it.  There could be other ways of marking a task
as already selected for cleanup, but this seemed the simplest.

The patch is appended below.  It applies cleanly to 2.4.14

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

-------------------------

--- linux-2.4.13/kernel/exit.c	Mon Oct 22 11:27:55 2001
+++ linux-2.4.14-pre8/kernel/exit.c	Mon Nov  5 11:56:45 2001
@@ -534,6 +534,9 @@
 				}
 				goto end_wait4;
 			case TASK_ZOMBIE:
+				/* Make sure no other waiter picks this task up */
+				p->state = TASK_DEAD;
+
 				current->times.tms_cutime += p->times.tms_utime + p->times.tms_cutime;
 				current->times.tms_cstime += p->times.tms_stime + p->times.tms_cstime;
 				read_unlock(&tasklist_lock);
--- linux-2.4.13/include/linux/sched.h	Tue Oct 23 23:59:06 2001
+++ linux-2.4.14-pre8/include/linux/sched.h	Mon Nov  5 12:56:20 2001
@@ -88,6 +88,7 @@
 #define TASK_UNINTERRUPTIBLE	2
 #define TASK_ZOMBIE		4
 #define TASK_STOPPED		8
+#define TASK_DEAD		16
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)

