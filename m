Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261303AbTCJMNH>; Mon, 10 Mar 2003 07:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261304AbTCJMNH>; Mon, 10 Mar 2003 07:13:07 -0500
Received: from relay2.uni-heidelberg.de ([129.206.210.211]:12445 "EHLO
	relay2.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S261303AbTCJMM6>; Mon, 10 Mar 2003 07:12:58 -0500
Date: Mon, 10 Mar 2003 13:23:33 +0100 (MET)
From: Timm Morten Steinbeck <timm@kip.uni-heidelberg.de>
To: linux-kernel@vger.kernel.org
cc: Arne Wiebalck <wiebalck@kip.uni-heidelberg.de>,
       Jan Astalos <Jan.Astalos@tuke.sk>
Subject: Linux Kernel Precise Accounting (2.4.20)
Message-ID: <Pine.HPX.4.43.0303101257210.25962-100000@electra.kip.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

we have developed a patch for a more precise CPU usage accounting.

The accounting in the standard kernel via the "cpu*" lines from /proc/stat
can produce misleading data for programs that give up the rest of their
timeslice, e.g. via usleep.

Our patch is based on the precise accounting patch for 2.2.14 and 2.4.0 by
Jan Astalos
(http://www.beowulf.org/pipermail/beowulf/2000-February/008415.html) and
uses the CPU time-stamp-counter on x86 CPUs for a clock-tick granularity.
We have enhanced the original patch for more current kernels (2.4.20 and
2.4.18 on our website (see below)), SMP capability, accounting of
interrupts and Soft-IRQs, and global as well as process-wise accounting.

With the patch the context switch latency increases by 10% (from 0.89
usec. to 0.97 usec. for 0k process size) as measured with lmbench.

The patch for 2.4.20 and 2.4.18 can be found at:
http://www.ti.uni-hd.de/HLT/documentation/software-and-documentation.html#kernel

The version for 2.4.20 is attached to this mail.

Please CC all comments to timm.steinbeck AT kip.uni-heidelberg.de and
arne.wiebalck AT kip.uni-heidelberg.de, as we are not subscribed to the
LKML.

Best regards
  Arne & Timm

************************************************************************
 Timm M. Steinbeck                      Kirchhoff Institute for Physics
 Arne Wiebalck                               Technical Computer Science
                                                    INF 227, Room 3.315
                                                     D-69120 Heidelberg

 e-mail: timm.steinbeck AT kip.uni-heidelberg.de  Tel.: (+49) 6221/54-9816
 web   : http://www.kip.uni-heidelberg.de      Fax.: (+49) 6221/54-9809
************************************************************************


-----------------------------8<------------------------------------

diff -ur linux-2.4.20/Makefile linux-2.4.20-pa/Makefile
--- linux-2.4.20/Makefile	Fri Nov 29 00:53:16 2002
+++ linux-2.4.20-pa/Makefile	Tue Feb  4 10:12:45 2003
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 20
-EXTRAVERSION =
+EXTRAVERSION = -precacct

 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

diff -ur linux-2.4.20/arch/i386/config.in linux-2.4.20-pa/arch/i386/config.in
--- linux-2.4.20/arch/i386/config.in	Fri Nov 29 00:53:09 2002
+++ linux-2.4.20-pa/arch/i386/config.in	Tue Feb  4 10:11:58 2003
@@ -285,6 +285,9 @@

 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
+if [ "$CONFIG_X86_TSC" = "y" ]; then
+  bool 'Precise accounting' CONFIG_PRECISE_ACCT
+fi
 bool 'Sysctl support' CONFIG_SYSCTL
 if [ "$CONFIG_PROC_FS" = "y" ]; then
    choice 'Kernel core (/proc/kcore) format' \
diff -ur linux-2.4.20/arch/i386/kernel/apic.c linux-2.4.20-pa/arch/i386/kernel/apic.c
--- linux-2.4.20/arch/i386/kernel/apic.c	Fri Nov 29 00:53:09 2002
+++ linux-2.4.20-pa/arch/i386/kernel/apic.c	Tue Feb  4 10:11:58 2003
@@ -38,6 +38,8 @@
 int prof_old_multiplier[NR_CPUS] = { 1, };
 int prof_counter[NR_CPUS] = { 1, };

+extern unsigned long cycles_per_jiffie;
+
 int get_maxlvt(void)
 {
 	unsigned int v, ver, maxlvt;
@@ -910,6 +912,8 @@
 	printk("..... host bus clock speed is %ld.%04ld MHz.\n",
 		result/(1000000/HZ),
 		result%(1000000/HZ));
+
+	cycles_per_jiffie = (long)(t2-t1)/LOOPS;

 	return result;
 }
diff -ur linux-2.4.20/arch/i386/kernel/irq.c linux-2.4.20-pa/arch/i386/kernel/irq.c
--- linux-2.4.20/arch/i386/kernel/irq.c	Fri Nov 29 00:53:09 2002
+++ linux-2.4.20-pa/arch/i386/kernel/irq.c	Tue Feb  4 10:13:48 2003
@@ -183,6 +183,70 @@
 }


+#ifdef CONFIG_PRECISE_ACCT
+int get_irq_cycles_list(char *buf)
+{
+	int i, j;
+	struct irqaction * action;
+	char *p = buf;
+
+	p += sprintf(p, "                       ");
+	for (j=0; j<smp_num_cpus; j++)
+		p += sprintf(p, "     CPU%d            ",j);
+	*p++ = '\n';
+
+	for (i = 0 ; i < NR_IRQS ; i++) {
+		action = irq_desc[i].action;
+		if (!action)
+			continue;
+		p += sprintf(p, "            %3d: ",i);
+		for (j = 0; j < smp_num_cpus; j++)
+			p += sprintf(p, "%20Lu ",
+				kstat.irq_cycles[cpu_logical_map(j)][i]);
+		p += sprintf(p, " %14s", irq_desc[i].handler->typename);
+		p += sprintf(p, "  %s", action->name);
+
+		for (action=action->next; action; action = action->next)
+			p += sprintf(p, ", %s", action->name);
+		*p++ = '\n';
+	}
+	p += sprintf(p, "     HI_SOFTIRQ: ");
+	for (j = 0; j < smp_num_cpus; j++)
+		p += sprintf(p, "%20Lu ",
+			kstat.softirq_used_cycles[cpu_logical_map(j)][ HI_SOFTIRQ ] );
+	p += sprintf(p, "\n");
+	p += sprintf(p, " NET_TX_SOFTIRQ: ");
+	for (j = 0; j < smp_num_cpus; j++)
+		p += sprintf(p, "%20Lu ",
+			kstat.softirq_used_cycles[cpu_logical_map(j)][ NET_TX_SOFTIRQ ] );
+	p += sprintf(p, "\n");
+	p += sprintf(p, " NET_RX_SOFTIRQ: ");
+	for (j = 0; j < smp_num_cpus; j++)
+		p += sprintf(p, "%20Lu ",
+			kstat.softirq_used_cycles[cpu_logical_map(j)][ NET_RX_SOFTIRQ ] );
+	p += sprintf(p, "\n");
+	p += sprintf(p, "TASKLET_SOFTIRQ: ");
+	for (j = 0; j < smp_num_cpus; j++)
+		p += sprintf(p, "%20Lu ",
+			kstat.softirq_used_cycles[cpu_logical_map(j)][ TASKLET_SOFTIRQ ] );
+	p += sprintf(p, "\n");
+	i = 0;
+	for (j = 0; j < smp_num_cpus; j++)
+	    if ( kstat.softirq_used_cycles[cpu_logical_map(j)][ TASKLET_SOFTIRQ+1 ] )
+		i = 1;
+	if ( i )
+	    {
+	    p += sprintf(p, "SOFTIRQ_OTHER: ");
+	    for (j = 0; j < smp_num_cpus; j++)
+		p += sprintf(p, "%20Lu ",
+			     kstat.softirq_used_cycles[cpu_logical_map(j)][ TASKLET_SOFTIRQ+1 ] );
+	    p += sprintf(p, "\n");
+	    }
+	return p - buf;
+}
+#endif
+
+
 /*
  * Global interrupt locks for SMP. Allow interrupts to come in on any
  * CPU, yet make cli/sti act globally to protect critical regions..
@@ -577,6 +641,9 @@
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
 	unsigned int status;
+#ifdef CONFIG_PRECISE_ACCT
+        cycles_t td, t = get_cycles();
+#endif
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	long esp;

@@ -650,6 +717,12 @@
 	 */
 	desc->handler->end(irq);
 	spin_unlock(&desc->lock);
+
+#ifdef CONFIG_PRECISE_ACCT
+	td = get_cycles()-t;
+	last_cycles[cpu] += td;
+	kstat.irq_cycles[cpu][irq] += td;
+#endif

 	if (softirq_pending(cpu))
 		do_softirq();
diff -ur linux-2.4.20/arch/i386/kernel/time.c linux-2.4.20-pa/arch/i386/kernel/time.c
--- linux-2.4.20/arch/i386/kernel/time.c	Fri Nov 29 00:53:09 2002
+++ linux-2.4.20-pa/arch/i386/kernel/time.c	Tue Feb  4 10:11:58 2003
@@ -67,6 +67,8 @@

 unsigned long cpu_khz;	/* Detected as we calibrate the TSC */

+extern unsigned long cycles_per_jiffie;
+
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;

@@ -695,6 +697,13 @@
         	       		:"r" (tsc_quotient),
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
+
+				eax = 0;
+				edx = 1000000/HZ;
+				__asm__("divl %2"
+		       		:"=a" (cycles_per_jiffie), "=d" (edx)
+        	       		:"r" (tsc_quotient),
+	                	"0" (eax), "1" (edx));
 			}
 		}
 	}
