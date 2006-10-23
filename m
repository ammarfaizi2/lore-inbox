Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWJWEMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWJWEMX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 00:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWJWEMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 00:12:23 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:20610 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751445AbWJWEMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 00:12:21 -0400
Subject: [PATCH] Freeze bdevs when freezing processes.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 14:12:15 +1000
Message-Id: <1161576735.3466.7.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

XFS can continue to submit I/O from a timer routine, even after
freezeable kernel and userspace threads are frozen. This doesn't seem to
be an issue for current swsusp code, but is definitely an issue for
Suspend2, where the pages being written could be overwritten by
Suspend2's atomic copy.
    
We can address this issue by freezing bdevs after stopping userspace
threads, and thawing them prior to thawing userspace.
    
Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 4a001fe..ddeeb50 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -13,6 +13,7 @@ #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/buffer_head.h>
 #include <linux/freezer.h>
 
 /* 
@@ -20,6 +21,58 @@ #include <linux/freezer.h>
  */
 #define TIMEOUT	(20 * HZ)
 
+struct frozen_fs
+{
+	struct list_head fsb_list;
+	struct super_block *sb;
+};
+
+LIST_HEAD(frozen_fs_list);
+
+void freezer_make_fses_rw(void)
+{
+	struct frozen_fs *fs, *next_fs;
+
+	list_for_each_entry_safe(fs, next_fs, &frozen_fs_list, fsb_list) {
+		thaw_bdev(fs->sb->s_bdev, fs->sb);
+
+		list_del(&fs->fsb_list);
+		kfree(fs);
+	}
+}
+
+/* 
+ * Done after userspace is frozen, so there should be no danger of
+ * fses being unmounted while we're in here.
+ */
+int freezer_make_fses_ro(void)
+{
+	struct frozen_fs *fs;
+	struct super_block *sb;
+
+	/* Generate the list */
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (!sb->s_root || !sb->s_bdev ||
+		    (sb->s_frozen == SB_FREEZE_TRANS) ||
+		    (sb->s_flags & MS_RDONLY))
+			continue;
+
+		fs = kmalloc(sizeof(struct frozen_fs), GFP_ATOMIC);
+		if (!fs)
+			return 1;
+		fs->sb = sb;
+		list_add_tail(&fs->fsb_list, &frozen_fs_list);
+	};
+
+	/* Do the freezing in reverse order so filesystems dependant
+	 * upon others are frozen in the right order. (Eg loopback
+	 * on ext3). */
+	list_for_each_entry_reverse(fs, &frozen_fs_list, fsb_list)
+		freeze_bdev(fs->sb->s_bdev);
+
+	return 0;
+}
+
 
 static inline int freezeable(struct task_struct * p)
 {
@@ -119,7 +172,7 @@ int freeze_processes(void)
 		read_unlock(&tasklist_lock);
 		todo += nr_user;
 		if (!user_frozen && !nr_user) {
-			sys_sync();
+			freezer_make_fses_ro();
 			start_time = jiffies;
 		}
 		user_frozen = !nr_user;
@@ -174,6 +227,12 @@ void thaw_some_processes(int all)
 					"Strange, %s not stopped\n", p->comm );
 		} while_each_thread(g, p);
 
+		if (!pass) {
+			read_unlock(&tasklist_lock);
+			freezer_make_fses_rw();
+			read_lock(&tasklist_lock);
+		}
+
 		pass++;
 	} while (pass < 2 && all);
 


