Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbTAPVBR>; Thu, 16 Jan 2003 16:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbTAPVBR>; Thu, 16 Jan 2003 16:01:17 -0500
Received: from fmr02.intel.com ([192.55.52.25]:41208 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267260AbTAPVAC>; Thu, 16 Jan 2003 16:00:02 -0500
content-class: urn:content-classes:message
Subject: [PATCH][2.5] IRQ distribution patch for 2.5.58
Date: Thu, 16 Jan 2003 13:08:55 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DA5CE8D@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C2BDA3.7AC98913"
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.5] IRQ distribution patch for 2.5.58
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK9o3nrtVA40XeoTu+1yP4e2TZSTA==
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 16 Jan 2003 21:08:56.0216 (UTC) FILETIME=[7B161980:01C2BDA3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C2BDA3.7AC98913
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Linus,
=A0 This patch improves Linux kernel performance with heavy interrupts =
load on IA32 systems, also incorporates Hyper-Threading awareness in the =
IRQ distribution.
=A0 I have rebased the patch for 2.5.58 kernel, with minor changes for =
the comments I received from Greg KH on LKML.
=A0
The performance change results collected and received with validation so =
far:
4xP4 Xeon with HT =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : netperf : =
+12%
4xP4 Xeon with HT on IBM Summit : NetBench: +5%
4xp6 system=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
: netperf : +2%
=A0
Please add it in the 2.5.* kernel tree.
=A0
Thanks & Regards,
Nitin
=A0
=A0diff -Naru 2.5.58/arch/i386/kernel/io_apic.c =
kirq/arch/i386/kernel/io_apic.c
--- 2.5.58/arch/i386/kernel/io_apic.c	2003-01-13 21:58:29.000000000 =
-0800
+++ kirq/arch/i386/kernel/io_apic.c	2003-01-15 18:32:44.000000000 -0800
@@ -207,19 +207,34 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
-#if CONFIG_SMP
-
-typedef struct {
-	unsigned int cpu;
-	unsigned long timestamp;
-} ____cacheline_aligned irq_balance_t;
-
-static irq_balance_t irq_balance[NR_IRQS] __cacheline_aligned
-			=3D { [ 0 ... NR_IRQS-1 ] =3D { 0, 0 } };
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
@@ -227,10 +242,224 @@
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
+long balanced_irq_interval =3D MAX_BALANCED_IRQ_INTERVAL;
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
+	balanced_irq_interval =3D max((long)MIN_BALANCED_IRQ_INTERVAL,
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
+			if ( package_index =3D=3D i )
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
+		balanced_irq_interval =3D max((long)MIN_BALANCED_IRQ_INTERVAL,
+			balanced_irq_interval - BALANCED_IRQ_LESS_DELTA);=09
+		return;
+	}
+	goto tryanotherirq;
+
+not_worth_the_effort:
+	/* if we did not find an IRQ to move, then adjust the time interval =
upward */
+	balanced_irq_interval =3D min((long)MAX_BALANCED_IRQ_INTERVAL,
+		balanced_irq_interval + BALANCED_IRQ_MORE_DELTA);=09
+	Dprintk("IRQ worth rotating not found\n");
+	return;
+}
+
 static unsigned long move(int curr_cpu, unsigned long allowed_mask, =
unsigned long now, int direction)
 {
 	int search_idle =3D 1;
@@ -257,34 +486,111 @@
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
 	if (no_balance_irq)
 		return;
=20
-	if (unlikely(time_after(now, entry->timestamp + =
IRQ_BALANCE_INTERVAL))) {
-		unsigned long allowed_mask;
-		unsigned int new_cpu;
-		int random_number;
+	allowed_mask =3D cpu_online_map & irq_affinity[irq];
+	new_cpu =3D move(cpu, allowed_mask, now, 1);
+	if (cpu !=3D new_cpu) {
+		irq_desc_t *desc =3D irq_desc + irq;
+		spin_lock(&desc->lock);
+		irq_balance_mask[irq] =3D 1 << new_cpu;
+		spin_unlock(&desc->lock);
+	}
+}
=20
-		rdtscl(random_number);
-		random_number &=3D 1;
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
+		}
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
+	/* Enable physical balance only if more than 1 physical processor is =
present */
+	if (smp_num_siblings > 1 && cpu_online_map >> 2)
+		physical_balance =3D 1;
=20
-		allowed_mask =3D cpu_online_map & irq_affinity[irq];
-		entry->timestamp =3D now;
-		new_cpu =3D move(entry->cpu, allowed_mask, now, random_number);
-		if (entry->cpu !=3D new_cpu) {
-			entry->cpu =3D new_cpu;
-			set_ioapic_affinity(irq, 1 << new_cpu);
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
 		}
+		memset(irq_cpu_data[i].irq_delta,0,sizeof(unsigned long) * NR_IRQS);
+		memset(irq_cpu_data[i].last_irq,0,sizeof(unsigned long) * NR_IRQS);
 	}
