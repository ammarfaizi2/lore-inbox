Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265495AbRGBXhE>; Mon, 2 Jul 2001 19:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265494AbRGBXgp>; Mon, 2 Jul 2001 19:36:45 -0400
Received: from archive.osdlab.org ([65.201.151.11]:26340 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S265496AbRGBXgd>;
	Mon, 2 Jul 2001 19:36:33 -0400
Date: Mon, 2 Jul 2001 16:36:31 -0700
From: Zach Brown <zab@osdlab.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] struct kernel_stat -> struct cpu_stat[NR_CPUS]
Message-ID: <20010702163631.B9806@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently struct kernel_stat has a few pre cpu arrays.  This creates
cacheline exchange noise as the cpus update their entries in each array.
This patch creates an array of per cpu structs.  The structure is padded
to the length of a cacheline.  The meat of the patch against 2.4.6-pre8
is attached.  The rest of the patch is rather large because it touches
all the architectures' use of ks->irqs[], and can be found at

	http://www.osdlab.org/sw_resources/cpustat/cpustat-2.4.6.pre8-1.diff

These per cpu statistics are reported via a new /proc/cpustat, a quick
tool for processing that output, vmstat-style, can be found near

	http://www.osdlab.org/sw_resources/cpustat/index.shtml

In addition to shuffling structures around, the patch adds the recording
of context scheduling migrations as well as "minor", "major", and
"cow" faults.

I'd really like to hear what people think of the patch.  Unless someone
strongly is dead set against it, I'd like to send it off to Linus and
move on to other things :)  Would arch maintainers rather that I fed
them per-arch patches for their trees?

- z

--- linux-2.4.6-pre8/fs/proc/proc_misc.c.cpustat	Fri Apr 13 20:26:07 2001
+++ linux-2.4.6-pre8/fs/proc/proc_misc.c	Mon Jul  2 15:04:49 2001
@@ -265,32 +265,37 @@
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
+		user += cpu_stat[cpu].user;
+		nice += cpu_stat[cpu].nice;
+		system += cpu_stat[cpu].system;
+		ctxt += cpu_stat[cpu].context_swtch;
 #if !defined(CONFIG_ARCH_S390)
 		for (j = 0 ; j < NR_IRQS ; j++)
-			sum += kstat.irqs[cpu][j];
+			sum += cpu_stat[cpu].irqs[j];
 #endif
 	}
 
 	len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
 		      jif * smp_num_cpus - (user + nice + system));
-	for (i = 0 ; i < smp_num_cpus; i++)
+	for (i = 0 ; i < smp_num_cpus; i++) {
+		unsigned int user_i, nice_i, system_i;
+		int cpu = cpu_logical_map(i);
+
+		user_i = cpu_stat[cpu].user;
+		nice_i = cpu_stat[cpu].nice;
+		system_i = cpu_stat[cpu].system;
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
@@ -330,13 +335,64 @@
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
+		struct cpu_stat *cs = &cpu_stat[cpu];
+
+#if !defined(CONFIG_ARCH_S390)
+		len += sprintf(page + len, "cpu%d irqs ",  cpu);
+		for (j = 0 ; j < NR_IRQS ; j++) {
+			len += sprintf(page + len, " %u", 
+				cs->irqs[j]);
+		}
+		len += sprintf(page + len, "\n");
+#endif
+#if defined(CONFIG_SMP)
+		len += sprintf(page + len, "cpu%d context_migration %u\n",  
+			cpu, cs->context_migration);
+#endif
+		len += sprintf(page + len, "cpu%d context_switches %u\n",  
+			cpu, cs->context_swtch);
+
+		len += sprintf(page + len, "cpu%d major_faults %u\n",  
+			cpu, cs->major_fault);
+		len += sprintf(page + len, "cpu%d minor_faults %u\n",  
+			cpu, cs->minor_fault);
+		len += sprintf(page + len, "cpu%d cow_faults %u\n",  
+			cpu, cs->cow_fault);
+
+		user = cs->user;
+		nice = cs->nice;
+		system = cs->system;
+
+		len += sprintf(page + len, "cpu%d user_time %u\n",  
+			cpu, user);
+		len += sprintf(page + len, "cpu%d nice_time %u\n",  
+			cpu, nice);
+		len += sprintf(page + len, "cpu%d system_time %u\n",  
+			cpu, system);
+		len += sprintf(page + len, "cpu%d unaccounted_time %lu\n",  
+			cpu, jiffies - (  user + nice + system ) );
+	}
+
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
 static int devices_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -532,6 +588,7 @@
 		{"ksyms",	ksyms_read_proc},
 #endif
 		{"stat",	kstat_read_proc},
+		{"cpustat",	cstat_read_proc},
 		{"devices",	devices_read_proc},
 		{"partitions",	partitions_read_proc},
 #if !defined(CONFIG_ARCH_S390)
--- linux-2.4.6-pre8/kernel/sched.c.cpustat	Mon Jul  2 15:04:21 2001
+++ linux-2.4.6-pre8/kernel/sched.c	Mon Jul  2 15:04:49 2001
@@ -107,6 +107,8 @@
 
 struct kernel_stat kstat;
 
+struct cpu_stat cpu_stat[NR_CPUS] __cacheline_aligned = { { 0, } };
+
 #ifdef CONFIG_SMP
 
 #define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
@@ -607,6 +609,7 @@
 	sched_data->curr = next;
 #ifdef CONFIG_SMP
  	next->has_cpu = 1;
