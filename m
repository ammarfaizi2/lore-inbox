Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266455AbUFQLdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266455AbUFQLdr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 07:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266452AbUFQLdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 07:33:47 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:24505 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266455AbUFQLdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 07:33:22 -0400
Date: Thu, 17 Jun 2004 20:34:37 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
In-reply-to: <20040527210447.GA2029@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Andi Kleen <ak@muc.de>
Message-id: <C7C4545F11DFBEindou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040527210447.GA2029@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all

On Thu, 27 May 2004 23:04:47 +0200, Ingo Molnar wrote:

>
>* Christoph Hellwig <hch@infradead.org> wrote:
>
>> > +/******************************** Disk dump **************************
>> > *********/
>> > +#if defined(CONFIG_DISKDUMP) || defined(CONFIG_DISKDUMP_MODULE)
>> > +#undef  add_timer
>> > +#define add_timer       diskdump_add_timer
>> > +#undef  del_timer_sync
>> > +#define del_timer_sync  diskdump_del_timer
>> > +#undef  del_timer
>> > +#define del_timer       diskdump_del_timer
>> > +#undef  mod_timer
>> > +#define mod_timer       diskdump_mod_timer
>> > +
>> > +#define tasklet_schedule        diskdump_tasklet_schedule
>> > +#endif
>> 
>> Yikes.  No way in hell we'll place code like this in drivers.  This
>> needs to be handled in common code.
>
>yeah, this is arguably the biggest (and i think only) conceptual item
>that needs to be solved before this can be integrated.
>
>The goal of these defines is to provide a separate (and polling based)
>timer mechanism that is completely separate from the normal kernel's
>state.
>
>it would also be easier to enable diskdump in a driver if this was
>handled in add_timer()/del_timer()/mod_timer()/tasklet_schedule().


Instead of redefinition, I add hooks into the timer/tasklet routines.

