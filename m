Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261601AbSJIMaJ>; Wed, 9 Oct 2002 08:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261768AbSJIMaJ>; Wed, 9 Oct 2002 08:30:09 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:35536 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261601AbSJIM3y> convert rfc822-to-8bit; Wed, 9 Oct 2002 08:29:54 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.41 s390 (2/8): work queues.
Date: Wed, 9 Oct 2002 14:28:29 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210091428.29362.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all tq_structs from s390 driver code.

diff -urN linux-2.5.41/drivers/s390/block/dasd.c linux-2.5.41-s390/drivers/s390/block/dasd.c
--- linux-2.5.41/drivers/s390/block/dasd.c	Mon Oct  7 20:24:13 2002
+++ linux-2.5.41-s390/drivers/s390/block/dasd.c	Wed Oct  9 14:01:13 2002
@@ -93,6 +93,7 @@
 static void dasd_int_handler(int, void *, struct pt_regs *);
 static void dasd_flush_ccw_queue(dasd_device_t *, int);
 static void dasd_tasklet(dasd_device_t *);
+static void do_kick_device(void *data);
 
 /*
  * Parameter parsing functions. There are two for the dasd driver:
@@ -254,6 +255,7 @@
 		     (unsigned long) device);
 	INIT_LIST_HEAD(&device->ccw_queue);
 	init_timer(&device->timer);
+	INIT_WORK(&device->kick_work, do_kick_device, (void *) (addr_t) device->devinfo.devno);
 	device->state = DASD_STATE_NEW;
 	device->target = DASD_STATE_NEW;
 
@@ -590,11 +592,13 @@
  * event daemon.
  */
 static void
-do_kick_device(int devno)
+do_kick_device(void *data)
 {
+	int devno;
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
 
+	devno = (long) data;
 	devmap = dasd_devmap_from_devno(devno);
 	device = (devmap != NULL) ?
 		dasd_get_device(devmap) : ERR_PTR(-ENODEV);
@@ -610,10 +614,8 @@
 dasd_kick_device(dasd_device_t *device)
 {
 	atomic_inc(&device->ref_count);
-	device->kick_tq.routine = (void *) do_kick_device;
-	device->kick_tq.data = (void *) (addr_t) device->devinfo.devno;
 	/* queue call to dasd_kick_device to the kernel event daemon. */
-	schedule_task(&device->kick_tq);
+	schedule_work(&device->kick_work);
 }
 
 /*
@@ -784,7 +786,7 @@
 do_not_oper_handler(void *data)
 {
 	struct {
-		struct tq_struct tq;
+		struct work_struct work;
 		int irq;
 	} *p;
 	dasd_device_t *device;
@@ -815,7 +817,7 @@
 dasd_not_oper_handler(int irq, int status)
 {
 	struct {
-		struct tq_struct tq;
+		struct work_struct work;
 		int irq;
 	} *p;
 
@@ -823,11 +825,10 @@
 	if (p == NULL)
 		/* FIXME: No memory, we loose. */
 		return;
-	p->tq.routine = (void *) do_not_oper_handler;
-	p->tq.data = (void *) p;
+	INIT_WORK(&p->work, (void *) do_not_oper_handler, p);
 	p->irq = irq;
 	/* queue call to do_not_oper_handler to the kernel event daemon. */
-	schedule_task(&p->tq);
+	schedule_work(&p->work);
 }
 
 /*
@@ -837,7 +838,7 @@
 do_oper_handler(void *data)
 {
 	struct {
-		struct tq_struct tq;
+		struct work_struct work;
 		int devno;
 	} *p;
 	dasd_devmap_t *devmap;
@@ -868,7 +869,7 @@
 dasd_oper_handler(int irq, devreg_t * devreg)
 {
 	struct {
-		struct tq_struct tq;
+		struct work_struct work;
 		int devno;
 	} *p;
 
@@ -879,10 +880,9 @@
 	p->devno = get_devno_by_irq(irq);
 	if (p->devno == -ENODEV)
 		return -ENODEV;
-	p->tq.routine = (void *) do_oper_handler;
-	p->tq.data = (void *) p;
+	INIT_WORK(&p->work, (void *) do_oper_handler, p);
 	/* queue call to do_oper_handler to the kernel event daemon. */
