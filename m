Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264602AbUAZTsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 14:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUAZTsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 14:48:23 -0500
Received: from ra.abo.fi ([130.232.213.1]:19149 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id S264602AbUAZTsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 14:48:22 -0500
Date: Mon, 26 Jan 2004 21:47:57 +0200 (EET)
From: Marcus Alanen <maalanen@ra.abo.fi>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch] copy_namespace check for NULL
Message-ID: <Pine.LNX.4.44.0401262139400.7855-100000@instlogin.cs.abo.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checking-Host: melitta.abo.fi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

As far as I can see the copy_tree() function can return NULL, so this 
checks for it. Same thing in 2.4, I'll rediff for Marcelo.

Marcus

#
# create_patch: fix_copy_namespace-2004-01-26-A.patch
# Date: Mon Jan 26 21:22:51 EET 2004
#
diff -Naurd --exclude-from=/home/msa/linux/base/diff_exclude linus-2.6.2-rc1-mm2/fs/namespace.c fix_copy_namespace-2.6.2-rc1-mm2/fs/namespace.c
--- linus-2.6.2-rc1-mm2/fs/namespace.c	2004-01-26 19:15:05.000000000 +0000
+++ fix_copy_namespace-2.6.2-rc1-mm2/fs/namespace.c	2004-01-26 19:17:06.000000000 +0000
@@ -822,12 +822,16 @@
 
 	atomic_set(&new_ns->count, 1);
 	init_rwsem(&new_ns->sem);
-	new_ns->root = NULL;
 	INIT_LIST_HEAD(&new_ns->list);
 
 	down_write(&tsk->namespace->sem);
 	/* First pass: copy the tree topology */
 	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root);
+	if (!new_ns->root) {
+		up_write(&tsk->namespace->sem);
+		kfree(new_ns);
+		goto out;
+	}
 	spin_lock(&vfsmount_lock);
 	list_add_tail(&new_ns->list, &new_ns->root->mnt_list);
 	spin_unlock(&vfsmount_lock);

