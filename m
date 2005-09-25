Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVIYGnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVIYGnW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 02:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVIYGnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 02:43:22 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:51550 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751189AbVIYGnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 02:43:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=hO0FHThKGEGdLjc5cKO11ZLIX9KgZy3UMlBD+scIkoo1pckDZap79sNuzxL+MgzFLY0ObtlSxy6P+HbAbtdTeocAMOlTAzyDRSdkOcKsnQAhXc7CoQSwLV7Z4y9kiUEt3oG7Ackag+BlpqA7lNbeVbQT46bEw6tIbqy5j5wF8XM=
From: Tejun Heo <htejun@gmail.com>
To: zwane@linuxpower.ca, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050925064218.E7558977@htj.dyndns.org>
In-Reply-To: <20050925064218.E7558977@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6 01/04] brsem: implement big reader semaphore
Message-ID: <20050925064218.FF1C2BEC@htj.dyndns.org>
Date: Sun, 25 Sep 2005 15:43:12 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_brsem_implement_brsem.patch

	This patch implements big reader semaphore - a rwsem with very
	cheap reader-side operations and very expensive writer-side
	operations.  For details, please read comments at the top of
	kern/brsem.c.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 include/linux/brsem.h |  202 +++++++++++
 init/main.c           |    3 
 kernel/Makefile       |    2 
 kernel/brsem.c        |  869 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1075 insertions(+), 1 deletion(-)

