Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265181AbUFWOgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUFWOgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbUFWOgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:36:52 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:52211 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S265181AbUFWOgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:36:25 -0400
Subject: PATCH: Precise Accounting for 2.6.7
From: Timm Morten Steinbeck <timm.steinbeck@kip.uni-heidelberg.de>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, mingo@elte.hu,
       Arne Wiebalck <wiebalck@kip.uni-heidelberg.de>
Content-Type: text/plain
Message-Id: <1088001374.9326.365.camel@ts2.kip.uni-heidelberg.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 23 Jun 2004 16:36:17 +0200
Content-Transfer-Encoding: 7bit
X-SA-Relays-Trusted: [ ip=129.206.177.159 rdns=ts2.kip.uni-heidelberg.de helo=ts2.kip.uni-heidelberg.de by=mail.kip.uni-heidelberg.de ident= ]
X-SA-Relays-Untrusted: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we have ported our x86 precise accounting patch from the 2.4 kernel
series to 2.6.7.

The patch fixes a problem with the accounting via the "cpu*" lines from
/proc/stat. The standard kernels can produce misleading data for
programs that give up the rest of their timeslice, e.g. via usleep. This
can lead to programs using 90% or more CPU time which is not accounted.
The computer is reported as idle or another program seems to use up the
time. The patch fixes the problem by doing the accounting on the basis
of the CPU's time stamp counter instead of whole time slices.
The patch as well as proof-of-principle programs illustrating the
problem can be downloaded at
http://www.ti.uni-hd.de/HLT/software/software.html#kernel .

Our original mail for the 2.4.20 patch is at
http://lwn.net/Articles/24974/ .

Please CC all comments to timm.steinbeck AT kip.uni-heidelberg.de and
arne.wiebalck AT kip.uni-heidelberg.de, as we are not subscribed to the
LKML.

Best regards
  Arne & Timm


-- 
********************************************************************
 Timm M. Steinbeck &                Kirchhoff Institute for Physics
 Arne Wiebalck                Computer Science/Computer Engineering
 e-mail:                                        INF 227, Room 3.315
 timm.steinbeck AT kip.uni-heidelberg.de         D-69120 Heidelberg
 arne.wiebalck AT kip.uni-heidelberg.de
 web:                                      Tel.: (+49) 6221/54-9816
 http://www.kip.uni-heidelberg.de          Fax.: (+49) 6221/54-9809
********************************************************************


---------------------- BEGIN PATCH ----------------------
diff -ur linux-2.6.7/Makefile linux-2.6.7-precacct/Makefile
--- linux-2.6.7/Makefile	2004-06-16 07:19:37.000000000 +0200
+++ linux-2.6.7-precacct/Makefile	2004-06-17 11:01:01.000000000 +0200
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 7
-EXTRAVERSION =
+EXTRAVERSION = -precacct
 NAME=Zonked Quokka
 
 # *DOCUMENTATION*
diff -ur linux-2.6.7/arch/i386/kernel/irq.c
linux-2.6.7-precacct/arch/i386/kernel/irq.c
--- linux-2.6.7/arch/i386/kernel/irq.c	2004-06-16 07:18:57.000000000
+0200
+++ linux-2.6.7-precacct/arch/i386/kernel/irq.c	2004-06-23
11:30:09.000000000 +0200
@@ -430,6 +430,9 @@
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
 	unsigned int status;
+#ifdef CONFIG_PRECISE_ACCT
+        cycles_t td, t = get_cycles();
+#endif
 
 	irq_enter();
 
@@ -570,6 +573,12 @@
 
 	irq_exit();
 
+#ifdef CONFIG_PRECISE_ACCT
+	td = get_cycles()-t;
+	per_cpu( last_cycles, smp_processor_id() ) += td;
+	per_cpu( kstat, smp_processor_id() ).irq_cycles[irq] += td;
+#endif
+
 	return 1;
 }
 
@@ -1115,6 +1124,81 @@
 		register_irq_proc(i);
 }
 
