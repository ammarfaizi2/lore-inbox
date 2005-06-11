Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVFKCSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVFKCSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 22:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVFKCSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 22:18:39 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:2413 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S261164AbVFKCSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 22:18:30 -0400
Date: Fri, 10 Jun 2005 19:18:05 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] export generic_drop_inode()
Message-ID: <20050611021805.GM1153@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
        OCFS2 wants to mark an inode which has been orphaned by another node
so that during final iput it takes the correct path through the VFS and can
pass through the OCFS2 delete_inode callback. Since i_nlink can get out of
date with other nodes, the best way I see to accomplish this is by clearing
i_nlink on those inodes at drop_inode time. Other than this small amount of
work, nothing different needs to happen, so I think it would be cleanest to
be able to just call generic_drop_inode at the end of the OCFS2 drop_inode
callback.

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>

diff -aru linux-2.6.12-rc6.orig/fs/inode.c linux-2.6.12-rc6/fs/inode.c
--- linux-2.6.12-rc6.orig/fs/inode.c	2005-06-06 08:22:29.000000000 -0700
+++ linux-2.6.12-rc6/fs/inode.c	2005-06-10 18:27:07.000000000 -0700
@@ -1048,7 +1048,7 @@
  * inode when the usage count drops to zero, and
  * i_nlink is zero.
  */
-static void generic_drop_inode(struct inode *inode)
+void generic_drop_inode(struct inode *inode)
 {
 	if (!inode->i_nlink)
 		generic_delete_inode(inode);
@@ -1056,6 +1056,8 @@
 		generic_forget_inode(inode);
 }
 
+EXPORT_SYMBOL(generic_drop_inode);
+
 /*
  * Called when we're dropping the last reference
  * to an inode. 
diff -aru linux-2.6.12-rc6.orig/include/linux/fs.h linux-2.6.12-rc6/include/linux/fs.h
--- linux-2.6.12-rc6.orig/include/linux/fs.h	2005-06-06 08:22:29.000000000 -0700
+++ linux-2.6.12-rc6/include/linux/fs.h	2005-06-10 17:13:18.000000000 -0700
@@ -1411,6 +1411,7 @@
 extern ino_t iunique(struct super_block *, ino_t);
 extern int inode_needs_sync(struct inode *inode);
 extern void generic_delete_inode(struct inode *inode);
+extern void generic_drop_inode(struct inode *inode);
 
 extern struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data);
