Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbUDZRJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUDZRJT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 13:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbUDZRJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 13:09:19 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:25608 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S263149AbUDZRJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 13:09:07 -0400
Date: Tue, 27 Apr 2004 01:11:15 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-mm2
In-Reply-To: <20040426013944.49a105a8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404270105200.2304@donald.themaw.net>
References: <20040426013944.49a105a8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.7, required 8,
	IN_REP_TO, NO_REAL_NAME, PATCH_UNIFIED_DIFF, REFERENCES,
	USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch to sync 2.6.6-rc2-mm2 with the result of my discussion with 
Christoph Hellwig.

Difference is that Christoph realised that merging may_umount_tree and 
may_umount was not worth it. They are now seperate functions.

diff -Nur linux-2.6.6-rc2-mm2.orig/fs/namespace.c linux-2.6.6-rc2-mm2/fs/namespace.c
--- linux-2.6.6-rc2-mm2.orig/fs/namespace.c	2004-04-27 00:51:36.000000000 +0800
+++ linux-2.6.6-rc2-mm2/fs/namespace.c	2004-04-27 00:43:32.000000000 +0800
@@ -260,7 +260,15 @@
 	.show	= show_vfsmnt
 };
 
-static int __may_umount_tree(struct vfsmount *mnt, int root_mnt_only)
+/**
+ * may_umount_tree - check if a mount tree is busy
+ * @mnt: root of mount tree
+ *
+ * This is called to check if a tree of mounts has any
+ * open files, pwds, chroots or sub mounts that are
+ * busy.
+ */
+int may_umount_tree(struct vfsmount *mnt)
 {
 	struct list_head *next;
 	struct vfsmount *this_parent = mnt;
@@ -270,14 +278,6 @@
 	spin_lock(&vfsmount_lock);
 	actual_refs = atomic_read(&mnt->mnt_count);
 	minimum_refs = 2;
-
-	if (root_mnt_only) {
- 		spin_unlock(&vfsmount_lock);
-		if (actual_refs > minimum_refs)
-			return -EBUSY;
-		return 0;
-	}
-
 repeat:
 	next = this_parent->mnt_mounts.next;
 resume:
@@ -308,19 +308,6 @@
 	return 0;
 }
 
-/**
- * may_umount_tree - check if a mount tree is busy
- * @mnt: root of mount tree
- *
- * This is called to check if a tree of mounts has any
- * open files, pwds, chroots or sub mounts that are
- * busy.
- */
-int may_umount_tree(struct vfsmount *mnt)
-{
-	return __may_umount_tree(mnt, 0);
-}
-
 EXPORT_SYMBOL(may_umount_tree);
 
 /**
@@ -338,7 +325,9 @@
  */
 int may_umount(struct vfsmount *mnt)
 {
-	return __may_umount_tree(mnt, 1);
+	if (atomic_read(&mnt->mnt_count) > 2)
+		return -EBUSY;
+	return 0;
 }
 
 EXPORT_SYMBOL(may_umount);
