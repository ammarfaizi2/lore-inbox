Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275449AbTHJBYa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 21:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275451AbTHJBYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 21:24:30 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:40936
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S275449AbTHJBY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 21:24:29 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O14.1int
Date: Sun, 10 Aug 2003 11:29:53 +1000
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308101129.53270.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reverse the "fix" which broke SMP and small change to requeuing.
Will consider how to fix it properly.

Con

--- linux-2.6.0-test2-mm5-O14/kernel/sched.c	2003-08-10 11:26:04.000000000 +1000
+++ linux-2.6.0-test2-mm5/kernel/sched.c	2003-08-10 11:24:13.000000000 +1000
@@ -1178,9 +1178,9 @@ skip_queue:
 	 * 3) are cache-hot on their current CPU.
 	 */
 
-#define CAN_MIGRATE_TASK(p,rq,this_cpu)	\
-	((!idle || (NS_TO_JIFFIES(now - (p)->timestamp) > \
-		cache_decay_ticks)) && !task_running(rq, p) && \
+#define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
+	((!idle || (((now - (p)->timestamp)>>10) > cache_decay_ticks)) &&\
+		!task_running(rq, p) &&					\
 			cpu_isset(this_cpu, (p)->cpus_allowed))
 
 	curr = curr->prev;
@@ -1405,6 +1405,7 @@ void scheduler_tick(int user_ticks, int 
 			 */
 			if (HIGH_CREDIT(p))
 				p->activated = 2;
+			p->prio = effective_prio(p);
 			enqueue_task(p, rq->active);
 		}
 	}

