Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbTFROEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265105AbTFROEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:04:09 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:20744 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S265053AbTFRODp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:03:45 -0400
Date: Wed, 18 Jun 2003 15:17:41 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: oprofile-list@lists.sf.net
Subject: [PATCH][RFC] OProfile annotated call graphs
Message-ID: <20030618141741.GA44364@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19Sdkr-00078w-Kw*YNYD3Rn.kmc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below is a simple patch for backtracing for x86. It basically takes an
optimistic approach towards whether ebp has useful values. It seems to
work reasonably well already :

               77.79  442.20       6/58          kmem_cache_free [9]
              661.24 3758.69      51/58          _pte_chain_free [12]
[10]     4.6  752.00 4274.59      58         page_remove_rmap [10]
             1596.54 1578.45     594/679         zap_pte_range [14]
              973.46  112.77     189/1594        do_wp_page [3]
                8.73    3.54      17/2542        zap_pmd_range [27]
                0.28    0.49       8/16796       handle_mm_fault [31]
                0.00    0.32       2/2           copy_one_pte [802]

Obviously you'll need CONFIG_FRAME_POINTER=y for the kernel to get
useful results (without, it still "works" but you only get traces for
sched.c as the frame pointer is enabled there).

If you're bored enough to actually try it out, get 

http://movementarian.org/oprofile-0.6cvs.tar.gz

then

opcontrol --init
echo 20 >/dev/oprofile/backtrace_depth
start the profiler
opcontrol --dump
opgprof /boot/2.5.72/vmlinux # or whatever, generates gmon.out
gprof /boot/2.5.72/vmlinux # gives gprof output

The userspace is broken for doing anything other than the above at this
point.

Any comments ?

regards,
john


diff -Naur -X dontdiff linux-cvs/arch/alpha/oprofile/op_model_ev4.c linux-me/arch/alpha/oprofile/op_model_ev4.c
--- linux-cvs/arch/alpha/oprofile/op_model_ev4.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/arch/alpha/oprofile/op_model_ev4.c	2003-06-11 01:16:55.000000000 +0100
@@ -101,8 +101,7 @@
 		return;
 
 	/* Record the sample.  */
-	oprofile_add_sample(regs->pc, !user_mode(regs),
-			    which, smp_processor_id());
+	oprofile_add_sample(regs, which);
 }
 
 
diff -Naur -X dontdiff linux-cvs/arch/alpha/oprofile/op_model_ev5.c linux-me/arch/alpha/oprofile/op_model_ev5.c
--- linux-cvs/arch/alpha/oprofile/op_model_ev5.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/arch/alpha/oprofile/op_model_ev5.c	2003-06-11 01:17:02.000000000 +0100
@@ -186,8 +186,7 @@
 		     struct op_counter_config *ctr)
 {
 	/* Record the sample.  */
-	oprofile_add_sample(regs->pc, !user_mode(regs),
-			    which, smp_processor_id());
+	oprofile_add_sample(regs, which);
 }
 
 
diff -Naur -X dontdiff linux-cvs/arch/alpha/oprofile/op_model_ev67.c linux-me/arch/alpha/oprofile/op_model_ev67.c
--- linux-cvs/arch/alpha/oprofile/op_model_ev67.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/arch/alpha/oprofile/op_model_ev67.c	2003-06-11 01:17:45.000000000 +0100
@@ -138,8 +138,7 @@
 	if (counter == 1)
 		fake_counter += PM_NUM_COUNTERS;
 	if (ctr[fake_counter].enabled)
-		oprofile_add_sample(pc, kern, fake_counter,
-				    smp_processor_id());
+		oprofile_add_pc(pc, kern, fake_counter);
 }
 
 static void
@@ -197,8 +196,7 @@
 			   to PALcode. Recognize ITB miss by PALcode
 			   offset address, and get actual PC from
 			   EXC_ADDR.  */
