Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268506AbUH3PuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268506AbUH3PuW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 11:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUH3PuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 11:50:21 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:41960 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S268506AbUH3PrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 11:47:21 -0400
Date: Mon, 30 Aug 2004 09:38:23 -0500
From: Michael Halcrow <mike@halcrow.us>
To: chrisw@osdl.org
Cc: linux-kernel@vger.kernel.org, mike@halcrow.us
Subject: [PATCH] BSD Secure Levels LSM (2/3)
Message-ID: <20040830143823.GB9980@halcrow.us>
Reply-To: Michael Halcrow <mahalcro@us.ibm.com>
References: <20040830143547.GA9980@halcrow.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <20040830143547.GA9980@halcrow.us>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

BSD Secure Levels LSM.  This adds settime hooks necessary to support
the BSD Secure Levels model.

Signed-off-by: Michael A. Halcrow <mike@halcrow.us>
--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="settime_2.6.8-rc3.diff"

--- linux-2.6.8-rc3/arch/mips/kernel/sysirix.c	2004-08-09 16:15:39.000000000 -0500
+++ linux-2.6.8-rc3_seclvl/arch/mips/kernel/sysirix.c	2004-08-09 16:16:33.000000000 -0500
@@ -614,8 +614,14 @@
 
 asmlinkage int irix_stime(int value)
 {
-	if (!capable(CAP_SYS_TIME))
-		return -EPERM;
+	int err;
+	struct timespec tv;
+
+	tv.tv_sec = value;
+	tv.tv_nsec = 0;
+	err = security_settime(&tv, NULL);
+	if (err)
+		return err;
 
 	write_seqlock_irq(&xtime_lock);
 	xtime.tv_sec = value;
--- linux-2.6.8-rc3/arch/ppc64/kernel/time.c	2004-08-09 16:15:42.000000000 -0500
+++ linux-2.6.8-rc3_seclvl/arch/ppc64/kernel/time.c	2004-08-09 16:16:35.000000000 -0500
@@ -435,9 +435,7 @@
 {
 	int value;
 	struct timespec myTimeval;
-
-	if (!capable(CAP_SYS_TIME))
-		return -EPERM;
+	int err;
 
 	if (get_user(value, tptr))
 		return -EFAULT;
@@ -445,6 +443,10 @@
 	myTimeval.tv_sec = value;
 	myTimeval.tv_nsec = 0;
 
+	err = security_settime(&myTimeval, NULL);
+	if (err)
+		return err;
+
 	do_settimeofday(&myTimeval);
 
 	return 0;
@@ -460,9 +462,7 @@
 {
 	long value;
 	struct timespec myTimeval;
-
-	if (!capable(CAP_SYS_TIME))
-		return -EPERM;
+	int err;
 
 	if (get_user(value, tptr))
 		return -EFAULT;
@@ -470,6 +470,10 @@
 	myTimeval.tv_sec = value;
 	myTimeval.tv_nsec = 0;
 
+	err = security_settime(&myTimeval, NULL);
+	if (err)
+		return err;
+
 	do_settimeofday(&myTimeval);
 
 	return 0;
--- linux-2.6.8-rc3/include/linux/security.h	2004-08-09 16:16:08.000000000 -0500
+++ linux-2.6.8-rc3_seclvl/include/linux/security.h	2004-08-09 16:17:00.000000000 -0500
@@ -39,6 +39,7 @@
  * as the default capabilities functions
  */
 extern int cap_capable (struct task_struct *tsk, int cap);
+extern int cap_settime (struct timespec *ts, struct timezone *tz);
 extern int cap_ptrace (struct task_struct *parent, struct task_struct *child);
 extern int cap_capget (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
 extern int cap_capset_check (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
@@ -999,6 +1000,12 @@
  *	See the syslog(2) manual page for an explanation of the @type values.  
  *	@type contains the type of action.
  *	Return 0 if permission is granted.
+ * @settime:
+ *	Check permission to change the system time. 
+ *	struct timespec and timezone are defined in include/linux/time.h
+ *	@ts contains new time
+ *	@tz contains new timezone
+ *	Return 0 if permission is granted.
  * @vm_enough_memory:
  *	Check permissions for allocating a new virtual mapping.
  *      @pages contains the number of pages.
@@ -1034,6 +1041,7 @@
 	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
 	int (*quota_on) (struct file * f);
 	int (*syslog) (int type);
+	int (*settime) (struct timespec *ts, struct timezone *tz);
 	int (*vm_enough_memory) (long pages);
 
 	int (*bprm_alloc_security) (struct linux_binprm * bprm);
@@ -1289,6 +1297,12 @@
 	return security_ops->syslog(type);
 }
 
+static inline int security_settime(struct timespec *ts, struct timezone *tz)
+{
+	return security_ops->settime(ts, tz);
+}
+
+
 static inline int security_vm_enough_memory(long pages)
 {
 	return security_ops->vm_enough_memory(pages);
@@ -1961,6 +1975,11 @@
 	return cap_syslog(type);
 }
 
+static inline int security_settime(struct timespec *ts, struct timezone *tz)
+{
+	return cap_settime(ts, tz);
+}
+
 static inline int security_vm_enough_memory(long pages)
 {
 	return cap_vm_enough_memory(pages);
--- linux-2.6.8-rc3/kernel/time.c	2004-06-16 00:19:01.000000000 -0500
+++ linux-2.6.8-rc3_seclvl/kernel/time.c	2004-08-09 08:05:02.000000000 -0500
@@ -28,6 +28,7 @@
 #include <linux/timex.h>
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
@@ -74,13 +75,17 @@
 asmlinkage long sys_stime(time_t __user *tptr)
 {
 	struct timespec tv;
+	int err;
 
-	if (!capable(CAP_SYS_TIME))
-		return -EPERM;
 	if (get_user(tv.tv_sec, tptr))
 		return -EFAULT;
 
 	tv.tv_nsec = 0;
+
+	err = security_settime(&tv, NULL);
+	if (err)
+		return err;
+
 	do_settimeofday(&tv);
 	return 0;
 }
@@ -142,10 +147,12 @@
 int do_sys_settimeofday(struct timespec *tv, struct timezone *tz)
 {
 	static int firsttime = 1;
+	int error = 0;
+
+	error = security_settime(tv, tz);
+	if (error)
+		return error;
 
-	if (!capable(CAP_SYS_TIME))
-		return -EPERM;
-		
 	if (tz) {
 		/* SMP safe, global irq locking makes it work. */
 		sys_tz = *tz;
--- linux-2.6.8-rc3/security/capability.c	2004-06-16 00:19:13.000000000 -0500
+++ linux-2.6.8-rc3_seclvl/security/capability.c	2004-08-09 08:03:30.000000000 -0500
@@ -30,6 +30,7 @@
 	.capset_check =			cap_capset_check,
 	.capset_set =			cap_capset_set,
 	.capable =			cap_capable,
+	.settime =			cap_settime,
 	.netlink_send =			cap_netlink_send,
 	.netlink_recv =			cap_netlink_recv,
 
--- linux-2.6.8-rc3/security/commoncap.c	2004-06-16 00:19:13.000000000 -0500
+++ linux-2.6.8-rc3_seclvl/security/commoncap.c	2004-08-09 08:06:57.000000000 -0500
@@ -27,20 +27,25 @@
 int cap_capable (struct task_struct *tsk, int cap)
 {
 	/* Derived from include/linux/sched.h:capable. */
-	if (cap_raised (tsk->cap_effective, cap))
+	if (cap_raised(tsk->cap_effective, cap))
 		return 0;
-	else
+	return -EPERM;
+}
+
+int cap_settime(struct timespec *ts, struct timezone *tz)
+{
+	if (!capable(CAP_SYS_TIME))
 		return -EPERM;
+	return 0;
 }
 
 int cap_ptrace (struct task_struct *parent, struct task_struct *child)
 {
 	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
 	if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&
-	    !capable (CAP_SYS_PTRACE))
+	    !capable(CAP_SYS_PTRACE))
 		return -EPERM;
-	else
-		return 0;
+	return 0;
 }
 
 int cap_capget (struct task_struct *target, kernel_cap_t *effective,
@@ -368,6 +373,7 @@
 }
 
 EXPORT_SYMBOL(cap_capable);
+EXPORT_SYMBOL(cap_settime);
 EXPORT_SYMBOL(cap_ptrace);
 EXPORT_SYMBOL(cap_capget);
 EXPORT_SYMBOL(cap_capset_check);
--- linux-2.6.8-rc3/security/dummy.c	2004-08-09 16:16:09.000000000 -0500
+++ linux-2.6.8-rc3_seclvl/security/dummy.c	2004-08-09 16:17:05.000000000 -0500
@@ -104,6 +104,13 @@
 	return 0;
 }
 
+static int dummy_settime (struct timeval *tv, struct timezone *tz)
+{
+	if (!capable(CAP_SYS_TIME))
+		return -EPERM;
+	return 0;
+}
+
 /*
  * Check that a process has enough memory to allocate a new virtual
  * mapping. 0 means there is enough memory for the allocation to
@@ -897,6 +904,7 @@
 	set_to_dummy_if_null(ops, quota_on);
 	set_to_dummy_if_null(ops, sysctl);
 	set_to_dummy_if_null(ops, syslog);
+	set_to_dummy_if_null(ops, settime);
 	set_to_dummy_if_null(ops, vm_enough_memory);
 	set_to_dummy_if_null(ops, bprm_alloc_security);
 	set_to_dummy_if_null(ops, bprm_free_security);

--LyciRD1jyfeSSjG0--
