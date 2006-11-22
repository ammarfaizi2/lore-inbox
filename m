Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755779AbWKVNGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779AbWKVNGT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 08:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755765AbWKVNGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 08:06:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755759AbWKVNF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 08:05:27 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/5] WorkStruct: Separate delayable and non-delayable events. [try #2]
Date: Wed, 22 Nov 2006 13:02:25 +0000
To: torvalds@osdl.org, akpm@osdl.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20061122130224.24778.79588.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com>
References: <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Separate delayable work items from non-delayable work items be splitting them
into a separate structure (delayed_work), which incorporates a work_struct and
the timer_list removed from work_struct.

The work_struct struct is huge, and this limits it's usefulness.  On a 64-bit
architecture it's nearly 100 bytes in size.  This reduces that by half for the
non-delayable type of event.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/x86_64/kernel/mce.c           |    2 +
 drivers/ata/libata-core.c          |   11 +++-----
 drivers/ata/libata-eh.c            |    2 +
 drivers/char/random.c              |    2 +
 drivers/char/tty_io.c              |    2 +
 fs/aio.c                           |    4 +--
 fs/nfs/client.c                    |    2 +
 fs/nfs/namespace.c                 |    3 +-
 include/linux/aio.h                |    2 +
 include/linux/kbd_kern.h           |    2 +
 include/linux/libata.h             |    4 +--
 include/linux/nfs_fs_sb.h          |    2 +
 include/linux/sunrpc/rpc_pipe_fs.h |    2 +
 include/linux/sunrpc/xprt.h        |    2 +
 include/linux/tty.h                |    2 +
 include/linux/workqueue.h          |   44 +++++++++++++++++++++++--------
 kernel/workqueue.c                 |   51 ++++++++++++++++++++----------------
 mm/slab.c                          |    8 +++---
 net/core/link_watch.c              |    9 +++---
 net/sunrpc/cache.c                 |    4 +--
 net/sunrpc/rpc_pipe.c              |    3 +-
 net/sunrpc/xprtsock.c              |    6 ++--
 22 files changed, 96 insertions(+), 73 deletions(-)

diff --git a/arch/x86_64/kernel/mce.c b/arch/x86_64/kernel/mce.c
index bbea888..5306f26 100644
--- a/arch/x86_64/kernel/mce.c
+++ b/arch/x86_64/kernel/mce.c
@@ -307,7 +307,7 @@ #endif /* CONFIG_X86_MCE_INTEL */
 
 static int check_interval = 5 * 60; /* 5 minutes */
 static void mcheck_timer(void *data);
-static DECLARE_WORK(mcheck_work, mcheck_timer, NULL);
+static DECLARE_DELAYED_WORK(mcheck_work, mcheck_timer, NULL);
 
 static void mcheck_check_cpu(void *info)
 {
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 915a55a..0bb4b4d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -937,12 +937,9 @@ void ata_port_queue_task(struct ata_port
 	if (ap->pflags & ATA_PFLAG_FLUSH_PORT_TASK)
 		return;
 
-	PREPARE_WORK(&ap->port_task, fn, data);
+	PREPARE_DELAYED_WORK(&ap->port_task, fn, data);
 
-	if (!delay)
-		rc = queue_work(ata_wq, &ap->port_task);
-	else
-		rc = queue_delayed_work(ata_wq, &ap->port_task, delay);
+	rc = queue_delayed_work(ata_wq, &ap->port_task, delay);
 
 	/* rc == 0 means that another user is using port task */
 	WARN_ON(rc == 0);
@@ -5320,8 +5317,8 @@ #else
 	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
 #endif
 
-	INIT_WORK(&ap->port_task, NULL, NULL);
-	INIT_WORK(&ap->hotplug_task, ata_scsi_hotplug, ap);
+	INIT_DELAYED_WORK(&ap->port_task, NULL, NULL);
+	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug, ap);
 	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan, ap);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 02b2b27..9f6b7cc 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -332,7 +332,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 	if (ap->pflags & ATA_PFLAG_LOADING)
 		ap->pflags &= ~ATA_PFLAG_LOADING;
 	else if (ap->pflags & ATA_PFLAG_SCSI_HOTPLUG)
-		queue_work(ata_aux_wq, &ap->hotplug_task);
+		queue_delayed_work(ata_aux_wq, &ap->hotplug_task, 0);
 
 	if (ap->pflags & ATA_PFLAG_RECOVERED)
 		ata_port_printk(ap, KERN_INFO, "EH complete\n");
diff --git a/drivers/char/random.c b/drivers/char/random.c
index eb6b13f..f2ab61f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1424,7 +1424,7 @@ static unsigned int ip_cnt;
 
 static void rekey_seq_generator(void *private_);
 
-static DECLARE_WORK(rekey_work, rekey_seq_generator, NULL);
+static DECLARE_DELAYED_WORK(rekey_work, rekey_seq_generator, NULL);
 
 /*
  * Lock avoidance:
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index e90ea39..7297acf 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -3580,7 +3580,7 @@ static void initialize_tty_struct(struct
 	tty->overrun_time = jiffies;
 	tty->buf.head = tty->buf.tail = NULL;
 	tty_buffer_init(tty);
-	INIT_WORK(&tty->buf.work, flush_to_ldisc, tty);
+	INIT_DELAYED_WORK(&tty->buf.work, flush_to_ldisc, tty);
 	init_MUTEX(&tty->buf.pty_sem);
 	mutex_init(&tty->termios_mutex);
 	init_waitqueue_head(&tty->write_wait);
diff --git a/fs/aio.c b/fs/aio.c
index 9476659..11a1a71 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -227,7 +227,7 @@ static struct kioctx *ioctx_alloc(unsign
 
 	INIT_LIST_HEAD(&ctx->active_reqs);
 	INIT_LIST_HEAD(&ctx->run_list);
-	INIT_WORK(&ctx->wq, aio_kick_handler, ctx);
+	INIT_DELAYED_WORK(&ctx->wq, aio_kick_handler, ctx);
 
 	if (aio_setup_ring(ctx) < 0)
 		goto out_freectx;
@@ -876,7 +876,7 @@ static void aio_kick_handler(void *data)
 	 * we're in a worker thread already, don't use queue_delayed_work,
 	 */
 	if (requeue)
-		queue_work(aio_wq, &ctx->wq);
+		queue_delayed_work(aio_wq, &ctx->wq, 0);
 }
 
 
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 6e19b28..03b3e12 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -143,7 +143,7 @@ #ifdef CONFIG_NFS_V4
 	INIT_LIST_HEAD(&clp->cl_state_owners);
 	INIT_LIST_HEAD(&clp->cl_unused);
 	spin_lock_init(&clp->cl_lock);
