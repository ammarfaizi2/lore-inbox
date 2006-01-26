Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWAZDwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWAZDwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWAZDtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:49:43 -0500
Received: from [202.53.187.9] ([202.53.187.9]:15851 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932219AbWAZDtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:49:18 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 01/23] [Suspend2] Make workqueues freezeable.
Date: Thu, 26 Jan 2006 13:45:29 +1000
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060126034527.3178.99591.stgit@localhost.localdomain>
In-Reply-To: <20060126034518.3178.55397.stgit@localhost.localdomain>
References: <20060126034518.3178.55397.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Prior to this patch, kernel threads and workqueues are unconditionally
unfreezeable. This patch reverses that behaviour, making the default
for kernel processes to be frozen. New variations of the routines for
starting kernel threads and workqueues (containing _nofreeze_) allow
threads that need to run during suspend to be made nofreeze again.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 block/ll_rw_blk.c             |    2 -
 drivers/acpi/osl.c            |    2 -
 drivers/char/hvc_console.c    |    2 -
 drivers/char/hvcs.c           |    2 -
 drivers/input/serio/serio.c   |    2 -
 drivers/md/dm-crypt.c         |    2 -
 drivers/scsi/hosts.c          |    2 -
 drivers/scsi/lpfc/lpfc_init.c |    2 -
 drivers/usb/net/pegasus.c     |    2 -
 include/linux/kthread.h       |   27 ++++++++----
 include/linux/workqueue.h     |    9 +++-
 kernel/audit.c                |    3 +
 kernel/kthread.c              |   94 ++++++++++++++++++++++++++++++++++++++---
 kernel/sched.c                |    1 
 kernel/softirq.c              |    3 -
 kernel/workqueue.c            |   37 +++++++++++-----
 16 files changed, 149 insertions(+), 43 deletions(-)

diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
index 8e27d0a..e6c2c5d 100644
--- a/block/ll_rw_blk.c
+++ b/block/ll_rw_blk.c
@@ -3435,7 +3435,7 @@ int __init blk_dev_init(void)
 {
 	int i;
 
-	kblockd_workqueue = create_workqueue("kblockd");
+	kblockd_workqueue = create_nofreeze_workqueue("kblockd");
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 20c9a37..1b3ee90 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -91,7 +91,7 @@ acpi_status acpi_os_initialize1(void)
 		       "Access to PCI configuration space unavailable\n");
 		return AE_NULL_ENTRY;
 	}
-	kacpid_wq = create_singlethread_workqueue("kacpid");
+	kacpid_wq = create_nofreeze_singlethread_workqueue("kacpid");
 	BUG_ON(!kacpid_wq);
 
 	return AE_OK;
diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index 1994a92..44b5cff 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -839,7 +839,7 @@ int __init hvc_init(void)
 
 	/* Always start the kthread because there can be hotplug vty adapters
 	 * added later. */
-	hvc_task = kthread_run(khvcd, NULL, "khvcd");
+	hvc_task = kthread_nofreeze_run(khvcd, NULL, "khvcd");
 	if (IS_ERR(hvc_task)) {
 		panic("Couldn't create kthread for console.\n");
 		put_tty_driver(hvc_driver);
diff --git a/drivers/char/hvcs.c b/drivers/char/hvcs.c
index 831eb4e..4302c36 100644
--- a/drivers/char/hvcs.c
+++ b/drivers/char/hvcs.c
@@ -1404,7 +1404,7 @@ static int __init hvcs_module_init(void)
 		return -ENOMEM;
 	}
 
