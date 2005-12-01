Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbVLAADT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbVLAADT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVLAADD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:03:03 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:9379
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751323AbVK3X6b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:31 -0500
Subject: [patch 30/43] ktimeout documentation
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:04:01 +0100
Message-Id: <1133395441.32542.473.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-doc.patch)
- document ktimeouts and fix up existing documentation

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 include/linux/ktimeout.h |   21 ++++---
 kernel/ktimeout.c        |  124 ++++++++++++++++++++++++-----------------------
 2 files changed, 77 insertions(+), 68 deletions(-)

Index: linux/include/linux/ktimeout.h
===================================================================
--- linux.orig/include/linux/ktimeout.h
+++ linux/include/linux/ktimeout.h
@@ -1,3 +1,6 @@
+/*
+ *  Support for kernel-internal timeout events:
+ */
 #ifndef _LINUX_KTIMEOUT_H
 #define _LINUX_KTIMEOUT_H
 
@@ -43,14 +46,14 @@ static inline void setup_ktimeout(struct
 }
 
 /***
- * ktimeout_pending - is a ktimeout pending?
- * @ktimeout: the ktimeout in question
+ * ktimeout_pending - is a timeout pending?
+ * @ktimeout: the timeout in question
  *
- * ktimeout_pending will tell whether a given ktimeout is currently pending,
+ * ktimeout_pending will tell whether a given timeout is currently pending,
  * or not. Callers must ensure serialization wrt. other operations done
- * to this ktimeout, eg. interrupt contexts, or other CPUs on SMP.
+ * to this timeout, eg. interrupt contexts, or other CPUs on SMP.
  *
- * return value: 1 if the ktimeout is pending, 0 if not.
+ * return value: 1 if the timeout is pending, 0 if not.
  */
 static inline int ktimeout_pending(const struct ktimeout * ktimeout)
 {
@@ -66,17 +69,17 @@ extern unsigned long next_ktimeout_inter
 
 /***
  * add_ktimeout - start a ktimeout
- * @ktimeout: the ktimeout to be added
+ * @ktimeout: the timeout to be added
  *
  * The kernel will do a ->function(->data) callback from the
- * ktimeout interrupt at the ->expired point in the future. The
+ * timeout interrupt at the ->expired point in the future. The
  * current time is 'jiffies'.
  *
- * The ktimeout's ->expired, ->function (and if the handler uses it, ->data)
+ * The timeout's ->expired, ->function (and if the handler uses it, ->data)
  * fields must be set prior calling this function.
  *
  * Timers with an ->expired field in the past will be executed in the next
- * ktimeout tick.
+ * timeout tick.
  */
 static inline void add_ktimeout(struct ktimeout *ktimeout)
 {
Index: linux/kernel/ktimeout.c
===================================================================
--- linux.orig/kernel/ktimeout.c
+++ linux/kernel/ktimeout.c
@@ -1,7 +1,12 @@
 /*
  *  linux/kernel/ktimeout.c
  *
- *  Kernel internal timeouts API
+ *  Kernel internal timeouts
+ *
+ *  Timeouts are time events set for the future in where the performance and
+ *  scalability of setting and removing a future event is the most important
+ *  design factor. The actual events are more of an exception (but are still
+ *  handled fast). There is no strict precision or latency guarantee.
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
@@ -97,8 +102,8 @@ static void internal_add_ktimeout(tvec_b
 		vec = base->tv4.vec + i;
 	} else if ((signed long) idx < 0) {
 		/*
-		 * Can happen if you add a ktimeout with expires == jiffies,
-		 * or you set a ktimeout to go off in the past
+		 * Can happen if you add a timeout with expires == jiffies,
+		 * or you set a timeout to go off in the past
 		 */
 		vec = base->tv1.vec + (base->ktimeout_jiffies & TVR_MASK);
 	} else {
@@ -114,14 +119,15 @@ static void internal_add_ktimeout(tvec_b
 		vec = base->tv5.vec + i;
 	}
 	/*
-	 * Timers are FIFO:
+	 * Timeouts are FIFO:
 	 */
 	list_add_tail(&ktimeout->entry, vec);
 }
 
 typedef struct ktimeout_base_s ktimeout_base_t;
+
 /*
- * Used by TIMER_INITIALIZER, we can't use per_cpu(tvec_bases)
+ * Used by KTIMEOUT_INITIALIZER, we can't use per_cpu(tvec_bases)
  * at compile time, and we need ktimeout->base to lock the ktimeout.
  */
 ktimeout_base_t __init_ktimeout_base
@@ -129,11 +135,11 @@ ktimeout_base_t __init_ktimeout_base
 EXPORT_SYMBOL(__init_ktimeout_base);
 
 /***
- * init_ktimeout - initialize a ktimeout.
- * @ktimeout: the ktimeout to be initialized
+ * init_ktimeout - initialize a timeout.
+ * @ktimeout: the timeout to be initialized
  *
- * init_ktimeout() must be done to a ktimeout prior calling *any* of the
- * other ktimeout functions.
+ * init_ktimeout() must be done to a timeout prior calling *any* of the
+ * other timeout functions.
  */
 void fastcall init_ktimeout(struct ktimeout *ktimeout)
 {
@@ -155,14 +161,14 @@ static inline void detach_ktimeout(struc
 
 /*
  * We are using hashed locking: holding per_cpu(tvec_bases).t_base.lock
- * means that all ktimeouts which are tied to this base via ktimeout->base are
+ * means that all timeouts which are tied to this base via ktimeout->base are
  * locked, and the base itself is locked too.
  *
- * So __run_ktimeouts/migrate_ktimeouts can safely modify all ktimeouts which could
- * be found on ->tvX lists.
+ * So __run_ktimeouts/migrate_ktimeouts can safely modify all timeouts which
+ * could be found on ->tvX lists.
  *
- * When the ktimeout's base is locked, and the ktimeout removed from list, it is
- * possible to set ktimeout->base = NULL and drop the lock: the ktimeout remains
+ * When the timeout's base is locked, and the timeout removed from list, it is
+ * possible to set ktimeout->base = NULL and drop the lock: the timeout remains
  * locked.
  */
 static ktimeout_base_t *lock_ktimeout_base(struct ktimeout *ktimeout,
@@ -176,7 +182,7 @@ static ktimeout_base_t *lock_ktimeout_ba
 			spin_lock_irqsave(&base->lock, *flags);
 			if (likely(base == ktimeout->base))
 				return base;
-			/* The ktimeout has migrated to another CPU */
+			/* The timeout has migrated to another CPU */
 			spin_unlock_irqrestore(&base->lock, *flags);
 		}
 		cpu_relax();
@@ -203,14 +209,14 @@ int __mod_ktimeout(struct ktimeout *ktim
 
 	if (base != &new_base->t_base) {
 		/*
-		 * We are trying to schedule the ktimeout on the local CPU.
-		 * However we can't change ktimeout's base while it is running,
-		 * otherwise del_ktimeout_sync() can't detect that the ktimeout's
+		 * We are trying to schedule the timeout on the local CPU.
+		 * However we can't change timeout's base while it is running,
+		 * otherwise del_ktimeout_sync() can't detect that the timeout's
 		 * handler yet has not finished. This also guarantees that
-		 * the ktimeout is serialized wrt itself.
+		 * the timeout is serialized wrt itself.
 		 */
 		if (unlikely(base->running_ktimeout == ktimeout)) {
-			/* The ktimeout remains on a former base */
+			/* The timeout remains on a former base */
 			new_base = container_of(base, tvec_base_t, t_base);
 		} else {
 			/* See the comment in lock_ktimeout_base() */
@@ -231,8 +237,8 @@ int __mod_ktimeout(struct ktimeout *ktim
 EXPORT_SYMBOL(__mod_ktimeout);
 
 /***
- * add_ktimeout_on - start a ktimeout on a particular CPU
- * @ktimeout: the ktimeout to be added
+ * add_ktimeout_on - start a timeout on a particular CPU
+ * @ktimeout: the timeout to be added
  * @cpu: the CPU to start it on
  *
  * This is not very scalable on SMP. Double adds are not possible.
@@ -251,23 +257,23 @@ void add_ktimeout_on(struct ktimeout *kt
 

 /***
- * mod_ktimeout - modify a ktimeout's timeout
- * @ktimeout: the ktimeout to be modified
+ * mod_ktimeout - modify a timeout's interval
+ * @ktimeout: the timeout to be modified
  *
  * mod_ktimeout is a more efficient way to update the expire field of an
- * active ktimeout (if the ktimeout is inactive it will be activated)
+ * active timeout (if the timeout is inactive it will be activated)
  *
  * mod_ktimeout(ktimeout, expires) is equivalent to:
  *
- *     del_ktimeout(ktimeout); ktimeout->expires = expires; add_ktimeout(ktimeout);
+ *  del_ktimeout(ktimeout); ktimeout->expires = expires; add_ktimeout(ktimeout);
  *
- * Note that if there are multiple unserialized concurrent users of the
- * same ktimeout, then mod_ktimeout() is the only safe way to modify the timeout,
+ * Note that if there are multiple unserialized concurrent users of the same
+ * timeout, then mod_ktimeout() is the only safe way to modify the interval,
  * since add_ktimeout() cannot modify an already running ktimeout.
  *
- * The function returns whether it has modified a pending ktimeout or not.
- * (ie. mod_ktimeout() of an inactive ktimeout returns 0, mod_ktimeout() of an
- * active ktimeout returns 1.)
+ * The function returns whether it has modified a pending timeout or not.
+ * (ie. mod_ktimeout() of an inactive timeout returns 0, mod_ktimeout() of an
+ * active timeout returns 1.)
  */
 int mod_ktimeout(struct ktimeout *ktimeout, unsigned long expires)
 {
@@ -275,7 +281,7 @@ int mod_ktimeout(struct ktimeout *ktimeo
 
 	/*
 	 * This is a common optimization triggered by the
-	 * networking code - if the ktimeout is re-modified
+	 * networking code - if the timeout is re-modified
 	 * to be the same thing then just return:
 	 */
 	if (ktimeout->expires == expires && ktimeout_pending(ktimeout))
@@ -287,15 +293,15 @@ int mod_ktimeout(struct ktimeout *ktimeo
 EXPORT_SYMBOL(mod_ktimeout);
 
 /***
- * del_ktimeout - deactive a ktimeout.
- * @ktimeout: the ktimeout to be deactivated
+ * del_ktimeout - deactive a timeout.
+ * @ktimeout: the timeout to be deactivated
  *
- * del_ktimeout() deactivates a ktimeout - this works on both active and inactive
+ * del_ktimeout() deactivates a timeout - this works on both active and inactive
  * ktimeouts.
  *
- * The function returns whether it has deactivated a pending ktimeout or not.
- * (ie. del_ktimeout() of an inactive ktimeout returns 0, del_ktimeout() of an
- * active ktimeout returns 1.)
+ * The function returns whether it has deactivated a pending timeout or not.
+ * (ie. del_ktimeout() of an inactive timeout returns 0, del_ktimeout() of an
+ * active timeout returns 1.)
  */
 int del_ktimeout(struct ktimeout *ktimeout)
 {
@@ -319,8 +325,8 @@ EXPORT_SYMBOL(del_ktimeout);
 
 #ifdef CONFIG_SMP
 /*
- * This function tries to deactivate a ktimeout. Upon successful (ret >= 0)
- * exit the ktimeout is not queued and the handler is not running on any CPU.
+ * This function tries to deactivate a timeout. Upon successful (ret >= 0)
+ * exit the timeout is not queued and the handler is not running on any CPU.
  *
  * It must not be called from interrupt contexts.
  */
@@ -347,21 +353,21 @@ out:
 }
 
 /***
- * del_ktimeout_sync - deactivate a ktimeout and wait for the handler to finish.
- * @ktimeout: the ktimeout to be deactivated
+ * del_ktimeout_sync - deactivate a timeout and wait for the handler to finish.
+ * @ktimeout: the timeout to be deactivated
  *
  * This function only differs from del_ktimeout() on SMP: besides deactivating
- * the ktimeout it also makes sure the handler has finished executing on other
+ * the timeout it also makes sure the handler has finished executing on other
  * CPUs.
  *
- * Synchronization rules: callers must prevent restarting of the ktimeout,
+ * Synchronization rules: callers must prevent restarting of the timeout,
  * otherwise this function is meaningless. It must not be called from
  * interrupt contexts. The caller must not hold locks which would prevent
- * completion of the ktimeout's handler. The ktimeout's handler must not call
- * add_ktimeout_on(). Upon exit the ktimeout is not queued and the handler is
+ * completion of the timeout's handler. The timeout's handler must not call
+ * add_ktimeout_on(). Upon exit the timeout is not queued and the handler is
  * not running on any CPU.
  *
- * The function returns whether it has deactivated a pending ktimeout or not.
+ * The function returns whether it has deactivated a pending timeout or not.
  */
 int del_ktimeout_sync(struct ktimeout *ktimeout)
 {
@@ -377,13 +383,13 @@ EXPORT_SYMBOL(del_ktimeout_sync);
 
 static int cascade(tvec_base_t *base, tvec_t *tv, int index)
 {
-	/* cascade all the ktimeouts from tv up one level */
+	/* cascade all the timeouts from tv up one level */
 	struct list_head *head, *curr;
 
 	head = tv->vec + index;
 	curr = head->next;
 	/*
-	 * We are removing _all_ ktimeouts from the list, so we don't  have to
+	 * We are removing _all_ timeouts from the list, so we don't  have to
 	 * detach them individually, just clear the list afterwards.
 	 */
 	while (curr != head) {
@@ -400,10 +406,10 @@ static int cascade(tvec_base_t *base, tv
 }
 
 /***
- * __run_ktimeouts - run all expired ktimeouts (if any) on this CPU.
- * @base: the ktimeout vector to be processed.
+ * __run_ktimeouts - run all expired timeouts (if any) on this CPU.
+ * @base: the timeout vector to be processed.
  *
- * This function cascades all vectors and executes all expired ktimeout
+ * This function cascades all vectors and executes all expired timeout
  * vectors.
  */
 #define INDEX(N) (base->ktimeout_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
@@ -419,7 +425,7 @@ static inline void __run_ktimeouts(tvec_
  		int index = base->ktimeout_jiffies & TVR_MASK;
  
 		/*
-		 * Cascade ktimeouts:
+		 * Cascade timeouts:
 		 */
 		if (!index &&
 			(!cascade(base, &base->tv2, INDEX(0))) &&
@@ -460,7 +466,7 @@ static inline void __run_ktimeouts(tvec_
 
 #ifdef CONFIG_NO_IDLE_HZ
 /*
- * Find out when the next ktimeout event is due to happen. This
+ * Find out when the next timeout event is due to happen. This
  * is used on S/390 to stop all activity when a cpus is idle.
  * This functions needs to be called disabled.
  */
@@ -478,7 +484,7 @@ unsigned long next_ktimeout_interrupt(vo
 	expires = base->ktimeout_jiffies + (LONG_MAX >> 1);
 	list = 0;
 
-	/* Look for ktimeout events in tv1. */
+	/* Look for timeout events in tv1. */
 	j = base->ktimeout_jiffies & TVR_MASK;
 	do {
 		list_for_each_entry(nte, base->tv1.vec + j, entry) {
@@ -515,7 +521,7 @@ found:
 		/*
 		 * The search wrapped. We need to look at the next list
 		 * from next tv element that would cascade into tv element
-		 * where we found the ktimeout element.
+		 * where we found the timeout element.
 		 */
 		list_for_each_entry(nte, list, entry) {
 			if (time_before(nte->expires, expires))
@@ -528,7 +534,7 @@ found:
 #endif
 
 /*
- * This function runs ktimeouts and the ktimeout-tq in bottom half context.
+ * This function runs ktimers and timeouts in bottom half context.
  */
 static void run_ktimeout_softirq(struct softirq_action *h)
 {
@@ -540,7 +546,7 @@ static void run_ktimeout_softirq(struct 
 }
 
 /*
- * Called by the local, per-CPU ktimeout interrupt on SMP.
+ * Called by the local, per-CPU timeout interrupt on SMP.
  */
 void run_local_ktimeouts(void)
 {
@@ -567,7 +573,7 @@ static void process_timeout(unsigned lon
  *
  * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
  * delivered to the current task. In this case the remaining time
- * in jiffies will be returned, or 0 if the ktimeout expired in time
+ * in jiffies will be returned, or 0 if the timeout expired in time
  *
  * The current task state is guaranteed to be TASK_RUNNING when this
  * routine returns.

--