+	cpu_stat[this_cpu].context_migration += (next->processor != this_cpu);
 	next->processor = this_cpu;
 #endif
 	spin_unlock_irq(&runqueue_lock);
@@ -632,7 +635,7 @@
 
 #endif /* CONFIG_SMP */
 
-	kstat.context_swtch++;
+	cpu_stat[this_cpu].context_swtch++;
 	/*
 	 * there are 3 processes which are affected by a context switch:
 	 *
--- linux-2.4.6-pre8/kernel/timer.c.cpustat	Mon Jul  2 15:04:21 2001
+++ linux-2.4.6-pre8/kernel/timer.c	Mon Jul  2 15:04:49 2001
@@ -588,12 +588,12 @@
 			p->need_resched = 1;
 		}
 		if (p->nice > 0)
-			kstat.per_cpu_nice[cpu] += user_tick;
+			cpu_stat[cpu].nice += user_tick;
 		else
-			kstat.per_cpu_user[cpu] += user_tick;
-		kstat.per_cpu_system[cpu] += system;
+			cpu_stat[cpu].user += user_tick;
+		cpu_stat[cpu].system += system;
 	} else if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
-		kstat.per_cpu_system[cpu] += system;
+		cpu_stat[cpu].system += system;
 }
 
 /*
--- linux-2.4.6-pre8/mm/memory.c.cpustat	Mon Jul  2 15:04:21 2001
+++ linux-2.4.6-pre8/mm/memory.c	Mon Jul  2 15:04:49 2001
@@ -48,6 +48,8 @@
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
 
+#include <linux/kernel_stat.h>
+
 unsigned long max_mapnr;
 unsigned long num_physpages;
 void * high_memory;
@@ -931,6 +933,7 @@
 			break;
 		flush_cache_page(vma, address);
 		establish_pte(vma, address, page_table, pte_mkyoung(pte_mkdirty(pte_mkwrite(pte))));
+		THIS_CPU_STAT_ADD(minor_fault, 1);
 		return 1;	/* Minor fault */
 	}
 
@@ -955,6 +958,7 @@
 		new_page = old_page;
 	}
 	page_cache_release(new_page);
+	THIS_CPU_STAT_ADD(cow_fault, 1);
 	return 1;	/* Minor fault */
 
 bad_wp_page:
@@ -1250,6 +1254,7 @@
 
 	/* no need to invalidate: a not-present page shouldn't be cached */
 	update_mmu_cache(vma, address, entry);
+	THIS_CPU_STAT_ADD(major_fault, 1);
 	return 2;	/* Major fault */
 }
 
--- linux-2.4.6-pre8/include/linux/kernel_stat.h.cpustat	Fri May 25 18:01:27 2001
+++ linux-2.4.6-pre8/include/linux/kernel_stat.h	Mon Jul  2 15:09:45 2001
@@ -16,9 +16,6 @@
 #define DK_MAX_DISK 16
 
 struct kernel_stat {
-	unsigned int per_cpu_user[NR_CPUS],
-	             per_cpu_nice[NR_CPUS],
-	             per_cpu_system[NR_CPUS];
 	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
@@ -26,17 +23,35 @@
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
 
+struct cpu_stat { 
+	unsigned int user, nice, system;
+	unsigned long major_fault, minor_fault, cow_fault;
+	unsigned int context_swtch;
+#if defined(CONFIG_SMP)
+	unsigned long context_migration;
+#endif
+#if !defined(CONFIG_ARCH_S390)
+	unsigned int irqs[NR_IRQS];
+#endif
+
+	char __padding_dummy[0] ____cacheline_aligned;
+};
+
+extern struct cpu_stat cpu_stat[NR_CPUS];
+
+#define THIS_CPU_STAT_ADD(STAT, VAL) cpu_stat[current->processor].STAT += VAL
+/*
+ * 'CPU' as returned by smp_processor_id() or cpu_logical_map(0..smp_num_cpus)
+ */ 
+#define CPU_STAT_IRQ_INC(CPU, IRQ) cpu_stat[CPU].irqs[IRQ]++
+
 #if !defined(CONFIG_ARCH_S390)
 /*
  * Number of interrupts per specific IRQ source, since bootup
@@ -46,7 +61,7 @@
 	int i, sum=0;
 
 	for (i = 0 ; i < smp_num_cpus ; i++)
-		sum += kstat.irqs[cpu_logical_map(i)][irq];
+		sum += cpu_stat[cpu_logical_map(i)].irqs[irq];
 
 	return sum;
 }
--- linux-2.4.6-pre8/arch/i386/kernel/irq.c.cpustat	Mon Jul  2 15:04:19 2001
+++ linux-2.4.6-pre8/arch/i386/kernel/irq.c	Mon Jul  2 15:09:58 2001
@@ -152,7 +152,7 @@
 #else
 		for (j = 0; j < smp_num_cpus; j++)
 			p += sprintf(p, "%10u ",
-				kstat.irqs[cpu_logical_map(j)][i]);
+				cpu_stat[cpu_logical_map(j)].irqs[i]);
 #endif
 		p += sprintf(p, " %14s", irq_desc[i].handler->typename);
 		p += sprintf(p, "  %s", action->name);
@@ -575,7 +575,7 @@
 	struct irqaction * action;
 	unsigned int status;
 
-	kstat.irqs[cpu][irq]++;
+	CPU_STAT_IRQ_INC(cpu, irq);
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
 	/*
