Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTIZTMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 15:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTIZTMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 15:12:25 -0400
Received: from fungus.teststation.com ([212.32.186.211]:5381 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S261613AbTIZTMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 15:12:24 -0400
Date: Fri, 26 Sep 2003 21:12:16 +0200 (CEST)
From: Urban Widmark <Urban.Widmark@enlight.net>
X-X-Sender: puw@cola.local
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: buggy changes to fs/smbfs/inode.c
In-Reply-To: <20030925225116.433e1c53.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0309262054370.13663-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Sep 2003, David S. Miller wrote:

> 
> Your changes to fs/smbfs/inode.c do not build on platforms
> that do not define CONFIG_UID16.  You cannot use low2highuid()
> unless CONFIG_UID16 is known to be defined.

Ah, sorry about that.

I guess what I want is an OLD_TO_NEW_UID macro. How does this look?

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