ex.

 int mod_timer(struct timer_list *timer, unsigned long expires)
 {
 	BUG_ON(!timer->function);

+	if (crashdump_mode()) {
+		return diskdump_mod_timer(timer, expires);
+	}
 
 	 check_timer(timer);

Please see the following patches for details.
How do you think? 

Best Regards,
Takao Indoh



diff -Nur linux-2.6.6.org/include/linux/diskdumplib.h linux-2.6.6/include/linux/diskdumplib.h
--- linux-2.6.6.org/include/linux/diskdumplib.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.6/include/linux/diskdumplib.h	2004-06-17 18:28:01.000000000 +0900
@@ -0,0 +1,19 @@
+#ifndef _LINUX_DISKDUMPLIB_H
+#define _LINUX_DISKDUMPLIB_H
+
+struct timer_list;
+struct tasklet_struct;
+struct work_struct;
+
+void diskdump_lib_init(void);
+void diskdump_lib_exit(void);
+void diskdump_update(void);
+
+void diskdump_add_timer(struct timer_list *);
+int diskdump_del_timer(struct timer_list *);
+int diskdump_mod_timer(struct timer_list *, unsigned long);
+void diskdump_tasklet_schedule(struct tasklet_struct *);
+int diskdump_schedule_work(struct work_struct *);
+long diskdump_schedule_timeout(signed long timeout);
+
+#endif /* _LINUX_DISKDUMPLIB_H */
diff -Nur linux-2.6.6.org/include/linux/interrupt.h linux-2.6.6/include/linux/interrupt.h
--- linux-2.6.6.org/include/linux/interrupt.h	2004-06-04 21:22:09.000000000 +0900
+++ linux-2.6.6/include/linux/interrupt.h	2004-06-17 18:28:01.000000000 +0900
@@ -7,6 +7,7 @@
 #include <linux/linkage.h>
 #include <linux/bitops.h>
 #include <linux/preempt.h>
+#include <linux/diskdumplib.h>
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 #include <asm/ptrace.h>
@@ -172,6 +173,11 @@
 
 static inline void tasklet_schedule(struct tasklet_struct *t)
 {
+	if (crashdump_mode()) {
+		diskdump_tasklet_schedule(t);
+		return;
+	}
+
 	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
 		__tasklet_schedule(t);
 }
diff -Nur linux-2.6.6.org/include/linux/timer.h linux-2.6.6/include/linux/timer.h
--- linux-2.6.6.org/include/linux/timer.h	2004-06-04 21:22:06.000000000 +0900
+++ linux-2.6.6/include/linux/timer.h	2004-06-17 18:28:01.000000000 +0900
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
+#include <linux/diskdumplib.h>
 
 struct tvec_t_base_s;
 
@@ -83,7 +84,10 @@
  */
 static inline void add_timer(struct timer_list * timer)
 {
-	__mod_timer(timer, timer->expires);
+	if (crashdump_mode())
+		diskdump_add_timer(timer);
+	else
+		__mod_timer(timer, timer->expires);
 }
 
 #ifdef CONFIG_SMP
diff -Nur linux-2.6.6.org/kernel/Makefile linux-2.6.6/kernel/Makefile
--- linux-2.6.6.org/kernel/Makefile	2004-06-04 21:21:58.000000000 +0900
+++ linux-2.6.6/kernel/Makefile	2004-06-17 18:28:01.000000000 +0900
@@ -7,7 +7,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o
+	    kthread.o diskdumplib.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff -Nur linux-2.6.6.org/kernel/diskdumplib.c linux-2.6.6/kernel/diskdumplib.c
--- linux-2.6.6.org/kernel/diskdumplib.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.6/kernel/diskdumplib.c	2004-06-17 18:28:01.000000000 +0900
@@ -0,0 +1,213 @@
+/*
+ *  linux/kernel/diskdumplib.c
+ *
+ *  Copyright (C) 2004  FUJITSU LIMITED
+ *  Written by Nobuhiro Tachino (ntachino@jp.fujitsu.com)
+ *
+ */
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <linux/file.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/utsname.h>
+#include <linux/smp_lock.h>
+#include <linux/genhd.h>
+#include <linux/slab.h>
+#include <linux/blkdev.h>
+#include <linux/diskdump.h>
+#include <linux/diskdumplib.h>
+#include <asm/diskdump.h>
+
+/*
+ * timer list and tasklet_struct holder
+ */
+unsigned long volatile diskdump_base_jiffies;
+static unsigned long long timestamp_base;
+static unsigned long timestamp_hz;
+
+#define DISKDUMP_NUM_TASKLETS	8
+
+/*
+ * We can't use next field of tasklet because it breaks the original
+ * tasklets chain and we have no way to know which chain the tasklet is
+ * linked.
+ */
+static struct tasklet_struct	*diskdump_tasklets[DISKDUMP_NUM_TASKLETS];
+
+static LIST_HEAD(diskdump_timers);
+static LIST_HEAD(diskdump_workq);
+
+
+static int store_tasklet(struct tasklet_struct *tasklet)
+{
+	int i;
+
+	for (i = 0; i < DISKDUMP_NUM_TASKLETS; i++)
+		if (diskdump_tasklets[i] == NULL) {
+			diskdump_tasklets[i] = tasklet;
+			return 0;
+		}
+	return -1;
+}
+
+static struct tasklet_struct *find_tasklet(struct tasklet_struct *tasklet)
+{
+	int i;
+
+	for (i = 0; i < DISKDUMP_NUM_TASKLETS; i++)
+		if (diskdump_tasklets[i] == tasklet)
+			return diskdump_tasklets[i];
+	return NULL;
+}
+
+void diskdump_tasklet_schedule(struct tasklet_struct *tasklet)
+{
+	if (!find_tasklet(tasklet))
+		if (store_tasklet(tasklet))
+			printk(KERN_ERR "diskdumplib: too many tasklet. Ignored\n");
+	set_bit(TASKLET_STATE_SCHED, &tasklet->state);
+}
+
+int diskdump_schedule_work(struct work_struct *work)
+{
+	list_add_tail(&work->entry, &diskdump_workq);
+	return 1;
+}
+
+long diskdump_schedule_timeout(signed long timeout)
+{
+	mdelay(timeout);
+	set_current_state(TASK_RUNNING);
+	return timeout;
+}
+
+void diskdump_add_timer(struct timer_list *timer)
+{
+	timer->base = (void *)1;
+	list_add(&timer->entry, &diskdump_timers);
+}
+
+int diskdump_del_timer(struct timer_list *timer)
+{
+	if (timer->base != NULL) {
+		list_del(&timer->entry);
+		return 1;
+	} else {
+		timer->base = NULL;
+		return 0;
+	}
+}
+
+int diskdump_mod_timer(struct timer_list *timer, unsigned long expires)
+{
+	int ret;
+
+	ret = diskdump_del_timer(timer);
+	timer->expires = expires;
+	diskdump_add_timer(timer);
+
+	return ret;
+}
+
+static void update_jiffies(void)
+{
+	unsigned long long t;
+
+	platform_timestamp(t);
+	while (t > timestamp_base + timestamp_hz) {
+		timestamp_base += timestamp_hz;
+		jiffies++;
+		platform_timestamp(t);
+	}
+}
+
+void diskdump_update(void)
+{
+	struct tasklet_struct *tasklet;
+	struct work_struct *work;
+	struct timer_list *timer;
+	struct list_head *t, *n, head;
+	int i;
+
+	update_jiffies();
+
+	/* run timers */
+	list_for_each_safe(t, n, &diskdump_timers) {
+		timer = list_entry(t, struct timer_list, entry);
+		if (time_before_eq(timer->expires, jiffies)) {
+			list_del(t);
+			timer->function(timer->data);
+		}
+	}
+
+	/* run tasklet */
+	for (i = 0; i < DISKDUMP_NUM_TASKLETS; i++)
+		if ((tasklet = diskdump_tasklets[i]))
+			if (!atomic_read(&tasklet->count))
+				if (test_and_clear_bit(TASKLET_STATE_SCHED, &tasklet->state))
+					tasklet->func(tasklet->data);
+
+	/* run work queue */
+	list_add(&head, &diskdump_workq);
+	list_del_init(&diskdump_workq);
+	n = head.next;
+	while (n != &head) {
+		work = list_entry(t, struct work_struct, entry);
+		n = n->next;
+		if (work->func)
+			work->func(work->wq_data);
+	}
+}
+
+void diskdump_lib_init(void)
+{
+	unsigned long long t;
+
+	/* Save original jiffies value */
+	diskdump_base_jiffies = jiffies;
+
+	platform_timestamp(timestamp_base);
+	udelay(1000000/HZ);
+	platform_timestamp(t);
+	timestamp_hz = (unsigned long)(t - timestamp_base);
+
+	diskdump_update();
+}
+
+void diskdump_lib_exit(void)
+{
+	/* Resotre original jiffies. */
+	jiffies = diskdump_base_jiffies;
+}
+
+EXPORT_SYMBOL(diskdump_lib_init);
+EXPORT_SYMBOL(diskdump_lib_exit);
+EXPORT_SYMBOL(diskdump_update);
+EXPORT_SYMBOL(diskdump_add_timer);
+EXPORT_SYMBOL(diskdump_del_timer);
+EXPORT_SYMBOL(diskdump_mod_timer);
+EXPORT_SYMBOL(diskdump_tasklet_schedule);
+EXPORT_SYMBOL(diskdump_schedule_work);
+EXPORT_SYMBOL(diskdump_schedule_timeout);
+
+MODULE_LICENSE("GPL");
diff -Nur linux-2.6.6.org/kernel/timer.c linux-2.6.6/kernel/timer.c
--- linux-2.6.6.org/kernel/timer.c	2004-06-04 21:21:58.000000000 +0900
+++ linux-2.6.6/kernel/timer.c	2004-06-17 18:28:01.000000000 +0900
@@ -255,6 +255,10 @@
 {
 	BUG_ON(!timer->function);
 
+	if (crashdump_mode()) {
+		return diskdump_mod_timer(timer, expires);
+	}
+
 	check_timer(timer);
 
 	/*
@@ -286,6 +290,10 @@
 	unsigned long flags;
 	tvec_base_t *base;
 
+	if (crashdump_mode()) {
+		return diskdump_del_timer(timer);
+	}
+
 	check_timer(timer);
 
 repeat:
@@ -327,6 +335,10 @@
 	tvec_base_t *base;
 	int i, ret = 0;
 
+	if (crashdump_mode()) {
+		return diskdump_del_timer(timer);
+	}
+
 	check_timer(timer);
 
 del_again:
@@ -1070,6 +1082,10 @@
 	struct timer_list timer;
 	unsigned long expire;
 
+	if (crashdump_mode()) {
+		return diskdump_schedule_timeout(timeout);
+	}
+
 	switch (timeout)
 	{
 	case MAX_SCHEDULE_TIMEOUT:
diff -Nur linux-2.6.6.org/kernel/workqueue.c linux-2.6.6/kernel/workqueue.c
--- linux-2.6.6.org/kernel/workqueue.c	2004-06-04 21:21:58.000000000 +0900
+++ linux-2.6.6/kernel/workqueue.c	2004-06-17 18:30:31.000000000 +0900
@@ -386,7 +386,10 @@
 
 int fastcall schedule_work(struct work_struct *work)
 {
-	return queue_work(keventd_wq, work);
+	if (crashdump_mode())
+		return diskdump_schedule_work(work);
+	else
+		return queue_work(keventd_wq, work);
 }
 
 int fastcall schedule_delayed_work(struct work_struct *work, unsigned long delay)
