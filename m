Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSEYKiF>; Sat, 25 May 2002 06:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSEYKiF>; Sat, 25 May 2002 06:38:05 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:43278 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S314446AbSEYKiC>; Sat, 25 May 2002 06:38:02 -0400
Date: Sat, 25 May 2002 12:37:57 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Dave Jones <davej@suse.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] uptime > 497days, minimal cruft edition
Message-ID: <Pine.LNX.4.33.0205251227300.3045-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have 64 bit jiffies and also a separate <linux/jiffies.h> in 
2.5.18, I think it's time to finally use it to get rid of uptime 
wraparounds.

I've put together what I think is minimally needed and commonly 
acceptable, i.e. no timer gymnastics etc.:

   - use 64 bit jiffies for uptime via sysinfo
   - use 64 bit jiffies for uptime via /proc/uptime
   - use 64 bit jiffies in the oom_killer
   - bump up process start time in task_struct to 64 bits.
     This prevents reporting processes as having started in the future
     after 32 bit jiffies wrap
   - change BSD accounting and /proc/array accordingly
   - extend kernel_stat.per_cpu_[user,nice,system] from int to long,
     This prevents overflow on 64 bit platforms after about 48 days.

Tim


--- linux-2.5.18/include/linux/jiffies.h	Sat May 25 09:35:11 2002
+++ linux-2.5.18-j64/include/linux/jiffies.h	Sat May 25 11:20:46 2002
@@ -2,13 +2,32 @@
 #define _LINUX_JIFFIES_H
 
 #include <linux/types.h>
+#include <linux/spinlock.h>
+#include <asm/system.h>
 
 /*
  * The 64-bit value is not volatile - you MUST NOT read it
- * without holding read_lock_irq(&xtime_lock)
+ * without holding read_lock_irq(&xtime_lock).
+ * get_jiffies64() will do this for you as appropriate.
  */
 extern u64 jiffies_64;
 extern unsigned long volatile jiffies;
+
+static inline u64 get_jiffies64(void)
+{
+#if BITS_PER_LONG < 64
+	extern rwlock_t xtime_lock;
+	unsigned long flags;
+	u64 tmp;
+
+	read_lock_irqsave(&xtime_lock, flags);
+	tmp = jiffies_64;
+	read_unlock_irqrestore(&xtime_lock, flags);
+	return tmp;
+#else
+	return (u64)jiffies;
+#endif
+}                                                                              
 
 /*
  *	These inlines deal with timer wrapping correctly. You are 

--- linux-2.5.18/kernel/info.c	Tue May 21 07:07:31 2002
+++ linux-2.5.18-j64/kernel/info.c	Sat May 25 10:03:52 2002
@@ -12,15 +12,19 @@
 #include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 asmlinkage long sys_sysinfo(struct sysinfo *info)
 {
 	struct sysinfo val;
+	u64 uptime;
 
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
 	cli();
-	val.uptime = jiffies / HZ;
+	uptime = get_jiffies64();
+	do_div(uptime, HZ);
+	val.uptime = (unsigned long) uptime;
 
 	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
 	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);

--- linux-2.5.18/mm/oom_kill.c	Tue May 21 07:07:29 2002
+++ linux-2.5.18-j64/mm/oom_kill.c	Sat May 25 10:03:52 2002
@@ -69,11 +69,10 @@
 	/*
 	 * CPU time is in seconds and run time is in minutes. There is no
 	 * particular reason for this other than that it turned out to work
-	 * very well in practice. This is not safe against jiffie wraps
-	 * but we don't care _that_ much...
+	 * very well in practice.
 	 */
 	cpu_time = (p->times.tms_utime + p->times.tms_stime) >> (SHIFT_HZ + 3);
-	run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
+	run_time = (get_jiffies64() - p->start_time) >> (SHIFT_HZ + 10);
 
 	points /= int_sqrt(cpu_time);
 	points /= int_sqrt(int_sqrt(run_time));

--- linux-2.5.18/fs/proc/proc_misc.c	Sat May 25 09:14:06 2002
+++ linux-2.5.18-j64/fs/proc/proc_misc.c	Sat May 25 10:31:04 2002
@@ -36,10 +36,12 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
+#include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <asm/div64.h>
 
 
 #define LOAD_INT(x) ((x) >> FSHIFT)
@@ -93,34 +95,36 @@
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	unsigned long uptime;
-	unsigned long idle;
+	u64 uptime;
+	unsigned long uptime_remainder;
 	int len;
 
-	uptime = jiffies;
-	idle = init_task.times.tms_utime + init_task.times.tms_stime;
+	uptime = get_jiffies64();
+	uptime_remainder = (unsigned long) do_div(uptime, HZ);
 
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
-	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		(((uptime % HZ) * 100) / HZ) % 100,
-		idle / HZ,
-		(((idle % HZ) * 100) / HZ) % 100);
+	{
+		u64 idle = init_task.times.tms_utime+init_task.times.tms_stime;
+		unsigned long idle_remainder;
+
+		idle_remainder = (unsigned long) do_div(idle, HZ);
+		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
+			(unsigned long) uptime,
+			(uptime_remainder * 100) / HZ,
+			(unsigned long) idle,
+			(idle_remainder * 100) / HZ);
+	}
 #else
