Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161875AbWI2Tv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161875AbWI2Tv4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161874AbWI2Tv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:51:56 -0400
Received: from rs384.securehostserver.com ([72.22.69.69]:35343 "HELO
	rs384.securehostserver.com") by vger.kernel.org with SMTP
	id S1161873AbWI2Tvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:51:54 -0400
Subject: Re: [RFC][PATCH 2/2] Swap token re-tuned
From: Ashwin Chaugule <ashwin.chaugule@celunite.com>
Reply-To: ashwin.chaugule@celunite.com
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1159557812.13651.23.camel@lappy>
References: <1159556740.2141.24.camel@localhost.localdomain>
	 <1159557812.13651.23.camel@lappy>
Content-Type: text/plain
Date: Sat, 30 Sep 2006 01:21:35 +0530
Message-Id: <1159559495.2141.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 21:23 +0200, Peter Zijlstra wrote:
> On Sat, 2006-09-30 at 00:35 +0530, Ashwin Chaugule wrote:
> > New scheme to preempt token. 
> > 
> /*
>  * multi line comments look like this
>  */
> 


Thanks Peter ! 

Patch with reformatted comments.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@celunite.com>

---

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 34ed0d9..b818fdc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -342,9 +342,20 @@ struct mm_struct {
 	/* Architecture-specific MM context */
 	mm_context_t context;
 
-	/* Token based thrashing protection. */
-	unsigned long swap_token_time;
-	char recent_pagein;
+	/* Swap token stuff */
+	/* 
+	 * Last value of global fault stamp as seen by this process. 
+	 * In other words, this value gives an indication of how long
+	 * it has been since this task got the token 
+	 */
+	unsigned int faultstamp;
+
+       /*
+	* Deciding factor ! 
+	* Incrememt if (global_faults - faultstamp < FAULTSTAMP_DIFF ) 
+        * else decrement. High priority wins the token.
+	*/
+	int token_priority;
 
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
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index fd43c3e..ef52798 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -910,17 +910,6 @@ #ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
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
index f4c560b..e1480c0 100644
--- a/mm/thrash.c
+++ b/mm/thrash.c
@@ -14,83 +14,87 @@ #include <linux/sched.h>
 #include <linux/swap.h>
 
 static DEFINE_SPINLOCK(swap_token_lock);
-static unsigned long swap_token_timeout;
-static unsigned long swap_token_check;
-struct mm_struct * swap_token_mm = &init_mm;
+struct mm_struct * swap_token_mm = NULL;
+unsigned long global_faults = 0;
 
-#define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)
-#define SWAP_TOKEN_TIMEOUT	(300 * HZ)
-/*
- * Currently disabled; Needs further code to work at HZ * 300.
- */
-unsigned long swap_token_default_timeout = SWAP_TOKEN_TIMEOUT;
+#define SWAP_TOKEN_PREEMPT 1
+#define FAULTSTAMP_DIFF 5
 
-/*
- * Take the token away if the process had no page faults
- * in the last interval, or if it has held the token for
- * too long.
- */
-#define SWAP_TOKEN_ENOUGH_RSS 1
-#define SWAP_TOKEN_TIMED_OUT 2
 static int should_release_swap_token(struct mm_struct *mm)
 {
 	int ret = 0;
-	if (!mm->recent_pagein)
-		ret = SWAP_TOKEN_ENOUGH_RSS;
-	else if (time_after(jiffies, swap_token_timeout))
-		ret = SWAP_TOKEN_TIMED_OUT;
-	mm->recent_pagein = 0;
+	if ( current->mm->token_priority > mm->token_priority )
+		ret = SWAP_TOKEN_PREEMPT;
+	
 	return ret;
 }
 
-/*
- * Try to grab the swapout protection token.  We only try to
- * grab it once every TOKEN_CHECK_INTERVAL, both to prevent
- * SMP lock contention and to check that the process that held
- * the token before is no longer thrashing.
- */
 void grab_swap_token(void)
 {
-	struct mm_struct *mm;
+	struct mm_struct *mm_temp;
 	int reason;
 
-	/* We have the token. Let others know we still need it. */
-	if (has_swap_token(current->mm)) {
-		current->mm->recent_pagein = 1;
-		if (unlikely(!swap_token_default_timeout))
-			disable_swap_token();
+	/* 
+	 * This gives an indication of the number of processes 
+	 * contending for the token.
+	 */
+	
+	global_faults++; 
+
+	if (!spin_trylock(&swap_token_lock))
 		return;
-	}
 
-	if (time_after(jiffies, swap_token_check)) {
+	/*
+	 * First come first served. If a process holding the 
+	 * token exits, its up for grabs immediately 
+	 */
+	
+	if ( swap_token_mm == NULL ) {
+		swap_token_mm = current->mm;
+		swap_token_mm->faultstamp = global_faults;
+		goto out;
+	}
 
-		if (!swap_token_default_timeout) {
-			swap_token_check = jiffies + SWAP_TOKEN_CHECK_INTERVAL;
-			return;
-		}
+	if ((global_faults - current->mm->faultstamp) < FAULTSTAMP_DIFF )  {
 
-		/* ... or if we recently held the token. */
-		if (time_before(jiffies, current->mm->swap_token_time))
-			return;
+	/*
+	 * This would mean that too many of the current tasks pages
+	 * have been evicted and therefore it's calling swap-in or no-page 
+	 * too frequently. 
+	 */
 
-		if (!spin_trylock(&swap_token_lock))
-			return;
+		current->mm->faultstamp = global_faults;
+		current->mm->token_priority++;
+		mm_temp = swap_token_mm;
+	}
+	else {
+	/*
+	 * Decrement priority to ensure that the token holder doesnt
+	 * hold on to it for too long. 
+	 */
 
-		swap_token_check = jiffies + SWAP_TOKEN_CHECK_INTERVAL;
+		if (current->mm->token_priority > 0)
+			current->mm->token_priority--;
+		else {
+	/*
+	 * After this, the process will be able to contend for the token 
+	 * again.
+	 */
 
-		mm = swap_token_mm;
-		if ((reason = should_release_swap_token(mm))) {
-			unsigned long eligible = jiffies;
-			if (reason == SWAP_TOKEN_TIMED_OUT) {
-				eligible += swap_token_default_timeout;
-			}
-			mm->swap_token_time = eligible;
-			swap_token_timeout = jiffies + swap_token_default_timeout;
-			swap_token_mm = current->mm;
+			current->mm->token_priority = 0;
+			current->mm->faultstamp = global_faults;
 		}
-		spin_unlock(&swap_token_lock);
+		goto out;
 	}
-	return;
+
+	if ((reason = should_release_swap_token(mm_temp))) {
+		current->mm->faultstamp = global_faults;
+		swap_token_mm = current->mm;
+	}
+
+out:
+	spin_unlock(&swap_token_lock);
+return;
 }
 
 /* Called on process exit. */
@@ -98,9 +102,7 @@ void __put_swap_token(struct mm_struct *
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

---

