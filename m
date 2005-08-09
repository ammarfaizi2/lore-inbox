Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbVHIF0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVHIF0X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 01:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVHIF0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 01:26:23 -0400
Received: from nef2.ens.fr ([129.199.96.40]:51718 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1750946AbVHIF0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 01:26:22 -0400
Date: Tue, 9 Aug 2005 07:26:21 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: capabilities patch (v 0.1)
Message-ID: <20050809052621.GA7970@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Tue, 09 Aug 2005 07:26:21 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I wasn't sleepy tonight, so I produced the following patch for
Linux capabilities, which attempts to make them useful.  It is
supposed to do the following (which may or may not conform with the
POSIX semantics, I don't think it matters much):

* First, and most importantly, capabilities are carried across
execve().  More precisely, on execve(), the inheritable set of the
process (which is always a subset of the permitted set) is copied to
the permitted set, and ANDed on the effective set; except when a suid
root binary is executed, in which case the permitted, inheritable and
effective sets are fully set.

* Second, a much more extensive change, the patch introduces a third
set of capabilities for every process, the "bounding" set.  Normally
the bounding set has every capability in it.  If a capability is
removed from it, that means the process is never allowed to gain it on
exec.  In the current state of affairs, since the only way of gaining
capabilities is through suid root programs, the bounding set is
essentially an all-or-nothing affair: if you do not have every
capability in your bounding set, you may not run a suid root program
(execve() will fail with EPERM).  This can still be very useful on
untrusted programs.

This patch hasn't been tested very much; in fact, it has been hardly
tested at all (I just ran the kernel in a qemu and made a few basic
checks).  Since it adds a whole new set of capabilities to every
process, it also requires a specially modified version of libcap (the
one I have right now is pretty buggy, so I'm not posting the patch
here).

Consider this more a "proof of concept" than a serious patch, but I'm
interested in any comments.

### cut after ###
--- linux-2.6.12.4/fs/proc/array.c	2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4.caps/fs/proc/array.c	2005-08-09 01:32:07.000000000 +0200
@@ -281,10 +281,12 @@ static inline char *task_cap(struct task
 {
     return buffer + sprintf(buffer, "CapInh:\t%016x\n"
 			    "CapPrm:\t%016x\n"
-			    "CapEff:\t%016x\n",
+			    "CapEff:\t%016x\n"
+			    "CapBnd:\t%016x\n",
 			    cap_t(p->cap_inheritable),
 			    cap_t(p->cap_permitted),
-			    cap_t(p->cap_effective));
+			    cap_t(p->cap_effective),
+			    cap_t(p->cap_bounding));
 }
 
 int proc_pid_status(struct task_struct *task, char * buffer)
--- linux-2.6.12.4/include/linux/binfmts.h	2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4.caps/include/linux/binfmts.h	2005-08-09 01:41:03.000000000 +0200
@@ -28,7 +28,7 @@ struct linux_binprm{
 	int sh_bang;
 	struct file * file;
 	int e_uid, e_gid;
-	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
+	kernel_cap_t cap_inheritable, cap_permitted, cap_effective, cap_bounding;
 	void *security;
 	int argc, envc;
 	char * filename;	/* Name of binary as seen by procps */
--- linux-2.6.12.4/include/linux/capability.h	2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4.caps/include/linux/capability.h	2005-08-09 03:14:36.000000000 +0200
@@ -27,7 +27,7 @@
    library since the draft standard requires the use of malloc/free
    etc.. */
  
-#define _LINUX_CAPABILITY_VERSION  0x19980330
+#define _LINUX_CAPABILITY_VERSION  0x20050809
 
 typedef struct __user_cap_header_struct {
 	__u32 version;
@@ -38,6 +38,7 @@ typedef struct __user_cap_data_struct {
         __u32 effective;
         __u32 permitted;
         __u32 inheritable;
+        __u32 bounding;
 } __user *cap_user_data_t;
   
 #ifdef __KERNEL__
@@ -311,7 +312,7 @@ extern kernel_cap_t cap_bset;
 #define CAP_EMPTY_SET       to_cap_t(0)
 #define CAP_FULL_SET        to_cap_t(~0)
 #define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
-#define CAP_INIT_INH_SET    to_cap_t(0)
+#define CAP_INIT_INH_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
 
 #define CAP_TO_MASK(x) (1 << (x))
 #define cap_raise(c, flag)   (cap_t(c) |=  CAP_TO_MASK(flag))
--- linux-2.6.12.4/include/linux/init_task.h	2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4.caps/include/linux/init_task.h	2005-08-09 05:19:32.000000000 +0200
@@ -94,6 +94,7 @@ extern struct group_info init_groups;
 	.cap_effective	= CAP_INIT_EFF_SET,				\
 	.cap_inheritable = CAP_INIT_INH_SET,				\
 	.cap_permitted	= CAP_FULL_SET,					\
+	.cap_bounding	= CAP_FULL_SET,					\
 	.keep_capabilities = 0,						\
 	.user		= INIT_USER,					\
 	.comm		= "swapper",					\
--- linux-2.6.12.4/include/linux/sched.h	2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4.caps/include/linux/sched.h	2005-08-09 01:15:27.000000000 +0200
@@ -654,7 +654,7 @@ struct task_struct {
 	uid_t uid,euid,suid,fsuid;
 	gid_t gid,egid,sgid,fsgid;
 	struct group_info *group_info;
-	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
+	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted, cap_bounding;
 	unsigned keep_capabilities:1;
 	struct user_struct *user;
 #ifdef CONFIG_KEYS
--- linux-2.6.12.4/include/linux/security.h	2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4.caps/include/linux/security.h	2005-08-09 03:21:55.000000000 +0200
@@ -40,9 +40,9 @@ struct ctl_table;
 extern int cap_capable (struct task_struct *tsk, int cap);
 extern int cap_settime (struct timespec *ts, struct timezone *tz);
 extern int cap_ptrace (struct task_struct *parent, struct task_struct *child);
-extern int cap_capget (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
-extern int cap_capset_check (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
-extern void cap_capset_set (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
+extern int cap_capget (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted, kernel_cap_t *bounding);
+extern int cap_capset_check (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted, kernel_cap_t *bounding);
+extern void cap_capset_set (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted, kernel_cap_t *bounding);
 extern int cap_bprm_set_security (struct linux_binprm *bprm);
 extern void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe);
 extern int cap_bprm_secureexec(struct linux_binprm *bprm);
@@ -948,7 +948,7 @@ struct swap_info_struct;
  *	@child contains the task_struct structure for child process.
  *	Return 0 if permission is granted.
  * @capget:
- *	Get the @effective, @inheritable, and @permitted capability sets for
+ *	Get the @effective, @inheritable, @permitted and @bounding capability sets for
  *	the @target process.  The hook may also perform permission checking to
  *	determine if the current process is allowed to see the capability sets
  *	of the @target process.
@@ -956,10 +956,11 @@ struct swap_info_struct;
  *	@effective contains the effective capability set.
  *	@inheritable contains the inheritable capability set.
  *	@permitted contains the permitted capability set.
+ *	@bounding contains the bounding capability set.
  *	Return 0 if the capability sets were successfully obtained.
  * @capset_check:
- *	Check permission before setting the @effective, @inheritable, and
- *	@permitted capability sets for the @target process.
+ *	Check permission before setting the @effective, @inheritable,
+ *	@permitted and @bounding capability sets for the @target process.
  *	Caveat:  @target is also set to current if a set of processes is
  *	specified (i.e. all processes other than current and init or a
  *	particular process group).  Hence, the capset_set hook may need to
@@ -968,9 +969,10 @@ struct swap_info_struct;
  *	@effective contains the effective capability set.
  *	@inheritable contains the inheritable capability set.
  *	@permitted contains the permitted capability set.
+ *	@bounding contains the bounding capability set.
  *	Return 0 if permission is granted.
  * @capset_set:
- *	Set the @effective, @inheritable, and @permitted capability sets for
+ *	Set the @effective, @inheritable, @permitted and @bounding capability sets for
  *	the @target process.  Since capset_check cannot always check permission
  *	to the real @target process, this hook may also perform permission
  *	checking to determine if the current process is allowed to set the
@@ -980,6 +982,7 @@ struct swap_info_struct;
  *	@effective contains the effective capability set.
  *	@inheritable contains the inheritable capability set.
  *	@permitted contains the permitted capability set.
+ *	@bounding contains the bounding capability set.
  * @acct:
  *	Check permission before enabling or disabling process accounting.  If
  *	accounting is being enabled, then @file refers to the open file used to
@@ -1030,15 +1033,18 @@ struct security_operations {
 	int (*ptrace) (struct task_struct * parent, struct task_struct * child);
 	int (*capget) (struct task_struct * target,
 		       kernel_cap_t * effective,
-		       kernel_cap_t * inheritable, kernel_cap_t * permitted);
+		       kernel_cap_t * inheritable, kernel_cap_t * permitted,
+		       kernel_cap_t * bounding);
 	int (*capset_check) (struct task_struct * target,
 			     kernel_cap_t * effective,
 			     kernel_cap_t * inheritable,
-			     kernel_cap_t * permitted);
+			     kernel_cap_t * permitted,
+			     kernel_cap_t * bounding);
 	void (*capset_set) (struct task_struct * target,
 			    kernel_cap_t * effective,
 			    kernel_cap_t * inheritable,
-			    kernel_cap_t * permitted);
+			    kernel_cap_t * permitted,
+			    kernel_cap_t * bounding);
 	int (*acct) (struct file * file);
 	int (*sysctl) (struct ctl_table * table, int op);
 	int (*capable) (struct task_struct * tsk, int cap);
@@ -1257,25 +1263,28 @@ static inline int security_ptrace (struc
 static inline int security_capget (struct task_struct *target,
 				   kernel_cap_t *effective,
 				   kernel_cap_t *inheritable,
-				   kernel_cap_t *permitted)
+				   kernel_cap_t *permitted,
+				   kernel_cap_t *bounding)
 {
-	return security_ops->capget (target, effective, inheritable, permitted);
+	return security_ops->capget (target, effective, inheritable, permitted, bounding);
 }
 
 static inline int security_capset_check (struct task_struct *target,
 					 kernel_cap_t *effective,
 					 kernel_cap_t *inheritable,
-					 kernel_cap_t *permitted)
+					 kernel_cap_t *permitted,
+					 kernel_cap_t *bounding)
 {
-	return security_ops->capset_check (target, effective, inheritable, permitted);
+	return security_ops->capset_check (target, effective, inheritable, permitted, bounding);
 }
 
 static inline void security_capset_set (struct task_struct *target,
 					kernel_cap_t *effective,
 					kernel_cap_t *inheritable,
-					kernel_cap_t *permitted)
+					kernel_cap_t *permitted,
+					kernel_cap_t *bounding)
 {
-	security_ops->capset_set (target, effective, inheritable, permitted);
+	security_ops->capset_set (target, effective, inheritable, permitted, bounding);
 }
 
 static inline int security_acct (struct file *file)
@@ -2005,25 +2014,28 @@ static inline int security_ptrace (struc
 static inline int security_capget (struct task_struct *target,
 				   kernel_cap_t *effective,
 				   kernel_cap_t *inheritable,
-				   kernel_cap_t *permitted)
+				   kernel_cap_t *permitted,
+				   kernel_cap_t *bounding)
 {
-	return cap_capget (target, effective, inheritable, permitted);
+	return cap_capget (target, effective, inheritable, permitted, bounding);
 }
 
 static inline int security_capset_check (struct task_struct *target,
 					 kernel_cap_t *effective,
 					 kernel_cap_t *inheritable,
-					 kernel_cap_t *permitted)
+					 kernel_cap_t *permitted,
+					 kernel_cap_t *bounding)
 {
-	return cap_capset_check (target, effective, inheritable, permitted);
+	return cap_capset_check (target, effective, inheritable, permitted, bounding);
 }
 
 static inline void security_capset_set (struct task_struct *target,
 					kernel_cap_t *effective,
 					kernel_cap_t *inheritable,
-					kernel_cap_t *permitted)
+					kernel_cap_t *permitted,
+					kernel_cap_t *bounding)
 {
-	cap_capset_set (target, effective, inheritable, permitted);
+	cap_capset_set (target, effective, inheritable, permitted, bounding);
 }
 
 static inline int security_acct (struct file *file)
--- linux-2.6.12.4/kernel/capability.c	2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4.caps/kernel/capability.c	2005-08-09 03:29:13.000000000 +0200
@@ -14,7 +14,7 @@
 #include <asm/uaccess.h>
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
-kernel_cap_t cap_bset = CAP_INIT_EFF_SET;
+kernel_cap_t cap_bset = CAP_INIT_INH_SET;
 
 EXPORT_SYMBOL(securebits);
 EXPORT_SYMBOL(cap_bset);
@@ -69,7 +69,7 @@ asmlinkage long sys_capget(cap_user_head
      } else
 	     target = current;
 
-     ret = security_capget(target, &data.effective, &data.inheritable, &data.permitted);
+     ret = security_capget(target, &data.effective, &data.inheritable, &data.permitted, &data.bounding);
 
 out:
      read_unlock(&tasklist_lock); 
@@ -87,7 +87,8 @@ out:
  */
 static inline int cap_set_pg(int pgrp, kernel_cap_t *effective,
 			      kernel_cap_t *inheritable,
-			      kernel_cap_t *permitted)
+			      kernel_cap_t *permitted,
+			      kernel_cap_t *bounding)
 {
 	task_t *g, *target;
 	int ret = -EPERM;
@@ -98,10 +99,12 @@ static inline int cap_set_pg(int pgrp, k
 		while_each_thread(g, target) {
 			if (!security_capset_check(target, effective,
 							inheritable,
-							permitted)) {
+							permitted,
+							bounding)) {
 				security_capset_set(target, effective,
 							inheritable,
-							permitted);
+							permitted,
+							bounding);
 				ret = 0;
 			}
 			found = 1;
@@ -119,7 +122,8 @@ static inline int cap_set_pg(int pgrp, k
  */
 static inline int cap_set_all(kernel_cap_t *effective,
 			       kernel_cap_t *inheritable,
-			       kernel_cap_t *permitted)
+			       kernel_cap_t *permitted,
+			       kernel_cap_t *bounding)
 {
      task_t *g, *target;
      int ret = -EPERM;
@@ -130,10 +134,10 @@ static inline int cap_set_all(kernel_cap
                      continue;
              found = 1;
 	     if (security_capset_check(target, effective, inheritable,
-						permitted))
+						permitted, bounding))
 		     continue;
 	     ret = 0;
-	     security_capset_set(target, effective, inheritable, permitted);
+	     security_capset_set(target, effective, inheritable, permitted, bounding);
      } while_each_thread(g, target);
 
      if (!found)
