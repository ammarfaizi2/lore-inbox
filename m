Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbUJ0VDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbUJ0VDQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbUJ0Uzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:55:46 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:16393 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262570AbUJ0UuN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:50:13 -0400
Date: Wed, 27 Oct 2004 13:49:35 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041027204935.GA24732@nietzsche.lynx.com>
References: <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com> <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com> <20041027132926.GA7171@elte.hu> <417FB7F0.4070300@cybsft.com> <20041027150548.GA11233@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20041027150548.GA11233@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 27, 2004 at 05:05:48PM +0200, Ingo Molnar wrote:
> 
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> > I use the rtc-debug and amlat to generate histograms of latencies
> > which is what I was trying to do when I found the rtc problem the
> > first time.  I believe that rtc-debug/amlat is much more accurate for
> > generating histograms of latencies than realfeel is because the
> > instrumentation is in the kernel rather than a userspace program.
> 
> ah, ok - nice. So rtc-debug+amlat is the only known-reliable way to
> produce latency histograms?
> 
> Btw., rtc-debug's latency results could now be cross-validated with
> -V0.4's wakeup tracer (and vice versa), because the two are totally
> independent mechanisms.

I've got a latency/histogram patch here, but I've been having problems
trying to integrate it into Ingo's irq-threads and getting that simple
subtraction returning something sensible. The basic logic works otherwise.

Maybe another pair of eyes can figure this out, since I could have missed
something pretty simple...

bill


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="s.diff"

diff -rwu linux.voluntary.virgin/arch/i386/Kconfig linux.voluntary/arch/i386/Kconfig
--- linux.voluntary.virgin/arch/i386/Kconfig	2004-10-21 21:52:33.000000000 -0700
+++ linux.voluntary/arch/i386/Kconfig	2004-10-21 22:35:53.000000000 -0700
@@ -586,6 +586,17 @@
 	  system.
 	  Say N if you are unsure.
 
+config NOTE_LATENCY
+	bool "Note irq-thread wake latency"
+	depends on PREEMPT_HARDIRQS && HPET
+	default n
+	help
+	  This options timestamp marks exception frame wake events to the
+	  irq-thread in question and shoves it into a statistically scalable
+	  histogram. Timestamp events can be "zoomed" in that are of interest
+	  with compile time changes to the struct describing the ranges of
+	  band(s) being saved.
+
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !SMP
 	depends on !(X86_VISWS || X86_VOYAGER)
diff -rwu linux.voluntary.virgin/arch/i386/kernel/irq.c linux.voluntary/arch/i386/kernel/irq.c
--- linux.voluntary.virgin/arch/i386/kernel/irq.c	2004-10-21 21:52:33.000000000 -0700
+++ linux.voluntary/arch/i386/kernel/irq.c	2004-10-21 22:36:10.000000000 -0700
@@ -54,6 +54,7 @@
 	u32 *isp;
 #endif
 
+
 	irq_enter();
 	__trace((unsigned long)do_IRQ, regs.eip);
 	__trace((unsigned long)do_IRQ, irq);
@@ -101,6 +102,12 @@
 		);
 	} else
 #endif
+
+#ifdef CONFIG_NOTE_LATENCY
+//	irq_desc_t *desc = irq_desc + irq;
+	irq_desc[irq].timestamp = get_cycles();
+#endif
+
 		__do_IRQ(irq, &regs);
 
 	irq_exit();
diff -rwu linux.voluntary.virgin/arch/i386/kernel/kgdb_stub.c linux.voluntary/arch/i386/kernel/kgdb_stub.c
--- linux.voluntary.virgin/arch/i386/kernel/kgdb_stub.c	2004-10-21 21:52:18.000000000 -0700
+++ linux.voluntary/arch/i386/kernel/kgdb_stub.c	2004-10-21 22:36:17.000000000 -0700
@@ -365,8 +365,8 @@
 
 #ifdef CONFIG_SMP
 static int in_kgdb_called;
