Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbTEYUkJ (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 25 May 2003 16:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTEYUkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 16:40:08 -0400
Received: from hera.cwi.nl ([192.16.191.8]:22504 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263750AbTEYUkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 16:40:06 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 25 May 2003 22:53:13 +0200 (MEST)
Message-Id: <UTC200305252053.h4PKrDb19659.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: [patch] namespace.c fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another one in the namespace.c series.

The code in graft_tree() used to be correct, but the code

        err = -ENOENT;
        down(&nd->dentry->d_inode->i_sem);
        if (IS_DEADDIR(nd->dentry->d_inode))
                goto out_unlock;

        spin_lock(&dcache_lock);
        if (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry)) {
		...
	}
	spin_unlock(&dcache_lock);
 out_unlock:

was made incorrect in 2.5.29 when

        err = security_sb_check_sb(mnt, nd);
        if (err)
                goto out_unlock;

was inserted.  It has happened more often that people overlooked
a preexisting setting of err.

Andries

----------------------------------------------------------------
diff -u --recursive --new-file -X /linux/dontdiff a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	Sun May 25 17:54:02 2003
+++ b/fs/namespace.c	Sun May 25 23:41:25 2003
@@ -486,9 +486,11 @@
 	if (err)
 		goto out_unlock;
 
+	err = -ENOENT;
 	spin_lock(&dcache_lock);
 	if (IS_ROOT(nd->dentry) || !d_unhashed(nd->dentry)) {
 		struct list_head head;
+
 		attach_mnt(mnt, nd);
 		list_add_tail(&head, &mnt->mnt_list);
 		list_splice(&head, current->namespace->list.prev);
