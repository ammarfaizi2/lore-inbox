Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbVLJXd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbVLJXd2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 18:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVLJXd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 18:33:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932427AbVLJXd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 18:33:27 -0500
Date: Sat, 10 Dec 2005 15:33:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: adi@hexapodia.org, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-Id: <20051210153306.02377935.akpm@osdl.org>
In-Reply-To: <200512110007.35346.rjw@sisk.pl>
References: <20051205081935.GI22168@hexapodia.org>
	<200512060005.04556.rjw@sisk.pl>
	<20051210142149.f3f8fc02.akpm@osdl.org>
	<200512110007.35346.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
>  Would that be ok if I made drop_pagecache() nonstatic and called it directly
>  from swsusp?

Sure, I'll updates the patch for that.

It changed a bit..  You'll need to run sys_sync() then drop_pagecache()
then drop_slab().


From: Andrew Morton <akpm@osdl.org>

Add /proc/sys/vm/drop_caches.  When written to, this will cause the kernel
to discard as much pagecache and/or reclaimable slab objects as it can.

It won't drop dirty data, so the user should run `sync' first.

Caveats:

a) Holds inode_lock for exorbitant amounts of time.

b) Needs to be taught about NUMA nodes: propagate these all the way through
   so the discarding can be controlled on a per-node basis.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 Documentation/filesystems/proc.txt |   17 +++++++++
 Documentation/sysctl/vm.txt        |    3 +
 fs/Makefile                        |    2 -
 fs/drop_caches.c                   |   68 +++++++++++++++++++++++++++++++++++++
 include/linux/mm.h                 |    7 +++
 include/linux/sysctl.h             |    1 
 kernel/sysctl.c                    |   10 +++++
 mm/truncate.c                      |    1 
 mm/vmscan.c                        |    3 -
 9 files changed, 107 insertions(+), 5 deletions(-)

diff -puN /dev/null fs/drop_caches.c
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ devel-akpm/fs/drop_caches.c	2005-12-10 15:31:19.000000000 -0800
@@ -0,0 +1,68 @@
+/*
+ * Implement the manual drop-all-pagecache function
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/writeback.h>
+#include <linux/sysctl.h>
+#include <linux/gfp.h>
+
+/* A global variable is a bit ugly, but it keeps the code simple */
+int sysctl_drop_caches;
+
+static void drop_pagecache_sb(struct super_block *sb)
+{
+	struct inode *inode;
+
+	spin_lock(&inode_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		if (inode->i_state & (I_FREEING|I_WILL_FREE))
+			continue;
+		invalidate_inode_pages(inode->i_mapping);
+	}
+	spin_unlock(&inode_lock);
+}
+
+void drop_pagecache(void)
+{
+	struct super_block *sb;
+
+	spin_lock(&sb_lock);
+restart:
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+		down_read(&sb->s_umount);
+		if (sb->s_root)
+			drop_pagecache_sb(sb);
+		up_read(&sb->s_umount);
+		spin_lock(&sb_lock);
+		if (__put_super_and_need_restart(sb))
+			goto restart;
+	}
+	spin_unlock(&sb_lock);
+}
+
+void drop_slab(void)
+{
+	int nr_objects;
+
+	do {
+		nr_objects = shrink_slab(1000, GFP_KERNEL, 1000);
+	} while (nr_objects > 10);
+}
+
+int drop_caches_sysctl_handler(ctl_table *table, int write,
+	struct file *file, void __user *buffer, size_t *length, loff_t *ppos)
+{
+	proc_dointvec_minmax(table, write, file, buffer, length, ppos);
+	if (write) {
+		if (sysctl_drop_caches & 1)
+			drop_pagecache();
+		if (sysctl_drop_caches & 2)
+			drop_slab();
+	}
+	return 0;
+}
diff -puN fs/Makefile~drop-pagecache fs/Makefile
--- devel/fs/Makefile~drop-pagecache	2005-12-10 15:30:17.000000000 -0800
+++ devel-akpm/fs/Makefile	2005-12-10 15:30:17.000000000 -0800
@@ -10,7 +10,7 @@ obj-y :=	open.o read_write.o file_table.
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
-		ioprio.o pnode.o
+		ioprio.o pnode.o drop_caches.o
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
diff -puN include/linux/mm.h~drop-pagecache include/linux/mm.h
--- devel/include/linux/mm.h~drop-pagecache	2005-12-10 15:30:17.000000000 -0800
+++ devel-akpm/include/linux/mm.h	2005-12-10 15:31:35.000000000 -0800
@@ -1010,5 +1010,12 @@ int in_gate_area_no_task(unsigned long a
 /* /proc/<pid>/oom_adj set to -17 protects from the oom-killer */
 #define OOM_DISABLE -17
 
+int drop_caches_sysctl_handler(struct ctl_table *, int, struct file *,
+					void __user *, size_t *, loff_t *);
+int shrink_slab(unsigned long scanned, gfp_t gfp_mask,
+			unsigned long lru_pages);
+void drop_pagecache(void);
+void drop_slab(void);
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff -puN include/linux/sysctl.h~drop-pagecache include/linux/sysctl.h
--- devel/include/linux/sysctl.h~drop-pagecache	2005-12-10 15:30:17.000000000 -0800
+++ devel-akpm/include/linux/sysctl.h	2005-12-10 15:30:17.000000000 -0800
@@ -180,6 +180,7 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_DROP_PAGECACHE=29,	/* int: nuke lots of pagecache */
 };
 
 
