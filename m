Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992595AbWJTMGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992595AbWJTMGj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992597AbWJTMGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:06:39 -0400
Received: from poczta.o2.pl ([193.17.41.142]:55168 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S2992595AbWJTMGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:06:38 -0400
Date: Fri, 20 Oct 2006 14:11:45 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: [PATCH 2.6.19-rc2-git3][REVISED] lockdep: internal locking fixes
Message-ID: <20061020121145.GA3922@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	linux-kernel@vger.kernel.org, mingo@elte.hu
References: <20061020061234.GA1898@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020061234.GA1898@ff.dom.local>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 08:12:34AM +0200, Jarek Poplawski wrote:
>Hello,
...

Sorry - one more fix!

Here are mainly some lockdep returns with 0 with unlocking fixes. 

Best regards,
Jarek P.

PS: if there will be any questions after 3PM EST
I'll be back on monday. 


Signed-off-by: Jarek Poplawski <jarkao2@o2.pl>
---

diff -Nurp linux-2.6.19-rc2-git3-/kernel/lockdep.c linux-2.6.19-rc2-git3/kernel/lockdep.c
--- linux-2.6.19-rc2-git3-/kernel/lockdep.c	2006-10-19 18:41:00.000000000 +0200
+++ linux-2.6.19-rc2-git3/kernel/lockdep.c	2006-10-20 13:59:14.000000000 +0200
@@ -227,9 +227,9 @@ static int save_trace(struct stack_trace
 
 	trace->skip = 3;
 	trace->all_contexts = 0;
-
-	/* Make sure to not recurse in case the the unwinder needs to tak
-e	   locks. */
+	/*
+	 * Make sure to not recurse in case the unwinder needs to take locks.
+	 */
 	lockdep_off();
 	save_stack_trace(trace, NULL);
 	lockdep_on();
@@ -237,8 +237,10 @@ e	   locks. */
 	trace->max_entries = trace->nr_entries;
 
 	nr_stack_trace_entries += trace->nr_entries;
-	if (DEBUG_LOCKS_WARN_ON(nr_stack_trace_entries > MAX_STACK_TRACE_ENTRIES))
+	if (DEBUG_LOCKS_WARN_ON(nr_stack_trace_entries > MAX_STACK_TRACE_ENTRIES)) {
+		__raw_spin_unlock(&hash_lock);
 		return 0;
+	}
 
 	if (nr_stack_trace_entries == MAX_STACK_TRACE_ENTRIES) {
 		__raw_spin_unlock(&hash_lock);
@@ -474,7 +476,8 @@ static int add_lock_to_list(struct lock_
 		return 0;
 
 	entry->class = this;
-	save_trace(&entry->trace);
+	if (!save_trace(&entry->trace))
+		return 0;
 
 	/*
 	 * Since we never remove from the dependency list, the list can
@@ -562,8 +565,12 @@ static noinline int print_circular_bug_t
 	if (debug_locks_silent)
 		return 0;
 
+	/* hash_lock unlocked by the header */
+	__raw_spin_lock(&hash_lock);
 	this.class = check_source->class;
-	save_trace(&this.trace);
+	if (!save_trace(&this.trace))
+		return 0;
+	__raw_spin_unlock(&hash_lock);
 	print_circular_bug_entry(&this, 0);
 
 	printk("\nother info that might help us debug this:\n\n");
@@ -959,6 +966,9 @@ check_prev_add(struct task_struct *curr,
 	}
 
 	/*
+	 * Return value of 2 signals 'dependency already added',
+	 * in that case we dont have to add the backlink either.
+	 *
 	 * Ok, all validations passed, add the new lock
 	 * to the previous lock's dependency list:
 	 */
@@ -966,15 +976,10 @@ check_prev_add(struct task_struct *curr,
 			       &prev->class->locks_after, next->acquire_ip);
 	if (!ret)
 		return 0;
-	/*
-	 * Return value of 2 signals 'dependency already added',
-	 * in that case we dont have to add the backlink either.
-	 */
-	if (ret == 2)
-		return 2;
 	ret = add_lock_to_list(next->class, prev->class,
 			       &next->class->locks_before, next->acquire_ip);
-
+	if (!ret)
+		return 0;
 	/*
 	 * Debugging printouts:
 	 */
