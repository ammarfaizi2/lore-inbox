Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266336AbSKGD56>; Wed, 6 Nov 2002 22:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266326AbSKGD5I>; Wed, 6 Nov 2002 22:57:08 -0500
Received: from dp.samba.org ([66.70.73.150]:36553 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266323AbSKGDyt>;
	Wed, 6 Nov 2002 22:54:49 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15817.58746.513936.754515@argo.ozlabs.ibm.com>
Date: Thu, 7 Nov 2002 15:00:58 +1100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: [PATCH] Update ADB drivers in 2.5
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the ADB driver and the three low-level ADB bus
adaptor drivers used on powermacs.  The files affected are all in
drivers/macintosh; they are adb.c, macio-adb.c, via-cuda.c and
via-pmu.c.

The main changes in this patch are:

- Remove the use of global cli/sti and replace them with local cli/sti,
  spinlocks and semaphores as appropriate.
- Use DECLARE_WORK/schedule_work instead of tq_struct/schedule_task.
- Improvements to the PMU interrupt handling and sleep/wakeup code.

Linus, please apply.

Thanks,
Paul.

diff -urN linux-2.5/drivers/macintosh/adb.c pmac-2.5/drivers/macintosh/adb.c
--- linux-2.5/drivers/macintosh/adb.c	2002-10-31 02:09:29.000000000 +1100
+++ pmac-2.5/drivers/macintosh/adb.c	2002-11-07 14:38:03.000000000 +1100
@@ -34,8 +34,10 @@
 #include <linux/wait.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>
 #ifdef CONFIG_PPC
 #include <asm/prom.h>
 #include <asm/hydra.h>
@@ -75,8 +77,8 @@
 
 struct adb_driver *adb_controller;
 struct notifier_block *adb_client_list = NULL;
-static int adb_got_sleep = 0;
-static int adb_inited = 0;
+static int adb_got_sleep;
+static int adb_inited;
 static pid_t adb_probe_task_pid;
 static DECLARE_MUTEX(adb_probe_mutex);
 static struct completion adb_probe_task_comp;
@@ -94,7 +96,7 @@
 static int adb_scan_bus(void);
 static int do_adb_reset_bus(void);
 static void adbdev_init(void);
-
+static int try_handler_change(int, int);
 
 static struct adb_handler {
 	void (*handler)(unsigned char *, int, struct pt_regs *, int);
@@ -102,6 +104,18 @@
 	int handler_id;
 } adb_handler[16];
 
+/*
+ * The adb_handler_sem mutex protects all accesses to the original_address
+ * and handler_id fields of adb_handler[i] for all i, and changes to the
+ * handler field.
+ * Accesses to the handler field are protected by the adb_handler_lock
+ * rwlock.  It is held across all calls to any handler, so that by the
+ * time adb_unregister returns, we know that the old handler isn't being
+ * called.
+ */
+static DECLARE_MUTEX(adb_handler_sem);
+static rwlock_t adb_handler_lock = RW_LOCK_UNLOCKED;
+
 #if 0
 static void printADBreply(struct adb_request *req)
 {
@@ -254,25 +268,18 @@
 		SIGCHLD | CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
 }
 
+static DECLARE_WORK(adb_reset_work, __adb_probe_task, NULL);
+
 int
 adb_reset_bus(void)
 {
-	static struct tq_struct tqs = {
-		routine:	__adb_probe_task,
-	};
-
 	if (__adb_probe_sync) {
 		do_adb_reset_bus();
 		return 0;
 	}
 
 	down(&adb_probe_mutex);
-
-	/* Create probe thread as a child of keventd */
-	if (current_is_keventd())
-		__adb_probe_task(NULL);
-	else
-		schedule_task(&tqs);
+	schedule_work(&adb_reset_work);
 	return 0;
 }
 
@@ -372,7 +379,6 @@
 do_adb_reset_bus(void)
 {
 	int ret, nret, devs;
-	unsigned long flags;
 	
 	if (adb_controller == NULL)
 		return -ENXIO;
@@ -391,11 +397,11 @@
 		/* Let the trackpad settle down */
 		adb_wait_ms(500);
 	}
-	
-	save_flags(flags);
-	cli();
+
+	down(&adb_handler_sem);
+	write_lock_irq(&adb_handler_lock);
 	memset(adb_handler, 0, sizeof(adb_handler));
-	restore_flags(flags);
+	write_unlock_irq(&adb_handler_lock);
 
 	/* That one is still a bit synchronous, oh well... */
 	if (adb_controller->reset_bus)
@@ -413,6 +419,7 @@
 		if (adb_controller->autopoll)
 			adb_controller->autopoll(devs);
 	}
+	up(&adb_handler_sem);
 
 	nret = notifier_call_chain(&adb_client_list, ADB_MSG_POST_RESET, NULL);
 	if (nret & NOTIFY_STOP_MASK)
@@ -512,30 +519,41 @@
 {
 	int i;
 
+	down(&adb_handler_sem);
 	ids->nids = 0;
 	for (i = 1; i < 16; i++) {
 		if ((adb_handler[i].original_address == default_id) &&
 		    (!handler_id || (handler_id == adb_handler[i].handler_id) || 
-		    adb_try_handler_change(i, handler_id))) {
+		    try_handler_change(i, handler_id))) {
 			if (adb_handler[i].handler != 0) {
 				printk(KERN_ERR
 				       "Two handlers for ADB device %d\n",
 				       default_id);
 				continue;
 			}
+			write_lock_irq(&adb_handler_lock);
 			adb_handler[i].handler = handler;
+			write_unlock_irq(&adb_handler_lock);
 			ids->id[ids->nids++] = i;
 		}
 	}
