Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVHRA5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVHRA5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 20:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVHRA5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 20:57:55 -0400
Received: from chello062178225197.14.15.tuwien.teleweb.at ([62.178.225.197]:6592
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932068AbVHRA5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 20:57:55 -0400
Subject: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
	(update)
From: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Reply-To: e8607062@student.tuwien.ac.at
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Elliot Lee <sopwith@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Aug 2005 02:57:31 +0200
Message-Id: <1124326652.8359.3.camel@w2>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I incorporated the changes suggested by Greg KH and Kyle Moffett and
isolated some duplicated code (between setrlimit/setprlimit resp.
getprlimit/setprlimit) into helper functions. This is the first of
two patches, it implements the getprlimit() call.

Rationale: Currently usage limits (rlimits) can only be set inside a
process space, or inherited from the parent process. It would be
useful to allow adjusting resource limits for running processes, e.g.
tuning the resource usage of daemon processes under changing workloads
without restarting them.

Implementation: This patch provides a new syscall getprlimit() for
reading a given process resource limits for i386. Its implementation
follows closely the getrlimit syscall. It is given a pid as an
additional argument. If the given pid equals zero the current process
rlimits are read and the behaviour resembles the behaviour of
getrlimit. Otherwise some checking on the validity of the given pid is
done and if the given process is found access is granted if
- the calling process holds the CAP_SYS_RESOURCE capability or
- the calling process uid equals the uid, euid, suid of the target
  process and the calling process gid equals the gid, egid, sgid of
  the target process.
(This resembles the behaviour of the ptrace system call.)


See the followup for the writing syscall.

Simple programs for testing the syscalls can be found on
http://stud4.tuwien.ac.at/~e8607062/studies/soc/patches/


Signed-off-by: Wieland Gmeiner <e8607062@student.tuwien.ac.at>


diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-vanilla/arch/i386/kernel/syscall_table.S linux-2.6.13-rc6-getprlimit/arch/i386/kernel/syscall_table.S
--- linux-2.6.13-rc6-vanilla/arch/i386/kernel/syscall_table.S	2005-08-09 16:03:08.000000000 +0200
+++ linux-2.6.13-rc6-getprlimit/arch/i386/kernel/syscall_table.S	2005-08-17 03:20:30.000000000 +0200
@@ -294,3 +294,4 @@ ENTRY(sys_call_table)
 	.long sys_inotify_init
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
+	.long sys_getprlimit
diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-vanilla/include/asm-i386/unistd.h linux-2.6.13-rc6-getprlimit/include/asm-i386/unistd.h
--- linux-2.6.13-rc6-vanilla/include/asm-i386/unistd.h	2005-08-09 16:03:19.000000000 +0200
+++ linux-2.6.13-rc6-getprlimit/include/asm-i386/unistd.h	2005-08-17 03:20:29.000000000 +0200
@@ -299,8 +299,9 @@
 #define __NR_inotify_init	291
 #define __NR_inotify_add_watch	292
 #define __NR_inotify_rm_watch	293
+#define __NR_getprlimit		294
 
-#define NR_syscalls 294
+#define NR_syscalls 295
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-vanilla/kernel/sys.c linux-2.6.13-rc6-getprlimit/kernel/sys.c
--- linux-2.6.13-rc6-vanilla/kernel/sys.c	2005-08-09 16:03:21.000000000 +0200
+++ linux-2.6.13-rc6-getprlimit/kernel/sys.c	2005-08-17 23:56:40.000000000 +0200
@@ -1604,6 +1604,63 @@ asmlinkage long sys_setrlimit(unsigned i
 }
 
 /*
+ * As ptrace implies the ability to execute arbitrary code in the given
+ * process, which means that the calling process could obtain and set
+ * rlimits for that process without getprlimit/setprlimit anyways,
+ * we use the same permission checks as ptrace.
+ */
+
+static inline int prlim_check_perm(task_t *task)
+{
+	return ((current->uid == task->euid) &&
+		(current->uid == task->suid) &&
+		(current->uid == task->uid) &&
+		(current->gid == task->egid) &&
+		(current->gid == task->sgid) &&
+		(current->gid == task->gid)) || capable(CAP_SYS_RESOURCE);
+}
+
+asmlinkage long sys_getprlimit(pid_t pid, unsigned int resource,
+			       struct rlimit __user *rlim)
+{
+	struct rlimit value;
+	task_t *p;
+	int retval = -EINVAL;
+
+	if (resource >= RLIM_NLIMITS)
+		goto out_nounlock;
+
+	if (pid < 0)
+		goto out_nounlock;
+
+	retval = -ESRCH;
+	if (pid == 0) {
+		p = current;
+	} else {
+		read_lock(&tasklist_lock);
+		p = find_task_by_pid(pid);
+	}
+	if (p) {
+		retval = -EPERM;
+		if (!prlim_check_perm(p))
+			goto out_unlock;
+
+		task_lock(p->group_leader);
+		value = p->signal->rlim[resource];
+		task_unlock(p->group_leader);
+		retval = copy_to_user(rlim, &value, sizeof(*rlim)) ? -EFAULT : 0;
+	}
+	if (pid == 0)
+		goto out_nounlock;
+
+out_unlock:
+	read_unlock(&tasklist_lock);
+
+out_nounlock:
+	return retval;
+}
+
+/*
  * It would make sense to put struct rusage in the task_struct,
  * except that would make the task_struct be *really big*.  After
  * task_struct gets moved into malloc'ed memory, it would

