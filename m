Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbSKJJ0z>; Sun, 10 Nov 2002 04:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264772AbSKJJ0z>; Sun, 10 Nov 2002 04:26:55 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:36014 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S264771AbSKJJ0v>; Sun, 10 Nov 2002 04:26:51 -0500
Date: Sun, 10 Nov 2002 10:33:34 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] use 64 bit jiffies 2/4
In-Reply-To: <Pine.LNX.4.33.0211101014120.12784-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33.0211101029570.12784-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 2/4: fix uptime wrap

Use 64 bit jiffies for reporting uptime.


--- linux-2.5.46-bk4/kernel/timer.c	Sat Nov  9 08:31:13 2002
+++ linux-2.5.46-bk4-j64a/kernel/timer.c	Sun Nov 10 09:16:35 2002
@@ -25,8 +25,10 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
+#include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 /*
  * per-CPU timer vector definitions:
@@ -1060,13 +1062,16 @@
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

--- linux-2.5.46-bk4/fs/proc/proc_misc.c	Mon Nov  4 23:30:07 2002
+++ linux-2.5.46-bk4-j64a/fs/proc/proc_misc.c	Sun Nov 10 09:16:35 2002
@@ -40,12 +40,14 @@
 #include <linux/times.h>
 #include <linux/profile.h>
 #include <linux/blkdev.h>
+#include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
+#include <asm/div64.h>
 
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
@@ -97,34 +99,36 @@
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	unsigned long uptime;
-	unsigned long idle;
+	u64 uptime;
+	unsigned long uptime_remainder;
 	int len;
 
-	uptime = jiffies;
-	idle = init_task.utime + init_task.stime;
+	uptime = get_jiffies_64();
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
+		u64 idle = init_task.utime + init_task.stime;
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
@@ -320,6 +324,8 @@
 };
 #endif
 
+extern rwlock_t xtime_lock;
+
 extern struct seq_operations slabinfo_op;
 extern ssize_t slabinfo_write(struct file *, const char *, size_t, loff_t *);
 static int slabinfo_open(struct inode *inode, struct file *file)
@@ -339,7 +345,7 @@ static int kstat_read_proc(char *page, c
 {
 	int i, len;
 	extern unsigned long total_forks;
-	unsigned long jif = jiffies;
+	u64 jif = get_jiffies_64();
 	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0;
 	int major, disk;
 
@@ -401,6 +407,7 @@ static int kstat_read_proc(char *page, c
 		}
 	}
 
+	do_div(jif, HZ);
 	len += sprintf(page + len,
 		"\nctxt %lu\n"
 		"btime %lu\n"
@@ -408,7 +415,7 @@ static int kstat_read_proc(char *page, c
 		"procs_running %lu\n"
 		"procs_blocked %u\n",
 		nr_context_switches(),
-		xtime.tv_sec - jif / HZ,
+		xtime.tv_sec - (unsigned long) jif,
 		total_forks,
 		nr_running(),
 		atomic_read(&nr_iowait_tasks));

