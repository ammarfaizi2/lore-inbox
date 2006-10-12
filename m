Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWJLOKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWJLOKB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 10:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWJLOKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 10:10:01 -0400
Received: from mx1.suse.de ([195.135.220.2]:63168 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751420AbWJLOJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 10:09:56 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>
Message-Id: <20061012120120.29671.22341.sendpatchset@linux.site>
In-Reply-To: <20061012120102.29671.31163.sendpatchset@linux.site>
References: <20061012120102.29671.31163.sendpatchset@linux.site>
Subject: [patch 2/5] oom: cleanup messages
Date: Thu, 12 Oct 2006 16:09:52 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the OOM killer messages to be more consistent.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/oom_kill.c
===================================================================
--- linux-2.6.orig/mm/oom_kill.c
+++ linux-2.6/mm/oom_kill.c
@@ -263,7 +263,7 @@ static struct task_struct *select_bad_pr
  * flag though it's unlikely that  we select a process with CAP_SYS_RAW_IO
  * set.
  */
-static void __oom_kill_task(struct task_struct *p, const char *message)
+static void __oom_kill_task(struct task_struct *p, int verbose)
 {
 	if (is_init(p)) {
 		WARN_ON(1);
@@ -277,10 +277,8 @@ static void __oom_kill_task(struct task_
 		return;
 	}
 
-	if (message) {
-		printk(KERN_ERR "%s: Killed process %d (%s).\n",
-				message, p->pid, p->comm);
-	}
+	if (verbose)
+		printk(KERN_ERR "Killed process %d (%s).\n", p->pid, p->comm);
 
 	/*
 	 * We give our sacrificial lamb high priority and access to
@@ -293,7 +291,7 @@ static void __oom_kill_task(struct task_
 	force_sig(SIGKILL, p);
 }
 
-static int oom_kill_task(struct task_struct *p, const char *message)
+static int oom_kill_task(struct task_struct *p)
 {
 	struct mm_struct *mm;
 	struct task_struct *g, *q;
@@ -320,15 +318,15 @@ static int oom_kill_task(struct task_str
 			return 1;
 	} while_each_thread(g, q);
 
-	__oom_kill_task(p, message);
+	__oom_kill_task(p, 1);
 
 	/*
 	 * kill all processes that share the ->mm (i.e. all threads),
-	 * but are in a different thread group
+	 * but are in a different thread group.
 	 */
 	do_each_thread(g, q) {
 		if (q->mm == mm && q->tgid != p->tgid)
-			__oom_kill_task(q, message);
+			__oom_kill_task(q, 1);
 	} while_each_thread(g, q);
 
 	return 0;
@@ -345,21 +343,22 @@ static int oom_kill_process(struct task_
 	 * its children or threads, just set TIF_MEMDIE so it can die quickly
 	 */
 	if (p->flags & PF_EXITING) {
-		__oom_kill_task(p, NULL);
+		__oom_kill_task(p, 0);
 		return 0;
 	}
 
-	printk(KERN_ERR "Out of Memory: Kill process %d (%s) score %li"
-			" and children.\n", p->pid, p->comm, points);
+	printk(KERN_ERR "%s: kill process %d (%s) score %li or a child.\n",
+					message, p->pid, p->comm, points);
+
 	/* Try to kill a child first */
 	list_for_each(tsk, &p->children) {
 		c = list_entry(tsk, struct task_struct, sibling);
 		if (c->mm == p->mm)
 			continue;
-		if (!oom_kill_task(c, message))
+		if (!oom_kill_task(c))
 			return 0;
 	}
-	return oom_kill_task(p, message);
+	return oom_kill_task(p);
 }
 
 static BLOCKING_NOTIFIER_HEAD(oom_notify_list);