-static spinlock_t waitlocks[MAX_NO_CPUS] =
-    {[0 ... MAX_NO_CPUS - 1] = SPIN_LOCK_UNLOCKED };
+static raw_spinlock_t waitlocks[MAX_NO_CPUS] =
+    {[0 ... MAX_NO_CPUS - 1] = RAW_SPIN_LOCK_UNLOCKED };
 /*
  * The following array has the thread pointer of each of the "other"
  * cpus.  We make it global so it can be seen by gdb.
@@ -374,9 +374,9 @@
 volatile int in_kgdb_entry_log[MAX_NO_CPUS];
 volatile struct pt_regs *in_kgdb_here_log[MAX_NO_CPUS];
 /*
-static spinlock_t continuelocks[MAX_NO_CPUS];
+static raw_spinlock_t continuelocks[MAX_NO_CPUS];
 */
-spinlock_t kgdb_spinlock = SPIN_LOCK_UNLOCKED;
+raw_spinlock_t kgdb_spinlock = RAW_SPIN_LOCK_UNLOCKED;
 /* waiters on our spinlock plus us */
 static atomic_t spinlock_waiters = ATOMIC_INIT(1);
 static int spinlock_count = 0;
@@ -2404,7 +2404,7 @@
 void
 kgdb_tstamp(int line, char *source, int data0, int data1)
 {
-	static spinlock_t ts_spin = SPIN_LOCK_UNLOCKED;
+	static raw_spinlock_t ts_spin = RAW_SPIN_LOCK_UNLOCKED;
 	int flags;
 	kgdb_local_irq_save(flags);
 	spin_lock(&ts_spin);
diff -rwu linux.voluntary.virgin/arch/i386/kernel/timers/timer_hpet.c linux.voluntary/arch/i386/kernel/timers/timer_hpet.c
--- linux.voluntary.virgin/arch/i386/kernel/timers/timer_hpet.c	2004-10-21 21:52:33.000000000 -0700
+++ linux.voluntary/arch/i386/kernel/timers/timer_hpet.c	2004-10-26 14:11:31.000000000 -0700
@@ -49,7 +49,8 @@
 	cyc2ns_scale = (1000 << CYC2NS_SCALE_FACTOR)/cpu_mhz;
 }
 
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
+//static inline
+unsigned long long cycles_2_ns(unsigned long long cyc)
 {
 	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
 }
diff -rwu linux.voluntary.virgin/arch/i386/kernel/traps.c linux.voluntary/arch/i386/kernel/traps.c
--- linux.voluntary.virgin/arch/i386/kernel/traps.c	2004-10-21 21:52:33.000000000 -0700
+++ linux.voluntary/arch/i386/kernel/traps.c	2004-10-21 22:36:25.000000000 -0700
@@ -117,6 +117,7 @@
 	unsigned long addr, prev_frame;
 
 #ifdef CONFIG_KGDB
+#error
 extern void sysenter_past_esp(void);
 #include <asm/kgdb.h>
 #include <linux/init.h>
@@ -785,8 +786,9 @@
 		 * that really belongs to user space.  Others are
 		 * "Ours all ours!"
 		 */
-		if (((regs->xcs & 3) == 0) && ((void *)regs->eip == sysenter_past_esp))
+/*		if (((regs->xcs & 3) == 0) && ((void *)regs->eip == sysenter_past_esp))
 			goto clear_TF_reenable;
+		--billh	*/ 
 #else
 		if ((regs->xcs & 3) == 0)
 			goto clear_TF_reenable;
diff -rwu linux.voluntary.virgin/arch/i386/lib/kgdb_serial.c linux.voluntary/arch/i386/lib/kgdb_serial.c
--- linux.voluntary.virgin/arch/i386/lib/kgdb_serial.c	2004-10-21 21:52:18.000000000 -0700
+++ linux.voluntary/arch/i386/lib/kgdb_serial.c	2004-10-21 22:36:33.000000000 -0700
@@ -104,9 +104,9 @@
  * but we will just depend on the uart status to help keep that straight.
 
  */
-static spinlock_t uart_interrupt_lock = SPIN_LOCK_UNLOCKED;
+static raw_spinlock_t uart_interrupt_lock = RAW_SPIN_LOCK_UNLOCKED;
 #ifdef CONFIG_SMP
-extern spinlock_t kgdb_spinlock;
+extern raw_spinlock_t kgdb_spinlock;
 #endif
 
 static int
@@ -343,7 +343,7 @@
  */
 int kgdb_in_isr = 0;
 int kgdb_in_lsr = 0;
-extern spinlock_t kgdb_spinlock;
+extern raw_spinlock_t kgdb_spinlock;
 
 /* Caller takes needed protections */
 
