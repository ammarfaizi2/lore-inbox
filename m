Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261489AbSIZUX6>; Thu, 26 Sep 2002 16:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSIZUX6>; Thu, 26 Sep 2002 16:23:58 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:18955 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261489AbSIZUX0>;
	Thu, 26 Sep 2002 16:23:26 -0400
Date: Thu, 26 Sep 2002 13:27:14 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020926202713.GC6908@kroah.com>
References: <20020926202552.GA6908@kroah.com> <20020926202647.GB6908@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020926202647.GB6908@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.612   -> 1.613  
#	        kernel/sys.c	1.28    -> 1.29   
#	     kernel/sysctl.c	1.30    -> 1.31   
#	include/linux/security.h	1.4     -> 1.5    
#	       mm/swapfile.c	1.56    -> 1.57   
#	    security/dummy.c	1.7     -> 1.8    
#	       kernel/time.c	1.7     -> 1.8    
#	security/capability.c	1.6     -> 1.7    
#	arch/i386/kernel/ioport.c	1.3     -> 1.4    
#	       mm/oom_kill.c	1.16    -> 1.17   
#	arch/ia64/ia32/sys_ia32.c	1.19    -> 1.20   
#	     kernel/printk.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/26	sds@tislabs.com	1.613
# [PATCH] LSM: misc hooks addition
# 
# The patch below (relative to the LSM IPC hooks patch) adds the LSM hooks
# for miscellaneous system operations (module_*, sethostname, setdomainname,
# reboot, ioperm/iopl, sysctl, swapon/swapoff, syslog, settime).  It also
# replaces the hardcoded capability tests in the OOM killer code with
# appropriate calls to the LSM capable hook, preserving the original behavior
# as long as the capabilities module is enabled.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/ioport.c b/arch/i386/kernel/ioport.c
--- a/arch/i386/kernel/ioport.c	Thu Sep 26 13:23:55 2002
+++ b/arch/i386/kernel/ioport.c	Thu Sep 26 13:23:55 2002
@@ -14,6 +14,7 @@
 #include <linux/smp_lock.h>
 #include <linux/stddef.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 
 /* Set EXTENT bits starting at BASE in BITMAP to value TURN_ON. */
 static void set_bitmap(unsigned long *bitmap, short base, short extent, int new_value)
@@ -62,7 +63,12 @@
 		return -EINVAL;
 	if (turn_on && !capable(CAP_SYS_RAWIO))
 		return -EPERM;
