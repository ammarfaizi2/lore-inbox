Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVDCGbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVDCGbp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 01:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVDCGbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 01:31:45 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63911 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261527AbVDCGb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 01:31:28 -0500
Date: Sat, 2 Apr 2005 22:31:22 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: dipankar@in.ibm.com, antonb@au1.ibm.com, davej@codemonkey.org.uk,
       hpa@zytor.com, len.brown@intel.com, andmike@us.ibm.com, rth@twiddle.net,
       rusty@au1.ibm.com, schwidefsky@de.ibm.com, manfred@colorfullife.com
Subject: [RFC,PATCH 3/4] Change synchronize_kernel to _rcu and _sched
Message-ID: <20050403063122.GA1692@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes calls to synchronize_kernel(), deprecated in the
earlier "Deprecate synchronize_kernel, GPL replacement" patch to
instead call the new synchronize_rcu() and synchronize_sched() APIs.

Signed-off-by: <paulmck@us.ibm.com>
---

 arch/i386/oprofile/nmi_timer_int.c |    2 +-
 arch/ppc64/kernel/HvLpEvent.c      |    2 +-
 arch/x86_64/kernel/mce.c           |    2 +-
 drivers/acpi/processor_idle.c      |    2 +-
 drivers/char/ipmi/ipmi_si_intf.c   |    4 ++--
 drivers/input/keyboard/atkbd.c     |    2 +-
 drivers/md/multipath.c             |    2 +-
 drivers/md/raid1.c                 |    2 +-
 drivers/md/raid10.c                |    2 +-
 drivers/md/raid5.c                 |    2 +-
 drivers/md/raid6main.c             |    2 +-
 drivers/net/r8169.c                |    2 +-
 drivers/s390/cio/airq.c            |    4 ++--
 kernel/module.c                    |    2 +-
 kernel/profile.c                   |    2 +-
 mm/slab.c                          |    2 +-
 net/core/dev.c                     |    2 +-
 17 files changed, 19 insertions(+), 19 deletions(-)

diff -urpN -X dontdiff linux-2.6.12-rc1/arch/i386/oprofile/nmi_timer_int.c linux-2.6.12-rc1-bettersk/arch/i386/oprofile/nmi_timer_int.c
--- linux-2.6.12-rc1/arch/i386/oprofile/nmi_timer_int.c	Tue Mar  1 23:37:52 2005
+++ linux-2.6.12-rc1-bettersk/arch/i386/oprofile/nmi_timer_int.c	Fri Apr  1 21:03:57 2005
@@ -36,7 +36,7 @@ static void timer_stop(void)
 {
 	enable_timer_nmi_watchdog();
 	unset_nmi_callback();
-	synchronize_kernel();
+	synchronize_sched();  /* Allow already-started NMIs to complete. */
 }
 
 
diff -urpN -X dontdiff linux-2.6.12-rc1/arch/ppc64/kernel/HvLpEvent.c linux-2.6.12-rc1-bettersk/arch/ppc64/kernel/HvLpEvent.c
--- linux-2.6.12-rc1/arch/ppc64/kernel/HvLpEvent.c	Tue Mar  1 23:38:09 2005
+++ linux-2.6.12-rc1-bettersk/arch/ppc64/kernel/HvLpEvent.c	Fri Apr  1 20:54:40 2005
@@ -45,7 +45,7 @@ int HvLpEvent_unregisterHandler( HvLpEve
 			/* We now sleep until all other CPUs have scheduled. This ensures that
 			 * the deletion is seen by all other CPUs, and that the deleted handler
 			 * isn't still running on another CPU when we return. */
-			synchronize_kernel();
+			synchronize_rcu();
 		}
 	}
 	return rc;