+#ifdef CONFIG_PRECISE_ACCT
+int get_irq_cycles_list(char *buf)
+{
+	int i, j;
+	struct irqaction * action;
+	char *p = buf;
+
+	p += sprintf(p, "                       ");
+	for (j=0; j<NR_CPUS; j++)
+		p += sprintf(p, "     CPU%d            ",j);
+	*p++ = '\n';
+
+	for (i = 0 ; i < NR_IRQS ; i++) {
+		action = irq_desc[i].action;
+		if (!action) 
+			continue;
+		p += sprintf(p, "            %3d: ",i);
+		for (j = 0; j < NR_CPUS; j++)
+			p += sprintf(p, "%20Lu ",
+				per_cpu( kstat, j ).irq_cycles[i]);
+		p += sprintf(p, " %14s", irq_desc[i].handler->typename);
+		p += sprintf(p, "  %s", action->name);
+
+		for (action=action->next; action; action = action->next)
+			p += sprintf(p, ", %s", action->name);
+		*p++ = '\n';
+	}
+	p += sprintf(p, "     HI_SOFTIRQ: ");
+	for (j = 0; j < NR_CPUS; j++)
+		p += sprintf(p, "%20Lu ",
+			per_cpu( kstat, j ).softirq_cycles[ HI_SOFTIRQ ] );
+	p += sprintf(p, "\n");
+	p += sprintf(p, "  TIMER_SOFTIRQ: ");
+	for (j = 0; j < NR_CPUS; j++)
+		p += sprintf(p, "%20Lu ",
+			per_cpu( kstat, j ).softirq_cycles[ TIMER_SOFTIRQ ] );
+	p += sprintf(p, "\n");
+	p += sprintf(p, " NET_TX_SOFTIRQ: ");
+	for (j = 0; j < NR_CPUS; j++)
+		p += sprintf(p, "%20Lu ",
+			per_cpu( kstat, j ).softirq_cycles[ NET_TX_SOFTIRQ ] );
+	p += sprintf(p, "\n");
+	p += sprintf(p, " NET_RX_SOFTIRQ: ");
+	for (j = 0; j < NR_CPUS; j++)
+		p += sprintf(p, "%20Lu ",
+			per_cpu( kstat, j ).softirq_cycles[ NET_RX_SOFTIRQ ] );
+	p += sprintf(p, "\n");
+	p += sprintf(p, "   SCSI_SOFTIRQ: ");
+	for (j = 0; j < NR_CPUS; j++)
+		p += sprintf(p, "%20Lu ",
+			per_cpu( kstat, j ).softirq_cycles[ SCSI_SOFTIRQ ] );
+	p += sprintf(p, "\n");
+	p += sprintf(p, "TASKLET_SOFTIRQ: ");
+	for (j = 0; j < NR_CPUS; j++)
+		p += sprintf(p, "%20Lu ",
+			per_cpu( kstat, j ).softirq_cycles[ TASKLET_SOFTIRQ ] );
+	p += sprintf(p, "\n");
+	i = 0;
+	for (j = 0; j < NR_CPUS; j++)
+	    if ( per_cpu( kstat, j ).softirq_cycles[ TASKLET_SOFTIRQ+1 ] )
+		i = 1;
+	if ( i )
+	    {
+	    p += sprintf(p, "SOFTIRQ_OTHER: ");
+	    for (j = 0; j < NR_CPUS; j++)
+		p += sprintf(p, "%20Lu ",
+			     per_cpu( kstat, j ).softirq_cycles[ TASKLET_SOFTIRQ+1 ] );
+	    p += sprintf(p, "\n");
+	    }
+	return p - buf;
+}
+#endif
+
+
+
 
 #ifdef CONFIG_4KSTACKS
 static char softirq_stack[NR_CPUS * THREAD_SIZE] 
__attribute__((__aligned__(THREAD_SIZE),
__section__(".bss.page_aligned")));
diff -ur linux-2.6.7/fs/proc/array.c
linux-2.6.7-precacct/fs/proc/array.c
--- linux-2.6.7/fs/proc/array.c	2004-06-16 07:19:36.000000000 +0200
+++ linux-2.6.7-precacct/fs/proc/array.c	2004-06-17 13:52:07.000000000
+0200
@@ -357,9 +357,15 @@
 	/* Temporary variable needed for gcc-2.96 */
 	start_time = jiffies_64_to_clock_t(task->start_time -
INITIAL_JIFFIES);
 
+#ifdef CONFIG_PRECISE_ACCT
+	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
+%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu
%lu \
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\ncycles %llu\n",
+#else
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu
%lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+#endif
 		task->pid,
 		task->comm,
 		state,
@@ -404,7 +410,13 @@
 		task->exit_signal,
 		task_cpu(task),
 		task->rt_priority,
