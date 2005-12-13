Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVLMR5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVLMR5V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVLMR5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:57:12 -0500
Received: from verein.lst.de ([213.95.11.210]:39379 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932447AbVLMR5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:57:00 -0500
Date: Tue, 13 Dec 2005 18:56:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] move MS_NOATIME mirroring inside xfs
Message-ID: <20051213175655.GE17130@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

XFS propagates MS_NOATIME through two levels internally but doesn't
actually use it.  Kill this dead code.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.15-rc5/fs/xfs/linux-2.6/xfs_super.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/xfs/linux-2.6/xfs_super.c	2005-12-12 18:51:18.000000000 +0100
+++ linux-2.6.15-rc5/fs/xfs/linux-2.6/xfs_super.c	2005-12-13 11:48:12.000000000 +0100
@@ -76,8 +76,6 @@
 	strncpy(args->fsname, sb->s_id, MAXNAMELEN);
 
 	/* Copy the already-parsed mount(2) flags we're interested in */
-	if (sb->s_flags & MS_NOATIME)
-		args->flags |= XFSMNT_NOATIME;
 	if (sb->s_flags & MS_DIRSYNC)
 		args->flags |= XFSMNT_DIRSYNC;
 	if (sb->s_flags & MS_SYNCHRONOUS)
Index: linux-2.6.15-rc5/fs/xfs/xfs_clnt.h
===================================================================
--- linux-2.6.15-rc5.orig/fs/xfs/xfs_clnt.h	2005-12-12 18:51:18.000000000 +0100
+++ linux-2.6.15-rc5/fs/xfs/xfs_clnt.h	2005-12-13 11:48:18.000000000 +0100
@@ -68,8 +68,6 @@
 						 * enforcement */
 #define XFSMNT_PQUOTAENF	0x00000040	/* IRIX project quota limit
 						 * enforcement */
-#define XFSMNT_NOATIME		0x00000100	/* don't modify access
-						 * times on reads */
 #define XFSMNT_NOALIGN		0x00000200	/* don't allocate at
 						 * stripe boundaries*/
 #define XFSMNT_RETERR		0x00000400	/* return error to user */
Index: linux-2.6.15-rc5/fs/xfs/xfs_mount.h
===================================================================
--- linux-2.6.15-rc5.orig/fs/xfs/xfs_mount.h	2005-12-12 18:51:18.000000000 +0100
+++ linux-2.6.15-rc5/fs/xfs/xfs_mount.h	2005-12-13 11:47:51.000000000 +0100
@@ -387,8 +387,6 @@
 #define XFS_MOUNT_FS_SHUTDOWN	(1ULL << 4)	/* atomic stop of all filesystem
 						   operations, typically for
 						   disk errors in metadata */
-#define XFS_MOUNT_NOATIME	(1ULL << 5)	/* don't modify inode access
-						   times on reads */
 #define XFS_MOUNT_RETERR	(1ULL << 6)     /* return alignment errors to
 						   user */
 #define XFS_MOUNT_NOALIGN	(1ULL << 7)	/* turn off stripe alignment
Index: linux-2.6.15-rc5/fs/xfs/xfs_vfsops.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/xfs/xfs_vfsops.c	2005-12-12 18:51:18.000000000 +0100
+++ linux-2.6.15-rc5/fs/xfs/xfs_vfsops.c	2005-12-13 11:47:40.000000000 +0100
@@ -258,8 +258,6 @@
 		mp->m_inoadd = XFS_INO64_OFFSET;
 	}
 #endif
-	if (ap->flags & XFSMNT_NOATIME)
-		mp->m_flags |= XFS_MOUNT_NOATIME;
 	if (ap->flags & XFSMNT_RETERR)
 		mp->m_flags |= XFS_MOUNT_RETERR;
 	if (ap->flags & XFSMNT_NOALIGN)
@@ -654,11 +652,6 @@
 	xfs_mount_t	*mp = XFS_BHVTOM(bdp);
 	int		error;
 
-	if (args->flags & XFSMNT_NOATIME)
-		mp->m_flags |= XFS_MOUNT_NOATIME;
-	else
-		mp->m_flags &= ~XFS_MOUNT_NOATIME;
-
 	if (args->flags & XFSMNT_BARRIER)
 		mp->m_flags |= XFS_MOUNT_BARRIER;
 	else
