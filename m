Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWFWDAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWFWDAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 23:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWFWDAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 23:00:17 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:52460 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751089AbWFWDAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 23:00:15 -0400
Date: Fri, 23 Jun 2006 12:01:32 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, jeremy@goop.org,
       rdunlap@xenotime.net, clameter@sgi.com, ntl@pobox.com, akpm@osdl.org,
       ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] avoid cpu removal if busy revisited
Message-Id: <20060623120132.cd71dca8.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060623105058.96937576.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060623105058.96937576.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, a patch I sent was not up-to-date :(
This is newer one.  several typos and compile-error are fixed.

-Kame
==

Now, cpu hot remove migrates all tasks on target cpu by force.

During cpu-hot-remove, if tsk->cpus_allowed contains the only target
cpu of removal, tsk->cpus_allowd is disposed and the kernel migrate it to
random cpu.It's obvious that user-land configuration before cpu hot removal
is bad. But this is not good in carefully scheduled environment.

In this case,
1. ignore bad configuration in user-land just do warnings.
2. cancel cpu hot removal and warn users to fix the problem and retry.
seems to be a realisitc workaround. Killing the problematic process may
cause some trouble in user-land (dead-lock etc..)

This patch adds sysctl moderate_cpu_removal.
If moderate_cpu_removal == 0, all tasks are migrated by force.
If moderate_cpu_removal == 1, cpu_hotremoval can fail because of not-migratable
tasks.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



 include/linux/sysctl.h |    1 +
 kernel/sched.c         |   42 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c        |   13 +++++++++++++
 3 files changed, 56 insertions(+)

Index: linux-2.6.17.org/kernel/sched.c
===================================================================
--- linux-2.6.17.org.orig/kernel/sched.c
+++ linux-2.6.17.org/kernel/sched.c
@@ -4562,6 +4562,44 @@ wait_to_die:
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+/*
+ * if moderate_cpu_removal==1 (sysctl), cpu-hot-remove will fail if cpu is busy.
+ * Default value is 0. all tasks are forced to migrate.
+ */
+int moderate_cpu_removal;
+
+/*
+ * test there are tasks tightly coupled to the target cpu.
+ */
+static int test_cpu_busy(int cpu)
+{
+	cpumask_t mask;
+	int ret = 0;
+	pid_t pid = 0;
+	struct task_struct *p;
+	cpus_clear(mask);
+	cpu_set(cpu, mask);
+
+	read_lock(&tasklist_lock);
+	for_each_process(p) {
+		if (p == current)
+			continue;
+		if (p->mm && cpus_equal(mask, p->cpus_allowed)) {
+			ret = 1;
+			pid = p->pid;
+			break;
+		}
+	}
+	read_unlock(&tasklist_lock);
+	if (ret) {
+		printk(KERN_ERR "cpu(%d) is busy because of task(%d)\n",
+			cpu, pid);
+		printk(KERN_ERR "adjust task(%d) configuration or set "
+			"moderate_cpu_removal to 0 to remove cpu %d\n",
+			pid, cpu);
+	}
+	return ret;
+}
 /* Figure out where task on dead CPU should go, use force if neccessary. */
 static void move_task_off_dead_cpu(int dead_cpu, struct task_struct *tsk)
 {
@@ -4752,6 +4790,10 @@ static int migration_call(struct notifie
 		kthread_stop(cpu_rq(cpu)->migration_thread);
 		cpu_rq(cpu)->migration_thread = NULL;
 		break;
+	case CPU_DOWN_PREPARE:
+		if (moderate_cpu_removal && test_cpu_busy(cpu))
+			return NOTIFY_BAD;
+		break;
 	case CPU_DEAD:
 		migrate_live_tasks(cpu);
 		rq = cpu_rq(cpu);
Index: linux-2.6.17.org/kernel/sysctl.c
===================================================================
--- linux-2.6.17.org.orig/kernel/sysctl.c
+++ linux-2.6.17.org/kernel/sysctl.c
@@ -78,6 +78,9 @@ int unknown_nmi_panic;
 extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
 				  void __user *, size_t *, loff_t *);
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+int moderate_cpu_removal;
+#endif
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -683,6 +686,16 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	{
+		.ctl_name	= KERN_MODERATE_CPU_REMOVAL,
+		.procname	= "moderate_cpu_removal",
+		.data		= &moderate_cpu_removal,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
Index: linux-2.6.17.org/include/linux/sysctl.h
===================================================================
--- linux-2.6.17.org.orig/include/linux/sysctl.h
+++ linux-2.6.17.org/include/linux/sysctl.h
@@ -148,6 +148,7 @@ enum
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_MODERATE_CPU_REMOVAL=73, /* int: disallow forced cpu removal */
 };
 
 

