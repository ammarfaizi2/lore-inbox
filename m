Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135535AbREHV7c>; Tue, 8 May 2001 17:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135548AbREHV7X>; Tue, 8 May 2001 17:59:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60112 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135535AbREHV7O>;
	Tue, 8 May 2001 17:59:14 -0400
Date: Tue, 8 May 2001 17:59:11 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc_root_init() made saner
Message-ID: <Pine.GSO.4.21.0105081740440.5956-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Changes:
* proc_root_init() is called later in the boot sequence, after all essential
  VFS stuff had been initialized. That way we can have proc_mnt (along
  with superblock, root of dentry tree, etc.) set before we start registering
  any entries. As the result, now we are able to use all normal VFS machinery
  in create_proc_entry() and friends.  What's more important, we can use it
  when we do sysctl_init(). That will allow to remove a lot of cruft from
  sysctl handling.
* procfs_syms.c is gone (merged with root.c).

	This change is backwards compatible, BTW - nothing done that early
(between the old and new locations of proc_root_init() call) tries to create
proc entries, so we don't break anything by postponing the call.

	Please, apply it. It makes life much simpler for all procfs and sysctl
stuff - we _will_ need something equivalent if we ever want to get rid of
proc_dir_entry mess.
								Al

diff -urN S5-pre1/fs/proc/Makefile S5-pre1-proc_init/fs/proc/Makefile
--- S5-pre1/fs/proc/Makefile	Fri Feb 16 21:06:31 2001
+++ S5-pre1-proc_init/fs/proc/Makefile	Tue May  8 17:36:57 2001
@@ -9,10 +9,10 @@
 
 O_TARGET := proc.o
 
-export-objs := procfs_syms.o
+export-objs := root.o
 
 obj-y    := inode.o root.o base.o generic.o array.o \
-		kmsg.o proc_tty.o proc_misc.o kcore.o procfs_syms.o
+		kmsg.o proc_tty.o proc_misc.o kcore.o
 
 ifeq ($(CONFIG_PROC_DEVICETREE),y)
 obj-y += proc_devtree.o
diff -urN S5-pre1/fs/proc/procfs_syms.c S5-pre1-proc_init/fs/proc/procfs_syms.c
--- S5-pre1/fs/proc/procfs_syms.c	Tue May  8 17:55:17 2001
+++ S5-pre1-proc_init/fs/proc/procfs_syms.c	Wed Dec 31 19:00:00 1969
@@ -1,46 +0,0 @@
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/proc_fs.h>
-#include <linux/init.h>
-
-extern struct proc_dir_entry *proc_sys_root;
-
-#ifdef CONFIG_SYSCTL
-EXPORT_SYMBOL(proc_sys_root);
-#endif
-EXPORT_SYMBOL(proc_symlink);
-EXPORT_SYMBOL(proc_mknod);
-EXPORT_SYMBOL(proc_mkdir);
-EXPORT_SYMBOL(create_proc_entry);
-EXPORT_SYMBOL(remove_proc_entry);
-EXPORT_SYMBOL(proc_root);
-EXPORT_SYMBOL(proc_root_fs);
-EXPORT_SYMBOL(proc_net);
-EXPORT_SYMBOL(proc_bus);
-EXPORT_SYMBOL(proc_root_driver);
-
-static DECLARE_FSTYPE(proc_fs_type, "proc", proc_read_super, FS_SINGLE);
-
-static int __init init_proc_fs(void)
-{
-	int err = register_filesystem(&proc_fs_type);
-	if (!err) {
-		proc_mnt = kern_mount(&proc_fs_type);
-		err = PTR_ERR(proc_mnt);
-		if (IS_ERR(proc_mnt))
-			unregister_filesystem(&proc_fs_type);
-		else
-			err = 0;
-	}
-	return err;
-}
-
-static void __exit exit_proc_fs(void)
-{
-	unregister_filesystem(&proc_fs_type);
-	kern_umount(proc_mnt);
-}
-
-module_init(init_proc_fs)
-module_exit(exit_proc_fs)
diff -urN S5-pre1/fs/proc/root.c S5-pre1-proc_init/fs/proc/root.c
--- S5-pre1/fs/proc/root.c	Fri Feb 16 20:25:45 2001
+++ S5-pre1-proc_init/fs/proc/root.c	Tue May  8 17:37:44 2001
@@ -14,6 +14,7 @@
 #include <linux/stat.h>
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <asm/bitops.h>
 
 struct proc_dir_entry *proc_net, *proc_bus, *proc_root_fs, *proc_root_driver;
@@ -22,8 +23,19 @@
 struct proc_dir_entry *proc_sys_root;
 #endif
 
+static DECLARE_FSTYPE(proc_fs_type, "proc", proc_read_super, FS_SINGLE);
+
 void __init proc_root_init(void)
 {
+	int err = register_filesystem(&proc_fs_type);
+	if (err)
+		return;
+	proc_mnt = kern_mount(&proc_fs_type);
+	err = PTR_ERR(proc_mnt);
+	if (IS_ERR(proc_mnt)) {
+		unregister_filesystem(&proc_fs_type);
+		return;
+	}
 	proc_misc_init();
 	proc_net = proc_mkdir("net", 0);
 #ifdef CONFIG_SYSVIPC
@@ -106,3 +118,17 @@
 	proc_fops:	&proc_root_operations,
 	parent:		&proc_root,
 };
+
+#ifdef CONFIG_SYSCTL
+EXPORT_SYMBOL(proc_sys_root);
+#endif
+EXPORT_SYMBOL(proc_symlink);
+EXPORT_SYMBOL(proc_mknod);
+EXPORT_SYMBOL(proc_mkdir);
+EXPORT_SYMBOL(create_proc_entry);
+EXPORT_SYMBOL(remove_proc_entry);
+EXPORT_SYMBOL(proc_root);
+EXPORT_SYMBOL(proc_root_fs);
+EXPORT_SYMBOL(proc_net);
+EXPORT_SYMBOL(proc_bus);
+EXPORT_SYMBOL(proc_root_driver);
diff -urN S5-pre1/init/main.c S5-pre1-proc_init/init/main.c
--- S5-pre1/init/main.c	Wed May  2 11:16:38 2001
+++ S5-pre1-proc_init/init/main.c	Tue May  8 17:19:42 2001
@@ -561,9 +561,6 @@
 #endif
 	mem_init();
 	kmem_cache_sizes_init();
-#ifdef CONFIG_PROC_FS
-	proc_root_init();
-#endif
 	mempages = num_physpages;
 
 	fork_init(mempages);
@@ -577,6 +574,9 @@
 	signals_init();
 	bdev_init();
 	inode_init(mempages);
+#ifdef CONFIG_PROC_FS
+	proc_root_init();
+#endif
 #if defined(CONFIG_SYSVIPC)
 	ipc_init();
 #endif