-			oprofile_add_sample(regs->pc, kern, which,
-					    smp_processor_id());
+			oprofile_add_pc(regs->pc, kern, which);
 			if ((pmpc & ((1 << 15) - 1)) ==  581)
 				op_add_pm(regs->pc, kern, which,
 					  ctr, PM_ITB_MISS);
@@ -241,7 +239,7 @@
 		}
 	}
 
-	oprofile_add_sample(pmpc, kern, which, smp_processor_id());
+	oprofile_add_pc(pmpc, kern, which);
 
 	pctr_ctl = wrperfmon(5, 0);
 	if (pctr_ctl & (1UL << 27))
diff -Naur -X dontdiff linux-cvs/arch/alpha/oprofile/op_model_ev6.c linux-me/arch/alpha/oprofile/op_model_ev6.c
--- linux-cvs/arch/alpha/oprofile/op_model_ev6.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/arch/alpha/oprofile/op_model_ev6.c	2003-06-11 01:17:09.000000000 +0100
@@ -88,8 +88,7 @@
 		     struct op_counter_config *ctr)
 {
 	/* Record the sample.  */
-	oprofile_add_sample(regs->pc, !user_mode(regs),
-			    which, smp_processor_id());
+	oprofile_add_sample(regs, which);
 }
 
 
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/backtrace.c linux-me/arch/i386/oprofile/backtrace.c
--- linux-cvs/arch/i386/oprofile/backtrace.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-me/arch/i386/oprofile/backtrace.c	2003-06-16 20:36:26.000000000 +0100
@@ -0,0 +1,98 @@
+/**
+ * @file backtrace.c
+ *
+ * @remark Copyright 2002 OProfile authors
+ * @remark Read the file COPYING
+ *
+ * @author John Levon
+ * @author David Smith
+ */
+
+#include <linux/oprofile.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <asm/ptrace.h>
+ 
+struct frame_head {
+	struct frame_head * ebp;
+	unsigned long ret;
+} __attribute__((packed));
+
+
+static struct frame_head * dump_backtrace(struct frame_head * head)
+{
+	oprofile_add_trace(head->ret);
+
+	/* frame pointers should strictly progress back up the stack
+	 * (towards higher addresses) */
+	if (head >= head->ebp)
+		return 0;
+
+	return head->ebp;
+}
+
+
+/* check that the page(s) containing the frame head are present */
+static int pages_present(struct frame_head * head)
+{
+	struct mm_struct * mm = current->mm;
+
+	/* FIXME: only necessary once per page */
+	if (!follow_page(mm, (unsigned long)head, 0))
+		return 0;
+
+	return (int)follow_page(mm, (unsigned long)(head + 1), 0);
+}
+
+
+/*
+ * |             | /\ Higher addresses
+ * |             |
+ * --------------- stack base (address of current_thread_info)
+ * | thread info |
+ * .             .
+ * |    stack    |
+ * --------------- saved regs->ebp value if valid (frame_head address)
+ * .             .
+ * --------------- struct pt_regs stored on stack (struct pt_regs *)
+ * |             |
+ * .             .
+ * |             |
+ * --------------- %esp
+ * |             |
+ * |             | \/ Lower addresses
+ *
+ * Thus, &pt_regs <-> stack base restricts the valid(ish) ebp values
+ */
+static int valid_kernel_stack(struct frame_head * head, struct pt_regs * regs)
+{
+	unsigned long headaddr = (unsigned long)head;
+	unsigned long stack = (unsigned long)regs;
+	unsigned long stack_base = (stack & ~(THREAD_SIZE - 1)) + THREAD_SIZE;
+
+	return headaddr > stack && headaddr < stack_base;
+}
+
+
+void x86_backtrace(struct pt_regs * const regs, unsigned int depth)
+{
+	struct frame_head * head = (struct frame_head *)regs->ebp;
+
+	if (!user_mode(regs)) {
+		while (depth-- && valid_kernel_stack(head, regs))
+			head = dump_backtrace(head);
+		return;
+	}
+
+#ifdef CONFIG_SMP
+	if (!spin_trylock(&current->mm->page_table_lock))
+		return;
+#endif
+
+	while (depth-- && head && pages_present(head))
+		head = dump_backtrace(head);
+
+#ifdef CONFIG_SMP
+	spin_unlock(&current->mm->page_table_lock);
+#endif
+}
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/init.c linux-me/arch/i386/oprofile/init.c
--- linux-cvs/arch/i386/oprofile/init.c	2003-06-18 15:06:05.000000000 +0100
+++ linux-me/arch/i386/oprofile/init.c	2003-06-18 15:11:11.000000000 +0100
@@ -18,18 +18,22 @@
 extern int nmi_init(struct oprofile_operations ** ops);
 extern int nmi_timer_init(struct oprofile_operations **ops);
 extern void nmi_exit(void);
