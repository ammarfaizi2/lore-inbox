Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWHQQwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWHQQwh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWHQQwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:52:37 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:210 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S932558AbWHQQwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:52:36 -0400
Date: Fri, 18 Aug 2006 01:16:26 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       containers@lists.osdl.org
Subject: [PATCH -mm] simplify pid iterators
Message-ID: <20060817211626.GA643@oleg>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com> <11556661923847-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11556661923847-git-send-email-ebiederm@xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of Eric's recent include/linux/pid.h changes.

I think it is hardly possible to read the current do_each_task_pid().
The new version is much simpler and makes the code smaller.

Only the do_each_task_pid change is tested, the do_each_pid_task isn't.
Eric, could you take a hard look at this patch?

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc3/include/linux/pid.h~	2006-08-16 20:40:05.000000000 +0400
+++ 2.6.18-rc3/include/linux/pid.h	2006-08-18 00:45:06.000000000 +0400
@@ -99,42 +99,29 @@ static inline pid_t pid_nr(struct pid *p
 	return nr;
 }
 
-#define pid_next(task, type)					\
-	((task)->pids[(type)].node.next)
 
-#define pid_next_task(task, type) 				\
-	hlist_entry(pid_next(task, type), struct task_struct,	\
-			pids[(type)].node)
-
-
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
-
-#define do_each_pid_task(pid, type, task)				\
-	if ((task = pid_task(pid, type))) {				\
-		prefetch(pid_next(task, type));				\
-		do {
-
-#define while_each_pid_task(pid, type, task)				\
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
+
+
+#define do_each_pid_task(pid, type, task)					\
+	do {									\
+		struct hlist_node *pos___;					\
+		if (pid != NULL)						\
+			hlist_for_each_entry_rcu((task), pos___,		\
+				&pid->tasks[type], pids[type].node) {
+
+#define while_each_pid_task(pid, type, task)					\
+			}							\
+	} while (0)
 
 #endif /* _LINUX_PID_H */

