Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSGPKvb>; Tue, 16 Jul 2002 06:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSGPKvb>; Tue, 16 Jul 2002 06:51:31 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:9225 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S314096AbSGPKv2>; Tue, 16 Jul 2002 06:51:28 -0400
Date: Tue, 16 Jul 2002 12:54:21 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 1/2] Re: What is supposed to replace clock_t?
In-Reply-To: <Pine.LNX.4.44.0207131103410.16670-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0207161130100.31873-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2002, Linus Torvalds wrote:

> (for example, leave the broken clock_t representation in /proc/<pid>/stat
> alone, and just add a _sane_ seconds-based thing in the much more readable
> and parseable /proc/<pid>/status file.
> 
> Not all of the olf clock_t-based stuff is worth trying to fix up, imho.

However, I also don't see a reason not to fix /proc/<pid>/stat, either.
(see my following patch 2/3)

>           We should just make the internal jiffies be 64-bit. That's
> already true for the "true" jiffy count, but it's simply not true for some
> other things (process counters etc).
[...]
> Fixing "jiffies_to_timeval()" and friends to do the right thing for 64-bit
> jiffies will make a lot of the binary interfaces (ie gettimeofday/select/
> getrusage etc) just do the right thing.

Do we actually need to correct anything in gettimeofday() and select() ?
The timeout in select() probably shouldn't exceed 24 days, and 
gettimeofday() only uses jiffies to account for a few lost jiffies, as far 
as I can tell.
The real work seems to be getrusage(), since this requires having 64 bit 
per process statistics first.

> 
> I'd like to do this gradually, though. If you're interested, how about
> just slowly migrating to a
> 
> 	typedef u64 jiffies_t;
> 
> and slowly making the _internal_ stuff be 64-bit clean?


sure, first hunk of patches comes right now. Part 1/2 is simple:

 - introduce jiffies_t as u64
 - introduce jiffies_to_user_HZ()
 - use 64 bit jiffies for uptime

Since we certainly don't want to have a jiffies_64_to_clock_t_64()
function, I made jiffies_to_user_HZ() return an unsigned long long,
which is what we finally want to feed to printk anyways.

Tim
(email: "Tim Schmielau" <tim@physik3.uni-rostock.de>)


--- linux-2.5.25/include/linux/types.h	Fri Jun 21 00:53:49 2002
+++ linux-2.5.25-j64/include/linux/types.h	Tue Jul 16 08:18:05 2002
@@ -25,6 +25,7 @@
 typedef __kernel_suseconds_t	suseconds_t;
 
 #ifdef __KERNEL__
+typedef u64			jiffies_t;
 typedef __kernel_uid32_t	uid_t;
 typedef __kernel_gid32_t	gid_t;
 typedef __kernel_uid16_t        uid16_t;

--- linux-2.5.25/include/linux/times.h	Sat Jul 13 08:40:21 2002
+++ linux-2.5.25-j64/include/linux/times.h	Tue Jul 16 09:15:32 2002
@@ -1,8 +1,16 @@
 #ifndef _LINUX_TIMES_H
 #define _LINUX_TIMES_H
 
+#include <asm/div64.h>
+
 #ifdef __KERNEL__
 # define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
+
+static inline unsigned long long jiffies_to_user_HZ(jiffies_t x)
+{
+	do_div(x, HZ / USER_HZ);
+	return x;
+}
 #endif
 
 struct tms {

--- linux-2.5.25/include/linux/jiffies.h	Fri Jun 21 00:53:42 2002
+++ linux-2.5.25-j64/include/linux/jiffies.h	Tue Jul 16 09:47:15 2002
@@ -2,14 +2,37 @@
 #define _LINUX_JIFFIES_H
 
 #include <linux/types.h>
+#include <linux/spinlock.h>
+#include <asm/system.h>
 #include <asm/param.h>			/* for HZ */
 
 /*
  * The 64-bit value is not volatile - you MUST NOT read it
- * without holding read_lock_irq(&xtime_lock)
+ * without holding read_lock_irq(&xtime_lock).
+ * get_jiffies64() will handle this for you as appropriate.
  */
-extern u64 jiffies_64;
+extern jiffies_t jiffies_64;
 extern unsigned long volatile jiffies;
+
+/*
+ * We assume only 64 bit architectures have BITS_PER_LONG == 64 and
+ * that these access longs atomically.
+ */
+static inline jiffies_t get_jiffies_64(void)
+{
+#if BITS_PER_LONG < 64
+	extern rwlock_t xtime_lock;
+	unsigned long flags;
+	jiffies_t tmp;
+
+	read_lock_irqsave(&xtime_lock, flags);
+	tmp = jiffies_64;
+	read_unlock_irqrestore(&xtime_lock, flags);
+	return tmp;
+#else
+	return (jiffies_t) jiffies;
+#endif
+}                                                                              
 
 /*
  *	These inlines deal with timer wrapping correctly. You are 

--- linux-2.5.25/kernel/timer.c	Sat Jul 13 08:40:21 2002
+++ linux-2.5.25-j64/kernel/timer.c	Tue Jul 16 08:22:12 2002
@@ -24,8 +24,10 @@
 #include <linux/interrupt.h>
 #include <linux/tqueue.h>
 #include <linux/kernel_stat.h>
+#include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 struct kernel_stat kstat;
 
@@ -922,13 +924,16 @@
 asmlinkage long sys_sysinfo(struct sysinfo *info)
 {
 	struct sysinfo val;
+	u64 uptime;
 	unsigned long mem_total, sav_total;
 	unsigned int mem_unit, bitcount;
 
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
 	read_lock_irq(&xtime_lock);
-	val.uptime = jiffies / HZ;
+	uptime = jiffies_64;
+	do_div(uptime, HZ);
+	val.uptime = (unsigned long) uptime;
 
 	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
 	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);

--- linux-2.5.25/fs/proc/proc_misc.c	Sat Jul 13 08:40:20 2002
+++ linux-2.5.25-j64/fs/proc/proc_misc.c	Tue Jul 16 09:50:36 2002
@@ -37,10 +37,12 @@
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
 #include <linux/times.h>
+#include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <asm/div64.h>
 
 
 #define LOAD_INT(x) ((x) >> FSHIFT)
@@ -94,34 +96,27 @@
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	unsigned long uptime;
-	unsigned long idle;
+	u64 uptime, idle;
+	unsigned long uptime_remainder, idle_remainder;
 	int len;
 
-	uptime = jiffies;
-	idle = init_task.utime + init_task.stime;
+	uptime = get_jiffies_64();
+	uptime_remainder = (unsigned long) do_div(uptime, HZ);
+	idle = (u64) init_task.utime + init_task.stime;
+	idle_remainder = (unsigned long) do_div(idle, HZ);
 
-	/* The formula for the fraction parts really is ((t * 100) / HZ) % 100, but
-	   that would overflow about every five days at HZ == 100.
-	   Therefore the identity a = (a / b) * b + a % b is used so that it is
-	   calculated as (((t / HZ) * 100) + ((t % HZ) * 100) / HZ) % 100.
-	   The part in front of the '+' always evaluates as 0 (mod 100). All divisions
-	   in the above formulas are truncating. For HZ being a power of 10, the
-	   calculations simplify to the version in the #else part (if the printf
-	   format is adapted to the same number of digits as zeroes in HZ.
-	 */
 #if HZ!=100
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		(((uptime % HZ) * 100) / HZ) % 100,
-		idle / HZ,
-		(((idle % HZ) * 100) / HZ) % 100);
+		(unsigned long) uptime,
+		(uptime_remainder * 100) / HZ,
+		(unsigned long) idle,
+		(idle_remainder * 100) / HZ);
 #else
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		uptime % HZ,
-		idle / HZ,
-		idle % HZ);
+		(unsigned long) uptime,
+		uptime_remainder,
+		(unsigned long) idle,
+		idle_remainder;
 #endif
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
@@ -278,7 +273,7 @@
 {
 	int i, len;
 	extern unsigned long total_forks;
-	unsigned long jif = jiffies;
+	jiffies_t jif = get_jiffies_64();
 	unsigned int sum = 0, user = 0, nice = 0, system = 0;
 	int major, disk;
 
@@ -295,21 +290,22 @@
 #endif
 	}
 
