Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932915AbWFWHil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915AbWFWHil (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 03:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932918AbWFWHil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 03:38:41 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:52357 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932915AbWFWHik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 03:38:40 -0400
Date: Fri, 23 Jun 2006 16:40:42 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: pavel@suse.cz, Jeremy Fitzhardinge <jeremy@goop.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, clameter@sgi.com, ntl@pobox.com,
       akpm@osdl.org, ashok.raj@intel.com, ak@suse.de, nickpiggin@yahoo.com.au,
       mingo@elte.hu
Subject: [RFC][PATCH] avoid cpu hot removal if busy take3
Message-Id: <20060623164042.3a828e8e.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At first I'm sorry that a patch I sent was too messy.
This is updated one. tested on ia64 SMP and works well.

This is the log of failure of cpu-hot-removal. 
==
Jun 23 16:14:26 casares kernel: cpu(1) is busy because of task(6512)
Jun 23 16:14:26 casares kernel: adjust task(6512)'s cpu affinity  or set cpu_remo
va_migration to 1 to remove cpu 1
Jun 23 16:14:26 casares kernel: cpu_down: attempt to take down CPU 1 failed
==
I think this includes enough information for sysadmin.

Changelog V2 -> V3
- changes the name and the meaning of sysctl. 
- bug fixes

-Kame
==

Now, cpu hot remove migrates all tasks on target cpu by force.

During cpu-hot-remove, if tsk->cpus_allowed contains the only target
cpu of removal, tsk->cpus_allowd is disposed and the kernel migrate it to
any cpu at random. It's obvious that user-land configuration before cpu hot
removal was bad. This looks a realisitc workaround, but this is not good in
carefully scheduled environment.

In this case,
1. ignore bad configuration in user-land just do warnings.
2. cancel cpu hot removal and warn users to fix the problem and retry.
seems to be a realisitc workaround. Killing the problematic process may
cause some trouble in user-land (dead-lock etc..)

This patch adds sysctl cpu_removal_migration.
If cpu_removal_migration == 1, all tasks are migrated by force.
If cpu_removal_migration == 0, cpu_hotremoval can fail because of not-migratable
tasks.

Note: cpu scheduler's notifier chain has the highest priority. then, this
      failure detection will be done at first.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



 include/linux/sysctl.h |    1 +
 kernel/sched.c         |   44 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c        |   13 +++++++++++++
 3 files changed, 58 insertions(+)

Index: linux-2.6.17.cputest/kernel/sched.c
===================================================================
--- linux-2.6.17.cputest.orig/kernel/sched.c	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.cputest/kernel/sched.c	2006-06-23 15:25:21.000000000 +0900
@@ -4562,6 +4562,46 @@
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
+/*
+ * if cpu_removal_migration=0(sysctl), cpu-hot-remove will fail if cpu is busy.
+ * Default value is 1. all tasks are forced to migrate.
+ */
+int cpu_removal_migration = 1;
+
+/*
+ * test there are tasks tightly coupled to the target cpu.
+ * This is called only when cpu_removal_migration = 0.
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
+		printk(KERN_ERR "adjust task(%d)'s cpu affinity  or set "
+			"cpu_remova_migration to 1 to remove cpu %d\n",
+			pid, cpu);
+	}
+	return ret;
+}
+
 /* Figure out where task on dead CPU should go, use force if neccessary. */
 static void move_task_off_dead_cpu(int dead_cpu, struct task_struct *tsk)
 {
@@ -4752,6 +4792,10 @@
 		kthread_stop(cpu_rq(cpu)->migration_thread);
 		cpu_rq(cpu)->migration_thread = NULL;
 		break;
+	case CPU_DOWN_PREPARE:
+		if (!cpu_removal_migration && test_cpu_busy(cpu))
+			return NOTIFY_BAD;
+		break;
 	case CPU_DEAD:
 		migrate_live_tasks(cpu);
 		rq = cpu_rq(cpu);
Index: linux-2.6.17.cputest/kernel/sysctl.c
===================================================================
--- linux-2.6.17.cputest.orig/kernel/sysctl.c	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.cputest/kernel/sysctl.c	2006-06-23 15:25:21.000000000 +0900
@@ -78,6 +78,9 @@
 extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
 				  void __user *, size_t *, loff_t *);
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+extern int cpu_removal_migration;
+#endif
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -683,6 +686,16 @@
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	{
+		.ctl_name	= KERN_CPU_REMOVAL_MIGRATION,
+		.procname	= "cpu_removal_migration",
+		.data		= &cpu_removal_migration,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
Index: linux-2.6.17.cputest/include/linux/sysctl.h
===================================================================
--- linux-2.6.17.cputest.orig/include/linux/sysctl.h	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.cputest/include/linux/sysctl.h	2006-06-23 15:33:34.000000000 +0900
@@ -148,6 +148,7 @@
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_CPU_REMOVAL_MIGRATION=73, /* int: allow forced migration at cpu removal */
 };
 
 

