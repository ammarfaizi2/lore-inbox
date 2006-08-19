Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWHSQQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWHSQQt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 12:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWHSQQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 12:16:49 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:9890 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751761AbWHSQQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 12:16:48 -0400
Date: Sun, 20 Aug 2006 00:40:47 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] sched_setscheduler: fix? policy checks
Message-ID: <20060819204047.GA11410@oleg>
References: <20060819193243.GA8648@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060819193243.GA8648@oleg>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/19, Oleg Nesterov wrote:
>
> I am not sure this patch is correct:

Surely it is not correct. Another attempt ...

[PATCH 4/4] sched_setscheduler: fix? policy checks

I am not sure this patch is correct: I can't understand what the current
code does, and I don't know what it was supposed to do.

The comment says:

		 * can't change policy, except between SCHED_NORMAL
		 * and SCHED_BATCH:

The code:

		if (((policy != SCHED_NORMAL && p->policy != SCHED_BATCH) &&
			(policy != SCHED_BATCH && p->policy != SCHED_NORMAL)) &&

But this is equivalent to:

		if ( (is_rt_policy(policy) && has_rt_policy(p)) &&

which means something different. We can't _decrease_ the current ->rt_priority
with such a check (if rlim[RLIMIT_RTPRIO] == 0).


Probably, it was supposed to be:

		if (	!(policy == SCHED_NORMAL && p->policy == SCHED_BATCH)  &&
			!(policy == SCHED_BATCH  && p->policy == SCHED_NORMAL)

this matches the comment, but strange: it doesn't allow to _drop_ the
realtime priority when rlim[RLIMIT_RTPRIO] == 0.


I think the right check would be:

		/* can't set/change rt policy */
		if (is_rt_policy(policy) &&
				policy != p->policy &&
				!rlim_rtprio)
			return -EPERM;

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/kernel/sched.c~4_policy	2006-08-19 22:03:26.000000000 +0400
+++ 2.6.18-rc4/kernel/sched.c	2006-08-20 00:37:05.000000000 +0400
@@ -4079,27 +4079,25 @@ recheck:
 	 * Allow unprivileged RT tasks to decrease priority:
 	 */
 	if (!capable(CAP_SYS_NICE)) {
-		unsigned long rlim_rtprio;
-		unsigned long flags;
+		if (is_rt_policy(policy)) {
+			unsigned long rlim_rtprio;
+			unsigned long flags;
 
-		if (!lock_task_sighand(p, &flags))
-			return -ESRCH;
-		rlim_rtprio = p->signal->rlim[RLIMIT_RTPRIO].rlim_cur;
-		unlock_task_sighand(p, &flags);
+			if (!lock_task_sighand(p, &flags))
+				return -ESRCH;
+			rlim_rtprio = p->signal->rlim[RLIMIT_RTPRIO].rlim_cur;
+			unlock_task_sighand(p, &flags);
+
+			/* can't set/change the rt policy */
+			if (policy != p->policy && !rlim_rtprio)
+				return -EPERM;
+
+			/* can't increase priority */
+			if (param->sched_priority > p->rt_priority &&
+			    param->sched_priority > rlim_rtprio)
+				return -EPERM;
+		}
 
-		/*
-		 * can't change policy, except between SCHED_NORMAL
-		 * and SCHED_BATCH:
-		 */
-		if (((policy != SCHED_NORMAL && p->policy != SCHED_BATCH) &&
-			(policy != SCHED_BATCH && p->policy != SCHED_NORMAL)) &&
-				!rlim_rtprio)
-			return -EPERM;
-		/* can't increase priority */
-		if (is_rt_policy(policy) &&
-		    param->sched_priority > p->rt_priority &&
-		    param->sched_priority > rlim_rtprio)
-			return -EPERM;
 		/* can't change other user's priorities */
 		if ((current->euid != p->euid) &&
 		    (current->euid != p->uid))

