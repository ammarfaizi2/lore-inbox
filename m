Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264284AbTEZJnj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 05:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264327AbTEZJnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 05:43:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57770 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264284AbTEZJni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 05:43:38 -0400
Date: Mon, 26 May 2003 11:55:20 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] signal-latency-2.5.69-B0
Message-ID: <Pine.LNX.4.44.0305261143140.4970-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch, against BK-curr, further optimizes the 'kick wakeup'
scheduler feature:

 - do not kick any CPU on UP

 - no need to mark the target task for reschedule - it's enough to send an 
   interrupt to that CPU, that will initiate a signal processing pass.

tested on x86 SMP and UP.

	Ingo

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -500,9 +500,12 @@ repeat_lock_task:
 					resched_task(rq->curr);
 			}
 			success = 1;
-		} else
-			if (unlikely(kick) && task_running(rq, p))
-				resched_task(rq->curr);
+		}
+#if CONFIG_SMP
+	       	else
+			if (unlikely(kick) && task_running(rq, p) && (p->thread_info->cpu != smp_processor_id()))
+				smp_send_reschedule(p->thread_info->cpu);
+#endif
 		p->state = TASK_RUNNING;
 	}
 	task_rq_unlock(rq, &flags);