-	schedule_task(&p->tq);
+	schedule_work(&p->work);
         return 0;
 
 }
@@ -1317,7 +1317,7 @@
 do_state_change_pending(void *data)
 {
 	struct {
-		struct tq_struct tq;
+		struct work_struct work;
 		unsigned short devno;
 	} *p;
 	dasd_devmap_t *devmap;
@@ -1355,7 +1355,7 @@
 dasd_handle_state_change_pending(devstat_t * stat)
 {
 	struct {
-		struct tq_struct tq;
+		struct work_struct work;
 		unsigned short devno;
 	} *p;
 
@@ -1363,11 +1363,10 @@
 	if (p == NULL)
 		/* No memory, let the timeout do the reactivation. */
 		return;
-	p->tq.routine = (void *) do_state_change_pending;
-	p->tq.data = (void *) p;
+	INIT_WORK(&p->work, (void *) do_state_change_pending, p);
 	p->devno = stat->devno;
 	/* queue call to do_state_change_pending to the kernel event daemon. */
-	schedule_task(&p->tq);
+	schedule_work(&p->work);
 }
 
 /*
diff -urN linux-2.5.41/drivers/s390/block/dasd_int.h linux-2.5.41-s390/drivers/s390/block/dasd_int.h
--- linux-2.5.41/drivers/s390/block/dasd_int.h	Mon Oct  7 20:24:46 2002
+++ linux-2.5.41-s390/drivers/s390/block/dasd_int.h	Wed Oct  9 14:01:13 2002
@@ -58,6 +58,7 @@
 #include <linux/genhd.h>
 #include <linux/hdreg.h>
 #include <linux/interrupt.h>
+#include <linux/workqueue.h>
 #include <asm/debug.h>
 #include <asm/dasd.h>
 #include <asm/idals.h>
@@ -292,7 +293,7 @@
 
 	atomic_t tasklet_scheduled;
         struct tasklet_struct tasklet;
-	struct tq_struct kick_tq;
+	struct work_struct kick_work;
 	struct timer_list timer;
 
 	debug_info_t *debug_area;
diff -urN linux-2.5.41/drivers/s390/char/ctrlchar.c linux-2.5.41-s390/drivers/s390/char/ctrlchar.c
--- linux-2.5.41/drivers/s390/char/ctrlchar.c	Mon Oct  7 20:25:20 2002
+++ linux-2.5.41-s390/drivers/s390/char/ctrlchar.c	Wed Oct  9 14:01:13 2002
@@ -23,10 +23,7 @@
 	handle_sysrq(ctrlchar_sysrq_key, NULL, tty);
 }
 
-static struct tq_struct ctrlchar_tq = {
-	.list = LIST_HEAD_INIT(ctrlchar_tq.list),
-	.routine = ctrlchar_handle_sysrq,
-};
+static DECLARE_WORK(ctrlchar_work, ctrlchar_handle_sysrq, 0);
 #endif
 
 
@@ -56,8 +53,8 @@
 	/* racy */
 	if (len == 3 && buf[1] == '-') {
 		ctrlchar_sysrq_key = buf[2];
-		ctrlchar_tq.data = tty;
-		schedule_task(&ctrlchar_tq);
+		ctrlchar_work.data = tty;
+		schedule_work(&ctrlchar_work);
 		return CTRLCHAR_SYSRQ;
 	}
 #endif
diff -urN linux-2.5.41/drivers/s390/misc/chandev.c linux-2.5.41-s390/drivers/s390/misc/chandev.c
--- linux-2.5.41/drivers/s390/misc/chandev.c	Mon Oct  7 20:24:06 2002
+++ linux-2.5.41-s390/drivers/s390/misc/chandev.c	Wed Oct  9 14:01:13 2002
@@ -24,7 +24,7 @@
 #include <asm/s390dyn.h>
 #include <asm/queue.h>
 #include <linux/kmod.h>
-#include <linux/tqueue.h>
+#include <linux/workqueue.h>
 #ifndef MIN
 #define MIN(a,b) ((a<b)?a:b)
 #endif
@@ -190,8 +190,8 @@
 
 static unsigned long chandev_last_machine_check;
 
-
-static struct tq_struct chandev_msck_task_tq;
+static void chandev_msck_task(void *unused);
+static DECLARE_WORK(chandev_msck_work, chandev_msck_task, 0);
 static atomic_t chandev_msck_thread_lock;
 static atomic_t chandev_new_msck;
 static unsigned long chandev_last_startmsck_list_update;
@@ -666,7 +666,7 @@
 	chandev_last_machine_check=jiffies;
 	if(atomic_dec_and_test(&chandev_msck_thread_lock))
 	{
-		schedule_task(&chandev_msck_task_tq);
+		schedule_work(&chandev_msck_work);
 	}
 	atomic_set(&chandev_new_msck,TRUE);
 	return(0);
@@ -686,7 +686,7 @@
 		spin_unlock(&chandev_not_oper_spinlock);
 		if(atomic_dec_and_test(&chandev_msck_thread_lock))
 		{
-			schedule_task(&chandev_msck_task_tq);
+			schedule_work(&chandev_msck_work);
 		}
 	}
 	else