@@ -381,7 +381,7 @@
 }				/* tty_getDebugChar */
 
 static int count = 3;
-static spinlock_t one_at_atime = SPIN_LOCK_UNLOCKED;
+static raw_spinlock_t one_at_atime = RAW_SPIN_LOCK_UNLOCKED;
 
 static int __init
 kgdb_enable_ints(void)
diff -rwu linux.voluntary.virgin/include/asm-i386/timex.h linux.voluntary/include/asm-i386/timex.h
--- linux.voluntary.virgin/include/asm-i386/timex.h	2004-10-21 21:52:22.000000000 -0700
+++ linux.voluntary/include/asm-i386/timex.h	2004-10-26 16:26:32.000000000 -0700
@@ -7,6 +7,7 @@
 #define _ASMi386_TIMEX_H
 
 #include <linux/config.h>
+#include <asm/types.h>
 #include <asm/processor.h>
 
 #ifdef CONFIG_X86_ELAN
@@ -30,7 +31,7 @@
  * four billion cycles just basically sounds like a good idea,
  * regardless of how fast the machine is. 
  */
-typedef unsigned long long cycles_t;
+typedef u64 cycles_t;
 
 extern cycles_t cacheflush_time;
 
@@ -49,6 +50,21 @@
 	return ret;
 }
 
+static inline cycles_t get_cycles64 (void)
+{
+	union u64_a {
+		u64 intlong;
+		struct u32x2_a {
+			uint32_t eax;
+			uint32_t edx;
+		} uintint;
+	} ulonglong;
+		
+	rdtsc(ulonglong.uintint.eax, ulonglong.uintint.edx);
+	return ulonglong.intlong;
+}
+
+
 extern unsigned long cpu_khz;
 
 #endif
diff -rwu linux.voluntary.virgin/include/linux/irq.h linux.voluntary/include/linux/irq.h
--- linux.voluntary.virgin/include/linux/irq.h	2004-10-21 21:52:33.000000000 -0700
+++ linux.voluntary/include/linux/irq.h	2004-10-21 22:36:54.000000000 -0700
@@ -76,6 +76,9 @@
 	unsigned int irq_count;		/* For detecting broken interrupts */
 	unsigned int irqs_unhandled;
 	struct task_struct *thread;
+#ifdef CONFIG_NOTE_LATENCY
+	u32 timestamp;
+#endif
 	wait_queue_head_t wait_for_handler;
 	raw_spinlock_t lock;
 } ____cacheline_aligned irq_desc_t;
diff -rwu linux.voluntary.virgin/kernel/irq/handle.c linux.voluntary/kernel/irq/handle.c
--- linux.voluntary.virgin/kernel/irq/handle.c	2004-10-21 21:52:33.000000000 -0700
+++ linux.voluntary/kernel/irq/handle.c	2004-10-27 02:50:40.000000000 -0700
@@ -139,6 +139,10 @@
 	struct irqaction * action;
 	unsigned int status;
 
+#ifdef CONFIG_NOTE_LATENCY
+//#error
+	desc->timestamp = get_cycles64();
+#endif
 	kstat_this_cpu.irqs[irq]++;
 	if (desc->status & IRQ_PER_CPU) {
 		irqreturn_t action_ret;
diff -rwu linux.voluntary.virgin/kernel/irq/manage.c linux.voluntary/kernel/irq/manage.c
--- linux.voluntary.virgin/kernel/irq/manage.c	2004-10-21 21:52:33.000000000 -0700
+++ linux.voluntary/kernel/irq/manage.c	2004-10-27 02:51:37.000000000 -0700
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/interrupt.h>
+#include <asm/timex.h>
 
 #include "internals.h"
 
@@ -448,6 +449,10 @@
 	local_irq_enable();
 }
 
+#ifdef CONFIG_NOTE_LATENCY
+extern void note_latency_event(cycles_t start_event_time);
+#endif
+
 extern asmlinkage void __do_softirq(void);
 
 static int do_irqd(void * __desc)
@@ -468,6 +473,10 @@
 
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
+#ifdef CONFIG_NOTE_LATENCY
+//#error
+		note_latency_event(desc->timestamp);
+#endif
 		do_hardirq(desc);
 		cond_resched_all();
 		__do_softirq();
