Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270972AbTGPSVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271031AbTGPSUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:20:00 -0400
Received: from www.13thfloor.at ([212.16.59.250]:46785 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S270972AbTGPSTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:19:18 -0400
Date: Wed, 16 Jul 2003 20:34:16 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [herbert@13thfloor.at: NFS root and Floppy Fallback ...]
Message-ID: <20030716183416.GA15019@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	lkml <linux-kernel@vger.kernel.org>
References: <20030716163615.GA11879@www.13thfloor.at> <Pine.LNX.4.55L.0307161359010.31785@freak.distro.conectiva> <20030716171622.GA14742@www.13thfloor.at> <Pine.LNX.4.55L.0307161432400.31785@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.55L.0307161432400.31785@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 16, 2003 at 02:33:11PM -0300, Marcelo Tosatti wrote:
> On Wed, 16 Jul 2003, Herbert Pötzl wrote:
> > On Wed, Jul 16, 2003 at 02:01:37PM -0300, Marcelo Tosatti wrote:
> > >
> > > Herbert,
> > > Does Trond know about this patch?
> >
> > yes, I sent him a mail describing the issues on
> > Thu, 3 Jul 2003 16:37:50 +0200, but did never
> > receive any reply ...
> >
> > > What he thinks about it?
> >
> > I don't know ... but the first part (the fix)
> > should be obvious anyway ...
> >
> > please advice how to proceed ...
> 
> Resend the patch to me AND trond, CC lkml.
> 
> OK?

here they are, rediffed for 2.4.22-pre6 ...

first patch fixes NFS root issue, second adds
the Disable Floppy Fallback config option ...

best,
Herbert


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="nfs_root_fix.diff"

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

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="floppy_fallback_new.diff"

diff -NurbP --minimal linux-2.4.22-pre6-fix/Documentation/Configure.help linux-2.4.22-pre6-fix-ffb/Documentation/Configure.help
--- linux-2.4.22-pre6-fix/Documentation/Configure.help	Sun Jul  6 22:54:52 2003
+++ linux-2.4.22-pre6-fix-ffb/Documentation/Configure.help	Wed Jul  9 23:00:08 2003
@@ -15983,6 +15983,18 @@
 
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
diff -NurbP --minimal linux-2.4.22-pre6-fix/fs/Config.in linux-2.4.22-pre6-fix-ffb/fs/Config.in
--- linux-2.4.22-pre6-fix/fs/Config.in	Sun Jul  6 22:55:05 2003
+++ linux-2.4.22-pre6-fix-ffb/fs/Config.in	Wed Jul  9 22:49:40 2003
@@ -108,6 +108,7 @@
    dep_mbool '  Provide NFSv3 client support' CONFIG_NFS_V3 $CONFIG_NFS_FS
    dep_mbool '  Allow direct I/O on NFS files (EXPERIMENTAL)' CONFIG_NFS_DIRECTIO $CONFIG_NFS_FS $CONFIG_EXPERIMENTAL
    dep_bool '  Root file system on NFS' CONFIG_ROOT_NFS $CONFIG_NFS_FS $CONFIG_IP_PNP
+   dep_bool '    Disable Floppy Fallback' CONFIG_NO_FLOPPY_FALLBACK $CONFIG_ROOT_NFS
 
    dep_tristate 'NFS server support' CONFIG_NFSD $CONFIG_INET
    dep_mbool '  Provide NFSv3 server support' CONFIG_NFSD_V3 $CONFIG_NFSD
diff -NurbP --minimal linux-2.4.22-pre6-fix/init/do_mounts.c linux-2.4.22-pre6-fix-ffb/init/do_mounts.c
--- linux-2.4.22-pre6-fix/init/do_mounts.c	Wed Jul  9 22:48:48 2003
+++ linux-2.4.22-pre6-fix-ffb/init/do_mounts.c	Wed Jul  9 22:49:40 2003
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

--OgqxwSJOaUobr8KG--
