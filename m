Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267756AbSLTJAh>; Fri, 20 Dec 2002 04:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267757AbSLTJAg>; Fri, 20 Dec 2002 04:00:36 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:40151 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S267756AbSLTJAV>; Fri, 20 Dec 2002 04:00:21 -0500
Subject: [PATCH] IRQ distribution in the 2.5.52  kernel
Date: Fri, 20 Dec 2002 01:08:18 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DA5CE2F@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: yes
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C2A807.565E8E30"
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] IRQ distribution in the 2.5.52  kernel
Thread-Index: AcKoB1Xemj6Q45GGS/qcuqhVU5Tmqg==
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
X-OriginalArrivalTime: 20 Dec 2002 09:08:19.0235 (UTC) FILETIME=[56AF1F30:01C2A807]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C2A807.565E8E30
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello All,

  We were looking at the performance impact of the IRQ routing from the =
2.5.52 Linux kernel. This email includes some of our findings about the =
way the interrupts are getting moved in the 2.5.52 kernel. Also there is =
discussion and a patch for a new implementation. Let me know what you =
think at nitin.a.kamble@intel.com
=20
Current implementation:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
We have found that the existing implementation works well on IA32 SMP =
systems with light load of interrupts. Also we noticed that it is not =
working that well under heavy interrupt load conditions on these SMP =
systems. The observations are:
=20
* Interrupt load of each IRQ is getting balanced on CPUs independent of =
load of other IRQs. Also the current implementation moves the IRQs =
randomly. This works well when the interrupt load is light. But we start =
seeing imbalance of interrupt load with existence of multiple heavy =
interrupt sources. Frequently multiple heavily loaded IRQs gets moved to =
a single CPU while other CPUs stay very lightly loaded. To achieve a =
good interrupts load balance, it is important to consider the load of =
all the interrupts together.
    This further can be explained with an example of 4 CPUs and 4 heavy =
interrupt sources. With the existing random movement approach, the =
chance of each of these heavy interrupt sources moving to separate CPUs =
is: (4/4)*(3/4)*(2/4)*(1/4) =3D 3/16. It means 13/16 =3D 81.25% of the =
time the situation is, some CPUs are very lightly loaded and some are =
loaded with multiple heavy interrupts. This causes the interrupt load =
imbalance and results in less performance. In a case of 2 CPUs and 2 =
heavily loaded interrupt sources, this imbalance happens 1/2 =3D 50% of =
the times. This issue becomes more and more severe with increasing =
number of heavy interrupt sources.
=20
* Another interesting observation is: We cannot see the imbalance of the =
interrupt load from /proc/interrupts. (/proc/interrupts shows the =
cumulative load of interrupts on all CPUs.) If the interrupt load is =
imbalanced and this imbalance is getting rotated among CPUs =
continuously, then /proc/interrupts will still show that the interrupt =
load is going to processors very evenly. Currently at the frequency =
(HZ/50) at which IRQs are moved across CPUs, it is not possible to see =
any interrupt load imbalance happening.
=20
* We have also found that, in certain cases the static IRQ binding =
performs better than the existing kernel distribution of interrupt load. =
The reason is, in a well-balanced interrupt load situations, these =
interrupts are unnecessarily getting frequently moved across CPUs. This =
adds an extra overhead; also it takes off the CPU cache warmth benefits.
  This came out from the performance measurements done on a 4-way HT (8 =
logical processors) Pentium 4 Xeon system running 8 copies of netperf. =
The 4 NICs in the system taking different IRQs generated sizable =
interrupt load with the help of connected clients.
=20
Here the netperf transactions/sec throughput numbers observed are:
=20
IRQs nicely manually bound to CPUs: 56.20K=20
The current kernel implementation of IRQ movement: 50.05K
 -----------------------
 The static binding of IRQs has performed 12.28% better than the current =
IRQ movement implemented in the kernel.
=20
* The current implementation does not distinguish siblings from the HT =
(Hyper-Threading(tm)) enabled CPUs. It will be beneficial to balance the =
interrupt load with respect to processor packages first, and then among =
logical CPUs inside processor packages.=20
  For example if we have 2 heavy interrupt sources and 2 processor =
