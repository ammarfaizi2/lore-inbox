Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130570AbRAWMjM>; Tue, 23 Jan 2001 07:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131045AbRAWMiw>; Tue, 23 Jan 2001 07:38:52 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:47493 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131004AbRAWMio>; Tue, 23 Jan 2001 07:38:44 -0500
Message-ID: <3A6D7D06.FDBF89DC@uow.edu.au>
Date: Tue, 23 Jan 2001 23:45:58 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Hartner <bhartner@us.ibm.com>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: more on scheduler benchmarks
In-Reply-To: <OFBD35263C.BED6AC47-ON852569DC.006C12E2@raleigh.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------0E06DB70EF329287E879BA2B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0E06DB70EF329287E879BA2B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Bill Hartner wrote:
> 
> Hubertus wrote :
> 
> > The only problem I have with sched_yield like benchmarks is that it
> creates
> > artificial lock contention as we basically spent most of the time other
> > then context switching + syscall under the scheduler lock. This we won't
> > see in real apps, that's why I think the chatroom numbers are probably
> > better indicators.
> 
> Agreed. 100% artificial. The intention of the benchmark is to put a lot
> of pressure on the scheduler so that the benchmark results will be very
> "sensitive" to changes in schedule().

One approach would be to directly measure the time taken by schedule()
using the pentium timestamp counter.

You can do this with the point-to-point timing patch which
I did last year (recently refreshed).  It's at

	http://www.uow.edu.au/~andrewm/linux/#timepegs

Applying timepegs, plus schedule-timer.patch (attached) reveals that
vanilla schedule() takes 32 microseconds with 100 tasks on the
runqueue, and 4 usecs with an empty runqueue.

timepegs are probably a bit heavyweight for this.  Their
cache footprint perhaps introduces some heisenberg effects.
Although, given that you're only looking for deltas, this
won't matter a lot.

[ hack, hack, hack ]

