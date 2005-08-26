Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbVHZDj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbVHZDj6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 23:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVHZDj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 23:39:57 -0400
Received: from chello062178225197.14.15.tuwien.teleweb.at ([62.178.225.197]:28866
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751445AbVHZDj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 23:39:57 -0400
Subject: [PATCH 2.6.13-rc7 2/2] New Syscall: set rlimits of any process
	(reworked)
From: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Reply-To: e8607062@student.tuwien.ac.at
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Elliot Lee <sopwith@redhat.com>
In-Reply-To: <1125027277.6394.8.camel@w2>
References: <1125027277.6394.8.camel@w2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 26 Aug 2005 05:39:41 +0200
Message-Id: <1125027581.6394.11.camel@w2>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second of two patches, it implements the setprlimit()
syscall.

Implementation: This patch provides a new syscall setprlimit() for
writing a given process resource limits for i386. Its implementation
follows closely the setrlimit syscall. It is given a pid as an
additional argument. If the given pid equals zero the current process
rlimits are written and the behaviour resembles the behaviour of
setrlimit. Otherwise some checking on the validity of the given pid is
done and if the given process is found access is granted if
- the calling process holds the CAP_SYS_PTRACE capability or
- the calling process uid equals the uid, euid, suid of the target
  process and the calling process gid equals the gid, egid, sgid of
  the target process.
(This resembles the behaviour of the ptrace system call.)

Simple programs for testing the syscalls can be found on
http://stud4.tuwien.ac.at/~e8607062/studies/soc/patches/


Signed-off-by: Wieland Gmeiner <e8607062@student.tuwien.ac.at>



---

 arch/i386/kernel/syscall_table.S |    1 
 include/asm-i386/unistd.h        |    3 -
 kernel/sys.c                     |  114 ++++++++++++++++++++++++---------------
 security/selinux/hooks.c         |   14 +++-
 4 files changed, 85 insertions(+), 47 deletions(-)

diff -puN arch/i386/kernel/syscall_table.S~setprlimit arch/i386/kernel/syscall_table.S
--- linux-2.6.13-rc7/arch/i386/kernel/syscall_table.S~setprlimit	2005-08-26 05:09:13.000000000 +0200
+++ linux-2.6.13-rc7-wieland/arch/i386/kernel/syscall_table.S	2005-08-26 05:09:34.000000000 +0200
@@ -295,3 +295,4 @@ ENTRY(sys_call_table)
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
 	.long sys_getprlimit
+	.long sys_setprlimit		/* 295 */
diff -puN include/asm-i386/unistd.h~setprlimit include/asm-i386/unistd.h
--- linux-2.6.13-rc7/include/asm-i386/unistd.h~setprlimit	2005-08-26 05:09:13.000000000 +0200
+++ linux-2.6.13-rc7-wieland/include/asm-i386/unistd.h	2005-08-26 05:09:34.000000000 +0200
@@ -300,8 +300,9 @@
 #define __NR_inotify_add_watch	292
 #define __NR_inotify_rm_watch	293
 #define __NR_getprlimit		294
+#define __NR_setprlimit		295
 
-#define NR_syscalls 295
+#define NR_syscalls 296
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff -puN kernel/sys.c~setprlimit kernel/sys.c
--- linux-2.6.13-rc7/kernel/sys.c~setprlimit	2005-08-26 05:09:13.000000000 +0200
+++ linux-2.6.13-rc7-wieland/kernel/sys.c	2005-08-26 05:09:34.000000000 +0200
@@ -1600,6 +1600,78 @@ asmlinkage long sys_getrlimit(unsigned i
 	return rlim_do_getprlimit(0, resource, rlim);
 }
 
+static inline long rlim_do_setprlimit(pid_t pid, unsigned int resource,
+				      struct rlimit __user *rlim)
+{
+	struct rlimit new_rlim, *old_rlim;
+	int retval;
+	task_t *p;
+
+	if (resource >= RLIM_NLIMITS)
+		return -EINVAL;
+	if (pid < 0)
+		return -EINVAL;
+	if(copy_from_user(&new_rlim, rlim, sizeof(*rlim)))
+		return -EFAULT;
+	if (new_rlim.rlim_cur > new_rlim.rlim_max)
+		return -EINVAL;
+
+	retval = -ESRCH;
+	read_lock(&tasklist_lock);
+	if (pid == 0) {
+		p = current;
+	} else {
+		p = find_task_by_pid(pid);
+	}
+	if (p) {
+		retval = -EPERM;
+		if (pid && !prlim_check_perm(p))
+			goto out;
+
+		old_rlim = p->signal->rlim + resource;
+		if ((new_rlim.rlim_max > old_rlim->rlim_max) &&
+		    !capable(CAP_SYS_RESOURCE))
+			goto out;
+		if (resource == RLIMIT_NOFILE && new_rlim.rlim_max > NR_OPEN)
+			goto out;
+
+		retval = security_task_rlimit(p, resource, &new_rlim);
+		if (retval)
+			goto out;
+
+		task_lock(p->group_leader);
+		*old_rlim = new_rlim;
+		task_unlock(p->group_leader);
+
+		if (resource == RLIMIT_CPU &&
+		    new_rlim.rlim_cur != RLIM_INFINITY &&
+		    (cputime_eq(p->signal->it_prof_expires, cputime_zero) ||
+		     new_rlim.rlim_cur <= cputime_to_secs(
+			     p->signal->it_prof_expires))) {
+			cputime_t cputime = secs_to_cputime(new_rlim.rlim_cur);
+			spin_lock_irq(&p->sighand->siglock);
+			set_process_cpu_timer(p, CPUCLOCK_PROF,
+					      &cputime, NULL);
+			spin_unlock_irq(&p->sighand->siglock);
+		}
+	}
+
+out:
+	read_unlock(&tasklist_lock);
+	return retval;
+}
+
+asmlinkage long sys_setprlimit(pid_t pid, unsigned int resource,
+			       struct rlimit __user *rlim)
+{
+	return rlim_do_setprlimit(pid, resource, rlim);
+}
+
+asmlinkage long sys_setrlimit(unsigned int resource, struct rlimit __user *rlim)
+{
+	return rlim_do_setprlimit(0, resource, rlim);
+}
+
 #ifdef __ARCH_WANT_SYS_OLD_GETRLIMIT
 
 /*
@@ -1624,48 +1696,6 @@ asmlinkage long sys_old_getrlimit(unsign
 
 #endif
 
-asmlinkage long sys_setrlimit(unsigned int resource, struct rlimit __user *rlim)
-{
-	struct rlimit new_rlim, *old_rlim;
-	int retval;
-
-	if (resource >= RLIM_NLIMITS)
-		return -EINVAL;
-	if(copy_from_user(&new_rlim, rlim, sizeof(*rlim)))
-		return -EFAULT;
-       if (new_rlim.rlim_cur > new_rlim.rlim_max)
-               return -EINVAL;
-	old_rlim = current->signal->rlim + resource;
-	if ((new_rlim.rlim_max > old_rlim->rlim_max) &&
-	    !capable(CAP_SYS_RESOURCE))
-		return -EPERM;
-	if (resource == RLIMIT_NOFILE && new_rlim.rlim_max > NR_OPEN)
-			return -EPERM;
-
-	retval = security_task_rlimit(0, resource, &new_rlim);
-	if (retval)
-		return retval;
-
-	task_lock(current->group_leader);
-	*old_rlim = new_rlim;
-	task_unlock(current->group_leader);
-
-	if (resource == RLIMIT_CPU && new_rlim.rlim_cur != RLIM_INFINITY &&
-	    (cputime_eq(current->signal->it_prof_expires, cputime_zero) ||
-	     new_rlim.rlim_cur <= cputime_to_secs(
-		     current->signal->it_prof_expires))) {
-		cputime_t cputime = secs_to_cputime(new_rlim.rlim_cur);
-		read_lock(&tasklist_lock);
-		spin_lock_irq(&current->sighand->siglock);
-		set_process_cpu_timer(current, CPUCLOCK_PROF,
-				      &cputime, NULL);
-		spin_unlock_irq(&current->sighand->siglock);
-		read_unlock(&tasklist_lock);
-	}
-
-	return 0;
-}
-
 /*
  * It would make sense to put struct rusage in the task_struct,
  * except that would make the task_struct be *really big*.  After
diff -puN security/selinux/hooks.c~setprlimit security/selinux/hooks.c
--- linux-2.6.13-rc7/security/selinux/hooks.c~setprlimit	2005-08-26 05:09:13.000000000 +0200
+++ linux-2.6.13-rc7-wieland/security/selinux/hooks.c	2005-08-26 05:09:34.000000000 +0200
@@ -2710,21 +2710,27 @@ static int selinux_task_rlimit(struct ta
 	struct rlimit *old_rlim = p->signal->rlim + resource;
 	int rc;
 
+	/* getprlimit */
 	if (!new_rlim)
 		rc = secondary_ops->task_rlimit(p, resource, 0);
-	else
+	/* setrlimit */
+	else if (p == current)
 		rc = secondary_ops->task_rlimit(0, resource, new_rlim);
+	/* setprlimit */
+	else
+		rc = secondary_ops->task_rlimit(p, resource, new_rlim);
 	if (rc)
 		return rc;
 
-	if (!new_rlim)
-		return task_has_perm(current, p, PROCESS__PTRACE);
 	/* Control the ability to change the hard limit (whether
 	   lowering or raising it), so that the hard limit can
 	   later be used as a safe reset point for the soft limit
 	   upon context transitions. See selinux_bprm_apply_creds. */
-	else if (p == current && old_rlim->rlim_max != new_rlim->rlim_max)
+	if (p == current && new_rlim &&
+	    old_rlim->rlim_max != new_rlim->rlim_max)
 		return task_has_perm(current, current, PROCESS__SETRLIMIT);
+	else
+		return task_has_perm(current, p, PROCESS__PTRACE);
 
 	return 0;
 }
_

