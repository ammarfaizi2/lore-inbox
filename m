Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262113AbSI3PuM>; Mon, 30 Sep 2002 11:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262114AbSI3PuM>; Mon, 30 Sep 2002 11:50:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7598 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262113AbSI3Ptr>;
	Mon, 30 Sep 2002 11:49:47 -0400
Date: Mon, 30 Sep 2002 18:04:31 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] generic work queue handling, workqueue-2.5.39-D6
Message-ID: <Pine.LNX.4.44.0209301747560.13521-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch (against BK-curr) cleans up the impact of the removal
of task-queue support. It merges kernel/context.c (keventd) and the old
task-queue concept into a unified 'work queue' concept. The basic
primitives are:

 extern workqueue_t *create_workqueue(const char *name);
 extern void destroy_workqueue(workqueue_t *wq);
 extern int queue_work(work_t *work, workqueue_t *wq);
 extern void flush_workqueue(workqueue_t *wq);

there is one 'default' workqueue, the events queue, which is analogous to
the old keventd code, with very similar semantics:

 extern int schedule_work(work_t *work);
 extern void flush_scheduled_work(void);

(they replace schedule_task() and flush_schedule_tasks())

atomic work that just needs to be run occasionally can be places on this
common queue, no need to create a separate queue for them. Potentially
high-latency uses like the starting of IO requests should use separate
workqueues.

workqueues are pretty easy to use, eg. the aio.c bits to initialize a
workqueue are:

	static workqueue_t *aio_wq;
	...

	aio_wq = create_workqueue("aio");

and to queue up work:

	static DECLARE_WORK(fput_work, aio_fput_routine, NULL);
	...

	queue_work(&fput_work, aio_wq);

it cannot get any simpler than this. Work-queues are SMP-safe and
guarantee serialization of actual work performed.

I've converted most of the task-queue users to workqueues: aio, keventd,
reiserfs and the common tq_immediate users. Eg. aio and reiserfs has its
separate work-queue now, to not decrease the latency of irq-related event
processing. In fact to me the new-style work-queueing code is more
readable and more intuitive, but i'm obviously biased :)

the design and implementation is streamlined - eg. the workqueue structure
details are completely hidden from users - the task-queue concept did not
do a very good job in this area, it used the same structure for 'work
queue head' and 'actual piece of work', which was a bit confusing.

i've introduced per-workqueue spinlocks, not a common tq_lock, which
should also improve SMP scalability.

the patch adds only 7 more lines, despite adding more functionality, which
shows that it simplified things noticeably:

 27 files changed, 381 insertions(+), 374 deletions(-)

not all tq-using code is converted yet, but i've compiled a reasonably
wide-featured kernel and it compiles, boots & works just fine on x86 SMP
and UP.

	Ingo

--- linux/drivers/serial/8250.c.orig	Mon Sep 30 16:41:38 2002
+++ linux/drivers/serial/8250.c	Mon Sep 30 16:41:54 2002
@@ -735,7 +735,7 @@
 
 	do {
 		if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
-			tty->flip.tqueue.routine((void *)tty);
+			tty->flip.work.routine((void *)tty);
 			if (tty->flip.count >= TTY_FLIPBUF_SIZE)
 				return; // if TTY_DONT_FLIP is set
 		}
--- linux/drivers/char/drm/radeon_irq.c.orig	Mon Sep 30 17:08:31 2002
+++ linux/drivers/char/drm/radeon_irq.c	Mon Sep 30 17:16:13 2002
@@ -69,7 +69,7 @@
 
 	atomic_inc(&dev_priv->irq_received);
 #ifdef __linux__
-	schedule_task(&dev->tq);
+	schedule_work(&dev->work);
 #endif /* __linux__ */
 #ifdef __FreeBSD__
 	taskqueue_enqueue(taskqueue_swi, &dev->task);
--- linux/drivers/char/drm/drmP.h.orig	Mon Sep 30 17:08:51 2002
+++ linux/drivers/char/drm/drmP.h	Mon Sep 30 17:15:34 2002
@@ -66,7 +66,7 @@
 #include <linux/types.h>
 #include <linux/agp_backend.h>
 #endif
-#include <linux/tqueue.h>
+#include <linux/workqueue.h>
 #include <linux/poll.h>
 #include <asm/pgalloc.h>
 #include "drm.h"
@@ -575,7 +575,7 @@
 	int		  last_checked;	/* Last context checked for DMA	   */
 	int		  last_context;	/* Last current context		   */
 	unsigned long	  last_switch;	/* jiffies at last context switch  */
-	struct tq_struct  tq;
+	work_t		  work;
 	cycles_t	  ctx_start;
 	cycles_t	  lck_start;
 #if __HAVE_DMA_HISTOGRAM
--- linux/drivers/char/drm/drm_dma.h.orig	Mon Sep 30 17:14:28 2002
+++ linux/drivers/char/drm/drm_dma.h	Mon Sep 30 17:15:04 2002
@@ -532,10 +532,7 @@
 	dev->dma->this_buffer = NULL;
 
 #if __HAVE_DMA_IRQ_BH
-	INIT_LIST_HEAD( &dev->tq.list );
-	dev->tq.sync = 0;
-	dev->tq.routine = DRM(dma_immediate_bh);
-	dev->tq.data = dev;
+	INIT_WORK(&dev->work, DRM(dma_immediate_bh), dev);
 #endif
 
 				/* Before installing handler */
--- linux/drivers/char/tty_io.c.orig	Mon Sep 30 16:26:53 2002
+++ linux/drivers/char/tty_io.c	Mon Sep 30 16:32:21 2002
@@ -538,7 +538,7 @@
 	
 	printk(KERN_DEBUG "%s hangup...\n", tty_name(tty, buf));
 #endif
-	schedule_task(&tty->tq_hangup);
+	schedule_work(&tty->hangup_work);
 }
 
 void tty_vhangup(struct tty_struct * tty)
