Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWCJMM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWCJMM7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 07:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWCJMM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 07:12:59 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:14347 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1750719AbWCJMM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 07:12:58 -0500
Date: Fri, 10 Mar 2006 20:08:49 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] autofs4 - follow_link missing funtionality
Message-ID: <Pine.LNX.4.64.0603102003110.3032@eagle.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This functionality is also need for operation of autofs v5 direct mounts.

Signed-off-by: Ian Kent <raven@themaw.net>

---

--- linux-2.6.16-rc5-mm3/fs/autofs4/root.c.follow_link-ommission	2006-03-08 13:21:37.000000000 +0800
+++ linux-2.6.16-rc5-mm3/fs/autofs4/root.c	2006-03-08 13:27:47.000000000 +0800
@@ -57,6 +57,9 @@ struct inode_operations autofs4_indirect
 
 struct inode_operations autofs4_direct_root_inode_operations = {
 	.lookup		= autofs4_lookup,
+	.unlink		= autofs4_dir_unlink,
+	.mkdir		= autofs4_dir_mkdir,
+	.rmdir		= autofs4_dir_rmdir,
 	.follow_link	= autofs4_follow_link,
 };
 
@@ -337,10 +340,34 @@ static void *autofs4_follow_link(struct 
 	if (oz_mode || !lookup_type)
 		goto done;
 
+	/*
+	 * If the dentry contains directories then it is an
+	 * autofs multi-mount with no root offset. So don't
+	 * try to mount it again.
+	 */
+	spin_lock(&dcache_lock);
+	if (!list_empty(&dentry->d_subdirs)) {
+		spin_unlock(&dcache_lock);
+		goto done;
+	}
+	spin_unlock(&dcache_lock);
+
 	status = try_to_fill_dentry(dentry, 0);
 	if (status)
 		goto out_error;
 
+	/*
+	 * The mount succeeded but if there is no root mount
+	 * and directories have been created then it must
+	 * be an autofs multi-mount with no root offset.
+	 */
+	spin_lock(&dcache_lock);
+	if (!d_mountpoint(dentry) && !list_empty(&dentry->d_subdirs)) {
+		spin_unlock(&dcache_lock);
+		goto done;
+	}
+	spin_unlock(&dcache_lock);
+
 	if (!autofs4_follow_mount(&nd->mnt, &nd->dentry)) {
 		status = -ENOENT;
 		goto out_error;
--- linux-2.6.16-rc5-mm3/fs/autofs4/expire.c.follow_link-ommission	2006-03-08 14:18:25.000000000 +0800
+++ linux-2.6.16-rc5-mm3/fs/autofs4/expire.c	2006-03-08 13:28:21.000000000 +0800
@@ -113,10 +113,6 @@ static int autofs4_direct_busy(struct vf
 	DPRINTK("top %p %.*s",
 		top, (int) top->d_name.len, top->d_name.name);
 
-	/* Not a mountpoint - give up */
-	if (!d_mountpoint(top))
-		return 1;
-
 	/* If it's busy update the expiry counters */
 	if (!may_umount_tree(mnt)) {
 		struct autofs_info *ino = autofs4_dentry_ino(top);
