Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272762AbTG3F6d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 01:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272773AbTG3F6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 01:58:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:63404 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S272762AbTG3F6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 01:58:09 -0400
Date: Wed, 30 Jul 2003 07:57:32 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linas@austin.ibm.com, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
In-Reply-To: <20030729135643.2e9b74bc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0307300733200.25010-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jul 2003, Andrew Morton wrote:

> Andrea says that we need to take the per-timer lock in add_timer() and
> del_timer(), but I haven't yet got around to working out why.

this makes no sense - in 2.6 (and in 2.4) there's no safe add_timer() /
del_timer() use without using external SMP synchronization. (There's one
special timer use variant involving del_timer_sync() that was safe in 2.4
but is unsafe in 2.6, see below.)

and i dont think Linas' patch is correct either - how can the timer base
change under us? We are holding the timer spinlock.

What i'd propose is the attached (tested, against 2.6.0-test2) patch
instead. It unifies the functionality of add_timer() and mod_timer(), and
makes any combination of the timer API calls completely SMP-safe.  
del_timer() is still not using the timer lock.

this patch fixes the only timer bug in 2.6 i'm aware of: the
del_timer_sync() + add_timer() combination in kernel/itimer.c is buggy.
This was correct code in 2.4, because there it was safe to do an
add_timer() from the timer handler itself, parallel to a del_timer_sync().  
If we want to make this safe in 2.6 too (which i think we want to) then we
have to make add_timer() almost equivalent to mod_timer(), locking-wise.
And once we are at this point i think it's much cleaner to actually make
add_timer() a variant of mod_timer(). (There's no locking cost for
add_timer(), only the cost of an extra branch. And we've removed another
commonly used function from the icache.)

Linas, could you please give this patch a go, does it make a difference to
your timer list corruption problem? I've booted it on SMP and UP as well.

	Ingo

--- linux/include/linux/timer.h.orig	
+++ linux/include/linux/timer.h	
@@ -60,11 +60,30 @@ static inline int timer_pending(const st
 	return timer->base != NULL;
 }
 
-extern void add_timer(struct timer_list * timer);
 extern void add_timer_on(struct timer_list *timer, int cpu);
 extern int del_timer(struct timer_list * timer);
+extern int __mod_timer(struct timer_list *timer, unsigned long expires);
 extern int mod_timer(struct timer_list *timer, unsigned long expires);
-  
+
+/***
+ * add_timer - start a timer
+ * @timer: the timer to be added
+ *
+ * The kernel will do a ->function(->data) callback from the
+ * timer interrupt at the ->expired point in the future. The
+ * current time is 'jiffies'.
+ *
+ * The timer's ->expired, ->function (and if the handler uses it, ->data)
+ * fields must be set prior calling this function.
+ *
+ * Timers with an ->expired field in the past will be executed in the next
+ * timer tick.
+ */
+static inline void add_timer(struct timer_list * timer)
+{
+	__mod_timer(timer, timer->expires);
+}
+ 
 #ifdef CONFIG_SMP
   extern int del_timer_sync(struct timer_list * timer);
 #else
--- linux/kernel/timer.c.orig	
+++ linux/kernel/timer.c	
@@ -144,34 +144,62 @@ static void internal_add_timer(tvec_base
 	list_add_tail(&timer->entry, vec);
 }
 
