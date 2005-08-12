Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVHLRug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVHLRug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVHLRug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:50:36 -0400
Received: from chello062178225197.14.15.tuwien.teleweb.at ([62.178.225.197]:33747
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750762AbVHLRuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:50:35 -0400
Subject: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process
From: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Reply-To: e8607062@student.tuwien.ac.at
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Elliot Lee <sopwith@redhat.com>,
       Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Aug 2005 19:48:22 +0200
Message-Id: <1123868902.10923.5.camel@w2>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I'm a participant in Googles Summer of Code Program, doing an entry
level kernel project suggested by Fedora Core, "Getting and Setting
Process Resource Limits out of Process Space".

Rationale: Currently resource usage limits (rlimits) can only be set 
inside a process space, or inherited from the parent process. It 
would be useful to allow adjusting resource limits for running 
processes, e.g. tuning the resource usage of daemon processes under 
changing workloads without restarting them.

Implementation: This patch provides a new syscall getprlimit() for
reading a given process resource limits for i386. Its implementation
follows closely the getrlimit syscall. It is given a pid as an
additional argument. If the given pid equals zero the current process
rlimits are read and the behaviour resembles the behaviour of
getrlimit. Otherwise some checking on the validity of the given pid is
done and if the given process is found access is granted if

- the calling process holds the CAP_SYS_RESOURCE capability or
- the calling process uid equals the uid of the process whose rlimit
  is being read or
- the calling process uid equals the suid of the process whose rlimit
  is being read or
- the calling process euid equals the uid of the process whose rlimit
  is being read or
- the calling process euid equals the suid of the process whose 
  rlimit is being read

See the followup for the writing syscall. Additionally a
/proc/pid/rlimits interface for comfortable access is under
construction.

Simple programs for testing the syscalls can be found on
http://stud4.tuwien.ac.at/~e8607062/studies/soc/patches/


Signed-off-by: Wieland Gmeiner <e8607062@student.tuwien.ac.at>


diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-vanilla/arch/i386/kernel/syscall_table.S linux-2.6.13-rc6-rlim/arch/i386/kernel/syscall_table.S
--- linux-2.6.13-rc6-vanilla/arch/i386/kernel/syscall_table.S	2005-08-09 16:03:08.000000000 +0200
+++ linux-2.6.13-rc6-rlim/arch/i386/kernel/syscall_table.S	2005-08-09 15:06:54.000000000 +0200
@@ -294,3 +294,4 @@ ENTRY(sys_call_table)
 	.long sys_inotify_init
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
+        .long sys_getprlimit
diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-vanilla/include/asm-i386/unistd.h linux-2.6.13-rc6-rlim/include/asm-i386/unistd.h
--- linux-2.6.13-rc6-vanilla/include/asm-i386/unistd.h	2005-08-09 16:03:19.000000000 +0200
+++ linux-2.6.13-rc6-rlim/include/asm-i386/unistd.h	2005-08-09 15:07:46.000000000 +0200
@@ -299,8 +299,9 @@
 #define __NR_inotify_init	291
 #define __NR_inotify_add_watch	292
 #define __NR_inotify_rm_watch	293
+#define __NR_getprlimit         294
 
-#define NR_syscalls 294
+#define NR_syscalls 295
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
diff -uprN -X linux-2.6.13-rc6-vanilla/Documentation/dontdiff linux-2.6.13-rc6-vanilla/kernel/sys.c linux-2.6.13-rc6-rlim/kernel/sys.c
--- linux-2.6.13-rc6-vanilla/kernel/sys.c	2005-08-09 16:03:21.000000000 +0200
+++ linux-2.6.13-rc6-rlim/kernel/sys.c	2005-08-09 15:10:32.000000000 +0200
@@ -1603,6 +1603,47 @@ asmlinkage long sys_setrlimit(unsigned i
 	return 0;
 }
 
+asmlinkage long sys_getprlimit(pid_t pid, unsigned int resource, struct rlimit __user *rlim)
+{
+        struct rlimit value;
+        task_t *p;
+        int retval = -EINVAL;
+
+        if (resource >= RLIM_NLIMITS)
+                goto out_nounlock;
+
+        if (pid < 0)
+                goto out_nounlock;
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
+                if ((current->euid ^ p->suid) && (current->euid ^ p->uid) &&
+                    (current->uid ^ p->suid) && (current->uid ^ p->uid) &&
+                    !capable(CAP_SYS_RESOURCE))
+                        goto out_unlock;
+
+                task_lock(p->group_leader);
+                value = p->signal->rlim[resource];
+                task_unlock(p->group_leader);
+                retval = copy_to_user(rlim, &value, sizeof(*rlim)) ? -EFAULT : 0;
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

