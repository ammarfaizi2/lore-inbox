Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318318AbSGXXth>; Wed, 24 Jul 2002 19:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318319AbSGXXth>; Wed, 24 Jul 2002 19:49:37 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:7042 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318318AbSGXXta>;
	Wed, 24 Jul 2002 19:49:30 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 24 Jul 2002 17:46:05 -0600
To: sct@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Allow changing of journaling commit interval
Message-ID: <20020724174605.M13812@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addeds a sysctl entry for changing the journal commit interval
for ext3.

It's extracted from the -tmcitk (too many chefs in the kitchen) and the
-jrua (Joe random useless acronym) trees.

Stephen, can you take a look at this and tell me if the locking is sane and
safe for ext3?  I looked it over for some time and ran it in several
configurations without error but I'd consider the locking about as safe as
a Rusty Russell patch swinging a chainsaw until you gave it a look.

diff -Nru a/fs/jbd/journal.c b/fs/jbd/journal.c
--- a/fs/jbd/journal.c	Wed Jul 24 17:38:08 2002
+++ b/fs/jbd/journal.c	Wed Jul 24 17:38:08 2002
@@ -36,6 +36,7 @@
 #include <linux/slab.h>
 #include <asm/uaccess.h>
 #include <linux/proc_fs.h>
+#include <linux/sysctl.h>
 
 EXPORT_SYMBOL(journal_start);
 EXPORT_SYMBOL(journal_try_start);
@@ -195,6 +196,66 @@
 
 journal_t *current_journal;		// AKPM: debug
 
+/* sysctl variable for changing the commit interval on all journals */
+int journal_commit_interval = 5;
+
+#ifdef CONFIG_SYSCTL
+/*
+ * Change the value of journal_commit_interval and then change the
+ * corresponding value in every journal.  This function also resets
+ * the commit timers for the journal.
+ *  -- Cort <cort@fsmlabs.com>
+ */
+int journal_dointvec(ctl_table *table, int write, struct file *filp,
+		     void *buffer, size_t *lenp)
+{
+	int i;
+	struct list_head *list;
+
+	/* do the normal parsing to get an int */
+	if ( (i = proc_dointvec(table,write,filp,buffer,lenp)) )
+		return i;
+
+	/* we have the new value, change it in all journals */
+	list_for_each(list, &all_journals)
+	{
+		unsigned long new_expires;
+		
+		journal_t *journal =
+			list_entry(list, journal_t, j_all_journals);
+
+		lock_journal(journal);
+		
+		/* compute the new expire time */
+		new_expires = (journal->j_commit_timer->expires -
+			       journal->j_commit_interval) +
+			(journal_commit_interval*HZ);
+			
+		/* set the new interval */
+		journal->j_commit_interval =
+			journal_commit_interval*HZ;
+
+		/* set the new expire for the transaction */
+		if ( journal->j_running_transaction )
+			journal->j_running_transaction->t_expires =
+				new_expires;
+		
+		/* Adjust each timer for the new interval taking
+		 * into account how long it has already been since
+		 * the last commit.  We don't modify timers that
+		 * are not already active since they get set and
+		 * activated elsewhere when they're needed.
+		 */
+		if ( journal->j_commit_timer_active )
+			mod_timer( journal->j_commit_timer, new_expires );
+
+		unlock_journal(journal);
+	}
+	
+	return 0;
+}
+#endif /* CONFIG_SYSCTL */
+
 int kjournald(void *arg)
 {
 	journal_t *journal = (journal_t *) arg;
@@ -688,7 +749,7 @@
 	init_MUTEX(&journal->j_checkpoint_sem);
 	init_MUTEX(&journal->j_sem);
 
-	journal->j_commit_interval = (HZ * 5);
+	journal->j_commit_interval = journal_commit_interval*HZ;
 
 	/* The journal is marked for error until we succeed with recovery! */
 	journal->j_flags = JFS_ABORT;
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Wed Jul 24 17:38:08 2002
+++ b/include/linux/sysctl.h	Wed Jul 24 17:38:08 2002
@@ -543,6 +543,7 @@
 	FS_LEASES=13,	/* int: leases enabled */
 	FS_DIR_NOTIFY=14,	/* int: directory notification enabled */
 	FS_LEASE_TIME=15,	/* int: maximum time to wait for a lease break */
+	FS_JOURNAL_TIMEOUT=16,	/* int: time between journal commits */
 };
 
 /* CTL_DEBUG names: */
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	Wed Jul 24 17:38:07 2002
+++ b/kernel/sysctl.c	Wed Jul 24 17:38:07 2002
@@ -91,6 +91,12 @@
 		  void *buffer, size_t *lenp);
 #endif
 
+#ifdef CONFIG_EXT3_FS
+extern int journal_commit_interval;
+int journal_dointvec(ctl_table *, int, struct file *, void *, size_t *);
+#endif /* CONFIG_EXT3_FS */
+
+
 #ifdef CONFIG_BSD_PROCESS_ACCT
 extern int acct_parm[];
 #endif
@@ -306,6 +312,10 @@
 	 sizeof(int), 0644, NULL, &proc_dointvec},
 	{FS_LEASE_TIME, "lease-break-time", &lease_break_time, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+#ifdef CONFIG_EXT3_FS
+	{FS_JOURNAL_TIMEOUT, "journal-commit-interval",
+	 &journal_commit_interval, sizeof(int), 0644, NULL, &journal_dointvec},
+#endif /* CONFIG_EXT3_FS */
 	{0}
 };
 
