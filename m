Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbUKILQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbUKILQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUKIKzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:55:18 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:54739 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261478AbUKIKiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:38:15 -0500
Subject: [PATCH 2/11] oprofile: arch-independent code for stack trace
	sampling
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-UGbe2cNaWP4OUJzb39KB"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1099996668.1985.783.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 21:37:48 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UGbe2cNaWP4OUJzb39KB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-UGbe2cNaWP4OUJzb39KB
Content-Disposition: attachment; filename=oprofile-callgraph-common
Content-Type: text/plain; name=oprofile-callgraph-common; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

oprofile arch-independent updates, including some internal
API changes and support for stack trace sampling.

Signed-off-by: John Levon <levon@movementarian.org>
Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 drivers/oprofile/buffer_sync.c    |   57 ++++++++++++---
 drivers/oprofile/cpu_buffer.c     |  141 ++++++++++++++++++++++++++++++--------
 drivers/oprofile/cpu_buffer.h     |    6 +
 drivers/oprofile/event_buffer.h   |    2 
 drivers/oprofile/oprof.c          |   74 +++++++++++--------
 drivers/oprofile/oprof.h          |    5 +
 drivers/oprofile/oprofile_files.c |   42 +++++++++--
 drivers/oprofile/oprofile_stats.c |    4 +
 drivers/oprofile/oprofile_stats.h |    1 
 drivers/oprofile/timer_int.c      |   19 +----
 include/linux/oprofile.h          |   20 ++++-
 11 files changed, 279 insertions(+), 92 deletions(-)

Index: linux/drivers/oprofile/oprofile_files.c
===================================================================
--- linux.orig/drivers/oprofile/oprofile_files.c	2004-10-19 07:54:08.%N +1000
+++ linux/drivers/oprofile/oprofile_files.c	2004-11-07 18:00:02.%N +1100
@@ -18,6 +18,37 @@ unsigned long fs_buffer_size = 131072;
 unsigned long fs_cpu_buffer_size = 8192;
 unsigned long fs_buffer_watershed = 32768; /* FIXME: tune */
 