-	len = sprintf(page, "cpu  %u %u %u %lu\n",
+	len = sprintf(page, "cpu  %u %u %u %llu\n",
 		jiffies_to_clock_t(user),
 		jiffies_to_clock_t(nice),
 		jiffies_to_clock_t(system),
-		jiffies_to_clock_t(jif * num_online_cpus() - (user + nice + system)));
+		jiffies_to_user_HZ(jif * num_online_cpus()
+		                   - user - nice - system));
 	for (i = 0 ; i < NR_CPUS; i++){
 		if (!cpu_online(i)) continue;
-		len += sprintf(page + len, "cpu%d %u %u %u %lu\n",
+		len += sprintf(page + len, "cpu%d %u %u %u %llu\n",
 			i,
 			jiffies_to_clock_t(kstat.per_cpu_user[i]),
 			jiffies_to_clock_t(kstat.per_cpu_nice[i]),
 			jiffies_to_clock_t(kstat.per_cpu_system[i]),
-			jiffies_to_clock_t(jif - (  kstat.per_cpu_user[i] \
-				   + kstat.per_cpu_nice[i] \
-				   + kstat.per_cpu_system[i])));
+			jiffies_to_user_HZ(jif - kstat.per_cpu_user[i]
+			                       - kstat.per_cpu_nice[i]
+			                       - kstat.per_cpu_system[i]));
 	}
 	len += sprintf(page + len,
 		"page %u %u\n"
@@ -346,12 +342,13 @@
 		}
 	}
 
+	do_div(jif, HZ);
 	len += sprintf(page + len,
 		"\nctxt %lu\n"
 		"btime %lu\n"
 		"processes %lu\n",
 		nr_context_switches(),
-		xtime.tv_sec - jif / HZ,
+		xtime.tv_sec - (unsigned long) jif,
 		total_forks);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);