+	up(&adb_handler_sem);
 	return ids->nids;
 }
 
 int
 adb_unregister(int index)
 {
-	if (!adb_handler[index].handler)
-		return -ENODEV;
-	adb_handler[index].handler = 0;
+	int ret = -ENODEV;
+
+	down(&adb_handler_sem);
+	write_lock_irq(&adb_handler_lock);
+	if (adb_handler[index].handler) {
+		ret = 0;
+		adb_handler[index].handler = 0;
+	}
+	write_unlock_irq(&adb_handler_lock);
+	up(&adb_handler_sem);
 	return 0;
 }
 
@@ -544,6 +562,7 @@
 {
 	int i, id;
 	static int dump_adb_input = 0;
+	void (*handler)(unsigned char *, int, struct pt_regs *, int);
 
 	/* We skip keystrokes and mouse moves when the sleep process
 	 * has been started. We stop autopoll, but this is another security
@@ -558,14 +577,15 @@
 			printk(" %x", buf[i]);
 		printk(", id = %d\n", id);
 	}
-	if (adb_handler[id].handler != 0) {
-		(*adb_handler[id].handler)(buf, nb, regs, autopoll);
-	}
+	read_lock(&adb_handler_lock);
+	handler = adb_handler[id].handler;
+	if (handler != 0)
+		(*handler)(buf, nb, regs, autopoll);
+	read_unlock(&adb_handler_lock);
 }
 
-/* Try to change handler to new_id. Will return 1 if successful */
-int
-adb_try_handler_change(int address, int new_id)
+/* Try to change handler to new_id. Will return 1 if successful. */
+static int try_handler_change(int address, int new_id)
 {
 	struct adb_request req;
 
@@ -585,11 +605,24 @@
 }
 
 int
+adb_try_handler_change(int address, int new_id)
+{
+	int ret;
+
+	down(&adb_handler_sem);
+	ret = try_handler_change(address, new_id);
+	up(&adb_handler_sem);
+	return ret;
+}
+
+int
 adb_get_infos(int address, int *original_address, int *handler_id)
 {
+	down(&adb_handler_sem);
 	*original_address = adb_handler[address].original_address;
 	*handler_id = adb_handler[address].handler_id;
-	
+	up(&adb_handler_sem);
+
 	return (*original_address != 0);
 }
 
diff -urN linux-2.5/drivers/macintosh/macio-adb.c pmac-2.5/drivers/macintosh/macio-adb.c
--- linux-2.5/drivers/macintosh/macio-adb.c	2002-02-06 04:40:16.000000000 +1100
+++ pmac-2.5/drivers/macintosh/macio-adb.c	2002-10-13 15:00:41.000000000 +1000
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
+#include <linux/spinlock.h>
 #include <asm/prom.h>
 #include <linux/adb.h>
 #include <asm/io.h>
@@ -57,7 +58,7 @@
 
 static volatile struct adb_regs *adb;
 static struct adb_request *current_req, *last_req;
-static unsigned char adb_rbuf[16];
+static spinlock_t macio_lock = SPIN_LOCK_UNLOCKED;
 
 static int macio_probe(void);
 static int macio_init(void);
@@ -66,7 +67,6 @@
 static int macio_adb_autopoll(int devs);
 static void macio_adb_poll(void);
 static int macio_adb_reset_bus(void);
-static void completed(void);
 
 struct adb_driver macio_adb_driver = {
 	"MACIO",
@@ -107,19 +107,19 @@
 	adb = (volatile struct adb_regs *)
 		ioremap(adbs->addrs->address, sizeof(struct adb_regs));
 
-	if (request_irq(adbs->intrs[0].line, macio_adb_interrupt,
-			0, "ADB", (void *)0)) {
-		printk(KERN_ERR "ADB: can't get irq %d\n",
-		       adbs->intrs[0].line);
-		return -EAGAIN;
-	}
-
 	out_8(&adb->ctrl.r, 0);
 	out_8(&adb->intr.r, 0);
 	out_8(&adb->error.r, 0);
 	out_8(&adb->active_hi.r, 0xff); /* for now, set all devices active */
 	out_8(&adb->active_lo.r, 0xff);
 	out_8(&adb->autopoll.r, APE);
+
+	if (request_irq(adbs->intrs[0].line, macio_adb_interrupt,
+			0, "ADB", (void *)0)) {
+		printk(KERN_ERR "ADB: can't get irq %d\n",
+		       adbs->intrs[0].line);
+		return -EAGAIN;
+	}
 	out_8(&adb->intr_enb.r, DFB | TAG);
 
 	printk("adb: mac-io driver 1.0 for unified ADB\n");
@@ -129,16 +129,27 @@
 
 static int macio_adb_autopoll(int devs)
 {
+	unsigned long flags;
+	
+	spin_lock_irqsave(&macio_lock, flags);
 	out_8(&adb->active_hi.r, devs >> 8);
 	out_8(&adb->active_lo.r, devs);
 	out_8(&adb->autopoll.r, devs? APE: 0);
+	spin_unlock_irqrestore(&macio_lock, flags);
 	return 0;
 }
 
 static int macio_adb_reset_bus(void)
 {
+	unsigned long flags;
 	int timeout = 1000000;
 
+	/* Hrm... we may want to not lock interrupts for so
+	 * long ... oh well, who uses that chip anyway ? :)
+	 * That function will be seldomly used during boot
+	 * on rare machines, so...
+	 */
+	spin_lock_irqsave(&macio_lock, flags);
 	out_8(&adb->ctrl.r, in_8(&adb->ctrl.r) | ADB_RST);
 	while ((in_8(&adb->ctrl.r) & ADB_RST) != 0) {
 		if (--timeout == 0) {
@@ -146,13 +157,14 @@
 			return -1;
 		}
 	}
+	spin_unlock_irqrestore(&macio_lock, flags);
 	return 0;
 }
 
 /* Send an ADB command */
 static int macio_send_request(struct adb_request *req, int sync)
 {
-	unsigned long mflags;
+	unsigned long flags;
 	int i;
 	
 	if (req->data[0] != ADB_PACKET)
@@ -167,8 +179,7 @@
 	req->complete = 0;
 	req->reply_len = 0;
 
-	save_flags(mflags);
-	cli();
+	spin_lock_irqsave(&macio_lock, flags);
 	if (current_req != 0) {
 		last_req->next = req;
 		last_req = req;
@@ -176,7 +187,7 @@
 		current_req = last_req = req;
 		out_8(&adb->ctrl.r, in_8(&adb->ctrl.r) | TAR);
 	}
-	restore_flags(mflags);
+	spin_unlock_irqrestore(&macio_lock, flags);
 	
 	if (sync) {
 		while (!req->complete)
@@ -190,7 +201,12 @@
 {
 	int i, n, err;
 	struct adb_request *req;
-
+	unsigned char ibuf[16];
+	int ibuf_len = 0;
+	int complete = 0;
+	int autopoll = 0;
+	
+	spin_lock(&macio_lock);
 	if (in_8(&adb->intr.r) & TAG) {
 		if ((req = current_req) != 0) {
 			/* put the current request in */
@@ -202,7 +218,10 @@
 				out_8(&adb->ctrl.r, DTB + CRE);
 			} else {
 				out_8(&adb->ctrl.r, DTB);
-				completed();
+				current_req = req->next;
+				complete = 1;
+				if (current_req)
+					out_8(&adb->ctrl.r, in_8(&adb->ctrl.r) | TAR);
 			}
 		}
 		out_8(&adb->intr.r, 0);
@@ -218,39 +237,42 @@
 				for (i = 0; i < req->reply_len; ++i)
 					req->reply[i] = in_8(&adb->data[i].r);
 			}
-			completed();
+			current_req = req->next;
+			complete = 1;
+			if (current_req)
+				out_8(&adb->ctrl.r, in_8(&adb->ctrl.r) | TAR);
 		} else if (err == 0) {
 			/* autopoll data */
 			n = in_8(&adb->dcount.r) & HMB;
 			for (i = 0; i < n; ++i)
-				adb_rbuf[i] = in_8(&adb->data[i].r);
-			adb_input(adb_rbuf, n, regs,
-				  in_8(&adb->dcount.r) & APD);
+				ibuf[i] = in_8(&adb->data[i].r);
+			ibuf_len = n;
+			autopoll = (in_8(&adb->dcount.r) & APD) != 0;
 		}
 		out_8(&adb->error.r, 0);
 		out_8(&adb->intr.r, 0);
 	}
-}
-
-static void completed(void)
-{
-	struct adb_request *req = current_req;
-
-	req->complete = 1;
-	current_req = req->next;
-	if (current_req)
-		out_8(&adb->ctrl.r, in_8(&adb->ctrl.r) | TAR);
-	if (req->done)
-		(*req->done)(req);
+	spin_unlock(&macio_lock);
+	if (complete && req) {
+	    void (*done)(struct adb_request *) = req->done;
+	    mb();
+	    req->complete = 1;
+	    /* Here, we assume that if the request has a done member, the
+    	     * struct request will survive to setting req->complete to 1
+	     */
+	    if (done)
+		(*done)(req);
+	}
+	if (ibuf_len)
+		adb_input(ibuf, ibuf_len, regs, autopoll);
 }
 
 static void macio_adb_poll(void)
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	if (in_8(&adb->intr.r) != 0)
 		macio_adb_interrupt(0, 0, 0);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
diff -urN linux-2.5/drivers/macintosh/via-cuda.c pmac-2.5/drivers/macintosh/via-cuda.c
--- linux-2.5/drivers/macintosh/via-cuda.c	2002-07-24 17:12:04.000000000 +1000
+++ pmac-2.5/drivers/macintosh/via-cuda.c	2002-10-13 15:00:41.000000000 +1000
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
+#include <linux/spinlock.h>
 #ifdef CONFIG_PPC
 #include <asm/prom.h>
 #include <asm/machdep.h>
@@ -31,6 +32,7 @@
 #include <linux/init.h>
 
 static volatile unsigned char *via;
+static spinlock_t cuda_lock = SPIN_LOCK_UNLOCKED;
 
 #ifdef CONFIG_MAC
 #define CUDA_IRQ IRQ_MAC_ADB
@@ -386,8 +388,8 @@
     req->sent = 0;
     req->complete = 0;
     req->reply_len = 0;
-    save_flags(flags); cli();
 
+    spin_lock_irqsave(&cuda_lock, flags);
     if (current_req != 0) {
 	last_req->next = req;
 	last_req = req;
@@ -397,15 +399,14 @@
 	if (cuda_state == idle)
 	    cuda_start();
     }
+    spin_unlock_irqrestore(&cuda_lock, flags);
 
-    restore_flags(flags);
     return 0;
 }
 
 static void
 cuda_start()
 {
-    unsigned long flags;
     struct adb_request *req;
 
     /* assert cuda_state == idle */
@@ -413,41 +414,46 @@
     req = current_req;
     if (req == 0)
 	return;
-    save_flags(flags); cli();
-    if ((via[B] & TREQ) == 0) {
-	restore_flags(flags);
+    if ((via[B] & TREQ) == 0)
 	return;			/* a byte is coming in from the CUDA */
-    }
 
     /* set the shift register to shift out and send a byte */
     via[ACR] |= SR_OUT; eieio();
     via[SR] = req->data[0]; eieio();
     via[B] &= ~TIP;
     cuda_state = sent_first_byte;
-    restore_flags(flags);
 }
 
 void
 cuda_poll()
 {
-    unsigned long flags;
+    if (via[IFR] & SR_INT) {
+	unsigned long flags;
 
-    save_flags(flags);
-    cli();
-    if (via[IFR] & SR_INT)
+	/* cuda_interrupt only takes a normal lock, we disable
+	 * interrupts here to avoid re-entering and thus deadlocking.
+	 * An option would be to disable only the IRQ source with
+	 * disable_irq(), would that work on m68k ? --BenH
+	 */
+	local_irq_save(flags);
 	cuda_interrupt(0, 0, 0);
-    restore_flags(flags);
+	local_irq_restore(flags);
+    }
 }
 
 static void
 cuda_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
     int x, status;
