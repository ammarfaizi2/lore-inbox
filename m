Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132705AbRDQPJJ>; Tue, 17 Apr 2001 11:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132702AbRDQPI5>; Tue, 17 Apr 2001 11:08:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28402 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132705AbRDQPIn>;
	Tue, 17 Apr 2001 11:08:43 -0400
Date: Tue, 17 Apr 2001 11:08:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][crapectomy] death of filesystem_setup()
Message-ID: <Pine.GSO.4.21.0104171103340.8919-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Patch below switches the last 3 filesystems that are initialized from
filesystem_setup() to module_init/module_exit. Result: filesystem_setup() is
no more.

	Linus, could you apply it?
								Al

diff -urN S4-pre3/fs/devfs/base.c S4-pre3-init/fs/devfs/base.c
--- S4-pre3/fs/devfs/base.c	Mon Feb 26 14:18:32 2001
+++ S4-pre3-init/fs/devfs/base.c	Tue Apr 17 09:03:51 2001
@@ -3339,7 +3339,7 @@
 }   /*  End Function devfsd_close  */
 
 
-int __init init_devfs_fs (void)
+static int __init init_devfs_fs (void)
 {
     int err;
 
@@ -3369,3 +3369,5 @@
     if (err == 0) printk ("Mounted devfs on /dev\n");
     else printk ("Warning: unable to mount devfs, err: %d\n", err);
 }   /*  End Function mount_devfs_fs  */
+
+module_init(init_devfs_fs)
diff -urN S4-pre3/fs/devpts/inode.c S4-pre3-init/fs/devpts/inode.c
--- S4-pre3/fs/devpts/inode.c	Mon Feb 26 14:18:32 2001
+++ S4-pre3-init/fs/devpts/inode.c	Tue Apr 17 09:10:52 2001
@@ -228,28 +228,25 @@
 		err = PTR_ERR(devpts_mnt);
 		if (!IS_ERR(devpts_mnt))
 			err = 0;
-	}
-	return err;
-}
-
 #ifdef MODULE
-
-int init_module(void)
-{
-	int err = init_devpts_fs();
-	if ( !err ) {
-		devpts_upcall_new  = devpts_pty_new;
-		devpts_upcall_kill = devpts_pty_kill;
+		if ( !err ) {
+			devpts_upcall_new  = devpts_pty_new;
+			devpts_upcall_kill = devpts_pty_kill;
+		}
+#endif
 	}
 	return err;
 }
 
-void cleanup_module(void)
+void __exit exit_devpts_fs(void)
 {
+#ifdef MODULE
 	devpts_upcall_new  = NULL;
 	devpts_upcall_kill = NULL;
+#endif
 	unregister_filesystem(&devpts_fs_type);
 	kern_umount(devpts_mnt);
 }
 
-#endif
+module_init(init_devpts_fs)
+module_exit(exit_devpts_fs)
diff -urN S4-pre3/fs/filesystems.c S4-pre3-init/fs/filesystems.c
--- S4-pre3/fs/filesystems.c	Mon Sep 25 19:05:01 2000
+++ S4-pre3-init/fs/filesystems.c	Tue Apr 17 09:53:31 2001
@@ -7,36 +7,10 @@
  */
 
 #include <linux/config.h>
-#include <linux/fs.h>
-
-#include <linux/devfs_fs_kernel.h>
-#include <linux/nfs_fs.h>
-#include <linux/auto_fs.h>
-#include <linux/devpts_fs.h>
-#include <linux/major.h>
-#include <linux/smp.h>
+#include <linux/sched.h>
 #include <linux/smp_lock.h>
 #include <linux/kmod.h>
-#include <linux/init.h>
-#include <linux/module.h>
 #include <linux/nfsd/interface.h>
-
-#ifdef CONFIG_DEVPTS_FS
-extern int init_devpts_fs(void);
-#endif
-
-void __init filesystem_setup(void)
-{
-	init_devfs_fs();  /*  Header file may make this empty  */
-
-#ifdef CONFIG_NFS_FS
-	init_nfs_fs();
-#endif
-
-#ifdef CONFIG_DEVPTS_FS
-	init_devpts_fs();
-#endif
-}
 
 #if defined(CONFIG_NFSD_MODULE)
 struct nfsd_linkage *nfsd_linkage = NULL;
