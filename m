Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263593AbTIBHv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 03:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263601AbTIBHv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 03:51:57 -0400
Received: from dukat.upl.cs.wisc.edu ([128.105.45.39]:37265 "EHLO
	dukat.upl.cs.wisc.edu") by vger.kernel.org with ESMTP
	id S263593AbTIBHvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 03:51:46 -0400
Date: Tue, 2 Sep 2003 02:51:45 -0500
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] might_sleep() improvements
Message-ID: <20030902075145.GA12817@sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew - I thought this might be appropriate for -mm kernels.

This patch makes the following improvements to might_sleep():

 o Add a "might_sleep_if()" macro for when we might sleep only if some
   condition is met.  I think this is a bit better than the currently used
   "if (cond) might_sleep();" since it's clearer that the test won't be
   compiled in if spinlock sleep debugging is turned off.  (Obviously
   gcc is smart enough to omit simple conditions in that case)  It also
   looks cleaner, IMO.  Think of it as analogous to BUG()/BUG_ON().

 o Add might_sleep checks to skb_share_check() and skb_unshare() which
   sometimes need to allocate memory.

 o Make all architectures call might_sleep() in both down() and
   down_interruptible().  Before only ppc, ppc64, and i386 did this check.
   (sh did the check on down() but not down_interruptible())

Patch is versus 2.6.0-test4, hopefully it still applies cleanly.

-Mitch

diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/arch/sparc64/kernel/semaphore.c linux-2.6.0-test4mightsleep/arch/sparc64/kernel/semaphore.c
--- linux-2.6.0-test4-VIRGIN/arch/sparc64/kernel/semaphore.c	2003-07-13 20:37:13.000000000 -0700
+++ linux-2.6.0-test4mightsleep/arch/sparc64/kernel/semaphore.c	2003-09-01 13:38:18.000000000 -0700
@@ -110,6 +110,7 @@
 
 void down(struct semaphore *sem)
 {
+	might_sleep();
 	/* This atomically does:
 	 * 	old_val = sem->count;
 	 *	new_val = sem->count - 1;
@@ -219,6 +220,7 @@
 {
 	int ret = 0;
 	
+	might_sleep();
 	/* This atomically does:
 	 * 	old_val = sem->count;
 	 *	new_val = sem->count - 1;
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-alpha/semaphore.h linux-2.6.0-test4mightsleep/include/asm-alpha/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-alpha/semaphore.h	2003-07-13 20:37:17.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-alpha/semaphore.h	2003-09-01 13:28:36.000000000 -0700
@@ -88,14 +88,18 @@
 
 static inline void __down(struct semaphore *sem)
 {
-	long count = atomic_dec_return(&sem->count);
+	long count;
+	might_sleep();
+	count = atomic_dec_return(&sem->count);
 	if (unlikely(count < 0))
 		__down_failed(sem);
 }
 
 static inline int __down_interruptible(struct semaphore *sem)
 {
-	long count = atomic_dec_return(&sem->count);
+	long count;
+	might_sleep();
+	count = atomic_dec_return(&sem->count);
 	if (unlikely(count < 0))
 		return __down_failed_interruptible(sem);
 	return 0;
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-arm/semaphore.h linux-2.6.0-test4mightsleep/include/asm-arm/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-arm/semaphore.h	2003-07-13 20:34:31.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-arm/semaphore.h	2003-09-01 13:29:33.000000000 -0700
@@ -88,7 +88,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	__down_op(sem, __down_failed);
 }
 
@@ -101,7 +101,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	return __down_op_ret(sem, __down_interruptible_failed);
 }
 
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-arm26/semaphore.h linux-2.6.0-test4mightsleep/include/asm-arm26/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-arm26/semaphore.h	2003-07-13 20:38:51.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-arm26/semaphore.h	2003-09-01 13:29:04.000000000 -0700
@@ -84,7 +84,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	__down_op(sem, __down_failed);
 }
 
@@ -97,7 +97,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	return __down_op_ret(sem, __down_interruptible_failed);
 }
 
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-cris/semaphore.h linux-2.6.0-test4mightsleep/include/asm-cris/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-cris/semaphore.h	2003-07-13 20:32:42.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-cris/semaphore.h	2003-09-01 13:30:37.000000000 -0700
@@ -79,6 +79,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
+	might_sleep();
 
 	/* atomically decrement the semaphores count, and if its negative, we wait */
 	local_save_flags(flags);
@@ -104,6 +105,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
+	might_sleep();
 
 	/* atomically decrement the semaphores count, and if its negative, we wait */
 	local_save_flags(flags);
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-h8300/semaphore.h linux-2.6.0-test4mightsleep/include/asm-h8300/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-h8300/semaphore.h	2003-08-22 13:47:25.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-h8300/semaphore.h	2003-09-01 13:30:59.000000000 -0700
@@ -90,6 +90,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
+	might_sleep();
 
 	count = &(sem->count);
 	__asm__ __volatile__(
@@ -117,6 +118,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
+	might_sleep();
 
 	count = &(sem->count);
 	__asm__ __volatile__(
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-ia64/semaphore.h linux-2.6.0-test4mightsleep/include/asm-ia64/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-ia64/semaphore.h	2003-07-13 20:33:51.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-ia64/semaphore.h	2003-09-01 13:31:25.000000000 -0700
@@ -73,6 +73,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
+	might_sleep();
 	if (atomic_dec_return(&sem->count) < 0)
 		__down(sem);
 }
@@ -89,6 +90,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
+	might_sleep();
 	if (atomic_dec_return(&sem->count) < 0)
 		ret = __down_interruptible(sem);
 	return ret;
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-m68k/semaphore.h linux-2.6.0-test4mightsleep/include/asm-m68k/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-m68k/semaphore.h	2003-07-13 20:39:22.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-m68k/semaphore.h	2003-09-01 13:32:01.000000000 -0700
@@ -89,7 +89,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	__asm__ __volatile__(
 		"| atomic down operation\n\t"
 		"subql #1,%0@\n\t"
@@ -112,7 +112,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	__asm__ __volatile__(
 		"| atomic interruptible down operation\n\t"
 		"subql #1,%1@\n\t"
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-m68knommu/semaphore.h linux-2.6.0-test4mightsleep/include/asm-m68knommu/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-m68knommu/semaphore.h	2003-07-13 20:35:14.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-m68knommu/semaphore.h	2003-09-01 13:31:46.000000000 -0700
@@ -88,7 +88,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	__asm__ __volatile__(
 		"| atomic down operation\n\t"
 		"movel	%0, %%a1\n\t"
@@ -108,7 +108,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	__asm__ __volatile__(
 		"| atomic down operation\n\t"
 		"movel	%1, %%a1\n\t"
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-mips/semaphore.h linux-2.6.0-test4mightsleep/include/asm-mips/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-mips/semaphore.h	2003-07-13 20:33:10.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-mips/semaphore.h	2003-09-01 13:32:26.000000000 -0700
@@ -88,6 +88,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
+	might_sleep();
 	if (atomic_dec_return(&sem->count) < 0)
 		__down(sem);
 }
@@ -103,6 +104,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
+	might_sleep();
 	if (atomic_dec_return(&sem->count) < 0)
 		ret = __down_interruptible(sem);
 	return ret;
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-parisc/semaphore.h linux-2.6.0-test4mightsleep/include/asm-parisc/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-parisc/semaphore.h	2003-07-13 20:28:54.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-parisc/semaphore.h	2003-09-01 13:32:42.000000000 -0700
@@ -84,7 +84,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	spin_lock_irq(&sem->sentry);
 	if (sem->count > 0) {
 		sem->count--;
@@ -100,7 +100,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
-
+	might_sleep();
 	spin_lock_irq(&sem->sentry);
 	if (sem->count > 0) {
 		sem->count--;
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-s390/semaphore.h linux-2.6.0-test4mightsleep/include/asm-s390/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-s390/semaphore.h	2003-07-13 20:28:53.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-s390/semaphore.h	2003-09-01 13:33:06.000000000 -0700
@@ -60,6 +60,7 @@
 
 static inline void down(struct semaphore * sem)
 {
+	might_sleep();
 	if (atomic_dec_return(&sem->count) < 0)
 		__down(sem);
 }
@@ -68,6 +69,7 @@
 {
 	int ret = 0;
 
+	might_sleep();
 	if (atomic_dec_return(&sem->count) < 0)
 		ret = __down_interruptible(sem);
 	return ret;
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-sh/semaphore.h linux-2.6.0-test4mightsleep/include/asm-sh/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-sh/semaphore.h	2003-07-13 20:38:51.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-sh/semaphore.h	2003-09-01 13:15:52.000000000 -0700
@@ -107,6 +107,7 @@
 	CHECK_MAGIC(sem->__magic);
 #endif
 
+	might_sleep();
 	if (atomic_dec_return(&sem->count) < 0)
 		ret = __down_interruptible(sem);
 	return ret;
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-sparc/semaphore.h linux-2.6.0-test4mightsleep/include/asm-sparc/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-sparc/semaphore.h	2003-07-13 20:39:21.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-sparc/semaphore.h	2003-09-01 13:34:21.000000000 -0700
@@ -71,6 +71,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
+	might_sleep();
 
 	ptr = &(sem->count.counter);
 	increment = 1;
@@ -107,6 +108,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
+	might_sleep();
 
 	ptr = &(sem->count.counter);
 	increment = 1;
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-v850/semaphore.h linux-2.6.0-test4mightsleep/include/asm-v850/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-v850/semaphore.h	2003-07-13 20:33:12.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-v850/semaphore.h	2003-09-01 13:34:52.000000000 -0700
@@ -57,6 +57,7 @@
 
 extern inline void down (struct semaphore * sem)
 {
+	might_sleep();
 	if (atomic_dec_return (&sem->count) < 0)
 		__down (sem);
 }
@@ -64,6 +65,7 @@
 extern inline int down_interruptible (struct semaphore * sem)
 {
 	int ret = 0;
+	might_sleep();
 	if (atomic_dec_return (&sem->count) < 0)
 		ret = __down_interruptible (sem);
 	return ret;
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/asm-x86_64/semaphore.h linux-2.6.0-test4mightsleep/include/asm-x86_64/semaphore.h
--- linux-2.6.0-test4-VIRGIN/include/asm-x86_64/semaphore.h	2003-07-13 20:28:54.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/asm-x86_64/semaphore.h	2003-09-01 13:35:12.000000000 -0700
@@ -118,6 +118,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
+	might_sleep();
 
 	__asm__ __volatile__(
 		"# atomic down operation\n\t"
@@ -144,6 +145,7 @@
 #if WAITQUEUE_DEBUG
 	CHECK_MAGIC(sem->__magic);
 #endif
+	might_sleep();
 
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/linux/kernel.h linux-2.6.0-test4mightsleep/include/linux/kernel.h
--- linux-2.6.0-test4-VIRGIN/include/linux/kernel.h	2003-07-13 20:28:53.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/linux/kernel.h	2003-09-01 13:07:59.000000000 -0700
@@ -52,8 +52,10 @@
 #ifdef CONFIG_DEBUG_SPINLOCK_SLEEP
 void __might_sleep(char *file, int line);
 #define might_sleep() __might_sleep(__FILE__, __LINE__)
+#define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
 #else
 #define might_sleep() do {} while(0)
+#define might_sleep_if(cond) do {} while (0)
 #endif
 
 extern struct notifier_block *panic_notifier_list;
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/include/linux/skbuff.h linux-2.6.0-test4mightsleep/include/linux/skbuff.h
--- linux-2.6.0-test4-VIRGIN/include/linux/skbuff.h	2003-08-10 05:28:41.000000000 -0700
+++ linux-2.6.0-test4mightsleep/include/linux/skbuff.h	2003-09-01 13:26:55.000000000 -0700
@@ -389,6 +389,7 @@
  */
 static inline struct sk_buff *skb_share_check(struct sk_buff *skb, int pri)
 {
+	might_sleep_if(pri != GFP_ATOMIC);
 	if (skb_shared(skb)) {
 		struct sk_buff *nskb = skb_clone(skb, pri);
 		kfree_skb(skb);
@@ -419,6 +420,7 @@
  */
 static inline struct sk_buff *skb_unshare(struct sk_buff *skb, int pri)
 {
+	might_sleep_if(pri != GFP_ATOMIC);
 	if (skb_cloned(skb)) {
 		struct sk_buff *nskb = skb_copy(skb, pri);
 		kfree_skb(skb);	/* Free our shared copy */
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/mm/page_alloc.c linux-2.6.0-test4mightsleep/mm/page_alloc.c
--- linux-2.6.0-test4-VIRGIN/mm/page_alloc.c	2003-08-22 13:47:28.000000000 -0700
+++ linux-2.6.0-test4mightsleep/mm/page_alloc.c	2003-09-01 13:16:42.000000000 -0700
@@ -542,8 +542,7 @@
 	int do_retry;
 	struct reclaim_state reclaim_state;
 
-	if (wait)
-		might_sleep();
+	might_sleep_if(wait);
 
 	cold = 0;
 	if (gfp_mask & __GFP_COLD)
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/mm/rmap.c linux-2.6.0-test4mightsleep/mm/rmap.c
--- linux-2.6.0-test4-VIRGIN/mm/rmap.c	2003-07-13 20:38:02.000000000 -0700
+++ linux-2.6.0-test4mightsleep/mm/rmap.c	2003-09-01 13:17:19.000000000 -0700
@@ -503,8 +503,7 @@
 	struct pte_chain *ret;
 	struct pte_chain **pte_chainp;
 
-	if (gfp_flags & __GFP_WAIT)
-		might_sleep();
+	might_sleep_if(gfp_flags & __GFP_WAIT);
 
 	pte_chainp = &get_cpu_var(local_pte_chain);
 	if (*pte_chainp) {
diff -urN -X dontdiff linux-2.6.0-test4-VIRGIN/mm/slab.c linux-2.6.0-test4mightsleep/mm/slab.c
--- linux-2.6.0-test4-VIRGIN/mm/slab.c	2003-08-22 13:47:28.000000000 -0700
+++ linux-2.6.0-test4mightsleep/mm/slab.c	2003-09-01 13:17:01.000000000 -0700
@@ -1813,8 +1813,7 @@
 static inline void
 cache_alloc_debugcheck_before(kmem_cache_t *cachep, int flags)
 {
-	if (flags & __GFP_WAIT)
-		might_sleep();
+	might_sleep_if(flags & __GFP_WAIT);
 #if DEBUG
 	kmem_flagcheck(cachep, flags);
 #endif
