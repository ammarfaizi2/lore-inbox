Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbWHOSYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbWHOSYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbWHOSYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:24:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15582 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030441AbWHOSYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:24:06 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/7] pid: Add do_each_pid_task
Date: Tue, 15 Aug 2006 12:23:07 -0600
Message-Id: <11556661923847-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid pid rollover confusion the kernel needs to work with
struct pid * instead of pid_t.  Currently there is not an iterator
that walks through all of the tasks of a given pid type starting
with a struct pid.  This prevents us replacing some pid_t instances
with struct pid.  So this patch adds do_each_pid_task which walks
through the set of task for a given pid type starting with a struct pid.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/pid.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 93da7e2..4007114 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -118,4 +118,17 @@ #define while_each_task_pid(who, type, t
 				1; }) );				\
 	}
 
+#define do_each_pid_task(pid, type, task)				\
+	if ((task = pid_task(pid, type))) {				\
+		prefetch(pid_next(task, type));				\
+		do {
+
+#define while_each_pid_task(pid, type, task)				\
+		} while (pid_next(task, type) &&  ({			\
+				task = pid_next_task(task, type);	\
+				rcu_dereference(task);			\
+				prefetch(pid_next(task, type));		\
+				1; }) );				\
+	}
+
 #endif /* _LINUX_PID_H */
-- 
1.4.2.rc3.g7e18e-dirty

