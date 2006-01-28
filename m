Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422809AbWA1CuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422809AbWA1CuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWA1CuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:50:24 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:45731 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1750735AbWA1CuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:50:22 -0500
Message-ID: <43DADB1D.80907@samwel.tk>
Date: Sat, 28 Jan 2006 03:46:53 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Represent dirty_*_centisecs as jiffies internally
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make that the internal values for:

/proc/sys/vm/dirty_writeback_centisecs
/proc/sys/vm/dirty_expire_centisecs

are stored as jiffies instead of centiseconds. Let the sysctl
interface do the conversions with full precision using
clock_t_to_jiffies, instead of doing overflow-sensitive on-the-fly
conversions every time the values are used.


Cons: apparent precision loss if HZ is not a multiple of 100,
because of conversion back and forth. This is a common problem
for all sysctl values that use proc_dointvec_userhz_jiffies.
(There is only one other in-tree use, in net/core/neighbour.c.)



Signed-off-by: Bart Samwel <bart@samwel.tk>

--- linux-2.6.16-rc1.orig/mm/page-writeback.c	2006-01-28 01:44:32.000000000 +0100
+++ linux-2.6.16-rc1/mm/page-writeback.c	2006-01-28 01:43:25.000000000 +0100
@@ -75,12 +75,12 @@
   * The interval between `kupdate'-style writebacks, in centiseconds
   * (hundredths of a second)
   */
-int dirty_writeback_centisecs = 5 * 100;
+int dirty_writeback_interval = 5 * HZ;

  /*
   * The longest number of centiseconds for which data is allowed to remain dirty
   */
-int dirty_expire_centisecs = 30 * 100;
+int dirty_expire_interval = 30 * HZ;

  /*
   * Flag that makes the machine dump writes/reads and block dirtyings.
@@ -379,8 +379,8 @@
   * just walks the superblock inode list, writing back any inodes which are
   * older than a specific point in time.
   *
- * Try to run once per dirty_writeback_centisecs.  But if a writeback event
- * takes longer than a dirty_writeback_centisecs interval, then leave a
+ * Try to run once per dirty_writeback_interval.  But if a writeback event
+ * takes longer than a dirty_writeback_interval interval, then leave a
   * one-second gap.
   *
   * older_than_this takes precedence over nr_to_write.  So we'll only write back
@@ -405,9 +405,9 @@
  	sync_supers();

  	get_writeback_state(&wbs);
-	oldest_jif = jiffies - (dirty_expire_centisecs * HZ) / 100;
+	oldest_jif = jiffies - dirty_expire_interval;
  	start_jif = jiffies;
-	next_jif = start_jif + (dirty_writeback_centisecs * HZ) / 100;
+	next_jif = start_jif + dirty_writeback_interval;
  	nr_to_write = wbs.nr_dirty + wbs.nr_unstable +
  			(inodes_stat.nr_inodes - inodes_stat.nr_unused);
  	while (nr_to_write > 0) {
@@ -424,7 +424,7 @@
  	}
  	if (time_before(next_jif, jiffies + HZ))
  		next_jif = jiffies + HZ;
-	if (dirty_writeback_centisecs)
+	if (dirty_writeback_interval)
  		mod_timer(&wb_timer, next_jif);
  }

@@ -434,11 +434,11 @@
  int dirty_writeback_centisecs_handler(ctl_table *table, int write,
  		struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
  {
-	proc_dointvec(table, write, file, buffer, length, ppos);
-	if (dirty_writeback_centisecs) {
+	proc_dointvec_userhz_jiffies(table, write, file, buffer, length, ppos);
+	if (dirty_writeback_interval) {
  		mod_timer(&wb_timer,
-			jiffies + (dirty_writeback_centisecs * HZ) / 100);
-	} else {
+			jiffies + dirty_writeback_interval);
+		} else {
  		del_timer(&wb_timer);
  	}
  	return 0;
@@ -543,7 +543,7 @@
  		if (vm_dirty_ratio <= 0)
  			vm_dirty_ratio = 1;
  	}
-	mod_timer(&wb_timer, jiffies + (dirty_writeback_centisecs * HZ) / 100);
+	mod_timer(&wb_timer, jiffies + dirty_writeback_interval);
  	set_ratelimit();
  	register_cpu_notifier(&ratelimit_nb);
  }
--- linux-2.6.16-rc1.orig/include/linux/writeback.h	2006-01-28 01:44:32.000000000 +0100
+++ linux-2.6.16-rc1/include/linux/writeback.h	2006-01-28 01:34:03.000000000 +0100
@@ -88,8 +88,8 @@
  /* These are exported to sysctl. */
  extern int dirty_background_ratio;
  extern int vm_dirty_ratio;
-extern int dirty_writeback_centisecs;
-extern int dirty_expire_centisecs;
+extern int dirty_writeback_interval;
+extern int dirty_expire_interval;
  extern int block_dump;
  extern int laptop_mode;

--- linux-2.6.16-rc1.orig/kernel/sysctl.c	2006-01-28 01:44:32.000000000 +0100
+++ linux-2.6.16-rc1/kernel/sysctl.c	2006-01-28 01:34:18.000000000 +0100
@@ -717,18 +717,18 @@
  	{
  		.ctl_name	= VM_DIRTY_WB_CS,
  		.procname	= "dirty_writeback_centisecs",
-		.data		= &dirty_writeback_centisecs,
-		.maxlen		= sizeof(dirty_writeback_centisecs),
+		.data		= &dirty_writeback_interval,
+		.maxlen		= sizeof(dirty_writeback_interval),
  		.mode		= 0644,
  		.proc_handler	= &dirty_writeback_centisecs_handler,
  	},
  	{
  		.ctl_name	= VM_DIRTY_EXPIRE_CS,
  		.procname	= "dirty_expire_centisecs",
-		.data		= &dirty_expire_centisecs,
-		.maxlen		= sizeof(dirty_expire_centisecs),
+		.data		= &dirty_expire_interval,
+		.maxlen		= sizeof(dirty_expire_interval),
  		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= &proc_dointvec_userhz_jiffies,
  	},
  	{
  		.ctl_name	= VM_NR_PDFLUSH_THREADS,

