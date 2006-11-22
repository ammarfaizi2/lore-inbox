Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755766AbWKVNGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbWKVNGR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 08:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755765AbWKVNGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 08:06:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11149 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755766AbWKVNFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 08:05:34 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 4/5] WorkStruct: Pass the work_struct pointer instead of context data [try #2]
Date: Wed, 22 Nov 2006 13:02:32 +0000
To: torvalds@osdl.org, akpm@osdl.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20061122130231.24778.66928.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com>
References: <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the work_struct pointer to the work function rather than context data.
The work function can use container_of() to work out the data.

For the cases where the container of the work_struct may go away the moment the
pending bit is cleared, it is made possible to defer the release of the
structure by deferring the clearing of the pending bit.

To make this work, an extra flag is introduced into the management side of the
work_struct.  This governs auto-release of the structure upon execution.

Ordinarily, the work queue executor would release the work_struct for further
scheduling or deallocation by clearing the pending bit prior to jumping to the
work function.  This means that, unless the driver makes some guarantee itself
that the work_struct won't go away, the work function may not access anything
else in the work_struct or its container lest they be deallocated..  This is a
problem if the auxiliary data is taken away (as done by the last patch).

However, if the pending bit is *not* cleared before jumping to the work
function, then the work function *may* access the work_struct and its container
with no problems.  But then the work function must itself release the
work_struct by calling work_release().

In most cases, automatic release is fine, so this is the default.  Special
initiators exist for the non-auto-release case (ending in _NAR).


Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/x86_64/kernel/mce.c           |    6 +-
 arch/x86_64/kernel/smpboot.c       |   12 +++-
 arch/x86_64/kernel/time.c          |    4 +
 block/as-iosched.c                 |    7 +--
 block/cfq-iosched.c                |    8 ++-
 block/ll_rw_blk.c                  |    8 +--
 crypto/cryptomgr.c                 |    7 +--
 drivers/acpi/osl.c                 |   25 +++------
 drivers/ata/libata-core.c          |   20 ++++---
 drivers/ata/libata-scsi.c          |   14 +++--
 drivers/ata/libata.h               |    4 +
 drivers/block/floppy.c             |    6 +-
 drivers/char/random.c              |    6 +-
 drivers/char/sysrq.c               |    4 +
 drivers/char/tty_io.c              |   31 ++++++-----
 drivers/char/vt.c                  |    6 +-
 drivers/cpufreq/cpufreq.c          |   10 ++--
 drivers/input/keyboard/atkbd.c     |    6 +-
 drivers/input/serio/libps2.c       |    6 +-
 drivers/net/e1000/e1000_main.c     |   10 ++--
 drivers/pci/pcie/aer/aerdrv.c      |    2 -
 drivers/pci/pcie/aer/aerdrv.h      |    2 -
 drivers/pci/pcie/aer/aerdrv_core.c |    8 +--
 drivers/scsi/scsi_scan.c           |    7 +--
 drivers/scsi/scsi_sysfs.c          |   10 ++--
 fs/aio.c                           |   14 +++--
 fs/bio.c                           |    6 +-
 fs/file.c                          |    6 +-
 fs/nfs/client.c                    |    2 -
 fs/nfs/namespace.c                 |    9 +--
 fs/nfs/nfs4_fs.h                   |    2 -
 fs/nfs/nfs4renewd.c                |    5 +-
 include/linux/libata.h             |    3 +
 include/linux/workqueue.h          |   99 +++++++++++++++++++++++++++---------
 include/net/inet_timewait_sock.h   |    2 -
 ipc/util.c                         |    7 ++-
 kernel/kmod.c                      |   16 ++++--
 kernel/kthread.c                   |   13 +++--
 kernel/power/poweroff.c            |    4 +
 kernel/sys.c                       |    4 +
 kernel/workqueue.c                 |   19 +++----
 mm/slab.c                          |    6 +-
 net/core/link_watch.c              |    6 +-
 net/ipv4/inet_timewait_sock.c      |    5 +-
 net/ipv4/tcp_minisocks.c           |    3 -
 net/sunrpc/cache.c                 |    6 +-
 net/sunrpc/rpc_pipe.c              |    7 +--
 net/sunrpc/sched.c                 |    8 +--
 net/sunrpc/xprt.c                  |    7 +--
 net/sunrpc/xprtsock.c              |   18 ++++---
 security/keys/key.c                |    6 +-
 51 files changed, 293 insertions(+), 219 deletions(-)

diff --git a/arch/x86_64/kernel/mce.c b/arch/x86_64/kernel/mce.c
index 5306f26..c7587fc 100644
--- a/arch/x86_64/kernel/mce.c
+++ b/arch/x86_64/kernel/mce.c
@@ -306,8 +306,8 @@ #endif /* CONFIG_X86_MCE_INTEL */
  */
 
 static int check_interval = 5 * 60; /* 5 minutes */
-static void mcheck_timer(void *data);
-static DECLARE_DELAYED_WORK(mcheck_work, mcheck_timer, NULL);
+static void mcheck_timer(struct work_struct *work);
+static DECLARE_DELAYED_WORK(mcheck_work, mcheck_timer);
 
 static void mcheck_check_cpu(void *info)
 {
@@ -315,7 +315,7 @@ static void mcheck_check_cpu(void *info)
 		do_machine_check(NULL, 0);
 }
 
-static void mcheck_timer(void *data)
+static void mcheck_timer(struct work_struct *work)
 {
 	on_each_cpu(mcheck_check_cpu, NULL, 1, 1);
 	schedule_delayed_work(&mcheck_work, check_interval * HZ);
diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
index 62c2e74..9800147 100644
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -753,14 +753,16 @@ static int __cpuinit wakeup_secondary_vi
 }
 
 struct create_idle {
+	struct work_struct work;
 	struct task_struct *idle;
 	struct completion done;
 	int cpu;
 };
 
-void do_fork_idle(void *_c_idle)
+void do_fork_idle(struct work_struct *work)
 {
-	struct create_idle *c_idle = _c_idle;
+	struct create_idle *c_idle =
+		container_of(work, struct create_idle, work);
 
 	c_idle->idle = fork_idle(c_idle->cpu);
 	complete(&c_idle->done);
@@ -775,10 +777,10 @@ static int __cpuinit do_boot_cpu(int cpu
 	int timeout;
 	unsigned long start_rip;
 	struct create_idle c_idle = {
+		.work = __WORK_INITIALIZER(c_idle.work, do_fork_idle),
 		.cpu = cpu,
 		.done = COMPLETION_INITIALIZER_ONSTACK(c_idle.done),
 	};
-	DECLARE_WORK(work, do_fork_idle, &c_idle);
 
 	/* allocate memory for gdts of secondary cpus. Hotplug is considered */
 	if (!cpu_gdt_descr[cpu].address &&
@@ -825,9 +827,9 @@ static int __cpuinit do_boot_cpu(int cpu
 	 * thread.
 	 */
 	if (!keventd_up() || current_is_keventd())
-		work.func(work.data);
+		c_idle.work.func(&c_idle.work);
 	else {
-		schedule_work(&work);
+		schedule_work(&c_idle.work);
 		wait_for_completion(&c_idle.done);
 	}
 
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index e3ef544..9f05bc9 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -563,7 +563,7 @@ static unsigned int cpufreq_delayed_issc
 static unsigned int cpufreq_init = 0;
 static struct work_struct cpufreq_delayed_get_work;
 
-static void handle_cpufreq_delayed_get(void *v)
+static void handle_cpufreq_delayed_get(struct work_struct *v)
 {
 	unsigned int cpu;
 	for_each_online_cpu(cpu) {
@@ -639,7 +639,7 @@ static struct notifier_block time_cpufre
 
 static int __init cpufreq_tsc(void)
 {
-	INIT_WORK(&cpufreq_delayed_get_work, handle_cpufreq_delayed_get, NULL);
+	INIT_WORK(&cpufreq_delayed_get_work, handle_cpufreq_delayed_get);
 	if (!cpufreq_register_notifier(&time_cpufreq_notifier_block,
 				       CPUFREQ_TRANSITION_NOTIFIER))
 		cpufreq_init = 1;
diff --git a/block/as-iosched.c b/block/as-iosched.c
index 50b95e4..f371c93 100644
--- a/block/as-iosched.c
+++ b/block/as-iosched.c
@@ -1274,9 +1274,10 @@ static void as_merged_requests(request_q
  *
  * FIXME! dispatch queue is not a queue at all!
  */
-static void as_work_handler(void *data)
+static void as_work_handler(struct work_struct *work)
 {
-	struct request_queue *q = data;
+	struct as_data *ad = container_of(work, struct as_data, antic_work);
+	struct request_queue *q = ad->q;
 	unsigned long flags;
 
 	spin_lock_irqsave(q->queue_lock, flags);
@@ -1332,7 +1333,7 @@ static void *as_init_queue(request_queue
 	ad->antic_timer.function = as_antic_timeout;
 	ad->antic_timer.data = (unsigned long)q;
 	init_timer(&ad->antic_timer);
-	INIT_WORK(&ad->antic_work, as_work_handler, q);
+	INIT_WORK(&ad->antic_work, as_work_handler);
 
 	INIT_LIST_HEAD(&ad->fifo_list[REQ_SYNC]);
 	INIT_LIST_HEAD(&ad->fifo_list[REQ_ASYNC]);
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 1d9c3c7..6cec3a1 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -1841,9 +1841,11 @@ queue_fail:
 	return 1;
 }
 
-static void cfq_kick_queue(void *data)
+static void cfq_kick_queue(struct work_struct *work)
 {
-	request_queue_t *q = data;
+	struct cfq_data *cfqd =
+		container_of(work, struct cfq_data, unplug_work);
+	request_queue_t *q = cfqd->queue;
 	unsigned long flags;
 
 	spin_lock_irqsave(q->queue_lock, flags);
@@ -1987,7 +1989,7 @@ static void *cfq_init_queue(request_queu
 	cfqd->idle_class_timer.function = cfq_idle_class_timer;
 	cfqd->idle_class_timer.data = (unsigned long) cfqd;
 
-	INIT_WORK(&cfqd->unplug_work, cfq_kick_queue, q);
+	INIT_WORK(&cfqd->unplug_work, cfq_kick_queue);
 
 	cfqd->cfq_quantum = cfq_quantum;
 	cfqd->cfq_fifo_expire[0] = cfq_fifo_expire[0];
diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 9eaee66..eb4cf6d 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -34,7 +34,7 @@ #include <linux/blktrace_api.h>
  */
 #include <scsi/scsi_cmnd.h>
 
-static void blk_unplug_work(void *data);
+static void blk_unplug_work(struct work_struct *work);
 static void blk_unplug_timeout(unsigned long data);
 static void drive_stat_acct(struct request *rq, int nr_sectors, int new_io);
 static void init_request_from_bio(struct request *req, struct bio *bio);
@@ -227,7 +227,7 @@ void blk_queue_make_request(request_queu
 	if (q->unplug_delay == 0)
 		q->unplug_delay = 1;
 
-	INIT_WORK(&q->unplug_work, blk_unplug_work, q);
+	INIT_WORK(&q->unplug_work, blk_unplug_work);
 
 	q->unplug_timer.function = blk_unplug_timeout;
 	q->unplug_timer.data = (unsigned long)q;
@@ -1631,9 +1631,9 @@ static void blk_backing_dev_unplug(struc
 	}
 }
 
-static void blk_unplug_work(void *data)
+static void blk_unplug_work(struct work_struct *work)
 {
-	request_queue_t *q = data;
+	request_queue_t *q = container_of(work, request_queue_t, unplug_work);
 
 	blk_add_trace_pdu_int(q, BLK_TA_UNPLUG_IO, NULL,
 				q->rq.count[READ] + q->rq.count[WRITE]);
diff --git a/crypto/cryptomgr.c b/crypto/cryptomgr.c
index 9b5b156..2ebffb8 100644
--- a/crypto/cryptomgr.c
+++ b/crypto/cryptomgr.c
@@ -40,9 +40,10 @@ struct cryptomgr_param {
 	char template[CRYPTO_MAX_ALG_NAME];
 };
 
-static void cryptomgr_probe(void *data)
+static void cryptomgr_probe(struct work_struct *work)
 {
-	struct cryptomgr_param *param = data;
+	struct cryptomgr_param *param =
+		container_of(work, struct cryptomgr_param, work);
 	struct crypto_template *tmpl;
 	struct crypto_instance *inst;
 	int err;
@@ -112,7 +113,7 @@ static int cryptomgr_schedule_probe(stru
 	param->larval.type = larval->alg.cra_flags;
 	param->larval.mask = larval->mask;
 
-	INIT_WORK(&param->work, cryptomgr_probe, param);
+	INIT_WORK(&param->work, cryptomgr_probe);
 	schedule_work(&param->work);
 
 	return NOTIFY_STOP;
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 068fe4f..02b30ae 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -50,6 +50,7 @@ #define PREFIX		"ACPI: "
 struct acpi_os_dpc {
 	acpi_osd_exec_callback function;
 	void *context;
+	struct work_struct work;
 };
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -564,12 +565,9 @@ void acpi_os_derive_pci_id(acpi_handle r
 	acpi_os_derive_pci_id_2(rhandle, chandle, id, &is_bridge, &bus_number);
 }
 
-static void acpi_os_execute_deferred(void *context)
+static void acpi_os_execute_deferred(struct work_struct *work)
 {
-	struct acpi_os_dpc *dpc = NULL;
-
-
-	dpc = (struct acpi_os_dpc *)context;
+	struct acpi_os_dpc *dpc = container_of(work, struct acpi_os_dpc, work);
 	if (!dpc) {
 		printk(KERN_ERR PREFIX "Invalid (NULL) context\n");
 		return;
@@ -602,7 +600,6 @@ acpi_status acpi_os_execute(acpi_execute
 {
 	acpi_status status = AE_OK;
 	struct acpi_os_dpc *dpc;
-	struct work_struct *task;
 
 	ACPI_FUNCTION_TRACE("os_queue_for_execution");
 
@@ -615,28 +612,22 @@ acpi_status acpi_os_execute(acpi_execute
 
 	/*
 	 * Allocate/initialize DPC structure.  Note that this memory will be
-	 * freed by the callee.  The kernel handles the tq_struct list  in a
+	 * freed by the callee.  The kernel handles the work_struct list  in a
 	 * way that allows us to also free its memory inside the callee.
 	 * Because we may want to schedule several tasks with different
 	 * parameters we can't use the approach some kernel code uses of
-	 * having a static tq_struct.
-	 * We can save time and code by allocating the DPC and tq_structs
-	 * from the same memory.
+	 * having a static work_struct.
 	 */
 
-	dpc =
-	    kmalloc(sizeof(struct acpi_os_dpc) + sizeof(struct work_struct),
-		    GFP_ATOMIC);
+	dpc = kmalloc(sizeof(struct acpi_os_dpc), GFP_ATOMIC);
 	if (!dpc)
 		return_ACPI_STATUS(AE_NO_MEMORY);
 
 	dpc->function = function;
 	dpc->context = context;
 
-	task = (void *)(dpc + 1);
-	INIT_WORK(task, acpi_os_execute_deferred, (void *)dpc);
-
-	if (!queue_work(kacpid_wq, task)) {
+	INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+	if (!queue_work(kacpid_wq, &dpc->work)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "Call to queue_work() failed.\n"));
 		kfree(dpc);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0bb4b4d..b5f2da6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -914,7 +914,7 @@ static unsigned int ata_id_xfermask(cons
  *	ata_port_queue_task - Queue port_task
  *	@ap: The ata_port to queue port_task for
  *	@fn: workqueue function to be scheduled
- *	@data: data value to pass to workqueue function
+ *	@data: data for @fn to use
  *	@delay: delay time for workqueue function
  *
  *	Schedule @fn(@data) for execution after @delay jiffies using
@@ -929,7 +929,7 @@ static unsigned int ata_id_xfermask(cons
  *	LOCKING:
  *	Inherited from caller.
  */
-void ata_port_queue_task(struct ata_port *ap, void (*fn)(void *), void *data,
+void ata_port_queue_task(struct ata_port *ap, work_func_t fn, void *data,
 			 unsigned long delay)
 {
 	int rc;
@@ -937,7 +937,8 @@ void ata_port_queue_task(struct ata_port
 	if (ap->pflags & ATA_PFLAG_FLUSH_PORT_TASK)
 		return;
 
-	PREPARE_DELAYED_WORK(&ap->port_task, fn, data);
+	PREPARE_DELAYED_WORK(&ap->port_task, fn);
+	ap->port_task_data = data;
 
 	rc = queue_delayed_work(ata_wq, &ap->port_task, delay);
 
@@ -4292,10 +4293,11 @@ fsm_start:
 	return poll_next;
 }
 
-static void ata_pio_task(void *_data)
+static void ata_pio_task(struct work_struct *work)
 {
-	struct ata_queued_cmd *qc = _data;
-	struct ata_port *ap = qc->ap;
+	struct ata_port *ap =
+		container_of(work, struct ata_port, port_task.work);
+	struct ata_queued_cmd *qc = ap->port_task_data;
 	u8 status;
 	int poll_next;
 
@@ -5317,9 +5319,9 @@ #else
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
 #endif
 
-	INIT_DELAYED_WORK(&ap->port_task, NULL, NULL);
-	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug, ap);
-	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan, ap);
+	INIT_DELAYED_WORK(&ap->port_task, NULL);
+	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
+	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 5c1fc46..2d35c92 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3079,7 +3079,7 @@ static void ata_scsi_remove_dev(struct a
 
 /**
  *	ata_scsi_hotplug - SCSI part of hotplug
- *	@data: Pointer to ATA port to perform SCSI hotplug on
+ *	@work: Pointer to ATA port to perform SCSI hotplug on
  *
  *	Perform SCSI part of hotplug.  It's executed from a separate
  *	workqueue after EH completes.  This is necessary because SCSI
@@ -3089,9 +3089,10 @@ static void ata_scsi_remove_dev(struct a
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-void ata_scsi_hotplug(void *data)
+void ata_scsi_hotplug(struct work_struct *work)
 {
-	struct ata_port *ap = data;
+	struct ata_port *ap =
+		container_of(work, struct ata_port, hotplug_task.work);
 	int i;
 
 	if (ap->pflags & ATA_PFLAG_UNLOADING) {
@@ -3190,7 +3191,7 @@ static int ata_scsi_user_scan(struct Scs
 
 /**
  *	ata_scsi_dev_rescan - initiate scsi_rescan_device()
- *	@data: Pointer to ATA port to perform scsi_rescan_device()
+ *	@work: Pointer to ATA port to perform scsi_rescan_device()
  *
  *	After ATA pass thru (SAT) commands are executed successfully,
  *	libata need to propagate the changes to SCSI layer.  This
@@ -3200,9 +3201,10 @@ static int ata_scsi_user_scan(struct Scs
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-void ata_scsi_dev_rescan(void *data)
+void ata_scsi_dev_rescan(struct work_struct *work)
 {
-	struct ata_port *ap = data;
+	struct ata_port *ap = 
+		container_of(work, struct ata_port, scsi_rescan_task);
 	struct ata_device *dev;
 	unsigned int i;
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 0ed263b..7e0f3af 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -81,7 +81,7 @@ extern struct scsi_transport_template at
 
 extern void ata_scsi_scan_host(struct ata_port *ap);
 extern int ata_scsi_offline_dev(struct ata_device *dev);
-extern void ata_scsi_hotplug(void *data);
+extern void ata_scsi_hotplug(struct work_struct *work);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
 
@@ -111,7 +111,7 @@ extern void ata_scsi_rbuf_fill(struct at
                         unsigned int (*actor) (struct ata_scsi_args *args,
                                            u8 *rbuf, unsigned int buflen));
 extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
-extern void ata_scsi_dev_rescan(void *data);
+extern void ata_scsi_dev_rescan(struct work_struct *work);
 extern int ata_bus_probe(struct ata_port *ap);
 
 /* libata-eh.c */
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index aa1eb44..3f1b382 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -992,11 +992,11 @@ static void empty(void)
 {
 }
 
-static DECLARE_WORK(floppy_work, NULL, NULL);
+static DECLARE_WORK(floppy_work, NULL);
 
 static void schedule_bh(void (*handler) (void))
 {
-	PREPARE_WORK(&floppy_work, (work_func_t)handler, NULL);
+	PREPARE_WORK(&floppy_work, (work_func_t)handler);
 	schedule_work(&floppy_work);
 }
 
@@ -1008,7 +1008,7 @@ static void cancel_activity(void)
 
 	spin_lock_irqsave(&floppy_lock, flags);
 	do_floppy = NULL;
-	PREPARE_WORK(&floppy_work, (work_func_t)empty, NULL);
+	PREPARE_WORK(&floppy_work, (work_func_t)empty);
 	del_timer(&fd_timer);
 	spin_unlock_irqrestore(&floppy_lock, flags);
 }
diff --git a/drivers/char/random.c b/drivers/char/random.c
index f2ab61f..fa76468 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1422,9 +1422,9 @@ static struct keydata {
 
 static unsigned int ip_cnt;
 
-static void rekey_seq_generator(void *private_);
+static void rekey_seq_generator(struct work_struct *work);
 
-static DECLARE_DELAYED_WORK(rekey_work, rekey_seq_generator, NULL);
+static DECLARE_DELAYED_WORK(rekey_work, rekey_seq_generator);
 
 /*
  * Lock avoidance:
@@ -1438,7 +1438,7 @@ static DECLARE_DELAYED_WORK(rekey_work, 
  * happen, and even if that happens only a not perfectly compliant
  * ISN is generated, nothing fatal.
  */
-static void rekey_seq_generator(void *private_)
+static void rekey_seq_generator(struct work_struct *work)
 {
 	struct keydata *keyptr = &ip_keydata[1 ^ (ip_cnt & 1)];
 
diff --git a/drivers/char/sysrq.c b/drivers/char/sysrq.c
index 5f49280..c64f5bc 100644
--- a/drivers/char/sysrq.c
+++ b/drivers/char/sysrq.c
@@ -219,13 +219,13 @@ static struct sysrq_key_op sysrq_term_op
 	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
 
-static void moom_callback(void *ignored)
+static void moom_callback(struct work_struct *ignored)
 {
 	out_of_memory(&NODE_DATA(0)->node_zonelists[ZONE_NORMAL],
 			GFP_KERNEL, 0);
 }
 
-static DECLARE_WORK(moom_work, moom_callback, NULL);
+static DECLARE_WORK(moom_work, moom_callback);
 
 static void sysrq_handle_moom(int key, struct tty_struct *tty)
 {
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index 7297acf..83e9e7d 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1254,7 +1254,7 @@ EXPORT_SYMBOL_GPL(tty_ldisc_flush);
 	
 /**
  *	do_tty_hangup		-	actual handler for hangup events
- *	@data: tty device
+ *	@work: tty device
  *
  *	This can be called by the "eventd" kernel thread.  That is process
  *	synchronous but doesn't hold any locks, so we need to make sure we
@@ -1274,9 +1274,10 @@ EXPORT_SYMBOL_GPL(tty_ldisc_flush);
  *		tasklist_lock to walk task list for hangup event
  *
  */
-static void do_tty_hangup(void *data)
+static void do_tty_hangup(struct work_struct *work)
 {
-	struct tty_struct *tty = (struct tty_struct *) data;
+	struct tty_struct *tty =
+		container_of(work, struct tty_struct, hangup_work);
 	struct file * cons_filp = NULL;
 	struct file *filp, *f = NULL;
 	struct task_struct *p;
@@ -1433,7 +1434,7 @@ #ifdef TTY_DEBUG_HANGUP
 
 	printk(KERN_DEBUG "%s vhangup...\n", tty_name(tty, buf));
 #endif
-	do_tty_hangup((void *) tty);
+	do_tty_hangup(&tty->hangup_work);
 }
 EXPORT_SYMBOL(tty_vhangup);
 
@@ -3304,12 +3305,13 @@ #endif
  * Nasty bug: do_SAK is being called in interrupt context.  This can
  * deadlock.  We punt it up to process context.  AKPM - 16Mar2001
  */
-static void __do_SAK(void *arg)
+static void __do_SAK(struct work_struct *work)
 {
+	struct tty_struct *tty =
+		container_of(work, struct tty_struct, SAK_work);
 #ifdef TTY_SOFT_SAK
 	tty_hangup(tty);
 #else
-	struct tty_struct *tty = arg;
 	struct task_struct *g, *p;
 	int session;
 	int		i;
@@ -3388,7 +3390,7 @@ void do_SAK(struct tty_struct *tty)
 {
 	if (!tty)
 		return;
-	PREPARE_WORK(&tty->SAK_work, __do_SAK, tty);
+	PREPARE_WORK(&tty->SAK_work, __do_SAK);
 	schedule_work(&tty->SAK_work);
 }
 
@@ -3396,7 +3398,7 @@ EXPORT_SYMBOL(do_SAK);
 
 /**
  *	flush_to_ldisc
- *	@private_: tty structure passed from work queue.
+ *	@work: tty structure passed from work queue.
  *
  *	This routine is called out of the software interrupt to flush data
  *	from the buffer chain to the line discipline.
@@ -3406,9 +3408,10 @@ EXPORT_SYMBOL(do_SAK);
  *	receive_buf method is single threaded for each tty instance.
  */
  
-static void flush_to_ldisc(void *private_)
+static void flush_to_ldisc(struct work_struct *work)
 {
-	struct tty_struct *tty = (struct tty_struct *) private_;
+	struct tty_struct *tty =
+		container_of(work, struct tty_struct, buf.work.work);
 	unsigned long 	flags;
 	struct tty_ldisc *disc;
 	struct tty_buffer *tbuf, *head;
@@ -3553,7 +3556,7 @@ void tty_flip_buffer_push(struct tty_str
 	spin_unlock_irqrestore(&tty->buf.lock, flags);
 
 	if (tty->low_latency)
-		flush_to_ldisc((void *) tty);
+		flush_to_ldisc(&tty->buf.work.work);
 	else
 		schedule_delayed_work(&tty->buf.work, 1);
 }
@@ -3580,17 +3583,17 @@ static void initialize_tty_struct(struct
 	tty->overrun_time = jiffies;
 	tty->buf.head = tty->buf.tail = NULL;
 	tty_buffer_init(tty);
-	INIT_DELAYED_WORK(&tty->buf.work, flush_to_ldisc, tty);
+	INIT_DELAYED_WORK(&tty->buf.work, flush_to_ldisc);
 	init_MUTEX(&tty->buf.pty_sem);
 	mutex_init(&tty->termios_mutex);
 	init_waitqueue_head(&tty->write_wait);
 	init_waitqueue_head(&tty->read_wait);
-	INIT_WORK(&tty->hangup_work, do_tty_hangup, tty);
+	INIT_WORK(&tty->hangup_work, do_tty_hangup);
 	mutex_init(&tty->atomic_read_lock);
 	mutex_init(&tty->atomic_write_lock);
 	spin_lock_init(&tty->read_lock);
 	INIT_LIST_HEAD(&tty->tty_files);
-	INIT_WORK(&tty->SAK_work, NULL, NULL);
+	INIT_WORK(&tty->SAK_work, NULL);
 }
 
 /*
diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 8e4413f..8ee04ad 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -155,7 +155,7 @@ static void con_flush_chars(struct tty_s
 static void set_vesa_blanking(char __user *p);
 static void set_cursor(struct vc_data *vc);
 static void hide_cursor(struct vc_data *vc);
-static void console_callback(void *ignored);
+static void console_callback(struct work_struct *ignored);
 static void blank_screen_t(unsigned long dummy);
 static void set_palette(struct vc_data *vc);
 
@@ -174,7 +174,7 @@ static int vesa_blank_mode; /* 0:none 1:
 static int blankinterval = 10*60*HZ;
 static int vesa_off_interval;
 
-static DECLARE_WORK(console_work, console_callback, NULL);
+static DECLARE_WORK(console_work, console_callback);
 
 /*
  * fg_console is the current virtual console,
@@ -2154,7 +2154,7 @@ #undef FLUSH
  * with other console code and prevention of re-entrancy is
  * ensured with console_sem.
  */
-static void console_callback(void *ignored)
+static void console_callback(struct work_struct *ignored)
 {
 	acquire_console_sem();
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index dd0c262..7a7c6e6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -42,7 +42,7 @@ static DEFINE_SPINLOCK(cpufreq_driver_lo
 
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy, unsigned int event);
-static void handle_update(void *data);
+static void handle_update(struct work_struct *work);
 
 /**
  * Two notifier lists: the "policy" list is involved in the
@@ -665,7 +665,7 @@ #endif
 	mutex_init(&policy->lock);
 	mutex_lock(&policy->lock);
 	init_completion(&policy->kobj_unregister);
-	INIT_WORK(&policy->update, handle_update, (void *)(long)cpu);
+	INIT_WORK(&policy->update, handle_update);
 
 	/* call driver. From then on the cpufreq must be able
 	 * to accept all calls to ->verify and ->setpolicy for this CPU
@@ -895,9 +895,11 @@ #endif
 }
 
 
-static void handle_update(void *data)
+static void handle_update(struct work_struct *work)
 {
-	unsigned int cpu = (unsigned int)(long)data;
+	struct cpufreq_policy *policy =
+		container_of(work, struct cpufreq_policy, update);
+	unsigned int cpu = policy->cpu;
 	dprintk("handle_update for cpu %u called\n", cpu);
 	cpufreq_update_policy(cpu);
 }
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index cbb9366..8451b29 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -567,9 +567,9 @@ static int atkbd_set_leds(struct atkbd *
  * interrupt context.
  */
 
-static void atkbd_event_work(void *data)
+static void atkbd_event_work(struct work_struct *work)
 {
-	struct atkbd *atkbd = data;
+	struct atkbd *atkbd = container_of(work, struct atkbd, event_work);
 
 	mutex_lock(&atkbd->event_mutex);
 
@@ -943,7 +943,7 @@ static int atkbd_connect(struct serio *s
 
 	atkbd->dev = dev;
 	ps2_init(&atkbd->ps2dev, serio);
-	INIT_WORK(&atkbd->event_work, atkbd_event_work, atkbd);
+	INIT_WORK(&atkbd->event_work, atkbd_event_work);
 	mutex_init(&atkbd->event_mutex);
 
 	switch (serio->id.type) {
diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index e5b1b60..b3e84d3 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -251,9 +251,9 @@ EXPORT_SYMBOL(ps2_command);
  * ps2_schedule_command(), to a PS/2 device (keyboard, mouse, etc.)
  */
 
-static void ps2_execute_scheduled_command(void *data)
+static void ps2_execute_scheduled_command(struct work_struct *work)
 {
-	struct ps2work *ps2work = data;
+	struct ps2work *ps2work = container_of(work, struct ps2work, work);
 
 	ps2_command(ps2work->ps2dev, ps2work->param, ps2work->command);
 	kfree(ps2work);
@@ -278,7 +278,7 @@ int ps2_schedule_command(struct ps2dev *
 	ps2work->ps2dev = ps2dev;
 	ps2work->command = command;
 	memcpy(ps2work->param, param, send);
-	INIT_WORK(&ps2work->work, ps2_execute_scheduled_command, ps2work);
+	INIT_WORK(&ps2work->work, ps2_execute_scheduled_command);
 
 	if (!schedule_work(&ps2work->work)) {
 		kfree(ps2work);
diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index 726ec5e..0329440 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -183,7 +183,7 @@ void e1000_set_ethtool_ops(struct net_de
 static void e1000_enter_82542_rst(struct e1000_adapter *adapter);
 static void e1000_leave_82542_rst(struct e1000_adapter *adapter);
 static void e1000_tx_timeout(struct net_device *dev);
-static void e1000_reset_task(struct net_device *dev);
+static void e1000_reset_task(struct work_struct *work);
 static void e1000_smartspeed(struct e1000_adapter *adapter);
 static int e1000_82547_fifo_workaround(struct e1000_adapter *adapter,
                                        struct sk_buff *skb);
@@ -908,8 +908,7 @@ #endif
 	adapter->phy_info_timer.function = &e1000_update_phy_info;
 	adapter->phy_info_timer.data = (unsigned long) adapter;
 
-	INIT_WORK(&adapter->reset_task,
-		(void (*)(void *))e1000_reset_task, netdev);
+	INIT_WORK(&adapter->reset_task, e1000_reset_task);
 
 	e1000_check_options(adapter);
 
@@ -3154,9 +3153,10 @@ e1000_tx_timeout(struct net_device *netd
 }
 
 static void
-e1000_reset_task(struct net_device *netdev)
+e1000_reset_task(struct work_struct *work)
 {
-	struct e1000_adapter *adapter = netdev_priv(netdev);
+	struct e1000_adapter *adapter =
+		container_of(work, struct e1000_adapter, reset_task);
 
 	e1000_reinit_locked(adapter);
 }
diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 04c43ef..55866b6 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -160,7 +160,7 @@ static struct aer_rpc* aer_alloc_rpc(str
 	rpc->e_lock = SPIN_LOCK_UNLOCKED;
 
 	rpc->rpd = dev;
-	INIT_WORK(&rpc->dpc_handler, aer_isr, (void *)dev);
+	INIT_WORK(&rpc->dpc_handler, aer_isr);
 	rpc->prod_idx = rpc->cons_idx = 0;
 	mutex_init(&rpc->rpc_mutex);
 	init_waitqueue_head(&rpc->wait_release);
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index daf0cad..3c0a58f 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -118,7 +118,7 @@ extern struct bus_type pcie_port_bus_typ
 extern void aer_enable_rootport(struct aer_rpc *rpc);
 extern void aer_delete_rootport(struct aer_rpc *rpc);
 extern int aer_init(struct pcie_device *dev);
-extern void aer_isr(void *context);
+extern void aer_isr(struct work_struct *work);
 extern void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 extern int aer_osc_setup(struct pci_dev *dev);
 
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 1c7e660..08e1303 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -690,14 +690,14 @@ static void aer_isr_one_error(struct pci
 
 /**
  * aer_isr - consume errors detected by root port
- * @context: pointer to a private data of pcie device
+ * @work: definition of this work item
  *
  * Invoked, as DPC, when root port records new detected error
  **/
-void aer_isr(void *context)
+void aer_isr(struct work_struct *work)
 {
-	struct pcie_device *p_device = (struct pcie_device *) context;
-	struct aer_rpc *rpc = get_service_data(p_device);
+	struct aer_rpc *rpc = container_of(work, struct aer_rpc, dpc_handler);
+	struct pcie_device *p_device = rpc->rpd;
 	struct aer_err_source *e_src;
 
 	mutex_lock(&rpc->rpc_mutex);
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 94a2746..d3c5e96 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -362,9 +362,10 @@ static struct scsi_target *scsi_alloc_ta
 	goto retry;
 }
 
-static void scsi_target_reap_usercontext(void *data)
+static void scsi_target_reap_usercontext(struct work_struct *work)
 {
-	struct scsi_target *starget = data;
+	struct scsi_target *starget =
+		container_of(work, struct scsi_target, ew.work);
 	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
 	unsigned long flags;
 
@@ -400,7 +401,7 @@ void scsi_target_reap(struct scsi_target
 		starget->state = STARGET_DEL;
 		spin_unlock_irqrestore(shost->host_lock, flags);
 		execute_in_process_context(scsi_target_reap_usercontext,
-					   starget, &starget->ew);
+					   &starget->ew);
 		return;
 
 	}
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index e1a9166..259c90c 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -218,16 +218,16 @@ static void scsi_device_cls_release(stru
 	put_device(&sdev->sdev_gendev);
 }
 
-static void scsi_device_dev_release_usercontext(void *data)
+static void scsi_device_dev_release_usercontext(struct work_struct *work)
 {
-	struct device *dev = data;
 	struct scsi_device *sdev;
 	struct device *parent;
 	struct scsi_target *starget;
 	unsigned long flags;
 
-	parent = dev->parent;
-	sdev = to_scsi_device(dev);
+	sdev = container_of(work, struct scsi_device, ew.work);
+
+	parent = sdev->sdev_gendev.parent;
 	starget = to_scsi_target(parent);
 
 	spin_lock_irqsave(sdev->host->host_lock, flags);
@@ -258,7 +258,7 @@ static void scsi_device_dev_release_user
 static void scsi_device_dev_release(struct device *dev)
 {
 	struct scsi_device *sdp = to_scsi_device(dev);
-	execute_in_process_context(scsi_device_dev_release_usercontext, dev,
+	execute_in_process_context(scsi_device_dev_release_usercontext,
 				   &sdp->ew);
 }
 
diff --git a/fs/aio.c b/fs/aio.c
index 11a1a71..ca1c518 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -53,13 +53,13 @@ static kmem_cache_t	*kioctx_cachep;
 static struct workqueue_struct *aio_wq;
 
 /* Used for rare fput completion. */
-static void aio_fput_routine(void *);
-static DECLARE_WORK(fput_work, aio_fput_routine, NULL);
+static void aio_fput_routine(struct work_struct *);
+static DECLARE_WORK(fput_work, aio_fput_routine);
 
 static DEFINE_SPINLOCK(fput_lock);
 static LIST_HEAD(fput_head);
 
-static void aio_kick_handler(void *);
+static void aio_kick_handler(struct work_struct *);
 static void aio_queue_work(struct kioctx *);
 
 /* aio_setup
@@ -227,7 +227,7 @@ static struct kioctx *ioctx_alloc(unsign
 
 	INIT_LIST_HEAD(&ctx->active_reqs);
 	INIT_LIST_HEAD(&ctx->run_list);
-	INIT_DELAYED_WORK(&ctx->wq, aio_kick_handler, ctx);
+	INIT_DELAYED_WORK(&ctx->wq, aio_kick_handler);
 
 	if (aio_setup_ring(ctx) < 0)
 		goto out_freectx;
@@ -470,7 +470,7 @@ static inline void really_put_req(struct
 		wake_up(&ctx->wait);
 }
 
-static void aio_fput_routine(void *data)
+static void aio_fput_routine(struct work_struct *data)
 {
 	spin_lock_irq(&fput_lock);
 	while (likely(!list_empty(&fput_head))) {
@@ -859,9 +859,9 @@ static inline void aio_run_all_iocbs(str
  *      space.
  * Run on aiod's context.
  */
-static void aio_kick_handler(void *data)
+static void aio_kick_handler(struct work_struct *work)
 {
-	struct kioctx *ctx = data;
+	struct kioctx *ctx = container_of(work, struct kioctx, wq.work);
 	mm_segment_t oldfs = get_fs();
 	int requeue;
 
diff --git a/fs/bio.c b/fs/bio.c
index f95c874..c6c07ca 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -955,16 +955,16 @@ static void bio_release_pages(struct bio
  * run one bio_put() against the BIO.
  */
 
-static void bio_dirty_fn(void *data);
+static void bio_dirty_fn(struct work_struct *work);
 
-static DECLARE_WORK(bio_dirty_work, bio_dirty_fn, NULL);
+static DECLARE_WORK(bio_dirty_work, bio_dirty_fn);
 static DEFINE_SPINLOCK(bio_dirty_lock);
 static struct bio *bio_dirty_list;
 
 /*
  * This runs in process context
  */
-static void bio_dirty_fn(void *data)
+static void bio_dirty_fn(struct work_struct *work)
 {
 	unsigned long flags;
 	struct bio *bio;
diff --git a/fs/file.c b/fs/file.c
index 8e81775..3787e82 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -91,8 +91,10 @@ out:
 	spin_unlock(&fddef->lock);
 }
 
-static void free_fdtable_work(struct fdtable_defer *f)
+static void free_fdtable_work(struct work_struct *work)
 {
+	struct fdtable_defer *f =
+		container_of(work, struct fdtable_defer, wq);
 	struct fdtable *fdt;
 
 	spin_lock_bh(&f->lock);
@@ -351,7 +353,7 @@ static void __devinit fdtable_defer_list
 {
 	struct fdtable_defer *fddef = &per_cpu(fdtable_defer_list, cpu);
 	spin_lock_init(&fddef->lock);
-	INIT_WORK(&fddef->wq, (void (*)(void *))free_fdtable_work, fddef);
+	INIT_WORK(&fddef->wq, free_fdtable_work);
 	init_timer(&fddef->timer);
 	fddef->timer.data = (unsigned long)fddef;
 	fddef->timer.function = fdtable_timer;
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 03b3e12..566eb38 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -143,7 +143,7 @@ #ifdef CONFIG_NFS_V4
 	INIT_LIST_HEAD(&clp->cl_state_owners);
 	INIT_LIST_HEAD(&clp->cl_unused);
 	spin_lock_init(&clp->cl_lock);
-	INIT_DELAYED_WORK(&clp->cl_renewd, nfs4_renew_state, clp);
+	INIT_DELAYED_WORK(&clp->cl_renewd, nfs4_renew_state);
 	rpc_init_wait_queue(&clp->cl_rpcwaitq, "NFS client");
 	clp->cl_boot_time = CURRENT_TIME;
 	clp->cl_state = 1 << NFS4CLNT_LEASE_EXPIRED;
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 5ed798b..371b804 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -18,11 +18,10 @@ #include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_VFS
 
-static void nfs_expire_automounts(void *list);
+static void nfs_expire_automounts(struct work_struct *work);
 
 LIST_HEAD(nfs_automount_list);
-static DECLARE_DELAYED_WORK(nfs_automount_task, nfs_expire_automounts,
-			    &nfs_automount_list);
+static DECLARE_DELAYED_WORK(nfs_automount_task, nfs_expire_automounts);
 int nfs_mountpoint_expiry_timeout = 500 * HZ;
 
 static struct vfsmount *nfs_do_submount(const struct vfsmount *mnt_parent,
@@ -165,9 +164,9 @@ struct inode_operations nfs_referral_ino
 	.follow_link	= nfs_follow_mountpoint,
 };
 
-static void nfs_expire_automounts(void *data)
+static void nfs_expire_automounts(struct work_struct *work)
 {
-	struct list_head *list = (struct list_head *)data;
+	struct list_head *list = &nfs_automount_list;
 
 	mark_mounts_for_expiry(list);
 	if (!list_empty(list))
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 6f34667..c26cd97 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -185,7 +185,7 @@ extern const u32 nfs4_fs_locations_bitma
 extern void nfs4_schedule_state_renewal(struct nfs_client *);
 extern void nfs4_renewd_prepare_shutdown(struct nfs_server *);
 extern void nfs4_kill_renewd(struct nfs_client *);
-extern void nfs4_renew_state(void *);
+extern void nfs4_renew_state(struct work_struct *);
 
 /* nfs4state.c */
 struct rpc_cred *nfs4_get_renew_cred(struct nfs_client *clp);
diff --git a/fs/nfs/nfs4renewd.c b/fs/nfs/nfs4renewd.c
index 7b6df18..8232985 100644
--- a/fs/nfs/nfs4renewd.c
+++ b/fs/nfs/nfs4renewd.c
@@ -59,9 +59,10 @@ #include "delegation.h"
 #define NFSDBG_FACILITY	NFSDBG_PROC
 
 void
-nfs4_renew_state(void *data)
+nfs4_renew_state(struct work_struct *work)
 {
-	struct nfs_client *clp = (struct nfs_client *)data;
+	struct nfs_client *clp =
+		container_of(work, struct nfs_client, cl_renewd.work);
 	struct rpc_cred *cred;
 	long lease, timeout;
 	unsigned long last, now;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5f04006..b3f32ea 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -568,6 +568,7 @@ struct ata_port {
 	struct ata_host		*host;
 	struct device 		*dev;
 
+	void			*port_task_data;
 	struct delayed_work	port_task;
 	struct delayed_work	hotplug_task;
 	struct work_struct	scsi_rescan_task;
@@ -747,7 +748,7 @@ extern int ata_ratelimit(void);
 extern unsigned int ata_busy_sleep(struct ata_port *ap,
 				   unsigned long timeout_pat,
 				   unsigned long timeout);
-extern void ata_port_queue_task(struct ata_port *ap, void (*fn)(void *),
+extern void ata_port_queue_task(struct ata_port *ap, work_func_t fn,
 				void *data, unsigned long delay);
 extern u32 ata_wait_register(void __iomem *reg, u32 mask, u32 val,
 			     unsigned long interval_msec,
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index ecc017d..4a3ea83 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -11,18 +11,19 @@ #include <linux/bitops.h>
 
 struct workqueue_struct;
 
-typedef void (*work_func_t)(void *data);
+struct work_struct;
+typedef void (*work_func_t)(struct work_struct *work);
 
 struct work_struct {
-	/* the first word is the work queue pointer and the pending flag
-	 * rolled into one */
+	/* the first word is the work queue pointer and the flags rolled into
+	 * one */
 	unsigned long management;
 #define WORK_STRUCT_PENDING 0		/* T if work item pending execution */
+#define WORK_STRUCT_NOAUTOREL 1		/* F if work item automatically released on exec */
 #define WORK_STRUCT_FLAG_MASK (3UL)
 #define WORK_STRUCT_WQ_DATA_MASK (~WORK_STRUCT_FLAG_MASK)
 	struct list_head entry;
 	work_func_t func;
-	void *data;
 };
 
 struct delayed_work {
@@ -34,48 +35,77 @@ struct execute_work {
 	struct work_struct work;
 };
 
-#define __WORK_INITIALIZER(n, f, d) {				\
+#define __WORK_INITIALIZER(n, f) {				\
+	.management = 0,					\
         .entry	= { &(n).entry, &(n).entry },			\
 	.func = (f),						\
-	.data = (d),						\
 	}
 
-#define __DELAYED_WORK_INITIALIZER(n, f, d) {			\
-	.work = __WORK_INITIALIZER((n).work, (f), (d)),		\
+#define __WORK_INITIALIZER_NAR(n, f) {				\
+	.management = (1 << WORK_STRUCT_NOAUTOREL),		\
+        .entry	= { &(n).entry, &(n).entry },			\
+	.func = (f),						\
+	}
+
+#define __DELAYED_WORK_INITIALIZER(n, f) {			\
+	.work = __WORK_INITIALIZER((n).work, (f)),		\
+	.timer = TIMER_INITIALIZER(NULL, 0, 0),			\
+	}
+
+#define __DELAYED_WORK_INITIALIZER_NAR(n, f) {			\
+	.work = __WORK_INITIALIZER_NAR((n).work, (f)),		\
 	.timer = TIMER_INITIALIZER(NULL, 0, 0),			\
 	}
 
-#define DECLARE_WORK(n, f, d)					\
-	struct work_struct n = __WORK_INITIALIZER(n, f, d)
+#define DECLARE_WORK(n, f)					\
+	struct work_struct n = __WORK_INITIALIZER(n, f)
+
+#define DECLARE_WORK_NAR(n, f)					\
+	struct work_struct n = __WORK_INITIALIZER_NAR(n, f)
 
-#define DECLARE_DELAYED_WORK(n, f, d)				\
-	struct delayed_work n = __DELAYED_WORK_INITIALIZER(n, f, d)
+#define DECLARE_DELAYED_WORK(n, f)				\
+	struct delayed_work n = __DELAYED_WORK_INITIALIZER(n, f)
+
+#define DECLARE_DELAYED_WORK_NAR(n, f)			\
+	struct dwork_struct n = __DELAYED_WORK_INITIALIZER_NAR(n, f)
 
 /*
- * initialize a work item's function and data pointers
+ * initialize a work item's function pointer
  */
-#define PREPARE_WORK(_work, _func, _data)			\
+#define PREPARE_WORK(_work, _func)				\
 	do {							\
 		(_work)->func = (_func);			\
-		(_work)->data = (_data);			\
 	} while (0)
 
-#define PREPARE_DELAYED_WORK(_work, _func, _data)		\
-	PREPARE_WORK(&(_work)->work, (_func), (_data))
+#define PREPARE_DELAYED_WORK(_work, _func)			\
+	PREPARE_WORK(&(_work)->work, (_func))
 
 /*
  * initialize all of a work item in one go
  */
-#define INIT_WORK(_work, _func, _data)				\
+#define INIT_WORK(_work, _func)					\
 	do {							\
-		INIT_LIST_HEAD(&(_work)->entry);		\
 		(_work)->management = 0;			\
-		PREPARE_WORK((_work), (_func), (_data));	\
+		INIT_LIST_HEAD(&(_work)->entry);		\
+		PREPARE_WORK((_work), (_func));			\
+	} while (0)
+
+#define INIT_WORK_NAR(_work, _func)					\
+	do {								\
+		(_work)->management = (1 << WORK_STRUCT_NOAUTOREL);	\
+		INIT_LIST_HEAD(&(_work)->entry);			\
+		PREPARE_WORK((_work), (_func));				\
+	} while (0)
+
+#define INIT_DELAYED_WORK(_work, _func)				\
+	do {							\
+		INIT_WORK(&(_work)->work, (_func));		\
+		init_timer(&(_work)->timer);			\
 	} while (0)
 
-#define INIT_DELAYED_WORK(_work, _func, _data)		\
+#define INIT_DELAYED_WORK_NAR(_work, _func)			\
 	do {							\
-		INIT_WORK(&(_work)->work, (_func), (_data));	\
+		INIT_WORK_NAR(&(_work)->work, (_func));		\
 		init_timer(&(_work)->timer);			\
 	} while (0)
 
@@ -94,6 +124,27 @@ #define work_pending(work) \
 #define delayed_work_pending(work) \
 	test_bit(WORK_STRUCT_PENDING, &(work)->work.management)
 
+/**
+ * work_release - Release a work item under execution
+ * @work: The work item to release
+ *
+ * This is used to release a work item that has been initialised with automatic
+ * release mode disabled (WORK_STRUCT_NOAUTOREL is set).  This gives the work
+ * function the opportunity to grab auxiliary data from the container of the
+ * work_struct before clearing the pending bit as the work_struct may be
+ * subject to deallocation the moment the pending bit is cleared.
+ *
+ * In such a case, this should be called in the work function after it has
+ * fetched any data it may require from the containter of the work_struct.
+ * After this function has been called, the work_struct may be scheduled for
+ * further execution or it may be deallocated unless other precautions are
+ * taken.
+ *
+ * This should also be used to release a delayed work item.
+ */
+#define work_release(work) \
+	clear_bit(WORK_STRUCT_PENDING, &(work)->management)
+
 
 extern struct workqueue_struct *__create_workqueue(const char *name,
 						    int singlethread);
@@ -112,7 +163,7 @@ extern int FASTCALL(schedule_work(struct
 extern int FASTCALL(schedule_delayed_work(struct delayed_work *work, unsigned long delay));
 
 extern int schedule_delayed_work_on(int cpu, struct delayed_work *work, unsigned long delay);
-extern int schedule_on_each_cpu(work_func_t func, void *info);
+extern int schedule_on_each_cpu(work_func_t func);
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
 extern int keventd_up(void);
@@ -121,7 +172,7 @@ extern void init_workqueues(void);
 void cancel_rearming_delayed_work(struct delayed_work *work);
 void cancel_rearming_delayed_workqueue(struct workqueue_struct *,
 				       struct delayed_work *);
-int execute_in_process_context(work_func_t fn, void *, struct execute_work *);
+int execute_in_process_context(work_func_t fn, struct execute_work *);
 
 /*
  * Kill off a pending schedule_delayed_work().  Note that the work callback
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 5f48748..f7be1ac 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -84,7 +84,7 @@ struct inet_timewait_death_row {
 };
 
 extern void inet_twdr_hangman(unsigned long data);
-extern void inet_twdr_twkill_work(void *data);
+extern void inet_twdr_twkill_work(struct work_struct *work);
 extern void inet_twdr_twcal_tick(unsigned long data);
 
 #if (BITS_PER_LONG == 64)
diff --git a/ipc/util.c b/ipc/util.c
index cd8bb14..a9b7a22 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -514,6 +514,11 @@ void ipc_rcu_getref(void *ptr)
 	container_of(ptr, struct ipc_rcu_hdr, data)->refcount++;
 }
 
+static void ipc_do_vfree(struct work_struct *work)
+{
+	vfree(container_of(work, struct ipc_rcu_sched, work));
+}
+
 /**
  * ipc_schedule_free - free ipc + rcu space
  * @head: RCU callback structure for queued work
@@ -528,7 +533,7 @@ static void ipc_schedule_free(struct rcu
 	struct ipc_rcu_sched *sched =
 			container_of(&(grace->data[0]), struct ipc_rcu_sched, data[0]);
 
-	INIT_WORK(&sched->work, vfree, sched);
+	INIT_WORK(&sched->work, ipc_do_vfree);
 	schedule_work(&sched->work);
 }
 
diff --git a/kernel/kmod.c b/kernel/kmod.c
index bb4e29d..7dc7a9d 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -114,6 +114,7 @@ EXPORT_SYMBOL(request_module);
 #endif /* CONFIG_KMOD */
 
 struct subprocess_info {
+	struct work_struct work;
 	struct completion *complete;
 	char *path;
 	char **argv;
@@ -221,9 +222,10 @@ static int wait_for_helper(void *data)
 }
 
 /* This is run by khelper thread  */
-static void __call_usermodehelper(void *data)
+static void __call_usermodehelper(struct work_struct *work)
 {
-	struct subprocess_info *sub_info = data;
+	struct subprocess_info *sub_info =
+		container_of(work, struct subprocess_info, work);
 	pid_t pid;
 	int wait = sub_info->wait;
 
@@ -264,6 +266,8 @@ int call_usermodehelper_keys(char *path,
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	struct subprocess_info sub_info = {
+		.work		= __WORK_INITIALIZER(sub_info.work,
+						     __call_usermodehelper),
 		.complete	= &done,
 		.path		= path,
 		.argv		= argv,
@@ -272,7 +276,6 @@ int call_usermodehelper_keys(char *path,
 		.wait		= wait,
 		.retval		= 0,
 	};
-	DECLARE_WORK(work, __call_usermodehelper, &sub_info);
 
 	if (!khelper_wq)
 		return -EBUSY;
@@ -280,7 +283,7 @@ int call_usermodehelper_keys(char *path,
 	if (path[0] == '\0')
 		return 0;
 
-	queue_work(khelper_wq, &work);
+	queue_work(khelper_wq, &sub_info.work);
 	wait_for_completion(&done);
 	return sub_info.retval;
 }
@@ -291,6 +294,8 @@ int call_usermodehelper_pipe(char *path,
 {
 	DECLARE_COMPLETION(done);
 	struct subprocess_info sub_info = {
+		.work		= __WORK_INITIALIZER(sub_info.work,
+						     __call_usermodehelper),
 		.complete	= &done,
 		.path		= path,
 		.argv		= argv,
@@ -298,7 +303,6 @@ int call_usermodehelper_pipe(char *path,
 		.retval		= 0,
 	};
 	struct file *f;
-	DECLARE_WORK(work, __call_usermodehelper, &sub_info);
 
 	if (!khelper_wq)
 		return -EBUSY;
@@ -318,7 +322,7 @@ int call_usermodehelper_pipe(char *path,
 	}
 	sub_info.stdin = f;
 
-	queue_work(khelper_wq, &work);
+	queue_work(khelper_wq, &sub_info.work);
 	wait_for_completion(&done);
 	return sub_info.retval;
 }
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 4f9c60e..1db8c72 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -31,6 +31,8 @@ struct kthread_create_info
 	/* Result passed back to kthread_create() from keventd. */
 	struct task_struct *result;
 	struct completion done;
+
+	struct work_struct work;
 };
 
 struct kthread_stop_info
@@ -111,9 +113,10 @@ static int kthread(void *_create)
 }
 
 /* We are keventd: create a thread. */
-static void keventd_create_kthread(void *_create)
+static void keventd_create_kthread(struct work_struct *work)
 {
-	struct kthread_create_info *create = _create;
+	struct kthread_create_info *create =
+		container_of(work, struct kthread_create_info, work);
 	int pid;
 
 	/* We want our own signal handler (we take no signals by default). */
@@ -154,20 +157,20 @@ struct task_struct *kthread_create(int (
 				   ...)
 {
 	struct kthread_create_info create;
-	DECLARE_WORK(work, keventd_create_kthread, &create);
 
 	create.threadfn = threadfn;
 	create.data = data;
 	init_completion(&create.started);
 	init_completion(&create.done);
+	INIT_WORK(&create.work, keventd_create_kthread);
 
 	/*
 	 * The workqueue needs to start up first:
 	 */
 	if (!helper_wq)
-		work.func(work.data);
+		create.work.func(&create.work);
 	else {
-		queue_work(helper_wq, &work);
+		queue_work(helper_wq, &create.work);
 		wait_for_completion(&create.done);
 	}
 	if (!IS_ERR(create.result)) {
diff --git a/kernel/power/poweroff.c b/kernel/power/poweroff.c
index f1f900a..678ec73 100644
--- a/kernel/power/poweroff.c
+++ b/kernel/power/poweroff.c
@@ -16,12 +16,12 @@ #include <linux/reboot.h>
  * callback we use.
  */
 
-static void do_poweroff(void *dummy)
+static void do_poweroff(struct work_struct *dummy)
 {
 	kernel_power_off();
 }
 
-static DECLARE_WORK(poweroff_work, do_poweroff, NULL);
+static DECLARE_WORK(poweroff_work, do_poweroff);
 
 static void handle_poweroff(int key, struct tty_struct *tty)
 {
diff --git a/kernel/sys.c b/kernel/sys.c
index 98489d8..c87b461 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -880,7 +880,7 @@ #endif
 	return 0;
 }
 
-static void deferred_cad(void *dummy)
+static void deferred_cad(struct work_struct *dummy)
 {
 	kernel_restart(NULL);
 }
@@ -892,7 +892,7 @@ static void deferred_cad(void *dummy)
  */
 void ctrl_alt_del(void)
 {
-	static DECLARE_WORK(cad_work, deferred_cad, NULL);
+	static DECLARE_WORK(cad_work, deferred_cad);
 
 	if (C_A_D)
 		schedule_work(&cad_work);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9674797..8d1e7cb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -241,14 +241,14 @@ static void run_workqueue(struct cpu_wor
 		struct work_struct *work = list_entry(cwq->worklist.next,
 						struct work_struct, entry);
 		work_func_t f = work->func;
-		void *data = work->data;
 
 		list_del_init(cwq->worklist.next);
 		spin_unlock_irqrestore(&cwq->lock, flags);
 
 		BUG_ON(get_wq_data(work) != cwq);
-		clear_bit(WORK_STRUCT_PENDING, &work->management);
-		f(data);
+		if (!test_bit(WORK_STRUCT_NOAUTOREL, &work->management))
+			work_release(work);
+		f(work);
 
 		spin_lock_irqsave(&cwq->lock, flags);
 		cwq->remove_sequence++;
@@ -527,7 +527,6 @@ EXPORT_SYMBOL(schedule_delayed_work_on);
 /**
  * schedule_on_each_cpu - call a function on each online CPU from keventd
  * @func: the function to call
- * @info: a pointer to pass to func()
  *
  * Returns zero on success.
  * Returns -ve errno on failure.
@@ -536,7 +535,7 @@ EXPORT_SYMBOL(schedule_delayed_work_on);
  *
  * schedule_on_each_cpu() is very slow.
  */
-int schedule_on_each_cpu(work_func_t func, void *info)
+int schedule_on_each_cpu(work_func_t func)
 {
 	int cpu;
 	struct work_struct *works;
@@ -547,7 +546,7 @@ int schedule_on_each_cpu(work_func_t fun
 
 	mutex_lock(&workqueue_mutex);
 	for_each_online_cpu(cpu) {
-		INIT_WORK(per_cpu_ptr(works, cpu), func, info);
+		INIT_WORK(per_cpu_ptr(works, cpu), func);
 		__queue_work(per_cpu_ptr(keventd_wq->cpu_wq, cpu),
 				per_cpu_ptr(works, cpu));
 	}
@@ -591,7 +590,6 @@ EXPORT_SYMBOL(cancel_rearming_delayed_wo
 /**
  * execute_in_process_context - reliably execute the routine with user context
  * @fn:		the function to execute
- * @data:	data to pass to the function
  * @ew:		guaranteed storage for the execute work structure (must
  *		be available when the work executes)
  *
@@ -601,15 +599,14 @@ EXPORT_SYMBOL(cancel_rearming_delayed_wo
  * Returns:	0 - function was executed
  *		1 - function was scheduled for execution
  */
-int execute_in_process_context(work_func_t fn, void *data,
-			       struct execute_work *ew)
+int execute_in_process_context(work_func_t fn, struct execute_work *ew)
 {
 	if (!in_interrupt()) {
-		fn(data);
+		fn(&ew->work);
 		return 0;
 	}
 
-	INIT_WORK(&ew->work, fn, data);
+	INIT_WORK(&ew->work, fn);
 	schedule_work(&ew->work);
 
 	return 1;
diff --git a/mm/slab.c b/mm/slab.c
index a65bc5e..5de8147 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -313,7 +313,7 @@ static int drain_freelist(struct kmem_ca
 static void free_block(struct kmem_cache *cachep, void **objpp, int len,
 			int node);
 static int enable_cpucache(struct kmem_cache *cachep);
-static void cache_reap(void *unused);
+static void cache_reap(struct work_struct *unused);
 
 /*
  * This function must be completely optimized away if a constant is passed to
@@ -925,7 +925,7 @@ static void __devinit start_cpu_timer(in
 	 */
 	if (keventd_up() && reap_work->work.func == NULL) {
 		init_reap_node(cpu);
-		INIT_DELAYED_WORK(reap_work, cache_reap, NULL);
+		INIT_DELAYED_WORK(reap_work, cache_reap);
 		schedule_delayed_work_on(cpu, reap_work, HZ + 3 * cpu);
 	}
 }
@@ -3815,7 +3815,7 @@ void drain_array(struct kmem_cache *cach
  * If we cannot acquire the cache chain mutex then just give up - we'll try
  * again on the next iteration.
  */
-static void cache_reap(void *unused)
+static void cache_reap(struct work_struct *unused)
 {
 	struct kmem_cache *searchp;
 	struct kmem_list3 *l3;
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index f2ed09e..549a2ce 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -34,8 +34,8 @@ enum lw_bits {
 static unsigned long linkwatch_flags;
 static unsigned long linkwatch_nextevent;
 
-static void linkwatch_event(void *dummy);
-static DECLARE_DELAYED_WORK(linkwatch_work, linkwatch_event, NULL);
+static void linkwatch_event(struct work_struct *dummy);
+static DECLARE_DELAYED_WORK(linkwatch_work, linkwatch_event);
 
 static LIST_HEAD(lweventlist);
 static DEFINE_SPINLOCK(lweventlist_lock);
@@ -127,7 +127,7 @@ void linkwatch_run_queue(void)
 }       
 
 
-static void linkwatch_event(void *dummy)
+static void linkwatch_event(struct work_struct *dummy)
 {
 	/* Limit the number of linkwatch events to one
 	 * per second so that a runaway driver does not
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index cdd8053..8c74f91 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -197,9 +197,10 @@ EXPORT_SYMBOL_GPL(inet_twdr_hangman);
 
 extern void twkill_slots_invalid(void);
 
-void inet_twdr_twkill_work(void *data)
+void inet_twdr_twkill_work(struct work_struct *work)
 {
-	struct inet_timewait_death_row *twdr = data;
+	struct inet_timewait_death_row *twdr =
+		container_of(work, struct inet_timewait_death_row, twkill_work);
 	int i;
 
 	if ((INET_TWDR_TWKILL_SLOTS - 1) > (sizeof(twdr->thread_slots) * 8))
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 0163d98..af7b2c9 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -45,8 +45,7 @@ struct inet_timewait_death_row tcp_death
 	.tw_timer	= TIMER_INITIALIZER(inet_twdr_hangman, 0,
 					    (unsigned long)&tcp_death_row),
 	.twkill_work	= __WORK_INITIALIZER(tcp_death_row.twkill_work,
-					     inet_twdr_twkill_work,
-					     &tcp_death_row),
+					     inet_twdr_twkill_work),
 /* Short-time timewait calendar */
 
 	.twcal_hand	= -1,
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index d5725cb..d96fd46 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -284,8 +284,8 @@ static struct file_operations cache_file
 static struct file_operations content_file_operations;
 static struct file_operations cache_flush_operations;
 
-static void do_cache_clean(void *data);
-static DECLARE_DELAYED_WORK(cache_cleaner, do_cache_clean, NULL);
+static void do_cache_clean(struct work_struct *work);
+static DECLARE_DELAYED_WORK(cache_cleaner, do_cache_clean);
 
 void cache_register(struct cache_detail *cd)
 {
@@ -461,7 +461,7 @@ static int cache_clean(void)
 /*
  * We want to regularly clean the cache, so we need to schedule some work ...
  */
-static void do_cache_clean(void *data)
+static void do_cache_clean(struct work_struct *work)
 {
 	int delay = 5;
 	if (cache_clean() == -1)
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 97be3f7..49dba5f 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -54,10 +54,11 @@ static void rpc_purge_list(struct rpc_in
 }
 
 static void
-rpc_timeout_upcall_queue(void *data)
+rpc_timeout_upcall_queue(struct work_struct *work)
 {
 	LIST_HEAD(free_list);
-	struct rpc_inode *rpci = (struct rpc_inode *)data;
+	struct rpc_inode *rpci =
+		container_of(work, struct rpc_inode, queue_timeout.work);
 	struct inode *inode = &rpci->vfs_inode;
 	void (*destroy_msg)(struct rpc_pipe_msg *);
 
@@ -838,7 +839,7 @@ init_once(void * foo, kmem_cache_t * cac
 		rpci->pipelen = 0;
 		init_waitqueue_head(&rpci->waitq);
 		INIT_DELAYED_WORK(&rpci->queue_timeout,
-				    rpc_timeout_upcall_queue, rpci);
+				    rpc_timeout_upcall_queue);
 		rpci->ops = NULL;
 	}
 }
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index a1ab4ee..eff44bc 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -41,7 +41,7 @@ static mempool_t	*rpc_buffer_mempool __r
 
 static void			__rpc_default_timer(struct rpc_task *task);
 static void			rpciod_killall(void);
-static void			rpc_async_schedule(void *);
+static void			rpc_async_schedule(struct work_struct *);
 
 /*
  * RPC tasks sit here while waiting for conditions to improve.
@@ -305,7 +305,7 @@ static void rpc_make_runnable(struct rpc
 	if (RPC_IS_ASYNC(task)) {
 		int status;
 
-		INIT_WORK(&task->u.tk_work, rpc_async_schedule, (void *)task);
+		INIT_WORK(&task->u.tk_work, rpc_async_schedule);
 		status = queue_work(task->tk_workqueue, &task->u.tk_work);
 		if (status < 0) {
 			printk(KERN_WARNING "RPC: failed to add task to queue: error: %d!\n", status);
@@ -695,9 +695,9 @@ rpc_execute(struct rpc_task *task)
 	return __rpc_execute(task);
 }
 
-static void rpc_async_schedule(void *arg)
+static void rpc_async_schedule(struct work_struct *work)
 {
-	__rpc_execute((struct rpc_task *)arg);
+	__rpc_execute(container_of(work, struct rpc_task, u.tk_work));
 }
 
 /**
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 8085747..4f9a5d9 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -479,9 +479,10 @@ int xprt_adjust_timeout(struct rpc_rqst 
 	return status;
 }
 
-static void xprt_autoclose(void *args)
+static void xprt_autoclose(struct work_struct *work)
 {
-	struct rpc_xprt *xprt = (struct rpc_xprt *)args;
+	struct rpc_xprt *xprt =
+		container_of(work, struct rpc_xprt, task_cleanup);
 
 	xprt_disconnect(xprt);
 	xprt->ops->close(xprt);
@@ -932,7 +933,7 @@ struct rpc_xprt *xprt_create_transport(i
 
 	INIT_LIST_HEAD(&xprt->free);
 	INIT_LIST_HEAD(&xprt->recv);
-	INIT_WORK(&xprt->task_cleanup, xprt_autoclose, xprt);
+	INIT_WORK(&xprt->task_cleanup, xprt_autoclose);
 	init_timer(&xprt->timer);
 	xprt->timer.function = xprt_init_autodisconnect;
 	xprt->timer.data = (unsigned long) xprt;
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 3c7532c..cfe3c15 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1060,13 +1060,14 @@ static int xs_bindresvport(struct rpc_xp
 
 /**
  * xs_udp_connect_worker - set up a UDP socket
- * @args: RPC transport to connect
+ * @work: RPC transport to connect
  *
  * Invoked by a work queue tasklet.
  */
-static void xs_udp_connect_worker(void *args)
+static void xs_udp_connect_worker(struct work_struct *work)
 {
-	struct rpc_xprt *xprt = (struct rpc_xprt *) args;
+	struct rpc_xprt *xprt =
+		container_of(work, struct rpc_xprt, connect_worker.work);
 	struct socket *sock = xprt->sock;
 	int err, status = -EIO;
 
@@ -1144,13 +1145,14 @@ static void xs_tcp_reuse_connection(stru
 
 /**
  * xs_tcp_connect_worker - connect a TCP socket to a remote endpoint
- * @args: RPC transport to connect
+ * @work: RPC transport to connect
  *
  * Invoked by a work queue tasklet.
  */
-static void xs_tcp_connect_worker(void *args)
+static void xs_tcp_connect_worker(struct work_struct *work)
 {
-	struct rpc_xprt *xprt = (struct rpc_xprt *)args;
+	struct rpc_xprt *xprt =
+		container_of(work, struct rpc_xprt, connect_worker.work);
 	struct socket *sock = xprt->sock;
 	int err, status = -EIO;
 
@@ -1375,7 +1377,7 @@ int xs_setup_udp(struct rpc_xprt *xprt, 
 	/* XXX: header size can vary due to auth type, IPv6, etc. */
 	xprt->max_payload = (1U << 16) - (MAX_HEADER << 3);
 
-	INIT_DELAYED_WORK(&xprt->connect_worker, xs_udp_connect_worker, xprt);
+	INIT_DELAYED_WORK(&xprt->connect_worker, xs_udp_connect_worker);
 	xprt->bind_timeout = XS_BIND_TO;
 	xprt->connect_timeout = XS_UDP_CONN_TO;
 	xprt->reestablish_timeout = XS_UDP_REEST_TO;
@@ -1420,7 +1422,7 @@ int xs_setup_tcp(struct rpc_xprt *xprt, 
 	xprt->tsh_size = sizeof(rpc_fraghdr) / sizeof(u32);
 	xprt->max_payload = RPC_MAX_FRAGMENT_SIZE;
 
-	INIT_DELAYED_WORK(&xprt->connect_worker, xs_tcp_connect_worker, xprt);
+	INIT_DELAYED_WORK(&xprt->connect_worker, xs_tcp_connect_worker);
 	xprt->bind_timeout = XS_BIND_TO;
 	xprt->connect_timeout = XS_TCP_CONN_TO;
 	xprt->reestablish_timeout = XS_TCP_INIT_REEST_TO;
diff --git a/security/keys/key.c b/security/keys/key.c
index 80de8c3..70eacbe 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -30,8 +30,8 @@ DEFINE_SPINLOCK(key_user_lock);
 static LIST_HEAD(key_types_list);
 static DECLARE_RWSEM(key_types_sem);
 
-static void key_cleanup(void *data);
-static DECLARE_WORK(key_cleanup_task, key_cleanup, NULL);
+static void key_cleanup(struct work_struct *work);
+static DECLARE_WORK(key_cleanup_task, key_cleanup);
 
 /* we serialise key instantiation and link */
 DECLARE_RWSEM(key_construction_sem);
@@ -552,7 +552,7 @@ EXPORT_SYMBOL(key_negate_and_link);
  * do cleaning up in process context so that we don't have to disable
  * interrupts all over the place
  */
-static void key_cleanup(void *data)
+static void key_cleanup(struct work_struct *work)
 {
 	struct rb_node *_n;
 	struct key *key;
