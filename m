Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUFRMB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUFRMB3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 08:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUFRMB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 08:01:29 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:34537 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265131AbUFRMBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 08:01:19 -0400
Date: Fri, 18 Jun 2004 21:02:35 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
In-reply-to: <20040617121356.GA24338@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andi Kleen <ak@muc.de>
Message-id: <D3C4552C24A60Aindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040617121356.GA24338@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

This is a test patch for clearing timer/tasklet and executing it
during dumping.
This patch does not work yet. I tried dumping using this patch, but
aic7xxx is unstable...


diff -Nur linux-2.6.6.org/include/linux/interrupt.h linux-2.6.6/include/linux/interrupt.h
--- linux-2.6.6.org/include/linux/interrupt.h	2004-06-04 21:22:09.000000000 +0900
+++ linux-2.6.6/include/linux/interrupt.h	2004-06-18 20:53:59.000000000 +0900
@@ -246,4 +246,8 @@
 extern int probe_irq_off(unsigned long);	/* returns 0 or negative on failure */
 extern unsigned int probe_irq_mask(unsigned long);	/* returns mask of ISA interrupts */
 
+
+extern void diskdump_clear_tasklet(void);
+extern void diskdump_run_tasklet(void);
+
 #endif
diff -Nur linux-2.6.6.org/include/linux/timer.h linux-2.6.6/include/linux/timer.h
--- linux-2.6.6.org/include/linux/timer.h	2004-06-04 21:22:06.000000000 +0900
+++ linux-2.6.6/include/linux/timer.h	2004-06-18 20:53:59.000000000 +0900
@@ -96,4 +96,7 @@
 extern void run_local_timers(void);
 extern void it_real_fn(unsigned long);
 
+extern void diskdump_clear_timers(void);
+extern void diskdump_run_timers(void);
+
 #endif
diff -Nur linux-2.6.6.org/include/linux/workqueue.h linux-2.6.6/include/linux/workqueue.h
--- linux-2.6.6.org/include/linux/workqueue.h	2004-06-04 21:22:09.000000000 +0900
+++ linux-2.6.6/include/linux/workqueue.h	2004-06-18 20:53:59.000000000 +0900
@@ -84,4 +84,7 @@
 	return ret;
 }
 
+extern void diskdump_clear_workqueue(void);
+extern void diskdump_run_workqueue(void);
+
 #endif
diff -Nur linux-2.6.6.org/kernel/softirq.c linux-2.6.6/kernel/softirq.c
--- linux-2.6.6.org/kernel/softirq.c	2004-06-04 21:21:58.000000000 +0900
+++ linux-2.6.6/kernel/softirq.c	2004-06-18 20:53:59.000000000 +0900
@@ -314,6 +314,37 @@
 
 EXPORT_SYMBOL(tasklet_kill);
 
+struct tasklet_head saved_tasklet;
+void diskdump_clear_tasklet(void)
+{
+	saved_tasklet.list = __get_cpu_var(tasklet_vec).list;
+	__get_cpu_var(tasklet_vec).list = NULL;
+}
+
+EXPORT_SYMBOL(diskdump_clear_tasklet);
+
+void diskdump_run_tasklet(void)
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
+EXPORT_SYMBOL(diskdump_run_tasklet);
+
 void __init softirq_init(void)
 {
 	open_softirq(TASKLET_SOFTIRQ, tasklet_action, NULL);
diff -Nur linux-2.6.6.org/kernel/timer.c linux-2.6.6/kernel/timer.c
--- linux-2.6.6.org/kernel/timer.c	2004-06-04 21:21:58.000000000 +0900
+++ linux-2.6.6/kernel/timer.c	2004-06-18 20:53:59.000000000 +0900
@@ -31,6 +31,7 @@
 #include <linux/time.h>
 #include <linux/jiffies.h>
 #include <linux/cpu.h>
+#include <linux/delay.h>
 
 #include <asm/uaccess.h>
 #include <asm/div64.h>
@@ -1070,6 +1071,12 @@
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
@@ -1292,6 +1299,25 @@
 	base->timer_jiffies = jiffies;
 }
 
+tvec_base_t saved_tvec_base;
+void diskdump_clear_timers(void)
+{
+	tvec_base_t *base = &per_cpu(tvec_bases, smp_processor_id());
+
+	memcpy(&saved_tvec_base, base, sizeof(saved_tvec_base));
+	init_timers_cpu(smp_processor_id());
+}
+
+EXPORT_SYMBOL(diskdump_clear_timers);
+
+void diskdump_run_timers(void)
+{
+	tvec_base_t *base = &__get_cpu_var(tvec_bases);
+	__run_timers(base);
+}
+
+EXPORT_SYMBOL(diskdump_run_timers);
+
 #ifdef CONFIG_HOTPLUG_CPU
 static int migrate_timer_list(tvec_base_t *new_base, struct list_head *head)
 {
diff -Nur linux-2.6.6.org/kernel/workqueue.c linux-2.6.6/kernel/workqueue.c
--- linux-2.6.6.org/kernel/workqueue.c	2004-06-04 21:21:58.000000000 +0900
+++ linux-2.6.6/kernel/workqueue.c	2004-06-18 20:53:59.000000000 +0900
@@ -420,6 +420,36 @@
 
 }
 
+struct cpu_workqueue_struct saved_cwq;
+void diskdump_clear_workqueue(void)
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
+void diskdump_run_workqueue(void)
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
@@ -503,3 +533,6 @@
 EXPORT_SYMBOL(schedule_delayed_work);
 EXPORT_SYMBOL(flush_scheduled_work);
 
+EXPORT_SYMBOL(diskdump_clear_workqueue);
+EXPORT_SYMBOL(diskdump_run_workqueue);
+
