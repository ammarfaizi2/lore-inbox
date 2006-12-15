Return-Path: <linux-kernel-owner+w=401wt.eu-S1753067AbWLOSjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbWLOSjS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 13:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbWLOSjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 13:39:18 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:55995 "EHLO pfx2.jmh.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067AbWLOSjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 13:39:17 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] avoid one conditional branch in touch_atime()
Date: Fri, 15 Dec 2006 19:38:54 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200612150823.kBF8NV2u011171@shell0.pdx.osdl.net> <20061215081138.4c51e7c5.akpm@osdl.org> <200612151851.58741.dada1@cosmosbay.com>
In-Reply-To: <200612151851.58741.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/uugFUh4B9Do63f"
Message-Id: <200612151938.55010.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_/uugFUh4B9Do63f
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I added IS_NOATIME(inode) macro definition in include/linux/fs.h, true if the 
inode superblock is marked readonly or noatime.

This new macro is then used in touch_atime() instead of separatly testing 
MS_RDONLY and MS_NOATIME

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_/uugFUh4B9Do63f
Content-Type: text/plain;
  charset="utf-8";
  name="touch_atime.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="touch_atime.patch"

--- linux-2.6.20-rc1-mm1/fs/inode.c	2006-12-14 02:14:23.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/fs/inode.c	2006-12-15 20:14:31.000000000 +0100
@@ -1160,11 +1160,9 @@ void touch_atime(struct vfsmount *mnt, s
 	struct inode *inode = dentry->d_inode;
 	struct timespec now;
 
-	if (IS_RDONLY(inode))
-		return;
 	if (inode->i_flags & S_NOATIME)
 		return;
-	if (inode->i_sb->s_flags & MS_NOATIME)
+	if (IS_NOATIME(inode))
 		return;
 	if ((inode->i_sb->s_flags & MS_NODIRATIME) && S_ISDIR(inode->i_mode))
 		return;
--- linux-2.6.20-rc1-mm1/include/linux/fs.h	2006-12-15 15:46:16.000000000 +0100
+++ linux-2.6.20-rc1-mm1-ed/include/linux/fs.h	2006-12-15 20:16:13.000000000 +0100
@@ -169,6 +169,7 @@ extern int dir_notify_enable;
 #define IS_DIRSYNC(inode)	(__IS_FLG(inode, MS_SYNCHRONOUS|MS_DIRSYNC) || \
 					((inode)->i_flags & (S_SYNC|S_DIRSYNC)))
 #define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
+#define IS_NOATIME(inode)   __IS_FLG(inode, MS_RDONLY|MS_NOATIME)
 
 #define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
 #define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)

--Boundary-00=_/uugFUh4B9Do63f--