-		task->policy);
+#ifdef CONFIG_PRECISE_ACCT
+		task->policy, 
+                (unsigned long long)task->cycles
+#else
+		task->policy
+#endif
+                );
 	if(mm)
 		mmput(mm);
 	return res;
diff -ur linux-2.6.7/fs/proc/proc_misc.c
linux-2.6.7-precacct/fs/proc/proc_misc.c
--- linux-2.6.7/fs/proc/proc_misc.c	2004-06-16 07:18:58.000000000 +0200
+++ linux-2.6.7-precacct/fs/proc/proc_misc.c	2004-06-23
09:49:35.000000000 +0200
@@ -70,6 +70,9 @@
 #ifdef CONFIG_SGI_DS1286
 extern int get_ds1286_status(char *);
 #endif
+#ifdef CONFIG_PRECISE_ACCT
+extern int get_irq_cycles_list(char *);
+#endif
 
 static int proc_calc_metrics(char *page, char **start, off_t off,
 				 int count, int *eof, int len)
@@ -363,7 +366,9 @@
 	unsigned long jif;
 	u64	sum = 0, user = 0, nice = 0, system = 0,
 		idle = 0, iowait = 0, irq = 0, softirq = 0;
-
+#ifdef CONFIG_PRECISE_ACCT
+	unsigned long long used_cycles = 0, tot_cycles = 0, irq_cycles = 0,
softirq_cycles = 0;
+#endif
 	jif = - wall_to_monotonic.tv_sec;
 	if (wall_to_monotonic.tv_nsec)
 		--jif;
@@ -380,6 +385,14 @@
 		softirq += kstat_cpu(i).cpustat.softirq;
 		for (j = 0 ; j < NR_IRQS ; j++)
 			sum += kstat_cpu(i).irqs[j];
+#ifdef CONFIG_PRECISE_ACCT
+		used_cycles += kstat_cpu(i).cpustat.used_cycles;
+		tot_cycles += per_cpu( last_cycles, i );
+		for (j = 0 ; j < NR_IRQS ; j++)
+			irq_cycles += kstat_cpu(i).irq_cycles[j];
+		for (j = 0 ; j < TASKLET_SOFTIRQ+2 ; j++)
+			softirq_cycles += kstat_cpu(i).softirq_cycles[j];
+#endif
 	}
 
 	seq_printf(p, "cpu  %llu %llu %llu %llu %llu %llu %llu\n",
@@ -410,6 +423,32 @@
 			(unsigned long long)jiffies_64_to_clock_t(irq),
 			(unsigned long long)jiffies_64_to_clock_t(softirq));
 	}
+#ifdef CONFIG_PRECISE_ACCT
+	seq_printf(p, "cycles  %llu %llu %llu %llu\n",
+		(unsigned long long)used_cycles, 
+		(unsigned long long)irq_cycles,
+		(unsigned long long)softirq_cycles,
+		(unsigned long long)tot_cycles );
+	for_each_online_cpu(i) {
+	        int j;
+
+		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
+		used_cycles = kstat_cpu(i).cpustat.used_cycles;
+		tot_cycles = per_cpu( last_cycles, i );
+		irq_cycles = 0;
+		softirq_cycles = 0;
+		for (j = 0 ; j < NR_IRQS ; j++)
+			irq_cycles += kstat_cpu(i).irq_cycles[j];
+		for (j = 0 ; j < TASKLET_SOFTIRQ+2 ; j++)
+			softirq_cycles += kstat_cpu(i).softirq_cycles[j];
+		seq_printf(p, "cycles%d %llu %llu %llu %llu\n",
+			i,
+			(unsigned long long)used_cycles,
+			(unsigned long long)irq_cycles,
+			(unsigned long long)softirq_cycles,
+			(unsigned long long)tot_cycles );
+	}
+#endif
 	seq_printf(p, "intr %llu", (unsigned long long)sum);
 
 #if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)
@@ -512,6 +551,15 @@
 	.release	= seq_release,
 };
 
