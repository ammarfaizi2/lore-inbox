Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSGSQwv>; Fri, 19 Jul 2002 12:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSGSQwv>; Fri, 19 Jul 2002 12:52:51 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:45578 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S316897AbSGSQwt>; Fri, 19 Jul 2002 12:52:49 -0400
Date: Fri, 19 Jul 2002 18:55:51 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2/3] fix indirect dependencies on sched.h
In-Reply-To: <Pine.LNX.4.33.0207191825120.23556-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33.0207191842370.23556-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to be quite common to assume that sched.h and all the other
headers it drags in are available without declaration anyways.
Since I aim at invalidating this assumption by removing all unneccessary 
includes, I have started to make dependencies on header files included
by sched.h explicit.                                                            

This, however, turned out to be a larger task than I am able to handle.
So this time I tried a minimal approach and restricted myself to files 
where sched.h was #included before, but isn't necessarily after applying 
the previous patch 1/3.
This should just be enough to make the kernel compile again, except for
one case that my scripts are unable to detect and that is fixed separately 
by part 3/3.


diff -urP --exclude-from dontdiff linux-2.5.26-sr0/drivers/base/base.h linux-2.5.26-sr1/drivers/base/base.h
--- linux-2.5.26-sr0/drivers/base/base.h	Wed Jul 17 01:49:31 2002
+++ linux-2.5.26-sr1/drivers/base/base.h	Fri Jul 19 17:04:06 2002
@@ -1,6 +1,7 @@
 #undef DEBUG
 
 #ifdef DEBUG
+# include <linux/kernel.h>
 # define DBG(x...) printk(x)
 #else
 # define DBG(x...)
