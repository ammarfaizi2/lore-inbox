Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130128AbQKUJyd>; Tue, 21 Nov 2000 04:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbQKUJyW>; Tue, 21 Nov 2000 04:54:22 -0500
Received: from nat-dial-160.valinux.com ([198.186.202.160]:57085 "EHLO
	tytlal.z.streaker.org") by vger.kernel.org with ESMTP
	id <S130128AbQKUJyK>; Tue, 21 Nov 2000 04:54:10 -0500
Date: Tue, 21 Nov 2000 01:17:45 -0800
From: Chip Salzenberg <chip@valinux.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: nfs@lists.sourceforge.net
Subject: [PATCH] 2.2.18: d_move() with self-root dentries
Message-ID: <20001121011744.A2147@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The d_move() function doesn't correctly handle dentries that have no
parents (i.e. 'x->d_parent==x').  This patch lets it do so.

Normally, the only parentless dentries are filesystem roots.  However,
the NFS server creates (temporary) parentless dentries whenever dentry
pruning has deleted the dentries referring to clients' open files.

Making nfsd's d_splice() compensate for d_move's limitations is not
only a kludge, but also it harder to keep nfsd correct.  Besides,
someday, nfsd may not be the only creator of this kind of dentry.

Thus, this patch.  If you apply this, you'll also want to patch
fs/nfsd/nfsfh.c to stop compensating for d_move's old limitations.
(Alan, this is 2.2.19 material [if then].)

Index: fs/dcache.c
--- fs/dcache.c.prev
+++ fs/dcache.c	Mon Nov 20 22:31:09 2000
@@ -749,16 +749,28 @@ void d_move(struct dentry * dentry, stru
 	INIT_LIST_HEAD(&target->d_hash);
 
+	/* Switch the names */
+	switch_names(dentry, target);
+	do_switch(dentry->d_name.len, target->d_name.len);
+	do_switch(dentry->d_name.hash, target->d_name.hash);
+
+	/* Switch parentage, allowing for self-parents */
+
 	list_del(&dentry->d_child);
 	list_del(&target->d_child);
 
-	/* Switch the parents and the names.. */
-	switch_names(dentry, target);
 	do_switch(dentry->d_parent, target->d_parent);
-	do_switch(dentry->d_name.len, target->d_name.len);
-	do_switch(dentry->d_name.hash, target->d_name.hash);
 
-	/* And add them back to the (new) parent lists */
-	list_add(&target->d_child, &target->d_parent->d_subdirs);
-	list_add(&dentry->d_child, &dentry->d_parent->d_subdirs);
+	if (dentry->d_parent != target)
+		list_add(&dentry->d_child, &dentry->d_parent->d_subdirs);
+	else {
+		INIT_LIST_HEAD(&dentry->d_child);
+		dentry->d_parent = dentry;
+	}
+	if (target->d_parent != dentry)
+		list_add(&target->d_child, &target->d_parent->d_subdirs);
+	else {
+		INIT_LIST_HEAD(&target->d_child);
+		target->d_parent = target;
+	}
 }
 

-- 
Chip Salzenberg            - a.k.a. -            <chip@valinux.com>
   "Give me immortality, or give me death!"  // Firesign Theatre
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
