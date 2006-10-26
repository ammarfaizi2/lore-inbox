Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945992AbWJZXWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945992AbWJZXWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945993AbWJZXWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:22:37 -0400
Received: from host-233-54.several.ru ([213.234.233.54]:10118 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1945991AbWJZXWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:22:35 -0400
Date: Fri, 27 Oct 2006 03:22:24 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] taskstats: don't use tasklist_lock
Message-ID: <20061026232224.GA535@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove tasklist_lock from taskstats.c. find_task_by_pid() is rcu-safe.
->siglock allows us to traverse subthread without tasklist.

Q: delay accounting looks wrong to me. If sub-thread has already
called taskstats_exit_send() but didn't call release_task(self) yet
it will be accounted twice. The window is big. No?

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/kernel/taskstats.c~6_tasklist	2006-10-27 02:00:32.000000000 +0400
+++ STATS/kernel/taskstats.c	2006-10-27 03:03:40.000000000 +0400
@@ -174,21 +174,19 @@ static void send_cpu_listeners(struct sk
 	up_write(&listeners->sem);
 }
 
-static int fill_pid(pid_t pid, struct task_struct *pidtsk,
+static int fill_pid(pid_t pid, struct task_struct *tsk,
 		struct taskstats *stats)
 {
 	int rc = 0;
-	struct task_struct *tsk = pidtsk;
 
-	if (!pidtsk) {
-		read_lock(&tasklist_lock);
+	if (!tsk) {
+		rcu_read_lock();
 		tsk = find_task_by_pid(pid);
-		if (!tsk) {
-			read_unlock(&tasklist_lock);
+		if (tsk)
+			get_task_struct(tsk);
+		rcu_read_unlock();
+		if (!tsk)
 			return -ESRCH;
-		}
-		get_task_struct(tsk);
-		read_unlock(&tasklist_lock);
 	} else
 		get_task_struct(tsk);
 
@@ -214,40 +212,28 @@ static int fill_pid(pid_t pid, struct ta
 
 }
 
-static int fill_tgid(pid_t tgid, struct task_struct *tgidtsk,
+static int fill_tgid(pid_t tgid, struct task_struct *first,
 		struct taskstats *stats)
 {
-	struct task_struct *tsk, *first;
+	struct task_struct *tsk;
 	unsigned long flags;
+	int rc = -ESRCH;
 
 	/*
 	 * Add additional stats from live tasks except zombie thread group
 	 * leaders who are already counted with the dead tasks
 	 */
-	first = tgidtsk;
-	if (!first) {
-		read_lock(&tasklist_lock);
+	rcu_read_lock();
+	if (!first)
 		first = find_task_by_pid(tgid);
-		if (!first) {
-			read_unlock(&tasklist_lock);
-			return -ESRCH;
-		}
-		get_task_struct(first);
-		read_unlock(&tasklist_lock);
-	} else
-		get_task_struct(first);
 
+	if (!first || !lock_task_sighand(first, &flags))
+		goto out;
 
-	tsk = first;
-	read_lock(&tasklist_lock);
-	/* Start with stats from dead tasks */
-	if (first->sighand) {
-		spin_lock_irqsave(&first->sighand->siglock, flags);
-		if (first->signal->stats)
-			memcpy(stats, first->signal->stats, sizeof(*stats));
-		spin_unlock_irqrestore(&first->sighand->siglock, flags);
-	}
+	if (first->signal->stats)
+		memcpy(stats, first->signal->stats, sizeof(*stats));
 
+	tsk = first;
 	do {
 		if (tsk->exit_state == EXIT_ZOMBIE && thread_group_leader(tsk))
 			continue;
@@ -260,15 +246,18 @@ static int fill_tgid(pid_t tgid, struct 
 		delayacct_add_tsk(stats, tsk);
 
 	} while_each_thread(first, tsk);
-	read_unlock(&tasklist_lock);
-	stats->version = TASKSTATS_VERSION;
 
+	unlock_task_sighand(first, &flags);
+	rc = 0;
+out:
+	rcu_read_unlock();
+
+	stats->version = TASKSTATS_VERSION;
 	/*
 	 * Accounting subsytems can also add calls here to modify
 	 * fields of taskstats.
 	 */
-	put_task_struct(first);
-	return 0;
+	return rc;
 }
 
 