-	hvcs_task = kthread_run(khvcsd, NULL, "khvcsd");
+	hvcs_task = kthread_nofreeze_run(khvcsd, NULL, "khvcsd");
 	if (IS_ERR(hvcs_task)) {
 		printk(KERN_ERR "HVCS: khvcsd creation failed.  Driver not loaded.\n");
 		kfree(hvcs_pi_buff);
diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 2f76813..edd7254 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -901,7 +901,7 @@ irqreturn_t serio_interrupt(struct serio
 
 static int __init serio_init(void)
 {
-	serio_task = kthread_run(serio_thread, NULL, "kseriod");
+	serio_task = kthread_nofreeze_run(serio_thread, NULL, "kseriod");
 	if (IS_ERR(serio_task)) {
 		printk(KERN_ERR "serio: Failed to start kseriod\n");
 		return PTR_ERR(serio_task);
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index e7a650f..634c82b 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -928,7 +928,7 @@ static int __init dm_crypt_init(void)
 	if (!_crypt_io_pool)
 		return -ENOMEM;
 
-	_kcryptd_workqueue = create_workqueue("kcryptd");
+	_kcryptd_workqueue = create_nofreeze_workqueue("kcryptd");
 	if (!_kcryptd_workqueue) {
 		r = -ENOMEM;
 		DMERR(PFX "couldn't create kcryptd");
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 5881079..2f245f0 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -227,7 +227,7 @@ int scsi_add_host(struct Scsi_Host *shos
 	if (shost->transportt->create_work_queue) {
 		snprintf(shost->work_q_name, KOBJ_NAME_LEN, "scsi_wq_%d",
 			shost->host_no);
-		shost->work_q = create_singlethread_workqueue(
+		shost->work_q = create_nofreeze_singlethread_workqueue(
 					shost->work_q_name);
 		if (!shost->work_q)
 			goto out_free_shost_data;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index b7a603a..02734fc 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -1521,7 +1521,7 @@ lpfc_pci_probe_one(struct pci_dev *pdev,
 	phba->work_ha_mask |= (HA_RXMASK << (LPFC_ELS_RING * 4));
 
 	/* Startup the kernel thread for this host adapter. */
-	phba->worker_thread = kthread_run(lpfc_do_work, phba,
+	phba->worker_thread = kthread_nofreeze_run(lpfc_do_work, phba,
 				       "lpfc_worker_%d", phba->brd_no);
 	if (IS_ERR(phba->worker_thread)) {
 		error = PTR_ERR(phba->worker_thread);
diff --git a/drivers/usb/net/pegasus.c b/drivers/usb/net/pegasus.c
index 156a2f1..d6a1474 100644
--- a/drivers/usb/net/pegasus.c
+++ b/drivers/usb/net/pegasus.c
@@ -1451,7 +1451,7 @@ static int __init pegasus_init(void)
 	pr_info("%s: %s, " DRIVER_DESC "\n", driver_name, DRIVER_VERSION);
 	if (devid)
 		parse_id(devid);
-	pegasus_workqueue = create_singlethread_workqueue("pegasus");
+	pegasus_workqueue = create_nofreeze_singlethread_workqueue("pegasus");
 	if (!pegasus_workqueue)
 		return -ENOMEM;
 	return usb_register(&pegasus_driver);
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index ebdd41f..965e836 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -23,10 +23,20 @@
  *
  * Returns a task_struct or ERR_PTR(-ENOMEM).
  */
+struct task_struct *__kthread_create(int (*threadfn)(void *data),
+				   void *data,
+				   unsigned long freezer_flags,
+				   const char namefmt[],
+				   va_list * args);
+
 struct task_struct *kthread_create(int (*threadfn)(void *data),
 				   void *data,
 				   const char namefmt[], ...);
 
+struct task_struct *kthread_nofreeze_create(int (*threadfn)(void *data),
+				   void *data,
+				   const char namefmt[], ...);
+
 /**
  * kthread_run: create and wake a thread.
  * @threadfn: the function to run until signal_pending(current).
@@ -35,14 +45,15 @@ struct task_struct *kthread_create(int (
  *
  * Description: Convenient wrapper for kthread_create() followed by
  * wake_up_process().  Returns the kthread, or ERR_PTR(-ENOMEM). */
-#define kthread_run(threadfn, data, namefmt, ...)			   \
-({									   \
-	struct task_struct *__k						   \
-		= kthread_create(threadfn, data, namefmt, ## __VA_ARGS__); \
-	if (!IS_ERR(__k))						   \
-		wake_up_process(__k);					   \
-	__k;								   \
-})
+
+extern struct task_struct * kthread_run(int (*threadfn)(void *data),
+					void *data,
+					const char namefmt[], ...);
+
+extern struct task_struct * kthread_nofreeze_run(int (*threadfn)(void *data),
+					void *data,
+					const char namefmt[], ...);
+
 
 /**
  * kthread_bind: bind a just-created kthread to a cpu.
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 86b1113..fb1b51e 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -51,9 +51,12 @@ struct work_struct {
 	} while (0)
 
 extern struct workqueue_struct *__create_workqueue(const char *name,
-						    int singlethread);
-#define create_workqueue(name) __create_workqueue((name), 0)
-#define create_singlethread_workqueue(name) __create_workqueue((name), 1)
+						    int singlethread,
+						    unsigned long freezer_flag);
+#define create_workqueue(name) __create_workqueue((name), 0, 0)
+#define create_nofreeze_workqueue(name) __create_workqueue((name), 0, PF_NOFREEZE)
+#define create_singlethread_workqueue(name) __create_workqueue((name), 1, 0)
+#define create_nofreeze_singlethread_workqueue(name) __create_workqueue((name), 1, PF_NOFREEZE)
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
diff --git a/kernel/audit.c b/kernel/audit.c
index 0a813d2..0cd1b16 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -288,6 +288,9 @@ static int kauditd_thread(void *dummy)
 			}
 		} else {
 			DECLARE_WAITQUEUE(wait, current);
+			
+			try_to_freeze();
+
 			set_current_state(TASK_INTERRUPTIBLE);
 			add_wait_queue(&kauditd_wait, &wait);
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index e75950a..36f82da 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -25,6 +25,7 @@ struct kthread_create_info
 	/* Information passed to kthread() from keventd. */
 	int (*threadfn)(void *data);
 	void *data;
+	unsigned long freezer_flags;
 	struct completion started;
 
 	/* Result passed back to kthread_create() from keventd. */
@@ -86,6 +87,10 @@ static int kthread(void *_create)
 	/* By default we can run anywhere, unlike keventd. */
 	set_cpus_allowed(current, CPU_MASK_ALL);
 
+	/* Set our freezer flags */
+	current->flags &= ~PF_NOFREEZE;
+	current->flags |= (create->freezer_flags & PF_NOFREEZE);
+
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_INTERRUPTIBLE);
 	complete(&create->started);
@@ -119,16 +124,18 @@ static void keventd_create_kthread(void 
 	complete(&create->done);
 }
 
-struct task_struct *kthread_create(int (*threadfn)(void *data),
+struct task_struct *__kthread_create(int (*threadfn)(void *data),
 				   void *data,
+				   unsigned long freezer_flags,
 				   const char namefmt[],
-				   ...)
+				   va_list * args)
 {
 	struct kthread_create_info create;
 	DECLARE_WORK(work, keventd_create_kthread, &create);
 
 	create.threadfn = threadfn;
 	create.data = data;
+	create.freezer_flags = freezer_flags;
 	init_completion(&create.started);
 	init_completion(&create.done);
 
@@ -141,18 +148,89 @@ struct task_struct *kthread_create(int (
 		queue_work(helper_wq, &work);
 		wait_for_completion(&create.done);
 	}
-	if (!IS_ERR(create.result)) {
-		va_list args;
-		va_start(args, namefmt);
+	if (!IS_ERR(create.result))
 		vsnprintf(create.result->comm, sizeof(create.result->comm),
-			  namefmt, args);
-		va_end(args);
-	}
+			  namefmt, *args);
 
 	return create.result;
 }
+
+struct task_struct *kthread_create(int (*threadfn)(void *data),
+				   void *data,
+				   const char namefmt[], ...)
+{
+	struct task_struct * result;
+
+	va_list args;
+	va_start(args, namefmt);
+	result = __kthread_create(threadfn, data, 0, namefmt, &args);
+	va_end(args);
+	return result;
+}
+
 EXPORT_SYMBOL(kthread_create);
 
+struct task_struct *kthread_nofreeze_create(int (*threadfn)(void *data),
+				   void *data,
+				   const char namefmt[], ...)
+{
+	struct task_struct * result;
+
+	va_list args;
+	va_start(args, namefmt);
+	result = __kthread_create(threadfn, data, PF_NOFREEZE, namefmt, &args);
+	va_end(args);
+	return result;
+}
+
+EXPORT_SYMBOL(kthread_nofreeze_create);
+
+/**
+ * kthread_run: create and wake a thread.
+ * @threadfn: the function to run until signal_pending(current).
+ * @data: data ptr for @threadfn.
+ * @namefmt: printf-style name for the thread.
+ *
+ * Description: Convenient wrapper for kthread_create() followed by
+ * wake_up_process().  Returns the kthread, or ERR_PTR(-ENOMEM).
+ **/
+struct task_struct * kthread_run(int (*threadfn)(void *data),
+		void *data,
+		const char namefmt[], ...)
+{
+	struct task_struct *__k;
+	va_list args;
+
+	va_start(args, namefmt);
+	__k = __kthread_create(threadfn, data, 0, namefmt, &args);
+	va_end(args);
+
+	if(!IS_ERR(__k))
+		wake_up_process(__k);
+
+	return __k;
+}
+
+EXPORT_SYMBOL(kthread_run);
+
+struct task_struct * kthread_nofreeze_run(int (*threadfn)(void *data),
+		void *data,
+		const char namefmt[], ...)
+{
+	struct task_struct *__k;
+	va_list args;
+
+	va_start(args, namefmt);
+	__k = __kthread_create(threadfn, data, PF_NOFREEZE, namefmt, &args);
+	va_end(args);
+
+	if(!IS_ERR(__k))
+		wake_up_process(__k);
+
+	return __k;
+}
+EXPORT_SYMBOL(kthread_nofreeze_run);
+
 void kthread_bind(struct task_struct *k, unsigned int cpu)
 {
 	BUG_ON(k->state != TASK_INTERRUPTIBLE);
diff --git a/kernel/sched.c b/kernel/sched.c
index 3ee2ae4..ad3c9ac 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4805,7 +4805,6 @@ static int migration_call(struct notifie
 		p = kthread_create(migration_thread, hcpu, "migration/%d",cpu);
 		if (IS_ERR(p))
 			return NOTIFY_BAD;
-		p->flags |= PF_NOFREEZE;
 		kthread_bind(p, cpu);
 		/* Must be high prio: stop_machine expects to yield to it. */
 		rq = task_rq_lock(p, &flags);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index ad3295c..25cae0d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -350,7 +350,6 @@ void __init softirq_init(void)
 static int ksoftirqd(void * __bind_cpu)
 {
 	set_user_nice(current, 19);
-	current->flags |= PF_NOFREEZE;
 
 	set_current_state(TASK_INTERRUPTIBLE);
 
@@ -456,7 +455,7 @@ static int __devinit cpu_callback(struct
 	case CPU_UP_PREPARE:
 		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
 		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
-		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
+		p = kthread_nofreeze_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("ksoftirqd for %i failed\n", hotcpu);
 			return NOTIFY_BAD;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b052e2c..124b6b8 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -191,8 +191,6 @@ static int worker_thread(void *__cwq)
 	struct k_sigaction sa;
 	sigset_t blocked;
 
-	current->flags |= PF_NOFREEZE;
-
 	set_user_nice(current, -5);
 
 	/* Block and flush all signals */
@@ -213,6 +211,7 @@ static int worker_thread(void *__cwq)
 			schedule();
 		else
 			__set_current_state(TASK_RUNNING);
+		try_to_freeze();
 		remove_wait_queue(&cwq->more_work, &wait);
 
 		if (!list_empty(&cwq->worklist))
@@ -282,7 +281,8 @@ void fastcall flush_workqueue(struct wor
 }
 
 static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
-						   int cpu)
+						   int cpu,
+						   unsigned long freezer_flags)
 {
 	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
 	struct task_struct *p;
@@ -296,10 +296,21 @@ static struct task_struct *create_workqu
 	init_waitqueue_head(&cwq->more_work);
 	init_waitqueue_head(&cwq->work_done);
 
-	if (is_single_threaded(wq))
-		p = kthread_create(worker_thread, cwq, "%s", wq->name);
-	else
-		p = kthread_create(worker_thread, cwq, "%s/%d", wq->name, cpu);
+	if (is_single_threaded(wq)) {
+		if (freezer_flags)
+			p = kthread_nofreeze_create(worker_thread, cwq,
+					"%s", wq->name);
+		else
+			p = kthread_create(worker_thread, cwq,
+					"%s", wq->name);
+	} else {
+		if (freezer_flags)
+			p = kthread_nofreeze_create(worker_thread, cwq,
+					"%s/%d", wq->name, cpu);
+		else
+			p = kthread_create(worker_thread, cwq,
+					"%s/%d", wq->name, cpu);
+	}
 	if (IS_ERR(p))
 		return NULL;
 	cwq->thread = p;
@@ -307,7 +318,8 @@ static struct task_struct *create_workqu
 }
 
 struct workqueue_struct *__create_workqueue(const char *name,
-					    int singlethread)
+					    int singlethread,
+					    unsigned long freezer_flags)
 {
 	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
@@ -328,7 +340,8 @@ struct workqueue_struct *__create_workqu
 	lock_cpu_hotplug();
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
-		p = create_workqueue_thread(wq, singlethread_cpu);
+		p = create_workqueue_thread(wq, singlethread_cpu,
+				freezer_flags);
 		if (!p)
 			destroy = 1;
 		else
@@ -338,7 +351,7 @@ struct workqueue_struct *__create_workqu
 		list_add(&wq->list, &workqueues);
 		spin_unlock(&workqueue_lock);
 		for_each_online_cpu(cpu) {
-			p = create_workqueue_thread(wq, cpu);
+			p = create_workqueue_thread(wq, cpu, freezer_flags);
 			if (p) {
 				kthread_bind(p, cpu);
 				wake_up_process(p);
@@ -529,7 +542,7 @@ static int __devinit workqueue_cpu_callb
 	case CPU_UP_PREPARE:
 		/* Create a new workqueue thread for it. */
 		list_for_each_entry(wq, &workqueues, list) {
-			if (!create_workqueue_thread(wq, hotcpu)) {
+			if (!create_workqueue_thread(wq, hotcpu, 0)) {
 				printk("workqueue for %i failed\n", hotcpu);
 				return NOTIFY_BAD;
 			}
@@ -572,7 +585,7 @@ void init_workqueues(void)
 {
 	singlethread_cpu = first_cpu(cpu_possible_map);
 	hotcpu_notifier(workqueue_cpu_callback, 0);
-	keventd_wq = create_workqueue("events");
+	keventd_wq = create_nofreeze_workqueue("events");
 	BUG_ON(!keventd_wq);
 }
 

--
Nigel Cunningham		nigel at suspend2 dot net
