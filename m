Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVCNSTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVCNSTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVCNSQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:16:59 -0500
Received: from everest.2mbit.com ([24.123.221.2]:18120 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261661AbVCNSOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:14:43 -0500
Date: Mon, 14 Mar 2005 13:14:42 -0500
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] oom_kill fix
Message-ID: <20050314181442.GA31020@everest.sosdg.org>
Reply-To: coywolf@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

This oom_kill fix is to do mmput(mm) a bit earlier and returning 0 or 1
to indicate success or failure instead of returning mm_struct pointer. 

	Coywolf


Signed-off-by: Coywolf Qi Hunt <coywolf@gmail.com>
 oom_kill.c |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)
diff -Nrup 2.6.11/mm/oom_kill.c 2.6.11-cy/mm/oom_kill.c
--- 2.6.11/mm/oom_kill.c	2005-03-03 17:12:18.000000000 +0800
+++ 2.6.11-cy/mm/oom_kill.c	2005-03-15 00:28:32.000000000 +0800
@@ -202,16 +202,16 @@ static void __oom_kill_task(task_t *p)
 	force_sig(SIGKILL, p);
 }
 
-static struct mm_struct *oom_kill_task(task_t *p)
+static int oom_kill_task(task_t *p)
 {
 	struct mm_struct *mm = get_task_mm(p);
 	task_t * g, * q;
 
 	if (!mm)
-		return NULL;
+		return 0;
 	if (mm == &init_mm) {
 		mmput(mm);
-		return NULL;
+		return 0;
 	}
 
 	__oom_kill_task(p);
@@ -224,12 +224,12 @@ static struct mm_struct *oom_kill_task(t
 			__oom_kill_task(q);
 	while_each_thread(g, q);
 
-	return mm;
+	mmput(mm);
+	return 1;
 }
 
-static struct mm_struct *oom_kill_process(struct task_struct *p)
+static int oom_kill_process(struct task_struct *p)
 {
- 	struct mm_struct *mm;
 	struct task_struct *c;
 	struct list_head *tsk;
 
@@ -238,9 +238,8 @@ static struct mm_struct *oom_kill_proces
 		c = list_entry(tsk, struct task_struct, sibling);
 		if (c->mm == p->mm)
 			continue;
-		mm = oom_kill_task(c);
-		if (mm)
-			return mm;
+		if (oom_kill_task(c))
+			return 1;
 	}
 	return oom_kill_task(p);
 }
@@ -255,7 +254,6 @@ static struct mm_struct *oom_kill_proces
  */
 void out_of_memory(int gfp_mask)
 {
-	struct mm_struct *mm = NULL;
 	task_t * p;
 
 	read_lock(&tasklist_lock);
@@ -274,14 +272,11 @@ retry:
 
 	printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
 	show_free_areas();
-	mm = oom_kill_process(p);
-	if (!mm)
+	if (!oom_kill_process(p))
 		goto retry;
 
  out:
 	read_unlock(&tasklist_lock);
-	if (mm)
-		mmput(mm);
 
 	/*
 	 * Give "p" a good chance of killing itself before we