@@ -155,7 +159,7 @@ static inline int cap_set_all(kernel_cap
  */
 asmlinkage long sys_capset(cap_user_header_t header, const cap_user_data_t data)
 {
-     kernel_cap_t inheritable, permitted, effective;
+     kernel_cap_t inheritable, permitted, effective, bounding;
      __u32 version;
      task_t *target;
      int ret;
@@ -178,7 +182,8 @@ asmlinkage long sys_capset(cap_user_head
 
      if (copy_from_user(&effective, &data->effective, sizeof(effective)) ||
 	 copy_from_user(&inheritable, &data->inheritable, sizeof(inheritable)) ||
-	 copy_from_user(&permitted, &data->permitted, sizeof(permitted)))
+	 copy_from_user(&permitted, &data->permitted, sizeof(permitted)) ||
+	 copy_from_user(&bounding, &data->bounding, sizeof(bounding)))
 	     return -EFAULT; 
 
      spin_lock(&task_capability_lock);
@@ -199,17 +204,20 @@ asmlinkage long sys_capset(cap_user_head
            we now put them into effect. */
      if (pid < 0) {
              if (pid == -1)  /* all procs other than current and init */
-                     ret = cap_set_all(&effective, &inheritable, &permitted);
+                     ret = cap_set_all(&effective, &inheritable, &permitted, &bounding);
 
              else            /* all procs in process group */
                      ret = cap_set_pg(-pid, &effective, &inheritable,
-		     					&permitted);
+		     					&permitted,
+		     					&bounding);
      } else {
 	     ret = security_capset_check(target, &effective, &inheritable,
-	     						&permitted);
+	     						&permitted,
+	     						&bounding);
 	     if (!ret)
 		     security_capset_set(target, &effective, &inheritable,
-		     					&permitted);
+		     					&permitted,
+		     					&bounding);
      }
 
 out:
