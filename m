Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWBCSPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWBCSPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWBCSPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:15:08 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:26319 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751309AbWBCSPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:15:06 -0500
Message-ID: <43E3AFBD.5E7FA622@tv-sign.ru>
Date: Fri, 03 Feb 2006 22:32:13 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] remove add_parent()'s parent argument
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(this patch doesn't conflict with any of Eric's patches)

add_parent(p, parent) is always called with parent == p->parent,
and it makes no sense to do it differently. This patch removes
this argument.

No changes in affected .o files.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- RC-1/include/linux/sched.h~1_ADD	2006-02-04 00:10:57.000000000 +0300
+++ RC-1/include/linux/sched.h	2006-02-04 00:25:39.000000000 +0300
@@ -1175,7 +1175,7 @@ extern void wait_task_inactive(task_t * 
 #endif
 
 #define remove_parent(p)	list_del_init(&(p)->sibling)
-#define add_parent(p, parent)	list_add_tail(&(p)->sibling,&(parent)->children)
+#define add_parent(p)		list_add_tail(&(p)->sibling,&(p)->parent->children)
 
 #define REMOVE_LINKS(p) do {					\
 	if (thread_group_leader(p))				\
@@ -1186,7 +1186,7 @@ extern void wait_task_inactive(task_t * 
 #define SET_LINKS(p) do {					\
 	if (thread_group_leader(p))				\
 		list_add_tail(&(p)->tasks,&init_task.tasks);	\
-	add_parent(p, (p)->parent);				\
+	add_parent(p);						\
 	} while (0)
 
 #define next_task(p)	list_entry((p)->tasks.next, struct task_struct, tasks)
--- RC-1/kernel/exit.c~1_ADD	2006-02-04 00:23:41.000000000 +0300
+++ RC-1/kernel/exit.c	2006-02-04 00:28:49.000000000 +0300
@@ -1251,7 +1251,7 @@ bail_ref:
 
 	/* move to end of parent's list to avoid starvation */
 	remove_parent(p);
-	add_parent(p, p->parent);
+	add_parent(p);
 
 	write_unlock_irq(&tasklist_lock);
 
--- RC-1/fs/exec.c~1_ADD	2006-02-02 00:39:40.000000000 +0300
+++ RC-1/fs/exec.c	2006-02-04 00:29:58.000000000 +0300
@@ -715,8 +715,8 @@ static int de_thread(struct task_struct 
 		current->group_leader = current;
 		leader->group_leader = leader;
 
-		add_parent(current, current->parent);
-		add_parent(leader, leader->parent);
+		add_parent(current);
+		add_parent(leader);
 		if (ptrace) {
 			current->ptrace = ptrace;
 			__ptrace_link(current, parent);
--- RC-1/arch/mips/kernel/irixsig.c~1_ADD	2005-12-06 23:34:07.000000000 +0300
+++ RC-1/arch/mips/kernel/irixsig.c	2006-02-04 00:30:59.000000000 +0300
@@ -603,7 +603,7 @@ repeat:
 			/* move to end of parent's list to avoid starvation */
 			write_lock_irq(&tasklist_lock);
 			remove_parent(p);
-			add_parent(p, p->parent);
+			add_parent(p);
 			write_unlock_irq(&tasklist_lock);
 			retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
 			if (retval)
@@ -643,7 +643,7 @@ repeat:
 				write_lock_irq(&tasklist_lock);
 				remove_parent(p);
 				p->parent = p->real_parent;
-				add_parent(p, p->parent);
+				add_parent(p);
 				do_notify_parent(p, SIGCHLD);
 				write_unlock_irq(&tasklist_lock);
 			} else
