Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272363AbTHEAM7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 20:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272366AbTHEAM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 20:12:59 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:16793
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272363AbTHEAMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 20:12:45 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O13.1int
Date: Tue, 5 Aug 2003 10:17:55 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308051017.55616.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A heck of a lot fairer on disk only tasks; lets them earn sleep avg up to just 
interactive state so they stay on the active array.

Con

--- linux-2.6.0-test2-mm4-O13/kernel/sched.c	2003-08-05 10:08:15.000000000 +1000
+++ linux-2.6.0-test2-mm4-O13.1/kernel/sched.c	2003-08-05 09:58:55.000000000 +1000
@@ -584,13 +584,16 @@ repeat_lock_task:
 				goto repeat_lock_task;
 			}
 			if (old_state == TASK_UNINTERRUPTIBLE){
+				rq->nr_uninterruptible--;
 				/*
 				 * Tasks on involuntary sleep don't earn
-				 * sleep_avg
+				 * sleep_avg beyond just interactive state.
 				 */
-				rq->nr_uninterruptible--;
-				p->timestamp = sched_clock();
-				p->activated = -1;
+				if (NS_TO_JIFFIES(p->sleep_avg) >=
+					JUST_INTERACTIVE_SLEEP(p)){
+						p->timestamp = sched_clock();
+						p->activated = -1;
+				}
 			}
 			if (sync)
 				__activate_task(p, rq);