diff -puN kernel/sysctl.c~drop-pagecache kernel/sysctl.c
--- devel/kernel/sysctl.c~drop-pagecache	2005-12-10 15:30:17.000000000 -0800
+++ devel-akpm/kernel/sysctl.c	2005-12-10 15:30:17.000000000 -0800
@@ -68,6 +68,7 @@ extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
+extern int sysctl_drop_caches;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -775,6 +776,15 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_intvec,
 	},
 	{
+		.ctl_name	= VM_DROP_PAGECACHE,
+		.procname	= "drop_caches",
+		.data		= &sysctl_drop_caches,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= drop_caches_sysctl_handler,
+		.strategy	= &sysctl_intvec,
+	},
+	{
 		.ctl_name	= VM_MIN_FREE_KBYTES,
 		.procname	= "min_free_kbytes",
 		.data		= &min_free_kbytes,
diff -puN mm/truncate.c~drop-pagecache mm/truncate.c
--- devel/mm/truncate.c~drop-pagecache	2005-12-10 15:30:17.000000000 -0800
+++ devel-akpm/mm/truncate.c	2005-12-10 15:30:17.000000000 -0800
@@ -249,7 +249,6 @@ unlock:
 				break;
 		}
 		pagevec_release(&pvec);
-		cond_resched();
 	}
 	return ret;
 }
diff -puN mm/vmscan.c~drop-pagecache mm/vmscan.c
--- devel/mm/vmscan.c~drop-pagecache	2005-12-10 15:30:17.000000000 -0800
+++ devel-akpm/mm/vmscan.c	2005-12-10 15:30:17.000000000 -0800
@@ -183,8 +183,7 @@ EXPORT_SYMBOL(remove_shrinker);
  *
  * Returns the number of slab objects which we shrunk.
  */
-static int shrink_slab(unsigned long scanned, gfp_t gfp_mask,
-			unsigned long lru_pages)
+int shrink_slab(unsigned long scanned, gfp_t gfp_mask, unsigned long lru_pages)
 {
 	struct shrinker *shrinker;
 	int ret = 0;
diff -puN Documentation/sysctl/vm.txt~drop-pagecache Documentation/sysctl/vm.txt
--- devel/Documentation/sysctl/vm.txt~drop-pagecache	2005-12-10 15:30:17.000000000 -0800
+++ devel-akpm/Documentation/sysctl/vm.txt	2005-12-10 15:30:17.000000000 -0800
@@ -26,12 +26,13 @@ Currently, these files are in /proc/sys/
 - min_free_kbytes
 - laptop_mode
 - block_dump
+- drop-caches
 
 ==============================================================
 
 dirty_ratio, dirty_background_ratio, dirty_expire_centisecs,
 dirty_writeback_centisecs, vfs_cache_pressure, laptop_mode,
-block_dump, swap_token_timeout:
+block_dump, swap_token_timeout, drop-caches:
 
 See Documentation/filesystems/proc.txt
 
diff -puN Documentation/filesystems/proc.txt~drop-pagecache Documentation/filesystems/proc.txt
--- devel/Documentation/filesystems/proc.txt~drop-pagecache	2005-12-10 15:30:17.000000000 -0800
+++ devel-akpm/Documentation/filesystems/proc.txt	2005-12-10 15:30:17.000000000 -0800
@@ -1302,6 +1302,23 @@ VM has token based thrashing control mec
 unnecessary page faults in thrashing situation. The unit of the value is
 second. The value would be useful to tune thrashing behavior.
 
+drop_caches
+-----------
+
+Writing to this will cause the kernel to drop clean caches, dentries and
+inodes from memory, causing that memory to become free.
+
+To free caches:
+	echo 1 > /proc/sys/vm/drop_caches
+To free dentries and inodes:
+	echo 2 > /proc/sys/vm/drop_caches
+To free caches, dentries and inodes:
+	echo 3 > /proc/sys/vm/drop_caches
+
+As this is a non-destructive operation and dirty objects are not freeable, the
+user should run `sync' first.
+
+
 2.5 /proc/sys/dev - Device specific parameters
 ----------------------------------------------
 
_

