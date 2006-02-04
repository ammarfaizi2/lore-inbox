Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWBDTNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWBDTNT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 14:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWBDTNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 14:13:19 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:38121 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751550AbWBDTNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 14:13:18 -0500
Message-ID: <43E50EE2.2A907162@tv-sign.ru>
Date: Sat, 04 Feb 2006 23:30:26 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH rc1-mm] kill SET_LINKS/REMOVE_LINKS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Andrew, this patch can't be applied to the current -mm tree,
 I have sent you updated pidhash 1-3 patches which should go
 after this patch)

Depends on these patches:
	remove-add_parents-parent-argument.patch
	dont-use-remove_links-set_links-for-reparenting.patch

Both SET_LINKS() and SET_LINKS/REMOVE_LINKS() have exactly one
caller, and these callers already check thread_group_leader().

This patch kills theese macros, they mix two different things:
setting process's parent and registering it in init_task.tasks
list. Callers are updated to do these actions by hand.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/include/linux/sched.h~0_LINKS	2006-02-04 23:48:15.000000000 +0300
+++ RC-1/include/linux/sched.h	2006-02-04 23:50:54.000000000 +0300
@@ -1177,18 +1177,6 @@ extern void wait_task_inactive(task_t * 
 #define remove_parent(p)	list_del_init(&(p)->sibling)
 #define add_parent(p)		list_add_tail(&(p)->sibling,&(p)->parent->children)
 
-#define REMOVE_LINKS(p) do {					\
-	if (thread_group_leader(p))				\
-		list_del_init(&(p)->tasks);			\
-	remove_parent(p);					\
-	} while (0)
-
-#define SET_LINKS(p) do {					\
-	if (thread_group_leader(p))				\
-		list_add_tail(&(p)->tasks,&init_task.tasks);	\
-	add_parent(p);						\
-	} while (0)
-
 #define next_task(p)	list_entry((p)->tasks.next, struct task_struct, tasks)
 #define prev_task(p)	list_entry((p)->tasks.prev, struct task_struct, tasks)
 
--- RC-1/kernel/fork.c~0_LINKS	2006-02-04 23:31:47.000000000 +0300
+++ RC-1/kernel/fork.c	2006-02-04 23:43:16.000000000 +0300
@@ -1131,7 +1131,7 @@ static task_t *copy_process(unsigned lon
 	 */
 	p->ioprio = current->ioprio;
 
-	SET_LINKS(p);
+	add_parent(p);
 	if (unlikely(p->ptrace & PT_PTRACED))
 		__ptrace_link(p, current->parent);
 
@@ -1143,6 +1143,8 @@ static task_t *copy_process(unsigned lon
 		p->signal->session = current->signal->session;
 		attach_pid(p, PIDTYPE_PGID, process_group(p));
 		attach_pid(p, PIDTYPE_SID, p->signal->session);
+
+		list_add_tail(&p->tasks, &init_task.tasks);
 		if (p->pid)
 			__get_cpu_var(process_counts)++;
 	}
--- RC-1/kernel/exit.c~0_LINKS	2006-02-04 23:31:47.000000000 +0300
+++ RC-1/kernel/exit.c	2006-02-04 23:45:14.000000000 +0300
@@ -52,11 +52,13 @@ static void __unhash_process(struct task
 	if (thread_group_leader(p)) {
 		detach_pid(p, PIDTYPE_PGID);
 		detach_pid(p, PIDTYPE_SID);
+
+		list_del_init(&p->tasks);
 		if (p->pid)
 			__get_cpu_var(process_counts)--;
 	}
 
-	REMOVE_LINKS(p);
+	remove_parent(p);
 }
 
 void release_task(struct task_struct * p)
