Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751841AbWB1Fas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbWB1Fas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 00:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWB1Fas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 00:30:48 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:5538 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751841AbWB1Far (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 00:30:47 -0500
Date: Tue, 28 Feb 2006 06:30:46 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [RFC 2/2] vfs: fixup nfs and fuse by passing nd_flags via mask
Message-ID: <20060228053046.GC6494@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060228052606.GA6494@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060228052606.GA6494@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fixup nfs and fuse nameidata related checks by 
passing the relevant flags via the mask.

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>
Acked-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---

diff -NurpP --minimal linux-2.6.16-rc5-vfs0.02.1/fs/fuse/dir.c linux-2.6.16-rc5-vfs0.02.2/fs/fuse/dir.c
--- linux-2.6.16-rc5-vfs0.02.1/fs/fuse/dir.c	2006-02-28 05:56:38 +0100
+++ linux-2.6.16-rc5-vfs0.02.2/fs/fuse/dir.c	2006-02-28 05:49:57 +0100
@@ -731,8 +731,9 @@ static int fuse_permission(struct inode 
 		if ((mask & MAY_EXEC) && !S_ISDIR(mode) && !(mode & S_IXUGO))
 			return -EACCES;
 
-		if (nd && (nd->flags & LOOKUP_ACCESS))
+		if (mask & LOOKUP_ACCESS)
 			return fuse_access(inode, mask);
+
 		return 0;
 	}
 }
diff -NurpP --minimal linux-2.6.16-rc5-vfs0.02.1/fs/namei.c linux-2.6.16-rc5-vfs0.02.2/fs/namei.c
--- linux-2.6.16-rc5-vfs0.02.1/fs/namei.c	2006-02-28 05:34:28 +0100
+++ linux-2.6.16-rc5-vfs0.02.2/fs/namei.c	2006-02-28 05:47:29 +0100
@@ -271,8 +271,11 @@ int permission(struct inode *inode, int 
  */
 int vfs_permission(struct nameidata *nd, int mask)
 {
+	int nd_flags = nd->flags &
+		(LOOKUP_ACCESS | LOOKUP_CREATE | LOOKUP_OPEN);
+
 	/* do nd based stuff here */
-	return permission(nd->dentry->d_inode, mask);
+	return permission(nd->dentry->d_inode, mask | nd_flags);
 }
 
 /**
diff -NurpP --minimal linux-2.6.16-rc5-vfs0.02.1/fs/nfs/dir.c linux-2.6.16-rc5-vfs0.02.2/fs/nfs/dir.c
--- linux-2.6.16-rc5-vfs0.02.1/fs/nfs/dir.c	2006-02-28 05:56:38 +0100
+++ linux-2.6.16-rc5-vfs0.02.2/fs/nfs/dir.c	2006-02-28 05:51:36 +0100
@@ -1643,7 +1643,7 @@ int nfs_permission(struct inode *inode, 
 	if (mask == 0)
 		goto out;
 	/* Is this sys_access() ? */
-	if (nd != NULL && (nd->flags & LOOKUP_ACCESS))
+	if (mask & LOOKUP_ACCESS)
 		goto force_lookup;
 
 	switch (inode->i_mode & S_IFMT) {
@@ -1652,8 +1652,7 @@ int nfs_permission(struct inode *inode, 
 		case S_IFREG:
 			/* NFSv4 has atomic_open... */
 			if (nfs_server_capable(inode, NFS_CAP_ATOMIC_OPEN)
-					&& nd != NULL
-					&& (nd->flags & LOOKUP_OPEN))
+					&& (mask & LOOKUP_OPEN))
 				goto out;
 			break;
 		case S_IFDIR:

