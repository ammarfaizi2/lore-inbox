Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422756AbWJPQ2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422756AbWJPQ2d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422745AbWJPQ2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:28:20 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:20169 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1422741AbWJPQ2Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:28:16 -0400
Message-Id: <20061016162734.724613000@szeredi.hu>
References: <20061016162709.369579000@szeredi.hu>
User-Agent: quilt/0.45-1
Date: Mon, 16 Oct 2006 18:27:12 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [patch 03/12] fuse: locking fix for nlookup
Content-Disposition: inline; filename=fuse_protect_nlookup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An inode could be returned by independent parallel lookups, in this
case an update of the lookup counter could be lost resulting in a
memory leak in userspace.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/fs/fuse/dir.c
===================================================================
--- linux.orig/fs/fuse/dir.c	2006-10-16 16:06:11.000000000 +0200
+++ linux/fs/fuse/dir.c	2006-10-16 16:08:00.000000000 +0200
@@ -163,7 +163,9 @@ static int fuse_dentry_revalidate(struct
 				fuse_send_forget(fc, req, outarg.nodeid, 1);
 				return 0;
 			}
+			spin_lock(&fc->lock);
 			fi->nlookup ++;
+			spin_unlock(&fc->lock);
 		}
 		fuse_put_request(fc, req);
 		if (err || (outarg.attr.mode ^ inode->i_mode) & S_IFMT)
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-10-16 15:57:12.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-10-16 16:08:00.000000000 +0200
@@ -195,7 +195,9 @@ struct inode *fuse_iget(struct super_blo
 	}
 
 	fi = get_fuse_inode(inode);
+	spin_lock(&fc->lock);
 	fi->nlookup ++;
+	spin_unlock(&fc->lock);
 	fuse_change_attributes(inode, attr);
 	return inode;
 }

--