-/***
- * add_timer - start a timer
- * @timer: the timer to be added
- *
- * The kernel will do a ->function(->data) callback from the
- * timer interrupt at the ->expired point in the future. The
- * current time is 'jiffies'.
- *
- * The timer's ->expired, ->function (and if the handler uses it, ->data)
- * fields must be set prior calling this function.
- *
- * Timers with an ->expired field in the past will be executed in the next
- * timer tick. It's illegal to add an already pending timer.
- */
-void add_timer(struct timer_list *timer)
+int __mod_timer(struct timer_list *timer, unsigned long expires)
 {
-	tvec_base_t *base = &get_cpu_var(tvec_bases);
-  	unsigned long flags;
-  
-  	BUG_ON(timer_pending(timer) || !timer->function);
+	tvec_base_t *old_base, *new_base;
+	unsigned long flags;
+	int ret = 0;
+
+	BUG_ON(!timer->function);
 
 	check_timer(timer);
 
-	spin_lock_irqsave(&base->lock, flags);
-	internal_add_timer(base, timer);
-	timer->base = base;
-	spin_unlock_irqrestore(&base->lock, flags);
-	put_cpu_var(tvec_bases);
+	spin_lock_irqsave(&timer->lock, flags);
+	new_base = &__get_cpu_var(tvec_bases);
+repeat:
+	old_base = timer->base;
+
+	/*
+	 * Prevent deadlocks via ordering by old_base < new_base.
+	 */
+	if (old_base && (new_base != old_base)) {
+		if (old_base < new_base) {
+			spin_lock(&new_base->lock);
+			spin_lock(&old_base->lock);
+		} else {
+			spin_lock(&old_base->lock);
+			spin_lock(&new_base->lock);
+		}
+		/*
+		 * The timer base might have been cancelled while we were
+		 * trying to take the lock(s):
+		 */
+		if (timer->base != old_base) {
+			spin_unlock(&new_base->lock);
+			spin_unlock(&old_base->lock);
+			goto repeat;
+		}
+	} else
+		spin_lock(&new_base->lock);
+
+	/*
+	 * Delete the previous timeout (if there was any), and install
+	 * the new one:
+	 */
+	if (old_base) {
+		list_del(&timer->entry);
+		ret = 1;
+	}
+	timer->expires = expires;
+	internal_add_timer(new_base, timer);
+	timer->base = new_base;
+
+	if (old_base && (new_base != old_base))
+		spin_unlock(&old_base->lock);
+	spin_unlock(&new_base->lock);
+	spin_unlock_irqrestore(&timer->lock, flags);
+
+	return ret;
 }
 
 /***
@@ -179,7 +207,7 @@ void add_timer(struct timer_list *timer)
  * @timer: the timer to be added
  * @cpu: the CPU to start it on
  *
- * This is not very scalable on SMP.
+ * This is not very scalable on SMP. Double adds are not possible.
  */
 void add_timer_on(struct timer_list *timer, int cpu)
 {
@@ -217,10 +245,6 @@ void add_timer_on(struct timer_list *tim
  */
 int mod_timer(struct timer_list *timer, unsigned long expires)
 {
-	tvec_base_t *old_base, *new_base;
-	unsigned long flags;
-	int ret = 0;
-
 	BUG_ON(!timer->function);
 
 	check_timer(timer);
@@ -233,52 +257,7 @@ int mod_timer(struct timer_list *timer, 
 	if (timer->expires == expires && timer_pending(timer))
 		return 1;
 
-	spin_lock_irqsave(&timer->lock, flags);
-	new_base = &__get_cpu_var(tvec_bases);
-repeat:
-	old_base = timer->base;
-
-	/*
-	 * Prevent deadlocks via ordering by old_base < new_base.
-	 */
-	if (old_base && (new_base != old_base)) {
-		if (old_base < new_base) {
-			spin_lock(&new_base->lock);
-			spin_lock(&old_base->lock);
-		} else {
-			spin_lock(&old_base->lock);
-			spin_lock(&new_base->lock);
-		}
-		/*
-		 * The timer base might have been cancelled while we were
-		 * trying to take the lock(s):
-		 */
-		if (timer->base != old_base) {
-			spin_unlock(&new_base->lock);
-			spin_unlock(&old_base->lock);
-			goto repeat;
-		}
-	} else
-		spin_lock(&new_base->lock);
-
-	/*
-	 * Delete the previous timeout (if there was any), and install
-	 * the new one:
-	 */
-	if (old_base) {
-		list_del(&timer->entry);
-		ret = 1;
-	}
-	timer->expires = expires;
-	internal_add_timer(new_base, timer);
-	timer->base = new_base;
-
-	if (old_base && (new_base != old_base))
-		spin_unlock(&old_base->lock);
-	spin_unlock(&new_base->lock);
-	spin_unlock_irqrestore(&timer->lock, flags);
-
-	return ret;
+	return __mod_timer(timer, expires);
 }
 
 /***


