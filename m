Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVHLR4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVHLR4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVHLR4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:56:00 -0400
Received: from chello062178225197.14.15.tuwien.teleweb.at ([62.178.225.197]:42234
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750809AbVHLRzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:55:42 -0400
Subject: [PATCH 2.6.13-rc6 2/2] New Syscall: set rlimits of any process
From: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Reply-To: e8607062@student.tuwien.ac.at
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Elliot Lee <sopwith@redhat.com>,
       Wieland Gmeiner <e8607062@student.tuwien.ac.at>
In-Reply-To: <1123868902.10923.5.camel@w2>
References: <1123868902.10923.5.camel@w2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Aug 2005 19:53:50 +0200
Message-Id: <1123869230.10923.8.camel@w2>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Implementation: This patch provides a new syscall setprlimit() for
writing a given process resource limits for i386. Its implementation
follows closely the setrlimit syscall. It is given a pid as an
additional argument. If the given pid equals zero the current process
rlimits are written and the behaviour resembles the behaviour of
setrlimit. Otherwise some checking on the validity of the given pid is
done and if the given process is found write access is granted if

- the calling process holds the CAP_SYS_RESOURCE capability
  or
- the calling process uid equals the uid of the process whose rlimit
  is being written and
  the calling process uid equals the euid of the process whose rlimit
  is being written
  or
- the calling process euid equals the suid of the process whose 
  rlimit is being written

Signed-off-by: Wieland Gmeiner <e8607062@student.tuwien.ac.at>



diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-rlim/arch/i386/kernel/syscall_table.S linux-2.6.13-rc6-get_set_rlim/arch/i386/kernel/syscall_table.S
--- linux-2.6.13-rc6-rlim/arch/i386/kernel/syscall_table.S	2005-08-09 16:30:51.000000000 +0200
+++ linux-2.6.13-rc6-get_set_rlim/arch/i386/kernel/syscall_table.S	2005-08-09 16:34:54.000000000 +0200
@@ -295,3 +295,4 @@ ENTRY(sys_call_table)
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
         .long sys_getprlimit
+        .long sys_setprlimit            /* 295 */
diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-rlim/include/asm-i386/unistd.h linux-2.6.13-rc6-get_set_rlim/include/asm-i386/unistd.h
--- linux-2.6.13-rc6-rlim/include/asm-i386/unistd.h	2005-08-09 16:30:51.000000000 +0200
+++ linux-2.6.13-rc6-get_set_rlim/include/asm-i386/unistd.h	2005-08-09 16:34:54.000000000 +0200
@@ -300,8 +300,9 @@
 #define __NR_inotify_add_watch	292
 #define __NR_inotify_rm_watch	293
 #define __NR_getprlimit         294
+#define __NR_setprlimit         295
 
-#define NR_syscalls 295
+#define NR_syscalls 296
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-rlim/include/linux/security.h linux-2.6.13-rc6-get_set_rlim/include/linux/security.h
--- linux-2.6.13-rc6-rlim/include/linux/security.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc6-get_set_rlim/include/linux/security.h	2005-08-09 16:34:55.000000000 +0200
@@ -591,7 +591,16 @@ struct swap_info_struct;
  *	@resource contains the resource whose limit is being set.
  *	@new_rlim contains the new limits for @resource.
  *	Return 0 if permission is granted.
- * @task_setscheduler:
+ * @task_setprlimit:
+ *	Check permission before setting the resource limits of process @p
+ *	for @resource to @new_rlim.  The old resource limit values can
+ *	be examined by dereferencing (p->signal->rlim + resource).
+ *	@p contains the task struct of the process whose resource limit is
+ *	being set.
+ *	@resource contains the resource whose limit is being set.
+ *	@new_rlim contains the new limits for @resource.
+ *	Return 0 if permission is granted.
+  @task_setscheduler:
  *	Check permission before setting scheduling policy and/or parameters of
  *	process @p based on @policy and @lp.
  *	@p contains the task_struct for process.
@@ -1157,6 +1166,8 @@ struct security_operations {
 	int (*task_setgroups) (struct group_info *group_info);
 	int (*task_setnice) (struct task_struct * p, int nice);
 	int (*task_setrlimit) (unsigned int resource, struct rlimit * new_rlim);
+	int (*task_setprlimit) (struct task_struct * p, unsigned int resource, 
+                                struct rlimit * new_rlim);
 	int (*task_setscheduler) (struct task_struct * p, int policy,
 				  struct sched_param * lp);
 	int (*task_getscheduler) (struct task_struct * p);
@@ -1804,6 +1815,13 @@ static inline int security_task_setrlimi
 	return security_ops->task_setrlimit (resource, new_rlim);
 }
 
+static inline int security_task_setprlimit (struct task_struct *p,
+                                            unsigned int resource,
+					    struct rlimit *new_rlim)
+{
+	return security_ops->task_setprlimit (p, resource, new_rlim);
+}
+
 static inline int security_task_setscheduler (struct task_struct *p,
 					      int policy,
 					      struct sched_param *lp)
diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-rlim/kernel/sys.c linux-2.6.13-rc6-get_set_rlim/kernel/sys.c
--- linux-2.6.13-rc6-rlim/kernel/sys.c	2005-08-09 16:30:51.000000000 +0200
+++ linux-2.6.13-rc6-get_set_rlim/kernel/sys.c	2005-08-09 16:34:56.000000000 +0200
@@ -1644,6 +1644,72 @@ out_nounlock:
         return retval;
 }
 
