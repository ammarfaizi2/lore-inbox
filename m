Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVDBJQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVDBJQW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 04:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVDBJQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 04:16:22 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:4261 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261261AbVDBJQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 04:16:05 -0500
Message-ID: <424E6441.12A6BC03@tv-sign.ru>
Date: Sat, 02 Apr 2005 13:22:09 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Lameter <christoph@lameter.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] timers fixes/improvements
References: <424D373F.1BCBF2AC@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, It never ends. Andrew, please apply this too.
Or I can send you updated previous patch if your prefer.

[PATCH] timers fixes/improvements fix

1. Fix compilation with CONFIG_NO_IDLE_HZ:
   s/->lock/->t_base.lock/

2. s/_base/base as Ingo suggested.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.12-rc1/include/linux/timer.h~FIX	2005-04-01 00:33:33.000000000 +0400
+++ 2.6.12-rc1/include/linux/timer.h	2005-04-02 16:08:45.000000000 +0400
@@ -17,7 +17,7 @@ struct timer_list {
 	void (*function)(unsigned long);
 	unsigned long data;
 
-	struct timer_base_s *_base;
+	struct timer_base_s *base;
 };
 
 #define TIMER_MAGIC	0x4b87ad6e
@@ -28,7 +28,7 @@ extern struct timer_base_s __init_timer_
 		.function = (_function),			\
 		.expires = (_expires),				\
 		.data = (_data),				\
-		._base = &__init_timer_base,			\
+		.base = &__init_timer_base,			\
 		.magic = TIMER_MAGIC,				\
 	}
 
--- 2.6.12-rc1/kernel/timer.c~FIX	2005-04-02 15:49:13.000000000 +0400
+++ 2.6.12-rc1/kernel/timer.c	2005-04-02 16:09:11.000000000 +0400
@@ -172,7 +172,7 @@ EXPORT_SYMBOL(__init_timer_base);
 void fastcall init_timer(struct timer_list *timer)
 {
 	timer->entry.next = NULL;
-	timer->_base = &per_cpu(tvec_bases,
+	timer->base = &per_cpu(tvec_bases,
 			__smp_processor_id()).t_base;
 	timer->magic = TIMER_MAGIC;
 }
@@ -195,11 +195,11 @@ static timer_base_t *lock_timer_base(str
 	timer_base_t *base;
 
 	for (;;) {
-		base = timer->_base;
+		base = timer->base;
 		/* Can be NULL while __mod_timer switches bases */
 		if (likely(base != NULL)) {
 			spin_lock_irqsave(&base->lock, *flags);
-			if (likely(base == timer->_base))
+			if (likely(base == timer->base))
 				return base;
 			spin_unlock_irqrestore(&base->lock, *flags);
 		}
@@ -233,13 +233,13 @@ int __mod_timer(struct timer_list *timer
 		}
 
 		if (base != &new_base->t_base) {
-			timer->_base = NULL;
+			timer->base = NULL;
 			/* Safe: the timer can't be seen via ->entry,
-			 * and lock_timer_base checks ->_base != 0. */
+			 * and lock_timer_base checks ->base != 0. */
 			spin_unlock(&base->lock);
 			base = &new_base->t_base;
 			spin_lock(&base->lock);
-			timer->_base = base;
+			timer->base = base;
 		}
 
 		timer->expires = expires;
@@ -270,7 +270,7 @@ void add_timer_on(struct timer_list *tim
 	check_timer(timer);
 
 	spin_lock_irqsave(&base->t_base.lock, flags);
-	timer->_base = &base->t_base;
+	timer->base = &base->t_base;
 	internal_add_timer(base, timer);
 	spin_unlock_irqrestore(&base->t_base.lock, flags);
 }
@@ -409,7 +409,7 @@ static int cascade(tvec_base_t *base, tv
 		struct timer_list *tmp;
 
 		tmp = list_entry(curr, struct timer_list, entry);
-		BUG_ON(tmp->_base != &base->t_base);
+		BUG_ON(tmp->base != &base->t_base);
 		curr = curr->next;
 		internal_add_timer(base, tmp);
 	}
@@ -491,7 +491,7 @@ unsigned long next_timer_interrupt(void)
 	int i, j;
 
 	base = &__get_cpu_var(tvec_bases);
-	spin_lock(&base->lock);
+	spin_lock(&base->t_base.lock);
 	expires = base->timer_jiffies + (LONG_MAX >> 1);
 	list = 0;
 
@@ -539,7 +539,7 @@ found:
 				expires = nte->expires;
 		}
 	}
-	spin_unlock(&base->lock);
+	spin_unlock(&base->t_base.lock);
 	return expires;
 }
 #endif
@@ -1301,7 +1301,7 @@ static void migrate_timer_list(tvec_base
 	while (!list_empty(head)) {
 		timer = list_entry(head->next, struct timer_list, entry);
 		detach_timer(timer, 0);
-		timer->_base = &new_base->t_base;
+		timer->base = &new_base->t_base;
 		internal_add_timer(new_base, timer);
 	}
 }
