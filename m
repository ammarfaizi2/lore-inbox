Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316903AbSGHNwu>; Mon, 8 Jul 2002 09:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSGHNwt>; Mon, 8 Jul 2002 09:52:49 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:63414 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S316903AbSGHNwi> convert rfc822-to-8bit; Mon, 8 Jul 2002 09:52:38 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.25: s390 drivers.
Date: Mon, 8 Jul 2002 15:33:27 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207081533.28011.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
improvements for the s/390 drivers:
* use list_move_tail instead of list_del/list_add_tail in dasd driver
* dynamically allocate dasd_info in dasd_ioctl_information since its big
* replace immediate bottom half with tasklet in 3215, 3270, tape, ctc and iucv driver

blue skies,
  Martin.

diff -urN linux-2.5.25/drivers/s390/block/dasd.c linux-2.5.25-s390/drivers/s390/block/dasd.c
--- linux-2.5.25/drivers/s390/block/dasd.c	Sat Jul  6 01:42:23 2002
+++ linux-2.5.25-s390/drivers/s390/block/dasd.c	Mon Jul  8 15:08:28 2002
@@ -1547,11 +1547,9 @@
 			goto restart;
 		}
 
-		/* Dechain request from device request queue ... */
+		/* Rechain request on device device request queue */
 		cqr->endclk = get_clock();
-		list_del(&cqr->list);
-		/* ... and add it to list of final requests. */
-		list_add_tail(&cqr->list, final_queue);
+		list_move_tail(&cqr->list, final_queue);
 	}
 }
 
@@ -1715,11 +1713,9 @@
 			__dasd_process_erp(device, cqr);
 			continue;
 		}
-		/* Dechain request from device request queue ... */
+		/* Rechain request on device request queue */
 		cqr->endclk = get_clock();
-		list_del(&cqr->list);
-		/* ... and add it to list of flushed requests. */
-		list_add_tail(&cqr->list, &flush_queue);
+		list_move_tail(&cqr->list, &flush_queue);
 	}
 	spin_unlock_irq(get_irq_lock(device->devinfo.irq));
 	/* Now call the callback function of flushed requests */
diff -urN linux-2.5.25/drivers/s390/block/dasd_ioctl.c linux-2.5.25-s390/drivers/s390/block/dasd_ioctl.c
--- linux-2.5.25/drivers/s390/block/dasd_ioctl.c	Sat Jul  6 01:42:02 2002
+++ linux-2.5.25-s390/drivers/s390/block/dasd_ioctl.c	Mon Jul  8 15:08:28 2002
@@ -340,7 +340,7 @@
 {
 	dasd_devmap_t *devmap;
 	dasd_device_t *device;
-	dasd_information2_t dasd_info;
+	dasd_information2_t *dasd_info;
 	unsigned long flags;
 	int rc;
 
@@ -354,20 +354,24 @@
 		return -EINVAL;
 	}
 
-	rc = device->discipline->fill_info(device, &dasd_info);
+	dasd_info = kmalloc(sizeof(dasd_information2_t), GFP_KERNEL);
+	if (dasd_info == NULL)
+		return -ENOMEM;
+	rc = device->discipline->fill_info(device, dasd_info);
 	if (rc) {
 		dasd_put_device(devmap);
+		kfree(dasd_info);
 		return rc;
 	}
 
-	dasd_info.devno = device->devinfo.devno;
-	dasd_info.schid = device->devinfo.irq;
-	dasd_info.cu_type = device->devinfo.sid_data.cu_type;
-	dasd_info.cu_model = device->devinfo.sid_data.cu_model;
-	dasd_info.dev_type = device->devinfo.sid_data.dev_type;
-	dasd_info.dev_model = device->devinfo.sid_data.dev_model;
-	dasd_info.open_count = atomic_read(&device->open_count);
-	dasd_info.status = device->state;
+	dasd_info->devno = device->devinfo.devno;
+	dasd_info->schid = device->devinfo.irq;
+	dasd_info->cu_type = device->devinfo.sid_data.cu_type;
+	dasd_info->cu_model = device->devinfo.sid_data.cu_model;
+	dasd_info->dev_type = device->devinfo.sid_data.dev_type;
+	dasd_info->dev_model = device->devinfo.sid_data.dev_model;
+	dasd_info->open_count = atomic_read(&device->open_count);
+	dasd_info->status = device->state;
 	
 	/*
 	 * check if device is really formatted
@@ -375,16 +379,16 @@
 	 */
 	if ((device->state < DASD_STATE_READY) ||
 	    (dasd_check_blocksize(device->bp_block)))
