Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267682AbTAHCop>; Tue, 7 Jan 2003 21:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267683AbTAHCoo>; Tue, 7 Jan 2003 21:44:44 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:56634 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S267682AbTAHCo2>; Tue, 7 Jan 2003 21:44:28 -0500
content-class: urn:content-classes:message
Subject: [PATCH] [2.5] IRQ distribution in the 2.5.52  kernel
Date: Tue, 7 Jan 2003 18:52:59 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DA5CE52@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C2B6C1.0DE8A962"
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [2.5] IRQ distribution in the 2.5.52  kernel
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK2wK3Wu0R7hFpGRJaVfQgiQkMzbgAAAm7A
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: <linux-kernel@vger.kernel.org>,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Cc: "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 08 Jan 2003 02:53:02.0798 (UTC) FILETIME=[0FB0BEE0:01C2B6C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C2B6C1.0DE8A962
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


The patch for the IRQ balancing.

Thanks,
Nitin


diff -Naru 2.5.52/Documentation/kernel-parameters.txt
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
diff -Naru 2.5.52/arch/i386/kernel/io_apic.c
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
+#  define TDprintk(x...) do { printk("<%ld:%s:%d>: ", jiffies,
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
 		(idle_cpu(cpu) && ((now) -
irq_stat[(cpu)].idle_timestamp > 1))
@@ -226,10 +244,224 @@
 #define IRQ_ALLOWED(cpu,allowed_mask) \
 		((1 << cpu) & (allowed_mask))
