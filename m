Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265091AbRFUSb1>; Thu, 21 Jun 2001 14:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbRFUSbU>; Thu, 21 Jun 2001 14:31:20 -0400
Received: from archive.osdlab.org ([65.201.151.11]:48783 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S265091AbRFUSbJ>;
	Thu, 21 Jun 2001 14:31:09 -0400
Date: Thu, 21 Jun 2001 11:31:07 -0700
From: Zach Brown <zab@osdlab.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] cutting up struct kernel_stat into cpu_stat
Message-ID: <20010621113107.A16934@osdlab.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch-in-progress removes the per-cpu statistics from
struct kernel_stat and puts them in a cpu_stat structure, one per cpu,
cacheline padded.  The data is still coolated and presented through
/proc/stat, but another file /proc/cpustat is also added.  The locking
is as nonexistant as it was with kernel_stat, but who cares, they're
just fuzzy stats to be eyeballed by system tuners :).

A tool for printing the cpu stats specifically can be found near:

	http://www.osdlab.org/sw_resources/cpustat/index.shtml

Its output is almost identical to solaris' mpstat.  

I'm not sure I like the macro use, but it shields the callers from the
union garbage.  We can easily also make a THIS_CPU_STAT_ADD() interface,
as some have hinted would be nice :)

Currently its mostly ( :) ) only collecting the stats that were
collected in kernel_stat.  I'd like to add more stats -- page faults,
syscalls, cross-cpu calls, etc.  I understand people not wanting more
live cachelines in the fast paths.  I can make CPU_CRITICAL_STAT defines
that are config-ed out..

comments?  If its ok I can whip up a patch that updates all the ports
use of ->irqs[] as well.

- z
[ heading out for lunch :) ]

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpustat-2.4.5-1.diff"

--- linux-2.4.5-cpustat/fs/proc/proc_misc.c.cpustat	Fri Apr 13 20:26:07 2001
+++ linux-2.4.5-cpustat/fs/proc/proc_misc.c	Thu Jun 21 12:23:49 2001
@@ -265,32 +265,36 @@
 	int i, len;
 	extern unsigned long total_forks;
 	unsigned long jif = jiffies;
-	unsigned int sum = 0, user = 0, nice = 0, system = 0;
+	unsigned int sum = 0, user = 0, nice = 0, system = 0, ctxt = 0;
 	int major, disk;
 
 	for (i = 0 ; i < smp_num_cpus; i++) {
 		int cpu = cpu_logical_map(i), j;
 
-		user += kstat.per_cpu_user[cpu];
-		nice += kstat.per_cpu_nice[cpu];
-		system += kstat.per_cpu_system[cpu];
+		user += CPU_STAT_VAL(cpu, user);
+		nice += CPU_STAT_VAL(cpu, nice);
+		system += CPU_STAT_VAL(cpu, system);
+		ctxt += CPU_STAT_VAL(cpu, context_swtch);
 #if !defined(CONFIG_ARCH_S390)
 		for (j = 0 ; j < NR_IRQS ; j++)
-			sum += kstat.irqs[cpu][j];
+			sum += CPU_STAT_VAL(cpu, irqs[j]);
 #endif
 	}
 
 	len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
 		      jif * smp_num_cpus - (user + nice + system));
-	for (i = 0 ; i < smp_num_cpus; i++)
+	for (i = 0 ; i < smp_num_cpus; i++) {
+		unsigned int user_i, nice_i, system_i;
+
+		user_i = CPU_STAT_VAL(cpu_logical_map(i), user);
+		nice_i = CPU_STAT_VAL(cpu_logical_map(i), nice);
+		system_i = CPU_STAT_VAL(cpu_logical_map(i), system);
+
 		len += sprintf(page + len, "cpu%d %u %u %u %lu\n",
 			i,
-			kstat.per_cpu_user[cpu_logical_map(i)],
-			kstat.per_cpu_nice[cpu_logical_map(i)],
-			kstat.per_cpu_system[cpu_logical_map(i)],
-			jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
-			           + kstat.per_cpu_nice[cpu_logical_map(i)] \
-			           + kstat.per_cpu_system[cpu_logical_map(i)]));
+			user_i, nice_i, system_i, 
+			jif - (  user_i + nice_i + system_i ) );
+	}
 	len += sprintf(page + len,
 		"page %u %u\n"
                 "swap %u %u\n"
@@ -330,13 +334,58 @@
 		"\nctxt %u\n"
 		"btime %lu\n"
 		"processes %lu\n",
-		kstat.context_swtch,
+		ctxt, 
 		xtime.tv_sec - jif / HZ,
 		total_forks);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+static int cstat_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	int i, len;
