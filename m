Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTKHOHh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 09:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTKHOHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 09:07:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19592 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261763AbTKHOGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 09:06:48 -0500
Date: Sat, 8 Nov 2003 15:06:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cfq + io priorities
Message-ID: <20031108140648.GV14728@suse.de>
References: <20031108124758.GQ14728@suse.de> <20031108132539.GU14728@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031108132539.GU14728@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

And also a new cfq, of course a few embarassing bugs were introduced
right before diffing...

I also forgot to include a small intro to the tunables that cfq-prio
has, so I'll do that here too. You can find these in
/sys/block/<disk>/queue/iosched.

quantum
	A batch quantum, an io class is only allowed to submit as much
	as this number of io requests per turn. Default is 4.

idle_quantum
	Like quantum, but for idle io. Default is 1.

queued
	A process is able to submit at least this number of io requests,
	regardless. Default is 4.

grace_rt
	The realtime grace period, in jiffies (I'll add user -> kernel
	conversions later, for now you need to know the clock rate of
	your arch. Disk is kept idle this long after realtime io
	completes, to allow more realtime io. Default is 10 ms.

grace_idle
	Disk must have been idle for this long before idle io is allowed
	to be sent to disk. Default is 100ms.

Additionally, should any "normal" io be pending when realtime io is
submitted, it's pulled off the dispatch list and put back into the io
scheduler. Should any idle io be on the dispatch list when normal or rt
io is submitted, that too is pulled back into the scheduler.

===== arch/i386/kernel/entry.S 1.69 vs edited =====
--- 1.69/arch/i386/kernel/entry.S	Wed Oct  1 15:53:17 2003
+++ edited/arch/i386/kernel/entry.S	Sat Nov  8 11:53:19 2003
@@ -880,5 +880,7 @@
 	.long sys_utimes
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
+	.long sys_ioprio_set
+	.long sys_ioprio_get
 
 nr_syscalls=(.-sys_call_table)/4
===== arch/ppc/kernel/misc.S 1.49 vs edited =====
--- 1.49/arch/ppc/kernel/misc.S	Fri Sep 12 18:26:52 2003
+++ edited/arch/ppc/kernel/misc.S	Sat Nov  8 11:53:19 2003
@@ -1385,3 +1385,5 @@
 	.long sys_statfs64
 	.long sys_fstatfs64
 	.long ppc_fadvise64_64
+	.long sys_ioprio_set
+	.long sys_ioprio_get
===== drivers/block/Kconfig.iosched 1.2 vs edited =====
--- 1.2/drivers/block/Kconfig.iosched	Fri Aug 15 03:16:57 2003
+++ edited/drivers/block/Kconfig.iosched	Sat Nov  8 11:55:04 2003
@@ -27,3 +27,11 @@
 	  a disk at any one time, its behaviour is almost identical to the
 	  anticipatory I/O scheduler and so is a good choice.
 
+config IOSCHED_CFQ
+	bool "CFQ I/O scheduler" if EMBEDDED
+	default y
+	---help---
+	  The CFQ I/O scheduler tries to distribute bandwidth equally
+	  among all processes in the system, with the option of assigning
+	  io priorities a process or process group. It should provide a fair
+	  working environment, suitable for desktop systems.
===== drivers/block/Makefile 1.22 vs edited =====
--- 1.22/drivers/block/Makefile	Thu Oct 16 06:38:46 2003
+++ edited/drivers/block/Makefile	Sat Nov  8 11:53:19 2003
@@ -18,6 +18,7 @@
 obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
 obj-$(CONFIG_IOSCHED_AS)	+= as-iosched.o
 obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o
+obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
 obj-$(CONFIG_BLK_DEV_FD98)	+= floppy98.o
===== drivers/block/elevator.c 1.52 vs edited =====
--- 1.52/drivers/block/elevator.c	Fri Sep  5 12:13:05 2003
+++ edited/drivers/block/elevator.c	Sat Nov  8 11:53:19 2003
@@ -302,6 +302,14 @@
 		e->elevator_put_req_fn(q, rq);
 }
 
+void elv_set_congested(request_queue_t *q)
+{
+	elevator_t *e = &q->elevator;
+
+	if (e->elevator_set_congested_fn)
+		e->elevator_set_congested_fn(q);
+}
+
 int elv_may_queue(request_queue_t *q, int rw)
 {
 	elevator_t *e = &q->elevator;
@@ -309,7 +317,7 @@
 	if (e->elevator_may_queue_fn)
 		return e->elevator_may_queue_fn(q, rw);
 
-	return 0;
+	return 1;
 }
 
 void elv_completed_request(request_queue_t *q, struct request *rq)
===== drivers/block/ll_rw_blk.c 1.221 vs edited =====
--- 1.221/drivers/block/ll_rw_blk.c	Thu Nov  6 00:11:47 2003
+++ edited/drivers/block/ll_rw_blk.c	Sat Nov  8 14:49:51 2003
@@ -1331,7 +1331,9 @@
 static int __make_request(request_queue_t *, struct bio *);
 
 static elevator_t *chosen_elevator =
-#if defined(CONFIG_IOSCHED_AS)
+#if defined(CONFIG_IOSCHED_CFQ)
+	&iosched_cfq;
+#elif defined(CONFIG_IOSCHED_AS)
 	&iosched_as;
 #elif defined(CONFIG_IOSCHED_DEADLINE)
 	&iosched_deadline;
@@ -1353,6 +1355,10 @@
 	if (!strcmp(str, "as"))
 		chosen_elevator = &iosched_as;
 #endif
+#ifdef CONFIG_IOSCHED_CFQ
+	if (!strcmp(str, "cfq"))
+		chosen_elevator = &iosched_cfq;
+#endif
 #ifdef CONFIG_IOSCHED_NOOP
 	if (!strcmp(str, "noop"))
 		chosen_elevator = &elevator_noop;
@@ -1553,6 +1559,10 @@
 	struct io_context *ioc = get_io_context(gfp_mask);
 
 	spin_lock_irq(q->queue_lock);
+
+	if (!elv_may_queue(q, rw))
+		goto out_lock;
+
 	if (rl->count[rw]+1 >= q->nr_requests) {
 		/*
 		 * The queue will fill after this allocation, so set it as
@@ -1566,15 +1576,12 @@
 		}
 	}
 
-	if (blk_queue_full(q, rw)
-			&& !ioc_batching(ioc) && !elv_may_queue(q, rw)) {
-		/*
-		 * The queue is full and the allocating process is not a
-		 * "batcher", and not exempted by the IO scheduler
-		 */
-		spin_unlock_irq(q->queue_lock);
-		goto out;
-	}
+	/*
+	 * The queue is full and the allocating process is not a
+	 * "batcher", and not exempted by the IO scheduler
+	 */
+	if (blk_queue_full(q, rw) && !ioc_batching(ioc))
+		goto out_lock;
 
 	rl->count[rw]++;
 	if (rl->count[rw] >= queue_congestion_on_threshold(q))
