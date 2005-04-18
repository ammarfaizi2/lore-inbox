Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVDRIIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVDRIIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 04:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVDRIIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 04:08:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:18832 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261870AbVDRIIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 04:08:18 -0400
Date: Mon, 18 Apr 2005 10:07:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Olivier Croquette <ocroquette@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Changing RT priority in kernel 2.6 without CAP_SYS_NICE
Message-ID: <20050418080750.GA20811@elte.hu>
References: <42628300.5020009@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42628300.5020009@free.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


looks fine to me, only minor nits:

- this area of code changed since 2.6.8 so it needed merging.

- whitespace damage: your patch had all tabs as spaces.

- whitespace style: stuff like "if(" should be "if (".

i've reworked and tested the patch (attached below) to apply against the 
latest scheduler queue in -mm.

	Ingo

--
From: Olivier Croquette <ocroquette@free.fr>

Presently, a process without the capability CAP_SYS_NICE can not change 
its own policy, which is OK.

But it can also not decrease its RT priority (if scheduled with policy 
SCHED_RR or SCHED_FIFO), which is what this patch changes.

The rationale is the same as for the nice value: a process should be 
able to require less priority for itself. Increasing the priority is 
still not allowed.

This is for example useful if you give a multithreaded user process a RT 
priority, and the process would like to organize its internal threads 
using priorities also. Then you can give the process the highest 
priority needed N, and the process starts its threads with lower 
priorities: N-1, N-2...

The POSIX norm says that the permissions are implementation specific, so 
I think we can do that.

In a sense, it makes the permissions consistent whatever the policy is: 
with this patch, process scheduled by SCHED_FIFO, SCHED_RR and 
SCHED_OTHER can all decrease their priority.

From: Ingo Molnar <mingo@elte.hu>

cleaned up and merged to -mm.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- kernel/sched.c.orig
+++ kernel/sched.c
@@ -3436,12 +3436,22 @@ recheck:
 	if ((policy == SCHED_NORMAL) != (param->sched_priority == 0))
 		return -EINVAL;
 
-	if ((policy == SCHED_FIFO || policy == SCHED_RR) &&
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
+		    param->sched_priority > p->rt_priority)
+			return -EPERM;
+		/* can't change other user's priorities */
+		if ((current->euid != p->euid) &&
+		    (current->euid != p->uid))
+			return -EPERM;
+	}
 
 	retval = security_task_setscheduler(p, policy, param);
 	if (retval)
