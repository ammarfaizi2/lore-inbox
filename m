Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVEKTFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVEKTFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVEKTFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:05:55 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:49055 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261257AbVEKTF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:05:26 -0400
Date: Thu, 12 May 2005 00:46:54 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, V Srivatsa <vatsa@in.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050511191654.GA3916@in.ibm.com>
Reply-To: dino@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


cpusets+hotplug+preempt hangs up the machine, if both
cpuset and hotplug operations are going on simultaneously

I also get this oops first

scheduling while atomic: cpuoff.sh/0x00000001/25331
 [<c040195d>] schedule+0xa4d/0xa60
 [<c0401b25>] wait_for_completion+0xc5/0xf0
 [<c011a200>] default_wake_function+0x0/0x20
 [<c0400cd3>] __down+0x83/0x110
 [<c011a200>] default_wake_function+0x0/0x20
 [<c0400eab>] __down_failed+0x7/0xc
 [<c0141fe7>] .text.lock.cpuset+0x105/0x15e
 [<c011b860>] move_task_off_dead_cpu+0x130/0x1f0
 [<c011ba7c>] migrate_live_tasks+0x8c/0x90
 [<c011be25>] migration_call+0x75/0x2c0
 [<c01423f2>] __stop_machine_run+0x92/0xb0
 [<c012e0dd>] notifier_call_chain+0x2d/0x50
 [<c013a6fb>] cpu_down+0x16b/0x2a0
 [<c027ddfb>] store_online+0x5b/0x80
 [<c027ae15>] sysdev_store+0x35/0x40
 [<c019f43e>] flush_write_buffer+0x3e/0x50
 [<c019f4a8>] sysfs_write_file+0x58/0x80
 [<c0163d26>] vfs_write+0xc6/0x180
 [<c0163eb1>] sys_write+0x51/0x80
 [<c01034e5>] syscall_call+0x7/0xb

It looks like hotplug operations need to take cpuset_sem as well.

Here is a patch against 2.6.12-rc2-mm3. Should apply against rc3-mm3 as well
This has been tested and seems to fix the problem

        -Dinakar
                                                                
Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>



--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpusets-hot-preempt.patch"

diff -Naurp linux-2.6.12-rc2-mm3.orig/include/linux/cpuset.h linux-2.6.12-rc2-mm3-0/include/linux/cpuset.h
--- linux-2.6.12-rc2-mm3.orig/include/linux/cpuset.h	2005-05-11 19:44:42.000000000 +0530
+++ linux-2.6.12-rc2-mm3-0/include/linux/cpuset.h	2005-05-11 19:51:31.000000000 +0530
@@ -14,6 +14,10 @@
 
 #ifdef CONFIG_CPUSETS
 
+extern struct semaphore cpuset_sem;
+#define lock_cpuset_sem()	down(&cpuset_sem);
+#define unlock_cpuset_sem()	up(&cpuset_sem);
+
 extern int cpuset_init(void);
 extern void cpuset_init_smp(void);
 extern void cpuset_fork(struct task_struct *p);