+extern void
+x86_backtrace(struct pt_regs * const regs, unsigned int depth);
+
 
 int __init oprofile_arch_init(struct oprofile_operations ** ops)
 {
 	int ret = -ENODEV;
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	ret = nmi_init(ops);
 #endif
-
 #ifdef CONFIG_X86_IO_APIC
 	if (ret < 0)
 		ret = nmi_timer_init(ops);
 #endif
+	(*ops)->backtrace = x86_backtrace;
 	return ret;
 }
 
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/Makefile linux-me/arch/i386/oprofile/Makefile
--- linux-cvs/arch/i386/oprofile/Makefile	2003-06-18 15:06:05.000000000 +0100
+++ linux-me/arch/i386/oprofile/Makefile	2003-06-18 15:10:02.000000000 +0100
@@ -6,7 +6,7 @@
 		oprofilefs.o oprofile_stats.o  \
 		timer_int.o )
 
-oprofile-y				:= $(DRIVER_OBJS) init.o
+oprofile-y				:= $(DRIVER_OBJS) init.o backtrace.o
 oprofile-$(CONFIG_X86_LOCAL_APIC) 	+= nmi_int.o op_model_athlon.o \
 					   op_model_ppro.o op_model_p4.o
 oprofile-$(CONFIG_X86_IO_APIC)		+= nmi_timer_int.o
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/nmi_int.c linux-me/arch/i386/oprofile/nmi_int.c
--- linux-cvs/arch/i386/oprofile/nmi_int.c	2003-06-18 15:06:05.000000000 +0100
+++ linux-me/arch/i386/oprofile/nmi_int.c	2003-06-18 15:10:02.000000000 +0100
@@ -83,7 +83,7 @@
 
 static int nmi_callback(struct pt_regs * regs, int cpu)
 {
-	return model->check_ctrs(cpu, &cpu_msrs[cpu], regs);
+	return model->check_ctrs(regs, &cpu_msrs[cpu]);
 }
  
  
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/nmi_timer_int.c linux-me/arch/i386/oprofile/nmi_timer_int.c
--- linux-cvs/arch/i386/oprofile/nmi_timer_int.c	2003-06-21 17:19:10.000000000 +0100
+++ linux-me/arch/i386/oprofile/nmi_timer_int.c	2003-06-18 15:12:03.000000000 +0100
@@ -20,9 +20,7 @@
  
 static int nmi_timer_callback(struct pt_regs * regs, int cpu)
 {
-	unsigned long eip = instruction_pointer(regs);
- 
-	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
+	oprofile_add_sample(regs, 0);
 	return 1;
 }
 
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/op_model_athlon.c linux-me/arch/i386/oprofile/op_model_athlon.c
--- linux-cvs/arch/i386/oprofile/op_model_athlon.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/arch/i386/oprofile/op_model_athlon.c	2003-06-11 01:18:39.000000000 +0100
@@ -90,19 +90,16 @@
 }
 
  
