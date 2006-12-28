Return-Path: <linux-kernel-owner+w=401wt.eu-S964862AbWL1DRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWL1DRS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 22:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWL1DRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 22:17:18 -0500
Received: from mga05.intel.com ([192.55.52.89]:9048 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964862AbWL1DRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 22:17:17 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,213,1165219200"; 
   d="scan'208"; a="182309769:sNHT20469211"
Subject: [PATCH] drop page cache of a single file
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Date: Thu, 28 Dec 2006 11:17:25 +0800
Message-Id: <1167275845.15989.153.camel@ymzhang>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.2 (2.9.2-2.fc7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, by /proc/sys/vm/drop_caches, applications could drop pagecache,
slab(dentries and inodes), or both, but applications couldn't choose to
just drop the page cache of one file. An user of VOD (Video-On-Demand)
needs this capability to have more detailed control on page cache release.

Below patch against 2.6.19 implements it.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

diff -Nraup linux-2.6.19/Documentation/filesystems/proc.txt linux-2.6.19_dropcache/Documentation/filesystems/proc.txt
--- linux-2.6.19/Documentation/filesystems/proc.txt	2006-12-08 15:32:44.000000000 +0800
+++ linux-2.6.19_dropcache/Documentation/filesystems/proc.txt	2006-12-28 10:20:39.000000000 +0800
@@ -1320,6 +1320,8 @@ To free dentries and inodes:
 	echo 2 > /proc/sys/vm/drop_caches
 To free pagecache, dentries and inodes:
 	echo 3 > /proc/sys/vm/drop_caches
+To free the pagecache of one file:
+	echo "4 /path/to/filename" > /proc/sys/vm/drop_caches
 
 As this is a non-destructive operation and dirty objects are not freeable, the
 user should run `sync' first.
diff -Nraup linux-2.6.19/fs/drop_caches.c linux-2.6.19_dropcache/fs/drop_caches.c
--- linux-2.6.19/fs/drop_caches.c	2006-12-08 15:31:58.000000000 +0800
+++ linux-2.6.19_dropcache/fs/drop_caches.c	2006-12-28 11:04:22.000000000 +0800
@@ -8,9 +8,9 @@
 #include <linux/writeback.h>
 #include <linux/sysctl.h>
 #include <linux/gfp.h>
+#include <linux/namei.h>
 
-/* A global variable is a bit ugly, but it keeps the code simple */
-int sysctl_drop_caches;
+char sysctl_drop_caches[PATH_MAX+2];
 
 static void drop_pagecache_sb(struct super_block *sb)
 {
@@ -54,15 +54,70 @@ void drop_slab(void)
 	} while (nr_objects > 10);
 }
 
+void drop_file_pagecache(char *path)
+{
+	struct inode *inode;
+	struct nameidata nd;
+	int error;
+
+	if (!path || !*path)
+		return;
+
+	error = path_lookup(path, LOOKUP_FOLLOW, &nd);
+	if (error)
+		return;
+
+	inode = nd.dentry->d_inode;
+	if (!(inode->i_state & (I_FREEING|I_WILL_FREE)))
+		invalidate_inode_pages(inode->i_mapping);
+	path_release(&nd);
+
+	return;
+}
+
 int drop_caches_sysctl_handler(ctl_table *table, int write,
 	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
 {
-	proc_dointvec_minmax(table, write, file, buffer, length, ppos);
-	if (write) {
-		if (sysctl_drop_caches & 1)
+	int error;
+	char *path;
+	int operation;
+
+	error = proc_dostring(table, write, file, buffer, length, ppos);
+	if (write && !error) {
+		sscanf(sysctl_drop_caches, "%d", &operation);
+
+		switch (operation) {
+		case 1:
 			drop_pagecache();
-		if (sysctl_drop_caches & 2)
+			break;
+		case 2:
 			drop_slab();
+			break;
+		case 3:
+			drop_pagecache();
+			drop_slab();
+			break;
+		case 4:
+			/*
+			 * The format in sysctl_drop_caches is:
+			 * 4 /path/to/filename
+			 */
+			path = strchr(sysctl_drop_caches, '4');
+			if (!path)
+				break;
+
+			path ++;
+			while (*path) {
+				if (*path == ' ' || *path == '\t')
+					path ++;
+				else
+					break;
+			}
+
+			drop_file_pagecache(path);
+			break;
+		}
 	}
 	return 0;
 }
+
diff -Nraup linux-2.6.19/include/linux/mm.h linux-2.6.19_dropcache/include/linux/mm.h
--- linux-2.6.19/include/linux/mm.h	2006-12-08 15:32:49.000000000 +0800
+++ linux-2.6.19_dropcache/include/linux/mm.h	2006-12-28 09:59:10.000000000 +0800
@@ -1121,6 +1121,7 @@ unsigned long shrink_slab(unsigned long 
 			unsigned long lru_pages);
 void drop_pagecache(void);
 void drop_slab(void);
+void drop_file_pagecache(char *path);
 
 #ifndef CONFIG_MMU
 #define randomize_va_space 0
diff -Nraup linux-2.6.19/kernel/sysctl.c linux-2.6.19_dropcache/kernel/sysctl.c
--- linux-2.6.19/kernel/sysctl.c	2006-12-08 15:32:49.000000000 +0800
+++ linux-2.6.19_dropcache/kernel/sysctl.c	2006-12-28 09:50:18.000000000 +0800
@@ -73,7 +73,7 @@ extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
-extern int sysctl_drop_caches;
+extern char sysctl_drop_caches[PATH_MAX+2];
 extern int percpu_pagelist_fraction;
 extern int compat_log;
 
@@ -901,10 +901,10 @@ static ctl_table vm_table[] = {
 		.ctl_name	= VM_DROP_PAGECACHE,
 		.procname	= "drop_caches",
 		.data		= &sysctl_drop_caches,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(sysctl_drop_caches),
 		.mode		= 0644,
 		.proc_handler	= drop_caches_sysctl_handler,
-		.strategy	= &sysctl_intvec,
+		.strategy	= &sysctl_string,
 	},
 	{
 		.ctl_name	= VM_MIN_FREE_KBYTES,
