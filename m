Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVJNAI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVJNAI6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 20:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVJNAI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 20:08:58 -0400
Received: from host-84-9-201-133.bulldogdsl.com ([84.9.201.133]:12936 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932186AbVJNAI5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 20:08:57 -0400
Date: Fri, 14 Oct 2005 01:08:54 +0100
From: Ben Dooks <ben@fluff.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fs - fix sparse errors
Message-ID: <20051014000854.GA28803@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

There are a number of sparse warnings coming
from the fs subdirectory, mainly due to not
defining functions that are used by other files,
as well as 0/NULL patch to fs/proc/task_mmu.c

This patch creates a header with the definitions
in and includes it into the relevant .c files,
and moves the proc definitions into 
linux/proc_fs.h

Also cleans up some static definitions in
fs/inotify.c

Files modified:

 fs/block_dev.c          |    2 ++
 fs/char_dev.c           |    2 ++
 fs/compat.c             |    4 ++--
 fs/filesystems.c        |    3 +++
 fs/fs-writeback.c       |    2 +-
 fs/fs.h                 |   16 ++++++++++++++++
 fs/inotify.c            |    6 +++---
 fs/locks.c              |    1 +
 fs/namespace.c          |    2 ++
 fs/proc/proc_misc.c     |   13 -------------
 fs/proc/task_mmu.c      |    2 +-
 fs/super.c              |    3 +--
 include/linux/proc_fs.h |   15 +++++++++++++++
 kernel/exec_domain.c    |    2 +-
 14 files changed, 50 insertions(+), 23 deletions(-)



Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fs-sparse-fix-part1.patch"

diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3/fs/block_dev.c linux-2.6.14-rc4-bjd3b/fs/block_dev.c
--- linux-2.6.14-rc4-bjd3/fs/block_dev.c	2005-09-01 21:02:38.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/fs/block_dev.c	2005-10-14 01:03:22.000000000 +0100
@@ -25,6 +25,8 @@
 #include <linux/namei.h>
 #include <asm/uaccess.h>
 
+#include "fs.h"
+
 struct bdev_inode {
 	struct block_device bdev;
 	struct inode vfs_inode;
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3/fs/char_dev.c linux-2.6.14-rc4-bjd3b/fs/char_dev.c
--- linux-2.6.14-rc4-bjd3/fs/char_dev.c	2005-09-01 21:02:38.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/fs/char_dev.c	2005-10-14 00:42:11.000000000 +0100
@@ -20,6 +20,8 @@
 #include <linux/kobj_map.h>
 #include <linux/cdev.h>
 
+#include <linux/proc_fs.h>
+
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3/fs/compat.c linux-2.6.14-rc4-bjd3b/fs/compat.c
--- linux-2.6.14-rc4-bjd3/fs/compat.c	2005-10-11 10:56:33.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/fs/compat.c	2005-10-14 00:32:08.000000000 +0100
@@ -53,6 +53,8 @@
 #include <asm/mmu_context.h>
 #include <asm/ioctls.h>
 
+#include "fs.h"
+
 /*
  * Not all architectures have sys_utime, so implement this in terms
  * of sys_utimes.
@@ -787,8 +789,6 @@ static int do_nfs4_super_data_conv(void 
 	return 0;
 }
 
-extern int copy_mount_options (const void __user *, unsigned long *);
-
 #define SMBFS_NAME      "smbfs"
 #define NCPFS_NAME      "ncpfs"
 #define NFS4_NAME	"nfs4"
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3/fs/filesystems.c linux-2.6.14-rc4-bjd3b/fs/filesystems.c
--- linux-2.6.14-rc4-bjd3/fs/filesystems.c	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/fs/filesystems.c	2005-10-14 00:43:06.000000000 +0100
@@ -13,6 +13,9 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <asm/uaccess.h>
+#include <linux/proc_fs.h>
+
+#include "fs.h"
 
 /*
  * Handling of filesystem drivers list.
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3/fs/fs-writeback.c linux-2.6.14-rc4-bjd3b/fs/fs-writeback.c
--- linux-2.6.14-rc4-bjd3/fs/fs-writeback.c	2005-09-01 21:02:38.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/fs/fs-writeback.c	2005-10-14 00:31:07.000000000 +0100
@@ -23,7 +23,7 @@
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
 
-extern struct super_block *blockdev_superblock;
+#include "fs.h"
 
 /**
  *	__mark_inode_dirty -	internal function
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3/fs/fs.h linux-2.6.14-rc4-bjd3b/fs/fs.h
--- linux-2.6.14-rc4-bjd3/fs/fs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/fs/fs.h	2005-10-14 00:33:53.000000000 +0100
@@ -0,0 +1,16 @@
+/* linux/fs/fs.h
+ *
+ * (C) 2005 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Filesystem internal declarations
+ *
+ * Licensed under GPLv2 
+*/
+
+extern void get_filesystem(struct file_system_type *fs);
+extern void put_filesystem(struct file_system_type *fs);
+
+extern struct super_block *blockdev_superblock;
+
+extern int copy_mount_options (const void __user *, unsigned long *);
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3/fs/inotify.c linux-2.6.14-rc4-bjd3b/fs/inotify.c
--- linux-2.6.14-rc4-bjd3/fs/inotify.c	2005-10-11 10:56:33.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/fs/inotify.c	2005-10-14 00:46:11.000000000 +0100
@@ -45,9 +45,9 @@ static kmem_cache_t *event_cachep;
 static struct vfsmount *inotify_mnt;
 
 /* these are configurable via /proc/sys/fs/inotify/ */
-int inotify_max_user_instances;
-int inotify_max_user_watches;
-int inotify_max_queued_events;
+static int inotify_max_user_instances;
+static int inotify_max_user_watches;
+static int inotify_max_queued_events;
 
 /*
  * Lock ordering:
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3/fs/locks.c linux-2.6.14-rc4-bjd3b/fs/locks.c
--- linux-2.6.14-rc4-bjd3/fs/locks.c	2005-10-11 10:56:33.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/fs/locks.c	2005-10-14 00:42:39.000000000 +0100
@@ -125,6 +125,7 @@
 #include <linux/syscalls.h>
 #include <linux/time.h>
 #include <linux/rcupdate.h>
+#include <linux/proc_fs.h>
 
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3/fs/namespace.c linux-2.6.14-rc4-bjd3b/fs/namespace.c
--- linux-2.6.14-rc4-bjd3/fs/namespace.c	2005-10-11 10:56:33.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/fs/namespace.c	2005-10-14 00:32:24.000000000 +0100
@@ -25,6 +25,8 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
+#include "fs.h"
+
 extern int __init init_rootfs(void);
 
 #ifdef CONFIG_SYSFS
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3/fs/proc/proc_misc.c linux-2.6.14-rc4-bjd3b/fs/proc/proc_misc.c
--- linux-2.6.14-rc4-bjd3/fs/proc/proc_misc.c	2005-09-01 21:02:38.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/fs/proc/proc_misc.c	2005-10-14 00:40:25.000000000 +0100
@@ -54,19 +54,6 @@
 
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
-/*
- * Warning: stuff below (imported functions) assumes that its output will fit
- * into one page. For some of those functions it may be wrong. Moreover, we
- * have a way to deal with that gracefully. Right now I used straightforward
- * wrappers, but this needs further analysis wrt potential overflows.
- */
-extern int get_hardware_list(char *);
-extern int get_stram_list(char *);
-extern int get_chrdev_list(char *);
-extern int get_filesystem_list(char *);
-extern int get_exec_domain_list(char *);
-extern int get_dma_list(char *);
-extern int get_locks_status (char *, char **, off_t, int);
 
 static int proc_calc_metrics(char *page, char **start, off_t off,
 				 int count, int *eof, int len)
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3/fs/proc/task_mmu.c linux-2.6.14-rc4-bjd3b/fs/proc/task_mmu.c
--- linux-2.6.14-rc4-bjd3/fs/proc/task_mmu.c	2005-10-11 10:56:33.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/fs/proc/task_mmu.c	2005-10-14 00:19:11.000000000 +0100
@@ -178,7 +178,7 @@ static int show_map_internal(struct seq_
 
 static int show_map(struct seq_file *m, void *v)
 {
-	return show_map_internal(m, v, 0);
+	return show_map_internal(m, v, NULL);
 }
 
 static void smaps_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3/fs/super.c linux-2.6.14-rc4-bjd3b/fs/super.c
--- linux-2.6.14-rc4-bjd3/fs/super.c	2005-09-01 21:02:38.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/fs/super.c	2005-10-14 00:23:15.000000000 +0100
@@ -39,9 +39,8 @@
 #include <linux/kobject.h>
 #include <asm/uaccess.h>
 
+#include "fs.h"
 
-void get_filesystem(struct file_system_type *fs);
-void put_filesystem(struct file_system_type *fs);
 struct file_system_type *get_fs_type(const char *name);
 
 LIST_HEAD(super_blocks);
--- linux-2.6.14-rc4-bjd3/include/linux/proc_fs.h	2005-09-01 21:02:39.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/include/linux/proc_fs.h	2005-10-14 00:41:15.000000000 +0100
@@ -104,6 +104,21 @@ unsigned long task_vsize(struct mm_struc
 int task_statm(struct mm_struct *, int *, int *, int *, int *);
 char *task_mem(struct mm_struct *, char *);
 
+/*
+ * Warning: stuff below (imported functions) assumes that its output will fit
+ * into one page. For some of those functions it may be wrong. Moreover, we
+ * have a way to deal with that gracefully. Right now I used straightforward
+ * wrappers, but this needs further analysis wrt potential overflows.
+ */
+
+extern int get_locks_status (char *, char **, off_t, int);
+extern int get_filesystem_list(char *);
+extern int get_chrdev_list(char *);
+extern int get_hardware_list(char *);
+extern int get_stram_list(char *);
+extern int get_exec_domain_list(char *);
+extern int get_dma_list(char *);
+
 extern struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
 						struct proc_dir_entry *parent);
 extern void remove_proc_entry(const char *name, struct proc_dir_entry *parent);
diff -urpN -X ../dontdiff linux-2.6.14-rc4-bjd3/kernel/exec_domain.c linux-2.6.14-rc4-bjd3b/kernel/exec_domain.c
--- linux-2.6.14-rc4-bjd3/kernel/exec_domain.c	2005-06-17 20:48:29.000000000 +0100
+++ linux-2.6.14-rc4-bjd3b/kernel/exec_domain.c	2005-10-14 00:52:54.000000000 +0100
@@ -17,7 +17,7 @@
 #include <linux/syscalls.h>
 #include <linux/sysctl.h>
 #include <linux/types.h>
-
+#include <linux/proc_fs.h>
 
 static void default_handler(int, struct pt_regs *);
 

--0F1p//8PRICkK4MW--
