Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUBAMgd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 07:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUBAMgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 07:36:33 -0500
Received: from ns.suse.de ([195.135.220.2]:20609 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265285AbUBAMg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 07:36:28 -0500
Subject: permission() bug?
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andrew Morgan <morgan@transmeta.com>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Content-Type: multipart/mixed; boundary="=-a2A43HzTrfTgAsqMEpey"
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1075638996.2424.13.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 01 Feb 2004 13:36:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a2A43HzTrfTgAsqMEpey
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Andrew,

the fix for permission() that makes it compliant with POSIX.1-2001
apparently was lost. Here is the patch I sent before. (The relevant
lines from the standard text are cited in
http://www.ussg.iu.edu/hypermail/linux/kernel/0310.2/0286.html. The fix
proposed in that posting did not handle directories without execute
permissions correctly.)

Could you please apply the attached patch to mainline? Thanks.


Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

--=-a2A43HzTrfTgAsqMEpey
Content-Disposition: attachment; filename=permission.diff
Content-Type: text/plain; name=permission.diff; charset=
Content-Transfer-Encoding: 7bit

Make permission check conform to POSIX.1-2001

The access(2) function does not conform to POSIX.1-2001: For root
and a file with no permissions, access(file, MAY_READ|MAY_EXEC)
returns 0 (it should return -1).

Index: linux-2.6.0+fix/fs/jfs/acl.c
===================================================================
--- linux-2.6.0+fix.orig/fs/jfs/acl.c	2003-12-18 03:58:07.000000000 +0100
+++ linux-2.6.0+fix/fs/jfs/acl.c	2003-12-27 02:01:56.000000000 +0100
@@ -191,7 +191,8 @@ check_capabilities:
 	 * Read/write DACs are always overridable.
 	 * Executable DACs are overridable if at least one exec bit is set.
 	 */
-	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+	if (!(mask & MAY_EXEC) ||
+	    (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode))
 		if (capable(CAP_DAC_OVERRIDE))
 			return 0;
 
Index: linux-2.6.0+fix/fs/xfs/xfs_inode.c
===================================================================
--- linux-2.6.0+fix.orig/fs/xfs/xfs_inode.c	2003-12-18 03:59:45.000000000 +0100
+++ linux-2.6.0+fix/fs/xfs/xfs_inode.c	2003-12-27 02:05:00.000000000 +0100
@@ -3722,7 +3722,8 @@ xfs_iaccess(
 	 * Read/write DACs are always overridable.
 	 * Executable DACs are overridable if at least one exec bit is set.
 	 */
-	if ((orgmode & (S_IRUSR|S_IWUSR)) || (inode->i_mode & S_IXUGO))
+	if (!(orgmode & S_IXUSR) || (inode->i_mode & S_IXUGO) ||
+	    (ip->i_d.di_mode & S_IFMT) == S_IFDIR)
 		if (capable_cred(cr, CAP_DAC_OVERRIDE))
 			return 0;
 
Index: linux-2.6.0+fix/fs/ext2/acl.c
===================================================================
--- linux-2.6.0+fix.orig/fs/ext2/acl.c	2003-12-18 03:59:18.000000000 +0100
+++ linux-2.6.0+fix/fs/ext2/acl.c	2003-12-27 02:05:46.000000000 +0100
@@ -322,7 +322,8 @@ check_groups:
 
 check_capabilities:
 	/* Allowed to override Discretionary Access Control? */
-	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+	if (!(mask & MAY_EXEC) ||
+	    (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode))
 		if (capable(CAP_DAC_OVERRIDE))
 			return 0;
 	/* Read and search granted if capable(CAP_DAC_READ_SEARCH) */
Index: linux-2.6.0+fix/fs/ext3/acl.c
===================================================================
--- linux-2.6.0+fix.orig/fs/ext3/acl.c	2003-12-18 03:58:39.000000000 +0100
+++ linux-2.6.0+fix/fs/ext3/acl.c	2003-12-27 02:07:02.000000000 +0100
@@ -327,7 +327,8 @@ check_groups:
 
 check_capabilities:
 	/* Allowed to override Discretionary Access Control? */
-	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+	if (!(mask & MAY_EXEC) ||
+	    (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode))
 		if (capable(CAP_DAC_OVERRIDE))
 			return 0;
 	/* Read and search granted if capable(CAP_DAC_READ_SEARCH) */
Index: linux-2.6.0+fix/fs/namei.c
===================================================================
--- linux-2.6.0+fix.orig/fs/namei.c	2003-12-18 03:58:40.000000000 +0100
+++ linux-2.6.0+fix/fs/namei.c	2003-12-27 01:58:23.000000000 +0100
@@ -190,7 +190,8 @@ int vfs_permission(struct inode * inode,
 	 * Read/write DACs are always overridable.
 	 * Executable DACs are overridable if at least one exec bit is set.
 	 */
-	if ((mask & (MAY_READ|MAY_WRITE)) || (inode->i_mode & S_IXUGO))
+	if (!(mask & MAY_EXEC) ||
+	    (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode))
 		if (capable(CAP_DAC_OVERRIDE))
 			return 0;
 

--=-a2A43HzTrfTgAsqMEpey--

