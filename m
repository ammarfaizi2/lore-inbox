Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTCEVqp>; Wed, 5 Mar 2003 16:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTCEVqp>; Wed, 5 Mar 2003 16:46:45 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:31757 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262789AbTCEVqi>; Wed, 5 Mar 2003 16:46:38 -0500
Date: Wed, 5 Mar 2003 21:57:06 +0000
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix oprofile on UP, small additional fix
Message-ID: <20030305215705.GA41042@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18qgsu-000Avj-00*To5T0HRZEsM*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The below has been in -mm for a while, and has been tested on my UP
and 2-way machines.

OProfile was completely unsafe on UP - a spinlock is no protection
against the NMI arriving and putting data into the buffer. Pretty stupid
bug. This fixes it by implementing reader/writer windows in the buffer
and removing the lock altogether. This patch was originally done by Will
Cohen.

It also fixes the oops Dave Hansen saw on 2.5.62 SMP

Please apply.

thanks
john


diff -Naur -X dontdiff linux-linus/arch/i386/oprofile/nmi_int.c linux/arch/i386/oprofile/nmi_int.c
--- linux-linus/arch/i386/oprofile/nmi_int.c	2003-03-05 19:45:25.000000000 +0000
+++ linux/arch/i386/oprofile/nmi_int.c	2003-03-05 19:46:56.000000000 +0000
@@ -58,7 +58,7 @@
 	unsigned int const nr_ctrls = model->num_controls; 
 	struct op_msr_group * counters = &msrs->counters;
 	struct op_msr_group * controls = &msrs->controls;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < nr_ctrs; ++i) {
 		rdmsr(counters->addrs[i],
@@ -108,7 +108,7 @@
 	unsigned int const nr_ctrls = model->num_controls; 
 	struct op_msr_group * counters = &msrs->counters;
 	struct op_msr_group * controls = &msrs->controls;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < nr_ctrls; ++i) {
 		wrmsr(controls->addrs[i],
@@ -182,7 +182,7 @@
 
 static int nmi_create_files(struct super_block * sb, struct dentry * root)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < model->num_counters; ++i) {
 		struct dentry * dir;
diff -Naur -X dontdiff linux-linus/arch/i386/oprofile/op_model_p4.c linux/arch/i386/oprofile/op_model_p4.c
--- linux-linus/arch/i386/oprofile/op_model_p4.c	2003-02-15 18:10:37.000000000 +0000
+++ linux/arch/i386/oprofile/op_model_p4.c	2003-03-03 06:48:07.000000000 +0000
@@ -389,7 +389,7 @@
 
 static void p4_fill_in_addresses(struct op_msrs * const msrs)
 {
-	int i; 
+	unsigned int i; 
 	unsigned int addr, stag;
 
 	setup_num_counters();
diff -Naur -X dontdiff linux-linus/drivers/oprofile/buffer_sync.c linux/drivers/oprofile/buffer_sync.c
--- linux-linus/drivers/oprofile/buffer_sync.c	2003-02-25 13:53:52.000000000 +0000
+++ linux/drivers/oprofile/buffer_sync.c	2003-03-03 06:46:44.000000000 +0000
@@ -277,10 +277,7 @@
  */
 static struct mm_struct * take_task_mm(struct task_struct * task)
 {
-	struct mm_struct * mm;
-	task_lock(task);
-	mm = task->mm;
-	task_unlock(task);
+	struct mm_struct * mm = task->mm;
  
 	/* if task->mm !NULL, mm_count must be at least 1. It cannot
 	 * drop to 0 without the task exiting, which will have to sleep
@@ -310,6 +307,32 @@
 }
  
 
+/* compute number of filled slots in cpu_buffer queue */
+static unsigned long nr_filled_slots(struct oprofile_cpu_buffer * b)
+{
+	unsigned long head = b->head_pos;
+	unsigned long tail = b->tail_pos;
+
+	if (head >= tail)
+		return head - tail;
+
+	return head + (b->buffer_size - tail);
+}
+
+
+static void increment_tail(struct oprofile_cpu_buffer * b)
+{
+	unsigned long new_tail = b->tail_pos + 1;
+
+	rmb();
+
+	if (new_tail < (b->buffer_size))
+		b->tail_pos = new_tail;
+	else
+		b->tail_pos = 0;
+}
+
+
 /* Sync one of the CPU's buffers into the global event buffer.
  * Here we need to go through each batch of samples punctuated
  * by context switch notes, taking the task's mmap_sem and doing
@@ -322,10 +345,14 @@
 	struct task_struct * new;
 	unsigned long cookie;
 	int in_kernel = 1;
-	int i;
+	unsigned int i;
  
-	for (i=0; i < cpu_buf->pos; ++i) {
-		struct op_sample * s = &cpu_buf->buffer[i];
+	/* Remember, only we can modify tail_pos */
+
+	unsigned long const available_elements = nr_filled_slots(cpu_buf);
+  
+	for (i=0; i < available_elements; ++i) {
+		struct op_sample * s = &cpu_buf->buffer[cpu_buf->tail_pos];
  
 		if (is_ctx_switch(s->eip)) {
 			if (s->event <= 1) {
@@ -345,6 +372,8 @@
 		} else {
 			add_sample(mm, s, in_kernel);
 		}
+
+		increment_tail(cpu_buf);
 	}
 	release_mm(mm);
 
@@ -369,17 +398,8 @@
  
 		cpu_buf = &cpu_buffer[i];
  
-		/* We take a spin lock even though we might
-		 * sleep. It's OK because other users are try
-		 * lockers only, and this region is already
-		 * protected by buffer_sem. It's raw to prevent
-		 * the preempt bogometer firing. Fruity, huh ? */
-		if (cpu_buf->pos > 0) {
-			_raw_spin_lock(&cpu_buf->int_lock);
-			add_cpu_switch(i);
-			sync_buffer(cpu_buf);
-			_raw_spin_unlock(&cpu_buf->int_lock);
-		}
+		add_cpu_switch(i);
+		sync_buffer(cpu_buf);
 	}
 
 	up(&buffer_sem);
diff -Naur -X dontdiff linux-linus/drivers/oprofile/cpu_buffer.c linux/drivers/oprofile/cpu_buffer.c
--- linux-linus/drivers/oprofile/cpu_buffer.c	2003-02-15 18:10:45.000000000 +0000
+++ linux/drivers/oprofile/cpu_buffer.c	2003-02-27 02:28:36.000000000 +0000
@@ -26,8 +26,6 @@
 
 struct oprofile_cpu_buffer cpu_buffer[NR_CPUS] __cacheline_aligned;
 
-static unsigned long buffer_size;
- 
 static void __free_cpu_buffers(int num)
 {
 	int i;
@@ -47,7 +45,7 @@
 {
 	int i;
  
-	buffer_size = fs_cpu_buffer_size;
+	unsigned long buffer_size = fs_cpu_buffer_size;
  
 	for (i=0; i < NR_CPUS; ++i) {
 		struct oprofile_cpu_buffer * b = &cpu_buffer[i];
@@ -59,12 +57,12 @@
 		if (!b->buffer)
 			goto fail;
  
-		spin_lock_init(&b->int_lock);
-		b->pos = 0;
 		b->last_task = 0;
 		b->last_is_kernel = -1;
+		b->buffer_size = buffer_size;
+		b->tail_pos = 0;
+		b->head_pos = 0;
 		b->sample_received = 0;
-		b->sample_lost_locked = 0;
 		b->sample_lost_overflow = 0;
 		b->sample_lost_task_exit = 0;
 	}
@@ -80,11 +78,41 @@
 	__free_cpu_buffers(NR_CPUS);
 }
 
- 
-/* Note we can't use a semaphore here as this is supposed to
- * be safe from any context. Instead we trylock the CPU's int_lock.
- * int_lock is taken by the processing code in sync_cpu_buffers()
- * so we avoid disturbing that.
+
+/* compute number of available slots in cpu_buffer queue */
+static unsigned long nr_available_slots(struct oprofile_cpu_buffer const * b)
+{
+	unsigned long head = b->head_pos;
+	unsigned long tail = b->tail_pos;
+
+	if (tail == head)
+		return b->buffer_size;
+
+	if (tail > head)
+		return tail - head;
+
+	return tail + (b->buffer_size - head);
+}
+
+
+static void increment_head(struct oprofile_cpu_buffer * b)
+{
+	unsigned long new_head = b->head_pos + 1;
+
+	/* Ensure anything written to the slot before we
+	 * increment is visible */
+	wmb();
+
+	if (new_head < (b->buffer_size))
+		b->head_pos = new_head;
+	else
+		b->head_pos = 0;
+}
+
+
+/* This must be safe from any context. It's safe writing here
+ * because of the head/tail separation of the writer and reader
+ * of the CPU buffer.
  *
  * is_kernel is needed because on some architectures you cannot
  * tell if you are in kernel or user space simply by looking at
@@ -101,14 +129,10 @@
 
 	cpu_buf->sample_received++;
  
-	if (!spin_trylock(&cpu_buf->int_lock)) {
-		cpu_buf->sample_lost_locked++;
-		return;
-	}
 
-	if (cpu_buf->pos > buffer_size - 2) {
+	if (nr_available_slots(cpu_buf) < 3) {
 		cpu_buf->sample_lost_overflow++;
-		goto out;
+		return;
 	}
 
 	task = current;
@@ -116,18 +140,18 @@
 	/* notice a switch from user->kernel or vice versa */
 	if (cpu_buf->last_is_kernel != is_kernel) {
 		cpu_buf->last_is_kernel = is_kernel;
-		cpu_buf->buffer[cpu_buf->pos].eip = ~0UL;
-		cpu_buf->buffer[cpu_buf->pos].event = is_kernel;
-		cpu_buf->pos++;
+		cpu_buf->buffer[cpu_buf->head_pos].eip = ~0UL;
+		cpu_buf->buffer[cpu_buf->head_pos].event = is_kernel;
+		increment_head(cpu_buf);
 	}
 
 	/* notice a task switch */
 	if (cpu_buf->last_task != task) {
 		cpu_buf->last_task = task;
 		if (!(task->flags & PF_EXITING)) {
-			cpu_buf->buffer[cpu_buf->pos].eip = ~0UL;
-			cpu_buf->buffer[cpu_buf->pos].event = (unsigned long)task;
-			cpu_buf->pos++;
+			cpu_buf->buffer[cpu_buf->head_pos].eip = ~0UL;
+			cpu_buf->buffer[cpu_buf->head_pos].event = (unsigned long)task;
+			increment_head(cpu_buf);
 		}
 	}
  
@@ -138,23 +162,20 @@
 	 */
 	if (task->flags & PF_EXITING) {
 		cpu_buf->sample_lost_task_exit++;
-		goto out;
+		return;
 	}
  
-	cpu_buf->buffer[cpu_buf->pos].eip = eip;
-	cpu_buf->buffer[cpu_buf->pos].event = event;
-	cpu_buf->pos++;
-out:
-	spin_unlock(&cpu_buf->int_lock);
+	cpu_buf->buffer[cpu_buf->head_pos].eip = eip;
+	cpu_buf->buffer[cpu_buf->head_pos].event = event;
+	increment_head(cpu_buf);
 }
 
+
 /* resets the cpu buffer to a sane state - should be called with 
  * cpu_buf->int_lock held
  */
 void cpu_buffer_reset(struct oprofile_cpu_buffer *cpu_buf)
 {
-	cpu_buf->pos = 0;
-
 	/* reset these to invalid values; the next sample
 	 * collected will populate the buffer with proper
 	 * values to initialize the buffer
@@ -162,4 +183,3 @@
 	cpu_buf->last_is_kernel = -1;
 	cpu_buf->last_task = 0;
 }
-
diff -Naur -X dontdiff linux-linus/drivers/oprofile/cpu_buffer.h linux/drivers/oprofile/cpu_buffer.h
--- linux-linus/drivers/oprofile/cpu_buffer.h	2003-02-15 18:10:45.000000000 +0000
+++ linux/drivers/oprofile/cpu_buffer.h	2003-03-05 21:56:22.000000000 +0000
@@ -30,14 +30,13 @@
 };
  
 struct oprofile_cpu_buffer {
-	spinlock_t int_lock;
-	/* protected by int_lock */
-	unsigned long pos;
+	volatile unsigned long head_pos;
+	volatile unsigned long tail_pos;
+	unsigned long buffer_size;
 	struct task_struct * last_task;
 	int last_is_kernel;
 	struct op_sample * buffer;
 	unsigned long sample_received;
-	unsigned long sample_lost_locked;
 	unsigned long sample_lost_overflow;
 	unsigned long sample_lost_task_exit;
 } ____cacheline_aligned;
diff -Naur -X dontdiff linux-linus/drivers/oprofile/oprofile_stats.c linux/drivers/oprofile/oprofile_stats.c
--- linux-linus/drivers/oprofile/oprofile_stats.c	2003-02-25 13:53:52.000000000 +0000
+++ linux/drivers/oprofile/oprofile_stats.c	2003-02-25 13:56:06.000000000 +0000
@@ -27,7 +27,6 @@
 
 		cpu_buf = &cpu_buffer[i]; 
 		cpu_buf->sample_received = 0;
-		cpu_buf->sample_lost_locked = 0;
 		cpu_buf->sample_lost_overflow = 0;
 		cpu_buf->sample_lost_task_exit = 0;
 	}
@@ -63,8 +62,6 @@
 		 */
 		oprofilefs_create_ro_ulong(sb, cpudir, "sample_received",
 			&cpu_buf->sample_received);
-		oprofilefs_create_ro_ulong(sb, cpudir, "sample_lost_locked",
-			&cpu_buf->sample_lost_locked);
 		oprofilefs_create_ro_ulong(sb, cpudir, "sample_lost_overflow",
 			&cpu_buf->sample_lost_overflow);
 		oprofilefs_create_ro_ulong(sb, cpudir, "sample_lost_task_exit",
diff -Naur -X dontdiff linux-linus/include/linux/profile.h linux/include/linux/profile.h
--- linux-linus/include/linux/profile.h	2003-02-25 13:53:59.000000000 +0000
+++ linux/include/linux/profile.h	2003-02-27 02:41:10.000000000 +0000
@@ -2,15 +2,15 @@
 #define _LINUX_PROFILE_H
 
 #ifdef __KERNEL__
- 
+
 #include <linux/kernel.h>
 #include <linux/config.h>
 #include <linux/init.h>
 #include <asm/errno.h>
- 
+
 /* parse command line */
 int __init profile_setup(char * str);
- 
+
 /* init basic kernel profiler */
 void __init profile_init(void);
 
@@ -27,14 +27,14 @@
 };
 
 #ifdef CONFIG_PROFILING
- 
+
 struct notifier_block;
 struct task_struct;
 struct mm_struct;
- 
+
 /* task is in do_exit() */
 void profile_exit_task(struct task_struct * task);
- 
+
 /* change of vma mappings */
 void profile_exec_unmap(struct mm_struct * mm);
 
@@ -44,10 +44,10 @@
 int profile_event_register(enum profile_type, struct notifier_block * n);
 
 int profile_event_unregister(enum profile_type, struct notifier_block * n);
- 
+
 int register_profile_notifier(struct notifier_block * nb);
 int unregister_profile_notifier(struct notifier_block * nb);
- 
+
 /* profiling hook activated on each timer interrupt */
 void profile_hook(struct pt_regs * regs);
 
@@ -57,12 +57,12 @@
 {
 	return -ENOSYS;
 }
- 
+
 static inline int profile_event_unregister(enum profile_type t, struct notifier_block * n)
 {
 	return -ENOSYS;
 }
- 
+
 #define profile_exit_task(a) do { } while (0)
 #define profile_exec_unmap(a) do { } while (0)
 #define profile_exit_mmap(a) do { } while (0)
@@ -80,7 +80,7 @@
 #define profile_hook(regs) do { } while (0)
 
 #endif /* CONFIG_PROFILING */
- 
+
 #endif /* __KERNEL__ */
- 
+
 #endif /* _LINUX_PROFILE_H */