+
+	len = sprintf(page, "cpu_stat 0.0\n");
+
+	for (i = 0 ; i < smp_num_cpus; i++) {
+		unsigned int user, nice, system;
+		int j, cpu = cpu_logical_map(i);
+
+#if !defined(CONFIG_ARCH_S390)
+		len += sprintf(page + len, "cpu%d irqs ",  cpu);
+		for (j = 0 ; j < NR_IRQS ; j++) {
+			len += sprintf(page + len, " %u", 
+				CPU_STAT_VAL(cpu, irqs[j]));
+		}
+		len += sprintf(page + len, "\n");
+#endif
+#if defined(CONFIG_SMP)
+		len += sprintf(page + len, "cpu%d context_migration %u\n",  
+			cpu, CPU_STAT_VAL(cpu, context_migration));
+#endif
+		len += sprintf(page + len, "cpu%d bottom_halves %u\n",  
+			cpu, CPU_STAT_VAL(cpu, bh));
+		len += sprintf(page + len, "cpu%d context_switches %u\n",  
+			cpu, CPU_STAT_VAL(cpu, context_swtch));
+
+		user = CPU_STAT_VAL(cpu_logical_map(i), user);
+		nice = CPU_STAT_VAL(cpu_logical_map(i), nice);
+		system = CPU_STAT_VAL(cpu_logical_map(i), system);
+
+		len += sprintf(page + len, "cpu%d user_time %u\n",  
+			cpu, user);
+		len += sprintf(page + len, "cpu%d nice_time %u\n",  
+			cpu, nice);
+		len += sprintf(page + len, "cpu%d system_time %u\n",  
+			cpu, system);
+		len += sprintf(page + len, "cpu%d unaccounted_time %u\n",  
+			cpu, jiffies - (  user + nice + system ) );
+	}
+
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
 static int devices_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -532,6 +581,7 @@
 		{"ksyms",	ksyms_read_proc},
 #endif
 		{"stat",	kstat_read_proc},
+		{"cpustat",	cstat_read_proc},
 		{"devices",	devices_read_proc},
 		{"partitions",	partitions_read_proc},
 #if !defined(CONFIG_ARCH_S390)
--- linux-2.4.5-cpustat/kernel/sched.c.cpustat	Fri Apr 20 18:26:16 2001
+++ linux-2.4.5-cpustat/kernel/sched.c	Thu Jun 21 12:01:34 2001
@@ -107,6 +107,8 @@
 
 struct kernel_stat kstat;
 
+union cpu_stat_u cpu_stats[NR_CPUS] __cacheline_aligned = { {{0, }}};
+
 #ifdef CONFIG_SMP
 
 #define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
@@ -607,6 +609,7 @@
 	sched_data->curr = next;
 #ifdef CONFIG_SMP
  	next->has_cpu = 1;
+	CPU_STAT_ADD(this_cpu, context_migration, next->processor != this_cpu ); 
 	next->processor = this_cpu;
 #endif
 	spin_unlock_irq(&runqueue_lock);
@@ -632,7 +635,7 @@
 
 #endif /* CONFIG_SMP */
 
