Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSLTOlD>; Fri, 20 Dec 2002 09:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbSLTOlD>; Fri, 20 Dec 2002 09:41:03 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:46213 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262360AbSLTOk6>; Fri, 20 Dec 2002 09:40:58 -0500
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: [PATCH 2.5.52] NUMA scheduler: cputimes stats
Date: Fri, 20 Dec 2002 15:49:09 +0100
User-Agent: KMail/1.4.3
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200211061734.42713.efocht@ess.nec.de> <200212021629.39060.efocht@ess.nec.de> <200212181721.39434.efocht@ess.nec.de>
In-Reply-To: <200212181721.39434.efocht@ess.nec.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_XHAF22CLCZ7FMKE86DV2"
Message-Id: <200212201549.09864.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_XHAF22CLCZ7FMKE86DV2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The attached patch is needed for evaluating and understanding
scheduler and load balancer activity. It adds back to the kernel per
CPU user and system time statistics for each process in /proc/PID/cpu,
a feature which was around for ages and went lost in 2.5.50.

Regards,
Erich

On Wednesday 18 December 2002 17:21, Erich Focht wrote:
> This is the first part of the minimal NUMA scheduler built on top of
> the O(1) load balancer. It is rediffed for 2.5.52 and contains a small
> bugfix in build_node_data().
>
> The two patches are:
>
> 01-numa-sched-core-2.5.52-23.patch: core NUMA scheduler infrastructure
>   providing a node aware load_balancer.
>
> 02-numa-sched-ilb-2.5.52-21.patch: initial load balancing, selects
>   least loaded node & CPU at exec().
>
> Regards,
> Erich

--------------Boundary-00=_XHAF22CLCZ7FMKE86DV2
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="03-cputimes_stat-2.5.52.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="03-cputimes_stat-2.5.52.patch"

diff -urN a/fs/proc/array.c b/fs/proc/array.c
--- a/fs/proc/array.c	2002-12-16 03:08:11.000000000 +0100
+++ b/fs/proc/array.c	2002-12-20 15:40:41.000000000 +0100
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
--- a/fs/proc/base.c	2002-12-16 03:08:11.000000000 +0100
+++ b/fs/proc/base.c	2002-12-20 15:40:42.000000000 +0100
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
--- a/include/linux/sched.h	2002-12-18 16:54:40.000000000 +0100
+++ b/include/linux/sched.h	2002-12-20 15:40:42.000000000 +0100
@@ -354,6 +354,9 @@
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
--- a/kernel/fork.c	2002-12-16 03:07:44.000000000 +0100
+++ b/kernel/fork.c	2002-12-20 15:40:42.000000000 +0100
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
--- a/kernel/timer.c	2002-12-16 03:07:52.000000000 +0100
+++ b/kernel/timer.c	2002-12-20 15:40:42.000000000 +0100
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

--------------Boundary-00=_XHAF22CLCZ7FMKE86DV2--