-		dasd_info.format = DASD_FORMAT_NONE;
+		dasd_info->format = DASD_FORMAT_NONE;
 	
-	dasd_info.features = devmap->features;
+	dasd_info->features = devmap->features;
 	
 	if (device->discipline)
-		memcpy(dasd_info.type, device->discipline->name, 4);
+		memcpy(dasd_info->type, device->discipline->name, 4);
 	else
-		memcpy(dasd_info.type, "none", 4);
-	dasd_info.req_queue_len = 0;
-	dasd_info.chanq_len = 0;
+		memcpy(dasd_info->type, "none", 4);
+	dasd_info->req_queue_len = 0;
+	dasd_info->chanq_len = 0;
 	if (device->request_queue->request_fn) {
 		struct list_head *l;
 #ifdef DASD_EXTENDED_PROFILING
@@ -392,24 +396,25 @@
 			struct list_head *l;
 			spin_lock_irqsave(&device->lock, flags);
 			list_for_each(l, &device->request_queue->queue_head)
-				dasd_info.req_queue_len++;
+				dasd_info->req_queue_len++;
 			spin_unlock_irqrestore(&device->lock, flags);
 		}
 #endif				/* DASD_EXTENDED_PROFILING */
 		spin_lock_irqsave(get_irq_lock(device->devinfo.irq), flags);
 		list_for_each(l, &device->ccw_queue)
-			dasd_info.chanq_len++;
+			dasd_info->chanq_len++;
 		spin_unlock_irqrestore(get_irq_lock(device->devinfo.irq),
 				       flags);
 	}
 	
 	rc = 0;
