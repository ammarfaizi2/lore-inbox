Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263766AbUFVNqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbUFVNqw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 09:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUFVNqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 09:46:37 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:30163 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263574AbUFVNpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 09:45:50 -0400
Date: Tue, 22 Jun 2004 22:47:05 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: [PATCH 0/4][Diskdump]Update patches
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Andi Kleen <ak@muc.de>
Message-id: <E4C4585F67CAA4indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I update the Diskdump patches!

- fix timer problem
- support kernel 2.6.7

Source code of tool(diskdumptuils) can be downloaded from
 http://sourceforge.net/projects/lkdump

TODO:
- Replace proc interface with sysfs.
- Merge scsi_dump with scsi_mod.


I solved the timer problem by the method which Ingo Molnar proposed.

On Thu, 17 Jun 2004 14:13:56 +0200, Ingo Molnar wrote:

>but there's another possible method (suggested by Alan Cox) that
>requires no changes to the timer API hotpaths: 'clear' all timer lists
>upon a crash [once all CPUs have stopped and irqs are disabled] and just
>let the drivers use the normal timer APIs. Drive timer execution via a
>polling method.
>
>this basically approximates your polling based implementation but uses
>the existing kernel timer data structures and timer mechanism so should
>be robust and compatible. It doesnt rely on any previous state (because
>all currently pending timers are discarded) so it's as crash-safe as
>possible.


The following is core part of patches related to timer problem.
The complete patch is posted later.


diff -Nur linux-2.6.7.org/include/linux/interrupt.h linux-2.6.7/include/linux/interrupt.h
--- linux-2.6.7.org/include/linux/interrupt.h	2004-06-22 10:27:34.000000000 +0900
+++ linux-2.6.7/include/linux/interrupt.h	2004-06-22 22:26:39.000000000 +0900
@@ -246,4 +246,8 @@
 extern int probe_irq_off(unsigned long);	/* returns 0 or negative on failure */
 extern unsigned int probe_irq_mask(unsigned long);	/* returns mask of ISA interrupts */
 
+
+extern void dump_clear_tasklet(void);
+extern void dump_run_tasklet(void);
+
 #endif
diff -Nur linux-2.6.7.org/include/linux/timer.h linux-2.6.7/include/linux/timer.h
--- linux-2.6.7.org/include/linux/timer.h	2004-06-22 10:27:31.000000000 +0900
+++ linux-2.6.7/include/linux/timer.h	2004-06-22 22:26:39.000000000 +0900
@@ -99,4 +99,7 @@
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
 
+extern void dump_clear_timers(void);
+extern void dump_run_timers(void);
+
 #endif
diff -Nur linux-2.6.7.org/include/linux/workqueue.h linux-2.6.7/include/linux/workqueue.h
--- linux-2.6.7.org/include/linux/workqueue.h	2004-06-22 10:27:35.000000000 +0900
+++ linux-2.6.7/include/linux/workqueue.h	2004-06-22 22:26:39.000000000 +0900
@@ -84,4 +84,7 @@
 	return ret;
 }
 
+extern void dump_clear_workqueue(void);
+extern void dump_run_workqueue(void);
+
 #endif
diff -Nur linux-2.6.7.org/kernel/softirq.c linux-2.6.7/kernel/softirq.c
--- linux-2.6.7.org/kernel/softirq.c	2004-06-22 10:27:25.000000000 +0900
+++ linux-2.6.7/kernel/softirq.c	2004-06-22 22:26:39.000000000 +0900
@@ -314,6 +314,38 @@
 
 EXPORT_SYMBOL(tasklet_kill);
 
+struct tasklet_head saved_tasklet;
+
+void dump_clear_tasklet(void)
+{
+	saved_tasklet.list = __get_cpu_var(tasklet_vec).list;
+	__get_cpu_var(tasklet_vec).list = NULL;
+}
+
+EXPORT_SYMBOL(dump_clear_tasklet);
+
+void dump_run_tasklet(void)
+{
+	struct tasklet_struct *list;
+
+	list = __get_cpu_var(tasklet_vec).list;
+	__get_cpu_var(tasklet_vec).list = NULL;
+
+	while (list) {
+		struct tasklet_struct *t = list;
+		list = list->next;
+
+		if (!atomic_read(&t->count) &&
+		    (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)))
+				t->func(t->data);
+
+		t->next = __get_cpu_var(tasklet_vec).list;
+		__get_cpu_var(tasklet_vec).list = t;
+	}
+}
+
+EXPORT_SYMBOL(dump_run_tasklet);
+
 void __init softirq_init(void)
 {
 	open_softirq(TASKLET_SOFTIRQ, tasklet_action, NULL);
diff -Nur linux-2.6.7.org/kernel/timer.c linux-2.6.7/kernel/timer.c
--- linux-2.6.7.org/kernel/timer.c	2004-06-22 10:27:25.000000000 +0900
+++ linux-2.6.7/kernel/timer.c	2004-06-22 22:26:39.000000000 +0900
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
+#include <linux/delay.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -424,7 +425,6 @@
 {
 	struct timer_list *timer;
 
-	spin_lock_irq(&base->lock);
 	while (time_after_eq(jiffies, base->timer_jiffies)) {
 		struct list_head work_list = LIST_HEAD_INIT(work_list);
 		struct list_head *head = &work_list;
@@ -460,6 +460,12 @@
 		}
 	}
 	set_running_timer(base, NULL);
+}
+
+static inline void _run_timers(tvec_base_t *base)
+{
+	spin_lock_irq(&base->lock);
+	__run_timers(base);
 	spin_unlock_irq(&base->lock);
 }
 
