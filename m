Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270322AbUJTJ4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270322AbUJTJ4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270057AbUJTJu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 05:50:27 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:15289 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S270113AbUJTJr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 05:47:56 -0400
Date: Wed, 20 Oct 2004 02:47:47 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] change {get,put}_filesystem prototypes to static inlines
Message-ID: <20041020094747.GA2102@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al,

Any objections/comments to something like this?



Remove unneeded get_fs_type prototype.  Move get_filesystem and
put_filesystem to fs.h and make them static inline.

Signed-off-by: cw@f00f.org


 fs/filesystems.c   |   11 -----------
 fs/super.c         |    5 -----
 include/linux/fs.h |   12 ++++++++++++
 3 files changed, 12 insertions(+), 16 deletions(-)


===== fs/filesystems.c 1.19 vs edited =====
--- 1.19/fs/filesystems.c	2004-10-18 22:26:38 -07:00
+++ edited/fs/filesystems.c	2004-10-20 02:40:35 -07:00
@@ -30,17 +30,6 @@
 static struct file_system_type *file_systems;
 static rwlock_t file_systems_lock = RW_LOCK_UNLOCKED;
 
-/* WARNING: This can be used only if we _already_ own a reference */
-void get_filesystem(struct file_system_type *fs)
-{
-	__module_get(fs->owner);
-}
-
-void put_filesystem(struct file_system_type *fs)
-{
-	module_put(fs->owner);
-}
-
 static struct file_system_type **find_filesystem(const char *name)
 {
 	struct file_system_type **p;
===== fs/super.c 1.125 vs edited =====
--- 1.125/fs/super.c	2004-10-19 08:00:43 -07:00
+++ edited/fs/super.c	2004-10-20 02:40:32 -07:00
@@ -39,11 +39,6 @@
 #include <linux/kobject.h>
 #include <asm/uaccess.h>
 
-
-void get_filesystem(struct file_system_type *fs);
-void put_filesystem(struct file_system_type *fs);
-struct file_system_type *get_fs_type(const char *name);
-
 LIST_HEAD(super_blocks);
 spinlock_t sb_lock = SPIN_LOCK_UNLOCKED;
 
===== include/linux/fs.h 1.352 vs edited =====
x--- 1.352/include/linux/fs.h	2004-10-19 02:40:29 -07:00
+++ edited/include/linux/fs.h	2004-10-20 02:40:35 -07:00
@@ -7,6 +7,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/linkage.h>
 #include <linux/limits.h>
 #include <linux/wait.h>
@@ -1537,6 +1538,17 @@
 extern int vfs_stat(char __user *, struct kstat *);
 extern int vfs_lstat(char __user *, struct kstat *);
 extern int vfs_fstat(unsigned int, struct kstat *);
+
+/* WARNING: This can be used only if we _already_ own a reference */
+static inline void get_filesystem(struct file_system_type *fs)
+{
+	__module_get(fs->owner);
+}
+
+static inline void put_filesystem(struct file_system_type *fs)
+{
+	module_put(fs->owner);
+}
 
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(struct block_device *);
