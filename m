Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314670AbSEKKaB>; Sat, 11 May 2002 06:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314672AbSEKK34>; Sat, 11 May 2002 06:29:56 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:21765 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S314670AbSEKK3s>; Sat, 11 May 2002 06:29:48 -0400
Date: Sat, 11 May 2002 12:29:45 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 5a/6: export 64 bit time values in /proc
Message-ID: <Pine.LNX.4.33.0205111228300.26626-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Report 64 bit values for uptime, idle time, and per-cpu user, nice, 
and system time in /proc/uptime and /proc/stat.
Calculate boot time correctly after 32 bit jiffies wrap.

High 31 bits of 63 bit idle, user, nice, and system times are again
maintained on 32 bit platforms using a timer.

This may be considered creeping featurism, so I'll provide an alternate
patch that just exports the 64 bit values where available.
OTOH, the timer tricks are purely local to proc_fs, so you don't get them
when you don't mount /proc.


--- linux-2.5.15/include/linux/kernel_stat.h	Sun May  5 08:32:04 2002
+++ linux-2.5.15-j64/include/linux/kernel_stat.h	Thu May  9 17:48:21 2002
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

--- linux-2.5.15/fs/proc/proc_misc.c	Sun May  5 08:32:03 2002
+++ linux-2.5.15-j64/fs/proc/proc_misc.c	Thu May  9 18:02:05 2002
@@ -40,6 +40,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <asm/div64.h>
 
 
 #define LOAD_INT(x) ((x) >> FSHIFT)
@@ -62,6 +63,92 @@
 extern int get_ds1286_status(char *);
 #endif
 
