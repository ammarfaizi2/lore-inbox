Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267635AbTBKLgP>; Tue, 11 Feb 2003 06:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbTBKLgP>; Tue, 11 Feb 2003 06:36:15 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:16652 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267635AbTBKLfv>; Tue, 11 Feb 2003 06:35:51 -0500
Date: Tue, 11 Feb 2003 11:45:37 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH 4/4] oprofile update: kernel/user addresses fix
Message-ID: <20030211114537.GD57908@compsoc.man.ac.uk>
References: <20030211113227.GH53481@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030211113227.GH53481@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18iYr3-0005u0-00*02vxT6W4V6c*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch replaces the assumption that > PAGE_OFFSET == kernel address
with testing for user_mode(regs) and inserting switch codes instead.


diff -Naur -X dontdiff linux/arch/i386/oprofile/op_model_athlon.c linux2/arch/i386/oprofile/op_model_athlon.c
--- linux/arch/i386/oprofile/op_model_athlon.c	2003-01-03 03:15:26.000000000 +0000
+++ linux2/arch/i386/oprofile/op_model_athlon.c	2003-01-23 20:24:53.000000000 +0000
@@ -96,10 +96,13 @@
 {
 	unsigned int low, high;
 	int i;
+	unsigned long eip = instruction_pointer(regs);
+	int is_kernel = !user_mode(regs);
+
 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
 		CTR_READ(low, high, msrs, i);
 		if (CTR_OVERFLOWED(low)) {
-			oprofile_add_sample(instruction_pointer(regs), i, cpu);
+			oprofile_add_sample(eip, is_kernel, i, cpu);
 			CTR_WRITE(reset_value[i], msrs, i);
 			return 1;
 		}
diff -Naur -X dontdiff linux/arch/i386/oprofile/op_model_p4.c linux2/arch/i386/oprofile/op_model_p4.c
--- linux/arch/i386/oprofile/op_model_p4.c	2003-01-15 19:26:32.000000000 +0000
+++ linux2/arch/i386/oprofile/op_model_p4.c	2003-01-31 03:57:28.000000000 +0000
@@ -569,6 +569,8 @@
 {
 	unsigned long ctr, low, high, stag, real;
 	int i;
+	unsigned long eip = instruction_pointer(regs);
+	int is_kernel = !user_mode(regs);
 
 	stag = get_stagger();
 
@@ -599,7 +601,7 @@
 		CCCR_READ(low, high, real);
  		CTR_READ(ctr, high, real);
 		if (CCCR_OVF_P(low) || CTR_OVERFLOW_P(ctr)) {
-			oprofile_add_sample(regs->eip, i, cpu);
+			oprofile_add_sample(eip, is_kernel, i, cpu);
  			CTR_WRITE(reset_value[i], real);
 			CCCR_CLEAR_OVF(low);
 			CCCR_WRITE(low, high, real);
@@ -624,7 +626,8 @@
 	stag = get_stagger();
 
 	for (i = 0; i < num_counters; ++i) {
-		if (!reset_value[i]) continue;
+		if (!reset_value[i])
+			continue;
 		CCCR_READ(low, high, VIRT_CTR(stag, i));
 		CCCR_SET_ENABLE(low);
 		CCCR_WRITE(low, high, VIRT_CTR(stag, i));
diff -Naur -X dontdiff linux/arch/i386/oprofile/op_model_ppro.c linux2/arch/i386/oprofile/op_model_ppro.c
--- linux/arch/i386/oprofile/op_model_ppro.c	2003-01-03 03:15:26.000000000 +0000
+++ linux2/arch/i386/oprofile/op_model_ppro.c	2003-01-23 20:24:53.000000000 +0000
@@ -90,11 +90,13 @@
 {
 	unsigned int low, high;
 	int i;
+	unsigned long eip = instruction_pointer(regs);
+	int is_kernel = !user_mode(regs);
  
 	for (i = 0 ; i < NUM_COUNTERS; ++i) {
 		CTR_READ(low, high, msrs, i);
 		if (CTR_OVERFLOWED(low)) {
-			oprofile_add_sample(instruction_pointer(regs), i, cpu);
+			oprofile_add_sample(eip, is_kernel, i, cpu);
 			CTR_WRITE(reset_value[i], msrs, i);
 			return 1;
 		}
diff -Naur -X dontdiff linux/arch/i386/oprofile/timer_int.c linux2/arch/i386/oprofile/timer_int.c
--- linux/arch/i386/oprofile/timer_int.c	2003-02-10 19:40:25.000000000 +0000
+++ linux2/arch/i386/oprofile/timer_int.c	2003-01-23 20:24:53.000000000 +0000
@@ -20,8 +20,9 @@
 {
 	struct pt_regs * regs = (struct pt_regs *)data;
 	int cpu = smp_processor_id();
+	unsigned long eip = instruction_pointer(regs);
  
-	oprofile_add_sample(instruction_pointer(regs), 0, cpu);
+	oprofile_add_sample(eip, !user_mode(regs), 0, cpu);
 	return 0;
 }
  
diff -Naur -X dontdiff linux/arch/parisc/oprofile/timer_int.c linux2/arch/parisc/oprofile/timer_int.c
--- linux/arch/parisc/oprofile/timer_int.c	2003-02-11 10:53:30.000000000 +0000
+++ linux2/arch/parisc/oprofile/timer_int.c	2003-01-23 20:30:56.000000000 +0000
@@ -19,8 +19,10 @@
 {
 	struct pt_regs * regs = (struct pt_regs *)data;
 	int cpu = smp_processor_id();
+	unsigned long pc = regs->iaoq[0];
+	int is_kernel = !user_mode(regs);
  
-	oprofile_add_sample(regs->iaoq[0], 0, cpu);
+	oprofile_add_sample(pc, is_kernel, 0, cpu);
 	return 0;
 }
  
diff -Naur -X dontdiff linux/arch/ppc64/oprofile/timer_int.c linux2/arch/ppc64/oprofile/timer_int.c
--- linux/arch/ppc64/oprofile/timer_int.c	2003-02-10 19:40:25.000000000 +0000
+++ linux2/arch/ppc64/oprofile/timer_int.c	2003-01-23 20:28:39.000000000 +0000
@@ -19,8 +19,10 @@
 {
 	struct pt_regs * regs = (struct pt_regs *)data;
 	int cpu = smp_processor_id();
+	unsigned long pc = instruction_pointer(regs);
+	int is_kernel = !user_mode(regs);
  
-	oprofile_add_sample(instruction_pointer(regs), 0, cpu);
+	oprofile_add_sample(pc, is_kernel, 0, cpu);
 	return 0;
 }
  
diff -Naur -X dontdiff linux/arch/sparc64/oprofile/timer_int.c linux2/arch/sparc64/oprofile/timer_int.c
--- linux/arch/sparc64/oprofile/timer_int.c	2003-02-10 19:40:25.000000000 +0000
+++ linux2/arch/sparc64/oprofile/timer_int.c	2003-01-23 20:27:54.000000000 +0000
@@ -19,8 +19,10 @@
 {
 	struct pt_regs * regs = (struct pt_regs *)data;
 	int cpu = smp_processor_id();
+	unsigned long pc = instruction_pointer(regs);
+	int is_kernel = !user_mode(regs);
  
-	oprofile_add_sample(instruction_pointer(regs), 0, cpu);
+	oprofile_add_sample(pc, is_kernel, 0, cpu);
 	return 0;
 }
  
diff -Naur -X dontdiff linux/drivers/oprofile/buffer_sync.c linux2/drivers/oprofile/buffer_sync.c
--- linux/drivers/oprofile/buffer_sync.c	2003-01-11 20:04:17.000000000 +0000
+++ linux2/drivers/oprofile/buffer_sync.c	2003-02-10 19:47:30.000000000 +0000
@@ -199,8 +199,16 @@
 	last_cookie = ~0UL;
 }
 
+static void add_kernel_ctx_switch(unsigned int in_kernel)
+{
+	add_event_entry(ESCAPE_CODE);
+	if (in_kernel)
+		add_event_entry(KERNEL_ENTER_SWITCH_CODE); 
+	else
+		add_event_entry(KERNEL_EXIT_SWITCH_CODE); 
+}
  
-static void add_ctx_switch(pid_t pid, unsigned long cookie)
+static void add_user_ctx_switch(pid_t pid, unsigned long cookie)
 {
 	add_event_entry(ESCAPE_CODE);
 	add_event_entry(CTX_SWITCH_CODE); 
@@ -243,19 +251,13 @@
 }
 
  
-static inline int is_kernel(unsigned long val)
-{
-	return val > PAGE_OFFSET;
-}
-
-
 /* Add a sample to the global event buffer. If possible the
  * sample is converted into a persistent dentry/offset pair
  * for later lookup from userspace.
  */
-static void add_sample(struct mm_struct * mm, struct op_sample * s)
+static void add_sample(struct mm_struct * mm, struct op_sample * s, int in_kernel)
 {
-	if (is_kernel(s->eip)) {
+	if (in_kernel) {
 		add_sample_entry(s->eip, s->event);
 	} else if (mm) {
 		add_us_sample(mm, s);
@@ -319,26 +321,34 @@
 	struct mm_struct * mm = 0;
 	struct task_struct * new;
 	unsigned long cookie;
+	int in_kernel = 1;
 	int i;
  
 	for (i=0; i < cpu_buf->pos; ++i) {
 		struct op_sample * s = &cpu_buf->buffer[i];
  
 		if (is_ctx_switch(s->eip)) {
-			new = (struct task_struct *)s->event;
- 
-			release_mm(mm);
-			mm = take_task_mm(new);
- 
-			cookie = get_exec_dcookie(mm);
-			add_ctx_switch(new->pid, cookie);
+			if (s->event <= 1) {
+				/* kernel/userspace switch */
+				in_kernel = s->event;
+				add_kernel_ctx_switch(s->event);
+			} else {
+				/* userspace context switch */
+				new = (struct task_struct *)s->event;
+
+				release_mm(mm);
+				mm = take_task_mm(new);
+
+				cookie = get_exec_dcookie(mm);
+				add_user_ctx_switch(new->pid, cookie);
+			}
 		} else {
-			add_sample(mm, s);
+			add_sample(mm, s, in_kernel);
 		}
 	}
 	release_mm(mm);
 
-	cpu_buf->pos = 0;
+	cpu_buffer_reset(cpu_buf);
 }
  
  
@@ -364,10 +374,12 @@
 		 * lockers only, and this region is already
 		 * protected by buffer_sem. It's raw to prevent
 		 * the preempt bogometer firing. Fruity, huh ? */
-		_raw_spin_lock(&cpu_buf->int_lock);
-		add_cpu_switch(i);
-		sync_buffer(cpu_buf);
-		_raw_spin_unlock(&cpu_buf->int_lock);
+		if (cpu_buf->pos > 0) {
+			_raw_spin_lock(&cpu_buf->int_lock);
+			add_cpu_switch(i);
+			sync_buffer(cpu_buf);
+			_raw_spin_unlock(&cpu_buf->int_lock);
+		}
 	}
 
 	up(&buffer_sem);
@@ -393,3 +405,4 @@
 	schedule_work(&sync_wq);
 	/* timer is re-added by the scheduled task */
 }
+
diff -Naur -X dontdiff linux/drivers/oprofile/cpu_buffer.c linux2/drivers/oprofile/cpu_buffer.c
--- linux/drivers/oprofile/cpu_buffer.c	2002-12-17 16:59:03.000000000 +0000
+++ linux2/drivers/oprofile/cpu_buffer.c	2003-01-23 20:24:53.000000000 +0000
@@ -62,6 +62,7 @@
 		spin_lock_init(&b->int_lock);
 		b->pos = 0;
 		b->last_task = 0;
+		b->last_is_kernel = -1;
 		b->sample_received = 0;
 		b->sample_lost_locked = 0;
 		b->sample_lost_overflow = 0;
@@ -84,12 +85,20 @@
  * be safe from any context. Instead we trylock the CPU's int_lock.
  * int_lock is taken by the processing code in sync_cpu_buffers()
  * so we avoid disturbing that.
+ *
+ * is_kernel is needed because on some architectures you cannot
+ * tell if you are in kernel or user space simply by looking at
+ * eip. We tag this in the buffer by generating kernel enter/exit
+ * events whenever is_kernel changes
  */
-void oprofile_add_sample(unsigned long eip, unsigned long event, int cpu)
+void oprofile_add_sample(unsigned long eip, unsigned int is_kernel, 
+	unsigned long event, int cpu)
 {
 	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[cpu];
 	struct task_struct * task;
 
+	is_kernel = !!is_kernel;
+
 	cpu_buf->sample_received++;
  
 	if (!spin_trylock(&cpu_buf->int_lock)) {
@@ -101,9 +110,17 @@
 		cpu_buf->sample_lost_overflow++;
 		goto out;
 	}
- 
+
 	task = current;
 
+	/* notice a switch from user->kernel or vice versa */
+	if (cpu_buf->last_is_kernel != is_kernel) {
+		cpu_buf->last_is_kernel = is_kernel;
+		cpu_buf->buffer[cpu_buf->pos].eip = ~0UL;
+		cpu_buf->buffer[cpu_buf->pos].event = is_kernel;
+		cpu_buf->pos++;
+	}
+
 	/* notice a task switch */
 	if (cpu_buf->last_task != task) {
 		cpu_buf->last_task = task;
@@ -130,3 +147,19 @@
 out:
 	spin_unlock(&cpu_buf->int_lock);
 }
+
+/* resets the cpu buffer to a sane state - should be called with 
+ * cpu_buf->int_lock held
+ */
+void cpu_buffer_reset(struct oprofile_cpu_buffer *cpu_buf)
+{
+	cpu_buf->pos = 0;
+
+	/* reset these to invalid values; the next sample
+	 * collected will populate the buffer with proper
+	 * values to initialize the buffer
+	 */
+	cpu_buf->last_is_kernel = -1;
+	cpu_buf->last_task = 0;
+}
+
diff -Naur -X dontdiff linux/drivers/oprofile/cpu_buffer.h linux2/drivers/oprofile/cpu_buffer.h
--- linux/drivers/oprofile/cpu_buffer.h	2002-12-16 03:53:07.000000000 +0000
+++ linux2/drivers/oprofile/cpu_buffer.h	2003-01-23 20:24:53.000000000 +0000
@@ -20,7 +20,7 @@
 int alloc_cpu_buffers(void);
 
 void free_cpu_buffers(void);
- 
+
 /* CPU buffer is composed of such entries (which are
  * also used for context switch notes)
  */
@@ -34,6 +34,7 @@
 	/* protected by int_lock */
 	unsigned long pos;
 	struct task_struct * last_task;
+	int last_is_kernel;
 	struct op_sample * buffer;
 	unsigned long sample_received;
 	unsigned long sample_lost_locked;
@@ -43,4 +44,6 @@
 
 extern struct oprofile_cpu_buffer cpu_buffer[];
 
+void cpu_buffer_reset(struct oprofile_cpu_buffer *cpu_buf);
+
 #endif /* OPROFILE_CPU_BUFFER_H */
diff -Naur -X dontdiff linux/drivers/oprofile/event_buffer.h linux2/drivers/oprofile/event_buffer.h
--- linux/drivers/oprofile/event_buffer.h	2002-12-16 03:53:07.000000000 +0000
+++ linux2/drivers/oprofile/event_buffer.h	2003-01-23 20:24:53.000000000 +0000
@@ -25,9 +25,11 @@
  * relevant data.
  */
 #define ESCAPE_CODE		~0UL
-#define CTX_SWITCH_CODE 	1
-#define CPU_SWITCH_CODE 	2
-#define COOKIE_SWITCH_CODE 	3
+#define CTX_SWITCH_CODE 		1
+#define CPU_SWITCH_CODE 		2
+#define COOKIE_SWITCH_CODE 		3
+#define KERNEL_ENTER_SWITCH_CODE	4
+#define KERNEL_EXIT_SWITCH_CODE		5
  
 /* add data to the event buffer */
 void add_event_entry(unsigned long data);
diff -Naur -X dontdiff linux/include/linux/oprofile.h linux2/include/linux/oprofile.h
--- linux/include/linux/oprofile.h	2003-02-10 19:40:25.000000000 +0000
+++ linux2/include/linux/oprofile.h	2003-01-23 20:24:53.000000000 +0000
@@ -49,7 +49,8 @@
  * Add a sample. This may be called from any context. Pass
  * smp_processor_id() as cpu.
  */
-extern void oprofile_add_sample(unsigned long eip, unsigned long event, int cpu);
+extern void oprofile_add_sample(unsigned long eip, unsigned int is_kernel, 
+	unsigned long event, int cpu);
 
 /**
  * Create a file of the given name as a child of the given root, with