diff -urP --exclude-from dontdiff linux-2.5.26-sr0/drivers/base/interface.c linux-2.5.26-sr1/drivers/base/interface.c
--- linux-2.5.26-sr0/drivers/base/interface.c	Wed Jul 17 01:49:25 2002
+++ linux-2.5.26-sr1/drivers/base/interface.c	Fri Jul 19 17:05:54 2002
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/stat.h>
+#include <linux/string.h>
 
 static ssize_t device_read_name(struct device * dev, char * buf, size_t count, loff_t off)
 {
diff -urP --exclude-from dontdiff linux-2.5.26-sr0/drivers/block/paride/paride.c linux-2.5.26-sr1/drivers/block/paride/paride.c
--- linux-2.5.26-sr0/drivers/block/paride/paride.c	Wed Jul 17 01:49:26 2002
+++ linux-2.5.26-sr1/drivers/block/paride/paride.c	Fri Jul 19 17:08:22 2002
@@ -26,6 +26,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
+#include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
diff -urP --exclude-from dontdiff linux-2.5.26-sr0/fs/nfsd/nfscache.c linux-2.5.26-sr1/fs/nfsd/nfscache.c
--- linux-2.5.26-sr0/fs/nfsd/nfscache.c	Wed Jul 17 01:49:38 2002
+++ linux-2.5.26-sr1/fs/nfsd/nfscache.c	Fri Jul 19 17:10:23 2002
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/jiffies.h>
 #include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/string.h>
diff -urP --exclude-from dontdiff linux-2.5.26-sr0/include/linux/brlock.h linux-2.5.26-sr1/include/linux/brlock.h
--- linux-2.5.26-sr0/include/linux/brlock.h	Wed Jul 17 01:49:31 2002
+++ linux-2.5.26-sr1/include/linux/brlock.h	Fri Jul 19 17:12:37 2002
@@ -46,6 +46,7 @@
 
 #include <linux/cache.h>
 #include <linux/spinlock.h>
+#include <linux/smp.h>
 
 #if defined(__i386__) || defined(__ia64__) || defined(__x86_64__)
 #define __BRLOCK_USE_ATOMICS
diff -urP --exclude-from dontdiff linux-2.5.26-sr0/include/linux/efs_fs_i.h linux-2.5.26-sr1/include/linux/efs_fs_i.h
--- linux-2.5.26-sr0/include/linux/efs_fs_i.h	Wed Jul 17 01:49:31 2002
+++ linux-2.5.26-sr1/include/linux/efs_fs_i.h	Fri Jul 19 17:14:31 2002
@@ -9,6 +9,8 @@
 #ifndef	__EFS_FS_I_H__
 #define	__EFS_FS_I_H__
 
+#include <linux/types.h>
+
 typedef	int32_t		efs_block_t;
 typedef uint32_t	efs_ino_t;
 
diff -urP --exclude-from dontdiff linux-2.5.26-sr0/include/linux/ext2_fs.h linux-2.5.26-sr1/include/linux/ext2_fs.h
--- linux-2.5.26-sr0/include/linux/ext2_fs.h	Wed Jul 17 01:49:26 2002
+++ linux-2.5.26-sr1/include/linux/ext2_fs.h	Fri Jul 19 17:15:31 2002
@@ -16,8 +16,10 @@
 #ifndef _LINUX_EXT2_FS_H
 #define _LINUX_EXT2_FS_H
 
+#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/ext2_fs_sb.h>
+#include <asm/spinlock.h>
 
 /*
  * The second extended filesystem constants/structures
diff -urP --exclude-from dontdiff linux-2.5.26-sr0/include/linux/ext2_fs_sb.h linux-2.5.26-sr1/include/linux/ext2_fs_sb.h
--- linux-2.5.26-sr0/include/linux/ext2_fs_sb.h	Wed Jul 17 01:49:37 2002
+++ linux-2.5.26-sr1/include/linux/ext2_fs_sb.h	Fri Jul 19 17:18:03 2002
@@ -16,6 +16,8 @@
 #ifndef _LINUX_EXT2_FS_SB
 #define _LINUX_EXT2_FS_SB
 
+#include <linux/types.h>
+
 /*
  * second extended-fs super-block data in memory
  */
diff -urP --exclude-from dontdiff linux-2.5.26-sr0/include/linux/namei.h linux-2.5.26-sr1/include/linux/namei.h
--- linux-2.5.26-sr0/include/linux/namei.h	Wed Jul 17 01:49:30 2002
+++ linux-2.5.26-sr1/include/linux/namei.h	Fri Jul 19 17:21:41 2002
@@ -2,6 +2,8 @@
 #define _LINUX_NAMEI_H
 
 #include <linux/linkage.h>
+#include <linux/dcache.h>
+#include <linux/mount.h>
 
 struct vfsmount;
 
diff -urP --exclude-from dontdiff linux-2.5.26-sr0/include/linux/selection.h linux-2.5.26-sr1/include/linux/selection.h
--- linux-2.5.26-sr0/include/linux/selection.h	Wed Jul 17 01:49:35 2002
+++ linux-2.5.26-sr1/include/linux/selection.h	Fri Jul 19 17:22:29 2002
@@ -8,6 +8,7 @@
 #define _LINUX_SELECTION_H_
 
 #include <linux/vt_buffer.h>
+#include <asm/types.h>
 
 extern int sel_cons;
 
diff -urP --exclude-from dontdiff linux-2.5.26-sr0/include/linux/serio.h linux-2.5.26-sr1/include/linux/serio.h
--- linux-2.5.26-sr0/include/linux/serio.h	Wed Jul 17 01:49:35 2002
+++ linux-2.5.26-sr1/include/linux/serio.h	Fri Jul 19 17:23:32 2002
@@ -32,6 +32,7 @@
  */
 
 #include <linux/ioctl.h>
+#include <linux/sched.h>
 #define SPIOCSTYPE	_IOW('q', 0x01, unsigned long)
 
 struct serio;
diff -urP --exclude-from dontdiff linux-2.5.26-sr0/include/linux/vt_buffer.h linux-2.5.26-sr1/include/linux/vt_buffer.h
--- linux-2.5.26-sr0/include/linux/vt_buffer.h	Wed Jul 17 01:49:36 2002
+++ linux-2.5.26-sr1/include/linux/vt_buffer.h	Fri Jul 19 17:25:52 2002
@@ -14,6 +14,8 @@
 #define _LINUX_VT_BUFFER_H_
 
 #include <linux/config.h>
+#include <linux/string.h>
+#include <asm/types.h>
 
 #if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_MDA_CONSOLE)
 #include <asm/vga.h>
diff -urP --exclude-from dontdiff linux-2.5.26-sr1/include/linux/sunrpc/svcauth.h linux-2.5.26-sr2/include/linux/sunrpc/svcauth.h
--- linux-2.5.26-sr1/include/linux/sunrpc/svcauth.h	Wed Jul 17 01:49:31 2002
+++ linux-2.5.26-sr2/include/linux/sunrpc/svcauth.h	Fri Jul 19 18:02:46 2002
@@ -11,6 +11,8 @@
 
 #ifdef __KERNEL__
 
+#include <linux/types.h>
+#include <asm/param.h>
 #include <linux/sunrpc/msg_prot.h>
 
 struct svc_cred {
diff -urP --exclude-from dontdiff linux-2.5.26-sr1/include/linux/sunrpc/types.h linux-2.5.26-sr2/include/linux/sunrpc/types.h
--- linux-2.5.26-sr1/include/linux/sunrpc/types.h	Fri Jul 19 18:04:13 2002
+++ linux-2.5.26-sr2/include/linux/sunrpc/types.h	Fri Jul 19 18:04:28 2002
@@ -13,6 +13,7 @@
 #include <linux/tqueue.h>
 #include <linux/sunrpc/debug.h>
 #include <linux/list.h>
+#include <linux/sched.h>
 
 /*
  * Shorthands
diff -urP --exclude-from dontdiff linux-2.5.26-sr1/include/linux/sunrpc/xprt.h linux-2.5.26-sr2/include/linux/sunrpc/xprt.h
--- linux-2.5.26-sr1/include/linux/sunrpc/xprt.h	Wed Jul 17 01:49:36 2002
+++ linux-2.5.26-sr2/include/linux/sunrpc/xprt.h	Fri Jul 19 18:04:49 2002
@@ -14,6 +14,7 @@
 #include <linux/in.h>
 #include <linux/sunrpc/sched.h>
 #include <linux/sunrpc/xdr.h>
+#include <asm/param.h>
 
 /*
  * The transport code maintains an estimate on the maximum number of out-

