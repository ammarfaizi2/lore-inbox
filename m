Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVEAHsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVEAHsg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 03:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVEAHsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 03:48:36 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:25295 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261548AbVEAHs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 03:48:28 -0400
Message-ID: <42748B75.D6CBF829@tv-sign.ru>
Date: Sun, 01 May 2005 11:55:33 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Maneesh Soni <maneesh@in.ibm.com>,
       Juergen Kreileder <jk@blackdown.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] fix __mod_timer vs __run_timers deadlock.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bug was identified by Maneesh Soni.

When __mod_timer() changes timer's base it waits for the completion
of timer->function. It is just stupid: the caller of __mod_timer()
can held locks which would prevent completion of the timer's handler.

Solution: do not change the base of the currently running timer.

Side effect: __mod_timer() doesn't garantees anymore that timer will
run on the local cpu.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc2-mm3/kernel/timer.c~	2005-04-30 18:43:56.000000000 +0400
+++ rc2-mm3/kernel/timer.c	2005-05-01 14:29:02.000000000 +0400
@@ -212,41 +212,39 @@ int __mod_timer(struct timer_list *timer
 	timer_base_t *base;
 	tvec_base_t *new_base;
 	unsigned long flags;
-	int ret = -1;
+	int ret;
 
 	BUG_ON(!timer->function);
 	check_timer(timer);
-
-	do {
-		base = lock_timer_base(timer, &flags);
-		new_base = &__get_cpu_var(tvec_bases);
-
-		/* Ensure the timer is serialized. */
-		if (base != &new_base->t_base
-			&& base->running_timer == timer)
-			goto unlock;
-
-		ret = 0;
-		if (timer_pending(timer)) {
-			detach_timer(timer, 0);
-			ret = 1;
-		}
-
-		if (base != &new_base->t_base) {
-			timer->base = NULL;
-			/* Safe: the timer can't be seen via ->entry,
-			 * and lock_timer_base checks ->base != 0. */
-			spin_unlock(&base->lock);
-			base = &new_base->t_base;
-			spin_lock(&base->lock);
-			timer->base = base;
-		}
-
-		timer->expires = expires;
-		internal_add_timer(new_base, timer);
-unlock:
-		spin_unlock_irqrestore(&base->lock, flags);
-	} while (ret < 0);
+
+	base = lock_timer_base(timer, &flags);
+
+	ret = 0;
+	if (timer_pending(timer)) {
+		detach_timer(timer, 0);
+		ret = 1;
+	}
+
+	new_base = &__get_cpu_var(tvec_bases);
+
+	if (base != &new_base->t_base) {
+		if (unlikely(base->running_timer == timer))
+			/* Don't change timer's base while it is running.
+			 * Needed for serialization of timer wrt itself. */
+			new_base = container_of(base, tvec_base_t, t_base);
+		else {
+			timer->base = NULL;
+			/* Safe: the timer can't be seen via ->entry,
+			 * and lock_timer_base checks ->base != 0. */
+			spin_unlock(&base->lock);
+			spin_lock(&new_base->t_base.lock);
+			timer->base = &new_base->t_base;
+		}
+	}
+
+	timer->expires = expires;
+	internal_add_timer(new_base, timer);
+	spin_unlock_irqrestore(&new_base->t_base.lock, flags);
 
 	return ret;
 }