@@ -1265,7 +1265,7 @@
 	/*
 	 * Make sure that the tty's task queue isn't activated. 
 	 */
-	flush_scheduled_tasks();
+	flush_scheduled_work();
 
 	/* 
 	 * The release_mem function takes care of the details of clearing
@@ -1874,8 +1874,8 @@
 }
 
 /*
- * The tq handling here is a little racy - tty->SAK_tq may already be queued.
- * Fortunately we don't need to worry, because if ->SAK_tq is already queued,
+ * The tq handling here is a little racy - tty->SAK_work may already be queued.
+ * Fortunately we don't need to worry, because if ->SAK_work is already queued,
  * the values which we write to it will be identical to the values which it
  * already has. --akpm
  */
@@ -1883,8 +1883,8 @@
 {
 	if (!tty)
 		return;
-	PREPARE_TQUEUE(&tty->SAK_tq, __do_SAK, tty);
-	schedule_task(&tty->SAK_tq);
+	PREPARE_WORK(&tty->SAK_work, __do_SAK, tty);
+	schedule_work(&tty->SAK_work);
 }
 
 /*
@@ -1900,7 +1900,7 @@
 	unsigned long flags;
 
 	if (test_bit(TTY_DONT_FLIP, &tty->flags)) {
-		schedule_task(&tty->flip.tqueue);
+		schedule_work(&tty->flip.work);
 		return;
 	}
 	if (tty->flip.buf_num) {
@@ -1977,7 +1977,7 @@
 	if (tty->low_latency)
 		flush_to_ldisc((void *) tty);
 	else
-		schedule_task(&tty->flip.tqueue);
+		schedule_work(&tty->flip.work);
 }
 
 /*
@@ -1991,18 +1991,16 @@
 	tty->pgrp = -1;
 	tty->flip.char_buf_ptr = tty->flip.char_buf;
 	tty->flip.flag_buf_ptr = tty->flip.flag_buf;
-	tty->flip.tqueue.routine = flush_to_ldisc;
-	tty->flip.tqueue.data = tty;
+	INIT_WORK(&tty->flip.work, flush_to_ldisc, tty);
 	init_MUTEX(&tty->flip.pty_sem);
 	init_waitqueue_head(&tty->write_wait);
 	init_waitqueue_head(&tty->read_wait);
-	tty->tq_hangup.routine = do_tty_hangup;
-	tty->tq_hangup.data = tty;
+	INIT_WORK(&tty->hangup_work, do_tty_hangup, tty);
 	sema_init(&tty->atomic_read, 1);
 	sema_init(&tty->atomic_write, 1);
 	spin_lock_init(&tty->read_lock);
 	INIT_LIST_HEAD(&tty->tty_files);
-	INIT_TQUEUE(&tty->SAK_tq, 0, 0);
+	INIT_WORK(&tty->SAK_work, NULL, NULL);
 }
 
 /*
--- linux/drivers/char/vt.c.orig	Mon Sep 30 16:35:15 2002
+++ linux/drivers/char/vt.c	Mon Sep 30 16:35:49 2002
@@ -161,9 +161,7 @@
 static int blankinterval = 10*60*HZ;
 static int vesa_off_interval;
 
-static struct tq_struct console_callback_tq = {
-	routine: console_callback,
-};
+static DECLARE_WORK(console_work, console_callback, NULL);
 
 /*
  * fg_console is the current virtual console,
@@ -241,7 +239,7 @@
 
 void schedule_console_callback(void)
 {
-	schedule_task(&console_callback_tq);
+	schedule_work(&console_work);
 }
 
 static void scrup(int currcons, unsigned int t, unsigned int b, int nr)
--- linux/drivers/char/random.c.orig	Mon Sep 30 16:36:48 2002
+++ linux/drivers/char/random.c	Mon Sep 30 16:38:34 2002
@@ -252,7 +252,7 @@
 #include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/fs.h>
-#include <linux/tqueue.h>
+#include <linux/workqueue.h>
 
 #include <asm/processor.h>
 #include <asm/uaccess.h>
@@ -624,8 +624,8 @@
 static int	*batch_entropy_credit;
 static int	batch_max;
 static int	batch_head, batch_tail;
-static struct tq_struct	batch_tqueue;
 static void batch_entropy_process(void *private_);
+static DECLARE_WORK(batch_work, batch_entropy_process, NULL);
 
 /* note: the size must be a power of 2 */
 static int __init batch_entropy_init(int size, struct entropy_store *r)
@@ -640,8 +640,7 @@
 	}
 	batch_head = batch_tail = 0;
 	batch_max = size;
-	batch_tqueue.routine = batch_entropy_process;
-	batch_tqueue.data = r;
+	batch_work.data = r;
 	return 0;
 }
 
@@ -665,7 +664,7 @@
 	new = (batch_head+1) & (batch_max-1);
 	if (new != batch_tail) {
 		// FIXME: is this correct?
-		schedule_task(&batch_tqueue);
+		schedule_work(&batch_work);
 		batch_head = new;
 	} else {
 		DEBUG_ENT("batch entropy buffer full\n");
@@ -1749,7 +1748,7 @@
 
 	sysctl_init_random(new_store);
 	old_store = random_state;
-	random_state = batch_tqueue.data = new_store;
+	random_state = batch_work.data = new_store;
 	free_entropy_store(old_store);
 	return 0;
 }
--- linux/drivers/block/floppy.c.orig	Mon Sep 30 17:19:17 2002
+++ linux/drivers/block/floppy.c	Mon Sep 30 17:23:10 2002
@@ -150,7 +150,7 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/timer.h>
-#include <linux/tqueue.h>
+#include <linux/workqueue.h>
 #define FDPATCHES
 #include <linux/fdreg.h>
 
@@ -1004,12 +1004,12 @@
 {
 }
 
