Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262950AbUKRUHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbUKRUHx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbUKRUF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:05:57 -0500
Received: from mx2.elte.hu ([157.181.151.9]:32927 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261157AbUKRUDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:03:31 -0500
Date: Thu, 18 Nov 2004 22:05:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Christian Meder <chris@onestepahead.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
Message-ID: <20041118210517.GA8703@elte.hu>
References: <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <49222.195.245.190.94.1100789179.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49222.195.245.190.94.1100789179.squirrel@195.245.190.94>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

> I'm still seeing this sometimes (not everytime) on my P4/UP laptop
> while shutting down ALSA modules. This isn't the same as the lockup
> I've been reporting lately (that happens on my P4/SMT desktop) but may
> be remotely related.

could you (and Christian) try the patch below, ontop of a current-ish
tree - does the unload crash still occur? (this is an earlier cleanup
patch from Thomas Gleixner, but it could fix a real PREEMPT_RT bug in
this particular case.)

	Ingo

--- linux/drivers/base/driver.c.orig
+++ linux/drivers/base/driver.c
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
--- linux/drivers/base/bus.c.orig
+++ linux/drivers/base/bus.c
@@ -65,7 +65,7 @@ static struct sysfs_ops driver_sysfs_ops
 static void driver_release(struct kobject * kobj)
 {
 	struct device_driver * drv = to_driver(kobj);
-	up(&drv->unload_sem);
+	complete(&drv->unload_done);
 }
 
 static struct kobj_type ktype_driver = {
--- linux/include/linux/device.h.orig
+++ linux/include/linux/device.h
@@ -102,7 +102,7 @@ struct device_driver {
 	char			* name;
 	struct bus_type		* bus;
 
-	struct semaphore	unload_sem;
+	struct completion	unload_done;
 	struct kobject		kobj;
 	struct list_head	devices;
 