@@ -1592,8 +1599,7 @@
 		 */
 		spin_lock_irq(q->queue_lock);
 		freed_request(q, rw);
-		spin_unlock_irq(q->queue_lock);
-		goto out;
+		goto out_lock;
 	}
 
 	if (ioc_batching(ioc))
@@ -1622,6 +1628,11 @@
 out:
 	put_io_context(ioc);
 	return rq;
+out_lock:
+	if (!rq)
+		elv_set_congested(q);
+	spin_unlock_irq(q->queue_lock);
+	goto out;
 }
 
 /*
@@ -2936,3 +2947,21 @@
 		kobject_put(&disk->kobj);
 	}
 }
+
+asmlinkage int sys_ioprio_set(int ioprio)
+{
+	if (ioprio < IOPRIO_IDLE || ioprio > IOPRIO_RT)
+		return -EINVAL;
+	if (ioprio == IOPRIO_RT && !capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	printk("%s: set ioprio %d\n", current->comm, ioprio);
+	current->ioprio = ioprio;
+	return 0;
+}
+
+asmlinkage int sys_ioprio_get(void)
+{
+	return current->ioprio;
+}
+
===== include/asm-i386/unistd.h 1.30 vs edited =====
--- 1.30/include/asm-i386/unistd.h	Thu Oct  2 09:12:21 2003
+++ edited/include/asm-i386/unistd.h	Sat Nov  8 11:53:20 2003
@@ -279,8 +279,10 @@
 #define __NR_utimes		271
 #define __NR_fadvise64_64	272
 #define __NR_vserver		273
+#define __NR_ioprio_set		274
+#define __NR_ioprio_get		275
 
-#define NR_syscalls 274
+#define NR_syscalls 276
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
===== include/asm-ppc/unistd.h 1.26 vs edited =====
--- 1.26/include/asm-ppc/unistd.h	Sat Aug 23 04:15:18 2003
+++ edited/include/asm-ppc/unistd.h	Sat Nov  8 11:53:20 2003
@@ -259,8 +259,10 @@
 #define __NR_statfs64		252
 #define __NR_fstatfs64		253
 #define __NR_fadvise64_64	254
+#define __NR_ioprio_set		255
+#define __NR_ioprio_get		256
 
-#define __NR_syscalls		255
+#define __NR_syscalls		257
 
 #define __NR(n)	#n
 
===== include/asm-x86_64/unistd.h 1.18 vs edited =====
--- 1.18/include/asm-x86_64/unistd.h	Sun Oct  5 18:35:37 2003
+++ edited/include/asm-x86_64/unistd.h	Sat Nov  8 11:53:20 2003
@@ -532,8 +532,12 @@
 __SYSCALL(__NR_utimes, sys_utimes)
 #define __NR_vserver		236
 __SYSCALL(__NR_vserver, sys_ni_syscall)
+#define __NR_ioprio_set		237
+__SYSCALL(__NR_ioprio_set, sys_ioprio_set);
+#define __NR_ioprio_get		238
+__SYSCALL(__NR_ioprio_get, sys_ioprio_get);
 
-#define __NR_syscall_max __NR_vserver
+#define __NR_syscall_max __ioprio_get
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */
===== include/linux/elevator.h 1.29 vs edited =====
--- 1.29/include/linux/elevator.h	Sun Sep 21 23:50:12 2003
+++ edited/include/linux/elevator.h	Sat Nov  8 11:53:20 2003
@@ -17,6 +17,7 @@
 typedef struct request *(elevator_request_list_fn) (request_queue_t *, struct request *);
 typedef void (elevator_completed_req_fn) (request_queue_t *, struct request *);
 typedef int (elevator_may_queue_fn) (request_queue_t *, int);
+typedef void (elevator_set_congested_fn) (request_queue_t *);
 
 typedef int (elevator_set_req_fn) (request_queue_t *, struct request *, int);
 typedef void (elevator_put_req_fn) (request_queue_t *, struct request *);
@@ -45,6 +46,7 @@
 	elevator_put_req_fn *elevator_put_req_fn;
 
 	elevator_may_queue_fn *elevator_may_queue_fn;
+	elevator_set_congested_fn *elevator_set_congested_fn;
 
 	elevator_init_fn *elevator_init_fn;
 	elevator_exit_fn *elevator_exit_fn;
@@ -74,6 +76,7 @@
 extern int elv_register_queue(request_queue_t *q);
 extern void elv_unregister_queue(request_queue_t *q);
 extern int elv_may_queue(request_queue_t *, int);
+extern void elv_set_congested(request_queue_t *);
 extern void elv_completed_request(request_queue_t *, struct request *);
 extern int elv_set_request(request_queue_t *, struct request *, int);
 extern void elv_put_request(request_queue_t *, struct request *);
@@ -93,6 +96,11 @@
  * anticipatory I/O scheduler
  */
 extern elevator_t iosched_as;
+
+/*
+ * completely fair queueing I/O scheduler
+ */
+extern elevator_t iosched_cfq;
 
 extern int elevator_init(request_queue_t *, elevator_t *);
 extern void elevator_exit(request_queue_t *);
===== include/linux/fs.h 1.274 vs edited =====
--- 1.274/include/linux/fs.h	Tue Sep 23 06:16:30 2003
+++ edited/include/linux/fs.h	Sat Nov  8 11:53:20 2003
@@ -1408,5 +1408,16 @@
 	return res;
 }
 
+/* io priorities */
+
+#define IOPRIO_NR      21
+
+#define IOPRIO_IDLE	0
+#define IOPRIO_NORM	10
+#define IOPRIO_RT	20
+
+asmlinkage int sys_ioprio_set(int ioprio);
+asmlinkage int sys_ioprio_get(void);
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_FS_H */
===== include/linux/init_task.h 1.27 vs edited =====
--- 1.27/include/linux/init_task.h	Tue Aug 19 04:46:23 2003
+++ edited/include/linux/init_task.h	Sat Nov  8 11:53:20 2003
@@ -108,6 +108,7 @@
 	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
+	.ioprio		= IOPRIO_NORM,					\
 }
 
 
===== include/linux/sched.h 1.174 vs edited =====
--- 1.174/include/linux/sched.h	Mon Oct 27 04:16:19 2003
+++ edited/include/linux/sched.h	Sat Nov  8 11:53:20 2003
@@ -462,6 +462,8 @@
 
 	struct io_context *io_context;
 
+	int ioprio;
+
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
 };
