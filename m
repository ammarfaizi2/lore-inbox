Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUJXOa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUJXOa6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 10:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbUJXOa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 10:30:58 -0400
Received: from aun.it.uu.se ([130.238.12.36]:26569 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261498AbUJXO2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 10:28:04 -0400
Date: Sun, 24 Oct 2004 16:27:56 +0200 (MEST)
Message-Id: <200410241427.i9OERul1016009@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.9-mm1] perfctr API changes: first step
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch is the first step in the planned perfctr API changes.
It converts sys_vperfctr_read() to interpret a command token
telling it what to read, instead of it getting a bunch of pointers
to structs to update. Right now the functionality is the same;
the point of the change is to allow new functionality to be added
without breaking the API.

The "write control data" and "other state changes" APIs will also
be updated shortly.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/version.h |    2 -
 drivers/perfctr/virtual.c |   63 +++++++++++++++++++++++++---------------------
 include/linux/perfctr.h   |   12 +++++---
 3 files changed, 43 insertions(+), 34 deletions(-)

diff -rupN linux-2.6.9-mm1/drivers/perfctr/version.h linux-2.6.9-mm1.vperfctr-api-update/drivers/perfctr/version.h
--- linux-2.6.9-mm1/drivers/perfctr/version.h	2004-10-24 01:06:08.000000000 +0200
+++ linux-2.6.9-mm1.vperfctr-api-update/drivers/perfctr/version.h	2004-10-19 15:09:21.000000000 +0200
@@ -1 +1 @@
-#define VERSION "2.7.5"
+#define VERSION "2.7.6"
diff -rupN linux-2.6.9-mm1/drivers/perfctr/virtual.c linux-2.6.9-mm1.vperfctr-api-update/drivers/perfctr/virtual.c
--- linux-2.6.9-mm1/drivers/perfctr/virtual.c	2004-10-24 01:06:08.000000000 +0200
+++ linux-2.6.9-mm1.vperfctr-api-update/drivers/perfctr/virtual.c	2004-10-24 12:38:25.000000000 +0200
@@ -1,4 +1,4 @@
-/* $Id: virtual.c,v 1.104 2004/08/09 09:42:22 mikpe Exp $
+/* $Id: virtual.c,v 1.107 2004/10/23 23:28:45 mikpe Exp $
  * Virtual per-process performance counters.
  *
  * Copyright (C) 1999-2004  Mikael Pettersson
@@ -636,19 +636,20 @@ static int do_vperfctr_unlink(struct vpe
 }
 
 static int do_vperfctr_read(struct vperfctr *perfctr,
-			    struct perfctr_sum_ctrs __user *sump,
-			    struct vperfctr_control __user *controlp,
-			    struct perfctr_sum_ctrs __user *childrenp,
+			    unsigned int cmd,
+			    void __user *argp,
+			    unsigned int argbytes,
 			    struct task_struct *tsk)
 {
-	struct {
+	union {
 		struct perfctr_sum_ctrs sum;
 		struct vperfctr_control control;
 		struct perfctr_sum_ctrs children;
 	} *tmp;
+	unsigned int tmpbytes;
 	int ret;
 
-	/* The state snapshot can be large (more than 600 bytes on i386),
+	/* The state snapshot can be large (348 bytes on i386/x86_64),
 	   so kmalloc() it instead of storing it on the stack.
 	   We must use task-private storage to prevent racing with a
 	   monitor process attaching to us during the preemptible
@@ -663,40 +664,49 @@ static int do_vperfctr_read(struct vperf
 	   Disable preemption to ensure we get a consistent copy.
 	   Not needed for other cases since the perfctr is either
 	   unlinked or its owner is ptrace ATTACH suspended by us. */