diff -ur linux-2.4.20/fs/proc/array.c linux-2.4.20-pa/fs/proc/array.c
--- linux-2.4.20/fs/proc/array.c	Sat Aug  3 02:39:45 2002
+++ linux-2.4.20-pa/fs/proc/array.c	Tue Feb  4 10:11:58 2003
@@ -307,6 +307,11 @@
 	int res;
 	pid_t ppid;
 	struct mm_struct *mm;
+#ifdef CONFIG_PRECISE_ACCT
+	cycles_t tot_cycles = 0;
+	int i;
+#endif
+

 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -318,6 +323,12 @@
 		tty_pgrp = task->tty->pgrp;
 		tty_nr = kdev_t_to_nr(task->tty->device);
 	}
+
+#ifdef CONFIG_PRECISE_ACCT
+	for (i = 0 ; i < smp_num_cpus; i++) {
+	        tot_cycles += task->cycles[cpu_logical_map(i)];
+	}
+#endif
 	task_unlock(task);
 	if (mm) {
 		struct vm_area_struct *vma;
@@ -391,6 +402,16 @@
 		task->cnswap,
 		task->exit_signal,
 		task->processor);
+#ifdef CONFIG_PRECISE_ACCT
+	res += sprintf( buffer+res,
+			"cycles " );
+	for (i = 0 ; i < smp_num_cpus; i++) {
+	         res += sprintf( buffer+res,
+				 "%Lu ", task->cycles[cpu_logical_map(i)] );
+	}
+	res += sprintf( buffer+res,
+			"%Lu\n", tot_cycles );
+#endif
 	if(mm)
 		mmput(mm);
 	return res;
