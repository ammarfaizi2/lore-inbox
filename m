Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSLaNYd>; Tue, 31 Dec 2002 08:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbSLaNYc>; Tue, 31 Dec 2002 08:24:32 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:28294 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S263105AbSLaNY2>; Tue, 31 Dec 2002 08:24:28 -0500
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: [PATCH 2.5.53] NUMA scheduler (3/3)
Date: Tue, 31 Dec 2002 14:30:48 +0100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200211061734.42713.efocht@ess.nec.de> <200212181721.39434.efocht@ess.nec.de> <200212311429.04382.efocht@ess.nec.de>
In-Reply-To: <200212311429.04382.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_C7KZ5RHG3KM14K1CRIC5"
Message-Id: <200212311430.49001.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_C7KZ5RHG3KM14K1CRIC5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=2E.. and the third patch ...

On Tuesday 31 December 2002 14:29, Erich Focht wrote:
> Here comes the minimal NUMA scheduler built on top of the O(1) load
> balancer rediffed for 2.5.53 with some changes in the core part. As
> suggested by Michael, I added the cputimes_stat patch, as it is
> absolutely needed for understanding the scheduler behavior.
>
> The three patches:
> 01-numa-sched-core-2.5.53-24.patch: core NUMA scheduler infrastructure
>   providing a node aware load_balancer. Cosmetic changes + more comment=
s.
>
> 02-numa-sched-ilb-2.5.53-21.patch: initial load balancing, selects
>   least loaded node & CPU at exec().
>
> 03-cputimes_stat-2.5.53.patch: adds back to the kernel per CPU user
>   and system time statistics for each process in /proc/PID/cpu. Needed
>   for evaluating scheduler behavior and performance of tasks running
>   on SMP and NUMA systems.
>
> Regards,
> Erich

--------------Boundary-00=_C7KZ5RHG3KM14K1CRIC5
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="03-cputimes_stat-2.5.53.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="03-cputimes_stat-2.5.53.patch"

diff -urN a/fs/proc/array.c b/fs/proc/array.c
--- a/fs/proc/array.c	2002-12-24 06:20:36.000000000 +0100
+++ b/fs/proc/array.c	2002-12-31 14:19:15.000000000 +0100
@@ -597,3 +597,26 @@
 out:
 	return retval;
 }
+
+#ifdef CONFIG_SMP
+int proc_pid_cpu(struct task_struct *task, char * buffer)
+{
+	int i, len;
+
+	len = sprintf(buffer,
+		"cpu  %lu %lu\n",
+		jiffies_to_clock_t(task->utime),
+		jiffies_to_clock_t(task->stime));
+		
+	for (i = 0 ; i < NR_CPUS; i++) {
+		if (cpu_online(i))
+		len += sprintf(buffer + len, "cpu%d %lu %lu\n",
+			i,
+			jiffies_to_clock_t(task->per_cpu_utime[i]),
+			jiffies_to_clock_t(task->per_cpu_stime[i]));
+
+	}
+	len += sprintf(buffer + len, "current_cpu %d\n",task_cpu(task));
+	return len;
+}
+#endif
diff -urN a/fs/proc/base.c b/fs/proc/base.c
--- a/fs/proc/base.c	2002-12-24 06:20:39.000000000 +0100
+++ b/fs/proc/base.c	2002-12-31 14:19:15.000000000 +0100
@@ -55,6 +55,7 @@
 	PROC_PID_STAT,
 	PROC_PID_STATM,
 	PROC_PID_MAPS,
+	PROC_PID_CPU,
 	PROC_PID_MOUNTS,
 	PROC_PID_WCHAN,
 	PROC_PID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
@@ -75,6 +76,9 @@
   E(PROC_PID_CMDLINE,	"cmdline",	S_IFREG|S_IRUGO),
   E(PROC_PID_STAT,	"stat",		S_IFREG|S_IRUGO),
   E(PROC_PID_STATM,	"statm",	S_IFREG|S_IRUGO),
+#ifdef CONFIG_SMP
+  E(PROC_PID_CPU,	"cpu",		S_IFREG|S_IRUGO),
+#endif
   E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUGO),
   E(PROC_PID_MEM,	"mem",		S_IFREG|S_IRUSR|S_IWUSR),
   E(PROC_PID_CWD,	"cwd",		S_IFLNK|S_IRWXUGO),
@@ -1026,7 +1030,12 @@
 		case PROC_PID_MAPS:
 			inode->i_fop = &proc_maps_operations;
 			break;
-
+#ifdef CONFIG_SMP
+		case PROC_PID_CPU:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_cpu;
+			break;
+#endif
 		case PROC_PID_MEM:
 			inode->i_op = &proc_mem_inode_operations;
 			inode->i_fop = &proc_mem_operations;
diff -urN a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2002-12-31 14:17:13.000000000 +0100
+++ b/include/linux/sched.h	2002-12-31 14:19:15.000000000 +0100
@@ -340,6 +340,9 @@
 	struct timer_list real_timer;
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long start_time;
+#ifdef CONFIG_SMP
+	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
+#endif
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 	int swappable:1;
diff -urN a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	2002-12-24 06:19:35.000000000 +0100
+++ b/kernel/fork.c	2002-12-31 14:19:15.000000000 +0100
@@ -795,6 +795,14 @@
 	p->tty_old_pgrp = 0;
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
+#ifdef CONFIG_SMP
+	{
+		int i;
+
+		for(i = 0; i < NR_CPUS; i++)
+			p->per_cpu_utime[i] = p->per_cpu_stime[i] = 0;
+	}
+#endif
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = jiffies;
diff -urN a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	2002-12-24 06:19:51.000000000 +0100
+++ b/kernel/timer.c	2002-12-31 14:19:15.000000000 +0100
@@ -695,6 +695,10 @@
 void update_one_process(struct task_struct *p, unsigned long user,
 			unsigned long system, int cpu)
 {
+#ifdef CONFIG_SMP
+	p->per_cpu_utime[cpu] += user;
+	p->per_cpu_stime[cpu] += system;
+#endif
 	do_process_times(p, user, system);
 	do_it_virt(p, user);
 	do_it_prof(p);

--------------Boundary-00=_C7KZ5RHG3KM14K1CRIC5--