Index: linux-work/include/linux/brsem.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/include/linux/brsem.h	2005-09-25 15:42:03.000000000 +0900
@@ -0,0 +1,202 @@
+#ifndef __LINUX_BRSEM_H
+#define __LINUX_BRSEM_H
+
+/*
+ * include/linux/brsem.h		- Big reader rw semaphore
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ *
+ * Copyright (C) 2005 Tejun Heo <htejun@gmail.com>
+ *
+ * See kernel/brsem.c for more information.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+#include <linux/percpu.h>
+#include <asm/semaphore.h>
+
+DECLARE_PER_CPU(int *, brsem_rcnt_ar);
+
+struct brsem {
+	int idx;
+	spinlock_t lock;
+	long long master_rcnt;
+	wait_queue_head_t read_wait;
+	wait_queue_head_t write_wait;
+	struct semaphore write_mutex;
+	struct work_struct async_work;
+	unsigned flags;
+};
+
+enum {
+	/*
+	 * sem->flags, protected by sem->lock
+	 */
+	BRSEM_F_ALLOCATED		= 0x0001,
+	BRSEM_F_BYPASS			= 0x0002,
+
+	/* Async todo flags */
+	BRSEM_F_ASYNC_UPWRITE		= 0x0100,
+	BRSEM_F_ASYNC_DESTROY		= 0x0200,
+	BRSEM_F_ASYNC_MASK		= 0x0300,
+};
+
+/*
+ * brsem subsys initialization routines, called from init/main.c
+ */
+void brsem_init_early(void);
+void brsem_init(void);
+
+/*
+ * The following initializer and __create_brsem() are for cases where
+ * brsem should be used before brsem_init_early() is finished.
+ */
+#define BRSEM_BYPASS_INITIALIZER	{ .idx = 0, .flags = BRSEM_F_BYPASS }
+
+struct brsem *__create_brsem(struct brsem *sem);
+
+int __brsem_down_read_slow(struct brsem *sem, int interruptible);
+int __brsem_down_read_trylock_slow(struct brsem *sem);
+void __brsem_up_read_slow(struct brsem *sem);
+
+static inline int *__brsem_rcnt(struct brsem *sem)
+{
+	return __get_cpu_var(brsem_rcnt_ar) + sem->idx;
+}
+
+/*
+ * The following *_crit functions can be changed to use
+ * local_irq_disable/enable on architectures where irq switching is
+ * cheaper than bh switching.  See brsem.c for more information.
+ */
+static inline void __brsem_enter_crit(void)
+{
+	local_bh_disable();
+}
+
+static inline void __brsem_leave_crit(void)
+{
+	if (!irqs_disabled())		/* is this cheap on all archs? */
+		local_bh_enable();
+	else
+		__local_bh_enable();
+}
+
+static inline int __brsem_down_read(struct brsem *sem, int interruptible)
+{
+	int *p;
+	might_sleep();
+	__brsem_enter_crit();
+	p = __brsem_rcnt(sem);
+	if (*p - 1 < INT_MAX - 1) {	/* *p != INT_MIN && *p != INT_MAX */
+		(*p)++;
+		__brsem_leave_crit();
+		return 0;
+	}
+	return __brsem_down_read_slow(sem, interruptible);
+}
+
+/*
+ * Public functions
+ */
+
+/**
+ * create_brsem - allocates and initializes a new brsem.  Returns
+ * pointer to the new brsem on success, NULL on failure
+ *
+ * This function may sleep.
+ */
+static inline struct brsem *create_brsem(void)
+{
+	return __create_brsem(NULL);
+}
+
+void destroy_brsem(struct brsem *brsem);
+
+/**
+ * brsem_down_read - read lock the specified brsem
+ *
+ * This function may sleep.
+ */
+static inline void brsem_down_read(struct brsem *sem)
+{
+	__brsem_down_read(sem, 0);
+}
+
+/**
+ * brsem_down_read_interruptible - read lock the specified brsem
+ * (interruptible).  Returns 0 on success and -EINTR if interrupted.
+ *
+ * This function is identical to brsem_down_read except that it may be
+ * interrupted by signal.  This function may sleep.
+ */
+static inline int brsem_down_read_interruptible(struct brsem *sem)
+{
+	return __brsem_down_read(sem, 1);
+}
+
+/**
+ * brsem_down_read_trylock - try to read lock the specified brsem.
+ * Returns 1 on sucess and 0 on failure.
+ *
+ * If the specfied brsem can be acquired without sleeping, it's
+ * acquired and 1 is returned; otherwise, 0 is returned.  This
+ * function doesn't sleep and can be called from anywhere except for
+ * irq handlers.
+ */
+static inline int brsem_down_read_trylock(struct brsem *sem)
+{
+	int *p;
+	BUG_ON(in_irq());
+	__brsem_enter_crit();
+	p = __brsem_rcnt(sem);
+	if (*p - 1 < INT_MAX - 1) {	/* *p != INT_MIN && *p != INT_MAX */
+		(*p)++;
+		__brsem_leave_crit();
+		return 1;
+	}
+	return __brsem_down_read_trylock_slow(sem);
+}
+
+/**
+ * brsem_up_read - read unlock the specified brsem
+ *
+ * This function doesn't sleep and can be called from anywhere except
+ * for irq handlers.
+ */
+static inline void brsem_up_read(struct brsem *sem)
+{
+	int *p;
+	BUG_ON(in_irq());
+	__brsem_enter_crit();
+	p = __brsem_rcnt(sem);
+	if (*p > INT_MIN + 1) {		/* *p != INT_MIN && *p != INT_MIN + 1 */
+		(*p)--;
+		__brsem_leave_crit();
+		return;
+	}
+	__brsem_up_read_slow(sem);
+}
+
+void brsem_down_write(struct brsem *sem);
+int brsem_down_write_interruptible(struct brsem *sem);
+void brsem_up_write(struct brsem *sem);
+void brsem_up_write_async(struct brsem *sem);
+
+#endif /* __LINUX_BRSEM_H */
Index: linux-work/kernel/Makefile
===================================================================
--- linux-work.orig/kernel/Makefile	2005-09-25 15:26:33.000000000 +0900
+++ linux-work/kernel/Makefile	2005-09-25 15:42:03.000000000 +0900
@@ -7,7 +7,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
+	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o brsem.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
Index: linux-work/kernel/brsem.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/kernel/brsem.c	2005-09-25 15:42:03.000000000 +0900
@@ -0,0 +1,869 @@
+/*
+ * kernel/brsem.c			- Big reader rw semaphore
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ *
+ * Copyright (C) 2005 Tejun Heo <htejun@gmail.com>
+ *
+ * This file implements big-reader rw semaphore.
+ *
+ * Read locking and unlocking are very cheap - no shared word, no
+ * atomic operation, no memory barrier, just local bh enable/disable,
+ * some cpu-local arithmetics and conditionals.  Of course, we can't
+ * cheat the mother nature and writers take all the overhead plus some
+ * extra.  Write locking and unlocking involve issuing workqueue works
+ * to all active CPUs and waiting for them.
+ *
+ * DO NOT use brsem if updates are frequent.  brsem is intended to be
+ * used for things like file system remount <-> open/write
+ * synchronization or cpu hotplug synchronizaion, where writer side is
+ * _very_ rare while the reader side can be frequent.
+ *
+ * brsem is semantically identical to rwsem except for the followings.
+ *
+ * a. All non-sleeping functions - destroy_brsem,
+ *    brsem_down_read_trylock, brsem_up_read and brsem_up_write_async
+ *    - cannot be called from irq handlers.  They can be called from
+ *    bh or while irq and/or bh are disabled (in_softirq ||
+ *    irqs_disabled) but cannot be called from irq handlers (in_irq).
+ *
+ *    This is because brsem uses bh disable/enable to achieve
+ *    exclusion on local cpu.  This choice is made because switching
+ *    local irq is quite expensive on some architectures.  On
+ *    architectures where local irq switching is cheaper than bh
+ *    switching, changing __brsem_enter/leave_crit to use
+ *    local_irq_disable/enable would be a good idea.  (maybe
+ *    __ARCH_CHEAP_LOCAL_IRQ_OPS)
+ *
+ * b. brsem_up_write needs to sleep.  If write unlocking needs to be
+ *    done while in_atomic, brsem_up_write_async should be used.
+ *
+ *    A dedicated workqueue is used for brsem_up_write_async as
+ *    otherwise deadlock can occur if a work on the same workqueue
+ *    releases a brsem while holding a spin and then tries to regrab
+ *    it after releasing the spin.
+ *
+ *    Note: destroy_brsem also operates asynchronously using the same
+ *    brsem workqueue.
+ *
+ * brsem is different from rcu in that
+ *
+ * a. being a sempahore not a spinlock, readers and writers can sleep
+ *    while holding it.
+ *
+ * b. it actually synchronizes and can be used where transient stale
+ *    data cannot be tolerated or working around is too cumbersome.
+ *
+ * brsem is different from seqlock in that
+ *
+ * a. both readers and writers can sleep while holding it.
+ *
+ * b. it actually synchronizes and can be used where reader side retry
+ *    is impossible or impractical.
+ *
+ * On UP machines, brsem can be trivially replaced by rwsem with
+ * simple macro redirections once rwsem supports interruptible down
+ * operations.
+ */
+
+#include <linux/brsem.h>
+
+#include <linux/idr.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/notifier.h>
+#include <linux/cpu.h>
+#include <linux/module.h>
+#include <linux/completion.h>
+#include <asm/bitops.h>
+#include <asm/atomic.h>
+
+enum {
+	BRSEM_INITIAL_RCNT_ARLEN	= 32,
+};
+
+static int initial_rcnt_ar[BRSEM_INITIAL_RCNT_ARLEN] __initdata = { INT_MIN };
+
+static int brsem_initialized;
+static spinlock_t brsem_alloc_lock = SPIN_LOCK_UNLOCKED;
+static int brsem_len = BRSEM_INITIAL_RCNT_ARLEN;
+static DEFINE_IDR(brsem_idr);
+
+DEFINE_PER_CPU(int *, brsem_rcnt_ar) = initial_rcnt_ar;
+static DEFINE_PER_CPU(int, brsem_rcnt_arlen) = BRSEM_INITIAL_RCNT_ARLEN;
+
+static struct workqueue_struct *brsem_async_wq;
+
+static void do_async_jobs(void *data);
+
+#define is_bypass(sem) \
+	unlikely((sem)->idx == 0 && (sem)->flags & BRSEM_F_BYPASS)
+
+#define check_idx(sem) \
+	BUG_ON((sem)->idx <= 0 || (sem)->idx >= brsem_len)
+
+static inline void spin_lock_crit(spinlock_t *spin)
+{
+	__brsem_enter_crit();
+	spin_lock(spin);
+}
+
+static inline void spin_unlock_crit(spinlock_t *spin)
+{
+	spin_unlock(spin);
+	__brsem_leave_crit();
+}
+
+/*
+ * Call on all cpus
+ */
+struct coac_work_arg {
+	void (*func)(void *);
+	void *data;
+	atomic_t remaining;
+	struct completion completion;
+};
+
+static void coac_work_fn(void *data)
+{
+	struct coac_work_arg *arg = data;
+
+	arg->func(arg->data);
+
+	smp_mb__before_atomic_dec();
+
+	if (atomic_dec_and_test(&arg->remaining))
+		complete(&arg->completion);
+}
+
+static void coac_schedule_work_per_cpu(void *data)
+{
+	struct work_struct *works = data;
+
+	schedule_work(works + smp_processor_id());
+}
+
+static void call_on_all_cpus(void (*func)(void *), void *data)
+{
+	static DECLARE_MUTEX(coac_mutex); /* serializes uses of coac_works */
+	static struct work_struct coac_works[NR_CPUS];
+	struct coac_work_arg coac_arg;
+	int cpu, local_cpu = -1;
+
+	coac_arg.func = func;
+	coac_arg.data = data;
+	atomic_set(&coac_arg.remaining, num_online_cpus());
+	init_completion(&coac_arg.completion);
+
+	for_each_online_cpu(cpu) {
+		struct work_struct *w = coac_works + cpu;
+		INIT_WORK(w, coac_work_fn, &coac_arg);
+	}
+
+	down(&coac_mutex);
+	lock_cpu_hotplug();
+
+	/*
+	 * If we're on keventd, scheduling work and waiting for it
+	 * will deadlock.  In such cases, @func is invoked directly.
+	 * Note that, if we're not on keventd, we cannot call @func
+	 * directly as we aren't bound to specific cpu and @func
+	 * cannot be called with preemption disabled.
+	 */
+	preempt_disable();
+	if (current_is_keventd())
+		local_cpu = smp_processor_id();
+
+	smp_call_function(coac_schedule_work_per_cpu, coac_works, 1, 0);
+
+	if (local_cpu >= 0) {
+		preempt_enable();
+		func(data);
+		if (atomic_dec_and_test(&coac_arg.remaining))
+			smp_mb__after_atomic_dec();
+		else
+			wait_for_completion(&coac_arg.completion);
+	} else {
+		coac_schedule_work_per_cpu(coac_works);
+		preempt_enable();
+		wait_for_completion(&coac_arg.completion);
+	}
+
+	unlock_cpu_hotplug();
+	up(&coac_mutex);
+}
+
+static void *alloc_rcnt_ar(size_t size)
+{
+	if (size <= PAGE_SIZE)
+		return kmalloc(size, GFP_KERNEL);
+	else
+		return vmalloc(size);
+}
+
+static void free_rcnt_ar(void *ptr, size_t size)
+{
+	if (size <= PAGE_SIZE)
+		kfree(ptr);
+	else
+		vfree(ptr);
+}
+
+/*
+ * While expanding rcnt_ar's, substitution should be done locally on
+ * each cpu.  Note that rcnt_ar's are also allocated by each cpu.
+ * This is simpler to implement and NUMA friendly.
+ *
+ * Once expanded, rcnt_ar's are never shrinked, not even when
+ * expansion on other cpus fail.  Per-cpu rcnt_ar_len's are kept to
+ * maintain integrity and avoid unnecessary reallocation.  Note that
+ * per-cpu rcnt_ar_len's are also necessary when processing cpu
+ * hot-plug events.
+ */
+struct expand_brsem_arg {
+	int new_len;
+	atomic_t failed;
+};
+
+static void expand_brsem_cpucb(void *data)
+{
+	struct expand_brsem_arg *ebarg = data;
+	int len, new_len;
+	size_t size, new_size;
+	int *rcnt_ar, *new_rcnt_ar;
+
+	len = __get_cpu_var(brsem_rcnt_arlen);
+	size = sizeof(rcnt_ar[0]) * len;
+	rcnt_ar = __get_cpu_var(brsem_rcnt_ar);
+
+	new_len = ebarg->new_len;
+	if (len >= new_len)
+		return;
+	new_size = sizeof(new_rcnt_ar[0]) * new_len;
+	new_rcnt_ar = alloc_rcnt_ar(new_size);
+	if (!new_rcnt_ar)
+		goto fail;
+
+	memset((void *)new_rcnt_ar + size, 0, new_size - size);
+
+	__brsem_enter_crit();
+	memcpy(new_rcnt_ar, rcnt_ar, size);
+	__get_cpu_var(brsem_rcnt_ar) = new_rcnt_ar;
+	__get_cpu_var(brsem_rcnt_arlen) = new_len;
+	__brsem_leave_crit();
+
+	free_rcnt_ar(rcnt_ar, size);
+
+	return;
+ fail:
+	atomic_inc(&ebarg->failed);
+}
+
+static int expand_brsem(int target_idx)
+{
+	static DECLARE_MUTEX(expand_mutex);
+	int new_len, res;
+	struct expand_brsem_arg ebarg;
+
+	/*
+	 * brsem rcnt_ar's cannot be expanded until brsem is fully
+	 * initialized.  If the following BUG_ON is ever hit, bump
+	 * BRSEM_INITIAL_RCNT_ARLEN.
+	 */
+	BUG_ON(!brsem_initialized);
+
+	down(&expand_mutex);
+
+	new_len = brsem_len;
+	while (new_len <= target_idx) {
+		new_len <<= 1;
+		if (new_len < 0) {
+			/* Duh... wrapped around? */
+			WARN_ON(1);
+			res = -EBUSY;
+			goto out;
+		}
+	}
+
+	res = 0;
+	if (new_len <= brsem_len)
+		goto out;
+
+	ebarg.new_len = new_len;
+	atomic_set(&ebarg.failed, 0);
+
+	call_on_all_cpus(expand_brsem_cpucb, &ebarg);
+
+	res = -ENOMEM;
+	if (atomic_read(&ebarg.failed))
+		goto out;
+
+	brsem_len = new_len;
+	res = 0;
+ out:
+	up(&expand_mutex);
+	return res;
+}
+
+struct brsem *__create_brsem(struct brsem *sem)
+{
+	struct brsem *allocated_sem = NULL;
+	int idx, res;
+
+	if (!sem) {
+		sem = allocated_sem = kzalloc(sizeof(*sem), GFP_KERNEL);
+		if (!sem)
+			goto out;
+	}
+
+	do {
+		res = idr_pre_get(&brsem_idr, GFP_KERNEL);
+		if (res < 0)
+			goto out_free;
+		spin_lock(&brsem_alloc_lock);
+		res = idr_get_new_above(&brsem_idr, sem, 1, &idx);
+		spin_unlock(&brsem_alloc_lock);
+	} while (res == -EAGAIN);
+
+	if (res < 0)
+		goto out_free;
+
+	while (idx >= brsem_len) {
+		res = expand_brsem(idx);
+		if (res < 0)
+			goto out_idr_remove;
+	}
+
+	sem->idx = idx;
+	spin_lock_init(&sem->lock);
+	init_waitqueue_head(&sem->read_wait);
+	init_waitqueue_head(&sem->write_wait);
+	init_MUTEX(&sem->write_mutex);
+	INIT_WORK(&sem->async_work, do_async_jobs, sem);
+	sem->flags |= allocated_sem ? BRSEM_F_ALLOCATED : 0;
+
+	goto out;
+
+ out_idr_remove:
+	spin_lock(&brsem_alloc_lock);
+	idr_remove(&brsem_idr, idx);
+	spin_unlock(&brsem_alloc_lock);
+ out_free:
+	kfree(allocated_sem);
+	sem = NULL;
+ out:
+	return sem;
+}
+
+/*
+ * This is the heart and soul of brsem write operations.  sync_brsem()
+ * does two things atomically (w.r.t. each cpu) - collecting all
+ * cpu-local reader counts into sem->master_rcnt, and resetting or
+ * locking those rcnts.
+ *
+ * Locking per-cpu rcnts is done by setting them to INT_MIN.  All
+ * reader-side fast path functions fall back to slow path when they
+ * encounter INT_MIN, allowing inter-cpu synchronization and rwsem
+ * semantics to be implemented in slow path proper.
+ */
+struct sync_brsem_arg {
+	struct brsem *sem;
+	int write_locking;
+};
+
+static void sync_brsem_cpucb(void *data)
+{
+	struct sync_brsem_arg *sbarg = data;
+	struct brsem *sem = sbarg->sem;
+	int *p = __brsem_rcnt(sem);
+
+	__brsem_enter_crit();
+
+	/* collect rcnt */
+	if (*p != 0 && *p != INT_MIN) {
+		spin_lock(&sem->lock);
+		sem->master_rcnt += *p;
+		spin_unlock(&sem->lock);
+	}
+
+	/* lock or unlock rcnt */
+	*p = sbarg->write_locking ? INT_MIN : 0;
+
+	__brsem_leave_crit();
+}
+
+static void sync_brsem(struct brsem *sem, int write_locking)
+{
+	int cpu;
+
+	if (brsem_initialized) {
+		struct sync_brsem_arg sbarg = { sem, write_locking };
+		call_on_all_cpus(sync_brsem_cpucb, &sbarg);
+		return;
+	}
+
+	/*
+	 * Workqueue is not operational yet.  Fortunately, we're still
+	 * single threaded.  Sync manually.  Note that lockings are
+	 * not necessary here.  They're done just for consistency.
+	 */
+	lock_cpu_hotplug();
+	spin_lock_crit(&sem->lock);
+	for_each_online_cpu(cpu) {
+		int *p = per_cpu(brsem_rcnt_ar, cpu) + sem->idx;
+		if (*p != INT_MIN)
+			sem->master_rcnt += *p;
+		*p = write_locking ? INT_MIN : 0;
+	}
+	spin_unlock_crit(&sem->lock);
+	unlock_cpu_hotplug();
+}
+
+static void do_destroy_brsem(struct brsem *sem)
+{
+	check_idx(sem);
+
+	sync_brsem(sem, 0);
+	BUG_ON(sem->master_rcnt != 0);
+
+	spin_lock(&brsem_alloc_lock);
+
+	BUG_ON(idr_find(&brsem_idr, sem->idx) != sem);
+	idr_remove(&brsem_idr, sem->idx);
+
+	spin_unlock(&brsem_alloc_lock);
+
+	sem->idx = 0;
+
+	if (sem->flags & BRSEM_F_ALLOCATED)
+		kfree(sem);
+}
+
+static void do_async_jobs(void *data)
+{
+	struct brsem *sem = data;
+	unsigned flags;
+
+	spin_lock_crit(&sem->lock);
+	flags = sem->flags & BRSEM_F_ASYNC_MASK;
+	sem->flags ^= flags;
+	spin_unlock_crit(&sem->lock);
+
+	if (flags & BRSEM_F_ASYNC_UPWRITE)
+		brsem_up_write(sem);
+
+	if (flags & BRSEM_F_ASYNC_DESTROY)
+		do_destroy_brsem(sem);
+}
+
+static void queue_async(struct brsem *sem, unsigned todo)
+{
+	spin_lock_crit(&sem->lock);
+
+	BUG_ON(todo & ~BRSEM_F_ASYNC_MASK || sem->flags & todo);
+	sem->flags |= todo;
+
+	queue_work(brsem_async_wq, &sem->async_work);
+
+	/* sem->lock must be released after the last reference */
+	spin_unlock_crit(&sem->lock);
+}
+
+/**
+ * destroy_brsem - destroy and free the specified brsem
+ *
+ * This function doesn't sleep and can be called from anywhere except
+ * for irq handlers.  See comment at the top of this file for more
+ * information regarding async operations.
+ */
+void destroy_brsem(struct brsem *sem)
+{
+	queue_async(sem, BRSEM_F_ASYNC_DESTROY);
+}
+
+int __brsem_down_read_slow(struct brsem *sem, int interruptible)
+{
+	int *p;
+	DEFINE_WAIT(wait);
+
+	if (is_bypass(sem))
+		goto out;
+	check_idx(sem);
+ retry:
+	p = __brsem_rcnt(sem);
+	switch (*p) {
+	case INT_MIN:
+		/* writer(s) present */
+		prepare_to_wait(&sem->read_wait, &wait,
+				interruptible ? TASK_INTERRUPTIBLE
+					      : TASK_UNINTERRUPTIBLE);
+		__brsem_leave_crit();
+
+		schedule();
+		finish_wait(&sem->read_wait, &wait);
+
+		if (interruptible && signal_pending(current))
+			return -EINTR;
+
+		__brsem_enter_crit();
+		goto retry;
+
+	case INT_MAX:
+		/* local rcnt overflow, dump into master rcnt */
+		spin_lock(&sem->lock);
+		sem->master_rcnt += *p;
+		*p = 1;
+		spin_unlock(&sem->lock);
+		break;
+
+	default:
+		(*p)++;
+	}
+ out:
+	__brsem_leave_crit();
+	return 0;
+}
+
+int __brsem_down_read_trylock_slow(struct brsem *sem)
+{
+	int *p = __brsem_rcnt(sem);
+	int res = 1;
+
+	if (is_bypass(sem))
+		goto out;
+	check_idx(sem);
+
+	if (*p == INT_MIN) {
+		/* writer(s) present */
+		res = 0;
+	} else {
+		/* local rcnt overflow, dump into master rcnt */
+		spin_lock(&sem->lock);
+		sem->master_rcnt += *p;
+		*p = 1;
+		spin_unlock(&sem->lock);
+	}
+ out:
+	__brsem_leave_crit();
+	return res;
+}
+
+void __brsem_up_read_slow(struct brsem *sem)
+{
+	int *p = __brsem_rcnt(sem);
+
+	if (is_bypass(sem))
+		goto out;
+	check_idx(sem);
+
+	spin_lock(&sem->lock);
+
+	if (*p == INT_MIN) {
+		/* writer(s) present.  */
+		if (--sem->master_rcnt == 0)
+			wake_up(&sem->write_wait);
+	} else {
+		/* local rcnt underflow, dump into master rcnt */
+		sem->master_rcnt += *p;
+		*p = -1;
+	}
+
+	spin_unlock(&sem->lock);
+ out:
+	__brsem_leave_crit();
+}
+
+static int __brsem_down_write(struct brsem *sem, int interruptible)
+{
+	int res;
+
+	if (is_bypass(sem))
+		return 0;
+	check_idx(sem);
+
+	if (interruptible) {
+		res = down_interruptible(&sem->write_mutex);
+		if (res < 0)
+			return res;
+	} else
+		down(&sem->write_mutex);
+
+	sync_brsem(sem, 1);
+
+	spin_lock_crit(&sem->lock);
+
+	if (sem->master_rcnt) {
+		/* there are still readers left, wait for them */
+		DEFINE_WAIT(wait);
+
+		BUG_ON(sem->master_rcnt < 0);
+
+		prepare_to_wait(&sem->write_wait, &wait,
+				interruptible ? TASK_INTERRUPTIBLE
+					      : TASK_UNINTERRUPTIBLE);
+		spin_unlock_crit(&sem->lock);
+		schedule();
+		finish_wait(&sem->write_wait, &wait);
+
+		if (interruptible && signal_pending(current)) {
+			sync_brsem(sem, 0);
+			wake_up_all(&sem->read_wait);
+			up(&sem->write_mutex);
+			return -EINTR;
+		}
+		/* we got the lock */
+	} else
+		spin_unlock_crit(&sem->lock);
+
+	return 0;
+}
+
+/**
+ * brsem_down_write - write lock the specified brsem
+ *
+ * This function may sleep.
+ */
+void brsem_down_write(struct brsem *sem)
+{
+	int res = __brsem_down_write(sem, 0);
+	BUG_ON(res != 0);
+}
+
+/**
+ * brsem_down_write_interruptible - write lock the specified brsem
+ * (interruptible).  Returns 0 on success and -EINTR if interrupted.
+ *
+ * This function is identical to brsem_down_write except that it may
+ * be interrupted by signal.  This function may sleep.
+ */
+int brsem_down_write_interruptible(struct brsem *sem)
+{
+	return __brsem_down_write(sem, 1);
+}
+
+/**
+ * brsem_up_write - write unlock the specified brsem
+ *
+ * This function may sleep.
+ */
+void brsem_up_write(struct brsem *sem)
+{
+	if (is_bypass(sem))
+		return;
+	check_idx(sem);
+
+	BUG_ON(sem->master_rcnt);
+	sync_brsem(sem, 0);
+	wake_up_all(&sem->read_wait);
+	up(&sem->write_mutex);
+}
+
+/**
+ * brsem_up_write_async - write unlock the specified brsem asynchronously
+ *
+ * This function schedules write unlock of the specified brsem.  It
+ * can be called from anywhere except irq handlers.  See comment at
+ * the top of this file for more information regarding async
+ * operations.
+ */
+void brsem_up_write_async(struct brsem *sem)
+{
+	queue_async(sem, BRSEM_F_ASYNC_UPWRITE);
+}
+
+static int __cpuinit brsem_cpu_callback(struct notifier_block *nfb,
+					unsigned long action, void *data)
+{
+	int cpu = (unsigned long)data, online_cpu;
+	int *rcnt_ar, *new_rcnt_ar, len, i;
+	struct brsem *sem;
+
+	switch (action) {
+	case CPU_UP_PREPARE:
+		/*
+		 * Using any online cpu's rcnt_arlen as reference is
+		 * safe because it is protected with cpu hotplug lock.
+		 */
+		online_cpu = any_online_cpu(CPU_MASK_ALL);
+		rcnt_ar = per_cpu(brsem_rcnt_ar, online_cpu);
+		len = per_cpu(brsem_rcnt_arlen, online_cpu);
+
+		new_rcnt_ar = alloc_rcnt_ar(sizeof(new_rcnt_ar[0]) * len);
+		if (!new_rcnt_ar)
+			return NOTIFY_BAD;
+
+		/*
+		 * Transition between INT_MIN and any other value is
+		 * protected by cpu hotplug lock.
+		 */
+		for (i = 0; i < len; i++)
+			new_rcnt_ar[i] = rcnt_ar[i] == INT_MIN ? INT_MIN : 0;
+
+		BUG_ON(per_cpu(brsem_rcnt_ar, cpu) ||
+		       per_cpu(brsem_rcnt_arlen, cpu));
+
+		per_cpu(brsem_rcnt_ar, cpu) = new_rcnt_ar;
+		per_cpu(brsem_rcnt_arlen, cpu) = len;
+		break;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_UP_CANCELED:
+	case CPU_DEAD:
+		rcnt_ar = per_cpu(brsem_rcnt_ar, cpu);
+		len = per_cpu(brsem_rcnt_arlen, cpu);
+		if (rcnt_ar == NULL)
+			break;
+
+		per_cpu(brsem_rcnt_ar, cpu) = NULL;
+		per_cpu(brsem_rcnt_arlen, cpu) = 0;
+
+		for (i = 0; i < len; i++) {
+			if (rcnt_ar[i] == 0 || rcnt_ar[i] == INT_MIN)
+				continue;
+
+			spin_lock(&brsem_alloc_lock);
+			sem = idr_find(&brsem_idr, i);
+			spin_unlock(&brsem_alloc_lock);
+
+			BUG_ON(!sem || sem->idx != i);
+
+			/*
+			 * All inter-cpu synchronizations occur while
+			 * rcnt_ar is INT_MIN, so the following
+			 * doesn't interfere with any.
+			 */
+			spin_lock_crit(&sem->lock);
+			sem->master_rcnt += rcnt_ar[i];
+			spin_unlock_crit(&sem->lock);
+		}
+
+		free_rcnt_ar(rcnt_ar, sizeof(rcnt_ar[0]) * len);
+		break;
+#endif
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block brsem_cpu_notifier =
+	{ brsem_cpu_callback, NULL, 0 };
+
+/*
+ * brsem is initialized in three stages to make it useable as early as
+ * possible in the booting process.
+ *
+ * 1. per_cpu area setup
+ *
+ *  This happens _very_ early in the booting process.  Once this is
+ *  done, all statically allocated brsems initialized with
+ *  BRSEM_BYPASS_INITIALIZER can be passed to brsem functions.  At
+ *  this stage, these brsems don't do anything.  All operations on
+ *  them succeed unconditionally.
+ *
+ *  As only one thread runs on only one cpu in this stage, bypassing
+ *  locking mechanism doesn't cause any problem.
+ *
+ *  brsems cannot be initialized with __create_brsem() or created with
+ *  create_brsem() in this stage.
+ *
+ * 2. brsem_init_early
+ *
+ *  This is done as soon as slab allocator is online.  CPU notifier is
+ *  installed and brsem_idr is initialized.  Workqueue is not working
+ *  yet but the kernel runs only one thread until this stage making
+ *  access to rcnt_ar's of other cpus safe.
+ *
+ *  In this stage, brsem properly operates (not of much use as we're
+ *  still single threaded) and brsems can be initialized or allocated.
+ *
+ * 3. brsem_init
+ *
+ *  After workqueue is ready, brsem_init() is called and brsem becomes
+ *  fully operational.
+ *
+ * Unless brsems are needed before before stage 2, users of brsem
+ * don't have to worry about initialization.  Simply calling
+ * create_brsem() works.
+ *
+ * However, if a brsem is needed before stage 2, it needs to be
+ * allocated manually (either statically or with alloc_bootmem) and
+ * initialized with BRSEM_BYPASS_INITIALIZER before the first use.
+ * The brsem must be initialized with __create_brsem() once stage 2 is
+ * reached.  The initialization can be done at anytime after stage 2
+ * but doing it while things are still single-threaded is strongly
+ * recommended.
+ *
+ * *CAUTION* When initializing a brsem with __create_brsem(), the
+ * brsem MUST NOT have any writer or reader.  brsem doesn't keep track
+ * of its holders while bypassing and initializing it while holders
+ * are present will screw brsem when they release the brsem.
+ */
+void __init brsem_init_early(void)
+{
+	int cpu;
+
+	/*
+	 * per-cpu initializer linked initial rcnt_ar to all cpus.
+	 * Bang all except cpu0.
+	 */
+	for (cpu = 1; cpu < NR_CPUS; cpu++) {
+		per_cpu(brsem_rcnt_ar, cpu) = NULL;
+		per_cpu(brsem_rcnt_arlen, cpu) = 0;
+	}
+
+	register_cpu_notifier(&brsem_cpu_notifier);
+	idr_init(&brsem_idr);
+}
+
+static void __init dummy_cpucb(void *data)
+{
+	/* nothing */
+}
+
+void __init brsem_init(void)
+{
+	int *rcnt_ar, *new_rcnt_ar;
+	size_t size;
+
+	/* Replace cpu0's __initdata rcnt_ar with kmalloc'ed one */
+	rcnt_ar = per_cpu(brsem_rcnt_ar, 0);
+
+	size = sizeof(new_rcnt_ar[0]) * BRSEM_INITIAL_RCNT_ARLEN;
+	new_rcnt_ar = kmalloc(size, GFP_KERNEL);
+	BUG_ON(!new_rcnt_ar);
+
+	memcpy(new_rcnt_ar, rcnt_ar, size);
+	per_cpu(brsem_rcnt_ar, 0) = new_rcnt_ar;
+
+	/* Create async workqueue */
+	brsem_async_wq = create_singlethread_workqueue("brsem");
+	BUG_ON(!brsem_async_wq);
+
+	/* CPU's are all online now and workqueue is working */
+	brsem_initialized = 1;
+
+	/* Make sure other cpus see above change */
+	call_on_all_cpus(dummy_cpucb, NULL);
+}
+
+EXPORT_SYMBOL(__create_brsem);
+EXPORT_SYMBOL(destroy_brsem);
+EXPORT_SYMBOL(__brsem_down_read_slow);
+EXPORT_SYMBOL(__brsem_down_read_trylock_slow);
+EXPORT_SYMBOL(__brsem_up_read_slow);
+EXPORT_SYMBOL(brsem_down_write);
+EXPORT_SYMBOL(brsem_down_write_interruptible);
+EXPORT_SYMBOL(brsem_up_write);
Index: linux-work/init/main.c
===================================================================
--- linux-work.orig/init/main.c	2005-09-25 15:26:33.000000000 +0900
+++ linux-work/init/main.c	2005-09-25 15:42:03.000000000 +0900
@@ -35,6 +35,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/security.h>
 #include <linux/workqueue.h>
+#include <linux/brsem.h>
 #include <linux/profile.h>
 #include <linux/rcupdate.h>
 #include <linux/moduleparam.h>
@@ -511,6 +512,7 @@ asmlinkage void __init start_kernel(void
 	kmem_cache_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
+	brsem_init_early();
 	if (late_time_init)
 		late_time_init();
 	calibrate_delay();
@@ -605,6 +607,7 @@ static void __init do_basic_setup(void)
 {
 	/* drivers will send hotplug events */
 	init_workqueues();
+	brsem_init();
 	usermodehelper_init();
 	driver_init();
 