-    struct adb_request *req;
-
+    struct adb_request *req = NULL;
+    unsigned char ibuf[16];
+    int ibuf_len = 0;
+    int complete = 0;
+    
     if ((via[IFR] & SR_INT) == 0)
 	return;
 
+    spin_lock(&cuda_lock);
     status = (~via[B] & (TIP|TREQ)) | (via[ACR] & SR_OUT); eieio();
     /* printk("cuda_interrupt: state=%d status=%x\n", cuda_state, status); */
     switch (cuda_state) {
@@ -502,8 +508,7 @@
 		cuda_state = awaiting_reply;
 	    } else {
 		current_req = req->next;
-		if (req->done)
-		    (*req->done)(req);
+		complete = 1;
 		/* not sure about this */
 		cuda_state = idle;
 		cuda_start();
@@ -544,12 +549,18 @@
 		    memmove(req->reply, req->reply + 2, req->reply_len);
 		}
 	    }
-	    req->complete = 1;
 	    current_req = req->next;
-	    if (req->done)
-		(*req->done)(req);
+	    complete = 1;
 	} else {
-	    cuda_input(cuda_rbuf, reply_ptr - cuda_rbuf, regs);
+	    /* This is tricky. We must break the spinlock to call
+	     * cuda_input. However, doing so means we might get
+	     * re-entered from another CPU getting an interrupt
+	     * or calling cuda_poll(). I ended up using the stack
+	     * (it's only for 16 bytes) and moving the actual
+	     * call to cuda_input to outside of the lock.
+	     */
+	    ibuf_len = reply_ptr - cuda_rbuf;
+	    memcpy(ibuf, cuda_rbuf, ibuf_len);
 	}
 	if (status == TREQ) {
 	    via[B] &= ~TIP; eieio();
@@ -565,6 +576,19 @@
     default:
 	printk("cuda_interrupt: unknown cuda_state %d?\n", cuda_state);
     }