@@ -682,6 +703,15 @@
 int proc_pid_cpu(struct task_struct *task, char * buffer)
 {
 	int i, len;
+#ifdef CONFIG_PRECISE_ACCT
+	cycles_t tot_cycles = 0;
+#endif
+
+#ifdef CONFIG_PRECISE_ACCT
+	for (i = 0 ; i < smp_num_cpus; i++) {
+	        tot_cycles += task->cycles[cpu_logical_map(i)];
+	}
+#endif

 	len = sprintf(buffer,
 		"cpu  %lu %lu\n",
@@ -693,6 +723,16 @@
 			i,
 			task->per_cpu_utime[cpu_logical_map(i)],
 			task->per_cpu_stime[cpu_logical_map(i)]);
+
+#ifdef CONFIG_PRECISE_ACCT
+	len += sprintf( buffer+len,
+			"cycles %Lu\n", tot_cycles );
+	for (i = 0 ; i < smp_num_cpus; i++) {
+	        len += sprintf( buffer+len,
+				"cycles%d %Lu\n",
+				i, task->cycles[cpu_logical_map(i)] );
+	}
+#endif

 	return len;
 }
diff -ur linux-2.4.20/fs/proc/proc_misc.c linux-2.4.20-pa/fs/proc/proc_misc.c
--- linux-2.4.20/fs/proc/proc_misc.c	Fri Nov 29 00:53:15 2002
+++ linux-2.4.20-pa/fs/proc/proc_misc.c	Tue Feb  4 10:16:39 2003
@@ -308,6 +308,11 @@
 	unsigned long jif = jiffies;
 	unsigned int sum = 0, user = 0, nice = 0, system = 0;
 	int major, disk;
