Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267682AbUHUT3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267682AbUHUT3V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 15:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUHUT3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 15:29:21 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:59146 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S267682AbUHUT0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 15:26:32 -0400
Date: Sat, 21 Aug 2004 20:26:30 +0100
From: John Levon <levon@movementarian.org>
To: oprofile-list@lists.sf.net, linux-kernel@vger.kernel.org
Cc: jbarnes@sgi.com, anton@samba.org, akpm@osdl.org
Subject: [PATCH] improve OProfile on many-way systems
Message-ID: <20040821192630.GA9501@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1BybVW-000A5R-Pz*bsN6nbhak5s*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anton prompted me to get this patch merged.  It changes the core buffer
sync algorithm of OProfile to avoid global locks wherever possible.
Anton tested an earlier version of this patch with some success. I've
lightly tested this applied against 2.6.8.1-mm3 on my two-way machine.

The changes also have the happy side-effect of losing less samples after
munmap operations, and removing the blind spot of tasks exiting inside
the kernel.

Andrew, please consider for -mm so I can get some wider testing.

thanks,
john


Index: linux-cvs/drivers/oprofile/buffer_sync.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/drivers/oprofile/buffer_sync.c,v
retrieving revision 1.23
diff -u -a -p -r1.23 buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	30 Jun 2004 22:51:07 -0000	1.23
+++ linux-cvs/drivers/oprofile/buffer_sync.c	21 Aug 2004 19:23:22 -0000
@@ -32,64 +32,68 @@
 #include "cpu_buffer.h"
 #include "buffer_sync.h"
  
-#define DEFAULT_EXPIRE (HZ / 4)
- 
-static void wq_sync_buffers(void *);
-static DECLARE_WORK(sync_wq, wq_sync_buffers, NULL);
- 
-static struct timer_list sync_timer;
-static void timer_ping(unsigned long data);
-static void sync_cpu_buffers(void);
+static LIST_HEAD(dying_tasks);
+static LIST_HEAD(dead_tasks);
+cpumask_t marked_cpus = CPU_MASK_NONE;
+static spinlock_t task_mortuary = SPIN_LOCK_UNLOCKED;
+void process_task_mortuary(void);
+  
 
- 
-/* We must make sure to process every entry in the CPU buffers
- * before a task got the PF_EXITING flag, otherwise we will hold
- * references to a possibly freed task_struct. We are safe with
- * samples past the PF_EXITING point in do_exit(), because we
- * explicitly check for that in cpu_buffer.c 
+/* Take ownership of the task struct and place it on the
+ * list for processing. Only after two full buffer syncs
+ * does the task eventually get freed, because by then
+ * we are sure we will not reference it again.
  */
-static int exit_task_notify(struct notifier_block * self, unsigned long val, void * data)
+static int task_free_notify(struct notifier_block * self, unsigned long val, void * data)
 {
-	sync_cpu_buffers();
-	return 0;
+	struct task_struct * task = (struct task_struct *)data;
+	spin_lock(&task_mortuary);
+	list_add(&task->tasks, &dying_tasks);
+	spin_unlock(&task_mortuary);
+	return NOTIFY_OK;
 }
- 
-/* There are two cases of tasks modifying task->mm->mmap list we
- * must concern ourselves with. First, when a task is about to
- * exit (exit_mmap()), we should process the buffer to deal with
- * any samples in the CPU buffer, before we lose the ->mmap information
- * we need. It is vital to get this case correct, otherwise we can
- * end up trying to access a freed task_struct.
+   
+
+/* The task is on its way out. A sync of the buffer means we can catch
+ * any remaining samples for this task.
  */
-static int mm_notify(struct notifier_block * self, unsigned long val, void * data)
+static int task_exit_notify(struct notifier_block * self, unsigned long val, void * data)
 {
-	sync_cpu_buffers();
-	return 0;
+	/* To avoid latency problems, we only process the current CPU,
+	 * hoping that most samples for the task are on this CPU
+	 */
+	sync_buffer(smp_processor_id());
+  	return 0;
 }