@@ -29,6 +33,9 @@ extern char *cpuset_task_status_allowed(
 
 #else /* !CONFIG_CPUSETS */
 
+#define lock_cpuset_sem()	do { } while (0)
+#define unlock_cpuset_sem()	do { } while (0)
+
 static inline int cpuset_init(void) { return 0; }
 static inline void cpuset_init_smp(void) {}
 static inline void cpuset_fork(struct task_struct *p) {}
diff -Naurp linux-2.6.12-rc2-mm3.orig/kernel/cpu.c linux-2.6.12-rc2-mm3-0/kernel/cpu.c
--- linux-2.6.12-rc2-mm3.orig/kernel/cpu.c	2005-05-11 19:44:42.000000000 +0530
+++ linux-2.6.12-rc2-mm3-0/kernel/cpu.c	2005-05-11 19:46:38.000000000 +0530
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/unistd.h>
 #include <linux/cpu.h>
+#include <linux/cpuset.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/stop_machine.h>
@@ -82,6 +83,7 @@ int cpu_down(unsigned int cpu)
 
 	if ((err = lock_cpu_hotplug_interruptible()) != 0)
 		return err;
+	lock_cpuset_sem();
 
 	if (num_online_cpus() == 1) {
 		err = -EBUSY;
@@ -145,6 +147,7 @@ out_thread:
 out_allowed:
 	set_cpus_allowed(current, old_allowed);
 out:
+	unlock_cpuset_sem();
 	unlock_cpu_hotplug();
 	return err;
 }
@@ -157,6 +160,7 @@ int __devinit cpu_up(unsigned int cpu)
 
 	if ((ret = down_interruptible(&cpucontrol)) != 0)
 		return ret;
+	lock_cpuset_sem();
 
 	if (cpu_online(cpu) || !cpu_present(cpu)) {
 		ret = -EINVAL;
@@ -184,6 +188,7 @@ out_notify:
 	if (ret != 0)
 		notifier_call_chain(&cpu_chain, CPU_UP_CANCELED, hcpu);
 out:
+	unlock_cpuset_sem();
 	up(&cpucontrol);
 	return ret;
 }
diff -Naurp linux-2.6.12-rc2-mm3.orig/kernel/cpuset.c linux-2.6.12-rc2-mm3-0/kernel/cpuset.c
--- linux-2.6.12-rc2-mm3.orig/kernel/cpuset.c	2005-05-11 19:44:42.000000000 +0530
+++ linux-2.6.12-rc2-mm3-0/kernel/cpuset.c	2005-05-11 19:55:08.000000000 +0530
@@ -180,7 +180,7 @@ static struct super_block *cpuset_sb = N
  * for any special hack to ensure that top_cpuset cannot be deleted.
  */
 
-static DECLARE_MUTEX(cpuset_sem);
+DECLARE_MUTEX(cpuset_sem);
 
 /*
  * A couple of forward declarations required, due to cyclic reference loop:
@@ -1430,17 +1430,17 @@ void cpuset_exit(struct task_struct *tsk
  * attached to the specified @tsk.  Guaranteed to return some non-empty
  * subset of cpu_online_map, even if this means going outside the
  * tasks cpuset.
+ *
+ * Call with cpuset_sem held.
  **/
 
 cpumask_t cpuset_cpus_allowed(const struct task_struct *tsk)
 {
 	cpumask_t mask;
 
-	down(&cpuset_sem);
 	task_lock((struct task_struct *)tsk);
 	guarantee_online_cpus(tsk->cpuset, &mask);
 	task_unlock((struct task_struct *)tsk);
-	up(&cpuset_sem);
 
 	return mask;
 }
diff -Naurp linux-2.6.12-rc2-mm3.orig/kernel/sched.c linux-2.6.12-rc2-mm3-0/kernel/sched.c
--- linux-2.6.12-rc2-mm3.orig/kernel/sched.c	2005-05-11 19:44:42.000000000 +0530
+++ linux-2.6.12-rc2-mm3-0/kernel/sched.c	2005-05-11 19:48:29.000000000 +0530
@@ -3608,11 +3608,13 @@ long sched_setaffinity(pid_t pid, cpumas
 	cpumask_t cpus_allowed;
 
 	lock_cpu_hotplug();
+	lock_cpuset_sem();
 	read_lock(&tasklist_lock);
 
 	p = find_process_by_pid(pid);
 	if (!p) {
 		read_unlock(&tasklist_lock);
+		unlock_cpuset_sem();
 		unlock_cpu_hotplug();
 		return -ESRCH;
 	}
@@ -3636,6 +3638,7 @@ long sched_setaffinity(pid_t pid, cpumas
 
 out_unlock:
 	put_task_struct(p);
+	unlock_cpuset_sem();
 	unlock_cpu_hotplug();
 	return retval;
 }

--C7zPtVaVf+AK4Oqc--
