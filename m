Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264497AbTLTPVi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 10:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTLTPVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 10:21:38 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:39347 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264497AbTLTPV3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 10:21:29 -0500
Message-ID: <3FE468F5.7020501@cyberone.com.au>
Date: Sun, 21 Dec 2003 02:21:25 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] 2.6.0 sched migrate comment
References: <3FE46885.2030905@cyberone.com.au> <3FE468BF.9000102@cyberone.com.au>
In-Reply-To: <3FE468BF.9000102@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------050104060008010908010202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050104060008010908010202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Some comments were lost during minor surgery here...


--------------050104060008010908010202
Content-Type: text/plain;
 name="sched-migrate-comment.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-migrate-comment.patch"


Some comments were lost during minor surgery here...


 linux-2.6-npiggin/kernel/sched.c |   42 +++++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 19 deletions(-)

diff -puN kernel/sched.c~sched-migrate-comment kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-migrate-comment	2003-12-04 13:01:06.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2003-12-04 13:01:25.000000000 +1100
@@ -1179,25 +1179,34 @@ static inline void pull_task(runqueue_t 
 }
 
 /*
- * Previously:
- *
- * #define CAN_MIGRATE_TASK(p,rq,this_cpu)	\
- *	((!idle || (NS_TO_JIFFIES(now - (p)->timestamp) > \
- *		cache_decay_ticks)) && !task_running(rq, p) && \
- *			cpu_isset(this_cpu, (p)->cpus_allowed))
+ * can_migrate_task
+ * May task p from runqueue rq be migrated to this_cpu?
+ * idle: Is this_cpu idle
+ * Returns: 1 if p may be migrated, 0 otherwise.
  */
-
 static inline int
-can_migrate_task(task_t *tsk, runqueue_t *rq, int this_cpu, int idle)
+can_migrate_task(task_t *p, runqueue_t *rq, int this_cpu, int idle)
 {
-	unsigned long delta = sched_clock() - tsk->timestamp;
+	unsigned long delta;
+
+	/*
+	 * We do not migrate tasks that are:
+	 * 1) running (obviously), or
+	 * 2) cannot be migrated to this CPU due to cpus_allowed, or
+	 * 3) are cache-hot on their current CPU.
+	 */
 
-	if (!idle && (delta <= JIFFIES_TO_NS(cache_decay_ticks)))
+	if (task_running(rq, p))
 		return 0;
-	if (task_running(rq, tsk))
+
+	if (!cpu_isset(this_cpu, p->cpus_allowed))
 		return 0;
-	if (!cpu_isset(this_cpu, tsk->cpus_allowed))
+
+	/* Aggressive migration if we're idle */
+	delta = sched_clock() - p->timestamp;
+	if (!idle && (delta <= cache_decay_ticks))
 		return 0;
+
 	return 1;
 }
 
@@ -1259,13 +1268,6 @@ skip_bitmap:
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
@@ -1275,6 +1277,8 @@ skip_queue:
 		goto skip_bitmap;
 	}
 	pull_task(busiest, array, tmp, this_rq, this_cpu);
+
+	/* Only migrate 1 task if we're idle */
 	if (!idle && --imbalance) {
 		if (curr != head)
 			goto skip_queue;

_

--------------050104060008010908010202--

