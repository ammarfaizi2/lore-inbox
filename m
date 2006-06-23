Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751831AbWFWRwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbWFWRwu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 13:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWFWRwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 13:52:50 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39848 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751831AbWFWRwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 13:52:49 -0400
Message-ID: <449C2A44.9000206@watson.ibm.com>
Date: Fri, 23 Jun 2006 13:52:04 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jay Lan <jlan@sgi.com>, Balbir Singh <balbir@in.ibm.com>,
       Chris Sturtivant <csturtiv@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch] Revised locking for taskstats interface
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert locking used within taskstats interface and delay accounting
code to be more fine-grained.

Dynamic allocation of the delays data structure led to exit race
conditions that were being fixed through use of a global mutex at the
taskstats interface level. The same mutex was also being used for
protecting per-task delay structure allocation. Together, these were
causing higher contention and unnecessary serialization.

This patch switches to a per-task locking for protecting tsk->delays
and eliminates global locking within the taskstats interface.

Results collected by Jay Lan (jlan@sgi.com) from running a test
with rapid forks/exits shows substantial improvement in system time.
For a benchmark that only forks+exits 1000 threads and runs for
5000 iterations, the reduction seen are as follows:

	base	+patch   %improvement
user	0.06	0.07	-16%		
system	1.34	0.86	35%
elapsed	622	470	24%


Signed-off-by: Shailabh Nagar <nagar@watson.ibm.com>
---

 include/linux/sched.h |    1 +
 kernel/delayacct.c    |   18 ++++++++++++++++--
 kernel/taskstats.c    |    7 -------
 3 files changed, 17 insertions(+), 9 deletions(-)

Index: linux-2.6.17/include/linux/sched.h
===================================================================
--- linux-2.6.17.orig/include/linux/sched.h	2006-06-22 02:56:44.000000000 -0400
+++ linux-2.6.17/include/linux/sched.h	2006-06-22 15:18:09.000000000 -0400
@@ -933,6 +933,7 @@ struct task_struct {
 	 */
 	struct pipe_inode_info *splice_pipe;
 #ifdef	CONFIG_TASK_DELAY_ACCT
+	spinlock_t delays_lock;
 	struct task_delay_info *delays;
 #endif
 };
Index: linux-2.6.17/kernel/delayacct.c
===================================================================
--- linux-2.6.17.orig/kernel/delayacct.c	2006-06-22 02:56:44.000000000 -0400
+++ linux-2.6.17/kernel/delayacct.c	2006-06-22 15:18:09.000000000 -0400
@@ -41,6 +41,10 @@ void delayacct_init(void)

 void __delayacct_tsk_init(struct task_struct *tsk)
 {
+	spin_lock_init(&tsk->delays_lock);
+	/* No need to acquire tsk->delays_lock for allocation here unless
+	   __delayacct_tsk_init called after tsk is attached to tasklist
+	*/
 	tsk->delays = kmem_cache_zalloc(delayacct_cache, SLAB_KERNEL);
 	if (tsk->delays)
 		spin_lock_init(&tsk->delays->lock);
@@ -49,9 +53,9 @@ void __delayacct_tsk_init(struct task_st
 void __delayacct_tsk_exit(struct task_struct *tsk)
 {
 	struct task_delay_info *delays = tsk->delays;
-	mutex_lock(&taskstats_exit_mutex);
+	spin_lock(&tsk->delays_lock);
 	tsk->delays = NULL;
-	mutex_unlock(&taskstats_exit_mutex);
+	spin_unlock(&tsk->delays_lock);
 	kmem_cache_free(delayacct_cache, delays);
 }

@@ -114,6 +118,14 @@ int __delayacct_add_tsk(struct taskstats
 	struct timespec ts;
 	unsigned long t1,t2,t3;

+	spin_lock(&tsk->delays_lock);
+
+	/* Though tsk->delays accessed later, early exit avoids
+	 * unnecessary returning of other data
+	 */
+	if (!tsk->delays)
+		goto done;
+
 	tmp = (s64)d->cpu_run_real_total;
 	cputime_to_timespec(tsk->utime + tsk->stime, &ts);
 	tmp += timespec_to_ns(&ts);
@@ -148,6 +160,8 @@ int __delayacct_add_tsk(struct taskstats
 	d->swapin_count += tsk->delays->swapin_count;
 	spin_unlock(&tsk->delays->lock);

+done:
+	spin_unlock(&tsk->delays_lock);
 	return 0;
 }

Index: linux-2.6.17/kernel/taskstats.c
===================================================================
--- linux-2.6.17.orig/kernel/taskstats.c	2006-06-22 02:56:44.000000000 -0400
+++ linux-2.6.17/kernel/taskstats.c	2006-06-22 15:27:09.000000000 -0400
@@ -25,7 +25,6 @@
 static DEFINE_PER_CPU(__u32, taskstats_seqnum) = { 0 };
 static int family_registered = 0;
 kmem_cache_t *taskstats_cache;
-DEFINE_MUTEX(taskstats_exit_mutex);

 static struct genl_family family = {
 	.id		= GENL_ID_GENERATE,
@@ -193,7 +192,6 @@ static int taskstats_send_stats(struct s
 	if (rc < 0)
 		return rc;

-	mutex_lock(&taskstats_exit_mutex);
 	if (info->attrs[TASKSTATS_CMD_ATTR_PID]) {
 		u32 pid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_PID]);
 		rc = fill_pid(pid, NULL, &stats);
@@ -219,7 +217,6 @@ static int taskstats_send_stats(struct s
 		goto err;
 	}

-	mutex_unlock(&taskstats_exit_mutex);
 	nla_nest_end(rep_skb, na);

 	return send_reply(rep_skb, info->snd_pid, TASKSTATS_MSG_UNICAST);
@@ -228,7 +225,6 @@ nla_put_failure:
 	return genlmsg_cancel(rep_skb, reply);
 err:
 	nlmsg_free(rep_skb);
-	mutex_unlock(&taskstats_exit_mutex);
 	return rc;
 }

@@ -246,8 +242,6 @@ void taskstats_exit_send(struct task_str
 	if (!family_registered || !tidstats)
 		return;

-	mutex_lock(&taskstats_exit_mutex);
-
 	is_thread_group = !thread_group_empty(tsk);
 	rc = 0;

@@ -305,7 +299,6 @@ nla_put_failure:
 err_skb:
 	nlmsg_free(rep_skb);
 ret:
-	mutex_unlock(&taskstats_exit_mutex);
 	return;
 }

