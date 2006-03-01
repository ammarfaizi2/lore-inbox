Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWCAVhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWCAVhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWCAVhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:37:16 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:1449 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751277AbWCAVhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:37:14 -0500
Message-ID: <440613FF.4040807@vilain.net>
Date: Thu, 02 Mar 2006 10:37:03 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>
Subject: [Fwd: [PATCH 3/5] NFS: Abstract out namespace initialisation [try
 #2]]
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch abstracts out the namespace initialisation so that 
temporary namespaces can be set up elsewhere.

Signed-Off-By: David Howells <dhowells@redhat.com>
Acked-By: Sam Vilain <sam.vilain@catalyst.net.nz>
---
David,

This looks sane to me, thought I'd just quickly ack it as I'm also doing 
work in this area... it seems a lot of what you're doing is cleaning up 
the boundaries between VFS and FS - did you get a chance to review the 
patch Herbert Pötzl sent to the list about the permission() cleanup?

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
  extern struct namespace *dup_namespace(struct task_struct *, struct 
fs_struct *);

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

