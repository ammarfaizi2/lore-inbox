Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271704AbTHDLoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 07:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271707AbTHDLoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 07:44:55 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:19857
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271704AbTHDLox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 07:44:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O12.3 for interactivity
Date: Mon, 4 Aug 2003 21:50:01 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308042150.01715.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a small patch against O12.2. This should not change peformance in any 
way but removes redundant code (which we all love to do). Ingo pointed out
that new forks wont have any sleep time to earn as sleep_avg. It is also
extrememly unlikely that there won't be any sleep time with nanosecond 
timing. Patch applies to 2.6.0-test2-mm4 or test2 patched with O12.2.

Con

diff -Naurp linux-2.6.0-test2-mm4/kernel/sched.c linux-2.6.0-test2-mm4-O12.3/kernel/sched.c
--- linux-2.6.0-test2-mm4/kernel/sched.c	2003-08-04 20:16:02.000000000 +1000
+++ linux-2.6.0-test2-mm4-O12.3/kernel/sched.c	2003-08-04 20:19:10.000000000 +1000
@@ -365,9 +365,6 @@ static void recalc_task_prio(task_t *p, 
 	unsigned long long __sleep_time = now - p->timestamp;
 	unsigned long sleep_time;
 
-	if (unlikely(!p->timestamp))
-		__sleep_time = 0;
-
 	if (__sleep_time > NS_MAX_SLEEP_AVG)
 		sleep_time = NS_MAX_SLEEP_AVG;
 	else
@@ -420,8 +417,7 @@ static void recalc_task_prio(task_t *p, 
 				p->interactive_credit++;
 			}
 		}
-	} else if (!p->sleep_avg)
-		p->interactive_credit--;
+	}
 
 	p->prio = effective_prio(p);
 }
@@ -454,9 +450,6 @@ static inline void activate_task(task_t 
 	 */
 		p->activated = 1;
 
-	if (unlikely(!p->timestamp))
-		p->activated = 0;
-
 	p->timestamp = now;
 
 	__activate_task(p, rq);
@@ -644,7 +637,6 @@ void wake_up_forked_process(task_t * p)
 	p->sleep_avg = JIFFIES_TO_NS(sleep_avg);
 
 	p->interactive_credit = 0;
-	p->timestamp = 0;
 
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());

