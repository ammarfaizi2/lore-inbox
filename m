Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUJTFVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUJTFVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 01:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266768AbUJTFRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 01:17:18 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27810
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S268342AbUJTFKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 01:10:22 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <1098229166.12223.1153.camel@thomas>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
	 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>
	 <20041019180059.GA23113@elte.hu>
	 <1098229098.26927.40.camel@cmn37.stanford.edu>
	 <1098229166.12223.1153.camel@thomas>
Content-Type: multipart/mixed; boundary="=-0s7BIGc+KbV+EBhgHKMV"
Organization: linutronix
Message-Id: <1098248541.12223.1450.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 07:02:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0s7BIGc+KbV+EBhgHKMV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-10-20 at 01:39, Thomas Gleixner wrote:
> That's in scsi_error_handler() where a mutex is initialized locked and
> then acquired again. This triggers the deadlock/correctness check.

Some more fixes

- scsi_error_handler() fix

- device subsystem device_remove locking fix

tglx



--=-0s7BIGc+KbV+EBhgHKMV
Content-Disposition: attachment; filename=driver.patch
Content-Type: text/x-patch; name=driver.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff --exclude='*~' -urN 2.6.9-rc4-mm1-RT-U7/drivers/base/bus.c 2.6.9-rc4-mm1-RT-U7-work/drivers/base/bus.c
--- 2.6.9-rc4-mm1-RT-U7/drivers/base/bus.c	2004-10-12 09:41:05.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U7-work/drivers/base/bus.c	2004-10-20 03:04:29.000000000 +0200
@@ -65,7 +65,7 @@
 static void driver_release(struct kobject * kobj)
 {
 	struct device_driver * drv = to_driver(kobj);
-	up(&drv->unload_sem);
+	complete(&drv->unload_done);
 }
 
 static struct kobj_type ktype_driver = {
diff --exclude='*~' -urN 2.6.9-rc4-mm1-RT-U7/include/linux/device.h 2.6.9-rc4-mm1-RT-U7-work/include/linux/device.h
--- 2.6.9-rc4-mm1-RT-U7/include/linux/device.h	2004-10-12 09:41:58.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U7-work/include/linux/device.h	2004-10-20 03:05:02.000000000 +0200
@@ -102,7 +102,7 @@
 	char			* name;
 	struct bus_type		* bus;
 
-	struct semaphore	unload_sem;
+	struct completion	unload_done;
 	struct kobject		kobj;
 	struct list_head	devices;
 
diff --exclude='*~' -urN 2.6.9-rc4-mm1-RT-U7/drivers/base/driver.c 2.6.9-rc4-mm1-RT-U7-work/drivers/base/driver.c
--- 2.6.9-rc4-mm1-RT-U7/drivers/base/driver.c	2004-10-12 09:41:05.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U7-work/drivers/base/driver.c	2004-10-20 03:11:20.000000000 +0200
@@ -79,14 +79,13 @@
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
 
@@ -97,18 +96,16 @@
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

--=-0s7BIGc+KbV+EBhgHKMV
Content-Disposition: attachment; filename=scsi.patch
Content-Type: text/x-patch; name=scsi.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff --exclude='*~' -urN 2.6.9-rc4-mm1-RT-U7/drivers/scsi/hosts.c 2.6.9-rc4-mm1-RT-U7-work/drivers/scsi/hosts.c
--- 2.6.9-rc4-mm1-RT-U7/drivers/scsi/hosts.c	2004-10-12 09:41:34.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U7-work/drivers/scsi/hosts.c	2004-10-20 03:32:10.000000000 +0200
@@ -149,7 +149,7 @@
 		DECLARE_COMPLETION(sem);
 		shost->eh_notify = &sem;
 		shost->eh_kill = 1;
-		up(shost->eh_wait);
+		wake_up(shost->eh_wait);
 		wait_for_completion(&sem);
 		shost->eh_notify = NULL;
 	}
diff --exclude='*~' -urN 2.6.9-rc4-mm1-RT-U7/drivers/scsi/scsi_error.c 2.6.9-rc4-mm1-RT-U7-work/drivers/scsi/scsi_error.c
--- 2.6.9-rc4-mm1-RT-U7/drivers/scsi/scsi_error.c	2004-10-19 20:29:46.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U7-work/drivers/scsi/scsi_error.c	2004-10-20 05:31:20.000000000 +0200
@@ -49,7 +49,7 @@
 void scsi_eh_wakeup(struct Scsi_Host *shost)
 {
 	if (shost->host_busy == shost->host_failed) {
-		up(shost->eh_wait);
+		wake_up(shost->eh_wait);
 		SCSI_LOG_ERROR_RECOVERY(5,
 				printk("Waking error handler thread\n"));
 	}
@@ -1599,9 +1599,8 @@
 {
 	struct Scsi_Host *shost = (struct Scsi_Host *) data;
 	int rtn;
-	DECLARE_MUTEX(sem);
+	DECLARE_WAIT_QUEUE_HEAD(eh_wait);
 
-	init_MUTEX_LOCKED(&sem);
 	/*
 	 *    Flush resources
 	 */
@@ -1610,7 +1609,7 @@
 
 	current->flags |= PF_NOFREEZE;
 
-	shost->eh_wait = &sem;
+	shost->eh_wait = &eh_wait;
 	shost->ehandler = current;
 
 	/*
@@ -1632,15 +1631,12 @@
 						  " sleeping\n",shost->host_no));
 
 		/*
-		 * Note - we always use down_interruptible with the semaphore
-		 * even if the module was loaded as part of the kernel.  The
-		 * reason is that down() will cause this thread to be counted
-		 * in the load average as a running process, and down
-		 * interruptible doesn't.  Given that we need to allow this
-		 * thread to die if the driver was loaded as a module, using
-		 * semaphores isn't unreasonable.
+		 * Wait, until somebody decides to wake us due to an error
+		 * or because we should be killed
 		 */
-		down_interruptible(&sem);
+		wait_event_interruptible(eh_wait, shost->eh_kill ||
+				(shost->host_busy == shost->host_failed)); 
+	
 		if (shost->eh_kill)
 			break;
 
diff --exclude='*~' -urN 2.6.9-rc4-mm1-RT-U7/include/scsi/scsi_host.h 2.6.9-rc4-mm1-RT-U7-work/include/scsi/scsi_host.h
--- 2.6.9-rc4-mm1-RT-U7/include/scsi/scsi_host.h	2004-10-12 09:42:00.000000000 +0200
+++ 2.6.9-rc4-mm1-RT-U7-work/include/scsi/scsi_host.h	2004-10-20 03:42:05.000000000 +0200
@@ -396,7 +396,7 @@
 
 	struct list_head	eh_cmd_q;
 	struct task_struct    * ehandler;  /* Error recovery thread. */
-	struct semaphore      * eh_wait;   /* The error recovery thread waits
+	wait_queue_head_t     * eh_wait;   /* The error recovery thread waits
 					      on this. */
 	struct completion     * eh_notify; /* wait for eh to begin or end */
 	struct semaphore      * eh_action; /* Wait for specific actions on the

--=-0s7BIGc+KbV+EBhgHKMV--