===== kernel/fork.c 1.145 vs edited =====
--- 1.145/kernel/fork.c	Fri Oct 10 00:13:54 2003
+++ edited/kernel/fork.c	Sat Nov  8 11:53:20 2003
@@ -1046,6 +1046,7 @@
 	} else
 		link_pid(p, p->pids + PIDTYPE_TGID, &p->group_leader->pids[PIDTYPE_TGID].pid);
 
+	p->ioprio = current->ioprio;
 	nr_threads++;
 	write_unlock_irq(&tasklist_lock);
 	retval = 0;
--- /dev/null	2003-09-24 00:19:32.000000000 +0200
+++ linux-2.6-cfq/drivers/block/cfq-iosched.c	2003-11-08 14:55:41.000000000 +0100
@@ -0,0 +1,1169 @@
+/*
+ *  linux/drivers/block/cfq-iosched.c
+ *
+ *  CFQ, or complete fairness queueing, disk scheduler.
+ *
+ *  Based on ideas from a previously unfinished io
+ *  scheduler (round robin per-process disk scheduling) and Andrea Arcangeli.
+ *
+ *  IO priorities are supported, from 0% to 100% in 5% increments. Both of
+ *  those values have special meaning - 0% class is allowed to do io if
+ *  noone else wants to use the disk. 100% is considered real-time io, and
+ *  always get priority. Default process io rate is 95%. In absence of other
+ *  io, a class may consume 100% disk bandwidth regardless. Withing a class,
+ *  bandwidth is distributed equally among the citizens.
+ *
+ * TODO:
+ *	- cfq_select_requests() needs some work for 5-95% io
+ *	- barriers not supported
+ *
+ *  Copyright (C) 2003 Jens Axboe <axboe@suse.de>
+ */
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/blkdev.h>
+#include <linux/elevator.h>
+#include <linux/bio.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/compiler.h>
+#include <linux/hash.h>
+#include <linux/rbtree.h>
+#include <linux/mempool.h>
+
+#if IOPRIO_NR > BITS_PER_LONG
+#error Cannot support this many io priority levels
+#endif
+
+/*
+ * tunables
+ */
+static int cfq_quantum = 4;
+static int cfq_idle_quantum = 1;
+static int cfq_queued = 4;
+static int cfq_grace_rt = HZ / 100 ?: 1;
+static int cfq_grace_idle = HZ / 10;
+
+#define CFQ_QHASH_SHIFT		6
+#define CFQ_QHASH_ENTRIES	(1 << CFQ_QHASH_SHIFT)
+#define list_entry_qhash(entry)	list_entry((entry), struct cfq_queue, cfq_hash)
+
+#define CFQ_MHASH_SHIFT		8
+#define CFQ_MHASH_BLOCK(sec)	((sec) >> 3)
+#define CFQ_MHASH_ENTRIES	(1 << CFQ_MHASH_SHIFT)
+#define CFQ_MHASH_FN(sec)	(hash_long(CFQ_MHASH_BLOCK((sec)),CFQ_MHASH_SHIFT))
+#define ON_MHASH(crq)		!list_empty(&(crq)->hash)
+#define rq_hash_key(rq)		((rq)->sector + (rq)->nr_sectors)
+#define list_entry_hash(ptr)	list_entry((ptr), struct cfq_rq, hash)
+
+#define list_entry_cfqq(ptr)	list_entry((ptr), struct cfq_queue, cfq_list)
+#define list_entry_prio(ptr)	list_entry((ptr), struct cfq_rq, prio_list)
+
+#define RQ_DATA(rq)		((struct cfq_rq *) (rq)->elevator_private)
+
+#define cfq_account_io(crq)	\
+	((crq)->ioprio != IOPRIO_IDLE && (crq)->ioprio != IOPRIO_RT)
+
+/*
+ * defines how we distribute bandwidth (can be tgid, uid, etc)
+ */
+#define cfq_hash_key(current)	((current)->tgid)
+
+/*
+ * move to io_context
+ */
+#define cfq_ioprio(current)	((current)->ioprio)
+
+#define CFQ_WAIT_RT	0
+#define CFQ_WAIT_NORM	1
+
+static kmem_cache_t *crq_pool;
+static kmem_cache_t *cfq_pool;
+static mempool_t *cfq_mpool;
+
+/*
+ * defines an io class
+ */
+struct class_io_data {
+	struct list_head rr_list;
+	int busy_queues;
+	int busy_rq;
+	struct list_head prio_list;
+	int last_queued;
+};
+
+/*
+ * per-request queue structure
+ */
+struct cfq_data {
+	struct list_head *dispatch;
+	struct list_head *cfq_hash;
+	struct list_head *crq_hash;
+	mempool_t *crq_pool;
+
+	struct class_io_data cid[IOPRIO_NR];
+
+	/*
+	 * total number of busy queues and requests
+	 */
+	int busy_rq;
+	int busy_queues;
+
+	unsigned long rq_starved_mask;
+
+	/*
+	 * grace period handling
+	 */
+	struct timer_list timer;
+	unsigned long wait_end;
+	unsigned long flags;
+	struct work_struct work;
+
+	/*
+	 * tunables
+	 */
+	unsigned int cfq_quantum;
+	unsigned int cfq_idle_quantum;
+	unsigned int cfq_queued;
+	unsigned int cfq_grace_rt;
+	unsigned int cfq_grace_idle;
+};
+
+/*
+ * per-class structure
+ */
+struct cfq_queue {
+	struct list_head cfq_list;
+	struct list_head cfq_hash;
+	int hash_key;
+	struct rb_root sort_list;
+	int queued[2];
+	int ioprio;
+};
+
+/*
+ * per-request structure
+ */
+struct cfq_rq {
+	struct cfq_queue *cfq_queue;
+	struct rb_node rb_node;
+	struct list_head hash;
+	sector_t rb_key;
+
+	struct request *request;
+
+	struct list_head prio_list;
+	int ioprio;
+};
+
+static void cfq_put_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq);
+static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *cfqd, int pid);
+static void cfq_dispatch_sort(struct list_head *head, struct cfq_rq *crq);
+
+/*
+ * lots of deadline iosched dupes, can be abstracted later...
+ */
+static inline void __cfq_del_crq_hash(struct cfq_rq *crq)
+{
+	list_del_init(&crq->hash);
+}
+
+static inline void cfq_del_crq_hash(struct cfq_rq *crq)
+{
+	if (ON_MHASH(crq))
+		__cfq_del_crq_hash(crq);
+}
+
+static inline void
+cfq_remove_merge_hints(request_queue_t *q, struct cfq_rq *crq)
+{
+	cfq_del_crq_hash(crq);
+
+	if (q->last_merge == crq->request)
+		q->last_merge = NULL;
+}
+
+static inline void cfq_add_crq_hash(struct cfq_data *cfqd, struct cfq_rq *crq)
+{
+	struct request *rq = crq->request;
+
+	BUG_ON(ON_MHASH(crq));
+
+	list_add(&crq->hash, &cfqd->crq_hash[CFQ_MHASH_FN(rq_hash_key(rq))]);
+}
+
+static struct request *cfq_find_rq_hash(struct cfq_data *cfqd, sector_t offset)
+{
+	struct list_head *hash_list = &cfqd->crq_hash[CFQ_MHASH_FN(offset)];
+	struct list_head *entry, *next = hash_list->next;
+
+	while ((entry = next) != hash_list) {
+		struct cfq_rq *crq = list_entry_hash(entry);
+		struct request *__rq = crq->request;
+
+		next = entry->next;
+
+		BUG_ON(!ON_MHASH(crq));
+
+		if (!rq_mergeable(__rq)) {
+			__cfq_del_crq_hash(crq);
+			continue;
+		}
+
+		if (rq_hash_key(__rq) == offset)
+			return __rq;
+	}
+
+	return NULL;
+}
+
+/*
+ * rb tree support functions
+ */
+#define RB_NONE			(2)
+#define RB_EMPTY(node)		((node)->rb_node == NULL)
+#define RB_CLEAR(node)		((node)->rb_color = RB_NONE)
+#define RB_CLEAR_ROOT(root)	((root)->rb_node = NULL)
+#define ON_RB(node)		((node)->rb_color != RB_NONE)
+#define rb_entry_crq(node)	rb_entry((node), struct cfq_rq, rb_node)
+#define rq_rb_key(rq)		(rq)->sector
+
+static void
+cfq_del_crq_rb(struct cfq_data *cfqd, struct cfq_queue *cfqq,struct cfq_rq *crq)
+{
+	if (ON_RB(&crq->rb_node)) {
+		if (cfq_account_io(crq)) {
+			cfqd->busy_rq--;
+			cfqd->cid[crq->ioprio].busy_rq--;
+		}
+		cfqq->queued[rq_data_dir(crq->request)]--;
+		rb_erase(&crq->rb_node, &cfqq->sort_list);
+		RB_CLEAR(&crq->rb_node);
+		crq->cfq_queue = NULL;
+	}
+}
+
+static struct cfq_rq *
+__cfq_add_crq_rb(struct cfq_queue *cfqq, struct cfq_rq *crq)
+{
+	struct rb_node **p = &cfqq->sort_list.rb_node;
+	struct rb_node *parent = NULL;
+	struct cfq_rq *__crq;
+
+	while (*p) {
+		parent = *p;
+		__crq = rb_entry_crq(parent);
+
+		if (crq->rb_key < __crq->rb_key)
+			p = &(*p)->rb_left;
+		else if (crq->rb_key > __crq->rb_key)
+			p = &(*p)->rb_right;
+		else
+			return __crq;
+	}
+
+	rb_link_node(&crq->rb_node, parent, p);
+	return 0;
+}
+
+static void
+cfq_add_crq_rb(struct cfq_data *cfqd, struct cfq_queue *cfqq,struct cfq_rq *crq)
+{
+	struct request *rq = crq->request;
+	struct cfq_rq *__alias;
+
+	crq->rb_key = rq_rb_key(rq);
+	cfqq->queued[rq_data_dir(rq)]++;
+	if (cfq_account_io(crq)) {
+		cfqd->busy_rq++;
+		cfqd->cid[crq->ioprio].busy_rq++;
+	}
+retry:
+	__alias = __cfq_add_crq_rb(cfqq, crq);
+	if (!__alias) {
+		rb_insert_color(&crq->rb_node, &cfqq->sort_list);
+		crq->cfq_queue = cfqq;
+		return;
+	}
+
+	cfq_del_crq_rb(cfqd, cfqq, __alias);
+	cfq_dispatch_sort(cfqd->dispatch, __alias);
+	goto retry;
+}
+
+static struct request *
+cfq_find_rq_rb(struct cfq_data *cfqd, sector_t sector)
+{
+	struct cfq_queue *cfqq = cfq_find_cfq_hash(cfqd, cfq_hash_key(current));
+	struct rb_node *n;
+
+	if (!cfqq)
+		goto out;
+
+	n = cfqq->sort_list.rb_node;
+	while (n) {
+		struct cfq_rq *crq = rb_entry_crq(n);
+
+		if (sector < crq->rb_key)
+			n = n->rb_left;
+		else if (sector > crq->rb_key)
+			n = n->rb_right;
+		else
+			return crq->request;
+	}
+
+out:
+	return NULL;
+}
+
+static void cfq_remove_request(request_queue_t *q, struct request *rq)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_rq *crq = RQ_DATA(rq);
+
+	if (crq) {
+		cfq_remove_merge_hints(q, crq);
+		list_del_init(&crq->prio_list);
+		list_del_init(&rq->queuelist);
+
+		/*
+		 * set a grace period timer to allow realtime io to make real
+		 * progress, if we release an rt request. for normal request,
+		 * set timer so idle io doesn't interfere with other io
+		 */
+		if (crq->ioprio == IOPRIO_RT) {
+			set_bit(CFQ_WAIT_RT, &cfqd->flags);
+			cfqd->wait_end = jiffies + cfqd->cfq_grace_rt;
+		} else if (crq->ioprio != IOPRIO_IDLE) {
+			set_bit(CFQ_WAIT_NORM, &cfqd->flags);
+			cfqd->wait_end = jiffies + cfqd->cfq_grace_idle;
+		}
+
+		if (ON_RB(&crq->rb_node)) {
+			struct cfq_queue *cfqq = crq->cfq_queue;
+
+			cfq_del_crq_rb(cfqd, cfqq, crq);
+
+			if (RB_EMPTY(&cfqq->sort_list))
+				cfq_put_queue(cfqd, cfqq);
+		}
+	}
+}
+
+static int
+cfq_merge(request_queue_t *q, struct request **req, struct bio *bio)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct request *__rq;
+	int ret;
+
+	ret = elv_try_last_merge(q, bio);
+	if (ret != ELEVATOR_NO_MERGE) {
+		__rq = q->last_merge;
+		goto out_insert;
+	}
+
+	__rq = cfq_find_rq_hash(cfqd, bio->bi_sector);
+	if (__rq) {
+		BUG_ON(__rq->sector + __rq->nr_sectors != bio->bi_sector);
+
+		if (elv_rq_merge_ok(__rq, bio)) {
+			ret = ELEVATOR_BACK_MERGE;
+			goto out;
+		}
+	}
+
+	__rq = cfq_find_rq_rb(cfqd, bio->bi_sector + bio_sectors(bio));
+	if (__rq) {
+		if (elv_rq_merge_ok(__rq, bio)) {
+			ret = ELEVATOR_FRONT_MERGE;
+			goto out;
+		}
+	}
+
+	return ELEVATOR_NO_MERGE;
+out:
+	q->last_merge = __rq;
+out_insert:
+	*req = __rq;
+	return ret;
+}
+
+static void cfq_merged_request(request_queue_t *q, struct request *req)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_rq *crq = RQ_DATA(req);
+
+	cfq_del_crq_hash(crq);
+	cfq_add_crq_hash(cfqd, crq);
+
+	if (ON_RB(&crq->rb_node) && (rq_rb_key(req) != crq->rb_key)) {
+		struct cfq_queue *cfqq = crq->cfq_queue;
+
+		cfq_del_crq_rb(cfqd, cfqq, crq);
+		cfq_add_crq_rb(cfqd, cfqq, crq);
+	}
+
+	q->last_merge = req;
+}
+
+static void
+cfq_merged_requests(request_queue_t *q, struct request *req,
+		    struct request *next)
+{
+	cfq_merged_request(q, req);
+	cfq_remove_request(q, next);
+}
+
+/*
+ * sort into dispatch list, in optimal ascending order
+ */
+static void cfq_dispatch_sort(struct list_head *head, struct cfq_rq *crq)
+{
+	struct list_head *entry = head;
+	struct request *__rq;
+
+	if (!list_empty(head)) {
+		__rq = list_entry_rq(head->next);
+
+		if (crq->request->sector < __rq->sector) {
+			entry = head->prev;
+			goto link;
+		}
+	}
+
+	while ((entry = entry->prev) != head) {
+		__rq = list_entry_rq(entry);
+
+		if (crq->request->sector <= __rq->sector)
+			break;
+	}
+
+link:
+	list_add_tail(&crq->request->queuelist, entry);
+}
+
+/*
+ * remove from io scheduler core and put on dispatch list for service
+ */
+static inline void
+__cfq_dispatch_requests(request_queue_t *q, struct cfq_data *cfqd,
+			struct cfq_queue *cfqq)
+{
+	struct cfq_rq *crq;
+
+	crq = rb_entry_crq(rb_first(&cfqq->sort_list));
+
+	cfq_del_crq_rb(cfqd, cfqq, crq);
+	cfq_remove_merge_hints(q, crq);
+	cfq_dispatch_sort(cfqd->dispatch, crq);
+
+	/*
+	 * technically, for IOPRIO_RT we don't need to add it to the list.
+	 */
+	list_add_tail(&crq->prio_list, &cfqd->cid[cfqq->ioprio].prio_list);
+}
+
+static int
+cfq_dispatch_requests(request_queue_t *q, int prio, int may_queue)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct list_head *plist = &cfqd->cid[prio].rr_list;
+	struct list_head *entry, *nxt;
+	int queued = 0;
+
+	/*
+	 * for each queue at this prio level, dispatch a request
+	 */
+	list_for_each_safe(entry, nxt, plist) {
+		struct cfq_queue *cfqq = list_entry_cfqq(entry);
+
+		BUG_ON(RB_EMPTY(&cfqq->sort_list));
+
+		__cfq_dispatch_requests(q, cfqd, cfqq);
+		queued++;
+
+		if (RB_EMPTY(&cfqq->sort_list))
+			cfq_put_queue(cfqd, cfqq);
+
+		/*
+		 * if we hit the queue limit, put the string of serviced
+		 * queues at the back of the pending list
+		 */
+		if (queued == may_queue) {
+			struct list_head *prv = nxt->prev;
+
+			if (prv != plist) {
+				list_del(plist);
+				list_add(plist, prv);
+			}
+			break;
+		}
+	}
+
+	return queued;
+}
+
+/*
+ * try to move some requests to the dispatch list. return 0 on success
+ */
+static int cfq_select_requests(request_queue_t *q, struct cfq_data *cfqd)
+{
+	int queued, ios, i;
+
+	/*
+	 * if there's any realtime io, only schedule that
+	 */
+	if (cfq_dispatch_requests(q, IOPRIO_RT, cfqd->cfq_quantum))
+		return 1;
+
+	/*
+	 * if RT io was last serviced and grace time hasn't expired,
+	 * arm the timer to restart queueing if no other RT io has been
+	 * submitted in the mean time
+	 */
+	if (test_bit(CFQ_WAIT_RT, &cfqd->flags)) {
+		if (time_before(jiffies, cfqd->wait_end)) {
+			mod_timer(&cfqd->timer, cfqd->wait_end);
+			return 0;
+		}
+		clear_bit(CFQ_WAIT_RT, &cfqd->flags);
+	}
+
+	/*
+	 * for each priority class, calculate number of requests we
+	 * are allowed to put into service.
+	 */
+	queued = 0;
+	ios = cfqd->busy_rq;
+	for (i = IOPRIO_RT - 1; i > IOPRIO_IDLE; i--) {
+		const int other_io = ios - cfqd->cid[i].busy_rq;
+		int may_queue = cfqd->cfq_quantum;
+		int dispatched;
+
+		/*
+		 * no need to keep iterating the list, if there are no
+		 * requests pending anymore
+		 */
+		if (!cfqd->busy_rq)
+			break;
+
+		if (other_io)
+			may_queue = other_io * (i + 1) / IOPRIO_NR;
+		if (may_queue > cfqd->cfq_quantum)
+			may_queue = cfqd->cfq_quantum;
+		/*
+		 * average with last dispatched for fairness
+		 */
+		if (cfqd->cid[i].last_queued != -1)
+			may_queue = (cfqd->cid[i].last_queued + may_queue) / 2;
+
+		dispatched = cfq_dispatch_requests(q, i, may_queue);
+
+		cfqd->cid[i].last_queued = dispatched;
+		queued += dispatched;
+	}
+
+	if (queued)
+		return 1;
+
+	/*
+	 * only allow dispatch of idle io, if the queue has been idle from
+	 * servicing RT or normal io for the grace period
+	 */
+	if (test_bit(CFQ_WAIT_NORM, &cfqd->flags)) {
+		if (time_before(jiffies, cfqd->wait_end)) {
+			mod_timer(&cfqd->timer, cfqd->wait_end);
+			return 0;
+		}
+		clear_bit(CFQ_WAIT_NORM, &cfqd->flags);
+	}
+
+	/*
+	 * if we found nothing to do, allow idle io to be serviced
+	 */
+	if (cfq_dispatch_requests(q, IOPRIO_IDLE, cfqd->cfq_idle_quantum))
+		return 1;
+
+	return 0;
+}
+
+static struct request *cfq_next_request(request_queue_t *q)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct request *rq;
+
+	if (!list_empty(cfqd->dispatch)) {
+		struct cfq_rq *crq;
+dispatch:
+		/*
+		 * end grace period, we are servicing a request
+		 */
+		del_timer(&cfqd->timer);
+		clear_bit(CFQ_WAIT_RT, &cfqd->flags);
+		clear_bit(CFQ_WAIT_NORM, &cfqd->flags);
+
+		BUG_ON(list_empty(cfqd->dispatch));
+		rq = list_entry_rq(cfqd->dispatch->next);
+
+		BUG_ON(q->last_merge == rq);
+		crq = RQ_DATA(rq);
+		if (crq) {
+			BUG_ON(ON_MHASH(crq));
+			list_del_init(&crq->prio_list);
+		}
+
+		return rq;
+	}
+
+	/*
+	 * we moved requests to dispatch list, go back end serve one
+	 */
+	if (cfq_select_requests(q, cfqd))
+		goto dispatch;
+
+	return NULL;
+}
+
+static inline struct cfq_queue *
+__cfq_find_cfq_hash(struct cfq_data *cfqd, int hashkey, const int hashval)
+{
+	struct list_head *hash_list = &cfqd->cfq_hash[hashval];
+	struct list_head *entry;
+
+	list_for_each(entry, hash_list) {
+		struct cfq_queue *__cfqq = list_entry_qhash(entry);
+
+		if (__cfqq->hash_key == hashkey)
+			return __cfqq;
+	}
+
+	return NULL;
+}
+
+static struct cfq_queue *cfq_find_cfq_hash(struct cfq_data *cfqd, int hashkey)
+{
+	const int hashval = hash_long(hashkey, CFQ_QHASH_SHIFT);
+
+	return __cfq_find_cfq_hash(cfqd, hashkey, hashval);
+}
+
+static void cfq_put_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq)
+{
+	cfqd->busy_queues--;
+	WARN_ON(cfqd->busy_queues < 0);
+
+	cfqd->cid[cfqq->ioprio].busy_queues--;
+	WARN_ON(cfqd->cid[cfqq->ioprio].busy_queues < 0);
+
+	list_del(&cfqq->cfq_list);
+	list_del(&cfqq->cfq_hash);
+	mempool_free(cfqq, cfq_mpool);
+}
+
+static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, int hashkey)
+{
+	const int hashval = hash_long(hashkey, CFQ_QHASH_SHIFT);
+	struct cfq_queue *cfqq = __cfq_find_cfq_hash(cfqd, hashkey, hashval);
+
+	if (!cfqq) {
+		cfqq = mempool_alloc(cfq_mpool, GFP_NOIO);
+
+		INIT_LIST_HEAD(&cfqq->cfq_hash);
+		INIT_LIST_HEAD(&cfqq->cfq_list);
+		RB_CLEAR_ROOT(&cfqq->sort_list);
+
+		cfqq->hash_key = cfq_hash_key(current);
+		cfqq->queued[0] = cfqq->queued[1] = 0;
+		cfqq->ioprio = cfq_ioprio(current);
+		list_add(&cfqq->cfq_hash, &cfqd->cfq_hash[hashval]);
+	}
+
+	return cfqq;
+}
+
+static void
+__cfq_enqueue(request_queue_t *q, struct cfq_data *cfqd, struct cfq_rq *crq)
+{
+	const int prio = crq->ioprio;
+	struct cfq_queue *cfqq;
+
+	cfqq = cfq_get_queue(cfqd, cfq_hash_key(current));
+
+	/*
+	 * not too good...
+	 */
+	if (prio > cfqq->ioprio) {
+		if (!list_empty(&cfqq->cfq_list)) {
+			cfqd->cid[cfqq->ioprio].busy_queues--;
+			WARN_ON(cfqd->cid[cfqq->ioprio].busy_queues < 0);
+			cfqd->cid[prio].busy_queues++;
+			list_move_tail(&cfqq->cfq_list,&cfqd->cid[prio].rr_list);
+		}
+		cfqq->ioprio = prio;
+	}
+
+	cfq_add_crq_rb(cfqd, cfqq, crq);
+
+	if (list_empty(&cfqq->cfq_list)) {
+		list_add_tail(&cfqq->cfq_list, &cfqd->cid[prio].rr_list);
+		cfqd->cid[prio].busy_queues++;
+		cfqd->busy_queues++;
+	}
+
+	if (rq_mergeable(crq->request)) {
+		cfq_add_crq_hash(cfqd, crq);
+
+		if (!q->last_merge)
+			q->last_merge = crq->request;
+	}
+
+}
+
+static void cfq_reenqueue(request_queue_t *q, struct cfq_data *cfqd, int prio)
+{
+	struct list_head *prio_list = &cfqd->cid[prio].prio_list;
+	struct list_head *entry, *tmp;
+
+	list_for_each_safe(entry, tmp, prio_list) {
+		struct cfq_rq *crq = list_entry_prio(entry);
+
+		list_del_init(entry);
+		list_del_init(&crq->request->queuelist);
+		__cfq_enqueue(q, cfqd, crq);
+	}
+}
+
+static void
+cfq_enqueue(request_queue_t *q, struct cfq_data *cfqd, struct cfq_rq *crq)
+{
+	const int prio = cfq_ioprio(current);
+
+	crq->ioprio = prio;
+	__cfq_enqueue(q, cfqd, crq);
+
+	if (prio == IOPRIO_RT) {
+		int i;
+
+		/*
+		 * realtime io gets priority, move all other io back
+		 */
+		for (i = IOPRIO_IDLE; i < IOPRIO_RT; i++)
+			cfq_reenqueue(q, cfqd, i);
+	} else if (prio != IOPRIO_IDLE) {
+		/*
+		 * check if we need to move idle io back into queue
+		 */
+		cfq_reenqueue(q, cfqd, IOPRIO_IDLE);
+	}
+}
+
+static void
+cfq_insert_request(request_queue_t *q, struct request *rq, int where)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_rq *crq = RQ_DATA(rq);
+
+	switch (where) {
+		case ELEVATOR_INSERT_BACK:
+#if 0
+			while (cfq_dispatch_requests(q, cfqd))
+				;
+#endif
+			list_add_tail(&rq->queuelist, cfqd->dispatch);
+			break;
+		case ELEVATOR_INSERT_FRONT:
+			list_add(&rq->queuelist, cfqd->dispatch);
+			break;
+		case ELEVATOR_INSERT_SORT:
+			BUG_ON(!blk_fs_request(rq));
+			cfq_enqueue(q, cfqd, crq);
+			break;
+		default:
+			printk("%s: bad insert point %d\n", __FUNCTION__,where);
+			return;
+	}
+}
+
+static int cfq_queue_empty(request_queue_t *q)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+
+	if (list_empty(cfqd->dispatch) && !cfqd->busy_queues)
+		return 1;
+
+	return 0;
+}
+
+static struct request *
+cfq_former_request(request_queue_t *q, struct request *rq)
+{
+	struct cfq_rq *crq = RQ_DATA(rq);
+	struct rb_node *rbprev = rb_prev(&crq->rb_node);
+
+	if (rbprev)
+		return rb_entry_crq(rbprev)->request;
+
+	return NULL;
+}
+
+static struct request *
+cfq_latter_request(request_queue_t *q, struct request *rq)
+{
+	struct cfq_rq *crq = RQ_DATA(rq);
+	struct rb_node *rbnext = rb_next(&crq->rb_node);
+
+	if (rbnext)
+		return rb_entry_crq(rbnext)->request;
+
+	return NULL;
+}
+
+static void cfq_queue_congested(request_queue_t *q)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+
+	set_bit(cfq_ioprio(current), &cfqd->rq_starved_mask);
+}
+
+static int cfq_may_queue(request_queue_t *q, int rw)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_queue *cfqq;
+	const int prio = cfq_ioprio(current);
+	int limit, ret = 1;
+
+	if (!cfqd->busy_queues)
+		goto out;
+
+	cfqq = cfq_find_cfq_hash(cfqd, cfq_hash_key(current));
+	if (!cfqq)
+		goto out;
+
+	cfqq = cfq_find_cfq_hash(cfqd, cfq_hash_key(current));
+	if (!cfqq)
+		goto out;
+
+	/*
+	 * if higher or equal prio io is sleeping waiting for a request, don't
+	 * allow this one to allocate one. as long as ll_rw_blk does fifo
+	 * waitqueue wakeups this should work...
+	 */
+	if (cfqd->rq_starved_mask & ~((1 << prio) - 1))
+		goto out;
+
+	if (cfqq->queued[rw] < cfqd->cfq_queued || !cfqd->cid[prio].busy_queues)
+		goto out;
+
+	limit = q->nr_requests * (prio + 1) / IOPRIO_NR;
+	limit /= cfqd->cid[prio].busy_queues;
+	if (cfqq->queued[rw] > limit)
+		ret = 0;
+
+out:
+	return ret;
+}
+
+static void cfq_put_request(request_queue_t *q, struct request *rq)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_rq *crq = RQ_DATA(rq);
+
+	if (crq) {
+		BUG_ON(q->last_merge == rq);
+		BUG_ON(ON_MHASH(crq));
+
+		mempool_free(crq, cfqd->crq_pool);
+		rq->elevator_private = NULL;
+	}
+}
+
+static int cfq_set_request(request_queue_t *q, struct request *rq, int gfp_mask)
+{
+	struct cfq_data *cfqd = q->elevator.elevator_data;
+	struct cfq_rq *crq = mempool_alloc(cfqd->crq_pool, gfp_mask);
+
+	if (crq) {
+		/*
+		 * process now has one request
+		 */
+		clear_bit(cfq_ioprio(current), &cfqd->rq_starved_mask);
+
+		memset(crq, 0, sizeof(*crq));
+		RB_CLEAR(&crq->rb_node);
+		crq->request = rq;
+		INIT_LIST_HEAD(&crq->hash);
+		INIT_LIST_HEAD(&crq->prio_list);
+		rq->elevator_private = crq;
+		return 0;
+	}
+
+	return 1;
+}
+
+static void cfq_exit(request_queue_t *q, elevator_t *e)
+{
+	struct cfq_data *cfqd = e->elevator_data;
+
+	e->elevator_data = NULL;
+	mempool_destroy(cfqd->crq_pool);
+	kfree(cfqd->crq_hash);
+	kfree(cfqd->cfq_hash);
+	kfree(cfqd);
+}
+
+static void cfq_timer(unsigned long data)
+{
+	struct cfq_data *cfqd = (struct cfq_data *) data;
+
+	clear_bit(CFQ_WAIT_RT, &cfqd->flags);
+	clear_bit(CFQ_WAIT_NORM, &cfqd->flags);
+	kblockd_schedule_work(&cfqd->work);
+}
+
+static void cfq_work(void *data)
+{
+	request_queue_t *q = data;
+	unsigned long flags;
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	if (cfq_next_request(q))
+		q->request_fn(q);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+}
+
+static int cfq_init(request_queue_t *q, elevator_t *e)
+{
+	struct cfq_data *cfqd;
+	int i;
+
+	cfqd = kmalloc(sizeof(*cfqd), GFP_KERNEL);
+	if (!cfqd)
+		return -ENOMEM;
+
+	memset(cfqd, 0, sizeof(*cfqd));
+
+	init_timer(&cfqd->timer);
+	cfqd->timer.function = cfq_timer;
+	cfqd->timer.data = (unsigned long) cfqd;
+
+	INIT_WORK(&cfqd->work, cfq_work, q);
+
+	for (i = 0; i < IOPRIO_NR; i++) {
+		struct class_io_data *cid = &cfqd->cid[i];
+
+		INIT_LIST_HEAD(&cid->rr_list);
+		INIT_LIST_HEAD(&cid->prio_list);
+		cid->last_queued = -1;
+	}
+
+	cfqd->crq_hash = kmalloc(sizeof(struct list_head) * CFQ_MHASH_ENTRIES, GFP_KERNEL);
+	if (!cfqd->crq_hash)
+		goto out_crqhash;
+
+	cfqd->cfq_hash = kmalloc(sizeof(struct list_head) * CFQ_QHASH_ENTRIES, GFP_KERNEL);
+	if (!cfqd->cfq_hash)
+		goto out_cfqhash;
+
+	cfqd->crq_pool = mempool_create(BLKDEV_MIN_RQ, mempool_alloc_slab, mempool_free_slab, crq_pool);
+	if (!cfqd->crq_pool)
+		goto out_crqpool;
+
+	for (i = 0; i < CFQ_MHASH_ENTRIES; i++)
+		INIT_LIST_HEAD(&cfqd->crq_hash[i]);
+	for (i = 0; i < CFQ_QHASH_ENTRIES; i++)
+		INIT_LIST_HEAD(&cfqd->cfq_hash[i]);
+
+	cfqd->cfq_queued = cfq_queued;
+	cfqd->cfq_quantum = cfq_quantum;
+	cfqd->cfq_idle_quantum = cfq_idle_quantum;
+	cfqd->cfq_grace_rt = cfq_grace_rt;
+	cfqd->cfq_grace_idle = cfq_grace_idle;
+
+	q->nr_requests <<= 2;
+
+	cfqd->dispatch = &q->queue_head;
+	e->elevator_data = cfqd;
+
+	return 0;
+out_crqpool:
+	kfree(cfqd->cfq_hash);
+out_cfqhash:
+	kfree(cfqd->crq_hash);
+out_crqhash:
+	kfree(cfqd);
+	return -ENOMEM;
+}
+
+static int __init cfq_slab_setup(void)
+{
+	crq_pool = kmem_cache_create("crq_pool", sizeof(struct cfq_rq), 0, 0,
+					NULL, NULL);
+
+	if (!crq_pool)
+		panic("cfq_iosched: can't init crq pool\n");
+
+	cfq_pool = kmem_cache_create("cfq_pool", sizeof(struct cfq_queue), 0, 0,
+					NULL, NULL);
+
+	if (!cfq_pool)
+		panic("cfq_iosched: can't init cfq pool\n");
+
+	cfq_mpool = mempool_create(64, mempool_alloc_slab, mempool_free_slab, cfq_pool);
+
+	if (!cfq_mpool)
+		panic("cfq_iosched: can't init cfq mpool\n");
+
+	return 0;
+}
+
+subsys_initcall(cfq_slab_setup);
+
+/*
+ * sysfs parts below -->
+ */
+struct cfq_fs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct cfq_data *, char *);
+	ssize_t (*store)(struct cfq_data *, const char *, size_t);
+};
+
+static ssize_t
+cfq_var_show(unsigned int var, char *page)
+{
+	return sprintf(page, "%d\n", var);
+}
+
+static ssize_t
+cfq_var_store(unsigned int *var, const char *page, size_t count)
+{
+	char *p = (char *) page;
+
+	*var = simple_strtoul(p, &p, 10);
+	return count;
+}
+
+#define SHOW_FUNCTION(__FUNC, __VAR)					\
+static ssize_t __FUNC(struct cfq_data *cfqd, char *page)		\
+{									\
+	return cfq_var_show(__VAR, (page));				\
+}
+SHOW_FUNCTION(cfq_quantum_show, cfqd->cfq_quantum);
+SHOW_FUNCTION(cfq_idle_quantum_show, cfqd->cfq_idle_quantum);
+SHOW_FUNCTION(cfq_queued_show, cfqd->cfq_queued);
+SHOW_FUNCTION(cfq_grace_rt_show, cfqd->cfq_grace_rt);
+SHOW_FUNCTION(cfq_grace_idle_show, cfqd->cfq_grace_idle);
+#undef SHOW_FUNCTION
+
+#define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX)				\
+static ssize_t __FUNC(struct cfq_data *cfqd, const char *page, size_t count)	\
+{									\
+	int ret = cfq_var_store(__PTR, (page), count);			\
+	if (*(__PTR) < (MIN))						\
+		*(__PTR) = (MIN);					\
+	else if (*(__PTR) > (MAX))					\
+		*(__PTR) = (MAX);					\
+	return ret;							\
+}
+STORE_FUNCTION(cfq_quantum_store, &cfqd->cfq_quantum, 0, INT_MAX);
+STORE_FUNCTION(cfq_idle_quantum_store, &cfqd->cfq_idle_quantum, 0, INT_MAX);
+STORE_FUNCTION(cfq_queued_store, &cfqd->cfq_queued, 0, INT_MAX);
+STORE_FUNCTION(cfq_grace_rt_store, &cfqd->cfq_grace_rt, 0, INT_MAX);
+STORE_FUNCTION(cfq_grace_idle_store, &cfqd->cfq_grace_idle, 0, INT_MAX);
+#undef STORE_FUNCTION
+
+static struct cfq_fs_entry cfq_quantum_entry = {
+	.attr = {.name = "quantum", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_quantum_show,
+	.store = cfq_quantum_store,
+};
+static struct cfq_fs_entry cfq_idle_quantum_entry = {
+	.attr = {.name = "idle_quantum", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_idle_quantum_show,
+	.store = cfq_idle_quantum_store,
+};
+static struct cfq_fs_entry cfq_queued_entry = {
+	.attr = {.name = "queued", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_queued_show,
+	.store = cfq_queued_store,
+};
+static struct cfq_fs_entry cfq_grace_rt_entry = {
+	.attr = {.name = "grace_rt", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_grace_rt_show,
+	.store = cfq_grace_rt_store,
+};
+static struct cfq_fs_entry cfq_grace_idle_entry = {
+	.attr = {.name = "grace_idle", .mode = S_IRUGO | S_IWUSR },
+	.show = cfq_grace_idle_show,
+	.store = cfq_grace_idle_store,
+};
+
+static struct attribute *default_attrs[] = {
+	&cfq_quantum_entry.attr,
+	&cfq_idle_quantum_entry.attr,
+	&cfq_queued_entry.attr,
+	&cfq_grace_rt_entry.attr,
+	&cfq_grace_idle_entry.attr,
+	NULL,
+};
+
+#define to_cfq(atr) container_of((atr), struct cfq_fs_entry, attr)
+
+static ssize_t
+cfq_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
+{
+	elevator_t *e = container_of(kobj, elevator_t, kobj);
+	struct cfq_fs_entry *entry = to_cfq(attr);
+
+	if (!entry->show)
+		return 0;
+
+	return entry->show(e->elevator_data, page);
+}
+
+static ssize_t
+cfq_attr_store(struct kobject *kobj, struct attribute *attr,
+	       const char *page, size_t length)
+{
+	elevator_t *e = container_of(kobj, elevator_t, kobj);
+	struct cfq_fs_entry *entry = to_cfq(attr);
+
+	if (!entry->store)
+		return -EINVAL;
+
+	return entry->store(e->elevator_data, page, length);
+}
+
+static struct sysfs_ops cfq_sysfs_ops = {
+	.show	= cfq_attr_show,
+	.store	= cfq_attr_store,
+};
+
+struct kobj_type cfq_ktype = {
+	.sysfs_ops	= &cfq_sysfs_ops,
+	.default_attrs	= default_attrs,
+};
+
+elevator_t iosched_cfq = {
+	.elevator_name =		"cfq",
+	.elevator_ktype =		&cfq_ktype,
+	.elevator_merge_fn = 		cfq_merge,
+	.elevator_merged_fn =		cfq_merged_request,
+	.elevator_merge_req_fn =	cfq_merged_requests,
+	.elevator_next_req_fn =		cfq_next_request,
+	.elevator_add_req_fn =		cfq_insert_request,
+	.elevator_remove_req_fn =	cfq_remove_request,
+	.elevator_queue_empty_fn =	cfq_queue_empty,
+	.elevator_former_req_fn =	cfq_former_request,
+	.elevator_latter_req_fn =	cfq_latter_request,
+	.elevator_set_req_fn =		cfq_set_request,
+	.elevator_put_req_fn =		cfq_put_request,
+	.elevator_may_queue_fn =	cfq_may_queue,
+	.elevator_set_congested_fn =	cfq_queue_congested,
+	.elevator_init_fn =		cfq_init,
+	.elevator_exit_fn =		cfq_exit,
+};
+
+EXPORT_SYMBOL(iosched_cfq);

-- 
Jens Axboe

