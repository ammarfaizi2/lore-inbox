Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268746AbUJECiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268746AbUJECiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 22:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbUJECiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 22:38:07 -0400
Received: from fmr04.intel.com ([143.183.121.6]:56023 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S268746AbUJECiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 22:38:02 -0400
Message-Id: <200410050237.i952bx620740@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: bug in sched.c:task_hot()
Date: Mon, 4 Oct 2004 19:38:01 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSqhFUV6ax6XVQDS9eE31wy/inRzw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of task_hot() has a performance bug in it
that it will cause integer underflow.

Variable "now" (typically passed in as rq->timestamp_last_tick)
and p->timestamp are all defined as unsigned long long.  However,
If former is smaller than the latter, integer under flow occurs
which make the result of subtraction a huge positive number. Then
it is compared to sd->cache_hot_time and it will wrongly identify
a cache hot task as cache cold.

This bug causes large amount of incorrect process migration across
cpus (at stunning 10,000 per second) and we lost cache affinity very
quickly and almost took double digit performance regression on a db
transaction processing workload.  Patch to fix the bug.  Diff'ed against
2.6.9-rc3.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- linux-2.6.9-rc3/kernel/sched.c.orig	2004-10-04 19:11:21.000000000 -0700
+++ linux-2.6.9-rc3/kernel/sched.c	2004-10-04 19:19:27.000000000 -0700
@@ -180,7 +180,8 @@ static unsigned int task_timeslice(task_
 	else
 		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
 }
-#define task_hot(p, now, sd) ((now) - (p)->timestamp < (sd)->cache_hot_time)
+#define task_hot(p, now, sd) ((long long) ((now) - (p)->timestamp)	\
+				< (long long) (sd)->cache_hot_time)

 enum idle_type
 {


