Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbUKXNKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbUKXNKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbUKXNJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:09:15 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:32916 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262640AbUKXNAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:00:52 -0500
Subject: Suspend 2 merge: 5/51: Workthread freezer support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101293394.5805.209.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:57:11 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This thread adds freezer support for workthreads.

A new parameter in the create_ functions allows the thread to be marked
as PF_NOFREEZE. This should only be used for threads that may need to
run during writing the image.

In a later patch, you'll see a new SYNCTHREAD flag, used for processes
that need to run while we're syncing data to disk, but not for writing
the image. That isn't used here because all kernel threads are frozen
after we've synced, so it's irrelevant to them.


diff -ruN 210-workthreads-old/drivers/acpi/osl.c 210-workthreads-new/drivers/acpi/osl.c
--- 210-workthreads-old/drivers/acpi/osl.c	2004-11-03 21:54:44.000000000 +1100
+++ 210-workthreads-new/drivers/acpi/osl.c	2004-11-04 16:27:39.000000000 +1100
@@ -90,7 +90,7 @@
 		return AE_NULL_ENTRY;
 	}
 #endif
-	kacpid_wq = create_singlethread_workqueue("kacpid");
+	kacpid_wq = create_singlethread_workqueue("kacpid", 0);
 	BUG_ON(!kacpid_wq);
 
 	return AE_OK;
