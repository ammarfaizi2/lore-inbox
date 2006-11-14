Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966485AbWKNXl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966485AbWKNXl6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966486AbWKNXl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:41:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:2446 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S966485AbWKNXl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:41:57 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,422,1157353200"; 
   d="scan'208"; a="163916500:sNHT31709853"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <nickpiggin@yahoo.com.au>, "Ingo Molnar" <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] sched: optimize activate_task for RT task
Date: Tue, 14 Nov 2006 15:41:54 -0800
Message-ID: <000301c70846$786c87e0$d834030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccIRnb8zoPSUTNxSF+p8JyryR1LKg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RT task does not participate in interactiveness priority and thus
shouldn't be bothered with timestamp when task is being put on run
queue. We should push all of the time calculation inside already
existed if (!rt_task) block.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./kernel/sched.c.orig	2006-11-14 13:29:37.000000000 -0800
+++ ./kernel/sched.c	2006-11-14 13:52:02.000000000 -0800
@@ -936,20 +936,19 @@ static int recalc_task_prio(struct task_
  */
 static void activate_task(struct task_struct *p, struct rq *rq, int local)
 {
-	unsigned long long now;
-
-	now = sched_clock();
+	if (!rt_task(p)) {
+		unsigned long long now = sched_clock();
 #ifdef CONFIG_SMP
-	if (!local) {
-		/* Compensate for drifting sched_clock */
-		struct rq *this_rq = this_rq();
-		now = (now - this_rq->timestamp_last_tick)
-			+ rq->timestamp_last_tick;
-	}
+		if (!local) {
+			/* Compensate for drifting sched_clock */
+			struct rq *this_rq = this_rq();
+			now = (now - this_rq->timestamp_last_tick)
+				+ rq->timestamp_last_tick;
+		}
 #endif
-
-	if (!rt_task(p))
 		p->prio = recalc_task_prio(p, now);
+		p->timestamp = now;
+	}
 
 	/*
 	 * This checks to make sure it's not an uninterruptible task
@@ -973,7 +972,6 @@ static void activate_task(struct task_st
 			p->sleep_type = SLEEP_INTERACTIVE;
 		}
 	}
-	p->timestamp = now;
 
 	__activate_task(p, rq);
 }
