Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSEaPyq>; Fri, 31 May 2002 11:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315722AbSEaPyp>; Fri, 31 May 2002 11:54:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:45552 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315456AbSEaPyh>; Fri, 31 May 2002 11:54:37 -0400
Subject: [PATCH] 2.5 capability.c cleanup
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 May 2002 08:54:36 -0700
Message-Id: <1022860476.985.1308.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus et al,

I started looking into a couple FIXMEs in kernel/capability.c and I
ended up with a fairly largish patch (although not quite so much changes
to object code).

First, it is unsafe to touch task->cap_* while not holding
task_capability_lock.  The most notable occurrence of this is sys_access
which saves the current cap_* values, changes them, does its business,
then restores them.  In between all this they can change and then
restored to old values.  Unfortunately we cannot just grab the lock here
since the function can sleep - I marked this with a FIXME for now.

Second, I formalized the locking rules with task_capability_lock.  I
declared the lock in include/linux/capability.h so other code can grab
it.

Finally, there is a whole boatload of code cleanup:

	- remove conditional locking/unlocking - that is just gross
	- don't pointlessly grab the read_lock twice
	- add/remove/edit comments
	- change some types (int -> pid_t, etc)
	- static inline two small functions that are called only
	  once each
	- remove two FIXMEs
	- general code cleanup for readability and performance

TODO:

	- fix sys_access and other cap_* accesses
	- do something about the annoying oddball 5-space indentation
	  in kernel/capability.c !!

Patch is against 2.5.19, please apply.

	Robert Love

diff -urN linux-2.5.19/fs/open.c linux/fs/open.c
--- linux-2.5.19/fs/open.c	Wed May 29 11:42:45 2002
+++ linux/fs/open.c	Thu May 30 18:42:39 2002
@@ -338,7 +338,14 @@
 	current->fsuid = current->uid;
 	current->fsgid = current->gid;
 
-	/* Clear the capabilities if we switch to a non-root user */
+	/*
+	 * Clear the capabilities if we switch to a non-root user
+	 *
+	 * FIXME: There is a race here against sys_capset.  The
+	 * capabilities can change yet we will restore the old
+	 * value below.  We should hold task_capabilities_lock,
+	 * but we cannot because user_path_walk can sleep.
+	 */
 	if (current->uid)
 		cap_clear(current->cap_effective);
 	else
diff -urN linux-2.5.19/include/linux/capability.h linux/include/linux/capability.h
--- linux-2.5.19/include/linux/capability.h	Wed May 29 11:42:50 2002
+++ linux/include/linux/capability.h	Thu May 30 15:21:58 2002
@@ -41,6 +41,10 @@
   
 #ifdef __KERNEL__
 
+#include <linux/spinlock.h>
+
+extern spinlock_t task_capability_lock;
+
 /* #define STRICT_CAP_T_TYPECHECKS */
 
 #ifdef STRICT_CAP_T_TYPECHECKS
diff -urN linux-2.5.19/kernel/capability.c linux/kernel/capability.c
--- linux-2.5.19/kernel/capability.c	Wed May 29 11:42:47 2002
+++ linux/kernel/capability.c	Thu May 30 15:19:37 2002
@@ -2,17 +2,21 @@
  * linux/kernel/capability.c
  *
  * Copyright (C) 1997  Andrew Main <zefram@fysh.org>
+ *
  * Integrated into 2.1.97+,  Andrew G. Morgan <morgan@transmeta.com>
+ * 30 May 2002:	Cleanup, Robert M. Love <rml@tech9.net>
  */ 
 
 #include <linux/mm.h>
 #include <asm/uaccess.h>
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
-
 kernel_cap_t cap_bset = CAP_INIT_EFF_SET;
 
-/* Note: never hold tasklist_lock while spinning for this one */
+/*
+ * This global lock protects task->cap_* for all tasks including current.
+ * Locking rule: acquire this prior to tasklist_lock.
+ */
 spinlock_t task_capability_lock = SPIN_LOCK_UNLOCKED;
 
 /*
@@ -21,23 +25,24 @@
  * uninteresting and/or not to be changed.
  */
 