-static struct tq_struct floppy_tq;
+static DECLARE_WORK(floppy_work, NULL, NULL);
 
 static void schedule_bh( void (*handler)(void*) )
 {
-	floppy_tq.routine = (void *)(void *) handler;
-	schedule_task(&floppy_tq);
+	PREPARE_WORK(&floppy_work, handler, NULL);
+	schedule_work(&floppy_work);
 }
 
 static struct timer_list fd_timer;
@@ -1017,7 +1017,7 @@
 static void cancel_activity(void)
 {
 	do_floppy = NULL;
-	floppy_tq.routine = (void *)(void *) empty;
+	PREPARE_WORK(&floppy_work, (void*)(void*)empty, NULL);
 	del_timer(&fd_timer);
 }
 
@@ -1886,8 +1886,8 @@
 	printk("fdc_busy=%lu\n", fdc_busy);
 	if (do_floppy)
 		printk("do_floppy=%p\n", do_floppy);
-	if (floppy_tq.sync)
-		printk("floppy_tq.routine=%p\n", floppy_tq.routine);
+	if (floppy_work.pending)
+		printk("floppy_work.routine=%p\n", floppy_work.routine);
 	if (timer_pending(&fd_timer))
 		printk("fd_timer.function=%p\n", fd_timer.function);
 	if (timer_pending(&fd_timeout)){
@@ -4360,7 +4360,7 @@
 	if (have_no_fdc) 
 	{
 		DPRINT("no floppy controllers found\n");
-		flush_scheduled_tasks();
+		flush_scheduled_work();
 		if (usage_count)
 			floppy_release_irq_and_dma();
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
@@ -4516,8 +4516,8 @@
 		printk("floppy timer still active:%s\n", timeout_message);
 	if (timer_pending(&fd_timer))
 		printk("auxiliary floppy timer still active\n");
-	if (floppy_tq.sync)
-		printk("task queue still active\n");
+	if (floppy_work.pending)
+		printk("work still pending\n");
 #endif
 	old_fdc = fdc;
 	for (fdc = 0; fdc < N_FDC; fdc++)
--- linux/drivers/input/mouse/psmouse.c.orig	Mon Sep 30 16:39:34 2002
+++ linux/drivers/input/mouse/psmouse.c	Mon Sep 30 16:41:04 2002
@@ -17,7 +17,6 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/init.h>
-#include <linux/tqueue.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("PS/2 mouse driver");
@@ -43,7 +42,6 @@
 	struct serio *serio;
 	char *vendor;
 	char *name;
-	struct tq_struct tq;
 	unsigned char cmdbuf[8];
 	unsigned char packet[8];
 	unsigned char cmdcnt;
--- linux/arch/i386/kernel/bluesmoke.c.orig	Mon Sep 30 17:17:56 2002
+++ linux/arch/i386/kernel/bluesmoke.c	Mon Sep 30 17:18:23 2002
@@ -306,15 +306,13 @@
 	add_timer (&mce_timer);
 } 
 
-static struct tq_struct mce_task = { 
-	.routine = do_mce_timer	
-};
+static DECLARE_WORK(mce_work, do_mce_timer, NULL);
 
 static void mce_timerfunc (unsigned long data)
 {
 #ifdef CONFIG_SMP
 	if (num_online_cpus() > 1) { 
-		schedule_task(&mce_task); 
+		schedule_work(&mce_work); 
 		return;
 	}
 #endif
--- linux/fs/reiserfs/journal.c.orig	Mon Sep 30 17:00:17 2002
+++ linux/fs/reiserfs/journal.c	Mon Sep 30 17:08:02 2002
@@ -59,12 +59,15 @@
 #include <linux/smp_lock.h>
 #include <linux/suspend.h>
 #include <linux/buffer_head.h>
+#include <linux/workqueue.h>
 
 /* the number of mounted filesystems.  This is used to decide when to
-** start and kill the commit thread
+** start and kill the commit workqueue
 */
 static int reiserfs_mounted_fs_count = 0 ;
 
+static workqueue_t *commit_wq;
+
 #define JOURNAL_TRANS_HALF 1018   /* must be correct to keep the desc and commit
 				     structs at 4k */
 #define BUFNR 64 /*read ahead */
@@ -1334,7 +1337,11 @@
 
   reiserfs_mounted_fs_count-- ;
   /* wait for all commits to finish */
-  flush_scheduled_tasks();
+  flush_workqueue(commit_wq);
+  if (!reiserfs_mounted_fs_count) {
+    destroy_workqueue(commit_wq);
+    commit_wq = NULL;
+  }
 
   release_journal_dev( p_s_sb, SB_JOURNAL( p_s_sb ) );
   free_journal_ram(p_s_sb) ;
@@ -1798,12 +1805,11 @@
                        ** is zero, we free the whole struct on finish
 		       */
   struct reiserfs_journal_commit_task *self ;
-  struct wait_queue *task_done ;
-  struct tq_struct task ;
+  work_t work;
 } ;
 
-static void reiserfs_journal_commit_task_func(struct reiserfs_journal_commit_task *ct) {
-
+static void reiserfs_journal_commit_task_func(void *__ct) {
+  struct reiserfs_journal_commit_task *ct = __ct;
   struct reiserfs_journal_list *jl ;
 
   /* FIXMEL: is this needed? */
@@ -1829,12 +1835,8 @@
   }
   ct->p_s_sb = p_s_sb ;
   ct->jindex = jindex ;
-  ct->task_done = NULL ;
-  INIT_LIST_HEAD(&ct->task.list) ;
-  ct->task.sync = 0 ;
-  ct->task.routine = (void *)(void *)reiserfs_journal_commit_task_func ; 
+  INIT_WORK(&ct->work, reiserfs_journal_commit_task_func, ct);
   ct->self = ct ;
-  ct->task.data = (void *)ct ;
 }
 
 static void commit_flush_async(struct super_block *p_s_sb, int jindex) {
@@ -1845,7 +1847,7 @@
   ct = reiserfs_kmalloc(sizeof(struct reiserfs_journal_commit_task), GFP_NOFS, p_s_sb) ;
   if (ct) {
     setup_commit_task_arg(ct, p_s_sb, jindex) ;
-    schedule_task(&ct->task) ;
+    queue_work(&ct->work, commit_wq) ;
   } else {
 #ifdef CONFIG_REISERFS_CHECK
     reiserfs_warning("journal-1540: kmalloc failed, doing sync commit\n") ;
@@ -2126,6 +2128,9 @@
     return 0;
 
   reiserfs_mounted_fs_count++ ;
+  if (reiserfs_mounted_fs_count <= 1)
+    commit_wq = create_workqueue("reiserfs");
+
   return 0 ;
 
 }
--- linux/fs/aio.c.orig	Mon Sep 30 16:11:02 2002
+++ linux/fs/aio.c	Mon Sep 30 16:59:16 2002
@@ -30,8 +30,8 @@
 #include <linux/compiler.h>
 #include <linux/brlock.h>
 #include <linux/module.h>
-#include <linux/tqueue.h>
 #include <linux/highmem.h>
+#include <linux/workqueue.h>
 
 #include <asm/kmap_types.h>
 #include <asm/uaccess.h>
@@ -50,11 +50,11 @@
 static kmem_cache_t	*kiocb_cachep;
 static kmem_cache_t	*kioctx_cachep;
 
+static workqueue_t *aio_wq;
+
 /* Used for rare fput completion. */
 static void aio_fput_routine(void *);
-static struct tq_struct	fput_tqueue = {
-	.routine	= aio_fput_routine,
-};
+static DECLARE_WORK(fput_work, aio_fput_routine, NULL);
 
 static spinlock_t	fput_lock = SPIN_LOCK_UNLOCKED;
 LIST_HEAD(fput_head);
@@ -75,6 +75,8 @@
 	if (!kioctx_cachep)
 		panic("unable to create kioctx cache");
 
+	aio_wq = create_workqueue("aio");
+
 	printk(KERN_NOTICE "aio_setup: sizeof(struct page) = %d\n", (int)sizeof(struct page));
 
 	return 0;
@@ -196,8 +198,7 @@
 
 static inline void put_aio_ring_event(struct io_event *event, enum km_type km)
 {
-	void *p = (void *)((unsigned long)event & PAGE_MASK);
-	kunmap_atomic(p, km);
+	kunmap_atomic((void *)((unsigned long)event & PAGE_MASK), km);
 }
 
 /* ioctx_alloc
@@ -475,14 +476,14 @@
 	req->ki_cancel = NULL;
 
 	/* Must be done under the lock to serialise against cancellation.
-	 * Call this aio_fput as it duplicates fput via the fput_tqueue.
+	 * Call this aio_fput as it duplicates fput via the fput_work.
 	 */
 	if (unlikely(atomic_dec_and_test(&req->ki_filp->f_count))) {
 		get_ioctx(ctx);
 		spin_lock(&fput_lock);
 		list_add(&req->ki_list, &fput_head);
 		spin_unlock(&fput_lock);
-		schedule_task(&fput_tqueue);
+		queue_work(&fput_work, aio_wq);
 	} else
 		really_put_req(ctx, req);
 	return 1;
--- linux/include/linux/sunrpc/sched.h.orig	Mon Sep 30 17:44:06 2002
+++ linux/include/linux/sunrpc/sched.h	Mon Sep 30 17:44:08 2002
@@ -10,7 +10,6 @@
 #define _LINUX_SUNRPC_SCHED_H_
 
 #include <linux/timer.h>
-#include <linux/tqueue.h>
 #include <linux/sunrpc/types.h>
 #include <linux/wait.h>
 
--- linux/include/linux/tty.h.orig	Mon Sep 30 16:26:19 2002
+++ linux/include/linux/tty.h	Mon Sep 30 16:29:43 2002
@@ -20,7 +20,7 @@
 #include <linux/fs.h>
 #include <linux/major.h>
 #include <linux/termios.h>
-#include <linux/tqueue.h>
+#include <linux/workqueue.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_ldisc.h>
 
@@ -138,7 +138,7 @@
 #define TTY_FLIPBUF_SIZE 512
 
 struct tty_flip_buffer {
-	struct tq_struct tqueue;
+	work_t		work;
 	struct semaphore pty_sem;
 	char		*char_buf_ptr;
 	unsigned char	*flag_buf_ptr;
@@ -279,7 +279,7 @@
 	int alt_speed;		/* For magic substitution of 38400 bps */
 	wait_queue_head_t write_wait;
 	wait_queue_head_t read_wait;
-	struct tq_struct tq_hangup;
+	work_t hangup_work;
 	void *disc_data;
 	void *driver_data;
 	struct list_head tty_files;
@@ -309,7 +309,7 @@
 	struct semaphore atomic_write;
 	spinlock_t read_lock;
 	/* If the tty has a pending do_SAK, queue it here - akpm */
-	struct tq_struct SAK_tq;
+	work_t SAK_work;
 };
 
 /* tty magic number */
--- linux/include/linux/workqueue.h.orig	Mon Sep 30 13:13:52 2002
+++ linux/include/linux/workqueue.h	Mon Sep 30 16:44:43 2002
@@ -0,0 +1,57 @@
+/*
+ * workqueue.h --- work queue handling for Linux.
+ */
+
+#ifndef _LINUX_WORKQUEUE_H
+#define _LINUX_WORKQUEUE_H
+
+typedef struct work_s {
+	unsigned long pending;
+	struct list_head entry;
+	void (*routine)(void *);
+	void *data;
+} work_t;
+
+#define __WORK_INITIALIZER(n, f, d) {				\
+        .entry	= { &(n).entry, &(n).entry },			\
+	.routine = (f),						\
+	.data = (d) }
+
+#define DECLARE_WORK(n, f, d)					\
+	work_t n = __WORK_INITIALIZER(n, f, d)
+
+struct workqueue_s;
+typedef struct workqueue_s workqueue_t;
+
+/*
+ * initialize a work-struct's routine and data pointers:
+ */
+#define PREPARE_WORK(_work, _routine, _data)			\
+	do {							\
+		(_work)->routine = _routine;			\
+		(_work)->data = _data;				\
+	} while (0)
+
+/*
+ * initialize all of a work-struct:
+ */
+#define INIT_WORK(_work, _routine, _data)			\
+	do {							\
+		INIT_LIST_HEAD(&(_work)->entry);		\
+		(_work)->pending = 0;				\
+		PREPARE_WORK((_work), (_routine), (_data));	\
+	} while (0)
+
+extern workqueue_t *create_workqueue(const char *name);
+extern void destroy_workqueue(workqueue_t *wq);
+extern int queue_work(work_t *work, workqueue_t *wq);
+extern void flush_workqueue(workqueue_t *wq);
+
+extern int schedule_work(work_t *work);
+extern void flush_scheduled_work(void);
+extern int current_is_keventd(void);
+
+extern void init_workqueues(void);
+
+#endif
+
--- linux/include/linux/tqueue.h.orig	Mon Sep 30 16:09:05 2002
+++ linux/include/linux/tqueue.h	Mon Sep 30 16:25:51 2002
@@ -1,55 +0,0 @@
-/*
- * tqueue.h --- task queue handling for Linux.
- *
- * Modified version of previous incarnations of task-queues,
- * written by:
- *
- * (C) 1994 Kai Petzke, wpp@marie.physik.tu-berlin.de
- * Modified for use in the Linux kernel by Theodore Ts'o,
- * tytso@mit.edu.
- */
-
-#ifndef _LINUX_TQUEUE_H
-#define _LINUX_TQUEUE_H
-
-#include <linux/spinlock.h>
-#include <linux/list.h>
-#include <linux/bitops.h>
-#include <asm/system.h>
-
-struct tq_struct {
-	struct list_head list;		/* linked list of active tq's */
-	unsigned long sync;		/* must be initialized to zero */
-	void (*routine)(void *);	/* function to call */
-	void *data;			/* argument to function */
-};
-
-/*
- * Emit code to initialise a tq_struct's routine and data pointers
- */
-#define PREPARE_TQUEUE(_tq, _routine, _data)			\
-	do {							\
-		(_tq)->routine = _routine;			\
-		(_tq)->data = _data;				\
-	} while (0)
-
-/*
- * Emit code to initialise all of a tq_struct
- */
-#define INIT_TQUEUE(_tq, _routine, _data)			\
-	do {							\
-		INIT_LIST_HEAD(&(_tq)->list);			\
-		(_tq)->sync = 0;				\
-		PREPARE_TQUEUE((_tq), (_routine), (_data));	\
-	} while (0)
-
-#define DECLARE_TASK_QUEUE(q)	LIST_HEAD(q)
-
-/* Schedule a tq to run in process context */
-extern int schedule_task(struct tq_struct *task);
-
-/* finish all currently pending tasks - do not call from irq context */
-extern void flush_scheduled_tasks(void);
-
-#endif
-
--- linux/include/linux/serialP.h.orig	Mon Sep 30 16:42:13 2002
+++ linux/include/linux/serialP.h	Mon Sep 30 16:42:35 2002
@@ -21,7 +21,7 @@
 
 #include <linux/config.h>
 #include <linux/termios.h>
-#include <linux/tqueue.h>
+#include <linux/workqueue.h>
 #include <linux/circ_buf.h>
 #include <linux/wait.h>
 #if (LINUX_VERSION_CODE < 0x020300)
@@ -86,7 +86,7 @@
 	u8			*iomem_base;
 	u16			iomem_reg_shift;
 	int			io_type;
-	struct tq_struct	tqueue;
+	work_t			work;
 #ifdef DECLARE_WAITQUEUE
 	wait_queue_head_t	open_wait;
 	wait_queue_head_t	close_wait;
--- linux/include/linux/tty_flip.h.orig	Mon Sep 30 16:30:57 2002
+++ linux/include/linux/tty_flip.h	Mon Sep 30 16:31:08 2002
@@ -19,7 +19,7 @@
 
 _INLINE_ void tty_schedule_flip(struct tty_struct *tty)
 {
-	schedule_task(&tty->flip.tqueue);
+	schedule_work(&tty->flip.work);
 }
 
 #undef _INLINE_
--- linux/include/linux/kbd_kern.h.orig	Mon Sep 30 16:31:23 2002
+++ linux/include/linux/kbd_kern.h	Mon Sep 30 16:31:48 2002
@@ -150,7 +150,7 @@
 
 static inline void con_schedule_flip(struct tty_struct *t)
 {
-	schedule_task(&t->flip.tqueue);
+	schedule_work(&t->flip.work);
 }
 
 #endif
--- linux/include/linux/sched.h.orig	Mon Sep 30 16:44:26 2002
+++ linux/include/linux/sched.h	Mon Sep 30 16:44:31 2002
@@ -172,9 +172,6 @@
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
 
-extern int start_context_thread(void);
-extern int current_is_keventd(void);
-
 struct namespace;
 
 /* Maximum number of active map areas.. This is a random (large) number */
--- linux/include/linux/blkdev.h.orig	Mon Sep 30 17:43:37 2002
+++ linux/include/linux/blkdev.h	Mon Sep 30 17:43:40 2002
@@ -4,7 +4,6 @@
 #include <linux/major.h>
 #include <linux/sched.h>
 #include <linux/genhd.h>
-#include <linux/tqueue.h>
 #include <linux/list.h>
 #include <linux/pagemap.h>
 #include <linux/backing-dev.h>
--- linux/kernel/context.c.orig	Mon Sep 30 12:15:45 2002
+++ linux/kernel/context.c	Mon Sep 30 16:20:32 2002
@@ -1,221 +0,0 @@
-/*
- * linux/kernel/context.c
- *
- * Mechanism for running arbitrary tasks in process context
- *
- * dwmw2@redhat.com:		Genesis
- *
- * andrewm@uow.edu.au:		2.4.0-test12
- *	- Child reaping
- *	- Support for tasks which re-add themselves
- *	- flush_scheduled_tasks.
- */
-
-#define __KERNEL_SYSCALLS__
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/init.h>
-#include <linux/unistd.h>
-#include <linux/signal.h>
-#include <linux/completion.h>
-#include <linux/tqueue.h>
-
-static DECLARE_TASK_QUEUE(tq_context);
-static DECLARE_WAIT_QUEUE_HEAD(context_task_wq);
-static DECLARE_WAIT_QUEUE_HEAD(context_task_done);
-static int keventd_running;
-static struct task_struct *keventd_task;
-
-static spinlock_t tqueue_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
-
-typedef struct list_head task_queue;
-
-/*
- * Queue a task on a tq.  Return non-zero if it was successfully
- * added.
- */
-static inline int queue_task(struct tq_struct *tq, task_queue *list)
-{
-	int ret = 0;
-	unsigned long flags;
-
-	if (!test_and_set_bit(0, &tq->sync)) {
-		spin_lock_irqsave(&tqueue_lock, flags);
-		list_add_tail(&tq->list, list);
-		spin_unlock_irqrestore(&tqueue_lock, flags);
-		ret = 1;
-	}
-	return ret;
-}
-
-#define TQ_ACTIVE(q)	(!list_empty(&q))
-
-static inline void run_task_queue(task_queue *list)
-{
-	struct list_head head, *next;
-	unsigned long flags;
-
-	if (!TQ_ACTIVE(*list))
-		return;
-
-	spin_lock_irqsave(&tqueue_lock, flags);
-	list_add(&head, list);
-	list_del_init(list);
-	spin_unlock_irqrestore(&tqueue_lock, flags);
-
-	next = head.next;
-	while (next != &head) {
-		void (*f) (void *);
-		struct tq_struct *p;
-		void *data;
-
-		p = list_entry(next, struct tq_struct, list);
-		next = next->next;
-		f = p->routine;
-		data = p->data;
-		wmb();
-		p->sync = 0;
-		if (f)
-			f(data);
-	}
-}
-
-static int need_keventd(const char *who)
-{
-	if (keventd_running == 0)
-		printk(KERN_ERR "%s(): keventd has not started\n", who);
-	return keventd_running;
-}
-	
-int current_is_keventd(void)
-{
-	int ret = 0;
-	if (need_keventd(__FUNCTION__))
-		ret = (current == keventd_task);
-	return ret;
-}
-
-/**
- * schedule_task - schedule a function for subsequent execution in process context.
- * @task: pointer to a &tq_struct which defines the function to be scheduled.
- *
- * May be called from interrupt context.  The scheduled function is run at some
- * time in the near future by the keventd kernel thread.  If it can sleep, it
- * should be designed to do so for the minimum possible time, as it will be
- * stalling all other scheduled tasks.
- *
- * schedule_task() returns non-zero if the task was successfully scheduled.
- * If @task is already residing on a task queue then schedule_task() fails
- * to schedule your task and returns zero.
- */
-int schedule_task(struct tq_struct *task)
-{
-	int ret;
-	need_keventd(__FUNCTION__);
-	ret = queue_task(task, &tq_context);
-	wake_up(&context_task_wq);
-	return ret;
-}
-
-static int context_thread(void *startup)
-{
-	struct task_struct *curtask = current;
-	DECLARE_WAITQUEUE(wait, curtask);
-	struct k_sigaction sa;
-
-	daemonize();
-	strcpy(curtask->comm, "keventd");
-	current->flags |= PF_IOTHREAD;
-	keventd_running = 1;
-	keventd_task = curtask;
-
-	spin_lock_irq(&curtask->sig->siglock);
-	siginitsetinv(&curtask->blocked, sigmask(SIGCHLD));
-	recalc_sigpending();
-	spin_unlock_irq(&curtask->sig->siglock);
-
-	complete((struct completion *)startup);
-
-	/* Install a handler so SIGCLD is delivered */
-	sa.sa.sa_handler = SIG_IGN;
-	sa.sa.sa_flags = 0;
-	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
-	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
-
-	/*
-	 * If one of the functions on a task queue re-adds itself
-	 * to the task queue we call schedule() in state TASK_RUNNING
-	 */
-	for (;;) {
-		set_task_state(curtask, TASK_INTERRUPTIBLE);
-		add_wait_queue(&context_task_wq, &wait);
-		if (TQ_ACTIVE(tq_context))
-			set_task_state(curtask, TASK_RUNNING);
-		schedule();
-		remove_wait_queue(&context_task_wq, &wait);
-		run_task_queue(&tq_context);
-		wake_up(&context_task_done);
-		if (signal_pending(curtask)) {
-			while (waitpid(-1, (unsigned int *)0, __WALL|WNOHANG) > 0)
-				;
-			spin_lock_irq(&curtask->sig->siglock);
-			flush_signals(curtask);
-			recalc_sigpending();
-			spin_unlock_irq(&curtask->sig->siglock);
-		}
-	}
-}
-
-/**
- * flush_scheduled_tasks - ensure that any scheduled tasks have run to completion.
- *
- * Forces execution of the schedule_task() queue and blocks until its completion.
- *
- * If a kernel subsystem uses schedule_task() and wishes to flush any pending
- * tasks, it should use this function.  This is typically used in driver shutdown
- * handlers.
- *
- * The caller should hold no spinlocks and should hold no semaphores which could
- * cause the scheduled tasks to block.
- */
-static struct tq_struct dummy_task;
-
-void flush_scheduled_tasks(void)
-{
-	int count;
-	DECLARE_WAITQUEUE(wait, current);
-
-	/*
-	 * Do it twice. It's possible, albeit highly unlikely, that
-	 * the caller queued a task immediately before calling us,
-	 * and that the eventd thread was already past the run_task_queue()
-	 * but not yet into wake_up(), so it woke us up before completing
-	 * the caller's queued task or our new dummy task.
-	 */
-	add_wait_queue(&context_task_done, &wait);
-	for (count = 0; count < 2; count++) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-
-		/* Queue a dummy task to make sure we get kicked */
-		schedule_task(&dummy_task);
-
-		/* Wait for it to complete */
-		schedule();
-	}
-	remove_wait_queue(&context_task_done, &wait);
-}
-	
-int start_context_thread(void)
-{
-	static struct completion startup __initdata = COMPLETION_INITIALIZER(startup);
-
-	kernel_thread(context_thread, &startup, CLONE_FS | CLONE_FILES);
-	wait_for_completion(&startup);
-	return 0;
-}
-
-EXPORT_SYMBOL(schedule_task);
-EXPORT_SYMBOL(flush_scheduled_tasks);
-
--- linux/kernel/workqueue.c.orig	Mon Sep 30 12:20:25 2002
+++ linux/kernel/workqueue.c	Mon Sep 30 17:45:49 2002
@@ -0,0 +1,241 @@
+/*
+ * linux/kernel/workqueue.c
+ *
+ * Generic mechanism for defining kernel helper threads for running
+ * arbitrary tasks in process context.
+ *
+ * Started by Ingo Molnar, Copyright (C) 2002
+ *
+ * Derived from the taskqueue/keventd code by:
+ *
+ *   David Woodhouse <dwmw2@redhat.com>
+ *   Andrew Morton <andrewm@uow.edu.au>
+ *   Kai Petzke <wpp@marie.physik.tu-berlin.de>
+ *   Theodore Ts'o <tytso@mit.edu>
+ */
+
+#define __KERNEL_SYSCALLS__
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/unistd.h>
+#include <linux/signal.h>
+#include <linux/completion.h>
+#include <linux/workqueue.h>
+#include <linux/slab.h>
+
+struct workqueue_s {
+	spinlock_t lock;
+	task_t *thread;
+	struct list_head worklist;
+	wait_queue_head_t more_work;
+
+	struct completion startup;
+	struct completion exit;
+	const char *name;
+};
+
+/*
+ * Queue work on a workqueue. Return non-zero if it was successfully
+ * added.
+ */
+int queue_work(work_t *work, workqueue_t *wq)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	if (!test_and_set_bit(0, &work->pending)) {
+		BUG_ON(!list_empty(&work->entry));
+		spin_lock_irqsave(&wq->lock, flags);
+		list_add_tail(&work->entry, &wq->worklist);
+		spin_unlock_irqrestore(&wq->lock, flags);
+		wake_up(&wq->more_work);
+		ret = 1;
+	}
+	return ret;
+}
+
+static inline void run_workqueue(workqueue_t *wq)
+{
+	struct list_head head, *l, *n;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&head);
+	/*
+	 * Split off the current amount of work from
+	 * the worklist and keep the workqueue unlocked
+	 * while processing the local list.
+	 */
+	spin_lock_irqsave(&wq->lock, flags);
+	list_splice_init(&wq->worklist, &head);
+	spin_unlock_irqrestore(&wq->lock, flags);
+
+	list_for_each_safe(l, n, &head) {
+		work_t *work = list_entry(l, work_t, entry);
+		void (*f) (void *);
+		void *data;
+
+		f = work->routine;
+		data = work->data;
+
+		list_del_init(l);
+		clear_bit(0, &work->pending);
+		f(data);
+	}
+}
+
+static int worker_thread(void *__wq)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	workqueue_t *wq = __wq;
+	struct k_sigaction sa;
+
+	daemonize();
+	sprintf(current->comm, "wq: %s", wq->name);
+	current->flags |= PF_IOTHREAD;
+	wq->thread = current;
+	wq->name = NULL;
+
+	spin_lock_irq(&current->sig->siglock);
+	siginitsetinv(&current->blocked, sigmask(SIGCHLD));
+	recalc_sigpending();
+	spin_unlock_irq(&current->sig->siglock);
+
+	complete(&wq->startup);
+
+	/* Install a handler so SIGCLD is delivered */
+	sa.sa.sa_handler = SIG_IGN;
+	sa.sa.sa_flags = 0;
+	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
+	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
+
+	for (;;) {
+		set_task_state(current, TASK_INTERRUPTIBLE);
+
+		add_wait_queue(&wq->more_work, &wait);
+		if (!wq->thread)
+			break;
+		if (list_empty(&wq->worklist))
+			schedule();
+		else
+			set_task_state(current, TASK_RUNNING);
+		remove_wait_queue(&wq->more_work, &wait);
+
+		while (!list_empty(&wq->worklist))
+			run_workqueue(wq);
+
+		if (signal_pending(current)) {
+			while (waitpid(-1, NULL, __WALL|WNOHANG) > 0)
+				/* SIGCHLD - auto-reaping */ ;
+
+			/* zap all other signals */
+			spin_lock_irq(&current->sig->siglock);
+			flush_signals(current);
+			recalc_sigpending();
+			spin_unlock_irq(&current->sig->siglock);
+		}
+	}
+	remove_wait_queue(&wq->more_work, &wait);
+	complete(&wq->exit);
+
+	return 0;
+}
+
+static void flush_done(void *__done)
+{
+	complete(__done);
+}
+
+/*
+ * flush_workqueue - ensure that any scheduled work has run to completion.
+ *
+ * Forces execution of the workqueue and blocks until its completion.
+ * This is typically used in driver shutdown handlers.
+ */
+void flush_workqueue(workqueue_t *wq)
+{
+	struct completion done;
+	work_t work;
+
+	while (!list_empty(&wq->worklist)) {
+		INIT_WORK(&work, flush_done, &done);
+		init_completion(&done);
+		queue_work(&work, wq);
+		wait_for_completion(&done);
+	}
+}
+
+workqueue_t *create_workqueue(const char *name)
+{
+	workqueue_t *wq;
+	int ret;
+
+	if (strlen(name) > 10)
+		return NULL;
+
+	wq = kmalloc(sizeof(*wq), GFP_KERNEL);
+	if (!wq)
+		return NULL;
+
+	spin_lock_init(&wq->lock);
+	wq->thread = NULL;
+	INIT_LIST_HEAD(&wq->worklist);
+	init_waitqueue_head(&wq->more_work);
+	init_completion(&wq->startup);
+	wq->name = name;
+
+	ret = kernel_thread(worker_thread, wq, CLONE_FS | CLONE_FILES);
+	if (ret < 0) {
+		kfree(wq);
+		return NULL;
+	}
+	wait_for_completion(&wq->startup);
+	BUG_ON(!wq->thread);
+
+	return wq;
+}
+
+void destroy_workqueue(workqueue_t *wq)
+{
+	init_completion(&wq->exit);
+	wq->thread = NULL;
+	wake_up(&wq->more_work);
+
+	wait_for_completion(&wq->exit);
+	kfree(wq);
+}
+
+static workqueue_t *keventd_wq;
+
+int schedule_work(work_t *work)
+{
+	return queue_work(work, keventd_wq);
+}
+
+void flush_scheduled_work(void)
+{
+	flush_workqueue(keventd_wq);
+}
+
+int current_is_keventd(void)
+{
+	BUG_ON(!keventd_wq);
+	return current == keventd_wq->thread;
+}
+
+void init_workqueues(void)
+{
+	keventd_wq = create_workqueue("events");
+	BUG_ON(!keventd_wq);
+}
+
+EXPORT_SYMBOL_GPL(create_workqueue);
+EXPORT_SYMBOL_GPL(queue_work);
+EXPORT_SYMBOL_GPL(flush_workqueue);
+EXPORT_SYMBOL_GPL(destroy_workqueue);
+
+EXPORT_SYMBOL(schedule_work);
+EXPORT_SYMBOL(flush_scheduled_work);
+
--- linux/kernel/Makefile.orig	Mon Sep 30 13:27:25 2002
+++ linux/kernel/Makefile	Mon Sep 30 16:09:24 2002
@@ -2,13 +2,13 @@
 # Makefile for the linux kernel.
 #
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
+export-objs = signal.o sys.o kmod.o workqueue.o ksyms.o pm.o exec_domain.o \
 	      printk.o platform.o suspend.o dma.o module.o cpufreq.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o pid.o