diff -ruN 210-workthreads-old/drivers/block/ll_rw_blk.c 210-workthreads-new/drivers/block/ll_rw_blk.c
--- 210-workthreads-old/drivers/block/ll_rw_blk.c	2004-11-03 21:51:17.000000000 +1100
+++ 210-workthreads-new/drivers/block/ll_rw_blk.c	2004-11-24 15:47:12.160377296 +1100
@@ -3021,7 +3021,7 @@
 
 int __init blk_dev_init(void)
 {
-	kblockd_workqueue = create_workqueue("kblockd");
+	kblockd_workqueue = create_workqueue("kblockd", PF_NOFREEZE);
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
 
diff -ruN 210-workthreads-old/drivers/char/hvc_console.c 210-workthreads-new/drivers/char/hvc_console.c
--- 210-workthreads-old/drivers/char/hvc_console.c	2004-11-03 21:54:45.000000000 +1100
+++ 210-workthreads-new/drivers/char/hvc_console.c	2004-11-04 16:27:39.000000000 +1100
@@ -757,7 +757,7 @@
 
 	/* Always start the kthread because there can be hotplug vty adapters
 	 * added later. */
-	hvc_task = kthread_run(khvcd, NULL, "khvcd");
+	hvc_task = kthread_run(khvcd, NULL, PF_NOFREEZE, "khvcd");
 	if (IS_ERR(hvc_task)) {
 		panic("Couldn't create kthread for console.\n");
 		put_tty_driver(hvc_driver);
diff -ruN 210-workthreads-old/drivers/char/hvcs.c 210-workthreads-new/drivers/char/hvcs.c
--- 210-workthreads-old/drivers/char/hvcs.c	2004-11-03 21:55:05.000000000 +1100
+++ 210-workthreads-new/drivers/char/hvcs.c	2004-11-04 16:27:39.000000000 +1100
@@ -1420,7 +1420,7 @@
 		return -ENOMEM;
 	}
 
-	hvcs_task = kthread_run(khvcsd, NULL, "khvcsd");
+	hvcs_task = kthread_run(khvcsd, NULL, PF_NOFREEZE, "khvcsd");
 	if (IS_ERR(hvcs_task)) {
 		printk(KERN_ERR "HVCS: khvcsd creation failed.  Driver not loaded.\n");
 		kfree(hvcs_pi_buff);
diff -ruN 210-workthreads-old/drivers/macintosh/therm_adt746x.c 210-workthreads-new/drivers/macintosh/therm_adt746x.c
--- 210-workthreads-old/drivers/macintosh/therm_adt746x.c	2004-11-03 21:54:41.000000000 +1100
+++ 210-workthreads-new/drivers/macintosh/therm_adt746x.c	2004-11-04 16:27:39.000000000 +1100
@@ -394,7 +394,7 @@
 		write_both_fan_speed(th, -1);
 	}
 	
-	thread_therm = kthread_run(monitor_task, th, "kfand");
+	thread_therm = kthread_run(monitor_task, th, 0, "kfand");
 
 	if (thread_therm == ERR_PTR(-ENOMEM)) {
 		printk(KERN_INFO "adt746x: Kthread creation failed\n");
diff -ruN 210-workthreads-old/drivers/md/dm-crypt.c 210-workthreads-new/drivers/md/dm-crypt.c
--- 210-workthreads-old/drivers/md/dm-crypt.c	2004-11-03 21:51:10.000000000 +1100
+++ 210-workthreads-new/drivers/md/dm-crypt.c	2004-11-04 16:27:39.000000000 +1100
@@ -758,7 +758,7 @@
 	if (!_crypt_io_pool)
 		return -ENOMEM;
 
-	_kcryptd_workqueue = create_workqueue("kcryptd");
+	_kcryptd_workqueue = create_workqueue("kcryptd", PF_NOFREEZE);
 	if (!_kcryptd_workqueue) {
 		r = -ENOMEM;
 		DMERR(PFX "couldn't create kcryptd");
diff -ruN 210-workthreads-old/drivers/md/dm-raid1.c 210-workthreads-new/drivers/md/dm-raid1.c
--- 210-workthreads-old/drivers/md/dm-raid1.c	2004-11-03 21:55:03.000000000 +1100
+++ 210-workthreads-new/drivers/md/dm-raid1.c	2004-11-04 16:27:39.000000000 +1100
@@ -1233,7 +1233,7 @@
 	if (r)
 		return r;
 
-	_kmirrord_wq = create_workqueue("kmirrord");
+	_kmirrord_wq = create_workqueue("kmirrord", PF_SYNCTHREAD);
 	if (!_kmirrord_wq) {
 		DMERR("couldn't start kmirrord");
 		dm_dirty_log_exit();
diff -ruN 210-workthreads-old/drivers/md/kcopyd.c 210-workthreads-new/drivers/md/kcopyd.c
--- 210-workthreads-old/drivers/md/kcopyd.c	2004-11-03 21:51:14.000000000 +1100
+++ 210-workthreads-new/drivers/md/kcopyd.c	2004-11-04 16:27:39.000000000 +1100
@@ -609,7 +609,7 @@
 		return r;
 	}
 
-	_kcopyd_wq = create_singlethread_workqueue("kcopyd");
+	_kcopyd_wq = create_singlethread_workqueue("kcopyd", PF_SYNCTHREAD);
 	if (!_kcopyd_wq) {
 		jobs_exit();
 		up(&kcopyd_init_lock);
diff -ruN 210-workthreads-old/drivers/message/i2o/driver.c 210-workthreads-new/drivers/message/i2o/driver.c
--- 210-workthreads-old/drivers/message/i2o/driver.c	2004-11-03 21:55:03.000000000 +1100
+++ 210-workthreads-new/drivers/message/i2o/driver.c	2004-11-04 16:27:39.000000000 +1100
@@ -80,7 +80,7 @@
 	pr_debug("Register driver %s\n", drv->name);
 
 	if (drv->event) {
-		drv->event_queue = create_workqueue(drv->name);
+		drv->event_queue = create_workqueue(drv->name, 0);
 		if (!drv->event_queue) {
 			printk(KERN_ERR "i2o: Could not initialize event queue "
 			       "for driver %s\n", drv->name);
diff -ruN 210-workthreads-old/drivers/net/wan/sdlamain.c 210-workthreads-new/drivers/net/wan/sdlamain.c
--- 210-workthreads-old/drivers/net/wan/sdlamain.c	2004-11-03 21:54:35.000000000 +1100
+++ 210-workthreads-new/drivers/net/wan/sdlamain.c	2004-11-04 16:27:39.000000000 +1100
@@ -240,7 +240,7 @@
 	printk(KERN_INFO "%s v%u.%u %s\n",
 		fullname, DRV_VERSION, DRV_RELEASE, copyright);
 
-	wanpipe_wq = create_workqueue("wanpipe_wq");
+	wanpipe_wq = create_workqueue("wanpipe_wq", 0);
 	if (!wanpipe_wq)
 		return -ENOMEM;
 
diff -ruN 210-workthreads-old/drivers/s390/cio/device.c 210-workthreads-new/drivers/s390/cio/device.c
--- 210-workthreads-old/drivers/s390/cio/device.c	2004-11-03 21:54:36.000000000 +1100
+++ 210-workthreads-new/drivers/s390/cio/device.c	2004-11-04 16:27:39.000000000 +1100
@@ -151,15 +151,16 @@
 	init_waitqueue_head(&ccw_device_init_wq);
 	atomic_set(&ccw_device_init_count, 0);
 
-	ccw_device_work = create_singlethread_workqueue("cio");
+	ccw_device_work = create_singlethread_workqueue("cio", 0);
 	if (!ccw_device_work)
 		return -ENOMEM; /* FIXME: better errno ? */
-	ccw_device_notify_work = create_singlethread_workqueue("cio_notify");
+	ccw_device_notify_work = create_singlethread_workqueue("cio_notify",
+			0);
 	if (!ccw_device_notify_work) {
 		ret = -ENOMEM; /* FIXME: better errno ? */
 		goto out_err;
 	}
-	slow_path_wq = create_singlethread_workqueue("kslowcrw");
+	slow_path_wq = create_singlethread_workqueue("kslowcrw", 0);
 	if (!slow_path_wq) {
 		ret = -ENOMEM; /* FIXME: better errno ? */
 		goto out_err;
diff -ruN 210-workthreads-old/drivers/scsi/libata-core.c 210-workthreads-new/drivers/scsi/libata-core.c
--- 210-workthreads-old/drivers/scsi/libata-core.c	2004-11-03 21:51:09.000000000 +1100
+++ 210-workthreads-new/drivers/scsi/libata-core.c	2004-11-24 15:47:12.086388544 +1100
@@ -3591,7 +3591,7 @@
 
 static int __init ata_init(void)
 {
-	ata_wq = create_workqueue("ata");
+	ata_wq = create_workqueue("ata", 0);
 	if (!ata_wq)
 		return -ENOMEM;
 
diff -ruN 210-workthreads-old/fs/aio.c 210-workthreads-new/fs/aio.c
--- 210-workthreads-old/fs/aio.c	2004-11-03 21:53:42.000000000 +1100
+++ 210-workthreads-new/fs/aio.c	2004-11-10 12:16:01.000000000 +1100
@@ -72,7 +72,7 @@
 	kioctx_cachep = kmem_cache_create("kioctx", sizeof(struct kioctx),
 				0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
-	aio_wq = create_workqueue("aio");
+	aio_wq = create_workqueue("aio", 0);
 
 	pr_debug("aio_setup: sizeof(struct page) = %d\n", (int)sizeof(struct page));
 
diff -ruN 210-workthreads-old/fs/reiserfs/journal.c 210-workthreads-new/fs/reiserfs/journal.c
--- 210-workthreads-old/fs/reiserfs/journal.c	2004-11-03 21:53:50.000000000 +1100
+++ 210-workthreads-new/fs/reiserfs/journal.c	2004-11-24 15:47:12.119383528 +1100
@@ -2483,7 +2483,7 @@
 
   reiserfs_mounted_fs_count++ ;
   if (reiserfs_mounted_fs_count <= 1)
-    commit_wq = create_workqueue("reiserfs");
+    commit_wq = create_workqueue("reiserfs", PF_SYNCTHREAD);
 
   INIT_WORK(&journal->j_work, flush_async_commits, p_s_sb);
   return 0 ;
diff -ruN 210-workthreads-old/fs/xfs/linux-2.6/xfs_buf.c 210-workthreads-new/fs/xfs/linux-2.6/xfs_buf.c
--- 210-workthreads-old/fs/xfs/linux-2.6/xfs_buf.c	2004-11-03 21:51:13.000000000 +1100
+++ 210-workthreads-new/fs/xfs/linux-2.6/xfs_buf.c	2004-11-24 15:47:12.121383224 +1100
@@ -1784,11 +1784,11 @@
 {
 	int		rval;
 
-	pagebuf_logio_workqueue = create_workqueue("xfslogd");
+	pagebuf_logio_workqueue = create_workqueue("xfslogd", PF_SYNCTHREAD);
 	if (!pagebuf_logio_workqueue)
 		return -ENOMEM;
 
-	pagebuf_dataio_workqueue = create_workqueue("xfsdatad");
+	pagebuf_dataio_workqueue = create_workqueue("xfsdatad", PF_SYNCTHREAD);
 	if (!pagebuf_dataio_workqueue) {
 		destroy_workqueue(pagebuf_logio_workqueue);
 		return -ENOMEM;
diff -ruN 210-workthreads-old/include/linux/kthread.h 210-workthreads-new/include/linux/kthread.h
--- 210-workthreads-old/include/linux/kthread.h	2004-11-03 21:51:12.000000000 +1100
+++ 210-workthreads-new/include/linux/kthread.h	2004-11-04 16:27:40.000000000 +1100
@@ -25,20 +25,26 @@
  */
 struct task_struct *kthread_create(int (*threadfn)(void *data),
 				   void *data,
+				   unsigned long freezer_flags,
 				   const char namefmt[], ...);
 
 /**
  * kthread_run: create and wake a thread.
  * @threadfn: the function to run until signal_pending(current).
  * @data: data ptr for @threadfn.
+ * @freezer_flags: process flags that should be used for freezing.
+ * 	PF_SYNCTHREAD if needed for syncing data to disk.
+ * 	PF_NOFREEZE if also needed for writing the image.
+ * 	0 otherwise.
  * @namefmt: printf-style name for the thread.
  *
  * Description: Convenient wrapper for kthread_create() followed by
  * wake_up_process().  Returns the kthread, or ERR_PTR(-ENOMEM). */
-#define kthread_run(threadfn, data, namefmt, ...)			   \
+#define kthread_run(threadfn, data, freezer_flags, namefmt, ...)	   \
 ({									   \
 	struct task_struct *__k						   \
-		= kthread_create(threadfn, data, namefmt, ## __VA_ARGS__); \
+		= kthread_create(threadfn, data, freezer_flags, 	   \
+			namefmt, ## __VA_ARGS__);			   \
 	if (!IS_ERR(__k))						   \
 		wake_up_process(__k);					   \
 	__k;								   \
diff -ruN 210-workthreads-old/include/linux/workqueue.h 210-workthreads-new/include/linux/workqueue.h
--- 210-workthreads-old/include/linux/workqueue.h	2004-11-03 21:54:39.000000000 +1100
+++ 210-workthreads-new/include/linux/workqueue.h	2004-11-04 16:27:40.000000000 +1100
@@ -51,9 +51,10 @@
 	} while (0)
 
 extern struct workqueue_struct *__create_workqueue(const char *name,
-						    int singlethread);
-#define create_workqueue(name) __create_workqueue((name), 0)
-#define create_singlethread_workqueue(name) __create_workqueue((name), 1)
+						    int singlethread,
+						    unsigned long freezer_flag);
+#define create_workqueue(name, flags) __create_workqueue((name), 0, flags)
+#define create_singlethread_workqueue(name, flags) __create_workqueue((name), 1, flags)
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
diff -ruN 210-workthreads-old/kernel/kmod.c 210-workthreads-new/kernel/kmod.c
--- 210-workthreads-old/kernel/kmod.c	2004-11-03 21:52:56.000000000 +1100
+++ 210-workthreads-new/kernel/kmod.c	2004-11-04 16:27:40.000000000 +1100
@@ -274,6 +274,6 @@
 
 void __init usermodehelper_init(void)
 {
-	khelper_wq = create_singlethread_workqueue("khelper");
+	khelper_wq = create_singlethread_workqueue("khelper", 0);
 	BUG_ON(!khelper_wq);
 }
diff -ruN 210-workthreads-old/kernel/kthread.c 210-workthreads-new/kernel/kthread.c
--- 210-workthreads-old/kernel/kthread.c	2004-11-03 21:55:00.000000000 +1100
+++ 210-workthreads-new/kernel/kthread.c	2004-11-09 12:26:59.000000000 +1100
@@ -19,6 +19,7 @@
 	/* Information passed to kthread() from keventd. */
 	int (*threadfn)(void *data);
 	void *data;
+	unsigned long freezer_flags;
 	struct completion started;
 
 	/* Result passed back to kthread_create() from keventd. */
@@ -80,6 +81,10 @@
 	/* By default we can run anywhere, unlike keventd. */
 	set_cpus_allowed(current, CPU_MASK_ALL);
 
+	/* Set our freezer flags */
+	current->flags &= ~(PF_SYNCTHREAD | PF_NOFREEZE);
+	current->flags |= create->freezer_flags;
+
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_INTERRUPTIBLE);
 	complete(&create->started);
@@ -115,6 +120,7 @@
 
 struct task_struct *kthread_create(int (*threadfn)(void *data),
 				   void *data,
+				   unsigned long freezer_flags,
 				   const char namefmt[],
 				   ...)
 {
@@ -123,6 +129,7 @@
 
 	create.threadfn = threadfn;
 	create.data = data;
+	create.freezer_flags = freezer_flags;
 	init_completion(&create.started);
 	init_completion(&create.done);
 
diff -ruN 210-workthreads-old/kernel/sched.c 210-workthreads-new/kernel/sched.c
--- 210-workthreads-old/kernel/sched.c	2004-11-24 15:47:06.402252664 +1100
+++ 210-workthreads-new/kernel/sched.c	2004-11-24 15:47:12.250363616 +1100
@@ -4146,10 +4146,10 @@
 
 	switch (action) {
 	case CPU_UP_PREPARE:
-		p = kthread_create(migration_thread, hcpu, "migration/%d",cpu);
+		p = kthread_create(migration_thread, hcpu, 0,
+				"migration/%d",cpu);
 		if (IS_ERR(p))
 			return NOTIFY_BAD;
-		p->flags |= PF_NOFREEZE;
 		kthread_bind(p, cpu);
 		/* Must be high prio: stop_machine expects to yield to it. */
 		rq = task_rq_lock(p, &flags);
diff -ruN 210-workthreads-old/kernel/softirq.c 210-workthreads-new/kernel/softirq.c
--- 210-workthreads-old/kernel/softirq.c	2004-11-03 21:52:39.000000000 +1100
+++ 210-workthreads-new/kernel/softirq.c	2004-11-16 14:48:20.000000000 +1100
@@ -328,7 +328,6 @@
 static int ksoftirqd(void * __bind_cpu)
 {
 	set_user_nice(current, 19);
-	current->flags |= PF_NOFREEZE;
 
 	set_current_state(TASK_INTERRUPTIBLE);
 
@@ -338,6 +337,8 @@
 
 		__set_current_state(TASK_RUNNING);
 
+		try_to_freeze(PF_FREEZE);
+
 		while (local_softirq_pending()) {
 			/* Preempt disable stops cpu going offline.
 			   If already offline, we'll be on wrong CPU:
@@ -430,7 +431,7 @@
 	case CPU_UP_PREPARE:
 		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
 		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
-		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
+		p = kthread_create(ksoftirqd, hcpu, PF_NOFREEZE, "ksoftirqd/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("ksoftirqd for %i failed\n", hotcpu);
 			return NOTIFY_BAD;
diff -ruN 210-workthreads-old/kernel/stop_machine.c 210-workthreads-new/kernel/stop_machine.c
--- 210-workthreads-old/kernel/stop_machine.c	2004-11-03 21:51:14.000000000 +1100
+++ 210-workthreads-new/kernel/stop_machine.c	2004-11-04 16:27:40.000000000 +1100
@@ -174,7 +174,7 @@
 	if (cpu == NR_CPUS)
 		cpu = smp_processor_id();
 
-	p = kthread_create(do_stop, &smdata, "kstopmachine");
+	p = kthread_create(do_stop, &smdata, 0, "kstopmachine");
 	if (!IS_ERR(p)) {
 		kthread_bind(p, cpu);
 		wake_up_process(p);
diff -ruN 210-workthreads-old/kernel/workqueue.c 210-workthreads-new/kernel/workqueue.c
--- 210-workthreads-old/kernel/workqueue.c	2004-11-03 21:55:02.000000000 +1100
+++ 210-workthreads-new/kernel/workqueue.c	2004-11-10 09:46:21.000000000 +1100
@@ -186,8 +186,6 @@
 	struct k_sigaction sa;
 	sigset_t blocked;
 
-	current->flags |= PF_NOFREEZE;
-
 	set_user_nice(current, -10);
 
 	/* Block and flush all signals */
@@ -208,6 +206,7 @@
 			schedule();
 		else
 			__set_current_state(TASK_RUNNING);
+		try_to_freeze(PF_FREEZE);
 		remove_wait_queue(&cwq->more_work, &wait);
 
 		if (!list_empty(&cwq->worklist))
@@ -277,7 +276,8 @@
 }
 
 static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
-						   int cpu)
+						   int cpu,
+						   unsigned long freezer_flags)
 {
 	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
 	struct task_struct *p;
@@ -292,9 +292,11 @@
 	init_waitqueue_head(&cwq->work_done);
 
 	if (is_single_threaded(wq))
-		p = kthread_create(worker_thread, cwq, "%s", wq->name);
+		p = kthread_create(worker_thread, cwq, freezer_flags, 
+				"%s", wq->name);
 	else
-		p = kthread_create(worker_thread, cwq, "%s/%d", wq->name, cpu);
+		p = kthread_create(worker_thread, cwq, freezer_flags,
+				"%s/%d", wq->name, cpu);
 	if (IS_ERR(p))
 		return NULL;
 	cwq->thread = p;
@@ -302,7 +304,8 @@
 }
 
 struct workqueue_struct *__create_workqueue(const char *name,
-					    int singlethread)
+					    int singlethread,
+					    unsigned long freezer_flags)
 {
 	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
@@ -320,7 +323,7 @@
 	lock_cpu_hotplug();
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
-		p = create_workqueue_thread(wq, 0);
+		p = create_workqueue_thread(wq, 0, freezer_flags);
 		if (!p)
 			destroy = 1;
 		else
@@ -330,7 +333,7 @@
 		list_add(&wq->list, &workqueues);
 		spin_unlock(&workqueue_lock);
 		for_each_online_cpu(cpu) {
-			p = create_workqueue_thread(wq, cpu);
+			p = create_workqueue_thread(wq, cpu, freezer_flags);
 			if (p) {
 				kthread_bind(p, cpu);
 				wake_up_process(p);
@@ -513,7 +516,7 @@
 void init_workqueues(void)
 {
 	hotcpu_notifier(workqueue_cpu_callback, 0);
-	keventd_wq = create_workqueue("events");
+	keventd_wq = create_workqueue("events", PF_NOFREEZE);
 	BUG_ON(!keventd_wq);
 }
 
diff -ruN 210-workthreads-old/mm/pdflush.c 210-workthreads-new/mm/pdflush.c
--- 210-workthreads-old/mm/pdflush.c	2004-11-03 21:55:04.000000000 +1100
+++ 210-workthreads-new/mm/pdflush.c	2004-11-24 15:47:12.139380488 +1100
@@ -215,7 +215,7 @@
 
 static void start_one_pdflush_thread(void)
 {
-	kthread_run(pdflush, NULL, "pdflush");
+	kthread_run(pdflush, NULL, 0, "pdflush");
 }
 
 static int __init pdflush_init(void)