+/*
+ * sys_capget - get the capabilities of a given process.
+ */
 asmlinkage long sys_capget(cap_user_header_t header, cap_user_data_t dataptr)
 {
-     int error, pid;
+     int ret = 0;
+     pid_t pid;
      __u32 version;
-     struct task_struct *target;
+     task_t *target;
      struct __user_cap_data_struct data;
 
      if (get_user(version, &header->version))
 	     return -EFAULT;
-	     
-     error = -EINVAL; 
-     if (version != _LINUX_CAPABILITY_VERSION) {
-             version = _LINUX_CAPABILITY_VERSION;
-	     if (put_user(version, &header->version))
-		     error = -EFAULT; 
-             return error;
-     }
+
+     if (version != _LINUX_CAPABILITY_VERSION)
+	     if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
+		     return -EFAULT; 
+             return -EINVAL;
 
      if (get_user(pid, &header->pid))
 	     return -EFAULT; 
@@ -45,48 +50,39 @@
      if (pid < 0) 
              return -EINVAL;
 
-     error = 0;
-
      spin_lock(&task_capability_lock);
+     read_lock(&tasklist_lock); 
 
-     if (pid && pid != current->pid) {
-	     read_lock(&tasklist_lock); 
-             target = find_task_by_pid(pid);  /* identify target of query */
-             if (!target) 
-                     error = -ESRCH;
-     } else {
-             target = current;
+     target = find_task_by_pid(pid);
+     if (!target) {
+          ret = -ESRCH;
+          goto out;
      }
 
-     if (!error) { 
-	     data.permitted = cap_t(target->cap_permitted);
-	     data.inheritable = cap_t(target->cap_inheritable); 
-	     data.effective = cap_t(target->cap_effective);
-     }
+     data.permitted = cap_t(target->cap_permitted);
+     data.inheritable = cap_t(target->cap_inheritable); 
+     data.effective = cap_t(target->cap_effective);
 
-     if (target != current)
-	     read_unlock(&tasklist_lock); 
+out:
+     read_unlock(&tasklist_lock); 
      spin_unlock(&task_capability_lock);
 
-     if (!error) {
-	     if (copy_to_user(dataptr, &data, sizeof data))
-		     return -EFAULT; 
-     }
+     if (!ret && copy_to_user(dataptr, &data, sizeof data))
+          return -EFAULT; 
 
-     return error;
+     return ret;
 }
 
-/* set capabilities for all processes in a given process group */
-
-static void cap_set_pg(int pgrp,
-                    kernel_cap_t *effective,
-                    kernel_cap_t *inheritable,
-                    kernel_cap_t *permitted)
+/*
+ * cap_set_pg - set capabilities for all processes in a given process
+ * group.  We call this holding task_capability_lock and tasklist_lock.
+ */
+static inline void cap_set_pg(int pgrp, kernel_cap_t *effective,
+			      kernel_cap_t *inheritable,
+			      kernel_cap_t *permitted)
 {
-     struct task_struct *target;
+     task_t *target;
 
-     /* FIXME: do we need to have a write lock here..? */
-     read_lock(&tasklist_lock);
      for_each_task(target) {
              if (target->pgrp != pgrp)
                      continue;
@@ -94,20 +90,18 @@
              target->cap_inheritable = *inheritable;
              target->cap_permitted   = *permitted;
      }
-     read_unlock(&tasklist_lock);
 }
 
-/* set capabilities for all processes other than 1 and self */
-
-static void cap_set_all(kernel_cap_t *effective,
-                     kernel_cap_t *inheritable,
-                     kernel_cap_t *permitted)
+/*
+ * cap_set_all - set capabilities for all processes other than init
+ * and self.  We call this holding task_capability_lock and tasklist_lock.
+ */
+static inline void cap_set_all(kernel_cap_t *effective,
+			       kernel_cap_t *inheritable,
+			       kernel_cap_t *permitted)
 {
-     struct task_struct *target;
+     task_t *target;
 
-     /* FIXME: do we need to have a write lock here..? */
-     read_lock(&tasklist_lock);
-     /* ALL means everyone other than self or 'init' */
      for_each_task(target) {
              if (target == current || target->pid == 1)
                      continue;
@@ -115,35 +109,35 @@
              target->cap_inheritable = *inheritable;
              target->cap_permitted   = *permitted;
      }
-     read_unlock(&tasklist_lock);
 }
 
 /*
+ * sys_capset - set capabilities for a given process, all processes, or all
+ * processes in a given process group.
+ *
  * The restrictions on setting capabilities are specified as:
  *
  * [pid is for the 'target' task.  'current' is the calling task.]
  *
- * I: any raised capabilities must be a subset of the (old current) Permitted
+ * I: any raised capabilities must be a subset of the (old current) permitted
  * P: any raised capabilities must be a subset of the (old current) permitted
- * E: must be set to a subset of (new target) Permitted
+ * E: must be set to a subset of (new target) permitted
  */
-
 asmlinkage long sys_capset(cap_user_header_t header, const cap_user_data_t data)
 {
      kernel_cap_t inheritable, permitted, effective;
      __u32 version;
-     struct task_struct *target;
-     int error, pid;
+     task_t *target;
+     int ret;
+     pid_t pid;
 
      if (get_user(version, &header->version))
 	     return -EFAULT; 
 
-     if (version != _LINUX_CAPABILITY_VERSION) {
-             version = _LINUX_CAPABILITY_VERSION;
-	     if (put_user(version, &header->version))
+     if (version != _LINUX_CAPABILITY_VERSION)
+	     if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
 		     return -EFAULT; 
              return -EINVAL;
-     }
 
      if (get_user(pid, &header->pid))
 	     return -EFAULT; 
@@ -156,43 +150,35 @@
 	 copy_from_user(&permitted, &data->permitted, sizeof(permitted)))
 	     return -EFAULT; 
 
-     error = -EPERM;
      spin_lock(&task_capability_lock);
+     read_lock(&tasklist_lock);
 
      if (pid > 0 && pid != current->pid) {
-             read_lock(&tasklist_lock);
-             target = find_task_by_pid(pid);  /* identify target of query */
-             if (!target) {
-                     error = -ESRCH;
-		     goto out;
-	     }
-     } else {
-             target = current;
-     }
+          target = find_task_by_pid(pid);
+          if (!target) {
+               ret = -ESRCH;
+               goto out;
+          }
+     } else
+               target = current;
 
