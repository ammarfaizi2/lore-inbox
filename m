Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266664AbUF3MWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266664AbUF3MWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266652AbUF3MVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:21:38 -0400
Received: from aun.it.uu.se ([130.238.12.36]:65183 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266645AbUF3MUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:20:40 -0400
Date: Wed, 30 Jun 2004 14:20:33 +0200 (MEST)
Message-Id: <200406301220.i5UCKX9J014158@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-mm4] perfctr update 3/6: __user annotations
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Add __user annotations on relevant system calls and helper functions.
- Swap cpus_copy_to_user() parameter order, to match copy_to_user().

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.7-mm4/drivers/perfctr/init.c.~1~	2004-06-29 12:43:27.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/init.c	2004-06-29 19:01:56.000000000 +0200
@@ -23,7 +23,7 @@
 
 char *perfctr_cpu_name __initdata;
 
-static int cpus_copy_to_user(const cpumask_t *cpus, struct perfctr_cpu_mask *argp)
+static int cpus_copy_to_user(struct perfctr_cpu_mask __user *argp, const cpumask_t *cpus)
 {
 	const unsigned int k_nrwords = PERFCTR_CPUMASK_NRLONGS*(sizeof(long)/sizeof(int));
 	unsigned int u_nrwords;
@@ -47,21 +47,21 @@
 	return 0;
 }
 
-asmlinkage long sys_perfctr_info(struct perfctr_info *infop,
-				 struct perfctr_cpu_mask *cpusp,
-				 struct perfctr_cpu_mask *forbiddenp)
+asmlinkage long sys_perfctr_info(struct perfctr_info __user *infop,
+				 struct perfctr_cpu_mask __user *cpusp,
+				 struct perfctr_cpu_mask __user *forbiddenp)
 {
 	if (infop && copy_to_user(infop, &perfctr_info, sizeof perfctr_info))
 		return -EFAULT;
 	if (cpusp) {
 		cpumask_t cpus = cpu_online_map;
-		int err = cpus_copy_to_user(&cpus, cpusp);
+		int err = cpus_copy_to_user(cpusp, &cpus);
 		if (err)
 			return err;
 	}
 	if (forbiddenp) {
 		cpumask_t cpus = perfctr_cpus_forbidden_mask;
-		int err = cpus_copy_to_user(&cpus, forbiddenp);
+		int err = cpus_copy_to_user(forbiddenp, &cpus);
 		if (err)
 			return err;
 	}
--- linux-2.6.7-mm4/drivers/perfctr/virtual.c.~1~	2004-06-29 18:05:23.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/virtual.c	2004-06-29 19:11:30.000000000 +0200
@@ -388,7 +388,7 @@
  ****************************************************************/
 
 static int do_vperfctr_control(struct vperfctr *perfctr,
-			       const struct vperfctr_control *argp,
+			       const struct vperfctr_control __user *argp,
 			       struct task_struct *tsk)
 {
 	struct vperfctr_control control;
@@ -496,8 +496,8 @@
 }
 
 static int do_vperfctr_read(struct vperfctr *perfctr,
-			    struct perfctr_sum_ctrs *sump,
-			    struct vperfctr_control *controlp,
+			    struct perfctr_sum_ctrs __user *sump,
+			    struct vperfctr_control __user *controlp,
 			    const struct task_struct *tsk)
 {
 	struct perfctr_sum_ctrs sum;
@@ -836,7 +836,8 @@
 		put_task_struct(tsk);
 }
 
-asmlinkage long sys_vperfctr_control(int fd, const struct vperfctr_control *control)
+asmlinkage long sys_vperfctr_control(int fd,
+				     const struct vperfctr_control __user *control)
 {
 	struct vperfctr *perfctr;
 	struct task_struct *tsk;
@@ -899,7 +900,9 @@
 	return ret;
 }
 
-asmlinkage long sys_vperfctr_read(int fd, struct perfctr_sum_ctrs *sum, struct vperfctr_control *control)
+asmlinkage long sys_vperfctr_read(int fd,
+				  struct perfctr_sum_ctrs __user *sum,
+				  struct vperfctr_control __user *control)
 {
 	struct vperfctr *perfctr;
 	struct task_struct *tsk;
--- linux-2.6.7-mm4/include/linux/perfctr.h.~1~	2004-06-29 18:05:23.000000000 +0200
+++ linux-2.6.7-mm4/include/linux/perfctr.h	2004-06-29 19:09:29.000000000 +0200
@@ -66,14 +66,17 @@
 /*
  * The perfctr system calls.
  */
-asmlinkage long sys_perfctr_info(struct perfctr_info*, struct perfctr_cpu_mask*, struct perfctr_cpu_mask*);
+asmlinkage long sys_perfctr_info(struct perfctr_info __user*,
+				 struct perfctr_cpu_mask __user*,
+				 struct perfctr_cpu_mask __user*);
 asmlinkage long sys_vperfctr_open(int tid, int creat);
-asmlinkage long sys_vperfctr_control(int fd, const struct vperfctr_control*);
+asmlinkage long sys_vperfctr_control(int fd,
+				     const struct vperfctr_control __user*);
 asmlinkage long sys_vperfctr_unlink(int fd);
 asmlinkage long sys_vperfctr_iresume(int fd);
 asmlinkage long sys_vperfctr_read(int fd,
-				  struct perfctr_sum_ctrs*,
-				  struct vperfctr_control*);
+				  struct perfctr_sum_ctrs __user*,
+				  struct vperfctr_control __user*);
 
 extern struct perfctr_info perfctr_info;
 
