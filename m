Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbUDXNkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUDXNkr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 09:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUDXNkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 09:40:47 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:18194 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262311AbUDXNko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 09:40:44 -0400
Date: Sat, 24 Apr 2004 21:43:24 +0800 (WST)
From: raven@themaw.net
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-mm1
In-Reply-To: <20040423143521.A1961@infradead.org>
Message-ID: <Pine.LNX.4.58.0404242141030.22603@donald.themaw.net>
References: <20040421014544.37942eb4.akpm@osdl.org>
 <Pine.LNX.4.58.0404222321310.6767@donald.themaw.net> <20040423131149.B1218@infradead.org>
 <Pine.LNX.4.58.0404232125420.5889@donald.themaw.net> <20040423143521.A1961@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.2, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, PATCH_UNIFIED_DIFF,
	QUOTED_EMAIL_TEXT, REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004, Christoph Hellwig wrote:

> 
> It's say keep may_umount as is, and do a no-argument may_umount_tree
> in namespace.c aswell.  As for what patches is best ask akpm.
> 

Incremental patch to revert previous may_umount_tree patch based on 
Christophs' further observation.

diff -Nur linux-2.6.6-rc1-mm1/fs/namespace.c linux-2.6.6-rc1-mm1.revert/fs/namespace.c
--- linux-2.6.6-rc1-mm1/fs/namespace.c	2004-04-22 21:06:09.000000000 +0800
+++ linux-2.6.6-rc1-mm1.revert/fs/namespace.c	2004-04-24 21:18:46.000000000 +0800
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
+ * also busy.
+ */
+int may_umount_tree(struct vfsmount *mnt)
 {
 	struct list_head *next;
 	struct vfsmount *this_parent = mnt;
@@ -271,12 +279,6 @@
 	actual_refs = atomic_read(&mnt->mnt_count);
 	minimum_refs = 2;
 
-	if (root_mnt_only) {
-		if (actual_refs > minimum_refs)
-			return -EBUSY;
-		return 0;
-	}
-
 repeat:
 	next = this_parent->mnt_mounts.next;
 resume:
@@ -307,19 +309,6 @@
 	return 0;
 }
 
-/**
- * may_umount_tree - check if a mount tree is busy
- * @mnt: root of mount tree
- *
- * This is called to check if a tree of mounts has any
- * open files, pwds, chroots or sub mounts that are
- * also busy.
- */
-int may_umount_tree(struct vfsmount *mnt)
-{
-	return __may_umount_tree(mnt, 0);
-}
-
 EXPORT_SYMBOL(may_umount_tree);
 
 /**
@@ -337,7 +326,9 @@
  */
 int may_umount(struct vfsmount *mnt)
 {
-	return __may_umount_tree(mnt, 1);
+	if (atomic_read(&mnt->mnt_count) > 2)
+		return -EBUSY;
+	return 0;
 }
 
 EXPORT_SYMBOL(may_umount);
