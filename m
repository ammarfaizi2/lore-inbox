Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVI2Pqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVI2Pqi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVI2Pqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:46:38 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:450 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932139AbVI2Pqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:46:37 -0400
Message-ID: <433C0F3D.30C19186@tv-sign.ru>
Date: Thu, 29 Sep 2005 19:58:53 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix TASK_STOPPED vs TASK_NONINTERACTIVE interaction
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_signal_stop:

	for_each_thread(t) {
		if (t->state < TASK_STOPPED)
			++sig->group_stop_count;
	}

However, TASK_NONINTERACTIVE > TASK_STOPPED, so this loop will not
count TASK_INTERRUPTIBLE | TASK_NONINTERACTIVE threads.

See also wait_task_stopped(), which checks ->state > TASK_STOPPED.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc2/include/linux/sched.h~6_NONINT	2005-09-24 18:33:51.000000000 +0400
+++ 2.6.14-rc2/include/linux/sched.h	2005-09-29 23:42:25.000000000 +0400
@@ -110,11 +110,11 @@ extern unsigned long nr_iowait(void);
 #define TASK_RUNNING		0
 #define TASK_INTERRUPTIBLE	1
 #define TASK_UNINTERRUPTIBLE	2
-#define TASK_STOPPED		4
-#define TASK_TRACED		8
-#define EXIT_ZOMBIE		16
-#define EXIT_DEAD		32
-#define TASK_NONINTERACTIVE	64
+#define TASK_NONINTERACTIVE	4
+#define TASK_STOPPED		8
+#define TASK_TRACED		16
+#define EXIT_ZOMBIE		32
+#define EXIT_DEAD		64
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
