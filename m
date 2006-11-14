Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966491AbWKNXzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966491AbWKNXzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966492AbWKNXzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:55:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:64687 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S966491AbWKNXzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:55:18 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,422,1157353200"; 
   d="scan'208"; a="163927402:sNHT29782879"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <nickpiggin@yahoo.com.au>, "'Ingo Molnar'" <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] sched: optimize activate_task for RT task - v2
Date: Tue, 14 Nov 2006 15:55:10 -0800
Message-ID: <000401c70848$520252e0$d834030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccISFHooshAU3ivTjuS84gCcXb32A==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps the following is a better patch compare to earlier one.
The p->sleep_type are only for SCHED_NORMAL as well, so we can
bypass them altogether in one shot.




RT task does not participate in interactiveness priority and thus
shouldn't be bothered with timestamp and p->sleep_type manipulation
when task is being put on run queue.  Bypass all of the them with
a single if (rt_task) test.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./kernel/sched.c.orig	2006-11-14 13:29:37.000000000 -0800
+++ ./kernel/sched.c	2006-11-14 14:05:39.000000000 -0800
@@ -938,6 +938,9 @@ static void activate_task(struct task_st
 {
 	unsigned long long now;
 
+	if (rt_task(p))
+		goto out;
+
 	now = sched_clock();
 #ifdef CONFIG_SMP
 	if (!local) {
@@ -947,9 +950,7 @@ static void activate_task(struct task_st
 			+ rq->timestamp_last_tick;
 	}
 #endif
-
-	if (!rt_task(p))
-		p->prio = recalc_task_prio(p, now);
+	p->prio = recalc_task_prio(p, now);
 
 	/*
 	 * This checks to make sure it's not an uninterruptible task
@@ -974,7 +975,7 @@ static void activate_task(struct task_st
 		}
 	}
 	p->timestamp = now;
-
+out:
 	__activate_task(p, rq);
 }
 