-static int athlon_check_ctrs(unsigned int const cpu, 
-			      struct op_msrs const * const msrs, 
-			      struct pt_regs * const regs)
+static int athlon_check_ctrs(struct pt_regs * const regs,
+                             struct op_msrs const * const msrs)
 {
 	unsigned int low, high;
 	int i;
-	unsigned long eip = instruction_pointer(regs);
-	int is_kernel = !user_mode(regs);
 
 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
 		CTR_READ(low, high, msrs, i);
 		if (CTR_OVERFLOWED(low)) {
-			oprofile_add_sample(eip, is_kernel, i, cpu);
+			oprofile_add_sample(regs, i);
 			CTR_WRITE(reset_value[i], msrs, i);
 		}
 	}
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/op_model_p4.c linux-me/arch/i386/oprofile/op_model_p4.c
--- linux-cvs/arch/i386/oprofile/op_model_p4.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/arch/i386/oprofile/op_model_p4.c	2003-06-11 01:19:12.000000000 +0100
@@ -592,14 +592,11 @@
 }
 
 
-static int p4_check_ctrs(unsigned int const cpu, 
-			  struct op_msrs const * const msrs,
-			  struct pt_regs * const regs)
+static int p4_check_ctrs(struct pt_regs * const regs,
+                         struct op_msrs const * const msrs)
 {
 	unsigned long ctr, low, high, stag, real;
 	int i;
-	unsigned long eip = instruction_pointer(regs);
-	int is_kernel = !user_mode(regs);
 
 	stag = get_stagger();
 
@@ -630,7 +627,7 @@
 		CCCR_READ(low, high, real);
  		CTR_READ(ctr, high, real);
 		if (CCCR_OVF_P(low) || CTR_OVERFLOW_P(ctr)) {
-			oprofile_add_sample(eip, is_kernel, i, cpu);
+			oprofile_add_sample(regs, i);
  			CTR_WRITE(reset_value[i], real);
 			CCCR_CLEAR_OVF(low);
 			CCCR_WRITE(low, high, real);
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/op_model_ppro.c linux-me/arch/i386/oprofile/op_model_ppro.c
--- linux-cvs/arch/i386/oprofile/op_model_ppro.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/arch/i386/oprofile/op_model_ppro.c	2003-06-11 01:20:29.000000000 +0100
@@ -84,19 +84,16 @@
 }
 
  
-static int ppro_check_ctrs(unsigned int const cpu, 
-			    struct op_msrs const * const msrs,
-			    struct pt_regs * const regs)
+static int ppro_check_ctrs(struct pt_regs * const regs,
+                           struct op_msrs const * const msrs)
 {
 	unsigned int low, high;
 	int i;
-	unsigned long eip = instruction_pointer(regs);
-	int is_kernel = !user_mode(regs);
  
 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
 		CTR_READ(low, high, msrs, i);
 		if (CTR_OVERFLOWED(low)) {
-			oprofile_add_sample(eip, is_kernel, i, cpu);
+			oprofile_add_sample(regs, i);
 			CTR_WRITE(reset_value[i], msrs, i);
 		}
 	}
diff -Naur -X dontdiff linux-cvs/arch/i386/oprofile/op_x86_model.h linux-me/arch/i386/oprofile/op_x86_model.h
--- linux-cvs/arch/i386/oprofile/op_x86_model.h	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/arch/i386/oprofile/op_x86_model.h	2003-06-11 01:19:49.000000000 +0100
@@ -39,9 +39,8 @@
 	unsigned int const num_controls;
 	void (*fill_in_addresses)(struct op_msrs * const msrs);
 	void (*setup_ctrs)(struct op_msrs const * const msrs);
-	int (*check_ctrs)(unsigned int const cpu, 
-		struct op_msrs const * const msrs,
-		struct pt_regs * const regs);
+	int (*check_ctrs)(struct pt_regs * const regs,
+		struct op_msrs const * const msrs);
 	void (*start)(struct op_msrs const * const msrs);
 	void (*stop)(struct op_msrs const * const msrs);
 };
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/buffer_sync.c linux-me/drivers/oprofile/buffer_sync.c
--- linux-cvs/drivers/oprofile/buffer_sync.c	2003-06-18 15:06:09.000000000 +0100
+++ linux-me/drivers/oprofile/buffer_sync.c	2003-06-18 15:12:52.000000000 +0100
@@ -294,6 +294,20 @@
 }
 
  