-	kstat.context_swtch++;
+	CPU_STAT_ADD(this_cpu, context_swtch, 1);
 	/*
 	 * there are 3 processes which are affected by a context switch:
 	 *
--- linux-2.4.5-cpustat/kernel/timer.c.cpustat	Sun Dec 10 09:53:19 2000
+++ linux-2.4.5-cpustat/kernel/timer.c	Wed Jun 20 13:45:06 2001
@@ -588,12 +588,12 @@
 			p->need_resched = 1;
 		}
 		if (p->nice > 0)
-			kstat.per_cpu_nice[cpu] += user_tick;
+			CPU_STAT_ADD(cpu, nice, user_tick);
 		else
-			kstat.per_cpu_user[cpu] += user_tick;
-		kstat.per_cpu_system[cpu] += system;
+			CPU_STAT_ADD(cpu, user, user_tick);
+		CPU_STAT_ADD(cpu, system, system);
 	} else if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
-		kstat.per_cpu_system[cpu] += system;
+		CPU_STAT_ADD(cpu, system, system);
 }
 
 /*
--- linux-2.4.5-cpustat/kernel/softirq.c.cpustat	Fri Dec 29 14:07:24 2000
+++ linux-2.4.5-cpustat/kernel/softirq.c	Thu Jun 21 11:29:01 2001
@@ -74,7 +74,7 @@
 		mask &= ~active;
 
 		do {
-			if (active & 1)
+			if (active & 1) 
 				h->action(h);
 			h++;
 			active >>= 1;
@@ -253,8 +253,10 @@
 	if (!hardirq_trylock(cpu))
 		goto resched_unlock;
 
-	if (bh_base[nr])
+	if (bh_base[nr]) {
 		bh_base[nr]();
+		CPU_STAT_ADD(cpu, bh, 1);
+	}
 
 	hardirq_endlock(cpu);
 	spin_unlock(&global_bh_lock);
--- linux-2.4.5-cpustat/include/linux/kernel_stat.h.cpustat	Fri May 25 18:01:27 2001
+++ linux-2.4.5-cpustat/include/linux/kernel_stat.h	Thu Jun 21 11:28:52 2001
@@ -16,9 +16,6 @@
 #define DK_MAX_DISK 16
 
 struct kernel_stat {
-	unsigned int per_cpu_user[NR_CPUS],
-	             per_cpu_nice[NR_CPUS],
-	             per_cpu_system[NR_CPUS];
 	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
@@ -26,17 +23,33 @@
 	unsigned int dk_drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int pgpgin, pgpgout;
 	unsigned int pswpin, pswpout;
-#if !defined(CONFIG_ARCH_S390)
-	unsigned int irqs[NR_CPUS][NR_IRQS];
-#endif
 	unsigned int ipackets, opackets;
 	unsigned int ierrors, oerrors;
 	unsigned int collisions;
-	unsigned int context_swtch;
 };
 
 extern struct kernel_stat kstat;
 
+union cpu_stat_u {
+	struct cpu_stat { 
+		unsigned int user, nice, system;
+		unsigned int context_swtch;
+		unsigned int bh;
+#if defined(CONFIG_SMP)
+		unsigned int context_migration;
+#endif
+#if !defined(CONFIG_ARCH_S390)
+		unsigned int irqs[NR_IRQS];
+#endif
+	} cs;
+	char __pad [SMP_CACHE_BYTES];
+}; 
+
+extern union cpu_stat_u cpu_stats[NR_CPUS];
+
+#define CPU_STAT_ADD(CPU, STAT, VAL) cpu_stats[CPU].cs.STAT += VAL
+#define CPU_STAT_VAL(CPU, STAT) cpu_stats[CPU].cs.STAT
+
 #if !defined(CONFIG_ARCH_S390)
 /*
  * Number of interrupts per specific IRQ source, since bootup
@@ -46,7 +59,7 @@
 	int i, sum=0;
 
 	for (i = 0 ; i < smp_num_cpus ; i++)
-		sum += kstat.irqs[cpu_logical_map(i)][irq];
+		sum += CPU_STAT_VAL(cpu_logical_map(i), irqs[irq]);
 
 	return sum;
 }
--- linux-2.4.5-cpustat/arch/i386/kernel/irq.c.cpustat	Fri Feb  9 11:29:44 2001
+++ linux-2.4.5-cpustat/arch/i386/kernel/irq.c	Wed Jun 20 14:02:34 2001
@@ -146,7 +146,7 @@
 #else
 		for (j = 0; j < smp_num_cpus; j++)
 			p += sprintf(p, "%10u ",
-				kstat.irqs[cpu_logical_map(j)][i]);
+				CPU_STAT_VAL(cpu_logical_map(j), irqs[i]));
 #endif
 		p += sprintf(p, " %14s", irq_desc[i].handler->typename);
 		p += sprintf(p, "  %s", action->name);
@@ -564,7 +564,7 @@
 	struct irqaction * action;
 	unsigned int status;
 
-	kstat.irqs[cpu][irq]++;
+	CPU_STAT_ADD(cpu, irqs[irq], 1);
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
 	/*

--Q68bSM7Ycu6FN28Q--
