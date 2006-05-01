Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWEAV51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWEAV51 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbWEAV50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:57:26 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:20356 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932291AbWEAV5J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:57:09 -0400
Date: Mon, 1 May 2006 14:57:42 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, bunk@stusta.de, heiko.carstens@de.ibm.com
Subject: [PATCH] Make RCU API inaccessible to non-GPL Linux kernel modules
Message-ID: <20060501215742.GA2215@us.ibm.com>
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

Andrew, please apply.

							Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>

 Documentation/RCU/whatisRCU.txt            |    1 -
 Documentation/feature-removal-schedule.txt |   14 --------------
 include/linux/rcupdate.h                   |    3 +--
 kernel/rcupdate.c                          |   19 ++++++++-----------
 4 files changed, 9 insertions(+), 28 deletions(-)

diff -urpNa -X dontdiff linux-2.6.17-rc3/Documentation/RCU/whatisRCU.txt linux-2.6.17-rc3-GPLRCU/Documentation/RCU/whatisRCU.txt
--- linux-2.6.17-rc3/Documentation/RCU/whatisRCU.txt	2006-04-26 19:19:25.000000000 -0700
+++ linux-2.6.17-rc3-GPLRCU/Documentation/RCU/whatisRCU.txt	2006-05-01 10:28:18.000000000 -0700
@@ -790,7 +790,6 @@ RCU pointer update:
 
 RCU grace period:
 
-	synchronize_kernel (deprecated)
 	synchronize_net
 	synchronize_sched
 	synchronize_rcu
diff -urpNa -X dontdiff linux-2.6.17-rc3/Documentation/feature-removal-schedule.txt linux-2.6.17-rc3-GPLRCU/Documentation/feature-removal-schedule.txt
--- linux-2.6.17-rc3/Documentation/feature-removal-schedule.txt	2006-04-26 19:19:25.000000000 -0700
+++ linux-2.6.17-rc3-GPLRCU/Documentation/feature-removal-schedule.txt	2006-05-01 10:28:18.000000000 -0700
@@ -33,21 +33,6 @@ Who:	Adrian Bunk <bunk@stusta.de>
 
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
diff -urpNa -X dontdiff linux-2.6.17-rc3/include/linux/rcupdate.h linux-2.6.17-rc3-GPLRCU/include/linux/rcupdate.h
--- linux-2.6.17-rc3/include/linux/rcupdate.h	2006-04-26 19:19:25.000000000 -0700
+++ linux-2.6.17-rc3-GPLRCU/include/linux/rcupdate.h	2006-05-01 10:31:01.000000000 -0700
@@ -245,7 +245,7 @@ extern int rcu_pending(int cpu);
  * softirq handlers will have completed, since in some kernels, these
  * handlers can run in process context, and can block.
  *
- * This primitive provides the guarantees made by the (deprecated)
+ * This primitive provides the guarantees made by the (now removed)
  * synchronize_kernel() API.  In contrast, synchronize_rcu() only
  * guarantees that rcu_read_lock() sections will have completed.
  * In "classic RCU", these two guarantees happen to be one and
@@ -263,7 +263,6 @@ extern void FASTCALL(call_rcu(struct rcu
 				void (*func)(struct rcu_head *head)));
 extern void FASTCALL(call_rcu_bh(struct rcu_head *head,
 				void (*func)(struct rcu_head *head)));
-extern __deprecated_for_modules void synchronize_kernel(void);
 extern void synchronize_rcu(void);
 void synchronize_idle(void);
 extern void rcu_barrier(void);
diff -urpNa -X dontdiff linux-2.6.17-rc3/kernel/rcupdate.c linux-2.6.17-rc3-GPLRCU/kernel/rcupdate.c
--- linux-2.6.17-rc3/kernel/rcupdate.c	2006-04-26 19:19:25.000000000 -0700
+++ linux-2.6.17-rc3-GPLRCU/kernel/rcupdate.c	2006-05-01 10:33:01.000000000 -0700
@@ -479,6 +479,12 @@ static int __rcu_pending(struct rcu_ctrl
 	return 0;
 }
 
+/*
+ * Check to see if there is any immediate RCU-related work to be done
+ * by the current CPU, returning 1 if so.  This function is part of the
+ * RCU implementation; it is -not- an exported member of the RCU API.
+ */
+
 int rcu_pending(int cpu)
 {
 	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
@@ -593,14 +599,6 @@ void synchronize_rcu(void)
 	wait_for_completion(&rcu.completion);
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
@@ -608,7 +606,6 @@ module_param(qlowmark, int, 0);
 module_param(rsinterval, int, 0);
 #endif
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
-EXPORT_SYMBOL_GPL_FUTURE(call_rcu);	/* WARNING: GPL-only in April 2006. */
-EXPORT_SYMBOL_GPL_FUTURE(call_rcu_bh);	/* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL_GPL(call_rcu);
+EXPORT_SYMBOL_GPL(call_rcu_bh);
 EXPORT_SYMBOL_GPL(synchronize_rcu);
-EXPORT_SYMBOL_GPL_FUTURE(synchronize_kernel); /* WARNING: GPL-only in April 2006. */
