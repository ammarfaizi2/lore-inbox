Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUJURTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUJURTN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270692AbUJURRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:17:20 -0400
Received: from yacht.ocn.ne.jp ([222.146.40.168]:44031 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S269116AbUJURKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:10:46 -0400
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] schedstat: fix schedule() statistics
Date: Fri, 22 Oct 2004 02:12:42 +0900
User-Agent: KMail/1.5.4
Cc: ricklind@us.ibm.com, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410220212.42881.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The number of times schedule() left the processor idle in the /proc/schedstat
(runqueue.sched_goidle) seems to be wrong.

The schedule() statistics should satisfy the equation:
	sched_cnt == sched_noswitch + sched_switch + sched_goidle

(http://eaglet.rain.com/rick/linux/schedstat/v10/format-10.html)

The below patch fix this, and I have confirmed to be fixed with:
	# grep ^cpu /proc/schedstat | awk '{print $6+$7+$9, $8}'

--- 2.6-mm/kernel/sched.c.orig	2004-10-22 01:09:38.391429584 +0900
+++ 2.6-mm/kernel/sched.c	2004-10-22 01:23:18.590740336 +0900
@@ -2809,7 +2809,6 @@ go_idle:
 		}
 	} else {
 		if (dependent_sleeper(cpu, rq)) {
-			schedstat_inc(rq, sched_goidle);
 			next = rq->idle;
 			goto switch_tasks;
 		}
@@ -2853,6 +2852,8 @@ go_idle:
 	}
 	next->activated = 0;
 switch_tasks:
+	if (next == rq->idle)
+		schedstat_inc(rq, sched_goidle);
 	prefetch(next);
 	clear_tsk_need_resched(prev);
 	rcu_qsctr_inc(task_cpu(prev));



