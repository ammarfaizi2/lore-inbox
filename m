Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311038AbSCMTO6>; Wed, 13 Mar 2002 14:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311035AbSCMTOu>; Wed, 13 Mar 2002 14:14:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:65448 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S311029AbSCMTOc>;
	Wed, 13 Mar 2002 14:14:32 -0500
Date: Wed, 13 Mar 2002 20:10:11 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: "Maciej W. Rocycki" <macro@ds2.pg.gda.pl>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.LNX.4.33.0203131912140.1477-100000@biker.pdb.fsc.net>
Message-ID: <Pine.LNX.4.33.0203132006310.28859-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Mar 2002, Martin Wilck wrote:

> First of all, we see that virtually 100% of all IRQs are handled by
> CPU 0. I have seen this reported a number of times before. I guess it
> can become a severe performance problem in IRQ-intensive situations.

i've written a patch for this, it's enclosed in this email. It implements
a brownean motion of IRQs, based on load patterns. The concept works
really well on Foster CPUs - eg. it will redirect IRQs to idle CPUs - but
if all CPUs are idle then the IRQs are randomly and evenly distributed
between CPUs.

(the patch can be made cheaper, but i've kept the overhead per-IRQ for the
time being to have more flexibility.)

let me know whether this fixes your problem,

	Ingo

--- linux/kernel/sched.c.orig	Tue Feb  5 13:11:35 2002
+++ linux/kernel/sched.c	Tue Feb  5 13:12:48 2002
@@ -118,6 +118,11 @@
 #define can_schedule(p,cpu) \
 	((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))

+int idle_cpu(int cpu)
+{
+	return cpu_curr(cpu) == idle_task(cpu);
+}
+
 #else

 #define idle_task(cpu) (&init_task)
--- linux/include/linux/sched.h.orig	Tue Feb  5 13:13:09 2002
+++ linux/include/linux/sched.h	Tue Feb  5 13:14:00 2002
@@ -144,6 +144,7 @@

 extern void sched_init(void);
 extern void init_idle(void);
+extern int idle_cpu(int cpu);
 extern void show_state(void);
 extern void cpu_init (void);
 extern void trap_init(void);
--- linux/include/asm-i386/hardirq.h.orig	Tue Feb  5 13:10:39 2002
+++ linux/include/asm-i386/hardirq.h	Tue Feb  5 13:14:00 2002
@@ -12,6 +12,7 @@
 	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
+	unsigned long idle_timestamp;
 	unsigned int __nmi_count;	/* arch dependent */
 } ____cacheline_aligned irq_cpustat_t;

--- linux/arch/i386/kernel/io_apic.c.orig	Tue Feb  5 13:10:37 2002
+++ linux/arch/i386/kernel/io_apic.c	Tue Feb  5 13:15:23 2002
@@ -28,6 +28,7 @@
 #include <linux/config.h>
 #include <linux/smp_lock.h>
 #include <linux/mc146818rtc.h>
+#include <linux/compiler.h>

 #include <asm/io.h>
 #include <asm/smp.h>
@@ -163,6 +164,86 @@
 			clear_IO_APIC_pin(apic, pin);
 }

+static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
+{
+	unsigned long flags;
+
+	/*
+	 * Only the first 8 bits are valid.
+	 */
+	mask = mask << 24;
+	spin_lock_irqsave(&ioapic_lock, flags);
+	__DO_ACTION(1, = mask, )
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
+#if CONFIG_SMP
+
+typedef struct {
+	unsigned int cpu;
+	unsigned long timestamp;
+} ____cacheline_aligned irq_balance_t;
+
+static irq_balance_t irq_balance[NR_IRQS] __cacheline_aligned
+			= { [ 0 ... NR_IRQS-1 ] = { 1, 0 } };
+
+extern unsigned long irq_affinity [NR_IRQS];
+
+#endif
+
+#define IDLE_ENOUGH(cpu,now) \
+		(idle_cpu(cpu) && ((now) - irq_stat[(cpu)].idle_timestamp > 1))
+
+#define IRQ_ALLOWED(cpu,allowed_mask) \
+		((1 << cpu) & (allowed_mask))
+
+static unsigned long move(int curr_cpu, unsigned long allowed_mask, unsigned long now, int direction)
+{
+	int search_idle = 1;
+	int cpu = curr_cpu;
+
+	goto inside;
+
+	do {
+		if (unlikely(cpu == curr_cpu))
+			search_idle = 0;
+inside:
+		if (direction == 1) {
+			cpu++;
+			if (cpu >= smp_num_cpus)
+				cpu = 0;
+		} else {
+			cpu--;
+			if (cpu == -1)
+				cpu = smp_num_cpus-1;
+		}
+	} while (!IRQ_ALLOWED(cpu,allowed_mask) ||
+			(search_idle && !IDLE_ENOUGH(cpu,now)));
+
+	return cpu;
+}
+
+static inline void balance_irq(int irq)
+{
+#if CONFIG_SMP
+	irq_balance_t *entry = irq_balance + irq;
+	unsigned long now = jiffies;
+
+	if (unlikely(entry->timestamp != now)) {
+		unsigned long allowed_mask;
+		int random_number;
+
+		rdtscl(random_number);
+		random_number &= 1;
+
+		allowed_mask = cpu_online_map & irq_affinity[irq];
+		entry->timestamp = now;
+		entry->cpu = move(entry->cpu, allowed_mask, now, random_number);
+		set_ioapic_affinity(irq, 1 << entry->cpu);
+	}
+#endif
+}
+
 /*
  * support for broken MP BIOSs, enables hand-redirection of PIRQ0-7 to
  * specific CPU-side IRQs.
@@ -653,8 +734,7 @@
 }

 /*
- * Set up the 8259A-master output pin as broadcast to all
- * CPUs.
+ * Set up the 8259A-master output pin:
  */
 void __init setup_ExtINT_IRQ0_pin(unsigned int pin, int vector)
 {
@@ -1174,6 +1254,7 @@
  */
 static void ack_edge_ioapic_irq(unsigned int irq)
 {
+	balance_irq(irq);
 	if ((irq_desc[irq].status & (IRQ_PENDING | IRQ_DISABLED))
 					== (IRQ_PENDING | IRQ_DISABLED))
 		mask_IO_APIC_irq(irq);
@@ -1213,6 +1294,7 @@
 	unsigned long v;
 	int i;

+	balance_irq(irq);
 /*
  * It appears there is an erratum which affects at least version 0x11
  * of I/O APIC (that's the 82093AA and cores integrated into various
@@ -1268,19 +1350,6 @@
 }

 static void mask_and_ack_level_ioapic_irq (unsigned int irq) { /* nothing */ }
-
-static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
-{
-	unsigned long flags;
-	/*
-	 * Only the first 8 bits are valid.
-	 */
-	mask = mask << 24;
-
-	spin_lock_irqsave(&ioapic_lock, flags);
-	__DO_ACTION(1, = mask, )
-	spin_unlock_irqrestore(&ioapic_lock, flags);
-}

 /*
  * Level and edge triggered IO-APIC interrupts need different handling,
--- linux/arch/i386/kernel/irq.c.orig	Tue Feb  5 13:10:34 2002
+++ linux/arch/i386/kernel/irq.c	Tue Feb  5 13:11:15 2002
@@ -1076,7 +1076,7 @@

 static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];

-static unsigned long irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = ~0UL };
+unsigned long irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = ~0UL };
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {

