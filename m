Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVCLXf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVCLXf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVCLXdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:33:21 -0500
Received: from aun.it.uu.se ([130.238.12.36]:43210 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262462AbVCLXZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:25:09 -0500
Date: Sun, 13 Mar 2005 00:24:58 +0100 (MET)
Message-Id: <200503122324.j2CNOw8a029056@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm3] perfctr API update 9/9: domain-based read/write syscalls
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Convert sys_vperfctr_write() to accept <domain,data,datalen> triples.
  Have it interpret codes for the common domains, and pass unknown
  domains to perfctr_cpu_control_write().
- In sys_vperfctr_read(), replace "cmd" by "domain" and complete conversion
  to fine-grained domains for control data.
- Remove _reserved and cpu_control fields from struct vperfctr_control.

This depends on the cpu_control header and the cpu_control access patches.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

/Mikael

 drivers/perfctr/virtual.c |  144 ++++++++++++++++++++++++++++------------------
 include/linux/perfctr.h   |   25 +++----
 2 files changed, 100 insertions(+), 69 deletions(-)

diff -rupN linux-2.6.11-mm3.perfctr-cpu_control-access/drivers/perfctr/virtual.c linux-2.6.11-mm3.perfctr-read-write-domains/drivers/perfctr/virtual.c
--- linux-2.6.11-mm3.perfctr-cpu_control-access/drivers/perfctr/virtual.c	2005-03-12 20:01:35.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-read-write-domains/drivers/perfctr/virtual.c	2005-03-12 20:03:52.000000000 +0100
@@ -537,34 +537,25 @@ void __vperfctr_set_cpus_allowed(struct 
  ****************************************************************/
 
 static int do_vperfctr_write(struct vperfctr *perfctr,
-			     const struct vperfctr_control __user *argp,
-			     unsigned int argbytes,
+			     unsigned int domain,
+			     const void __user *srcp,
+			     unsigned int srcbytes,
 			     struct task_struct *tsk)
 {
-	struct vperfctr_control *control;
+	void *tmp;
 	int err;
 
 	if (!tsk)
 		return -ESRCH;	/* attempt to update unlinked perfctr */
 
-	/* The control object can be large (over 300 bytes on i386),
-	   so kmalloc() it instead of storing it on the stack.
-	   We must use task-private storage to prevent racing with a
-	   monitor process attaching to us before the non-preemptible
-	   perfctr update step. Therefore we cannot store the copy
-	   in the perfctr object itself. */
-	control = kmalloc(sizeof(*control), GFP_USER);
-	if (!control)
+	if (srcbytes > PAGE_SIZE) /* primitive sanity check */
+		return -EINVAL;
+	tmp = kmalloc(srcbytes, GFP_USER);
+	if (!tmp)
 		return -ENOMEM;
-
-	err = -EINVAL;
-	if (argbytes > sizeof *control)
-		goto out_kfree;
 	err = -EFAULT;
-	if (copy_from_user(control, argp, argbytes))
+	if (copy_from_user(tmp, srcp, srcbytes))
 		goto out_kfree;
-	if (argbytes < sizeof *control)
-		memset((char*)control + argbytes, 0, sizeof *control - argbytes);
 
 	/* PREEMPT note: preemption is disabled over the entire
 	   region since we're updating an active perfctr. */
@@ -575,16 +566,45 @@ static int do_vperfctr_write(struct vper
 		perfctr->cpu_state.cstatus = 0;
 		perfctr->resume_cstatus = 0;
 	}
-	perfctr->cpu_state.control = control->cpu_control;
-	/* XXX: validate si_signo? */
-	perfctr->si_signo = control->si_signo;
-	perfctr->preserve = control->preserve;
 
-	preempt_enable();
-	err = 0;
+	switch (domain) {
+	case VPERFCTR_DOMAIN_CONTROL: {
+		struct vperfctr_control control;
 
+		err = -EINVAL;
+		if (srcbytes > sizeof(control))
+			break;
+		control.si_signo = perfctr->si_signo;
+		control.preserve = perfctr->preserve;
+		memcpy(&control, tmp, srcbytes);
+		/* XXX: validate si_signo? */
+		perfctr->si_signo = control.si_signo;
+		perfctr->preserve = control.preserve;
+		err = 0;
+		break;
+	}
+	case PERFCTR_DOMAIN_CPU_CONTROL:
+		err = -EINVAL;
+		if (srcbytes > sizeof(perfctr->cpu_state.control.header))
+			break;
+		memcpy(&perfctr->cpu_state.control.header, tmp, srcbytes);
+		err = 0;
+		break;
+	case PERFCTR_DOMAIN_CPU_MAP:
+		err = -EINVAL;
+		if (srcbytes > sizeof(perfctr->cpu_state.control.pmc_map))
+			break;
+		memcpy(perfctr->cpu_state.control.pmc_map, tmp, srcbytes);
+		err = 0;
+		break;
+	default:
+		err = perfctr_cpu_control_write(&perfctr->cpu_state.control,
+						domain, tmp, srcbytes);
+	}
+
+	preempt_enable();
  out_kfree:
-	kfree(control);
+	kfree(tmp);
 	return err;
 }
 
@@ -751,9 +771,9 @@ static int do_vperfctr_control(struct vp
 }
 
 static int do_vperfctr_read(struct vperfctr *perfctr,
-			    unsigned int cmd,
-			    void __user *argp,
-			    unsigned int argbytes,
+			    unsigned int domain,
+			    void __user *dstp,
+			    unsigned int dstbytes,
 			    struct task_struct *tsk)
 {
 	union {
@@ -764,13 +784,12 @@ static int do_vperfctr_read(struct vperf
 	unsigned int tmpbytes;
 	int ret;
 
-	/* The state snapshot can be large (348 bytes on i386/x86_64),
-	   so kmalloc() it instead of storing it on the stack.
-	   We must use task-private storage to prevent racing with a
-	   monitor process attaching to us during the preemptible
-	   copy_to_user() step. Therefore we cannot store the snapshot
-	   in the perfctr object itself. */
-	tmp = kmalloc(sizeof(*tmp), GFP_USER);
+	tmpbytes = dstbytes;
+	if (tmpbytes > PAGE_SIZE) /* primitive sanity check */
+		return -EINVAL;
+	if (tmpbytes < sizeof(*tmp))
+		tmpbytes = sizeof(*tmp);
+	tmp = kmalloc(tmpbytes, GFP_USER);
 	if (!tmp)
 		return -ENOMEM;
 
@@ -782,44 +801,56 @@ static int do_vperfctr_read(struct vperf
 	if (tsk == current)
 		preempt_disable();
 
-	switch (cmd) {
-	case VPERFCTR_READ_SUM: {
+	switch (domain) {
+	case VPERFCTR_DOMAIN_SUM: {
 		int j;
 
 		vperfctr_sample(perfctr);
 		tmp->sum.tsc = perfctr->cpu_state.tsc_sum;
 		for(j = 0; j < ARRAY_SIZE(tmp->sum.pmc); ++j)
 			tmp->sum.pmc[j] = perfctr->cpu_state.pmc[j].sum;
-		tmpbytes = sizeof(tmp->sum);
+		ret = sizeof(tmp->sum);
 		break;
 	}
-	case VPERFCTR_READ_CONTROL:
+	case VPERFCTR_DOMAIN_CONTROL:
 		tmp->control.si_signo = perfctr->si_signo;
-		tmp->control.cpu_control = perfctr->cpu_state.control;
-		tmp->control.preserve = 0;
-		tmpbytes = sizeof(tmp->control);
+		tmp->control.preserve = perfctr->preserve;
+		ret = sizeof(tmp->control);
 		break;
-	case VPERFCTR_READ_CHILDREN:
+	case VPERFCTR_DOMAIN_CHILDREN:
 		if (tsk)
 			spin_lock(&perfctr->children_lock);
 		tmp->children = perfctr->children;
 		if (tsk)
 			spin_unlock(&perfctr->children_lock);
-		tmpbytes = sizeof(tmp->children);
+		ret = sizeof(tmp->children);
+		break;
+	case PERFCTR_DOMAIN_CPU_CONTROL:
+		if (tmpbytes > sizeof(perfctr->cpu_state.control.header))
+			tmpbytes = sizeof(perfctr->cpu_state.control.header);
+		memcpy(tmp, &perfctr->cpu_state.control.header, tmpbytes);
+		ret = tmpbytes;
+		break;
+	case PERFCTR_DOMAIN_CPU_MAP:
+		if (tmpbytes > sizeof(perfctr->cpu_state.control.pmc_map))
+			tmpbytes = sizeof(perfctr->cpu_state.control.pmc_map);
+		memcpy(tmp, perfctr->cpu_state.control.pmc_map, tmpbytes);
+		ret = tmpbytes;
 		break;
 	default:
-		tmpbytes = 0;
+		ret = -EFAULT;
+		if (copy_from_user(tmp, dstp, dstbytes) == 0)
+			ret = perfctr_cpu_control_read(&perfctr->cpu_state.control,
+						       domain, tmp, dstbytes);
 	}
 
 	if (tsk == current)
 		preempt_enable();
 
-	ret = -EINVAL;
-	if (tmpbytes > argbytes)
-		tmpbytes = argbytes;
-	if (tmpbytes > 0) {
-		ret = tmpbytes;
-		if (copy_to_user(argp, tmp, tmpbytes))
+	if (ret > 0) {
+		if (ret > dstbytes)
+			ret = dstbytes;
+		if (ret > 0 && copy_to_user(dstp, tmp, ret))
 			ret = -EFAULT;
 	}
 	kfree(tmp);
@@ -1130,8 +1161,8 @@ static void vperfctr_put_tsk(struct task
 		put_task_struct(tsk);
 }
 
-asmlinkage long sys_vperfctr_write(int fd,
-				   const struct vperfctr_control __user *argp,
+asmlinkage long sys_vperfctr_write(int fd, unsigned int domain,
+				   const void __user *argp,
 				   unsigned int argbytes)
 {
 	struct vperfctr *perfctr;
@@ -1146,7 +1177,7 @@ asmlinkage long sys_vperfctr_write(int f
 		ret = PTR_ERR(tsk);
 		goto out;
 	}
-	ret = do_vperfctr_write(perfctr, argp, argbytes, tsk);
+	ret = do_vperfctr_write(perfctr, domain, argp, argbytes, tsk);
 	vperfctr_put_tsk(tsk);
  out:
 	put_vperfctr(perfctr);
@@ -1174,7 +1205,8 @@ asmlinkage long sys_vperfctr_control(int
 	return ret;
 }
 
-asmlinkage long sys_vperfctr_read(int fd, unsigned int cmd, void __user *argp, unsigned int argbytes)
+asmlinkage long sys_vperfctr_read(int fd, unsigned int domain,
+				  void __user *argp, unsigned int argbytes)
 {
 	struct vperfctr *perfctr;
 	struct task_struct *tsk;
@@ -1188,7 +1220,7 @@ asmlinkage long sys_vperfctr_read(int fd
 		ret = PTR_ERR(tsk);
 		goto out;
 	}
-	ret = do_vperfctr_read(perfctr, cmd, argp, argbytes, tsk);
+	ret = do_vperfctr_read(perfctr, domain, argp, argbytes, tsk);
 	vperfctr_put_tsk(tsk);
  out:
 	put_vperfctr(perfctr);
diff -rupN linux-2.6.11-mm3.perfctr-cpu_control-access/include/linux/perfctr.h linux-2.6.11-mm3.perfctr-read-write-domains/include/linux/perfctr.h
--- linux-2.6.11-mm3.perfctr-cpu_control-access/include/linux/perfctr.h	2005-03-12 20:01:39.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-read-write-domains/include/linux/perfctr.h	2005-03-12 20:03:52.000000000 +0100
@@ -47,11 +47,6 @@ struct vperfctr_state {
 struct vperfctr_control {
 	int si_signo;
 	unsigned int preserve;
-	unsigned int _reserved1;
-	unsigned int _reserved2;
-	unsigned int _reserved3;
-	unsigned int _reserved4;
-	struct perfctr_cpu_control cpu_control;
 };
 
 /* commands for sys_vperfctr_control() */
@@ -66,16 +61,18 @@ struct perfctr_cpu_reg {
 	unsigned int value;
 };
 
+/* state and control domain numbers
+   0-127 are for architecture-neutral domains
+   128-255 are for architecture-specific domains */
+#define VPERFCTR_DOMAIN_SUM		1	/* struct perfctr_sum_ctrs */
+#define VPERFCTR_DOMAIN_CONTROL		2	/* struct vperfctr_control */
+#define VPERFCTR_DOMAIN_CHILDREN	3	/* struct perfctr_sum_ctrs */
+
 /* domain numbers for common arch-specific control data */
 #define PERFCTR_DOMAIN_CPU_CONTROL	128	/* struct perfctr_cpu_control_header */
 #define PERFCTR_DOMAIN_CPU_MAP		129	/* unsigned int[] */
 #define PERFCTR_DOMAIN_CPU_REGS		130	/* struct perfctr_cpu_reg[] */
 
-/* commands for sys_vperfctr_read() */
-#define VPERFCTR_READ_SUM	0x01
-#define VPERFCTR_READ_CONTROL	0x02
-#define VPERFCTR_READ_CHILDREN	0x03
-
 #else
 struct perfctr_info;
 struct perfctr_cpu_mask;
@@ -90,10 +87,12 @@ struct vperfctr_control;
  */
 asmlinkage long sys_vperfctr_open(int tid, int creat);
 asmlinkage long sys_vperfctr_control(int fd, unsigned int cmd);
-asmlinkage long sys_vperfctr_write(int fd,
-				   const struct vperfctr_control __user *argp,
+asmlinkage long sys_vperfctr_write(int fd, unsigned int domain,
+				   const void __user *argp,
 				   unsigned int argbytes);
-asmlinkage long sys_vperfctr_read(int fd, unsigned int cmd, void __user *argp, unsigned int argbytes);
+asmlinkage long sys_vperfctr_read(int fd, unsigned int domain,
+				  void __user *argp,
+				  unsigned int argbytes);
 
 extern struct perfctr_info perfctr_info;
 