+static void add_trace_begin(void)
+{
+	add_event_entry(ESCAPE_CODE);
+	add_event_entry(TRACE_BEGIN_CODE);
+}
+
+
+static void add_trace_end(void)
+{
+	add_event_entry(ESCAPE_CODE);
+	add_event_entry(TRACE_END_CODE);
+}
+
+
 static void add_sample_entry(unsigned long offset, unsigned long event)
 {
 	add_event_entry(offset);
@@ -324,7 +338,8 @@
  * sample is converted into a persistent dentry/offset pair
  * for later lookup from userspace.
  */
-static void add_sample(struct mm_struct * mm, struct op_sample * s, int in_kernel)
+static void
+add_sample(struct mm_struct * mm, struct op_sample * s, int in_kernel)
 {
 	if (in_kernel) {
 		add_sample_entry(s->eip, s->event);
@@ -369,7 +384,7 @@
 }
  
  
-static inline int is_ctx_switch(unsigned long val)
+static inline int is_code(unsigned long val)
 {
 	return val == ~0UL;
 }
@@ -436,29 +451,36 @@
 	for (i=0; i < available; ++i) {
 		struct op_sample * s = &cpu_buf->buffer[cpu_buf->tail_pos];
  
-		if (is_ctx_switch(s->eip)) {
-			if (s->event <= 1) {
-				/* kernel/userspace switch */
-				in_kernel = s->event;
-				add_kernel_ctx_switch(s->event);
-			} else {
-				struct mm_struct * oldmm = mm;
-
-				/* userspace context switch */
-				new = (struct task_struct *)s->event;
-
-				release_mm(oldmm);
-				mm = take_tasks_mm(new);
-				if (mm != oldmm)
-					cookie = get_exec_dcookie(mm);
-				add_user_ctx_switch(new, cookie);
-			}
-		} else {
+		if (!is_code(s->eip)) {
 			add_sample(mm, s, in_kernel);
+			increment_tail(cpu_buf);
+			continue;
+		}
+
+		if (s->event <= CPU_IS_KERNEL) {
+			/* kernel/userspace switch */
+			in_kernel = s->event;
+			add_kernel_ctx_switch(s->event);
+		} else if (s->event == CPU_TRACE_BEGIN) {
+			add_trace_begin();
+		} else if (s->event == CPU_TRACE_END) {
+			add_trace_end();
+		} else {
+			struct mm_struct * oldmm = mm;
+
+			/* userspace context switch */
+			new = (struct task_struct *)s->event;
+
+			release_mm(oldmm);
+			mm = take_tasks_mm(new);
+			if (mm != oldmm)
+				cookie = get_exec_dcookie(mm);
+			add_user_ctx_switch(new, cookie);
 		}
 
 		increment_tail(cpu_buf);
 	}
+
 	release_mm(mm);
 }
  
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/cpu_buffer.c linux-me/drivers/oprofile/cpu_buffer.c
--- linux-cvs/drivers/oprofile/cpu_buffer.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/drivers/oprofile/cpu_buffer.c	2003-06-11 01:23:43.000000000 +0100
@@ -18,6 +18,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/oprofile.h>
 #include <linux/vmalloc.h>
 #include <linux/errno.h>
  
@@ -59,6 +60,7 @@
  
 		b->last_task = 0;
 		b->last_is_kernel = -1;
+		b->tracing = 0;
 		b->buffer_size = buffer_size;
 		b->tail_pos = 0;
 		b->head_pos = 0;
@@ -79,6 +81,20 @@
 }
 
 
+/* Resets the cpu buffer to a sane state. */
+void cpu_buffer_reset(struct oprofile_cpu_buffer * cpu_buf)
+{
+	/* reset these to invalid values; the next sample
+	 * collected will populate the buffer with proper
+	 * values to initialize the buffer
+	 */
+	cpu_buf->last_is_kernel = -1;
+	cpu_buf->last_task = 0;
+	/* avoid a dangling set of trace entries */
+	cpu_buf->tracing = 0;
+}
+
+
 /* compute number of available slots in cpu_buffer queue */
 static unsigned long nr_available_slots(struct oprofile_cpu_buffer const * b)
 {
@@ -107,29 +123,43 @@
 }
 
 
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
+	add_sample(buffer, ~0UL, value);
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
+                      int is_kernel, unsigned long event)
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
 
 	task = current;
