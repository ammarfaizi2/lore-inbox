Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266464AbSLDMgn>; Wed, 4 Dec 2002 07:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbSLDMgm>; Wed, 4 Dec 2002 07:36:42 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:40155 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S266464AbSLDMgc>; Wed, 4 Dec 2002 07:36:32 -0500
From: Erich Focht <efocht@ess.nec.de>
To: Andrew Morton <akpm@zip.com.au>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: per cpu time statistics
Date: Wed, 4 Dec 2002 13:43:39 +0100
User-Agent: KMail/1.4.3
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       LSE <lse-tech@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_R0IL0IH97J1G7SCM9EHG"
Message-Id: <200212041343.39734.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_R0IL0IH97J1G7SCM9EHG
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Andrew, Bill,

I had to learn from Michael Hohnbaum that you've eliminated the per
CPU time statistics in 2.5.50 (akpm changeset from Nov. 26). Reading
the cset comments I understood that the motivation was to save
8*NR_CPUS bytes of memory in the task_struct. Maybe that was really an
issue at the time when Bill suggested the patch (July), but in the
mean time we got configurable NR_CPUS (October) and that small amount
of additional memory really doesn't matter. Most people running SMP
have 2 CPUs.

I wasn't aware of the patch and the RFC from Bill, otherwise I would
have "shouted" long time ago. My fault... BTW: did that RFC go to the
LSE mailing list, too? I can't remember. But that's the place were I'd
expect to find people interested in such issues.

When digging in the kernel archives I found:

wli> On Tue, Jul 16, 2002 at 11:12:32AM +0100, Alan Cox wrote:
wli> > A PS: to that. I'm not opposed to removing them. I'd prefer them l=
eft
wli> > around in the kernel debugging options though
wli>=20
wli> In that case, I can make it conditional on something like
wli> CONFIG_DEBUG_SCHED, which option of course would go in the "Kernel H=
acking"
wli> section.
wli>=20
wli> Cheers,
wli> Bill

I find this idea better than just eliminating the only way of finding
out on which CPUs a task has spent its time. This is an essential
question when investigating the performance on SMP and NUMA systems.

For those who miss this feature I'm attaching a patch doing what wli
suggested. The config option is CONFIG_CPUS_STAT and can be found in
the "Kernel Hacking" menu, as wli suggested. Just didn't like
DEBUG_SCHED, we want to monitor the statistics and this is not
necessarily related to bugs in the scheduler. Also added as last line
in /proc/pid/cpu the current CPU of the task. It's often needed and
/proc/pid/stat is much too cryptic.

Regards,

Erich

--------------Boundary-00=_R0IL0IH97J1G7SCM9EHG
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="cputimes_stat-2.5.50.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cputimes_stat-2.5.50.patch"

diff -urN a/arch/alpha/Kconfig b/arch/alpha/Kconfig
--- a/arch/alpha/Kconfig	2002-11-27 23:36:17.000000000 +0100
+++ b/arch/alpha/Kconfig	2002-12-04 13:16:56.000000000 +0100
@@ -997,6 +997,14 @@
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on DEBUG_KERNEL && SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 config MATHEMU
 	tristate "Kernel FP software completion" if DEBUG_KERNEL
 	default y if !DEBUG_KERNEL
diff -urN a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2002-11-27 23:35:50.000000000 +0100
+++ b/arch/i386/Kconfig	2002-12-04 13:13:07.000000000 +0100
@@ -1551,6 +1551,14 @@
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on DEBUG_KERNEL && SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
diff -urN a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig	2002-11-27 23:36:20.000000000 +0100
+++ b/arch/ia64/Kconfig	2002-12-04 13:13:43.000000000 +0100
@@ -813,6 +813,14 @@
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on DEBUG_KERNEL && SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 config KALLSYMS
 	bool "Load all symbols for debugging/kksymoops"
 	depends on DEBUG_KERNEL
diff -urN a/arch/mips/Kconfig b/arch/mips/Kconfig
--- a/arch/mips/Kconfig	2002-11-27 23:36:00.000000000 +0100
+++ b/arch/mips/Kconfig	2002-12-04 13:19:56.000000000 +0100
@@ -1284,6 +1284,14 @@
 	  Say Y here if you are compiling the kernel on a different
 	  architecture than the one it is intended to run on.
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 config REMOTE_DEBUG
 	bool "Remote GDB kernel debugging"
 	depends on SERIAL=y || AU1000_UART
diff -urN a/arch/mips64/Kconfig b/arch/mips64/Kconfig
--- a/arch/mips64/Kconfig	2002-11-27 23:35:55.000000000 +0100
+++ b/arch/mips64/Kconfig	2002-12-04 13:20:09.000000000 +0100
@@ -692,6 +692,14 @@
 	  Say Y here if you are compiling the kernel on a different
 	  architecture than the one it is intended to run on.
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 config MIPS_FPE_MODULE
 	bool "Build fp exception handler module"
 	depends on MODULES
diff -urN a/arch/parisc/Kconfig b/arch/parisc/Kconfig
--- a/arch/parisc/Kconfig	2002-11-27 23:36:05.000000000 +0100
+++ b/arch/parisc/Kconfig	2002-12-04 13:18:46.000000000 +0100
@@ -415,6 +415,14 @@
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on DEBUG_KERNEL && SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 config DEBUG_SLAB
 	bool "Debug memory allocations"
 	depends on DEBUG_KERNEL
diff -urN a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2002-11-27 23:36:22.000000000 +0100
+++ b/arch/ppc/Kconfig	2002-12-04 13:19:29.000000000 +0100
@@ -1789,6 +1789,14 @@
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on DEBUG_KERNEL && SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 config DEBUG_SLAB
 	bool "Debug memory allocations"
 	depends on DEBUG_KERNEL