+static ssize_t depth_read(struct file * file, char * buf, size_t count, loff_t * offset)
+{
+	return oprofilefs_ulong_to_user(backtrace_depth, buf, count, offset);
+}
+
+ 
+static ssize_t depth_write(struct file * file, char const * buf, size_t count, loff_t * offset)
+{
+	unsigned long val;
+	int retval;
+
+	if (*offset)
+		return -EINVAL;
+
+	retval = oprofilefs_ulong_from_user(&val, buf, count);
+	if (retval)
+		return retval;
+  
+	retval = oprofile_set_backtrace(val);
+
+	if (retval)
+		return retval;
+	return count;
+}
+
+
+static struct file_operations depth_fops = {
+	.read		= depth_read,
+	.write		= depth_write
+};
+
  
 static ssize_t pointer_size_read(struct file * file, char __user * buf, size_t count, loff_t * offset)
 {
@@ -32,7 +63,7 @@ static struct file_operations pointer_si
 
 static ssize_t cpu_type_read(struct file * file, char __user * buf, size_t count, loff_t * offset)
 {
-	return oprofilefs_str_to_user(oprofile_ops->cpu_type, buf, count, offset);
+	return oprofilefs_str_to_user(oprofile_ops.cpu_type, buf, count, offset);
 }
  
  
@@ -47,7 +78,7 @@ static ssize_t enable_read(struct file *
 }
 
 
-static ssize_t enable_write(struct file *file, char const __user * buf, size_t count, loff_t * offset)
+static ssize_t enable_write(struct file * file, char const __user * buf, size_t count, loff_t * offset)
 {
 	unsigned long val;
 	int retval;
@@ -76,7 +107,7 @@ static struct file_operations enable_fop
 };
 
 
-static ssize_t dump_write(struct file *file, char const __user * buf, size_t count, loff_t * offset)
+static ssize_t dump_write(struct file * file, char const __user * buf, size_t count, loff_t * offset)
 {
 	wake_up_buffer_waiter();
 	return count;
@@ -96,8 +127,9 @@ void oprofile_create_files(struct super_
 	oprofilefs_create_ulong(sb, root, "buffer_watershed", &fs_buffer_watershed);
 	oprofilefs_create_ulong(sb, root, "cpu_buffer_size", &fs_cpu_buffer_size);
 	oprofilefs_create_file(sb, root, "cpu_type", &cpu_type_fops); 
+	oprofilefs_create_file(sb, root, "backtrace_depth", &depth_fops);
 	oprofilefs_create_file(sb, root, "pointer_size", &pointer_size_fops);
 	oprofile_create_stats_files(sb, root);
-	if (oprofile_ops->create_files)
-		oprofile_ops->create_files(sb, root);
+	if (oprofile_ops.create_files)
+		oprofile_ops.create_files(sb, root);
 }
Index: linux/drivers/oprofile/oprofile_stats.h
===================================================================
--- linux.orig/drivers/oprofile/oprofile_stats.h	2004-10-19 07:55:36.%N +1000
+++ linux/drivers/oprofile/oprofile_stats.h	2004-11-07 18:00:02.%N +1100
@@ -15,6 +15,7 @@
 struct oprofile_stat_struct {
 	atomic_t sample_lost_no_mm;
 	atomic_t sample_lost_no_mapping;
+	atomic_t bt_lost_no_mapping;
 	atomic_t event_lost_overflow;
 };
 
Index: linux/include/linux/oprofile.h
===================================================================
--- linux.orig/include/linux/oprofile.h	2004-10-19 07:54:37.%N +1000
+++ linux/include/linux/oprofile.h	2004-11-07 18:00:02.%N +1100
@@ -20,6 +20,7 @@
 struct super_block;
 struct dentry;
 struct file_operations;
+struct pt_regs;
  
 /* Operations structure to be filled in */
 struct oprofile_operations {
@@ -34,6 +35,8 @@ struct oprofile_operations {
 	int (*start)(void);
 	/* Stop delivering interrupts. */
 	void (*stop)(void);
+	/* Initiate a stack backtrace. Optional. */
+	void (*backtrace)(struct pt_regs * const regs, unsigned int depth);
 	/* CPU identification string. */
 	char * cpu_type;
 };
@@ -41,11 +44,11 @@ struct oprofile_operations {
 /**
  * One-time initialisation. *ops must be set to a filled-in
  * operations structure. This is called even in timer interrupt
- * mode.
+ * mode so an arch can set a backtrace callback.
  *
- * Return 0 on success.
+ * If an error occurs, the fields should be left untouched.
  */
-int oprofile_arch_init(struct oprofile_operations ** ops);
+void oprofile_arch_init(struct oprofile_operations * ops);
  
 /**
  * One-time exit/cleanup for the arch.
@@ -56,8 +59,15 @@ void oprofile_arch_exit(void);
  * Add a sample. This may be called from any context. Pass
  * smp_processor_id() as cpu.
  */
-extern void oprofile_add_sample(unsigned long eip, unsigned int is_kernel, 
-	unsigned long event, int cpu);
+void oprofile_add_sample(struct pt_regs * const regs, unsigned long event);
+
+/* Use this instead when the PC value is not from the regs. Doesn't
+ * backtrace. */
+void oprofile_add_pc(unsigned long pc, int is_kernel, unsigned long event);
+
+/* add a backtrace entry, to be called from the ->backtrace callback */
+void oprofile_add_trace(unsigned long eip);
+
 
 /**
  * Create a file of the given name as a child of the given root, with
Index: linux/drivers/oprofile/cpu_buffer.c
===================================================================
--- linux.orig/drivers/oprofile/cpu_buffer.c	2004-10-19 07:53:06.%N +1000
+++ linux/drivers/oprofile/cpu_buffer.c	2004-11-07 18:00:02.%N +1100
@@ -18,9 +18,11 @@
  */
 
 #include <linux/sched.h>
+#include <linux/oprofile.h>
 #include <linux/vmalloc.h>
 #include <linux/errno.h>
  
+#include "event_buffer.h" 
 #include "cpu_buffer.h"
 #include "buffer_sync.h"
 #include "oprof.h"
@@ -58,6 +60,7 @@ int alloc_cpu_buffers(void)
  
 		b->last_task = NULL;
 		b->last_is_kernel = -1;
+		b->tracing = 0;
 		b->buffer_size = buffer_size;
 		b->tail_pos = 0;
 		b->head_pos = 0;
@@ -114,6 +117,18 @@ void end_cpu_work(void)
 }
 
 
+/* Resets the cpu buffer to a sane state. */
+void cpu_buffer_reset(struct oprofile_cpu_buffer * cpu_buf)
+{
+	/* reset these to invalid values; the next sample
+	 * collected will populate the buffer with proper
+	 * values to initialize the buffer
+	 */
+	cpu_buf->last_is_kernel = -1;
+	cpu_buf->last_task = NULL;
+}
+
+
 /* compute number of available slots in cpu_buffer queue */
 static unsigned long nr_available_slots(struct oprofile_cpu_buffer const * b)
 {
@@ -135,74 +150,148 @@ static void increment_head(struct oprofi
 	 * increment is visible */
 	wmb();
 
-	if (new_head < (b->buffer_size))
+	if (new_head < b->buffer_size)
 		b->head_pos = new_head;
 	else
 		b->head_pos = 0;
 }
 
 
+
+
+inline static void
+add_sample(struct oprofile_cpu_buffer * cpu_buf,
+           unsigned long pc, unsigned long event)
+{
+	struct op_sample * entry = &cpu_buf->buffer[cpu_buf->head_pos];
+	entry->eip = pc;
+	entry->event = event;
+	increment_head(cpu_buf);
+}
+
+
+inline static void
+add_code(struct oprofile_cpu_buffer * buffer, unsigned long value)
+{
+	add_sample(buffer, ESCAPE_CODE, value);
+}
+
+
 /* This must be safe from any context. It's safe writing here
  * because of the head/tail separation of the writer and reader
  * of the CPU buffer.
  *
  * is_kernel is needed because on some architectures you cannot
  * tell if you are in kernel or user space simply by looking at
- * eip. We tag this in the buffer by generating kernel enter/exit
+ * pc. We tag this in the buffer by generating kernel enter/exit
  * events whenever is_kernel changes
  */
-void oprofile_add_sample(unsigned long eip, unsigned int is_kernel, 
-	unsigned long event, int cpu)
+static int log_sample(struct oprofile_cpu_buffer * cpu_buf, unsigned long pc,
+		      int is_kernel, unsigned long event)
 {
-	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[cpu];
 	struct task_struct * task;
 
-	is_kernel = !!is_kernel;
-
 	cpu_buf->sample_received++;
- 
 
 	if (nr_available_slots(cpu_buf) < 3) {
 		cpu_buf->sample_lost_overflow++;
-		return;
+		return 0;
 	}
 
+	is_kernel = !!is_kernel;
+
 	task = current;
 
 	/* notice a switch from user->kernel or vice versa */
 	if (cpu_buf->last_is_kernel != is_kernel) {
 		cpu_buf->last_is_kernel = is_kernel;
-		cpu_buf->buffer[cpu_buf->head_pos].eip = ~0UL;
-		cpu_buf->buffer[cpu_buf->head_pos].event = is_kernel;
-		increment_head(cpu_buf);
+		add_code(cpu_buf, is_kernel);
 	}
 
 	/* notice a task switch */
 	if (cpu_buf->last_task != task) {
 		cpu_buf->last_task = task;
-		cpu_buf->buffer[cpu_buf->head_pos].eip = ~0UL;
-		cpu_buf->buffer[cpu_buf->head_pos].event = (unsigned long)task;
-		increment_head(cpu_buf);
+		add_code(cpu_buf, (unsigned long)task);
 	}
  
-	cpu_buf->buffer[cpu_buf->head_pos].eip = eip;
-	cpu_buf->buffer[cpu_buf->head_pos].event = event;
-	increment_head(cpu_buf);
+	add_sample(cpu_buf, pc, event);
+	return 1;
 }
 
+static int oprofile_begin_trace(struct oprofile_cpu_buffer * cpu_buf)
+{
+	if (nr_available_slots(cpu_buf) < 4) {
+		cpu_buf->sample_lost_overflow++;
+		return 0;
+	}
 
-/* Resets the cpu buffer to a sane state. */
-void cpu_buffer_reset(struct oprofile_cpu_buffer * cpu_buf)
+	add_code(cpu_buf, CPU_TRACE_BEGIN);
+	cpu_buf->tracing = 1;
+	return 1;
+}
+
+
+static void oprofile_end_trace(struct oprofile_cpu_buffer * cpu_buf)
 {
-	/* reset these to invalid values; the next sample
-	 * collected will populate the buffer with proper
-	 * values to initialize the buffer
-	 */
-	cpu_buf->last_is_kernel = -1;
-	cpu_buf->last_task = NULL;
+	cpu_buf->tracing = 0;
+}
+
+
+void oprofile_add_sample(struct pt_regs * const regs, unsigned long event)
+{
+	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[smp_processor_id()];
+	unsigned long pc = instruction_pointer(regs);
+	int is_kernel = !user_mode(regs);
+
+	if (!backtrace_depth) {
+		log_sample(cpu_buf, pc, is_kernel, event);
+		return;
+	}
+
+	if (!oprofile_begin_trace(cpu_buf))
+		return;
+
+	/* if log_sample() fail we can't backtrace since we lost the source
+	 * of this event */
+	if (log_sample(cpu_buf, pc, is_kernel, event))
+		oprofile_ops.backtrace(regs, backtrace_depth);
+	oprofile_end_trace(cpu_buf);
+}
+
+
+void oprofile_add_pc(unsigned long pc, int is_kernel, unsigned long event)
+{
+	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[smp_processor_id()];
+	log_sample(cpu_buf, pc, is_kernel, event);
+}
+
+
+void oprofile_add_trace(unsigned long pc)
+{
+	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[smp_processor_id()];
+
+	if (!cpu_buf->tracing)
+		return;
+
+	if (nr_available_slots(cpu_buf) < 1) {
+		cpu_buf->tracing = 0;
+		cpu_buf->sample_lost_overflow++;
+		return;
+	}
+
+	/* broken frame can give an eip with the same value as an escape code,
+	 * abort the trace if we get it */
+	if (pc == ESCAPE_CODE) {
+		cpu_buf->tracing = 0;
+		cpu_buf->backtrace_aborted++;
+		return;
+	}
+
+	add_sample(cpu_buf, pc, 0);
 }
 
 
+
 /*
  * This serves to avoid cpu buffer overflow, and makes sure
  * the task mortuary progresses
Index: linux/drivers/oprofile/oprof.c
===================================================================
--- linux.orig/drivers/oprofile/oprof.c	2004-10-19 07:53:44.%N +1000
+++ linux/drivers/oprofile/oprof.c	2004-11-07 18:00:02.%N +1100
@@ -20,8 +20,10 @@
 #include "buffer_sync.h"
 #include "oprofile_stats.h"
  
-struct oprofile_operations * oprofile_ops;
+struct oprofile_operations oprofile_ops;
+
 unsigned long oprofile_started;
+unsigned long backtrace_depth;
 static unsigned long is_setup;
 static DECLARE_MUTEX(start_sem);
 
@@ -43,7 +45,7 @@ int oprofile_setup(void)
 	if ((err = alloc_event_buffer()))
 		goto out1;
  
-	if (oprofile_ops->setup && (err = oprofile_ops->setup()))
+	if (oprofile_ops.setup && (err = oprofile_ops.setup()))
 		goto out2;
  
 	/* Note even though this starts part of the
@@ -59,8 +61,8 @@ int oprofile_setup(void)
 	return 0;
  
 out3:
-	if (oprofile_ops->shutdown)
-		oprofile_ops->shutdown();
+	if (oprofile_ops.shutdown)
+		oprofile_ops.shutdown();
 out2:
 	free_event_buffer();
 out1:
@@ -88,7 +90,7 @@ int oprofile_start(void)
  
 	oprofile_reset_stats();
 
-	if ((err = oprofile_ops->start()))
+	if ((err = oprofile_ops.start()))
 		goto out;
 
 	oprofile_started = 1;
@@ -104,7 +106,7 @@ void oprofile_stop(void)
 	down(&start_sem);
 	if (!oprofile_started)
 		goto out;
-	oprofile_ops->stop();
+	oprofile_ops.stop();
 	oprofile_started = 0;
 	/* wake up the daemon to read what remains */
 	wake_up_buffer_waiter();
@@ -117,8 +119,8 @@ void oprofile_shutdown(void)
 {
 	down(&start_sem);
 	sync_stop();
-	if (oprofile_ops->shutdown)
-		oprofile_ops->shutdown(); 
+	if (oprofile_ops.shutdown)
+		oprofile_ops.shutdown(); 
 	is_setup = 0;
 	free_event_buffer();
 	free_cpu_buffers();
@@ -126,38 +128,50 @@ void oprofile_shutdown(void)
 }
 
 
-extern void timer_init(struct oprofile_operations ** ops);
+int oprofile_set_backtrace(unsigned long val)
+{
+	int err = 0;
 
+	down(&start_sem);
 
-static int __init oprofile_init(void)
-{
-	/* Architecture must fill in the interrupt ops and the
-	 * logical CPU type, or we can fall back to the timer
-	 * interrupt profiler.
-	 */
-	int err = oprofile_arch_init(&oprofile_ops);
+	if (oprofile_started) {
+		err = -EBUSY;
+		goto out;
+	}
 
-	if (err == -ENODEV || timer) {
-		timer_init(&oprofile_ops);
-		err = 0;
-	} else if (err) {
+	if (!oprofile_ops.backtrace) {
+		err = -EINVAL;
 		goto out;
 	}
 
-	if (!oprofile_ops->cpu_type) {
-		printk(KERN_ERR "oprofile: cpu_type not set !\n");
-		err = -EFAULT;
+	backtrace_depth = val;
+
+out:
+	up(&start_sem);
+	return err;
+}
+
+
+extern void timer_init(struct oprofile_operations * ops);
+
+static int __init oprofile_init(void)
+{
+	int err = 0;
+
+	/* this is our fallback case */
+	timer_init(&oprofile_ops);
+
+	if (timer) {
+		printk(KERN_INFO "oprofile: using timer interrupt.\n");
 	} else {
-		err = oprofilefs_register();
+		oprofile_arch_init(&oprofile_ops);
 	}
- 
+
+	err = oprofilefs_register();
 	if (err)
-		goto out_exit;
-out:
+		oprofile_arch_exit();
+
 	return err;
-out_exit:
-	oprofile_arch_exit();
-	goto out;
 }
 
 
Index: linux/drivers/oprofile/cpu_buffer.h
===================================================================
--- linux.orig/drivers/oprofile/cpu_buffer.h	2004-10-19 07:55:27.%N +1000
+++ linux/drivers/oprofile/cpu_buffer.h	2004-11-07 18:00:02.%N +1100
@@ -37,9 +37,11 @@ struct oprofile_cpu_buffer {
 	unsigned long buffer_size;
 	struct task_struct * last_task;
 	int last_is_kernel;
+	int tracing;
 	struct op_sample * buffer;
 	unsigned long sample_received;
 	unsigned long sample_lost_overflow;
+	unsigned long backtrace_aborted;
 	int cpu;
 	struct work_struct work;
 } ____cacheline_aligned;
@@ -48,4 +50,8 @@ extern struct oprofile_cpu_buffer cpu_bu
 
 void cpu_buffer_reset(struct oprofile_cpu_buffer * cpu_buf);
 
+/* transient events for the CPU buffer -> event buffer */
+#define CPU_IS_KERNEL 1
+#define CPU_TRACE_BEGIN 2
+
 #endif /* OPROFILE_CPU_BUFFER_H */
Index: linux/drivers/oprofile/buffer_sync.c
===================================================================
--- linux.orig/drivers/oprofile/buffer_sync.c	2004-10-19 07:53:45.%N +1000
+++ linux/drivers/oprofile/buffer_sync.c	2004-11-07 18:00:02.%N +1100
@@ -296,6 +296,13 @@ static void add_cookie_switch(unsigned l
 }
 
  
+static void add_trace_begin(void)
+{
+	add_event_entry(ESCAPE_CODE);
+	add_event_entry(TRACE_BEGIN_CODE);
+}
+
+
 static void add_sample_entry(unsigned long offset, unsigned long event)
 {
 	add_event_entry(offset);
@@ -303,7 +310,7 @@ static void add_sample_entry(unsigned lo
 }
 
 
-static void add_us_sample(struct mm_struct * mm, struct op_sample * s)
+static int add_us_sample(struct mm_struct * mm, struct op_sample * s)
 {
 	unsigned long cookie;
 	off_t offset;
@@ -312,7 +319,7 @@ static void add_us_sample(struct mm_stru
  
 	if (!cookie) {
 		atomic_inc(&oprofile_stats.sample_lost_no_mapping);
-		return;
+		return 0;
 	}
 
 	if (cookie != last_cookie) {
@@ -321,6 +328,8 @@ static void add_us_sample(struct mm_stru
 	}
 
 	add_sample_entry(offset, s->event);
+
+	return 1;
 }
 
  
@@ -328,15 +337,18 @@ static void add_us_sample(struct mm_stru
  * sample is converted into a persistent dentry/offset pair
  * for later lookup from userspace.
  */
-static void add_sample(struct mm_struct * mm, struct op_sample * s, int in_kernel)
+static int
+add_sample(struct mm_struct * mm, struct op_sample * s, int in_kernel)
 {
 	if (in_kernel) {
 		add_sample_entry(s->eip, s->event);
+		return 1;
 	} else if (mm) {
-		add_us_sample(mm, s);
+		return add_us_sample(mm, s);
 	} else {
 		atomic_inc(&oprofile_stats.sample_lost_no_mm);
 	}
+	return 0;
 }
  
 
@@ -358,9 +370,9 @@ static struct mm_struct * take_tasks_mm(
 }
 
 
-static inline int is_ctx_switch(unsigned long val)
+static inline int is_code(unsigned long val)
 {
-	return val == ~0UL;
+	return val == ESCAPE_CODE;
 }
  
 
@@ -397,7 +409,7 @@ static void increment_tail(struct oprofi
 
 	rmb();
 
-	if (new_tail < (b->buffer_size))
+	if (new_tail < b->buffer_size)
 		b->tail_pos = new_tail;
 	else
 		b->tail_pos = 0;
@@ -454,6 +466,17 @@ static void mark_done(int cpu)
 }
 
 
+/* FIXME: this is not sufficient if we implement syscall barrier backtrace
+ * traversal, the code switch to sb_sample_start at first kernel enter/exit
+ * switch so we need a fifth state and some special handling in sync_buffer()
+ */
+typedef enum {
+	sb_bt_ignore = -2,
+	sb_buffer_start,
+	sb_bt_start,
+	sb_sample_start,
+} sync_buffer_state;
+
 /* Sync one of the CPU's buffers into the global event buffer.
  * Here we need to go through each batch of samples punctuated
  * by context switch notes, taking the task's mmap_sem and doing
@@ -468,6 +491,7 @@ void sync_buffer(int cpu)
 	unsigned long cookie = 0;
 	int in_kernel = 1;
 	unsigned int i;
+	sync_buffer_state state = sb_buffer_start;
 	unsigned long available;
 
 	down(&buffer_sem);
@@ -478,14 +502,19 @@ void sync_buffer(int cpu)
 
 	available = get_slots(cpu_buf);
 
-	for (i=0; i < available; ++i) {
+	for (i = 0; i < available; ++i) {
 		struct op_sample * s = &cpu_buf->buffer[cpu_buf->tail_pos];
  
-		if (is_ctx_switch(s->eip)) {
-			if (s->event <= 1) {
+		if (is_code(s->eip)) {
+			if (s->event <= CPU_IS_KERNEL) {
 				/* kernel/userspace switch */
 				in_kernel = s->event;
+				if (state == sb_buffer_start)
+					state = sb_sample_start;
 				add_kernel_ctx_switch(s->event);
+			} else if (s->event == CPU_TRACE_BEGIN) {
+				state = sb_bt_start;
+				add_trace_begin();
 			} else {
 				struct mm_struct * oldmm = mm;
 
@@ -499,7 +528,13 @@ void sync_buffer(int cpu)
 				add_user_ctx_switch(new, cookie);
 			}
 		} else {
-			add_sample(mm, s, in_kernel);
+			if (state >= sb_bt_start &&
+			    !add_sample(mm, s, in_kernel)) {
+				if (state == sb_bt_start) {
+					state = sb_bt_ignore;
+					atomic_inc(&oprofile_stats.bt_lost_no_mapping);
+				}
+			}
 		}
 
 		increment_tail(cpu_buf);
Index: linux/drivers/oprofile/timer_int.c
===================================================================
--- linux.orig/drivers/oprofile/timer_int.c	2004-11-07 17:59:34.%N +1100
+++ linux/drivers/oprofile/timer_int.c	2004-11-07 18:01:50.%N +1100
@@ -17,10 +17,7 @@
  
 static int timer_notify(struct pt_regs *regs)
 {
-	int cpu = smp_processor_id();
-	unsigned long eip = profile_pc(regs);
- 
-	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
+ 	oprofile_add_sample(regs, 0);
 	return 0;
 }
 
@@ -36,15 +33,9 @@ static void timer_stop(void)
 }
 
 
-static struct oprofile_operations timer_ops = {
-	.start	= timer_start,
-	.stop	= timer_stop,
-	.cpu_type = "timer"
-};
-
- 
-void __init timer_init(struct oprofile_operations ** ops)
+void __init timer_init(struct oprofile_operations * ops)
 {
-	*ops = &timer_ops;
-	printk(KERN_INFO "oprofile: using timer interrupt.\n");
+	ops->start = timer_start;
+	ops->stop = timer_stop;
+	ops->cpu_type = "timer";
 }
Index: linux/drivers/oprofile/oprofile_stats.c
===================================================================
--- linux.orig/drivers/oprofile/oprofile_stats.c	2004-10-19 07:54:39.%N +1000
+++ linux/drivers/oprofile/oprofile_stats.c	2004-11-07 18:00:02.%N +1100
@@ -59,6 +59,8 @@ void oprofile_create_stats_files(struct 
 			&cpu_buf->sample_received);
 		oprofilefs_create_ro_ulong(sb, cpudir, "sample_lost_overflow",
 			&cpu_buf->sample_lost_overflow);
+		oprofilefs_create_ro_ulong(sb, cpudir, "backtrace_aborted",
+			&cpu_buf->backtrace_aborted);
 	}
  
 	oprofilefs_create_ro_atomic(sb, dir, "sample_lost_no_mm",
@@ -67,4 +69,6 @@ void oprofile_create_stats_files(struct 
 		&oprofile_stats.sample_lost_no_mapping);
 	oprofilefs_create_ro_atomic(sb, dir, "event_lost_overflow",
 		&oprofile_stats.event_lost_overflow);
+	oprofilefs_create_ro_atomic(sb, dir, "bt_lost_no_mapping",
+		&oprofile_stats.bt_lost_no_mapping);
 }
Index: linux/drivers/oprofile/event_buffer.h
===================================================================
--- linux.orig/drivers/oprofile/event_buffer.h	2004-10-19 07:53:21.%N +1000
+++ linux/drivers/oprofile/event_buffer.h	2004-11-07 18:00:02.%N +1100
@@ -32,6 +32,8 @@ void wake_up_buffer_waiter(void);
 #define KERNEL_EXIT_SWITCH_CODE		5
 #define MODULE_LOADED_CODE		6
 #define CTX_TGID_CODE			7
+#define TRACE_BEGIN_CODE		8
+#define TRACE_END_CODE			9
  
 /* add data to the event buffer */
 void add_event_entry(unsigned long data);
Index: linux/drivers/oprofile/oprof.h
===================================================================
--- linux.orig/drivers/oprofile/oprof.h	2004-10-19 07:53:22.%N +1000
+++ linux/drivers/oprofile/oprof.h	2004-11-07 18:00:02.%N +1100
@@ -24,12 +24,15 @@ struct oprofile_operations;
 extern unsigned long fs_buffer_size;
 extern unsigned long fs_cpu_buffer_size;
 extern unsigned long fs_buffer_watershed;
-extern struct oprofile_operations * oprofile_ops;
+extern struct oprofile_operations oprofile_ops;
 extern unsigned long oprofile_started;
+extern unsigned long backtrace_depth;
  
 struct super_block;
 struct dentry;
 
 void oprofile_create_files(struct super_block * sb, struct dentry * root);
+
+int oprofile_set_backtrace(unsigned long depth);
  
 #endif /* OPROF_H */

--=-UGbe2cNaWP4OUJzb39KB--

