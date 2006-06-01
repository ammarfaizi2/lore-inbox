Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWFAPKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWFAPKM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWFAPKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:10:12 -0400
Received: from palrel12.hp.com ([156.153.255.237]:17132 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S1030192AbWFAPKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:10:08 -0400
Date: Thu, 1 Jun 2006 11:10:04 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: linux-kernel@vger.kernel.org
Cc: John McCutchan <john@johnmccutchan.com>, Robert Love <rlove@rlove.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/5] inotify: add interfaces to kernel API
Message-ID: <20060601151004.GA2214@zk3.dec.com>
References: <20060601150702.GA2171@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601150702.GA2171@zk3.dec.com>
X-Mailer: Mutt http://www.mutt.org/
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add inotify_init_watch() so caller can use inotify_watch refcounts
before calling inotify_add_watch().

Add inotify_find_watch() to find an existing watch for an (ih,inode)
pair.  This is similar to inotify_find_update_watch(), but does not
update the watch's mask if one is found.

Add inotify_rm_watch() to remove a watch via the watch pointer instead
of the watch descriptor.

Signed-off-by: Amy Griffis <amy.griffis@hp.com>

---

 fs/inotify.c            |   64 +++++++++++++++++++++++++++++++++++++++++++----
 fs/inotify_user.c       |    1 +
 include/linux/inotify.h |   20 +++++++++++++++
 3 files changed, 79 insertions(+), 6 deletions(-)

48dcb4a1afcdac08fd85b4bf6e7a5600afd33e94
diff --git a/fs/inotify.c b/fs/inotify.c
index f25c218..8477c4f 100644
--- a/fs/inotify.c
+++ b/fs/inotify.c
@@ -468,6 +468,19 @@ struct inotify_handle *inotify_init(cons
 EXPORT_SYMBOL_GPL(inotify_init);
 
 /**
+ * inotify_init_watch - initialize an inotify watch
+ * @watch: watch to initialize
+ */
+void inotify_init_watch(struct inotify_watch *watch)
+{
+	INIT_LIST_HEAD(&watch->h_list);
+	INIT_LIST_HEAD(&watch->i_list);
+	atomic_set(&watch->count, 0);
+	get_inotify_watch(watch); /* initial get */
+}
+EXPORT_SYMBOL_GPL(inotify_init_watch);
+
+/**
  * inotify_destroy - clean up and destroy an inotify instance
  * @ih: inotify handle
  */
@@ -515,6 +528,37 @@ void inotify_destroy(struct inotify_hand
 EXPORT_SYMBOL_GPL(inotify_destroy);
 
 /**
+ * inotify_find_watch - find an existing watch for an (ih,inode) pair
+ * @ih: inotify handle
+ * @inode: inode to watch
+ * @watchp: pointer to existing inotify_watch
+ *
+ * Caller must pin given inode (via nameidata).
+ */
+s32 inotify_find_watch(struct inotify_handle *ih, struct inode *inode,
+		       struct inotify_watch **watchp)
+{
+	struct inotify_watch *old;
+	int ret = -ENOENT;
+
+	mutex_lock(&inode->inotify_mutex);
+	mutex_lock(&ih->mutex);
+
+	old = inode_find_handle(inode, ih);
+	if (unlikely(old)) {
+		get_inotify_watch(old); /* caller must put watch */
+		*watchp = old;
+		ret = old->wd;
+	}
+
+	mutex_unlock(&ih->mutex);
+	mutex_unlock(&inode->inotify_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(inotify_find_watch);
+
+/**
  * inotify_find_update_watch - find and update the mask of an existing watch
  * @ih: inotify handle
  * @inode: inode's watch to update
@@ -593,10 +637,6 @@ s32 inotify_add_watch(struct inotify_han
 		goto out;
 	ret = watch->wd;
 
-	atomic_set(&watch->count, 0);
-	INIT_LIST_HEAD(&watch->h_list);
-	INIT_LIST_HEAD(&watch->i_list);
-
 	/* save a reference to handle and bump the count to make it official */
 	get_inotify_handle(ih);
 	watch->ih = ih;
@@ -607,8 +647,6 @@ s32 inotify_add_watch(struct inotify_han
 	 */
 	watch->inode = igrab(inode);
 
-	get_inotify_watch(watch); /* initial get */
-
 	if (!inotify_inode_watched(inode))
 		set_dentry_child_flags(inode, 1);
 
@@ -659,6 +697,20 @@ int inotify_rm_wd(struct inotify_handle 
 }
 EXPORT_SYMBOL_GPL(inotify_rm_wd);
 
+/**
+ * inotify_rm_watch - remove a watch from an inotify instance
+ * @ih: inotify handle
+ * @watch: watch to remove
+ *
+ * Can sleep.
+ */
+int inotify_rm_watch(struct inotify_handle *ih,
+		     struct inotify_watch *watch)
+{
+	return inotify_rm_wd(ih, watch->wd);
+}
+EXPORT_SYMBOL_GPL(inotify_rm_watch);
+
 /*
  * inotify_setup - core initialization function
  */
diff --git a/fs/inotify_user.c b/fs/inotify_user.c
index 8b83c71..9e9931e 100644
--- a/fs/inotify_user.c
+++ b/fs/inotify_user.c
@@ -380,6 +380,7 @@ static int create_watch(struct inotify_d
 
 	atomic_inc(&dev->user->inotify_watches);
 
+	inotify_init_watch(&watch->wdata);
 	ret = inotify_add_watch(dev->ih, &watch->wdata, inode, mask);
 	if (ret < 0)
 		free_inotify_user_watch(&watch->wdata);
diff --git a/include/linux/inotify.h b/include/linux/inotify.h
index e7899e7..e7e7fb7 100644
--- a/include/linux/inotify.h
+++ b/include/linux/inotify.h
@@ -112,11 +112,15 @@ extern u32 inotify_get_cookie(void);
 /* Kernel Consumer API */
 
 extern struct inotify_handle *inotify_init(const struct inotify_operations *);
+extern void inotify_init_watch(struct inotify_watch *);
 extern void inotify_destroy(struct inotify_handle *);
+extern __s32 inotify_find_watch(struct inotify_handle *, struct inode *,
+				struct inotify_watch **);
 extern __s32 inotify_find_update_watch(struct inotify_handle *, struct inode *,
 				       u32);
 extern __s32 inotify_add_watch(struct inotify_handle *, struct inotify_watch *,
 			       struct inode *, __u32);
+extern int inotify_rm_watch(struct inotify_handle *, struct inotify_watch *);
 extern int inotify_rm_wd(struct inotify_handle *, __u32);
 extern void get_inotify_watch(struct inotify_watch *);
 extern void put_inotify_watch(struct inotify_watch *);
@@ -163,10 +167,20 @@ static inline struct inotify_handle *ino
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline void inotify_init_watch(struct inotify_watch *watch)
+{
+}
+
 static inline void inotify_destroy(struct inotify_handle *ih)
 {
 }
 
+static inline __s32 inotify_find_watch(struct inotify_handle *ih, struct inode *inode,
+				       struct inotify_watch **watchp)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline __s32 inotify_find_update_watch(struct inotify_handle *ih,
 					      struct inode *inode, u32 mask)
 {
@@ -180,6 +194,12 @@ static inline __s32 inotify_add_watch(st
 	return -EOPNOTSUPP;
 }
 
+static inline int inotify_rm_watch(struct inotify_handle *ih,
+				   struct inotify_watch *watch)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int inotify_rm_wd(struct inotify_handle *ih, __u32 wd)
 {
 	return -EOPNOTSUPP;
-- 
1.3.0