+	    signal.o sys.o kmod.o workqueue.o futex.o platform.o pid.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
--- linux/kernel/sys.c.orig	Mon Sep 30 16:20:45 2002
+++ linux/kernel/sys.c	Mon Sep 30 16:25:24 2002
@@ -16,7 +16,7 @@
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/fs.h>
-#include <linux/tqueue.h>
+#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/times.h>
 #include <linux/security.h>
@@ -442,12 +442,10 @@
  */
 void ctrl_alt_del(void)
 {
-	static struct tq_struct cad_tq = {
-		.routine = deferred_cad,
-	};
+	static DECLARE_WORK(cad_work, deferred_cad, NULL);
 
 	if (C_A_D)
-		schedule_task(&cad_tq);
+		schedule_work(&cad_work);
 	else
 		kill_proc(cad_pid, SIGINT, 1);
 }
--- linux/kernel/kmod.c.orig	Mon Sep 30 16:23:17 2002
+++ linux/kernel/kmod.c	Mon Sep 30 16:25:00 2002
@@ -28,7 +28,7 @@
 #include <linux/namespace.h>
 #include <linux/completion.h>
 #include <linux/file.h>
-#include <linux/tqueue.h>
+#include <linux/workqueue.h>
 
 #include <asm/uaccess.h>
 