--- linux-2.6.12.4/security/commoncap.c	2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4.caps/security/commoncap.c	2005-08-09 05:39:54.000000000 +0200
@@ -66,18 +66,23 @@ int cap_ptrace (struct task_struct *pare
 }
 
 int cap_capget (struct task_struct *target, kernel_cap_t *effective,
-		kernel_cap_t *inheritable, kernel_cap_t *permitted)
+		kernel_cap_t *inheritable, kernel_cap_t *permitted,
+		kernel_cap_t *bounding)
 {
 	/* Derived from kernel/capability.c:sys_capget. */
 	*effective = cap_t (target->cap_effective);
 	*inheritable = cap_t (target->cap_inheritable);
 	*permitted = cap_t (target->cap_permitted);
+	*bounding = cap_t (target->cap_bounding);
 	return 0;
 }
 
 int cap_capset_check (struct task_struct *target, kernel_cap_t *effective,
-		      kernel_cap_t *inheritable, kernel_cap_t *permitted)
+		      kernel_cap_t *inheritable, kernel_cap_t *permitted,
+		      kernel_cap_t *bounding)
 {
+	/* FIXME - Is this correct if target != current ??? */
+
 	/* Derived from kernel/capability.c:sys_capset. */
 	/* verify restrictions on target's new Inheritable set */
 	if (!cap_issubset (*inheritable,
@@ -93,20 +98,37 @@ int cap_capset_check (struct task_struct
 		return -EPERM;
 	}
 
+	/* verify the _new_Inheritable_ is a subset of the _new_Permitted_ */
+	if (!cap_issubset (*inheritable, *permitted)) {
+		return -EPERM;
+	}
+
 	/* verify the _new_Effective_ is a subset of the _new_Permitted_ */
 	if (!cap_issubset (*effective, *permitted)) {
 		return -EPERM;
 	}
 
+	/* verify restrictions on target's new Bounding set */
+	if (!cap_issubset (*bounding, target->cap_bounding)) {
+		return -EPERM;
+	}
+
+	/* verify the _new_Inheritable_ is a subset of the _new_Bounding_ */
+	if (!cap_issubset (*inheritable, *bounding)) {
+		return -EPERM;
+	}
+
 	return 0;
 }
 
 void cap_capset_set (struct task_struct *target, kernel_cap_t *effective,
-		     kernel_cap_t *inheritable, kernel_cap_t *permitted)
+		     kernel_cap_t *inheritable, kernel_cap_t *permitted,
+		     kernel_cap_t *bounding)
 {
 	target->cap_effective = *effective;
 	target->cap_inheritable = *inheritable;
 	target->cap_permitted = *permitted;
+	target->cap_bounding = *bounding;
 }
 
 int cap_bprm_set_security (struct linux_binprm *bprm)
@@ -114,25 +136,24 @@ int cap_bprm_set_security (struct linux_
 	/* Copied from fs/exec.c:prepare_binprm. */
 
 	/* We don't have VFS support for capabilities yet */
-	cap_clear (bprm->cap_inheritable);
-	cap_clear (bprm->cap_permitted);
-	cap_clear (bprm->cap_effective);
+	bprm->cap_inheritable = current->cap_inheritable;
+	bprm->cap_permitted = current->cap_inheritable;
+	bprm->cap_effective = cap_intersect (current->cap_inheritable, current->cap_effective);
+	bprm->cap_bounding = current->cap_bounding;
 
 	/*  To support inheritance of root-permissions and suid-root
 	 *  executables under compatibility mode, we raise all three
 	 *  capability sets for the file.
-	 *
-	 *  If only the real uid is 0, we only raise the inheritable
-	 *  and permitted sets of the executable file.
 	 */
 
 	if (!issecure (SECURE_NOROOT)) {
-		if (bprm->e_uid == 0 || current->uid == 0) {
-			cap_set_full (bprm->cap_inheritable);
-			cap_set_full (bprm->cap_permitted);
+		if (bprm->e_uid == 0 && current->euid != 0) {
+			if (!cap_issubset(cap_bset, bprm->cap_bounding))
+				return -EPERM;
+			bprm->cap_inheritable = cap_bset;
+			bprm->cap_permitted = cap_bset;
+			bprm->cap_effective = cap_bset;
 		}
-		if (bprm->e_uid == 0)
-			cap_set_full (bprm->cap_effective);
 	}
 	return 0;
 }
@@ -140,15 +161,14 @@ int cap_bprm_set_security (struct linux_
 void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
 {
 	/* Derived from fs/exec.c:compute_creds. */
-	kernel_cap_t new_permitted, working;
+	kernel_cap_t new_permitted, new_inheritable;
 
-	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
-	working = cap_intersect (bprm->cap_inheritable,
-				 current->cap_inheritable);
-	new_permitted = cap_combine (new_permitted, working);
+	new_permitted = bprm->cap_permitted;
+	new_inheritable = bprm->cap_inheritable;
 
 	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
-	    !cap_issubset (new_permitted, current->cap_permitted)) {
+	    !cap_issubset (new_permitted, current->cap_permitted) ||
+	    !cap_issubset (new_inheritable, current->cap_inheritable)) {
 		current->mm->dumpable = 0;
 
 		if (unsafe & ~LSM_UNSAFE_PTRACE_CAP) {
@@ -159,6 +179,8 @@ void cap_bprm_apply_creds (struct linux_
 			if (!capable (CAP_SETPCAP)) {
 				new_permitted = cap_intersect (new_permitted,
 							current->cap_permitted);
+				new_inheritable = cap_intersect (new_inheritable,
+							current->cap_inheritable);
 			}
 		}
 	}
@@ -166,14 +188,10 @@ void cap_bprm_apply_creds (struct linux_
 	current->suid = current->euid = current->fsuid = bprm->e_uid;
 	current->sgid = current->egid = current->fsgid = bprm->e_gid;
 
-	/* For init, we want to retain the capabilities set
-	 * in the init_task struct. Thus we skip the usual
-	 * capability rules */
-	if (current->pid != 1) {
-		current->cap_permitted = new_permitted;
-		current->cap_effective =
-		    cap_intersect (new_permitted, bprm->cap_effective);
-	}
+	current->cap_permitted = new_permitted;
+	current->cap_inheritable = new_inheritable;
+	current->cap_effective = cap_intersect (new_permitted, bprm->cap_effective);
+	current->cap_bounding = bprm->cap_bounding;
 
 	/* AUD: Audit candidate if current->cap_effective is set */
 
@@ -248,6 +266,7 @@ static inline void cap_emulate_setxuid (
 	    !current->keep_capabilities) {
 		cap_clear (current->cap_permitted);
 		cap_clear (current->cap_effective);
+		cap_clear (current->cap_inheritable);
 	}
 	if (old_euid == 0 && current->euid != 0) {
 		cap_clear (current->cap_effective);
--- linux-2.6.12.4/security/dummy.c	2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4.caps/security/dummy.c	2005-08-09 05:40:55.000000000 +0200
@@ -35,17 +35,21 @@ static int dummy_ptrace (struct task_str
 }
 
 static int dummy_capget (struct task_struct *target, kernel_cap_t * effective,
-			 kernel_cap_t * inheritable, kernel_cap_t * permitted)
+			 kernel_cap_t * inheritable, kernel_cap_t * permitted,
+			 kernel_cap_t * bounding)
 {
 	*effective = *inheritable = *permitted = 0;
+	*bounding = CAP_FULL_SET;
 	if (!issecure(SECURE_NOROOT)) {
 		if (target->euid == 0) {
-			*permitted |= (~0 & ~CAP_FS_MASK);
-			*effective |= (~0 & ~CAP_TO_MASK(CAP_SETPCAP) & ~CAP_FS_MASK);
+			*permitted |= (CAP_FULL_SET & ~CAP_FS_MASK);
+			*effective |= (CAP_FULL_SET & ~CAP_TO_MASK(CAP_SETPCAP) & ~CAP_FS_MASK);
+			*inheritable |= (CAP_FULL_SET & ~CAP_TO_MASK(CAP_SETPCAP) & ~CAP_FS_MASK);
 		}
 		if (target->fsuid == 0) {
 			*permitted |= CAP_FS_MASK;
 			*effective |= CAP_FS_MASK;
+			*inheritable |= CAP_FS_MASK;
 		}
 	}
 	return 0;
@@ -54,7 +58,8 @@ static int dummy_capget (struct task_str
 static int dummy_capset_check (struct task_struct *target,
 			       kernel_cap_t * effective,
 			       kernel_cap_t * inheritable,
-			       kernel_cap_t * permitted)
+			       kernel_cap_t * permitted,
+			       kernel_cap_t * bounding)
 {
 	return -EPERM;
 }
@@ -62,7 +67,8 @@ static int dummy_capset_check (struct ta
 static void dummy_capset_set (struct task_struct *target,
 			      kernel_cap_t * effective,
 			      kernel_cap_t * inheritable,
-			      kernel_cap_t * permitted)
+			      kernel_cap_t * permitted,
+			      kernel_cap_t * bounding)
 {
 	return;
 }
@@ -141,7 +147,7 @@ static void dummy_bprm_apply_creds (stru
 	current->suid = current->euid = current->fsuid = bprm->e_uid;
 	current->sgid = current->egid = current->fsgid = bprm->e_gid;
 
-	dummy_capget(current, &current->cap_effective, &current->cap_inheritable, &current->cap_permitted);
+	dummy_capget(current, &current->cap_effective, &current->cap_inheritable, &current->cap_permitted, &current->cap_bounding);
 }
 
 static void dummy_bprm_post_apply_creds (struct linux_binprm *bprm)
@@ -509,7 +515,7 @@ static int dummy_task_setuid (uid_t id0,
 
 static int dummy_task_post_setuid (uid_t id0, uid_t id1, uid_t id2, int flags)
 {
-	dummy_capget(current, &current->cap_effective, &current->cap_inheritable, &current->cap_permitted);
+	dummy_capget(current, &current->cap_effective, &current->cap_inheritable, &current->cap_permitted, &current->cap_bounding);
 	return 0;
 }
 
--- linux-2.6.12.4/security/selinux/hooks.c	2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4.caps/security/selinux/hooks.c	2005-08-09 01:33:35.000000000 +0200
@@ -1362,7 +1362,8 @@ static int selinux_ptrace(struct task_st
 }
 
 static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
-                          kernel_cap_t *inheritable, kernel_cap_t *permitted)
+                          kernel_cap_t *inheritable, kernel_cap_t *permitted,
+			  kernel_cap_t *bounding)
 {
 	int error;
 
@@ -1370,15 +1371,16 @@ static int selinux_capget(struct task_st
 	if (error)
 		return error;
 
-	return secondary_ops->capget(target, effective, inheritable, permitted);
+	return secondary_ops->capget(target, effective, inheritable, permitted, bounding);
 }
 
 static int selinux_capset_check(struct task_struct *target, kernel_cap_t *effective,
-                                kernel_cap_t *inheritable, kernel_cap_t *permitted)
+                                kernel_cap_t *inheritable, kernel_cap_t *permitted,
+				kernel_cap_t *bounding)
 {
 	int error;
 
-	error = secondary_ops->capset_check(target, effective, inheritable, permitted);
+	error = secondary_ops->capset_check(target, effective, inheritable, permitted, bounding);
 	if (error)
 		return error;
 
@@ -1386,9 +1388,10 @@ static int selinux_capset_check(struct t
 }
 
 static void selinux_capset_set(struct task_struct *target, kernel_cap_t *effective,
-                               kernel_cap_t *inheritable, kernel_cap_t *permitted)
+                               kernel_cap_t *inheritable, kernel_cap_t *permitted,
+			       kernel_cap_t *bounding)
 {
-	secondary_ops->capset_set(target, effective, inheritable, permitted);
+	secondary_ops->capset_set(target, effective, inheritable, permitted, bounding);
 }
 
 static int selinux_capable(struct task_struct *tsk, int cap)
### cut before ###

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
