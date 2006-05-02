Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWEBSYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWEBSYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWEBSYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:24:15 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:7316 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964957AbWEBSYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:24:14 -0400
Date: Tue, 2 May 2006 11:24:42 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, dipankar@in.ibm.com
Subject: [PATCH -rt] Make RCU API inaccessible to non-GPL Linux kernel modules
Message-ID: <20060502182442.GA2134@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch removes synchronize_kernel() (deprecated 2-APR-2005 in
http://lkml.org/lkml/2005/4/3/11) and makes the RCU API inaccessible
to non-GPL Linux kernel modules (as was announced more than one year
ago in http://lkml.org/lkml/2005/4/3/8).  Tested on x86 and ppc64.

Same as the one sent yesterday, but for -rt rather than mainline.

Ingo, please apply.

						Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>
---

 Documentation/RCU/whatisRCU.txt            |    1 -
 Documentation/feature-removal-schedule.txt |   14 --------------
 include/linux/rcupdate.h                   |    3 +--
 kernel/rcupdate.c                          |   13 ++-----------
 kernel/rcupreempt.c                        |   15 +++------------
 5 files changed, 6 insertions(+), 40 deletions(-)

diff -urpNa -X dontdiff linux-2.6.16-rt18/Documentation/RCU/whatisRCU.txt linux-2.6.16-rt18-GPLRCU/Documentation/RCU/whatisRCU.txt
--- linux-2.6.16-rt18/Documentation/RCU/whatisRCU.txt	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16-rt18-GPLRCU/Documentation/RCU/whatisRCU.txt	2006-05-02 08:42:23.000000000 -0700
@@ -790,7 +790,6 @@ RCU pointer update:
 
 RCU grace period:
 
-	synchronize_kernel (deprecated)
 	synchronize_net
 	synchronize_sched
 	synchronize_rcu
diff -urpNa -X dontdiff linux-2.6.16-rt18/Documentation/feature-removal-schedule.txt linux-2.6.16-rt18-GPLRCU/Documentation/feature-removal-schedule.txt
--- linux-2.6.16-rt18/Documentation/feature-removal-schedule.txt	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.16-rt18-GPLRCU/Documentation/feature-removal-schedule.txt	2006-05-02 08:43:24.000000000 -0700
@@ -32,21 +32,6 @@ Who:	Adrian Bunk <bunk@stusta.de>
 
 ---------------------------
 
-What:	RCU API moves to EXPORT_SYMBOL_GPL
-When:	April 2006
-Files:	include/linux/rcupdate.h, kernel/rcupdate.c
-Why:	Outside of Linux, the only implementations of anything even
-	vaguely resembling RCU that I am aware of are in DYNIX/ptx,
-	VM/XA, Tornado, and K42.  I do not expect anyone to port binary
-	drivers or kernel modules from any of these, since the first two
-	are owned by IBM and the last two are open-source research OSes.
-	So these will move to GPL after a grace period to allow
-	people, who might be using implementations that I am not aware
-	of, to adjust to this upcoming change.
-Who:	Paul E. McKenney <paulmck@us.ibm.com>
-
----------------------------
-
 What:	raw1394: requests of type RAW1394_REQ_ISO_SEND, RAW1394_REQ_ISO_LISTEN
 When:	November 2005
 Why:	Deprecated in favour of the new ioctl-based rawiso interface, which is
diff -urpNa -X dontdiff linux-2.6.16-rt18/include/linux/rcupdate.h linux-2.6.16-rt18-GPLRCU/include/linux/rcupdate.h
--- linux-2.6.16-rt18/include/linux/rcupdate.h	2006-05-02 08:25:48.000000000 -0700
+++ linux-2.6.16-rt18-GPLRCU/include/linux/rcupdate.h	2006-05-02 08:29:55.000000000 -0700
@@ -268,7 +268,7 @@ extern int rcu_pending(int cpu);
  * softirq handlers will have completed, since in some kernels, these
  * handlers can run in process context, and can block.
  *
- * This primitive provides the guarantees made by the (deprecated)
+ * This primitive provides the guarantees made by the (now removed)
  * synchronize_kernel() API.  In contrast, synchronize_rcu() only
  * guarantees that rcu_read_lock() sections will have completed.
  * In "classic RCU", these two guarantees happen to be one and
@@ -292,7 +292,6 @@ extern void FASTCALL(call_rcu(struct rcu
 				void (*func)(struct rcu_head *head)));
 extern void FASTCALL(call_rcu_bh(struct rcu_head *head,
 				void (*func)(struct rcu_head *head)));
-extern __deprecated_for_modules void synchronize_kernel(void);
 extern void synchronize_rcu(void);
 void synchronize_idle(void);
 
diff -urpNa -X dontdiff linux-2.6.16-rt18/kernel/rcupdate.c linux-2.6.16-rt18-GPLRCU/kernel/rcupdate.c
--- linux-2.6.16-rt18/kernel/rcupdate.c	2006-05-02 08:25:48.000000000 -0700
+++ linux-2.6.16-rt18-GPLRCU/kernel/rcupdate.c	2006-05-02 08:34:28.000000000 -0700
@@ -560,21 +560,12 @@ void __init rcu_init(void)
 	register_cpu_notifier(&rcu_nb);
 }
 
-/*
- * Deprecated, use synchronize_rcu() or synchronize_sched() instead.
- */
-void synchronize_kernel(void)
-{
-	synchronize_rcu();
-}
-
 module_param(blimit, int, 0);
 module_param(qhimark, int, 0);
 module_param(qlowmark, int, 0);
 #ifdef CONFIG_SMP
 module_param(rsinterval, int, 0);
 #endif
-EXPORT_SYMBOL(call_rcu);  /* WARNING: GPL-only in April 2006. */
-EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL(call_rcu);
+EXPORT_SYMBOL_GPL(call_rcu_bh);
 EXPORT_SYMBOL_GPL(synchronize_rcu);
-EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: GPL-only in April 2006. */
diff -urpNa -X dontdiff linux-2.6.16-rt18/kernel/rcupreempt.c linux-2.6.16-rt18-GPLRCU/kernel/rcupreempt.c
--- linux-2.6.16-rt18/kernel/rcupreempt.c	2006-05-02 08:25:48.000000000 -0700
+++ linux-2.6.16-rt18-GPLRCU/kernel/rcupreempt.c	2006-05-02 08:37:55.000000000 -0700
@@ -388,14 +388,6 @@ void __init rcu_init(void)
 	tasklet_init(&rcu_data.rcu_tasklet, rcu_process_callbacks, 0UL);
 }
 
-/*
- * Deprecated, use synchronize_rcu() or synchronize_sched() instead.
- */
-void synchronize_kernel(void)
-{
-	synchronize_rcu();
-}
-
 #ifdef CONFIG_RCU_STATS
 int rcu_read_proc_data(char *page)
 {
@@ -463,10 +455,9 @@ int rcu_read_proc_ctrs_data(char *page)
 
 #endif /* #ifdef CONFIG_RCU_STATS */
 
-EXPORT_SYMBOL(call_rcu); /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL(call_rcu);
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 EXPORT_SYMBOL_GPL(synchronize_sched);
-EXPORT_SYMBOL(rcu_read_lock);  /* WARNING: GPL-only in April 2006. */
-EXPORT_SYMBOL(rcu_read_unlock);  /* WARNING: GPL-only in April 2006. */
-EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: Removal in April 2006. */
+EXPORT_SYMBOL_GPL(rcu_read_lock);
+EXPORT_SYMBOL_GPL(rcu_read_unlock);