-
+ 
+ 	ret = security_ops->ioperm(from, num, turn_on);
+ 	if (ret) {
+ 		return ret;
+ 	}
+ 
 	tss = init_tss + get_cpu();
 
 	/*
@@ -116,6 +122,7 @@
 	struct pt_regs * regs = (struct pt_regs *) &unused;
 	unsigned int level = regs->ebx;
 	unsigned int old = (regs->eflags >> 12) & 3;
+	int retval;
 
 	if (level > 3)
 		return -EINVAL;
@@ -124,6 +131,11 @@
 		if (!capable(CAP_SYS_RAWIO))
 			return -EPERM;
 	}
+	retval = security_ops->iopl(old, level);
+	if (retval) {
+		return retval;
+	}
+
 	regs->eflags = (regs->eflags & 0xffffcfff) | (level << 12);
 	return 0;
 }
diff -Nru a/arch/ia64/ia32/sys_ia32.c b/arch/ia64/ia32/sys_ia32.c
--- a/arch/ia64/ia32/sys_ia32.c	Thu Sep 26 13:23:55 2002
+++ b/arch/ia64/ia32/sys_ia32.c	Thu Sep 26 13:23:55 2002
@@ -49,6 +49,7 @@
 #include <linux/ptrace.h>
 #include <linux/stat.h>
 #include <linux/ipc.h>
+#include <linux/security.h>
 
 #include <asm/types.h>
 #include <asm/uaccess.h>
@@ -3184,6 +3185,7 @@
 	unsigned int old;
 	unsigned long addr;
 	mm_segment_t old_fs = get_fs ();
+	int retval;
 
 	if (level != 3)
 		return(-EINVAL);
@@ -3193,6 +3195,11 @@
 		if (!capable(CAP_SYS_RAWIO))
 			return -EPERM;
 	}
+	retval = security_ops->iopl(old,level);
+	if (retval) {
+		return retval;
+	}
+
 	set_fs(KERNEL_DS);
 	fd = sys_open("/dev/mem", O_SYNC | O_RDWR, 0);
 	set_fs(old_fs);
diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Thu Sep 26 13:23:55 2002
+++ b/include/linux/security.h	Thu Sep 26 13:23:55 2002
@@ -6,6 +6,7 @@
  * Copyright (C) 2001 Networks Associates Technology, Inc <ssmalley@nai.com>
  * Copyright (C) 2001 James Morris <jmorris@intercode.com.au>
  * Copyright (C) 2001 Silicon Graphics, Inc. (Trust Technology Group)
+ * Copyright (C) 2002 International Business Machines <robb@austin.ibm.com>
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License as published by
@@ -32,6 +33,7 @@
 #include <linux/sysctl.h>
 #include <linux/shm.h>
 #include <linux/msg.h>
+#include <linux/time.h>
 
 /*
  * Values used in the task_security_ops calls
@@ -572,6 +574,26 @@
  * 	is being reparented to the init task.
  *	@p contains the task_struct for the kernel thread.
  *
+ * Security hooks for kernel module operations.
+ *
+ * @module_create:
+ *	Check the permission before allocating space for a module.
+ *	@name contains the module name.
+ *	@size contains the module size.
+ *	Return 0 if permission is granted.
+ * @module_initialize:
+ * 	Check permission before initializing a module.
+ * 	@mod contains a pointer to the module being initialized.
+ *	Return 0 if permission is granted.
+ * @module_delete:
+ *	Check permission before removing a module.
+ *	@mod contains a pointer to the module being deleted.
+ *	Return 0 if permission is granted.
+ * 
+ * These are the hooks for kernel module operations.  All hooks are called with
+ * the big kernel lock held, and @delete_module is also called with the
+ * unload_lock held.
+ *
  * Security hooks affecting all System V IPC operations.
  *
  * @ipc_permission:
@@ -725,6 +747,34 @@
  *	@alter contains the flag indicating whether changes are to be made.
  *	Return 0 if permission is granted.
  *
+ * @sethostname:
+ *	Check permission before the hostname is set to @hostname.
+ *	@hostname contains the new hostname
+ *	Return 0 if permission is granted.
+ * @setdomainname:
+ *	Check permission before the domainname is set to @domainname.
+ *	@domainname contains the new domainname
+ *	Return 0 if permission is granted.
+ * @reboot:
+ *	Check permission before rebooting or enabling/disabling the
+ *	Ctrl-Alt-Del key sequence.
+ *	The values for @cmd are defined in the reboot(2) manual page.
+ *	@cmd contains the reboot command.
+ *	Return 0 if permission is granted.
+ * @ioperm:
+ *	Check permission before setting port input/output permissions for the
+ *	process for @num bytes starting from the port address @from to the
+ *	value @turn_on.
+ *	@from contains the starting port address.
+ *	@num contains the number of bytes starting from @from.
+ *	@turn_on contains the permissions value.
+ *	Return 0 if permission is granted.
+ * @iopl:
+ *	Check permission before changing the I/O privilege level of the current
+ *	process from @old to @level.
+ *	@old contains the old level.
+ *	@level contains the new level.
+ *	Return 0 if permission is granted.
  * @ptrace:
  *	Check permission before allowing the @parent process to trace the
  *	@child process.
@@ -775,6 +825,12 @@
  *	is NULL.
  *	@file contains the file structure for the accounting file (may be NULL).
  *	Return 0 if permission is granted.
+ * @sysctl:
+ *	Check permission before accessing the @table sysctl variable in the
+ *	manner specified by @op.
+ *	@table contains the ctl_table structure for the sysctl variable.
+ *	@op contains the operation (001 = search, 002 = write, 004 = read).
+ *	Return 0 if permission is granted.
  * @capable:
  *	Check whether the @tsk process has the @cap capability.
  *	@tsk contains the task_struct for the process.
@@ -795,6 +851,42 @@
  *	@args contains the call arguments (user space pointer).
  *	The module should return -ENOSYS if it does not implement any new
  *	system calls.
+ * @swapon:
+ *	Check permission before enabling swapping to the file or block device
+ *	identified by @swap.
+ *	@swap contains the swap_info_struct structure for the swap file and device.
+ *	Return 0 if permission is granted.
+ * @swapoff:
+ *	Check permission before disabling swapping to the file or block device
+ *	identified by @swap.
+ *	@swap contains the swap_info_struct structure for the swap file and device.
+ *	Return 0 if permission is granted.
+ * @quotactl:
+ *	Check permission before performing the quota operation identified by
+ *	@cmd for the specified @type, @id, and @sb.  The @sb parameter may be
+ *	NULL, e.g. for the Q_SYNC and Q_GETSTATS commands.
+ *	@cmd contains the command value.
+ *	@type contains the type of quota (USRQUOTA or GRPQUOTA).
+ *	@id contains the user or group identifier.
+ *	@sb contains the super_block structure for the filesystem (may be NULL).
+ *	Return 0 if permission is granted.
+ * @quota_on:
+ *	Check permission before enabling quotas for a file system using @f as
+ *	the quota file.
+ *	@f contains the open file for storing quotas.
+ *	Return 0 if permission is granted.
+ * @syslog:
+ *	Check permission before accessing the kernel message ring or changing
+ *	logging to the console.
+ *	See the syslog(2) manual page for an explanation of the @type values.  
+ *	@type contains the type of action.
+ *	Return 0 if permission is granted.
+ * @settime:
+ *      Check permission to change the system time. 
+ *      struct timeval and timezone are defined in include/linux/time.h
+ *      @tv contains new time
+ *      @tz contains new timezone
+ *      Return 0 if permission is granted.
  *
  * @register_security:
  * 	allow module stacking.
@@ -808,6 +900,11 @@
  * This is the main security structure.
  */
 struct security_operations {
+	int (*sethostname) (char *hostname);
+	int (*setdomainname) (char *domainname);
+	int (*reboot) (unsigned int cmd);
+	int (*ioperm) (unsigned long from, unsigned long num, int turn_on);
+	int (*iopl) (unsigned int old, unsigned int level);
 	int (*ptrace) (struct task_struct * parent, struct task_struct * child);
 	int (*capget) (struct task_struct * target,
 		       kernel_cap_t * effective,
@@ -821,11 +918,16 @@
 			    kernel_cap_t * inheritable,
 			    kernel_cap_t * permitted);
 	int (*acct) (struct file * file);
+	int (*sysctl) (ctl_table * table, int op);
 	int (*capable) (struct task_struct * tsk, int cap);
 	int (*sys_security) (unsigned int id, unsigned call,
 			     unsigned long *args);
+	int (*swapon) (struct swap_info_struct * swap);
+	int (*swapoff) (struct swap_info_struct * swap);
 	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
 	int (*quota_on) (struct file * f);
+	int (*syslog) (int type);
+	int (*settime) (struct timeval *tv, struct timezone *tz);
 
 	int (*bprm_alloc_security) (struct linux_binprm * bprm);
 	void (*bprm_free_security) (struct linux_binprm * bprm);
@@ -938,6 +1040,10 @@
 			   unsigned long arg5);
 	void (*task_kmod_set_label) (void);
 	void (*task_reparent_to_init) (struct task_struct * p);
