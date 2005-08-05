Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262999AbVHEMMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbVHEMMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 08:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbVHEMMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 08:12:51 -0400
Received: from [203.171.93.254] ([203.171.93.254]:12960 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262999AbVHEMMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 08:12:48 -0400
Subject: Re: [linux-pm] [PATCH] Workqueue freezer support.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0507211221550.12779-100000@monsoon.he.net>
References: <1121923059.2936.224.camel@localhost>
	 <Pine.LNX.4.50.0507211221550.12779-100000@monsoon.he.net>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1123243967.3266.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 05 Aug 2005 22:12:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I finally found some time to finish this off. I don't really like the
end result - the macros looked clearer to me - but here goes. If it
looks okay, I'll seek sign offs from each of the affected driver
maintainers and from Ingo. Anyone else?

Regards,

Nigel

 drivers/acpi/osl.c          |    2 
 drivers/block/ll_rw_blk.c   |    2 
 drivers/char/hvc_console.c  |    2 
 drivers/char/hvcs.c         |    2 
 drivers/input/serio/serio.c |    2 
 drivers/md/dm-crypt.c       |    2 
 drivers/scsi/hosts.c        |    2 
 drivers/usb/net/pegasus.c   |    2 
 include/linux/kthread.h     |   27 ++++++++----
 include/linux/workqueue.h   |    9 ++--
 kernel/kthread.c            |   94 ++++++++++++++++++++++++++++++++++++++++----
 kernel/sched.c              |    1 
 kernel/softirq.c            |    3 -
 kernel/workqueue.c          |   36 +++++++++++-----
 14 files changed, 144 insertions(+), 42 deletions(-)
diff -ruNp 400-workthreads.patch-old/drivers/acpi/osl.c 400-workthreads.patch-new/drivers/acpi/osl.c
--- 400-workthreads.patch-old/drivers/acpi/osl.c	2005-08-02 22:30:57.000000000 +1000
+++ 400-workthreads.patch-new/drivers/acpi/osl.c	2005-08-02 22:33:49.000000000 +1000
@@ -98,7 +98,7 @@ acpi_os_initialize1(void)
 		return AE_NULL_ENTRY;
 	}
 #endif
-	kacpid_wq = create_singlethread_workqueue("kacpid");
+	kacpid_wq = create_nofreeze_singlethread_workqueue("kacpid");
 	BUG_ON(!kacpid_wq);
 
 	return AE_OK;
