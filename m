Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWEQVIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWEQVIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 17:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWEQVIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 17:08:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:53399 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751128AbWEQVIw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 17:08:52 -0400
Subject: [RFC][-rt PATCH] Try to safely error out when mixing pi/non-pi
	futex operations on the same futex.
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       mingo@redhat.com, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 17 May 2006 14:08:49 -0700
Message-Id: <1147900129.9363.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,
	We've been seeing some oopses because there are waiters on pi futexes
that do not have pi_states. This seems to be because they were used w/
futex_wait in one path and futex_lock_pi in another. 

I'm told this shouldn't ever happen, but if it did, the kernel should
safely error out, instead of oopsing or never releasing a lock.

Not sure if this is a solid fix (it does build and boot), but hopefully
it will stir up some discussion.

thanks
-john


Try to handle odd cases where a futex is used w/ both the pi and non-pi methods.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

Index: futex-test/kernel/futex.c
===================================================================
--- futex-test.orig/kernel/futex.c	2006-05-17 13:44:41.000000000 -0500
+++ futex-test/kernel/futex.c	2006-05-17 15:48:45.000000000 -0500
@@ -472,11 +472,17 @@
 
 	list_for_each_entry_safe(this, next, head, list) {
 		if (match_futex (&this->key, &me->key)) {
-			/*
-			 * Another waiter already exists - bump up
-			 * the refcount and return its pi_state:
-			 */
+			/* Another waiter already exists */
 			pi_state = this->pi_state;
+
+			/* make sure its a PI waiter: */
+			if (!pi_state) {
+				printk("BUG: %s/%d: Mixing pi and non pi"
+					" futexes!\n", current->comm,
+						current->pid);
+				return -EINVAL;
+			}
+			/* bump up the refcount and return its pi_state: */
 			atomic_inc(&pi_state->refcount);
 			me->pi_state = pi_state;
 			pr_debug("Waiter found: %d\n",
@@ -638,8 +644,14 @@
 
 	list_for_each_entry_safe(this, next, head, list) {
 		if (match_futex (&this->key, &key)) {
-			if (this->pi_state)
-				return -EINVAL;
+			/* XXX - this might cause odd behavior
+			 * as we may have already woken some futexes
+			 * before we return -EINVAL -johnstul@us.ibm.com
+			 */
+			if (this->pi_state) {
+				ret = -EINVAL;
+				break;
+			}
 			wake_futex(this);
 			if (++ret >= nr_wake)
 				break;
@@ -1200,6 +1212,9 @@
 	ret = lookup_pi_state(uval, hb, &q);
 
 	if (unlikely(ret)) {
+		/* Handle pi/non-pi mixups: */
+		if (ret == -EINVAL)
+			goto out_unlock_release_sem;
 		/*
 		 * There were no waiters and the owner task lookup
 		 * failed. When the OWNER_DIED bit is set, then we


