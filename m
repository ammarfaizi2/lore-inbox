Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267916AbUIPLLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267916AbUIPLLB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267920AbUIPLLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:11:01 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:63203 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267916AbUIPLHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:07:14 -0400
Subject: [PATCH] Suspend2 Merge: Workthread freezer support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095332918.3327.174.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 21:08:39 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's an updated workthread freezer-support patch. In addition to
previous versions, it correctly sets flags on threads made for cpu
hot-plugging.

Regards,

Nigel

diff -ruN 999-old/drivers/acpi/osl.c 999-new/drivers/acpi/osl.c
--- 999-old/drivers/acpi/osl.c	2004-09-07 21:58:30.000000000 +1000
+++ 999-new/drivers/acpi/osl.c	2004-09-09 19:30:11.000000000 +1000
@@ -87,7 +87,7 @@
 		return AE_NULL_ENTRY;
 	}
 #endif
-	kacpid_wq = create_singlethread_workqueue("kacpid");
+	kacpid_wq = create_singlethread_workqueue("kacpid", 0);
 	BUG_ON(!kacpid_wq);
 
 	return AE_OK;
diff -ruN linux-2.6.9-rc1/drivers/block/ll_rw_blk.c software-suspend-linux-2.6.9-rc1-rev3/drivers/block/ll_rw_blk.c
--- linux-2.6.9-rc1/drivers/block/ll_rw_blk.c	2004-09-07 21:58:30.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/block/ll_rw_blk.c	2004-09-09 19:36:24.000000000 +1000
@@ -3019,7 +3019,7 @@
 
 int __init blk_dev_init(void)
 {
-	kblockd_workqueue = create_workqueue("kblockd");
+	kblockd_workqueue = create_workqueue("kblockd", PF_NOFREEZE);
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
 
diff -ruN linux-2.6.9-rc1/drivers/char/hvcs.c software-suspend-linux-2.6.9-rc1-rev3/drivers/char/hvcs.c
--- linux-2.6.9-rc1/drivers/char/hvcs.c	2004-09-07 21:58:31.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/char/hvcs.c	2004-09-09 19:36:24.000000000 +1000
@@ -1364,7 +1364,7 @@
 		return -ENOMEM;
 	}
 