@@ -137,18 +167,14 @@
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
 		if (!(task->flags & PF_EXITING)) {
-			cpu_buf->buffer[cpu_buf->head_pos].eip = ~0UL;
-			cpu_buf->buffer[cpu_buf->head_pos].event = (unsigned long)task;
-			increment_head(cpu_buf);
+			add_code(cpu_buf, (unsigned long)task);
 		}
 	}
  
@@ -159,22 +185,80 @@
 	 */
 	if (task->flags & PF_EXITING) {
 		cpu_buf->sample_lost_task_exit++;
-		return;
+		return 0;
 	}
  
-	cpu_buf->buffer[cpu_buf->head_pos].eip = eip;
-	cpu_buf->buffer[cpu_buf->head_pos].event = event;
-	increment_head(cpu_buf);
+	add_sample(cpu_buf, pc, event);
+	return 1;
 }
 
 
-/* Resets the cpu buffer to a sane state. */
-void cpu_buffer_reset(struct oprofile_cpu_buffer * cpu_buf)
+static int oprofile_begin_trace(struct oprofile_cpu_buffer * cpu_buf)
 {
-	/* reset these to invalid values; the next sample
-	 * collected will populate the buffer with proper
-	 * values to initialize the buffer
-	 */
-	cpu_buf->last_is_kernel = -1;
-	cpu_buf->last_task = 0;
+	if (nr_available_slots(cpu_buf) < 4) {
+		cpu_buf->sample_lost_overflow++;
+		return 0;
+	}
+
+	add_code(cpu_buf, CPU_TRACE_BEGIN);
+	cpu_buf->tracing = 1;
+	return 1;
+}
+
+
+static void oprofile_end_trace(struct oprofile_cpu_buffer * cpu_buf)
+{
+	if (!cpu_buf->tracing)
+		return;
+
+	cpu_buf->tracing = 0;
+
+	if (nr_available_slots(cpu_buf) < 1)
+		return;
+
+	add_code(cpu_buf, CPU_TRACE_END);
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
+	log_sample(cpu_buf, pc, is_kernel, event);
+	oprofile_ops->backtrace(regs, backtrace_depth);
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
+	add_sample(cpu_buf, pc, 0);
 }
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/cpu_buffer.h linux-me/drivers/oprofile/cpu_buffer.h
--- linux-cvs/drivers/oprofile/cpu_buffer.h	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/drivers/oprofile/cpu_buffer.h	2003-06-09 22:30:30.000000000 +0100
@@ -35,6 +35,7 @@
 	unsigned long buffer_size;
 	struct task_struct * last_task;
 	int last_is_kernel;
+	int tracing;
 	struct op_sample * buffer;
 	unsigned long sample_received;
 	unsigned long sample_lost_overflow;
@@ -45,4 +46,9 @@
 
 void cpu_buffer_reset(struct oprofile_cpu_buffer *cpu_buf);
 
