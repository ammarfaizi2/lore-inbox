Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317209AbSGSXKA>; Fri, 19 Jul 2002 19:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSGSXKA>; Fri, 19 Jul 2002 19:10:00 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:16393 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317209AbSGSXIx>;
	Fri, 19 Jul 2002 19:08:53 -0400
Date: Fri, 19 Jul 2002 16:10:18 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM task control for 2.5.26
Message-ID: <20020719231017.GC24044@kroah.com>
References: <20020719230936.GA24044@kroah.com> <20020719231000.GB24044@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719231000.GB24044@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 21 Jun 2002 22:08:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.661   -> 1.662  
#	               (new)	        -> 1.1     security/security.c
#	               (new)	        -> 1.1     include/linux/security.h
#	               (new)	        -> 1.1     security/dummy.c
#	               (new)	        -> 1.1     security/Config.in
#	               (new)	        -> 1.1     security/capability.c
#	               (new)	        -> 1.1     security/Config.help
#	               (new)	        -> 1.1     security/Makefile
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/19	greg@kroah.com	1.662
# LSM: Add all of the new security/* files for basic task control
# 
# This includes the security_* functions, and the default and capability
# modules.
# --------------------------------------------
#
diff -Nru a/include/linux/security.h b/include/linux/security.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/security.h	Fri Jul 19 16:03:50 2002
@@ -0,0 +1,383 @@
+/*
+ * Linux Security plug
+ *
+ * Copyright (C) 2001 WireX Communications, Inc <chris@wirex.com>
+ * Copyright (C) 2001 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (C) 2001 Networks Associates Technology, Inc <ssmalley@nai.com>
+ * Copyright (C) 2001 James Morris <jmorris@intercode.com.au>
+ * Copyright (C) 2001 Silicon Graphics, Inc. (Trust Technology Group)
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ *
+ *	Due to this file being licensed under the GPL there is controversy over
+ *	whether this permits you to write a module that #includes this file
+ *	without placing your module under the GPL.  Please consult a lawyer for
+ *	advice before doing this.
+ *
+ */
+
+#ifndef __LINUX_SECURITY_H
+#define __LINUX_SECURITY_H
+
+#ifdef __KERNEL__
+
+#include <linux/fs.h>
+#include <linux/binfmts.h>
+#include <linux/signal.h>
+#include <linux/resource.h>
+#include <linux/sem.h>
+#include <linux/sysctl.h>
+#include <linux/shm.h>
+#include <linux/msg.h>
+
+/*
+ * Values used in the task_security_ops calls
+ */
+/* setuid or setgid, id0 == uid or gid */
+#define LSM_SETID_ID	1
+
+/* setreuid or setregid, id0 == real, id1 == eff */
+#define LSM_SETID_RE	2
+
+/* setresuid or setresgid, id0 == real, id1 == eff, uid2 == saved */
+#define LSM_SETID_RES	4
+
+/* setfsuid or setfsgid, id0 == fsuid or fsgid */
+#define LSM_SETID_FS	8
+
+/* forward declares to avoid warnings */
+struct sk_buff;
+struct net_device;
+struct nfsctl_arg;
+struct sched_param;
+struct swap_info_struct;
+
+/**
+ * struct security_operations - main security structure
+ *
+ * Security hooks for program execution operations.
+ *
+ * @bprm_alloc_security:
+ *	Allocate and attach a security structure to the @bprm->security field.
+ *	The security field is initialized to NULL when the bprm structure is
+ *	allocated.
+ *	@bprm contains the linux_binprm structure to be modified.
+ *	Return 0 if operation was successful.
+ * @bprm_free_security:
+ *	@bprm contains the linux_binprm structure to be modified.
+ *	Deallocate and clear the @bprm->security field.
+ * @bprm_compute_creds:
+ *	Compute and set the security attributes of a process being transformed
+ *	by an execve operation based on the old attributes (current->security)
+ *	and the information saved in @bprm->security by the set_security hook.
+ *	Since this hook function (and its caller) are void, this hook can not
+ *	return an error.  However, it can leave the security attributes of the
+ *	process unchanged if an access failure occurs at this point. It can
+ *	also perform other state changes on the process (e.g.  closing open
+ *	file descriptors to which access is no longer granted if the attributes
+ *	were changed). 
+ *	@bprm contains the linux_binprm structure.
+ * @bprm_set_security:
+ *	Save security information in the bprm->security field, typically based
+ *	on information about the bprm->file, for later use by the compute_creds
+ *	hook.  This hook may also optionally check permissions (e.g. for
+ *	transitions between security domains).
+ *	This hook may be called multiple times during a single execve, e.g. for
+ *	interpreters.  The hook can tell whether it has already been called by
+ *	checking to see if @bprm->security is non-NULL.  If so, then the hook
+ *	may decide either to retain the security information saved earlier or
+ *	to replace it.
+ *	@bprm contains the linux_binprm structure.
+ *	Return 0 if the hook is successful and permission is granted.
+ * @bprm_check_security:
+ * 	This hook mediates the point when a search for a binary handler	will
+ * 	begin.  It allows a check the @bprm->security value which is set in
+ * 	the preceding set_security call.  The primary difference from
+ * 	set_security is that the argv list and envp list are reliably
+ * 	available in @bprm.  This hook may be called multiple times
+ * 	during a single execve; and in each pass set_security is called
+ * 	first.
+ * 	@bprm contains the linux_binprm structure.
+ *	Return 0 if the hook is successful and permission is granted.
+ *
+ * Security hooks for task operations.
+ *
+ * @task_create:
+ *	Check permission before creating a child process.  See the clone(2)
+ *	manual page for definitions of the @clone_flags.
+ *	@clone_flags contains the flags indicating what should be shared.
+ *	Return 0 if permission is granted.
+ * @task_alloc_security:
+ *	@p contains the task_struct for child process.
+ *	Allocate and attach a security structure to the p->security field. The
+ *	security field is initialized to NULL when the task structure is
+ *	allocated.
+ *	Return 0 if operation was successful.
+ * @task_free_security:
+ *	@p contains the task_struct for process.
+ *	Deallocate and clear the p->security field.
+ * @task_setuid:
+ *	Check permission before setting one or more of the user identity
+ *	attributes of the current process.  The @flags parameter indicates
+ *	which of the set*uid system calls invoked this hook and how to
+ *	interpret the @id0, @id1, and @id2 parameters.  See the LSM_SETID
+ *	definitions at the beginning of this file for the @flags values and
+ *	their meanings.
+ *	@id0 contains a uid.
+ *	@id1 contains a uid.
+ *	@id2 contains a uid.
+ *	@flags contains one of the LSM_SETID_* values.
+ *	Return 0 if permission is granted.
+ * @task_post_setuid:
+ *	Update the module's state after setting one or more of the user
+ *	identity attributes of the current process.  The @flags parameter
+ *	indicates which of the set*uid system calls invoked this hook.  If
+ *	@flags is LSM_SETID_FS, then @old_ruid is the old fs uid and the other
+ *	parameters are not used.
+ *	@old_ruid contains the old real uid (or fs uid if LSM_SETID_FS).
+ *	@old_euid contains the old effective uid (or -1 if LSM_SETID_FS).
+ *	@old_suid contains the old saved uid (or -1 if LSM_SETID_FS).
+ *	@flags contains one of the LSM_SETID_* values.
+ *	Return 0 on success.
+ * @task_setgid:
+ *	Check permission before setting one or more of the group identity
+ *	attributes of the current process.  The @flags parameter indicates
+ *	which of the set*gid system calls invoked this hook and how to
+ *	interpret the @id0, @id1, and @id2 parameters.  See the LSM_SETID
+ *	definitions at the beginning of this file for the @flags values and
+ *	their meanings.
+ *	@id0 contains a gid.
+ *	@id1 contains a gid.
+ *	@id2 contains a gid.
+ *	@flags contains one of the LSM_SETID_* values.
+ *	Return 0 if permission is granted.
+ * @task_setpgid:
+ *	Check permission before setting the process group identifier of the
+ *	process @p to @pgid.
+ *	@p contains the task_struct for process being modified.
+ *	@pgid contains the new pgid.
+ *	Return 0 if permission is granted.
+ * @task_getpgid:
+ *	Check permission before getting the process group identifier of the
+ *	process @p.
+ *	@p contains the task_struct for the process.
+ *	Return 0 if permission is granted.
+ * @task_getsid:
+ *	Check permission before getting the session identifier of the process
+ *	@p.
+ *	@p contains the task_struct for the process.
+ *	Return 0 if permission is granted.
+ * @task_setgroups:
+ *	Check permission before setting the supplementary group set of the
+ *	current process to @grouplist.
+ *	@gidsetsize contains the number of elements in @grouplist.
+ *	@grouplist contains the array of gids.
+ *	Return 0 if permission is granted.
+ * @task_setnice:
+ *	Check permission before setting the nice value of @p to @nice.
+ *	@p contains the task_struct of process.
+ *	@nice contains the new nice value.
+ *	Return 0 if permission is granted.
+ * @task_setrlimit:
+ *	Check permission before setting the resource limits of the current
+ *	process for @resource to @new_rlim.  The old resource limit values can
+ *	be examined by dereferencing (current->rlim + resource).
+ *	@resource contains the resource whose limit is being set.
+ *	@new_rlim contains the new limits for @resource.
+ *	Return 0 if permission is granted.
+ * @task_setscheduler:
+ *	Check permission before setting scheduling policy and/or parameters of
+ *	process @p based on @policy and @lp.
+ *	@p contains the task_struct for process.
+ *	@policy contains the scheduling policy.
+ *	@lp contains the scheduling parameters.
+ *	Return 0 if permission is granted.
+ * @task_getscheduler:
+ *	Check permission before obtaining scheduling information for process
+ *	@p.
+ *	@p contains the task_struct for process.
+ *	Return 0 if permission is granted.
+ * @task_kill:
+ *	Check permission before sending signal @sig to @p.  @info can be NULL,
+ *	the constant 1, or a pointer to a siginfo structure.  If @info is 1 or
+ *	SI_FROMKERNEL(info) is true, then the signal should be viewed as coming
+ *	from the kernel and should typically be permitted.
+ *	SIGIO signals are handled separately by the send_sigiotask hook in
+ *	file_security_ops.
+ *	@p contains the task_struct for process.
+ *	@info contains the signal information.
+ *	@sig contains the signal value.
+ *	Return 0 if permission is granted.
+ * @task_wait:
+ *	Check permission before allowing a process to reap a child process @p
+ *	and collect its status information.
+ *	@p contains the task_struct for process.
+ *	Return 0 if permission is granted.
+ * @task_prctl:
+ *	Check permission before performing a process control operation on the
+ *	current process.
+ *	@option contains the operation.
+ *	@arg2 contains a argument.
+ *	@arg3 contains a argument.
+ *	@arg4 contains a argument.
+ *	@arg5 contains a argument.
+ *	Return 0 if permission is granted.
+ * @task_kmod_set_label:
+ *	Set the security attributes in current->security for the kernel module
+ *	loader thread, so that it has the permissions needed to perform its
+ *	function.
+ * @task_reparent_to_init:
+ * 	Set the security attributes in @p->security for a kernel thread that
+ * 	is being reparented to the init task.
+ *	@p contains the task_struct for the kernel thread.
+ *
+ * @ptrace:
+ *	Check permission before allowing the @parent process to trace the
+ *	@child process.
+ *	Security modules may also want to perform a process tracing check
+ *	during an execve in the set_security or compute_creds hooks of
+ *	binprm_security_ops if the process is being traced and its security
+ *	attributes would be changed by the execve.
+ *	@parent contains the task_struct structure for parent process.
+ *	@child contains the task_struct structure for child process.
+ *	Return 0 if permission is granted.
+ * @capget:
+ *	Get the @effective, @inheritable, and @permitted capability sets for
+ *	the @target process.  The hook may also perform permission checking to
+ *	determine if the current process is allowed to see the capability sets
+ *	of the @target process.
+ *	@target contains the task_struct structure for target process.
+ *	@effective contains the effective capability set.
+ *	@inheritable contains the inheritable capability set.
+ *	@permitted contains the permitted capability set.
+ *	Return 0 if the capability sets were successfully obtained.
+ * @capset_check:
+ *	Check permission before setting the @effective, @inheritable, and
+ *	@permitted capability sets for the @target process.
+ *	Caveat:  @target is also set to current if a set of processes is
+ *	specified (i.e. all processes other than current and init or a
+ *	particular process group).  Hence, the capset_set hook may need to
+ *	revalidate permission to the actual target process.
+ *	@target contains the task_struct structure for target process.
+ *	@effective contains the effective capability set.
+ *	@inheritable contains the inheritable capability set.
+ *	@permitted contains the permitted capability set.
+ *	Return 0 if permission is granted.
+ * @capset_set:
+ *	Set the @effective, @inheritable, and @permitted capability sets for
+ *	the @target process.  Since capset_check cannot always check permission
+ *	to the real @target process, this hook may also perform permission
+ *	checking to determine if the current process is allowed to set the
+ *	capability sets of the @target process.  However, this hook has no way
+ *	of returning an error due to the structure of the sys_capset code.
+ *	@target contains the task_struct structure for target process.
+ *	@effective contains the effective capability set.
+ *	@inheritable contains the inheritable capability set.
+ *	@permitted contains the permitted capability set.
+ * @capable:
+ *	Check whether the @tsk process has the @cap capability.
+ *	@tsk contains the task_struct for the process.
+ *	@cap contains the capability <include/linux/capability.h>.
+ *	Return 0 if the capability is granted for @tsk.
+ * @sys_security:
+ *	Security modules may use this hook to implement new system calls for
+ *	security-aware applications.  The interface is similar to socketcall,
+ *	but with an @id parameter to help identify the security module whose
+ *	call is being invoked.  The module is responsible for interpreting the
+ *	parameters, and must copy in the @args array from user space if it is
+ *	used.
+ *	The recommended convention for creating the hexadecimal @id value is
+ *	echo "Name_of_module" | md5sum | cut -c -8; by using this convention,
+ *	there is no need for a central registry.
+ *	@id contains the security module identifier.
+ *	@call contains the call value.
+ *	@args contains the call arguments (user space pointer).
+ *	The module should return -ENOSYS if it does not implement any new
+ *	system calls.
+ *
+ * @register_security:
+ * 	allow module stacking.
+ * 	@name contains the name of the security module being stacked.
+ * 	@ops contains a pointer to the struct security_operations of the module to stack.
+ * @unregister_security:
+ *	remove a stacked module.
+ *	@name contains the name of the security module being unstacked.
+ *	@ops contains a pointer to the struct security_operations of the module to unstack.
+ * 
+ * This is the main security structure.
+ */
+struct security_operations {
+	int (*ptrace) (struct task_struct * parent, struct task_struct * child);
+	int (*capget) (struct task_struct * target,
+		       kernel_cap_t * effective,
+		       kernel_cap_t * inheritable, kernel_cap_t * permitted);
+	int (*capset_check) (struct task_struct * target,
+			     kernel_cap_t * effective,
+			     kernel_cap_t * inheritable,
+			     kernel_cap_t * permitted);
+	void (*capset_set) (struct task_struct * target,
+			    kernel_cap_t * effective,
+			    kernel_cap_t * inheritable,
+			    kernel_cap_t * permitted);
+	int (*capable) (struct task_struct * tsk, int cap);
+	int (*sys_security) (unsigned int id, unsigned call,
+			     unsigned long *args);
+
+	int (*bprm_alloc_security) (struct linux_binprm * bprm);
+	void (*bprm_free_security) (struct linux_binprm * bprm);
+	void (*bprm_compute_creds) (struct linux_binprm * bprm);
+	int (*bprm_set_security) (struct linux_binprm * bprm);
+	int (*bprm_check_security) (struct linux_binprm * bprm);
+
+	int (*task_create) (unsigned long clone_flags);
+	int (*task_alloc_security) (struct task_struct * p);
+	void (*task_free_security) (struct task_struct * p);
+	int (*task_setuid) (uid_t id0, uid_t id1, uid_t id2, int flags);
+	int (*task_post_setuid) (uid_t old_ruid /* or fsuid */ ,
+				 uid_t old_euid, uid_t old_suid, int flags);
+	int (*task_setgid) (gid_t id0, gid_t id1, gid_t id2, int flags);
+	int (*task_setpgid) (struct task_struct * p, pid_t pgid);
+	int (*task_getpgid) (struct task_struct * p);
+	int (*task_getsid) (struct task_struct * p);
+	int (*task_setgroups) (int gidsetsize, gid_t * grouplist);
+	int (*task_setnice) (struct task_struct * p, int nice);
+	int (*task_setrlimit) (unsigned int resource, struct rlimit * new_rlim);
+	int (*task_setscheduler) (struct task_struct * p, int policy,
+				  struct sched_param * lp);
+	int (*task_getscheduler) (struct task_struct * p);
+	int (*task_kill) (struct task_struct * p,
+			  struct siginfo * info, int sig);
+	int (*task_wait) (struct task_struct * p);
+	int (*task_prctl) (int option, unsigned long arg2,
+			   unsigned long arg3, unsigned long arg4,
+			   unsigned long arg5);
+	void (*task_kmod_set_label) (void);
+	void (*task_reparent_to_init) (struct task_struct * p);
+
+	/* allow module stacking */
+	int (*register_security) (const char *name,
+	                          struct security_operations *ops);
+	int (*unregister_security) (const char *name,
+	                            struct security_operations *ops);
+};
+
+
+/* prototypes */
+extern int security_scaffolding_startup	(void);
+extern int register_security	(struct security_operations *ops);
+extern int unregister_security	(struct security_operations *ops);
+extern int mod_reg_security	(const char *name, struct security_operations *ops);
+extern int mod_unreg_security	(const char *name, struct security_operations *ops);
+extern int capable		(int cap);
+
+/* global variables */
+extern struct security_operations *security_ops;
+
+
+#endif /* __KERNEL__ */
+
+#endif /* ! __LINUX_SECURITY_H */
+
diff -Nru a/security/Config.help b/security/Config.help
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/security/Config.help	Fri Jul 19 16:03:50 2002
@@ -0,0 +1,4 @@
+CONFIG_SECURITY_CAPABILITIES
+  This enables the "default" Linux capabilities functionality.
+  If you are unsure how to answer this question, answer Y.
+
diff -Nru a/security/Config.in b/security/Config.in
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/security/Config.in	Fri Jul 19 16:03:50 2002
@@ -0,0 +1,7 @@
+#
+# Security configuration
+#
+mainmenu_option next_comment
+comment 'Security options'
+tristate 'Capabilities Support' CONFIG_SECURITY_CAPABILITIES
+endmenu
diff -Nru a/security/Makefile b/security/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/security/Makefile	Fri Jul 19 16:03:50 2002
@@ -0,0 +1,13 @@
+#
+# Makefile for the kernel security code
+#
+
+# Objects that export symbols
+export-objs	:= security.o
+
+# Object file lists
+obj-y		:= security.o dummy.o
+
+obj-$(CONFIG_SECURITY_CAPABILITIES)	+= capability.o
+
+include $(TOPDIR)/Rules.make
diff -Nru a/security/capability.c b/security/capability.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/security/capability.c	Fri Jul 19 16:03:50 2002
@@ -0,0 +1,471 @@
+/*
+ *  Capabilities Linux Security Module
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/security.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/smp_lock.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+
+/* flag to keep track of how we were registered */
+static int secondary;
+
+static int cap_capable (struct task_struct *tsk, int cap)
+{
+	/* Derived from include/linux/sched.h:capable. */
+	if (cap_raised (tsk->cap_effective, cap))
+		return 0;
+	else
+		return -EPERM;
+}
+
+static int cap_sys_security (unsigned int id, unsigned int call,
+			     unsigned long *args)
+{
+	return -ENOSYS;
+}
+
+static int cap_ptrace (struct task_struct *parent, struct task_struct *child)
+{
+	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
+	if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&
+	    !capable (CAP_SYS_PTRACE))
+		return -EPERM;
+	else
+		return 0;
+}
+
+static int cap_capget (struct task_struct *target, kernel_cap_t * effective,
+		       kernel_cap_t * inheritable, kernel_cap_t * permitted)
+{
+	/* Derived from kernel/capability.c:sys_capget. */
+	*effective = cap_t (target->cap_effective);
+	*inheritable = cap_t (target->cap_inheritable);
+	*permitted = cap_t (target->cap_permitted);
+	return 0;
+}
+
+static int cap_capset_check (struct task_struct *target,
+			     kernel_cap_t * effective,
+			     kernel_cap_t * inheritable,
+			     kernel_cap_t * permitted)
+{
+	/* Derived from kernel/capability.c:sys_capset. */
+	/* verify restrictions on target's new Inheritable set */
+	if (!cap_issubset (*inheritable,
+			   cap_combine (target->cap_inheritable,
+					current->cap_permitted))) {
+		return -EPERM;
+	}
+
+	/* verify restrictions on target's new Permitted set */
+	if (!cap_issubset (*permitted,
+			   cap_combine (target->cap_permitted,
+					current->cap_permitted))) {
+		return -EPERM;
+	}
+
+	/* verify the _new_Effective_ is a subset of the _new_Permitted_ */
+	if (!cap_issubset (*effective, *permitted)) {
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+static void cap_capset_set (struct task_struct *target,
+			    kernel_cap_t * effective,
+			    kernel_cap_t * inheritable,
+			    kernel_cap_t * permitted)
+{
+	target->cap_effective = *effective;
+	target->cap_inheritable = *inheritable;
+	target->cap_permitted = *permitted;
+}
+
+static int cap_bprm_alloc_security (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static int cap_bprm_set_security (struct linux_binprm *bprm)
+{
+	/* Copied from fs/exec.c:prepare_binprm. */
+
+	/* We don't have VFS support for capabilities yet */
+	cap_clear (bprm->cap_inheritable);
+	cap_clear (bprm->cap_permitted);
+	cap_clear (bprm->cap_effective);
+
+	/*  To support inheritance of root-permissions and suid-root
+	 *  executables under compatibility mode, we raise all three
+	 *  capability sets for the file.
+	 *
+	 *  If only the real uid is 0, we only raise the inheritable
+	 *  and permitted sets of the executable file.
+	 */
+
+	if (!issecure (SECURE_NOROOT)) {
+		if (bprm->e_uid == 0 || current->uid == 0) {
+			cap_set_full (bprm->cap_inheritable);
+			cap_set_full (bprm->cap_permitted);
+		}
+		if (bprm->e_uid == 0)
+			cap_set_full (bprm->cap_effective);
+	}
+	return 0;
+}
+
+static int cap_bprm_check_security (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static void cap_bprm_free_security (struct linux_binprm *bprm)
+{
+	return;
+}
+
+/* Copied from fs/exec.c */
+static inline int must_not_trace_exec (struct task_struct *p)
+{
+	return (p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP);
+}
+
+static void cap_bprm_compute_creds (struct linux_binprm *bprm)
+{
+	/* Derived from fs/exec.c:compute_creds. */
+	kernel_cap_t new_permitted, working;
+	int do_unlock = 0;
+
+	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
+	working = cap_intersect (bprm->cap_inheritable,
+				 current->cap_inheritable);
+	new_permitted = cap_combine (new_permitted, working);
+
+	if (!cap_issubset (new_permitted, current->cap_permitted)) {
+		current->mm->dumpable = 0;
+
+		lock_kernel ();
+		if (must_not_trace_exec (current)
+		    || atomic_read (&current->fs->count) > 1
+		    || atomic_read (&current->files->count) > 1
+		    || atomic_read (&current->sig->count) > 1) {
+			if (!capable (CAP_SETPCAP)) {
+				new_permitted = cap_intersect (new_permitted,
+							       current->
+							       cap_permitted);
+			}
+		}
+		do_unlock = 1;
+	}
+
+	/* For init, we want to retain the capabilities set
+	 * in the init_task struct. Thus we skip the usual
+	 * capability rules */
+	if (current->pid != 1) {
+		current->cap_permitted = new_permitted;
+		current->cap_effective =
+		    cap_intersect (new_permitted, bprm->cap_effective);
+	}
+
+	/* AUD: Audit candidate if current->cap_effective is set */
+
+	if (do_unlock)
+		unlock_kernel ();
+
+	current->keep_capabilities = 0;
+}
+
+static int cap_task_create (unsigned long clone_flags)
+{
+	return 0;
+}
+
+static int cap_task_alloc_security (struct task_struct *p)
+{
+	return 0;
+}
+
+static void cap_task_free_security (struct task_struct *p)
+{
+	return;
+}
+
+static int cap_task_setuid (uid_t id0, uid_t id1, uid_t id2, int flags)
+{
+	return 0;
+}
+
+/* moved from kernel/sys.c. */
+/* 
+ * cap_emulate_setxuid() fixes the effective / permitted capabilities of
+ * a process after a call to setuid, setreuid, or setresuid.
+ *
+ *  1) When set*uiding _from_ one of {r,e,s}uid == 0 _to_ all of
+ *  {r,e,s}uid != 0, the permitted and effective capabilities are
+ *  cleared.
+ *
+ *  2) When set*uiding _from_ euid == 0 _to_ euid != 0, the effective
+ *  capabilities of the process are cleared.
+ *
+ *  3) When set*uiding _from_ euid != 0 _to_ euid == 0, the effective
+ *  capabilities are set to the permitted capabilities.
+ *
+ *  fsuid is handled elsewhere. fsuid == 0 and {r,e,s}uid!= 0 should 
+ *  never happen.
+ *
+ *  -astor 
+ *
+ * cevans - New behaviour, Oct '99
+ * A process may, via prctl(), elect to keep its capabilities when it
+ * calls setuid() and switches away from uid==0. Both permitted and
+ * effective sets will be retained.
+ * Without this change, it was impossible for a daemon to drop only some
+ * of its privilege. The call to setuid(!=0) would drop all privileges!
+ * Keeping uid 0 is not an option because uid 0 owns too many vital
+ * files..
+ * Thanks to Olaf Kirch and Peter Benie for spotting this.
+ */
+static inline void cap_emulate_setxuid (int old_ruid, int old_euid,
+					int old_suid)
+{
+	if ((old_ruid == 0 || old_euid == 0 || old_suid == 0) &&
+	    (current->uid != 0 && current->euid != 0 && current->suid != 0) &&
+	    !current->keep_capabilities) {
+		cap_clear (current->cap_permitted);
+		cap_clear (current->cap_effective);
+	}
+	if (old_euid == 0 && current->euid != 0) {
+		cap_clear (current->cap_effective);
+	}
+	if (old_euid != 0 && current->euid == 0) {
+		current->cap_effective = current->cap_permitted;
+	}
+}
+
+static int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid,
+				 int flags)
+{
+	switch (flags) {
+	case LSM_SETID_RE:
+	case LSM_SETID_ID:
+	case LSM_SETID_RES:
+		/* Copied from kernel/sys.c:setreuid/setuid/setresuid. */
+		if (!issecure (SECURE_NO_SETUID_FIXUP)) {
+			cap_emulate_setxuid (old_ruid, old_euid, old_suid);
+		}
+		break;
+	case LSM_SETID_FS:
+		{
+			uid_t old_fsuid = old_ruid;
+
+			/* Copied from kernel/sys.c:setfsuid. */
+
+			/*
+			 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
+			 *          if not, we might be a bit too harsh here.
+			 */
+
+			if (!issecure (SECURE_NO_SETUID_FIXUP)) {
+				if (old_fsuid == 0 && current->fsuid != 0) {
+					cap_t (current->cap_effective) &=
+					    ~CAP_FS_MASK;
+				}
+				if (old_fsuid != 0 && current->fsuid == 0) {
+					cap_t (current->cap_effective) |=
+					    (cap_t (current->cap_permitted) &
+					     CAP_FS_MASK);
+				}
+			}
+			break;
+		}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cap_task_setgid (gid_t id0, gid_t id1, gid_t id2, int flags)
+{
+	return 0;
+}
+
+static int cap_task_setpgid (struct task_struct *p, pid_t pgid)
+{
+	return 0;
+}
+
+static int cap_task_getpgid (struct task_struct *p)
+{
+	return 0;
+}
+
+static int cap_task_getsid (struct task_struct *p)
+{
+	return 0;
+}
+
+static int cap_task_setgroups (int gidsetsize, gid_t * grouplist)
+{
+	return 0;
+}
+
+static int cap_task_setnice (struct task_struct *p, int nice)
+{
+	return 0;
+}
+
+static int cap_task_setrlimit (unsigned int resource, struct rlimit *new_rlim)
+{
+	return 0;
+}
+
+static int cap_task_setscheduler (struct task_struct *p, int policy,
+				  struct sched_param *lp)
+{
+	return 0;
+}
+
+static int cap_task_getscheduler (struct task_struct *p)
+{
+	return 0;
+}
+
+static int cap_task_wait (struct task_struct *p)
+{
+	return 0;
+}
+
+static int cap_task_kill (struct task_struct *p, struct siginfo *info, int sig)
+{
+	return 0;
+}
+
+static int cap_task_prctl (int option, unsigned long arg2, unsigned long arg3,
+			   unsigned long arg4, unsigned long arg5)
+{
+	return 0;
+}
+
+static void cap_task_kmod_set_label (void)
+{
+	cap_set_full (current->cap_effective);
+	return;
+}
+
+static void cap_task_reparent_to_init (struct task_struct *p)
+{
+	p->cap_effective = CAP_INIT_EFF_SET;
+	p->cap_inheritable = CAP_INIT_INH_SET;
+	p->cap_permitted = CAP_FULL_SET;
+	p->keep_capabilities = 0;
+	return;
+}
+
+static int cap_register (const char *name, struct security_operations *ops)
+{
+	return -EINVAL;
+}
+
+static int cap_unregister (const char *name, struct security_operations *ops)
+{
+	return -EINVAL;
+}
+
+static struct security_operations capability_ops = {
+	ptrace:				cap_ptrace,
+	capget:				cap_capget,
+	capset_check:			cap_capset_check,
+	capset_set:			cap_capset_set,
+	capable:			cap_capable,
+	sys_security:			cap_sys_security,
+	
+	bprm_alloc_security:		cap_bprm_alloc_security,
+	bprm_free_security:		cap_bprm_free_security,
+	bprm_compute_creds:		cap_bprm_compute_creds,
+	bprm_set_security:		cap_bprm_set_security,
+	bprm_check_security:		cap_bprm_check_security,
+	
+	task_create:			cap_task_create,
+	task_alloc_security:		cap_task_alloc_security,
+	task_free_security:		cap_task_free_security,
+	task_setuid:			cap_task_setuid,
+	task_post_setuid:		cap_task_post_setuid,
+	task_setgid:			cap_task_setgid,
+	task_setpgid:			cap_task_setpgid,
+	task_getpgid:			cap_task_getpgid,
+	task_getsid:			cap_task_getsid,
+	task_setgroups:			cap_task_setgroups,
+	task_setnice:			cap_task_setnice,
+	task_setrlimit:			cap_task_setrlimit,
+	task_setscheduler:		cap_task_setscheduler,
+	task_getscheduler:		cap_task_getscheduler,
+	task_wait:			cap_task_wait,
+	task_kill:			cap_task_kill,
+	task_prctl:			cap_task_prctl,
+	task_kmod_set_label:		cap_task_kmod_set_label,
+	task_reparent_to_init:		cap_task_reparent_to_init,
+	
+	register_security:		cap_register,
+	unregister_security:		cap_unregister,
+};
+
+#if defined(CONFIG_SECURITY_CAPABILITIES_MODULE)
+#define MY_NAME THIS_MODULE->name
+#else
+#define MY_NAME "capability"
+#endif
+
+static int __init capability_init (void)
+{
+	/* register ourselves with the security framework */
+	if (register_security (&capability_ops)) {
+		printk (KERN_INFO
+			"Failure registering capabilities with the kernel\n");
+		/* try registering with primary module */
+		if (mod_reg_security (MY_NAME, &capability_ops)) {
+			printk (KERN_INFO "Failure registering capabilities "
+				"with primary security module.\n");
+			return -EINVAL;
+		}
+		secondary = 1;
+	}
+	printk (KERN_INFO "Capability LSM initialized\n");
+	return 0;
+}
+
+static void __exit capability_exit (void)
+{
+	/* remove ourselves from the security framework */
+	if (secondary) {
+		if (mod_unreg_security (MY_NAME, &capability_ops))
+			printk (KERN_INFO "Failure unregistering capabilities "
+				"with primary module.\n");
+		return;
+	}
+
+	if (unregister_security (&capability_ops)) {
+		printk (KERN_INFO
+			"Failure unregistering capabilities with the kernel\n");
+	}
+}
+
+module_init (capability_init);
+module_exit (capability_exit);
+
+MODULE_DESCRIPTION("Standard Linux Capabilities Security Module");
+MODULE_LICENSE("GPL");
diff -Nru a/security/dummy.c b/security/dummy.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/security/dummy.c	Fri Jul 19 16:03:50 2002
@@ -0,0 +1,236 @@
+/*
+ * Stub functions for the default security function pointers in case no
+ * security model is loaded.
+ *
+ * Copyright (C) 2001 WireX Communications, Inc <chris@wirex.com>
+ * Copyright (C) 2001 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (C) 2001 Networks Associates Technology, Inc <ssmalley@nai.com>
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/security.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+
+static int dummy_ptrace (struct task_struct *parent, struct task_struct *child)
+{
+	return 0;
+}
+
+static int dummy_capget (struct task_struct *target, kernel_cap_t * effective,
+			 kernel_cap_t * inheritable, kernel_cap_t * permitted)
+{
+	return 0;
+}
+
+static int dummy_capset_check (struct task_struct *target,
+			       kernel_cap_t * effective,
+			       kernel_cap_t * inheritable,
+			       kernel_cap_t * permitted)
+{
+	return 0;
+}
+
+static void dummy_capset_set (struct task_struct *target,
+			      kernel_cap_t * effective,
+			      kernel_cap_t * inheritable,
+			      kernel_cap_t * permitted)
+{
+	return;
+}
+
+static int dummy_capable (struct task_struct *tsk, int cap)
+{
+	if (cap_is_fs_cap (cap) ? tsk->fsuid == 0 : tsk->euid == 0)
+		/* capability granted */
+		return 0;
+
+	/* capability denied */
+	return -EPERM;
+}
+
+static int dummy_sys_security (unsigned int id, unsigned int call,
+			       unsigned long *args)
+{
+	return -ENOSYS;
+}
+
+static int dummy_bprm_alloc_security (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static void dummy_bprm_free_security (struct linux_binprm *bprm)
+{
+	return;
+}
+
+static void dummy_bprm_compute_creds (struct linux_binprm *bprm)
+{
+	return;
+}
+
+static int dummy_bprm_set_security (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static int dummy_bprm_check_security (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static int dummy_task_create (unsigned long clone_flags)
+{
+	return 0;
+}
+
+static int dummy_task_alloc_security (struct task_struct *p)
+{
+	return 0;
+}
+
+static void dummy_task_free_security (struct task_struct *p)
+{
+	return;
+}
+
+static int dummy_task_setuid (uid_t id0, uid_t id1, uid_t id2, int flags)
+{
+	return 0;
+}
+
+static int dummy_task_post_setuid (uid_t id0, uid_t id1, uid_t id2, int flags)
+{
+	return 0;
+}
+
+static int dummy_task_setgid (gid_t id0, gid_t id1, gid_t id2, int flags)
+{
+	return 0;
+}
+
+static int dummy_task_setpgid (struct task_struct *p, pid_t pgid)
+{
+	return 0;
+}
+
+static int dummy_task_getpgid (struct task_struct *p)
+{
+	return 0;
+}
+
+static int dummy_task_getsid (struct task_struct *p)
+{
+	return 0;
+}
+
+static int dummy_task_setgroups (int gidsetsize, gid_t * grouplist)
+{
+	return 0;
+}
+
+static int dummy_task_setnice (struct task_struct *p, int nice)
+{
+	return 0;
+}
+
+static int dummy_task_setrlimit (unsigned int resource, struct rlimit *new_rlim)
+{
+	return 0;
+}
+
+static int dummy_task_setscheduler (struct task_struct *p, int policy,
+				    struct sched_param *lp)
+{
+	return 0;
+}
+
+static int dummy_task_getscheduler (struct task_struct *p)
+{
+	return 0;
+}
+
+static int dummy_task_wait (struct task_struct *p)
+{
+	return 0;
+}
+
+static int dummy_task_kill (struct task_struct *p, struct siginfo *info,
+			    int sig)
+{
+	return 0;
+}
+
+static int dummy_task_prctl (int option, unsigned long arg2, unsigned long arg3,
+			     unsigned long arg4, unsigned long arg5)
+{
+	return 0;
+}
+
+static void dummy_task_kmod_set_label (void)
+{
+	return;
+}
+
+static void dummy_task_reparent_to_init (struct task_struct *p)
+{
+	p->euid = p->fsuid = 0;
+	return;
+}
+
+static int dummy_register (const char *name, struct security_operations *ops)
+{
+	return -EINVAL;
+}
+
+static int dummy_unregister (const char *name, struct security_operations *ops)
+{
+	return -EINVAL;
+}
+
+struct security_operations dummy_security_ops = {
+	ptrace:				dummy_ptrace,
+	capget:				dummy_capget,
+	capset_check:			dummy_capset_check,
+	capset_set:			dummy_capset_set,
+	capable:			dummy_capable,
+	sys_security:			dummy_sys_security,
+	
+	bprm_alloc_security:		dummy_bprm_alloc_security,
+	bprm_free_security:		dummy_bprm_free_security,
+	bprm_compute_creds:		dummy_bprm_compute_creds,
+	bprm_set_security:		dummy_bprm_set_security,
+	bprm_check_security:		dummy_bprm_check_security,
+
+	task_create:			dummy_task_create,
+	task_alloc_security:		dummy_task_alloc_security,
+	task_free_security:		dummy_task_free_security,
+	task_setuid:			dummy_task_setuid,
+	task_post_setuid:		dummy_task_post_setuid,
+	task_setgid:			dummy_task_setgid,
+	task_setpgid:			dummy_task_setpgid,
+	task_getpgid:			dummy_task_getpgid,
+	task_getsid:			dummy_task_getsid,
+	task_setgroups:			dummy_task_setgroups,
+	task_setnice:			dummy_task_setnice,
+	task_setrlimit:			dummy_task_setrlimit,
+	task_setscheduler:		dummy_task_setscheduler,
+	task_getscheduler:		dummy_task_getscheduler,
+	task_wait:			dummy_task_wait,
+	task_kill:			dummy_task_kill,
+	task_prctl:			dummy_task_prctl,
+	task_kmod_set_label:		dummy_task_kmod_set_label,
+	task_reparent_to_init:		dummy_task_reparent_to_init,
+	
+	register_security:		dummy_register,
+	unregister_security:		dummy_unregister,
+};
+
diff -Nru a/security/security.c b/security/security.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/security/security.c	Fri Jul 19 16:03:50 2002
@@ -0,0 +1,249 @@
+/*
+ * Security plug functions
+ *
+ * Copyright (C) 2001 WireX Communications, Inc <chris@wirex.com>
+ * Copyright (C) 2001 Greg Kroah-Hartman <greg@kroah.com>
+ * Copyright (C) 2001 Networks Associates Technology, Inc <ssmalley@nai.com>
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation; either version 2 of the License, or
+ *	(at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/security.h>
+
+#define SECURITY_SCAFFOLD_VERSION	"1.0.0"
+
+extern struct security_operations dummy_security_ops;	/* lives in dummy.c */
+
+struct security_operations *security_ops;	/* Initialized to NULL */
+
+/* This macro checks that all pointers in a struct are non-NULL.  It 
+ * can be fooled by struct padding for object tile alignment and when
+ * pointers to data and pointers to functions aren't the same size.
+ * Yes it's ugly, we'll replace it if it becomes a problem.
+ */
+#define VERIFY_STRUCT(struct_type, s, e) \
+	do { \
+		unsigned long * __start = (unsigned long *)(s); \
+		unsigned long * __end = __start + \
+				sizeof(struct_type)/sizeof(unsigned long *); \
+		while (__start != __end) { \
+			if (!*__start) { \
+				printk(KERN_INFO "%s is missing something\n",\
+					#struct_type); \
+				e++; \
+				break; \
+			} \
+			__start++; \
+		} \
+	} while (0)
+
+static int inline verify (struct security_operations *ops)
+{
+	int err;
+
+	/* verify the security_operations structure exists */
+	if (!ops) {
+		printk (KERN_INFO "Passed a NULL security_operations "
+			"pointer, " __FUNCTION__ " failed.\n");
+		return -EINVAL;
+	}
+
+	/* Perform a little sanity checking on our inputs */
+	err = 0;
+
+	/* This first check scans the whole security_ops struct for
+	 * missing structs or functions.
+	 *
+	 * (There is no further check now, but will leave as is until
+	 *  the lazy registration stuff is done -- JM).
+	 */
+	VERIFY_STRUCT(struct security_operations, ops, err);
+
+	if (err) {
+		printk (KERN_INFO "Not enough functions specified in the "
+			"security_operation structure, " __FUNCTION__
+			" failed.\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/**
+ * security_scaffolding_startup - initialzes the security scaffolding framework
+ *
+ * This should be called early in the kernel initialization sequence.
+ */
+int security_scaffolding_startup (void)
+{
+	printk (KERN_INFO "Security Scaffold v" SECURITY_SCAFFOLD_VERSION
+		" initialized\n");
+
+	security_ops = &dummy_security_ops;
+
+	return 0;
+}
+
+/**
+ * register_security - registers a security framework with the kernel
+ * @ops: a pointer to the struct security_options that is to be registered
+ *
+ * This function is to allow a security module to register itself with the
+ * kernel security subsystem.  Some rudimentary checking is done on the @ops
+ * value passed to this function.  A call to unregister_security() should be
+ * done to remove this security_options structure from the kernel.
+ *
+ * If the @ops structure does not contain function pointers for all hooks in
+ * the structure, or there is already a security module registered with the
+ * kernel, an error will be returned.  Otherwise 0 is returned on success.
+ */
+int register_security (struct security_operations *ops)
+{
+
+	if (verify (ops)) {
+		printk (KERN_INFO __FUNCTION__ " could not verify "
+			"security_operations structure.\n");
+		return -EINVAL;
+	}
+	if (security_ops != &dummy_security_ops) {
+		printk (KERN_INFO "There is already a security "
+			"framework initialized, " __FUNCTION__ " failed.\n");
+		return -EINVAL;
+	}
+
+	security_ops = ops;
+
+	return 0;
+}
+
+/**
+ * unregister_security - unregisters a security framework with the kernel
+ * @ops: a pointer to the struct security_options that is to be registered
+ *
+ * This function removes a struct security_operations variable that had
+ * previously been registered with a successful call to register_security().
+ *
+ * If @ops does not match the valued previously passed to register_security()
+ * an error is returned.  Otherwise the default security options is set to the
+ * the dummy_security_ops structure, and 0 is returned.
+ */
+int unregister_security (struct security_operations *ops)
+{
+	if (ops != security_ops) {
+		printk (KERN_INFO __FUNCTION__ ": trying to unregister "
+			"a security_opts structure that is not "
+			"registered, failing.\n");
+		return -EINVAL;
+	}
+
+	security_ops = &dummy_security_ops;
+
+	return 0;
+}
+
+/**
+ * mod_reg_security - allows security modules to be "stacked"
+ * @name: a pointer to a string with the name of the security_options to be registered
+ * @ops: a pointer to the struct security_options that is to be registered
+ *
+ * This function allows security modules to be stacked if the currently loaded
+ * security module allows this to happen.  It passes the @name and @ops to the
+ * register_security function of the currently loaded security module.
+ *
+ * The return value depends on the currently loaded security module, with 0 as
+ * success.
+ */
+int mod_reg_security (const char *name, struct security_operations *ops)
+{
+	if (verify (ops)) {
+		printk (KERN_INFO __FUNCTION__ " could not verify "
+			"security operations.\n");
+		return -EINVAL;
+	}
+
+	if (ops == security_ops) {
+		printk (KERN_INFO __FUNCTION__ " security operations "
+			"already registered.\n");
+		return -EINVAL;
+	}
+
+	return security_ops->register_security (name, ops);
+}
+
+/**
+ * mod_unreg_security - allows a security module registered with mod_reg_security() to be unloaded
+ * @name: a pointer to a string with the name of the security_options to be removed
+ * @ops: a pointer to the struct security_options that is to be removed
+ *
+ * This function allows security modules that have been successfully registered
+ * with a call to mod_reg_security() to be unloaded from the system.
+ * This calls the currently loaded security module's unregister_security() call
+ * with the @name and @ops variables.
+ *
+ * The return value depends on the currently loaded security module, with 0 as
+ * success.
+ */
+int mod_unreg_security (const char *name, struct security_operations *ops)
+{
+	if (ops == security_ops) {
+		printk (KERN_INFO __FUNCTION__ " invalid attempt to unregister "
+			" primary security ops.\n");
+		return -EINVAL;
+	}
+
+	return security_ops->unregister_security (name, ops);
+}
+
+/**
+ * capable - calls the currently loaded security module's capable() function with the specified capability
+ * @cap: the requested capability level.
+ *
+ * This function calls the currently loaded security module's cabable()
+ * function with a pointer to the current task and the specified @cap value.
+ *
+ * This allows the security module to implement the capable function call
+ * however it chooses to.
+ */
+int capable (int cap)
+{
+	if (security_ops->capable (current, cap)) {
+		/* capability denied */
+		return 0;
+	}
+
+	/* capability granted */
+	current->flags |= PF_SUPERPRIV;
+	return 1;
+}
+
+/**
+ * sys_security - security syscall multiplexor.
+ * @id: module id
+ * @call: call identifier
+ * @args: arg list for call
+ *
+ * Similar to sys_socketcall.  Can use id to help identify which module user
+ * app is talking to.  The recommended convention for creating the
+ * hexadecimal id value is:
+ * 'echo "Name_of_module" | md5sum | cut -c -8'.
+ * By following this convention, there's no need for a central registry.
+ */
+asmlinkage long sys_security (unsigned int id, unsigned int call,
+			      unsigned long *args)
+{
+	return security_ops->sys_security (id, call, args);
+}
+
+EXPORT_SYMBOL (register_security);
+EXPORT_SYMBOL (unregister_security);
+EXPORT_SYMBOL (mod_reg_security);
+EXPORT_SYMBOL (mod_unreg_security);
+EXPORT_SYMBOL (capable);
+EXPORT_SYMBOL (security_ops);