packages (4 logical CPUs); Assigning both the heavy interrupt sources in =
different processor packages is better, it will use different execution =
resources from the different processor packages.
=20
=20

New revised implementation:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
We also have been working on a new implementation. The following points =
are in main focus.
=20
* At any moment heavily loaded IRQs are distributed to different CPUs to =
achieve as much balance as possible.=20
=20
* Lightly loaded interrupt sources are ignored from the load balancing, =
as they do not cause considerable imbalance.
=20
* When the heavy interrupt sources are balanced, they are not moved =
around. This also helps in keeping the CPU caches warm.
=20
* It has been made HT aware. While distributing the load, the load on a =
processor package to which the logical CPUs belong to is also =
considered.
=20
* In the situations of few (lesser than num_cpus) heavy interrupt =
sources, it is not possible to balance them evenly. In such case the =
existing code has been reused to move the interrupts. The randomness =
from the original code has been removed.
=20
* The time interval for redistribution has been made flexible. It varies =
as the system interrupt load changes.
=20
* A new kernel_thread is introduced to do the load balancing =
calculations for all the interrupt sources. It keeps the balanace_maps =
ready for interrupt handlers, keeping the overhead in the interrupt =
handling to minimum.
=20
* It allows the disabling of the IRQ distribution from the boot loader =
command line, if anybody wants to do it for any reason.=20
=20
* The algorithm also takes into account the static binding of interrupts =
to CPUs that user imposes from the /proc/irq/{n}/smp_affinity interface.
=20
=20
Throughput numbers with the netperf setup for the new implementation:
=20
Current kernel IRQ balance implementation: 50.02K transactions/sec
The new IRQ balance implementation: 56.01K transactions/sec
 ---------------------
  The performance improvement on P4 Xeon of 11.9% is observed.
=20
The new IRQ balance implementation also shows little performance =
improvement on P6 (Pentium II, III) systems.
=20
On a P6 system the netperf throughput numbers are:
Current kernel IRQ balance implementation: 36.96K transactions/sec
The new IRQ balance implementation: 37.65K transactions/sec
 ---------------------
  Here the performance improvement on P6 system of about 2% is observed.
=20
=20
Thanks,
Nitin

diff -Naru 2.5.52/Documentation/kernel-parameters.txt =
kirqb/Documentation/kernel-parameters.txt
--- 2.5.52/Documentation/kernel-parameters.txt	Tue Dec 17 15:35:57 2002
+++ kirqb/Documentation/kernel-parameters.txt	Tue Dec 17 15:37:29 2002
@@ -352,6 +352,8 @@
=20
 	hugepages=3D	[HW,IA-32] Maximal number of HugeTLB pages
=20
+	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
+
 	i8042_direct	[HW] Non-translated mode
 	i8042_dumbkbd
 	i8042_noaux
diff -Naru 2.5.52/arch/i386/kernel/io_apic.c =
kirqb/arch/i386/kernel/io_apic.c
--- 2.5.52/arch/i386/kernel/io_apic.c	Tue Dec 17 15:35:26 2002
+++ kirqb/arch/i386/kernel/io_apic.c	Fri Dec 20 01:23:15 2002
@@ -206,19 +206,37 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
-#if CONFIG_SMP
+#if defined(CONFIG_SMP)
+# include <asm/processor.h>	/* kernel_thread() */
+# include <linux/kernel_stat.h>	/* kstat */
+# include <linux/slab.h>		/* kmalloc() */
+# include <linux/timer.h>	/* time_after() */
+=20
+# if CONFIG_BALANCED_IRQ_DEBUG
+#  define TDprintk(x...) do { printk("<%ld:%s:%d>: ", jiffies, =
__FILE__, __LINE__); printk(x); } while (0)
+#  define Dprintk(x...) do { TDprintk(x); } while (0)
+# else
+#  define TDprintk(x...)=20
+#  define Dprintk(x...)=20
+# endif
=20
-typedef struct {
-	unsigned int cpu;
-	unsigned long timestamp;
-} ____cacheline_aligned irq_balance_t;
-
-static irq_balance_t irq_balance[NR_IRQS] __cacheline_aligned
-			=3D { [ 0 ... NR_IRQS-1 ] =3D { 0, 0 } };
+# define MIN(a,b) (((a) < (b)) ? (a) : (b))
+# define MAX(a,b) (((a) > (b)) ? (a) : (b))
=20
 extern unsigned long irq_affinity [NR_IRQS];
