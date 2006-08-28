Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWH1U3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWH1U3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWH1U3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:29:15 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48143 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751481AbWH1U3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:29:13 -0400
Date: Mon, 28 Aug 2006 16:29:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] Change return value from schedule_work
Message-ID: <Pine.LNX.4.44L0.0608281628150.6800-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as775) renames:

	schedule_work()			to add_work(),
	schedule_delayed_work()		to add_delayed_work(),
	schedule_delayed_work_on()	to add_delayed_work_on().

The return value is altered, so that now 0 = success and -EBUSY = failure.

New routines with the original names are added, so that the majority of
callers don't need any changes.  The new routines call the original
functions, call WARN_ON if there was a failure, and then return void.

schedule_console_callback() in drivers/char/vt.c required special
alteration, because it normally called schedule_work() expecting the
call to fail.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Index: mm/drivers/usb/net/usbnet.c
===================================================================
--- mm.orig/drivers/usb/net/usbnet.c
+++ mm/drivers/usb/net/usbnet.c
@@ -286,7 +286,7 @@ static void defer_bh(struct usbnet *dev,
 void usbnet_defer_kevent (struct usbnet *dev, int work)
 {
 	set_bit (work, &dev->flags);
-	if (!schedule_work (&dev->kevent))
+	if (add_work (&dev->kevent) < 0)
 		deverr (dev, "kevent %d may have been dropped", work);
 	else
 		devdbg (dev, "kevent %d scheduled", work);
Index: mm/drivers/input/serio/libps2.c
===================================================================
--- mm.orig/drivers/input/serio/libps2.c
+++ mm/drivers/input/serio/libps2.c
@@ -272,7 +272,7 @@ int ps2_schedule_command(struct ps2dev *
 	memcpy(ps2work->param, param, send);
 	INIT_WORK(&ps2work->work, ps2_execute_scheduled_command, ps2work);
 
-	if (!schedule_work(&ps2work->work)) {
+	if (add_work(&ps2work->work) < 0) {
 		kfree(ps2work);
 		return -1;
 	}
Index: mm/fs/file.c
===================================================================
--- mm.orig/fs/file.c
+++ mm/fs/file.c
@@ -85,7 +85,7 @@ static void fdtable_timer(unsigned long 
 	 */
 	if (!fddef->next)
 		goto out;
-	if (!schedule_work(&fddef->wq))
+	if (add_work(&fddef->wq) < 0)
 		mod_timer(&fddef->timer, 5);
 out:
 	spin_unlock(&fddef->lock);
@@ -147,7 +147,7 @@ static void free_fdtable_rcu(struct rcu_
 		 * If the per-cpu workqueue is running, then we
 		 * defer work scheduling through a timer.
 		 */
-		if (!schedule_work(&fddef->wq))
+		if (add_work(&fddef->wq) < 0)
 			mod_timer(&fddef->timer, 5);
 		spin_unlock(&fddef->lock);
 		put_cpu_var(fdtable_defer_list);
Index: mm/drivers/net/smc91x.c
===================================================================
--- mm.orig/drivers/net/smc91x.c
+++ mm/drivers/net/smc91x.c
@@ -1436,9 +1436,8 @@ static void smc_timeout(struct net_devic
 	 * which calls schedule().  Hence we use a work queue.
 	 */
 	if (lp->phy_type != 0) {
-		if (schedule_work(&lp->phy_configure)) {
+		if (add_work(&lp->phy_configure) == 0)
 			lp->work_pending = 1;
-		}
 	}
 
 	/* We can accept TX packets again */
Index: mm/kernel/workqueue.c
===================================================================
--- mm.orig/kernel/workqueue.c
+++ mm/kernel/workqueue.c
@@ -449,33 +449,33 @@ EXPORT_SYMBOL_GPL(destroy_workqueue);
 static struct workqueue_struct *keventd_wq;
 
 /**
- * schedule_work - put work task in global workqueue
+ * add_work - put work task in global workqueue
  * @work: job to be done
  *
  * This puts a job in the kernel-global workqueue.
  */
-int fastcall schedule_work(struct work_struct *work)
+int fastcall add_work(struct work_struct *work)
 {
-	return !add_work_to_q(keventd_wq, work);
+	return add_work_to_q(keventd_wq, work);
 }
-EXPORT_SYMBOL(schedule_work);
+EXPORT_SYMBOL(add_work);
 
 /**
- * schedule_delayed_work - put work task in global workqueue after delay
+ * add_delayed_work - put work task in global workqueue after delay
  * @work: job to be done
  * @delay: number of jiffies to wait
  *
  * After waiting for a given time this puts a job in the kernel-global
  * workqueue.
  */
-int fastcall schedule_delayed_work(struct work_struct *work, unsigned long delay)
+int fastcall add_delayed_work(struct work_struct *work, unsigned long delay)
 {
-	return !add_delayed_work_to_q(keventd_wq, work, delay);
+	return add_delayed_work_to_q(keventd_wq, work, delay);
 }
-EXPORT_SYMBOL(schedule_delayed_work);
+EXPORT_SYMBOL(add_delayed_work);
 
 /**
- * schedule_delayed_work_on - queue work in global workqueue on CPU after delay
+ * add_delayed_work_on - queue work in global workqueue on CPU after delay
  * @cpu: cpu to use
  * @work: job to be done
  * @delay: number of jiffies to wait
@@ -483,12 +483,12 @@ EXPORT_SYMBOL(schedule_delayed_work);
  * After waiting for a given time this puts a job in the kernel-global
  * workqueue on the specified CPU.
  */
-int schedule_delayed_work_on(int cpu,
+int add_delayed_work_on(int cpu,
 			struct work_struct *work, unsigned long delay)
 {
-	return !add_delayed_work_to_q_on(cpu, keventd_wq, work, delay);
+	return add_delayed_work_to_q_on(cpu, keventd_wq, work, delay);
 }
-EXPORT_SYMBOL(schedule_delayed_work_on);
+EXPORT_SYMBOL(add_delayed_work_on);
 
 /*
  * Legacy API for use when the return codes aren't needed.
@@ -523,6 +523,35 @@ void queue_delayed_work_on(int cpu, stru
 }
 EXPORT_SYMBOL(queue_delayed_work_on);
 
+void fastcall schedule_work(struct work_struct *work)
+{
+	int rc;
+
+	rc = add_work_to_q(keventd_wq, work);
+	WARN_ON(rc < 0);
+}
+EXPORT_SYMBOL(schedule_work);
+
+void fastcall schedule_delayed_work(struct work_struct *work,
+		unsigned long delay)
+{
+	int rc;
+
+	rc = add_delayed_work_to_q(keventd_wq, work, delay);
+	WARN_ON(rc < 0);
+}
+EXPORT_SYMBOL(schedule_delayed_work);
+
+void schedule_delayed_work_on(int cpu, struct work_struct *work,
+		unsigned long delay)
+{
+	int rc;
+
+	rc = add_delayed_work_to_q_on(cpu, keventd_wq, work, delay);
+	WARN_ON(rc < 0);
+}
+EXPORT_SYMBOL(schedule_delayed_work_on);
+
 /**
  * schedule_on_each_cpu - call a function on each online CPU from keventd
  * @func: the function to call
Index: mm/include/linux/workqueue.h
===================================================================
--- mm.orig/include/linux/workqueue.h
+++ mm/include/linux/workqueue.h
@@ -69,10 +69,12 @@ extern int add_delayed_work_to_q_on(int 
 		struct work_struct *work, unsigned long delay);
 extern void FASTCALL(flush_workqueue(struct workqueue_struct *wq));
 
-extern int FASTCALL(schedule_work(struct work_struct *work));
-extern int FASTCALL(schedule_delayed_work(struct work_struct *work, unsigned long delay));
+extern int FASTCALL(add_work(struct work_struct *work));
+extern int FASTCALL(add_delayed_work(struct work_struct *work,
+		unsigned long delay));
+extern int add_delayed_work_on(int cpu, struct work_struct *work,
+		unsigned long delay);
 
-extern int schedule_delayed_work_on(int cpu, struct work_struct *work, unsigned long delay);
 extern int schedule_on_each_cpu(void (*func)(void *info), void *info);
 extern void flush_scheduled_work(void);
 extern int current_is_keventd(void);
@@ -111,4 +113,10 @@ extern void FASTCALL(queue_delayed_work(
 extern void queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 		struct work_struct *work, unsigned long delay);
 
+extern void FASTCALL(schedule_work(struct work_struct *work));
+extern void FASTCALL(schedule_delayed_work(struct work_struct *work,
+		unsigned long delay));
+extern void schedule_delayed_work_on(int cpu, struct work_struct *work,
+		unsigned long delay);
+
 #endif
Index: mm/drivers/usb/gadget/ether.c
===================================================================
--- mm.orig/drivers/usb/gadget/ether.c
+++ mm/drivers/usb/gadget/ether.c
@@ -1604,7 +1604,7 @@ static void defer_kevent (struct eth_dev
 {
 	if (test_and_set_bit (flag, &dev->todo))
 		return;
-	if (!schedule_work (&dev->work))
+	if (add_work (&dev->work) < 0)
 		ERROR (dev, "kevent %d may have been dropped\n", flag);
 	else
 		DEBUG (dev, "kevent %d scheduled\n", flag);
Index: mm/drivers/char/genrtc.c
===================================================================
--- mm.orig/drivers/char/genrtc.c
+++ mm/drivers/char/genrtc.c
@@ -122,7 +122,7 @@ static void genrtc_troutine(void *data)
 		add_timer(&timer_task);
 
 		gen_rtc_interrupt(0);
-	} else if (schedule_work(&genrtc_task) == 0)
+	} else if (add_work(&genrtc_task) < 0)
 		stask_active = 0;
 }
 
@@ -136,7 +136,7 @@ static void gen_rtc_timer(unsigned long 
 		       jiffies-tt_exp);
 	ttask_active=0;
 	stask_active=1;
-	if ((schedule_work(&genrtc_task) == 0))
+	if (add_work(&genrtc_task) < 0)
 		stask_active = 0;
 }
 
@@ -260,9 +260,8 @@ static inline int gen_set_rtc_irq_bit(un
 		init_timer(&timer_task);
 
 		stask_active = 1;
-		if (schedule_work(&genrtc_task) == 0){
+		if (add_work(&genrtc_task) < 0)
 			stask_active = 0;
-		}
 	}
 	spin_unlock(&gen_rtc_lock);
 	gen_rtc_irq_data = 0;
Index: mm/drivers/rtc/rtc-dev.c
===================================================================
--- mm.orig/drivers/rtc/rtc-dev.c
+++ mm/drivers/rtc/rtc-dev.c
@@ -71,7 +71,7 @@ static void rtc_uie_task(void *data)
 		rtc->uie_timer_active = 1;
 		rtc->uie_task_active = 0;
 		add_timer(&rtc->uie_timer);
-	} else if (schedule_work(&rtc->uie_task) == 0) {
+	} else if (add_work(&rtc->uie_task) < 0) {
 		rtc->uie_task_active = 0;
 	}
 	spin_unlock_irq(&rtc->irq_lock);
@@ -87,7 +87,7 @@ static void rtc_uie_timer(unsigned long 
 	spin_lock_irqsave(&rtc->irq_lock, flags);
 	rtc->uie_timer_active = 0;
 	rtc->uie_task_active = 1;
-	if ((schedule_work(&rtc->uie_task) == 0))
+	if (add_work(&rtc->uie_task) < 0)
 		rtc->uie_task_active = 0;
 	spin_unlock_irqrestore(&rtc->irq_lock, flags);
 }
@@ -127,7 +127,7 @@ static int set_uie(struct rtc_device *rt
 		rtc->stop_uie_polling = 0;
 		rtc->oldsecs = tm.tm_sec;
 		rtc->uie_task_active = 1;
-		if (schedule_work(&rtc->uie_task) == 0)
+		if (add_work(&rtc->uie_task) < 0)
 			rtc->uie_task_active = 0;
 	}
 	rtc->irq_data = 0;
Index: mm/drivers/usb/input/hid-core.c
===================================================================
--- mm.orig/drivers/usb/input/hid-core.c
+++ mm/drivers/usb/input/hid-core.c
@@ -988,7 +988,7 @@ static void hid_io_error(struct hid_devi
 
 		/* Retries failed, so do a port reset */
 		if (!test_and_set_bit(HID_RESET_PENDING, &hid->iofl)) {
-			if (schedule_work(&hid->reset_work))
+			if (add_work(&hid->reset_work) == 0)
 				goto done;
 			clear_bit(HID_RESET_PENDING, &hid->iofl);
 		}
Index: mm/drivers/net/smc911x.c
===================================================================
--- mm.orig/drivers/net/smc911x.c
+++ mm/drivers/net/smc911x.c
@@ -1362,9 +1362,8 @@ static void smc911x_timeout(struct net_d
 	 * which calls schedule().	 Hence we use a work queue.
 	 */
 	if (lp->phy_type != 0) {
-		if (schedule_work(&lp->phy_configure)) {
+		if (add_work(&lp->phy_configure) == 0)
 			lp->work_pending = 1;
-		}
 	}
 
 	/* We can accept TX packets again */
Index: mm/drivers/i2c/chips/isp1301_omap.c
===================================================================
--- mm.orig/drivers/i2c/chips/isp1301_omap.c
+++ mm/drivers/i2c/chips/isp1301_omap.c
@@ -357,8 +357,8 @@ isp1301_defer_work(struct isp1301 *isp, 
 
 	if (isp && !test_and_set_bit(work, &isp->todo)) {
 		(void) get_device(&isp->client.dev);
-		status = schedule_work(&isp->work);
-		if (!status && !isp->working)
+		status = add_work(&isp->work);
+		if (status < 0 && !isp->working)
 			dev_vdbg(&isp->client.dev,
 				"work item %d may be lost\n", work);
 	}
Index: mm/drivers/char/vt.c
===================================================================
--- mm.orig/drivers/char/vt.c
+++ mm/drivers/char/vt.c
@@ -263,7 +263,11 @@ static inline void scrolldelta(int lines
 
 void schedule_console_callback(void)
 {
-	schedule_work(&console_work);
+	/*
+	 * If a callback is already scheduled then this will fail.
+	 * That's okay; the callback will eventually happen regardless.
+	 */
+	(void) add_work(&console_work);
 }
 
 static void scrup(struct vc_data *vc, unsigned int t, unsigned int b, int nr)
@@ -3453,7 +3457,7 @@ static void blank_screen_t(unsigned long
 		return;
 	}
 	blank_timer_expired = 1;
-	schedule_work(&console_work);
+	schedule_console_callback();
 }
 
 void poke_blanked_console(void)