+/* transient events for the CPU buffer -> event buffer */
+#define CPU_IS_KERNEL 1
+#define CPU_TRACE_BEGIN 2
+#define CPU_TRACE_END 3
+
 #endif /* OPROFILE_CPU_BUFFER_H */
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/event_buffer.h linux-me/drivers/oprofile/event_buffer.h
--- linux-cvs/drivers/oprofile/event_buffer.h	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/drivers/oprofile/event_buffer.h	2003-06-12 11:44:27.000000000 +0100
@@ -32,6 +32,8 @@
 #define KERNEL_EXIT_SWITCH_CODE		5
 #define MODULE_LOADED_CODE		6
 #define CTX_TGID_CODE			7
+#define TRACE_BEGIN_CODE		8
+#define TRACE_END_CODE			9
  
 /* add data to the event buffer */
 void add_event_entry(unsigned long data);
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/oprof.c linux-me/drivers/oprofile/oprof.c
--- linux-cvs/drivers/oprofile/oprof.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/drivers/oprofile/oprof.c	2003-06-12 11:46:22.000000000 +0100
@@ -22,6 +22,7 @@
  
 struct oprofile_operations * oprofile_ops;
 unsigned long oprofile_started;
+unsigned long backtrace_depth;
 static unsigned long is_setup;
 static DECLARE_MUTEX(start_sem);
 
@@ -126,6 +127,30 @@
 }
 
 
+int oprofile_set_backtrace(unsigned long val)
+{
+	int err = 0;
+
+	down(&start_sem);
+
+	if (oprofile_started) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	if (!oprofile_ops->backtrace) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	backtrace_depth = val;
+
+out:
+	up(&start_sem);
+	return err;
+}
+
+
 extern void timer_init(struct oprofile_operations ** ops);
 
 
@@ -137,27 +162,20 @@
 	 */
 	int err = oprofile_arch_init(&oprofile_ops);
 
+	/* over-ride with timer interrupt if set */
 	if (err == -ENODEV || timer) {
 		timer_init(&oprofile_ops);
+		printk(KERN_INFO "oprofile: using timer interrupt.\n");
 		err = 0;
-	} else if (err) {
-		goto out;
 	}
 
-	if (!oprofile_ops->cpu_type) {
-		printk(KERN_ERR "oprofile: cpu_type not set !\n");
-		err = -EFAULT;
-	} else {
+	if (!err) {
 		err = oprofilefs_register();
+		if (err)
+			oprofile_arch_exit();
 	}
  
-	if (err)
-		goto out_exit;
-out:
 	return err;
-out_exit:
-	oprofile_arch_exit();
-	goto out;
 }
 
 
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/oprof.h linux-me/drivers/oprofile/oprof.h
--- linux-cvs/drivers/oprofile/oprof.h	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/drivers/oprofile/oprof.h	2003-06-10 22:06:32.000000000 +0100
@@ -26,10 +26,13 @@
 extern unsigned long fs_buffer_watershed;
 extern struct oprofile_operations * oprofile_ops;
 extern unsigned long oprofile_started;
+extern unsigned long backtrace_depth;
  
 struct super_block;
 struct dentry;
 
 void oprofile_create_files(struct super_block * sb, struct dentry * root);
+
+int oprofile_set_backtrace(unsigned long depth);
  
 #endif /* OPROF_H */
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/oprofile_files.c linux-me/drivers/oprofile/oprofile_files.c
--- linux-cvs/drivers/oprofile/oprofile_files.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/drivers/oprofile/oprofile_files.c	2003-06-10 22:02:36.000000000 +0100
@@ -18,7 +18,38 @@
 unsigned long fs_cpu_buffer_size = 8192;
 unsigned long fs_buffer_watershed = 32768; /* FIXME: tune */
 
