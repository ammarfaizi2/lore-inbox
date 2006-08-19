Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWHSPHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWHSPHR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 11:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWHSPHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 11:07:17 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:20894 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751419AbWHSPHP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 11:07:15 -0400
Date: Sat, 19 Aug 2006 23:31:13 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] do_sched_setscheduler: don't take tasklist_lock
Message-ID: <20060819193113.GA7969@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use rcu locks instead. sched_setscheduler() now takes ->siglock
before reading ->signal->rlim[].

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/kernel/sched.c~2_signal	2006-08-19 20:22:09.000000000 +0400
+++ 2.6.18-rc4/kernel/sched.c	2006-08-19 21:14:19.000000000 +0400
@@ -4043,6 +4043,8 @@ static void __setscheduler(struct task_s
  * @p: the task in question.
  * @policy: new policy.
  * @param: structure containing the new RT priority.
+ *
+ * NOTE: the task may be already dead
  */
 int sched_setscheduler(struct task_struct *p, int policy,
 		       struct sched_param *param)
@@ -4078,19 +4080,26 @@ recheck:
 	 * Allow unprivileged RT tasks to decrease priority:
 	 */
 	if (!capable(CAP_SYS_NICE)) {
+		unsigned long rlim_rtprio;
+		unsigned long flags;
+
+		if (!lock_task_sighand(p, &flags))
+			return -ESRCH;
+		rlim_rtprio = p->signal->rlim[RLIMIT_RTPRIO].rlim_cur;
+		unlock_task_sighand(p, &flags);
+
 		/*
 		 * can't change policy, except between SCHED_NORMAL
 		 * and SCHED_BATCH:
 		 */
 		if (((policy != SCHED_NORMAL && p->policy != SCHED_BATCH) &&
 			(policy != SCHED_BATCH && p->policy != SCHED_NORMAL)) &&
-				!p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
+				!rlim_rtprio)
 			return -EPERM;
 		/* can't increase priority */
 		if ((policy != SCHED_NORMAL && policy != SCHED_BATCH) &&
 		    param->sched_priority > p->rt_priority &&
-		    param->sched_priority >
-				p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
+		    param->sched_priority > rlim_rtprio)
 			return -EPERM;
 		/* can't change other user's priorities */
 		if ((current->euid != p->euid) &&
@@ -4156,14 +4165,13 @@ do_sched_setscheduler(pid_t pid, int pol
 		return -EINVAL;
 	if (copy_from_user(&lparam, param, sizeof(struct sched_param)))
 		return -EFAULT;
-	read_lock_irq(&tasklist_lock);
+
+	rcu_read_lock();
+	retval = -ESRCH;
 	p = find_process_by_pid(pid);
-	if (!p) {
-		read_unlock_irq(&tasklist_lock);
-		return -ESRCH;
-	}
-	retval = sched_setscheduler(p, policy, &lparam);
-	read_unlock_irq(&tasklist_lock);
+	if (p != NULL)
+		retval = sched_setscheduler(p, policy, &lparam);
+	rcu_read_unlock();
 
 	return retval;
 }

