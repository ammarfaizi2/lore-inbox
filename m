Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbTGRQTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271872AbTGRQSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:18:03 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:686 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S271859AbTGRQRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:17:32 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: LSE <lse-tech@lists.sourceforge.net>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.0-test1] per cpu times
Date: Fri, 18 Jul 2003 18:35:42 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eHCG/dGwkNXN72u"
Message-Id: <200307181835.42454.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_eHCG/dGwkNXN72u
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch brings back the per CPU user & system times which one was
used to see in /proc/PID/cpu with 2.4 kernels. Useful for SMP and NUMA
scheduler development, needed for reasonable output in numabench /
numa_test.

Regards,
Erich



--Boundary-00=_eHCG/dGwkNXN72u
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="cputimes_stat-2.6.0t1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cputimes_stat-2.6.0t1.patch"

diff -urN 2.6.0-test1-ia64-0/fs/proc/array.c 2.6.0-test1-ia64-na/fs/proc/array.c
--- 2.6.0-test1-ia64-0/fs/proc/array.c	2003-07-14 05:35:12.000000000 +0200
+++ 2.6.0-test1-ia64-na/fs/proc/array.c	2003-07-18 13:38:02.000000000 +0200
@@ -405,3 +405,26 @@
 	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
 		       size, resident, shared, text, lib, data, 0);
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
diff -urN 2.6.0-test1-ia64-0/fs/proc/base.c 2.6.0-test1-ia64-na/fs/proc/base.c
--- 2.6.0-test1-ia64-0/fs/proc/base.c	2003-07-14 05:35:15.000000000 +0200
+++ 2.6.0-test1-ia64-na/fs/proc/base.c	2003-07-18 13:38:02.000000000 +0200
@@ -56,6 +56,7 @@
 	PROC_PID_STAT,
 	PROC_PID_STATM,
 	PROC_PID_MAPS,
+	PROC_PID_CPU,
 	PROC_PID_MOUNTS,
 	PROC_PID_WCHAN,
 #ifdef CONFIG_SECURITY
@@ -83,6 +84,9 @@
   E(PROC_PID_CMDLINE,	"cmdline",	S_IFREG|S_IRUGO),
   E(PROC_PID_STAT,	"stat",		S_IFREG|S_IRUGO),
   E(PROC_PID_STATM,	"statm",	S_IFREG|S_IRUGO),
+#ifdef CONFIG_SMP
+  E(PROC_PID_CPU,	"cpu",		S_IFREG|S_IRUGO),
+#endif
   E(PROC_PID_MAPS,	"maps",		S_IFREG|S_IRUGO),
   E(PROC_PID_MEM,	"mem",		S_IFREG|S_IRUSR|S_IWUSR),
   E(PROC_PID_CWD,	"cwd",		S_IFLNK|S_IRWXUGO),
@@ -1170,6 +1174,12 @@
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_stat;
 			break;
+#ifdef CONFIG_SMP
+		case PROC_PID_CPU:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_cpu;
+			break;
+#endif
 		case PROC_PID_CMDLINE:
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_cmdline;
diff -urN 2.6.0-test1-ia64-0/include/linux/sched.h 2.6.0-test1-ia64-na/include/linux/sched.h
--- 2.6.0-test1-ia64-0/include/linux/sched.h	2003-07-14 05:30:40.000000000 +0200
+++ 2.6.0-test1-ia64-na/include/linux/sched.h	2003-07-18 13:38:02.000000000 +0200
@@ -390,6 +390,9 @@
 	struct list_head posix_timers; /* POSIX.1b Interval Timers */
 	unsigned long utime, stime, cutime, cstime;
 	u64 start_time;
+#ifdef CONFIG_SMP
+	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
+#endif
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 /* process credentials */
diff -urN 2.6.0-test1-ia64-0/kernel/fork.c 2.6.0-test1-ia64-na/kernel/fork.c
--- 2.6.0-test1-ia64-0/kernel/fork.c	2003-07-14 05:30:39.000000000 +0200
+++ 2.6.0-test1-ia64-na/kernel/fork.c	2003-07-18 13:38:02.000000000 +0200
@@ -861,6 +861,14 @@
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
 	p->start_time = get_jiffies_64();
diff -urN 2.6.0-test1-ia64-0/kernel/timer.c 2.6.0-test1-ia64-na/kernel/timer.c
--- 2.6.0-test1-ia64-0/kernel/timer.c	2003-07-14 05:37:22.000000000 +0200
+++ 2.6.0-test1-ia64-na/kernel/timer.c	2003-07-18 13:38:02.000000000 +0200
@@ -720,6 +720,10 @@
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

--Boundary-00=_eHCG/dGwkNXN72u--

