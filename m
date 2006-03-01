Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWCARgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWCARgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 12:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWCARgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 12:36:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16080 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932409AbWCARgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 12:36:40 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/5] NFS: Abstract out namespace initialisation [try #2]
Date: Wed, 01 Mar 2006 17:36:26 +0000
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060301173626.16639.89127.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060301173617.16639.83553.stgit@warthog.cambridge.redhat.com>
References: <20060301173617.16639.83553.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch abstracts out the namespace initialisation so that temporary
namespaces can be set up elsewhere.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/namespace.c            |    8 +-------
 include/linux/namespace.h |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 51d3ebc..0194538 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1688,13 +1688,7 @@ static void __init init_mount_tree(void)
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
index 3abc8e3..ea6fd62 100644
--- a/include/linux/namespace.h
+++ b/include/linux/namespace.h
@@ -17,6 +17,21 @@ extern int copy_namespace(int, struct ta
 extern void __put_namespace(struct namespace *namespace);
 extern struct namespace *dup_namespace(struct task_struct *, struct fs_struct *);
 
+static inline void init_namespace(struct namespace *namespace,
+				  struct vfsmount *mnt)
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
 static inline void put_namespace(struct namespace *namespace)
 {
 	if (atomic_dec_and_lock(&namespace->count, &vfsmount_lock))

