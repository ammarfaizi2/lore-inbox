Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVAQFvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVAQFvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 00:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVAQFvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 00:51:16 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:16554 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262701AbVAQFuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 00:50:50 -0500
Date: Sun, 16 Jan 2005 21:50:44 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: cw@f00f.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Horrible regression with -CURRENT from "Don't busy-lock-loop in preemptable spinlocks" patch
Message-ID: <20050117055044.GA3514@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The change below is causing major problems for me on a dual K7 with
CONFIG_PREEMPT enabled (cset -x and rebuilding makes the machine
usable again).

This change was merged a couple of days ago so I'm surprised nobody
else has reported this.  I tried to find where this patch came from
but I don't see it on lkml only the bk history.

Note, even with this removed I'm still seeing a few (many actually)
"BUG: using smp_processor_id() in preemptible [00000001] code: xxx"
messages which I've not seen before --- that might be unrelated but I
do see *many* such messages so I'm sure I would have noticed this
before or it would have broken something earlier.

Is this specific to the k7 or do other people also see this?



Thanks,

  --cw

---

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/15 09:40:45-08:00 mingo@elte.hu 
#   [PATCH] Don't busy-lock-loop in preemptable spinlocks
#   
#   Paul Mackerras points out that doing the _raw_spin_trylock each time
#   through the loop will generate tons of unnecessary bus traffic.
#   Instead, after we fail to get the lock we should poll it with simple
#   loads until we see that it is clear and then retry the atomic op. 
#   Assuming a reasonable cache design, the loads won't generate any bus
#   traffic until another cpu writes to the cacheline containing the lock.
#   
#   Agreed.
#   
#   Signed-off-by: Ingo Molnar <mingo@elte.hu>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
# kernel/spinlock.c
#   2005/01/14 16:00:00-08:00 mingo@elte.hu +8 -6
#   Don't busy-lock-loop in preemptable spinlocks
# 
diff -Nru a/kernel/spinlock.c b/kernel/spinlock.c
--- a/kernel/spinlock.c	2005-01-16 21:43:15 -08:00
+++ b/kernel/spinlock.c	2005-01-16 21:43:15 -08:00
@@ -173,7 +173,7 @@
  * (We do this in a function because inlining it would be excessive.)
  */
 
-#define BUILD_LOCK_OPS(op, locktype)					\
+#define BUILD_LOCK_OPS(op, locktype, is_locked_fn)			\
 void __lockfunc _##op##_lock(locktype *lock)				\
 {									\
 	preempt_disable();						\
@@ -183,7 +183,8 @@
 		preempt_enable();					\
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
-		cpu_relax();						\
+		while (is_locked_fn(lock) && (lock)->break_lock)	\
+			cpu_relax();					\
 		preempt_disable();					\
 	}								\
 }									\
@@ -204,7 +205,8 @@
 		preempt_enable();					\
 		if (!(lock)->break_lock)				\
 			(lock)->break_lock = 1;				\
-		cpu_relax();						\
+		while (is_locked_fn(lock) && (lock)->break_lock)	\
+			cpu_relax();					\
 		preempt_disable();					\
 	}								\
 	return flags;							\
@@ -244,9 +246,9 @@
  *         _[spin|read|write]_lock_irqsave()
  *         _[spin|read|write]_lock_bh()
  */
-BUILD_LOCK_OPS(spin, spinlock_t);
-BUILD_LOCK_OPS(read, rwlock_t);
-BUILD_LOCK_OPS(write, rwlock_t);
+BUILD_LOCK_OPS(spin, spinlock_t, spin_is_locked);
+BUILD_LOCK_OPS(read, rwlock_t, rwlock_is_locked);
+BUILD_LOCK_OPS(write, rwlock_t, spin_is_locked);
 
 #endif /* CONFIG_PREEMPT */
 
