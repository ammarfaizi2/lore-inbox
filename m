Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265819AbTFSPtZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265820AbTFSPtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:49:25 -0400
Received: from www.13thfloor.at ([212.16.59.250]:40665 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S265819AbTFSPtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:49:11 -0400
Date: Thu, 19 Jun 2003 18:03:14 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.4.21 Floppy Fallback with NFS root ...
Message-ID: <20030619160314.GA27584@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
References: <20030616141832.GG23590@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030616141832.GG23590@www.13thfloor.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on a deeper look at this issue, another astounding
(read confusing, erroneous) detail was revealed ...

consider a kernel boot cmdline like

  "root=/dev/vg/slash ro"

which could be used to boot from a LVM LV named slash
or, if you prefer a physical device (using devfs)

  "root=/dev/ide//host0/bus0/target0/lun0/part1 ro"


now what happens on boot is:

root_dev_setup() is called with "root=" and, in turn
calls name_to_kdev_t() which searches root_dev_names[]
for the given device names, which of course, can not
be found, because they are not listed, so ROOT_DEV
becomes (0:0)
 
if you have CONFIG_ROOT_NFS enabled, then mount_root()
will check if MAJOR(ROOT_DEV) == UNNAMED_MAJOR, which
will be true, although root=/dev/nfs (0:ff) wasn't 
specified, leading directly to "Unable to mount root 
fs via NFS, trying floppy." and the Floppy Fallback, 
instead of booting from your specified root device.

  "root=/dev/hda1 ro"

will work as expected, because it will be found in
root_dev_names[] ...


I suggest to do one fix, and one improvement ...

and of course this _will_ break the current behaviour
you won't be able to use root=tux (or your favorite
pet name) to have root on nfs ...

what do you think?

best,
Herbert


------------------ FIX

diff -NurbP --minimal linux-2.4.21/init/do_mounts.c linux-2.4.21-ffb/init/do_mounts.c
--- linux-2.4.21/init/do_mounts.c	Fri Jun 13 17:49:28 2003
+++ linux-2.4.21-ffb/init/do_mounts.c	Thu Jun 19 17:41:35 2003
@@ -747,7 +747,8 @@
 static void __init mount_root(void)
 {
 #ifdef CONFIG_ROOT_NFS
-	if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR) {
+	if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR
+	    && MINOR(ROOT_DEV) == 255) {
 		if (mount_nfs_root()) {
 			sys_chdir("/root");
 			ROOT_DEV = current->fs->pwdmnt->mnt_sb->s_dev;


maybe a NFS_MAJOR, NFS_MINOR would be more descriptive here ...


------------------ SECURITY IMPROVEMENT ;)

diff -NurbP --minimal linux-2.4.21/fs/Config.in linux-2.4.21-ffb/fs/Config.in
--- linux-2.4.21/fs/Config.in	Tue Dec 10 03:25:19 2002
+++ linux-2.4.21-ffb/fs/Config.in	Thu Jun 19 17:42:35 2003
@@ -103,6 +103,7 @@
    dep_tristate 'NFS file system support' CONFIG_NFS_FS $CONFIG_INET
    dep_mbool '  Provide NFSv3 client support' CONFIG_NFS_V3 $CONFIG_NFS_FS
    dep_bool '  Root file system on NFS' CONFIG_ROOT_NFS $CONFIG_NFS_FS $CONFIG_IP_PNP
+   dep_bool '    Disable Floppy Fallback' CONFIG_NO_FLOPPY_FALLBACK $CONFIG_ROOT_NFS
 
    dep_tristate 'NFS server support' CONFIG_NFSD $CONFIG_INET
    dep_mbool '  Provide NFSv3 server support' CONFIG_NFSD_V3 $CONFIG_NFSD
diff -NurbP --minimal linux-2.4.21/init/do_mounts.c linux-2.4.21-ffb/init/do_mounts.c
--- linux-2.4.21/init/do_mounts.c	Fri Jun 13 17:49:28 2003
+++ linux-2.4.21-ffb/init/do_mounts.c	Thu Jun 19 17:41:35 2003
@@ -754,8 +754,10 @@
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



