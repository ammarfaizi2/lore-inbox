Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVD1OQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVD1OQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 10:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVD1OQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 10:16:55 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:425 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262141AbVD1OQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 10:16:53 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: multiple links to directory fix
Message-Id: <E1DR9oc-0005tk-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Apr 2005 16:16:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug, that allowed multiple dentries to refer to the
same directory inode.  This check was dropped from the 2.6 version
probably because I believed that d_splice_alias() will somehow do this
check (which it doesn't).  Thanks to the fine folks on linux-fsdevel
reminding me of the ugly possibility of hardlinked directories.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc2-mm3/fs/fuse/dir.c linux-fuse/fs/fuse/dir.c
--- linux-2.6.12-rc2-mm3/fs/fuse/dir.c	2005-04-22 16:00:16.000000000 +0200
+++ linux-fuse/fs/fuse/dir.c	2005-04-28 15:32:02.000000000 +0200
@@ -703,6 +731,15 @@ static struct dentry *fuse_lookup(struct
 	int err = fuse_lookup_iget(dir, entry, &inode);
 	if (err)
 		return ERR_PTR(err);
+	if (inode && S_ISDIR(inode->i_mode)) {
+		/* Don't allow creating an alias to a directory  */
+		struct dentry *alias = d_find_alias(inode);
+		if (alias && !(alias->d_flags & DCACHE_DISCONNECTED)) {
+			dput(alias);
+			iput(inode);
+			return ERR_PTR(-EIO);
+		}
+	}
 	return d_splice_alias(inode, entry);
 }
 