+=09
+	printk(KERN_INFO "Starting balanced_irq\n");
+	if (kernel_thread(balanced_irq, NULL, CLONE_KERNEL) >=3D 0)=20
+		return 0;
+	else=20
+		printk(KERN_ERR "balanced_irq_init: failed to spawn balanced_irq");
+failed:
+	for (i =3D 0; i < NR_CPUS; i++) {
+		if(irq_cpu_data[i].irq_delta)
+			kfree(irq_cpu_data[i].irq_delta);
+		if(irq_cpu_data[i].last_irq)
+			kfree(irq_cpu_data[i].last_irq);
+	}
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
@@ -1307,7 +1613,7 @@
  */
 static void ack_edge_ioapic_irq(unsigned int irq)
 {
-	balance_irq(irq);
+	move_irq(irq);
 	if ((irq_desc[irq].status & (IRQ_PENDING | IRQ_DISABLED))
 					=3D=3D (IRQ_PENDING | IRQ_DISABLED))
 		mask_IO_APIC_irq(irq);
@@ -1347,7 +1653,7 @@
 	unsigned long v;
 	int i;
=20
-	balance_irq(irq);
+	move_irq(irq);
 /*
  * It appears there is an erratum which affects at least version 0x11
  * of I/O APIC (that's the 82093AA and cores integrated into various
diff -Naru 2.5.58/Documentation/kernel-parameters.txt =
kirq/Documentation/kernel-parameters.txt
--- 2.5.58/Documentation/kernel-parameters.txt	2003-01-13 =
21:59:35.000000000 -0800
+++ kirq/Documentation/kernel-parameters.txt	2003-01-14 =
16:18:41.000000000 -0800
@@ -352,6 +352,8 @@
=20
 	hugepages=3D	[HW,IA-32] Maximal number of HugeTLB pages
=20
+	noirqbalance	[IA-32,SMP,KNL] Disable kernel irq balancing
+
 	i8042_direct	[HW] Non-translated mode
 	i8042_dumbkbd
 	i8042_noaux

------_=_NextPart_001_01C2BDA3.7AC98913
Content-Type: application/octet-stream;
	name="kirq_2.5.58.patch"
Content-Transfer-Encoding: base64
Content-Description: kirq_2.5.58.patch
Content-Disposition: attachment;
	filename="kirq_2.5.58.patch"

ZGlmZiAtTmFydSAyLjUuNTgvYXJjaC9pMzg2L2tlcm5lbC9pb19hcGljLmMga2lycS9hcmNoL2kz
ODYva2VybmVsL2lvX2FwaWMuYwotLS0gMi41LjU4L2FyY2gvaTM4Ni9rZXJuZWwvaW9fYXBpYy5j
CTIwMDMtMDEtMTMgMjE6NTg6MjkuMDAwMDAwMDAwIC0wODAwCisrKyBraXJxL2FyY2gvaTM4Ni9r
ZXJuZWwvaW9fYXBpYy5jCTIwMDMtMDEtMTUgMTg6MzI6NDQuMDAwMDAwMDAwIC0wODAwCkBAIC0y
MDcsMTkgKzIwNywzNCBAQAogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmlvYXBpY19sb2NrLCBm
bGFncyk7CiB9CiAKLSNpZiBDT05GSUdfU01QCi0KLXR5cGVkZWYgc3RydWN0IHsKLQl1bnNpZ25l
ZCBpbnQgY3B1OwotCXVuc2lnbmVkIGxvbmcgdGltZXN0YW1wOwotfSBfX19fY2FjaGVsaW5lX2Fs
aWduZWQgaXJxX2JhbGFuY2VfdDsKLQotc3RhdGljIGlycV9iYWxhbmNlX3QgaXJxX2JhbGFuY2Vb
TlJfSVJRU10gX19jYWNoZWxpbmVfYWxpZ25lZAotCQkJPSB7IFsgMCAuLi4gTlJfSVJRUy0xIF0g
PSB7IDAsIDAgfSB9OworI2lmIGRlZmluZWQoQ09ORklHX1NNUCkKKyMgaW5jbHVkZSA8YXNtL3By
b2Nlc3Nvci5oPgkvKiBrZXJuZWxfdGhyZWFkKCkgKi8KKyMgaW5jbHVkZSA8bGludXgva2VybmVs
X3N0YXQuaD4JLyoga3N0YXQgKi8KKyMgaW5jbHVkZSA8bGludXgvc2xhYi5oPgkJLyoga21hbGxv
YygpICovCisjIGluY2x1ZGUgPGxpbnV4L3RpbWVyLmg+CS8qIHRpbWVfYWZ0ZXIoKSAqLworIAor
IyBpZiBDT05GSUdfQkFMQU5DRURfSVJRX0RFQlVHCisjICBkZWZpbmUgVERwcmludGsoeC4uLikg
ZG8geyBwcmludGsoIjwlbGQ6JXM6JWQ+OiAiLCBqaWZmaWVzLCBfX0ZJTEVfXywgX19MSU5FX18p
OyBwcmludGsoeCk7IH0gd2hpbGUgKDApCisjICBkZWZpbmUgRHByaW50ayh4Li4uKSBkbyB7IFRE
cHJpbnRrKHgpOyB9IHdoaWxlICgwKQorIyBlbHNlCisjICBkZWZpbmUgVERwcmludGsoeC4uLikg
CisjICBkZWZpbmUgRHByaW50ayh4Li4uKSAKKyMgZW5kaWYKIAogZXh0ZXJuIHVuc2lnbmVkIGxv
bmcgaXJxX2FmZmluaXR5IFtOUl9JUlFTXTsKLQotI2VuZGlmCit1bnNpZ25lZCBsb25nIF9fY2Fj
aGVsaW5lX2FsaWduZWQgaXJxX2JhbGFuY2VfbWFzayBbTlJfSVJRU107CitzdGF0aWMgaW50IGly
cWJhbGFuY2VfZGlzYWJsZWQgX19pbml0ZGF0YSA9IDA7CitzdGF0aWMgaW50IHBoeXNpY2FsX2Jh
bGFuY2UgPSAwOworCitzdHJ1Y3QgaXJxX2NwdV9pbmZvIHsKKwl1bnNpZ25lZCBsb25nICogbGFz
dF9pcnE7CisJdW5zaWduZWQgbG9uZyAqIGlycV9kZWx0YTsKKwl1bnNpZ25lZCBsb25nIGlycTsK
K30gaXJxX2NwdV9kYXRhW05SX0NQVVNdOworCisjZGVmaW5lIENQVV9JUlEoY3B1KQkJKGlycV9j
cHVfZGF0YVtjcHVdLmlycSkKKyNkZWZpbmUgTEFTVF9DUFVfSVJRKGNwdSxpcnEpICAgKGlycV9j
cHVfZGF0YVtjcHVdLmxhc3RfaXJxW2lycV0pCisjZGVmaW5lIElSUV9ERUxUQShjcHUsaXJxKSAJ
KGlycV9jcHVfZGF0YVtjcHVdLmlycV9kZWx0YVtpcnFdKQogCiAjZGVmaW5lIElETEVfRU5PVUdI
KGNwdSxub3cpIFwKIAkJKGlkbGVfY3B1KGNwdSkgJiYgKChub3cpIC0gaXJxX3N0YXRbKGNwdSld
LmlkbGVfdGltZXN0YW1wID4gMSkpCkBAIC0yMjcsMTAgKzI0MiwyMjQgQEAKICNkZWZpbmUgSVJR
X0FMTE9XRUQoY3B1LGFsbG93ZWRfbWFzaykgXAogCQkoKDEgPDwgY3B1KSAmIChhbGxvd2VkX21h
c2spKQogCi0jaWYgQ09ORklHX1NNUAorI2RlZmluZSBDUFVfVE9fUEFDS0FHRUlOREVYKGkpIFwK
KwkJKChwaHlzaWNhbF9iYWxhbmNlICYmIGkgPiBjcHVfc2libGluZ19tYXBbaV0pID8gY3B1X3Np
YmxpbmdfbWFwW2ldIDogaSkKKworI2RlZmluZSBNQVhfQkFMQU5DRURfSVJRX0lOVEVSVkFMCSg1
KkhaKQorI2RlZmluZSBNSU5fQkFMQU5DRURfSVJRX0lOVEVSVkFMCShIWi8yKQorI2RlZmluZSBC
QUxBTkNFRF9JUlFfTU9SRV9ERUxUQQkJKEhaLzEwKQorI2RlZmluZSBCQUxBTkNFRF9JUlFfTEVT
U19ERUxUQQkJKEhaKQorCitsb25nIGJhbGFuY2VkX2lycV9pbnRlcnZhbCA9IE1BWF9CQUxBTkNF
RF9JUlFfSU5URVJWQUw7CisJCQkJCSAKK3N0YXRpYyBpbmxpbmUgdm9pZCBiYWxhbmNlX2lycShp
bnQgY3B1LCBpbnQgaXJxKTsKKworc3RhdGljIGlubGluZSB2b2lkIHJvdGF0ZV9pcnFzX2Ftb25n
X2NwdXModW5zaWduZWQgbG9uZyB1c2VmdWxfbG9hZF90aHJlc2hvbGQpCit7CisJaW50IGksIGo7
CisJRHByaW50aygiUm90YXRpbmcgSVJRcyBhbW9uZyBDUFVzLlxuIik7CisJZm9yIChpID0gMDsg
aSA8IE5SX0NQVVM7IGkrKykgeworCQlmb3IgKGogPSAwOyBjcHVfb25saW5lKGkpICYmIChqIDwg
TlJfSVJRUyk7IGorKykgeworCQkJaWYgKCFpcnFfZGVzY1tqXS5hY3Rpb24pCisJCQkJY29udGlu
dWU7CisJCQkvKiBJcyBpdCBhIHNpZ25pZmljYW50IGxvYWQgPyAgKi8KKwkJCWlmIChJUlFfREVM
VEEoQ1BVX1RPX1BBQ0tBR0VJTkRFWChpKSxqKSA8IHVzZWZ1bF9sb2FkX3RocmVzaG9sZCkKKwkJ
CQljb250aW51ZTsKKwkJCWJhbGFuY2VfaXJxKGksIGopOworCQl9CisJfQorCWJhbGFuY2VkX2ly
cV9pbnRlcnZhbCA9IG1heCgobG9uZylNSU5fQkFMQU5DRURfSVJRX0lOVEVSVkFMLAorCQliYWxh
bmNlZF9pcnFfaW50ZXJ2YWwgLSBCQUxBTkNFRF9JUlFfTEVTU19ERUxUQSk7CQorCXJldHVybjsK
K30KKworc3RhdGljIHZvaWQgZG9faXJxX2JhbGFuY2Uodm9pZCkKK3sKKwlpbnQgaSwgajsKKwl1
bnNpZ25lZCBsb25nIG1heF9jcHVfaXJxID0gMCwgbWluX2NwdV9pcnEgPSAofjApOworCXVuc2ln
bmVkIGxvbmcgbW92ZV90aGlzX2xvYWQgPSAwOworCWludCBtYXhfbG9hZGVkID0gMCwgbWluX2xv
YWRlZCA9IDA7CisJdW5zaWduZWQgbG9uZyB1c2VmdWxfbG9hZF90aHJlc2hvbGQgPSBiYWxhbmNl
ZF9pcnFfaW50ZXJ2YWwgKyAxMDsKKwlpbnQgc2VsZWN0ZWRfaXJxOworCWludCB0bXBfbG9hZGVk
LCBmaXJzdF9hdHRlbXB0ID0gMTsKKwl1bnNpZ25lZCBsb25nIHRtcF9jcHVfaXJxOworCXVuc2ln
bmVkIGxvbmcgaW1iYWxhbmNlID0gMDsKKwl1bnNpZ25lZCBsb25nIGFsbG93ZWRfbWFzazsKKwl1
bnNpZ25lZCBsb25nIHRhcmdldF9jcHVfbWFzazsKKworCWZvciAoaSA9IDA7IGkgPCBOUl9DUFVT
OyBpKyspIHsKKwkJaW50IHBhY2thZ2VfaW5kZXg7CisJCUNQVV9JUlEoaSkgPSAwOworCQlpZiAo
IWNwdV9vbmxpbmUoaSkpCisJCQljb250aW51ZTsKKwkJcGFja2FnZV9pbmRleCA9IENQVV9UT19Q
QUNLQUdFSU5ERVgoaSk7CisJCWZvciAoaiA9IDA7IGogPCBOUl9JUlFTOyBqKyspIHsKKwkJCXVu
c2lnbmVkIGxvbmcgdmFsdWVfbm93LCBkZWx0YTsKKwkJCS8qIElzIHRoaXMgYW4gYWN0aXZlIElS
UT8gKi8KKwkJCWlmICghaXJxX2Rlc2Nbal0uYWN0aW9uKQorCQkJCWNvbnRpbnVlOworCQkJaWYg
KCBwYWNrYWdlX2luZGV4ID09IGkgKQorCQkJCUlSUV9ERUxUQShwYWNrYWdlX2luZGV4LGopID0g
MDsKKwkJCS8qIERldGVybWluZSB0aGUgdG90YWwgY291bnQgcGVyIHByb2Nlc3NvciBwZXIgSVJR
ICovCisJCQl2YWx1ZV9ub3cgPSAodW5zaWduZWQgbG9uZykga3N0YXRfY3B1KGkpLmlycXNbal07
CisKKwkJCS8qIERldGVybWluZSB0aGUgYWN0aXZpdHkgcGVyIHByb2Nlc3NvciBwZXIgSVJRICov
CisJCQlkZWx0YSA9IHZhbHVlX25vdyAtIExBU1RfQ1BVX0lSUShpLGopOworCisJCQkvKiBVcGRh
dGUgbGFzdF9jcHVfaXJxW11bXSBmb3IgdGhlIG5leHQgdGltZSAqLworCQkJTEFTVF9DUFVfSVJR
KGksaikgPSB2YWx1ZV9ub3c7CisKKwkJCS8qIElnbm9yZSBJUlFzIHdob3NlIHJhdGUgaXMgbGVz
cyB0aGFuIHRoZSBjbG9jayAqLworCQkJaWYgKGRlbHRhIDwgdXNlZnVsX2xvYWRfdGhyZXNob2xk
KQorCQkJCWNvbnRpbnVlOworCQkJLyogdXBkYXRlIHRoZSBsb2FkIGZvciB0aGUgcHJvY2Vzc29y
IG9yIHBhY2thZ2UgdG90YWwgKi8KKwkJCUlSUV9ERUxUQShwYWNrYWdlX2luZGV4LGopICs9IGRl
bHRhOworCisJCQkvKiBLZWVwIHRyYWNrIG9mIHRoZSBoaWdoZXIgbnVtYmVyZWQgc2libGluZyBh
cyB3ZWxsICovCisJCQlpZiAoaSAhPSBwYWNrYWdlX2luZGV4KQorCQkJCUNQVV9JUlEoaSkgKz0g
ZGVsdGE7CisJCQkvKgorCQkJICogV2UgaGF2ZSBzaWJsaW5nIEEgYW5kIHNpYmxpbmcgQiBpbiB0
aGUgcGFja2FnZQorCQkJICoKKwkJCSAqIGNwdV9pcnFbQV0gPSBsb2FkIGZvciBjcHUgQSArIGxv
YWQgZm9yIGNwdSBCCisJCQkgKiBjcHVfaXJxW0JdID0gbG9hZCBmb3IgY3B1IEIKKwkJCSAqLwor
CQkJQ1BVX0lSUShwYWNrYWdlX2luZGV4KSArPSBkZWx0YTsKKwkJfQorCX0KKwkvKiBGaW5kIHRo
ZSBsZWFzdCBsb2FkZWQgcHJvY2Vzc29yIHBhY2thZ2UgKi8KKwlmb3IgKGkgPSAwOyBpIDwgTlJf
Q1BVUzsgaSsrKSB7CisJCWlmICghY3B1X29ubGluZShpKSkKKwkJCWNvbnRpbnVlOworCQlpZiAo
cGh5c2ljYWxfYmFsYW5jZSAmJiBpID4gY3B1X3NpYmxpbmdfbWFwW2ldKQorCQkJY29udGludWU7
CisJCWlmIChtaW5fY3B1X2lycSA+IENQVV9JUlEoaSkpIHsKKwkJCW1pbl9jcHVfaXJxID0gQ1BV
X0lSUShpKTsKKwkJCW1pbl9sb2FkZWQgPSBpOworCQl9CisJfQorCW1heF9jcHVfaXJxID0gVUxP
TkdfTUFYOworCit0cnlhbm90aGVyY3B1OgorCS8qIExvb2sgZm9yIGhlYXZpZXN0IGxvYWRlZCBw
cm9jZXNzb3IuCisJICogV2UgbWF5IGNvbWUgYmFjayB0byBnZXQgdGhlIG5leHQgaGVhdmllc3Qg
bG9hZGVkIHByb2Nlc3Nvci4KKwkgKiBTa2lwIHByb2Nlc3NvcnMgd2l0aCB0cml2aWFsIGxvYWRz
LgorCSAqLworCXRtcF9jcHVfaXJxID0gMDsKKwl0bXBfbG9hZGVkID0gLTE7CisJZm9yIChpID0g
MDsgaSA8IE5SX0NQVVM7IGkrKykgeworCQlpZiAoIWNwdV9vbmxpbmUoaSkpCisJCQljb250aW51
ZTsKKwkJaWYgKHBoeXNpY2FsX2JhbGFuY2UgJiYgaSA+IGNwdV9zaWJsaW5nX21hcFtpXSkKKwkJ
CWNvbnRpbnVlOworCQlpZiAobWF4X2NwdV9pcnEgPD0gQ1BVX0lSUShpKSkgCisJCQljb250aW51
ZTsKKwkJaWYgKHRtcF9jcHVfaXJxIDwgQ1BVX0lSUShpKSkgeworCQkJdG1wX2NwdV9pcnEgPSBD
UFVfSVJRKGkpOworCQkJdG1wX2xvYWRlZCA9IGk7CisJCX0KKwl9CisKKwlpZiAodG1wX2xvYWRl
ZCA9PSAtMSkgeworIAkgLyogSW4gdGhlIGNhc2Ugb2Ygc21hbGwgbnVtYmVyIG9mIGhlYXZ5IGlu
dGVycnVwdCBzb3VyY2VzLCAKKwkgICogbG9hZGluZyBzb21lIG9mIHRoZSBjcHVzIHRvbyBtdWNo
LiBXZSB1c2UgSW5nbydzIG9yaWdpbmFsIAorCSAgKiBhcHByb2FjaCB0byByb3RhdGUgdGhlbSBh
cm91bmQuCisJICAqLworCQlpZiAoIWZpcnN0X2F0dGVtcHQgJiYgaW1iYWxhbmNlID49IHVzZWZ1
bF9sb2FkX3RocmVzaG9sZCkgeworCQkJcm90YXRlX2lycXNfYW1vbmdfY3B1cyh1c2VmdWxfbG9h
ZF90aHJlc2hvbGQpOworCQkJcmV0dXJuOworCQl9CisJCWdvdG8gbm90X3dvcnRoX3RoZV9lZmZv
cnQ7CisJfQorCQorCWZpcnN0X2F0dGVtcHQgPSAwOwkJLyogaGVhdmllc3Qgc2VhcmNoICovCisJ
bWF4X2NwdV9pcnEgPSB0bXBfY3B1X2lycTsJLyogbG9hZCAqLworCW1heF9sb2FkZWQgPSB0bXBf
bG9hZGVkOwkvKiBwcm9jZXNzb3IgKi8KKwlpbWJhbGFuY2UgPSAobWF4X2NwdV9pcnEgLSBtaW5f
Y3B1X2lycSkgLyAyOworCQorCURwcmludGsoIm1heF9sb2FkZWQgY3B1ID0gJWRcbiIsIG1heF9s
b2FkZWQpOworCURwcmludGsoIm1pbl9sb2FkZWQgY3B1ID0gJWRcbiIsIG1pbl9sb2FkZWQpOwor
CURwcmludGsoIm1heF9jcHVfaXJxIGxvYWQgPSAlbGRcbiIsIG1heF9jcHVfaXJxKTsKKwlEcHJp
bnRrKCJtaW5fY3B1X2lycSBsb2FkID0gJWxkXG4iLCBtaW5fY3B1X2lycSk7CisJRHByaW50aygi
bG9hZCBpbWJhbGFuY2UgPSAlbHVcbiIsIGltYmFsYW5jZSk7CisKKwkvKiBpZiBpbWJhbGFuY2Ug
aXMgbGVzcyB0aGFuIGFwcHJveCAxMCUgb2YgbWF4IGxvYWQsIHRoZW4KKwkgKiBvYnNlcnZlIGRp
bWluaXNoaW5nIHJldHVybnMgYWN0aW9uLiAtIHF1aXQKKwkgKi8KKwlpZiAoaW1iYWxhbmNlIDwg
KG1heF9jcHVfaXJxID4+IDMpKSB7CisJCURwcmludGsoIkltYmFsYW5jZSB0b28gdHJpdmlhbFxu
Iik7CisJCWdvdG8gbm90X3dvcnRoX3RoZV9lZmZvcnQ7CisJfQorCit0cnlhbm90aGVyaXJxOgor
CS8qIGlmIHdlIHNlbGVjdCBhbiBJUlEgdG8gbW92ZSB0aGF0IGNhbid0IGdvIHdoZXJlIHdlIHdh
bnQsIHRoZW4KKwkgKiBzZWUgaWYgdGhlcmUgaXMgYW5vdGhlciBvbmUgdG8gdHJ5LgorCSAqLwor
CW1vdmVfdGhpc19sb2FkID0gMDsKKwlzZWxlY3RlZF9pcnEgPSAtMTsKKwlmb3IgKGogPSAwOyBq
IDwgTlJfSVJRUzsgaisrKSB7CisJCS8qIElzIHRoaXMgYW4gYWN0aXZlIElSUT8gKi8KKwkJaWYg
KCFpcnFfZGVzY1tqXS5hY3Rpb24pCisJCQljb250aW51ZTsKKwkJaWYgKGltYmFsYW5jZSA8PSBJ
UlFfREVMVEEobWF4X2xvYWRlZCxqKSkKKwkJCWNvbnRpbnVlOworCQkvKiBUcnkgdG8gZmluZCB0
aGUgSVJRIHRoYXQgaXMgY2xvc2VzdCB0byB0aGUgaW1iYWxhbmNlCisJCSAqIHdpdGhvdXQgZ29p
bmcgb3Zlci4KKwkJICovCisJCWlmIChtb3ZlX3RoaXNfbG9hZCA8IElSUV9ERUxUQShtYXhfbG9h
ZGVkLGopKSB7CisJCQltb3ZlX3RoaXNfbG9hZCA9IElSUV9ERUxUQShtYXhfbG9hZGVkLGopOwor
CQkJc2VsZWN0ZWRfaXJxID0gajsKKwkJfQorCX0KKwlpZiAoc2VsZWN0ZWRfaXJxID09IC0xKSB7
CisJCWdvdG8gdHJ5YW5vdGhlcmNwdTsKKwl9CiAKLSNkZWZpbmUgSVJRX0JBTEFOQ0VfSU5URVJW
QUwgKEhaLzUwKQorCWltYmFsYW5jZSA9IG1vdmVfdGhpc19sb2FkOwogCQorCS8qIEZvciBwaHlz
aWNhbF9iYWxhbmNlIGNhc2UsIHdlIGFjY3VtbGF0ZWQgYm90aCBsb2FkCisJICogdmFsdWVzIGlu
IHRoZSBvbmUgb2YgdGhlIHNpYmxpbmdzIGNwdV9pcnFbXSwKKwkgKiB0byB1c2UgdGhlIHNhbWUg
Y29kZSBmb3IgcGh5c2ljYWwgYW5kIGxvZ2ljYWwgcHJvY2Vzc29ycworCSAqIGFzIG11Y2ggYXMg
cG9zc2libGUuIAorCSAqCisJICogTk9URTogdGhlIGNwdV9pcnFbXSBhcnJheSBob2xkcyB0aGUg
c3VtIG9mIHRoZSBsb2FkIGZvcgorCSAqIHNpYmxpbmcgQSBhbmQgc2libGluZyBCIGluIHRoZSBz
bG90IGZvciB0aGUgbG93ZXN0IG51bWJlcmVkCisJICogc2libGluZyAoQSksIF9BTkRfIHRoZSBs
b2FkIGZvciBzaWJsaW5nIEIgaW4gdGhlIHNsb3QgZm9yCisJICogdGhlIGhpZ2hlciBudW1iZXJl
ZCBzaWJsaW5nLgorCSAqCisJICogV2Ugc2VlayB0aGUgbGVhc3QgbG9hZGVkIHNpYmxpbmcgYnkg
bWFraW5nIHRoZSBjb21wYXJpc29uCisJICogKEErQikvMiB2cyBCCisJICovCisJaWYgKHBoeXNp
Y2FsX2JhbGFuY2UgJiYgKENQVV9JUlEobWluX2xvYWRlZCkgPj4gMSkgPiBDUFVfSVJRKGNwdV9z
aWJsaW5nX21hcFttaW5fbG9hZGVkXSkpCisJCW1pbl9sb2FkZWQgPSBjcHVfc2libGluZ19tYXBb
bWluX2xvYWRlZF07CisKKwlhbGxvd2VkX21hc2sgPSBjcHVfb25saW5lX21hcCAmIGlycV9hZmZp
bml0eVtzZWxlY3RlZF9pcnFdOworCXRhcmdldF9jcHVfbWFzayA9IDEgPDwgbWluX2xvYWRlZDsK
KworCWlmICh0YXJnZXRfY3B1X21hc2sgJiBhbGxvd2VkX21hc2spIHsKKwkJaXJxX2Rlc2NfdCAq
ZGVzYyA9IGlycV9kZXNjICsgc2VsZWN0ZWRfaXJxOworCQlEcHJpbnRrKCJpcnEgPSAlZCBtb3Zl
ZCB0byBjcHUgPSAlZFxuIiwgc2VsZWN0ZWRfaXJxLCBtaW5fbG9hZGVkKTsKKwkJLyogbWFyayBm
b3IgY2hhbmdlIGRlc3RpbmF0aW9uICovCisJCXNwaW5fbG9jaygmZGVzYy0+bG9jayk7CisJCWly
cV9iYWxhbmNlX21hc2tbc2VsZWN0ZWRfaXJxXSA9IHRhcmdldF9jcHVfbWFzazsKKwkJc3Bpbl91
bmxvY2soJmRlc2MtPmxvY2spOworCQkvKiBTaW5jZSB3ZSBtYWRlIGEgY2hhbmdlLCBjb21lIGJh
Y2sgc29vbmVyIHRvIAorCQkgKiBjaGVjayBmb3IgbW9yZSB2YXJpYXRpb24uCisJCSAqLworCQli
YWxhbmNlZF9pcnFfaW50ZXJ2YWwgPSBtYXgoKGxvbmcpTUlOX0JBTEFOQ0VEX0lSUV9JTlRFUlZB
TCwKKwkJCWJhbGFuY2VkX2lycV9pbnRlcnZhbCAtIEJBTEFOQ0VEX0lSUV9MRVNTX0RFTFRBKTsJ
CisJCXJldHVybjsKKwl9CisJZ290byB0cnlhbm90aGVyaXJxOworCitub3Rfd29ydGhfdGhlX2Vm
Zm9ydDoKKwkvKiBpZiB3ZSBkaWQgbm90IGZpbmQgYW4gSVJRIHRvIG1vdmUsIHRoZW4gYWRqdXN0
IHRoZSB0aW1lIGludGVydmFsIHVwd2FyZCAqLworCWJhbGFuY2VkX2lycV9pbnRlcnZhbCA9IG1p
bigobG9uZylNQVhfQkFMQU5DRURfSVJRX0lOVEVSVkFMLAorCQliYWxhbmNlZF9pcnFfaW50ZXJ2
YWwgKyBCQUxBTkNFRF9JUlFfTU9SRV9ERUxUQSk7CQorCURwcmludGsoIklSUSB3b3J0aCByb3Rh
dGluZyBub3QgZm91bmRcbiIpOworCXJldHVybjsKK30KKwogc3RhdGljIHVuc2lnbmVkIGxvbmcg
bW92ZShpbnQgY3Vycl9jcHUsIHVuc2lnbmVkIGxvbmcgYWxsb3dlZF9tYXNrLCB1bnNpZ25lZCBs
b25nIG5vdywgaW50IGRpcmVjdGlvbikKIHsKIAlpbnQgc2VhcmNoX2lkbGUgPSAxOwpAQCAtMjU3
LDM0ICs0ODYsMTExIEBACiAJcmV0dXJuIGNwdTsKIH0KIAotc3RhdGljIGlubGluZSB2b2lkIGJh
bGFuY2VfaXJxKGludCBpcnEpCitzdGF0aWMgaW5saW5lIHZvaWQgYmFsYW5jZV9pcnEgKGludCBj
cHUsIGludCBpcnEpCiB7Ci0JaXJxX2JhbGFuY2VfdCAqZW50cnkgPSBpcnFfYmFsYW5jZSArIGly
cTsKIAl1bnNpZ25lZCBsb25nIG5vdyA9IGppZmZpZXM7Ci0KKwl1bnNpZ25lZCBsb25nIGFsbG93
ZWRfbWFzazsKKwl1bnNpZ25lZCBpbnQgbmV3X2NwdTsKKwkJCiAJaWYgKG5vX2JhbGFuY2VfaXJx
KQogCQlyZXR1cm47CiAKLQlpZiAodW5saWtlbHkodGltZV9hZnRlcihub3csIGVudHJ5LT50aW1l
c3RhbXAgKyBJUlFfQkFMQU5DRV9JTlRFUlZBTCkpKSB7Ci0JCXVuc2lnbmVkIGxvbmcgYWxsb3dl
ZF9tYXNrOwotCQl1bnNpZ25lZCBpbnQgbmV3X2NwdTsKLQkJaW50IHJhbmRvbV9udW1iZXI7CisJ
YWxsb3dlZF9tYXNrID0gY3B1X29ubGluZV9tYXAgJiBpcnFfYWZmaW5pdHlbaXJxXTsKKwluZXdf
Y3B1ID0gbW92ZShjcHUsIGFsbG93ZWRfbWFzaywgbm93LCAxKTsKKwlpZiAoY3B1ICE9IG5ld19j
cHUpIHsKKwkJaXJxX2Rlc2NfdCAqZGVzYyA9IGlycV9kZXNjICsgaXJxOworCQlzcGluX2xvY2so
JmRlc2MtPmxvY2spOworCQlpcnFfYmFsYW5jZV9tYXNrW2lycV0gPSAxIDw8IG5ld19jcHU7CisJ
CXNwaW5fdW5sb2NrKCZkZXNjLT5sb2NrKTsKKwl9Cit9CiAKLQkJcmR0c2NsKHJhbmRvbV9udW1i
ZXIpOwotCQlyYW5kb21fbnVtYmVyICY9IDE7CitpbnQgYmFsYW5jZWRfaXJxKHZvaWQgKnVudXNl
ZCkKK3sKKwlpbnQgaTsKKwl1bnNpZ25lZCBsb25nIHByZXZfYmFsYW5jZV90aW1lID0gamlmZmll
czsKKwlsb25nIHRpbWVfcmVtYWluaW5nID0gYmFsYW5jZWRfaXJxX2ludGVydmFsOworCWRhZW1v
bml6ZSgpOworCXNpZ2ZpbGxzZXQoJmN1cnJlbnQtPmJsb2NrZWQpOworCXNwcmludGYoY3VycmVu
dC0+Y29tbSwgImJhbGFuY2VkX2lycSIpOworCQorCS8qIHB1c2ggZXZlcnl0aGluZyB0byBDUFUg
MCB0byBnaXZlIHVzIGEgc3RhcnRpbmcgcG9pbnQuICAqLworCWZvciAoaSA9IDAgOyBpIDwgTlJf
SVJRUyA7IGkrKykKKwkJaXJxX2JhbGFuY2VfbWFza1tpXSA9IDEgPDwgMDsKKwlmb3IgKDs7KSB7
CisJCXNldF9jdXJyZW50X3N0YXRlKFRBU0tfSU5URVJSVVBUSUJMRSk7CisJCXRpbWVfcmVtYWlu
aW5nID0gc2NoZWR1bGVfdGltZW91dCh0aW1lX3JlbWFpbmluZyk7CisJCWlmICh0aW1lX2FmdGVy
KGppZmZpZXMsIHByZXZfYmFsYW5jZV90aW1lK2JhbGFuY2VkX2lycV9pbnRlcnZhbCkpIHsKKwkJ
CURwcmludGsoImJhbGFuY2VkX2lycTogY2FsbGluZyBkb19pcnFfYmFsYW5jZSgpICVsdVxuIiwg
amlmZmllcyk7CisJCQlkb19pcnFfYmFsYW5jZSgpOworCQkJcHJldl9iYWxhbmNlX3RpbWUgPSBq
aWZmaWVzOworCQkJdGltZV9yZW1haW5pbmcgPSBiYWxhbmNlZF9pcnFfaW50ZXJ2YWw7CisJCX0K
KyAgICAgICAgfQorfQorCitzdGF0aWMgaW50IF9faW5pdCBiYWxhbmNlZF9pcnFfaW5pdCh2b2lk
KQoreworCWludCBpOworCXN0cnVjdCBjcHVpbmZvX3g4NiAqYzsKKyAgICAgICAgYyA9ICZib290
X2NwdV9kYXRhOworCWlmIChpcnFiYWxhbmNlX2Rpc2FibGVkKQorCQlyZXR1cm4gMDsKKwkvKiBF
bmFibGUgcGh5c2ljYWwgYmFsYW5jZSBvbmx5IGlmIG1vcmUgdGhhbiAxIHBoeXNpY2FsIHByb2Nl
c3NvciBpcyBwcmVzZW50ICovCisJaWYgKHNtcF9udW1fc2libGluZ3MgPiAxICYmIGNwdV9vbmxp
bmVfbWFwID4+IDIpCisJCXBoeXNpY2FsX2JhbGFuY2UgPSAxOwogCi0JCWFsbG93ZWRfbWFzayA9
IGNwdV9vbmxpbmVfbWFwICYgaXJxX2FmZmluaXR5W2lycV07Ci0JCWVudHJ5LT50aW1lc3RhbXAg
PSBub3c7Ci0JCW5ld19jcHUgPSBtb3ZlKGVudHJ5LT5jcHUsIGFsbG93ZWRfbWFzaywgbm93LCBy
YW5kb21fbnVtYmVyKTsKLQkJaWYgKGVudHJ5LT5jcHUgIT0gbmV3X2NwdSkgewotCQkJZW50cnkt
PmNwdSA9IG5ld19jcHU7Ci0JCQlzZXRfaW9hcGljX2FmZmluaXR5KGlycSwgMSA8PCBuZXdfY3B1
KTsKKwlmb3IgKGkgPSAwOyBpIDwgTlJfQ1BVUzsgaSsrKSB7CisJCWlmICghY3B1X29ubGluZShp
KSkKKwkJCWNvbnRpbnVlOworCQlpcnFfY3B1X2RhdGFbaV0uaXJxX2RlbHRhID0ga21hbGxvYyhz
aXplb2YodW5zaWduZWQgbG9uZykgKiBOUl9JUlFTLCBHRlBfS0VSTkVMKTsKKwkJaXJxX2NwdV9k
YXRhW2ldLmxhc3RfaXJxID0ga21hbGxvYyhzaXplb2YodW5zaWduZWQgbG9uZykgKiBOUl9JUlFT
LCBHRlBfS0VSTkVMKTsKKwkJaWYgKGlycV9jcHVfZGF0YVtpXS5pcnFfZGVsdGEgPT0gTlVMTCB8
fCBpcnFfY3B1X2RhdGFbaV0ubGFzdF9pcnEgPT0gTlVMTCkgeworCQkJcHJpbnRrKEtFUk5fRVJS
ICJiYWxhbmNlZF9pcnFfaW5pdDogb3V0IG9mIG1lbW9yeSIpOworCQkJZ290byBmYWlsZWQ7CiAJ
CX0KKwkJbWVtc2V0KGlycV9jcHVfZGF0YVtpXS5pcnFfZGVsdGEsMCxzaXplb2YodW5zaWduZWQg
bG9uZykgKiBOUl9JUlFTKTsKKwkJbWVtc2V0KGlycV9jcHVfZGF0YVtpXS5sYXN0X2lycSwwLHNp
emVvZih1bnNpZ25lZCBsb25nKSAqIE5SX0lSUVMpOwogCX0KKwkKKwlwcmludGsoS0VSTl9JTkZP
ICJTdGFydGluZyBiYWxhbmNlZF9pcnFcbiIpOworCWlmIChrZXJuZWxfdGhyZWFkKGJhbGFuY2Vk
X2lycSwgTlVMTCwgQ0xPTkVfS0VSTkVMKSA+PSAwKSAKKwkJcmV0dXJuIDA7CisJZWxzZSAKKwkJ
cHJpbnRrKEtFUk5fRVJSICJiYWxhbmNlZF9pcnFfaW5pdDogZmFpbGVkIHRvIHNwYXduIGJhbGFu
Y2VkX2lycSIpOworZmFpbGVkOgorCWZvciAoaSA9IDA7IGkgPCBOUl9DUFVTOyBpKyspIHsKKwkJ
aWYoaXJxX2NwdV9kYXRhW2ldLmlycV9kZWx0YSkKKwkJCWtmcmVlKGlycV9jcHVfZGF0YVtpXS5p
cnFfZGVsdGEpOworCQlpZihpcnFfY3B1X2RhdGFbaV0ubGFzdF9pcnEpCisJCQlrZnJlZShpcnFf
Y3B1X2RhdGFbaV0ubGFzdF9pcnEpOworCX0KKwlyZXR1cm4gMDsKIH0KLSNlbHNlIC8qICFTTVAg
Ki8KLXN0YXRpYyBpbmxpbmUgdm9pZCBiYWxhbmNlX2lycShpbnQgaXJxKSB7IH0KLSNlbmRpZgor
CitzdGF0aWMgaW50IF9faW5pdCBpcnFiYWxhbmNlX2Rpc2FibGUoY2hhciAqc3RyKQoreworCWly
cWJhbGFuY2VfZGlzYWJsZWQgPSAxOworCXJldHVybiAwOworfQorCitfX3NldHVwKCJub2lycWJh
bGFuY2UiLCBpcnFiYWxhbmNlX2Rpc2FibGUpOworCitzdGF0aWMgdm9pZCBzZXRfaW9hcGljX2Fm
ZmluaXR5ICh1bnNpZ25lZCBpbnQgaXJxLCB1bnNpZ25lZCBsb25nIG1hc2spOworCitzdGF0aWMg
aW5saW5lIHZvaWQgbW92ZV9pcnEoaW50IGlycSkKK3sKKwkvKiBub3RlIC0gd2UgaG9sZCB0aGUg
ZGVzYy0+bG9jayAqLworCWlmICh1bmxpa2VseShpcnFfYmFsYW5jZV9tYXNrW2lycV0pKSB7CisJ
CXNldF9pb2FwaWNfYWZmaW5pdHkoaXJxLCBpcnFfYmFsYW5jZV9tYXNrW2lycV0pOworCQlpcnFf
YmFsYW5jZV9tYXNrW2lycV0gPSAwOworCX0KK30KKworX19pbml0Y2FsbChiYWxhbmNlZF9pcnFf
aW5pdCk7CisKKyNlbmRpZiAvKiBkZWZpbmVkKENPTkZJR19TTVApICovCisKIAogLyoKICAqIHN1
cHBvcnQgZm9yIGJyb2tlbiBNUCBCSU9TcywgZW5hYmxlcyBoYW5kLXJlZGlyZWN0aW9uIG9mIFBJ
UlEwLTcgdG8KQEAgLTEzMDcsNyArMTYxMyw3IEBACiAgKi8KIHN0YXRpYyB2b2lkIGFja19lZGdl
X2lvYXBpY19pcnEodW5zaWduZWQgaW50IGlycSkKIHsKLQliYWxhbmNlX2lycShpcnEpOworCW1v
dmVfaXJxKGlycSk7CiAJaWYgKChpcnFfZGVzY1tpcnFdLnN0YXR1cyAmIChJUlFfUEVORElORyB8
IElSUV9ESVNBQkxFRCkpCiAJCQkJCT09IChJUlFfUEVORElORyB8IElSUV9ESVNBQkxFRCkpCiAJ
CW1hc2tfSU9fQVBJQ19pcnEoaXJxKTsKQEAgLTEzNDcsNyArMTY1Myw3IEBACiAJdW5zaWduZWQg
bG9uZyB2OwogCWludCBpOwogCi0JYmFsYW5jZV9pcnEoaXJxKTsKKwltb3ZlX2lycShpcnEpOwog
LyoKICAqIEl0IGFwcGVhcnMgdGhlcmUgaXMgYW4gZXJyYXR1bSB3aGljaCBhZmZlY3RzIGF0IGxl
YXN0IHZlcnNpb24gMHgxMQogICogb2YgSS9PIEFQSUMgKHRoYXQncyB0aGUgODIwOTNBQSBhbmQg
Y29yZXMgaW50ZWdyYXRlZCBpbnRvIHZhcmlvdXMKZGlmZiAtTmFydSAyLjUuNTgvRG9jdW1lbnRh
dGlvbi9rZXJuZWwtcGFyYW1ldGVycy50eHQga2lycS9Eb2N1bWVudGF0aW9uL2tlcm5lbC1wYXJh
bWV0ZXJzLnR4dAotLS0gMi41LjU4L0RvY3VtZW50YXRpb24va2VybmVsLXBhcmFtZXRlcnMudHh0
CTIwMDMtMDEtMTMgMjE6NTk6MzUuMDAwMDAwMDAwIC0wODAwCisrKyBraXJxL0RvY3VtZW50YXRp
b24va2VybmVsLXBhcmFtZXRlcnMudHh0CTIwMDMtMDEtMTQgMTY6MTg6NDEuMDAwMDAwMDAwIC0w
ODAwCkBAIC0zNTIsNiArMzUyLDggQEAKIAogCWh1Z2VwYWdlcz0JW0hXLElBLTMyXSBNYXhpbWFs
IG51bWJlciBvZiBIdWdlVExCIHBhZ2VzCiAKKwlub2lycWJhbGFuY2UJW0lBLTMyLFNNUCxLTkxd
IERpc2FibGUga2VybmVsIGlycSBiYWxhbmNpbmcKKwogCWk4MDQyX2RpcmVjdAlbSFddIE5vbi10
cmFuc2xhdGVkIG1vZGUKIAlpODA0Ml9kdW1ia2JkCiAJaTgwNDJfbm9hdXgK

------_=_NextPart_001_01C2BDA3.7AC98913--
