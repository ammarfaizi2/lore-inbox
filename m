Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263004AbUKTMUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbUKTMUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 07:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUKTMQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 07:16:45 -0500
Received: from mx1.elte.hu ([157.181.1.137]:2713 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262874AbUKTMLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 07:11:17 -0500
Date: Sat, 20 Nov 2004 14:13:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
Message-ID: <20041120131350.GA8926@elte.hu>
References: <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <1100891156.6119.8.camel@twins>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <1100891156.6119.8.camel@twins>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> Hi Ingo,
> 
> in 29-4 I get a lot of these lines in my log:
> 
> drivers/usb/input/hid-core.c: input irq status -71 received
> 
> 29-0 didn't do that.

weird. I've attached the diff between -0 and -4 - nothing should affect
USB, except perhaps the manage.c bits. Could you try to revert the
smaller plaintext patch below, does that solve this problem?

	Ingo

--- linux.old/kernel/irq/manage.c	
+++ linux.new/kernel/irq/manage.c	
@@ -509,9 +509,7 @@ static int start_irq_thread(int irq, str
 	 * such a case:
 	 */
 	smp_mb();
-	
-	if (desc->status & IRQ_INPROGRESS)
-		wake_up_process(desc->thread);
+	wake_up_process(desc->thread);
 	
 	return 0;
 }

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

--- linux.old/Makefile	
+++ linux.new/Makefile	
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 10
-EXTRAVERSION =-rc2-mm2-V0.7.29-0
+EXTRAVERSION =-rc2-mm2-V0.7.29-5
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
--- linux.old/arch/i386/kernel/io_apic.c	
+++ linux.new/arch/i386/kernel/io_apic.c	
@@ -1956,7 +1956,7 @@ static void end_level_ioapic_irq(unsigne
 		unmask_IO_APIC_irq(irq);
 }
 
-#else /* !CONFIG_PREEMPT_HARDIRQS */
+#else /* !CONFIG_PREEMPT_HARDIRQS || !CONFIG_SMP */
 
 static void mask_and_ack_level_ioapic_irq(unsigned int irq)
 {
--- linux.old/drivers/base/bus.c	
+++ linux.new/drivers/base/bus.c	
@@ -65,7 +65,7 @@ static struct sysfs_ops driver_sysfs_ops
 static void driver_release(struct kobject * kobj)
 {
 	struct device_driver * drv = to_driver(kobj);
-	up(&drv->unload_sem);
+	complete(&drv->unload_done);
 }
 
 static struct kobj_type ktype_driver = {
--- linux.old/drivers/base/driver.c	
+++ linux.new/drivers/base/driver.c	
@@ -79,14 +79,13 @@ void put_driver(struct device_driver * d
  *	since most of the things we have to do deal with the bus
  *	structures.
  *
- *	The one interesting aspect is that we initialize @drv->unload_sem
- *	to a locked state here. It will be unlocked when the driver
- *	reference count reaches 0.
+ *	We init the completion strcut here. When the reference 
+ *	count reaches zero, complete() is called from bus_release().
  */
 int driver_register(struct device_driver * drv)
 {
 	INIT_LIST_HEAD(&drv->devices);
-	init_MUTEX_LOCKED(&drv->unload_sem);
+	init_completion(&drv->unload_done);
 	return bus_add_driver(drv);
 }
 
@@ -97,18 +96,16 @@ int driver_register(struct device_driver
  *
  *	Again, we pass off most of the work to the bus-level call.
  *
- *	Though, once that is done, we attempt to take @drv->unload_sem.
- *	This will block until the driver refcount reaches 0, and it is
- *	released. Only modular drivers will call this function, and we
+ *	Though, once that is done, we wait until the driver refcount 
+ *	reaches 0, and complete() is called in bus_release().
+ *	Only modular drivers will call this function, and we
  *	have to guarantee that it won't complete, letting the driver
  *	unload until all references are gone.
  */
-
 void driver_unregister(struct device_driver * drv)
 {
 	bus_remove_driver(drv);
-	down(&drv->unload_sem);
-	up(&drv->unload_sem);
+	wait_for_completion(&drv->unload_done);
 }
 
 /**
--- linux.old/drivers/media/dvb/dvb-core/dvb_frontend.c	
+++ linux.new/drivers/media/dvb/dvb-core/dvb_frontend.c	
@@ -658,7 +658,7 @@ static void dvb_frontend_stop (struct dv
 		printk("dvb_frontend_stop: thread PID %d already died\n",
 				fe->thread_pid);
 		/* make sure the mutex was not held by the thread */
-		init_MUTEX (&fe->sem);
+		sema_init_nocheck (&fe->sem, 1);
 		return;
 	}
 
@@ -1127,10 +1127,10 @@ dvb_register_frontend (int (*ioctl) (str
 
 	memset (fe, 0, sizeof (struct dvb_frontend_data));
 
-	init_MUTEX (&fe->sem);
+	sema_init_nocheck (&fe->sem, 1);
 	init_waitqueue_head (&fe->wait_queue);
 	init_waitqueue_head (&fe->events.wait_queue);
-	init_MUTEX (&fe->events.sem);
+	sema_init_nocheck (&fe->events.sem, 1);
 	fe->events.eventw = fe->events.eventr = 0;
 	fe->events.overflow = 0;
 	fe->module = module;
--- linux.old/fs/lockd/svc.c	
+++ linux.new/fs/lockd/svc.c	
@@ -49,7 +49,7 @@ static pid_t			nlmsvc_pid;
 int				nlmsvc_grace_period;
 unsigned long			nlmsvc_timeout;
 
-static DECLARE_MUTEX_NOCHECK(lockd_start);
+static DECLARE_WAIT_QUEUE_HEAD(lockd_start);
 static DECLARE_WAIT_QUEUE_HEAD(lockd_exit);
 
 /*
@@ -112,7 +112,7 @@ lockd(struct svc_rqst *rqstp)
 	 * Let our maker know we're running.
 	 */
 	nlmsvc_pid = current->pid;
-	up(&lockd_start);
+	wake_up(&lockd_start);
 
 	daemonize("lockd");
 
@@ -233,6 +233,7 @@ lockd_up(void)
 		printk(KERN_WARNING
 			"lockd_up: no pid, %d users??\n", nlmsvc_users);
 
+
 	error = -ENOMEM;
 	serv = svc_create(&nlmsvc_program, LOCKD_BUFSIZE);
 	if (!serv) {
@@ -261,8 +262,15 @@ lockd_up(void)
 			"lockd_up: create thread failed, error=%d\n", error);
 		goto destroy_and_out;
 	}
-	down(&lockd_start);
-
+	/*
+	 * Wait for the lockd process to start, but since we're holding
+	 * the lockd semaphore, we can't wait around forever ...
+	 */
+	if (wait_event_interruptible_timeout(lockd_start, 
+					     nlmsvc_pid != 0, HZ) <= 0) {
+		printk(KERN_WARNING 
+			"lockd_down: lockd failed to start\n");
+	}
 	/*
 	 * Note: svc_serv structures have an initial use count of 1,
 	 * so we exit through here on both success and failure.
@@ -302,16 +310,12 @@ lockd_down(void)
 	 * Wait for the lockd process to exit, but since we're holding
 	 * the lockd semaphore, we can't wait around forever ...
 	 */
-	clear_thread_flag(TIF_SIGPENDING);
-	interruptible_sleep_on_timeout(&lockd_exit, HZ);
-	if (nlmsvc_pid) {
+	if (wait_event_interruptible_timeout(lockd_exit, 
+					     nlmsvc_pid == 0, HZ) <= 0) {
 		printk(KERN_WARNING 
 			"lockd_down: lockd failed to exit, clearing pid\n");
 		nlmsvc_pid = 0;
 	}
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
 out:
 	up(&nlmsvc_sema);
 }
@@ -428,7 +432,6 @@ module_param_call(nlm_tcpport, param_set
 
 static int __init init_nlm(void)
 {
-	down(&lockd_start); // initialize as locked
 	nlm_sysctl_table = register_sysctl_table(nlm_sysctl_root, 0);
 	return nlm_sysctl_table ? 0 : -ENOMEM;
 }
--- linux.old/include/linux/device.h	
+++ linux.new/include/linux/device.h	
@@ -102,7 +102,7 @@ struct device_driver {
 	char			* name;
 	struct bus_type		* bus;
 
-	struct semaphore	unload_sem;
+	struct completion	unload_done;
 	struct kobject		kobj;
 	struct list_head	devices;
 
--- linux.old/include/linux/preempt.h	
+++ linux.new/include/linux/preempt.h	
@@ -66,6 +66,8 @@ do { \
 #define preempt_enable()		do { } while (0)
 #define preempt_check_resched()		do { } while (0)
 
+#define preempt_schedule_irq()		do { } while (0)
+
 #endif
 
 #endif /* __LINUX_PREEMPT_H */
--- linux.old/kernel/irq/manage.c	
+++ linux.new/kernel/irq/manage.c	
@@ -509,9 +509,7 @@ static int start_irq_thread(int irq, str
 	 * such a case:
 	 */
 	smp_mb();
-	
-	if (desc->status & IRQ_INPROGRESS)
-		wake_up_process(desc->thread);
+	wake_up_process(desc->thread);
 	
 	return 0;
 }
--- linux.old/kernel/rt.c	
+++ linux.new/kernel/rt.c	
@@ -1112,7 +1112,7 @@ static void __up_mutex(struct rt_mutex *
 	 * reschedule then do it here without enabling interrupts
 	 * again (and lengthening latency):
 	 */
-	while (need_resched() && !irqs_disabled_flags(flags) && !preempt_count())
+	if (need_resched() && !irqs_disabled_flags(flags) && !preempt_count())
 		preempt_schedule_irq();
 	local_irq_restore(flags);
 	/* no need to check for preempt here - we just handled it */
--- linux.old/kernel/sched.c	
+++ linux.new/kernel/sched.c	
@@ -1165,7 +1165,7 @@ out:
 	 * reschedule then do it here without enabling interrupts
 	 * again (and lengthening latency):
 	 */
-	while (need_resched() && !irqs_disabled_flags(flags) && !preempt_count())
+	if (need_resched() && !irqs_disabled_flags(flags) && !preempt_count())
 		preempt_schedule_irq();
 	local_irq_restore(flags);
 	/* no need to check for preempt here - we just handled it */

--lrZ03NoBR/3+SXJZ--
