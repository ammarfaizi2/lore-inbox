Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbVHZPEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVHZPEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbVHZPEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:04:52 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:26802 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S965066AbVHZPEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:04:52 -0400
Subject: [patch 1/2] Fixup symlink function pointers for hppfs [for 2.6.13]
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 26 Aug 2005 16:57:44 +0200
Message-Id: <20050826145749.03BFE24D661@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Update hppfs for the symlink functions prototype change.
Should be trivial, but please verify it's correct.

Yes, I know the code I leave there is still _bogus_, see next patch for this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/fs/hppfs/hppfs_kern.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff -puN fs/hppfs/hppfs_kern.c~hppfs-fix-symlink fs/hppfs/hppfs_kern.c
--- linux-2.6.git/fs/hppfs/hppfs_kern.c~hppfs-fix-symlink	2005-08-24 17:43:56.000000000 +0200
+++ linux-2.6.git-paolo/fs/hppfs/hppfs_kern.c	2005-08-24 18:17:46.000000000 +0200
@@ -679,25 +679,25 @@ static int hppfs_readlink(struct dentry 
 	return(n);
 }
 
-static int hppfs_follow_link(struct dentry *dentry, struct nameidata *nd)
+static void* hppfs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct file *proc_file;
 	struct dentry *proc_dentry;
-	int (*follow_link)(struct dentry *, struct nameidata *);
-	int err, n;
+	void * (*follow_link)(struct dentry *, struct nameidata *);
+	void *ret;
 
 	proc_dentry = HPPFS_I(dentry->d_inode)->proc_dentry;
 	proc_file = dentry_open(dget(proc_dentry), NULL, O_RDONLY);
-	err = PTR_ERR(proc_dentry);
-	if(IS_ERR(proc_dentry))
-		return(err);
+
+	if (IS_ERR(proc_dentry))
+		return proc_dentry;
 
 	follow_link = proc_dentry->d_inode->i_op->follow_link;
-	n = (*follow_link)(proc_dentry, nd);
+	ret = (*follow_link)(proc_dentry, nd);
 
 	fput(proc_file);
 
-	return(n);
+	return ret;
 }
 
 static struct inode_operations hppfs_dir_iops = {
_