@@ -346,18 +346,15 @@
  */
 int call_usermodehelper(char *path, char **argv, char **envp)
 {
-	DECLARE_COMPLETION(work);
+	DECLARE_COMPLETION(done);
 	struct subprocess_info sub_info = {
-		.complete	= &work,
+		.complete	= &done,
 		.path		= path,
 		.argv		= argv,
 		.envp		= envp,
 		.retval		= 0,
 	};
-	struct tq_struct tqs = {
-		.routine	= __call_usermodehelper,
-		.data		= &sub_info,
-	};
+	DECLARE_WORK(work, __call_usermodehelper, &sub_info);
 
 	if (!system_running)
 		return -EBUSY;
@@ -369,8 +366,8 @@
 		/* We can't wait on keventd! */
 		__call_usermodehelper(&sub_info);
 	} else {
-		schedule_task(&tqs);
-		wait_for_completion(&work);
+		schedule_work(&work);
+		wait_for_completion(&done);
 	}
 out:
 	return sub_info.retval;
--- linux/init/main.c.orig	Mon Sep 30 16:03:26 2002
+++ linux/init/main.c	Mon Sep 30 16:36:26 2002
@@ -30,6 +30,7 @@
 #include <linux/percpu.h>
 #include <linux/kernel_stat.h>
 #include <linux/security.h>
+#include <linux/workqueue.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -477,7 +478,7 @@
 	} while (call < &__initcall_end);
 
 	/* Make sure there is no pending stuff from the initcall sequence */
-	flush_scheduled_tasks();
+	flush_scheduled_work();
 }
 
 /*
@@ -503,7 +504,7 @@
 	/* Networking initialization needs a process context */ 
 	sock_init();
 
-	start_context_thread();
+	init_workqueues();
 	do_initcalls();
 }
 