-	hvcs_task = kthread_run(khvcsd, NULL, "khvcsd");
+	hvcs_task = kthread_run(khvcsd, NULL, 0, "khvcsd");
 	if (IS_ERR(hvcs_task)) {
 		printk("khvcsd creation failed.  Driver not loaded.\n");
 		kfree(hvcs_pi_buff);
diff -ruN linux-2.6.9-rc1/drivers/md/dm-crypt.c software-suspend-linux-2.6.9-rc1-rev3/drivers/md/dm-crypt.c
--- linux-2.6.9-rc1/drivers/md/dm-crypt.c	2004-05-19 22:10:27.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/md/dm-crypt.c	2004-09-09 19:36:24.000000000 +1000
@@ -758,7 +758,7 @@
 	if (!_crypt_io_pool)
 		return -ENOMEM;
 
-	_kcryptd_workqueue = create_workqueue("kcryptd");
+	_kcryptd_workqueue = create_workqueue("kcryptd", PF_NOFREEZE);
 	if (!_kcryptd_workqueue) {
 		r = -ENOMEM;
 		DMERR(PFX "couldn't create kcryptd");
diff -ruN linux-2.6.9-rc1/drivers/md/dm-raid1.c software-suspend-linux-2.6.9-rc1-rev3/drivers/md/dm-raid1.c
--- linux-2.6.9-rc1/drivers/md/dm-raid1.c	2004-09-07 21:58:37.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/md/dm-raid1.c	2004-09-09 19:36:24.000000000 +1000
@@ -1238,7 +1238,7 @@
 	if (r)
 		return r;
 
-	_kmirrord_wq = create_workqueue("kmirrord");
+	_kmirrord_wq = create_workqueue("kmirrord", PF_SYNCTHREAD);
 	if (!_kmirrord_wq) {
 		DMERR("couldn't start kmirrord");
 		dm_dirty_log_exit();
diff -ruN linux-2.6.9-rc1/drivers/md/kcopyd.c software-suspend-linux-2.6.9-rc1-rev3/drivers/md/kcopyd.c
--- linux-2.6.9-rc1/drivers/md/kcopyd.c	2004-09-07 21:58:37.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/md/kcopyd.c	2004-09-09 19:36:24.000000000 +1000
@@ -609,7 +609,7 @@
 		return r;
 	}
 
-	_kcopyd_wq = create_singlethread_workqueue("kcopyd");
+	_kcopyd_wq = create_singlethread_workqueue("kcopyd", PF_SYNCTHREAD);
 	if (!_kcopyd_wq) {
 		jobs_exit();
 		up(&kcopyd_init_lock);
diff -ruN linux-2.6.9-rc1/drivers/net/wan/sdlamain.c software-suspend-linux-2.6.9-rc1-rev3/drivers/net/wan/sdlamain.c
--- linux-2.6.9-rc1/drivers/net/wan/sdlamain.c	2004-03-16 09:20:04.000000000 +1100
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/net/wan/sdlamain.c	2004-09-09 19:36:24.000000000 +1000
@@ -240,7 +240,7 @@
 	printk(KERN_INFO "%s v%u.%u %s\n",
 		fullname, DRV_VERSION, DRV_RELEASE, copyright);
 
-	wanpipe_wq = create_workqueue("wanpipe_wq");
+	wanpipe_wq = create_workqueue("wanpipe_wq", 0);
 	if (!wanpipe_wq)
 		return -ENOMEM;
 
diff -ruN linux-2.6.9-rc1/drivers/s390/cio/device.c software-suspend-linux-2.6.9-rc1-rev3/drivers/s390/cio/device.c
--- linux-2.6.9-rc1/drivers/s390/cio/device.c	2004-06-18 12:44:07.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/s390/cio/device.c	2004-09-09 19:36:24.000000000 +1000
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
diff -ruN linux-2.6.9-rc1/drivers/scsi/libata-core.c software-suspend-linux-2.6.9-rc1-rev3/drivers/scsi/libata-core.c
--- linux-2.6.9-rc1/drivers/scsi/libata-core.c	2004-09-07 21:58:46.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/scsi/libata-core.c	2004-09-09 19:36:24.000000000 +1000
@@ -3503,7 +3503,7 @@
 
 static int __init ata_init(void)
 {
-	ata_wq = create_workqueue("ata");
+	ata_wq = create_workqueue("ata", PF_NOFREEZE);
 	if (!ata_wq)
 		return -ENOMEM;
 
diff -ruN linux-2.6.9-rc1/fs/aio.c software-suspend-linux-2.6.9-rc1-rev3/fs/aio.c
--- linux-2.6.9-rc1/fs/aio.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/fs/aio.c	2004-09-09 19:36:24.000000000 +1000
@@ -69,7 +69,7 @@
 	kioctx_cachep = kmem_cache_create("kioctx", sizeof(struct kioctx),
 				0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
-	aio_wq = create_workqueue("aio");
+	aio_wq = create_workqueue("aio", PF_NOFREEZE);
 
 	pr_debug("aio_setup: sizeof(struct page) = %d\n", (int)sizeof(struct page));
 
diff -ruN linux-2.6.9-rc1/fs/reiserfs/journal.c software-suspend-linux-2.6.9-rc1-rev3/fs/reiserfs/journal.c
--- linux-2.6.9-rc1/fs/reiserfs/journal.c	2004-09-07 21:58:54.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/fs/reiserfs/journal.c	2004-09-09 19:36:24.000000000 +1000
@@ -2483,7 +2483,7 @@
 
   reiserfs_mounted_fs_count++ ;
   if (reiserfs_mounted_fs_count <= 1)
-    commit_wq = create_workqueue("reiserfs");
+    commit_wq = create_workqueue("reiserfs", PF_SYNCTHREAD);
 
   INIT_WORK(&journal->j_work, flush_async_commits, p_s_sb);
   return 0 ;
diff -ruN linux-2.6.9-rc1/fs/xfs/linux-2.6/xfs_buf.c software-suspend-linux-2.6.9-rc1-rev3/fs/xfs/linux-2.6/xfs_buf.c
--- linux-2.6.9-rc1/fs/xfs/linux-2.6/xfs_buf.c	2004-09-07 21:58:54.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/fs/xfs/linux-2.6/xfs_buf.c	2004-09-09 19:36:24.000000000 +1000
@@ -1787,11 +1786,11 @@
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
diff -ruN linux-2.6.9-rc1/include/linux/kthread.h software-suspend-linux-2.6.9-rc1-rev3/include/linux/kthread.h
--- linux-2.6.9-rc1/include/linux/kthread.h	2004-07-08 12:03:28.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/include/linux/kthread.h	2004-09-09 19:36:24.000000000 +1000
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
diff -ruN linux-2.6.9-rc1/include/linux/workqueue.h software-suspend-linux-2.6.9-rc1-rev3/include/linux/workqueue.h
--- linux-2.6.9-rc1/include/linux/workqueue.h	2004-09-07 21:59:00.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/include/linux/workqueue.h	2004-09-09 19:36:24.000000000 +1000
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
 
diff -ruN linux-2.6.9-rc1/kernel/kmod.c software-suspend-linux-2.6.9-rc1-rev3/kernel/kmod.c
--- linux-2.6.9-rc1/kernel/kmod.c	2004-09-07 21:59:00.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/kernel/kmod.c	2004-09-09 19:36:24.000000000 +1000
@@ -274,6 +274,6 @@
 
 void __init usermodehelper_init(void)
 {
-	khelper_wq = create_singlethread_workqueue("khelper");
+	khelper_wq = create_singlethread_workqueue("khelper", 0);
 	BUG_ON(!khelper_wq);
 }
diff -ruN linux-2.6.9-rc1/kernel/kthread.c software-suspend-linux-2.6.9-rc1-rev3/kernel/kthread.c
--- linux-2.6.9-rc1/kernel/kthread.c	2004-09-07 21:59:00.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/kernel/kthread.c	2004-09-09 19:36:24.000000000 +1000
@@ -19,6 +19,7 @@
 	/* Information passed to kthread() from keventd. */
 	int (*threadfn)(void *data);
 	void *data;
+	unsigned long freezer_flags;
 	struct completion started;
 
 	/* Result passed back to kthread_create() from keventd. */
@@ -80,6 +81,9 @@
 	/* By default we can run anywhere, unlike keventd. */
 	set_cpus_allowed(current, CPU_MASK_ALL);
 
+	/* Set our freezer flags */
+	current->flags |= create->freezer_flags;
+
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_INTERRUPTIBLE);
 	complete(&create->started);
@@ -115,6 +119,7 @@
 
 struct task_struct *kthread_create(int (*threadfn)(void *data),
 				   void *data,
+				   unsigned long freezer_flags,
 				   const char namefmt[],
 				   ...)
 {
@@ -123,6 +128,7 @@
 
 	create.threadfn = threadfn;
 	create.data = data;
+	create.freezer_flags = freezer_flags;
 	init_completion(&create.started);
 	init_completion(&create.done);
 
diff -ruN linux-2.6.9-rc1/kernel/sched.c software-suspend-linux-2.6.9-rc1-rev3/kernel/sched.c
--- linux-2.6.9-rc1/kernel/sched.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/kernel/sched.c	2004-09-09 19:36:24.000000000 +1000
@@ -3570,7 +3570,8 @@
 
 	switch (action) {
 	case CPU_UP_PREPARE:
-		p = kthread_create(migration_thread, hcpu, "migration/%d",cpu);
+		p = kthread_create(migration_thread, hcpu, 0,
+				"migration/%d",cpu);
 		if (IS_ERR(p))
 			return NOTIFY_BAD;
 		p->flags |= PF_NOFREEZE;
diff -ruN linux-2.6.9-rc1/kernel/softirq.c software-suspend-linux-2.6.9-rc1-rev3/kernel/softirq.c
--- linux-2.6.9-rc1/kernel/softirq.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/kernel/softirq.c	2004-09-09 19:36:24.000000000 +1000
@@ -430,7 +430,7 @@
 	case CPU_UP_PREPARE:
 		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
 		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
-		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
+		p = kthread_create(ksoftirqd, hcpu, 0, "ksoftirqd/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("ksoftirqd for %i failed\n", hotcpu);
 			return NOTIFY_BAD;
diff -ruN linux-2.6.9-rc1/kernel/stop_machine.c software-suspend-linux-2.6.9-rc1-rev3/kernel/stop_machine.c
--- linux-2.6.9-rc1/kernel/stop_machine.c	2004-05-19 22:10:48.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/kernel/stop_machine.c	2004-09-09 19:36:24.000000000 +1000
@@ -174,7 +174,7 @@
 	if (cpu == NR_CPUS)
 		cpu = smp_processor_id();
 
-	p = kthread_create(do_stop, &smdata, "kstopmachine");
+	p = kthread_create(do_stop, &smdata, 0, "kstopmachine");
 	if (!IS_ERR(p)) {
 		kthread_bind(p, cpu);
 		wake_up_process(p);
diff -ruN linux-2.6.9-rc1/kernel/workqueue.c software-suspend-linux-2.6.9-rc1-rev3/kernel/workqueue.c
--- linux-2.6.9-rc1/kernel/workqueue.c	2004-09-07 21:59:01.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/kernel/workqueue.c	2004-09-09 19:36:24.000000000 +1000
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/kthread.h>
+#include <linux/suspend.h>
 
 /*
  * The per-CPU workqueue (if single thread, we always use cpu 0's).
@@ -186,8 +187,6 @@
 	struct k_sigaction sa;
 	sigset_t blocked;
 
-	current->flags |= PF_NOFREEZE;
-
 	set_user_nice(current, -10);
 
 	/* Block and flush all signals */
@@ -208,6 +207,8 @@
 			schedule();
 		else
 			__set_current_state(TASK_RUNNING);
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_FREEZE);
 		remove_wait_queue(&cwq->more_work, &wait);
 
 		if (!list_empty(&cwq->worklist))
@@ -277,7 +278,8 @@
 }
 
 static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
-						   int cpu)
+						   int cpu,
+						   unsigned long freezer_flags)
 {
 	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
 	struct task_struct *p;
@@ -292,9 +294,11 @@
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
@@ -302,7 +306,8 @@
 }
 
 struct workqueue_struct *__create_workqueue(const char *name,
-					    int singlethread)
+					    int singlethread,
+					    unsigned long freezer_flags)
 {
 	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
@@ -320,7 +325,7 @@
 	lock_cpu_hotplug();
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
-		p = create_workqueue_thread(wq, 0);
+		p = create_workqueue_thread(wq, 0, freezer_flags);
 		if (!p)
 			destroy = 1;
 		else
@@ -330,7 +335,7 @@
 		list_add(&wq->list, &workqueues);
 		spin_unlock(&workqueue_lock);
 		for_each_online_cpu(cpu) {
-			p = create_workqueue_thread(wq, cpu);
+			p = create_workqueue_thread(wq, cpu, freezer_flags);
 			if (p) {
 				kthread_bind(p, cpu);
 				wake_up_process(p);
@@ -513,7 +518,7 @@
 void init_workqueues(void)
 {
 	hotcpu_notifier(workqueue_cpu_callback, 0);
-	keventd_wq = create_workqueue("events");
+	keventd_wq = create_workqueue("events", 0);
 	BUG_ON(!keventd_wq);
 }
 
diff -ruN linux-2.6.9-rc1/mm/pdflush.c software-suspend-linux-2.6.9-rc1-rev3/mm/pdflush.c
--- linux-2.6.9-rc1/mm/pdflush.c	2004-05-19 22:10:48.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/mm/pdflush.c	2004-09-09 19:36:24.000000000 +1000
@@ -215,7 +215,7 @@
 
 static void start_one_pdflush_thread(void)
 {
-	kthread_run(pdflush, NULL, "pdflush");
+	kthread_run(pdflush, NULL, 0, "pdflush");
 }
 
 static int __init pdflush_init(void)

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

