Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVCOQPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVCOQPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVCOQPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:15:10 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:20905 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261375AbVCOQOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:14:31 -0500
Message-ID: <4237193E.D797A56E@tv-sign.ru>
Date: Tue, 15 Mar 2005 20:19:58 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, Shai Fultheim <Shai@Scalex86.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 1/2] del_timer_sync: proof of concept
References: <4231E959.141F7D85@tv-sign.ru> <Pine.LNX.4.58.0503111254270.25992@server.graphe.net>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames ->base to _base. Now this field
is used only in __get_base/__set_base helpers.

It is ugly, just to reduce the size of patch.

No changes in kernel/timer.o, so it is correct.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.11/include/linux/timer.h~1_BASE	2005-03-14 00:22:43.000000000 +0300
+++ 2.6.11/include/linux/timer.h	2005-03-15 17:49:19.000000000 +0300
@@ -18,16 +18,21 @@ struct timer_list {
 	void (*function)(unsigned long);
 	unsigned long data;
 
-	struct tvec_t_base_s *base;
+	struct tvec_t_base_s *_base;
 };
 
+static inline int __timer_pending(struct tvec_t_base_s *base)
+{
+	return base != NULL;
+}
+
 #define TIMER_MAGIC	0x4b87ad6e
 
 #define TIMER_INITIALIZER(_function, _expires, _data) {		\
 		.function = (_function),			\
 		.expires = (_expires),				\
 		.data = (_data),				\
-		.base = NULL,					\
+		._base = NULL,					\
 		.magic = TIMER_MAGIC,				\
 		.lock = SPIN_LOCK_UNLOCKED,			\
 	}
@@ -41,7 +46,7 @@ struct timer_list {
  */
 static inline void init_timer(struct timer_list * timer)
 {
-	timer->base = NULL;
+	timer->_base = NULL;
 	timer->magic = TIMER_MAGIC;
 	spin_lock_init(&timer->lock);
 }
@@ -58,7 +63,7 @@ static inline void init_timer(struct tim
  */
 static inline int timer_pending(const struct timer_list * timer)
 {
-	return timer->base != NULL;
+	return __timer_pending(timer->_base);
 }
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
--- 2.6.11/kernel/timer.c~1_BASE	2005-03-14 00:21:13.000000000 +0300
+++ 2.6.11/kernel/timer.c	2005-03-15 17:55:00.000000000 +0300
@@ -84,6 +84,20 @@ static inline void set_running_timer(tve
 #endif
 }
 
+static inline tvec_base_t *__get_base(struct timer_list *timer)
+{
+	return timer->_base;
+}
+
+static inline void __set_base(struct timer_list *timer,
+				tvec_base_t *base, int pending)
+{
+	if (pending)
+		timer->_base = base;
+	else
+		timer->_base = NULL;
+}
+
 /* Fake initialization */
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
 
@@ -167,7 +181,7 @@ int __mod_timer(struct timer_list *timer
 	spin_lock_irqsave(&timer->lock, flags);
 	new_base = &__get_cpu_var(tvec_bases);
 repeat:
-	old_base = timer->base;
+	old_base = __get_base(timer);
 
 	/*
 	 * Prevent deadlocks via ordering by old_base < new_base.
@@ -184,14 +198,14 @@ repeat:
 		 * The timer base might have been cancelled while we were
 		 * trying to take the lock(s):
 		 */
-		if (timer->base != old_base) {
+		if (__get_base(timer) != old_base) {
 			spin_unlock(&new_base->lock);
 			spin_unlock(&old_base->lock);
 			goto repeat;
 		}
 	} else {
 		spin_lock(&new_base->lock);
-		if (timer->base != old_base) {
+		if (__get_base(timer) != old_base) {
 			spin_unlock(&new_base->lock);
 			goto repeat;
 		}
@@ -207,7 +221,7 @@ repeat:
 	}
 	timer->expires = expires;
 	internal_add_timer(new_base, timer);
-	timer->base = new_base;
+	__set_base(timer, new_base, 1);
 
 	if (old_base && (new_base != old_base))
 		spin_unlock(&old_base->lock);
@@ -237,7 +251,7 @@ void add_timer_on(struct timer_list *tim
 
 	spin_lock_irqsave(&base->lock, flags);
 	internal_add_timer(base, timer);
-	timer->base = base;
+	__set_base(timer, base, 1);
 	spin_unlock_irqrestore(&base->lock, flags);
 }
 
@@ -299,18 +313,18 @@ int del_timer(struct timer_list *timer)
 	check_timer(timer);
 
 repeat:
- 	base = timer->base;
+ 	base = __get_base(timer);
 	if (!base)
 		return 0;
 	spin_lock_irqsave(&base->lock, flags);
-	if (base != timer->base) {
+	if (base != __get_base(timer)) {
 		spin_unlock_irqrestore(&base->lock, flags);
 		goto repeat;
 	}
 	list_del(&timer->entry);
 	/* Need to make sure that anybody who sees a NULL base also sees the list ops */
 	smp_wmb();
-	timer->base = NULL;
+	__set_base(timer, base, 0);
 	spin_unlock_irqrestore(&base->lock, flags);
 
 	return 1;
@@ -413,7 +427,7 @@ static int cascade(tvec_base_t *base, tv
 		struct timer_list *tmp;
 
 		tmp = list_entry(curr, struct timer_list, entry);
-		BUG_ON(tmp->base != base);
+		BUG_ON(__get_base(tmp) != base);
 		curr = curr->next;
 		internal_add_timer(base, tmp);
 	}
@@ -463,7 +477,7 @@ repeat:
 			list_del(&timer->entry);
 			set_running_timer(base, timer);
 			smp_wmb();
-			timer->base = NULL;
+			__set_base(timer, base, 0);
 			spin_unlock_irq(&base->lock);
 			{
 				u32 preempt_count = preempt_count();
@@ -1309,7 +1323,7 @@ static int migrate_timer_list(tvec_base_
 			return 0;
 		list_del(&timer->entry);
 		internal_add_timer(new_base, timer);
-		timer->base = new_base;
+		__set_base(timer, new_base, 1);
 		spin_unlock(&timer->lock);
 	}
 	return 1;
