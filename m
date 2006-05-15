Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbWEOTEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWEOTEI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbWEOTEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:04:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:26012 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932317AbWEOTEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:04:05 -0400
Message-Id: <4t16i2$12rqnu@orsmga001.jf.intel.com>
X-IronPort-AV: i="4.05,130,1146466800"; 
   d="scan'208"; a="36563710:sNHT7341033294"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>
Cc: <tim.c.chen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
       <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>
Subject: RE: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Mon, 15 May 2006 12:01:06 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZ3cDNbvUN9Jw1lT32tJEio0WrB2AA3CMIg
In-Reply-To: <200605150203.13633.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Sunday, May 14, 2006 9:03 AM
> There would be no difference if the priority boost is done lower. The if and 
> else blocks both end up equating to the same amount of priority boost, with 
> the former having a ceiling on it, so yes it is the intent. You'll see that 
> the amount of sleep required to jump from lowest priority to MAX_SLEEP_AVG - 
> DEF_TIMESLICE is INTERACTIVE_SLEEP.

I don't think the if and the else block is doing the same thing. In the if
block, the p->sleep_avg is unconditionally boosted to ceiling for all tasks,
though it will not reduce sleep_avg for tasks that already exceed the ceiling.
Bumping up sleep_avg will then translate into priority boost of MAX_BONUS-1,
which potentially can be too high.

But that's fine if it is the intent. At minimum, the comment in the source
code should say so instead of fooling people who don't actually read the code.


[patch] sched: update comments in priority calculation w.r.t. implementation.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./kernel/sched.c.orig	2006-05-15 12:24:02.000000000 -0700
+++ ./kernel/sched.c	2006-05-15 12:37:16.000000000 -0700
@@ -746,10 +746,12 @@ static int recalc_task_prio(task_t *p, u
 	if (likely(sleep_time > 0)) {
 		/*
 		 * User tasks that sleep a long time are categorised as
-		 * idle. They will only have their sleep_avg increased to a
-		 * level that makes them just interactive priority to stay
-		 * active yet prevent them suddenly becoming cpu hogs and
-		 * starving other processes.
+		 * idle. If they sleep longer than INTERACTIVE_SLEEP, it
+		 * will have its priority boosted to minimum MAX_BONUS-1.
+		 * For short sleep, they will only have their sleep_avg
+		 * increased to a level that makes them just interactive
+		 * priority to stay active yet prevent them suddenly becoming
+		 * cpu hogs and starving other processes.
 		 */
 		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
 				unsigned long ceiling;


