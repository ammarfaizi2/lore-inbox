Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263175AbUKTXLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263175AbUKTXLc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbUKTXLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:11:31 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:5771 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S263175AbUKTXJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:09:06 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/13] Filesystem in Userspace
Message-Id: <E1CVeLj-0007Oe-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 00:08:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an empty /sys/fs, which filesystems can use.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
diff -ru linux-2.6.10-rc2.orig/fs/filesystems.c linux-2.6.10-rc2/fs/filesystems.c
--- linux-2.6.10-rc2.orig/fs/filesystems.c	2004-11-17 17:33:26.000000000 +0100
+++ linux-2.6.10-rc2/fs/filesystems.c	2004-11-18 14:34:07.000000000 +0100
@@ -29,6 +29,7 @@
 
 static struct file_system_type *file_systems;
 static rwlock_t file_systems_lock = RW_LOCK_UNLOCKED;
+static decl_subsys(fs, NULL, NULL);
 
 /* WARNING: This can be used only if we _already_ own a reference */
 void get_filesystem(struct file_system_type *fs)
@@ -234,3 +235,17 @@
 }
 
 EXPORT_SYMBOL(get_fs_type);
+
+int fs_subsys_register(struct subsystem *sub)
+{
+	kset_set_kset_s(sub, fs_subsys);
+	return subsystem_register(sub);
+}
+
+EXPORT_SYMBOL(fs_subsys_register);
+
+int __init fs_subsys_init(void)
+{
+	/* register fs_subsys */
+	return subsystem_register(&fs_subsys);
+}
diff -ru linux-2.6.10-rc2.orig/fs/namespace.c linux-2.6.10-rc2/fs/namespace.c
--- linux-2.6.10-rc2.orig/fs/namespace.c	2004-11-17 17:33:28.000000000 +0100
+++ linux-2.6.10-rc2/fs/namespace.c	2004-11-18 14:39:21.000000000 +0100
@@ -26,6 +26,7 @@
 #include <asm/unistd.h>
 
 extern int __init init_rootfs(void);
+extern int __init fs_subsys_init(void);
 
 #ifdef CONFIG_SYSFS
 extern int __init sysfs_init(void);
@@ -1436,6 +1437,7 @@
 		i--;
 	} while (i);
 	sysfs_init();
+	fs_subsys_init();
 	init_rootfs();
 	init_mount_tree();
 }
diff -ru linux-2.6.10-rc2.orig/include/linux/fs.h linux-2.6.10-rc2/include/linux/fs.h
--- linux-2.6.10-rc2.orig/include/linux/fs.h	2004-11-17 17:33:46.000000000 +0100
+++ linux-2.6.10-rc2/include/linux/fs.h	2004-11-18 14:19:19.000000000 +0100
@@ -1185,6 +1185,9 @@
 
 extern int vfs_statfs(struct super_block *, struct kstatfs *);
 
+/* Register filesystem specific subsystem under /sys/fs */
+extern int fs_subsys_register(struct subsystem *sub);
+
 /* Return value for VFS lock functions - tells locks.c to lock conventionally
  * REALLY kosha for root NFS and nfs_lock
  */ 
