Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWARH1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWARH1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWARHYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:24:13 -0500
Received: from 203-59-65-76.dyn.iinet.net.au ([203.59.65.76]:16325 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S1030275AbWARHXr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:23:47 -0500
Date: Wed, 18 Jan 2006 15:23:11 +0800
Message-Id: <200601180723.k0I7NBmY006152@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: [PATCH 5/13] autofs4 - simplify expire tree traversal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies the expire tree traversal code by using a
function from namespace.c to calculate the next entry in the top
down tree traversals carried out during the expire operation.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.15-mm2/fs/autofs4/expire.c.expire-traversal-cleanup	2006-01-12 15:11:55.000000000 +0800
+++ linux-2.6.15-mm2/fs/autofs4/expire.c	2006-01-12 15:14:27.000000000 +0800
@@ -72,6 +72,27 @@ done:
 	return status;
 }
 
+/*
+ * Calculate next entry in top down tree traversal.
+ * From next_mnt in namespace.c - elegant.
+ */
+static struct dentry *next_dentry(struct dentry *p, struct dentry *root)
+{
+	struct list_head *next = p->d_subdirs.next;
+
+	if (next == &p->d_subdirs) {
+		while (1) {
+			if (p == root)
+				return NULL;
+			next = p->d_u.d_child.next;
+			if (next != &p->d_parent->d_subdirs)
+				break;
+			p = p->d_parent;
+		}
+	}
+	return list_entry(next, struct dentry, d_u.d_child);
+}
+
 /* Check a directory tree of mount points for busyness
  * The tree is not busy iff no mountpoints are busy
  */
@@ -80,8 +101,7 @@ static int autofs4_tree_busy(struct vfsm
 			     unsigned long timeout,
 			     int do_now)
 {
-	struct dentry *this_parent = top;
-	struct list_head *next;
+	struct dentry *p;
 
 	DPRINTK("top %p %.*s",
 		top, (int)top->d_name.len, top->d_name.name);
@@ -99,49 +119,28 @@ static int autofs4_tree_busy(struct vfsm
 		return 1;
 
 	spin_lock(&dcache_lock);
-repeat:
-	next = this_parent->d_subdirs.next;
-resume:
-	while (next != &this_parent->d_subdirs) {
-		struct dentry *dentry = list_entry(next, struct dentry, d_u.d_child);
-
+	for (p = top; p; p = next_dentry(p, top)) {
 		/* Negative dentry - give up */
-		if (!simple_positive(dentry)) {
-			next = next->next;
+		if (!simple_positive(p))
 			continue;
-		}
 
 		DPRINTK("dentry %p %.*s",
-			dentry, (int)dentry->d_name.len, dentry->d_name.name);
-
-		if (!simple_empty_nolock(dentry)) {
-			this_parent = dentry;
-			goto repeat;
-		}
+			p, (int) p->d_name.len, p->d_name.name);
 
-		dentry = dget(dentry);
+		p = dget(p);
 		spin_unlock(&dcache_lock);
 
-		if (d_mountpoint(dentry)) {
+		if (d_mountpoint(p)) {
 			/* First busy => tree busy */
-			if (autofs4_mount_busy(mnt, dentry)) {
-				dput(dentry);
+			if (autofs4_mount_busy(mnt, p)) {
+				dput(p);
 				return 1;
 			}
 		}
-
-		dput(dentry);
+		dput(p);
 		spin_lock(&dcache_lock);
-		next = next->next;
-	}
-
-	if (this_parent != top) {
-		next = this_parent->d_u.d_child.next;
-		this_parent = this_parent->d_parent;
-		goto resume;
 	}
 	spin_unlock(&dcache_lock);
-
 	return 0;
 }
 
@@ -150,59 +149,38 @@ static struct dentry *autofs4_check_leav
 					   unsigned long timeout,
 					   int do_now)
 {
-	struct dentry *this_parent = parent;
-	struct list_head *next;
+	struct dentry *p;
 
 	DPRINTK("parent %p %.*s",
 		parent, (int)parent->d_name.len, parent->d_name.name);
 
 	spin_lock(&dcache_lock);
-repeat:
-	next = this_parent->d_subdirs.next;
-resume:
-	while (next != &this_parent->d_subdirs) {
-		struct dentry *dentry = list_entry(next, struct dentry, d_u.d_child);
-
+	for (p = parent; p; p = next_dentry(p, parent)) {
 		/* Negative dentry - give up */
-		if (!simple_positive(dentry)) {
-			next = next->next;
+		if (!simple_positive(p))
 			continue;
-		}
 
 		DPRINTK("dentry %p %.*s",
-			dentry, (int)dentry->d_name.len, dentry->d_name.name);
+			p, (int) p->d_name.len, p->d_name.name);
 
-		if (!list_empty(&dentry->d_subdirs)) {
-			this_parent = dentry;
-			goto repeat;
-		}
-
-		dentry = dget(dentry);
+		p = dget(p);
 		spin_unlock(&dcache_lock);
 
-		if (d_mountpoint(dentry)) {
+		if (d_mountpoint(p)) {
 			/* Can we expire this guy */
-			if (!autofs4_can_expire(dentry, timeout, do_now))
+			if (!autofs4_can_expire(p, timeout, do_now))
 				goto cont;
 
 			/* Can we umount this guy */
-			if (!autofs4_mount_busy(mnt, dentry))
-				return dentry;
+			if (!autofs4_mount_busy(mnt, p))
+				return p;
 
 		}
 cont:
-		dput(dentry);
+		dput(p);
 		spin_lock(&dcache_lock);
-		next = next->next;
-	}
-
-	if (this_parent != parent) {
-		next = this_parent->d_u.d_child.next;
-		this_parent = this_parent->d_parent;
-		goto resume;
 	}
 	spin_unlock(&dcache_lock);
-
 	return NULL;
 }
 
