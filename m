Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWFUGHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWFUGHE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 02:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWFUGHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 02:07:04 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:62630 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751184AbWFUGHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 02:07:01 -0400
From: Balbir Singh <balbir@in.ibm.com>
To: akpm@osdl.org
Cc: Shailabh.Nagar@d23av01.au.ibm.com (nagar@watson.ibm.com),
       Balbir Singh <balbir@in.ibm.com>,
       Jay.Lan@d23av01.au.ibm.com (jlan@engr.sgi.com),
       linux-kernel@vger.kernel.org
Date: Wed, 21 Jun 2006 11:29:52 +0530
Message-Id: <20060621055952.6658.49704.sendpatchset@localhost.localdomain>
Subject: [PATCH 2.6.17-rc6-mm2] Fix exit race in per-task-delay-accounting
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

This patch fixes a race in per-task-delay-accounting. This race
was reported by Jay Lan. I tested the patch using
cerebrus test control system for eight hours with getdelays running on
the side (for both push and pull of delay statistics).

It fixed the problem that Jay Lan saw.

Here's an explanation of the race condition

Consider tasks of the same thread group exiting, lets call them T1 and T2


T1                          T2

CPU0                        CPU1
=====                       =====

do_exit()
...                        do_exit()
taskstats_exit_send()                ...
                           taskstats_exit_send()
                           	fill_tgid()
                                delayacct_add_tsk()
delayacct_tsk_exit()            ....
                                __delayacct_add_tsk()


While T1 is yet to be removed from the thread group. T1->delays is set to NULL
between delayacct_add_tsk() and __delayacct_add_tsk() call.

When T2 looks for threads in the thread group, it finds T1 and tries to
collect stats for it. When we get to the spin_lock() in __delayacct_add_tsk(),
we find T1->delays is a NULL pointer.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/linux/taskstats_kern.h |    1 +
 kernel/delayacct.c             |    5 ++++-
 kernel/taskstats.c             |    5 ++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff -puN kernel/taskstats.c~per-task-delay-accounting-fix-exit-race kernel/taskstats.c
--- linux-2.6.17-rc6/kernel/taskstats.c~per-task-delay-accounting-fix-exit-race	2006-06-20 13:49:29.000000000 +0530
+++ linux-2.6.17-rc6-balbir/kernel/taskstats.c	2006-06-20 13:49:29.000000000 +0530
@@ -25,7 +25,7 @@
 static DEFINE_PER_CPU(__u32, taskstats_seqnum) = { 0 };
 static int family_registered = 0;
 kmem_cache_t *taskstats_cache;
-static DEFINE_MUTEX(taskstats_exit_mutex);
+DEFINE_MUTEX(taskstats_exit_mutex);
 
 static struct genl_family family = {
 	.id		= GENL_ID_GENERATE,
@@ -193,6 +193,7 @@ static int taskstats_send_stats(struct s
 	if (rc < 0)
 		return rc;
 
+	mutex_lock(&taskstats_exit_mutex);
 	if (info->attrs[TASKSTATS_CMD_ATTR_PID]) {
 		u32 pid = nla_get_u32(info->attrs[TASKSTATS_CMD_ATTR_PID]);
 		rc = fill_pid(pid, NULL, &stats);
@@ -218,6 +219,7 @@ static int taskstats_send_stats(struct s
 		goto err;
 	}
 
+	mutex_unlock(&taskstats_exit_mutex);
 	nla_nest_end(rep_skb, na);
 
 	return send_reply(rep_skb, info->snd_pid, TASKSTATS_MSG_UNICAST);
@@ -226,6 +228,7 @@ nla_put_failure:
 	return genlmsg_cancel(rep_skb, reply);
 err:
 	nlmsg_free(rep_skb);
+	mutex_unlock(&taskstats_exit_mutex);
 	return rc;
 }
 
diff -puN kernel/delayacct.c~per-task-delay-accounting-fix-exit-race kernel/delayacct.c
--- linux-2.6.17-rc6/kernel/delayacct.c~per-task-delay-accounting-fix-exit-race	2006-06-20 13:49:29.000000000 +0530
+++ linux-2.6.17-rc6-balbir/kernel/delayacct.c	2006-06-20 13:49:29.000000000 +0530
@@ -48,8 +48,11 @@ void __delayacct_tsk_init(struct task_st
 
 void __delayacct_tsk_exit(struct task_struct *tsk)
 {
-	kmem_cache_free(delayacct_cache, tsk->delays);
+	struct task_delay_info *delays = tsk->delays;
+	mutex_lock(&taskstats_exit_mutex);
 	tsk->delays = NULL;
+	mutex_unlock(&taskstats_exit_mutex);
+	kmem_cache_free(delayacct_cache, delays);
 }
 
 /*
diff -puN include/linux/taskstats_kern.h~per-task-delay-accounting-fix-exit-race include/linux/taskstats_kern.h
--- linux-2.6.17-rc6/include/linux/taskstats_kern.h~per-task-delay-accounting-fix-exit-race	2006-06-20 13:49:29.000000000 +0530
+++ linux-2.6.17-rc6-balbir/include/linux/taskstats_kern.h	2006-06-20 13:49:29.000000000 +0530
@@ -17,6 +17,7 @@ enum {
 
 #ifdef CONFIG_TASKSTATS
 extern kmem_cache_t *taskstats_cache;
+extern struct mutex taskstats_exit_mutex;
 
 static inline void taskstats_exit_alloc(struct taskstats **ptidstats,
 					struct taskstats **ptgidstats)
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
