Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVGYUaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVGYUaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVGYUaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:30:09 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:41102 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261545AbVGYU2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:28:53 -0400
Subject: [PATCH] fix (again) MAX_USER_RT_PRIO and MAX_RT_PRIO (was:
	MAX_USER_RT_PRIO and MAX_RT_PRIO are wrong!)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Dean Nelson <dcn@SGI.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 25 Jul 2005 16:28:39 -0400
Message-Id: <1122323319.4895.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, 

As we discussed in OLS, here's the patch again to fix the code to handle
if the values between MAX_USER_RT_PRIO and MAX_RT_PRIO are different.
Without this patch, an SMP system will crash if the values are
different. I've already submitted this patch and it made it to -mm, but
never made it to mainline, so you told me to send it again and here it
is.

Also, shouldn't these values (MAX_RT_PRIO, MAX_USER_RT_PRIO) be user
configurable via a config parameter?  If so, I can send a separate patch
to do just that.

Ingo,

I've CC you just because you are the schedule maintainer.  You already
accepted this patch into your RT tree.

Dean,

I've CC you since it also has the change to
linux-2.6.13-rc3/arch/ia64/sn/kernel/xpc_main.c in it. But I don't see
this in -mm.  I don't have a ia64 so I can't test it. You tested this
for me before, so it should still work. This part should be at least
acknowledged by you.

-- Steve

PS. I'm currently running this patched kernel with MAX_RT_USER set to 95
and MAX_RT_PRIO set to 100 on an SMP machine.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

--- linux-2.6.13-rc3/kernel/sched.c.orig	2005-07-25 10:16:31.000000000 -0400
+++ linux-2.6.13-rc3/kernel/sched.c	2005-07-25 10:23:35.000000000 -0400
@@ -3486,7 +3486,7 @@ static void __setscheduler(struct task_s
 	p->policy = policy;
 	p->rt_priority = prio;
 	if (policy != SCHED_NORMAL)
-		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
+		p->prio = MAX_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
 }
@@ -3518,7 +3518,8 @@ recheck:
 	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
 	 */
 	if (param->sched_priority < 0 ||
-	    param->sched_priority > MAX_USER_RT_PRIO-1)
+	    (p->mm &&  param->sched_priority > MAX_USER_RT_PRIO-1) ||
+	    (!p->mm && param->sched_priority > MAX_RT_PRIO-1))
 		return -EINVAL;
 	if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
 		return -EINVAL;
--- linux-2.6.13-rc3/arch/ia64/sn/kernel/xpc_main.c.orig	2005-07-25 10:23:22.000000000 -0400
+++ linux-2.6.13-rc3/arch/ia64/sn/kernel/xpc_main.c	2005-07-25 10:23:35.000000000 -0400
@@ -420,7 +420,7 @@ xpc_activating(void *__partid)
 	partid_t partid = (u64) __partid;
 	struct xpc_partition *part = &xpc_partitions[partid];
 	unsigned long irq_flags;
-	struct sched_param param = { sched_priority: MAX_USER_RT_PRIO - 1 };
+	struct sched_param param = { sched_priority: MAX_RT_PRIO - 1 };
 	int ret;
 



