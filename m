Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVKNVdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVKNVdY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVKNVdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:33:23 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:54741 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932150AbVKNVcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:32:52 -0500
Message-Id: <20051114212528.571248000@sergelap>
References: <20051114212341.724084000@sergelap>
Date: Mon, 14 Nov 2005 15:23:49 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [RFC] [PATCH 08/13] Change pid accesses: mm/
Content-Disposition: inline; filename=B7-change-pid-tgid-references-mm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace-Subject: Change pid accesses: mm/
From: Serge Hallyn <serue@us.ibm.com>

Change pid accesses for mm/.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 mm/nommu.c    |   14 +++++++-------
 mm/oom_kill.c |   10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

Index: linux-2.6.15-rc1/mm/nommu.c
===================================================================
--- linux-2.6.15-rc1.orig/mm/nommu.c
+++ linux-2.6.15-rc1/mm/nommu.c
@@ -264,7 +264,7 @@ static void show_process_blocks(void)
 {
 	struct vm_list_struct *vml;
 
-	printk("Process blocks %d:", current->pid);
+	printk("Process blocks %d:", task_pid(current));
 
 	for (vml = &current->mm->context.vmlist; vml; vml = vml->next) {
 		printk(" %p: %p", vml, vml->vma);
@@ -380,7 +380,7 @@ static int validate_mmap_request(struct 
 	if (flags & MAP_FIXED || addr) {
 		printk(KERN_DEBUG
 		       "%d: Can't do fixed-address/overlay mmap of RAM\n",
-		       current->pid);
+		       task_pid(current));
 		return -EINVAL;
 	}
 
@@ -626,7 +626,7 @@ static int do_mmap_private(struct vm_are
 #ifdef WARN_ON_SLACK
 	if (len + WARN_ON_SLACK <= kobjsize(result))
 		printk("Allocation of %lu bytes from process %d has %lu bytes of slack\n",
-		       len, current->pid, kobjsize(result) - len);
+		       len, task_pid(current), kobjsize(result) - len);
 #endif
 
 	if (vma->vm_file) {
@@ -663,7 +663,7 @@ error_free:
 
 enomem:
 	printk("Allocation of length %lu from process %d failed\n",
-	       len, current->pid);
+	       len, task_pid(current));
 	show_free_areas();
 	return -ENOMEM;
 }
@@ -855,13 +855,13 @@ unsigned long do_mmap_pgoff(struct file 
 	up_write(&nommu_vma_sem);
 	kfree(vml);
 	printk("Allocation of vma for %lu byte allocation from process %d failed\n",
-	       len, current->pid);
+	       len, task_pid(current));
 	show_free_areas();
 	return -ENOMEM;
 
  error_getting_vml:
 	printk("Allocation of vml for %lu byte allocation from process %d failed\n",
-	       len, current->pid);
+	       len, task_pid(current));
 	show_free_areas();
 	return -ENOMEM;
 }
@@ -915,7 +915,7 @@ int do_munmap(struct mm_struct *mm, unsi
 			goto found;
 
 	printk("munmap of non-mmaped memory by process %d (%s): %p\n",
-	       current->pid, current->comm, (void *) addr);
+	       task_pid(current), current->comm, (void *) addr);
 	return -EINVAL;
 
  found:
Index: linux-2.6.15-rc1/mm/oom_kill.c
===================================================================
--- linux-2.6.15-rc1.orig/mm/oom_kill.c
+++ linux-2.6.15-rc1/mm/oom_kill.c
@@ -125,7 +125,7 @@ unsigned long badness(struct task_struct
 
 #ifdef DEBUG
 	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
-	p->pid, p->comm, points);
+	task_pid(p), p->comm, points);
 #endif
 	return points;
 }
@@ -149,7 +149,7 @@ static struct task_struct * select_bad_p
 		int releasing;
 
 		/* skip the init task with pid == 1 */
-		if (p->pid == 1)
+		if (task_pid(p) == 1)
 			continue;
 		if (p->oomkilladj == OOM_DISABLE)
 			continue;
@@ -184,7 +184,7 @@ static struct task_struct * select_bad_p
  */
 static void __oom_kill_task(task_t *p)
 {
-	if (p->pid == 1) {
+	if (task_pid(p) == 1) {
 		WARN_ON(1);
 		printk(KERN_WARNING "tried to kill init!\n");
 		return;
@@ -199,7 +199,7 @@ static void __oom_kill_task(task_t *p)
 	}
 	task_unlock(p);
 	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n",
-							p->pid, p->comm);
+							task_pid(p), p->comm);
 
 	/*
 	 * We give our sacrificial lamb high priority and access to
@@ -230,7 +230,7 @@ static struct mm_struct *oom_kill_task(t
 	 * but are in a different thread group
 	 */
 	do_each_thread(g, q)
-		if (q->mm == mm && q->tgid != p->tgid)
+		if (q->mm == mm && task_tgid(q) != task_tgid(p))
 			__oom_kill_task(q);
 	while_each_thread(g, q);
 

--

