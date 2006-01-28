Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWA1LlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWA1LlE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 06:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWA1LlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 06:41:04 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:50854 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1751244AbWA1LlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 06:41:01 -0500
Message-ID: <43DB576D.5090402@samwel.tk>
Date: Sat, 28 Jan 2006 12:37:17 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix overflow issues with sysctl values in centiseconds/seconds
References: <43DADB03.7080606@samwel.tk> <20060127195539.6ffc3d3a.akpm@osdl.org>
In-Reply-To: <20060127195539.6ffc3d3a.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040003090104030900010402"
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040003090104030900010402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Bart Samwel <bart@samwel.tk> wrote:
>>  Here's a threesome of patches
> 
> All of which were space-stuffed by your (mozilla-derived) email client and
> hence are unusable by users of non-MS-wannabe email clients.  They may also
> be unusable by users of mozilla-based email clients, too - I don't know.

Yes, they are. Damn thunderbird... I've fallen for that trap once before,
thought I'd covered my ass by disabling line wrapping, but apparently that
wasn't all. :-/

Here are the patches as attachments.

--Bart

--------------040003090104030900010402
Content-Type: text/plain;
 name="laptop_mode_in_jiffies.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="laptop_mode_in_jiffies.patch"


Make that the internal value for /proc/sys/vm/laptop_mode
is stored as jiffies instead of seconds. Let the sysctl
interface do the conversions, instead of doing on-the-fly
conversions every time the value is used.

Add a description of the fact that laptop_mode doubles as a
flag and a timeout to the comment above the laptop_mode variable. 


Signed-off-by: Bart Samwel <bart@samwel.tk>

--- linux-2.6.16-rc1.orig/kernel/sysctl.c	2006-01-28 02:09:32.000000000 +0100
+++ linux-2.6.16-rc1/kernel/sysctl.c	2006-01-28 02:13:10.000000000 +0100
@@ -823,9 +823,8 @@
 		.data		= &laptop_mode,
 		.maxlen		= sizeof(laptop_mode),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-		.strategy	= &sysctl_intvec,
-		.extra1		= &zero,
+		.proc_handler	= &proc_dointvec_jiffies,
+		.strategy	= &sysctl_jiffies,
 	},
 	{
 		.ctl_name	= VM_BLOCK_DUMP,
--- linux-2.6.16-rc1.orig/mm/page-writeback.c	2006-01-28 01:47:24.000000000 +0100
+++ linux-2.6.16-rc1/mm/page-writeback.c	2006-01-28 02:11:52.000000000 +0100
@@ -88,7 +88,8 @@
 int block_dump;
 
 /*
- * Flag that puts the machine in "laptop mode".
+ * Flag that puts the machine in "laptop mode". Doubles as a timeout in jiffies:
+ * a full sync is triggered after this time elapses without any disk activity.
  */
 int laptop_mode;
 
@@ -467,7 +468,7 @@
  */
 void laptop_io_completion(void)
 {
-	mod_timer(&laptop_mode_wb_timer, jiffies + laptop_mode * HZ);
+	mod_timer(&laptop_mode_wb_timer, jiffies + laptop_mode);
 }
 
 /*

--------------040003090104030900010402
Content-Type: text/plain;
 name="check_sysctl_jiffies.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="check_sysctl_jiffies.patch"


When (integer) sysctl values are in either seconds or centiseconds,
but represented internally as jiffies, the allowable value range
is decreased. This patch adds range checks to the conversion
routines.

For values in seconds: maximum LONG_MAX / HZ.

For values in centiseconds: maximum (LONG_MAX / HZ) * USER_HZ.


(BTW, does anyone else feel that an interface in seconds should not be
accepting negative values?) 


Signed-off-by: Bart Samwel <bart@samwel.tk>


--- linux-2.6.16-rc1.orig/kernel/sysctl.c	2006-01-28 01:47:24.000000000 +0100
+++ linux-2.6.16-rc1/kernel/sysctl.c	2006-01-28 02:03:14.000000000 +0100
@@ -2008,6 +2008,8 @@
 					 int write, void *data)
 {
 	if (write) {
+		if (*lvalp > LONG_MAX / HZ)
+			return 1;		
 		*valp = *negp ? -(*lvalp*HZ) : (*lvalp*HZ);
 	} else {
 		int val = *valp;
@@ -2029,6 +2031,8 @@
 						int write, void *data)
 {
 	if (write) {
+		if (USER_HZ < HZ && *lvalp > (LONG_MAX / HZ) * USER_HZ)
+			return 1;
 		*valp = clock_t_to_jiffies(*negp ? -*lvalp : *lvalp);
 	} else {
 		int val = *valp;

--------------040003090104030900010402
Content-Type: text/plain;
 name="dirty_centisecs_jiffies.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dirty_centisecs_jiffies.patch"



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

--------------040003090104030900010402--