-
-
-/* Second, a task may unmap (part of) an executable mmap,
- * so we want to process samples before that happens too. This is merely
- * a QOI issue not a correctness one.
+  
+  
+/* The task is about to try a do_munmap(). We peek at what it's going to
+ * do, and if it's an executable region, process the samples first, so
+ * we don't lose any. This does not have to be exact, it's a QoI issue
+ * only.
  */
 static int munmap_notify(struct notifier_block * self, unsigned long val, void * data)
 {
-	/* Note that we cannot sync the buffers directly, because we might end up
-	 * taking the the mmap_sem that we hold now inside of event_buffer_read()
-	 * on a page fault, whilst holding buffer_sem - deadlock.
-	 *
-	 * This would mean a threaded reader of the event buffer, but we should
-	 * prevent it anyway.
-	 *
-	 * Delaying the work in a context that doesn't hold the mmap_sem means
-	 * that we won't lose samples from other mappings that current() may
-	 * have. Note that either way, we lose any pending samples for what is
-	 * being unmapped.
-	 */
-	schedule_work(&sync_wq);
+	unsigned long addr = (unsigned long)data;
+	struct mm_struct * mm = current->mm;
+	struct vm_area_struct * mpnt;
+
+	down_read(&mm->mmap_sem);
+
+	mpnt = find_vma(mm, addr);
+	if (mpnt && mpnt->vm_file && (mpnt->vm_flags & VM_EXEC)) {
+		up_read(&mm->mmap_sem);
+		/* To avoid latency problems, we only process the current CPU,
+		 * hoping that most samples for the task are on this CPU
+		 */
+		sync_buffer(smp_processor_id());
+		return 0;
+	}
+
+	up_read(&mm->mmap_sem);
 	return 0;
 }
-
+  
  
 /* We need to be told about new modules so we don't attribute to a previously
  * loaded module, or drop the samples on the floor.
@@ -100,7 +104,7 @@ static int module_load_notify(struct not
 	if (val != MODULE_STATE_COMING)
 		return 0;
 
-	sync_cpu_buffers();
+	/* FIXME: should we process all CPU buffers ? */
 	down(&buffer_sem);
 	add_event_entry(ESCAPE_CODE);
 	add_event_entry(MODULE_LOADED_CODE);
@@ -110,16 +114,16 @@ static int module_load_notify(struct not
 }
 
  