+#ifdef CONFIG_PRECISE_ACCT
+static int interrupts_cycles_read_proc(char *page, char **start, off_t
off,
+				 int count, int *eof, void *data)
+{
+	int len = get_irq_cycles_list(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+#endif
+
 static int filesystems_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -669,6 +717,9 @@
 		{"stram",	stram_read_proc},
 #endif
 		{"devices",	devices_read_proc},
+#ifdef CONFIG_PRECISE_ACCT
+		{ "interrupts_cycles", interrupts_cycles_read_proc },
+#endif
 		{"filesystems",	filesystems_read_proc},
 		{"cmdline",	cmdline_read_proc},
 #ifdef CONFIG_SGI_DS1286
diff -ur linux-2.6.7/include/linux/kernel_stat.h
linux-2.6.7-precacct/include/linux/kernel_stat.h
--- linux-2.6.7/include/linux/kernel_stat.h	2004-06-16
07:20:04.000000000 +0200
+++ linux-2.6.7-precacct/include/linux/kernel_stat.h	2004-06-18
16:50:34.000000000 +0200
@@ -6,6 +6,9 @@
 #include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
+#ifdef CONFIG_PRECISE_ACCT
+#include <linux/interrupt.h>
+#endif
 
 /*
  * 'kernel_stat.h' contains the definitions needed for doing
@@ -21,11 +24,18 @@
 	u64 irq;
 	u64 idle;
 	u64 iowait;
+#ifdef CONFIG_PRECISE_ACCT
+        cycles_t used_cycles;
+#endif
 };
 
 struct kernel_stat {
 	struct cpu_usage_stat	cpustat;
 	unsigned int irqs[NR_IRQS];
+#ifdef CONFIG_PRECISE_ACCT
+        cycles_t irq_cycles[NR_IRQS];
+        cycles_t softirq_cycles[TASKLET_SOFTIRQ+2];
+#endif
 };
 
 DECLARE_PER_CPU(struct kernel_stat, kstat);
diff -ur linux-2.6.7/include/linux/sched.h
linux-2.6.7-precacct/include/linux/sched.h
--- linux-2.6.7/include/linux/sched.h	2004-06-16 07:18:57.000000000
+0200
+++ linux-2.6.7-precacct/include/linux/sched.h	2004-06-17
12:15:28.000000000 +0200
@@ -131,6 +131,10 @@
 	int sched_priority;
 };
 
+#ifdef CONFIG_PRECISE_ACCT
+DECLARE_PER_CPU( cycles_t, last_cycles );
+#endif
+
 #ifdef __KERNEL__
 
 #include <linux/spinlock.h>
@@ -442,6 +446,9 @@
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	unsigned long utime, stime, cutime, cstime;
+#ifdef CONFIG_PRECISE_ACCT
+        cycles_t cycles;
+#endif
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw; /* context switch counts
*/
 	u64 start_time;
 /* mm fault and swap info: this can arguably be seen as either
mm-specific or thread-specific */
diff -ur linux-2.6.7/init/Kconfig linux-2.6.7-precacct/init/Kconfig
--- linux-2.6.7/init/Kconfig	2004-06-16 07:19:52.000000000 +0200
+++ linux-2.6.7-precacct/init/Kconfig	2004-06-17 13:54:03.000000000
+0200
@@ -121,6 +121,15 @@
 	  up to the user level program to do useful things with this
 	  information.  This is generally a good idea, so say Y.
 
+config PRECISE_ACCT
+	bool "Precise accounting"
+	depends on X86 && X86_TSC
+	default n
+ 	---help---
+	  Enables precise process accounting on a CPU timestamp counter 
+          granularity.
+	  If unsure, say N.
+
 config SYSCTL
 	bool "Sysctl support"
 	---help---
diff -ur linux-2.6.7/kernel/fork.c linux-2.6.7-precacct/kernel/fork.c
--- linux-2.6.7/kernel/fork.c	2004-06-16 07:18:57.000000000 +0200
+++ linux-2.6.7-precacct/kernel/fork.c	2004-06-17 11:31:55.000000000
+0200
@@ -959,6 +959,9 @@
 	p->real_timer.data = (unsigned long) p;
 
 	p->utime = p->stime = 0;
+#ifdef CONFIG_PRECISE_ACCT
+        p->cycles = 0;
+#endif
 	p->cutime = p->cstime = 0;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
diff -ur linux-2.6.7/kernel/sched.c linux-2.6.7-precacct/kernel/sched.c
--- linux-2.6.7/kernel/sched.c	2004-06-16 07:19:51.000000000 +0200
+++ linux-2.6.7-precacct/kernel/sched.c	2004-06-23 11:50:38.842667440
+0200
@@ -181,6 +181,14 @@
 
 #define task_hot(p, now, sd) ((now) - (p)->timestamp <
(sd)->cache_hot_time)
 
+
+
+#ifdef CONFIG_PRECISE_ACCT
+extern void update_process_cycles(void);
+DECLARE_PER_CPU( cycles_t, last_cycles );
+#endif
+
+
 /*
  * These are the runqueue data structures:
  */
@@ -2297,6 +2305,10 @@
 	}
 	prev->timestamp = now;
 
