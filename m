Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262310AbSJOF5l>; Tue, 15 Oct 2002 01:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262385AbSJOF5k>; Tue, 15 Oct 2002 01:57:40 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:37906
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262310AbSJOF5G>; Tue, 15 Oct 2002 01:57:06 -0400
Subject: [PATCH] 2.4: variable HZ
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Cc: high-res-timers-discourse@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Oct 2002 02:03:02 -0400
Message-Id: <1034661791.10843.9.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I backported the jiffies_to_clock_t() code from 2.5 to 2.4, mostly just
for fun.

It works fine, and I have successfully used HZ=1000 on my machines.  It
is the same API as 2.5, used in the same places - we export a static
HZ=100 to user-space and convert from the real HZ as needed.  The only
difference is I added a CONFIG_HZ to allow the user to set the value.

There are probably some HZ values you cannot use due to NTP issues.  I
suggest HZ=1000, since I know that works, and 2.5 is using it.  RedHat
is supposedly shipping their kernel with HZ=512 but I do not know if
they did anything else special.

Oh, and I did not backport 64-bit jiffies yet.  So HZ=1000 will wrap
around in just under 50 days.  If you just cannot have that, stick with
a lower value.

Patch is against 2.4.20-pre10-ac2 but applies OK to all 2.4.20-pre and
2.4.19 kernels.

Enjoy,

	Robert Love

diff -urN linux-2.4.20-pre10-ac2/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.4.20-pre10-ac2/arch/i386/config.in	2002-10-14 01:43:05.000000000 -0400
+++ linux/arch/i386/config.in	2002-10-14 18:24:48.000000000 -0400
@@ -244,6 +244,7 @@
 mainmenu_option next_comment
 comment 'General setup'
 
+int 'Timer frequency (HZ) (100)' CONFIG_HZ 100
 bool 'Networking support' CONFIG_NET
 
 # Visual Workstation support is utterly broken.
diff -urN linux-2.4.20-pre10-ac2/Documentation/Configure.help linux/Documentation/Configure.help
--- linux-2.4.20-pre10-ac2/Documentation/Configure.help	2002-10-14 01:43:06.000000000 -0400
+++ linux/Documentation/Configure.help	2002-10-14 18:32:38.000000000 -0400
@@ -2411,6 +2411,18 @@
   behaviour is platform-dependent, but normally the flash frequency is
   a hyperbolic function of the 5-minute load average.
 
+Timer frequency
+CONFIG_HZ
+  The frequency the system timer interrupt pops.  Higher tick values provide
+  improved granularity of timers, improved select() and poll() performance,
+  and lower scheduling latency.  Higher values, however, increase interrupt
+  overhead and will allow jiffie wraparound sooner.  For compatibility, the
+  tick count is always exported as if HZ=100.
+
+  The default value, which was the value for all of eternity, is 100.  If
+  you are looking to provide better timer granularity or increased desktop
+  performance, try 500 or 1000.  In unsure, go with the default of 100.
+
 Networking support
 CONFIG_NET
   Unless you really know what you are doing, you should say Y here.
diff -urN linux-2.4.20-pre10-ac2/fs/proc/array.c linux/fs/proc/array.c
--- linux-2.4.20-pre10-ac2/fs/proc/array.c	2002-10-14 01:43:10.000000000 -0400
+++ linux/fs/proc/array.c	2002-10-14 18:24:48.000000000 -0400
@@ -360,15 +360,15 @@
 		task->cmin_flt,
 		task->maj_flt,
 		task->cmaj_flt,
-		task->times.tms_utime,
-		task->times.tms_stime,
-		task->times.tms_cutime,
-		task->times.tms_cstime,
+		jiffies_to_clock_t(task->times.tms_utime),
+		jiffies_to_clock_t(task->times.tms_stime),
+		jiffies_to_clock_t(task->times.tms_cutime),
+		jiffies_to_clock_t(task->times.tms_cstime),
 		priority,
 		nice,
 		0UL /* removed */,
-		task->it_real_value,
-		task->start_time,
+		jiffies_to_clock_t(task->it_real_value),
+		jiffies_to_clock_t(task->start_time),
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,
@@ -686,14 +686,14 @@
 
 	len = sprintf(buffer,
 		"cpu  %lu %lu\n",
-		task->times.tms_utime,
-		task->times.tms_stime);
+		jiffies_to_clock_t(task->times.tms_utime),
+		jiffies_to_clock_t(task->times.tms_stime));
 		
 	for (i = 0 ; i < smp_num_cpus; i++)
 		len += sprintf(buffer + len, "cpu%d %lu %lu\n",
 			i,
-			task->per_cpu_utime[cpu_logical_map(i)],
-			task->per_cpu_stime[cpu_logical_map(i)]);
+			jiffies_to_clock_t(task->per_cpu_utime[cpu_logical_map(i)]),
+			jiffies_to_clock_t(task->per_cpu_stime[cpu_logical_map(i)]));
 
 	return len;
 }
