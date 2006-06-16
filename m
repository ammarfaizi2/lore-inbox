Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWFPQqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWFPQqh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 12:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWFPQqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 12:46:37 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:53984 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751493AbWFPQqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 12:46:36 -0400
Date: Sat, 17 Jun 2006 01:46:23 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, ashok.raj@intel.com, ak@suse.de
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT
 tasks.
Message-Id: <20060617014623.8f820e8b.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0606160908120.14330@schroedinger.engr.sgi.com>
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0606160908120.14330@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006 09:09:22 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Fri, 16 Jun 2006, KAMEZAWA Hiroyuki wrote:
> 
> > When cpu hot remove happens, tasks on the target cpu will be migrated even if
> > no available cpus in tsk->cpus_allowed. (See: move_task_off_dead_cpu().)
> 
> Could we kill the process instead? If a process has been forced to run on 
> a certain cpu then it is an error to migrate it to a different one. If a 
> system wiil do cpu hot remove then the system needs to be configured in 
> such a way as to allow processes to be migrated to other processors.
> 
How about this ? SIGKILL is better ?
(I'm a bit afraid that this force_sig is safe or not...)

good night..
-Kame
===
This patch adds sysctl "stop derailed process".

If stop_derailed_process == 1, a process will be stopped by SIGSTOP
which has cpu affinity but is forced to migrate to an unexpected cpu .

This will prevent unexpected trouble in multi-threaded application whose threads 
are tightly coupled to specified cpus.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 include/linux/sysctl.h |    1 +
 kernel/sched.c         |   11 +++++++++++
 kernel/sysctl.c        |   14 ++++++++++++++
 3 files changed, 26 insertions(+)

Index: linux-2.6.17-rc6-mm2/kernel/sched.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/sched.c
+++ linux-2.6.17-rc6-mm2/kernel/sched.c
@@ -4953,11 +4953,16 @@ wait_to_die:
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-/* Figure out where task on dead CPU should go, use force if neccessary. */
+int stop_derailed_process;
+
+/* Figure out where task on dead CPU should go, use force if neccessary.
+   if stop_derailed_process sysctl is 1, processes migrated to unexpected
+   cpus will stop.*/
 static void move_task_off_dead_cpu(int dead_cpu, struct task_struct *tsk)
 {
 	int dest_cpu;
 	cpumask_t mask;
+	int force = 0;
 
 	/* On same node? */
 	mask = node_to_cpumask(cpu_to_node(dead_cpu));
@@ -4982,8 +4987,16 @@ static void move_task_off_dead_cpu(int d
 			printk(KERN_INFO "process %d (%s) no "
 			       "longer affine to cpu%d\n",
 			       tsk->pid, tsk->comm, dead_cpu);
+		if (tsk->mm && stop_derailed_process) {
+			force = 1;
+			printk(KERN_INFO, "process %d (%s) is stopped "
+			       "by stop_derailed_process sysctl\n",
+				tsk->pid, tsk->comm);
+		}
 	}
 	__migrate_task(tsk, dead_cpu, dest_cpu);
+	if (force)
+		force_sig_specific(SIGSTOP, tsk);
 }
 
 /*
Index: linux-2.6.17-rc6-mm2/kernel/sysctl.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/kernel/sysctl.c
+++ linux-2.6.17-rc6-mm2/kernel/sysctl.c
@@ -90,6 +90,10 @@ extern int proc_nmi_enabled(struct ctl_t
 			void __user *, size_t *, loff_t *);
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern int stop_derailed_process;
+#endif
+
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
 static int minolduid;
@@ -784,6 +788,16 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	{
+		.ctl_name	= KERN_STOP_DERAILED_PROC,
+		.procname	= "stop_derailed_process",
+		.data		= &stop_derailed_process,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	}
+#endif
 
 	{ .ctl_name = 0 }
 };
Index: linux-2.6.17-rc6-mm2/include/linux/sysctl.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/sysctl.h
+++ linux-2.6.17-rc6-mm2/include/linux/sysctl.h
@@ -153,6 +153,7 @@ enum
 	KERN_NMI_WATCHDOG=74, /* int: enable/disable nmi watchdog */
 	KERN_PANIC_ON_NMI=75, /* int: whether we will panic on an unrecovered */
 	KERN_MAX_LOCK_DEPTH=76,
+	KERN_STOP_DERAILED_PROCESS=77, /* int: stop cpu bound process if the cpu is removed */
 };
 
 

