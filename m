Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269399AbUINPc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269399AbUINPc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269384AbUINPcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:32:55 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:49938 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S269404AbUINPcI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:32:08 -0400
Date: Tue, 14 Sep 2004 16:31:48 +0100
From: John Levon <levon@movementarian.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: zwane@linuxpower.ca, oprofile-list@lists.sf.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix OProfile locking
Message-ID: <20040914153148.GA86902@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1C7FHY-000Eb4-Jr*MOsBeuW2DuQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below uses get_task_mm() as discussed. It also fixes up Anton's previous
patch. Zwane's soaked this patch all night w/o problems.

regards
john


Index: linux-cvs/kernel/fork.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/kernel/fork.c,v
retrieving revision 1.212
diff -u -a -p -r1.212 fork.c
--- linux-cvs/kernel/fork.c	2 Sep 2004 21:42:48 -0000	1.212
+++ linux-cvs/kernel/fork.c	13 Sep 2004 20:39:03 -0000
@@ -483,6 +483,7 @@ void mmput(struct mm_struct *mm)
 		mmdrop(mm);
 	}
 }
+EXPORT_SYMBOL_GPL(mmput);
 
 /**
  * get_task_mm - acquire a reference to the task's mm
@@ -514,6 +515,7 @@ struct mm_struct *get_task_mm(struct tas
 	task_unlock(task);
 	return mm;
 }
+EXPORT_SYMBOL_GPL(get_task_mm);
 
 /* Please note the differences between mmput and mm_release.
  * mmput is called whenever we stop holding onto a mm_struct,
Index: linux-cvs/drivers/oprofile/buffer_sync.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/drivers/oprofile/buffer_sync.c,v
retrieving revision 1.24
diff -u -a -p -r1.24 buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	27 Aug 2004 17:34:28 -0000	1.24
+++ linux-cvs/drivers/oprofile/buffer_sync.c	13 Sep 2004 20:50:51 -0000
@@ -133,7 +133,7 @@ static struct notifier_block module_load
  
 static void end_sync(void)
 {
-	end_cpu_timers();
+	end_cpu_work();
 	/* make sure we don't leak task structs */
 	process_task_mortuary();
 	process_task_mortuary();
@@ -144,7 +144,7 @@ int sync_start(void)
 {
 	int err;
 
-	start_cpu_timers();
+	start_cpu_work();
 
 	err = task_handoff_register(&task_free_nb);
 	if (err)
@@ -339,40 +339,25 @@ static void add_sample(struct mm_struct 
 	}
 }
  
- 
+
 static void release_mm(struct mm_struct * mm)
 {
-	if (mm)
-		up_read(&mm->mmap_sem);
+	if (!mm)
+		return;
+	up_read(&mm->mmap_sem);
+	mmput(mm);
 }
 
 
-/* Take the task's mmap_sem to protect ourselves from
- * races when we do lookup_dcookie().
- */
 static struct mm_struct * take_tasks_mm(struct task_struct * task)
 {
-	struct mm_struct * mm;
-       
-	/* Subtle. We don't need to keep a reference to this task's mm,
-	 * because, for the mm to be freed on another CPU, that would have
-	 * to go through the task exit notifier, which ends up sleeping
-	 * on the buffer_sem we hold, so we end up with mutual exclusion
-	 * anyway.
-	 */
-	task_lock(task);
-	mm = task->mm;
-	task_unlock(task);
- 
-	if (mm) {
-		/* needed to walk the task's VMAs */
+	struct mm_struct * mm = get_task_mm(task);
+	if (mm)
 		down_read(&mm->mmap_sem);
-	}
- 
 	return mm;
 }
- 
- 
+
+
 static inline int is_ctx_switch(unsigned long val)
 {
 	return val == ~0UL;
Index: linux-cvs/drivers/oprofile/cpu_buffer.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/drivers/oprofile/cpu_buffer.c,v
retrieving revision 1.15
diff -u -a -p -r1.15 cpu_buffer.c
--- linux-cvs/drivers/oprofile/cpu_buffer.c	8 Sep 2004 14:57:38 -0000	1.15
+++ linux-cvs/drivers/oprofile/cpu_buffer.c	13 Sep 2004 20:45:29 -0000
@@ -30,7 +30,7 @@ struct oprofile_cpu_buffer cpu_buffer[NR
 static void wq_sync_buffer(void *);
 
 #define DEFAULT_TIMER_EXPIRE (HZ / 10)
-int timers_enabled;
+int work_enabled;
 
 static void __free_cpu_buffers(int num)
 {
@@ -80,11 +80,11 @@ void free_cpu_buffers(void)
 }
 
 
-void start_cpu_timers(void)
+void start_cpu_work(void)
 {
 	int i;
 
-	timers_enabled = 1;
+	work_enabled = 1;
 
 	for_each_online_cpu(i) {
 		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
@@ -98,11 +98,11 @@ void start_cpu_timers(void)
 }
 
 
-void end_cpu_timers(void)
+void end_cpu_work(void)
 {
 	int i;
 
-	timers_enabled = 0;
+	work_enabled = 0;
 
 	for_each_online_cpu(i) {
 		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
@@ -220,6 +220,6 @@ static void wq_sync_buffer(void * data)
 	sync_buffer(b->cpu);
 
 	/* don't re-add the work if we're shutting down */
-	if (timers_enabled)
+	if (work_enabled)
 		schedule_delayed_work(&b->work, DEFAULT_TIMER_EXPIRE);
 }
Index: linux-cvs/drivers/oprofile/cpu_buffer.h
===================================================================
RCS file: /home/moz/cvs//linux-2.5/drivers/oprofile/cpu_buffer.h,v
retrieving revision 1.7
diff -u -a -p -r1.7 cpu_buffer.h
--- linux-cvs/drivers/oprofile/cpu_buffer.h	8 Sep 2004 14:57:38 -0000	1.7
+++ linux-cvs/drivers/oprofile/cpu_buffer.h	13 Sep 2004 20:45:26 -0000
@@ -20,8 +20,8 @@ struct task_struct;
 int alloc_cpu_buffers(void);
 void free_cpu_buffers(void);
 
-void start_cpu_timers(void);
-void end_cpu_timers(void);
+void start_cpu_work(void);
+void end_cpu_work(void);
 
 /* CPU buffer is composed of such entries (which are
  * also used for context switch notes)