diff -ruNp 400-workthreads.patch-old/drivers/block/ll_rw_blk.c 400-workthreads.patch-new/drivers/block/ll_rw_blk.c
--- 400-workthreads.patch-old/drivers/block/ll_rw_blk.c	2005-08-02 22:30:57.000000000 +1000
+++ 400-workthreads.patch-new/drivers/block/ll_rw_blk.c	2005-08-02 22:33:49.000000000 +1000
@@ -3215,7 +3215,7 @@ EXPORT_SYMBOL(kblockd_flush);
 
 int __init blk_dev_init(void)
 {
-	kblockd_workqueue = create_workqueue("kblockd");
+	kblockd_workqueue = create_nofreeze_workqueue("kblockd");
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
 
diff -ruNp 400-workthreads.patch-old/drivers/char/hvc_console.c 400-workthreads.patch-new/drivers/char/hvc_console.c
--- 400-workthreads.patch-old/drivers/char/hvc_console.c	2005-08-02 22:30:58.000000000 +1000
+++ 400-workthreads.patch-new/drivers/char/hvc_console.c	2005-08-02 22:33:49.000000000 +1000
@@ -844,7 +844,7 @@ int __init hvc_init(void)
 
 	/* Always start the kthread because there can be hotplug vty adapters
 	 * added later. */
-	hvc_task = kthread_run(khvcd, NULL, "khvcd");
+	hvc_task = kthread_nofreeze_run(khvcd, NULL, "khvcd");
 	if (IS_ERR(hvc_task)) {
 		panic("Couldn't create kthread for console.\n");
 		put_tty_driver(hvc_driver);
diff -ruNp 400-workthreads.patch-old/drivers/char/hvcs.c 400-workthreads.patch-new/drivers/char/hvcs.c
--- 400-workthreads.patch-old/drivers/char/hvcs.c	2005-08-02 22:30:58.000000000 +1000
+++ 400-workthreads.patch-new/drivers/char/hvcs.c	2005-08-02 22:33:49.000000000 +1000
@@ -1403,7 +1403,7 @@ static int __init hvcs_module_init(void)
 		return -ENOMEM;
 	}
 
-	hvcs_task = kthread_run(khvcsd, NULL, "khvcsd");
+	hvcs_task = kthread_nofreeze_run(khvcsd, NULL, "khvcsd");
 	if (IS_ERR(hvcs_task)) {
 		printk(KERN_ERR "HVCS: khvcsd creation failed.  Driver not loaded.\n");
 		kfree(hvcs_pi_buff);
diff -ruNp 400-workthreads.patch-old/drivers/input/serio/serio.c 400-workthreads.patch-new/drivers/input/serio/serio.c
--- 400-workthreads.patch-old/drivers/input/serio/serio.c	2005-08-04 11:48:01.000000000 +1000
+++ 400-workthreads.patch-new/drivers/input/serio/serio.c	2005-08-02 22:33:49.000000000 +1000
@@ -899,7 +899,7 @@ irqreturn_t serio_interrupt(struct serio
 
 static int __init serio_init(void)
 {
-	serio_task = kthread_run(serio_thread, NULL, "kseriod");
+	serio_task = kthread_nofreeze_run(serio_thread, NULL, "kseriod");
 	if (IS_ERR(serio_task)) {
 		printk(KERN_ERR "serio: Failed to start kseriod\n");
 		return PTR_ERR(serio_task);
diff -ruNp 400-workthreads.patch-old/drivers/md/dm-crypt.c 400-workthreads.patch-new/drivers/md/dm-crypt.c
--- 400-workthreads.patch-old/drivers/md/dm-crypt.c	2005-08-02 22:31:02.000000000 +1000
+++ 400-workthreads.patch-new/drivers/md/dm-crypt.c	2005-08-02 22:33:49.000000000 +1000
@@ -926,7 +926,7 @@ static int __init dm_crypt_init(void)
 	if (!_crypt_io_pool)
 		return -ENOMEM;
 
-	_kcryptd_workqueue = create_workqueue("kcryptd");
+	_kcryptd_workqueue = create_nofreeze_workqueue("kcryptd");
 	if (!_kcryptd_workqueue) {
 		r = -ENOMEM;
 		DMERR(PFX "couldn't create kcryptd");
diff -ruNp 400-workthreads.patch-old/drivers/scsi/hosts.c 400-workthreads.patch-new/drivers/scsi/hosts.c
--- 400-workthreads.patch-old/drivers/scsi/hosts.c	2005-08-02 22:31:10.000000000 +1000
+++ 400-workthreads.patch-new/drivers/scsi/hosts.c	2005-08-02 22:33:49.000000000 +1000
@@ -132,7 +132,7 @@ int scsi_add_host(struct Scsi_Host *shos
 	if (shost->transportt->create_work_queue) {
 		snprintf(shost->work_q_name, KOBJ_NAME_LEN, "scsi_wq_%d",
 			shost->host_no);
-		shost->work_q = create_singlethread_workqueue(
+		shost->work_q = create_nofreeze_singlethread_workqueue(
 					shost->work_q_name);
 		if (!shost->work_q)
 			goto out_free_shost_data;
diff -ruNp 400-workthreads.patch-old/drivers/usb/net/pegasus.c 400-workthreads.patch-new/drivers/usb/net/pegasus.c
--- 400-workthreads.patch-old/drivers/usb/net/pegasus.c	2005-08-02 22:31:15.000000000 +1000
+++ 400-workthreads.patch-new/drivers/usb/net/pegasus.c	2005-08-02 22:33:49.000000000 +1000
@@ -1411,7 +1411,7 @@ static struct usb_driver pegasus_driver 
 static int __init pegasus_init(void)
 {
 	pr_info("%s: %s, " DRIVER_DESC "\n", driver_name, DRIVER_VERSION);
-	pegasus_workqueue = create_singlethread_workqueue("pegasus");
+	pegasus_workqueue = create_nofreeze_singlethread_workqueue("pegasus");
 	if (!pegasus_workqueue)
 		return -ENOMEM;
 	return usb_register(&pegasus_driver);
diff -ruNp 400-workthreads.patch-old/include/linux/kthread.h 400-workthreads.patch-new/include/linux/kthread.h
--- 400-workthreads.patch-old/include/linux/kthread.h	2004-11-03 21:51:12.000000000 +1100
+++ 400-workthreads.patch-new/include/linux/kthread.h	2005-08-03 11:52:01.000000000 +1000
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
diff -ruNp 400-workthreads.patch-old/include/linux/workqueue.h 400-workthreads.patch-new/include/linux/workqueue.h
--- 400-workthreads.patch-old/include/linux/workqueue.h	2005-06-20 11:47:30.000000000 +1000
+++ 400-workthreads.patch-new/include/linux/workqueue.h	2005-08-03 11:49:34.000000000 +1000
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
 
diff -ruNp 400-workthreads.patch-old/kernel/kthread.c 400-workthreads.patch-new/kernel/kthread.c
--- 400-workthreads.patch-old/kernel/kthread.c	2005-06-20 11:47:31.000000000 +1000
+++ 400-workthreads.patch-new/kernel/kthread.c	2005-08-04 09:46:43.000000000 +1000
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
diff -ruNp 400-workthreads.patch-old/kernel/sched.c 400-workthreads.patch-new/kernel/sched.c
--- 400-workthreads.patch-old/kernel/sched.c	2005-08-04 11:48:00.000000000 +1000
+++ 400-workthreads.patch-new/kernel/sched.c	2005-08-04 11:48:19.000000000 +1000
@@ -4585,7 +4585,6 @@ static int migration_call(struct notifie
 		p = kthread_create(migration_thread, hcpu, "migration/%d",cpu);
 		if (IS_ERR(p))
 			return NOTIFY_BAD;
-		p->flags |= PF_NOFREEZE;
 		kthread_bind(p, cpu);
 		/* Must be high prio: stop_machine expects to yield to it. */
 		rq = task_rq_lock(p, &flags);
diff -ruNp 400-workthreads.patch-old/kernel/softirq.c 400-workthreads.patch-new/kernel/softirq.c
--- 400-workthreads.patch-old/kernel/softirq.c	2005-06-20 11:47:32.000000000 +1000
+++ 400-workthreads.patch-new/kernel/softirq.c	2005-08-02 22:33:49.000000000 +1000
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
diff -ruNp 400-workthreads.patch-old/kernel/workqueue.c 400-workthreads.patch-new/kernel/workqueue.c
--- 400-workthreads.patch-old/kernel/workqueue.c	2005-06-20 11:47:32.000000000 +1000
+++ 400-workthreads.patch-new/kernel/workqueue.c	2005-08-03 11:57:01.000000000 +1000
@@ -186,8 +186,6 @@ static int worker_thread(void *__cwq)
 	struct k_sigaction sa;
 	sigset_t blocked;
 
-	current->flags |= PF_NOFREEZE;
-
 	set_user_nice(current, -5);
 
 	/* Block and flush all signals */
@@ -208,6 +206,7 @@ static int worker_thread(void *__cwq)
 			schedule();
 		else
 			__set_current_state(TASK_RUNNING);
+		try_to_freeze();
 		remove_wait_queue(&cwq->more_work, &wait);
 
 		if (!list_empty(&cwq->worklist))
@@ -277,7 +276,8 @@ void fastcall flush_workqueue(struct wor
 }
 
 static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
-						   int cpu)
+						   int cpu,
+						   unsigned long freezer_flags)
 {
 	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
 	struct task_struct *p;
@@ -291,10 +291,21 @@ static struct task_struct *create_workqu
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
@@ -302,7 +313,8 @@ static struct task_struct *create_workqu
 }
 
 struct workqueue_struct *__create_workqueue(const char *name,
-					    int singlethread)
+					    int singlethread,
+					    unsigned long freezer_flags)
 {
 	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
@@ -320,7 +332,7 @@ struct workqueue_struct *__create_workqu
 	lock_cpu_hotplug();
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
-		p = create_workqueue_thread(wq, 0);
+		p = create_workqueue_thread(wq, 0, freezer_flags);
 		if (!p)
 			destroy = 1;
 		else
@@ -330,7 +342,7 @@ struct workqueue_struct *__create_workqu
 		list_add(&wq->list, &workqueues);
 		spin_unlock(&workqueue_lock);
 		for_each_online_cpu(cpu) {
-			p = create_workqueue_thread(wq, cpu);
+			p = create_workqueue_thread(wq, cpu, freezer_flags);
 			if (p) {
 				kthread_bind(p, cpu);
 				wake_up_process(p);
@@ -501,7 +513,7 @@ static int __devinit workqueue_cpu_callb
 	case CPU_UP_PREPARE:
 		/* Create a new workqueue thread for it. */
 		list_for_each_entry(wq, &workqueues, list) {
-			if (create_workqueue_thread(wq, hotcpu) < 0) {
+			if (create_workqueue_thread(wq, hotcpu, 0) < 0) {
 				printk("workqueue for %i failed\n", hotcpu);
 				return NOTIFY_BAD;
 			}
@@ -540,7 +552,7 @@ static int __devinit workqueue_cpu_callb
 void init_workqueues(void)
 {
 	hotcpu_notifier(workqueue_cpu_callback, 0);
-	keventd_wq = create_workqueue("events");
+	keventd_wq = create_nofreeze_workqueue("events");
 	BUG_ON(!keventd_wq);
 }
 

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