-	if (tsk == current) {
+	if (tsk == current)
 		preempt_disable();
-		if (sump)
-			vperfctr_sample(perfctr);
-	}
-	if (sump) { //sum = perfctr->cpu_state.sum;
+
+	switch (cmd) {
+	case VPERFCTR_READ_SUM: {
 		int j;
+
+		vperfctr_sample(perfctr);
 		tmp->sum.tsc = perfctr->cpu_state.tsc_sum;
 		for(j = 0; j < ARRAY_SIZE(tmp->sum.pmc); ++j)
 			tmp->sum.pmc[j] = perfctr->cpu_state.pmc[j].sum;
+		tmpbytes = sizeof(tmp->sum);
+		break;
 	}
-	if (controlp) {
+	case VPERFCTR_READ_CONTROL:
 		tmp->control.si_signo = perfctr->si_signo;
 		tmp->control.cpu_control = perfctr->cpu_state.control;
 		tmp->control.preserve = 0;
-	}
-	if (childrenp) {
+		tmpbytes = sizeof(tmp->control);
+		break;
+	case VPERFCTR_READ_CHILDREN:
 		if (tsk)
 			spin_lock(&perfctr->children_lock);
 		tmp->children = perfctr->children;
 		if (tsk)
 			spin_unlock(&perfctr->children_lock);
+		tmpbytes = sizeof(tmp->children);
+		break;
+	default:
+		tmpbytes = 0;
 	}
+
 	if (tsk == current)
 		preempt_enable();
-	ret = -EFAULT;
-	if (sump && copy_to_user(sump, &tmp->sum, sizeof tmp->sum))
-		goto out;
-	if (controlp && copy_to_user(controlp, &tmp->control, sizeof tmp->control))
-		goto out;
-	if (childrenp && copy_to_user(childrenp, &tmp->children, sizeof tmp->children))
-		goto out;
-	ret = 0;
- out:
+
+	ret = -EINVAL;
+	if (tmpbytes > argbytes)
+		tmpbytes = argbytes;
+	if (tmpbytes > 0) {
+		ret = tmpbytes;
+		if (copy_to_user(argp, tmp, tmpbytes))
+			ret = -EFAULT;
+	}
 	kfree(tmp);
 	return ret;
 }
@@ -1069,10 +1079,7 @@ asmlinkage long sys_vperfctr_iresume(int
 	return ret;
 }
 
-asmlinkage long sys_vperfctr_read(int fd,
-				  struct perfctr_sum_ctrs __user *sum,
-				  struct vperfctr_control __user *control,
-				  struct perfctr_sum_ctrs __user *children)
+asmlinkage long sys_vperfctr_read(int fd, unsigned int cmd, void __user *argp, unsigned int argbytes)
 {
 	struct vperfctr *perfctr;
 	struct task_struct *tsk;
@@ -1086,7 +1093,7 @@ asmlinkage long sys_vperfctr_read(int fd
 		ret = PTR_ERR(tsk);
 		goto out;
 	}
-	ret = do_vperfctr_read(perfctr, sum, control, children, tsk);
+	ret = do_vperfctr_read(perfctr, cmd, argp, argbytes, tsk);
 	vperfctr_put_tsk(tsk);
  out:
 	put_vperfctr(perfctr);
diff -rupN linux-2.6.9-mm1/include/linux/perfctr.h linux-2.6.9-mm1.vperfctr-api-update/include/linux/perfctr.h
--- linux-2.6.9-mm1/include/linux/perfctr.h	2004-10-24 01:06:17.000000000 +0200
+++ linux-2.6.9-mm1.vperfctr-api-update/include/linux/perfctr.h	2004-10-24 13:16:18.000000000 +0200
@@ -1,4 +1,4 @@
-/* $Id: perfctr.h,v 1.78 2004/05/31 20:45:51 mikpe Exp $
+/* $Id: perfctr.h,v 1.83 2004/07/17 00:37:52 mikpe Exp $
  * Performance-Monitoring Counters driver
  *
  * Copyright (C) 1999-2004  Mikael Pettersson
@@ -54,6 +54,11 @@ struct vperfctr_control {
 	unsigned int _reserved4;
 };
 
+/* commands for sys_vperfctr_read() */
+#define VPERFCTR_READ_SUM	0x01
+#define VPERFCTR_READ_CONTROL	0x02
+#define VPERFCTR_READ_CHILDREN	0x03
+
 #else
 struct perfctr_info;
 struct perfctr_cpu_mask;
@@ -74,10 +79,7 @@ asmlinkage long sys_vperfctr_control(int
 				     const struct vperfctr_control __user*);
 asmlinkage long sys_vperfctr_unlink(int fd);
 asmlinkage long sys_vperfctr_iresume(int fd);
-asmlinkage long sys_vperfctr_read(int fd,
-				  struct perfctr_sum_ctrs __user*,
-				  struct vperfctr_control __user*,
-				  struct perfctr_sum_ctrs __user*);
+asmlinkage long sys_vperfctr_read(int fd, unsigned int cmd, void __user *argp, unsigned int argbytes);
 
 extern struct perfctr_info perfctr_info;
 