@@ -909,7 +915,7 @@
 	tvec_base_t *base = &__get_cpu_var(tvec_bases);
 
 	if (time_after_eq(jiffies, base->timer_jiffies))
-		__run_timers(base);
+		_run_timers(base);
 }
 
 /*
@@ -1105,6 +1111,12 @@
 	struct timer_list timer;
 	unsigned long expire;
 
+	if (unlikely(crashdump_mode())) {
+		mdelay(timeout);
+		set_current_state(TASK_RUNNING);
+		return timeout;
+	}
+
 	switch (timeout)
 	{
 	case MAX_SCHEDULE_TIMEOUT:
@@ -1308,7 +1320,7 @@
 	return 0;
 }
 
-static void __devinit init_timers_cpu(int cpu)
+static void /* __devinit */ init_timers_cpu(int cpu)
 {
 	int j;
 	tvec_base_t *base;
@@ -1327,6 +1339,27 @@
 	base->timer_jiffies = jiffies;
 }
 
+static tvec_base_t saved_tvec_base;
+
+void dump_clear_timers(void)
+{
+	tvec_base_t *base = &per_cpu(tvec_bases, smp_processor_id());
+
+	memcpy(&saved_tvec_base, base, sizeof(saved_tvec_base));
+	init_timers_cpu(smp_processor_id());
+}
+
+EXPORT_SYMBOL(dump_clear_timers);
+
+void dump_run_timers(void)
+{
+	tvec_base_t *base = &__get_cpu_var(tvec_bases);
+
+	__run_timers(base);
+}
+
+EXPORT_SYMBOL(dump_run_timers);
+
 #ifdef CONFIG_HOTPLUG_CPU
 static int migrate_timer_list(tvec_base_t *new_base, struct list_head *head)
 {
diff -Nur linux-2.6.7.org/kernel/workqueue.c linux-2.6.7/kernel/workqueue.c
--- linux-2.6.7.org/kernel/workqueue.c	2004-06-22 10:27:25.000000000 +0900
+++ linux-2.6.7/kernel/workqueue.c	2004-06-22 22:26:39.000000000 +0900
@@ -424,6 +424,37 @@
 
 }
 
+struct cpu_workqueue_struct saved_cwq;
+
+void dump_clear_workqueue(void)
+{
+	int cpu = smp_processor_id();
+	struct cpu_workqueue_struct *cwq = keventd_wq->cpu_wq + cpu;
+
+	memcpy(&saved_cwq, cwq, sizeof(saved_cwq));
+	spin_lock_init(&cwq->lock);
+	INIT_LIST_HEAD(&cwq->worklist);
+	init_waitqueue_head(&cwq->more_work);
+	init_waitqueue_head(&cwq->work_done);
+}
+
+void dump_run_workqueue(void)
+{
+	struct cpu_workqueue_struct *cwq;
+
+	cwq = keventd_wq->cpu_wq + smp_processor_id();
+	while (!list_empty(&cwq->worklist)) {
+		struct work_struct *work = list_entry(cwq->worklist.next,
+						struct work_struct, entry);
+		void (*f) (void *) = work->func;
+		void *data = work->data;
+
+		list_del_init(cwq->worklist.next);
+		clear_bit(0, &work->pending);
+		f(data);
+	}
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 /* Take the work from this (downed) CPU. */
 static void take_over_work(struct workqueue_struct *wq, unsigned int cpu)
@@ -507,3 +538,6 @@
 EXPORT_SYMBOL(schedule_delayed_work);
 EXPORT_SYMBOL(flush_scheduled_work);
 
+EXPORT_SYMBOL(dump_clear_workqueue);
+EXPORT_SYMBOL(dump_run_workqueue);
+
