Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271201AbTG1XVf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271202AbTG1XVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:21:35 -0400
Received: from www.13thfloor.at ([212.16.59.250]:20128 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S271201AbTG1XV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:21:29 -0400
Date: Tue, 29 Jul 2003 01:21:36 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [herbert@13thfloor.at: ROOT NFS fixes now for -pre9]
Message-ID: <20030728232136.GA31332@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a reminder, because I got no reply whatsoever ...

------------------------------------------------------------
I'm sure you're a busy man, but please have a look at 
the attached patch, which addresses the root=/dev/wossname 
issue, when ROOT_NFS is configured. IMHO this is a NFS only 
issue, and fixes an erroneous behaviour.

if it seems okay to you, please let Marcelo know,
so he could add this patch to the next -pre kernel

MTIA,
Herbert

PS: I hope this will make it into 2.4.22-pre9 ...


diff -NurbP --minimal linux-2.4.22-pre7/fs/nfs/nfsroot.c linux-2.4.22-pre7-fix/fs/nfs/nfsroot.c
--- linux-2.4.22-pre7/fs/nfs/nfsroot.c	2003-06-13 16:51:37.000000000 +0200
+++ linux-2.4.22-pre7-fix/fs/nfs/nfsroot.c	2003-07-21 22:15:12.000000000 +0200
@@ -305,7 +305,7 @@
  */
 int __init nfs_root_setup(char *line)
 {
-	ROOT_DEV = MKDEV(UNNAMED_MAJOR, 255);
+	ROOT_DEV = MKDEV(NFS_MAJOR, NFS_MINOR);
 	if (line[0] == '/' || line[0] == ',' || (line[0] >= '0' && line[0] <= '9')) {
 		strncpy(nfs_root_name, line, sizeof(nfs_root_name));
 		nfs_root_name[sizeof(nfs_root_name)-1] = '\0';
diff -NurbP --minimal linux-2.4.22-pre7/include/linux/nfs.h linux-2.4.22-pre7-fix/include/linux/nfs.h
--- linux-2.4.22-pre7/include/linux/nfs.h	2000-04-01 18:04:27.000000000 +0200
+++ linux-2.4.22-pre7-fix/include/linux/nfs.h	2003-07-21 22:13:12.000000000 +0200
@@ -30,6 +30,9 @@
 #define NFS_MNT_PROGRAM	100005
 #define NFS_MNT_PORT	627
 
+#define NFS_MAJOR   	UNNAMED_MAJOR
+#define NFS_MINOR   	0xff
+
 /*
  * NFS stats. The good thing with these values is that NFSv3 errors are
  * a superset of NFSv2 errors (with the exception of NFSERR_WFLUSH which
diff -NurbP --minimal linux-2.4.22-pre7/init/do_mounts.c linux-2.4.22-pre7-fix/init/do_mounts.c
--- linux-2.4.22-pre7/init/do_mounts.c	2003-07-19 14:14:31.000000000 +0200
+++ linux-2.4.22-pre7-fix/init/do_mounts.c	2003-07-21 22:13:12.000000000 +0200
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
diff -NurbP --minimal linux-2.4.22-pre7/net/ipv4/ipconfig.c linux-2.4.22-pre7-fix/net/ipv4/ipconfig.c
--- linux-2.4.22-pre7/net/ipv4/ipconfig.c	2003-07-19 14:14:31.000000000 +0200
+++ linux-2.4.22-pre7-fix/net/ipv4/ipconfig.c	2003-07-21 22:15:50.000000000 +0200
@@ -1234,7 +1234,7 @@
 			 * 				-- Chip
 			 */
 #ifdef CONFIG_ROOT_NFS
-			if (ROOT_DEV == MKDEV(UNNAMED_MAJOR, 255)) {
+			if (ROOT_DEV == MKDEV(NFS_MAJOR, NFS_MINOR)) {
 				printk(KERN_ERR 
 					"IP-Config: Retrying forever (NFS root)...\n");
 				goto try_try_again;



----- End forwarded message -----