-
-#endif
+unsigned long __cacheline_aligned irq_balance_mask [NR_IRQS];
+static int irqbalance_disabled __initdata =3D 0;
+static int physical_balance =3D 0;
+
+struct irq_cpu_info {
+	unsigned long * last_irq;
+	unsigned long * irq_delta;
+	unsigned long irq;
+} irq_cpu_data[NR_CPUS];
+
+#define CPU_IRQ(cpu)		(irq_cpu_data[cpu].irq)
+#define LAST_CPU_IRQ(cpu,irq)   (irq_cpu_data[cpu].last_irq[irq])
+#define IRQ_DELTA(cpu,irq) 	(irq_cpu_data[cpu].irq_delta[irq])
=20
 #define IDLE_ENOUGH(cpu,now) \
 		(idle_cpu(cpu) && ((now) - irq_stat[(cpu)].idle_timestamp > 1))
@@ -226,10 +244,224 @@
 #define IRQ_ALLOWED(cpu,allowed_mask) \
 		((1 << cpu) & (allowed_mask))
=20
-#if CONFIG_SMP
+#define CPU_TO_PACKAGEINDEX(i) \
+		((physical_balance && i > cpu_sibling_map[i]) ? cpu_sibling_map[i] : =
i)
+
+#define MAX_BALANCED_IRQ_INTERVAL	(5*HZ)
+#define MIN_BALANCED_IRQ_INTERVAL	(HZ/2)
+#define BALANCED_IRQ_MORE_DELTA		(HZ/10)
+#define BALANCED_IRQ_LESS_DELTA		(HZ)
+
+unsigned long balanced_irq_interval =3D MAX_BALANCED_IRQ_INTERVAL;
+					=20
+static inline void balance_irq(int cpu, int irq);
+
+static inline void rotate_irqs_among_cpus(unsigned long =
useful_load_threshold)
+{
+	int i, j;
+	Dprintk("Rotating IRQs among CPUs.\n");
+	for (i =3D 0; i < NR_CPUS; i++) {
+		for (j =3D 0; cpu_online(i) && (j < NR_IRQS); j++) {
+			if (!irq_desc[j].action)
+				continue;
+			/* Is it a significant load ?  */
+			if (IRQ_DELTA(CPU_TO_PACKAGEINDEX(i),j) < useful_load_threshold)
+				continue;
+			balance_irq(i, j);
+		}
+	}
+	balanced_irq_interval =3D MAX(MIN_BALANCED_IRQ_INTERVAL,
+		balanced_irq_interval - BALANCED_IRQ_LESS_DELTA);=09
+	return;
+}
+
+static void do_irq_balance(void)
+{
+	int i, j;
+	unsigned long max_cpu_irq =3D 0, min_cpu_irq =3D (~0);
+	unsigned long move_this_load =3D 0;
+	int max_loaded =3D 0, min_loaded =3D 0;
+	unsigned long useful_load_threshold =3D balanced_irq_interval + 10;
+	int selected_irq;
+	int tmp_loaded, first_attempt =3D 1;
+	unsigned long tmp_cpu_irq;
+	unsigned long imbalance =3D 0;
+	unsigned long allowed_mask;
+	unsigned long target_cpu_mask;
+
+	for (i =3D 0; i < NR_CPUS; i++) {
+		int package_index;
+		CPU_IRQ(i) =3D 0;
+		if (!cpu_online(i))
+			continue;
+		package_index =3D CPU_TO_PACKAGEINDEX(i);
+		for (j =3D 0; j < NR_IRQS; j++) {
+			unsigned long value_now, delta;
+			/* Is this an active IRQ? */
+			if (!irq_desc[j].action)
+				continue;
+			if (package_index =3D=3D i)
+				IRQ_DELTA(package_index,j) =3D 0;
+			/* Determine the total count per processor per IRQ */
+			value_now =3D (unsigned long) kstat_cpu(i).irqs[j];
+
+			/* Determine the activity per processor per IRQ */
+			delta =3D value_now - LAST_CPU_IRQ(i,j);
+
+			/* Update last_cpu_irq[][] for the next time */
+			LAST_CPU_IRQ(i,j) =3D value_now;
+
+			/* Ignore IRQs whose rate is less than the clock */
+			if (delta < useful_load_threshold)
+				continue;
+			/* update the load for the processor or package total */
+			IRQ_DELTA(package_index,j) +=3D delta;
+
+			/* Keep track of the higher numbered sibling as well */
+			if (i !=3D package_index)
+				CPU_IRQ(i) +=3D delta;
+			/*
+			 * We have sibling A and sibling B in the package
+			 *
+			 * cpu_irq[A] =3D load for cpu A + load for cpu B
+			 * cpu_irq[B] =3D load for cpu B
+			 */
+			CPU_IRQ(package_index) +=3D delta;
+		}
+	}
+	/* Find the least loaded processor package */
+	for (i =3D 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+		if (physical_balance && i > cpu_sibling_map[i])
+			continue;
+		if (min_cpu_irq > CPU_IRQ(i)) {
+			min_cpu_irq =3D CPU_IRQ(i);
+			min_loaded =3D i;
+		}
+	}
+	max_cpu_irq =3D ULONG_MAX;
+
+tryanothercpu:
+	/* Look for heaviest loaded processor.
+	 * We may come back to get the next heaviest loaded processor.
+	 * Skip processors with trivial loads.
+	 */
+	tmp_cpu_irq =3D 0;
+	tmp_loaded =3D -1;
+	for (i =3D 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+		if (physical_balance && i > cpu_sibling_map[i])
+			continue;
+		if (max_cpu_irq <=3D CPU_IRQ(i))=20
+			continue;
+		if (tmp_cpu_irq < CPU_IRQ(i)) {
+			tmp_cpu_irq =3D CPU_IRQ(i);
+			tmp_loaded =3D i;
+		}
+	}
+
+	if (tmp_loaded =3D=3D -1) {
+ 	 /* In the case of small number of heavy interrupt sources,=20
+	  * loading some of the cpus too much. We use Ingo's original=20
+	  * approach to rotate them around.
+	  */
+		if (!first_attempt && imbalance >=3D useful_load_threshold) {
+			rotate_irqs_among_cpus(useful_load_threshold);
+			return;
+		}
+		goto not_worth_the_effort;
+	}
+=09
+	first_attempt =3D 0;		/* heaviest search */
+	max_cpu_irq =3D tmp_cpu_irq;	/* load */
+	max_loaded =3D tmp_loaded;	/* processor */
+	imbalance =3D (max_cpu_irq - min_cpu_irq) / 2;
+=09
+	Dprintk("max_loaded cpu =3D %d\n", max_loaded);
+	Dprintk("min_loaded cpu =3D %d\n", min_loaded);
+	Dprintk("max_cpu_irq load =3D %ld\n", max_cpu_irq);
+	Dprintk("min_cpu_irq load =3D %ld\n", min_cpu_irq);
+	Dprintk("load imbalance =3D %lu\n", imbalance);
+
+	/* if imbalance is less than approx 10% of max load, then
+	 * observe diminishing returns action. - quit
+	 */
+	if (imbalance < (max_cpu_irq >> 3)) {
+		Dprintk("Imbalance too trivial\n");
+		goto not_worth_the_effort;
+	}
+
+tryanotherirq:
+	/* if we select an IRQ to move that can't go where we want, then
+	 * see if there is another one to try.
+	 */
+	move_this_load =3D 0;
+	selected_irq =3D -1;
+	for (j =3D 0; j < NR_IRQS; j++) {
+		/* Is this an active IRQ? */
+		if (!irq_desc[j].action)
+			continue;
+		if (imbalance <=3D IRQ_DELTA(max_loaded,j))
+			continue;
+		/* Try to find the IRQ that is closest to the imbalance
+		 * without going over.
+		 */
+		if (move_this_load < IRQ_DELTA(max_loaded,j)) {
+			move_this_load =3D IRQ_DELTA(max_loaded,j);
+			selected_irq =3D j;
+		}
+	}
+	if (selected_irq =3D=3D -1) {
+		goto tryanothercpu;
+	}
=20
-#define IRQ_BALANCE_INTERVAL (HZ/50)
+	imbalance =3D move_this_load;
 =09
+	/* For physical_balance case, we accumlated both load
+	 * values in the one of the siblings cpu_irq[],
+	 * to use the same code for physical and logical processors
+	 * as much as possible.=20
+	 *
+	 * NOTE: the cpu_irq[] array holds the sum of the load for
+	 * sibling A and sibling B in the slot for the lowest numbered
+	 * sibling (A), _AND_ the load for sibling B in the slot for
+	 * the higher numbered sibling.
+	 *
+	 * We seek the least loaded sibling by making the comparison
+	 * (A+B)/2 vs B
+	 */
+	if (physical_balance && (CPU_IRQ(min_loaded) >> 1) > =
CPU_IRQ(cpu_sibling_map[min_loaded]))
+		min_loaded =3D cpu_sibling_map[min_loaded];
+
+	allowed_mask =3D cpu_online_map & irq_affinity[selected_irq];
+	target_cpu_mask =3D 1 << min_loaded;
+
+	if (target_cpu_mask & allowed_mask) {
+		irq_desc_t *desc =3D irq_desc + selected_irq;
+		Dprintk("irq =3D %d moved to cpu =3D %d\n", selected_irq, =
min_loaded);
+		/* mark for change destination */
+		spin_lock(&desc->lock);
+		irq_balance_mask[selected_irq] =3D target_cpu_mask;
+		spin_unlock(&desc->lock);
+		/* Since we made a change, come back sooner to=20
+		 * check for more variation.
+		 */
+		balanced_irq_interval =3D MAX(MIN_BALANCED_IRQ_INTERVAL,
+			balanced_irq_interval - BALANCED_IRQ_LESS_DELTA);=09
+		return;
+	}
+	goto tryanotherirq;
+
+not_worth_the_effort:
+	/* if we did not find an IRQ to move, then adjust the time interval =
upward */
+	balanced_irq_interval =3D MIN(MAX_BALANCED_IRQ_INTERVAL,
+		balanced_irq_interval + BALANCED_IRQ_MORE_DELTA);=09
+	Dprintk("IRQ worth rotating not found\n");
+	return;
+}
+
 static unsigned long move(int curr_cpu, unsigned long allowed_mask, =
unsigned long now, int direction)
 {
 	int search_idle =3D 1;
@@ -256,34 +488,112 @@
 	return cpu;
 }
