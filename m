Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312364AbSDSN2G>; Fri, 19 Apr 2002 09:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312449AbSDSN2F>; Fri, 19 Apr 2002 09:28:05 -0400
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:59152 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S312364AbSDSN2D>; Fri, 19 Apr 2002 09:28:03 -0400
Date: Fri, 19 Apr 2002 07:27:42 -0600 (MDT)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <3CBFFC11.A851755A@compro.net>
To: Mark Hounschell <markh@compro.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Message-id: <Pine.LNX.4.44.0204190723070.27894-400000@skuld.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_17M9zsR8iwi+KOWRIEkWyA)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary_(ID_17M9zsR8iwi+KOWRIEkWyA)
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT

On Fri, 19 Apr 2002, Mark Hounschell wrote:

> Bill Davidsen wrote:
> > 
> > On Wed, 17 Apr 2002, James Bourne wrote:
> > 
> > > After Ingo forwarded me his original patch (I found his patch via a web
> > > based medium, which had converted all of the left shifts to compares, and
> > > now I'm very glad it didn't boot...) and the system is booted and is
> > > balancing most of the interrupts at least.  Here's the current output
> > > of /proc/interrupts
> > 
> 
> Is there a version of this patch for 2.4.18? I also found the one on the web site wouldn't
> boot but would very much like to have a copy that would work for 2.4.18. Where might I find
> this?

Ingos' irqbalance-2.4.17-B1.patch applies cleanly to 2.4.18. This and the 
timer-irq-balance-2.4.18.patch are attached.  Also attached is a 2
line patch to identify the CPUs on boot, instead of getting unknown cpu
errors (cosmetic only).

These are currently running on a system with hyper threading
turned on, for the past 2 days or so and it seems stable.  

Regards
James


> 
> Ragards
> Mark
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************

--Boundary_(ID_17M9zsR8iwi+KOWRIEkWyA)
Content-id: <Pine.LNX.4.44.0204190727420.27894@skuld.mtroyal.ab.ca>
Content-type: TEXT/PLAIN; name=irqbalance-2.4.17-B1.patch; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=irqbalance-2.4.17-B1.patch
Content-description: irq balance patch

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

--Boundary_(ID_17M9zsR8iwi+KOWRIEkWyA)
Content-id: <Pine.LNX.4.44.0204190727421.27894@skuld.mtroyal.ab.ca>
Content-type: TEXT/PLAIN; name=timer-irq-balance-2.4.18.patch; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=timer-irq-balance-2.4.18.patch
Content-description: timer balance patch

diff -up --recursive --new-file linux-2.4.18.macro/arch/i386/kernel/io_apic.c linux-2.4.18/arch/i386/kernel/io_apic.c
--- linux-2.4.18.macro/arch/i386/kernel/io_apic.c	Fri Nov 23 15:32:04 2001
+++ linux-2.4.18/arch/i386/kernel/io_apic.c	Fri Mar  1 14:58:20 2002
@@ -67,7 +67,7 @@ static struct irq_pin_list {
  * shared ISA-space IRQs, so we have to support them. We are super
  * fast in the common case, and fast for shared ISA-space IRQs.
  */
-static void add_pin_to_irq(unsigned int irq, int apic, int pin)
+static void __init add_pin_to_irq(unsigned int irq, int apic, int pin)
 {
 	static int first_free_entry = NR_IRQS;
 	struct irq_pin_list *entry = irq_2_pin + irq;
@@ -85,6 +85,26 @@ static void add_pin_to_irq(unsigned int 
 	entry->pin = pin;
 }
 
+/*
+ * Reroute an IRQ to a different pin.
+ */
+static void __init replace_pin_at_irq(unsigned int irq,
+				      int oldapic, int oldpin,
+				      int newapic, int newpin)
+{
+	struct irq_pin_list *entry = irq_2_pin + irq;
+
+	while (1) {
+		if (entry->apic == oldapic && entry->pin == oldpin) {
+			entry->apic = newapic;
+			entry->pin = newpin;
+		}
+		if (!entry->next)
+			break;
+		entry = irq_2_pin + entry->next;
+	}
+}
+
 #define __DO_ACTION(R, ACTION, FINAL)					\
 									\
 {									\
@@ -1533,6 +1553,10 @@ static inline void check_timer(void)
 		setup_ExtINT_IRQ0_pin(pin2, vector);
 		if (timer_irq_works()) {
 			printk("works.\n");
+			if (pin1 != -1)
+				replace_pin_at_irq(0, 0, pin1, 0, pin2);
+			else
+				add_pin_to_irq(0, 0, pin2);
 			if (nmi_watchdog == NMI_IO_APIC) {
 				setup_nmi();
 				check_nmi_watchdog();

--Boundary_(ID_17M9zsR8iwi+KOWRIEkWyA)
Content-id: <Pine.LNX.4.44.0204190727422.27894@skuld.mtroyal.ab.ca>
Content-type: TEXT/PLAIN; name=2.4.18-p4-xeon-ident.patch; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=2.4.18-p4-xeon-ident.patch
Content-description: ident patch

--- linux-2.4.18/arch/i386/kernel/mpparse.c~	Fri Nov  9 15:58:18 2001
+++ linux-2.4.18/arch/i386/kernel/mpparse.c	Wed Apr 17 12:57:08 2002
@@ -113,6 +113,8 @@
 		case 0x0F:
 			if (model == 0x00)
 				return("Pentium 4(tm)");
+			if (model == 0x02)
+				return("Pentium 4(tm) XEON(tm)");
 			if (model == 0x0F)
 				return("Special controller");
 	}

--Boundary_(ID_17M9zsR8iwi+KOWRIEkWyA)--