-static struct notifier_block exit_task_nb = {
-	.notifier_call	= exit_task_notify,
+static struct notifier_block task_free_nb = {
+	.notifier_call	= task_free_notify,
 };
 
-static struct notifier_block exec_unmap_nb = {
-	.notifier_call	= munmap_notify,
+static struct notifier_block task_exit_nb = {
+	.notifier_call	= task_exit_notify,
 };
 
-static struct notifier_block exit_mmap_nb = {
-	.notifier_call	= mm_notify,
+static struct notifier_block munmap_nb = {
+	.notifier_call	= munmap_notify,
 };
 
 static struct notifier_block module_load_nb = {
@@ -127,11 +131,12 @@ static struct notifier_block module_load
 };
 
  
-static void end_sync_timer(void)
+static void end_sync(void)
 {
-	del_timer_sync(&sync_timer);
-	/* timer might have queued work, make sure it's completed. */
-	flush_scheduled_work();
+	end_cpu_timers();
+	/* make sure we don't leak task structs */
+	process_task_mortuary();
+	process_task_mortuary();
 }
 
 
@@ -139,18 +144,15 @@ int sync_start(void)
 {
 	int err;
 
-	init_timer(&sync_timer);
-	sync_timer.function = timer_ping;
-	sync_timer.expires = jiffies + DEFAULT_EXPIRE;
-	add_timer(&sync_timer);
+	start_cpu_timers();
 
-	err = profile_event_register(EXIT_TASK, &exit_task_nb);
+	err = task_handoff_register(&task_free_nb);
 	if (err)
 		goto out1;
-	err = profile_event_register(EXIT_MMAP, &exit_mmap_nb);
+	err = profile_event_register(PROFILE_TASK_EXIT, &task_exit_nb);
 	if (err)
 		goto out2;
-	err = profile_event_register(EXEC_UNMAP, &exec_unmap_nb);
+	err = profile_event_register(PROFILE_MUNMAP, &munmap_nb);
 	if (err)
 		goto out3;
 	err = register_module_notifier(&module_load_nb);
@@ -160,13 +162,13 @@ int sync_start(void)
 out:
 	return err;
 out4:
-	profile_event_unregister(EXEC_UNMAP, &exec_unmap_nb);
+	profile_event_unregister(PROFILE_MUNMAP, &munmap_nb);
 out3:
-	profile_event_unregister(EXIT_MMAP, &exit_mmap_nb);
+	profile_event_unregister(PROFILE_TASK_EXIT, &task_exit_nb);
 out2:
-	profile_event_unregister(EXIT_TASK, &exit_task_nb);
+	task_handoff_unregister(&task_free_nb);
 out1:
-	end_sync_timer();
+	end_sync();
 	goto out;
 }
 
@@ -174,10 +176,10 @@ out1:
 void sync_stop(void)
 {
 	unregister_module_notifier(&module_load_nb);
-	profile_event_unregister(EXIT_TASK, &exit_task_nb);
-	profile_event_unregister(EXIT_MMAP, &exit_mmap_nb);
-	profile_event_unregister(EXEC_UNMAP, &exec_unmap_nb);
-	end_sync_timer();
+	profile_event_unregister(PROFILE_MUNMAP, &munmap_nb);
+	profile_event_unregister(PROFILE_TASK_EXIT, &task_exit_nb);
+	task_handoff_unregister(&task_free_nb);
+	end_sync();
 }
 
  
@@ -417,24 +419,80 @@ static void increment_tail(struct oprofi
 }
 
 
+/* Move tasks along towards death. Any tasks on dead_tasks
+ * will definitely have no remaining references in any
+ * CPU buffers at this point, because we use two lists,
+ * and to have reached the list, it must have gone through
+ * one full sync already.
+ */
+void process_task_mortuary(void)
+{
+	struct list_head * pos;
+	struct list_head * pos2;
+	struct task_struct * task;
+
+	spin_lock(&task_mortuary);
+
+	list_for_each_safe(pos, pos2, &dead_tasks) {
+		task = list_entry(pos, struct task_struct, tasks);
+		list_del(&task->tasks);
+		free_task(task);
+	}
+
+	list_for_each_safe(pos, pos2, &dying_tasks) {
+		task = list_entry(pos, struct task_struct, tasks);
+		list_del(&task->tasks);
+		list_add_tail(&task->tasks, &dead_tasks);
+	}
+		
+	spin_unlock(&task_mortuary);
+}
+
+
+static void mark_done(int cpu)
+{
+	int i;
+
+	cpu_set(cpu, marked_cpus);
+
+	for_each_online_cpu(i) {
+		if (!cpu_isset(i, marked_cpus))
+			return;
+	}
+
+	/* All CPUs have been processed at least once,
+	 * we can process the mortuary once
+	 */
+	process_task_mortuary();
+
+	cpus_clear(marked_cpus);
+}
+
+
 /* Sync one of the CPU's buffers into the global event buffer.
  * Here we need to go through each batch of samples punctuated
  * by context switch notes, taking the task's mmap_sem and doing
  * lookup in task->mm->mmap to convert EIP into dcookie/offset
  * value.
  */
-static void sync_buffer(struct oprofile_cpu_buffer * cpu_buf)
+void sync_buffer(int cpu)
 {
+	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[cpu];
 	struct mm_struct *mm = NULL;
 	struct task_struct * new;
 	unsigned long cookie = 0;
 	int in_kernel = 1;
 	unsigned int i;
+	unsigned long available;
+ 
+	down(&buffer_sem);
  
+	add_cpu_switch(cpu);
+
 	/* Remember, only we can modify tail_pos */
 
-	unsigned long const available = get_slots(cpu_buf);
-  
+	available = get_slots(cpu_buf);
+
 	for (i=0; i < available; ++i) {
 		struct op_sample * s = &cpu_buf->buffer[cpu_buf->tail_pos];
  
@@ -462,50 +520,8 @@ static void sync_buffer(struct oprofile_
 		increment_tail(cpu_buf);
 	}
 	release_mm(mm);
-}
- 
- 
-/* Process each CPU's local buffer into the global
- * event buffer.
- */
-static void sync_cpu_buffers(void)
-{
-	int i;
 
-	down(&buffer_sem);
- 
-	for (i = 0; i < NR_CPUS; ++i) {
-		struct oprofile_cpu_buffer * cpu_buf;
- 
-		if (!cpu_possible(i))
-			continue;
- 
-		cpu_buf = &cpu_buffer[i];
- 
-		add_cpu_switch(i);
-		sync_buffer(cpu_buf);
-	}
+	mark_done(cpu);
 
 	up(&buffer_sem);
- 
-	mod_timer(&sync_timer, jiffies + DEFAULT_EXPIRE);
-}
- 
-
-static void wq_sync_buffers(void * data)
-{
-	sync_cpu_buffers();
-}
- 
- 
-/* It is possible that we could have no munmap() or
- * other events for a period of time. This will lead
- * the CPU buffers to overflow and lose samples and
- * context switches. We try to reduce the problem
- * by timing out when nothing happens for a while.
- */
-static void timer_ping(unsigned long data)
-{
-	schedule_work(&sync_wq);
-	/* timer is re-added by the scheduled task */
 }
Index: linux-cvs/drivers/oprofile/buffer_sync.h
===================================================================
RCS file: /home/moz/cvs//linux-2.5/drivers/oprofile/buffer_sync.h,v
retrieving revision 1.2
diff -u -a -p -r1.2 buffer_sync.h
--- linux-cvs/drivers/oprofile/buffer_sync.h	16 Oct 2002 02:26:30 -0000	1.2
+++ linux-cvs/drivers/oprofile/buffer_sync.h	21 Aug 2004 19:16:40 -0000
@@ -16,4 +16,7 @@ int sync_start(void);
 /* remove the hooks */
 void sync_stop(void);
  
+/* sync the given CPU's buffer */
+void sync_buffer(int cpu);
+
 #endif /* OPROFILE_BUFFER_SYNC_H */
Index: linux-cvs/drivers/oprofile/cpu_buffer.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/drivers/oprofile/cpu_buffer.c,v
retrieving revision 1.11
diff -u -a -p -r1.11 cpu_buffer.c
--- linux-cvs/drivers/oprofile/cpu_buffer.c	30 Jun 2004 22:51:07 -0000	1.11
+++ linux-cvs/drivers/oprofile/cpu_buffer.c	21 Aug 2004 19:24:27 -0000
@@ -9,7 +9,7 @@
  * Each CPU has a local buffer that stores PC value/event
  * pairs. We also log context switches when we notice them.
  * Eventually each CPU's buffer is processed into the global
- * event buffer by sync_cpu_buffers().
+ * event buffer by sync_buffer().
  *
  * We use a local buffer for two reasons: an NMI or similar
  * interrupt cannot synchronise, and high sampling rates
@@ -22,21 +22,24 @@
 #include <linux/errno.h>
  
 #include "cpu_buffer.h"
+#include "buffer_sync.h"
 #include "oprof.h"
 
 struct oprofile_cpu_buffer cpu_buffer[NR_CPUS] __cacheline_aligned;
 
+static void wq_sync_buffer(void *);
+static void timer_ping(unsigned long data);
+#define DEFAULT_TIMER_EXPIRE (HZ / 2)
+int timers_enabled;
+
 static void __free_cpu_buffers(int num)
 {
 	int i;
  
-	for (i=0; i < num; ++i) {
-		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
- 
-		if (!cpu_possible(i)) 
+	for (i = 0; i < NR_CPUS; ++i) {
+		if (!cpu_online(i))
 			continue;
- 
-		vfree(b->buffer);
+		vfree(cpu_buffer[i].buffer);
 	}
 }
  
@@ -47,12 +50,12 @@ int alloc_cpu_buffers(void)
  
 	unsigned long buffer_size = fs_cpu_buffer_size;
  
-	for (i=0; i < NR_CPUS; ++i) {
+	for (i = 0; i < NR_CPUS; ++i) {
 		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
  
-		if (!cpu_possible(i)) 
+		if (!cpu_online(i))
 			continue;
- 
+
 		b->buffer = vmalloc(sizeof(struct op_sample) * buffer_size);
 		if (!b->buffer)
 			goto fail;
@@ -64,9 +67,15 @@ int alloc_cpu_buffers(void)
 		b->head_pos = 0;
 		b->sample_received = 0;
 		b->sample_lost_overflow = 0;
-		b->sample_lost_task_exit = 0;
+		b->cpu = i;
+		init_timer(&b->timer);
+		b->timer.function = timer_ping;
+		b->timer.data = i;
+		b->timer.expires = jiffies + DEFAULT_TIMER_EXPIRE;
+		INIT_WORK(&b->work, wq_sync_buffer, b);
 	}
 	return 0;
+
 fail:
 	__free_cpu_buffers(i);
 	return -ENOMEM;
@@ -79,6 +88,42 @@ void free_cpu_buffers(void)
 }
 
 
+void start_cpu_timers(void)
+{
+	int i;
+ 
+	timers_enabled = 1;
+
+	for (i = 0; i < NR_CPUS; ++i) {
+		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
+ 
+		if (!cpu_online(i))
+			continue;
+
+		add_timer_on(&b->timer, i);
+	}
+}
+
+
+void end_cpu_timers(void)
+{
+	int i;
+ 
+	timers_enabled = 0;
+
+	for (i = 0; i < NR_CPUS; ++i) {
+		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
+ 
+		if (!cpu_online(i))
+			continue;
+
+		del_timer_sync(&b->timer);
+	}
+
+	flush_scheduled_work();
+}
+
+
 /* compute number of available slots in cpu_buffer queue */
 static unsigned long nr_available_slots(struct oprofile_cpu_buffer const * b)
 {
@@ -145,21 +190,9 @@ void oprofile_add_sample(unsigned long e
 	/* notice a task switch */
 	if (cpu_buf->last_task != task) {
 		cpu_buf->last_task = task;
-		if (!(task->flags & PF_EXITING)) {
-			cpu_buf->buffer[cpu_buf->head_pos].eip = ~0UL;
-			cpu_buf->buffer[cpu_buf->head_pos].event = (unsigned long)task;
-			increment_head(cpu_buf);
-		}
-	}
- 
-	/* If the task is exiting it's not safe to take a sample
-	 * as the task_struct is about to be freed. We can't just
-	 * notify at release_task() time because of CLONE_DETACHED
-	 * tasks that release_task() themselves.
-	 */
-	if (task->flags & PF_EXITING) {
-		cpu_buf->sample_lost_task_exit++;
-		return;
+		cpu_buf->buffer[cpu_buf->head_pos].eip = ~0UL;
+		cpu_buf->buffer[cpu_buf->head_pos].event = (unsigned long)task;
+		increment_head(cpu_buf);
 	}
  
 	cpu_buf->buffer[cpu_buf->head_pos].eip = eip;
@@ -177,4 +210,37 @@ void cpu_buffer_reset(struct oprofile_cp
 	 */
 	cpu_buf->last_is_kernel = -1;
 	cpu_buf->last_task = NULL;
+}
+
+
+/* FIXME: not guaranteed to be on our CPU */
+static void wq_sync_buffer(void * data)
+{
+	struct oprofile_cpu_buffer * b = (struct oprofile_cpu_buffer *)data;
+	if (b->cpu != smp_processor_id()) {
+		printk("WQ on CPU%d, prefer CPU%d\n",
+		       smp_processor_id(), b->cpu);
+	}
+	sync_buffer(b->cpu);
+
+	/* don't re-add the timer if we're shutting down */
+	if (timers_enabled) {
+		del_timer_sync(&b->timer);
+		add_timer_on(&b->timer, b->cpu);
+	}
+}
+ 
+ 
+/* This serves to avoid cpu buffer overflow, and makes sure
+ * the task mortuary progresses
+ */
+static void timer_ping(unsigned long data)
+{
+	struct oprofile_cpu_buffer * b = &cpu_buffer[data];
+	if (b->cpu != smp_processor_id()) {
+		printk("Timer on CPU%d, prefer CPU%d\n",
+		       smp_processor_id(), b->cpu);
+	}
+	schedule_work(&b->work);
+	/* work will re-enable our timer */
 }
Index: linux-cvs/drivers/oprofile/cpu_buffer.h
===================================================================
RCS file: /home/moz/cvs//linux-2.5/drivers/oprofile/cpu_buffer.h,v
retrieving revision 1.5
diff -u -a -p -r1.5 cpu_buffer.h
--- linux-cvs/drivers/oprofile/cpu_buffer.h	7 Mar 2003 15:39:16 -0000	1.5
+++ linux-cvs/drivers/oprofile/cpu_buffer.h	21 Aug 2004 19:16:40 -0000
@@ -12,15 +12,18 @@
 
 #include <linux/types.h>
 #include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <linux/cache.h>
  
 struct task_struct;
  
-/* allocate a sample buffer for each CPU */
 int alloc_cpu_buffers(void);
-
 void free_cpu_buffers(void);
 
+void start_cpu_timers(void);
+void end_cpu_timers(void);
+
 /* CPU buffer is composed of such entries (which are
  * also used for context switch notes)
  */
@@ -38,11 +41,13 @@ struct oprofile_cpu_buffer {
 	struct op_sample * buffer;
 	unsigned long sample_received;
 	unsigned long sample_lost_overflow;
-	unsigned long sample_lost_task_exit;
+	int cpu;
+	struct timer_list timer;
+	struct work_struct work;
 } ____cacheline_aligned;
 
 extern struct oprofile_cpu_buffer cpu_buffer[];
 
-void cpu_buffer_reset(struct oprofile_cpu_buffer *cpu_buf);
+void cpu_buffer_reset(struct oprofile_cpu_buffer * cpu_buf);
 
 #endif /* OPROFILE_CPU_BUFFER_H */
Index: linux-cvs/drivers/oprofile/oprofile_stats.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/drivers/oprofile/oprofile_stats.c,v
retrieving revision 1.8
diff -u -a -p -r1.8 oprofile_stats.c
--- linux-cvs/drivers/oprofile/oprofile_stats.c	18 Apr 2004 17:54:39 -0000	1.8
+++ linux-cvs/drivers/oprofile/oprofile_stats.c	21 Aug 2004 19:16:40 -0000
@@ -29,7 +29,6 @@ void oprofile_reset_stats(void)
 		cpu_buf = &cpu_buffer[i]; 
 		cpu_buf->sample_received = 0;
 		cpu_buf->sample_lost_overflow = 0;
-		cpu_buf->sample_lost_task_exit = 0;
 	}
  
 	atomic_set(&oprofile_stats.sample_lost_no_mm, 0);
@@ -66,8 +65,6 @@ void oprofile_create_stats_files(struct 
 			&cpu_buf->sample_received);
 		oprofilefs_create_ro_ulong(sb, cpudir, "sample_lost_overflow",
 			&cpu_buf->sample_lost_overflow);
-		oprofilefs_create_ro_ulong(sb, cpudir, "sample_lost_task_exit",
-			&cpu_buf->sample_lost_task_exit);
 	}
  
 	oprofilefs_create_ro_atomic(sb, dir, "sample_lost_no_mm",
Index: linux-cvs/include/linux/profile.h
===================================================================
RCS file: /home/moz/cvs//linux-2.5/include/linux/profile.h,v
retrieving revision 1.6
diff -u -a -p -r1.6 profile.h
--- linux-cvs/include/linux/profile.h	6 Oct 2003 21:52:43 -0000	1.6
+++ linux-cvs/include/linux/profile.h	21 Aug 2004 19:16:40 -0000
@@ -21,9 +21,8 @@ extern int prof_on;
 
 
 enum profile_type {
-	EXIT_TASK,
-	EXIT_MMAP,
-	EXEC_UNMAP
+	PROFILE_TASK_EXIT,
+	PROFILE_MUNMAP
 };
 
 #ifdef CONFIG_PROFILING
@@ -33,16 +32,20 @@ struct task_struct;
 struct mm_struct;
 
 /* task is in do_exit() */
-void profile_exit_task(struct task_struct * task);
+void profile_task_exit(struct task_struct * task);
 
-/* change of vma mappings */
-void profile_exec_unmap(struct mm_struct * mm);
+/* task is dead, free task struct ? Returns 1 if
+ * the task was taken, 0 if the task should be freed.
+ */
+int profile_handoff_task(struct task_struct * task);
 
-/* exit of all vmas for a task */
-void profile_exit_mmap(struct mm_struct * mm);
+/* sys_munmap */
+void profile_munmap(unsigned long addr);
 
-int profile_event_register(enum profile_type, struct notifier_block * n);
+int task_handoff_register(struct notifier_block * n);
+int task_handoff_unregister(struct notifier_block * n);
 
+int profile_event_register(enum profile_type, struct notifier_block * n);
 int profile_event_unregister(enum profile_type, struct notifier_block * n);
 
 int register_profile_notifier(struct notifier_block * nb);
@@ -55,6 +58,16 @@ void profile_hook(struct pt_regs * regs)
 
 #else
 
+static inline int task_handoff_register(struct notifier_block * n)
+{
+	return -ENOSYS;
+}
+
+static inline int task_handoff_unregister(struct notifier_block * n)
+{
+	return -ENOSYS;
+}
+
 static inline int profile_event_register(enum profile_type t, struct notifier_block * n)
 {
 	return -ENOSYS;
@@ -65,9 +78,9 @@ static inline int profile_event_unregist
 	return -ENOSYS;
 }
 
-#define profile_exit_task(a) do { } while (0)
-#define profile_exec_unmap(a) do { } while (0)
-#define profile_exit_mmap(a) do { } while (0)
+#define profile_task_exit(a) do { } while (0)
+#define profile_handoff_task(a) (0)
+#define profile_munmap(a) do { } while (0)
 
 static inline int register_profile_notifier(struct notifier_block * nb)
 {
Index: linux-cvs/include/linux/sched.h
===================================================================
RCS file: /home/moz/cvs//linux-2.5/include/linux/sched.h,v
retrieving revision 1.246
diff -u -a -p -r1.246 sched.h
--- linux-cvs/include/linux/sched.h	29 Jul 2004 06:13:51 -0000	1.246
+++ linux-cvs/include/linux/sched.h	21 Aug 2004 19:16:40 -0000
@@ -534,6 +534,7 @@ static inline pid_t process_group(struct
 	return tsk->signal->pgrp;
 }
 
+extern void free_task(struct task_struct *tsk);
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
 #define put_task_struct(tsk) \
Index: linux-cvs/kernel/exit.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/kernel/exit.c,v
retrieving revision 1.142
diff -u -a -p -r1.142 exit.c
--- linux-cvs/kernel/exit.c	18 Jul 2004 04:51:57 -0000	1.142
+++ linux-cvs/kernel/exit.c	21 Aug 2004 19:16:40 -0000
@@ -797,6 +797,8 @@ asmlinkage NORET_TYPE void do_exit(long 
 {
 	struct task_struct *tsk = current;
 
+	profile_task_exit(tsk);
+
 	if (unlikely(in_interrupt()))
 		panic("Aiee, killing interrupt handler!");
 	if (unlikely(!tsk->pid))
@@ -813,8 +815,6 @@ asmlinkage NORET_TYPE void do_exit(long 
 				current->comm, current->pid,
 				preempt_count());
 
-	profile_exit_task(tsk);
- 
 	if (unlikely(current->ptrace & PT_TRACE_EXIT)) {
 		current->ptrace_message = code;
 		ptrace_notify((PTRACE_EVENT_EXIT << 8) | SIGTRAP);
Index: linux-cvs/kernel/fork.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/kernel/fork.c,v
retrieving revision 1.194
diff -u -a -p -r1.194 fork.c
--- linux-cvs/kernel/fork.c	29 Jul 2004 06:14:26 -0000	1.194
+++ linux-cvs/kernel/fork.c	21 Aug 2004 19:16:40 -0000
@@ -35,6 +35,7 @@
 #include <linux/ptrace.h>
 #include <linux/mount.h>
 #include <linux/audit.h>
+#include <linux/profile.h>
 #include <linux/rmap.h>
 
 #include <asm/pgtable.h>
@@ -75,11 +76,12 @@ int nr_processes(void)
 static kmem_cache_t *task_struct_cachep;
 #endif
 
-static void free_task(struct task_struct *tsk)
+void free_task(struct task_struct *tsk)
 {
 	free_thread_info(tsk->thread_info);
 	free_task_struct(tsk);
 }
+EXPORT_SYMBOL(free_task);
 
 void __put_task_struct(struct task_struct *tsk)
 {
@@ -92,7 +94,9 @@ void __put_task_struct(struct task_struc
 	security_task_free(tsk);
 	free_uid(tsk->user);
 	put_group_info(tsk->group_info);
-	free_task(tsk);
+
+	if (!profile_handoff_task(tsk))
+		free_task(tsk);
 }
 
 void fastcall add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
Index: linux-cvs/kernel/profile.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/kernel/profile.c,v
retrieving revision 1.5
diff -u -a -p -r1.5 profile.c
--- linux-cvs/kernel/profile.c	19 Jul 2003 02:22:58 -0000	1.5
+++ linux-cvs/kernel/profile.c	21 Aug 2004 19:16:40 -0000
@@ -47,31 +47,54 @@ void __init profile_init(void)
 #ifdef CONFIG_PROFILING
  
 static DECLARE_RWSEM(profile_rwsem);
-static struct notifier_block * exit_task_notifier;
-static struct notifier_block * exit_mmap_notifier;
-static struct notifier_block * exec_unmap_notifier;
+static rwlock_t handoff_lock = RW_LOCK_UNLOCKED;
+static struct notifier_block * task_exit_notifier;
+static struct notifier_block * task_free_notifier;
+static struct notifier_block * munmap_notifier;
  
-void profile_exit_task(struct task_struct * task)
+void profile_task_exit(struct task_struct * task)
 {
 	down_read(&profile_rwsem);
-	notifier_call_chain(&exit_task_notifier, 0, task);
+	notifier_call_chain(&task_exit_notifier, 0, task);
 	up_read(&profile_rwsem);
 }
  
-void profile_exit_mmap(struct mm_struct * mm)
+int profile_handoff_task(struct task_struct * task)
 {
-	down_read(&profile_rwsem);
-	notifier_call_chain(&exit_mmap_notifier, 0, mm);
-	up_read(&profile_rwsem);
+	int ret;
+	read_lock(&handoff_lock);
+	ret = notifier_call_chain(&task_free_notifier, 0, task);
+	read_unlock(&handoff_lock);
+	return (ret == NOTIFY_OK) ? 1 : 0;
 }
 
-void profile_exec_unmap(struct mm_struct * mm)
+void profile_munmap(unsigned long addr)
 {
 	down_read(&profile_rwsem);
-	notifier_call_chain(&exec_unmap_notifier, 0, mm);
+	notifier_call_chain(&munmap_notifier, 0, (void *)addr);
 	up_read(&profile_rwsem);
 }
 
+int task_handoff_register(struct notifier_block * n)
+{
+	int err = -EINVAL;
+
+	write_lock(&handoff_lock);
+	err = notifier_chain_register(&task_free_notifier, n);
+	write_unlock(&handoff_lock);
+	return err;
+}
+
+int task_handoff_unregister(struct notifier_block * n)
+{
+	int err = -EINVAL;
+
+	write_lock(&handoff_lock);
+	err = notifier_chain_unregister(&task_free_notifier, n);
+	write_unlock(&handoff_lock);
+	return err;
+}
+
 int profile_event_register(enum profile_type type, struct notifier_block * n)
 {
 	int err = -EINVAL;
@@ -79,14 +102,11 @@ int profile_event_register(enum profile_
 	down_write(&profile_rwsem);
  
 	switch (type) {
-		case EXIT_TASK:
-			err = notifier_chain_register(&exit_task_notifier, n);
+		case PROFILE_TASK_EXIT:
+			err = notifier_chain_register(&task_exit_notifier, n);
 			break;
-		case EXIT_MMAP:
-			err = notifier_chain_register(&exit_mmap_notifier, n);
-			break;
-		case EXEC_UNMAP:
-			err = notifier_chain_register(&exec_unmap_notifier, n);
+		case PROFILE_MUNMAP:
+			err = notifier_chain_register(&munmap_notifier, n);
 			break;
 	}
  
@@ -103,14 +123,11 @@ int profile_event_unregister(enum profil
 	down_write(&profile_rwsem);
  
 	switch (type) {
-		case EXIT_TASK:
-			err = notifier_chain_unregister(&exit_task_notifier, n);
-			break;
-		case EXIT_MMAP:
-			err = notifier_chain_unregister(&exit_mmap_notifier, n);
+		case PROFILE_TASK_EXIT:
+			err = notifier_chain_unregister(&task_exit_notifier, n);
 			break;
-		case EXEC_UNMAP:
-			err = notifier_chain_unregister(&exec_unmap_notifier, n);
+		case PROFILE_MUNMAP:
+			err = notifier_chain_unregister(&munmap_notifier, n);
 			break;
 	}
 
@@ -150,6 +167,8 @@ void profile_hook(struct pt_regs * regs)
 
 EXPORT_SYMBOL_GPL(register_profile_notifier);
 EXPORT_SYMBOL_GPL(unregister_profile_notifier);
+EXPORT_SYMBOL_GPL(task_handoff_register);
+EXPORT_SYMBOL_GPL(task_handoff_unregister);
 
 #endif /* CONFIG_PROFILING */
 
Index: linux-cvs/kernel/timer.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/kernel/timer.c,v
retrieving revision 1.88
diff -u -a -p -r1.88 timer.c
--- linux-cvs/kernel/timer.c	2 Aug 2004 17:31:12 -0000	1.88
+++ linux-cvs/kernel/timer.c	21 Aug 2004 19:16:41 -0000
@@ -233,6 +233,8 @@ void add_timer_on(struct timer_list *tim
 	spin_unlock_irqrestore(&base->lock, flags);
 }
 
+EXPORT_SYMBOL(add_timer_on);
+
 /***
  * mod_timer - modify a timer's timeout
  * @timer: the timer to be modified
Index: linux-cvs/mm/mmap.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/mm/mmap.c,v
retrieving revision 1.136
diff -u -a -p -r1.136 mmap.c
--- linux-cvs/mm/mmap.c	18 Jul 2004 16:08:19 -0000	1.136
+++ linux-cvs/mm/mmap.c	21 Aug 2004 19:16:41 -0000
@@ -1554,10 +1554,6 @@ int do_munmap(struct mm_struct *mm, unsi
 	if (mpnt->vm_start >= end)
 		return 0;
 
-	/* Something will probably happen, so notify. */
-	if (mpnt->vm_file && (mpnt->vm_flags & VM_EXEC))
-		profile_exec_unmap(mm);
- 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -1600,6 +1596,8 @@ asmlinkage long sys_munmap(unsigned long
 	int ret;
 	struct mm_struct *mm = current->mm;
 
+	profile_munmap(addr);
+
 	down_write(&mm->mmap_sem);
 	ret = do_munmap(mm, addr, len);
 	up_write(&mm->mmap_sem);
@@ -1700,8 +1698,6 @@ void exit_mmap(struct mm_struct *mm)
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted = 0;
 
-	profile_exit_mmap(mm);
- 
 	lru_add_drain();
 
 	spin_lock(&mm->page_table_lock);


