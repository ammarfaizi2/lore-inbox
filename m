Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWEJQEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWEJQEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 12:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWEJQCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 12:02:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19625 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751494AbWEJQB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 12:01:56 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 03/14] NFS: Abstract out namespace initialisation [try #8]
Date: Wed, 10 May 2006 17:01:25 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060510160125.9058.23308.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com>
References: <20060510160111.9058.55026.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch abstracts out the namespace initialisation so that temporary
namespaces can be set up elsewhere.


The following changes were made in [try #8]:

 (*) init_namespace() has been made out-of-line.


Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/namespace.c            |   28 +++++++++++++++++++++-------
 include/linux/namespace.h |    1 +
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 84a3bec..6d2e8fb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1790,6 +1790,26 @@ out3:
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
@@ -1802,13 +1822,7 @@ static void __init init_mount_tree(void)
 	namespace = kmalloc(sizeof(*namespace), GFP_KERNEL);
 	if (!namespace)
 		panic("Can't allocate initial namespace");
-	atomic_set(&namespace->count, 1);
-	INIT_LIST_HEAD(&namespace->list);
-	init_waitqueue_head(&namespace->poll);
-	namespace->event = 0;
-	list_add(&mnt->mnt_list, &namespace->list);
-	namespace->root = mnt;
-	mnt->mnt_namespace = namespace;
+	init_namespace(namespace, mnt);
 
 	init_task.namespace = namespace;
 	read_lock(&tasklist_lock);
diff --git a/include/linux/namespace.h b/include/linux/namespace.h
index 3abc8e3..c371a30 100644
--- a/include/linux/namespace.h
+++ b/include/linux/namespace.h
@@ -16,6 +16,7 @@ struct namespace {
 extern int copy_namespace(int, struct task_struct *);
 extern void __put_namespace(struct namespace *namespace);
 extern struct namespace *dup_namespace(struct task_struct *, struct fs_struct *);
+extern void init_namespace(struct namespace *, struct vfsmount *);
 
 static inline void put_namespace(struct namespace *namespace)
 {

