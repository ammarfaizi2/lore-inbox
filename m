Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTLTU1G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 15:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbTLTU1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 15:27:06 -0500
Received: from mx2.elte.hu ([157.181.151.9]:57801 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261193AbTLTU1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 15:27:00 -0500
Date: Sat, 20 Dec 2003 21:26:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] 2.6.0 sched migrate comment
Message-ID: <20031220202611.GB32320@elte.hu>
References: <3FE46885.2030905@cyberone.com.au> <3FE468BF.9000102@cyberone.com.au> <3FE468F5.7020501@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <3FE468F5.7020501@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Nick Piggin <piggin@cyberone.com.au> wrote:

> Some comments were lost during minor surgery here...

this patch collides with John Hawkes' sched_clock() fix-patch which goes
in first. Also, the patch does more than just comment fixups. It changes
the order of tests, where a bug slipped in:

+       if (!idle && (delta <= cache_decay_ticks))

This will cause the cache-hot test to almost never trigger, which is
clearly incorrect. The correct test is:

        if (!idle && (delta <= JIFFIES_TO_NS(cache_decay_ticks)))

anyway, i've fixed it all up (patch attached).

	Ingo

--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sched-can-migrate-2.6.0-A1"

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -1193,25 +1193,25 @@ static inline void pull_task(runqueue_t 
 }
 
 /*
- * Previously:
- *
- * #define CAN_MIGRATE_TASK(p,rq,this_cpu)	\
- *	((!idle || (NS_TO_JIFFIES(now - (p)->timestamp) > \
- *		cache_decay_ticks)) && !task_running(rq, p) && \
- *			cpu_isset(this_cpu, (p)->cpus_allowed))
+ * can_migrate_task - may task p from runqueue rq be migrated to this_cpu?
  */
-
 static inline int
 can_migrate_task(task_t *tsk, runqueue_t *rq, int this_cpu, int idle)
 {
 	unsigned long delta = rq->timestamp_last_tick - tsk->timestamp;
 
-	if (!idle && (delta <= JIFFIES_TO_NS(cache_decay_ticks)))
-		return 0;
+	/*
+	 * We do not migrate tasks that are:
+	 * 1) running (obviously), or
+	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
+	 * 3) are cache-hot on their current CPU.
+	 */
 	if (task_running(rq, tsk))
 		return 0;
 	if (!cpu_isset(this_cpu, tsk->cpus_allowed))
 		return 0;
+	if (!idle && (delta <= JIFFIES_TO_NS(cache_decay_ticks)))
+		return 0;
 	return 1;
 }
 
@@ -1273,13 +1273,6 @@ skip_bitmap:
 skip_queue:
 	tmp = list_entry(curr, task_t, run_list);
 
-	/*
-	 * We do not migrate tasks that are:
-	 * 1) running (obviously), or
-	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
-	 * 3) are cache-hot on their current CPU.
-	 */
-
 	curr = curr->prev;
 
 	if (!can_migrate_task(tmp, busiest, this_cpu, idle)) {
@@ -1289,6 +1282,8 @@ skip_queue:
 		goto skip_bitmap;
 	}
 	pull_task(busiest, array, tmp, this_rq, this_cpu);
+
+	/* Only migrate one task if we are idle */
 	if (!idle && --imbalance) {
 		if (curr != head)
 			goto skip_queue;

--hQiwHBbRI9kgIhsi--
