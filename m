Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbTI1NzM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbTI1NzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:55:12 -0400
Received: from fungus.teststation.com ([212.32.186.211]:28165 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S262567AbTI1NzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:55:05 -0400
Date: Sun, 28 Sep 2003 15:54:52 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Oliver Pitzeier <oliver@linux-kernel.at>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.6.0-test6
In-Reply-To: <200309281216.h8SCGWsl026399@indianer.linux-kernel.at>
Message-ID: <Pine.LNX.4.44.0309281548060.30451-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Sep 2003, Oliver Pitzeier wrote:

> Hi folks/Linus!
> 
<snip>
> It work's on my Intel machine, but on Alpha, I get this:
> <snip>
<snip, snip>
> fs/built-in.o: In function `smb_fill_super':
> fs/built-in.o(.text+0xc9618): undefined reference to `low2highuid'
> fs/built-in.o(.text+0xc9624): undefined reference to `low2highuid'
> fs/built-in.o(.text+0xc963c): undefined reference to `low2highuid'
> fs/built-in.o(.text+0xc9640): undefined reference to `low2highuid'
> make: *** [.tmp_vmlinux1] Error 1

This patch should solve this.

Linus, please apply unless you dislike OLD_TO_NEW_GID.
smbfs is the only user of it and could check CONFIG_UID16 itself.

/Urban

--- linux-2.6.0-test5-smbfs/fs/smbfs/inode.c-orig	Fri Sep 26 21:06:55 2003
+++ linux-2.6.0-test5-smbfs/fs/smbfs/inode.c	Fri Sep 26 20:58:00 2003
@@ -551,8 +551,8 @@
 	if (ver == SMB_MOUNT_OLDVERSION) {
 		mnt->version = oldmnt->version;
 
-		mnt->uid = low2highuid(oldmnt->uid);
-		mnt->gid = low2highuid(oldmnt->gid);
+		mnt->uid = OLD_TO_NEW_UID(oldmnt->uid);
+		mnt->gid = OLD_TO_NEW_GID(oldmnt->gid);
 
 		mnt->file_mode = (oldmnt->file_mode & S_IRWXUGO) | S_IFREG;
 		mnt->dir_mode = (oldmnt->dir_mode & S_IRWXUGO) | S_IFDIR;
--- linux-2.6.0-test5-smbfs/include/linux/highuid.h-orig	Fri Sep 26 21:07:34 2003
+++ linux-2.6.0-test5-smbfs/include/linux/highuid.h	Fri Sep 26 21:07:42 2003
@@ -56,6 +56,8 @@
 #define SET_GID16(var, gid)	var = high2lowgid(gid)
 #define NEW_TO_OLD_UID(uid)	high2lowuid(uid)
 #define NEW_TO_OLD_GID(gid)	high2lowgid(gid)
+#define OLD_TO_NEW_UID(uid)	low2highuid(uid)
+#define OLD_TO_NEW_GID(gid)	low2highgid(gid)
 
 /* specific to fs/stat.c */
 #define SET_OLDSTAT_UID(stat, uid)	(stat).st_uid = high2lowuid(uid)
@@ -69,6 +71,8 @@
 #define SET_GID16(var, gid)	do { ; } while (0)
 #define NEW_TO_OLD_UID(uid)	(uid)
 #define NEW_TO_OLD_GID(gid)	(gid)
+#define OLD_TO_NEW_UID(uid)	(uid)
+#define OLD_TO_NEW_GID(gid)	(gid)
 
 #define SET_OLDSTAT_UID(stat, uid)	(stat).st_uid = (uid)
 #define SET_OLDSTAT_GID(stat, gid)	(stat).st_gid = (gid)