+     ret = -EPERM;
 
      /* verify restrictions on target's new Inheritable set */
-     if (!cap_issubset(inheritable,
-                       cap_combine(target->cap_inheritable,
-                                   current->cap_permitted))) {
+     if (!cap_issubset(inheritable, cap_combine(target->cap_inheritable,
+                       current->cap_permitted)))
              goto out;
-     }
 
      /* verify restrictions on target's new Permitted set */
-     if (!cap_issubset(permitted,
-                       cap_combine(target->cap_permitted,
-                                   current->cap_permitted))) {
+     if (!cap_issubset(permitted, cap_combine(target->cap_permitted,
+                       current->cap_permitted)))
              goto out;
-     }
 
      /* verify the _new_Effective_ is a subset of the _new_Permitted_ */
-     if (!cap_issubset(effective, permitted)) {
+     if (!cap_issubset(effective, permitted))
              goto out;
-     }
 
-     /* having verified that the proposed changes are legal,
-           we now put them into effect. */
-     error = 0;
+     ret = 0;
 
      if (pid < 0) {
              if (pid == -1)  /* all procs other than current and init */
@@ -200,19 +186,15 @@
 
              else            /* all procs in process group */
                      cap_set_pg(-pid, &effective, &inheritable, &permitted);
-             goto spin_out;
      } else {
-             /* FIXME: do we need to have a write lock here..? */
              target->cap_effective   = effective;
              target->cap_inheritable = inheritable;
              target->cap_permitted   = permitted;
      }
 
 out:
-     if (target != current) {
-             read_unlock(&tasklist_lock);
-     }
-spin_out:
+     read_unlock(&tasklist_lock);
      spin_unlock(&task_capability_lock);
-     return error;
+
+     return ret;
 }