@@ -3208,13 +3208,6 @@
 #if CONFIG_PROC_FS
 	chandev_create_proc();
 #endif
-	chandev_msck_task_tq.routine=
-		chandev_msck_task;
-#if LINUX_VERSION_CODE>=KERNEL_VERSION(2,3,0)
-	INIT_LIST_HEAD(&chandev_msck_task_tq.list);
-	chandev_msck_task_tq.sync=0;
-#endif
-	chandev_msck_task_tq.data=NULL;
 	chandev_last_startmsck_list_update=chandev_last_machine_check=jiffies-HZ;
 	atomic_set(&chandev_msck_thread_lock,1);
 	chandev_lock_owner=CHANDEV_INVALID_LOCK_OWNER;
diff -urN linux-2.5.41/drivers/s390/net/ctcmain.c linux-2.5.41-s390/drivers/s390/net/ctcmain.c
--- linux-2.5.41/drivers/s390/net/ctcmain.c	Mon Oct  7 20:24:04 2002
+++ linux-2.5.41-s390/drivers/s390/net/ctcmain.c	Wed Oct  9 14:01:13 2002
@@ -49,7 +49,6 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/sched.h>
-#include <linux/tqueue.h>
 
 #include <linux/signal.h>
 #include <linux/string.h>
@@ -234,11 +233,6 @@
 	devstat_t           *devstat;
 
 	/**
-	 * Bottom half task queue.
-	 */
-	struct tq_struct    tq;
-
-	/**
 	 * RX/TX buffer size
 	 */
 	int                 max_bufsize;
