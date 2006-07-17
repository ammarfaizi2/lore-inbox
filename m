Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbWGQVwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWGQVwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 17:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWGQVwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 17:52:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:42131 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750768AbWGQVwm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 17:52:42 -0400
Subject: [Patch 1/3] make taskstats sending completely independent of delay
	accounting on/off status
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Balbir Singh <balbir@in.ibm.com>, Chris Sturtivant <csturtiv@sgi.com>
In-Reply-To: <1153173063.4551.10.camel@dyn9002218086.watson.ibm.com>
References: <1153173063.4551.10.camel@dyn9002218086.watson.ibm.com>
Content-Type: text/plain
Organization: IBM
Message-Id: <1153173158.4551.13.camel@dyn9002218086.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 17 Jul 2006 17:52:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Complete the separation of delay accounting and taskstats by ignoring the
return value of delay accounting functions that fill in parts of taskstats
before it is sent out (either in response to a command or as part of a task
exit).

Also make delayacct_add_tsk return silently when delay accounting is turned
off rather than treat it as an error.

Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/delayacct.h |    4 +---
 kernel/taskstats.c        |    8 +++-----
 2 files changed, 4 insertions(+), 8 deletions(-)

Index: linux-2.6.18-rc2/kernel/taskstats.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/taskstats.c	2006-07-17 17:01:51.000000000 -0400
+++ linux-2.6.18-rc2/kernel/taskstats.c	2006-07-17 17:03:41.000000000 -0400
@@ -177,7 +177,7 @@ static int send_cpu_listeners(struct sk_
 static int fill_pid(pid_t pid, struct task_struct *pidtsk,
 		struct taskstats *stats)
 {
-	int rc;
+	int rc = 0;
 	struct task_struct *tsk = pidtsk;
 
 	if (!pidtsk) {
@@ -196,12 +196,10 @@ static int fill_pid(pid_t pid, struct ta
 	 * Each accounting subsystem adds calls to its functions to
 	 * fill in relevant parts of struct taskstsats as follows
 	 *
-	 *	rc = per-task-foo(stats, tsk);
-	 *	if (rc)
-	 *		goto err;
+	 *	per-task-foo(stats, tsk);
 	 */
 
-	rc = delayacct_add_tsk(stats, tsk);
+	delayacct_add_tsk(stats, tsk);
 	stats->version = TASKSTATS_VERSION;
 
 	/* Define err: label here if needed */
Index: linux-2.6.18-rc2/include/linux/delayacct.h
===================================================================
--- linux-2.6.18-rc2.orig/include/linux/delayacct.h	2006-07-17 17:01:51.000000000 -0400
+++ linux-2.6.18-rc2/include/linux/delayacct.h	2006-07-17 17:03:41.000000000 -0400
@@ -80,9 +80,7 @@ static inline void delayacct_blkio_end(v
 static inline int delayacct_add_tsk(struct taskstats *d,
 					struct task_struct *tsk)
 {
-	if (likely(!delayacct_on))
-		return -EINVAL;
-	if (!tsk->delays)
+	if (likely(!delayacct_on) || !tsk->delays)
 		return 0;
 	return __delayacct_add_tsk(d, tsk);
 }


