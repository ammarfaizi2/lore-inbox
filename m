Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVCSR1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVCSR1n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 12:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262640AbVCSR0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 12:26:48 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:34214 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262644AbVCSRY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 12:24:57 -0500
Message-ID: <423C6FC9.9A002930@tv-sign.ru>
Date: Sat, 19 Mar 2005 21:30:33 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Lameter <christoph@lameter.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/5] timers: serialize timers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it is supposed that timers are serialized wrt to itself,
but I can't find any documentation about it.

If CPU_0 does mod_timer(jiffies+1) while the timer is currently
running on CPU 1, it is quite possible that local interrupt on
CPU_0 will start that timer before it finished on CPU_1.

With this patch __mod_timer() locks old_base even if timer is not
pending, like del_timer_sync() does. If the timer is still running,
and old_base != new_base, __mod_timer() retries.

Now we have:
	1. the timer's handler can't run on different cpus at
	   the same time.
	2. the timer's base can't be changed during execution
	   of the timer's handler.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.12-rc1/kernel/timer.c~3_MOD	2005-03-19 17:19:44.000000000 +0300
+++ 2.6.12-rc1/kernel/timer.c	2005-03-19 20:16:47.000000000 +0300
@@ -193,7 +193,7 @@ int __mod_timer(struct timer_list *timer
 	spin_lock_irqsave(&timer->lock, flags);
 	new_base = &__get_cpu_var(tvec_bases);
 repeat:
-	old_base = __get_base(timer);
+	old_base = timer_base(timer);
 
 	/*
 	 * Prevent deadlocks via ordering by old_base < new_base.
@@ -208,29 +208,32 @@ repeat:
 		}
 		/*
 		 * The timer base might have been cancelled while we were
-		 * trying to take the lock(s):
+		 * trying to take the lock(s), or can still be running on
+		 * old_base's CPU.
 		 */
-		if (__get_base(timer) != old_base) {
+		if (timer_base(timer) != old_base
+				|| old_base->running_timer == timer) {
 			spin_unlock(&new_base->lock);
 			spin_unlock(&old_base->lock);
 			goto repeat;
 		}
 	} else {
 		spin_lock(&new_base->lock);
-		if (__get_base(timer) != old_base) {
+		if (timer_base(timer) != old_base) {
 			spin_unlock(&new_base->lock);
 			goto repeat;
 		}
 	}
 
 	/*
-	 * Delete the previous timeout (if there was any), and install
-	 * the new one:
+	 * Delete the previous timeout (if there was any).
+	 * We hold timer->lock, no need to check old_base != 0.
 	 */
-	if (old_base) {
+	if (timer_pending(timer)) {
 		list_del(&timer->entry);
 		ret = 1;
 	}
+
 	timer->expires = expires;
 	internal_add_timer(new_base, timer);
 	__set_base(timer, new_base, 1);