+#if BITS_PER_LONG < 48
+static unsigned int uidle_msb_flips, sidle_msb_flips;
+static unsigned int per_cpu_user_flips[NR_CPUS],
+	            per_cpu_nice_flips[NR_CPUS],
+	            per_cpu_system_flips[NR_CPUS];
+
+static u64 get_64bits(unsigned long *val, unsigned int *flips)
+{
+	unsigned long v;
+	unsigned int f;
+
+	f = *flips; /* avoid races */
+	rmb();
+	v = *val;
+
+	/* account for not yet detected MSB flips */
+	f += (f ^ (v>>(BITS_PER_LONG-1))) & 1;
+	return ((u64) f << (BITS_PER_LONG-1)) | v;
+}
+
+#define get_uidle64()     get_64bits(&(init_task.times.tms_utime),\
+                                     &uidle_msb_flips)
+#define get_sidle64()     get_64bits(&(init_task.times.tms_stime),\
+                                     &sidle_msb_flips)
+#define get_user64(cpu)   get_64bits(&(kstat.per_cpu_user[cpu]),\
+                                     &(per_cpu_user_flips[cpu]))
+#define get_nice64(cpu)   get_64bits(&(kstat.per_cpu_nice[cpu]),\
+                                     &(per_cpu_nice_flips[cpu]))
+#define get_system64(cpu) get_64bits(&(kstat.per_cpu_system[cpu]),\
+                                     &(per_cpu_system_flips[cpu]))
+
+/*
+ * Use a timer to periodically check for overflows.
+ * Instead of overflows we count flips of the highest bit so
+ * that we can easily check whether the latest flip is already
+ * accounted for.
+ * Not racy as invocations are several days apart in time and
+ * *_flips is not modified elsewhere.
+ */
+
+static struct timer_list check_wraps_timer;
+#define CHECK_WRAPS_INTERVAL (1ul << (BITS_PER_LONG-2))
+
+static inline void check_one(unsigned long val, unsigned int *flips)
+{
+	*flips += 1 & (*flips ^ (val>>(BITS_PER_LONG-1)));
+}
+
+static void check_wraps(unsigned long data)
+{
+	int i;
+
+	mod_timer(&check_wraps_timer, jiffies + CHECK_WRAPS_INTERVAL);
+
+	check_one(init_task.times.tms_utime, &uidle_msb_flips);
+	check_one(init_task.times.tms_stime, &sidle_msb_flips);
+	for(i=0; i<NR_CPUS; i++) {
+		check_one(kstat.per_cpu_user[i], &(per_cpu_user_flips[i]));
+		check_one(kstat.per_cpu_nice[i], &(per_cpu_nice_flips[i]));
+		check_one(kstat.per_cpu_system[i], &(per_cpu_system_flips[i]));
+	}
+}
+
+static inline void init_check_wraps_timer(void)
+{
+	init_timer(&check_wraps_timer);
+	check_wraps_timer.expires = jiffies + CHECK_WRAPS_INTERVAL;
+	check_wraps_timer.function = check_wraps;
+	add_timer(&check_wraps_timer);
+}
+
+#else
+ /* Times won't overflow for 8716 years at HZ==1024 */
+
+#define get_uidle64()     (init_task.times.tms_utime)
+#define get_sidle64()     (init_task.times.tms_stime)
+#define get_user64(cpu)   (kstat.per_cpu_user[cpu])
+#define get_nice64(cpu)   (kstat.per_cpu_nice[cpu])
+#define get_system64(cpu) (kstat.per_cpu_system[cpu])
+ 
+static inline void init_check_wraps_timer(void)
+{
+}
+
+#endif /* BITS_PER_LONG < 48 */
+
 static int proc_calc_metrics(char *page, char **start, off_t off,
 				 int count, int *eof, int len)
 {
@@ -93,34 +180,27 @@
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	unsigned long uptime;
-	unsigned long idle;
+	u64 uptime, idle;
+	unsigned long uptime_remainder, idle_remainder;
 	int len;
 
-	uptime = jiffies;
-	idle = init_task.times.tms_utime + init_task.times.tms_stime;
+	uptime = get_jiffies64();
+	uptime_remainder = (unsigned long) do_div(uptime, HZ);
+	idle = get_sidle64() + get_uidle64();
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
+		idle_remainder);
 #endif
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
@@ -281,33 +361,39 @@
 {
 	int i, len;
 	extern unsigned long total_forks;
-	unsigned long jif = jiffies;
-	unsigned int sum = 0, user = 0, nice = 0, system = 0;
+	unsigned int sum = 0;
+	u64 jif = get_jiffies64(), user = 0, nice = 0, system = 0;
 	int major, disk;
 
 	for (i = 0 ; i < smp_num_cpus; i++) {
 		int cpu = cpu_logical_map(i), j;
 
-		user += kstat.per_cpu_user[cpu];
-		nice += kstat.per_cpu_nice[cpu];
-		system += kstat.per_cpu_system[cpu];
+		user += get_user64(cpu);
+		nice += get_nice64(cpu);
+		system += get_system64(cpu);
 #if !defined(CONFIG_ARCH_S390)
 		for (j = 0 ; j < NR_IRQS ; j++)
 			sum += kstat.irqs[cpu][j];
 #endif
 	}
 
-	len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
-		      jif * smp_num_cpus - (user + nice + system));
-	for (i = 0 ; i < smp_num_cpus; i++)
-		len += sprintf(page + len, "cpu%d %u %u %u %lu\n",
+	len = sprintf(page, "cpu  %llu %llu %llu %llu\n", 
+	              (unsigned long long) user,
+	              (unsigned long long) nice,
+	              (unsigned long long) system,
+	              (unsigned long long) jif * smp_num_cpus
+	                                    - user - nice - system);
+	for (i = 0 ; i < smp_num_cpus; i++) {
+		user = get_user64(cpu_logical_map(i));
+		nice = get_nice64(cpu_logical_map(i));
+		system = get_system64(cpu_logical_map(i));
+		len += sprintf(page + len, "cpu%d %llu %llu %llu %llu\n",
 			i,
-			kstat.per_cpu_user[cpu_logical_map(i)],
-			kstat.per_cpu_nice[cpu_logical_map(i)],
-			kstat.per_cpu_system[cpu_logical_map(i)],
-			jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
-				   + kstat.per_cpu_nice[cpu_logical_map(i)] \
-				   + kstat.per_cpu_system[cpu_logical_map(i)]));
+			(unsigned long long) user,
+			(unsigned long long) nice,
+			(unsigned long long) system,
+			(unsigned long long) jif -user -nice -system);
+	}	
 	len += sprintf(page + len,
 		"page %u %u\n"
 		"swap %u %u\n"
@@ -343,12 +429,13 @@
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
@@ -625,4 +722,6 @@
 			entry->proc_fops = &ppc_htab_operations;
 	}
 #endif
+
+	init_check_wraps_timer();
 }


