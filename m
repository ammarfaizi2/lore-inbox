Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTEROds (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 10:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTEROds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 10:33:48 -0400
Received: from hera.cwi.nl ([192.16.191.8]:20968 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262093AbTEROdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 10:33:46 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 18 May 2003 16:46:05 +0200 (MEST)
Message-Id: <UTC200305181446.h4IEk5C00022.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: [PATCH] namespace fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After
    # mount --rbind /tmp /mnt
(on 2.5.68) I have a corrupted namespace. Umounting /mnt fails,
and /proc/mounts contains
    ...
    /dev/root /mnt ext3 rw 0 0
    proc /mnt/proc proc rw 0 0
    usbfs /mnt/proc/bus/usb usbfs rw 0 0
    /dev/hdb5 /mnt/usr reiserfs rw 0 0
    ...
where of course no directories /mnt/proc or /mnt/usr exist.

This is caused by the fact that copy_tree() thinks that the dentry
it is called with is the root of the filesystem. If it is not,
confusion arose.

This confusion is fixed by the patch (against 2.5.69-bk12) below.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c	Sun May 18 00:44:23 2003
+++ b/fs/namespace.c	Sun May 18 17:17:21 2003
@@ -418,36 +418,54 @@
 #endif
 }
 
+static int
+lives_below_in_same_fs(struct dentry *d, struct dentry *dentry)
+{
+	while (1) {
+		if (d == dentry)
+			return 1;
+		if (d == NULL || d == d->d_parent)
+			return 0;
+		d = d->d_parent;
+	}
+}
+
 static struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry)
 {
-	struct vfsmount *p, *next, *q, *res;
+	struct vfsmount *res, *p, *q, *r, *s;
+	struct list_head *h;
 	struct nameidata nd;
 
-	p = mnt;
-	res = nd.mnt = q = clone_mnt(p, dentry);
+	res = q = clone_mnt(mnt, dentry);
 	if (!q)
 		goto Enomem;
-	q->mnt_parent = q;
-	q->mnt_mountpoint = p->mnt_mountpoint;
+	q->mnt_mountpoint = mnt->mnt_mountpoint;
+
+	p = mnt;
+	for (h = mnt->mnt_mounts.next; h != &mnt->mnt_mounts; h = h->next) {
+		r = list_entry(h, struct vfsmount, mnt_child);
+		if (!lives_below_in_same_fs(r->mnt_mountpoint, dentry))
+			continue;
 
-	while ( (next = next_mnt(p, mnt)) != NULL) {
-		while (p != next->mnt_parent) {
-			p = p->mnt_parent;
-			q = q->mnt_parent;
+		for (s = r; s; s = next_mnt(s, r)) {
+			while (p != s->mnt_parent) {
+				p = p->mnt_parent;
+				q = q->mnt_parent;
+			}
+			p = s;
+			nd.mnt = q;
+			nd.dentry = p->mnt_mountpoint;
+			q = clone_mnt(p, p->mnt_root);
+			if (!q)
+				goto Enomem;
+			spin_lock(&dcache_lock);
+			list_add_tail(&q->mnt_list, &res->mnt_list);
+			attach_mnt(q, &nd);
+			spin_unlock(&dcache_lock);
 		}
-		p = next;
-		nd.mnt = q;
-		nd.dentry = p->mnt_mountpoint;
-		q = clone_mnt(p, p->mnt_root);
-		if (!q)
-			goto Enomem;
-		spin_lock(&dcache_lock);
-		list_add_tail(&q->mnt_list, &res->mnt_list);
-		attach_mnt(q, &nd);
-		spin_unlock(&dcache_lock);
 	}
 	return res;
-Enomem:
+ Enomem:
 	if (res) {
 		spin_lock(&dcache_lock);
 		umount_tree(res);
