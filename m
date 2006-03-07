Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752153AbWCGLeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbWCGLeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 06:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbWCGLeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 06:34:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47781 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750759AbWCGLeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 06:34:12 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/6] NFS: Abstract out namespace initialisation [try #6]
Date: Tue, 07 Mar 2006 11:33:57 +0000
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060307113357.23330.4136.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060307113352.23330.80913.stgit@warthog.cambridge.redhat.com>
References: <20060307113352.23330.80913.stgit@warthog.cambridge.redhat.com>
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
index 8f96212..6f13481 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1726,13 +1726,7 @@ static void __init init_mount_tree(void)
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

