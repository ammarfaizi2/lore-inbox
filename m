Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316214AbSEKMS2>; Sat, 11 May 2002 08:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316215AbSEKMS1>; Sat, 11 May 2002 08:18:27 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:25861 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S316214AbSEKMS0>; Sat, 11 May 2002 08:18:26 -0400
Date: Sat, 11 May 2002 14:18:23 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 5b/6: export easily available 64 bit time values in /proc
Message-ID: <Pine.LNX.4.33.0205111417200.27342-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alternate patch to [PATCH] 5a/6: export 64 bit time values in /proc.

Per CPU user, nice, and system time currently overflow on alpha after
48.5 days respectively. Total values even overflow after
48.5 days / smp_num_cpus.
So make them 64 bit on 64 bit platforms.

Export 64 bit uptime on all platforms.
Calculate boot time correctly after 32 bit jiffies wrap.


--- linux-2.5.15-j65/include/linux/kernel_stat.h	Sat May 11 13:57:38 2002
+++ linux-2.5.15-j66/include/linux/kernel_stat.h	Sat May 11 13:49:10 2002
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

--- linux-2.5.15-j65/fs/proc/proc_misc.c	Sat May 11 13:47:04 2002
+++ linux-2.5.15-j66/fs/proc/proc_misc.c	Sat May 11 14:11:52 2002
@@ -40,6 +40,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <asm/div64.h>
 
 
 #define LOAD_INT(x) ((x) >> FSHIFT)
@@ -93,11 +94,12 @@
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	unsigned long uptime;
-	unsigned long idle;
+	u64 uptime;
+	unsigned long uptime_remainder, idle;
 	int len;
 
-	uptime = jiffies;
+	uptime = get_jiffies64();
+	uptime_remainder = (unsigned long) do_div(uptime, HZ);
 	idle = init_task.times.tms_utime + init_task.times.tms_stime;
 
 	/* The formula for the fraction parts really is ((t * 100) / HZ) % 100, but
@@ -111,14 +113,14 @@
 	 */
 #if HZ!=100
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		(((uptime % HZ) * 100) / HZ) % 100,
+		(unsigned long) uptime,
+		(uptime_remainder * 100) / HZ,
 		idle / HZ,
 		(((idle % HZ) * 100) / HZ) % 100);
 #else
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		uptime % HZ,
+		(unsigned long) uptime,
+		uptime_remainder,
 		idle / HZ,
 		idle % HZ);
 #endif
@@ -281,8 +283,9 @@
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
@@ -297,17 +300,19 @@
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
@@ -343,12 +348,13 @@
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