+#ifdef CONFIG_PRECISE_ACCT
+	update_process_cycles();
+#endif
+
 	if (likely(prev != next)) {
 		next->timestamp = now;
 		rq->nr_switches++;
@@ -3919,6 +3931,10 @@
 	for (i = 0; i < NR_CPUS; i++) {
 		prio_array_t *array;
 
+#ifdef CONFIG_PRECISE_ACCT
+		  per_cpu( last_cycles, i ) = get_cycles();
+#endif
+
 		rq = cpu_rq(i);
 		spin_lock_init(&rq->lock);
 		rq->active = rq->arrays;
diff -ur linux-2.6.7/kernel/softirq.c
linux-2.6.7-precacct/kernel/softirq.c
--- linux-2.6.7/kernel/softirq.c	2004-06-16 07:19:02.000000000 +0200
+++ linux-2.6.7-precacct/kernel/softirq.c	2004-06-18 16:50:01.000000000
+0200
@@ -35,6 +35,10 @@
    - Tasklets: serialized wrt itself.
  */
 
+#ifdef CONFIG_PRECISE_ACCT
+DECLARE_PER_CPU( cycles_t, last_cycles );
+#endif
+
 #ifndef __ARCH_IRQ_STAT
 irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
 EXPORT_SYMBOL(irq_stat);
@@ -75,6 +79,10 @@
 	struct softirq_action *h;
 	__u32 pending;
 	int max_restart = MAX_SOFTIRQ_RESTART;
+#ifdef CONFIG_PRECISE_ACCT
+	cycles_t td, t = get_cycles();
+	unsigned n;
+#endif
 
 	pending = local_softirq_pending();
 
@@ -84,14 +92,33 @@
 	local_softirq_pending() = 0;
 
 	local_irq_enable();
+#ifdef CONFIG_PRECISE_ACCT
+		n = 0;
+#endif
 
 	h = softirq_vec;
 
 	do {
-		if (pending & 1)
+        	if (pending & 1) {
+#ifdef CONFIG_PRECISE_ACCT
+	                t = get_cycles();
+#endif
+		  
 			h->action(h);
+#ifdef CONFIG_PRECISE_ACCT
+			td = get_cycles()-t;
+			per_cpu( last_cycles, smp_processor_id() ) += td;
+			if ( n <= TASKLET_SOFTIRQ )
+			  per_cpu( kstat, smp_processor_id() ).softirq_cycles[n] += td;
+			else
+			  per_cpu( kstat, smp_processor_id()
).softirq_cycles[TASKLET_SOFTIRQ+1] += td;
+#endif
+		}
 		h++;
 		pending >>= 1;
+#ifdef CONFIG_PRECISE_ACCT
+		n++;
+#endif
 	} while (pending);
 
 	local_irq_disable();
diff -ur linux-2.6.7/kernel/timer.c linux-2.6.7-precacct/kernel/timer.c
--- linux-2.6.7/kernel/timer.c	2004-06-16 07:19:52.000000000 +0200
+++ linux-2.6.7-precacct/kernel/timer.c	2004-06-18 15:26:41.000000000
+0200
@@ -68,6 +68,10 @@
 
 typedef struct tvec_t_base_s tvec_base_t;
 
+#ifdef CONFIG_PRECISE_ACCT
+DEFINE_PER_CPU( cycles_t, last_cycles );
+#endif
+
 static inline void set_running_timer(tvec_base_t *base,
 					struct timer_list *timer)
 {
@@ -852,6 +856,24 @@
 }
 
 /*
+ * Called from the scheduler.
+ */
+#ifdef CONFIG_PRECISE_ACCT
+void update_process_cycles(void)
+{
+	struct task_struct *p = current;
+	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
+	int cpu = smp_processor_id();
+	cycles_t t = get_cycles();
+
+	p->cycles += t - per_cpu( last_cycles, cpu );
+	if ( p->pid )
+	    cpustat->used_cycles += t - per_cpu( last_cycles, cpu );
+	per_cpu( last_cycles, cpu ) = t;
+}
+#endif
+
+/*
  * Nr of active tasks - counted in fixed-point numbers
  */
 static unsigned long count_active_tasks(void)