diff -urN a/arch/ppc64/Kconfig b/arch/ppc64/Kconfig
--- a/arch/ppc64/Kconfig	2002-11-27 23:36:01.000000000 +0100
+++ b/arch/ppc64/Kconfig	2002-12-04 13:20:37.000000000 +0100
@@ -499,6 +499,14 @@
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on DEBUG_KERNEL && SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 config DEBUG_SLAB
 	bool "Debug memory allocations"
 	depends on DEBUG_KERNEL
diff -urN a/arch/s390/Kconfig b/arch/s390/Kconfig
--- a/arch/s390/Kconfig	2002-11-27 23:35:57.000000000 +0100
+++ b/arch/s390/Kconfig	2002-12-04 13:21:32.000000000 +0100
@@ -303,6 +303,14 @@
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 endmenu
 
 source "security/Kconfig"
diff -urN a/arch/s390x/Kconfig b/arch/s390x/Kconfig
--- a/arch/s390x/Kconfig	2002-11-27 23:36:01.000000000 +0100
+++ b/arch/s390x/Kconfig	2002-12-04 13:22:18.000000000 +0100
@@ -312,6 +312,14 @@
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 endmenu
 
 source "security/Kconfig"
diff -urN a/arch/sparc/Kconfig b/arch/sparc/Kconfig
--- a/arch/sparc/Kconfig	2002-11-27 23:35:45.000000000 +0100
+++ b/arch/sparc/Kconfig	2002-12-04 13:23:08.000000000 +0100
@@ -1408,6 +1408,14 @@
 config DEBUG_SLAB
 	bool "Debug memory allocations"
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	help
diff -urN a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig	2002-11-27 23:36:18.000000000 +0100
+++ b/arch/sparc64/Kconfig	2002-12-04 13:23:51.000000000 +0100
@@ -1658,6 +1658,14 @@
 	  allocation as well as poisoning memory on free to catch use of freed
 	  memory.
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on DEBUG_KERNEL && SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on DEBUG_KERNEL
diff -urN a/arch/um/Kconfig b/arch/um/Kconfig
--- a/arch/um/Kconfig	2002-11-27 23:36:00.000000000 +0100
+++ b/arch/um/Kconfig	2002-12-04 13:24:32.000000000 +0100
@@ -154,6 +154,14 @@
 config DEBUG_SLAB
 	bool "Debug memory allocations"
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 config DEBUGSYM
 	bool "Enable kernel debugging symbols"
 
diff -urN a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
--- a/arch/x86_64/Kconfig	2002-11-27 23:36:17.000000000 +0100
+++ b/arch/x86_64/Kconfig	2002-12-04 13:25:28.000000000 +0100
@@ -694,6 +694,14 @@
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
+config CPUS_STAT
+	bool "Per CPU user and system time statistics"
+	depends on DEBUG_KERNEL && SMP
+	help
+	  Say Y here to let the kernel gather per CPU user and system
+	  time statistics for each task. This can be accessed in
+	  /proc/pid/cpu.
+
 config DEBUG_SLAB
 	bool "Debug memory allocations"
 	depends on DEBUG_KERNEL
diff -urN a/fs/proc/array.c b/fs/proc/array.c
--- a/fs/proc/array.c	2002-11-27 23:36:05.000000000 +0100
+++ b/fs/proc/array.c	2002-12-04 12:59:16.000000000 +0100
@@ -597,3 +597,26 @@
 out:
 	return retval;
 }
+
+#ifdef CONFIG_CPUS_STAT
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
--- a/fs/proc/base.c	2002-11-27 23:36:06.000000000 +0100
+++ b/fs/proc/base.c	2002-12-04 13:00:17.000000000 +0100
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
+#ifdef CONFIG_CPUS_STAT
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
+#ifdef CONFIG_CPUS_STAT
+		case PROC_PID_CPU:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pid_cpu;
+			break;
+#endif
 		case PROC_PID_MEM:
 			inode->i_op = &proc_mem_inode_operations;
 			inode->i_fop = &proc_mem_operations;
diff -urN a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2002-11-27 23:35:49.000000000 +0100
+++ b/include/linux/sched.h	2002-12-04 13:01:34.000000000 +0100
@@ -342,6 +342,9 @@
 	struct timer_list real_timer;
 	unsigned long utime, stime, cutime, cstime;
 	unsigned long start_time;
+#ifdef CONFIG_CPUS_STAT
+	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
+#endif
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
 	int swappable:1;
diff -urN a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	2002-11-27 23:35:49.000000000 +0100
+++ b/kernel/fork.c	2002-12-04 13:02:53.000000000 +0100
@@ -794,6 +794,14 @@
 	p->tty_old_pgrp = 0;
 	p->utime = p->stime = 0;
 	p->cutime = p->cstime = 0;
+#ifdef CONFIG_CPUS_STAT
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
--- a/kernel/timer.c	2002-11-27 23:35:54.000000000 +0100
+++ b/kernel/timer.c	2002-12-04 13:03:26.000000000 +0100
@@ -694,6 +694,10 @@
 void update_one_process(struct task_struct *p, unsigned long user,
 			unsigned long system, int cpu)
 {
+#ifdef CONFIG_CPUS_STAT
+	p->per_cpu_utime[cpu] += user;
+	p->per_cpu_stime[cpu] += system;
+#endif
 	do_process_times(p, user, system);
 	do_it_virt(p, user);
 	do_it_prof(p);

--------------Boundary-00=_R0IL0IH97J1G7SCM9EHG--

