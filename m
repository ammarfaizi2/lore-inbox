Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265809AbTCCPpo>; Mon, 3 Mar 2003 10:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTCCPpo>; Mon, 3 Mar 2003 10:45:44 -0500
Received: from [195.71.209.2] ([195.71.209.2]:31492 "HELO ns2.ontika.net")
	by vger.kernel.org with SMTP id <S265809AbTCCPpi>;
	Mon, 3 Mar 2003 10:45:38 -0500
Message-ID: <3E637AF5.2070506@ontika.net>
Date: Mon, 03 Mar 2003 16:55:33 +0100
From: Kai Bankett <chaosman@ontika.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IRQ APIC balance improvements (PATCH) need test-feedback
Content-Type: multipart/mixed;
 boundary="------------030101020601050505060204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030101020601050505060204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Maybe there is someone out there to do some benchmarking / testing /
commenting on the changes ?

The following patch adjusts the irq balancing a bit.
1) At least on my 2-CPU smp machine IRQs have been bouncing between CPUs.
This seems to happen because the imbalance-value between the CPUs was
noticed to be high enough for an IRQ-switch to a different CPU. After
switch-over the scenario not really improved -> switch back again.
Maybe the modification helps improving this a bit by implementing a
"look ahead" if moving the IRQ really makes sense.
2) As far as I understand, putting all interrupts on one CPU should be
preferred in case of low interrupt load. (cpu cache etc.)
This patch also adds a fallback-behavior if  the load of interrupts
drops again.
Currently I decided to add a processor variable to irq_desc structure.
I´m not sure if  this is the right way to go but I needed the
information on which CPU an IRQ is currently on. (to decide whether an
IRQ has to be switched back to the "primary CPU")
3) Now '/proc/interrupts' also shows the CPU-no the interrupt currently 
is routed to. (Not sure if this breaks some tools ?!?)

--------------030101020601050505060204
Content-Type: text/plain;
 name="diffstat.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diffstat.txt"

 arch/i386/kernel/io_apic.c |  111 ++++++++++++++++++++++++++++++---------------
 arch/i386/kernel/irq.c     |   11 ++++
 include/linux/irq.h        |    3 +
 3 files changed, 89 insertions(+), 36 deletions(-)




--------------030101020601050505060204
Content-Type: text/plain;
 name="balance_irq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="balance_irq.patch"

diff -r -u linux-2.5.63/arch/i386/kernel/io_apic.c linux-2.5.63.new/arch/i386/kernel/io_apic.c
--- linux-2.5.63/arch/i386/kernel/io_apic.c	2003-03-03 11:36:41.000000000 +0100
+++ linux-2.5.63.new/arch/i386/kernel/io_apic.c	2003-03-03 12:00:29.000000000 +0100
@@ -18,6 +18,8 @@
  *					and Rolf G. Tews
  *					for testing these extensively
  *	Paul Diefenbaugh	:	Added full ACPI support
+ *	Kai Bankett		:	Improved interrupt distribution
+ *					and stickiness
  */
 
 #include <linux/mm.h>
@@ -226,15 +228,23 @@
 static int irqbalance_disabled = NO_BALANCE_IRQ;
 static int physical_balance = 0;
 
-struct irq_cpu_info {
+static struct irq_cpu_info {
 	unsigned long * last_irq;
 	unsigned long * irq_delta;
 	unsigned long irq;
 } irq_cpu_data[NR_CPUS];
 
+static struct irq_cpu_sum {
+	unsigned long total;
+} irq_cpu_total[NR_CPUS];
+
+/* fall back to this CPU-no for all interrupts */
+#define IRQ_PRIMARY_CPU 0
+
 #define CPU_IRQ(cpu)		(irq_cpu_data[cpu].irq)
 #define LAST_CPU_IRQ(cpu,irq)   (irq_cpu_data[cpu].last_irq[irq])
 #define IRQ_DELTA(cpu,irq) 	(irq_cpu_data[cpu].irq_delta[irq])
+#define CPU_IRQ_TOTAL(cpu)	(irq_cpu_total[cpu].total)
 
 #define IDLE_ENOUGH(cpu,now) \
 		(idle_cpu(cpu) && ((now) - irq_stat[(cpu)].idle_timestamp > 1))
@@ -252,7 +262,7 @@
 
 long balanced_irq_interval = MAX_BALANCED_IRQ_INTERVAL;
 					 
-static inline void balance_irq(int cpu, int irq);
+static inline void balance_irq(int cpu, int irq, int on_primary);
 
 static inline void rotate_irqs_among_cpus(unsigned long useful_load_threshold)
 {
@@ -265,7 +275,8 @@
 			/* Is it a significant load ?  */
 			if (IRQ_DELTA(CPU_TO_PACKAGEINDEX(i),j) < useful_load_threshold)
 				continue;
-			balance_irq(i, j);
+			/* balance (no primary force) */
+			balance_irq(i, j, 0);
 		}
 	}
 	balanced_irq_interval = max((long)MIN_BALANCED_IRQ_INTERVAL,
@@ -293,6 +304,7 @@
 		if (!cpu_online(i))
 			continue;
 		package_index = CPU_TO_PACKAGEINDEX(i);
+		CPU_IRQ_TOTAL(package_index) = 0;
 		for (j = 0; j < NR_IRQS; j++) {
 			unsigned long value_now, delta;
 			/* Is this an active IRQ? */
@@ -306,6 +318,18 @@
 			/* Determine the activity per processor per IRQ */
 			delta = value_now - LAST_CPU_IRQ(i,j);
 
+			/* Switch back to primary cpu if not loaded */
+			if ((i == irq_desc[j].processor) &&
+			    (delta < useful_load_threshold) &&
+			    (irq_desc[j].processor != IRQ_PRIMARY_CPU)) {
+				/* move back irq */
+				balance_irq(irq_desc[j].processor,j,1);
+				continue;
+			}
+
+			/* update irq total counter */
+			CPU_IRQ_TOTAL(package_index) += delta;
+
 			/* Update last_cpu_irq[][] for the next time */
 			LAST_CPU_IRQ(i,j) = value_now;
 
@@ -441,6 +465,7 @@
 		Dprintk("irq = %d moved to cpu = %d\n", selected_irq, min_loaded);
 		/* mark for change destination */
 		spin_lock(&desc->lock);
+		irq_desc[selected_irq].processor = min_loaded;
 		pending_irq_balance_apicid[selected_irq] = cpu_to_logical_apicid(min_loaded);
 		spin_unlock(&desc->lock);
 		/* Since we made a change, come back sooner to 
@@ -460,62 +485,76 @@
 	return;
 }
 
-static unsigned long move(int curr_cpu, unsigned long allowed_mask, unsigned long now, int direction)
-{
-	int search_idle = 1;
-	int cpu = curr_cpu;
-
-	goto inside;
-
-	do {
-		if (unlikely(cpu == curr_cpu))
-			search_idle = 0;
-inside:
-		if (direction == 1) {
-			cpu++;
-			if (cpu >= NR_CPUS)
-				cpu = 0;
-		} else {
-			cpu--;
-			if (cpu == -1)
-				cpu = NR_CPUS-1;
-		}
-	} while (!cpu_online(cpu) || !IRQ_ALLOWED(cpu,allowed_mask) ||
-			(search_idle && !IDLE_ENOUGH(cpu,now)));
-
-	return cpu;
-}
-
-static inline void balance_irq (int cpu, int irq)
+static inline void balance_irq (int cpu, int irq, int on_primary)
 {
 	unsigned long now = jiffies;
 	unsigned long allowed_mask;
-	unsigned int new_cpu;
+	unsigned long tmp_cur_irq;
+	unsigned int i, new_cpu;
 		
 	if (irqbalance_disabled)
 		return;
 
 	allowed_mask = cpu_online_map & irq_affinity[irq];
-	new_cpu = move(cpu, allowed_mask, now, 1);
+
+	if (on_primary == 1) {
+		new_cpu = IRQ_PRIMARY_CPU;
+		goto do_work;
+	}
+
+	/* Does ist make sense to balance ? */
+	new_cpu = IRQ_PRIMARY_CPU;
+	tmp_cur_irq = ULONG_MAX;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i) || !IRQ_ALLOWED(i,allowed_mask))
+			continue;
+		if (CPU_IRQ_TOTAL(CPU_TO_PACKAGEINDEX(i)) < tmp_cur_irq) {
+			tmp_cur_irq = CPU_IRQ_TOTAL(CPU_TO_PACKAGEINDEX(i));
+			new_cpu = i;
+		}
+	}
+	if (CPU_IRQ_TOTAL(CPU_TO_PACKAGEINDEX(new_cpu)) + IRQ_DELTA(CPU_TO_PACKAGEINDEX(cpu),irq)
+			>= CPU_IRQ_TOTAL(CPU_TO_PACKAGEINDEX(cpu))) {
+		Dprintk("balanced_irq: Balance makes no sense\n");
+		return;
+	}
+
+do_work:
 	if (cpu != new_cpu) {
 		irq_desc_t *desc = irq_desc + irq;
 		spin_lock(&desc->lock);
+		irq_desc[irq].processor = new_cpu;
 		pending_irq_balance_apicid[irq] = cpu_to_logical_apicid(new_cpu);
 		spin_unlock(&desc->lock);
-	}
+	} else
+		Dprintk("balance_irq: irq-switch senseless (cpu == new_cpu)\n");
 }
 
 int balanced_irq(void *unused)
 {
 	int i;
+	int cpu_count = 0;
 	unsigned long prev_balance_time = jiffies;
 	long time_remaining = balanced_irq_interval;
 
+	/* push everything to CPU(IRQ_PRIMRAY_CPU)
+	   to give us a starting point. */
+	for (i = 0; i < NR_IRQS; i++) {
+		pending_irq_balance_apicid[i] = cpu_to_logical_apicid(IRQ_PRIMARY_CPU);
+		irq_desc[i].processor = 0;
+	}
+
+	/* if running only with one cpu - balance_irq does not make sense */
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i))
+			cpu_count++;
+	}
+	if (cpu_count < 2)
+		return 0;
+
 	daemonize("kirqd");
 	