+static ssize_t depth_read(struct file * file, char * buf, size_t count, loff_t * offset)
+{
+	return oprofilefs_ulong_to_user(&backtrace_depth, buf, count, offset);
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
+
 static ssize_t cpu_type_read(struct file * file, char * buf, size_t count, loff_t * offset)
 {
 	return oprofilefs_str_to_user(oprofile_ops->cpu_type, buf, count, offset);
@@ -36,7 +67,7 @@
 }
 
 
-static ssize_t enable_write(struct file *file, char const * buf, size_t count, loff_t * offset)
+static ssize_t enable_write(struct file * file, char const * buf, size_t count, loff_t * offset)
 {
 	unsigned long val;
 	int retval;
@@ -85,6 +116,7 @@
 	oprofilefs_create_ulong(sb, root, "buffer_watershed", &fs_buffer_watershed);
 	oprofilefs_create_ulong(sb, root, "cpu_buffer_size", &fs_cpu_buffer_size);
 	oprofilefs_create_file(sb, root, "cpu_type", &cpu_type_fops); 
+	oprofilefs_create_file(sb, root, "backtrace_depth", &depth_fops);
 	oprofile_create_stats_files(sb, root);
 	if (oprofile_ops->create_files)
 		oprofile_ops->create_files(sb, root);
diff -Naur -X dontdiff linux-cvs/drivers/oprofile/timer_int.c linux-me/drivers/oprofile/timer_int.c
--- linux-cvs/drivers/oprofile/timer_int.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/drivers/oprofile/timer_int.c	2003-06-11 01:25:00.000000000 +0100
@@ -18,11 +18,7 @@
  
 static int timer_notify(struct notifier_block * self, unsigned long val, void * data)
 {
-	struct pt_regs * regs = (struct pt_regs *)data;
-	int cpu = smp_processor_id();
-	unsigned long eip = instruction_pointer(regs);
- 
-	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
+	oprofile_add_sample((struct pt_regs *)data, 0);
 	return 0;
 }
  
@@ -54,5 +50,4 @@
 void __init timer_init(struct oprofile_operations ** ops)
 {
 	*ops = &timer_ops;
-	printk(KERN_INFO "oprofile: using timer interrupt.\n");
 }
diff -Naur -X dontdiff linux-cvs/include/linux/oprofile.h linux-me/include/linux/oprofile.h
--- linux-cvs/include/linux/oprofile.h	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/include/linux/oprofile.h	2003-06-12 11:46:39.000000000 +0100
@@ -20,6 +20,7 @@
 struct super_block;
 struct dentry;
 struct file_operations;
+struct pt_regs;
  
 /* Operations structure to be filled in */
 struct oprofile_operations {
@@ -34,6 +35,8 @@
 	int (*start)(void);
 	/* Stop delivering interrupts. */
 	void (*stop)(void);
+	/* Initiate a stack backtrace. */
+	void (*backtrace)(struct pt_regs * const regs, unsigned int depth);
 	/* CPU identification string. */
 	char * cpu_type;
 };
@@ -41,7 +44,7 @@
 /**
  * One-time initialisation. *ops must be set to a filled-in
  * operations structure. This is called even in timer interrupt
- * mode.
+ * mode so an arch can set a backtrace callback.
  *
  * Return 0 on success.
  */
@@ -56,8 +59,15 @@
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
diff -Naur -X dontdiff linux-cvs/kernel/ksyms.c linux-me/kernel/ksyms.c
--- linux-cvs/kernel/ksyms.c	2003-06-15 02:06:38.000000000 +0100
+++ linux-me/kernel/ksyms.c	2003-06-12 11:19:38.000000000 +0100
@@ -134,6 +134,7 @@
 EXPORT_SYMBOL(page_address);
 #endif
 EXPORT_SYMBOL(get_user_pages);
+EXPORT_SYMBOL(follow_page);
 
 /* filesystem internal functions */
 EXPORT_SYMBOL(def_blk_fops);