=20
-static inline void balance_irq(int irq)
+static inline void balance_irq (int cpu, int irq)
 {
-	irq_balance_t *entry =3D irq_balance + irq;
 	unsigned long now =3D jiffies;
-
+	unsigned long allowed_mask;
+	unsigned int new_cpu;
+	=09
 	if (clustered_apic_mode)
 		return;
=20
-	if (unlikely(time_after(now, entry->timestamp + =
IRQ_BALANCE_INTERVAL))) {
-		unsigned long allowed_mask;
-		unsigned int new_cpu;
-		int random_number;
-
-		rdtscl(random_number);
-		random_number &=3D 1;
-
-		allowed_mask =3D cpu_online_map & irq_affinity[irq];
-		entry->timestamp =3D now;
-		new_cpu =3D move(entry->cpu, allowed_mask, now, random_number);
-		if (entry->cpu !=3D new_cpu) {
-			entry->cpu =3D new_cpu;
-			set_ioapic_affinity(irq, 1 << new_cpu);
+	allowed_mask =3D cpu_online_map & irq_affinity[irq];
+	new_cpu =3D move(cpu, allowed_mask, now, 1);
+	if (cpu !=3D new_cpu) {
+		irq_desc_t *desc =3D irq_desc + irq;
+		spin_lock(&desc->lock);
+		irq_balance_mask[irq] =3D 1 << new_cpu;
+		spin_unlock(&desc->lock);
+	}
+}
+
+int balanced_irq(void *unused)
+{
+	int i;
+	unsigned long prev_balance_time =3D jiffies;
+	long time_remaining =3D balanced_irq_interval;
+	daemonize();
+	sigfillset(&current->blocked);
+	sprintf(current->comm, "balanced_irq");
+=09
+	/* push everything to CPU 0 to give us a starting point.  */
+	for (i =3D 0 ; i < NR_IRQS ; i++)
+		irq_balance_mask[i] =3D 1 << 0;
+	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		time_remaining =3D schedule_timeout(time_remaining);
+		if (time_after(jiffies, prev_balance_time+balanced_irq_interval)) {
+			Dprintk("balanced_irq: calling do_irq_balance() %lu\n", jiffies);
+			do_irq_balance();
+			prev_balance_time =3D jiffies;
+			time_remaining =3D balanced_irq_interval;
 		}
+        }
+}
+
+static int __init balanced_irq_init(void)
+{
+	int i;
+	struct cpuinfo_x86 *c;
+        c =3D &boot_cpu_data;
+	if (irqbalance_disabled)
+		return 0;
+	/* Enable physical balance only if more than=20
+	 * one physical processor package is present */
+	if (smp_num_siblings > 1 && cpu_online_map >> 2)
+		physical_balance =3D 1;
+
+	for (i =3D 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+		irq_cpu_data[i].irq_delta =3D kmalloc(sizeof(unsigned long) * =
NR_IRQS, GFP_KERNEL);
+		irq_cpu_data[i].last_irq =3D kmalloc(sizeof(unsigned long) * NR_IRQS, =
GFP_KERNEL);
+		if (irq_cpu_data[i].irq_delta =3D=3D NULL || irq_cpu_data[i].last_irq =
=3D=3D NULL) {
+			printk(KERN_ERR "balanced_irq_init: out of memory");
+			goto failed;
+		}
+		memset(irq_cpu_data[i].irq_delta,0,sizeof(unsigned long) * NR_IRQS);
+		memset(irq_cpu_data[i].last_irq,0,sizeof(unsigned long) * NR_IRQS);
+	}
+=09
+	printk(KERN_INFO "Starting balanced_irq\n");
+	if (kernel_thread(balanced_irq, NULL, CLONE_KERNEL) >=3D 0)=20
+		return 0;
+	else=20
+		printk(KERN_ERR "balanced_irq_init: failed to spawn balanced_irq");
+failed:
+	for (i =3D 0; i < NR_CPUS; i++) {
+		if (irq_cpu_data[i].irq_delta)
+			kfree(irq_cpu_data[i].irq_delta);
+		if (irq_cpu_data[i].last_irq)
+			kfree(irq_cpu_data[i].last_irq);
 	}
+	return 0;
 }
-#else /* !SMP */
-static inline void balance_irq(int irq) { }
-#endif
+
+static int __init irqbalance_disable(char *str)
+{
+	irqbalance_disabled =3D 1;
+	return 0;
+}
+
+__setup("noirqbalance", irqbalance_disable);
+
+static void set_ioapic_affinity (unsigned int irq, unsigned long mask);
+
+static inline void move_irq(int irq)
+{
+	/* note - we hold the desc->lock */
+	if (unlikely(irq_balance_mask[irq])) {
+		set_ioapic_affinity(irq, irq_balance_mask[irq]);
+		irq_balance_mask[irq] =3D 0;
+	}
+}
+
+__initcall(balanced_irq_init);
+
+#endif /* defined(CONFIG_SMP) */
+
=20
 /*
  * support for broken MP BIOSs, enables hand-redirection of PIRQ0-7 to
@@ -1308,7 +1618,7 @@
  */
 static void ack_edge_ioapic_irq(unsigned int irq)
 {
-	balance_irq(irq);
+	move_irq(irq);
 	if ((irq_desc[irq].status & (IRQ_PENDING | IRQ_DISABLED))
 					=3D=3D (IRQ_PENDING | IRQ_DISABLED))
 		mask_IO_APIC_irq(irq);
@@ -1348,7 +1658,7 @@
 	unsigned long v;
 	int i;
=20
-	balance_irq(irq);
+	move_irq(irq);
 /*
  * It appears there is an erratum which affects at least version 0x11
  * of I/O APIC (that's the 82093AA and cores integrated into various



------_=_NextPart_001_01C2A807.565E8E30
Content-Type: application/x-zip-compressed;
	name="kirqb_2.5.52.ZIP"
Content-Transfer-Encoding: base64
Content-Description: kirqb_2.5.52.ZIP
Content-Disposition: attachment;
	filename="kirqb_2.5.52.ZIP"

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

------_=_NextPart_001_01C2A807.565E8E30--
