Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSFYRFN>; Tue, 25 Jun 2002 13:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSFYRFN>; Tue, 25 Jun 2002 13:05:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59654 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315631AbSFYRFH>;
	Tue, 25 Jun 2002 13:05:07 -0400
Message-ID: <3D18A273.284F8EDD@zip.com.au>
Date: Tue, 25 Jun 2002 10:03:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when 
 alaptop is powered by a battery?
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> 
> Hi,
> 
> Is there any possibility we could:
> 
> 1)  Add support to the boot/mounting process
>     so that, if a machine is being powered by
>     battery, EXT3 partitions are mounted with
>     EXT2, instead?
> 
> 2)  While the machine is running, notice when the
>     power source switches between AC and battery
>     or vice versa and remount partitions EXT3
>     partitions to use EXT2 whenever a battery is
>     being used?
> 

umm, why?

If it's because of the disk-spins-up-too-much problem then
that can be addressed by allowing the commit interval to be
set to larger values.

--- 2.4.19-pre10/fs/jbd/journal.c~ext3-commit-interval	Fri Jun  7 22:56:37 2002
+++ 2.4.19-pre10-akpm/fs/jbd/journal.c	Sat Jun  8 00:30:32 2002
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/sysctl.h>
 #include <asm/uaccess.h>
 #include <linux/proc_fs.h>
 
@@ -85,6 +86,8 @@ EXPORT_SYMBOL(journal_force_commit);
 
 static int journal_convert_superblock_v1(journal_t *, journal_superblock_t *);
 
+int jbd_commit_interval = 5;	/* /proc/sys/fs/jbd_commit_interval */
+
 /*
  * journal_datalist_lock is used to protect data buffers:
  *
@@ -223,8 +226,8 @@ int kjournald(void *arg)
 	journal->j_task = current;
 	wake_up(&journal->j_wait_done_commit);
 
-	printk(KERN_INFO "kjournald starting.  Commit interval %ld seconds\n",
-			journal->j_commit_interval / HZ);
+	printk(KERN_INFO "kjournald starting.  Commit interval %d seconds\n",
+			jbd_commit_interval);
 	list_add(&journal->j_all_journals, &all_journals);
 
 	/* And now, wait forever for commit wakeup events. */
@@ -708,8 +711,6 @@ static journal_t * journal_init_common (
 	init_MUTEX(&journal->j_checkpoint_sem);
 	init_MUTEX(&journal->j_sem);
 
-	journal->j_commit_interval = (HZ * 5);
-
 	/* The journal is marked for error until we succeed with recovery! */
 	journal->j_flags = JFS_ABORT;
 
@@ -1775,59 +1776,41 @@ int journal_enable_debug;
 EXPORT_SYMBOL(journal_enable_debug);
 #endif
 
-#if defined(CONFIG_JBD_DEBUG) && defined(CONFIG_PROC_FS)
-
-static struct proc_dir_entry *proc_jbd_debug;
-
-int read_jbd_debug(char *page, char **start, off_t off,
-			  int count, int *eof, void *data)
-{
-	int ret;
-
-	ret = sprintf(page + off, "%d\n", journal_enable_debug);
-	*eof = 1;
-	return ret;
-}
+static ctl_table jbd_table[] = {
+	{ 1, "jbd-commit-interval", &jbd_commit_interval,
+		sizeof(jbd_commit_interval), 0644, NULL,
+		&proc_dointvec, NULL, },
+#ifdef CONFIG_JBD_DEBUG
+	{ 2, "jbd-debug", &journal_enable_debug,
+		sizeof(journal_enable_debug), 0644, NULL,
+		&proc_dointvec, NULL, },
+#endif
+	{ 0, },
+};
 
-int write_jbd_debug(struct file *file, const char *buffer,
-			   unsigned long count, void *data)
-{
-	char buf[32];
+static ctl_table jbd_root[] = {
+	{ FS_JBD, "jbd", NULL, 0, 0755, jbd_table, },
+	{ 0, },
+};
 
-	if (count > ARRAY_SIZE(buf) - 1)
-		count = ARRAY_SIZE(buf) - 1;
-	if (copy_from_user(buf, buffer, count))
-		return -EFAULT;
-	buf[ARRAY_SIZE(buf) - 1] = '\0';
-	journal_enable_debug = simple_strtoul(buf, NULL, 10);
-	return count;
-}
+static ctl_table fs_root[] = {
+	{ CTL_FS, "fs", NULL, 0, 0755, jbd_root, },
+	{ 0, },
+};
 
-#define JBD_PROC_NAME "sys/fs/jbd-debug"
+static struct ctl_table_header *sysctl_header;
 
-static void __init create_jbd_proc_entry(void)
+static void __init create_jbd_sysctls(void)
 {
-	proc_jbd_debug = create_proc_entry(JBD_PROC_NAME, 0644, NULL);
-	if (proc_jbd_debug) {
-		/* Why is this so hard? */
-		proc_jbd_debug->read_proc = read_jbd_debug;
-		proc_jbd_debug->write_proc = write_jbd_debug;
-	}
+	sysctl_header = register_sysctl_table(fs_root, 0);
 }
 
-static void __exit remove_jbd_proc_entry(void)
+static void __exit remove_jbd_sysctls(void)
 {
-	if (proc_jbd_debug)
-		remove_proc_entry(JBD_PROC_NAME, NULL);
+	if (sysctl_header)
+		unregister_sysctl_table(sysctl_header);
 }
 
-#else
-
-#define create_jbd_proc_entry() do {} while (0)
-#define remove_jbd_proc_entry() do {} while (0)
-
-#endif
-
 /*
  * Module startup and shutdown
  */
@@ -1856,7 +1839,7 @@ static int __init journal_init(void)
 	ret = journal_init_caches();
 	if (ret != 0)
 		journal_destroy_caches();
-	create_jbd_proc_entry();
+	create_jbd_sysctls();
 	return ret;
 }
 
