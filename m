Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293553AbSCCJ5F>; Sun, 3 Mar 2002 04:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293547AbSCCJ46>; Sun, 3 Mar 2002 04:56:58 -0500
Received: from relay02.valueweb.net ([216.219.253.236]:63759 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S293536AbSCCJ4m>; Sun, 3 Mar 2002 04:56:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: Quota patches for 2.5 - 4
Date: Sun, 3 Mar 2002 04:56:59 -0500
X-Mailer: KMail [version 1.3.1]
Cc: jack@suse.cz, Alexander Viro <viro@math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020303095625Z293045-31620+4@thor.valueweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the fourth of 13 patches.

	This patch makes the quota code use procfs (if compiled in) for reporting 
the quota statistics.


diff -urN -X txt/diff-exclude linux-2.5-linus/fs/dquot.c linux-2.5/fs/dquot.c
--- linux-2.5-linus/fs/dquot.c	Sat Mar  2 19:23:11 2002
+++ linux-2.5/fs/dquot.c	Sat Mar  2 19:21:55 2002
@@ -61,11 +61,10 @@
 #include <linux/slab.h>
 #include <linux/smp_lock.h>
 #include <linux/init.h>
+#include <linux/proc_fs.h>
 
 #include <asm/uaccess.h>
 
-#define __DQUOT_VERSION__	"dquot_6.4.0"
-
 int nr_dquots, nr_free_dquots;
 
 static char *quotatypes[] = INITQFNAMES;
@@ -879,21 +878,6 @@
 	return QUOTA_OK;
 }
 
-static int get_stats(caddr_t addr)
-{
-	int error = -EFAULT;
-	struct dqstats stats;
-
-	dqstats.allocated_dquots = nr_dquots;
-	dqstats.free_dquots = nr_free_dquots;
-
-	/* make a copy, in case we page-fault in user space */
-	memcpy(&stats, &dqstats, sizeof(struct dqstats));
-	if (!copy_to_user(addr, &stats, sizeof(struct dqstats)))
-		error = 0;
-	return error;
-}
-
 /*
  * Externally referenced functions through dquot_operations in inode.
  *
@@ -1172,17 +1156,6 @@
 	return ret;
 }
 
-static int __init dquot_init(void)
-{
-	int i;
-
-	for (i = 0; i < NR_DQHASH; i++)
-		INIT_LIST_HEAD(dquot_hash + i);
-	printk(KERN_NOTICE "VFS: Diskquotas version %s initialized\n", 
__DQUOT_VERSION__);
-	return 0;
-}
-__initcall(dquot_init);
-
 /*
  * Definitions of diskquota operations.
  */
@@ -1426,3 +1399,52 @@
 	unlock_kernel();
 	return ret;
 }
+
+#ifdef CONFIG_PROC_FS
+static int read_stats(char *buffer, char **start, off_t offset, int count, 
int *eof, void *data)
+{
+	int len;
+	struct quota_format_type *actqf;
+
+	dqstats.allocated_dquots = nr_dquots;
+	dqstats.free_dquots = nr_free_dquots;
+
+	len = sprintf(buffer, "Version %u\n", __DQUOT_NUM_VERSION__);
+	len += sprintf(buffer + len, "Formats");
+	lock_kernel();
+	for (actqf = quota_formats; actqf; actqf = actqf->qf_next)
+		len += sprintf(buffer + len, " %u", actqf->qf_id);
+	unlock_kernel();
+	len += sprintf(buffer + len, "\n%u %u %u %u %u %u %u %u\n",
+			dqstats.lookups, dqstats.drops,
+			dqstats.reads, dqstats.writes,
+			dqstats.cache_hits, dqstats.allocated_dquots,
+			dqstats.free_dquots, dqstats.syncs);
+
+	if (offset >= len) {
+		*start = buffer;
+		*eof = 1;
+		return 0;
+	}
+	*start = buffer + offset;
+	if ((len -= offset) > count)
+		return count;
+	*eof = 1;
+
+	return len;
+}
+#endif
+
+static int __init dquot_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_DQHASH; i++)
+		INIT_LIST_HEAD(dquot_hash + i);
+	printk(KERN_NOTICE "VFS: Diskquotas version %s initialized\n", 
__DQUOT_VERSION__);
+#ifdef CONFIG_PROC_FS
+	create_proc_read_entry("fs/quota", 0, 0, read_stats, NULL);
+#endif
+	return 0;
+}
+__initcall(dquot_init);
diff -urN -X txt/diff-exclude linux-2.5-linus/include/linux/quota.h 
linux-2.5/include/linux/quota.h
--- linux-2.5-linus/include/linux/quota.h	Sat Mar  2 19:23:11 2002
+++ linux-2.5/include/linux/quota.h	Sat Mar  2 19:21:55 2002
@@ -42,6 +42,9 @@
 #include <linux/errno.h>
 #include <linux/types.h>
 
+#define __DQUOT_VERSION__	"dquot_6.5.1"
+#define __DQUOT_NUM_VERSION__	6*10000+5*100+1
+
 typedef __kernel_uid32_t qid_t; /* Type in which we store ids in memory */
 
 /*
