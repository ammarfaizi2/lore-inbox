Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWJHU26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWJHU26 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 16:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWJHU26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 16:28:58 -0400
Received: from rs384.securehostserver.com ([72.22.69.69]:45838 "HELO
	rs384.securehostserver.com") by vger.kernel.org with SMTP
	id S1751460AbWJHU25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 16:28:57 -0400
Subject: [RFC][PATCH 2/2] new scheme to preempt swap token
From: Ashwin Chaugule <ashwin.chaugule@celunite.com>
Reply-To: ashwin.chaugule@celunite.com
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <20061002005905.a97a7b90.akpm@osdl.org>
References: <1159555312.2141.13.camel@localhost.localdomain>
	 <20061001155608.0a464d4c.akpm@osdl.org> <1159774552.13651.80.camel@lappy>
	 <20061002005905.a97a7b90.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 01:58:49 +0530
Message-Id: <1160339330.17751.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 00:59 -0700, Andrew Morton wrote:
> On Mon, 02 Oct 2006 09:35:52 +0200
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> It's just thrashing too much to bother optimising for.  Obviously we want
> it to terminate in a sane period of time and we'd _like_ to improve it. 
> But I think we'd accept a 10% slowdown in this region of operation if it
> gave us a 10% speedup in the 25%-utilisation region.
> 
> IOW: does the patch help mem=96M;make -j5??
> 
> > 
> > Tasks owning the swap token will retain their pages and will hence swap
> > less, other (contending) tasks will get less pages and will fault more
> > frequent. This prio mechanism will favour exactly those tasks not
> > holding the token. Which makes for token bouncing.


This algo should take care of it. 
Each task has a priority which is incremented if it contended
for the token in an interval less than its previous attempt.
If the token is acquired, that task's priority is boosted to prevent
the token from bouncing around too often and to let the task make 
some progress in its execution.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@celunite.com>

--
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 34ed0d9..c4bb78b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -342,9 +342,16 @@ struct mm_struct {
 	/* Architecture-specific MM context */
 	mm_context_t context;
 
-	/* Token based thrashing protection. */
-	unsigned long swap_token_time;
-	char recent_pagein;
+	/* Swap token stuff */
+	/*
+	 * Last value of global fault stamp as seen by this process. 
+	 * In other words, this value gives an indication of how long
+	 * it has been since this task got the token.
+	 * Look at mm/thrash.c
+	 */
+	unsigned int faultstamp;
+	unsigned int token_priority;
+	unsigned int last_interval;
 
 	/* coredumping support */
 	int core_waiters;
diff --git a/include/linux/swap.h b/include/linux/swap.h
index e7c36ba..89f8a39 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -259,7 +259,6 @@ extern spinlock_t swap_lock;
 
 /* linux/mm/thrash.c */
 extern struct mm_struct * swap_token_mm;
-extern unsigned long swap_token_default_timeout;
 extern void grab_swap_token(void);
 extern void __put_swap_token(struct mm_struct *);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index f9b014e..c4b19b3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -470,6 +470,10 @@ static struct mm_struct *dup_mm(struct t
 
 	memcpy(mm, oldmm, sizeof(*mm));
 
+	/* Initializing for Swap token stuff */
+	mm->token_priority = 0;
+	mm->last_interval = 0;
+
 	if (!mm_init(mm))
 		goto fail_nomem;
 
@@ -532,7 +536,11 @@ static int copy_mm(unsigned long clone_f
 	if (!mm)
 		goto fail_nomem;
 
-good_mm:
+good_mm:	
+	/* Initializing for Swap token stuff */
+	mm->token_priority = 0;
+	mm->last_interval = 0;
+	
 	tsk->mm = mm;
 	tsk->active_mm = mm;
 	return 0;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index fd43c3e..ef52798 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -910,17 +910,6 @@ static ctl_table vm_table[] = {
 		.extra1		= &zero,
 	},
 #endif
-#ifdef CONFIG_SWAP
-	{
-		.ctl_name	= VM_SWAP_TOKEN_TIMEOUT,
-		.procname	= "swap_token_timeout",
-		.data		= &swap_token_default_timeout,
-		.maxlen		= sizeof(swap_token_default_timeout),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec_jiffies,
-		.strategy	= &sysctl_jiffies,
-	},
-#endif
 #ifdef CONFIG_NUMA
 	{
 		.ctl_name	= VM_ZONE_RECLAIM_MODE,
diff --git a/mm/thrash.c b/mm/thrash.c
index f4c560b..c0d9cee 100644
--- a/mm/thrash.c
+++ b/mm/thrash.c
@@ -7,90 +7,66 @@
  *
  * Simple token based thrashing protection, using the algorithm
  * described in:  http://www.cs.wm.edu/~sjiang/token.pdf
+ *
+ * Sep 2006, Ashwin Chaugule <ashwin.chaugule@celunite.com>
+ * Improved algorithm to pass token:
+ * Each task has a priority which is incremented if it contended
+ * for the token in an interval less than its previous attempt.
+ * If the token is acquired, that task's priority is boosted to prevent
+ * the token from bouncing around too often and to let the task make 
+ * some progress in its execution.
  */
+
 #include <linux/jiffies.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/swap.h>
 
 static DEFINE_SPINLOCK(swap_token_lock);
-static unsigned long swap_token_timeout;
-static unsigned long swap_token_check;
-struct mm_struct * swap_token_mm = &init_mm;
-
-#define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)
-#define SWAP_TOKEN_TIMEOUT	(300 * HZ)
-/*
- * Currently disabled; Needs further code to work at HZ * 300.
- */
-unsigned long swap_token_default_timeout = SWAP_TOKEN_TIMEOUT;
-
-/*
- * Take the token away if the process had no page faults
- * in the last interval, or if it has held the token for
- * too long.
- */
-#define SWAP_TOKEN_ENOUGH_RSS 1
-#define SWAP_TOKEN_TIMED_OUT 2
-static int should_release_swap_token(struct mm_struct *mm)
-{
-	int ret = 0;
-	if (!mm->recent_pagein)
-		ret = SWAP_TOKEN_ENOUGH_RSS;
-	else if (time_after(jiffies, swap_token_timeout))
-		ret = SWAP_TOKEN_TIMED_OUT;
-	mm->recent_pagein = 0;
-	return ret;
-}
+struct mm_struct * swap_token_mm = NULL;
+unsigned int global_faults = 0;
 
-/*
- * Try to grab the swapout protection token.  We only try to
- * grab it once every TOKEN_CHECK_INTERVAL, both to prevent
- * SMP lock contention and to check that the process that held
- * the token before is no longer thrashing.
- */
 void grab_swap_token(void)
 {
-	struct mm_struct *mm;
-	int reason;
-
-	/* We have the token. Let others know we still need it. */
-	if (has_swap_token(current->mm)) {
-		current->mm->recent_pagein = 1;
-		if (unlikely(!swap_token_default_timeout))
-			disable_swap_token();
+	int current_interval = 0;
+	
+	global_faults++; 
+
+	current_interval = global_faults - current->mm->faultstamp;
+	
+	if (!spin_trylock(&swap_token_lock))
 		return;
-	}
 
-	if (time_after(jiffies, swap_token_check)) {
+	/* First come first served */
+	if (swap_token_mm == NULL) {
+		current->mm->token_priority = current->mm->token_priority + 2;
+		swap_token_mm = current->mm;
+		goto out;
+	}
 
-		if (!swap_token_default_timeout) {
-			swap_token_check = jiffies + SWAP_TOKEN_CHECK_INTERVAL;
-			return;
+	if (current->mm != swap_token_mm) {
+		if (current_interval < current->mm->last_interval) 
+			current->mm->token_priority++;
+		else {
+			current->mm->token_priority--;
+			if (unlikely(current->mm->token_priority < 0))
+				current->mm->token_priority = 0;
 		}
-
-		/* ... or if we recently held the token. */
-		if (time_before(jiffies, current->mm->swap_token_time))
-			return;
-
-		if (!spin_trylock(&swap_token_lock))
-			return;
-
-		swap_token_check = jiffies + SWAP_TOKEN_CHECK_INTERVAL;
-
-		mm = swap_token_mm;
-		if ((reason = should_release_swap_token(mm))) {
-			unsigned long eligible = jiffies;
-			if (reason == SWAP_TOKEN_TIMED_OUT) {
-				eligible += swap_token_default_timeout;
-			}
-			mm->swap_token_time = eligible;
-			swap_token_timeout = jiffies + swap_token_default_timeout;
+		/* Check if we deserve the token */
+		if (current->mm->token_priority > swap_token_mm->token_priority) {
+			current->mm->token_priority = current->mm->token_priority + 2;
 			swap_token_mm = current->mm;
 		}
-		spin_unlock(&swap_token_lock);
 	}
-	return;
+	else
+		/* Token holder came in again! */
+		current->mm->token_priority = current->mm->token_priority + 2;
+
+out:
+	current->mm->faultstamp = global_faults;
+	current->mm->last_interval = current_interval;
+	spin_unlock(&swap_token_lock);
+return;
 }
 
 /* Called on process exit. */
@@ -98,9 +74,7 @@ void __put_swap_token(struct mm_struct *
 {
 	spin_lock(&swap_token_lock);
 	if (likely(mm == swap_token_mm)) {
-		mm->swap_token_time = jiffies + SWAP_TOKEN_CHECK_INTERVAL;
-		swap_token_mm = &init_mm;
-		swap_token_check = jiffies;
+		swap_token_mm = NULL;
 	}
 	spin_unlock(&swap_token_lock);
 }

--