OK, schedule-hack-timer.patch open codes the measurement
of schedule().  Just thump on ALT-SYSRQ-Q and multiply
by your CPU clock period to get the statistics.  Booting
with `noapic' and ignoring CPU0's results may make things
more repeatable...

This patch gives similar figures to the timepeg approach.
Running 'bwait' (also attached) to populate the runqueue
I see schedule() taking the following amount of time:

runqueue length		microseconds (500MHz PII)

	2			5
	4			6
	6			6
	8			6
	16			7.5
	24			11
	32			15
	48			20
	64			25
	128			44

Seems surprisingly slow?

-
--------------0E06DB70EF329287E879BA2B
Content-Type: text/plain; charset=us-ascii;
 name="bwait.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bwait.c"

#include <stdio.h>
#include <stdlib.h>

main(int argc, char *argv[])
{
	int n = (argc > 1) ? atoi(argv[1]) : 20;
	int i;

	for (i = 0; i < n - 1; i++) {
		if (fork() == 0) {
			sleep(1);
			for ( ; ; )
				;
		}
	}
	printf("created %d busywaiters\n", n);
	for ( ; ; )
		;
}

--------------0E06DB70EF329287E879BA2B
Content-Type: text/plain; charset=us-ascii;
 name="schedule-hack-timer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="schedule-hack-timer.patch"

--- linux-2.4.1-pre10/kernel/sched.c	Tue Jan 23 19:28:16 2001
+++ linux-akpm/kernel/sched.c	Tue Jan 23 23:18:21 2001
@@ -33,6 +33,13 @@
 extern void tqueue_bh(void);
 extern void immediate_bh(void);
 
+#include <asm/msr.h>
+static struct {
+	unsigned long acc_time;
+	unsigned long n_times;
+	unsigned long long in;
+} ____cacheline_aligned schedule_stats[NR_CPUS + 1];
+
 /*
  * scheduler variables
  */
@@ -505,7 +512,7 @@
  * tasks can run. It can not be killed, and it cannot sleep. The 'state'
  * information in task[0] is never used.
  */
-asmlinkage void schedule(void)
+static void __schedule(void)
 {
 	struct schedule_data * sched_data;
 	struct task_struct *prev, *next, *p;
@@ -688,6 +695,88 @@
 	BUG();
 	return;
 }
+
+//////////////////////
+
+static unsigned long long dummy;
+static unsigned long long calib;
+static int done_calib;
+
+static void do_one(void)
+{
+	rdtscll(dummy);
+}
+
+static void calibrate(void)
+{
+	unsigned long long in, out;
+	unsigned long flags;
+	int i;
+
+	local_irq_save(flags);
+	rdtscll(in);
+	for (i = 0; i < 0x10000; i++) {
+		do_one();
+	}
+	rdtscll(out);
+	local_irq_restore(flags);
+	calib = (out - in) >> 16;
+	done_calib = 1;
+}
+
+asmlinkage void schedule(void)
+{
+	int cpu = smp_processor_id();
+	unsigned long long out;
+
+	if (!done_calib)
+		calibrate();
+
+	rdtscll(schedule_stats[cpu].in);
+	__schedule();
+	rdtscll(out);
+
+	schedule_stats[cpu].acc_time += out - schedule_stats[cpu].in - calib;
+	schedule_stats[cpu].n_times++;
+}
+
+static atomic_t cpu_count;
+
+static void ss_dumper(void *dummy)
+{
+	int cpu = smp_processor_id();
+	while (atomic_read(&cpu_count) != cpu)
+		;
+	printk("CPU %d: %lu / %lu = %lu cycles/switch\n",
+		cpu, schedule_stats[cpu].acc_time, schedule_stats[cpu].n_times,
+		schedule_stats[cpu].acc_time / schedule_stats[cpu].n_times);
+	
+	schedule_stats[NR_CPUS].acc_time += schedule_stats[cpu].acc_time;
+	schedule_stats[NR_CPUS].n_times += schedule_stats[cpu].n_times;
+
+	schedule_stats[cpu].acc_time = 0;
+	schedule_stats[cpu].n_times = 0;
+	atomic_inc(&cpu_count);
+	if (atomic_read(&cpu_count) == smp_num_cpus) {
+		printk("total: %lu / %lu = %lu cycles/switch\n",
+			schedule_stats[NR_CPUS].acc_time, schedule_stats[NR_CPUS].n_times,
+			schedule_stats[NR_CPUS].acc_time / schedule_stats[NR_CPUS].n_times);
+	}		
+}
+
+void dump_schedule_stats(void)
+{
+	schedule_stats[NR_CPUS].acc_time = 0;
+	schedule_stats[NR_CPUS].n_times = 0;
+	atomic_set(&cpu_count, 0);
+	printk("\n");
+	smp_call_function(ss_dumper, 0, 0, 0);
+	ss_dumper(0);
+}
+
+
+//////////////////////////
+
 
 static inline void __wake_up_common (wait_queue_head_t *q, unsigned int mode,
 			 	     int nr_exclusive, const int sync)
--- linux-2.4.1-pre10/drivers/char/sysrq.c	Tue Dec 12 19:24:17 2000
+++ linux-akpm/drivers/char/sysrq.c	Tue Jan 23 22:35:34 2001
@@ -95,6 +95,9 @@
 			sysrq_power_off();
 		}
 		break;
+	case 'q':
+		dump_schedule_stats();
+		break;
 	case 's':					    /* S -- emergency sync */
 		printk("Emergency Sync\n");
 		emergency_sync_scheduled = EMERG_SYNC;

--------------0E06DB70EF329287E879BA2B
Content-Type: text/plain; charset=us-ascii;
 name="schedule-timer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="schedule-timer.patch"

--- linux-2.4.1-pre10/kernel/sched.c	Tue Jan 23 19:28:16 2001
+++ linux-akpm/kernel/sched.c	Tue Jan 23 22:31:34 2001
@@ -28,6 +28,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
+#include <asm/timepeg.h>
 
 extern void timer_bh(void);
 extern void tqueue_bh(void);
@@ -202,7 +203,7 @@
  */
 static FASTCALL(void reschedule_idle(struct task_struct * p));
 
-static void reschedule_idle(struct task_struct * p)
+static void __reschedule_idle(struct task_struct * p)
 {
 #ifdef CONFIG_SMP
 	int this_cpu = smp_processor_id();
@@ -293,6 +294,13 @@
 #endif
 }
 
+static void reschedule_idle(struct task_struct * p)
+{
+	TIMEPEG_MODE("resched_idle_start", TPH_MODE_START);
+	__reschedule_idle(p);
+	TIMEPEG_MODE("resched_idle_stop", TPH_MODE_STOP);
+}
+
 /*
  * Careful!
  *
@@ -505,7 +513,7 @@
  * tasks can run. It can not be killed, and it cannot sleep. The 'state'
  * information in task[0] is never used.
  */
-asmlinkage void schedule(void)
+static void __schedule(void)
 {
 	struct schedule_data * sched_data;
 	struct task_struct *prev, *next, *p;
@@ -687,6 +695,13 @@
 	printk("Scheduling in interrupt\n");
 	BUG();
 	return;
+}
+
+asmlinkage void schedule(void)
+{
+	TIMEPEG_MODE("schedule_start", TPH_MODE_START);
+	__schedule();
+	TIMEPEG_MODE("schedule_stop", TPH_MODE_STOP);
 }
 
 static inline void __wake_up_common (wait_queue_head_t *q, unsigned int mode,

--------------0E06DB70EF329287E879BA2B--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
