Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWDMMkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWDMMkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 08:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWDMMkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 08:40:46 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:4546 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S964905AbWDMMkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 08:40:46 -0400
Date: Thu, 13 Apr 2006 20:37:27 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pids: simplify do_each_task_pid/while_each_task_pid
Message-ID: <20060413163727.GA1365@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simpllify do_each_task_pid/while_each_task_pid macros.
This also makes the code a bit smaller.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/include/linux/pid.h~	2006-03-23 22:48:10.000000000 +0300
+++ MM/include/linux/pid.h	2006-04-13 20:28:53.000000000 +0400
@@ -99,21 +99,16 @@ extern void FASTCALL(free_pid(struct pid
 			pids[(type)].node)
 
 
-/* We could use hlist_for_each_entry_rcu here but it takes more arguments
- * than the do_each_task_pid/while_each_task_pid.  So we roll our own
- * to preserve the existing interface.
- */
-#define do_each_task_pid(who, type, task)				\
-	if ((task = find_task_by_pid_type(type, who))) {		\
-		prefetch(pid_next(task, type));				\
-		do {
-
-#define while_each_task_pid(who, type, task)				\
-		} while (pid_next(task, type) &&  ({			\
-				task = pid_next_task(task, type);	\
-				rcu_dereference(task);			\
-				prefetch(pid_next(task, type));		\
-				1; }) );				\
-	}
+#define do_each_task_pid(who, type, task)					\
+	do {									\
+		struct hlist_node *pos___;					\
+		struct pid *pid___ = find_pid(who);				\
+		if (pid___ != NULL)						\
+			hlist_for_each_entry_rcu((task), pos___,		\
+				&pid___->tasks[type], pids[type].node) {
+
+#define while_each_task_pid(who, type, task)					\
+			}							\
+	} while (0)
 
 #endif /* _LINUX_PID_H */