diff -rwu linux.voluntary.virgin/kernel/irq/proc.c linux.voluntary/kernel/irq/proc.c
--- linux.voluntary.virgin/kernel/irq/proc.c	2004-10-21 21:52:33.000000000 -0700
+++ linux.voluntary/kernel/irq/proc.c	2004-10-27 02:54:32.000000000 -0700
@@ -196,6 +196,10 @@
 #undef MAX_NAMELEN
 
 
+#ifdef CONFIG_NOTE_LATENCY
+static int note_latency_proc_init(void);
+#endif
+
 void init_irq_proc(void)
 {
 	int i;
@@ -210,5 +214,198 @@
 	 */
 	for (i = 0; i < NR_IRQS; i++)
 		register_irq_proc(i);
+
+#ifdef CONFIG_NOTE_LATENCY
+	note_latency_proc_init();
+#endif
+}
+
+
+#include <linux/seq_file.h>
+#include <linux/module.h>
+#include <asm/delay.h>
+#include <asm/timex.h>
+#include <asm/div64.h>
+
+/*
+ * Tue Oct 19 15:54:33 PDT 2004
+ * Silly code that prints out the irq-thread latencies.
+ * --billh
+ */
+
+extern
+unsigned long long cycles_2_ns(unsigned long long cyc);
+
+#define NOTE_LATENCY_HISTO_SIZE 3
+
+typedef struct {
+	u64 usec_granularity;
+	u64 n_entries;
+
+	u64 usec_lower_bounds;
+	u64 usec_upper_bounds;
+	unsigned int *vec;
+} note_latency_vec_t;
+
+note_latency_vec_t
+	note_latency_histo_vec[NOTE_LATENCY_HISTO_SIZE] =
+		{ {1,  100,  0, 0, NULL},
+		  {10, 100,  0, 0, NULL},
+		  {50, 1000, 0, 0, NULL} };
+
+unsigned int note_latency_n_events = 0;
+
+void note_latency_init(void) {
+	int i;
+	u64 frame_base = 0;
+
+	for (i = 0; i < NOTE_LATENCY_HISTO_SIZE; ++i) {
+		note_latency_vec_t *t = &note_latency_histo_vec[i];
+
+		t->vec = (unsigned int *) kmalloc(sizeof(unsigned int) * t->n_entries,  GFP_KERNEL);
+		memset(t->vec, 0, sizeof(unsigned int) * t->n_entries); /* hack */
+
+		t->usec_lower_bounds = frame_base;
+		t->usec_upper_bounds = frame_base += t->usec_granularity * t->n_entries;
+	}
+
+	printk("cpu_khz = %d", cpu_khz);
+}
+
+void note_latency_destruct(void) {
+	unsigned int i;
+
+	for (i = 0; i < NOTE_LATENCY_HISTO_SIZE; ++i) {
+		note_latency_vec_t *t = &note_latency_histo_vec[i];
+		kfree((void *) t->vec);
+		t->vec = NULL;
+	}
+}
+
+extern unsigned long notrace cycles_to_usecs(cycles_t delta);
+
+void note_latency_event(cycles_t start_event_time) {
+	unsigned int i, index;
+	note_latency_vec_t *t;
+	cycles_t event_time, s, ss;
+	u32 remainder;
+
+	t = &note_latency_histo_vec[NOTE_LATENCY_HISTO_SIZE -1];
+
+	++note_latency_n_events;
+
+/*
+	ss = get_cycles64();
+	udelay(45);
+	s = get_cycles64();
+	s -= ss;
+*/
+	s = get_cycles64() - start_event_time;
+	remainder = do_div(s, cpu_khz / 1000 +1);
+	event_time = s;
+/*
+*/
+
+//	event_time = cycles_2_ns(get_cycles64() - start_event_time); // more accurate 
+//	event_time = cycles_to_usecs(get_cycles64() - start_event_time);
+
+
+	for (i = 0; i < NOTE_LATENCY_HISTO_SIZE; ++i) {
+		note_latency_vec_t *t2 = &note_latency_histo_vec[i];
+
+		if ((t2->usec_lower_bounds <= event_time) && (event_time < t2->usec_upper_bounds)) {
+			event_time -= t2->usec_lower_bounds;
+			remainder = do_div(event_time, t2->usec_granularity);
+			index = event_time;
+			t2->vec[index] += 1;
+			goto out;
+		}
+
+	}
+
+#if 0
+//	note_latency_histo_vec[1].vec[4] += 1; /* single spike */
+
+	/* over extended values add at the end */
+	if (event_time > 100000)
+		t->vec[t->n_entries - 2] += 1;
+#endif
+	if (event_time < 0)
+		t->vec[t->n_entries - 3] += 1;
+	t->vec[t->n_entries - 1] += 1;
+out:
+
+}
+
+void note_latency_dump_histogram(struct seq_file *s) {
+	int i, j;
+	unsigned int frame_base_time = 0;
+
+	for (i = 0; i < NOTE_LATENCY_HISTO_SIZE; ++i) {
+		note_latency_vec_t *t = &note_latency_histo_vec[i];
+		unsigned int peak;
+
+		seq_printf(s, "<%lld>\n", t->usec_lower_bounds);
+
+		for (j = 0; j < t->n_entries; ++j) {
+			if ( (peak = t->vec[j]) )
+				seq_printf(s, "%lld: %d\n",
+					frame_base_time + (j * t->usec_granularity),
+					peak);
+		}
+
+		seq_printf(s, "<%lld>\n", t->usec_upper_bounds);
+//		seq_printf(s, " ----- \n");
+
+		frame_base_time += t->usec_upper_bounds;
+	}
+	seq_printf(s, "N events = %d\n", note_latency_n_events);
+	seq_printf(s, "end\n");
+}
+
+static
+int note_latency_seq_show(struct seq_file *s, void *v)
+{
+	seq_printf(s, "BEGIN IRQ-task latency histogram (10usec bins)\n");
+	note_latency_dump_histogram(s);
+	seq_printf(s, "END\n");
+
+	return 0;
+}
+
+static
+int note_latency_seq_open(struct inode *inode, struct file *file)
+{
+	single_open(file, note_latency_seq_show, NULL);
+	return 0;
+}
+
+/* Virtual file system methods */
+static
+struct file_operations latency_file_ops = {
+        .owner   = THIS_MODULE,
+        .open    = note_latency_seq_open,
+        .read    = seq_read,
+        .llseek  = seq_lseek,
+        .release = single_release
+};
+
+#define PROC_PATH_ROOT_OBJECT "irq_latency_histogram"
+
+static
+int note_latency_proc_init(void) {
+        struct proc_dir_entry
+		*proc_root_object;
+
+        proc_root_object = create_proc_entry(PROC_PATH_ROOT_OBJECT, 0, NULL);
+        if (!proc_root_object) {
+                printk (KERN_ERR "cannot create /proc/" PROC_PATH_ROOT_OBJECT "\n");
+                return -ENOMEM;
+        }
+        proc_root_object->proc_fops = &latency_file_ops;
+
+	note_latency_init();
+
+	return 0;
 }
 
