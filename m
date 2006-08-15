Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbWHOSYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWHOSYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030444AbWHOSYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:24:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17630 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030447AbWHOSYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:24:10 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/7] pid: Implement access helpers for a tacks various process groups.
Date: Tue, 15 Aug 2006 12:23:06 -0600
Message-Id: <11556661922952-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

task_session returns the struct pid of a tasks session.
task_pgrp    returns the struct pid of a tasks process group.
task_tgid    returns the struct pid of a tasks thread group.
task_pid     returns the struct pid of a tasks process id.

These can be used to avoid unnecessary hash table lookups,
and to implement safe pid comparisions in the face of a
pid namespace.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/sched.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 03d96b9..6560dd3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1042,6 +1042,26 @@ static inline pid_t process_group(struct
 	return tsk->signal->pgrp;
 }
 
+static inline struct pid *task_pid(struct task_struct *task)
+{
+	return task->pids[PIDTYPE_PID].pid;
+}
+
+static inline struct pid *task_tgid(struct task_struct *task)
+{
+	return task->group_leader->pids[PIDTYPE_PID].pid;
+}
+
+static inline struct pid *task_pgrp(struct task_struct *task)
+{
+	return task->group_leader->pids[PIDTYPE_PGID].pid;
+}
+
+static inline struct pid *task_session(struct task_struct *task)
+{
+	return task->group_leader->pids[PIDTYPE_SID].pid;
+}
+
 /**
  * pid_alive - check that a task structure is not stale
  * @p: Task structure to be checked.
-- 
1.4.2.rc3.g7e18e-dirty

