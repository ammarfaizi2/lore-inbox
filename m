Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965458AbWFTDu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965458AbWFTDu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 23:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965460AbWFTDu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 23:50:58 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:16322 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965458AbWFTDu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 23:50:57 -0400
Date: Tue, 20 Jun 2006 12:51:59 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ashok.raj@intel.com, pavel@ucw.cz, clameter@sgi.com, ak@suse.de,
       nickpiggin@yahoo.com.au, mingo@elte.hu, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] stop on cpu lost
Message-Id: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the application is mis-configurated at cpu hot removal, a task's 
cpus_allowd can be empty. this patch adds sysctl to stop tasks whose 
cpus_allowed is empty.

I think there isn't one good answer to handle this problem and this is
depend on system management policy. In a system, forced migration is better 
than stop. In another, stopping tasks (and killing) will meet requirement.

How about this ?

-Kame

Now, when a task loses all of its allowed cpus because of cpu hot removal,
it will be foreced to migrate to not-allowed cpus.

In this case, the task is not properly reconfigurated by a user before
cpu-hot-removal. Here, the task (and system) is in a unexpeced wrong state.
This migration is maybe one of realistic workarounds. But sometimes it will be
harmfull.
(stealing other cpu time, making bugs in thread controllers, do some unexpected
 execution...)

This patch adds sysctl "sigstop_on_cpu_lost". When sigstop_on_cpu_lost==1,
a task which losts is cpu will be stopped by SIGSTOP.
Depends on system management policy, mis-configurated applications are stopped.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


 include/linux/sysctl.h |    1 +
 kernel/sched.c         |   14 ++++++++++++++
 kernel/sysctl.c        |   14 ++++++++++++++
 3 files changed, 29 insertions(+)

Index: linux-2.6.17/kernel/sched.c
===================================================================
--- linux-2.6.17.orig/kernel/sched.c
+++ linux-2.6.17/kernel/sched.c
@@ -4562,11 +4562,13 @@ wait_to_die:
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+int sigstop_on_cpu_lost;
 /* Figure out where task on dead CPU should go, use force if neccessary. */
 static void move_task_off_dead_cpu(int dead_cpu, struct task_struct *tsk)
 {
 	int dest_cpu;
 	cpumask_t mask;
+	int force = 0;
 
 	/* On same node? */
 	mask = node_to_cpumask(cpu_to_node(dead_cpu));
@@ -4591,8 +4593,20 @@ static void move_task_off_dead_cpu(int d
 			printk(KERN_INFO "process %d (%s) no "
 			       "longer affine to cpu%d\n",
 			       tsk->pid, tsk->comm, dead_cpu);
+		/*
+		 * This thread is not properly reconfigurated before cpu hot
+		 * remove. This means this process is in the wrong state now.
+		 * If system management policy doesn't allow mis-configurated
+		 * applications, this process should be stopped.
+		 */
+		if (tsk->mm && sigstop_on_cpu_lost)
+			force = 1;
 	}
 	__migrate_task(tsk, dead_cpu, dest_cpu);
+
+	if (force) {
+		force_sig_specific(SIGSTOP, tsk);
+	}
 }
 
 /*
Index: linux-2.6.17/kernel/sysctl.c
===================================================================
--- linux-2.6.17.orig/kernel/sysctl.c
+++ linux-2.6.17/kernel/sysctl.c
@@ -127,6 +127,10 @@ extern int sysctl_hz_timer;
 extern int acct_parm[];
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern int sigstop_on_cpu_lost;
+#endif
+
 #ifdef CONFIG_IA64
 extern int no_unaligned_warning;
 #endif
@@ -683,6 +687,16 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	{
+		.ctl_name	= KERN_STOP_ON_CPU_LOST,
+		.procname	= "sigstop_on_cpu_lost",
+		.data		= &sigstop_on_cpu_lost,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
Index: linux-2.6.17/include/linux/sysctl.h
===================================================================
--- linux-2.6.17.orig/include/linux/sysctl.h
+++ linux-2.6.17/include/linux/sysctl.h
@@ -148,6 +148,7 @@ enum
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_STOP_ON_CPU_LOST=73, /* int: SIGSTOP when a task losts its cpus */
 };
 
 

