Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVEVOtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVEVOtW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 10:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVEVOtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 10:49:22 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:24214 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261814AbVEVOtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 10:49:09 -0400
Message-ID: <42909DBC.686D4544@tv-sign.ru>
Date: Sun, 22 May 2005 18:57:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: George Anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH rc4-mm2 1/2] timers: introduce try_to_del_timer_sync()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch splits del_timer_sync() into 2 functions. The new one,
try_to_del_timer_sync(), returns -1 when it hits executing timer.

It can be used in interrupt context, or when the caller hold locks
which can prevent completion of the timer's handler.

NOTE. Currently it can't be used in interrupt context in UP case,
because ->running_timer is used only with CONFIG_SMP.

Should the need arise, it is possible to kill #ifdef CONFIG_SMP in
set_running_timer(), it is cheap.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.12-rc4-mm2/include/linux/timer.h~1_TRY	2005-05-22 15:41:51.000000000 +0400
+++ 2.6.12-rc4-mm2/include/linux/timer.h	2005-05-22 17:34:00.000000000 +0400
@@ -76,9 +76,11 @@ static inline void add_timer(struct time
 }
 
 #ifdef CONFIG_SMP
+  extern int try_to_del_timer_sync(struct timer_list *timer);
   extern int del_timer_sync(struct timer_list *timer);
 #else
-# define del_timer_sync(t) del_timer(t)
+# define try_to_del_timer_sync(t)	del_timer(t)
+# define del_timer_sync(t)		del_timer(t)
 #endif
 
 #define del_singleshot_timer_sync(t) del_timer_sync(t)
--- 2.6.12-rc4-mm2/kernel/timer.c~1_TRY	2005-05-22 15:41:51.000000000 +0400
+++ 2.6.12-rc4-mm2/kernel/timer.c	2005-05-22 18:08:15.000000000 +0400
@@ -366,6 +366,34 @@ int del_timer(struct timer_list *timer)
 EXPORT_SYMBOL(del_timer);
 
 #ifdef CONFIG_SMP
+/*
+ * This function tries to deactivate a timer. Upon successful (ret >= 0)
+ * exit the timer is not queued and the handler is not running on any CPU.
+ *
+ * It must not be called from interrupt contexts.
+ */
+int try_to_del_timer_sync(struct timer_list *timer)
+{
+	timer_base_t *base;
+	unsigned long flags;
+	int ret = -1;
+
+	base = lock_timer_base(timer, &flags);
+
+	if (base->running_timer == timer)
+		goto out;
+
+	ret = 0;
+	if (timer_pending(timer)) {
+		detach_timer(timer, 1);
+		ret = 1;
+	}
+out:
+	spin_unlock_irqrestore(&base->lock, flags);
+
+	return ret;
+}
+
 /***
  * del_timer_sync - deactivate a timer and wait for the handler to finish.
  * @timer: the timer to be deactivated
@@ -385,28 +413,13 @@ EXPORT_SYMBOL(del_timer);
  */
 int del_timer_sync(struct timer_list *timer)
 {
-	timer_base_t *base;
-	unsigned long flags;
-	int ret = -1;
-
 	check_timer(timer);
 
-	do {
-		base = lock_timer_base(timer, &flags);
-
-		if (base->running_timer == timer)
-			goto unlock;
-
-		ret = 0;
-		if (timer_pending(timer)) {
-			detach_timer(timer, 1);
-			ret = 1;
-		}
-unlock:
-		spin_unlock_irqrestore(&base->lock, flags);
-	} while (ret < 0);
-
-	return ret;
+	for (;;) {
+		int ret = try_to_del_timer_sync(timer);
+		if (ret >= 0)
+			return ret;
+	}
 }
 
 EXPORT_SYMBOL(del_timer_sync);