+    spin_unlock(&cuda_lock);
+    if (complete && req) {
+    	void (*done)(struct adb_request *) = req->done;
+    	mb();
+    	req->complete = 1;
+    	/* Here, we assume that if the request has a done member, the
+    	 * struct request will survive to setting req->complete to 1
+    	 */
+    	if (done)
+		(*done)(req);
+    }
+    if (ibuf_len)
+	cuda_input(ibuf, ibuf_len, regs);
 }
 
 static void
diff -urN linux-2.5/drivers/macintosh/via-pmu.c pmac-2.5/drivers/macintosh/via-pmu.c
--- linux-2.5/drivers/macintosh/via-pmu.c	2002-08-29 09:08:29.000000000 +1000
+++ pmac-2.5/drivers/macintosh/via-pmu.c	2002-10-13 15:00:41.000000000 +1000
@@ -9,11 +9,7 @@
  * and the RTC (real time clock) chip.
  *
  * Copyright (C) 1998 Paul Mackerras and Fabio Riccardi.
- * Copyright (C) 2001 Benjamin Herrenschmidt
- * 
- * todo: - Cleanup synchro between VIA interrupt and GPIO-based PMU
- *         interrupt.
- *
+ * Copyright (C) 2001-2002 Benjamin Herrenschmidt
  *
  */
 #include <stdarg.h>
@@ -111,14 +107,24 @@
 	reading_intr,
 } pmu_state;
 
+static volatile enum int_data_state {
+	int_data_empty,
+	int_data_fill,
+	int_data_ready,
+	int_data_flush
+} int_data_state[2] = { int_data_empty, int_data_empty };
+
 static struct adb_request *current_req;
 static struct adb_request *last_req;
 static struct adb_request *req_awaiting_reply;
-static unsigned char interrupt_data[256]; /* Made bigger: I've been told that might happen */
+static unsigned char interrupt_data[2][32];
+static int interrupt_data_len[2];
+static int int_data_last;
 static unsigned char *reply_ptr;
 static int data_index;
 static int data_len;
 static volatile int adb_int_pending;
+static volatile int disable_poll;
 static struct adb_request bright_req_1, bright_req_2, bright_req_3;
 static struct device_node *vias;
 static int pmu_kind = PMU_UNKNOWN;
@@ -174,12 +180,6 @@
 static int pmu_queue_request(struct adb_request *req);
 static void pmu_start(void);
 static void via_pmu_interrupt(int irq, void *arg, struct pt_regs *regs);
