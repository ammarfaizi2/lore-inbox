Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422661AbWBVUWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWBVUWW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422659AbWBVUWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:22:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17864 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751424AbWBVUWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:22:02 -0500
Date: Wed, 22 Feb 2006 20:21:46 GMT
Message-Id: <200602222021.k1MKLkRx028347@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-fsdevel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 3/5] NFS: Abstract out namespace initialisation
In-Reply-To: <dhowells1140639702@warthog.cambridge.redhat.com>
References: <dhowells1140639702@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch abstracts out the namespace initialisation so that temporary
namespaces can be set up elsewhere.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 init-namespace-2616rc4.diff
 fs/namespace.c            |    8 +-------
 include/linux/namespace.h |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff -uNrp linux-2.6.16-rc4-getsb/include/linux/namespace.h linux-2.6.16-rc4-getsb-nfs/include/linux/namespace.h
--- linux-2.6.16-rc4-getsb/include/linux/namespace.h	2006-02-22 17:00:42.000000000 +0000
+++ linux-2.6.16-rc4-getsb-nfs/include/linux/namespace.h	2006-02-22 17:37:04.000000000 +0000
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
diff -uNrp linux-2.6.16-rc4-getsb/fs/namespace.c linux-2.6.16-rc4-getsb-nfs/fs/namespace.c
--- linux-2.6.16-rc4-getsb/fs/namespace.c	2006-02-22 17:00:37.000000000 +0000
+++ linux-2.6.16-rc4-getsb-nfs/fs/namespace.c	2006-02-22 18:21:52.000000000 +0000
@@ -1679,13 +1679,7 @@ static void __init init_mount_tree(void)
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
