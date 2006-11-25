Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935144AbWKYEsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935144AbWKYEsR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 23:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935145AbWKYEsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 23:48:17 -0500
Received: from nacho.alt.net ([207.14.113.18]:27068 "HELO nacho.alt.net")
	by vger.kernel.org with SMTP id S935144AbWKYEsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 23:48:17 -0500
Date: Sat, 25 Nov 2006 04:48:15 +0000 (GMT)
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH 2.6.19-rc6] sched: cleanup output of show_state/show_task
Message-ID: <Pine.LNX.4.64.0611250416240.10489@nacho.alt.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
From: Chris Caputo <ccaputo@alt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Caputo <ccaputo@alt.net>
[PATCH 2.6.19-rc6] sched: cleanup output of show_state/show_task

This patch cleans up the output of show_state/task() (aka magic-sysrq-t) 
so that free stack space is printed as appropriate based on 
CONFIG_DEBUG_STACK_USAGE.

Also, without this patch the header is not aligned with the data and is 
thus confusing.  Free stack is labeled as pid, pid is labeled as father, 
and so on.

Signed-off-by: Chris Caputo <ccaputo@alt.net>
---

diff -uprN a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	2006-11-25 04:11:12.000000000 +0000
+++ b/kernel/sched.c	2006-11-25 04:13:07.000000000 +0000
@@ -4757,7 +4757,6 @@ static const char stat_nam[] = "RSDTtZX"
 static void show_task(struct task_struct *p)
 {
 	struct task_struct *relative;
-	unsigned long free = 0;
 	unsigned state;
 
 	state = p->state ? __ffs(p->state) + 1 : 0;
@@ -4779,10 +4778,10 @@ static void show_task(struct task_struct
 		unsigned long *n = end_of_stack(p);
 		while (!*n)
 			n++;
-		free = (unsigned long)n - (unsigned long)end_of_stack(p);
+		printk("%5lu ", (unsigned long)n - (unsigned long)end_of_stack(p));
 	}
 #endif
-	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
+	printk("%5d %6d ", p->pid, p->parent->pid);
 	if ((relative = eldest_child(p)))
 		printk("%5d ", relative->pid);
 	else
@@ -4808,14 +4807,18 @@ void show_state(void)
 {
 	struct task_struct *g, *p;
 
-#if (BITS_PER_LONG == 32)
+#ifdef CONFIG_DEBUG_STACK_USAGE
 	printk("\n"
-	       "                                               sibling\n");
-	printk("  task             PC      pid father child younger older\n");
+	       "                %s free                        sibling\n",
+	       BITS_PER_LONG == 32 ? "        " : "                ");
+	printk("  task          %s stack   pid father child younger older\n",
+	       BITS_PER_LONG == 32 ? "   PC   " : "       PC       ");
 #else
 	printk("\n"
-	       "                                                       sibling\n");
-	printk("  task                 PC          pid father child younger older\n");
+	       "                %s                       sibling\n",
+	       BITS_PER_LONG == 32 ? "        " : "                ");
+	printk("  task          %s   pid father child younger older\n",
+	       BITS_PER_LONG == 32 ? "   PC   " : "       PC       ");
 #endif
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
