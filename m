Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVCSR1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVCSR1m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 12:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVCSR1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 12:27:16 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:39590 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262634AbVCSRZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 12:25:13 -0500
Message-ID: <423C6FDA.D157A3F9@tv-sign.ru>
Date: Sat, 19 Mar 2005 21:30:50 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Lameter <christoph@lameter.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/5] timers: cleanup, kill __get_base()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__get_base() was added to reduce the changes in
previous patches. This patch removes it.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.12-rc1/kernel/timer.c~5_CLEAN	2005-03-19 22:28:34.000000000 +0300
+++ 2.6.12-rc1/kernel/timer.c	2005-03-19 23:34:23.000000000 +0300
@@ -86,16 +86,6 @@ static inline void set_running_timer(tve
 #endif
 }
 
-static inline tvec_base_t *__get_base(struct timer_list *timer)
-{
-	tvec_base_t *base = timer->_base;
-
-	if (__timer_pending(base))
-		return (void*)base - __TIMER_PENDING;
-	else
-		return NULL;
-}
-
 static inline void __set_base(struct timer_list *timer,
 				tvec_base_t *base, int pending)
 {
@@ -323,16 +313,18 @@ EXPORT_SYMBOL(mod_timer);
 int del_timer(struct timer_list *timer)
 {
 	unsigned long flags;
-	tvec_base_t *base;
+	tvec_base_t *_base, *base;
 
 	check_timer(timer);
 
 repeat:
- 	base = __get_base(timer);
-	if (!base)
+	_base = timer->_base;
+	if (!__timer_pending(_base))
 		return 0;
+
+	base = (void*)_base - __TIMER_PENDING;
 	spin_lock_irqsave(&base->lock, flags);
-	if (base != __get_base(timer)) {
+	if (_base != timer->_base) {
 		spin_unlock_irqrestore(&base->lock, flags);
 		goto repeat;
 	}
@@ -445,7 +437,7 @@ static int cascade(tvec_base_t *base, tv
 		struct timer_list *tmp;
 
 		tmp = list_entry(curr, struct timer_list, entry);
-		BUG_ON(__get_base(tmp) != base);
+		BUG_ON(tmp->_base != ((void*)base + __TIMER_PENDING));
 		curr = curr->next;
 		internal_add_timer(base, tmp);
 	}
