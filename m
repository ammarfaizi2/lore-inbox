Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751848AbWKBQXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWKBQXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 11:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWKBQXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 11:23:19 -0500
Received: from mx1.suse.de ([195.135.220.2]:52389 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751848AbWKBQXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 11:23:18 -0500
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Linux
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix user.* xattr permission check for sticky dirs
Date: Thu, 2 Nov 2006 17:24:02 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Gerard Neil <xyzzy@devferret.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611021724.02886.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The user.* extended attributes are only allowed on regular files and
directories. Sticky directories further restrict write access to the
owner and privileged users. (See the attr(5) man page for an
explanation.)

The original check in ext2/ext3 when user.* xattrs were merged was more
restrictive than intended, and when the xattr permission checks were moved 
into the VFS, read access to user.* attributes on sticky directores ended up
being denied in addition.

Originally-from: Gerard Neil <xyzzy@devferret.org>
Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.19-rc4/fs/xattr.c
===================================================================
--- linux-2.6.19-rc4.orig/fs/xattr.c
+++ linux-2.6.19-rc4/fs/xattr.c
@@ -48,14 +48,21 @@ xattr_permission(struct inode *inode, co
 		return 0;
 
 	/*
-	 * The trusted.* namespace can only accessed by a privilegued user.
+	 * The trusted.* namespace can only be accessed by a privileged user.
 	 */
 	if (!strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN))
 		return (capable(CAP_SYS_ADMIN) ? 0 : -EPERM);
 
+	/* In user.* namespace, only regular files and directories can have
+	 * extended attributes. For sticky directories, only the owner and
+	 * privileged user can write attributes.
+	 */
 	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
-		if (!S_ISREG(inode->i_mode) &&
-		    (!S_ISDIR(inode->i_mode) || inode->i_mode & S_ISVTX))
+		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
+			return -EPERM;
+		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
+		    (mask & MAY_WRITE) && (current->fsuid != inode->i_uid) &&
+		    !capable(CAP_FOWNER))
 			return -EPERM;
 	}
 
