Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVCUNNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVCUNNq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 08:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVCUNNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 08:13:46 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:48821 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261769AbVCUNNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 08:13:38 -0500
Message-ID: <423ED7E4.2A1F0970@tv-sign.ru>
Date: Mon, 21 Mar 2005 17:19:16 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Lameter <christoph@lameter.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 6/5] timers: enable irqs in __mod_timer()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of "[PATCH 5/5] timers: cleanup, kill __get_base()", see
http://marc.theaimsgroup.com/?l=linux-kernel&m=111125359121372

If the timer is currently running on another CPU, __mod_timer()
spins with interrupts disabled and timer->lock held. I think it
is better to spin_unlock_irqrestore(&timer->lock) in __mod_timer's
retry path.

This patch is unneccessary long. It is because it tries to cleanup
the code a bit. I do not like the fact that lock+test+unlock pattern
is duplicated in the code.

If you think that this patch uglifies the code or does not match
kernel's coding style - just say nack :)

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.12-rc1/kernel/timer.c~6_LOCK	2005-03-19 23:34:23.000000000 +0300
+++ 2.6.12-rc1/kernel/timer.c	2005-03-21 18:55:25.000000000 +0300
@@ -174,64 +174,60 @@ int __mod_timer(struct timer_list *timer
 {
 	tvec_base_t *old_base, *new_base;
 	unsigned long flags;
-	int ret = 0;
-
-	BUG_ON(!timer->function);
-
-	check_timer(timer);
-
-	spin_lock_irqsave(&timer->lock, flags);
-	new_base = &__get_cpu_var(tvec_bases);
-repeat:
-	old_base = timer_base(timer);
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
-		 * trying to take the lock(s), or can still be running on
-		 * old_base's CPU.
-		 */
-		if (timer_base(timer) != old_base
-				|| old_base->running_timer == timer) {
-			spin_unlock(&new_base->lock);
-			spin_unlock(&old_base->lock);
-			goto repeat;
-		}
-	} else {
-		spin_lock(&new_base->lock);
-		if (timer_base(timer) != old_base) {
-			spin_unlock(&new_base->lock);
-			goto repeat;
-		}
-	}
-
-	/*
-	 * Delete the previous timeout (if there was any).
-	 * We hold timer->lock, no need to check old_base != 0.
-	 */
-	if (timer_pending(timer)) {
-		list_del(&timer->entry);
-		ret = 1;
-	}
-
-	timer->expires = expires;
-	internal_add_timer(new_base, timer);
-	__set_base(timer, new_base, 1);
-
-	if (old_base && (new_base != old_base))
-		spin_unlock(&old_base->lock);
-	spin_unlock(&new_base->lock);
-	spin_unlock_irqrestore(&timer->lock, flags);
+	int new_lock, ret;
+
+	BUG_ON(!timer->function);
+	check_timer(timer);
+
+	for (ret = -1; ret < 0; ) {
+		spin_lock_irqsave(&timer->lock, flags);
+		new_base = &__get_cpu_var(tvec_bases);
+		old_base = timer_base(timer);
+
+		/* Prevent AB-BA deadlocks. */
+		new_lock = old_base < new_base;
+		if (new_lock)
+			spin_lock(&new_base->lock);
+
+		/* Note:
+		 *	(old_base == NULL)     => (new_lock == 1)
+		 *	(old_base == new_base) => (new_lock == 0)
+		 */
+		if (old_base) {
+			spin_lock(&old_base->lock);
+
+			if (timer_base(timer) != old_base)
+				goto unlock;
+
+			if (old_base != new_base) {
+				/* Ensure the timer is serialized. */
+				if (old_base->running_timer == timer)
+					goto unlock;
+
+				if (!new_lock) {
+					spin_lock(&new_base->lock);
+					new_lock = 1;
+				}
+			}
+		}
+
+		ret = 0;
+		/* We hold timer->lock, no need to check old_base != 0. */
+		if (timer_pending(timer)) {
+			list_del(&timer->entry);
+			ret = 1;
+		}
+
+		timer->expires = expires;
+		internal_add_timer(new_base, timer);
+		__set_base(timer, new_base, 1);
+unlock:
+		if (old_base)
+			spin_unlock(&old_base->lock);
+		if (new_lock)
+			spin_unlock(&new_base->lock);
+		spin_unlock_irqrestore(&timer->lock, flags);
+	}
 
 	return ret;
 }
