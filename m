Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWDOADc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWDOADc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 20:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWDOADc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 20:03:32 -0400
Received: from smtp-3.llnl.gov ([128.115.41.83]:37509 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S1751333AbWDOADb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 20:03:31 -0400
From: Dave Peterson <dsp@llnl.gov>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] mm: fix mm_struct reference counting bugs in mm/oom_kill.c
Date: Fri, 14 Apr 2006 17:00:21 -0700
User-Agent: KMail/1.5.3
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, riel@surriel.com
References: <200604131452.08292.dsp@llnl.gov> <20060414143109.5d537091.akpm@osdl.org> <200604141652.59909.dsp@llnl.gov>
In-Reply-To: <200604141652.59909.dsp@llnl.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604141700.21128.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes oom_kill_task() so it doesn't call mmput()
(which may sleep) while holding tasklist_lock.

Signed-Off-By: David S. Peterson <dsp@llnl.gov>
---

On Friday 14 April 2006 16:52, I wrote:
> Below is a revised version of my previous OOM killer patch.  I expect
> to be away from my computer until Monday, 4/24.  If you have any
> problems merging this into your tree, let me know and I'll fix things
> up when I get back.

Arrgghh... I sent the wrong patch by mistake.  Please ignore the previous
one and merge the patch below instead.

Thanks,
Dave



Index: work/mm/oom_kill.c
===================================================================
--- work.orig/mm/oom_kill.c	2006-04-14 16:21:05.000000000 -0700
+++ work/mm/oom_kill.c	2006-04-14 16:34:31.000000000 -0700
@@ -254,17 +254,24 @@ static void __oom_kill_task(task_t *p, c
 	force_sig(SIGKILL, p);
 }
 
-static struct mm_struct *oom_kill_task(task_t *p, const char *message)
+static int oom_kill_task(task_t *p, const char *message)
 {
-	struct mm_struct *mm = get_task_mm(p);
+	struct mm_struct *mm;
 	task_t * g, * q;
 
-	if (!mm)
-		return NULL;
-	if (mm == &init_mm) {
-		mmput(mm);
-		return NULL;
-	}
+	mm = p->mm;
+
+	/* WARNING: mm may not be dereferenced since we did not obtain its
+	 * value from get_task_mm(p).  This is OK since all we need to do is
+	 * compare mm to q->mm below.
+	 *
+	 * Furthermore, even if mm contains a non-NULL value, p->mm may
+	 * change to NULL at any time since we do not hold task_lock(p).
+	 * However, this is of no concern to us.
+	 */
+
+	if (mm == NULL || mm == &init_mm)
+		return 1;
 
 	__oom_kill_task(p, message);
 	/*
@@ -276,13 +283,12 @@ static struct mm_struct *oom_kill_task(t
 			__oom_kill_task(q, message);
 	while_each_thread(g, q);
 
-	return mm;
+	return 0;
 }
 
-static struct mm_struct *oom_kill_process(struct task_struct *p,
-				unsigned long points, const char *message)
+static int oom_kill_process(struct task_struct *p, unsigned long points,
+		const char *message)
 {
- 	struct mm_struct *mm;
 	struct task_struct *c;
 	struct list_head *tsk;
 
@@ -293,9 +299,8 @@ static struct mm_struct *oom_kill_proces
 		c = list_entry(tsk, struct task_struct, sibling);
 		if (c->mm == p->mm)
 			continue;
-		mm = oom_kill_task(c, message);
-		if (mm)
-			return mm;
+		if (!oom_kill_task(c, message))
+			return 0;
 	}
 	return oom_kill_task(p, message);
 }
@@ -310,7 +315,6 @@ static struct mm_struct *oom_kill_proces
  */
 void out_of_memory(struct zonelist *zonelist, gfp_t gfp_mask, int order)
 {
-	struct mm_struct *mm = NULL;
 	task_t *p;
 	unsigned long points = 0;
 
@@ -330,12 +334,12 @@ void out_of_memory(struct zonelist *zone
 	 */
 	switch (constrained_alloc(zonelist, gfp_mask)) {
 	case CONSTRAINT_MEMORY_POLICY:
-		mm = oom_kill_process(current, points,
+		oom_kill_process(current, points,
 				"No available memory (MPOL_BIND)");
 		break;
 
 	case CONSTRAINT_CPUSET:
-		mm = oom_kill_process(current, points,
+		oom_kill_process(current, points,
 				"No available memory in cpuset");
 		break;
 
@@ -357,8 +361,7 @@ retry:
 			panic("Out of memory and no killable processes...\n");
 		}
 
-		mm = oom_kill_process(p, points, "Out of memory");
-		if (!mm)
+		if (oom_kill_process(p, points, "Out of memory"))
 			goto retry;
 
 		break;
@@ -367,8 +370,6 @@ retry:
 out:
 	read_unlock(&tasklist_lock);
 	cpuset_unlock();
-	if (mm)
-		mmput(mm);
 
 	/*
 	 * Give "p" a good chance of killing itself before we


