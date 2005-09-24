Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVIXNeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVIXNeS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 09:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVIXNeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 09:34:17 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:6803 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750747AbVIXNeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 09:34:17 -0400
Message-ID: <433558BC.89097548@tv-sign.ru>
Date: Sat, 24 Sep 2005 17:46:36 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix de_thread vs it_real_fn() deadlock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

de_thread() calls del_timer_sync(->real_timer) under
->sighand->siglock. This is deadlockable, it_real_fn
sends a signal and needs this lock too.

Also, delete unneeded ->real_timer.data assignment.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc2/fs/exec.c~3_DEIT	2005-09-21 21:08:33.000000000 +0400
+++ 2.6.14-rc2/fs/exec.c	2005-09-24 20:31:25.000000000 +0400
@@ -646,8 +646,10 @@ static inline int de_thread(struct task_
 		 * before we can safely let the old group leader die.
 		 */
 		sig->real_timer.data = (unsigned long)current;
+		spin_unlock_irq(lock);
 		if (del_timer_sync(&sig->real_timer))
 			add_timer(&sig->real_timer);
+		spin_lock_irq(lock);
 	}
 	while (atomic_read(&sig->count) > count) {
 		sig->group_exit_task = current;
@@ -659,7 +661,6 @@ static inline int de_thread(struct task_
 	}
 	sig->group_exit_task = NULL;
 	sig->notify_count = 0;
-	sig->real_timer.data = (unsigned long)current;
 	spin_unlock_irq(lock);
 
 	/*