diff -rwu linux.voluntary.virgin/kernel/latency.c linux.voluntary/kernel/latency.c
--- linux.voluntary.virgin/kernel/latency.c	2004-10-21 21:52:33.000000000 -0700
+++ linux.voluntary/kernel/latency.c	2004-10-21 22:37:22.000000000 -0700
@@ -62,7 +62,8 @@
 
 static DEFINE_PER_CPU(struct cpu_trace, trace);
 
-static unsigned long notrace cycles_to_usecs(cycles_t delta)
+//static
+unsigned long notrace cycles_to_usecs(cycles_t delta)
 {
 #ifdef CONFIG_X86
 	do_div(delta, cpu_khz/1000+1);
diff -rwu linux.voluntary.virgin/lib/rwsem-generic.c linux.voluntary/lib/rwsem-generic.c
--- linux.voluntary.virgin/lib/rwsem-generic.c	2004-10-21 21:52:33.000000000 -0700
+++ linux.voluntary/lib/rwsem-generic.c	2004-10-21 22:37:27.000000000 -0700
@@ -179,7 +179,7 @@
 		 */
 		if (semblk == &kernel_sem.lock)
 			continue;
-		if (semblk && __rwsem_deadlock(semblk)) {
+		if (semblk && __rwsem_deadlock(semblk)) { /* recursive checking here */
 		  	rwsem_trace_on = 0;
 			printk("BUG: circular semaphore deadlock: %s/%d is "
 				"blocked on %p, deadlocking %s/%d\n",

--VbJkn9YxBvnuCH5J--