=20
-#if CONFIG_SMP
+#define CPU_TO_PACKAGEINDEX(i) \
+		((physical_balance && i > cpu_sibling_map[i]) ?
cpu_sibling_map[i] : i)
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
+static inline void rotate_irqs_among_cpus(unsigned long
useful_load_threshold)
+{
+	int i, j;
+	Dprintk("Rotating IRQs among CPUs.\n");
+	for (i =3D 0; i < NR_CPUS; i++) {
+		for (j =3D 0; cpu_online(i) && (j < NR_IRQS); j++) {
+			if (!irq_desc[j].action)
+				continue;
+			/* Is it a significant load ?  */
+			if (IRQ_DELTA(CPU_TO_PACKAGEINDEX(i),j) <
useful_load_threshold)
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
+	unsigned long useful_load_threshold =3D balanced_irq_interval +
10;
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
+			/* Determine the total count per processor per
IRQ */
+			value_now =3D (unsigned long)
kstat_cpu(i).irqs[j];
+
+			/* Determine the activity per processor per IRQ
*/
+			delta =3D value_now - LAST_CPU_IRQ(i,j);
+
+			/* Update last_cpu_irq[][] for the next time */
+			LAST_CPU_IRQ(i,j) =3D value_now;
+
+			/* Ignore IRQs whose rate is less than the clock
*/
+			if (delta < useful_load_threshold)
+				continue;
+			/* update the load for the processor or package
total */
+			IRQ_DELTA(package_index,j) +=3D delta;
+
+			/* Keep track of the higher numbered sibling as
well */
+			if (i !=3D package_index)
+				CPU_IRQ(i) +=3D delta;
+			/*
+			 * We have sibling A and sibling B in the
package
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
+		if (!first_attempt && imbalance >=3D
useful_load_threshold) {
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
+	if (physical_balance && (CPU_IRQ(min_loaded) >> 1) >
CPU_IRQ(cpu_sibling_map[min_loaded]))
+		min_loaded =3D cpu_sibling_map[min_loaded];
+
+	allowed_mask =3D cpu_online_map & irq_affinity[selected_irq];
+	target_cpu_mask =3D 1 << min_loaded;
+
+	if (target_cpu_mask & allowed_mask) {
+		irq_desc_t *desc =3D irq_desc + selected_irq;
+		Dprintk("irq =3D %d moved to cpu =3D %d\n", selected_irq,
min_loaded);
+		/* mark for change destination */
+		spin_lock(&desc->lock);
+		irq_balance_mask[selected_irq] =3D target_cpu_mask;
+		spin_unlock(&desc->lock);
+		/* Since we made a change, come back sooner to=20
+		 * check for more variation.
+		 */
+		balanced_irq_interval =3D MAX(MIN_BALANCED_IRQ_INTERVAL,
+			balanced_irq_interval -
BALANCED_IRQ_LESS_DELTA);=09
+		return;
+	}
+	goto tryanotherirq;
+
+not_worth_the_effort:
+	/* if we did not find an IRQ to move, then adjust the time
interval upward */
+	balanced_irq_interval =3D MIN(MAX_BALANCED_IRQ_INTERVAL,
+		balanced_irq_interval + BALANCED_IRQ_MORE_DELTA);=09
+	Dprintk("IRQ worth rotating not found\n");
+	return;
+}
+
 static unsigned long move(int curr_cpu, unsigned long allowed_mask,
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
-	if (unlikely(time_after(now, entry->timestamp +
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
-		new_cpu =3D move(entry->cpu, allowed_mask, now,
random_number);
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
+		if (time_after(jiffies,
prev_balance_time+balanced_irq_interval)) {
+			Dprintk("balanced_irq: calling do_irq_balance()
%lu\n", jiffies);
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
+		irq_cpu_data[i].irq_delta =3D kmalloc(sizeof(unsigned
long) * NR_IRQS, GFP_KERNEL);
+		irq_cpu_data[i].last_irq =3D kmalloc(sizeof(unsigned long)
* NR_IRQS, GFP_KERNEL);
+		if (irq_cpu_data[i].irq_delta =3D=3D NULL ||
irq_cpu_data[i].last_irq =3D=3D NULL) {
+			printk(KERN_ERR "balanced_irq_init: out of
memory");
+			goto failed;
+		}
+		memset(irq_cpu_data[i].irq_delta,0,sizeof(unsigned long)
* NR_IRQS);
+		memset(irq_cpu_data[i].last_irq,0,sizeof(unsigned long)
* NR_IRQS);
+	}
+=09
+	printk(KERN_INFO "Starting balanced_irq\n");
+	if (kernel_thread(balanced_irq, NULL, CLONE_KERNEL) >=3D 0)=20
+		return 0;
+	else=20
+		printk(KERN_ERR "balanced_irq_init: failed to spawn
balanced_irq");
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

------_=_NextPart_001_01C2B6C1.0DE8A962
Content-Type: application/octet-stream;
	name="kirqb_2.5.52.patch"
Content-Transfer-Encoding: base64
Content-Description: kirqb_2.5.52.patch
Content-Disposition: attachment;
	filename="kirqb_2.5.52.patch"

ZGlmZiAtTmFydSAyLjUuNTIvRG9jdW1lbnRhdGlvbi9rZXJuZWwtcGFyYW1ldGVycy50eHQga2ly
cWIvRG9jdW1lbnRhdGlvbi9rZXJuZWwtcGFyYW1ldGVycy50eHQKLS0tIDIuNS41Mi9Eb2N1bWVu
dGF0aW9uL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dAlUdWUgRGVjIDE3IDE1OjM1OjU3IDIwMDIKKysr
IGtpcnFiL0RvY3VtZW50YXRpb24va2VybmVsLXBhcmFtZXRlcnMudHh0CVR1ZSBEZWMgMTcgMTU6
Mzc6MjkgMjAwMgpAQCAtMzUyLDYgKzM1Miw4IEBACiAKIAlodWdlcGFnZXM9CVtIVyxJQS0zMl0g
TWF4aW1hbCBudW1iZXIgb2YgSHVnZVRMQiBwYWdlcwogCisJbm9pcnFiYWxhbmNlCVtJQS0zMixT
TVAsS05MXSBEaXNhYmxlIGtlcm5lbCBpcnEgYmFsYW5jaW5nCisKIAlpODA0Ml9kaXJlY3QJW0hX
XSBOb24tdHJhbnNsYXRlZCBtb2RlCiAJaTgwNDJfZHVtYmtiZAogCWk4MDQyX25vYXV4CmRpZmYg
LU5hcnUgMi41LjUyL2FyY2gvaTM4Ni9rZXJuZWwvaW9fYXBpYy5jIGtpcnFiL2FyY2gvaTM4Ni9r
ZXJuZWwvaW9fYXBpYy5jCi0tLSAyLjUuNTIvYXJjaC9pMzg2L2tlcm5lbC9pb19hcGljLmMJVHVl
IERlYyAxNyAxNTozNToyNiAyMDAyCisrKyBraXJxYi9hcmNoL2kzODYva2VybmVsL2lvX2FwaWMu
YwlGcmkgRGVjIDIwIDAxOjIzOjE1IDIwMDIKQEAgLTIwNiwxOSArMjA2LDM3IEBACiAJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmaW9hcGljX2xvY2ssIGZsYWdzKTsKIH0KIAotI2lmIENPTkZJR19T
TVAKKyNpZiBkZWZpbmVkKENPTkZJR19TTVApCisjIGluY2x1ZGUgPGFzbS9wcm9jZXNzb3IuaD4J
Lyoga2VybmVsX3RocmVhZCgpICovCisjIGluY2x1ZGUgPGxpbnV4L2tlcm5lbF9zdGF0Lmg+CS8q
IGtzdGF0ICovCisjIGluY2x1ZGUgPGxpbnV4L3NsYWIuaD4JCS8qIGttYWxsb2MoKSAqLworIyBp
bmNsdWRlIDxsaW51eC90aW1lci5oPgkvKiB0aW1lX2FmdGVyKCkgKi8KKyAKKyMgaWYgQ09ORklH
X0JBTEFOQ0VEX0lSUV9ERUJVRworIyAgZGVmaW5lIFREcHJpbnRrKHguLi4pIGRvIHsgcHJpbnRr
KCI8JWxkOiVzOiVkPjogIiwgamlmZmllcywgX19GSUxFX18sIF9fTElORV9fKTsgcHJpbnRrKHgp
OyB9IHdoaWxlICgwKQorIyAgZGVmaW5lIERwcmludGsoeC4uLikgZG8geyBURHByaW50ayh4KTsg
fSB3aGlsZSAoMCkKKyMgZWxzZQorIyAgZGVmaW5lIFREcHJpbnRrKHguLi4pIAorIyAgZGVmaW5l
IERwcmludGsoeC4uLikgCisjIGVuZGlmCiAKLXR5cGVkZWYgc3RydWN0IHsKLQl1bnNpZ25lZCBp
bnQgY3B1OwotCXVuc2lnbmVkIGxvbmcgdGltZXN0YW1wOwotfSBfX19fY2FjaGVsaW5lX2FsaWdu
ZWQgaXJxX2JhbGFuY2VfdDsKLQotc3RhdGljIGlycV9iYWxhbmNlX3QgaXJxX2JhbGFuY2VbTlJf
SVJRU10gX19jYWNoZWxpbmVfYWxpZ25lZAotCQkJPSB7IFsgMCAuLi4gTlJfSVJRUy0xIF0gPSB7
IDAsIDAgfSB9OworIyBkZWZpbmUgTUlOKGEsYikgKCgoYSkgPCAoYikpID8gKGEpIDogKGIpKQor
IyBkZWZpbmUgTUFYKGEsYikgKCgoYSkgPiAoYikpID8gKGEpIDogKGIpKQogCiBleHRlcm4gdW5z
aWduZWQgbG9uZyBpcnFfYWZmaW5pdHkgW05SX0lSUVNdOwotCi0jZW5kaWYKK3Vuc2lnbmVkIGxv
bmcgX19jYWNoZWxpbmVfYWxpZ25lZCBpcnFfYmFsYW5jZV9tYXNrIFtOUl9JUlFTXTsKK3N0YXRp
YyBpbnQgaXJxYmFsYW5jZV9kaXNhYmxlZCBfX2luaXRkYXRhID0gMDsKK3N0YXRpYyBpbnQgcGh5
c2ljYWxfYmFsYW5jZSA9IDA7CisKK3N0cnVjdCBpcnFfY3B1X2luZm8geworCXVuc2lnbmVkIGxv
bmcgKiBsYXN0X2lycTsKKwl1bnNpZ25lZCBsb25nICogaXJxX2RlbHRhOworCXVuc2lnbmVkIGxv
bmcgaXJxOworfSBpcnFfY3B1X2RhdGFbTlJfQ1BVU107CisKKyNkZWZpbmUgQ1BVX0lSUShjcHUp
CQkoaXJxX2NwdV9kYXRhW2NwdV0uaXJxKQorI2RlZmluZSBMQVNUX0NQVV9JUlEoY3B1LGlycSkg
ICAoaXJxX2NwdV9kYXRhW2NwdV0ubGFzdF9pcnFbaXJxXSkKKyNkZWZpbmUgSVJRX0RFTFRBKGNw
dSxpcnEpIAkoaXJxX2NwdV9kYXRhW2NwdV0uaXJxX2RlbHRhW2lycV0pCiAKICNkZWZpbmUgSURM
RV9FTk9VR0goY3B1LG5vdykgXAogCQkoaWRsZV9jcHUoY3B1KSAmJiAoKG5vdykgLSBpcnFfc3Rh
dFsoY3B1KV0uaWRsZV90aW1lc3RhbXAgPiAxKSkKQEAgLTIyNiwxMCArMjQ0LDIyNCBAQAogI2Rl
ZmluZSBJUlFfQUxMT1dFRChjcHUsYWxsb3dlZF9tYXNrKSBcCiAJCSgoMSA8PCBjcHUpICYgKGFs
bG93ZWRfbWFzaykpCiAKLSNpZiBDT05GSUdfU01QCisjZGVmaW5lIENQVV9UT19QQUNLQUdFSU5E
RVgoaSkgXAorCQkoKHBoeXNpY2FsX2JhbGFuY2UgJiYgaSA+IGNwdV9zaWJsaW5nX21hcFtpXSkg
PyBjcHVfc2libGluZ19tYXBbaV0gOiBpKQorCisjZGVmaW5lIE1BWF9CQUxBTkNFRF9JUlFfSU5U
RVJWQUwJKDUqSFopCisjZGVmaW5lIE1JTl9CQUxBTkNFRF9JUlFfSU5URVJWQUwJKEhaLzIpCisj
ZGVmaW5lIEJBTEFOQ0VEX0lSUV9NT1JFX0RFTFRBCQkoSFovMTApCisjZGVmaW5lIEJBTEFOQ0VE
X0lSUV9MRVNTX0RFTFRBCQkoSFopCisKK3Vuc2lnbmVkIGxvbmcgYmFsYW5jZWRfaXJxX2ludGVy
dmFsID0gTUFYX0JBTEFOQ0VEX0lSUV9JTlRFUlZBTDsKKwkJCQkJIAorc3RhdGljIGlubGluZSB2
b2lkIGJhbGFuY2VfaXJxKGludCBjcHUsIGludCBpcnEpOworCitzdGF0aWMgaW5saW5lIHZvaWQg
cm90YXRlX2lycXNfYW1vbmdfY3B1cyh1bnNpZ25lZCBsb25nIHVzZWZ1bF9sb2FkX3RocmVzaG9s
ZCkKK3sKKwlpbnQgaSwgajsKKwlEcHJpbnRrKCJSb3RhdGluZyBJUlFzIGFtb25nIENQVXMuXG4i
KTsKKwlmb3IgKGkgPSAwOyBpIDwgTlJfQ1BVUzsgaSsrKSB7CisJCWZvciAoaiA9IDA7IGNwdV9v
bmxpbmUoaSkgJiYgKGogPCBOUl9JUlFTKTsgaisrKSB7CisJCQlpZiAoIWlycV9kZXNjW2pdLmFj
dGlvbikKKwkJCQljb250aW51ZTsKKwkJCS8qIElzIGl0IGEgc2lnbmlmaWNhbnQgbG9hZCA/ICAq
LworCQkJaWYgKElSUV9ERUxUQShDUFVfVE9fUEFDS0FHRUlOREVYKGkpLGopIDwgdXNlZnVsX2xv
YWRfdGhyZXNob2xkKQorCQkJCWNvbnRpbnVlOworCQkJYmFsYW5jZV9pcnEoaSwgaik7CisJCX0K
Kwl9CisJYmFsYW5jZWRfaXJxX2ludGVydmFsID0gTUFYKE1JTl9CQUxBTkNFRF9JUlFfSU5URVJW
QUwsCisJCWJhbGFuY2VkX2lycV9pbnRlcnZhbCAtIEJBTEFOQ0VEX0lSUV9MRVNTX0RFTFRBKTsJ
CisJcmV0dXJuOworfQorCitzdGF0aWMgdm9pZCBkb19pcnFfYmFsYW5jZSh2b2lkKQoreworCWlu
dCBpLCBqOworCXVuc2lnbmVkIGxvbmcgbWF4X2NwdV9pcnEgPSAwLCBtaW5fY3B1X2lycSA9ICh+
MCk7CisJdW5zaWduZWQgbG9uZyBtb3ZlX3RoaXNfbG9hZCA9IDA7CisJaW50IG1heF9sb2FkZWQg
PSAwLCBtaW5fbG9hZGVkID0gMDsKKwl1bnNpZ25lZCBsb25nIHVzZWZ1bF9sb2FkX3RocmVzaG9s
ZCA9IGJhbGFuY2VkX2lycV9pbnRlcnZhbCArIDEwOworCWludCBzZWxlY3RlZF9pcnE7CisJaW50
IHRtcF9sb2FkZWQsIGZpcnN0X2F0dGVtcHQgPSAxOworCXVuc2lnbmVkIGxvbmcgdG1wX2NwdV9p
cnE7CisJdW5zaWduZWQgbG9uZyBpbWJhbGFuY2UgPSAwOworCXVuc2lnbmVkIGxvbmcgYWxsb3dl
ZF9tYXNrOworCXVuc2lnbmVkIGxvbmcgdGFyZ2V0X2NwdV9tYXNrOworCisJZm9yIChpID0gMDsg
aSA8IE5SX0NQVVM7IGkrKykgeworCQlpbnQgcGFja2FnZV9pbmRleDsKKwkJQ1BVX0lSUShpKSA9
IDA7CisJCWlmICghY3B1X29ubGluZShpKSkKKwkJCWNvbnRpbnVlOworCQlwYWNrYWdlX2luZGV4
ID0gQ1BVX1RPX1BBQ0tBR0VJTkRFWChpKTsKKwkJZm9yIChqID0gMDsgaiA8IE5SX0lSUVM7IGor
KykgeworCQkJdW5zaWduZWQgbG9uZyB2YWx1ZV9ub3csIGRlbHRhOworCQkJLyogSXMgdGhpcyBh
biBhY3RpdmUgSVJRPyAqLworCQkJaWYgKCFpcnFfZGVzY1tqXS5hY3Rpb24pCisJCQkJY29udGlu
dWU7CisJCQlpZiAocGFja2FnZV9pbmRleCA9PSBpKQorCQkJCUlSUV9ERUxUQShwYWNrYWdlX2lu
ZGV4LGopID0gMDsKKwkJCS8qIERldGVybWluZSB0aGUgdG90YWwgY291bnQgcGVyIHByb2Nlc3Nv
ciBwZXIgSVJRICovCisJCQl2YWx1ZV9ub3cgPSAodW5zaWduZWQgbG9uZykga3N0YXRfY3B1KGkp
LmlycXNbal07CisKKwkJCS8qIERldGVybWluZSB0aGUgYWN0aXZpdHkgcGVyIHByb2Nlc3NvciBw
ZXIgSVJRICovCisJCQlkZWx0YSA9IHZhbHVlX25vdyAtIExBU1RfQ1BVX0lSUShpLGopOworCisJ
CQkvKiBVcGRhdGUgbGFzdF9jcHVfaXJxW11bXSBmb3IgdGhlIG5leHQgdGltZSAqLworCQkJTEFT
VF9DUFVfSVJRKGksaikgPSB2YWx1ZV9ub3c7CisKKwkJCS8qIElnbm9yZSBJUlFzIHdob3NlIHJh
dGUgaXMgbGVzcyB0aGFuIHRoZSBjbG9jayAqLworCQkJaWYgKGRlbHRhIDwgdXNlZnVsX2xvYWRf
dGhyZXNob2xkKQorCQkJCWNvbnRpbnVlOworCQkJLyogdXBkYXRlIHRoZSBsb2FkIGZvciB0aGUg
cHJvY2Vzc29yIG9yIHBhY2thZ2UgdG90YWwgKi8KKwkJCUlSUV9ERUxUQShwYWNrYWdlX2luZGV4
LGopICs9IGRlbHRhOworCisJCQkvKiBLZWVwIHRyYWNrIG9mIHRoZSBoaWdoZXIgbnVtYmVyZWQg
c2libGluZyBhcyB3ZWxsICovCisJCQlpZiAoaSAhPSBwYWNrYWdlX2luZGV4KQorCQkJCUNQVV9J
UlEoaSkgKz0gZGVsdGE7CisJCQkvKgorCQkJICogV2UgaGF2ZSBzaWJsaW5nIEEgYW5kIHNpYmxp
bmcgQiBpbiB0aGUgcGFja2FnZQorCQkJICoKKwkJCSAqIGNwdV9pcnFbQV0gPSBsb2FkIGZvciBj
cHUgQSArIGxvYWQgZm9yIGNwdSBCCisJCQkgKiBjcHVfaXJxW0JdID0gbG9hZCBmb3IgY3B1IEIK
KwkJCSAqLworCQkJQ1BVX0lSUShwYWNrYWdlX2luZGV4KSArPSBkZWx0YTsKKwkJfQorCX0KKwkv
KiBGaW5kIHRoZSBsZWFzdCBsb2FkZWQgcHJvY2Vzc29yIHBhY2thZ2UgKi8KKwlmb3IgKGkgPSAw
OyBpIDwgTlJfQ1BVUzsgaSsrKSB7CisJCWlmICghY3B1X29ubGluZShpKSkKKwkJCWNvbnRpbnVl
OworCQlpZiAocGh5c2ljYWxfYmFsYW5jZSAmJiBpID4gY3B1X3NpYmxpbmdfbWFwW2ldKQorCQkJ
Y29udGludWU7CisJCWlmIChtaW5fY3B1X2lycSA+IENQVV9JUlEoaSkpIHsKKwkJCW1pbl9jcHVf
aXJxID0gQ1BVX0lSUShpKTsKKwkJCW1pbl9sb2FkZWQgPSBpOworCQl9CisJfQorCW1heF9jcHVf
aXJxID0gVUxPTkdfTUFYOworCit0cnlhbm90aGVyY3B1OgorCS8qIExvb2sgZm9yIGhlYXZpZXN0
IGxvYWRlZCBwcm9jZXNzb3IuCisJICogV2UgbWF5IGNvbWUgYmFjayB0byBnZXQgdGhlIG5leHQg
aGVhdmllc3QgbG9hZGVkIHByb2Nlc3Nvci4KKwkgKiBTa2lwIHByb2Nlc3NvcnMgd2l0aCB0cml2
aWFsIGxvYWRzLgorCSAqLworCXRtcF9jcHVfaXJxID0gMDsKKwl0bXBfbG9hZGVkID0gLTE7CisJ
Zm9yIChpID0gMDsgaSA8IE5SX0NQVVM7IGkrKykgeworCQlpZiAoIWNwdV9vbmxpbmUoaSkpCisJ
CQljb250aW51ZTsKKwkJaWYgKHBoeXNpY2FsX2JhbGFuY2UgJiYgaSA+IGNwdV9zaWJsaW5nX21h
cFtpXSkKKwkJCWNvbnRpbnVlOworCQlpZiAobWF4X2NwdV9pcnEgPD0gQ1BVX0lSUShpKSkgCisJ
CQljb250aW51ZTsKKwkJaWYgKHRtcF9jcHVfaXJxIDwgQ1BVX0lSUShpKSkgeworCQkJdG1wX2Nw
dV9pcnEgPSBDUFVfSVJRKGkpOworCQkJdG1wX2xvYWRlZCA9IGk7CisJCX0KKwl9CisKKwlpZiAo
dG1wX2xvYWRlZCA9PSAtMSkgeworIAkgLyogSW4gdGhlIGNhc2Ugb2Ygc21hbGwgbnVtYmVyIG9m
IGhlYXZ5IGludGVycnVwdCBzb3VyY2VzLCAKKwkgICogbG9hZGluZyBzb21lIG9mIHRoZSBjcHVz
IHRvbyBtdWNoLiBXZSB1c2UgSW5nbydzIG9yaWdpbmFsIAorCSAgKiBhcHByb2FjaCB0byByb3Rh
dGUgdGhlbSBhcm91bmQuCisJICAqLworCQlpZiAoIWZpcnN0X2F0dGVtcHQgJiYgaW1iYWxhbmNl
ID49IHVzZWZ1bF9sb2FkX3RocmVzaG9sZCkgeworCQkJcm90YXRlX2lycXNfYW1vbmdfY3B1cyh1
c2VmdWxfbG9hZF90aHJlc2hvbGQpOworCQkJcmV0dXJuOworCQl9CisJCWdvdG8gbm90X3dvcnRo
X3RoZV9lZmZvcnQ7CisJfQorCQorCWZpcnN0X2F0dGVtcHQgPSAwOwkJLyogaGVhdmllc3Qgc2Vh
cmNoICovCisJbWF4X2NwdV9pcnEgPSB0bXBfY3B1X2lycTsJLyogbG9hZCAqLworCW1heF9sb2Fk
ZWQgPSB0bXBfbG9hZGVkOwkvKiBwcm9jZXNzb3IgKi8KKwlpbWJhbGFuY2UgPSAobWF4X2NwdV9p
cnEgLSBtaW5fY3B1X2lycSkgLyAyOworCQorCURwcmludGsoIm1heF9sb2FkZWQgY3B1ID0gJWRc
biIsIG1heF9sb2FkZWQpOworCURwcmludGsoIm1pbl9sb2FkZWQgY3B1ID0gJWRcbiIsIG1pbl9s
b2FkZWQpOworCURwcmludGsoIm1heF9jcHVfaXJxIGxvYWQgPSAlbGRcbiIsIG1heF9jcHVfaXJx
KTsKKwlEcHJpbnRrKCJtaW5fY3B1X2lycSBsb2FkID0gJWxkXG4iLCBtaW5fY3B1X2lycSk7CisJ
RHByaW50aygibG9hZCBpbWJhbGFuY2UgPSAlbHVcbiIsIGltYmFsYW5jZSk7CisKKwkvKiBpZiBp
bWJhbGFuY2UgaXMgbGVzcyB0aGFuIGFwcHJveCAxMCUgb2YgbWF4IGxvYWQsIHRoZW4KKwkgKiBv
YnNlcnZlIGRpbWluaXNoaW5nIHJldHVybnMgYWN0aW9uLiAtIHF1aXQKKwkgKi8KKwlpZiAoaW1i
YWxhbmNlIDwgKG1heF9jcHVfaXJxID4+IDMpKSB7CisJCURwcmludGsoIkltYmFsYW5jZSB0b28g
dHJpdmlhbFxuIik7CisJCWdvdG8gbm90X3dvcnRoX3RoZV9lZmZvcnQ7CisJfQorCit0cnlhbm90
aGVyaXJxOgorCS8qIGlmIHdlIHNlbGVjdCBhbiBJUlEgdG8gbW92ZSB0aGF0IGNhbid0IGdvIHdo
ZXJlIHdlIHdhbnQsIHRoZW4KKwkgKiBzZWUgaWYgdGhlcmUgaXMgYW5vdGhlciBvbmUgdG8gdHJ5
LgorCSAqLworCW1vdmVfdGhpc19sb2FkID0gMDsKKwlzZWxlY3RlZF9pcnEgPSAtMTsKKwlmb3Ig
KGogPSAwOyBqIDwgTlJfSVJRUzsgaisrKSB7CisJCS8qIElzIHRoaXMgYW4gYWN0aXZlIElSUT8g
Ki8KKwkJaWYgKCFpcnFfZGVzY1tqXS5hY3Rpb24pCisJCQljb250aW51ZTsKKwkJaWYgKGltYmFs
YW5jZSA8PSBJUlFfREVMVEEobWF4X2xvYWRlZCxqKSkKKwkJCWNvbnRpbnVlOworCQkvKiBUcnkg
dG8gZmluZCB0aGUgSVJRIHRoYXQgaXMgY2xvc2VzdCB0byB0aGUgaW1iYWxhbmNlCisJCSAqIHdp
dGhvdXQgZ29pbmcgb3Zlci4KKwkJICovCisJCWlmIChtb3ZlX3RoaXNfbG9hZCA8IElSUV9ERUxU
QShtYXhfbG9hZGVkLGopKSB7CisJCQltb3ZlX3RoaXNfbG9hZCA9IElSUV9ERUxUQShtYXhfbG9h
ZGVkLGopOworCQkJc2VsZWN0ZWRfaXJxID0gajsKKwkJfQorCX0KKwlpZiAoc2VsZWN0ZWRfaXJx
ID09IC0xKSB7CisJCWdvdG8gdHJ5YW5vdGhlcmNwdTsKKwl9CiAKLSNkZWZpbmUgSVJRX0JBTEFO
Q0VfSU5URVJWQUwgKEhaLzUwKQorCWltYmFsYW5jZSA9IG1vdmVfdGhpc19sb2FkOwogCQorCS8q
IEZvciBwaHlzaWNhbF9iYWxhbmNlIGNhc2UsIHdlIGFjY3VtbGF0ZWQgYm90aCBsb2FkCisJICog
dmFsdWVzIGluIHRoZSBvbmUgb2YgdGhlIHNpYmxpbmdzIGNwdV9pcnFbXSwKKwkgKiB0byB1c2Ug
dGhlIHNhbWUgY29kZSBmb3IgcGh5c2ljYWwgYW5kIGxvZ2ljYWwgcHJvY2Vzc29ycworCSAqIGFz
IG11Y2ggYXMgcG9zc2libGUuIAorCSAqCisJICogTk9URTogdGhlIGNwdV9pcnFbXSBhcnJheSBo
b2xkcyB0aGUgc3VtIG9mIHRoZSBsb2FkIGZvcgorCSAqIHNpYmxpbmcgQSBhbmQgc2libGluZyBC
IGluIHRoZSBzbG90IGZvciB0aGUgbG93ZXN0IG51bWJlcmVkCisJICogc2libGluZyAoQSksIF9B
TkRfIHRoZSBsb2FkIGZvciBzaWJsaW5nIEIgaW4gdGhlIHNsb3QgZm9yCisJICogdGhlIGhpZ2hl
ciBudW1iZXJlZCBzaWJsaW5nLgorCSAqCisJICogV2Ugc2VlayB0aGUgbGVhc3QgbG9hZGVkIHNp
YmxpbmcgYnkgbWFraW5nIHRoZSBjb21wYXJpc29uCisJICogKEErQikvMiB2cyBCCisJICovCisJ
aWYgKHBoeXNpY2FsX2JhbGFuY2UgJiYgKENQVV9JUlEobWluX2xvYWRlZCkgPj4gMSkgPiBDUFVf
SVJRKGNwdV9zaWJsaW5nX21hcFttaW5fbG9hZGVkXSkpCisJCW1pbl9sb2FkZWQgPSBjcHVfc2li
bGluZ19tYXBbbWluX2xvYWRlZF07CisKKwlhbGxvd2VkX21hc2sgPSBjcHVfb25saW5lX21hcCAm
IGlycV9hZmZpbml0eVtzZWxlY3RlZF9pcnFdOworCXRhcmdldF9jcHVfbWFzayA9IDEgPDwgbWlu
X2xvYWRlZDsKKworCWlmICh0YXJnZXRfY3B1X21hc2sgJiBhbGxvd2VkX21hc2spIHsKKwkJaXJx
X2Rlc2NfdCAqZGVzYyA9IGlycV9kZXNjICsgc2VsZWN0ZWRfaXJxOworCQlEcHJpbnRrKCJpcnEg
PSAlZCBtb3ZlZCB0byBjcHUgPSAlZFxuIiwgc2VsZWN0ZWRfaXJxLCBtaW5fbG9hZGVkKTsKKwkJ
LyogbWFyayBmb3IgY2hhbmdlIGRlc3RpbmF0aW9uICovCisJCXNwaW5fbG9jaygmZGVzYy0+bG9j
ayk7CisJCWlycV9iYWxhbmNlX21hc2tbc2VsZWN0ZWRfaXJxXSA9IHRhcmdldF9jcHVfbWFzazsK
KwkJc3Bpbl91bmxvY2soJmRlc2MtPmxvY2spOworCQkvKiBTaW5jZSB3ZSBtYWRlIGEgY2hhbmdl
LCBjb21lIGJhY2sgc29vbmVyIHRvIAorCQkgKiBjaGVjayBmb3IgbW9yZSB2YXJpYXRpb24uCisJ
CSAqLworCQliYWxhbmNlZF9pcnFfaW50ZXJ2YWwgPSBNQVgoTUlOX0JBTEFOQ0VEX0lSUV9JTlRF
UlZBTCwKKwkJCWJhbGFuY2VkX2lycV9pbnRlcnZhbCAtIEJBTEFOQ0VEX0lSUV9MRVNTX0RFTFRB
KTsJCisJCXJldHVybjsKKwl9CisJZ290byB0cnlhbm90aGVyaXJxOworCitub3Rfd29ydGhfdGhl
X2VmZm9ydDoKKwkvKiBpZiB3ZSBkaWQgbm90IGZpbmQgYW4gSVJRIHRvIG1vdmUsIHRoZW4gYWRq
dXN0IHRoZSB0aW1lIGludGVydmFsIHVwd2FyZCAqLworCWJhbGFuY2VkX2lycV9pbnRlcnZhbCA9
IE1JTihNQVhfQkFMQU5DRURfSVJRX0lOVEVSVkFMLAorCQliYWxhbmNlZF9pcnFfaW50ZXJ2YWwg
KyBCQUxBTkNFRF9JUlFfTU9SRV9ERUxUQSk7CQorCURwcmludGsoIklSUSB3b3J0aCByb3RhdGlu
ZyBub3QgZm91bmRcbiIpOworCXJldHVybjsKK30KKwogc3RhdGljIHVuc2lnbmVkIGxvbmcgbW92
ZShpbnQgY3Vycl9jcHUsIHVuc2lnbmVkIGxvbmcgYWxsb3dlZF9tYXNrLCB1bnNpZ25lZCBsb25n
IG5vdywgaW50IGRpcmVjdGlvbikKIHsKIAlpbnQgc2VhcmNoX2lkbGUgPSAxOwpAQCAtMjU2LDM0
ICs0ODgsMTEyIEBACiAJcmV0dXJuIGNwdTsKIH0KIAotc3RhdGljIGlubGluZSB2b2lkIGJhbGFu
Y2VfaXJxKGludCBpcnEpCitzdGF0aWMgaW5saW5lIHZvaWQgYmFsYW5jZV9pcnEgKGludCBjcHUs
IGludCBpcnEpCiB7Ci0JaXJxX2JhbGFuY2VfdCAqZW50cnkgPSBpcnFfYmFsYW5jZSArIGlycTsK
IAl1bnNpZ25lZCBsb25nIG5vdyA9IGppZmZpZXM7Ci0KKwl1bnNpZ25lZCBsb25nIGFsbG93ZWRf
bWFzazsKKwl1bnNpZ25lZCBpbnQgbmV3X2NwdTsKKwkJCiAJaWYgKGNsdXN0ZXJlZF9hcGljX21v
ZGUpCiAJCXJldHVybjsKIAotCWlmICh1bmxpa2VseSh0aW1lX2FmdGVyKG5vdywgZW50cnktPnRp
bWVzdGFtcCArIElSUV9CQUxBTkNFX0lOVEVSVkFMKSkpIHsKLQkJdW5zaWduZWQgbG9uZyBhbGxv
d2VkX21hc2s7Ci0JCXVuc2lnbmVkIGludCBuZXdfY3B1OwotCQlpbnQgcmFuZG9tX251bWJlcjsK
LQotCQlyZHRzY2wocmFuZG9tX251bWJlcik7Ci0JCXJhbmRvbV9udW1iZXIgJj0gMTsKLQotCQlh
bGxvd2VkX21hc2sgPSBjcHVfb25saW5lX21hcCAmIGlycV9hZmZpbml0eVtpcnFdOwotCQllbnRy
eS0+dGltZXN0YW1wID0gbm93OwotCQluZXdfY3B1ID0gbW92ZShlbnRyeS0+Y3B1LCBhbGxvd2Vk
X21hc2ssIG5vdywgcmFuZG9tX251bWJlcik7Ci0JCWlmIChlbnRyeS0+Y3B1ICE9IG5ld19jcHUp
IHsKLQkJCWVudHJ5LT5jcHUgPSBuZXdfY3B1OwotCQkJc2V0X2lvYXBpY19hZmZpbml0eShpcnEs
IDEgPDwgbmV3X2NwdSk7CisJYWxsb3dlZF9tYXNrID0gY3B1X29ubGluZV9tYXAgJiBpcnFfYWZm
aW5pdHlbaXJxXTsKKwluZXdfY3B1ID0gbW92ZShjcHUsIGFsbG93ZWRfbWFzaywgbm93LCAxKTsK
KwlpZiAoY3B1ICE9IG5ld19jcHUpIHsKKwkJaXJxX2Rlc2NfdCAqZGVzYyA9IGlycV9kZXNjICsg
aXJxOworCQlzcGluX2xvY2soJmRlc2MtPmxvY2spOworCQlpcnFfYmFsYW5jZV9tYXNrW2lycV0g
PSAxIDw8IG5ld19jcHU7CisJCXNwaW5fdW5sb2NrKCZkZXNjLT5sb2NrKTsKKwl9Cit9CisKK2lu
dCBiYWxhbmNlZF9pcnEodm9pZCAqdW51c2VkKQoreworCWludCBpOworCXVuc2lnbmVkIGxvbmcg
cHJldl9iYWxhbmNlX3RpbWUgPSBqaWZmaWVzOworCWxvbmcgdGltZV9yZW1haW5pbmcgPSBiYWxh
bmNlZF9pcnFfaW50ZXJ2YWw7CisJZGFlbW9uaXplKCk7CisJc2lnZmlsbHNldCgmY3VycmVudC0+
YmxvY2tlZCk7CisJc3ByaW50ZihjdXJyZW50LT5jb21tLCAiYmFsYW5jZWRfaXJxIik7CisJCisJ
LyogcHVzaCBldmVyeXRoaW5nIHRvIENQVSAwIHRvIGdpdmUgdXMgYSBzdGFydGluZyBwb2ludC4g
ICovCisJZm9yIChpID0gMCA7IGkgPCBOUl9JUlFTIDsgaSsrKQorCQlpcnFfYmFsYW5jZV9tYXNr
W2ldID0gMSA8PCAwOworCWZvciAoOzspIHsKKwkJc2V0X2N1cnJlbnRfc3RhdGUoVEFTS19JTlRF
UlJVUFRJQkxFKTsKKwkJdGltZV9yZW1haW5pbmcgPSBzY2hlZHVsZV90aW1lb3V0KHRpbWVfcmVt
YWluaW5nKTsKKwkJaWYgKHRpbWVfYWZ0ZXIoamlmZmllcywgcHJldl9iYWxhbmNlX3RpbWUrYmFs
YW5jZWRfaXJxX2ludGVydmFsKSkgeworCQkJRHByaW50aygiYmFsYW5jZWRfaXJxOiBjYWxsaW5n
IGRvX2lycV9iYWxhbmNlKCkgJWx1XG4iLCBqaWZmaWVzKTsKKwkJCWRvX2lycV9iYWxhbmNlKCk7
CisJCQlwcmV2X2JhbGFuY2VfdGltZSA9IGppZmZpZXM7CisJCQl0aW1lX3JlbWFpbmluZyA9IGJh
bGFuY2VkX2lycV9pbnRlcnZhbDsKIAkJfQorICAgICAgICB9Cit9CisKK3N0YXRpYyBpbnQgX19p
bml0IGJhbGFuY2VkX2lycV9pbml0KHZvaWQpCit7CisJaW50IGk7CisJc3RydWN0IGNwdWluZm9f
eDg2ICpjOworICAgICAgICBjID0gJmJvb3RfY3B1X2RhdGE7CisJaWYgKGlycWJhbGFuY2VfZGlz
YWJsZWQpCisJCXJldHVybiAwOworCS8qIEVuYWJsZSBwaHlzaWNhbCBiYWxhbmNlIG9ubHkgaWYg
bW9yZSB0aGFuIAorCSAqIG9uZSBwaHlzaWNhbCBwcm9jZXNzb3IgcGFja2FnZSBpcyBwcmVzZW50
ICovCisJaWYgKHNtcF9udW1fc2libGluZ3MgPiAxICYmIGNwdV9vbmxpbmVfbWFwID4+IDIpCisJ
CXBoeXNpY2FsX2JhbGFuY2UgPSAxOworCisJZm9yIChpID0gMDsgaSA8IE5SX0NQVVM7IGkrKykg
eworCQlpZiAoIWNwdV9vbmxpbmUoaSkpCisJCQljb250aW51ZTsKKwkJaXJxX2NwdV9kYXRhW2ld
LmlycV9kZWx0YSA9IGttYWxsb2Moc2l6ZW9mKHVuc2lnbmVkIGxvbmcpICogTlJfSVJRUywgR0ZQ
X0tFUk5FTCk7CisJCWlycV9jcHVfZGF0YVtpXS5sYXN0X2lycSA9IGttYWxsb2Moc2l6ZW9mKHVu
c2lnbmVkIGxvbmcpICogTlJfSVJRUywgR0ZQX0tFUk5FTCk7CisJCWlmIChpcnFfY3B1X2RhdGFb
aV0uaXJxX2RlbHRhID09IE5VTEwgfHwgaXJxX2NwdV9kYXRhW2ldLmxhc3RfaXJxID09IE5VTEwp
IHsKKwkJCXByaW50ayhLRVJOX0VSUiAiYmFsYW5jZWRfaXJxX2luaXQ6IG91dCBvZiBtZW1vcnki
KTsKKwkJCWdvdG8gZmFpbGVkOworCQl9CisJCW1lbXNldChpcnFfY3B1X2RhdGFbaV0uaXJxX2Rl
bHRhLDAsc2l6ZW9mKHVuc2lnbmVkIGxvbmcpICogTlJfSVJRUyk7CisJCW1lbXNldChpcnFfY3B1
X2RhdGFbaV0ubGFzdF9pcnEsMCxzaXplb2YodW5zaWduZWQgbG9uZykgKiBOUl9JUlFTKTsKKwl9
CisJCisJcHJpbnRrKEtFUk5fSU5GTyAiU3RhcnRpbmcgYmFsYW5jZWRfaXJxXG4iKTsKKwlpZiAo
a2VybmVsX3RocmVhZChiYWxhbmNlZF9pcnEsIE5VTEwsIENMT05FX0tFUk5FTCkgPj0gMCkgCisJ
CXJldHVybiAwOworCWVsc2UgCisJCXByaW50ayhLRVJOX0VSUiAiYmFsYW5jZWRfaXJxX2luaXQ6
IGZhaWxlZCB0byBzcGF3biBiYWxhbmNlZF9pcnEiKTsKK2ZhaWxlZDoKKwlmb3IgKGkgPSAwOyBp
IDwgTlJfQ1BVUzsgaSsrKSB7CisJCWlmIChpcnFfY3B1X2RhdGFbaV0uaXJxX2RlbHRhKQorCQkJ
a2ZyZWUoaXJxX2NwdV9kYXRhW2ldLmlycV9kZWx0YSk7CisJCWlmIChpcnFfY3B1X2RhdGFbaV0u
bGFzdF9pcnEpCisJCQlrZnJlZShpcnFfY3B1X2RhdGFbaV0ubGFzdF9pcnEpOwogCX0KKwlyZXR1
cm4gMDsKIH0KLSNlbHNlIC8qICFTTVAgKi8KLXN0YXRpYyBpbmxpbmUgdm9pZCBiYWxhbmNlX2ly
cShpbnQgaXJxKSB7IH0KLSNlbmRpZgorCitzdGF0aWMgaW50IF9faW5pdCBpcnFiYWxhbmNlX2Rp
c2FibGUoY2hhciAqc3RyKQoreworCWlycWJhbGFuY2VfZGlzYWJsZWQgPSAxOworCXJldHVybiAw
OworfQorCitfX3NldHVwKCJub2lycWJhbGFuY2UiLCBpcnFiYWxhbmNlX2Rpc2FibGUpOworCitz
dGF0aWMgdm9pZCBzZXRfaW9hcGljX2FmZmluaXR5ICh1bnNpZ25lZCBpbnQgaXJxLCB1bnNpZ25l
ZCBsb25nIG1hc2spOworCitzdGF0aWMgaW5saW5lIHZvaWQgbW92ZV9pcnEoaW50IGlycSkKK3sK
KwkvKiBub3RlIC0gd2UgaG9sZCB0aGUgZGVzYy0+bG9jayAqLworCWlmICh1bmxpa2VseShpcnFf
YmFsYW5jZV9tYXNrW2lycV0pKSB7CisJCXNldF9pb2FwaWNfYWZmaW5pdHkoaXJxLCBpcnFfYmFs
YW5jZV9tYXNrW2lycV0pOworCQlpcnFfYmFsYW5jZV9tYXNrW2lycV0gPSAwOworCX0KK30KKwor
X19pbml0Y2FsbChiYWxhbmNlZF9pcnFfaW5pdCk7CisKKyNlbmRpZiAvKiBkZWZpbmVkKENPTkZJ
R19TTVApICovCisKIAogLyoKICAqIHN1cHBvcnQgZm9yIGJyb2tlbiBNUCBCSU9TcywgZW5hYmxl
cyBoYW5kLXJlZGlyZWN0aW9uIG9mIFBJUlEwLTcgdG8KQEAgLTEzMDgsNyArMTYxOCw3IEBACiAg
Ki8KIHN0YXRpYyB2b2lkIGFja19lZGdlX2lvYXBpY19pcnEodW5zaWduZWQgaW50IGlycSkKIHsK
LQliYWxhbmNlX2lycShpcnEpOworCW1vdmVfaXJxKGlycSk7CiAJaWYgKChpcnFfZGVzY1tpcnFd
LnN0YXR1cyAmIChJUlFfUEVORElORyB8IElSUV9ESVNBQkxFRCkpCiAJCQkJCT09IChJUlFfUEVO
RElORyB8IElSUV9ESVNBQkxFRCkpCiAJCW1hc2tfSU9fQVBJQ19pcnEoaXJxKTsKQEAgLTEzNDgs
NyArMTY1OCw3IEBACiAJdW5zaWduZWQgbG9uZyB2OwogCWludCBpOwogCi0JYmFsYW5jZV9pcnEo
aXJxKTsKKwltb3ZlX2lycShpcnEpOwogLyoKICAqIEl0IGFwcGVhcnMgdGhlcmUgaXMgYW4gZXJy
YXR1bSB3aGljaCBhZmZlY3RzIGF0IGxlYXN0IHZlcnNpb24gMHgxMQogICogb2YgSS9PIEFQSUMg
KHRoYXQncyB0aGUgODIwOTNBQSBhbmQgY29yZXMgaW50ZWdyYXRlZCBpbnRvIHZhcmlvdXMK

------_=_NextPart_001_01C2B6C1.0DE8A962--