@@ -797,19 +791,6 @@
 }
 
 /**
- * Bottom half routine.
- *
- * @param ch The channel to work on.
- */
-static void ctc_bh(channel *ch)
-{
-	struct sk_buff *skb;
-
-	while ((skb = skb_dequeue(&ch->io_queue)))
-		ctc_unpack_skb(ch, skb);
-}
-
-/**
  * Check return code of a preceeding do_IO, halt_IO etc...
  *
  * @param ch          The channel, the error belongs to.
@@ -1329,11 +1310,6 @@
 		       dev->name, 
 		       (CHANNEL_DIRECTION(ch->flags) == READ) ? "RX" : "TX");
 
-	INIT_LIST_HEAD(&ch->tq.list);
-	ch->tq.sync    = 0;
-	ch->tq.routine = (void *)(void *)ctc_bh;
-	ch->tq.data    = ch;
-
 	ch->ccw[0].cmd_code = CCW_CMD_PREPARE;
 	ch->ccw[0].flags    = CCW_FLAG_SLI | CCW_FLAG_CC;
 	ch->ccw[0].count    = 0;
diff -urN linux-2.5.41/drivers/s390/net/fsm.c linux-2.5.41-s390/drivers/s390/net/fsm.c
--- linux-2.5.41/drivers/s390/net/fsm.c	Mon Oct  7 20:24:15 2002
+++ linux-2.5.41-s390/drivers/s390/net/fsm.c	Wed Oct  9 14:01:13 2002
@@ -9,6 +9,7 @@
 #include <linux/version.h>
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/timer.h>
 
 fsm_instance *
 init_fsm(char *name, const char **state_names, const char **event_names, int nr_states,
@@ -172,19 +173,6 @@
 	       this->fi->name, this, millisec);
 #endif
 
-#if LINUX_VERSION_CODE >= 0x020300
-	if (this->tl.list.next || this->tl.list.prev) {
-		printk(KERN_WARNING "fsm(%s): timer already active!\n",
-			this->fi->name);
-		return -1;
-	}
-#else
-	if (this->tl.next || this->tl.prev) {
-		printk(KERN_WARNING "fsm(%s): timer already active!\n",
-			this->fi->name);
-		return -1;
-	}
-#endif
 	init_timer(&this->tl);
 	this->tl.function = (void *)fsm_expire_timer;
 	this->tl.data = (long)this;
@@ -205,13 +193,7 @@
 		this->fi->name, this, millisec);
 #endif
 
-#if LINUX_VERSION_CODE >= 0x020300
-	if (this->tl.list.next || this->tl.list.prev)
-		del_timer(&this->tl);
-#else
-	if (this->tl.next || this->tl.prev)
-		del_timer(&this->tl);
-#endif
+	del_timer(&this->tl);
 	init_timer(&this->tl);
 	this->tl.function = (void *)fsm_expire_timer;
 	this->tl.data = (long)this;
diff -urN linux-2.5.41/drivers/s390/net/lcs.c linux-2.5.41-s390/drivers/s390/net/lcs.c
--- linux-2.5.41/drivers/s390/net/lcs.c	Mon Oct  7 20:23:27 2002
+++ linux-2.5.41-s390/drivers/s390/net/lcs.c	Wed Oct  9 14:01:13 2002
@@ -461,7 +461,7 @@
 int                  lock_owner;            \
 int                  lock_cnt;              \
 wait_queue_head_t    wait;                  \
-struct  tq_struct    retry_task;            \
+struct work_struct   retry_task;            \
 devstat_t	     devstat;               \
 lcs_chan_busy_state  chan_busy_state;       \
 ccw1_t               ccw[num_io_buffs+1];   \
@@ -491,7 +491,7 @@
 	u32 tx_idx;		/* last buffer successfully transmitted */
 	unsigned long pkts_still_being_txed;
 	unsigned long bytes_still_being_txed;
-	struct tq_struct resume_task;
+	struct work_struct resume_task;
 	int resume_queued;
 	int resume_loopcnt;
 	uint64_t last_lcs_txpacket_time;
@@ -542,7 +542,7 @@
 	/* To insure only one kernel thread runs at a time */
 	atomic_t kernel_thread_lock;
 	int (*kernel_thread_routine) (lcs_drvr_globals * drvr_globals);
-	struct tq_struct kernel_thread_task;
+	struct work_struct kernel_thread_task;
 	u16 lgw_sequence_no;	/* this isn't required just being thorough */
 	atomic_t retry_cnt;
 	struct net_device_stats stats __attribute__ ((aligned(4)));
