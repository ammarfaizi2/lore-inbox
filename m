Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268626AbTGIWMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268618AbTGIWMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:12:49 -0400
Received: from www.13thfloor.at ([212.16.59.250]:14233 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S268615AbTGIWLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:11:55 -0400
Date: Thu, 10 Jul 2003 00:26:39 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: NFS root and Floppy Fallback ...
Message-ID: <20030709222639.GB3312@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo!

Here is my fix for the NFS root issue and optional 
floppy fallback ...

the (short) story: root_dev_setup() calls name_to_kdev_t()
which searches root_dev_names[], and if no device can be
found, (0:0) is returned, which in turn, if NFS root is
enabled, leads to a doomed NFS root attempt, finally 
leading to some ancient floppy fallback ...

the first patch 'corrects' the behaviour, in such way, 
that only root=/dev/nfs or a root device of (0:255) will
lead to the NFS root attempt (I guess this was the
original intention of the author).

the second patch adds a config option to disable the
Floppy Fallback entirely, which is disabled by default
(so no changes to the default behaviour).

best,
Herbert


-----

diff -NurbP --minimal linux-2.4.22-pre3/include/linux/nfs.h linux-2.4.22-pre3-fix/include/linux/nfs.h
--- linux-2.4.22-pre3/include/linux/nfs.h	Sat Apr  1 18:04:27 2000
+++ linux-2.4.22-pre3-fix/include/linux/nfs.h	Wed Jul  9 22:39:37 2003
@@ -30,6 +30,9 @@
 #define NFS_MNT_PROGRAM	100005
 #define NFS_MNT_PORT	627
 
+#define NFS_MAJOR   	UNNAMED_MAJOR
+#define NFS_MINOR   	0xff
+
 /*
  * NFS stats. The good thing with these values is that NFSv3 errors are
  * a superset of NFSv2 errors (with the exception of NFSERR_WFLUSH which
diff -NurbP --minimal linux-2.4.22-pre3/init/do_mounts.c linux-2.4.22-pre3-fix/init/do_mounts.c
--- linux-2.4.22-pre3/init/do_mounts.c	Sun Jul  6 22:55:07 2003
+++ linux-2.4.22-pre3-fix/init/do_mounts.c	Wed Jul  9 22:41:43 2003
@@ -88,7 +88,7 @@
 	const char *name;
 	const int num;
 } root_dev_names[] __initdata = {
-	{ "nfs",     0x00ff },
+	{ "nfs",     MKDEV(NFS_MAJOR, NFS_MINOR) },
 	{ "hda",     0x0300 },
 	{ "hdb",     0x0340 },
 	{ "loop",    0x0700 },
@@ -759,7 +759,8 @@
 static void __init mount_root(void)
 {
 #ifdef CONFIG_ROOT_NFS
-	if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR) {
+       if (MAJOR(ROOT_DEV) == NFS_MAJOR
+           && MINOR(ROOT_DEV) == NFS_MINOR) {
 		if (mount_nfs_root()) {
 			sys_chdir("/root");
 			ROOT_DEV = current->fs->pwdmnt->mnt_sb->s_dev;


-----

diff -NurbP --minimal linux-2.4.22-pre3-fix/Documentation/Configure.help linux-2.4.22-pre3-fix-ffb/Documentation/Configure.help
--- linux-2.4.22-pre3-fix/Documentation/Configure.help	Sun Jul  6 22:54:52 2003
+++ linux-2.4.22-pre3-fix-ffb/Documentation/Configure.help	Wed Jul  9 23:00:08 2003
@@ -15942,6 +15942,18 @@
 
   Most people say N here.
 
+Disable Fallback to Floppy
+CONFIG_NO_FLOPPY_FALLBACK
+  If root file system on NFS is enabled but the root device isn't
+  /dev/nfs (or the NFS root can not be mounted for any other reason)
+  the kernel usually falls back to a floppy boot.
+  
+  This option will disable the default behaviour, which could be a
+  security risk, allowing either to boot from a specified root device 
+  or not at all. 
+
+  If unsure say N here.
+
 NFS server support
 CONFIG_NFSD
   If you want your Linux box to act as an NFS *server*, so that other
diff -NurbP --minimal linux-2.4.22-pre3-fix/fs/Config.in linux-2.4.22-pre3-fix-ffb/fs/Config.in
--- linux-2.4.22-pre3-fix/fs/Config.in	Sun Jul  6 22:55:05 2003
+++ linux-2.4.22-pre3-fix-ffb/fs/Config.in	Wed Jul  9 22:49:40 2003
@@ -105,6 +105,7 @@
    dep_tristate 'NFS file system support' CONFIG_NFS_FS $CONFIG_INET
    dep_mbool '  Provide NFSv3 client support' CONFIG_NFS_V3 $CONFIG_NFS_FS
    dep_bool '  Root file system on NFS' CONFIG_ROOT_NFS $CONFIG_NFS_FS $CONFIG_IP_PNP
+   dep_bool '    Disable Floppy Fallback' CONFIG_NO_FLOPPY_FALLBACK $CONFIG_ROOT_NFS
 
    dep_tristate 'NFS server support' CONFIG_NFSD $CONFIG_INET
    dep_mbool '  Provide NFSv3 server support' CONFIG_NFSD_V3 $CONFIG_NFSD
diff -NurbP --minimal linux-2.4.22-pre3-fix/init/do_mounts.c linux-2.4.22-pre3-fix-ffb/init/do_mounts.c
--- linux-2.4.22-pre3-fix/init/do_mounts.c	Wed Jul  9 22:48:48 2003
+++ linux-2.4.22-pre3-fix-ffb/init/do_mounts.c	Wed Jul  9 22:49:40 2003
@@ -767,8 +767,10 @@
 			printk("VFS: Mounted root (nfs filesystem).\n");
 			return;
 		}
+# ifndef CONFIG_NO_FLOPPY_FALLBACK
 		printk(KERN_ERR "VFS: Unable to mount root fs via NFS, trying floppy.\n");
 		ROOT_DEV = MKDEV(FLOPPY_MAJOR, 0);
+# endif
 	}
 #endif
 	devfs_make_root(root_device_name);