-	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		uptime % HZ,
-		idle / HZ,
-		idle % HZ);
+	{
+		unsigned long idle = init_task.times.tms_utime
+		                     + init_task.times.tms_stime;
+
+		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
+			(unsigned long) uptime,
+			uptime_remainder,
+			idle / HZ,
+			idle % HZ);
+	}
 #endif
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
@@ -277,8 +281,9 @@
 {
 	int i, len;
 	extern unsigned long total_forks;
-	unsigned long jif = jiffies;
-	unsigned int sum = 0, user = 0, nice = 0, system = 0;
+	u64 jif = get_jiffies64();
+	unsigned int sum = 0;
+	unsigned long user = 0, nice = 0, system = 0;
 	int major, disk;
 
 	for (i = 0 ; i < smp_num_cpus; i++) {
@@ -293,17 +298,19 @@
 #endif
 	}
 
-	len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
-		      jif * smp_num_cpus - (user + nice + system));
+	len = sprintf(page, "cpu  %lu %lu %lu %llu\n", user, nice, system,
+		      (unsigned long long) jif * smp_num_cpus 
+		                            - user - nice - system);
 	for (i = 0 ; i < smp_num_cpus; i++)
-		len += sprintf(page + len, "cpu%d %u %u %u %lu\n",
+		len += sprintf(page + len, "cpu%d %lu %lu %lu %llu\n",
 			i,
 			kstat.per_cpu_user[cpu_logical_map(i)],
 			kstat.per_cpu_nice[cpu_logical_map(i)],
 			kstat.per_cpu_system[cpu_logical_map(i)],
-			jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
-				   + kstat.per_cpu_nice[cpu_logical_map(i)] \
-				   + kstat.per_cpu_system[cpu_logical_map(i)]));
+			(unsigned long long)
+			  jif - kstat.per_cpu_user[cpu_logical_map(i)]
+			      - kstat.per_cpu_nice[cpu_logical_map(i)]
+			      - kstat.per_cpu_system[cpu_logical_map(i)]);
 	len += sprintf(page + len,
 		"page %u %u\n"
 		"swap %u %u\n"
@@ -339,12 +346,13 @@
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

--- linux-2.5.18/include/linux/sched.h	Sat May 25 09:40:07 2002
+++ linux-2.5.18-j64/include/linux/sched.h	Sat May 25 11:23:20 2002
@@ -312,7 +312,7 @@
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	struct tms times;
-	unsigned long start_time;
+	u64 start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;

--- linux-2.5.18/kernel/fork.c	Tue May 21 07:07:31 2002
+++ linux-2.5.18-j64/kernel/fork.c	Sat May 25 10:04:23 2002
@@ -700,7 +700,7 @@
 #endif
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
-	p->start_time = jiffies;
+	p->start_time = get_jiffies64();
 
 	INIT_LIST_HEAD(&p->local_pages);
 

--- linux-2.5.18/fs/proc/array.c	Tue May 21 07:07:30 2002
+++ linux-2.5.18-j64/fs/proc/array.c	Sat May 25 10:04:23 2002
@@ -345,7 +345,7 @@
 	ppid = task->pid ? task->real_parent->pid : 0;
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
+%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
 		task->pid,
 		task->comm,
@@ -368,7 +368,7 @@
 		nice,
 		0UL /* removed */,
 		task->it_real_value,
-		task->start_time,
+		(unsigned long long)(task->start_time),
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

diff -urP linux-2.5.18/kernel/acct.c linux-2.5.18-j64/kernel/acct.c
--- linux-2.5.18/kernel/acct.c	Tue May 21 07:07:40 2002
+++ linux-2.5.18-j64/kernel/acct.c	Sat May 25 10:05:00 2002
@@ -50,6 +50,7 @@
 #include <linux/file.h>
 #include <linux/tty.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 /*
  * These constants control the amount of freespace that suspend and
@@ -299,6 +300,7 @@
 	mm_segment_t fs;
 	unsigned long vsize;
 	unsigned long flim;
+	u64 elapsed;
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -316,9 +318,11 @@
 	strncpy(ac.ac_comm, current->comm, ACCT_COMM);
 	ac.ac_comm[ACCT_COMM - 1] = '\0';
 
-	ac.ac_btime = CT_TO_SECS(current->start_time) +
-		(xtime.tv_sec - (jiffies / HZ));
-	ac.ac_etime = encode_comp_t(jiffies - current->start_time);
+	elapsed = get_jiffies64() - current->start_time;
+	ac.ac_etime = encode_comp_t(elapsed > (unsigned long) -1l ?
+	                       (unsigned long) -1l : (unsigned long) elapsed);
+	do_div(elapsed, HZ);
+	ac.ac_btime = xtime.tv_sec - elapsed;
 	ac.ac_utime = encode_comp_t(current->times.tms_utime);
 	ac.ac_stime = encode_comp_t(current->times.tms_stime);
 	ac.ac_uid = current->uid;

--- linux-2.5.18/include/linux/kernel_stat.h	Sat May 25 09:40:07 2002
+++ linux-2.5.18-j64/include/linux/kernel_stat.h	Sat May 25 11:23:32 2002
@@ -16,9 +16,9 @@
 #define DK_MAX_DISK 16
 
 struct kernel_stat {
-	unsigned int per_cpu_user[NR_CPUS],
-	             per_cpu_nice[NR_CPUS],
-	             per_cpu_system[NR_CPUS];
+	unsigned long per_cpu_user[NR_CPUS],
+	              per_cpu_nice[NR_CPUS],
+	              per_cpu_system[NR_CPUS];
 	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];