-	if (copy_to_user((long *) args, (long *) &dasd_info,
+	if (copy_to_user((long *) args, (long *) dasd_info,
 			 ((no == (unsigned int) BIODASDINFO2) ?
 			  sizeof (dasd_information2_t) :
 			  sizeof (dasd_information_t))))
 		rc = -EFAULT;
 	dasd_put_device(devmap);
+	kfree(dasd_info);
 	return rc;
 }
 
diff -urN linux-2.5.25/drivers/s390/char/con3215.c linux-2.5.25-s390/drivers/s390/char/con3215.c
--- linux-2.5.25/drivers/s390/char/con3215.c	Sat Jul  6 01:42:05 2002
+++ linux-2.5.25-s390/drivers/s390/char/con3215.c	Mon Jul  8 15:08:28 2002
@@ -89,7 +89,7 @@
         int written;                  /* number of bytes in write requests */
 	devstat_t devstat;	      /* device status structure for do_IO */
 	struct tty_struct *tty;	      /* pointer to tty structure if present */
-	struct tq_struct tqueue;      /* task queue to bottom half */
+	struct tasklet_struct tasklet;
 	raw3215_req *queued_read;     /* pointer to queued read requests */
 	raw3215_req *queued_write;    /* pointer to queued write requests */
 	wait_queue_head_t empty_wait; /* wait queue for flushing */
@@ -341,7 +341,7 @@
  * The bottom half handler routine for 3215 devices. It tries to start
  * the next IO and wakes up processes waiting on the tty.
  */
-static void raw3215_softint(void *data)
+static void raw3215_tasklet(void *data)
 {
 	raw3215_info *raw;
 	struct tty_struct *tty;
@@ -377,12 +377,7 @@
         if (raw->flags & RAW3215_BH_PENDING)
                 return;       /* already pending */
         raw->flags |= RAW3215_BH_PENDING;
-	INIT_LIST_HEAD(&raw->tqueue.list);
-	raw->tqueue.sync = 0;
-        raw->tqueue.routine = raw3215_softint;
-        raw->tqueue.data = raw;
-        queue_task(&raw->tqueue, &tq_immediate);
-        mark_bh(IMMEDIATE_BH);
+	tasklet_hi_schedule(&raw->tasklet);
 }
 
 /*
@@ -867,8 +862,9 @@
 			kfree(raw);
 			return -ENOMEM;
 		}
-		raw->tqueue.routine = raw3215_softint;
-		raw->tqueue.data = raw;
+		tasklet_init(&raw->tasklet, 
+			     (void (*)(unsigned long)) raw3215_tasklet,
+			     (unsigned long) raw);
                 init_waitqueue_head(&raw->empty_wait);
 		raw3215[line] = raw;
 	}
@@ -1097,8 +1093,9 @@
 	/* Find the first console */
 	raw->irq = raw3215_find_dev(0);
 	raw->flags |= RAW3215_FIXED;
-	raw->tqueue.routine = raw3215_softint;
-	raw->tqueue.data = raw;
+	tasklet_init(&raw->tasklet, 
+		     (void (*)(unsigned long)) raw3215_tasklet,
+		     (unsigned long) raw);
         init_waitqueue_head(&raw->empty_wait);
 
 	/* Request the console irq */
diff -urN linux-2.5.25/drivers/s390/char/tape.h linux-2.5.25-s390/drivers/s390/char/tape.h
--- linux-2.5.25/drivers/s390/char/tape.h	Sat Jul  6 01:42:32 2002
+++ linux-2.5.25-s390/drivers/s390/char/tape.h	Mon Jul  8 15:08:28 2002
@@ -197,8 +197,8 @@
 	struct request* current_request;
 	int blk_retries;
 	long position;
-	atomic_t bh_scheduled;
-	struct tq_struct bh_tq;
+	atomic_t tasklet_scheduled;
+	struct tasklet_struct tasklet;
 #ifdef CONFIG_DEVFS_FS
 	devfs_handle_t devfs_block_dir;    /* tape/DEVNO/block dir */
 	devfs_handle_t devfs_disc;         /* tape/DEVNO/block/disc */
diff -urN linux-2.5.25/drivers/s390/char/tapeblock.c linux-2.5.25-s390/drivers/s390/char/tapeblock.c
--- linux-2.5.25/drivers/s390/char/tapeblock.c	Sat Jul  6 01:42:21 2002
+++ linux-2.5.25-s390/drivers/s390/char/tapeblock.c	Mon Jul  8 15:08:28 2002
@@ -79,6 +79,8 @@
 }
 #endif
 
+static void run_tapeblock_exec_IO (tape_dev_t* td);
+
 void 
 tapeblock_setup(tape_dev_t* td) {
     blk_size[tapeblock_major][td->first_minor]=0; // this will be detected
@@ -88,6 +90,9 @@
     tapeblock_mkdevfstree(td);
 #endif
     set_device_ro (MKDEV(tapeblock_major, td->first_minor), 1);
+    tasklet_init(&td->blk_data.tasklet,
+		 (void (*)(unsigned long)) run_tapeblock_exec_IO,
+		 (unsinged long) td);
 }
 
 int
@@ -408,15 +413,7 @@
         if (atomic_compare_and_swap(0,1,&td->blk_data.bh_scheduled)) {
                 return;
         }
-#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
-	INIT_LIST_HEAD(&td->blk_data.bh_tq.list);
-#endif
-	td->blk_data.bh_tq.sync = 0;
-	td->blk_data.bh_tq.routine = (void *) (void *) run_tapeblock_exec_IO;
-	td->blk_data.bh_tq.data = td;
-
-	queue_task (&td->blk_data.bh_tq, &tq_immediate);
-	mark_bh (IMMEDIATE_BH);
+	tasklet_hi_schedule(&td->blk_data.tasklet);
 	return;
 }
 
diff -urN linux-2.5.25/drivers/s390/char/tuball.c linux-2.5.25-s390/drivers/s390/char/tuball.c
--- linux-2.5.25/drivers/s390/char/tuball.c	Sat Jul  6 01:42:19 2002
+++ linux-2.5.25-s390/drivers/s390/char/tuball.c	Mon Jul  8 15:08:28 2002
@@ -444,6 +444,13 @@
 	tubp->tty_bcb.bc_rd = 0;
 	(*tubminors)[minor] = tubp;
 