diff -urN S4-pre3/fs/nfs/inode.c S4-pre3-init/fs/nfs/inode.c
--- S4-pre3/fs/nfs/inode.c	Mon Apr  2 16:51:04 2001
+++ S4-pre3-init/fs/nfs/inode.c	Tue Apr 17 09:49:20 2001
@@ -15,6 +15,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/init.h>
 
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -1060,8 +1061,7 @@
 /*
  * Initialize NFS
  */
-int
-init_nfs_fs(void)
+static int __init init_nfs_fs(void)
 {
 	int err;
 
@@ -1079,23 +1079,7 @@
         return register_filesystem(&nfs_fs_type);
 }
 
-/*
- * Every kernel module contains stuff like this.
- */
-#ifdef MODULE
-
-EXPORT_NO_SYMBOLS;
-/* Not quite true; I just maintain it */
-MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
-
-int
-init_module(void)
-{
-	return init_nfs_fs();
-}
-
-void
-cleanup_module(void)
+static void __exit exit_nfs_fs(void)
 {
 	nfs_destroy_readpagecache();
 	nfs_destroy_nfspagecache();
@@ -1104,4 +1088,10 @@
 #endif
 	unregister_filesystem(&nfs_fs_type);
 }
-#endif
+
+EXPORT_NO_SYMBOLS;
+/* Not quite true; I just maintain it */
+MODULE_AUTHOR("Olaf Kirch <okir@monad.swb.de>");
+
+module_init(init_nfs_fs)
+module_exit(exit_nfs_fs)
diff -urN S4-pre3/include/linux/devfs_fs_kernel.h S4-pre3-init/include/linux/devfs_fs_kernel.h
--- S4-pre3/include/linux/devfs_fs_kernel.h	Fri Mar 23 16:09:44 2001
+++ S4-pre3-init/include/linux/devfs_fs_kernel.h	Tue Apr 17 09:43:03 2001
@@ -96,7 +96,6 @@
 				   unsigned int minor_start,
 				   umode_t mode, void *ops, void *info);
 
-extern int init_devfs_fs (void);
 extern void mount_devfs_fs (void);
 extern void devfs_make_root (const char *name);
 #else  /*  CONFIG_DEVFS_FS  */
@@ -233,10 +232,6 @@
     return;
 }
 
-static inline int init_devfs_fs (void)
-{
-    return 0;
-}
 static inline void mount_devfs_fs (void)
 {
     return;
diff -urN S4-pre3/include/linux/nfs_fs.h S4-pre3-init/include/linux/nfs_fs.h
--- S4-pre3/include/linux/nfs_fs.h	Wed Mar 28 21:12:47 2001
+++ S4-pre3-init/include/linux/nfs_fs.h	Tue Apr 17 09:42:48 2001
@@ -137,7 +137,6 @@
  * linux/fs/nfs/inode.c
  */
 extern struct super_block *nfs_read_super(struct super_block *, void *, int);
-extern int init_nfs_fs(void);
 extern void nfs_zap_caches(struct inode *);
 extern int nfs_inode_is_stale(struct inode *, struct nfs_fh *,
 				struct nfs_fattr *);
diff -urN S4-pre3/init/main.c S4-pre3-init/init/main.c
--- S4-pre3/init/main.c	Mon Apr  2 16:51:07 2001
+++ S4-pre3-init/init/main.c	Tue Apr 17 09:05:57 2001
@@ -96,7 +96,6 @@
 extern void net_notifier_init(void);
 
 extern void free_initmem(void);
-extern void filesystem_setup(void);
 
 #ifdef CONFIG_TC
 extern void tc_init(void);
@@ -722,9 +721,6 @@
 
 	start_context_thread();
 	do_initcalls();
-
-	/* .. filesystems .. */
-	filesystem_setup();
 
 #ifdef CONFIG_IRDA
 	irda_device_init(); /* Must be done after protocol initialization */

