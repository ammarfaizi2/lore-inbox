Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWAZDxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWAZDxm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAZDxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:53:15 -0500
Received: from [202.53.187.9] ([202.53.187.9]:24299 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932231AbWAZDti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:38 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 19/23] [Suspend2] Freeze all threads of a type.
Date: Thu, 26 Jan 2006 13:46:05 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034604.3178.13657.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a helper, which seeks to freeze all threads of a given type. If the
type is kernel threads, it first freezes filesystems. Separate timeouts
are used for periodically prodding processes that haven't yet entered
the refrigerator, and for the timeout after which we consider failure
to have occured.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/process.c |   65 ++++++++++++++++++++++++++++++------------------
 1 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 4322155..711ac1a 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -40,11 +40,9 @@
 #define freezer_message(msg, a...) do { } while(0)
 #endif
 
-/* 
- * Timeout for stopping processes
- */
-#define TIMEOUT	(6 * HZ)
-
+/* Timeouts when freezing */
+#define FREEZER_TOTAL_TIMEOUT (5 * HZ)
+#define FREEZER_CHECK_TIMEOUT (HZ / 10)
 
 DECLARE_COMPLETION(kernelspace_thaw);
 DECLARE_COMPLETION(userspace_thaw);
@@ -338,30 +336,49 @@ static int freezer_failure(int do_all_th
 	return result;
 }
 
-static inline void freeze(struct task_struct *p)
+/*
+ * freeze_threads
+ *
+ * Freeze a set of threads having particular attributes.
+ *
+ * Types:
+ * 2: User threads.
+ * 3: Kernel threads.
+ */
+static int freeze_threads(int do_all_threads)
 {
-	unsigned long flags;
+	int result = 0, still_to_do;
+	unsigned long start_time = jiffies;
+
+	if (do_all_threads)	
+		freezer_make_fses_ro();
+
+	signal_threads(do_all_threads);
+
+	/* Watch them do it, wake them if they ignore us. */
+	do {
+		prod_processes(do_all_threads);
+
+		set_task_state(current, TASK_INTERRUPTIBLE);
+		schedule_timeout(FREEZER_CHECK_TIMEOUT);
+
+		still_to_do = num_freezeable(do_all_threads) - 
+			num_uninterruptible(do_all_threads);
+
+	} while(still_to_do && (!test_freezer_state(ABORT_FREEZING)) &&
+		!time_after(jiffies, start_time + FREEZER_TOTAL_TIMEOUT));
 
 	/*
-	 * We only freeze if the todo list is empty to avoid
-	 * putting multiple freeze handlers on the todo list.
+	 * Did we time out? See if we failed to freeze processes as well.
+	 *
 	 */
-	if (!p->todo) {
-		struct notifier_block *n;
+	if ((time_after(jiffies, start_time + FREEZER_TOTAL_TIMEOUT))
+			&& (still_to_do))
+		result = freezer_failure(do_all_threads);
 
-		n = kmalloc(sizeof(struct notifier_block),
-					GFP_ATOMIC);
-		if (n) {
-			n->notifier_call = freeze_process;
-			n->priority = 0;
-			notifier_chain_register(&p->todo, n);
-		}
- 	}
-	/* Make the process work on its todo list */
-	spin_lock_irqsave(&p->sighand->siglock, flags);
-	recalc_sigpending();
-	signal_wake_up(p, 0);
-	spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	BUG_ON(in_atomic());
+	
+	return 0; 
 }
 
 /* 0 = success, else # of processes that we failed to stop */

--
Nigel Cunningham		nigel at suspend2 dot net
