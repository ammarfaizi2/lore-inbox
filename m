Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWHVIiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWHVIiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWHVIiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:38:50 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53910 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751363AbWHVIis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:38:48 -0400
Date: Tue, 22 Aug 2006 17:41:52 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com
Subject: [RFC][PATCH] ps command race fix take2 [3/4] profile fix
Message-Id: <20060822174152.7105aa33.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oprofile driver touches task->tasks.
But it doesn't have to use task->tasks, just list_head is needed.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 drivers/oprofile/buffer_sync.c |    6 +++---
 include/linux/sched.h          |    4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

Index: linux-2.6.18-rc4/include/linux/sched.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/sched.h
+++ linux-2.6.18-rc4/include/linux/sched.h
@@ -808,6 +808,10 @@ struct task_struct {
 	struct list_head ptrace_children;
 	struct list_head ptrace_list;
 
+#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
+	struct list_head 	dead_tasks;
+#endif
+
 	struct mm_struct *mm, *active_mm;
 
 /* task state */
Index: linux-2.6.18-rc4/drivers/oprofile/buffer_sync.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/oprofile/buffer_sync.c
+++ linux-2.6.18-rc4/drivers/oprofile/buffer_sync.c
@@ -51,7 +51,7 @@ static int task_free_notify(struct notif
 	unsigned long flags;
 	struct task_struct * task = data;
 	spin_lock_irqsave(&task_mortuary, flags);
-	list_add(&task->tasks, &dying_tasks);
+	list_add(&task->dead_tasks, &dying_tasks);
 	spin_unlock_irqrestore(&task_mortuary, flags);
 	return NOTIFY_OK;
 }
@@ -446,8 +446,8 @@ static void process_task_mortuary(void)
 
 	spin_unlock_irqrestore(&task_mortuary, flags);
 
-	list_for_each_entry_safe(task, ttask, &local_dead_tasks, tasks) {
-		list_del(&task->tasks);
+	list_for_each_entry_safe(task, ttask, &local_dead_tasks, dead_tasks) {
+		list_del(&task->dead_tasks);
 		free_task(task);
 	}
 }

