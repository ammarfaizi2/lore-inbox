Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263482AbTECXdC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 19:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTECXbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 19:31:55 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:51720 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263473AbTECXbp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 19:31:45 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10520054473909@movementarian.org>
Subject: [PATCH 5/8] OProfile update
In-Reply-To: <10520054463981@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb
Date: Sun, 4 May 2003 00:44:07 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Spam-Score: -6.3 (------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19C6fn-0009tp-JI*SAwl7j304SE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now we don't do buffer syncs whilst holding current's mmap_sem ever,
we can wait to hold it. Also take task_lock and try to improve the docs a bit.

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/buffer_sync.c linux-me/drivers/oprofile/buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	2003-04-05 18:44:49.000000000 +0100
+++ linux-me/drivers/oprofile/buffer_sync.c	2003-05-03 20:10:44.000000000 +0100
@@ -310,26 +337,23 @@
 /* Take the task's mmap_sem to protect ourselves from
  * races when we do lookup_dcookie().
  */
-static struct mm_struct * take_task_mm(struct task_struct * task)
+static struct mm_struct * take_tasks_mm(struct task_struct * task)
 {
-	struct mm_struct * mm = task->mm;
- 
-	/* if task->mm !NULL, mm_count must be at least 1. It cannot
-	 * drop to 0 without the task exiting, which will have to sleep
-	 * on buffer_sem first. So we do not need to mark mm_count
-	 * ourselves.
+	struct mm_struct * mm;
+       
+	/* Subtle. We don't need to keep a reference to this task's mm,
+	 * because, for the mm to be freed on another CPU, that would have
+	 * to go through the task exit notifier, which ends up sleeping
+	 * on the buffer_sem we hold, so we end up with mutual exclusion
+	 * anyway.
 	 */
+	task_lock(task);
+	mm = task->mm;
+	task_unlock(task);
+ 
 	if (mm) {
-		/* More ugliness. If a task took its mmap
-		 * sem then came to sleep on buffer_sem we
-		 * will deadlock waiting for it. So we can
-		 * but try. This will lose samples :/
-		 */
-		if (!down_read_trylock(&mm->mmap_sem)) {
-			/* FIXME: this underestimates samples lost */
-			atomic_inc(&oprofile_stats.sample_lost_mmap_sem);
-			mm = NULL;
-		}
+		/* needed to walk the task's VMAs */
+		down_read(&mm->mmap_sem);
 	}
  
 	return mm;
@@ -399,7 +423,7 @@
 				new = (struct task_struct *)s->event;
 
 				release_mm(mm);
-				mm = take_task_mm(new);
+				mm = take_tasks_mm(new);
 
 				cookie = get_exec_dcookie(mm);
 				add_user_ctx_switch(new->pid, cookie);
@@ -460,4 +484,3 @@
 	schedule_work(&sync_wq);
 	/* timer is re-added by the scheduled task */
 }
-