+#ifdef CONFIG_PRECISE_ACCT
+	unsigned long long used_cycles_tot = 0, tot_cycles_tot = 0, irq_cycles_tot = 0, softirq_cycles_tot = 0;
+	unsigned long long irq_cycles_cpu[ NR_CPUS ] = { 0 };
+	unsigned long long softirq_cycles_cpu[ NR_CPUS ] = { 0 };
+#endif

 	for (i = 0 ; i < smp_num_cpus; i++) {
 		int cpu = cpu_logical_map(i), j;
@@ -317,7 +322,20 @@
 		system += kstat.per_cpu_system[cpu];
 #if !defined(CONFIG_ARCH_S390)
 		for (j = 0 ; j < NR_IRQS ; j++)
+		    {
 			sum += kstat.irqs[cpu][j];
+#ifdef CONFIG_PRECISE_ACCT
+			irq_cycles_cpu[cpu] += kstat.irq_cycles[cpu][j];
+#endif
+		    }
+#endif
+#ifdef CONFIG_PRECISE_ACCT
+		used_cycles_tot += kstat.used_cycles[cpu];
+		tot_cycles_tot += last_cycles[cpu];
+		irq_cycles_tot += irq_cycles_cpu[cpu];
+		for ( j = 0; j < TASKLET_SOFTIRQ+2; j++ )
+		    softirq_cycles_cpu[cpu] += kstat.softirq_used_cycles[cpu][j];
+		softirq_cycles_tot += softirq_cycles_cpu[cpu];
 #endif
 	}

@@ -333,7 +351,22 @@
 			kstat.per_cpu_system[cpu_logical_map(i)],
 			jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
 				   + kstat.per_cpu_nice[cpu_logical_map(i)] \
-				   + kstat.per_cpu_system[cpu_logical_map(i)]));
+				   + kstat.per_cpu_system[cpu_logical_map(i)]));
+#ifdef CONFIG_PRECISE_ACCT
+	len += sprintf(page + len,
+		       "cycles %Lu %Lu %Lu %Lu %Lu\n", used_cycles_tot, irq_cycles_tot, softirq_cycles_tot,
+		       tot_cycles_tot - used_cycles_tot - irq_cycles_tot - softirq_cycles_tot, tot_cycles_tot );
+	for (i = 0 ; i < smp_num_cpus; i++)
+		proc_sprintf(page, &off, &len,
+			     "cycles%d %Lu %Lu %Lu %Lu %Lu\n",
+			     i,
+			     kstat.used_cycles[cpu_logical_map(i)],
+			     irq_cycles_cpu[cpu_logical_map(i)],
+			     softirq_cycles_cpu[cpu_logical_map(i)],
+			     last_cycles[cpu_logical_map(i)] - kstat.used_cycles[cpu_logical_map(i)]
+			     - irq_cycles_cpu[cpu_logical_map(i)] - softirq_cycles_cpu[cpu_logical_map(i)],
+			     last_cycles[cpu_logical_map(i)] );
+#endif
 	proc_sprintf(page, &off, &len,
 		"page %u %u\n"
 		"swap %u %u\n"
@@ -397,6 +430,17 @@
 }
 #endif