-	INIT_WORK(&clp->cl_renewd, nfs4_renew_state, clp);
+	INIT_DELAYED_WORK(&clp->cl_renewd, nfs4_renew_state, clp);
 	rpc_init_wait_queue(&clp->cl_rpcwaitq, "NFS client");
 	clp->cl_boot_time = CURRENT_TIME;
 	clp->cl_state = 1 << NFS4CLNT_LEASE_EXPIRED;
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index ec1114b..5ed798b 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -21,7 +21,8 @@ #define NFSDBG_FACILITY		NFSDBG_VFS
 static void nfs_expire_automounts(void *list);
 
 LIST_HEAD(nfs_automount_list);
-static DECLARE_WORK(nfs_automount_task, nfs_expire_automounts, &nfs_automount_list);
+static DECLARE_DELAYED_WORK(nfs_automount_task, nfs_expire_automounts,
+			    &nfs_automount_list);
 int nfs_mountpoint_expiry_timeout = 500 * HZ;
 
 static struct vfsmount *nfs_do_submount(const struct vfsmount *mnt_parent,
diff --git a/include/linux/aio.h b/include/linux/aio.h
index 0d71c00..9e350fd 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -194,7 +194,7 @@ struct kioctx {
 
 	struct aio_ring_info	ring_info;
 
-	struct work_struct	wq;
+	struct delayed_work	wq;
 };
 
 /* prototypes */
diff --git a/include/linux/kbd_kern.h b/include/linux/kbd_kern.h
index efe0ee4..06c58c4 100644
--- a/include/linux/kbd_kern.h
+++ b/include/linux/kbd_kern.h
@@ -158,7 +158,7 @@ static inline void con_schedule_flip(str
 	if (t->buf.tail != NULL)
 		t->buf.tail->commit = t->buf.tail->used;
 	spin_unlock_irqrestore(&t->buf.lock, flags);
-	schedule_work(&t->buf.work);
+	schedule_delayed_work(&t->buf.work, 0);
 }
 
 #endif
diff --git a/include/linux/libata.h b/include/linux/libata.h
index abd2deb..5f04006 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -568,8 +568,8 @@ struct ata_port {
 	struct ata_host		*host;
 	struct device 		*dev;
 
-	struct work_struct	port_task;
-	struct work_struct	hotplug_task;
+	struct delayed_work	port_task;
+	struct delayed_work	hotplug_task;
 	struct work_struct	scsi_rescan_task;
 
 	unsigned int		hsm_task_state;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index c44be53..d63d205 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -52,7 +52,7 @@ #ifdef CONFIG_NFS_V4
 
 	unsigned long		cl_lease_time;
 	unsigned long		cl_last_renewal;
-	struct work_struct	cl_renewd;
+	struct delayed_work	cl_renewd;
 
 	struct rpc_wait_queue	cl_rpcwaitq;
 
diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
index a2eb9b4..4a68125 100644
--- a/include/linux/sunrpc/rpc_pipe_fs.h
+++ b/include/linux/sunrpc/rpc_pipe_fs.h
@@ -30,7 +30,7 @@ struct rpc_inode {
 #define RPC_PIPE_WAIT_FOR_OPEN	1
 	int flags;
 	struct rpc_pipe_ops *ops;
-	struct work_struct queue_timeout;
+	struct delayed_work queue_timeout;
 };
 
 static inline struct rpc_inode *
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 60394fb..3e04c15 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -177,7 +177,7 @@ struct rpc_xprt {
 	unsigned long		connect_timeout,
 				bind_timeout,
 				reestablish_timeout;
-	struct work_struct	connect_worker;
+	struct delayed_work	connect_worker;
 	unsigned short		port;
 
 	/*
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 44091c0..c1f7164 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -53,7 +53,7 @@ struct tty_buffer {
 };
 
 struct tty_bufhead {
-	struct work_struct		work;
+	struct delayed_work work;
 	struct semaphore pty_sem;
 	spinlock_t lock;
 	struct tty_buffer *head;	/* Queue head */
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 9bca353..9faacca 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -17,6 +17,10 @@ struct work_struct {
 	void (*func)(void *);
 	void *data;
 	void *wq_data;
+};
+
+struct delayed_work {
+	struct work_struct work;
 	struct timer_list timer;
 };
 
@@ -28,32 +32,48 @@ #define __WORK_INITIALIZER(n, f, d) {			
         .entry	= { &(n).entry, &(n).entry },			\
 	.func = (f),						\
 	.data = (d),						\
+	}
+
+#define __DELAYED_WORK_INITIALIZER(n, f, d) {			\
+	.work = __WORK_INITIALIZER((n).work, (f), (d)),		\
 	.timer = TIMER_INITIALIZER(NULL, 0, 0),			\
 	}
 
 #define DECLARE_WORK(n, f, d)					\
 	struct work_struct n = __WORK_INITIALIZER(n, f, d)
 
+#define DECLARE_DELAYED_WORK(n, f, d)				\
+	struct delayed_work n = __DELAYED_WORK_INITIALIZER(n, f, d)
+
 /*
- * initialize a work-struct's func and data pointers:
+ * initialize a work item's function and data pointers
  */
 #define PREPARE_WORK(_work, _func, _data)			\
 	do {							\
-		(_work)->func = _func;				\
-		(_work)->data = _data;				\
+		(_work)->func = (_func);			\
+		(_work)->data = (_data);			\
 	} while (0)
 
+#define PREPARE_DELAYED_WORK(_work, _func, _data)		\
+	PREPARE_WORK(&(_work)->work, (_func), (_data))
+
 /*
- * initialize all of a work-struct:
+ * initialize all of a work item in one go
  */
 #define INIT_WORK(_work, _func, _data)				\
 	do {							\
 		INIT_LIST_HEAD(&(_work)->entry);		\
 		(_work)->pending = 0;				\
 		PREPARE_WORK((_work), (_func), (_data));	\
+	} while (0)
+
+#define INIT_DELAYED_WORK(_work, _func, _data)		\
+	do {							\
+		INIT_WORK(&(_work)->work, (_func), (_data));	\
 		init_timer(&(_work)->timer);			\
 	} while (0)
 
+
 extern struct workqueue_struct *__create_workqueue(const char *name,
 						    int singlethread);
 #define create_workqueue(name) __create_workqueue((name), 0)
@@ -62,24 +82,24 @@ #define create_singlethread_workqueue(na
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
 extern int FASTCALL(queue_work(struct workqueue_struct *wq, struct work_struct *work));
-extern int FASTCALL(queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));
+extern int FASTCALL(queue_delayed_work(struct workqueue_struct *wq, struct delayed_work *work, unsigned long delay));
 extern int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
