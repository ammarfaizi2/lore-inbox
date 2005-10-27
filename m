Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbVJ0Bx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbVJ0Bx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 21:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbVJ0Bx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 21:53:29 -0400
Received: from fmr24.intel.com ([143.183.121.16]:41705 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932623AbVJ0Bx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 21:53:28 -0400
Message-Id: <200510270153.j9R1r5g27370@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] optimize activate_task()
Date: Wed, 26 Oct 2005 18:53:05 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXamSv4u3LR4ONbTVW4Mz1d0Dyahw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

recalc_task_prio() is called from activate_task() to calculate
dynamic priority and interactive credit for the activating task.
For real-time scheduling process, all that dynamic calculation
is thrown away at the end because rt priority is fixed.  Patch
to optimize recalc_task_prio() away for rt processes.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- ./kernel/sched.c.orig	2005-10-26 10:39:40.594015398 -0700
+++ ./kernel/sched.c	2005-10-26 18:43:12.187410006 -0700
@@ -833,7 +833,8 @@ static void activate_task(task_t *p, run
 	}
 #endif
 
-	p->prio = recalc_task_prio(p, now);
+	if (!rt_task(p))
+		p->prio = recalc_task_prio(p, now);
 
 	/*
 	 * This checks to make sure it's not an uninterruptible task

