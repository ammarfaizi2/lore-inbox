Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129255AbQKUSyd>; Tue, 21 Nov 2000 13:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129682AbQKUSyX>; Tue, 21 Nov 2000 13:54:23 -0500
Received: from nat-dial-160.valinux.com ([198.186.202.160]:21742 "EHLO
	tytlal.z.streaker.org") by vger.kernel.org with ESMTP
	id <S129255AbQKUSyM>; Tue, 21 Nov 2000 13:54:12 -0500
Date: Tue, 21 Nov 2000 10:18:36 -0800
From: Chip Salzenberg <chip@valinux.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: nfs@lists.sourceforge.net
Subject: [PATCH] 2.2.18: d_move() with self-root dentries (Dentry Corruption!)
Message-ID: <20001121101836.C7075@valinux.com>
In-Reply-To: <20001121011744.A2147@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001121011744.A2147@valinux.com>; from chip@valinux.com on Tue, Nov 21, 2000 at 01:17:45AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be 2.2.18 material after all....  I wrote last night:
> Making nfsd's d_splice() compensate for d_move's limitations is not
> only a kludge, but also it harder to keep nfsd correct.
> someday, nfsd may not be the only creator of this kind of dentry.

Sure enough, there is just such a bug *already* in nfsd.  Nfsd's
cleanup after d_move is incomplete: It handles one of the dentries
being parentless, but not the other one.  This bug *will* cause dentry
corruption.[1]  It may well be what's been causing the hangs that my
recent patches seem to have fixed.

Therefore, in the mainline kernel, we need either the below patch to
d_move (along with a trivial simplifcation of nfsd's use of it), or an
expansion of the kludge in nfsd.  You can guess which one I favor....

[1] The bug can only show up when reconstructing pruned dentries, and
    only under a specific pattern of client requests, so it's not
    surprising that it is rarely observed in the wild.

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
