Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266657AbUF3M02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUF3M02 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266654AbUF3MY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:24:58 -0400
Received: from aun.it.uu.se ([130.238.12.36]:33953 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266657AbUF3MWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:22:47 -0400
Date: Wed, 30 Jun 2004 14:22:36 +0200 (MEST)
Message-Id: <200406301222.i5UCMaHL014303@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-mm4] perfctr update 6/6: misc minor cleanups
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- perfctr_{init,exit}() don't need to be global: mark them static
- add comment to vperfctr_alloc() as to why an entire page is
  claimed and reserved (mmap())
- add printk_ratelimit() to __vperfctr_set_cpus_allowed()
- add task_lock() new usage comment to <linux/sched.h>

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.7-mm4/drivers/perfctr/init.c.~1~	2004-06-30 01:14:20.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/init.c	2004-06-30 12:14:53.000000000 +0200
@@ -66,7 +66,7 @@
 	return 0;
 }
 
-int __init perfctr_init(void)
+static int __init perfctr_init(void)
 {
 	int err;
 
@@ -85,7 +85,7 @@
 	return 0;
 }
 
-void __exit perfctr_exit(void)
+static void __exit perfctr_exit(void)
 {
 	vperfctr_exit();
 	perfctr_cpu_exit();
--- linux-2.6.7-mm4/drivers/perfctr/virtual.c.~1~	2004-06-30 02:29:12.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/virtual.c	2004-06-30 12:22:25.000000000 +0200
@@ -145,6 +145,8 @@
 	spin_unlock(&nrctrs_lock);
 }
 
+/* Allocate a `struct vperfctr'. Claim and reserve
+   an entire page so that it can be mmap():ed. */
 static struct vperfctr *vperfctr_alloc(void)
 {
 	unsigned long page;
@@ -366,9 +368,10 @@
 {
 	if (cpus_intersects(new_mask, perfctr_cpus_forbidden_mask)) {
 		atomic_set(&perfctr->bad_cpus_allowed, 1);
-		printk(KERN_WARNING "perfctr: process %d (comm %s) issued unsafe"
-		       " set_cpus_allowed() on process %d (comm %s)\n",
-		       current->pid, current->comm, owner->pid, owner->comm);
+		if (printk_ratelimit())
+			printk(KERN_WARNING "perfctr: process %d (comm %s) issued unsafe"
+			       " set_cpus_allowed() on process %d (comm %s)\n",
+			       current->pid, current->comm, owner->pid, owner->comm);
 	} else
 		atomic_set(&perfctr->bad_cpus_allowed, 0);
 }
--- linux-2.6.7-mm4/include/linux/sched.h.~1~	2004-06-29 12:43:28.000000000 +0200
+++ linux-2.6.7-mm4/include/linux/sched.h	2004-06-30 12:32:59.000000000 +0200
@@ -946,6 +946,9 @@
  * Protects ->fs, ->files, ->mm, ->ptrace, ->group_info and synchronises with
  * wait4().
  *
+ * Synchronises set_cpus_allowed(), unlink, and creat of ->thread.perfctr.
+ * [if CONFIG_PERFCTR_VIRTUAL]
+ *
  * Nests both inside and outside of read_lock(&tasklist_lock).
  * It must not be nested with write_lock_irq(&tasklist_lock),
  * neither inside nor outside.
