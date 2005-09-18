Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVIRNjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVIRNjH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 09:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVIRNjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 09:39:07 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:43405 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751224AbVIRNjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 09:39:05 -0400
Message-ID: <432D70C8.EF7B0438@tv-sign.ru>
Date: Sun, 18 Sep 2005 17:51:04 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] introduce setup_timer() helper
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every user of init_timer() also needs to initialize ->function and
->data fields. This patch adds a simple setup_timer() helper for that.

The schedule_timeout() is patched as an example of usage.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc1/include/linux/timer.h~4_SETUP	2005-09-17 18:57:30.000000000 +0400
+++ 2.6.14-rc1/include/linux/timer.h	2005-09-18 20:55:15.000000000 +0400
@@ -38,6 +38,15 @@ extern struct timer_base_s __init_timer_
 
 void fastcall init_timer(struct timer_list * timer);
 
+static inline void setup_timer(struct timer_list * timer,
+				void (*function)(unsigned long),
+				unsigned long data)
+{
+	timer->function = function;
+	timer->data = data;
+	init_timer(timer);
+}
+
 /***
  * timer_pending - is a timer pending?
  * @timer: the timer in question
--- 2.6.14-rc1/kernel/timer.c~4_SETUP	2005-09-17 18:57:30.000000000 +0400
+++ 2.6.14-rc1/kernel/timer.c	2005-09-18 20:59:43.000000000 +0400
@@ -1137,12 +1137,8 @@ fastcall signed long __sched schedule_ti
 
 	expire = timeout + jiffies;
 
-	init_timer(&timer);
-	timer.expires = expire;
-	timer.data = (unsigned long) current;
-	timer.function = process_timeout;
-
-	add_timer(&timer);
+	setup_timer(&timer, process_timeout, (unsigned long)current);
+	__mod_timer(&timer, expire);
 	schedule();
 	del_singleshot_timer_sync(&timer);
