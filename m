Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262597AbSJVOB0>; Tue, 22 Oct 2002 10:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262617AbSJVOB0>; Tue, 22 Oct 2002 10:01:26 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:5095 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262597AbSJVOBW>;
	Tue, 22 Oct 2002 10:01:22 -0400
Date: Tue, 22 Oct 2002 19:41:11 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: [patch] kstat cleanup
Message-ID: <20021022194111.A27878@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
Here's the kstat cleanup you'd suggested sometime ago.
I have used Rusty's per_cpu infrastructure for the stats now.
Here're the changes in short.

1. Break out disk stats from kernel_stat and move disk stat to blkdev.h
2. Group cpu stat in kernel_stat and make them "per_cpu" instead of
   the NR_CPUS array
3. Remove EXPORT_SYMBOL(kstat) from ksyms.c (as I noticed that no module is
   using kstat)

The foll patch is tested on a 4 way PIII xeon. This patch has changes
for i386 files (+ arch independent changes)(.. it'll break other archs).  
I am in the process of changing other archs.  Patch for the same to follow 
soon. In the meanwhile, do let me know if the patch is ok by you. Patch
applies neatly on 2.5..44-mm2

Thanks,
Kiran


diff -ruN linux-2.5.44-mm2/arch/i386/kernel/irq.c kstat-2.5.44-mm2/arch/i386/kernel/irq.c
--- linux-2.5.44-mm2/arch/i386/kernel/irq.c	Tue Oct 22 16:09:14 2002
+++ kstat-2.5.44-mm2/arch/i386/kernel/irq.c	Tue Oct 22 16:06:03 2002
@@ -153,7 +153,7 @@
 		for (j = 0; j < NR_CPUS; j++)
 			if (cpu_online(j))
 				p += seq_printf(p, "%10u ",
-					     kstat.irqs[j][i]);
+					     kstat_cpu(j).irqs[i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
@@ -344,7 +344,7 @@
 		show_stack((void *)esp);
 	}
 #endif
-	kstat.irqs[cpu][irq]++;
+	kstat_cpu(cpu).irqs[irq]++;
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
 	/*
diff -ruN linux-2.5.44-mm2/arch/i386/mach-visws/visws_apic.c kstat-2.5.44-mm2/arch/i386/mach-visws/visws_apic.c
--- linux-2.5.44-mm2/arch/i386/mach-visws/visws_apic.c	Tue Oct 22 16:09:14 2002
+++ kstat-2.5.44-mm2/arch/i386/mach-visws/visws_apic.c	Tue Oct 22 16:06:04 2002
@@ -324,7 +324,7 @@
 	/*
 	 * handle this 'virtual interrupt' as a Cobalt one now.
 	 */
-	kstat.irqs[smp_processor_id()][irq]++;
+	kstat_cpu(smp_processor_id()).irqs[irq]++;
 	do_cobalt_IRQ(realirq, regs);
 
 	spin_lock(&irq_controller_lock);
diff -ruN linux-2.5.44-mm2/drivers/block/ll_rw_blk.c kstat-2.5.44-mm2/drivers/block/ll_rw_blk.c
--- linux-2.5.44-mm2/drivers/block/ll_rw_blk.c	Tue Oct 22 16:09:14 2002
+++ kstat-2.5.44-mm2/drivers/block/ll_rw_blk.c	Tue Oct 22 16:06:04 2002
@@ -27,6 +27,10 @@
 #include <linux/completion.h>
 #include <linux/slab.h>
 
+/*
+ * Disk stats 
+ */
+struct disk_stat dkstat;
 
 /*
  * For the allocated request tables
@@ -1441,13 +1445,13 @@
 	if ((index >= DK_MAX_DISK) || (major >= DK_MAX_MAJOR))
 		return;
 
-	kstat.dk_drive[major][index] += new_io;
+	dkstat.drive[major][index] += new_io;
 	if (rw == READ) {
-		kstat.dk_drive_rio[major][index] += new_io;
-		kstat.dk_drive_rblk[major][index] += nr_sectors;
+		dkstat.drive_rio[major][index] += new_io;
+		dkstat.drive_rblk[major][index] += nr_sectors;
 	} else if (rw == WRITE) {
-		kstat.dk_drive_wio[major][index] += new_io;
-		kstat.dk_drive_wblk[major][index] += nr_sectors;
+		dkstat.drive_wio[major][index] += new_io;
+		dkstat.drive_wblk[major][index] += nr_sectors;
 	} else
 		printk(KERN_ERR "drive_stat_acct: cmd not R/W?\n");
 }
diff -ruN linux-2.5.44-mm2/fs/proc/proc_misc.c kstat-2.5.44-mm2/fs/proc/proc_misc.c
--- linux-2.5.44-mm2/fs/proc/proc_misc.c	Tue Oct 22 16:09:29 2002
+++ kstat-2.5.44-mm2/fs/proc/proc_misc.c	Tue Oct 22 16:06:04 2002
@@ -348,14 +348,14 @@
 		int j;
 
 		if(!cpu_online(i)) continue;
-		user += kstat.per_cpu_user[i];
-		nice += kstat.per_cpu_nice[i];
-		system += kstat.per_cpu_system[i];
-		idle += kstat.per_cpu_idle[i];
-		iowait += kstat.per_cpu_iowait[i];
+		user += kstat_cpu(i).cpustat.user;
+		nice += kstat_cpu(i).cpustat.nice;
+		system += kstat_cpu(i).cpustat.system;
+		idle += kstat_cpu(i).cpustat.idle;
+		iowait += kstat_cpu(i).cpustat.iowait;
 #if !defined(CONFIG_ARCH_S390)
 		for (j = 0 ; j < NR_IRQS ; j++)
-			sum += kstat.irqs[i][j];
+			sum += kstat_cpu(i).irqs[j];
 #endif
 	}
 
@@ -369,11 +369,11 @@
 		if (!cpu_online(i)) continue;
 		len += sprintf(page + len, "cpu%d %u %u %u %u %u\n",
 			i,
-			jiffies_to_clock_t(kstat.per_cpu_user[i]),
-			jiffies_to_clock_t(kstat.per_cpu_nice[i]),
-			jiffies_to_clock_t(kstat.per_cpu_system[i]),
-			jiffies_to_clock_t(kstat.per_cpu_idle[i]),
-			jiffies_to_clock_t(kstat.per_cpu_iowait[i]));
+			jiffies_to_clock_t(kstat_cpu(i).cpustat.user),
+			jiffies_to_clock_t(kstat_cpu(i).cpustat.nice),
+			jiffies_to_clock_t(kstat_cpu(i).cpustat.system),
+			jiffies_to_clock_t(kstat_cpu(i).cpustat.idle),
+			jiffies_to_clock_t(kstat_cpu(i).cpustat.idle));
 	}
 	len += sprintf(page + len, "intr %u", sum);
 
@@ -386,18 +386,18 @@
 
 	for (major = 0; major < DK_MAX_MAJOR; major++) {
 		for (disk = 0; disk < DK_MAX_DISK; disk++) {
-			int active = kstat.dk_drive[major][disk] +
-				kstat.dk_drive_rblk[major][disk] +
-				kstat.dk_drive_wblk[major][disk];
+			int active = dkstat.drive[major][disk] +
+				dkstat.drive_rblk[major][disk] +
+				dkstat.drive_wblk[major][disk];
 			if (active)
 				len += sprintf(page + len,
 					"(%u,%u):(%u,%u,%u,%u,%u) ",
 					major, disk,
-					kstat.dk_drive[major][disk],
-					kstat.dk_drive_rio[major][disk],
-					kstat.dk_drive_rblk[major][disk],
-					kstat.dk_drive_wio[major][disk],
-					kstat.dk_drive_wblk[major][disk]
+					dkstat.drive[major][disk],
+					dkstat.drive_rio[major][disk],
+					dkstat.drive_rblk[major][disk],
+					dkstat.drive_wio[major][disk],
+					dkstat.drive_wblk[major][disk]
 			);
 		}
 	}
diff -ruN linux-2.5.44-mm2/include/linux/blkdev.h kstat-2.5.44-mm2/include/linux/blkdev.h
--- linux-2.5.44-mm2/include/linux/blkdev.h	Tue Oct 22 16:09:29 2002
+++ kstat-2.5.44-mm2/include/linux/blkdev.h	Tue Oct 22 16:06:04 2002
@@ -11,6 +11,22 @@
 
 #include <asm/scatterlist.h>
 
+/*
+ * Disk stats ...
+ */
+
+#define DK_MAX_MAJOR 16
+#define DK_MAX_DISK 16
+ 
+struct disk_stat {
+        unsigned int drive[DK_MAX_MAJOR][DK_MAX_DISK];
+        unsigned int drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
+        unsigned int drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
+        unsigned int drive_rblk[DK_MAX_MAJOR][DK_MAX_DISK];
+        unsigned int drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
+};
+extern struct disk_stat dkstat;
+
 struct request_queue;
 typedef struct request_queue request_queue_t;
 struct elevator_s;
diff -ruN linux-2.5.44-mm2/include/linux/kernel_stat.h kstat-2.5.44-mm2/include/linux/kernel_stat.h
--- linux-2.5.44-mm2/include/linux/kernel_stat.h	Tue Oct 22 16:09:15 2002
+++ kstat-2.5.44-mm2/include/linux/kernel_stat.h	Tue Oct 22 16:06:08 2002
@@ -5,6 +5,7 @@
 #include <asm/irq.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
+#include <linux/percpu.h>
 
 /*
  * 'kernel_stat.h' contains the definitions needed for doing
@@ -12,26 +13,25 @@
  * used by rstatd/perfmeter
  */
 
-#define DK_MAX_MAJOR 16
-#define DK_MAX_DISK 16
+struct cpu_usage_stat {
+	unsigned int user;
+	unsigned int nice;
+	unsigned int system;
+	unsigned int idle;
+	unsigned int iowait;
+};
 
 struct kernel_stat {
-	unsigned int per_cpu_user[NR_CPUS],
-	             per_cpu_nice[NR_CPUS],
-	             per_cpu_system[NR_CPUS],
-	             per_cpu_idle[NR_CPUS],
-	             per_cpu_iowait[NR_CPUS];
-	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_rblk[DK_MAX_MAJOR][DK_MAX_DISK];
-	unsigned int dk_drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
+	struct cpu_usage_stat	cpustat;
 #if !defined(CONFIG_ARCH_S390)
-	unsigned int irqs[NR_CPUS][NR_IRQS];
+	unsigned int irqs[NR_IRQS];
 #endif
 };
 
-extern struct kernel_stat kstat;
+DECLARE_PER_CPU(struct kernel_stat, kstat);
+
+#define kstat_cpu(cpu)	per_cpu(kstat, cpu)
+#define kstat_this_cpu	kstat_cpu(smp_processor_id())
 
 extern unsigned long nr_context_switches(void);
 
@@ -50,8 +50,9 @@
 {
 	int i, sum=0;
 
-	for (i = 0 ; i < NR_CPUS ; i++)
-		sum += kstat.irqs[i][irq];
+	for (i = 0 ; i < NR_CPUS ; i++) 
+		if (cpu_possible(i)) 
+			sum += kstat_cpu(i).irqs[irq];
 
 	return sum;
 }
diff -ruN linux-2.5.44-mm2/kernel/ksyms.c kstat-2.5.44-mm2/kernel/ksyms.c
--- linux-2.5.44-mm2/kernel/ksyms.c	Tue Oct 22 16:09:29 2002
+++ kstat-2.5.44-mm2/kernel/ksyms.c	Tue Oct 22 16:06:08 2002
@@ -501,7 +501,6 @@
 EXPORT_SYMBOL(loops_per_jiffy);
 #endif
 
-EXPORT_SYMBOL(kstat);
 
 /* misc */
 EXPORT_SYMBOL(panic);
diff -ruN linux-2.5.44-mm2/kernel/sched.c kstat-2.5.44-mm2/kernel/sched.c
--- linux-2.5.44-mm2/kernel/sched.c	Tue Oct 22 16:09:29 2002
+++ kstat-2.5.44-mm2/kernel/sched.c	Tue Oct 22 16:08:51 2002
@@ -839,6 +839,8 @@
 
 #endif
 
+DEFINE_PER_CPU(struct kernel_stat, kstat);
+
 /*
  * We place interactive tasks back into the active array, if possible.
  *
@@ -872,21 +874,21 @@
 	if (p == rq->idle) {
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
-			kstat.per_cpu_system[cpu] += sys_ticks;
+			kstat_cpu(cpu).cpustat.system += sys_ticks;
 		else if (atomic_read(&nr_iowait_tasks) > 0)
-			kstat.per_cpu_iowait[cpu] += sys_ticks;
+			kstat_cpu(cpu).cpustat.iowait += sys_ticks;
 		else
-			kstat.per_cpu_idle[cpu] += sys_ticks;
+			kstat_cpu(cpu).cpustat.idle += sys_ticks;
 #if CONFIG_SMP
 		idle_tick(rq);
 #endif
 		return;
 	}
 	if (TASK_NICE(p) > 0)
-		kstat.per_cpu_nice[cpu] += user_ticks;
+		kstat_cpu(cpu).cpustat.nice += user_ticks;
 	else
-		kstat.per_cpu_user[cpu] += user_ticks;
-	kstat.per_cpu_system[cpu] += sys_ticks;
+		kstat_cpu(cpu).cpustat.user += user_ticks;
+	kstat_cpu(cpu).cpustat.system += sys_ticks;
 
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
@@ -2115,6 +2117,38 @@
 #endif
 
 #if CONFIG_SMP || CONFIG_PREEMPT
+
+static void kstat_init_cpu(int cpu)
+{
+        /* Add any initialisation to kstat here */
+        /* Useful when cpu offlining logic is added.. */
+}
+ 
+static void kstat_cpu_notify(struct notifier_block *self,
+                                unsigned long action, void *hcpu)
+{
+	int cpu = (unsigned long)hcpu;
+	switch(action) {
+	case CPU_UP_PREPARE:
+		kstat_init_cpu(cpu);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+ 
+static struct notifier_block kstat_nb = {
+	.notifier_call  = kstat_cpu_notify,
+	.next           = NULL,
+};
+
+__init static void init_kstat(void) {
+	kstat_cpu_notify(&kstat_nb, (unsigned long)CPU_UP_PREPARE,
+			(void *)(long)smp_processor_id());
+	register_cpu_notifier(&kstat_nb);  
+}
+
 /*
  * The 'big kernel lock'
  *
@@ -2133,6 +2167,8 @@
 	runqueue_t *rq;
 	int i, j, k;
 
+	/* Init the kstat counters */
+	init_kstat()
 	for (i = 0; i < NR_CPUS; i++) {
 		prio_array_t *array;
 
diff -ruN linux-2.5.44-mm2/kernel/timer.c kstat-2.5.44-mm2/kernel/timer.c
--- linux-2.5.44-mm2/kernel/timer.c	Tue Oct 22 16:09:29 2002
+++ kstat-2.5.44-mm2/kernel/timer.c	Tue Oct 22 16:06:08 2002
@@ -440,7 +440,6 @@
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */
 
-struct kernel_stat kstat;
 
 /*
  * phase-lock loop variables
