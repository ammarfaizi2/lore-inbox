Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVKZVHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVKZVHR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 16:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVKZVHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 16:07:17 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:3275 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750749AbVKZVHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 16:07:15 -0500
Date: Sat, 26 Nov 2005 13:07:26 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: akpm@osdl.org, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn,
       levon@movementarian.org
Subject: [PATCH] Make RCU task_struct safe for oprofile
Message-ID: <20051126210726.GA5277@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Applying RCU to the task structure broke oprofile, because
free_task_notify() can now be called from softirq.  This means that the
task_mortuary lock must be acquired with irq disabled in order to avoid
intermittent self-deadlock.  Since irq is now disabled, the critical
section within process_task_mortuary() has been restructured to be O(1) in
order to maximize scalability and minimize realtime latency degradation.

Kudos to Wu Fengguang for finding this problem!

CC: <wfg@mail.ustc.edu.cn>
CC: <levon@movementarian.org>
Signed-off-by: <paulmck@us.ibm.com>

---

 buffer_sync.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff -urpNa -X dontdiff linux-2.6.14-mm2/drivers/oprofile/buffer_sync.c linux-2.6.14-mm2-fixmortuary/drivers/oprofile/buffer_sync.c
--- linux-2.6.14-mm2/drivers/oprofile/buffer_sync.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14-mm2-fixmortuary/drivers/oprofile/buffer_sync.c	2005-11-26 07:51:08.000000000 -0800
@@ -43,13 +43,16 @@ static void process_task_mortuary(void);
  * list for processing. Only after two full buffer syncs
  * does the task eventually get freed, because by then
  * we are sure we will not reference it again.
+ * Can be invoked from softirq via RCU callback due to
+ * call_rcu() of the task struct, hence the _irqsave.
  */
 static int task_free_notify(struct notifier_block * self, unsigned long val, void * data)
 {
+	unsigned long flags;
 	struct task_struct * task = data;
-	spin_lock(&task_mortuary);
+	spin_lock_irqsave(&task_mortuary, flags);
 	list_add(&task->tasks, &dying_tasks);
-	spin_unlock(&task_mortuary);
+	spin_unlock_irqrestore(&task_mortuary, flags);
 	return NOTIFY_OK;
 }
 
@@ -431,25 +434,22 @@ static void increment_tail(struct oprofi
  */
 static void process_task_mortuary(void)
 {
-	struct list_head * pos;
-	struct list_head * pos2;
+	unsigned long flags;
+	LIST_HEAD(local_dead_tasks);
 	struct task_struct * task;
+	struct task_struct * ttask;
 
-	spin_lock(&task_mortuary);
+	spin_lock_irqsave(&task_mortuary, flags);
 
-	list_for_each_safe(pos, pos2, &dead_tasks) {
-		task = list_entry(pos, struct task_struct, tasks);
-		list_del(&task->tasks);
-		free_task(task);
-	}
+	list_splice_init(&dead_tasks, &local_dead_tasks);
+	list_splice_init(&dying_tasks, &dead_tasks);
 
-	list_for_each_safe(pos, pos2, &dying_tasks) {
-		task = list_entry(pos, struct task_struct, tasks);
+	spin_unlock_irqrestore(&task_mortuary, flags);
+
+	list_for_each_entry_safe(task, ttask, &local_dead_tasks, tasks) {
 		list_del(&task->tasks);
-		list_add_tail(&task->tasks, &dead_tasks);
+		free_task(task);
 	}
-
-	spin_unlock(&task_mortuary);
 }
 
 