diff -urpN -X dontdiff linux-2.6.12-rc1/arch/x86_64/kernel/mce.c linux-2.6.12-rc1-bettersk/arch/x86_64/kernel/mce.c
--- linux-2.6.12-rc1/arch/x86_64/kernel/mce.c	Tue Mar  1 23:37:52 2005
+++ linux-2.6.12-rc1-bettersk/arch/x86_64/kernel/mce.c	Fri Apr  1 21:03:01 2005
@@ -392,7 +392,7 @@ static ssize_t mce_read(struct file *fil
 	memset(mcelog.entry, 0, next * sizeof(struct mce));
 	mcelog.next = 0;
 
-	synchronize_kernel();	
+	synchronize_sched();  /* Allow all already-started MCEs to complete. */
 
 	/* Collect entries that were still getting written before the synchronize. */
 
diff -urpN -X dontdiff linux-2.6.12-rc1/drivers/acpi/processor_idle.c linux-2.6.12-rc1-bettersk/drivers/acpi/processor_idle.c
--- linux-2.6.12-rc1/drivers/acpi/processor_idle.c	Tue Mar  1 23:38:25 2005
+++ linux-2.6.12-rc1-bettersk/drivers/acpi/processor_idle.c	Sat Apr  2 10:57:37 2005
@@ -838,7 +838,7 @@ int acpi_processor_cst_has_changed (stru
 
 	/* Fall back to the default idle loop */
 	pm_idle = pm_idle_save;
-	synchronize_kernel();
+	synchronize_sched();  /* Relies on interrupts forcing exit from idle. */
 
 	pr->flags.power = 0;
 	result = acpi_processor_get_power_info(pr);
diff -urpN -X dontdiff linux-2.6.12-rc1/drivers/char/ipmi/ipmi_si_intf.c linux-2.6.12-rc1-bettersk/drivers/char/ipmi/ipmi_si_intf.c
--- linux-2.6.12-rc1/drivers/char/ipmi/ipmi_si_intf.c	Thu Mar 31 09:53:02 2005
+++ linux-2.6.12-rc1-bettersk/drivers/char/ipmi/ipmi_si_intf.c	Fri Apr  1 20:44:59 2005
@@ -2194,7 +2194,7 @@ static int init_one_smi(int intf_num, st
 	/* Wait until we know that we are out of any interrupt
 	   handlers might have been running before we freed the
 	   interrupt. */
-	synchronize_kernel();
+	synchronize_sched();
 
 	if (new_smi->si_sm) {
 		if (new_smi->handlers)
@@ -2307,7 +2307,7 @@ static void __exit cleanup_one_si(struct
 	/* Wait until we know that we are out of any interrupt
 	   handlers might have been running before we freed the
 	   interrupt. */
-	synchronize_kernel();
+	synchronize_sched();
 
 	/* Wait for the timer to stop.  This avoids problems with race
 	   conditions removing the timer here. */
diff -urpN -X dontdiff linux-2.6.12-rc1/drivers/input/keyboard/atkbd.c linux-2.6.12-rc1-bettersk/drivers/input/keyboard/atkbd.c
--- linux-2.6.12-rc1/drivers/input/keyboard/atkbd.c	Thu Mar 31 09:53:04 2005
+++ linux-2.6.12-rc1-bettersk/drivers/input/keyboard/atkbd.c	Fri Apr  1 21:18:07 2005
@@ -678,7 +678,7 @@ static void atkbd_disconnect(struct seri
 	atkbd_disable(atkbd);
 
 	/* make sure we don't have a command in flight */
-	synchronize_kernel();
+	synchronize_sched();  /* Allow atkbd_interrupt()s to complete. */
 	flush_scheduled_work();
 
 	device_remove_file(&serio->dev, &atkbd_attr_extra);
diff -urpN -X dontdiff linux-2.6.12-rc1/drivers/md/multipath.c linux-2.6.12-rc1-bettersk/drivers/md/multipath.c
--- linux-2.6.12-rc1/drivers/md/multipath.c	Tue Mar  1 23:38:08 2005
+++ linux-2.6.12-rc1-bettersk/drivers/md/multipath.c	Fri Apr  1 21:20:08 2005
@@ -355,7 +355,7 @@ static int multipath_remove_disk(mddev_t
 			goto abort;
 		}
 		p->rdev = NULL;
-		synchronize_kernel();
+		synchronize_rcu();
 		if (atomic_read(&rdev->nr_pending)) {
 			/* lost the race, try later */
 			err = -EBUSY;
diff -urpN -X dontdiff linux-2.6.12-rc1/drivers/md/raid1.c linux-2.6.12-rc1-bettersk/drivers/md/raid1.c
--- linux-2.6.12-rc1/drivers/md/raid1.c	Thu Mar 31 09:53:05 2005
+++ linux-2.6.12-rc1-bettersk/drivers/md/raid1.c	Fri Apr  1 21:20:50 2005
@@ -797,7 +797,7 @@ static int raid1_remove_disk(mddev_t *md
 			goto abort;
 		}
 		p->rdev = NULL;
-		synchronize_kernel();
+		synchronize_rcu();
 		if (atomic_read(&rdev->nr_pending)) {
 			/* lost the race, try later */
 			err = -EBUSY;
diff -urpN -X dontdiff linux-2.6.12-rc1/drivers/md/raid10.c linux-2.6.12-rc1-bettersk/drivers/md/raid10.c
--- linux-2.6.12-rc1/drivers/md/raid10.c	Tue Mar  1 23:38:38 2005
+++ linux-2.6.12-rc1-bettersk/drivers/md/raid10.c	Fri Apr  1 21:21:24 2005
@@ -977,7 +977,7 @@ static int raid10_remove_disk(mddev_t *m
 			goto abort;
 		}
 		p->rdev = NULL;
-		synchronize_kernel();
+		synchronize_rcu();
 		if (atomic_read(&rdev->nr_pending)) {
 			/* lost the race, try later */
 			err = -EBUSY;
diff -urpN -X dontdiff linux-2.6.12-rc1/drivers/md/raid5.c linux-2.6.12-rc1-bettersk/drivers/md/raid5.c
--- linux-2.6.12-rc1/drivers/md/raid5.c	Thu Mar 31 09:53:05 2005
+++ linux-2.6.12-rc1-bettersk/drivers/md/raid5.c	Fri Apr  1 21:28:06 2005
@@ -1873,7 +1873,7 @@ static int raid5_remove_disk(mddev_t *md
 			goto abort;
 		}
 		p->rdev = NULL;
-		synchronize_kernel();
+		synchronize_rcu();
 		if (atomic_read(&rdev->nr_pending)) {
 			/* lost the race, try later */
 			err = -EBUSY;
diff -urpN -X dontdiff linux-2.6.12-rc1/drivers/md/raid6main.c linux-2.6.12-rc1-bettersk/drivers/md/raid6main.c
--- linux-2.6.12-rc1/drivers/md/raid6main.c	Thu Mar 31 09:53:05 2005
+++ linux-2.6.12-rc1-bettersk/drivers/md/raid6main.c	Fri Apr  1 21:29:19 2005
@@ -2038,7 +2038,7 @@ static int raid6_remove_disk(mddev_t *md
 			goto abort;
 		}
 		p->rdev = NULL;
-		synchronize_kernel();
+		synchronize_rcu();
 		if (atomic_read(&rdev->nr_pending)) {
 			/* lost the race, try later */
 			err = -EBUSY;
diff -urpN -X dontdiff linux-2.6.12-rc1/drivers/net/r8169.c linux-2.6.12-rc1-bettersk/drivers/net/r8169.c
--- linux-2.6.12-rc1/drivers/net/r8169.c	Thu Mar 31 09:53:08 2005
+++ linux-2.6.12-rc1-bettersk/drivers/net/r8169.c	Fri Apr  1 21:41:38 2005
@@ -2385,7 +2385,7 @@ core_down:
 	}
 
 	/* Give a racing hard_start_xmit a few cycles to complete. */
-	synchronize_kernel();
+	synchronize_sched();  /* FIXME: should this be synchronize_irq()? */
 
 	/*
 	 * And now for the 50k$ question: are IRQ disabled or not ?
diff -urpN -X dontdiff linux-2.6.12-rc1/drivers/s390/cio/airq.c linux-2.6.12-rc1-bettersk/drivers/s390/cio/airq.c
--- linux-2.6.12-rc1/drivers/s390/cio/airq.c	Tue Mar  1 23:38:17 2005
+++ linux-2.6.12-rc1-bettersk/drivers/s390/cio/airq.c	Fri Apr  1 21:44:18 2005
@@ -45,7 +45,7 @@ s390_register_adapter_interrupt (adapter
 	else
 		ret = (cmpxchg(&adapter_handler, NULL, handler) ? -EBUSY : 0);
 	if (!ret)
-		synchronize_kernel();
+		synchronize_sched();  /* Allow interrupts to complete. */
 
 	sprintf (dbf_txt, "ret:%d", ret);
 	CIO_TRACE_EVENT (4, dbf_txt);
@@ -65,7 +65,7 @@ s390_unregister_adapter_interrupt (adapt
 		ret = -EINVAL;
 	else {
 		adapter_handler = NULL;
-		synchronize_kernel();
+		synchronize_sched();  /* Allow interrupts to complete. */
 		ret = 0;
 	}
 	sprintf (dbf_txt, "ret:%d", ret);
diff -urpN -X dontdiff linux-2.6.12-rc1/kernel/module.c linux-2.6.12-rc1-bettersk/kernel/module.c
--- linux-2.6.12-rc1/kernel/module.c	Thu Mar 31 09:53:21 2005
+++ linux-2.6.12-rc1-bettersk/kernel/module.c	Sat Apr  2 10:58:02 2005
@@ -1801,7 +1801,7 @@ sys_init_module(void __user *umod,
 		/* Init routine failed: abort.  Try to protect us from
                    buggy refcounters. */
 		mod->state = MODULE_STATE_GOING;
-		synchronize_kernel();
+		synchronize_sched();
 		if (mod->unsafe)
 			printk(KERN_ERR "%s: module is now stuck!\n",
 			       mod->name);
diff -urpN -X dontdiff linux-2.6.12-rc1/kernel/profile.c linux-2.6.12-rc1-bettersk/kernel/profile.c
--- linux-2.6.12-rc1/kernel/profile.c	Tue Mar  1 23:38:26 2005
+++ linux-2.6.12-rc1-bettersk/kernel/profile.c	Fri Apr  1 21:46:10 2005
@@ -184,7 +184,7 @@ void unregister_timer_hook(int (*hook)(s
 	WARN_ON(hook != timer_hook);
 	timer_hook = NULL;
 	/* make sure all CPUs see the NULL hook */
-	synchronize_kernel();
+	synchronize_sched();  /* Allow ongoing interrupts to complete. */
 }
 
 EXPORT_SYMBOL_GPL(register_timer_hook);
diff -urpN -X dontdiff linux-2.6.12-rc1/mm/slab.c linux-2.6.12-rc1-bettersk/mm/slab.c
--- linux-2.6.12-rc1/mm/slab.c	Thu Mar 31 09:53:22 2005
+++ linux-2.6.12-rc1-bettersk/mm/slab.c	Fri Apr  1 21:50:57 2005
@@ -1656,7 +1656,7 @@ int kmem_cache_destroy (kmem_cache_t * c
 	}
 
 	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU))
-		synchronize_kernel();
+		synchronize_rcu();
 
 	/* no cpu_online check required here since we clear the percpu
 	 * array on cpu offline and set this to NULL.
diff -urpN -X dontdiff linux-2.6.12-rc1/net/core/dev.c linux-2.6.12-rc1-bettersk/net/core/dev.c
--- linux-2.6.12-rc1/net/core/dev.c	Thu Mar 31 09:53:22 2005
+++ linux-2.6.12-rc1-bettersk/net/core/dev.c	Fri Apr  1 22:25:26 2005
@@ -3077,7 +3077,7 @@ void free_netdev(struct net_device *dev)
 void synchronize_net(void) 
 {
 	might_sleep();
-	synchronize_kernel();
+	synchronize_rcu();
 }
 
 /**
