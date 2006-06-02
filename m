Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWFBTXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWFBTXg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWFBTXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:23:35 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:18877 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751454AbWFBTXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:23:35 -0400
From: Balbir Singh <balbir@in.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Balbir Singh <balbir@in.ibm.com>
Date: Sat, 03 Jun 2006 00:48:37 +0530
Message-Id: <20060602191837.23235.58930.sendpatchset@localhost.localdomain>
Subject: [PATCH -mm] Send statistics even if thread group leader exits
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

The following problem was found during the usage of the per-task delay
accounting code.

When a thread group leader exits, the statistics of the remaining threads
in the thread group are not sent on exit. delayacct_add_tsk() would
fail for the thread group leader. This fix causes statistics collected for
the pid to be sent out, even if collection of tgid statistics fail.

Test Program Psuedocode

1. Main program
	creates two threads called t1 and t2
	calls pthread_exit()

2. t1
	sleeps for a while
	calls pthread_exit()
3. t2
	sleeps for a while
	calls pthread_exit()

Earlier no stats were being sent for t1 and t2.

The pid statistics are being sent to user space after the fix.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 kernel/taskstats.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff -puN kernel/taskstats.c~taskstats-thread-group-leader-exits-first-fix kernel/taskstats.c
--- linux-2.6.17-rc5/kernel/taskstats.c~taskstats-thread-group-leader-exits-first-fix	2006-06-02 18:12:44.000000000 +0530
+++ linux-2.6.17-rc5-balbir/kernel/taskstats.c	2006-06-03 00:32:16.000000000 +0530
@@ -277,8 +277,15 @@ void taskstats_exit_send(struct task_str
 	}
 
 	rc = fill_tgid(tsk->pid, tsk, tgidstats);
-	if (rc < 0)
-		goto err_skb;
+	/*
+	 * If fill_tgid() failed then one probable reason could be that the
+	 * thread group leader has exited. fill_tgid() will fail, send out
+	 * the pid statistics collected earlier.
+	 */
+	if (rc < 0) {
+		send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
+		goto ret;
+	}
 
 	na = nla_nest_start(rep_skb, TASKSTATS_TYPE_AGGR_TGID);
 	NLA_PUT_U32(rep_skb, TASKSTATS_TYPE_TGID, (u32)tsk->tgid);
_

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