+#if !defined(CONFIG_ARCH_S390)
+#ifdef CONFIG_PRECISE_ACCT
+static int interrupts_cycles_read_proc(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	int len = get_irq_cycles_list(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+#endif
+#endif
+
 static int filesystems_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -566,6 +610,9 @@
 		{"devices",	devices_read_proc},
 #if !defined(CONFIG_ARCH_S390)
 		{"interrupts",	interrupts_read_proc},
+#ifdef CONFIG_PRECISE_ACCT
+		{"interrupts_cycles",	interrupts_cycles_read_proc},
+#endif
 #endif
 		{"filesystems",	filesystems_read_proc},
 		{"dma",		dma_read_proc},
diff -ur linux-2.4.20/include/linux/kernel_stat.h linux-2.4.20-pa/include/linux/kernel_stat.h
--- linux-2.4.20/include/linux/kernel_stat.h	Tue Feb  4 09:44:10 2003
+++ linux-2.4.20-pa/include/linux/kernel_stat.h	Tue Feb  4 10:22:12 2003
@@ -5,6 +5,9 @@
 #include <asm/irq.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
+#ifdef CONFIG_PRECISE_ACCT
+#include <linux/interrupt.h>
+#endif

 /*
  * 'kernel_stat.h' contains the definitions needed for doing
@@ -15,10 +18,18 @@
 #define DK_MAX_MAJOR 16
 #define DK_MAX_DISK 16

+
 struct kernel_stat {
 	unsigned int per_cpu_user[NR_CPUS],
 	             per_cpu_nice[NR_CPUS],
 	             per_cpu_system[NR_CPUS];
+#ifdef CONFIG_PRECISE_ACCT
+        cycles_t used_cycles[NR_CPUS];
+#if !defined(CONFIG_ARCH_S390)
+	cycles_t irq_cycles[NR_CPUS][NR_IRQS];
+#endif
+        cycles_t softirq_used_cycles[NR_CPUS][TASKLET_SOFTIRQ+2];
+#endif
 	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
diff -ur linux-2.4.20/include/linux/sched.h linux-2.4.20-pa/include/linux/sched.h
--- linux-2.4.20/include/linux/sched.h	Tue Feb  4 09:44:10 2003
+++ linux-2.4.20-pa/include/linux/sched.h	Tue Feb  4 10:22:07 2003
@@ -112,6 +112,9 @@
 	__set_current_state(state_value)
 #endif

+extern cycles_t last_cycles[NR_CPUS];
+
+
 /*
  * Scheduling policies
  */
@@ -365,6 +368,7 @@
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	struct tms times;
+	cycles_t cycles[NR_CPUS];
 	unsigned long start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
diff -ur linux-2.4.20/kernel/fork.c linux-2.4.20-pa/kernel/fork.c
--- linux-2.4.20/kernel/fork.c	Fri Nov 29 00:53:15 2002
+++ linux-2.4.20-pa/kernel/fork.c	Tue Feb  4 10:11:58 2003
@@ -580,6 +580,7 @@
 	int retval;
 	struct task_struct *p;
 	struct completion vfork;
+	int i;

 	if ((clone_flags & (CLONE_NEWNS|CLONE_FS)) == (CLONE_NEWNS|CLONE_FS))
 		return -EINVAL;
@@ -662,6 +663,8 @@
 	p->tty_old_pgrp = 0;
 	p->times.tms_utime = p->times.tms_stime = 0;
 	p->times.tms_cutime = p->times.tms_cstime = 0;
+	for ( i = 0; i < NR_CPUS; i++ )
+	    p->cycles[i] = 0;
 #ifdef CONFIG_SMP
 	{
 		int i;
diff -ur linux-2.4.20/kernel/sched.c linux-2.4.20-pa/kernel/sched.c
--- linux-2.4.20/kernel/sched.c	Fri Nov 29 00:53:15 2002
+++ linux-2.4.20-pa/kernel/sched.c	Tue Feb  4 10:11:58 2003
@@ -36,6 +36,10 @@
 extern void timer_bh(void);
 extern void tqueue_bh(void);
 extern void immediate_bh(void);
+#ifdef CONFIG_PRECISE_ACCT
+extern void update_process_cylces(void);
+#endif
+extern cycles_t last_cycles[NR_CPUS];

 /*
  * scheduler variables
@@ -625,6 +629,10 @@
 		goto repeat_schedule;
 	}

+#ifdef CONFIG_PRECISE_ACCT
+ 	if (prev != next)
+	    update_process_cycles();
+#endif
 	/*
 	 * from this point on nothing can prevent us from
 	 * switching to the next task, save this fact in
@@ -1327,6 +1335,8 @@
 	sched_data->curr = current;
 	sched_data->last_schedule = get_cycles();
 	clear_bit(current->processor, &wait_init_idle);
+
+	last_cycles[smp_processor_id()] = get_cycles();
 }

 extern void init_timervecs (void);
diff -ur linux-2.4.20/kernel/softirq.c linux-2.4.20-pa/kernel/softirq.c
--- linux-2.4.20/kernel/softirq.c	Fri Nov 29 00:53:15 2002
+++ linux-2.4.20-pa/kernel/softirq.c	Tue Feb  4 10:11:58 2003
@@ -64,6 +64,10 @@
 	__u32 pending;
 	unsigned long flags;
 	__u32 mask;
+#ifdef CONFIG_PRECISE_ACCT
+	cycles_t td, t = get_cycles();
+	unsigned n;
+#endif

 	if (in_interrupt())
 		return;
@@ -80,16 +84,34 @@
 restart:
 		/* Reset the pending bitmask before enabling irqs */
 		softirq_pending(cpu) = 0;
-
+#ifdef CONFIG_PRECISE_ACCT
+		n = 0;
+#endif
 		local_irq_enable();

 		h = softirq_vec;

 		do {
 			if (pending & 1)
+			    {
+#ifdef CONFIG_PRECISE_ACCT
+			        t = get_cycles();
+#endif
 				h->action(h);
+#ifdef CONFIG_PRECISE_ACCT
+				td = get_cycles()-t;
+				last_cycles[cpu] += td;
+				if ( n <= TASKLET_SOFTIRQ )
+				    kstat.softirq_used_cycles[cpu][n] += td;
+				else
+				    kstat.softirq_used_cycles[cpu][TASKLET_SOFTIRQ+1] += td;
+#endif
+			    }
 			h++;
 			pending >>= 1;
+#ifdef CONFIG_PRECISE_ACCT
+			n++;
+#endif
 		} while (pending);

 		local_irq_disable();
diff -ur linux-2.4.20/kernel/timer.c linux-2.4.20-pa/kernel/timer.c
--- linux-2.4.20/kernel/timer.c	Fri Nov 29 00:53:15 2002
+++ linux-2.4.20-pa/kernel/timer.c	Tue Feb  4 10:11:58 2003
@@ -64,6 +64,9 @@
 unsigned long event;

 extern int do_setitimer(int, struct itimerval *, struct itimerval *);
+#ifdef CONFIG_PRECISE_ACCT
+extern void update_process_cycles(void);
+#endif

 unsigned long volatile jiffies;

@@ -71,6 +74,9 @@
 unsigned long prof_len;
 unsigned long prof_shift;

+unsigned long cycles_per_jiffie = 0;
+cycles_t last_cycles[NR_CPUS];
+
 /*
  * Event timer code
  */
@@ -618,6 +624,24 @@
 	} else if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
 		kstat.per_cpu_system[cpu] += system;
 }
+
+/*
+ * Called from the scheduler.
+ */
+#ifdef CONFIG_PRECISE_ACCT
+void update_process_cycles(void)
+{
+	struct task_struct *p = current;
+	int cpu = smp_processor_id();
+	cycles_t t = get_cycles();
+
+	p->cycles[cpu] += t - last_cycles[cpu];
+	if ( p->pid )
+	    kstat.used_cycles[cpu] += t - last_cycles[cpu];
+	last_cycles[cpu] = t;
+
+}
+#endif

 /*
  * Nr of active tasks - counted in fixed-point numbers

-----------------------------8<------------------------------------

