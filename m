Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVBXHQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVBXHQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVBXHQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:16:19 -0500
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:49589 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261882AbVBXHQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:16:06 -0500
Subject: [PATCH 1/13] timestamp fixes
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109229293.5177.64.camel@npiggin-nld.site>
References: <1109229293.5177.64.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-gK3SSWiwZd7cSpXX/zzW"
Date: Thu, 24 Feb 2005 18:16:02 +1100
Message-Id: <1109229362.5177.67.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gK3SSWiwZd7cSpXX/zzW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

1/13


--=-gK3SSWiwZd7cSpXX/zzW
Content-Disposition: attachment; filename=sched-timestamp-fixes.patch
Content-Type: text/x-patch; name=sched-timestamp-fixes.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some fixes for unsynchronised TSCs. A task's timestamp may have been set
by another CPU. Although we try to adjust this correctly with the
timestamp_last_tick field, there is no guarantee this will be exactly right.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-02-24 17:31:25.384986289 +1100
+++ linux-2.6/kernel/sched.c	2005-02-24 17:43:39.356379395 +1100
@@ -648,6 +648,7 @@
 
 static void recalc_task_prio(task_t *p, unsigned long long now)
 {
+	/* Caller must always ensure 'now >= p->timestamp' */
 	unsigned long long __sleep_time = now - p->timestamp;
 	unsigned long sleep_time;
 
@@ -2703,8 +2704,10 @@
 
 	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
-	if (likely(now - prev->timestamp < NS_MAX_SLEEP_AVG))
+	if (likely((long long)now - prev->timestamp < NS_MAX_SLEEP_AVG))
 		run_time = now - prev->timestamp;
+		if (unlikely((long long)now - prev->timestamp < 0))
+			run_time = 0;
 	else
 		run_time = NS_MAX_SLEEP_AVG;
 
@@ -2782,6 +2785,8 @@
 
 	if (!rt_task(next) && next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
+		if (unlikely((long long)now - next->timestamp < 0))
+			delta = 0;
 
 		if (next->activated == 1)
 			delta = delta * (ON_RUNQUEUE_WEIGHT * 128 / 100) / 128;

--=-gK3SSWiwZd7cSpXX/zzW--


