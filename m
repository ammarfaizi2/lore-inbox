Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265560AbSKACqQ>; Thu, 31 Oct 2002 21:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265575AbSKACqQ>; Thu, 31 Oct 2002 21:46:16 -0500
Received: from h00010256f583.ne.client2.attbi.com ([66.30.243.14]:55168 "EHLO
	portent.dyndns.org") by vger.kernel.org with ESMTP
	id <S265560AbSKACqI>; Thu, 31 Oct 2002 21:46:08 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Lev Makhlis <mlev@despammed.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.5.45] SARQ (Run Queue Statistics) [Update]
Date: Thu, 31 Oct 2002 21:52:19 -0500
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210312152.19067.mlev@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure if there is any interest in this, but here is an update
of my previous patch for 2.5.45.  This version is less intrusive --
it doesn't touch calc_load() or count_active_tasks().  (I figure
that since nr_running()/nr_uninterruptible() are now O(NR_CPUS),
calling them one extra time per second is no big deal.)

The patch adds two counters in /proc/stat, runque and runocc, similar
to those in traditional UNIX systems (usually reported by sar -q),
that track the system run queue occupancy.
Every second, 'runque' is incremented by the run queue size, and
'runocc' is incremented by one if the run queue is not empty.

Lev

--------------------------------------------------------------------------

diff -urN linux-2.5.45.orig/fs/proc/proc_misc.c 
linux-2.5.45/fs/proc/proc_misc.c
--- linux-2.5.45.orig/fs/proc/proc_misc.c	Thu Oct 31 15:34:01 2002
+++ linux-2.5.45/fs/proc/proc_misc.c	Thu Oct 31 15:47:19 2002
@@ -419,12 +419,15 @@
 		"btime %lu\n"
 		"processes %lu\n"
 		"procs_running %lu\n"
-		"procs_blocked %u\n",
+		"procs_blocked %u\n"
+		"runque %u %u\n",
 		nr_context_switches(),
 		xtime.tv_sec - jif / HZ,
 		total_forks,
 		nr_running(),
-		atomic_read(&nr_iowait_tasks));
+		atomic_read(&nr_iowait_tasks),
+		kstat.runque,
+		kstat.runocc);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
diff -urN linux-2.5.45.orig/include/linux/kernel_stat.h 
linux-2.5.45/include/linux/kernel_stat.h
--- linux-2.5.45.orig/include/linux/kernel_stat.h	Sat Oct 19 00:01:50 2002
+++ linux-2.5.45/include/linux/kernel_stat.h	Thu Oct 31 15:45:44 2002
@@ -26,6 +26,7 @@
 	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_rblk[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_wblk[DK_MAX_MAJOR][DK_MAX_DISK];
+	unsigned int runque, runocc;
 #if !defined(CONFIG_ARCH_S390)
 	unsigned int irqs[NR_CPUS][NR_IRQS];
 #endif
diff -urN linux-2.5.45.orig/kernel/timer.c linux-2.5.45/kernel/timer.c
--- linux-2.5.45.orig/kernel/timer.c	Thu Oct 31 15:34:05 2002
+++ linux-2.5.45/kernel/timer.c	Thu Oct 31 15:54:53 2002
@@ -720,6 +720,25 @@
 	}
 }
 
+/*
+ * calc_runq - given tick count, update the runque/runocc counters.
+ */
+static inline void calc_runq(unsigned long ticks)
+{
+	unsigned long active_tasks;
+	static int count = HZ;
+
+	count -= ticks;
+	if (count < 0) {
+		count += HZ;
+		active_tasks = nr_running() + nr_uninterruptible();
+		if (active_tasks) {
+			kstat.runque += active_tasks;
+			kstat.runocc ++;
+		}
+	}
+}
+
 /* jiffies at the most recent update of wall time */
 unsigned long wall_jiffies;
 
@@ -764,6 +783,7 @@
 	}
 	last_time_offset = 0;
 	calc_load(ticks);
+	calc_runq(ticks);
 }
   
 /*
