Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbUKXKMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbUKXKMw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbUKXKKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:10:32 -0500
Received: from aun.it.uu.se ([130.238.12.36]:37609 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262592AbUKXKHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:07:05 -0500
Date: Wed, 24 Nov 2004 11:06:53 +0100 (MET)
Message-Id: <200411241006.iAOA6rF0022485@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc2-mm3][3/3] perfctr virtual update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 3/3 of perfctr control API changes:
- Changed sys_vperfctr_control() to handle variable-sized
  cpu_control data. Moved cpu_control field to end of
  struct vperfctr_control, added size parameter to
  sys_vperfctr_control(), and changed do_vperfctr_control()
  to only copy as many bytes as user-space indicates.
  Together with the array-of-struct layout for per-counter
  control fields, this:
  * maintains API compatibility even if future processors
    add more counters, and
  * allows for reduced argument copying when user-space only
    uses a small subset of the available counters.
- Bump version.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/version.h |    2 +-
 drivers/perfctr/virtual.c |   15 +++++++++++----
 include/linux/perfctr.h   |    7 ++++---
 3 files changed, 16 insertions(+), 8 deletions(-)

diff -rupN linux-2.6.10-rc2-mm3/drivers/perfctr/version.h linux-2.6.10-rc2-mm3.perfctr-virtual-update/drivers/perfctr/version.h
--- linux-2.6.10-rc2-mm3/drivers/perfctr/version.h	2004-11-24 01:52:30.000000000 +0100
+++ linux-2.6.10-rc2-mm3.perfctr-virtual-update/drivers/perfctr/version.h	2004-11-24 02:13:01.000000000 +0100
@@ -1 +1 @@
-#define VERSION "2.7.6"
+#define VERSION "2.7.8"
diff -rupN linux-2.6.10-rc2-mm3/drivers/perfctr/virtual.c linux-2.6.10-rc2-mm3.perfctr-virtual-update/drivers/perfctr/virtual.c
--- linux-2.6.10-rc2-mm3/drivers/perfctr/virtual.c	2004-11-24 01:52:30.000000000 +0100
+++ linux-2.6.10-rc2-mm3.perfctr-virtual-update/drivers/perfctr/virtual.c	2004-11-24 02:13:01.000000000 +0100
@@ -1,4 +1,4 @@
-/* $Id: virtual.c,v 1.107 2004/10/23 23:28:45 mikpe Exp $
+/* $Id: virtual.c,v 1.110 2004/11/24 00:38:30 mikpe Exp $
  * Virtual per-process performance counters.
  *
  * Copyright (C) 1999-2004  Mikael Pettersson
@@ -541,6 +541,7 @@ void __vperfctr_set_cpus_allowed(struct 
 
 static int do_vperfctr_control(struct vperfctr *perfctr,
 			       const struct vperfctr_control __user *argp,
+			       unsigned int argbytes,
 			       struct task_struct *tsk)
 {
 	struct vperfctr_control *control;
@@ -561,9 +562,14 @@ static int do_vperfctr_control(struct vp
 	if (!control)
 		return -ENOMEM;
 
+	err = -EINVAL;
+	if (argbytes > sizeof *control)
+		goto out_kfree;
 	err = -EFAULT;
-	if (copy_from_user(control, argp, sizeof *control))
+	if (copy_from_user(control, argp, argbytes))
 		goto out_kfree;
+	if (argbytes < sizeof *control)
+		memset((char*)control + argbytes, 0, sizeof *control - argbytes);
 
 	if (control->cpu_control.nractrs || control->cpu_control.nrictrs) {
 		cpumask_t old_mask, new_mask;
@@ -1046,7 +1052,8 @@ static void vperfctr_put_tsk(struct task
 }
 
 asmlinkage long sys_vperfctr_control(int fd,
-				     const struct vperfctr_control __user *control)
+				     const struct vperfctr_control __user *argp,
+				     unsigned int argbytes)
 {
 	struct vperfctr *perfctr;
 	struct task_struct *tsk;
@@ -1060,7 +1067,7 @@ asmlinkage long sys_vperfctr_control(int
 		ret = PTR_ERR(tsk);
 		goto out;
 	}
-	ret = do_vperfctr_control(perfctr, control, tsk);
+	ret = do_vperfctr_control(perfctr, argp, argbytes, tsk);
 	vperfctr_put_tsk(tsk);
  out:
 	put_vperfctr(perfctr);
diff -rupN linux-2.6.10-rc2-mm3/include/linux/perfctr.h linux-2.6.10-rc2-mm3.perfctr-virtual-update/include/linux/perfctr.h
--- linux-2.6.10-rc2-mm3/include/linux/perfctr.h	2004-11-24 01:52:32.000000000 +0100
+++ linux-2.6.10-rc2-mm3.perfctr-virtual-update/include/linux/perfctr.h	2004-11-24 02:13:01.000000000 +0100
@@ -1,4 +1,4 @@
-/* $Id: perfctr.h,v 1.83 2004/07/17 00:37:52 mikpe Exp $
+/* $Id: perfctr.h,v 1.85 2004/11/24 00:38:21 mikpe Exp $
  * Performance-Monitoring Counters driver
  *
  * Copyright (C) 1999-2004  Mikael Pettersson
@@ -46,12 +46,12 @@ struct vperfctr_state {
 /* virtual perfctr control object */
 struct vperfctr_control {
 	int si_signo;
-	struct perfctr_cpu_control cpu_control;
 	unsigned int preserve;
 	unsigned int _reserved1;
 	unsigned int _reserved2;
 	unsigned int _reserved3;
 	unsigned int _reserved4;
+	struct perfctr_cpu_control cpu_control;
 };
 
 /* commands for sys_vperfctr_read() */
@@ -76,7 +76,8 @@ asmlinkage long sys_perfctr_info(struct 
 				 struct perfctr_cpu_mask __user*);
 asmlinkage long sys_vperfctr_open(int tid, int creat);
 asmlinkage long sys_vperfctr_control(int fd,
-				     const struct vperfctr_control __user*);
+				     const struct vperfctr_control __user *argp,
+				     unsigned int argbytes);
 asmlinkage long sys_vperfctr_unlink(int fd);
 asmlinkage long sys_vperfctr_iresume(int fd);
 asmlinkage long sys_vperfctr_read(int fd, unsigned int cmd, void __user *argp, unsigned int argbytes);
