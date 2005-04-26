Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVDZFBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVDZFBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 01:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVDZFBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 01:01:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:8646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261304AbVDZFBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 01:01:08 -0400
Date: Mon, 25 Apr 2005 22:00:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: ocroquette@free.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Changing RT priority in kernel 2.6 without CAP_SYS_NICE
Message-Id: <20050425220040.7e876ce5.akpm@osdl.org>
In-Reply-To: <20050418080750.GA20811@elte.hu>
References: <42628300.5020009@free.fr>
	<20050418080750.GA20811@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
>  Presently, a process without the capability CAP_SYS_NICE can not change 
>  its own policy, which is OK.
> 
>  But it can also not decrease its RT priority (if scheduled with policy 
>  SCHED_RR or SCHED_FIFO), which is what this patch changes.

This patch needed some massaging to copt with the changes in
nice-and-rt-prio-rlimits.patch - please check.

I guess we should merge nice-and-rt-prio-rlimits.patch.

--- 25/kernel/sched.c~sched-changing-rt-priority-without-cap_sys_nice	2005-04-25 21:54:48.572295312 -0700
+++ 25-akpm/kernel/sched.c	2005-04-25 21:59:18.160311704 -0700
@@ -3445,13 +3445,24 @@ recheck:
 	if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
 		return -EINVAL;
 
-	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
-	    param->sched_priority > p->signal->rlim[RLIMIT_RTPRIO].rlim_cur &&
-	    !capable(CAP_SYS_NICE))
-		return -EPERM;
-	if ((current->euid != p->euid) && (current->euid != p->uid) &&
-	    !capable(CAP_SYS_NICE))
-		return -EPERM;
+	/*
+	 * Allow unprivileged RT tasks to decrease priority:
+	 */
+	if (!capable(CAP_SYS_NICE)) {
+		/* can't change policy */
+		if (policy != p->policy)
+			return -EPERM;
+		/* can't increase priority */
+		if (policy != SCHED_NORMAL &&
+		    param->sched_priority > p->rt_priority &&
+		    param->sched_priority >
+				p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
+			return -EPERM;
+		/* can't change other user's priorities */
+		if ((current->euid != p->euid) &&
+		    (current->euid != p->uid))
+			return -EPERM;
+	}
 
 	retval = security_task_setscheduler(p, policy, param);
 	if (retval)
_

