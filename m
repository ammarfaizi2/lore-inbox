Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVLAAHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVLAAHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 19:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbVLAAGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 19:06:39 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:65442
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751303AbVK3X6U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 18:58:20 -0500
Subject: [patch 24/43] Split timeout code into kernel/ktimeout.c
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, zippel@linux-m68k.org, george@mvista.com,
       johnstul@us.ibm.com
References: <20051130231140.164337000@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 01 Dec 2005 01:03:45 +0100
Message-Id: <1133395425.32542.467.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

plain text document attachment (ktimeout-c.patch)
- split the timeout implementation from kernel/timer.c, into kernel/ktimeout.c

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/Makefile   |    2 
 kernel/ktimeout.c |  771 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/timer.c    |  747 ----------------------------------------------------
 3 files changed, 773 insertions(+), 747 deletions(-)

Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile
+++ linux/kernel/Makefile
@@ -8,7 +8,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o \
-	    ktimer.o
+	    ktimer.o ktimeout.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: linux/kernel/ktimeout.c
===================================================================
--- /dev/null
+++ linux/kernel/ktimeout.c
@@ -0,0 +1,771 @@
+/*
+ *  linux/kernel/ktimeout.c
+ *
+ *  Kernel internal timeouts API
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *
+ *  1997-01-28  Modified by Finn Arne Gangstad to make timers scale better.
+ *  2000-10-05  Implemented scalable SMP per-CPU timer handling.
+ *                              Copyright (C) 2000, 2001, 2002  Ingo Molnar
+ *              Designed by David S. Miller, Alexey Kuznetsov and Ingo Molnar
+ */
+
+#include <linux/kernel_stat.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/percpu.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/notifier.h>
+#include <linux/thread_info.h>
+#include <linux/time.h>
+#include <linux/jiffies.h>
+#include <linux/posix-timers.h>
+#include <linux/cpu.h>
+#include <linux/syscalls.h>
+
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
+#include <asm/div64.h>
+#include <asm/timex.h>
+#include <asm/io.h>
+
+/*
+ * per-CPU timer vector definitions:
+ */
+
+#define TVN_BITS (CONFIG_BASE_SMALL ? 4 : 6)
+#define TVR_BITS (CONFIG_BASE_SMALL ? 6 : 8)
+#define TVN_SIZE (1 << TVN_BITS)
+#define TVR_SIZE (1 << TVR_BITS)
+#define TVN_MASK (TVN_SIZE - 1)
+#define TVR_MASK (TVR_SIZE - 1)
+
+struct timer_base_s {
+	spinlock_t lock;
+	struct timer_list *running_timer;
+};
+
+typedef struct tvec_s {
+	struct list_head vec[TVN_SIZE];
+} tvec_t;
+
+typedef struct tvec_root_s {
+	struct list_head vec[TVR_SIZE];
+} tvec_root_t;
+
+struct tvec_t_base_s {
+	struct timer_base_s t_base;
+	unsigned long timer_jiffies;
+	tvec_root_t tv1;
+	tvec_t tv2;
+	tvec_t tv3;
+	tvec_t tv4;
+	tvec_t tv5;
+} ____cacheline_aligned_in_smp;
+
+typedef struct tvec_t_base_s tvec_base_t;
+static DEFINE_PER_CPU(tvec_base_t, tvec_bases);
+
+static inline void set_running_timer(tvec_base_t *base,
+					struct timer_list *timer)
+{
+#ifdef CONFIG_SMP
+	base->t_base.running_timer = timer;
+#endif
+}
+
+static void internal_add_timer(tvec_base_t *base, struct timer_list *timer)
+{
+	unsigned long expires = timer->expires;
+	unsigned long idx = expires - base->timer_jiffies;
+	struct list_head *vec;
+
+	if (idx < TVR_SIZE) {
+		int i = expires & TVR_MASK;
+		vec = base->tv1.vec + i;
+	} else if (idx < 1 << (TVR_BITS + TVN_BITS)) {
+		int i = (expires >> TVR_BITS) & TVN_MASK;
+		vec = base->tv2.vec + i;
+	} else if (idx < 1 << (TVR_BITS + 2 * TVN_BITS)) {
+		int i = (expires >> (TVR_BITS + TVN_BITS)) & TVN_MASK;
+		vec = base->tv3.vec + i;
+	} else if (idx < 1 << (TVR_BITS + 3 * TVN_BITS)) {
+		int i = (expires >> (TVR_BITS + 2 * TVN_BITS)) & TVN_MASK;
+		vec = base->tv4.vec + i;
+	} else if ((signed long) idx < 0) {
+		/*
+		 * Can happen if you add a timer with expires == jiffies,
+		 * or you set a timer to go off in the past
+		 */
+		vec = base->tv1.vec + (base->timer_jiffies & TVR_MASK);
+	} else {
+		int i;
+		/* If the timeout is larger than 0xffffffff on 64-bit
+		 * architectures then we use the maximum timeout:
+		 */
+		if (idx > 0xffffffffUL) {
+			idx = 0xffffffffUL;
+			expires = idx + base->timer_jiffies;
+		}
+		i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
+		vec = base->tv5.vec + i;
+	}
+	/*
+	 * Timers are FIFO:
+	 */
+	list_add_tail(&timer->entry, vec);
+}
+
+typedef struct timer_base_s timer_base_t;
+/*
+ * Used by TIMER_INITIALIZER, we can't use per_cpu(tvec_bases)
+ * at compile time, and we need timer->base to lock the timer.
+ */
+timer_base_t __init_timer_base
+	____cacheline_aligned_in_smp = { .lock = SPIN_LOCK_UNLOCKED };
+EXPORT_SYMBOL(__init_timer_base);
+
+/***
+ * init_timer - initialize a timer.
+ * @timer: the timer to be initialized
+ *
+ * init_timer() must be done to a timer prior calling *any* of the
+ * other timer functions.
+ */
+void fastcall init_timer(struct timer_list *timer)
+{
+	timer->entry.next = NULL;
+	timer->base = &per_cpu(tvec_bases, raw_smp_processor_id()).t_base;
+}
+EXPORT_SYMBOL(init_timer);
+
+static inline void detach_timer(struct timer_list *timer,
+					int clear_pending)
+{
+	struct list_head *entry = &timer->entry;
+
+	__list_del(entry->prev, entry->next);
+	if (clear_pending)
+		entry->next = NULL;
+	entry->prev = LIST_POISON2;
+}
+
+/*
+ * We are using hashed locking: holding per_cpu(tvec_bases).t_base.lock
+ * means that all timers which are tied to this base via timer->base are
+ * locked, and the base itself is locked too.
+ *
+ * So __run_timers/migrate_timers can safely modify all timers which could
+ * be found on ->tvX lists.
+ *
+ * When the timer's base is locked, and the timer removed from list, it is
+ * possible to set timer->base = NULL and drop the lock: the timer remains
+ * locked.
+ */
+static timer_base_t *lock_timer_base(struct timer_list *timer,
+					unsigned long *flags)
+{
+	timer_base_t *base;
+
+	for (;;) {
+		base = timer->base;
+		if (likely(base != NULL)) {
+			spin_lock_irqsave(&base->lock, *flags);
+			if (likely(base == timer->base))
+				return base;
+			/* The timer has migrated to another CPU */
+			spin_unlock_irqrestore(&base->lock, *flags);
+		}
+		cpu_relax();
+	}
+}
+
+int __mod_timer(struct timer_list *timer, unsigned long expires)
+{
+	timer_base_t *base;
+	tvec_base_t *new_base;
+	unsigned long flags;
+	int ret = 0;
+
+	BUG_ON(!timer->function);
+
+	base = lock_timer_base(timer, &flags);
+
+	if (timer_pending(timer)) {
+		detach_timer(timer, 0);
+		ret = 1;
+	}
+
+	new_base = &__get_cpu_var(tvec_bases);
+
+	if (base != &new_base->t_base) {
+		/*
+		 * We are trying to schedule the timer on the local CPU.
+		 * However we can't change timer's base while it is running,
+		 * otherwise del_timer_sync() can't detect that the timer's
+		 * handler yet has not finished. This also guarantees that
+		 * the timer is serialized wrt itself.
+		 */
+		if (unlikely(base->running_timer == timer)) {
+			/* The timer remains on a former base */
+			new_base = container_of(base, tvec_base_t, t_base);
+		} else {
+			/* See the comment in lock_timer_base() */
+			timer->base = NULL;
+			spin_unlock(&base->lock);
+			spin_lock(&new_base->t_base.lock);
+			timer->base = &new_base->t_base;
+		}
+	}
+
+	timer->expires = expires;
+	internal_add_timer(new_base, timer);
+	spin_unlock_irqrestore(&new_base->t_base.lock, flags);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(__mod_timer);
+
+/***
+ * add_timer_on - start a timer on a particular CPU
+ * @timer: the timer to be added
+ * @cpu: the CPU to start it on
+ *
+ * This is not very scalable on SMP. Double adds are not possible.
+ */
+void add_timer_on(struct timer_list *timer, int cpu)
+{
+	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
+  	unsigned long flags;
+
+  	BUG_ON(timer_pending(timer) || !timer->function);
+	spin_lock_irqsave(&base->t_base.lock, flags);
+	timer->base = &base->t_base;
+	internal_add_timer(base, timer);
+	spin_unlock_irqrestore(&base->t_base.lock, flags);
+}
+
+
+/***
+ * mod_timer - modify a timer's timeout
+ * @timer: the timer to be modified
+ *
+ * mod_timer is a more efficient way to update the expire field of an
+ * active timer (if the timer is inactive it will be activated)
+ *
+ * mod_timer(timer, expires) is equivalent to:
+ *
+ *     del_timer(timer); timer->expires = expires; add_timer(timer);
+ *
+ * Note that if there are multiple unserialized concurrent users of the
+ * same timer, then mod_timer() is the only safe way to modify the timeout,
+ * since add_timer() cannot modify an already running timer.
+ *
+ * The function returns whether it has modified a pending timer or not.
+ * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
+ * active timer returns 1.)
+ */
+int mod_timer(struct timer_list *timer, unsigned long expires)
+{
+	BUG_ON(!timer->function);
+
+	/*
+	 * This is a common optimization triggered by the
+	 * networking code - if the timer is re-modified
+	 * to be the same thing then just return:
+	 */
+	if (timer->expires == expires && timer_pending(timer))
+		return 1;
+
+	return __mod_timer(timer, expires);
+}
+
+EXPORT_SYMBOL(mod_timer);
+
+/***
+ * del_timer - deactive a timer.
+ * @timer: the timer to be deactivated
+ *
+ * del_timer() deactivates a timer - this works on both active and inactive
+ * timers.
+ *
+ * The function returns whether it has deactivated a pending timer or not.
+ * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
+ * active timer returns 1.)
+ */
+int del_timer(struct timer_list *timer)
+{
+	timer_base_t *base;
+	unsigned long flags;
+	int ret = 0;
+
+	if (timer_pending(timer)) {
+		base = lock_timer_base(timer, &flags);
+		if (timer_pending(timer)) {
+			detach_timer(timer, 1);
+			ret = 1;
+		}
+		spin_unlock_irqrestore(&base->lock, flags);
+	}
+
+	return ret;
+}
+
+EXPORT_SYMBOL(del_timer);
+
+#ifdef CONFIG_SMP
+/*
+ * This function tries to deactivate a timer. Upon successful (ret >= 0)
+ * exit the timer is not queued and the handler is not running on any CPU.
+ *
+ * It must not be called from interrupt contexts.
+ */
+int try_to_del_timer_sync(struct timer_list *timer)
+{
+	timer_base_t *base;
+	unsigned long flags;
+	int ret = -1;
+
+	base = lock_timer_base(timer, &flags);
+
+	if (base->running_timer == timer)
+		goto out;
+
+	ret = 0;
+	if (timer_pending(timer)) {
+		detach_timer(timer, 1);
+		ret = 1;
+	}
+out:
+	spin_unlock_irqrestore(&base->lock, flags);
+
+	return ret;
+}
+
+/***
+ * del_timer_sync - deactivate a timer and wait for the handler to finish.
+ * @timer: the timer to be deactivated
+ *
+ * This function only differs from del_timer() on SMP: besides deactivating
+ * the timer it also makes sure the handler has finished executing on other
+ * CPUs.
+ *
+ * Synchronization rules: callers must prevent restarting of the timer,
+ * otherwise this function is meaningless. It must not be called from
+ * interrupt contexts. The caller must not hold locks which would prevent
+ * completion of the timer's handler. The timer's handler must not call
+ * add_timer_on(). Upon exit the timer is not queued and the handler is
+ * not running on any CPU.
+ *
+ * The function returns whether it has deactivated a pending timer or not.
+ */
+int del_timer_sync(struct timer_list *timer)
+{
+	for (;;) {
+		int ret = try_to_del_timer_sync(timer);
+		if (ret >= 0)
+			return ret;
+	}
+}
+
+EXPORT_SYMBOL(del_timer_sync);
+#endif
+
+static int cascade(tvec_base_t *base, tvec_t *tv, int index)
+{
+	/* cascade all the timers from tv up one level */
+	struct list_head *head, *curr;
+
+	head = tv->vec + index;
+	curr = head->next;
+	/*
+	 * We are removing _all_ timers from the list, so we don't  have to
+	 * detach them individually, just clear the list afterwards.
+	 */
+	while (curr != head) {
+		struct timer_list *tmp;
+
+		tmp = list_entry(curr, struct timer_list, entry);
+		BUG_ON(tmp->base != &base->t_base);
+		curr = curr->next;
+		internal_add_timer(base, tmp);
+	}
+	INIT_LIST_HEAD(head);
+
+	return index;
+}
+
+/***
+ * __run_timers - run all expired timers (if any) on this CPU.
+ * @base: the timer vector to be processed.
+ *
+ * This function cascades all vectors and executes all expired timer
+ * vectors.
+ */
+#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
+
+static inline void __run_timers(tvec_base_t *base)
+{
+	struct timer_list *timer;
+
+	spin_lock_irq(&base->t_base.lock);
+	while (time_after_eq(jiffies, base->timer_jiffies)) {
+		struct list_head work_list = LIST_HEAD_INIT(work_list);
+		struct list_head *head = &work_list;
+ 		int index = base->timer_jiffies & TVR_MASK;
+ 
+		/*
+		 * Cascade timers:
+		 */
+		if (!index &&
+			(!cascade(base, &base->tv2, INDEX(0))) &&
+				(!cascade(base, &base->tv3, INDEX(1))) &&
+					!cascade(base, &base->tv4, INDEX(2)))
+			cascade(base, &base->tv5, INDEX(3));
+		++base->timer_jiffies; 
+		list_splice_init(base->tv1.vec + index, &work_list);
+		while (!list_empty(head)) {
+			void (*fn)(unsigned long);
+			unsigned long data;
+
+			timer = list_entry(head->next,struct timer_list,entry);
+ 			fn = timer->function;
+ 			data = timer->data;
+
+			set_running_timer(base, timer);
+			detach_timer(timer, 1);
+			spin_unlock_irq(&base->t_base.lock);
+			{
+				int preempt_count = preempt_count();
+				fn(data);
+				if (preempt_count != preempt_count()) {
+					printk(KERN_WARNING "huh, entered %p "
+					       "with preempt_count %08x, exited"
+					       " with %08x?\n",
+					       fn, preempt_count,
+					       preempt_count());
+					BUG();
+				}
+			}
+			spin_lock_irq(&base->t_base.lock);
+		}
+	}
+	set_running_timer(base, NULL);
+	spin_unlock_irq(&base->t_base.lock);
+}
+
+#ifdef CONFIG_NO_IDLE_HZ
+/*
+ * Find out when the next timer event is due to happen. This
+ * is used on S/390 to stop all activity when a cpus is idle.
+ * This functions needs to be called disabled.
+ */
+unsigned long next_timer_interrupt(void)
+{
+	tvec_base_t *base;
+	struct list_head *list;
+	struct timer_list *nte;
+	unsigned long expires;
+	tvec_t *varray[4];
+	int i, j;
+
+	base = &__get_cpu_var(tvec_bases);
+	spin_lock(&base->t_base.lock);
+	expires = base->timer_jiffies + (LONG_MAX >> 1);
+	list = 0;
+
+	/* Look for timer events in tv1. */
+	j = base->timer_jiffies & TVR_MASK;
+	do {
+		list_for_each_entry(nte, base->tv1.vec + j, entry) {
+			expires = nte->expires;
+			if (j < (base->timer_jiffies & TVR_MASK))
+				list = base->tv2.vec + (INDEX(0));
+			goto found;
+		}
+		j = (j + 1) & TVR_MASK;
+	} while (j != (base->timer_jiffies & TVR_MASK));
+
+	/* Check tv2-tv5. */
+	varray[0] = &base->tv2;
+	varray[1] = &base->tv3;
+	varray[2] = &base->tv4;
+	varray[3] = &base->tv5;
+	for (i = 0; i < 4; i++) {
+		j = INDEX(i);
+		do {
+			if (list_empty(varray[i]->vec + j)) {
+				j = (j + 1) & TVN_MASK;
+				continue;
+			}
+			list_for_each_entry(nte, varray[i]->vec + j, entry)
+				if (time_before(nte->expires, expires))
+					expires = nte->expires;
+			if (j < (INDEX(i)) && i < 3)
+				list = varray[i + 1]->vec + (INDEX(i + 1));
+			goto found;
+		} while (j != (INDEX(i)));
+	}
+found:
+	if (list) {
+		/*
+		 * The search wrapped. We need to look at the next list
+		 * from next tv element that would cascade into tv element
+		 * where we found the timer element.
+		 */
+		list_for_each_entry(nte, list, entry) {
+			if (time_before(nte->expires, expires))
+				expires = nte->expires;
+		}
+	}
+	spin_unlock(&base->t_base.lock);
+	return expires;
+}
+#endif
+
+/*
+ * This function runs timers and the timer-tq in bottom half context.
+ */
+static void run_timer_softirq(struct softirq_action *h)
+{
+	tvec_base_t *base = &__get_cpu_var(tvec_bases);
+
+ 	ktimer_run_queues();
+	if (time_after_eq(jiffies, base->timer_jiffies))
+		__run_timers(base);
+}
+
+/*
+ * Called by the local, per-CPU timer interrupt on SMP.
+ */
+void run_local_timers(void)
+{
+	raise_softirq(TIMER_SOFTIRQ);
+}
+
+static void process_timeout(unsigned long __data)
+{
+	wake_up_process((task_t *)__data);
+}
+
+/**
+ * schedule_timeout - sleep until timeout
+ * @timeout: timeout value in jiffies
+ *
+ * Make the current task sleep until @timeout jiffies have
+ * elapsed. The routine will return immediately unless
+ * the current task state has been set (see set_current_state()).
+ *
+ * You can set the task state as follows -
+ *
+ * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
+ * pass before the routine returns. The routine will return 0
+ *
+ * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
+ * delivered to the current task. In this case the remaining time
+ * in jiffies will be returned, or 0 if the timer expired in time
+ *
+ * The current task state is guaranteed to be TASK_RUNNING when this
+ * routine returns.
+ *
+ * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT will schedule
+ * the CPU away without a bound on the timeout. In this case the return
+ * value will be %MAX_SCHEDULE_TIMEOUT.
+ *
+ * In all cases the return value is guaranteed to be non-negative.
+ */
+fastcall signed long __sched schedule_timeout(signed long timeout)
+{
+	struct timer_list timer;
+	unsigned long expire;
+
+	switch (timeout)
+	{
+	case MAX_SCHEDULE_TIMEOUT:
+		/*
+		 * These two special cases are useful to be comfortable
+		 * in the caller. Nothing more. We could take
+		 * MAX_SCHEDULE_TIMEOUT from one of the negative value
+		 * but I' d like to return a valid offset (>=0) to allow
+		 * the caller to do everything it want with the retval.
+		 */
+		schedule();
+		goto out;
+	default:
+		/*
+		 * Another bit of PARANOID. Note that the retval will be
+		 * 0 since no piece of kernel is supposed to do a check
+		 * for a negative retval of schedule_timeout() (since it
+		 * should never happens anyway). You just have the printk()
+		 * that will tell you if something is gone wrong and where.
+		 */
+		if (timeout < 0)
+		{
+			printk(KERN_ERR "schedule_timeout: wrong timeout "
+				"value %lx from %p\n", timeout,
+				__builtin_return_address(0));
+			current->state = TASK_RUNNING;
+			goto out;
+		}
+	}
+
+	expire = timeout + jiffies;
+
+	setup_timer(&timer, process_timeout, (unsigned long)current);
+	__mod_timer(&timer, expire);
+	schedule();
+	del_singleshot_timer_sync(&timer);
+
+	timeout = expire - jiffies;
+
+ out:
+	return timeout < 0 ? 0 : timeout;
+}
+EXPORT_SYMBOL(schedule_timeout);
+
+/*
+ * We can use __set_current_state() here because schedule_timeout() calls
+ * schedule() unconditionally.
+ */
+signed long __sched schedule_timeout_interruptible(signed long timeout)
+{
+	__set_current_state(TASK_INTERRUPTIBLE);
+	return schedule_timeout(timeout);
+}
+EXPORT_SYMBOL(schedule_timeout_interruptible);
+
+signed long __sched schedule_timeout_uninterruptible(signed long timeout)
+{
+	__set_current_state(TASK_UNINTERRUPTIBLE);
+	return schedule_timeout(timeout);
+}
+EXPORT_SYMBOL(schedule_timeout_uninterruptible);
+
+/**
+ * msleep - sleep safely even with waitqueue interruptions
+ * @msecs: Time in milliseconds to sleep for
+ */
+void msleep(unsigned int msecs)
+{
+	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
+
+	while (timeout)
+		timeout = schedule_timeout_uninterruptible(timeout);
+}
+
+EXPORT_SYMBOL(msleep);
+
+/**
+ * msleep_interruptible - sleep waiting for signals
+ * @msecs: Time in milliseconds to sleep for
+ */
+unsigned long msleep_interruptible(unsigned int msecs)
+{
+	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
+
+	while (timeout && !signal_pending(current))
+		timeout = schedule_timeout_interruptible(timeout);
+	return jiffies_to_msecs(timeout);
+}
+
+EXPORT_SYMBOL(msleep_interruptible);
+
+static void __devinit init_timers_cpu(int cpu)
+{
+	int j;
+	tvec_base_t *base;
+
+	base = &per_cpu(tvec_bases, cpu);
+	spin_lock_init(&base->t_base.lock);
+	for (j = 0; j < TVN_SIZE; j++) {
+		INIT_LIST_HEAD(base->tv5.vec + j);
+		INIT_LIST_HEAD(base->tv4.vec + j);
+		INIT_LIST_HEAD(base->tv3.vec + j);
+		INIT_LIST_HEAD(base->tv2.vec + j);
+	}
+	for (j = 0; j < TVR_SIZE; j++)
+		INIT_LIST_HEAD(base->tv1.vec + j);
+
+	base->timer_jiffies = jiffies;
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void migrate_timer_list(tvec_base_t *new_base, struct list_head *head)
+{
+	struct timer_list *timer;
+
+	while (!list_empty(head)) {
+		timer = list_entry(head->next, struct timer_list, entry);
+		detach_timer(timer, 0);
+		timer->base = &new_base->t_base;
+		internal_add_timer(new_base, timer);
+	}
+}
+
+static void __devinit migrate_timers(int cpu)
+{
+	tvec_base_t *old_base;
+	tvec_base_t *new_base;
+	int i;
+
+	BUG_ON(cpu_online(cpu));
+	old_base = &per_cpu(tvec_bases, cpu);
+	new_base = &get_cpu_var(tvec_bases);
+
+	local_irq_disable();
+	spin_lock(&new_base->t_base.lock);
+	spin_lock(&old_base->t_base.lock);
+
+	if (old_base->t_base.running_timer)
+		BUG();
+	for (i = 0; i < TVR_SIZE; i++)
+		migrate_timer_list(new_base, old_base->tv1.vec + i);
+	for (i = 0; i < TVN_SIZE; i++) {
+		migrate_timer_list(new_base, old_base->tv2.vec + i);
+		migrate_timer_list(new_base, old_base->tv3.vec + i);
+		migrate_timer_list(new_base, old_base->tv4.vec + i);
+		migrate_timer_list(new_base, old_base->tv5.vec + i);
+	}
+
+	spin_unlock(&old_base->t_base.lock);
+	spin_unlock(&new_base->t_base.lock);
+	local_irq_enable();
+	put_cpu_var(tvec_bases);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+static int __devinit timer_cpu_notify(struct notifier_block *self, 
+				unsigned long action, void *hcpu)
+{
+	long cpu = (long)hcpu;
+	switch(action) {
+	case CPU_UP_PREPARE:
+		init_timers_cpu(cpu);
+		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_DEAD:
+		migrate_timers(cpu);
+		break;
+#endif
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __devinitdata timers_nb = {
+	.notifier_call	= timer_cpu_notify,
+};
+
+
+void __init init_timers(void)
+{
+	timer_cpu_notify(&timers_nb, (unsigned long)CPU_UP_PREPARE,
+				(void *)(long)smp_processor_id());
+	register_cpu_notifier(&timers_nb);
+	open_softirq(TIMER_SOFTIRQ, run_timer_softirq, NULL);
+}
Index: linux/kernel/timer.c
===================================================================
--- linux.orig/kernel/timer.c
+++ linux/kernel/timer.c
@@ -1,12 +1,10 @@
 /*
  *  linux/kernel/timer.c
  *
- *  Kernel internal timers, kernel timekeeping, basic process system calls
+ *  Kernel timekeeping, basic process system calls
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
- *  1997-01-28  Modified by Finn Arne Gangstad to make timers scale better.
- *
  *  1997-09-10  Updated NTP code according to technical memorandum Jan '96
  *              "A Kernel Model for Precision Timekeeping" by Dave Mills
  *  1998-12-24  Fixed a xtime SMP race (we need the xtime_lock rw spinlock to
@@ -14,9 +12,6 @@
  *                              Copyright (C) 1998  Andrea Arcangeli
  *  1999-03-10  Improved NTP compatibility by Ulrich Windl
  *  2002-05-31	Move sys_sysinfo here and make its locking sane, Robert Love
- *  2000-10-05  Implemented scalable SMP per-CPU timer handling.
- *                              Copyright (C) 2000, 2001, 2002  Ingo Molnar
- *              Designed by David S. Miller, Alexey Kuznetsov and Ingo Molnar
  */
 
 #include <linux/kernel_stat.h>
@@ -51,503 +46,6 @@ u64 jiffies_64 __cacheline_aligned_in_sm
 EXPORT_SYMBOL(jiffies_64);
 
 /*
- * per-CPU timer vector definitions:
- */
-
-#define TVN_BITS (CONFIG_BASE_SMALL ? 4 : 6)
-#define TVR_BITS (CONFIG_BASE_SMALL ? 6 : 8)
-#define TVN_SIZE (1 << TVN_BITS)
-#define TVR_SIZE (1 << TVR_BITS)
-#define TVN_MASK (TVN_SIZE - 1)
-#define TVR_MASK (TVR_SIZE - 1)
-
-struct timer_base_s {
-	spinlock_t lock;
-	struct timer_list *running_timer;
-};
-
-typedef struct tvec_s {
-	struct list_head vec[TVN_SIZE];
-} tvec_t;
-
-typedef struct tvec_root_s {
-	struct list_head vec[TVR_SIZE];
-} tvec_root_t;
-
-struct tvec_t_base_s {
-	struct timer_base_s t_base;
-	unsigned long timer_jiffies;
-	tvec_root_t tv1;
-	tvec_t tv2;
-	tvec_t tv3;
-	tvec_t tv4;
-	tvec_t tv5;
-} ____cacheline_aligned_in_smp;
-
-typedef struct tvec_t_base_s tvec_base_t;
-static DEFINE_PER_CPU(tvec_base_t, tvec_bases);
-
-static inline void set_running_timer(tvec_base_t *base,
-					struct timer_list *timer)
-{
-#ifdef CONFIG_SMP
-	base->t_base.running_timer = timer;
-#endif
-}
-
-static void internal_add_timer(tvec_base_t *base, struct timer_list *timer)
-{
-	unsigned long expires = timer->expires;
-	unsigned long idx = expires - base->timer_jiffies;
-	struct list_head *vec;
-
-	if (idx < TVR_SIZE) {
-		int i = expires & TVR_MASK;
-		vec = base->tv1.vec + i;
-	} else if (idx < 1 << (TVR_BITS + TVN_BITS)) {
-		int i = (expires >> TVR_BITS) & TVN_MASK;
-		vec = base->tv2.vec + i;
-	} else if (idx < 1 << (TVR_BITS + 2 * TVN_BITS)) {
-		int i = (expires >> (TVR_BITS + TVN_BITS)) & TVN_MASK;
-		vec = base->tv3.vec + i;
-	} else if (idx < 1 << (TVR_BITS + 3 * TVN_BITS)) {
-		int i = (expires >> (TVR_BITS + 2 * TVN_BITS)) & TVN_MASK;
-		vec = base->tv4.vec + i;
-	} else if ((signed long) idx < 0) {
-		/*
-		 * Can happen if you add a timer with expires == jiffies,
-		 * or you set a timer to go off in the past
-		 */
-		vec = base->tv1.vec + (base->timer_jiffies & TVR_MASK);
-	} else {
-		int i;
-		/* If the timeout is larger than 0xffffffff on 64-bit
-		 * architectures then we use the maximum timeout:
-		 */
-		if (idx > 0xffffffffUL) {
-			idx = 0xffffffffUL;
-			expires = idx + base->timer_jiffies;
-		}
-		i = (expires >> (TVR_BITS + 3 * TVN_BITS)) & TVN_MASK;
-		vec = base->tv5.vec + i;
-	}
-	/*
-	 * Timers are FIFO:
-	 */
-	list_add_tail(&timer->entry, vec);
-}
-
-typedef struct timer_base_s timer_base_t;
-/*
- * Used by TIMER_INITIALIZER, we can't use per_cpu(tvec_bases)
- * at compile time, and we need timer->base to lock the timer.
- */
-timer_base_t __init_timer_base
-	____cacheline_aligned_in_smp = { .lock = SPIN_LOCK_UNLOCKED };
-EXPORT_SYMBOL(__init_timer_base);
-
-/***
- * init_timer - initialize a timer.
- * @timer: the timer to be initialized
- *
- * init_timer() must be done to a timer prior calling *any* of the
- * other timer functions.
- */
-void fastcall init_timer(struct timer_list *timer)
-{
-	timer->entry.next = NULL;
-	timer->base = &per_cpu(tvec_bases, raw_smp_processor_id()).t_base;
-}
-EXPORT_SYMBOL(init_timer);
-
-static inline void detach_timer(struct timer_list *timer,
-					int clear_pending)
-{
-	struct list_head *entry = &timer->entry;
-
-	__list_del(entry->prev, entry->next);
-	if (clear_pending)
-		entry->next = NULL;
-	entry->prev = LIST_POISON2;
-}
-
-/*
- * We are using hashed locking: holding per_cpu(tvec_bases).t_base.lock
- * means that all timers which are tied to this base via timer->base are
- * locked, and the base itself is locked too.
- *
- * So __run_timers/migrate_timers can safely modify all timers which could
- * be found on ->tvX lists.
- *
- * When the timer's base is locked, and the timer removed from list, it is
- * possible to set timer->base = NULL and drop the lock: the timer remains
- * locked.
- */
-static timer_base_t *lock_timer_base(struct timer_list *timer,
-					unsigned long *flags)
-{
-	timer_base_t *base;
-
-	for (;;) {
-		base = timer->base;
-		if (likely(base != NULL)) {
-			spin_lock_irqsave(&base->lock, *flags);
-			if (likely(base == timer->base))
-				return base;
-			/* The timer has migrated to another CPU */
-			spin_unlock_irqrestore(&base->lock, *flags);
-		}
-		cpu_relax();
-	}
-}
-
-int __mod_timer(struct timer_list *timer, unsigned long expires)
-{
-	timer_base_t *base;
-	tvec_base_t *new_base;
-	unsigned long flags;
-	int ret = 0;
-
-	BUG_ON(!timer->function);
-
-	base = lock_timer_base(timer, &flags);
-
-	if (timer_pending(timer)) {
-		detach_timer(timer, 0);
-		ret = 1;
-	}
-
-	new_base = &__get_cpu_var(tvec_bases);
-
-	if (base != &new_base->t_base) {
-		/*
-		 * We are trying to schedule the timer on the local CPU.
-		 * However we can't change timer's base while it is running,
-		 * otherwise del_timer_sync() can't detect that the timer's
-		 * handler yet has not finished. This also guarantees that
-		 * the timer is serialized wrt itself.
-		 */
-		if (unlikely(base->running_timer == timer)) {
-			/* The timer remains on a former base */
-			new_base = container_of(base, tvec_base_t, t_base);
-		} else {
-			/* See the comment in lock_timer_base() */
-			timer->base = NULL;
-			spin_unlock(&base->lock);
-			spin_lock(&new_base->t_base.lock);
-			timer->base = &new_base->t_base;
-		}
-	}
-
-	timer->expires = expires;
-	internal_add_timer(new_base, timer);
-	spin_unlock_irqrestore(&new_base->t_base.lock, flags);
-
-	return ret;
-}
-
-EXPORT_SYMBOL(__mod_timer);
-
-/***
- * add_timer_on - start a timer on a particular CPU
- * @timer: the timer to be added
- * @cpu: the CPU to start it on
- *
- * This is not very scalable on SMP. Double adds are not possible.
- */
-void add_timer_on(struct timer_list *timer, int cpu)
-{
-	tvec_base_t *base = &per_cpu(tvec_bases, cpu);
-  	unsigned long flags;
-
-  	BUG_ON(timer_pending(timer) || !timer->function);
-	spin_lock_irqsave(&base->t_base.lock, flags);
-	timer->base = &base->t_base;
-	internal_add_timer(base, timer);
-	spin_unlock_irqrestore(&base->t_base.lock, flags);
-}
-
-
-/***
- * mod_timer - modify a timer's timeout
- * @timer: the timer to be modified
- *
- * mod_timer is a more efficient way to update the expire field of an
- * active timer (if the timer is inactive it will be activated)
- *
- * mod_timer(timer, expires) is equivalent to:
- *
- *     del_timer(timer); timer->expires = expires; add_timer(timer);
- *
- * Note that if there are multiple unserialized concurrent users of the
- * same timer, then mod_timer() is the only safe way to modify the timeout,
- * since add_timer() cannot modify an already running timer.
- *
- * The function returns whether it has modified a pending timer or not.
- * (ie. mod_timer() of an inactive timer returns 0, mod_timer() of an
- * active timer returns 1.)
- */
-int mod_timer(struct timer_list *timer, unsigned long expires)
-{
-	BUG_ON(!timer->function);
-
-	/*
-	 * This is a common optimization triggered by the
-	 * networking code - if the timer is re-modified
-	 * to be the same thing then just return:
-	 */
-	if (timer->expires == expires && timer_pending(timer))
-		return 1;
-
-	return __mod_timer(timer, expires);
-}
-
-EXPORT_SYMBOL(mod_timer);
-
-/***
- * del_timer - deactive a timer.
- * @timer: the timer to be deactivated
- *
- * del_timer() deactivates a timer - this works on both active and inactive
- * timers.
- *
- * The function returns whether it has deactivated a pending timer or not.
- * (ie. del_timer() of an inactive timer returns 0, del_timer() of an
- * active timer returns 1.)
- */
-int del_timer(struct timer_list *timer)
-{
-	timer_base_t *base;
-	unsigned long flags;
-	int ret = 0;
-
-	if (timer_pending(timer)) {
-		base = lock_timer_base(timer, &flags);
-		if (timer_pending(timer)) {
-			detach_timer(timer, 1);
-			ret = 1;
-		}
-		spin_unlock_irqrestore(&base->lock, flags);
-	}
-
-	return ret;
-}
-
-EXPORT_SYMBOL(del_timer);
-
-#ifdef CONFIG_SMP
-/*
- * This function tries to deactivate a timer. Upon successful (ret >= 0)
- * exit the timer is not queued and the handler is not running on any CPU.
- *
- * It must not be called from interrupt contexts.
- */
-int try_to_del_timer_sync(struct timer_list *timer)
-{
-	timer_base_t *base;
-	unsigned long flags;
-	int ret = -1;
-
-	base = lock_timer_base(timer, &flags);
-
-	if (base->running_timer == timer)
-		goto out;
-
-	ret = 0;
-	if (timer_pending(timer)) {
-		detach_timer(timer, 1);
-		ret = 1;
-	}
-out:
-	spin_unlock_irqrestore(&base->lock, flags);
-
-	return ret;
-}
-
-/***
- * del_timer_sync - deactivate a timer and wait for the handler to finish.
- * @timer: the timer to be deactivated
- *
- * This function only differs from del_timer() on SMP: besides deactivating
- * the timer it also makes sure the handler has finished executing on other
- * CPUs.
- *
- * Synchronization rules: callers must prevent restarting of the timer,
- * otherwise this function is meaningless. It must not be called from
- * interrupt contexts. The caller must not hold locks which would prevent
- * completion of the timer's handler. The timer's handler must not call
- * add_timer_on(). Upon exit the timer is not queued and the handler is
- * not running on any CPU.
- *
- * The function returns whether it has deactivated a pending timer or not.
- */
-int del_timer_sync(struct timer_list *timer)
-{
-	for (;;) {
-		int ret = try_to_del_timer_sync(timer);
-		if (ret >= 0)
-			return ret;
-	}
-}
-
-EXPORT_SYMBOL(del_timer_sync);
-#endif
-
-static int cascade(tvec_base_t *base, tvec_t *tv, int index)
-{
-	/* cascade all the timers from tv up one level */
-	struct list_head *head, *curr;
-
-	head = tv->vec + index;
-	curr = head->next;
-	/*
-	 * We are removing _all_ timers from the list, so we don't  have to
-	 * detach them individually, just clear the list afterwards.
-	 */
-	while (curr != head) {
-		struct timer_list *tmp;
-
-		tmp = list_entry(curr, struct timer_list, entry);
-		BUG_ON(tmp->base != &base->t_base);
-		curr = curr->next;
-		internal_add_timer(base, tmp);
-	}
-	INIT_LIST_HEAD(head);
-
-	return index;
-}
-
-/***
- * __run_timers - run all expired timers (if any) on this CPU.
- * @base: the timer vector to be processed.
- *
- * This function cascades all vectors and executes all expired timer
- * vectors.
- */
-#define INDEX(N) (base->timer_jiffies >> (TVR_BITS + N * TVN_BITS)) & TVN_MASK
-
-static inline void __run_timers(tvec_base_t *base)
-{
-	struct timer_list *timer;
-
-	spin_lock_irq(&base->t_base.lock);
-	while (time_after_eq(jiffies, base->timer_jiffies)) {
-		struct list_head work_list = LIST_HEAD_INIT(work_list);
-		struct list_head *head = &work_list;
- 		int index = base->timer_jiffies & TVR_MASK;
- 
-		/*
-		 * Cascade timers:
-		 */
-		if (!index &&
-			(!cascade(base, &base->tv2, INDEX(0))) &&
-				(!cascade(base, &base->tv3, INDEX(1))) &&
-					!cascade(base, &base->tv4, INDEX(2)))
-			cascade(base, &base->tv5, INDEX(3));
-		++base->timer_jiffies; 
-		list_splice_init(base->tv1.vec + index, &work_list);
-		while (!list_empty(head)) {
-			void (*fn)(unsigned long);
-			unsigned long data;
-
-			timer = list_entry(head->next,struct timer_list,entry);
- 			fn = timer->function;
- 			data = timer->data;
-
-			set_running_timer(base, timer);
-			detach_timer(timer, 1);
-			spin_unlock_irq(&base->t_base.lock);
-			{
-				int preempt_count = preempt_count();
-				fn(data);
-				if (preempt_count != preempt_count()) {
-					printk(KERN_WARNING "huh, entered %p "
-					       "with preempt_count %08x, exited"
-					       " with %08x?\n",
-					       fn, preempt_count,
-					       preempt_count());
-					BUG();
-				}
-			}
-			spin_lock_irq(&base->t_base.lock);
-		}
-	}
-	set_running_timer(base, NULL);
-	spin_unlock_irq(&base->t_base.lock);
-}
-
-#ifdef CONFIG_NO_IDLE_HZ
-/*
- * Find out when the next timer event is due to happen. This
- * is used on S/390 to stop all activity when a cpus is idle.
- * This functions needs to be called disabled.
- */
-unsigned long next_timer_interrupt(void)
-{
-	tvec_base_t *base;
-	struct list_head *list;
-	struct timer_list *nte;
-	unsigned long expires;
-	tvec_t *varray[4];
-	int i, j;
-
-	base = &__get_cpu_var(tvec_bases);
-	spin_lock(&base->t_base.lock);
-	expires = base->timer_jiffies + (LONG_MAX >> 1);
-	list = 0;
-
-	/* Look for timer events in tv1. */
-	j = base->timer_jiffies & TVR_MASK;
-	do {
-		list_for_each_entry(nte, base->tv1.vec + j, entry) {
-			expires = nte->expires;
-			if (j < (base->timer_jiffies & TVR_MASK))
-				list = base->tv2.vec + (INDEX(0));
-			goto found;
-		}
-		j = (j + 1) & TVR_MASK;
-	} while (j != (base->timer_jiffies & TVR_MASK));
-
-	/* Check tv2-tv5. */
-	varray[0] = &base->tv2;
-	varray[1] = &base->tv3;
-	varray[2] = &base->tv4;
-	varray[3] = &base->tv5;
-	for (i = 0; i < 4; i++) {
-		j = INDEX(i);
-		do {
-			if (list_empty(varray[i]->vec + j)) {
-				j = (j + 1) & TVN_MASK;
-				continue;
-			}
-			list_for_each_entry(nte, varray[i]->vec + j, entry)
-				if (time_before(nte->expires, expires))
-					expires = nte->expires;
-			if (j < (INDEX(i)) && i < 3)
-				list = varray[i + 1]->vec + (INDEX(i + 1));
-			goto found;
-		} while (j != (INDEX(i)));
-	}
-found:
-	if (list) {
-		/*
-		 * The search wrapped. We need to look at the next list
-		 * from next tv element that would cascade into tv element
-		 * where we found the timer element.
-		 */
-		list_for_each_entry(nte, list, entry) {
-			if (time_before(nte->expires, expires))
-				expires = nte->expires;
-		}
-	}
-	spin_unlock(&base->t_base.lock);
-	return expires;
-}
-#endif
-
-/******************************************************************/
-
-/*
  * Timekeeping variables
  */
 unsigned long tick_usec = TICK_USEC; 		/* USER_HZ period (usec) */
@@ -851,26 +349,6 @@ EXPORT_SYMBOL(xtime_lock);
 #endif
 
 /*
- * This function runs timers and the timer-tq in bottom half context.
- */
-static void run_timer_softirq(struct softirq_action *h)
-{
-	tvec_base_t *base = &__get_cpu_var(tvec_bases);
-
- 	ktimer_run_queues();
-	if (time_after_eq(jiffies, base->timer_jiffies))
-		__run_timers(base);
-}
-
-/*
- * Called by the local, per-CPU timer interrupt on SMP.
- */
-void run_local_timers(void)
-{
-	raise_softirq(TIMER_SOFTIRQ);
-}
-
-/*
  * Called by the timer interrupt. xtime_lock must already be taken
  * by the timer IRQ!
  */
@@ -1015,104 +493,6 @@ asmlinkage long sys_getegid(void)
 
 #endif
 
-static void process_timeout(unsigned long __data)
-{
-	wake_up_process((task_t *)__data);
-}
-
-/**
- * schedule_timeout - sleep until timeout
- * @timeout: timeout value in jiffies
- *
- * Make the current task sleep until @timeout jiffies have
- * elapsed. The routine will return immediately unless
- * the current task state has been set (see set_current_state()).
- *
- * You can set the task state as follows -
- *
- * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
- * pass before the routine returns. The routine will return 0
- *
- * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
- * delivered to the current task. In this case the remaining time
- * in jiffies will be returned, or 0 if the timer expired in time
- *
- * The current task state is guaranteed to be TASK_RUNNING when this
- * routine returns.
- *
- * Specifying a @timeout value of %MAX_SCHEDULE_TIMEOUT will schedule
- * the CPU away without a bound on the timeout. In this case the return
- * value will be %MAX_SCHEDULE_TIMEOUT.
- *
- * In all cases the return value is guaranteed to be non-negative.
- */
-fastcall signed long __sched schedule_timeout(signed long timeout)
-{
-	struct timer_list timer;
-	unsigned long expire;
-
-	switch (timeout)
-	{
-	case MAX_SCHEDULE_TIMEOUT:
-		/*
-		 * These two special cases are useful to be comfortable
-		 * in the caller. Nothing more. We could take
-		 * MAX_SCHEDULE_TIMEOUT from one of the negative value
-		 * but I' d like to return a valid offset (>=0) to allow
-		 * the caller to do everything it want with the retval.
-		 */
-		schedule();
-		goto out;
-	default:
-		/*
-		 * Another bit of PARANOID. Note that the retval will be
-		 * 0 since no piece of kernel is supposed to do a check
-		 * for a negative retval of schedule_timeout() (since it
-		 * should never happens anyway). You just have the printk()
-		 * that will tell you if something is gone wrong and where.
-		 */
-		if (timeout < 0)
-		{
-			printk(KERN_ERR "schedule_timeout: wrong timeout "
-				"value %lx from %p\n", timeout,
-				__builtin_return_address(0));
-			current->state = TASK_RUNNING;
-			goto out;
-		}
-	}
-
-	expire = timeout + jiffies;
-
-	setup_timer(&timer, process_timeout, (unsigned long)current);
-	__mod_timer(&timer, expire);
-	schedule();
-	del_singleshot_timer_sync(&timer);
-
-	timeout = expire - jiffies;
-
- out:
-	return timeout < 0 ? 0 : timeout;
-}
-EXPORT_SYMBOL(schedule_timeout);
-
-/*
- * We can use __set_current_state() here because schedule_timeout() calls
- * schedule() unconditionally.
- */
-signed long __sched schedule_timeout_interruptible(signed long timeout)
-{
-	__set_current_state(TASK_INTERRUPTIBLE);
-	return schedule_timeout(timeout);
-}
-EXPORT_SYMBOL(schedule_timeout_interruptible);
-
-signed long __sched schedule_timeout_uninterruptible(signed long timeout)
-{
-	__set_current_state(TASK_UNINTERRUPTIBLE);
-	return schedule_timeout(timeout);
-}
-EXPORT_SYMBOL(schedule_timeout_uninterruptible);
-
 /* Thread ID - the internal kernel "pid" */
 asmlinkage long sys_gettid(void)
 {
@@ -1208,102 +588,6 @@ asmlinkage long sys_sysinfo(struct sysin
 	return 0;
 }
 
-static void __devinit init_timers_cpu(int cpu)
-{
-	int j;
-	tvec_base_t *base;
-
-	base = &per_cpu(tvec_bases, cpu);
-	spin_lock_init(&base->t_base.lock);
-	for (j = 0; j < TVN_SIZE; j++) {
-		INIT_LIST_HEAD(base->tv5.vec + j);
-		INIT_LIST_HEAD(base->tv4.vec + j);
-		INIT_LIST_HEAD(base->tv3.vec + j);
-		INIT_LIST_HEAD(base->tv2.vec + j);
-	}
-	for (j = 0; j < TVR_SIZE; j++)
-		INIT_LIST_HEAD(base->tv1.vec + j);
-
-	base->timer_jiffies = jiffies;
-}
-
-#ifdef CONFIG_HOTPLUG_CPU
-static void migrate_timer_list(tvec_base_t *new_base, struct list_head *head)
-{
-	struct timer_list *timer;
-
-	while (!list_empty(head)) {
-		timer = list_entry(head->next, struct timer_list, entry);
-		detach_timer(timer, 0);
-		timer->base = &new_base->t_base;
-		internal_add_timer(new_base, timer);
-	}
-}
-
-static void __devinit migrate_timers(int cpu)
-{
-	tvec_base_t *old_base;
-	tvec_base_t *new_base;
-	int i;
-
-	BUG_ON(cpu_online(cpu));
-	old_base = &per_cpu(tvec_bases, cpu);
-	new_base = &get_cpu_var(tvec_bases);
-
-	local_irq_disable();
-	spin_lock(&new_base->t_base.lock);
-	spin_lock(&old_base->t_base.lock);
-
-	if (old_base->t_base.running_timer)
-		BUG();
-	for (i = 0; i < TVR_SIZE; i++)
-		migrate_timer_list(new_base, old_base->tv1.vec + i);
-	for (i = 0; i < TVN_SIZE; i++) {
-		migrate_timer_list(new_base, old_base->tv2.vec + i);
-		migrate_timer_list(new_base, old_base->tv3.vec + i);
-		migrate_timer_list(new_base, old_base->tv4.vec + i);
-		migrate_timer_list(new_base, old_base->tv5.vec + i);
-	}
-
-	spin_unlock(&old_base->t_base.lock);
-	spin_unlock(&new_base->t_base.lock);
-	local_irq_enable();
-	put_cpu_var(tvec_bases);
-}
-#endif /* CONFIG_HOTPLUG_CPU */
-
-static int __devinit timer_cpu_notify(struct notifier_block *self, 
-				unsigned long action, void *hcpu)
-{
-	long cpu = (long)hcpu;
-	switch(action) {
-	case CPU_UP_PREPARE:
-		init_timers_cpu(cpu);
-		break;
-#ifdef CONFIG_HOTPLUG_CPU
-	case CPU_DEAD:
-		migrate_timers(cpu);
-		break;
-#endif
-	default:
-		break;
-	}
-	return NOTIFY_OK;
-}
-
-static struct notifier_block __devinitdata timers_nb = {
-	.notifier_call	= timer_cpu_notify,
-};
-
-
-void __init init_timers(void)
-{
-	timer_cpu_notify(&timers_nb, (unsigned long)CPU_UP_PREPARE,
-				(void *)(long)smp_processor_id());
-	register_cpu_notifier(&timers_nb);
-	open_softirq(TIMER_SOFTIRQ, run_timer_softirq, NULL);
-}
-
 #ifdef CONFIG_TIME_INTERPOLATION
 
 struct time_interpolator *time_interpolator;
@@ -1492,32 +776,3 @@ unregister_time_interpolator(struct time
 	spin_unlock(&time_interpolator_lock);
 }
 #endif /* CONFIG_TIME_INTERPOLATION */
-
-/**
- * msleep - sleep safely even with waitqueue interruptions
- * @msecs: Time in milliseconds to sleep for
- */
-void msleep(unsigned int msecs)
-{
-	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
-
-	while (timeout)
-		timeout = schedule_timeout_uninterruptible(timeout);
-}
-
-EXPORT_SYMBOL(msleep);
-
-/**
- * msleep_interruptible - sleep waiting for signals
- * @msecs: Time in milliseconds to sleep for
- */
-unsigned long msleep_interruptible(unsigned int msecs)
-{
-	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
-
-	while (timeout && !signal_pending(current))
-		timeout = schedule_timeout_interruptible(timeout);
-	return jiffies_to_msecs(timeout);
-}
-
-EXPORT_SYMBOL(msleep_interruptible);

--

