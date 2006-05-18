Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbWERXRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWERXRY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWERXRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:17:24 -0400
Received: from mga03.intel.com ([143.182.124.21]:57199 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750944AbWERXRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:17:23 -0400
Message-Id: <4t153d$14oruq@azsmga001.ch.intel.com>
X-IronPort-AV: i="4.05,143,1146466800"; 
   d="scan'208"; a="38563802:sNHT67113186"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>, "Mike Galbraith" <efault@gmx.de>
Cc: <tim.c.chen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
       <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>
Subject: RE: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Thu, 18 May 2006 16:17:21 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZ6P0Qi6Fn7PLXdSiCeH7Qyo7JTxgAkNJ9A
In-Reply-To: <200605181552.19868.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Wednesday, May 17, 2006 10:52 PM
> The relationship between INTERACTIVE_SLEEP and the ceiling is not perfect
> and not explicit enough. The sleep boost is not supposed to be any larger
> than without this code and the comment is not clear enough about what exactly
> it does, just the reason it does it.
> 
> There is a ceiling to the priority beyond which tasks that only ever sleep
> for very long periods cannot surpass.
> 
> Opportunity to micro-optimise and re-use the ceiling variable.


More opportunity to micro-optimize: now that you've put the clamp code of
p->sleep_avg in the common path, there is no need to clamp sleep_time at
the beginning of that function.  Just let the calculation go through and
clamp the final value of p->sleep_avg to NS_MAX_SLEEP_AVG at the end.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./kernel/sched.c.orig	2006-05-18 12:51:45.000000000 -0700
+++ ./kernel/sched.c	2006-05-18 14:53:47.000000000 -0700
@@ -731,17 +731,10 @@
 static int recalc_task_prio(task_t *p, unsigned long long now)
 {
 	/* Caller must always ensure 'now >= p->timestamp' */
-	unsigned long long __sleep_time = now - p->timestamp;
-	unsigned long sleep_time;
+	unsigned long sleep_time = now - p->timestamp;
 
 	if (batch_task(p))
 		sleep_time = 0;
-	else {
-		if (__sleep_time > NS_MAX_SLEEP_AVG)
-			sleep_time = NS_MAX_SLEEP_AVG;
-		else
-			sleep_time = (unsigned long)__sleep_time;
-	}
 
 	if (likely(sleep_time > 0)) {
 		/*


