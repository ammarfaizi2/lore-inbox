Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272267AbTG3VYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 17:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272268AbTG3VYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 17:24:23 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:38844
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272267AbTG3VYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 17:24:22 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O11.2int for interactivity
Date: Thu, 31 Jul 2003 07:28:56 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307310728.56863.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch backs out a little section which isn't quite right and 
just might in the wrong circumstances cause unfairness. Goes on
top of O11.1

Con

--- linux-2.6.0-test2-mm1/kernel/sched.c	2003-07-30 20:26:08.000000000 +1000
+++ linux-2.6.0-test2mm1O11/kernel/sched.c	2003-07-30 20:26:45.000000000 +1000
@@ -1292,16 +1292,7 @@ void scheduler_tick(int user_ticks, int 
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			if (!rq->expired_timestamp)
 				rq->expired_timestamp = jiffies;
-			/*
-			 * Long term interactive tasks need to completely
-			 * run out of sleep_avg to be expired, and when they
-			 * do they are put at the start of the expired array
-			 */
-			if (unlikely(p->interactive_credit && p->sleep_avg)){
-				enqueue_task(p, rq->active);
-				goto out_unlock;
-			}
-				enqueue_task(p, rq->expired);
+			enqueue_task(p, rq->expired);
 		} else
 			enqueue_task(p, rq->active);
 	} else if (p->mm && !((task_timeslice(p) - p->time_slice) %