@@ -1024,7 +1024,9 @@
 	lcs_write_globals *write;
 	lcs_read_globals *read;
 	int cnt;
+#if LINUX_VERSION_CODE<KERNEL_VERSION(2,5,41)
 	struct tq_struct *lcs_tq;
+#endif
 
 	lcs_debug_event(2, "lcs_alloc_drvr_globals called\n");
 	drvr_globals = lcs_dma_alloc(LCS_ALLOCSIZE);
@@ -1058,6 +1060,15 @@
 	read->drvr_globals = drvr_globals;
 	write->drvr_globals = drvr_globals;
 	lcs_resetstate(drvr_globals);
+#if LINUX_VERSION_CODE>=KERNEL_VERSION(2,5,41)
+	INIT_WORK(&drvr_globals->kernel_thread_task, lcs_kernel_thread,
+		  (unsigned long) drvr_globals);
+	INIT_WORK(&read->retry_task, lcs_queued_restartreadio, 
+		  (unsigned long) drvr_globals);
+	INIT_WORK(&write->retry_task, lcs_queued_restartwriteio,
+		  (unsigned long) drvr_globals);
+	INIT_WORK(&resume_task, lcs_resume_writetask, (unsigned long) write);
+#else
 	lcs_tq = &drvr_globals->kernel_thread_task;
 	lcs_tq->routine = (void (*)(void *)) lcs_kernel_thread;
 	lcs_tq->data = (void *) drvr_globals;
@@ -1075,6 +1086,7 @@
 	write->retry_task.data = read->retry_task.data = (void *) drvr_globals;
 	write->resume_task.routine = (void (*)(void *)) lcs_resume_writetask;
 	write->resume_task.data = (void *) write;
+#endif
 	read->chan_busy_state = write->chan_busy_state = chan_dead;
 	atomic_set(&drvr_globals->kernel_thread_lock, 1);
 	spin_lock(&lcs_card_list_lock);
@@ -1093,11 +1105,15 @@
 	lcs_debug_event(1, "lcs_retry subchannel %04x scheduling retry\n",
 			chan_globals->subchannel);
 	MOD_INC_USE_COUNT;
+#if LINUX_VERSION_CODE>=KERNEL_VERSION(2,5,41)
+	schedule_work(&chan_globals->retry_task);
+#else
 #if LINUX_VERSION_CODE>KERNEL_VERSION(2,2,16)
 	schedule_task(&chan_globals->retry_task);
 #else
 	queue_task(&chan_globals->retry_task, &tq_scheduler);
 #endif
+#endif
 }
 
 static int
@@ -1445,7 +1461,11 @@
 	 * needing mod usage counts */
 	lcs_debug_event(2, "lcs_queue_write write=%p\n", write);
 	write->resume_queued = TRUE;
+#if LINUX_VERSION_CODE>=KERNEL_VERSION(2,5,41)
+	schedule_work(&write->resume_task);
+#else
 	queue_task(&write->resume_task, &tq_immediate);
+#endif
 	mark_bh(IMMEDIATE_BH);
 }
 
@@ -1631,11 +1651,15 @@
 		netif_stop_queue(drvr_globals->dev);
 		MOD_INC_USE_COUNT;
 		drvr_globals->kernel_thread_routine = routine;
+#if LINUX_VERSION_CODE>=KERNEL_VERSION(2,5,41)
+		schedule_work(&drvr_globals->kernel_thread_task);
+#else
 #if LINUX_VERSION_CODE<=KERNEL_VERSION(2,2,16)
 		queue_task(&drvr_globals->kernel_thread_task, &tq_scheduler);
 #else
 		schedule_task(&drvr_globals->kernel_thread_task);
 #endif
+#endif
 	} else
 		lcs_debug_event(1,"lcs_queue_thread busy drvr_globals=%p "
 				"routine=%p",drvr_globals,routine);

