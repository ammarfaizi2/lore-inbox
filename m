Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUGRV2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUGRV2c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 17:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUGRV2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 17:28:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15278 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264524AbUGRV2a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 17:28:30 -0400
Date: Sun, 18 Jul 2004 22:28:28 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Re: check_mnt() breaks namespaces
Message-ID: <20040718212828.GF12308@parcelfarce.linux.theplanet.co.uk>
References: <20040714233646.GA25298@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714233646.GA25298@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	It's not check_mnt(), it's breakage in copy_namespace().
It forgets to switch new field (->mnt_namespace) in the vfsmounts
of new namespace.

--- ../RC8-rc2/fs/namespace.c	Sun Jul 18 09:08:42 2004
+++ fs/namespace.c	Sun Jul 18 17:23:15 2004
@@ -1037,6 +1037,7 @@
 	struct namespace *new_ns;
 	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL, *altrootmnt = NULL;
 	struct fs_struct *fs = tsk->fs;
+	struct vfsmount *p, *q;
 
 	if (!namespace)
 		return 0;
@@ -1071,14 +1072,16 @@
 	list_add_tail(&new_ns->list, &new_ns->root->mnt_list);
 	spin_unlock(&vfsmount_lock);
 
-	/* Second pass: switch the tsk->fs->* elements */
-	if (fs) {
-		struct vfsmount *p, *q;
-		write_lock(&fs->lock);
-
-		p = namespace->root;
-		q = new_ns->root;
-		while (p) {
+	/*
+	 * Second pass: switch the tsk->fs->* elements and mark new vfsmounts
+	 * as belonging to new namespace.  We have already acquired a private
+	 * fs_struct, so tsk->fs->lock is not needed.
+	 */
+	p = namespace->root;
+	q = new_ns->root;
+	while (p) {
+		q->mnt_namespace = new_ns;
+		if (fs) {
 			if (p == fs->rootmnt) {
 				rootmnt = p;
 				fs->rootmnt = mntget(q);
@@ -1091,10 +1094,9 @@
 				altrootmnt = p;
 				fs->altrootmnt = mntget(q);
 			}
-			p = next_mnt(p, namespace->root);
-			q = next_mnt(q, new_ns->root);
 		}
-		write_unlock(&fs->lock);
+		p = next_mnt(p, namespace->root);
+		q = next_mnt(q, new_ns->root);
 	}
 	up_write(&tsk->namespace->sem);
 