diff -urN linux-2.4.20-pre10-ac2/fs/proc/proc_misc.c linux/fs/proc/proc_misc.c
--- linux-2.4.20-pre10-ac2/fs/proc/proc_misc.c	2002-10-14 01:43:10.000000000 -0400
+++ linux/fs/proc/proc_misc.c	2002-10-14 18:40:08.000000000 -0400
@@ -317,7 +317,7 @@
 {
 	int i, len = 0;
 	extern unsigned long total_forks;
-	unsigned long jif = jiffies;
+	unsigned long jif = jiffies_to_clock_t(jiffies);
 	unsigned int sum = 0, user = 0, nice = 0, system = 0;
 	int major, disk;
 
@@ -334,16 +334,19 @@
 	}
 
 	proc_sprintf(page, &off, &len,
-		      "cpu  %u %u %u %lu\n", user, nice, system,
+		      "cpu  %u %u %u %lu\n",
+		      jiffies_to_clock_t(user),
+		      jiffies_to_clock_t(nice),
+		      jiffies_to_clock_t(system),
 		      jif * smp_num_cpus - (user + nice + system));
 	for (i = 0 ; i < smp_num_cpus; i++)
 		proc_sprintf(page, &off, &len,
 			"cpu%d %u %u %u %lu\n",
 			i,
-			kstat.per_cpu_user[cpu_logical_map(i)],
-			kstat.per_cpu_nice[cpu_logical_map(i)],
-			kstat.per_cpu_system[cpu_logical_map(i)],
-			jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
+			jiffies_to_clock_t(kstat.per_cpu_user[cpu_logical_map(i)]),
+			jiffies_to_clock_t(kstat.per_cpu_nice[cpu_logical_map(i)]),
+			jiffies_to_clock_t(kstat.per_cpu_system[cpu_logical_map(i)]),
+			jif - jiffies_to_clock_t(kstat.per_cpu_user[cpu_logical_map(i)] \
 				   + kstat.per_cpu_nice[cpu_logical_map(i)] \
 				   + kstat.per_cpu_system[cpu_logical_map(i)]));
 	proc_sprintf(page, &off, &len,
diff -urN linux-2.4.20-pre10-ac2/include/asm-i386/param.h linux/include/asm-i386/param.h
--- linux-2.4.20-pre10-ac2/include/asm-i386/param.h	2002-10-14 01:33:16.000000000 -0400
+++ linux/include/asm-i386/param.h	2002-10-14 18:33:35.000000000 -0400
@@ -1,8 +1,17 @@
 #ifndef _ASMi386_PARAM_H
 #define _ASMi386_PARAM_H
 
+#include <linux/config.h>
+
+#ifdef __KERNEL__
+# define HZ		CONFIG_HZ	/* internal kernel timer frequency */
+# define USER_HZ	100		/* some user interfaces are in ticks */
+# define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
+# define jiffies_to_clock_t(x)	((x) / ((HZ) / (USER_HZ)))
+#endif
+
 #ifndef HZ
-#define HZ 100
+#define HZ 100				/* if userspace cheats, give them 100 */
 #endif
 
 #define EXEC_PAGESIZE	4096
@@ -17,8 +26,4 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
-#ifdef __KERNEL__
-# define CLOCKS_PER_SEC	100	/* frequency at which times() counts */
-#endif
-
 #endif
diff -urN linux-2.4.20-pre10-ac2/kernel/signal.c linux/kernel/signal.c
--- linux-2.4.20-pre10-ac2/kernel/signal.c	2002-10-14 01:43:11.000000000 -0400
+++ linux/kernel/signal.c	2002-10-14 18:24:49.000000000 -0400
@@ -13,7 +13,7 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/sched.h>
-
+#include <asm/param.h>
 #include <asm/uaccess.h>
 
 /*
@@ -775,8 +775,8 @@
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
-	info.si_utime = tsk->times.tms_utime;
-	info.si_stime = tsk->times.tms_stime;
+	info.si_utime = jiffies_to_clock_t(tsk->times.tms_utime);
+	info.si_stime = jiffies_to_clock_t(tsk->times.tms_stime);
 
 	status = tsk->exit_code & 0x7f;
 	why = SI_KERNEL;	/* shouldn't happen */
diff -urN linux-2.4.20-pre10-ac2/kernel/sys.c linux/kernel/sys.c
--- linux-2.4.20-pre10-ac2/kernel/sys.c	2002-10-14 01:43:11.000000000 -0400
+++ linux/kernel/sys.c	2002-10-14 18:24:49.000000000 -0400
@@ -15,7 +15,7 @@
 #include <linux/prctl.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
-
+#include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
@@ -792,16 +792,23 @@
 
 asmlinkage long sys_times(struct tms * tbuf)
 {
+	struct tms temp;
+
 	/*
 	 *	In the SMP world we might just be unlucky and have one of
 	 *	the times increment as we use it. Since the value is an
 	 *	atomically safe type this is just fine. Conceptually its
 	 *	as if the syscall took an instant longer to occur.
 	 */
-	if (tbuf)
-		if (copy_to_user(tbuf, &current->times, sizeof(struct tms)))
+	if (tbuf) {
+		temp.tms_utime = jiffies_to_clock_t(current->times.tms_utime);
+		temp.tms_stime = jiffies_to_clock_t(current->times.tms_stime);
+		temp.tms_cutime = jiffies_to_clock_t(current->times.tms_cutime);
+		temp.tms_cstime = jiffies_to_clock_t(current->times.tms_cstime);
+		if (copy_to_user(tbuf, &temp, sizeof(struct tms)))
 			return -EFAULT;
-	return jiffies;
+	}
+	return jiffies_to_clock_t(jiffies);
 }
 
 /*