+asmlinkage long sys_setprlimit(pid_t pid, unsigned int resource, struct rlimit __user *rlim)
+{
+	struct rlimit new_rlim, *old_rlim;
+	int retval;
+        task_t *p;
+
+	if (resource >= RLIM_NLIMITS)
+		return -EINVAL;
+        if (pid < 0)
+                return -EINVAL;
+	if (copy_from_user(&new_rlim, rlim, sizeof(*rlim)))
+		return -EFAULT;
+        if (new_rlim.rlim_cur > new_rlim.rlim_max)
+                return -EINVAL;
+        
+        retval = -ESRCH;
+        if (pid == 0) {
+                p = current;
+        } else {
+                read_lock(&tasklist_lock);
+                p = find_task_by_pid(pid);
+        }
+        if (p) {
+                retval = -EPERM;
+                if ((current->euid ^ p->suid) &&
+                    ((current->uid ^ p->euid) || (current->uid ^ p->uid)) &&
+                    !capable(CAP_SYS_RESOURCE))
+                        goto out_unlock;
+ 
+                old_rlim = p->signal->rlim + resource;
+                if ((new_rlim.rlim_max > old_rlim->rlim_max) &&
+                                !capable(CAP_SYS_RESOURCE))
+                        goto out_unlock;
+                if (resource == RLIMIT_NOFILE && new_rlim.rlim_max > NR_OPEN)
+                        goto out_unlock;
+
+                retval = security_task_setprlimit(p, resource, &new_rlim);
+                if (retval)
+                        goto out_unlock;
+
+                task_lock(p->group_leader);
+	        *old_rlim = new_rlim;
+                task_unlock(p->group_leader);
+                retval = 0;
+
+        	if (resource == RLIMIT_CPU && new_rlim.rlim_cur != RLIM_INFINITY &&
+	            (cputime_eq(p->signal->it_prof_expires, cputime_zero) ||
+	             new_rlim.rlim_cur <= cputime_to_secs(
+		                p->signal->it_prof_expires))) {
+		        cputime_t cputime = secs_to_cputime(new_rlim.rlim_cur);
+		        spin_lock_irq(&p->sighand->siglock);
+		        set_process_cpu_timer(p, CPUCLOCK_PROF,
+			        	      &cputime, NULL);
+		        spin_unlock_irq(&p->sighand->siglock);
+	        }
+        }
+        if (pid == 0)
+                goto out_nounlock;
+
+out_unlock:
+        read_unlock(&tasklist_lock);
+
+out_nounlock:
+        return retval;
+}
+
 /*
  * It would make sense to put struct rusage in the task_struct,
  * except that would make the task_struct be *really big*.  After
diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-rlim/security/dummy.c linux-2.6.13-rc6-get_set_rlim/security/dummy.c
--- linux-2.6.13-rc6-rlim/security/dummy.c	2005-08-09 16:30:38.000000000 +0200
+++ linux-2.6.13-rc6-get_set_rlim/security/dummy.c	2005-08-09 16:34:56.000000000 +0200
@@ -548,6 +548,12 @@ static int dummy_task_setrlimit (unsigne
 	return 0;
 }
 
+static int dummy_task_setprlimit (struct task_struct *p, unsigned int resource,
+                                  struct rlimit *new_rlim)
+{
+	return 0;
+}
+
 static int dummy_task_setscheduler (struct task_struct *p, int policy,
 				    struct sched_param *lp)
 {
@@ -937,6 +943,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, task_setgroups);
 	set_to_dummy_if_null(ops, task_setnice);
 	set_to_dummy_if_null(ops, task_setrlimit);
+	set_to_dummy_if_null(ops, task_setprlimit);
 	set_to_dummy_if_null(ops, task_setscheduler);
 	set_to_dummy_if_null(ops, task_getscheduler);
 	set_to_dummy_if_null(ops, task_wait);
diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-rlim/security/selinux/hooks.c linux-2.6.13-rc6-get_set_rlim/security/selinux/hooks.c
--- linux-2.6.13-rc6-rlim/security/selinux/hooks.c	2005-08-09 16:30:38.000000000 +0200
+++ linux-2.6.13-rc6-get_set_rlim/security/selinux/hooks.c	2005-08-09 16:34:57.000000000 +0200
@@ -2722,6 +2722,26 @@ static int selinux_task_setrlimit(unsign
 	return 0;
 }
 
+static int selinux_task_setprlimit(struct task_struct *p, unsigned int resource,
+                                  struct rlimit *new_rlim)
+{
+	struct rlimit *old_rlim = p->signal->rlim + resource;
+	int rc;
+
+	rc = secondary_ops->task_setprlimit(p, resource, new_rlim);
+	if (rc)
+		return rc;
+
+	/* Control the ability to change the hard limit (whether
+	   lowering or raising it), so that the hard limit can
+	   later be used as a safe reset point for the soft limit
+	   upon context transitions. See selinux_bprm_apply_creds. */
+	if (old_rlim->rlim_max != new_rlim->rlim_max)
+		return task_has_perm(current, p, PROCESS__SETRLIMIT);
+
+	return 0;
+}
+
 static int selinux_task_setscheduler(struct task_struct *p, int policy, struct sched_param *lp)
 {
 	return task_has_perm(current, p, PROCESS__SETSCHED);