+	tasklet_init(&tubp->fs_tasklet,
+		     (void (*)(unsigned long)) fs3270_bh,
+		     (unsigned long) tubp);
+	tasklet_init(&tubp->tty_tasklet,
+		     (void (*)(unsigned long)) tty3270_bh,
+		     (unsigned long) tubp);
+
 #ifdef CONFIG_TN3270_CONSOLE
 	if (CONSOLE_IS_3270) {
 		if (tub3270_con_tubp == NULL && 
diff -urN linux-2.5.25/drivers/s390/char/tubfs.c linux-2.5.25-s390/drivers/s390/char/tubfs.c
--- linux-2.5.25/drivers/s390/char/tubfs.c	Sat Jul  6 01:42:31 2002
+++ linux-2.5.25-s390/drivers/s390/char/tubfs.c	Mon Jul  8 15:08:28 2002
@@ -238,7 +238,7 @@
 /*
  * fs3270_bh(tubp) -- Perform back-half processing
  */
-static void
+void
 fs3270_bh(void *data)
 {
 	long flags;
@@ -275,10 +275,7 @@
 	if (tubp->flags & TUB_BHPENDING)
 		return;
 	tubp->flags |= TUB_BHPENDING;
-	tubp->tqueue.routine = fs3270_bh;
-	tubp->tqueue.data = tubp;
-	queue_task(&tubp->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_hi_schedule(&tubp->fs_tasklet);
 }
 
 /*
diff -urN linux-2.5.25/drivers/s390/char/tubio.h linux-2.5.25-s390/drivers/s390/char/tubio.h
--- linux-2.5.25/drivers/s390/char/tubio.h	Sat Jul  6 01:42:00 2002
+++ linux-2.5.25-s390/drivers/s390/char/tubio.h	Mon Jul  8 15:08:28 2002
@@ -234,7 +234,8 @@
 	enum tubstat    stat;
 	enum tubcmd     cmd;
 	int             flags;		/* See below for values */
-	struct tq_struct tqueue;
+	struct tasklet_struct  fs_tasklet;
+	struct tasklet_struct  tty_tasklet;
 
 	/* Stuff for fs-driver support */
 	pid_t           fs_pid;         /* Pid if TBM_FS */
@@ -328,6 +329,8 @@
 extern int tty3270_proc_misc;
 extern enum tubwhat tty3270_proc_what;
 extern struct tty_driver tty3270_driver;
+extern void fs3270_bh(void *data);
+extern void tty3270_bh(void *data);
 #ifdef CONFIG_DEVFS_FS
 extern devfs_handle_t fs3270_devfs_dir;
 extern void fs3270_devfs_register(tub_t *);
diff -urN linux-2.5.25/drivers/s390/char/tubtty.c linux-2.5.25-s390/drivers/s390/char/tubtty.c
--- linux-2.5.25/drivers/s390/char/tubtty.c	Sat Jul  6 01:42:33 2002
+++ linux-2.5.25-s390/drivers/s390/char/tubtty.c	Mon Jul  8 15:08:48 2002
@@ -35,8 +35,6 @@
 	unsigned long, void *);
 
 /* tty3270 utility functions */
-static void tty3270_bh(void *);
-       void tty3270_sched_bh(tub_t *);
 static int tty3270_wait(tub_t *, long *);
        void tty3270_int(tub_t *, devstat_t *);
 static int tty3270_try_logging(tub_t *);
@@ -600,7 +598,7 @@
 /*
  * tty3270_bh(tubp) -- Perform back-half processing
  */
-static void
+void
 tty3270_bh(void *data)
 {
 	tub_t *tubp;
@@ -663,10 +661,7 @@
 	if (tubp->flags & TUB_BHPENDING)
 		return;
 	tubp->flags |= TUB_BHPENDING;
-	tubp->tqueue.routine = tty3270_bh;
-	tubp->tqueue.data = tubp;
-	queue_task(&tubp->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_hi_schedule(&tubp->tty_tasklet);
 }
 
 /*
diff -urN linux-2.5.25/drivers/s390/net/ctctty.c linux-2.5.25-s390/drivers/s390/net/ctctty.c
--- linux-2.5.25/drivers/s390/net/ctctty.c	Sat Jul  6 01:42:28 2002
+++ linux-2.5.25-s390/drivers/s390/net/ctctty.c	Mon Jul  8 15:08:28 2002
@@ -86,7 +86,7 @@
   wait_queue_head_t	open_wait;
   wait_queue_head_t	close_wait;
   struct semaphore      write_sem;
-  struct tq_struct      tq;
+  struct tasklet_struct tasklet;
   struct timer_list     stoptimer;
 } ctc_tty_info;
 
@@ -272,8 +272,7 @@
 	 */
 	skb_queue_tail(&info->rx_queue, skb);
 	/* Schedule dequeuing */
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 static int
@@ -390,8 +389,7 @@
 	skb_reserve(skb, skb_res);
 	*(skb_put(skb, 1)) = c;
 	skb_queue_head(&info->tx_queue, skb);
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 static void
@@ -400,8 +398,7 @@
 	if (ctc_tty_shuttingdown)
 		return;
 	info->flags |= CTC_ASYNC_TX_LINESTAT;
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 static void
@@ -562,8 +559,7 @@
 	}
 	if (skb_queue_len(&info->tx_queue)) {
 		info->lsr &= ~UART_LSR_TEMT;
-		queue_task(&info->tq, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		tasklet_schedule(&info->tasklet);
 	}
 	if (from_user)
 		up(&info->write_sem);
@@ -628,8 +624,7 @@
 		return;
 	if (tty->stopped || tty->hw_stopped || (!skb_queue_len(&info->tx_queue)))
 		return;
-	queue_task(&info->tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	tasklet_schedule(&info->tasklet);
 }
 
 /*
@@ -1170,8 +1165,9 @@
  * the lower levels.
  */
 static void
-ctc_tty_task(ctc_tty_info *info)
+ctc_tty_task(unsigned long arg)
 {
+	ctc_tty_info *info = (void *)arg;
 	unsigned long saveflags;
 	int again;
 
@@ -1182,8 +1178,7 @@
 			info->lsr |= UART_LSR_TEMT;
 		again |= ctc_tty_readmodem(info);
 		if (again) {
-			queue_task(&info->tq, &tq_immediate);
-			mark_bh(IMMEDIATE_BH);
+			tasklet_schedule(&info->tasklet);
 		}
 	}
 	spin_unlock_irqrestore(&ctc_tty_lock, saveflags);
@@ -1243,14 +1238,8 @@
 	for (i = 0; i < CTC_TTY_MAX_DEVICES; i++) {
 		info = &driver->info[i];
 		init_MUTEX(&info->write_sem);
-#if LINUX_VERSION_CODE >= 0x020400
-		INIT_LIST_HEAD(&info->tq.list);
-#else
-		info->tq.next    = NULL;
-#endif
-		info->tq.sync    = 0;
-		info->tq.routine = (void *)(void *)ctc_tty_task;
-		info->tq.data    = info;
+		tasklet_init(&info->tasklet, ctc_tty_task,
+				(unsigned long) info);
 		info->magic = CTC_ASYNC_MAGIC;
 		info->line = i;
 		info->tty = 0;
@@ -1331,10 +1320,6 @@
 		kfree(driver);
 		driver = NULL;
 	} else {
-		int i;
-
-		for (i = 0; i < CTC_TTY_MAX_DEVICES; i++)
-			driver->info[i].tq.routine = NULL;
 		tty_unregister_driver(&driver->ctc_tty_device);
 	}
 	spin_unlock_irqrestore(&ctc_tty_lock, saveflags);
diff -urN linux-2.5.25/drivers/s390/net/iucv.c linux-2.5.25-s390/drivers/s390/net/iucv.c
--- linux-2.5.25/drivers/s390/net/iucv.c	Sat Jul  6 01:42:04 2002
+++ linux-2.5.25-s390/drivers/s390/net/iucv.c	Mon Jul  8 15:08:28 2002
@@ -41,9 +41,9 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/init.h>
-#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/errno.h>
 #include <asm/atomic.h>
 #include "iucv.h"
 #include <asm/io.h>
@@ -99,16 +99,14 @@
 static struct list_head  iucv_irq_queue;
 static spinlock_t iucv_irq_queue_lock = SPIN_LOCK_UNLOCKED;
 
-static struct tq_struct  iucv_tq;
-
-static atomic_t   iucv_bh_scheduled = ATOMIC_INIT (0);
-
 /*
  *Internal function prototypes
  */
-static void iucv_bh_handler(void);
+static void iucv_tasklet_handler(unsigned long);
 static void iucv_irq_handler(struct pt_regs *, __u16);
 
+static DECLARE_TASKLET(iucv_tasklet,iucv_tasklet_handler,0);
+
 /************ FUNCTION ID'S ****************************/
 
 #define ACCEPT          10
@@ -302,7 +300,7 @@
 	if (debuglevel < 3)
 		return;
 
-	printk(KERN_DEBUG __FUNCTION__ ": %s\n", title);
+	printk(KERN_DEBUG "%s\n", title);
 	printk("  ");
 	for (i = 0; i < len; i++) {
 		if (!(i % 16) && i != 0)
@@ -318,7 +316,7 @@
 #define iucv_debug(lvl, fmt, args...) \
 do { \
 	if (debuglevel >= lvl) \
-		printk(KERN_DEBUG __FUNCTION__ ": " fmt "\n" , ## args); \
+		printk(KERN_DEBUG "%s: " fmt "\n", __FUNCTION__ , ## args); \
 } while (0)
 
 #else
@@ -385,11 +383,6 @@
 	}
 	memset(iucv_param_pool, 0, sizeof(iucv_param) * PARAM_POOL_SIZE);
 
-	/* Initialize task queue */
-	INIT_LIST_HEAD(&iucv_tq.list);
-	iucv_tq.sync = 0;
-	iucv_tq.routine = (void *)iucv_bh_handler;
-
 	/* Initialize irq queue */
 	INIT_LIST_HEAD(&iucv_irq_queue);
 
@@ -2177,7 +2170,7 @@
  * @code: irq code
  *
  * Handles external interrupts coming in from CP.
- * Places the interrupt buffer on a queue and schedules iucv_bh_handler().
+ * Places the interrupt buffer on a queue and schedules iucv_tasklet_handler().
  */
 static void
 iucv_irq_handler(struct pt_regs *regs, __u16 code)
@@ -2201,10 +2194,7 @@
 	list_add_tail(&irqdata->queue, &iucv_irq_queue);
 	spin_unlock(&iucv_irq_queue_lock);
 
-	if (atomic_compare_and_swap (0, 1, &iucv_bh_scheduled) == 0) {
-		queue_task (&iucv_tq, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
-	}
+	tasklet_schedule(&iucv_tasklet);
 
 	irq_exit(cpu, 0x4000);
 	return;
@@ -2215,7 +2205,7 @@
  * @int_buf: Pointer to copy of external interrupt buffer
  *
  * The workhorse for handling interrupts queued by iucv_irq_handler().
- * This function is called from the bottom half iucv_bh_handler().
+ * This function is called from the bottom half iucv_tasklet_handler().
  */
 static void
 iucv_do_int(iucv_GeneralInterrupt * int_buf)
@@ -2385,19 +2375,17 @@
 }
 
 /**
- * iucv_bh_handler:
+ * iucv_tasklet_handler:
  *
  * This function loops over the queue of irq buffers and runs iucv_do_int()
  * on every queue element.
  */
 static void
-iucv_bh_handler(void)
+iucv_tasklet_handler(unsigned long ignored)
 {
 	struct list_head head;
 	struct list_head *next;
 	ulong  flags;
-
-	atomic_set(&iucv_bh_scheduled, 0);
 
 	spin_lock_irqsave(&iucv_irq_queue_lock, flags);
 	list_add(&head, &iucv_irq_queue);
 
