Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287425AbSBXMii>; Sun, 24 Feb 2002 07:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSBXMi3>; Sun, 24 Feb 2002 07:38:29 -0500
Received: from gate.perex.cz ([194.212.165.105]:35344 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S287337AbSBXMiO>;
	Sun, 24 Feb 2002 07:38:14 -0500
Date: Sun, 24 Feb 2002 13:36:19 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: LKML <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: KMOD error messages - proposal and patch
Message-ID: <Pine.LNX.4.31.0202241325270.510-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	there are very bad-looking messages during the boot process for
ALSA and other code using request_module() when a real root filesystem is
not mounted:

kmod: failed to exec /sbin/modprobe -s -k snd-card-0, errno = 2

	I propose to add a new function can_request_module() allowing a
check, if request_module() function is useable. Implementation follows.

						Jaroslav

# This is a BitKeeper generated patch for the following project:
# Project Name: Perex's Linux 2.5 Tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.4     -> 1.5
#	       kernel/kmod.c	1.2     -> 1.4
#	include/linux/kmod.h	1.1     -> 1.2
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/24	perex@perex.cz	1.5
# kmod.c:
#   Exported function can_request_module()
# kmod.c, kmod.h:
#   Added can_request_module() function.
# --------------------------------------------
#
diff -Nru a/include/linux/kmod.h b/include/linux/kmod.h
--- a/include/linux/kmod.h	Sun Feb 24 13:20:44 2002
+++ b/include/linux/kmod.h	Sun Feb 24 13:20:44 2002
@@ -23,8 +23,10 @@
 #include <linux/errno.h>

 #ifdef CONFIG_KMOD
+extern int can_request_module(void);
 extern int request_module(const char * name);
 #else
+static inline int can_request_module(void) { return 0; }
 static inline int request_module(const char * name) { return -ENOSYS; }
 #endif

diff -Nru a/kernel/kmod.c b/kernel/kmod.c
--- a/kernel/kmod.c	Sun Feb 24 13:20:44 2002
+++ b/kernel/kmod.c	Sun Feb 24 13:20:44 2002
@@ -167,6 +167,27 @@
 }

 /**
+ * can_request_module - test if request_module() function can be used
+ *
+ * If no root filesystem is mounted, request_module() will fail.
+ * This test ensures, that everything is prepared to load on demand
+ * kernel modules.
+ */
+int can_request_module(void)
+{
+	/* Don't allow request_module() before the root fs is mounted! */
+	if ( ! current->fs->root )
+		return 0;
+
+	/* Don't allow request_module() when ramfs based rootfs is mounted! */
+	if ( ! strcmp("rootfs", current->fs->pwdmnt->mnt_sb->s_type->name) )
+		return 0;
+
+	/* Everything is ok */
+	return 1;
+}
+
+/**
  * request_module - try to load a kernel module
  * @module_name: Name of module
  *
@@ -189,13 +210,20 @@
 #define MAX_KMOD_CONCURRENT 50	/* Completely arbitrary value - KAO */
 	static int kmod_loop_msg;

-	/* Don't allow request_module() before the root fs is mounted!  */
+	/* Don't allow request_module() before the root fs is mounted! */
 	if ( ! current->fs->root ) {
 		printk(KERN_ERR "request_module[%s]: Root fs not mounted\n",
 			module_name);
 		return -EPERM;
 	}

+	/* Don't allow request_module() when ramfs based rootfs is mounted! */
+	if ( ! strcmp("rootfs", current->fs->pwdmnt->mnt_sb->s_type->name) ) {
+		printk(KERN_ERR "request_module[%s]: Real root fs not mounted\n",
+			module_name);
+		return -EPERM;
+	}
+
 	/* If modprobe needs a service that is in a module, we get a recursive
 	 * loop.  Limit the number of running kmod threads to max_threads/2 or
 	 * MAX_KMOD_CONCURRENT, whichever is the smaller.  A cleaner method
@@ -377,6 +405,7 @@
 EXPORT_SYMBOL(call_usermodehelper);

 #ifdef CONFIG_KMOD
+EXPORT_SYMBOL(can_request_module);
 EXPORT_SYMBOL(request_module);
 #endif


-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

