Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbWH2SLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbWH2SLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWH2SLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:11:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31716 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965207AbWH2SGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:06:08 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 06/19] BLOCK: Move extern declarations out of fs/*.c into header files [try #6]
Date: Tue, 29 Aug 2006 19:06:05 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829180605.32596.95917.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
References: <20060829180552.32596.15290.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Create a new header file, fs/internal.h, for common definitions local to the
sources in the fs/ directory.

Move extern definitions that should be in header files from fs/*.c to
fs/internal.h or other main header files where they span directories.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/binfmt_elf.c        |    1 -
 fs/block_dev.c         |    1 +
 fs/char_dev.c          |    1 +
 fs/compat.c            |    8 +-------
 fs/compat_ioctl.c      |    2 --
 fs/dcache.c            |    4 +---
 fs/fs-writeback.c      |    3 +--
 fs/internal.h          |   36 ++++++++++++++++++++++++++++++++++++
 fs/namespace.c         |   12 +-----------
 include/linux/compat.h |    1 +
 include/linux/ramfs.h  |    1 +
 include/linux/sysfs.h  |    9 +++++++++
 include/linux/tty.h    |    3 +++
 13 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 672a3b9..deb4269 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -46,7 +46,6 @@ #include <asm/page.h>
 static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs);
 static int load_elf_library(struct file *);
 static unsigned long elf_map (struct file *, unsigned long, struct elf_phdr *, int, int);
-extern int dump_fpu (struct pt_regs *, elf_fpregset_t *);
 
 #ifndef elf_addr_t
 #define elf_addr_t unsigned long
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 045f988..1c146a2 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -22,6 +22,7 @@ #include <linux/mount.h>
 #include <linux/uio.h>
 #include <linux/namei.h>
 #include <asm/uaccess.h>
+#include "internal.h"
 
 struct bdev_inode {
 	struct block_device bdev;
diff --git a/fs/char_dev.c b/fs/char_dev.c
index 3483d3c..a35775b 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -23,6 +23,7 @@ #include <linux/mutex.h>
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
+#include "internal.h"
 
 static struct kobj_map *cdev_map;
 
diff --git a/fs/compat.c b/fs/compat.c
index e31e9cf..f7ce0f5 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -52,8 +52,7 @@ #include <net/sock.h>		/* siocdevprivate
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/ioctls.h>
-
-extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
+#include "internal.h"
 
 int compat_log = 1;
 
@@ -313,9 +312,6 @@ out:
 #define IOCTL_HASHSIZE 256
 static struct ioctl_trans *ioctl32_hash_table[IOCTL_HASHSIZE];
 
-extern struct ioctl_trans ioctl_start[];
-extern int ioctl_table_size;
-
 static inline unsigned long ioctl32_hash(unsigned long cmd)
 {
 	return (((cmd >> 6) ^ (cmd >> 4) ^ cmd)) % IOCTL_HASHSIZE;
@@ -838,8 +834,6 @@ static int do_nfs4_super_data_conv(void 
 	return 0;
 }
 
-extern int copy_mount_options (const void __user *, unsigned long *);
-
 #define SMBFS_NAME      "smbfs"
 #define NCPFS_NAME      "ncpfs"
 #define NFS4_NAME	"nfs4"
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 4063a93..ab74c9b 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1279,8 +1279,6 @@ static int loop_status(unsigned int fd, 
 	return err;
 }
 
-extern int tty_ioctl(struct inode * inode, struct file * file, unsigned int cmd, unsigned long arg);
-
 #ifdef CONFIG_VT
 
 static int vt_check(struct file *file)
diff --git a/fs/dcache.c b/fs/dcache.c
index 1b4a3a3..ae6d053 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@ #include <linux/security.h>
 #include <linux/seqlock.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
+#include "internal.h"
 
 
 int sysctl_vfs_cache_pressure __read_mostly = 100;
@@ -1742,9 +1743,6 @@ kmem_cache_t *filp_cachep __read_mostly;
 
 EXPORT_SYMBOL(d_genocide);
 
-extern void bdev_cache_init(void);
-extern void chrdev_init(void);
-
 void __init vfs_caches_init_early(void)
 {
 	dcache_init_early();
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 892643d..0639024 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -22,8 +22,7 @@ #include <linux/writeback.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
-
-extern struct super_block *blockdev_superblock;
+#include "internal.h"
 
 /**
  *	__mark_inode_dirty -	internal function
diff --git a/fs/internal.h b/fs/internal.h
new file mode 100644
index 0000000..c21ecd3
--- /dev/null
+++ b/fs/internal.h
@@ -0,0 +1,36 @@
+/* fs/ internal definitions
+ *
+ * Copyright (C) 2006 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/ioctl32.h>
+
+/*
+ * block_dev.c
+ */
+extern struct super_block *blockdev_superblock;
+extern void __init bdev_cache_init(void);
+
+/*
+ * char_dev.c
+ */
+extern void __init chrdev_init(void);
+
+/*
+ * compat_ioctl.c
+ */
+#ifdef CONFIG_COMPAT
+extern struct ioctl_trans ioctl_start[];
+extern int ioctl_table_size;
+#endif
+
+/*
+ * namespace.c
+ */
+extern int copy_mount_options(const void __user *, unsigned long *);
diff --git a/fs/namespace.c b/fs/namespace.c
index fa7ed6a..6100d84 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -22,21 +22,11 @@ #include <linux/namespace.h>
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/mount.h>
+#include <linux/ramfs.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include "pnode.h"
 
-extern int __init init_rootfs(void);
-
-#ifdef CONFIG_SYSFS
-extern int __init sysfs_init(void);
-#else
-static inline int sysfs_init(void)
-{
-	return 0;
-}
-#endif
-
 /* spinlock for vfsmount related operations, inplace of dcache_lock */
 __cacheline_aligned_in_smp DEFINE_SPINLOCK(vfsmount_lock);
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 9760753..967e748 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -227,6 +227,7 @@ static inline int compat_timespec_compar
 asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp);
 
 extern int compat_printk(const char *fmt, ...);
+extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
 
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff --git a/include/linux/ramfs.h b/include/linux/ramfs.h
index 00b340b..b160fb1 100644
--- a/include/linux/ramfs.h
+++ b/include/linux/ramfs.h
@@ -17,5 +17,6 @@ #endif
 
 extern const struct file_operations ramfs_file_operations;
 extern struct vm_operations_struct generic_file_vm_ops;
+extern int __init init_rootfs(void);
 
 #endif
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 1ea5d3c..73d10f3 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -10,6 +10,7 @@
 #ifndef _SYSFS_H_
 #define _SYSFS_H_
 
+#include <linux/init.h>
 #include <asm/atomic.h>
 
 struct kobject;
@@ -86,6 +87,9 @@ #define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATT
 
 #ifdef CONFIG_SYSFS
 
+extern int __init
+sysfs_init(void);
+
 extern int
 sysfs_create_dir(struct kobject *);
 
@@ -122,6 +126,11 @@ void sysfs_notify(struct kobject * k, ch
 
 #else /* CONFIG_SYSFS */
 
+static inline int sysfs_init(void)
+{
+	return 0;
+}
+
 static inline int sysfs_create_dir(struct kobject * k)
 {
 	return 0;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 04827ca..a236c67 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -308,6 +308,9 @@ extern void tty_ldisc_put(int);
 extern void tty_wakeup(struct tty_struct *tty);
 extern void tty_ldisc_flush(struct tty_struct *tty);
 
+extern int tty_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		     unsigned long arg);
+
 extern struct mutex tty_mutex;
 
 /* n_tty.c */
