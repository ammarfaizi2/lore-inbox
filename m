Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVFGLcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVFGLcM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 07:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVFGLcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 07:32:12 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:46738 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261836AbVFGLcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 07:32:02 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-20
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050607110409.GA14613@elte.hu>
References: <20050607110409.GA14613@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 07 Jun 2005 07:31:56 -0400
Message-Id: <1118143916.4533.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 13:04 +0200, Ingo Molnar wrote:
> i have released the -V0.7.47-20 Real-Time Preemption patch, which can be 
> downloaded from the usual place:
> 

Ingo,

Here's the MAX_USER_RT_PRIO patch against your kernel.

-- Steve

--- kernel/sched.c.orig	2005-06-07 07:25:37.000000000 -0400
+++ kernel/sched.c	2005-06-07 07:27:38.000000000 -0400
@@ -2865,7 +2865,7 @@ static void trace_array(prio_array_t *ar
 			trace_special_pid(p->pid, p->prio,
 				p->policy == SCHED_NORMAL ?
 					p->static_prio :
-					MAX_USER_RT_PRIO - p->rt_priority);
+					(MAX_RT_PRIO-1) - p->rt_priority);
 		}
 	}
 }
@@ -3632,7 +3632,7 @@ int mutex_getprio(task_t *p)
 	int prio;
 
 	if (p->policy != SCHED_NORMAL)
-		prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
+		prio = MAX_RT_PRIO-1 - p->rt_priority;
 	else
 		prio = __effective_prio(p);
 	trace_special_pid(p->pid, p->prio, prio);
@@ -3794,7 +3794,7 @@ static void __setscheduler(struct task_s
 	p->policy = policy;
 	p->rt_priority = prio;
 	if (policy != SCHED_NORMAL)
-		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
+		p->prio = MAX_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
 }
@@ -3826,7 +3826,8 @@ recheck:
 	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
 	 */
 	if (param->sched_priority < 0 ||
-	    param->sched_priority > MAX_USER_RT_PRIO-1)
+	    (p->mm && param->sched_priority > MAX_USER_RT_PRIO-1) ||
+	    (!p->mm && param->sched_priority > MAX_RT_PRIO-1))
 		return -EINVAL;
 	if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
 		return -EINVAL;