+
+	int (*module_create) (const char *name, size_t size);
+	int (*module_initialize) (struct module * mod);
+	int (*module_delete) (const struct module * mod);
 
 	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
 	int (*ipc_getinfo) (int id, int cmd);
diff -Nru a/kernel/printk.c b/kernel/printk.c
--- a/kernel/printk.c	Thu Sep 26 13:23:55 2002
+++ b/kernel/printk.c	Thu Sep 26 13:23:55 2002
@@ -175,6 +175,10 @@
 	char *lbuf = NULL;
 	int error = 0;
 
+	error = security_ops->syslog(type);
+	if( error )
+		return error;
+
 	switch (type) {
 	case 0:		/* Close log */
 		break;
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Thu Sep 26 13:23:55 2002
+++ b/kernel/sys.c	Thu Sep 26 13:23:55 2002
@@ -349,11 +349,17 @@
 asmlinkage long sys_reboot(int magic1, int magic2, unsigned int cmd, void * arg)
 {
 	char buffer[256];
+	int retval;
 
 	/* We only trust the superuser with rebooting the system. */
 	if (!capable(CAP_SYS_BOOT))
 		return -EPERM;
 
+	retval = security_ops->reboot(cmd);
+	if (retval) {
+		return retval;
+	}
+
 	/* For safety, we require "magic" arguments. */
 	if (magic1 != LINUX_REBOOT_MAGIC1 ||
 	    (magic2 != LINUX_REBOOT_MAGIC2 && magic2 != LINUX_REBOOT_MAGIC2A &&
@@ -1130,18 +1136,23 @@
 
 asmlinkage long sys_sethostname(char *name, int len)
 {
+	char nodename[__NEW_UTS_LEN+1];
 	int errno;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	if (len < 0 || len > __NEW_UTS_LEN)
 		return -EINVAL;
+	if (copy_from_user(nodename, name, len)) 
+		return -EFAULT;
+	nodename[len] = 0;
+
+	errno = security_ops->sethostname(nodename);
+	if (errno)
+		return errno;
+
 	down_write(&uts_sem);
-	errno = -EFAULT;
-	if (!copy_from_user(system_utsname.nodename, name, len)) {
-		system_utsname.nodename[len] = 0;
-		errno = 0;
-	}
+	memcpy(system_utsname.nodename, nodename, len+1);
 	up_write(&uts_sem);
 	return errno;
 }
@@ -1169,19 +1180,23 @@
  */
 asmlinkage long sys_setdomainname(char *name, int len)
 {
+	char domainname[__NEW_UTS_LEN+1];
 	int errno;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 	if (len < 0 || len > __NEW_UTS_LEN)
 		return -EINVAL;
+	if (copy_from_user(domainname, name, len)) 
+		return -EFAULT;
+	domainname[len] = 0;
+
+	errno = security_ops->setdomainname(domainname);
+	if (errno)
+		return errno;
 
 	down_write(&uts_sem);
-	errno = -EFAULT;
-	if (!copy_from_user(system_utsname.domainname, name, len)) {
-		errno = 0;
-		system_utsname.domainname[len] = 0;
-	}
+	memcpy(system_utsname.domainname, domainname, len+1);
 	up_write(&uts_sem);
 	return errno;
 }
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Thu Sep 26 13:23:55 2002
+++ b/kernel/sysctl.c	Thu Sep 26 13:23:55 2002
@@ -427,6 +427,11 @@
 
 static inline int ctl_perm(ctl_table *table, int op)
 {
+	int error;
+	error = security_ops->sysctl(table, op);
+	if(error) {
+		return error;
+	}
 	return test_perm(table->mode, op);
 }
 
diff -Nru a/kernel/time.c b/kernel/time.c
--- a/kernel/time.c	Thu Sep 26 13:23:55 2002
+++ b/kernel/time.c	Thu Sep 26 13:23:55 2002
@@ -27,6 +27,7 @@
 #include <linux/timex.h>
 #include <linux/errno.h>
 #include <linux/smp_lock.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
@@ -147,9 +148,14 @@
 int do_sys_settimeofday(struct timeval *tv, struct timezone *tz)
 {
 	static int firsttime = 1;
+	int error = 0;
 
 	if (!capable(CAP_SYS_TIME))
 		return -EPERM;
+
+        error = security_ops->settime(tv, tz);
+        if (error)
+                return error;
 		
 	if (tz) {
 		/* SMP safe, global irq locking makes it work. */
diff -Nru a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c	Thu Sep 26 13:23:55 2002
+++ b/mm/oom_kill.c	Thu Sep 26 13:23:55 2002
@@ -88,7 +88,7 @@
 	 * Superuser processes are usually more important, so we make it
 	 * less likely that we kill those.
 	 */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
+	if (!security_ops->capable(p,CAP_SYS_ADMIN) ||
 				p->uid == 0 || p->euid == 0)
 		points /= 4;
 
@@ -98,7 +98,7 @@
 	 * tend to only have this flag set on applications they think
 	 * of as important.
 	 */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
+	if (!security_ops->capable(p,CAP_SYS_RAWIO))
 		points /= 4;
 #ifdef DEBUG
 	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
@@ -149,7 +149,7 @@
 	p->flags |= PF_MEMALLOC | PF_MEMDIE;
 
 	/* This process has hardware access, be more careful. */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
+	if (!security_ops->capable(p,CAP_SYS_RAWIO)) {
 		force_sig(SIGTERM, p);
 	} else {
 		force_sig(SIGKILL, p);
diff -Nru a/mm/swapfile.c b/mm/swapfile.c
--- a/mm/swapfile.c	Thu Sep 26 13:23:55 2002
+++ b/mm/swapfile.c	Thu Sep 26 13:23:55 2002
@@ -964,6 +964,13 @@
 		}
 		prev = type;
 	}
+
+	err = security_ops->swapoff(p);
+	if (err) {
+		swap_list_unlock();
+		goto out_dput;
+	}
+
 	err = -EINVAL;
 	if (type < 0) {
 		swap_list_unlock();
@@ -1136,6 +1143,9 @@
 	}
 
 	p->swap_file = swap_file;
+	error = security_ops->swapon(p);
+	if (error)
+		goto bad_swap_2;
 
 	error = -EINVAL;
 	if (S_ISBLK(swap_file->f_dentry->d_inode->i_mode)) {
diff -Nru a/security/capability.c b/security/capability.c
--- a/security/capability.c	Thu Sep 26 13:23:55 2002
+++ b/security/capability.c	Thu Sep 26 13:23:55 2002
@@ -22,6 +22,31 @@
 /* flag to keep track of how we were registered */
 static int secondary;
 
+static int cap_sethostname (char *hostname)
+{
+	return 0;
+}
+
+static int cap_setdomainname (char *domainname)
+{
+	return 0;
+}
+
+static int cap_reboot (unsigned int cmd)
+{
+	return 0;
+}
+
+static int cap_ioperm (unsigned long from, unsigned long num, int turn_on)
+{
+	return 0;
+}
+
+static int cap_iopl (unsigned int old, unsigned int level)
+{
+	return 0;
+}
+
 static int cap_capable (struct task_struct *tsk, int cap)
 {
 	/* Derived from include/linux/sched.h:capable. */
@@ -37,6 +62,16 @@
 	return -ENOSYS;
 }
 
+static int cap_swapon (struct swap_info_struct *swap)
+{
+	return 0;
+}
+
+static int cap_swapoff (struct swap_info_struct *swap)
+{
+	return 0;
+}
+
 static int cap_quotactl (int cmds, int type, int id, struct super_block *sb)
 {
 	return 0;
@@ -47,6 +82,16 @@
 	return 0;
 }
 
+static int cap_syslog (int type)
+{
+	return 0;
+}
+
+static int cap_settime (struct timeval *tv, struct timezone *tz)
+{
+        return 0;
+}
+
 static int cap_ptrace (struct task_struct *parent, struct task_struct *child)
 {
 	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
@@ -110,6 +155,11 @@
 	return 0;
 }
 
+static int cap_sysctl (ctl_table * table, int op)
+{
+	return 0;
+}
+
 static int cap_bprm_alloc_security (struct linux_binprm *bprm)
 {
 	return 0;
@@ -679,6 +729,21 @@
 	return;
 }
 
+static int cap_module_create (const char *name_user, size_t size)
+{
+	return 0;
+}
+
+static int cap_module_initialize (struct module *mod_user)
+{
+	return 0;
+}
+
+static int cap_module_delete (const struct module *mod)
+{
+	return 0;
+}
+
 static int cap_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
 {
 	return 0;
@@ -796,15 +861,25 @@
 }
 
 static struct security_operations capability_ops = {
+	.sethostname =		        cap_sethostname,
+	.setdomainname =		cap_setdomainname,
+	.reboot =			cap_reboot,
+	.ioperm =			cap_ioperm,
+	.iopl =			        cap_iopl,
 	.ptrace =			cap_ptrace,
 	.capget =			cap_capget,
 	.capset_check =			cap_capset_check,
 	.capset_set =			cap_capset_set,
 	.acct =				cap_acct,
+	.sysctl =			cap_sysctl,
 	.capable =			cap_capable,
 	.sys_security =			cap_sys_security,
+	.swapon =			cap_swapon,
+	.swapoff =		        cap_swapoff,
 	.quotactl =			cap_quotactl,
 	.quota_on =			cap_quota_on,
+	.syslog =			cap_syslog,
+	.settime =			cap_settime,
 
 	.bprm_alloc_security =		cap_bprm_alloc_security,
 	.bprm_free_security =		cap_bprm_free_security,
@@ -887,6 +962,10 @@
 	.task_prctl =			cap_task_prctl,
 	.task_kmod_set_label =		cap_task_kmod_set_label,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
+
+	.module_create =		cap_module_create,
+	.module_initialize =	        cap_module_initialize,
+	.module_delete =		cap_module_delete,
 
 	.ipc_permission =		cap_ipc_permission,
 	.ipc_getinfo =			cap_ipc_getinfo,
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Thu Sep 26 13:23:55 2002
+++ b/security/dummy.c	Thu Sep 26 13:23:55 2002
@@ -19,6 +19,31 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 
+static int dummy_sethostname (char *hostname)
+{
+	return 0;
+}
+
+static int dummy_setdomainname (char *domainname)
+{
+	return 0;
+}
+
+static int dummy_reboot (unsigned int cmd)
+{
+	return 0;
+}
+
+static int dummy_ioperm (unsigned long from, unsigned long num, int turn_on)
+{
+	return 0;
+}
+
+static int dummy_iopl (unsigned int old, unsigned int level)
+{
+	return 0;
+}
+
 static int dummy_ptrace (struct task_struct *parent, struct task_struct *child)
 {
 	return 0;
@@ -61,12 +86,27 @@
 	return -EPERM;
 }
 
+static int dummy_sysctl (ctl_table * table, int op)
+{
+	return 0;
+}
+
 static int dummy_sys_security (unsigned int id, unsigned int call,
 			       unsigned long *args)
 {
 	return -ENOSYS;
 }
 
+static int dummy_swapon (struct swap_info_struct *swap)
+{
+	return 0;
+}
+
+static int dummy_swapoff (struct swap_info_struct *swap)
+{
+	return 0;
+}
+
 static int dummy_quotactl (int cmds, int type, int id, struct super_block *sb)
 {
 	return 0;
@@ -77,6 +117,16 @@
 	return 0;
 }
 
+static int dummy_syslog (int type)
+{
+	return 0;
+}
+
+static int dummy_settime (struct timeval *tv, struct timezone *tz)
+{
+	return 0;
+}
+
 static int dummy_bprm_alloc_security (struct linux_binprm *bprm)
 {
 	return 0;
@@ -493,6 +543,21 @@
 	return;
 }
 
+static int dummy_module_create (const char *name_user, size_t size)
+{
+	return 0;
+}
+
+static int dummy_module_initialize (struct module *mod_user)
+{
+	return 0;
+}
+
+static int dummy_module_delete (const struct module *mod)
+{
+	return 0;
+}
+
 static int dummy_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
 {
 	return 0;
@@ -610,15 +675,25 @@
 }
 
 struct security_operations dummy_security_ops = {
+	.sethostname =			dummy_sethostname,
+	.setdomainname =		dummy_setdomainname,
+	.reboot =			dummy_reboot,
+	.ioperm =			dummy_ioperm,
+	.iopl =				dummy_iopl,
 	.ptrace =			dummy_ptrace,
 	.capget =			dummy_capget,
 	.capset_check =			dummy_capset_check,
 	.capset_set =			dummy_capset_set,
 	.acct =				dummy_acct,
 	.capable =			dummy_capable,
+	.sysctl =			dummy_sysctl,
 	.sys_security =			dummy_sys_security,
+	.swapon =			dummy_swapon,
+	.swapoff =			dummy_swapoff,
 	.quotactl =			dummy_quotactl,
 	.quota_on =			dummy_quota_on,
+	.syslog =			dummy_syslog,
+	.settime =			dummy_settime,
 
 	.bprm_alloc_security =		dummy_bprm_alloc_security,
 	.bprm_free_security =		dummy_bprm_free_security,
@@ -701,6 +776,10 @@
 	.task_prctl =			dummy_task_prctl,
 	.task_kmod_set_label =		dummy_task_kmod_set_label,
 	.task_reparent_to_init =	dummy_task_reparent_to_init,
+
+	.module_create =		dummy_module_create,
+	.module_initialize =            dummy_module_initialize,
+	.module_delete =		dummy_module_delete,
 
 	.ipc_permission =		dummy_ipc_permission,
 	.ipc_getinfo =			dummy_ipc_getinfo,
