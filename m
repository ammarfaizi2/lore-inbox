Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWE2Vff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWE2Vff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWE2VfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:35:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:13523 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751363AbWE2V0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:26:01 -0400
Date: Mon, 29 May 2006 23:26:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 40/61] lock validator: special locking: futex
Message-ID: <20060529212621.GN3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 kernel/futex.c |   44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

Index: linux/kernel/futex.c
===================================================================
--- linux.orig/kernel/futex.c
+++ linux/kernel/futex.c
@@ -604,6 +604,22 @@ static int unlock_futex_pi(u32 __user *u
 }
 
 /*
+ * Express the locking dependencies for lockdep:
+ */
+static inline void
+double_lock_hb(struct futex_hash_bucket *hb1, struct futex_hash_bucket *hb2)
+{
+	if (hb1 <= hb2) {
+		spin_lock(&hb1->lock);
+		if (hb1 < hb2)
+			spin_lock_nested(&hb2->lock, SINGLE_DEPTH_NESTING);
+	} else { /* hb1 > hb2 */
+		spin_lock(&hb2->lock);
+		spin_lock_nested(&hb1->lock, SINGLE_DEPTH_NESTING);
+	}
+}
+
+/*
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
  */
@@ -669,19 +685,15 @@ retryfull:
 	hb2 = hash_futex(&key2);
 
 retry:
-	if (hb1 < hb2)
-		spin_lock(&hb1->lock);
-	spin_lock(&hb2->lock);
-	if (hb1 > hb2)
-		spin_lock(&hb1->lock);
+	double_lock_hb(hb1, hb2);
 
 	op_ret = futex_atomic_op_inuser(op, uaddr2);
 	if (unlikely(op_ret < 0)) {
 		u32 dummy;
 
-		spin_unlock(&hb1->lock);
+		spin_unlock_non_nested(&hb1->lock);
 		if (hb1 != hb2)
-			spin_unlock(&hb2->lock);
+			spin_unlock_non_nested(&hb2->lock);
 
 #ifndef CONFIG_MMU
 		/*
@@ -748,9 +760,9 @@ retry:
 		ret += op_ret;
 	}
 
-	spin_unlock(&hb1->lock);
+	spin_unlock_non_nested(&hb1->lock);
 	if (hb1 != hb2)
-		spin_unlock(&hb2->lock);
+		spin_unlock_non_nested(&hb2->lock);
 out:
 	up_read(&current->mm->mmap_sem);
 	return ret;
@@ -782,11 +794,7 @@ static int futex_requeue(u32 __user *uad
 	hb1 = hash_futex(&key1);
 	hb2 = hash_futex(&key2);
 
-	if (hb1 < hb2)
-		spin_lock(&hb1->lock);
-	spin_lock(&hb2->lock);
-	if (hb1 > hb2)
-		spin_lock(&hb1->lock);
+	double_lock_hb(hb1, hb2);
 
 	if (likely(cmpval != NULL)) {
 		u32 curval;
@@ -794,9 +802,9 @@ static int futex_requeue(u32 __user *uad
 		ret = get_futex_value_locked(&curval, uaddr1);
 
 		if (unlikely(ret)) {
-			spin_unlock(&hb1->lock);
+			spin_unlock_non_nested(&hb1->lock);
 			if (hb1 != hb2)
-				spin_unlock(&hb2->lock);
+				spin_unlock_non_nested(&hb2->lock);
 
 			/*
 			 * If we would have faulted, release mmap_sem, fault
@@ -842,9 +850,9 @@ static int futex_requeue(u32 __user *uad
 	}
 
 out_unlock:
-	spin_unlock(&hb1->lock);
+	spin_unlock_non_nested(&hb1->lock);
 	if (hb1 != hb2)
-		spin_unlock(&hb2->lock);
+		spin_unlock_non_nested(&hb2->lock);
 
 	/* drop_key_refs() must be called outside the spinlocks. */
 	while (--drop_count >= 0)