@@ -1867,7 +1850,7 @@ static void __exit journal_exit(void)
 	if (n)
 		printk(KERN_EMERG "JBD: leaked %d journal_heads!\n", n);
 #endif
-	remove_jbd_proc_entry();
+	remove_jbd_sysctls();
 	journal_destroy_caches();
 }
 
--- 2.4.19-pre10/fs/jbd/transaction.c~ext3-commit-interval	Fri Jun  7 22:56:37 2002
+++ 2.4.19-pre10-akpm/fs/jbd/transaction.c	Fri Jun  7 22:56:37 2002
@@ -56,7 +56,7 @@ static transaction_t * get_transaction (
 	transaction->t_journal = journal;
 	transaction->t_state = T_RUNNING;
 	transaction->t_tid = journal->j_transaction_sequence++;
-	transaction->t_expires = jiffies + journal->j_commit_interval;
+	transaction->t_expires = jiffies + jbd_commit_interval * HZ;
 
 	/* Set up the commit timer for the new transaction. */
 	J_ASSERT (!journal->j_commit_timer_active);
--- 2.4.19-pre10/include/linux/ext3_fs_sb.h~ext3-commit-interval	Fri Jun  7 22:56:37 2002
+++ 2.4.19-pre10-akpm/include/linux/ext3_fs_sb.h	Fri Jun  7 22:57:32 2002
@@ -67,7 +67,6 @@ struct ext3_sb_info {
 	struct inode * s_journal_inode;
 	struct journal_s * s_journal;
 	struct list_head s_orphan;
-	unsigned long s_commit_interval;
 	struct block_device *journal_bdev;
 #ifdef CONFIG_JBD_DEBUG
 	struct timer_list turn_ro_timer;	/* For turning read-only (crash simulation) */
--- 2.4.19-pre10/include/linux/jbd.h~ext3-commit-interval	Fri Jun  7 22:56:37 2002
+++ 2.4.19-pre10-akpm/include/linux/jbd.h	Fri Jun  7 22:58:07 2002
@@ -522,10 +522,6 @@ struct journal_s
 	 * compound commit transaction */
 	int			j_max_transaction_buffers;
 
-	/* What is the maximum transaction lifetime before we begin a
-	 * commit? */
-	unsigned long		j_commit_interval;
-
 	/* The timer used to wakeup the commit thread: */
 	struct timer_list *	j_commit_timer;
 	int			j_commit_timer_active;
@@ -864,6 +860,8 @@ static inline int buffer_jbd_data(struct
 
 #endif	/* CONFIG_JBD || CONFIG_JBD_MODULE || !__KERNEL__ */
 
+extern int jbd_commit_interval;
+
 /*
  * Compatibility no-ops which allow the kernel to compile without CONFIG_JBD
  * go here.
--- 2.4.19-pre10/include/linux/sysctl.h~ext3-commit-interval	Sat Jun  8 00:03:48 2002
+++ 2.4.19-pre10-akpm/include/linux/sysctl.h	Sat Jun  8 00:04:22 2002
@@ -546,6 +546,7 @@ enum
 	FS_LEASES=13,	/* int: leases enabled */
 	FS_DIR_NOTIFY=14,	/* int: directory notification enabled */
 	FS_LEASE_TIME=15,	/* int: maximum time to wait for a lease break */
+	FS_JBD,		/* JBD subdir */
 };
 
 /* CTL_DEBUG names: */
--- 2.4.19-pre10/Documentation/sysctl/fs.txt~ext3-commit-interval	Sat Jun  8 00:30:58 2002
+++ 2.4.19-pre10-akpm/Documentation/sysctl/fs.txt	Sat Jun  8 00:39:50 2002
@@ -27,6 +27,7 @@ Currently, these files are in /proc/sys/
 - overflowgid
 - super-max
 - super-nr
+- jbd/
 
 Documentation for the files in /proc/sys/fs/binfmt_misc is
 in Documentation/binfmt_misc.txt.
@@ -138,3 +139,40 @@ thus the maximum number of mounted files
 can have. You only need to increase super-max if you need to
 mount more filesystems than the current value in super-max
 allows you to.
+
+==============================================================
+
+jbd/jbd-commit-interval:
+
+Defines, in seconds, the largest period of time for which the
+Journalled Block Device driver (JBD) will allow dirty data to remain in
+memory.  JBD is used by the ext3 filesystem.
+
+The default value is five seconds.  Increasing this value will provide
+"longer" transactions, and may be used to avoid repetitive spinup of
+disk drives.
+
+Note that `kupdate' activity will also cause a JBD commit, so it is
+necessary to also increase the bdflush `interval' parameter.  This is
+the fifth field in /proc/sys/vm/bdflush.
+
+It should be noted that increasing the value of `jbd-commit-interval'
+will increase the potential for data loss in the event of a system
+crash.  ext3 recovery will only restore the filesystem state to that
+which pertained at the time of the last commit.  So setting this to
+five minutes means that you can lose up to five minute's worth of data.
+
+==============================================================
+
+jbd/jbd-debug:
+
+If the kernel was compiled for JBD debugging then this sysctl will
+cause status information to be generated by the JBD driver.  The
+default value is zero (no debugging).  Larger values cause ore
+information to be emitted into the system logs.
+
+Note that system logging messages can themselves generate disk activity
+which will trigger more JBD debug messages.  So this option can cause a
+rapid growth in logfile usage if it is used while a kernel logging
+daemon is in operation.
+

-
