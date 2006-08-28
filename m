Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWH1U2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWH1U2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWH1U2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:28:17 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:46863 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751476AbWH1U2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:28:15 -0400
Date: Mon, 28 Aug 2006 16:28:14 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: [PATCH 1/3] Change return value from queue_work
Message-ID: <Pine.LNX.4.44L0.0608281626320.6800-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as774) renames:

	queue_work()		to add_work_to_q(),
	queue_delayed_work()	to add_delayed_work_to_q(),
	queue_delayed_work_on()	to add_delayed_work_to_q_on().

The return value is altered, so that now 0 = success and -EBUSY = failure.

New routines with the original names are added, so that the majority of
callers don't need any changes.  The new routines call the original
functions, call WARN_ON if there was a failure, and then return void.

Finally, fc_queue_work(), fc_queue_devloss_work(), scsi_queue_work(),
and kblockd_schedule_work() were changed to return void.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Index: mm/drivers/message/i2o/i2o_block.c
===================================================================
--- mm.orig/drivers/message/i2o/i2o_block.c
+++ mm/drivers/message/i2o/i2o_block.c
@@ -941,9 +941,9 @@ static void i2o_block_request_fn(struct 
 			INIT_WORK(&dreq->work, i2o_block_delayed_request_fn,
 				  dreq);
 
-			if (!queue_delayed_work(i2o_block_driver.event_queue,
+			if (add_delayed_work_to_q(i2o_block_driver.event_queue,
 						&dreq->work,
-						I2O_BLOCK_RETRY_TIME))
+						I2O_BLOCK_RETRY_TIME) < 0)
 				kfree(dreq);
 			else {
 				blk_stop_queue(q);
Index: mm/drivers/ata/libata-core.c
===================================================================
--- mm.orig/drivers/ata/libata-core.c
+++ mm/drivers/ata/libata-core.c
@@ -933,12 +933,12 @@ void ata_port_queue_task(struct ata_port
 	PREPARE_WORK(&ap->port_task, fn, data);
 
 	if (!delay)
-		rc = queue_work(ata_wq, &ap->port_task);
+		rc = add_work_to_q(ata_wq, &ap->port_task);
 	else
-		rc = queue_delayed_work(ata_wq, &ap->port_task, delay);
+		rc = add_delayed_work_to_q(ata_wq, &ap->port_task, delay);
 
-	/* rc == 0 means that another user is using port task */
-	WARN_ON(rc == 0);
+	/* rc < 0 means that another user is using port task */
+	WARN_ON(rc < 0);
 }
 
 /**
Index: mm/drivers/scsi/scsi_transport_fc.c
===================================================================
--- mm.orig/drivers/scsi/scsi_transport_fc.c
+++ mm/drivers/scsi/scsi_transport_fc.c
@@ -34,7 +34,7 @@
 #include <scsi/scsi_cmnd.h>
 #include "scsi_priv.h"
 
-static int fc_queue_work(struct Scsi_Host *, struct work_struct *);
+static void fc_queue_work(struct Scsi_Host *, struct work_struct *);
 
 /*
  * Redefine so that we can have same named attributes in the
@@ -1283,12 +1283,8 @@ EXPORT_SYMBOL(fc_release_transport);
  * @shost:	Pointer to Scsi_Host bound to fc_host.
  * @work:	Work to queue for execution.
  *
- * Return value:
- * 	1 - work queued for execution
- *	0 - work is already queued
- *	-EINVAL - work queue doesn't exist
  **/
-static int
+static void
 fc_queue_work(struct Scsi_Host *shost, struct work_struct *work)
 {
 	if (unlikely(!fc_host_work_q(shost))) {
@@ -1297,10 +1293,10 @@ fc_queue_work(struct Scsi_Host *shost, s
 			"when no workqueue created.\n", shost->hostt->name);
 		dump_stack();
 
-		return -EINVAL;
+		return;
 	}
 
-	return queue_work(fc_host_work_q(shost), work);
+	queue_work(fc_host_work_q(shost), work);
 }
 
 /**
@@ -1326,11 +1322,8 @@ fc_flush_work(struct Scsi_Host *shost)
  * @shost:	Pointer to Scsi_Host bound to fc_host.
  * @work:	Work to queue for execution.
  * @delay:	jiffies to delay the work queuing
- *
- * Return value:
- * 	0 on success / != 0 for error
  **/
-static int
+static void
 fc_queue_devloss_work(struct Scsi_Host *shost, struct work_struct *work,
 				unsigned long delay)
 {
@@ -1340,10 +1333,10 @@ fc_queue_devloss_work(struct Scsi_Host *
 			"when no workqueue created.\n", shost->hostt->name);
 		dump_stack();
 
-		return -EINVAL;
+		return;
 	}
 
-	return queue_delayed_work(fc_host_devloss_work_q(shost), work, delay);
+	queue_delayed_work(fc_host_devloss_work_q(shost), work, delay);
 }
 
 /**
Index: mm/block/ll_rw_blk.c
===================================================================
--- mm.orig/block/ll_rw_blk.c
+++ mm/block/ll_rw_blk.c
@@ -3530,9 +3530,9 @@ void blk_rq_bio_prep(request_queue_t *q,
 
 EXPORT_SYMBOL(blk_rq_bio_prep);
 
-int kblockd_schedule_work(struct work_struct *work)
+void kblockd_schedule_work(struct work_struct *work)
 {
-	return queue_work(kblockd_workqueue, work);
+	queue_work(kblockd_workqueue, work);
 }
 
 EXPORT_SYMBOL(kblockd_schedule_work);
Index: mm/drivers/connector/connector.c
===================================================================
--- mm.orig/drivers/connector/connector.c
+++ mm/drivers/connector/connector.c
@@ -142,8 +142,8 @@ static int cn_call_callback(struct cn_ms
 				__cbq->data.ddata = data;
 				__cbq->data.destruct_data = destruct_data;
 
-				if (queue_work(dev->cbdev->cn_queue,
-						&__cbq->work))
+				if (add_work_to_q(dev->cbdev->cn_queue,
+						&__cbq->work) == 0)
 					err = 0;
 			} else {
 				struct work_struct *w;
@@ -165,7 +165,8 @@ static int cn_call_callback(struct cn_ms
 					w->data = d;
 					init_timer(&w->timer);
 					
-					if (queue_work(dev->cbdev->cn_queue, w))
+					if (add_work_to_q(dev->cbdev->cn_queue,
+							w) == 0)
 						err = 0;
 					else {
 						kfree(w);
Index: mm/kernel/workqueue.c
===================================================================
--- mm.orig/kernel/workqueue.c
+++ mm/kernel/workqueue.c
@@ -80,7 +80,7 @@ static inline int is_single_threaded(str
 }
 
 /* Preempt must be disabled. */
-static void __queue_work(struct cpu_workqueue_struct *cwq,
+static void __add_work_to_q(struct cpu_workqueue_struct *cwq,
 			 struct work_struct *work)
 {
 	unsigned long flags;
@@ -94,30 +94,31 @@ static void __queue_work(struct cpu_work
 }
 
 /**
- * queue_work - queue work on a workqueue
+ * add_work_to_q - queue work on a workqueue
  * @wq: workqueue to use
  * @work: work to queue
  *
- * Returns non-zero if it was successfully added.
+ * Returns zero if it was successfully added, -EBUSY if @work is in use.
  *
  * We queue the work to the CPU it was submitted, but there is no
  * guarantee that it will be processed by that CPU.
  */
-int fastcall queue_work(struct workqueue_struct *wq, struct work_struct *work)
+int fastcall add_work_to_q(struct workqueue_struct *wq,
+		struct work_struct *work)
 {
-	int ret = 0, cpu = get_cpu();
+	int ret = -EBUSY, cpu = get_cpu();
 
 	if (!test_and_set_bit(0, &work->pending)) {
 		if (unlikely(is_single_threaded(wq)))
 			cpu = singlethread_cpu;
 		BUG_ON(!list_empty(&work->entry));
-		__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
-		ret = 1;
+		__add_work_to_q(per_cpu_ptr(wq->cpu_wq, cpu), work);
+		ret = 0;
 	}
 	put_cpu();
 	return ret;
 }
-EXPORT_SYMBOL_GPL(queue_work);
+EXPORT_SYMBOL_GPL(add_work_to_q);
 
 static void delayed_work_timer_fn(unsigned long __data)
 {
@@ -128,21 +129,21 @@ static void delayed_work_timer_fn(unsign
 	if (unlikely(is_single_threaded(wq)))
 		cpu = singlethread_cpu;
 
-	__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
+	__add_work_to_q(per_cpu_ptr(wq->cpu_wq, cpu), work);
 }
 
 /**
- * queue_delayed_work - queue work on a workqueue after delay
+ * add_delayed_work_to_q - queue work on a workqueue after delay
  * @wq: workqueue to use
  * @work: work to queue
  * @delay: number of jiffies to wait before queueing
  *
- * Returns non-zero if it was successfully added.
+ * Returns zero if it was successfully added, -EBUSY if @work is in use.
  */
-int fastcall queue_delayed_work(struct workqueue_struct *wq,
+int fastcall add_delayed_work_to_q(struct workqueue_struct *wq,
 			struct work_struct *work, unsigned long delay)
 {
-	int ret = 0;
+	int ret = -EBUSY;
 	struct timer_list *timer = &work->timer;
 
 	if (!test_and_set_bit(0, &work->pending)) {
@@ -155,25 +156,25 @@ int fastcall queue_delayed_work(struct w
 		timer->data = (unsigned long)work;
 		timer->function = delayed_work_timer_fn;
 		add_timer(timer);
-		ret = 1;
+		ret = 0;
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(queue_delayed_work);
+EXPORT_SYMBOL_GPL(add_delayed_work_to_q);
 
 /**
- * queue_delayed_work_on - queue work on specific CPU after delay
+ * add_delayed_work_to_q_on - queue work on specific CPU after delay
  * @cpu: CPU number to execute work on
  * @wq: workqueue to use
  * @work: work to queue
  * @delay: number of jiffies to wait before queueing
  *
- * Returns non-zero if it was successfully added.
+ * Returns zero if it was successfully added, -EBUSY if @work is in use.
  */
-int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
+int add_delayed_work_to_q_on(int cpu, struct workqueue_struct *wq,
 			struct work_struct *work, unsigned long delay)
 {
-	int ret = 0;
+	int ret = -EBUSY;
 	struct timer_list *timer = &work->timer;
 
 	if (!test_and_set_bit(0, &work->pending)) {
@@ -186,11 +187,11 @@ int queue_delayed_work_on(int cpu, struc
 		timer->data = (unsigned long)work;
 		timer->function = delayed_work_timer_fn;
 		add_timer_on(timer, cpu);
-		ret = 1;
+		ret = 0;
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(queue_delayed_work_on);
+EXPORT_SYMBOL_GPL(add_delayed_work_to_q_on);
 
 static void run_workqueue(struct cpu_workqueue_struct *cwq)
 {
@@ -455,7 +456,7 @@ static struct workqueue_struct *keventd_
  */
 int fastcall schedule_work(struct work_struct *work)
 {
-	return queue_work(keventd_wq, work);
+	return !add_work_to_q(keventd_wq, work);
 }
 EXPORT_SYMBOL(schedule_work);
 
@@ -469,7 +470,7 @@ EXPORT_SYMBOL(schedule_work);
  */
 int fastcall schedule_delayed_work(struct work_struct *work, unsigned long delay)
 {
-	return queue_delayed_work(keventd_wq, work, delay);
+	return !add_delayed_work_to_q(keventd_wq, work, delay);
 }
 EXPORT_SYMBOL(schedule_delayed_work);
 
@@ -485,10 +486,43 @@ EXPORT_SYMBOL(schedule_delayed_work);
 int schedule_delayed_work_on(int cpu,
 			struct work_struct *work, unsigned long delay)
 {
-	return queue_delayed_work_on(cpu, keventd_wq, work, delay);
+	return !add_delayed_work_to_q_on(cpu, keventd_wq, work, delay);
 }
 EXPORT_SYMBOL(schedule_delayed_work_on);
 
+/*
+ * Legacy API for use when the return codes aren't needed.
+ * These routines call WARN_ON() if the underlying function fails.
+ */
+void fastcall queue_work(struct workqueue_struct *wq, struct work_struct *work)
+{
+	int rc;
+
+	rc = add_work_to_q(wq, work);
+	WARN_ON(rc < 0);
+}
+EXPORT_SYMBOL(queue_work);
+
+void fastcall queue_delayed_work(struct workqueue_struct *wq,
+		struct work_struct *work, unsigned long delay)
+{
+	int rc;
+
+	rc = add_delayed_work_to_q(wq, work, delay);
+	WARN_ON(rc < 0);
+}
+EXPORT_SYMBOL(queue_delayed_work);
+
+void queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
+		struct work_struct *work, unsigned long delay)
+{
+	int rc;
+
+	rc = add_delayed_work_to_q_on(cpu, wq, work, delay);
+	WARN_ON(rc < 0);
+}
+EXPORT_SYMBOL(queue_delayed_work_on);
+
 /**
  * schedule_on_each_cpu - call a function on each online CPU from keventd
  * @func: the function to call
@@ -513,7 +547,7 @@ int schedule_on_each_cpu(void (*func)(vo
 	mutex_lock(&workqueue_mutex);
 	for_each_online_cpu(cpu) {
 		INIT_WORK(per_cpu_ptr(works, cpu), func, info);
-		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
+		__add_work_to_q(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
 				per_cpu_ptr(works, cpu));
 	}
 	mutex_unlock(&workqueue_mutex);
@@ -617,7 +651,8 @@ static void take_over_work(struct workqu
 		printk("Taking work for %s\n", wq->name);
 		work = list_entry(list.next,struct work_struct,entry);
 		list_del(&work->entry);
-		__queue_work(per_cpu_ptr(wq->cpu_wq, smp_processor_id()), work);
+		__add_work_to_q(per_cpu_ptr(wq->cpu_wq, smp_processor_id()),
+				work);
 	}
 	spin_unlock_irq(&cwq->lock);
 }
Index: mm/net/sunrpc/sched.c
===================================================================
--- mm.orig/net/sunrpc/sched.c
+++ mm/net/sunrpc/sched.c
@@ -313,7 +313,7 @@ static void rpc_make_runnable(struct rpc
 		int status;
 
 		INIT_WORK(&task->u.tk_work, rpc_async_schedule, (void *)task);
-		status = queue_work(task->tk_workqueue, &task->u.tk_work);
+		status = add_work_to_q(task->tk_workqueue, &task->u.tk_work);
 		if (status < 0) {
 			printk(KERN_WARNING "RPC: failed to add task to queue: error: %d!\n", status);
 			task->tk_status = status;
Index: mm/include/scsi/scsi_host.h
===================================================================
--- mm.orig/include/scsi/scsi_host.h
+++ mm/include/scsi/scsi_host.h
@@ -666,7 +666,7 @@ static inline int scsi_host_in_recovery(
 		shost->tmf_in_progress;
 }
 
-extern int scsi_queue_work(struct Scsi_Host *, struct work_struct *);
+extern void scsi_queue_work(struct Scsi_Host *, struct work_struct *);
 extern void scsi_flush_work(struct Scsi_Host *);
 
 extern struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *, int);
Index: mm/include/linux/workqueue.h
===================================================================
--- mm.orig/include/linux/workqueue.h
+++ mm/include/linux/workqueue.h
@@ -61,10 +61,12 @@ extern struct workqueue_struct *__create
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
-extern int FASTCALL(queue_work(struct workqueue_struct *wq, struct work_struct *work));
-extern int FASTCALL(queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));
-extern int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
-	struct work_struct *work, unsigned long delay);
+extern int FASTCALL(add_work_to_q(struct workqueue_struct *wq,
+		struct work_struct *work));
+extern int FASTCALL(add_delayed_work_to_q(struct workqueue_struct *wq,
+		struct work_struct *work, unsigned long delay));
+extern int add_delayed_work_to_q_on(int cpu, struct workqueue_struct *wq,
+		struct work_struct *work, unsigned long delay);
 extern void FASTCALL(flush_workqueue(struct workqueue_struct *wq));
 
 extern int FASTCALL(schedule_work(struct work_struct *work));
@@ -98,4 +100,15 @@ static inline int cancel_delayed_work(st
 	return ret;
 }
 
+/*
+ * Legacy APIs, used by old drivers that don't care about the return code.
+ * These routines call WARN_ON() if the underlying function fails.
+ */
+extern void FASTCALL(queue_work(struct workqueue_struct *wq,
+		struct work_struct *work));
+extern void FASTCALL(queue_delayed_work(struct workqueue_struct *wq,
+		struct work_struct *work, unsigned long delay));
+extern void queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
+		struct work_struct *work, unsigned long delay);
+
 #endif
Index: mm/drivers/scsi/hosts.c
===================================================================
--- mm.orig/drivers/scsi/hosts.c
+++ mm/drivers/scsi/hosts.c
@@ -487,16 +487,11 @@ int scsi_is_host_device(const struct dev
 EXPORT_SYMBOL(scsi_is_host_device);
 
 /**
- * scsi_queue_work - Queue work to the Scsi_Host workqueue.
+ * scsi_queue_work - Submit work to the Scsi_Host workqueue.
  * @shost:	Pointer to Scsi_Host.
  * @work:	Work to queue for execution.
- *
- * Return value:
- * 	1 - work queued for execution
- *	0 - work is already queued
- *	-EINVAL - work queue doesn't exist
  **/
-int scsi_queue_work(struct Scsi_Host *shost, struct work_struct *work)
+void scsi_queue_work(struct Scsi_Host *shost, struct work_struct *work)
 {
 	if (unlikely(!shost->work_q)) {
 		printk(KERN_ERR
@@ -504,10 +499,10 @@ int scsi_queue_work(struct Scsi_Host *sh
 			"when no workqueue created.\n", shost->hostt->name);
 		dump_stack();
 
-		return -EINVAL;
+		return;
 	}
 
-	return queue_work(shost->work_q, work);
+	queue_work(shost->work_q, work);
 }
 EXPORT_SYMBOL_GPL(scsi_queue_work);
 
Index: mm/fs/ocfs2/cluster/tcp.c
===================================================================
--- mm.orig/fs/ocfs2/cluster/tcp.c
+++ mm/fs/ocfs2/cluster/tcp.c
@@ -338,7 +338,7 @@ static void o2net_sc_queue_work(struct o
 				struct work_struct *work)
 {
 	sc_get(sc);
-	if (!queue_work(o2net_wq, work))
+	if (add_work_to_q(o2net_wq, work) < 0)
 		sc_put(sc);
 }
 static void o2net_sc_queue_delayed_work(struct o2net_sock_container *sc,
@@ -346,7 +346,7 @@ static void o2net_sc_queue_delayed_work(
 					int delay)
 {
 	sc_get(sc);
-	if (!queue_delayed_work(o2net_wq, work, delay))
+	if (add_delayed_work_to_q(o2net_wq, work, delay) < 0)
 		sc_put(sc);
 }
 static void o2net_sc_cancel_delayed_work(struct o2net_sock_container *sc,
Index: mm/include/linux/blkdev.h
===================================================================
--- mm.orig/include/linux/blkdev.h
+++ mm/include/linux/blkdev.h
@@ -813,7 +813,7 @@ static inline void put_dev_sector(Sector
 }
 
 struct work_struct;
-int kblockd_schedule_work(struct work_struct *work);
+void kblockd_schedule_work(struct work_struct *work);
 void kblockd_flush(void);
 
 #ifdef CONFIG_LBD
Index: mm/drivers/acpi/osl.c
===================================================================
--- mm.orig/drivers/acpi/osl.c
+++ mm/drivers/acpi/osl.c
@@ -636,9 +636,9 @@ acpi_status acpi_os_execute(acpi_execute
 	task = (void *)(dpc + 1);
 	INIT_WORK(task, acpi_os_execute_deferred, (void *)dpc);
 
-	if (!queue_work(kacpid_wq, task)) {
+	if (add_work_to_q(kacpid_wq, task) < 0) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
-				  "Call to queue_work() failed.\n"));
+				  "Call to add_work_to_q() failed.\n"));
 		kfree(dpc);
 		status = AE_ERROR;
 	}

