Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281245AbRKTSod>; Tue, 20 Nov 2001 13:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281215AbRKTSoZ>; Tue, 20 Nov 2001 13:44:25 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:42245 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S281234AbRKTSoM>; Tue, 20 Nov 2001 13:44:12 -0500
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Jeff Long <jeffwlong@hotmail.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Re: Zombies with 2.4.15pre5 (exit.c)
In-Reply-To: <F207EKzlO329qhXbGE400017908@hotmail.com>
	<41490000.1006272492@baldur>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 21 Nov 2001 03:40:49 +0900
In-Reply-To: <41490000.1006272492@baldur>
Message-ID: <8766851e1a.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dave McCracken <dmccr@us.ibm.com> writes:

> The intent of the original patch was to make the task unfindable to other
> waiters, which fixed a race condition in sys_wait4().  My assumption was
> that the task was about to be cleaned up in release_task().  What I missed
> was that there are a couple of code paths that don't release the task, but
> assume it'll be cleaned up later.

I think the original patch don't fix race condition, because
tasklist_lock is read_lock(). Furthermore, the threads which did not
receive process status continues waiting, even when there is no child
process.

I wrote the following patch. But, I'm not sure whether it is right.

Thanks
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--- linux-head/kernel/exit.c	Tue Nov 20 23:32:58 2001
+++ wait/kernel/exit.c	Tue Nov 20 17:56:12 2001
@@ -529,23 +529,27 @@
 				retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0; 
 				if (!retval && stat_addr) 
 					retval = put_user((p->exit_code << 8) | 0x7f, stat_addr);
-				if (!retval) {
-					p->exit_code = 0;
-					retval = p->pid;
+				if (retval)
+					goto end_wait4;
+
+				/* exactly one thread return the process status */
+				task_lock(p);
+				if (p->exit_code == 0) {
+					task_unlock(p);
+					goto repeat;
 				}
+				p->exit_code = 0;
+				task_unlock(p);
+				retval = p->pid;
 				goto end_wait4;
 			case TASK_ZOMBIE:
-				/* Make sure no other waiter picks this task up */
-				p->state = TASK_DEAD;
-
-				current->times.tms_cutime += p->times.tms_utime + p->times.tms_cutime;
-				current->times.tms_cstime += p->times.tms_stime + p->times.tms_cstime;
 				read_unlock(&tasklist_lock);
 				retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
 				if (!retval && stat_addr)
 					retval = put_user(p->exit_code, stat_addr);
 				if (retval)
-					goto end_wait4; 
+					goto end_wait4;
+
 				retval = p->pid;
 				if (p->p_opptr != p->p_pptr) {
 					write_lock_irq(&tasklist_lock);
@@ -554,8 +558,20 @@
 					SET_LINKS(p);
 					do_notify_parent(p, SIGCHLD);
 					write_unlock_irq(&tasklist_lock);
-				} else
-					release_task(p);
+					goto end_wait4;
+				}
+
+				/* exactly one thread return the process status */
+				task_lock(p);
+				if (p->pid == 0) {
+					task_unlock(p);
+					goto repeat;
+				}
+				p->pid = 0;
+				task_unlock(p);
+				current->times.tms_cutime += p->times.tms_utime + p->times.tms_cutime;
+				current->times.tms_cstime += p->times.tms_stime + p->times.tms_cstime;
+				release_task(p);
 				goto end_wait4;
 			default:
 				continue;
--- linux-head/include/linux/sched.h	Tue Nov 20 23:32:58 2001
+++ wait/include/linux/sched.h	Tue Nov 20 17:38:11 2001
@@ -88,7 +88,6 @@
 #define TASK_UNINTERRUPTIBLE	2
 #define TASK_ZOMBIE		4
 #define TASK_STOPPED		8
-#define TASK_DEAD		16
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