-	struct work_struct *work, unsigned long delay);
+	struct delayed_work *work, unsigned long delay);
 extern void FASTCALL(flush_workqueue(struct workqueue_struct *wq));
 
 extern int FASTCALL(schedule_work(struct work_struct *work));
-extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
+extern int FASTCALL(schedule_delayed_work(struct delayed_work *work, unsigned long delay));
 
-extern int schedule_delayed_work_on(int cpu, struct work_struct *work, unsigned long delay);
+extern int schedule_delayed_work_on(int cpu, struct delayed_work *work, unsigned long delay);
 extern int schedule_on_each_cpu(void (*func)(void *info), void *info);
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
 extern int keventd_up(void);
 
 extern void init_workqueues(void);
-void cancel_rearming_delayed_work(struct work_struct *work);
+void cancel_rearming_delayed_work(struct delayed_work *work);
 void cancel_rearming_delayed_workqueue(struct workqueue_struct *,
-				       struct work_struct *);
+				       struct delayed_work *);
 int execute_in_process_context(void (*fn)(void *), void *,
 			       struct execute_work *);
 
@@ -88,13 +108,13 @@ int execute_in_process_context(void (*fn
  * function may still be running on return from cancel_delayed_work().  Run
  * flush_scheduled_work() to wait on it.
  */
-static inline int cancel_delayed_work(struct work_struct *work)
+static inline int cancel_delayed_work(struct delayed_work *work)
 {
 	int ret;
 
 	ret = del_timer_sync(&work->timer);
 	if (ret)
-		clear_bit(0, &work->pending);
+		clear_bit(0, &work->work.pending);
 	return ret;
 }
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 17c2f03..44fc54b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -122,29 +122,33 @@ EXPORT_SYMBOL_GPL(queue_work);
 
 static void delayed_work_timer_fn(unsigned long __data)
 {
-	struct work_struct *work = (struct work_struct *)__data;
-	struct workqueue_struct *wq = work->wq_data;
+	struct delayed_work *dwork = (struct delayed_work *)__data;
+	struct workqueue_struct *wq = dwork->work.wq_data;
 	int cpu = smp_processor_id();
 
 	if (unlikely(is_single_threaded(wq)))
 		cpu = singlethread_cpu;
 
-	__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
+	__queue_work(per_cpu_ptr(wq->cpu_wq, cpu), &dwork->work);
 }
 
 /**
  * queue_delayed_work - queue work on a workqueue after delay
  * @wq: workqueue to use
- * @work: work to queue
+ * @work: delayable work to queue
  * @delay: number of jiffies to wait before queueing
  *
  * Returns 0 if @work was already on a queue, non-zero otherwise.
  */
 int fastcall queue_delayed_work(struct workqueue_struct *wq,
-			struct work_struct *work, unsigned long delay)
+			struct delayed_work *dwork, unsigned long delay)
 {
 	int ret = 0;
-	struct timer_list *timer = &work->timer;
+	struct timer_list *timer = &dwork->timer;
+	struct work_struct *work = &dwork->work;
+
+	if (delay == 0)
+		return queue_work(wq, work);
 
 	if (!test_and_set_bit(0, &work->pending)) {
 		BUG_ON(timer_pending(timer));
@@ -153,7 +157,7 @@ int fastcall queue_delayed_work(struct w
 		/* This stores wq for the moment, for the timer_fn */
 		work->wq_data = wq;
 		timer->expires = jiffies + delay;
-		timer->data = (unsigned long)work;
+		timer->data = (unsigned long)dwork;
 		timer->function = delayed_work_timer_fn;
 		add_timer(timer);
 		ret = 1;
@@ -172,10 +176,11 @@ EXPORT_SYMBOL_GPL(queue_delayed_work);
  * Returns 0 if @work was already on a queue, non-zero otherwise.
  */
 int queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
-			struct work_struct *work, unsigned long delay)
+			struct delayed_work *dwork, unsigned long delay)
 {
 	int ret = 0;
-	struct timer_list *timer = &work->timer;
+	struct timer_list *timer = &dwork->timer;
+	struct work_struct *work = &dwork->work;
 
 	if (!test_and_set_bit(0, &work->pending)) {
 		BUG_ON(timer_pending(timer));
@@ -184,7 +189,7 @@ int queue_delayed_work_on(int cpu, struc
 		/* This stores wq for the moment, for the timer_fn */
 		work->wq_data = wq;
 		timer->expires = jiffies + delay;
-		timer->data = (unsigned long)work;
+		timer->data = (unsigned long)dwork;
 		timer->function = delayed_work_timer_fn;
 		add_timer_on(timer, cpu);
 		ret = 1;
@@ -468,31 +473,31 @@ EXPORT_SYMBOL(schedule_work);
 
 /**
  * schedule_delayed_work - put work task in global workqueue after delay
- * @work: job to be done
- * @delay: number of jiffies to wait
+ * @dwork: job to be done
+ * @delay: number of jiffies to wait or 0 for immediate execution
  *
  * After waiting for a given time this puts a job in the kernel-global
  * workqueue.
  */
-int fastcall schedule_delayed_work(struct work_struct *work, unsigned long delay)
+int fastcall schedule_delayed_work(struct delayed_work *dwork, unsigned long delay)
 {
-	return queue_delayed_work(keventd_wq, work, delay);
+	return queue_delayed_work(keventd_wq, dwork, delay);
 }
 EXPORT_SYMBOL(schedule_delayed_work);
 
 /**
  * schedule_delayed_work_on - queue work in global workqueue on CPU after delay
  * @cpu: cpu to use
- * @work: job to be done
+ * @dwork: job to be done
  * @delay: number of jiffies to wait
  *
  * After waiting for a given time this puts a job in the kernel-global
  * workqueue on the specified CPU.
  */
 int schedule_delayed_work_on(int cpu,
-			struct work_struct *work, unsigned long delay)
+			struct delayed_work *dwork, unsigned long delay)
 {
-	return queue_delayed_work_on(cpu, keventd_wq, work, delay);
+	return queue_delayed_work_on(cpu, keventd_wq, dwork, delay);
 }
 EXPORT_SYMBOL(schedule_delayed_work_on);
 
@@ -539,12 +544,12 @@ EXPORT_SYMBOL(flush_scheduled_work);
  * cancel_rearming_delayed_workqueue - reliably kill off a delayed
  *			work whose handler rearms the delayed work.
  * @wq:   the controlling workqueue structure
- * @work: the delayed work struct
+ * @dwork: the delayed work struct
  */
 void cancel_rearming_delayed_workqueue(struct workqueue_struct *wq,
-				       struct work_struct *work)
+				       struct delayed_work *dwork)
 {
-	while (!cancel_delayed_work(work))
+	while (!cancel_delayed_work(dwork))
 		flush_workqueue(wq);
 }
 EXPORT_SYMBOL(cancel_rearming_delayed_workqueue);
@@ -552,11 +557,11 @@ EXPORT_SYMBOL(cancel_rearming_delayed_wo
 /**
  * cancel_rearming_delayed_work - reliably kill off a delayed keventd
  *			work whose handler rearms the delayed work.
- * @work: the delayed work struct
+ * @dwork: the delayed work struct
  */
-void cancel_rearming_delayed_work(struct work_struct *work)
+void cancel_rearming_delayed_work(struct delayed_work *dwork)
 {
-	cancel_rearming_delayed_workqueue(keventd_wq, work);
+	cancel_rearming_delayed_workqueue(keventd_wq, dwork);
 }
 EXPORT_SYMBOL(cancel_rearming_delayed_work);
 
diff --git a/mm/slab.c b/mm/slab.c
index 3c4a7e3..a65bc5e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -753,7 +753,7 @@ int slab_is_available(void)
 	return g_cpucache_up == FULL;
 }
 
-static DEFINE_PER_CPU(struct work_struct, reap_work);
+static DEFINE_PER_CPU(struct delayed_work, reap_work);
 
 static inline struct array_cache *cpu_cache_get(struct kmem_cache *cachep)
 {
@@ -916,16 +916,16 @@ #endif
  */
 static void __devinit start_cpu_timer(int cpu)
 {
-	struct work_struct *reap_work = &per_cpu(reap_work, cpu);
+	struct delayed_work *reap_work = &per_cpu(reap_work, cpu);
 
 	/*
 	 * When this gets called from do_initcalls via cpucache_init(),
 	 * init_workqueues() has already run, so keventd will be setup
 	 * at that time.
 	 */
-	if (keventd_up() && reap_work->func == NULL) {
+	if (keventd_up() && reap_work->work.func == NULL) {
 		init_reap_node(cpu);
-		INIT_WORK(reap_work, cache_reap, NULL);
+		INIT_DELAYED_WORK(reap_work, cache_reap, NULL);
 		schedule_delayed_work_on(cpu, reap_work, HZ + 3 * cpu);
 	}
 }
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 4b36114..f2ed09e 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -35,7 +35,7 @@ static unsigned long linkwatch_flags;
 static unsigned long linkwatch_nextevent;
 
 static void linkwatch_event(void *dummy);
-static DECLARE_WORK(linkwatch_work, linkwatch_event, NULL);
+static DECLARE_DELAYED_WORK(linkwatch_work, linkwatch_event, NULL);
 
 static LIST_HEAD(lweventlist);
 static DEFINE_SPINLOCK(lweventlist_lock);
@@ -171,10 +171,9 @@ void linkwatch_fire_event(struct net_dev
 			unsigned long delay = linkwatch_nextevent - jiffies;
 
 			/* If we wrap around we'll delay it by at most HZ. */
-			if (!delay || delay > HZ)
-				schedule_work(&linkwatch_work);
-			else
-				schedule_delayed_work(&linkwatch_work, delay);
+			if (delay > HZ)
+				delay = 0;
+			schedule_delayed_work(&linkwatch_work, delay);
 		}
 	}
 }
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 00cb388..d5725cb 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -285,7 +285,7 @@ static struct file_operations content_fi
 static struct file_operations cache_flush_operations;
 
 static void do_cache_clean(void *data);
-static DECLARE_WORK(cache_cleaner, do_cache_clean, NULL);
+static DECLARE_DELAYED_WORK(cache_cleaner, do_cache_clean, NULL);
 
 void cache_register(struct cache_detail *cd)
 {
@@ -337,7 +337,7 @@ void cache_register(struct cache_detail 
 	spin_unlock(&cache_list_lock);
 
 	/* start the cleaning process */
-	schedule_work(&cache_cleaner);
+	schedule_delayed_work(&cache_cleaner, 0);
 }
 
 int cache_unregister(struct cache_detail *cd)
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 9a0b41a..97be3f7 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -837,7 +837,8 @@ init_once(void * foo, kmem_cache_t * cac
 		INIT_LIST_HEAD(&rpci->pipe);
 		rpci->pipelen = 0;
 		init_waitqueue_head(&rpci->waitq);
-		INIT_WORK(&rpci->queue_timeout, rpc_timeout_upcall_queue, rpci);
+		INIT_DELAYED_WORK(&rpci->queue_timeout,
+				    rpc_timeout_upcall_queue, rpci);
 		rpci->ops = NULL;
 	}
 }
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 757fc91..3c7532c 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1262,7 +1262,7 @@ static void xs_connect(struct rpc_task *
 			xprt->reestablish_timeout = XS_TCP_MAX_REEST_TO;
 	} else {
 		dprintk("RPC:      xs_connect scheduled xprt %p\n", xprt);
-		schedule_work(&xprt->connect_worker);
+		schedule_delayed_work(&xprt->connect_worker, 0);
 
 		/* flush_scheduled_work can sleep... */
 		if (!RPC_IS_ASYNC(task))
@@ -1375,7 +1375,7 @@ int xs_setup_udp(struct rpc_xprt *xprt, 
 	/* XXX: header size can vary due to auth type, IPv6, etc. */
 	xprt->max_payload = (1U << 16) - (MAX_HEADER << 3);
 
-	INIT_WORK(&xprt->connect_worker, xs_udp_connect_worker, xprt);
+	INIT_DELAYED_WORK(&xprt->connect_worker, xs_udp_connect_worker, xprt);
 	xprt->bind_timeout = XS_BIND_TO;
 	xprt->connect_timeout = XS_UDP_CONN_TO;
 	xprt->reestablish_timeout = XS_UDP_REEST_TO;
@@ -1420,7 +1420,7 @@ int xs_setup_tcp(struct rpc_xprt *xprt, 
 	xprt->tsh_size = sizeof(rpc_fraghdr) / sizeof(u32);
 	xprt->max_payload = RPC_MAX_FRAGMENT_SIZE;
 
-	INIT_WORK(&xprt->connect_worker, xs_tcp_connect_worker, xprt);
+	INIT_DELAYED_WORK(&xprt->connect_worker, xs_tcp_connect_worker, xprt);
 	xprt->bind_timeout = XS_BIND_TO;
 	xprt->connect_timeout = XS_TCP_CONN_TO;
 	xprt->reestablish_timeout = XS_TCP_INIT_REEST_TO;
