Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWCHVOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWCHVOt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWCHVOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:14:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44995 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750860AbWCHVOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:14:48 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060308203023.25493.6137.stgit@warthog.cambridge.redhat.com> 
References: <20060308203023.25493.6137.stgit@warthog.cambridge.redhat.com>  <20060308203018.25493.23720.stgit@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com, hch@infradead.org
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] NFS: Make namespace initialisation out of line
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 08 Mar 2006 21:14:23 +0000
Message-ID: <8734.1141852463@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes the abstracted-out namespace initialisation out of
line.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 /tmp/initns.diff 
 fs/namespace.c            |   20 ++++++++++++++++++++
 include/linux/namespace.h |   16 +---------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6f13481..3466a11 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1714,6 +1714,26 @@ out3:
 	goto out2;
 }
 
+/*
+ * initialise a namespace, rooting it at the given specified mountpoint if one
+ * is given
+ */
+void init_namespace(struct namespace *namespace, struct vfsmount *mnt)
+{
+	atomic_set(&namespace->count, 1);
+	INIT_LIST_HEAD(&namespace->list);
+	init_waitqueue_head(&namespace->poll);
+	namespace->event = 0;
+	namespace->root = mnt;
+
+	if (mnt) {
+		list_add(&mnt->mnt_list, &namespace->list);
+		mnt->mnt_namespace = namespace;
+	}
+}
+
+EXPORT_SYMBOL_GPL(init_namespace);
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
diff --git a/include/linux/namespace.h b/include/linux/namespace.h
index ea6fd62..c371a30 100644
--- a/include/linux/namespace.h
+++ b/include/linux/namespace.h
@@ -16,21 +16,7 @@ struct namespace {
 extern int copy_namespace(int, struct task_struct *);
 extern void __put_namespace(struct namespace *namespace);
 extern struct namespace *dup_namespace(struct task_struct *, struct fs_struct *);
-
-static inline void init_namespace(struct namespace *namespace,
-				  struct vfsmount *mnt)
-{
-	atomic_set(&namespace->count, 1);
-	INIT_LIST_HEAD(&namespace->list);
-	init_waitqueue_head(&namespace->poll);
-	namespace->event = 0;
-	namespace->root = mnt;
-
-	if (mnt) {
-		list_add(&mnt->mnt_list, &namespace->list);
-		mnt->mnt_namespace = namespace;
-	}
-}
+extern void init_namespace(struct namespace *, struct vfsmount *);
 
 static inline void put_namespace(struct namespace *namespace)
 {

