Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbVJ1Kor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbVJ1Kor (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 06:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVJ1Kor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 06:44:47 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:62595 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965057AbVJ1Kop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 06:44:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=EVpRCcZqXIJMC2AKVwOlok7kpnx5QLs0qGRBG5K2Jhd2jg9ixaN5Pjv44eaCXTJKJCtuHVsTBY2wAE2orhIqz6zMgyOTtNg5ACwUnW4h9brF7P92UH20UF5iT96oQtAUXKZLz+vDfjEz6m/nO86u4xHPCqwxc86pw6h3jqd/kmM=
Date: Fri, 28 Oct 2005 19:44:37 +0900
From: Tejun Heo <htejun@gmail.com>
To: nickpiggin@yahoo.com.au, ntl@pobox.com, viro@ftp.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH RFC] big reader semaphore take#2
Message-ID: <20051028104437.GA17461@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello guys,

This is the second take of brsem (big reader semaphore).

Nick, unfortunately, simple array of rwsem's does not work as lock
holders are not pinned down to cpus and may release locks on other
cpus.

This is a compeletely new implementation and much simpler than the
first one.  Each brsem is consisted of shared part and two per-cpu
counters.  Read fast path involves only one atomic_add_return and
following conditional jump just as in rwsem.

The patch is against 2.6.14-rc4 and only implements brsem.  It does
not apply it to anywhere.  My simple concurrent dd benchmark shows
clear improvement over regular rwsem but it seems that there are too
many factors affecting the bench.  I'll soon create another micro
bench which concentrates only on synchronization and post the result.

I've written a document to describe how brsem works.  The document
seems a bit too long for direct posting.  It can be accessed at the
following page.

 http://home-tj.org/wiki/index.php/Brsem

Any comments are welcomed.

Thanks.

--- a/include/asm-i386/atomic.h
+++ b/include/asm-i386/atomic.h
@@ -178,6 +178,11 @@ static __inline__ int atomic_add_negativ
 	return c;
 }
 
+static __inline__ int atomic_xchg(atomic_t *v, int i)
+{
+	return xchg(&v->counter, i);
+}
+
 /**
  * atomic_add_return - add and return
  * @v: pointer of type atomic_t
--- a/include/asm-x86_64/atomic.h
+++ b/include/asm-x86_64/atomic.h
@@ -2,6 +2,7 @@
 #define __ARCH_X86_64_ATOMIC__
 
 #include <linux/config.h>
+#include <asm/system.h>		/* xchg */
 
 /* atomic_t should be 32 bit signed type */
 
@@ -178,6 +179,11 @@ static __inline__ int atomic_add_negativ
 	return c;
 }
 
+static __inline__ int atomic_xchg(atomic_t *v, int i)
+{
+	return xchg(&v->counter, i);
+}
+
 /* An 64bit atomic type */
 
 typedef struct { volatile long counter; } atomic64_t;