-static void send_byte(int x);
-static void recv_byte(void);
-static void pmu_sr_intr(struct pt_regs *regs);
-static void pmu_done(struct adb_request *req);
-static void pmu_handle_data(unsigned char *data, int len,
-			    struct pt_regs *regs);
 static void gpio1_interrupt(int irq, void *arg, struct pt_regs *regs);
 static int proc_get_info(char *page, char **start, off_t off,
 			  int count, int *eof, void *data);
@@ -521,8 +521,8 @@
 
 	/* ack all pending interrupts */
 	timeout = 100000;
-	interrupt_data[0] = 1;
-	while (interrupt_data[0] || pmu_state != idle) {
+	interrupt_data[0][0] = 1;
+	while (interrupt_data[0][0] || pmu_state != idle) {
 		if (--timeout < 0) {
 			printk(KERN_ERR "init_pmu: timed out acking intrs\n");
 			return 0;
@@ -1176,7 +1176,7 @@
 	return 0;
 }
 
-static void __openfirmware
+static inline void
 wait_for_ack(void)
 {
 	/* Sightly increased the delay, I had one occurence of the message
@@ -1194,7 +1194,7 @@
 
 /* New PMU seems to be very sensitive to those timings, so we make sure
  * PCI is flushed immediately */
-static void __openfirmware
+static inline void
 send_byte(int x)
 {
 	volatile unsigned char *v = via;
@@ -1205,8 +1205,8 @@
 	(void)in_8(&v[B]);
 }
 
-static void __openfirmware
-recv_byte()
+static inline void
+recv_byte(void)
 {
 	volatile unsigned char *v = via;
 
@@ -1216,7 +1216,18 @@
 	(void)in_8(&v[B]);
 }
 
-static volatile int disable_poll;
+static inline void
+pmu_done(struct adb_request *req)
+{
+	void (*done)(struct adb_request *) = req->done;
+	mb();
+	req->complete = 1;
+    	/* Here, we assume that if the request has a done member, the
+    	 * struct request will survive to setting req->complete to 1
+    	 */
+	if (done)
+		(*done)(req);
+}
 
 static void __openfirmware
 pmu_start()
@@ -1281,9 +1292,9 @@
 	}
 
 	do {
-		spin_unlock(&pmu_lock);
+		spin_unlock_irqrestore(&pmu_lock, flags);
 		via_pmu_interrupt(0, 0, 0);
-		spin_lock(&pmu_lock);
+		spin_lock_irqsave(&pmu_lock, flags);
 		if (!adb_int_pending && pmu_state == idle && !req_awaiting_reply) {
 #ifdef SUSPEND_USES_PMU
 			pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, 0);
@@ -1330,61 +1341,83 @@
 #endif /* SUSPEND_USES_PMU */
 }
 
+/* Interrupt data could be the result data from an ADB cmd */
 static void __openfirmware
-via_pmu_interrupt(int irq, void *arg, struct pt_regs *regs)
+pmu_handle_data(unsigned char *data, int len, struct pt_regs *regs)
 {
-	unsigned long flags;
-	int intr;
-	int nloop = 0;
-
-	/* This is a bit brutal, we can probably do better */
-	spin_lock_irqsave(&pmu_lock, flags);
-	++disable_poll;
-	
-	for (;;) {
-		intr = in_8(&via[IFR]) & (SR_INT | CB1_INT);
-		if (intr == 0)
-			break;
-		if (++nloop > 1000) {
-			printk(KERN_DEBUG "PMU: stuck in intr loop, "
-			       "intr=%x, ier=%x pmu_state=%d\n",
-			       intr, in_8(&via[IER]), pmu_state);
-			break;
-		}
-		out_8(&via[IFR], intr);
-		if (intr & SR_INT)
-			pmu_sr_intr(regs);
-		if (intr & CB1_INT)
-			adb_int_pending = 1;
+	asleep = 0;
+	if (drop_interrupts || len < 1) {
+		adb_int_pending = 0;
+		return;
 	}
-
-	if (pmu_state == idle) {
-		if (adb_int_pending) {
-			pmu_state = intack;
-			/* Sounds safer to make sure ACK is high before writing.
-			 * This helped kill a problem with ADB and some iBooks
+	/* Note: for some reason, we get an interrupt with len=1,
+	 * data[0]==0 after each normal ADB interrupt, at least
+	 * on the Pismo. Still investigating...  --BenH
+	 */
+	if (data[0] & PMU_INT_ADB) {
+		if ((data[0] & PMU_INT_ADB_AUTO) == 0) {
+			struct adb_request *req = req_awaiting_reply;
+			if (req == 0) {
+				printk(KERN_ERR "PMU: extra ADB reply\n");
+				return;
+			}
+			req_awaiting_reply = 0;
+			if (len <= 2)
+				req->reply_len = 0;
+			else {
+				memcpy(req->reply, data + 1, len - 1);
+				req->reply_len = len - 1;
+			}
+			pmu_done(req);
+		} else {
+#ifdef CONFIG_XMON
+			if (len == 4 && data[1] == 0x2c) {
+				extern int xmon_wants_key, xmon_adb_keycode;
+				if (xmon_wants_key) {
+					xmon_adb_keycode = data[2];
+					return;
+				}
+			}
+#endif /* CONFIG_XMON */
+#ifdef CONFIG_ADB
+			/*
+			 * XXX On the [23]400 the PMU gives us an up
+			 * event for keycodes 0x74 or 0x75 when the PC
+			 * card eject buttons are released, so we
+			 * ignore those events.
 			 */
-			wait_for_ack();
-			send_byte(PMU_INT_ACK);
-			adb_int_pending = 0;
-		} else if (current_req)
-			pmu_start();
-	}
-	
-	--disable_poll;
-	spin_unlock_irqrestore(&pmu_lock, flags);
-}
-
-static void __openfirmware
-gpio1_interrupt(int irq, void *arg, struct pt_regs *regs)
-{
-	if ((in_8(gpio_reg + 0x9) & 0x02) == 0) {
-		adb_int_pending = 1;
-		via_pmu_interrupt(0, 0, 0);
+			if (!(pmu_kind == PMU_OHARE_BASED && len == 4
+			      && data[1] == 0x2c && data[3] == 0xff
+			      && (data[2] & ~1) == 0xf4))
+				adb_input(data+1, len-1, regs, 1);
+#endif /* CONFIG_ADB */		
+		}
+	} else {
+		/* Sound/brightness button pressed */
+		if ((data[0] & PMU_INT_SNDBRT) && len == 3) {
+#ifdef CONFIG_PMAC_BACKLIGHT
+#ifdef CONFIG_INPUT_ADBHID
+			if (!disable_kernel_backlight)
+#endif /* CONFIG_INPUT_ADBHID */
+				set_backlight_level(data[1] >> 4);
+#endif /* CONFIG_PMAC_BACKLIGHT */
+		}
+#ifdef CONFIG_PMAC_PBOOK
+		/* Environement or tick interrupt, query batteries */
+		if (pmu_battery_count && (data[0] & PMU_INT_TICK)) {
+			if ((--query_batt_timer) == 0) {
+				query_battery_state();
+				query_batt_timer = BATTERY_POLLING_COUNT;
+			}
+		} else if (pmu_battery_count && (data[0] & PMU_INT_ENVIRONMENT))
+			query_battery_state();
+ 		if (data[0])
+			pmu_pass_intr(data, len);
+#endif /* CONFIG_PMAC_PBOOK */
 	}
 }
 
-static void __openfirmware
+static struct adb_request* __openfirmware
 pmu_sr_intr(struct pt_regs *regs)
 {
 	struct adb_request *req;
@@ -1393,7 +1426,7 @@
 	if (via[B] & TREQ) {
 		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", via[B]);
 		out_8(&via[IFR], SR_INT);
-		return;
+		return NULL;
 	}
 	/* The ack may not yet be low when we get the interrupt */
 	while ((in_8(&via[B]) & TACK) != 0)
@@ -1426,11 +1459,8 @@
 			current_req = req->next;
 			if (req->reply_expected)
 				req_awaiting_reply = req;
-			else {
-				spin_unlock(&pmu_lock);
-				pmu_done(req);
-				spin_lock(&pmu_lock);
-			}
+			else
+				return req;
 		} else {
 			pmu_state = reading;
 			data_index = 0;
@@ -1443,7 +1473,7 @@
 		data_index = 0;
 		data_len = -1;
 		pmu_state = reading_intr;
-		reply_ptr = interrupt_data;
+		reply_ptr = interrupt_data[int_data_last];
 		recv_byte();
 		break;
 
@@ -1462,108 +1492,113 @@
 		}
 
 		if (pmu_state == reading_intr) {
-			spin_unlock(&pmu_lock);
-			pmu_handle_data(interrupt_data, data_index, regs);
-			spin_lock(&pmu_lock);
+			pmu_state = idle;
+			int_data_state[int_data_last] = int_data_ready;
+			interrupt_data_len[int_data_last] = data_len;
 		} else {
 			req = current_req;
 			current_req = req->next;
 			req->reply_len += data_index;
-			spin_unlock(&pmu_lock);
-			pmu_done(req);
-			spin_lock(&pmu_lock);
+			pmu_state = idle;
+			return req;
 		}
-		pmu_state = idle;
-
 		break;
 
 	default:
 		printk(KERN_ERR "via_pmu_interrupt: unknown state %d?\n",
 		       pmu_state);
 	}
+	return NULL;
 }
 
 static void __openfirmware
-pmu_done(struct adb_request *req)
+via_pmu_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
-	req->complete = 1;
-	if (req->done)
-		(*req->done)(req);
+	unsigned long flags;
+	int intr;
+	int nloop = 0;
+	int int_data = -1;
+	struct adb_request *req = NULL;
+	
+	/* This is a bit brutal, we can probably do better */
+	spin_lock_irqsave(&pmu_lock, flags);
+	++disable_poll;
+	
+	for (;;) {
+		intr = in_8(&via[IFR]) & (SR_INT | CB1_INT);
+		if (intr == 0)
+			break;
+		if (++nloop > 1000) {
+			printk(KERN_DEBUG "PMU: stuck in intr loop, "
+			       "intr=%x, ier=%x pmu_state=%d\n",
+			       intr, in_8(&via[IER]), pmu_state);
+			break;
+		}
+		out_8(&via[IFR], intr);
+		if (intr & CB1_INT)
+			adb_int_pending = 1;
+		if (intr & SR_INT) {
+			req = pmu_sr_intr(regs);
+			if (req)
+				break;
+		}
+	}
+
+recheck:
+	if (pmu_state == idle) {
+		if (adb_int_pending) {
+			if (int_data_state[0] == int_data_empty)
+				int_data_last = 0;
+			else if (int_data_state[1] == int_data_empty)
+				int_data_last = 1;
+			else
+				goto no_free_slot;
+			pmu_state = intack;
+			int_data_state[int_data_last] = int_data_fill;
+			/* Sounds safer to make sure ACK is high before writing.
+			 * This helped kill a problem with ADB and some iBooks
+			 */
+			wait_for_ack();
+			send_byte(PMU_INT_ACK);
+			adb_int_pending = 0;
+no_free_slot:			
+		} else if (current_req)
+			pmu_start();
+	}
+	/* Mark the oldest buffer for flushing */
+	if (int_data_state[!int_data_last] == int_data_ready) {
+		int_data_state[!int_data_last] = int_data_flush;
+		int_data = !int_data_last;
+	} else if (int_data_state[int_data_last] == int_data_ready) {
+		int_data_state[int_data_last] = int_data_flush;
+		int_data = int_data_last;
+	}
+	--disable_poll;
+	spin_unlock_irqrestore(&pmu_lock, flags);
+
+	/* Deal with completed PMU requests outside of the lock */
+	if (req) {
+		pmu_done(req);
+		req = NULL;
+	}
+		
+	/* Deal with interrupt datas outside of the lock */
+	if (int_data >= 0) {
+		pmu_handle_data(interrupt_data[int_data], interrupt_data_len[int_data], regs);
+		spin_lock_irqsave(&pmu_lock, flags);
+		++disable_poll;
+		int_data_state[int_data] = int_data_empty;
+		int_data = -1;
+		goto recheck;
+	}
 }
 
-/* Interrupt data could be the result data from an ADB cmd */
 static void __openfirmware
-pmu_handle_data(unsigned char *data, int len, struct pt_regs *regs)
+gpio1_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
-	asleep = 0;
-	if (drop_interrupts || len < 1) {
-		adb_int_pending = 0;
-		return;
-	}
-	/* Note: for some reason, we get an interrupt with len=1,
-	 * data[0]==0 after each normal ADB interrupt, at least
-	 * on the Pismo. Still investigating...  --BenH
-	 */
-	if (data[0] & PMU_INT_ADB) {
-		if ((data[0] & PMU_INT_ADB_AUTO) == 0) {
-			struct adb_request *req = req_awaiting_reply;
-			if (req == 0) {
-				printk(KERN_ERR "PMU: extra ADB reply\n");
-				return;
-			}
-			req_awaiting_reply = 0;
-			if (len <= 2)
-				req->reply_len = 0;
-			else {
-				memcpy(req->reply, data + 1, len - 1);
-				req->reply_len = len - 1;
-			}
-			pmu_done(req);
-		} else {
-#ifdef CONFIG_XMON
-			if (len == 4 && data[1] == 0x2c) {
-				extern int xmon_wants_key, xmon_adb_keycode;
-				if (xmon_wants_key) {
-					xmon_adb_keycode = data[2];
-					return;
-				}
-			}
-#endif /* CONFIG_XMON */
-#ifdef CONFIG_ADB
-			/*
-			 * XXX On the [23]400 the PMU gives us an up
-			 * event for keycodes 0x74 or 0x75 when the PC
-			 * card eject buttons are released, so we
-			 * ignore those events.
-			 */
-			if (!(pmu_kind == PMU_OHARE_BASED && len == 4
-			      && data[1] == 0x2c && data[3] == 0xff
-			      && (data[2] & ~1) == 0xf4))
-				adb_input(data+1, len-1, regs, 1);
-#endif /* CONFIG_ADB */		
-		}
-	} else {
-		/* Sound/brightness button pressed */
-		if ((data[0] & PMU_INT_SNDBRT) && len == 3) {
-#ifdef CONFIG_PMAC_BACKLIGHT
-#ifdef CONFIG_INPUT_ADBHID
-			if (!disable_kernel_backlight)
-#endif /* CONFIG_INPUT_ADBHID */
-				set_backlight_level(data[1] >> 4);
-#endif /* CONFIG_PMAC_BACKLIGHT */
-		}
-#ifdef CONFIG_PMAC_PBOOK
-		/* Environement or tick interrupt, query batteries */
-		if (pmu_battery_count && (data[0] & PMU_INT_TICK)) {
-			if ((--query_batt_timer) == 0) {
-				query_battery_state();
-				query_batt_timer = BATTERY_POLLING_COUNT;
-			}
-		} else if (pmu_battery_count && (data[0] & PMU_INT_ENVIRONMENT))
-			query_battery_state();
- 		if (data[0])
-			pmu_pass_intr(data, len);
-#endif /* CONFIG_PMAC_PBOOK */
+	if ((in_8(gpio_reg + 0x9) & 0x02) == 0) {
+		adb_int_pending = 1;
+		via_pmu_interrupt(0, 0, 0);
 	}
 }
 
@@ -1635,7 +1670,7 @@
 {
 	struct adb_request req;
 
-	cli();
+	local_irq_disable();
 
 	drop_interrupts = 1;
 	
@@ -1658,7 +1693,7 @@
 {
 	struct adb_request req;
 
-	cli();
+	local_irq_disable();
 
 	drop_interrupts = 1;
 
@@ -1979,7 +2014,7 @@
 	unsigned long save_l2cr;
 	unsigned short pmcr1;
 	struct adb_request req;
-	int ret, timeout;
+	int ret;
 	struct pci_dev *grackle;
 
 	grackle = pci_find_slot(0, 0);
@@ -2036,17 +2071,16 @@
 	mb();
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
 	
-	/* Giveup the FPU */
-	if (current->thread.regs && (current->thread.regs->msr & MSR_FP) != 0)
-		giveup_fpu(current);
-
 	/* We can now disable MSR_EE */
-	cli();
+	local_irq_disable();
+
+	/* Giveup the FPU */
+	enable_kernel_fp();
 
 	/* For 750, save backside cache setting and disable it */
-	save_l2cr = _get_L2CR();	/* (returns 0 if not 750) */
-	if (save_l2cr)
-		_set_L2CR(0);
+	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
+	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
+		_set_L2CR(save_l2cr & 0x7fffffff);
 
 	/* Ask the PMU to put us to sleep */
 	pmu_request(&req, NULL, 5, PMU_SLEEP, 'M', 'A', 'T', 'T');
@@ -2077,7 +2111,7 @@
 	restore_via_state();
 	
 	/* Restore L2 cache */
-	if (save_l2cr)
+	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
  		_set_L2CR(save_l2cr);
 	
 	/* Restore userland MMU context */
@@ -2096,18 +2130,6 @@
 	while (!req.complete)
 		pmu_poll();
 
-	/* ack all pending interrupts */
-	timeout = 100000;
-	interrupt_data[0] = 1;
-	while (interrupt_data[0] || pmu_state != idle) {
-		if (--timeout < 0)
-			break;
-		if (pmu_state == idle)
-			adb_int_pending = 1;
-		via_pmu_interrupt(0, 0, 0);
-		udelay(10);
-	}
-
 	/* reenable interrupt controller */
 	pmac_sleep_restore_intrs();
 
@@ -2116,7 +2138,13 @@
 
 	/* Restart jiffies & scheduling */
 	wakeup_decrementer();
-	sti();
+
+	/* Force a poll of ADB interrupts */
+	adb_int_pending = 1;
+	via_pmu_interrupt(0, 0, 0);
+
+	/* Re-enable local CPU interrupts */
+	local_irq_enable();
 
 	/* Notify drivers */
 	broadcast_wake();
@@ -2127,8 +2155,9 @@
 int __openfirmware powerbook_sleep_Core99(void)
 {
 	unsigned long save_l2cr;
+	unsigned long save_l3cr;
 	struct adb_request req;
-	int ret, timeout;
+	int ret;
 	
 	if (!can_sleep) {
 		printk(KERN_ERR "Sleep mode not supported on this machine\n");
@@ -2187,6 +2216,9 @@
 	mb();
 	asm volatile("mtdec %0" : : "r" (0x7fffffff));
 
+	/* We can now disable MSR_EE */
+	local_irq_disable();
+
 	/* Giveup the FPU & vec */
 	enable_kernel_fp();
 
@@ -2195,12 +2227,12 @@
 		enable_kernel_altivec();
 #endif /* CONFIG_ALTIVEC */
 
-	/* We can now disable MSR_EE */
-	cli();
-
-	/* For 750, save backside cache setting and disable it */
-	save_l2cr = _get_L2CR();	/* (returns 0 if not 750) */
-	if (save_l2cr)
+	/* Save & disable L2 and L3 caches*/
+	save_l3cr = _get_L3CR();	/* (returns -1 if not available) */
+	save_l2cr = _get_L2CR();	/* (returns -1 if not available) */
+	if (save_l3cr != 0xffffffff && (save_l3cr & L3CR_L3E) != 0)
+		_set_L3CR(save_l3cr & 0x7fffffff);
+	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
 		_set_L2CR(save_l2cr & 0x7fffffff);
 
 	/* Save the state of PCI config space for some slots */
@@ -2248,8 +2280,11 @@
 	pmu_blink(2);
 		
 	/* Restore L2 cache */
-	if (save_l2cr)
+	if (save_l2cr != 0xffffffff && (save_l2cr & L2CR_L2E) != 0)
  		_set_L2CR(save_l2cr);
+	/* Restore L3 cache */
+	if (save_l3cr != 0xffffffff && (save_l3cr & L3CR_L3E) != 0)
+ 		_set_L3CR(save_l3cr);
 	
 	/* Restore userland MMU context */
 	set_context(current->active_mm->context, current->active_mm->pgd);
@@ -2262,18 +2297,6 @@
 	while (!req.complete)
 		pmu_poll();
 		
-	/* ack all pending interrupts */
-	timeout = 100000;
-	interrupt_data[0] = 1;
-	while (interrupt_data[0] || pmu_state != idle) {
-		if (--timeout < 0)
-			break;
-		if (pmu_state == idle)
-			adb_int_pending = 1;
-		via_pmu_interrupt(0, 0, 0);
-		udelay(10);
-	}
-
 	/* reenable interrupt controller */
 	openpic_sleep_restore_intrs();
 
@@ -2282,7 +2305,13 @@
 
 	/* Restart jiffies & scheduling */
 	wakeup_decrementer();
-	sti();
+
+	/* Force a poll of ADB interrupts */
+	adb_int_pending = 1;
+	via_pmu_interrupt(0, 0, 0);
+
+	/* Re-enable local CPU interrupts */
+	local_irq_enable();
 
 	/* Notify drivers */
 	broadcast_wake();
@@ -2402,7 +2431,9 @@
 
 	/* Restart jiffies & scheduling */
 	wakeup_decrementer();
-	sti();
+
+	/* Re-enable local CPU interrupts */
+	local_irq_enable();
 
 	/* Notify drivers */
 	broadcast_wake();
@@ -2718,7 +2749,7 @@
 	if (l >= 0 && req->nbytes != l + 1)
 		return -EINVAL;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	while (pmu_state != idle)
 		pmu_poll();
 
@@ -2741,7 +2772,7 @@
 	if (req->done)
 		(*req->done)(req);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 }
 #endif /* DEBUG_SLEEP */
