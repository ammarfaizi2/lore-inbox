Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbUJYPAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbUJYPAK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbUJYO4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:56:53 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:51368 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261841AbUJYOnq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:43:46 -0400
Cc: raven@themaw.net
Subject: [PATCH 10/28] VFS: Move next_mnt()
In-Reply-To: <10987153821176@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:43:32 -0400
Message-Id: <10987154121124@sun.com>
References: <10987153821176@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simply moves next_mnt in preparation for the next patch that
implements detachable subtrees.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 namespace.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:37.770722120 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:38.338635784 -0400
@@ -121,6 +121,22 @@ static inline int check_mnt(struct vfsmo
 	return mnt->mnt_namespace == current->namespace;
 }
 
+static struct vfsmount *next_mnt(struct vfsmount *p, struct vfsmount *root)
+{
+	struct list_head *next = p->mnt_mounts.next;
+	if (next == &p->mnt_mounts) {
+		while (1) {
+			if (p == root)
+				return NULL;
+			next = p->mnt_child.next;
+			if (next != &p->mnt_parent->mnt_mounts)
+				break;
+			p = p->mnt_parent;
+		}
+	}
+	return list_entry(next, struct vfsmount, mnt_child);
+}
+
 static void detach_mnt(struct vfsmount *mnt, struct nameidata *old_nd)
 {
 	old_nd->dentry = mnt->mnt_mountpoint;
@@ -141,22 +157,6 @@ static void attach_mnt(struct vfsmount *
 	nd->dentry->d_mounted++;
 }
 
-static struct vfsmount *next_mnt(struct vfsmount *p, struct vfsmount *root)
-{
-	struct list_head *next = p->mnt_mounts.next;
-	if (next == &p->mnt_mounts) {
-		while (1) {
-			if (p == root)
-				return NULL;
-			next = p->mnt_child.next;
-			if (next != &p->mnt_parent->mnt_mounts)
-				break;
-			p = p->mnt_parent;
-		}
-	}
-	return list_entry(next, struct vfsmount, mnt_child);
-}
-
 /* this expects the caller to hold vfsmount_lock */
 static int can_expire(struct vfsmount *root, int offset)
 {