--- /dev/null
+++ b/include/linux/brsem-generic.h
@@ -0,0 +1,56 @@
+#ifndef _LINUX_BRSEM_GENERIC_H
+#define _LINUX_BRSEM_GENERIC_H
+
+#include <asm/atomic.h>
+
+/*
+ * Assume that atomic_t's internal cnt is int.  Maybe define
+ * atomic_cnt_t and min, max values?
+ */
+typedef int brsem_cnt_t;
+typedef unsigned int brsem_unsigned_cnt_t;
+#define BRSEM_CNT_SIZE			sizeof(atomic_t)
+#define BRSEM_CNT_MIN			INT_MIN
+
+#define brsem_dec_cnt(ptr)		atomic_dec(ptr)
+#define brsem_xchg_cnt(ptr, val)	atomic_xchg(ptr, val)
+
+void brsem_down_read_failed(struct brsem *sem, void *cnt, brsem_cnt_t last);
+int brsem_down_read_trylock_failed(struct brsem *sem, void *cnt,
+				   brsem_cnt_t last);
+void brsem_up_read_failed(struct brsem *sem, void *cnt, brsem_cnt_t last);
+
+static inline void __brsem_down_read(struct brsem *sem)
+{
+	void *p;
+	brsem_cnt_t v;
+	p = brsem_local_down_cnt(sem);
+	v = atomic_add_return(1, p);
+	if (v >= 0)
+		return;
+	brsem_down_read_failed(sem, p, v);
+}
+
+static inline int __brsem_down_read_trylock(struct brsem *sem)
+{
+	void *p;
+	brsem_cnt_t v;
+	p = brsem_local_down_cnt(sem);
+	v = atomic_add_return(1, p);
+	if (v >= 0)
+		return 1;
+	return brsem_down_read_trylock_failed(sem, p, v);
+}
+
+static inline void __brsem_up_read(struct brsem *sem)
+{
+	void *p;
+	brsem_cnt_t v;
+	p = brsem_local_up_cnt(sem);
+	v = atomic_add_return(1, p);
+	if (v >= 0)
+		return;
+	brsem_up_read_failed(sem, p, v);
+}
+
+#endif /* _LINUX_BRSEM_GENERIC_H */
--- /dev/null
+++ b/include/linux/brsem.h
@@ -0,0 +1,62 @@
+#ifndef _LINUX_BRSEM_H
+#define _LINUX_BRSEM_H
+
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/percpu.h>
+
+enum brsem_writer_state {
+	BRSEM_WSTAT_NONE = 0,
+	BRSEM_WSTAT_PENDING,
+	BRSEM_WSTAT_LOCKED,
+	BRSEM_WSTAT_DRAINING,
+};
+
+struct brsem {
+	void *cpu_cnts;
+	spinlock_t master_lock;
+	long long master_cnt;
+	int drain_cnt;
+	enum brsem_writer_state writer_state;
+	wait_queue_head_t read_wait, write_wait;
+};
+
+#define brsem_cpu_down_cnt(sem, cpu) \
+	per_cpu_ptr((sem)->cpu_cnts, (cpu))
+#define brsem_cpu_up_cnt(sem, cpu) \
+	(per_cpu_ptr((sem)->cpu_cnts, (cpu)) + BRSEM_CNT_SIZE)
+#define brsem_local_down_cnt(sem) \
+	brsem_cpu_down_cnt(sem, raw_smp_processor_id())
+#define brsem_local_up_cnt(sem) \
+	brsem_cpu_up_cnt(sem, raw_smp_processor_id())
+
+#if 1	/* CONFIG_BRSEM_GENERIC */
+#include <linux/brsem-generic.h>
+#else
+#include <asm/brsem.h>
+#endif
+
+struct brsem *create_brsem(void);
+void destroy_brsem(struct brsem *sem);
+
+static inline void brsem_down_read(struct brsem *sem)
+{
+	might_sleep();
+	__brsem_down_read(sem);
+}
+
+static inline int brsem_down_read_trylock(struct brsem *sem)
+{
+	return __brsem_down_read_trylock(sem);
+}
+
+static inline void brsem_up_read(struct brsem *sem)
+{
+	__brsem_up_read(sem);
+}
+
+void brsem_down_write(struct brsem *sem);
+int brsem_down_write_trylock(struct brsem *sem);
+void brsem_up_write(struct brsem *sem);
+
+#endif /* _LINUX_BRSEM_H */
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -7,7 +7,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
-	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
+	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o brsem.o
 
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
--- /dev/null
+++ b/kernel/brsem.c
@@ -0,0 +1,318 @@
+#include <linux/brsem.h>
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/cpu.h>
+#include <linux/module.h>
+
+#define BRSEM_READER_BIAS	0
+#define BRSEM_WRITER_BIAS	(BRSEM_CNT_MIN / 2)
+
+struct brsem *create_brsem(void)
+{
+	struct brsem *sem;
+	int cpu;
+
+	BUG_ON(sizeof(brsem_cnt_t) >= sizeof(long long));
+
+	sem = kzalloc(sizeof(struct brsem), GFP_KERNEL);
+	if (!sem)
+		return NULL;
+
+	sem->cpu_cnts = __alloc_percpu(BRSEM_CNT_SIZE * 2, BRSEM_CNT_SIZE);
+	if (!sem->cpu_cnts) {
+		kfree(sem);
+		return NULL;
+	}
+
+	for_each_cpu(cpu) {
+		brsem_xchg_cnt(brsem_cpu_down_cnt(sem, cpu), BRSEM_READER_BIAS);
+		brsem_xchg_cnt(brsem_cpu_up_cnt(sem, cpu), BRSEM_READER_BIAS);
+	}
+
+	sem->master_lock = SPIN_LOCK_UNLOCKED;
+	init_waitqueue_head(&sem->read_wait);
+	init_waitqueue_head(&sem->write_wait);
+
+	return sem;
+}
+
+void destroy_brsem(struct brsem *sem)
+{
+	free_percpu(sem->cpu_cnts);
+	kfree(sem);
+}
+
+static inline int in_writer_range(brsem_cnt_t v)
+{
+	return v < 0 && v >= BRSEM_WRITER_BIAS;
+}
+
+static inline void bias_cnt(struct brsem *sem, void *cpu_dcnt, brsem_cnt_t bias,
+			    brsem_cnt_t *dcnt, brsem_cnt_t *ucnt)
+{
+	*dcnt = brsem_xchg_cnt(cpu_dcnt, bias);
+	*ucnt = brsem_xchg_cnt(cpu_dcnt + BRSEM_CNT_SIZE, bias);
+}
+
+static inline long long calc_delta(brsem_cnt_t v, brsem_cnt_t bias)
+{
+	return (brsem_unsigned_cnt_t)(v - bias);
+}
+
+static void bias_all_cnts(struct brsem *sem,
+			  brsem_cnt_t old_bias, brsem_cnt_t new_bias,
+			  long long *dcnt, long long *ucnt)
+{
+	int cpu;
+	brsem_cnt_t dc, uc;
+
+	*dcnt = 0;
+	*ucnt = 0;
+	for_each_cpu(cpu) {
+		bias_cnt(sem, brsem_cpu_down_cnt(sem, cpu), new_bias, &dc, &uc);
+		*dcnt += calc_delta(dc, old_bias);
+		*ucnt += calc_delta(uc, old_bias);
+		BUG_ON(*dcnt < 0 || *ucnt < 0);
+	}
+}
+
+static inline void collect_cpu_cnt(struct brsem *sem, void *cpu_dcnt)
+{
+	brsem_cnt_t dcnt, ucnt;
+	bias_cnt(sem, cpu_dcnt, BRSEM_READER_BIAS, &dcnt, &ucnt);
+	sem->master_cnt += calc_delta(dcnt, BRSEM_READER_BIAS);
+	sem->master_cnt -= calc_delta(ucnt, BRSEM_READER_BIAS);
+}
+
+static void drain_one_reader(struct brsem *sem)
+{
+	BUG_ON(sem->drain_cnt <= 0);
+
+	if (--sem->drain_cnt)
+		return;
+
+	if (waitqueue_active(&sem->write_wait)) {
+		long long dcnt, ucnt;
+		bias_all_cnts(sem, BRSEM_READER_BIAS, BRSEM_WRITER_BIAS,
+			      &dcnt, &ucnt);
+		sem->master_cnt += dcnt - ucnt;
+		BUG_ON(sem->master_cnt <= 0);
+		sem->writer_state = BRSEM_WSTAT_PENDING;
+	} else
+		sem->writer_state = BRSEM_WSTAT_NONE;
+}
+
+void brsem_down_read_failed(struct brsem *sem, void *cpu_dcnt, brsem_cnt_t last)
+{
+	DEFINE_WAIT(wait);
+
+	spin_lock_irq(&sem->master_lock);
+
+	switch (sem->writer_state) {
+	case BRSEM_WSTAT_PENDING:
+	case BRSEM_WSTAT_LOCKED:
+		/*
+		 * Write locking in progress or locked
+		 */
+		if (!in_writer_range(last)) {
+			/* this happened before writer's xchg, grant */
+			break;
+		}
+		sem->drain_cnt++;
+		prepare_to_wait(&sem->read_wait, &wait, TASK_UNINTERRUPTIBLE);
+		spin_unlock_irq(&sem->master_lock);
+		schedule();
+		finish_wait(&sem->read_wait, &wait);
+		return;
+
+	case BRSEM_WSTAT_DRAINING:
+		if (in_writer_range(last)) {
+			drain_one_reader(sem);
+			break;
+		}
+		/* fall through */
+	case BRSEM_WSTAT_NONE:
+		BUG_ON(in_writer_range(last));
+		collect_cpu_cnt(sem, cpu_dcnt);
+		break;
+	}
+
+	spin_unlock_irq(&sem->master_lock);
+}
+
+int brsem_down_read_trylock_failed(struct brsem *sem, void *cpu_dcnt,
+				   brsem_cnt_t last)
+{
+	unsigned long flags;
+	int res = 1;
+
+	spin_lock_irqsave(&sem->master_lock, flags);
+
+	switch (sem->writer_state) {
+	case BRSEM_WSTAT_PENDING:
+	case BRSEM_WSTAT_LOCKED:
+		if (in_writer_range(last)) {
+			brsem_dec_cnt(cpu_dcnt);
+			res = 0;
+		}
+		break;
+
+	case BRSEM_WSTAT_DRAINING:
+		if (in_writer_range(last)) {
+			drain_one_reader(sem);
+			break;
+		}
+		/* fall through */
+	case BRSEM_WSTAT_NONE:
+		BUG_ON(in_writer_range(last));
+		collect_cpu_cnt(sem, cpu_dcnt);
+		break;
+	}
+
+	spin_unlock_irqrestore(&sem->master_lock, flags);
+	return res;
+}
+
+void brsem_up_read_failed(struct brsem *sem, void *cpu_ucnt, brsem_cnt_t last)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sem->master_lock, flags);
+
+	switch (sem->writer_state) {
+	case BRSEM_WSTAT_PENDING:
+		if (in_writer_range(last)) {
+			sem->master_cnt--;
+			BUG_ON(sem->master_cnt < 0);
+			if (sem->master_cnt == 0) {
+				sem->writer_state = BRSEM_WSTAT_LOCKED;
+				wake_up(&sem->write_wait);
+			}
+		}
+		break;
+
+	case BRSEM_WSTAT_LOCKED:
+		BUG();
+		break;
+
+	case BRSEM_WSTAT_DRAINING:
+		if (in_writer_range(last)) {
+			drain_one_reader(sem);
+			break;
+		}
+		/* fall through */
+	case BRSEM_WSTAT_NONE:
+		BUG_ON(in_writer_range(last));
+		collect_cpu_cnt(sem, cpu_ucnt - BRSEM_CNT_SIZE);
+		break;
+	}
+
+	spin_unlock_irqrestore(&sem->master_lock, flags);
+}
+
+void brsem_down_write(struct brsem *sem)
+{
+	long long dcnt, ucnt;
+
+	DEFINE_WAIT(wait);
+
+	might_sleep();
+
+	spin_lock_irq(&sem->master_lock);
+
+	switch (sem->writer_state) {
+	case BRSEM_WSTAT_DRAINING:
+	case BRSEM_WSTAT_PENDING:
+	case BRSEM_WSTAT_LOCKED:
+		prepare_to_wait_exclusive(&sem->write_wait, &wait,
+					  TASK_UNINTERRUPTIBLE);
+		spin_unlock_irq(&sem->master_lock);
+		schedule();
+		finish_wait(&sem->write_wait, &wait);
+		break;
+
+	case BRSEM_WSTAT_NONE:
+		bias_all_cnts(sem, BRSEM_READER_BIAS, BRSEM_WRITER_BIAS,
+			      &dcnt, &ucnt);
+		sem->master_cnt += dcnt - ucnt;
+		BUG_ON(sem->master_cnt < 0);
+
+		if (sem->master_cnt) {
+			sem->writer_state = BRSEM_WSTAT_PENDING;
+			prepare_to_wait_exclusive(&sem->write_wait, &wait,
+						  TASK_UNINTERRUPTIBLE);
+			spin_unlock_irq(&sem->master_lock);
+			schedule();
+			finish_wait(&sem->write_wait, &wait);
+		} else {
+			sem->writer_state = BRSEM_WSTAT_LOCKED;
+			spin_unlock_irq(&sem->master_lock);
+		}
+		break;
+	}
+}
+
+int brsem_down_write_trylock(struct brsem *sem)
+{
+	long long dcnt, ucnt;
+	long flags;
+	int res = 0;
+
+	spin_lock_irqsave(&sem->master_lock, flags);
+
+	if (sem->writer_state != BRSEM_WSTAT_NONE)
+		goto out;
+
+	bias_all_cnts(sem, BRSEM_READER_BIAS, BRSEM_WRITER_BIAS, &dcnt, &ucnt);
+	sem->master_cnt += dcnt - ucnt;
+	BUG_ON(sem->master_cnt < 0);
+
+	if (sem->master_cnt) {
+		bias_all_cnts(sem, BRSEM_WRITER_BIAS, BRSEM_READER_BIAS,
+			      &dcnt, &ucnt);
+		sem->master_cnt += dcnt - ucnt;
+		sem->drain_cnt = dcnt + ucnt;
+		if (sem->drain_cnt)
+			sem->writer_state = BRSEM_WSTAT_DRAINING;
+	} else {
+		sem->writer_state = BRSEM_WSTAT_LOCKED;
+		res = 1;
+	}
+ out:
+	spin_unlock_irqrestore(&sem->master_lock, flags);
+	return res;
+}
+
+void brsem_up_write(struct brsem *sem)
+{
+	long flags;
+
+	spin_lock_irqsave(&sem->master_lock, flags);
+
+	BUG_ON(sem->writer_state != BRSEM_WSTAT_LOCKED || sem->master_cnt);
+
+	if (waitqueue_active(&sem->write_wait)) {
+		wake_up(&sem->write_wait);
+	} else {
+		long long dcnt, ucnt;
+		sem->writer_state = BRSEM_WSTAT_NONE;
+		bias_all_cnts(sem, BRSEM_WRITER_BIAS, BRSEM_READER_BIAS,
+			      &dcnt, &ucnt);
+		sem->master_cnt = dcnt;
+		sem->drain_cnt = dcnt - sem->drain_cnt;
+		if (sem->drain_cnt == 0)
+			sem->writer_state = BRSEM_WSTAT_NONE;
+		else
+			sem->writer_state = BRSEM_WSTAT_DRAINING;
+		wake_up_all(&sem->read_wait);
+	}
+
+	spin_unlock_irqrestore(&sem->master_lock, flags);
+}
+
+EXPORT_SYMBOL(brsem_down_read_failed);
+EXPORT_SYMBOL(brsem_down_read_trylock_failed);
+EXPORT_SYMBOL(brsem_down_write);
+EXPORT_SYMBOL(brsem_down_write_trylock);
+EXPORT_SYMBOL(brsem_up_write);
