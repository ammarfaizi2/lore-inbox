Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVFGCqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVFGCqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFGCqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:46:49 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:38813 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261163AbVFGCqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:46:43 -0400
Subject: [PATCH] MAX_USER_RT_PRIO and MAX_RT_PRIO are wrong!
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, anton.wilson@camotion.com,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 06 Jun 2005 22:46:30 -0400
Message-Id: <1118112390.4533.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to the comments in include/linux/sched.h

/*
* Priority of a process goes from 0..MAX_PRIO-1, valid RT
* priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL tasks are
* in the range MAX_RT_PRIO..MAX_PRIO-1. Priority values
* are inverted: lower p->prio value means higher priority.
*
* The MAX_USER_RT_PRIO value allows the actual maximum
* RT priority to be separate from the value exported to
* user-space.  This allows kernel threads to set their
* priority to a value higher than any user task. Note:
* MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
*/

This makes it look like the priority goes as follows:

prio: 0 .. MAX_RT_PRIO .. MAX_USER_RT_PRIO .. MAX_PRIO

where 0 is of highest priority

but in reality we have:

prio: 0 .. MAX_USER_RT_PRIO .. MAX_RT_PRIO .. MAX_PRIO

The comments say that MAX_RT_PRIO must not be smaller than
MAX_USER_RT_PRIO, but if it is bigger (thinking bigger means greater
than) then the system will crash on a SMP machine.

Here's how it works.  The migration_thread sets the priority of its
thread to MAX_RT_PRIO-1 via:

__setscheduler(p, SCHED_FIFO, MAX_RT_PRIO-1);

Now looking at __setscheduler

static void __setscheduler(struct task_struct *p, int policy, int prio)
{
        BUG_ON(p->array);
        p->policy = policy;
        p->rt_priority = prio;
        if (policy != SCHED_NORMAL)
                p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
        else
                p->prio = p->static_prio;
}

If we have MAX_USER_RT_PRIO = 99 and MAX_RT_PRIO = 100 then we would get

  p->prio = 99-1 - 100-1 = -1;

This would be very bad when it comes time to schedule.  Not to mention
that kstop_machine uses MAX_RT_PRIO and then calls
sys_sched_setscheduler, which would fail if MAX_RT_PRIO >
MAX_USER_RT_PRIO. Below is a patch that makes MAX_RT_PRIO work if it is
greater than MAX_USER_RT_PRIO on a SMP machine.  The p->mm is to allow
kstop_machine to work and any other kernel threads.

I tested the patch on an SMP machine where MAX_RT_PRIO = 100 and
MAX_USER_RT_PRIO = 99. Without the patch, the system crashes with a
reboot.

Funny, back in July 2002, this was noticed by an Anton Wilson and he was
just lost in the noise!
http://seclists.org/lists/linux-kernel/2002/Jul/1695.html


-- Steve

diff -u linux-2.6.12-rc5.orig/kernel/sched.c linux-2.6.12-rc5/kernel/sched.c
--- linux-2.6.12-rc5.orig/kernel/sched.c	2005-06-06 22:37:15.000000000 -0400
+++ linux-2.6.12-rc5/kernel/sched.c	2005-06-06 21:58:39.000000000 -0400
@@ -3347,7 +3347,7 @@
 	p->policy = policy;
 	p->rt_priority = prio;
 	if (policy != SCHED_NORMAL)
-		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
+		p->prio = MAX_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
 }
@@ -3379,7 +3379,8 @@
 	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
 	 */
 	if (param->sched_priority < 0 ||
-	    param->sched_priority > MAX_USER_RT_PRIO-1)
+	    (p->mm &&  param->sched_priority > MAX_USER_RT_PRIO-1) ||
+	    (!p->mm && param->sched_priority > MAX_RT_PRIO-1))
 		return -EINVAL;
 	if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
 		return -EINVAL;