-	/* push everything to CPU 0 to give us a starting point.  */
-	for (i = 0 ; i < NR_IRQS ; i++)
-		pending_irq_balance_apicid[i] = cpu_to_logical_apicid(0);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		time_remaining = schedule_timeout(time_remaining);
diff -r -u linux-2.5.63/arch/i386/kernel/irq.c linux-2.5.63.new/arch/i386/kernel/irq.c
--- linux-2.5.63/arch/i386/kernel/irq.c	2003-03-03 11:36:41.000000000 +0100
+++ linux-2.5.63.new/arch/i386/kernel/irq.c	2003-03-03 13:25:16.000000000 +0100
@@ -65,8 +65,13 @@
 /*
  * Controller mappings for all interrupt sources:
  */
+#if defined(CONFIG_X86_IO_APIC)
+irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
+	{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, 0, SPIN_LOCK_UNLOCKED}};
+#else
 irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
 	{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}};
+#endif
 
 static void register_irq_proc (unsigned int irq);
 
@@ -140,6 +145,9 @@
 	for (j=0; j<NR_CPUS; j++)
 		if (cpu_online(j))
 			p += seq_printf(p, "CPU%d       ",j);
+#if CONFIG_X86_IO_APIC
+	p += seq_printf(p, "ON_CPU");
+#endif
 	seq_putc(p, '\n');
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
@@ -155,6 +163,9 @@
 				p += seq_printf(p, "%10u ",
 					     kstat_cpu(j).irqs[i]);
 #endif
+#if CONFIG_X86_IO_APIC
+		seq_printf(p, " %11i", irq_desc[i].processor);
+#endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
 
diff -r -u linux-2.5.63/include/linux/irq.h linux-2.5.63.new/include/linux/irq.h
--- linux-2.5.63/include/linux/irq.h	2003-02-24 20:05:29.000000000 +0100
+++ linux-2.5.63.new/include/linux/irq.h	2003-03-03 12:37:06.000000000 +0100
@@ -61,6 +61,9 @@
 	hw_irq_controller *handler;
 	struct irqaction *action;	/* IRQ action list */
 	unsigned int depth;		/* nested irq disables */
+#if defined(CONFIG_X86_IO_APIC)
+	unsigned int processor;
+#endif
 	spinlock_t lock;
 } ____cacheline_aligned irq_desc_t;
 




--------------030101020601050505060204--

