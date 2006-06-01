Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965122AbWFAPI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbWFAPI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbWFAPI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:08:57 -0400
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:41939 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S965122AbWFAPI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:08:56 -0400
Date: Thu, 1 Jun 2006 11:08:52 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: linux-kernel@vger.kernel.org
Cc: John McCutchan <john@johnmccutchan.com>, Robert Love <rlove@rlove.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/5] inotify: add name's inode to event handler
Message-ID: <20060601150852.GB2171@zk3.dec.com>
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

When an inotify event includes a dentry name, also include the inode
associated with that name.

Signed-off-by: Amy Griffis <amy.griffis@hp.com>

---

 fs/inotify.c             |   13 ++++++++-----
 fs/inotify_user.c        |    3 ++-
 include/linux/fsnotify.h |   29 ++++++++++++++++-------------
 include/linux/inotify.h  |    7 ++++---
 4 files changed, 30 insertions(+), 22 deletions(-)

79525774dcbc21928de12e12e5be45ae4ca58653
diff --git a/fs/inotify.c b/fs/inotify.c
index a1bedf3..f25c218 100644
--- a/fs/inotify.c
+++ b/fs/inotify.c
@@ -232,7 +232,7 @@ static void remove_watch_no_event(struct
 static void remove_watch(struct inotify_watch *watch, struct inotify_handle *ih)
 {
 	remove_watch_no_event(watch, ih);
-	ih->in_ops->handle_event(watch, watch->wd, IN_IGNORED, 0, NULL);
+	ih->in_ops->handle_event(watch, watch->wd, IN_IGNORED, 0, NULL, NULL);
 }
 
 /* Kernel API for producing events */
@@ -275,9 +275,10 @@ void inotify_d_move(struct dentry *entry
  * @mask: event mask describing this event
  * @cookie: cookie for synchronization, or zero
  * @name: filename, if any
+ * @n_inode: inode associated with name
  */
 void inotify_inode_queue_event(struct inode *inode, u32 mask, u32 cookie,
-			       const char *name)
+			       const char *name, struct inode *n_inode)
 {
 	struct inotify_watch *watch, *next;
 
@@ -292,7 +293,8 @@ void inotify_inode_queue_event(struct in
 			mutex_lock(&ih->mutex);
 			if (watch_mask & IN_ONESHOT)
 				remove_watch_no_event(watch, ih);
-			ih->in_ops->handle_event(watch, watch->wd, mask, cookie, name);
+			ih->in_ops->handle_event(watch, watch->wd, mask, cookie,
+						 name, n_inode);
 			mutex_unlock(&ih->mutex);
 		}
 	}
@@ -323,7 +325,8 @@ void inotify_dentry_parent_queue_event(s
 	if (inotify_inode_watched(inode)) {
 		dget(parent);
 		spin_unlock(&dentry->d_lock);
-		inotify_inode_queue_event(inode, mask, cookie, name);
+		inotify_inode_queue_event(inode, mask, cookie, name,
+					  dentry->d_inode);
 		dput(parent);
 	} else
 		spin_unlock(&dentry->d_lock);
@@ -407,7 +410,7 @@ void inotify_unmount_inodes(struct list_
 			struct inotify_handle *ih= watch->ih;
 			mutex_lock(&ih->mutex);
 			ih->in_ops->handle_event(watch, watch->wd, IN_UNMOUNT, 0,
-						 NULL);
+						 NULL, NULL);
 			remove_watch(watch, ih);
 			mutex_unlock(&ih->mutex);
 		}
diff --git a/fs/inotify_user.c b/fs/inotify_user.c
index 845dc79..8b83c71 100644
--- a/fs/inotify_user.c
+++ b/fs/inotify_user.c
@@ -253,7 +253,8 @@ inotify_dev_get_event(struct inotify_dev
  * Can sleep (calls kernel_event()).
  */
 static void inotify_dev_queue_event(struct inotify_watch *w, u32 wd, u32 mask,
-				    u32 cookie, const char *name)
+				    u32 cookie, const char *name,
+				    struct inode *ignored)
 {
 	struct inotify_user_watch *watch;
 	struct inotify_device *dev;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 11438ef..a9d3044 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -54,16 +54,18 @@ static inline void fsnotify_move(struct 
 
 	if (isdir)
 		isdir = IN_ISDIR;
-	inotify_inode_queue_event(old_dir, IN_MOVED_FROM|isdir,cookie,old_name);
-	inotify_inode_queue_event(new_dir, IN_MOVED_TO|isdir, cookie, new_name);
+	inotify_inode_queue_event(old_dir, IN_MOVED_FROM|isdir,cookie,old_name,
+				  source);
+	inotify_inode_queue_event(new_dir, IN_MOVED_TO|isdir, cookie, new_name,
+				  source);
 
 	if (target) {
-		inotify_inode_queue_event(target, IN_DELETE_SELF, 0, NULL);
+		inotify_inode_queue_event(target, IN_DELETE_SELF, 0, NULL, NULL);
 		inotify_inode_is_dead(target);
 	}
 
 	if (source) {
-		inotify_inode_queue_event(source, IN_MOVE_SELF, 0, NULL);
+		inotify_inode_queue_event(source, IN_MOVE_SELF, 0, NULL, NULL);
 	}
 	audit_inode_child(old_name, source, old_dir->i_ino);
 	audit_inode_child(new_name, target, new_dir->i_ino);
@@ -85,7 +87,7 @@ static inline void fsnotify_nameremove(s
  */
 static inline void fsnotify_inoderemove(struct inode *inode)
 {
-	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL);
+	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL, NULL);
 	inotify_inode_is_dead(inode);
 }
 
@@ -95,7 +97,8 @@ static inline void fsnotify_inoderemove(
 static inline void fsnotify_create(struct inode *inode, struct dentry *dentry)
 {
 	inode_dir_notify(inode, DN_CREATE);
-	inotify_inode_queue_event(inode, IN_CREATE, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, IN_CREATE, 0, dentry->d_name.name,
+				  dentry->d_inode);
 	audit_inode_child(dentry->d_name.name, dentry->d_inode, inode->i_ino);
 }
 
@@ -106,7 +109,7 @@ static inline void fsnotify_mkdir(struct
 {
 	inode_dir_notify(inode, DN_CREATE);
 	inotify_inode_queue_event(inode, IN_CREATE | IN_ISDIR, 0, 
-				  dentry->d_name.name);
+				  dentry->d_name.name, dentry->d_inode);
 	audit_inode_child(dentry->d_name.name, dentry->d_inode, inode->i_ino);
 }
 
@@ -123,7 +126,7 @@ static inline void fsnotify_access(struc
 
 	dnotify_parent(dentry, DN_ACCESS);
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
-	inotify_inode_queue_event(inode, mask, 0, NULL);
+	inotify_inode_queue_event(inode, mask, 0, NULL, NULL);
 }
 
 /*
@@ -139,7 +142,7 @@ static inline void fsnotify_modify(struc
 
 	dnotify_parent(dentry, DN_MODIFY);
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
-	inotify_inode_queue_event(inode, mask, 0, NULL);
+	inotify_inode_queue_event(inode, mask, 0, NULL, NULL);
 }
 
 /*
@@ -154,7 +157,7 @@ static inline void fsnotify_open(struct 
 		mask |= IN_ISDIR;
 
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
-	inotify_inode_queue_event(inode, mask, 0, NULL);	
+	inotify_inode_queue_event(inode, mask, 0, NULL, NULL);
 }
 
 /*
@@ -172,7 +175,7 @@ static inline void fsnotify_close(struct
 		mask |= IN_ISDIR;
 
 	inotify_dentry_parent_queue_event(dentry, mask, 0, name);
-	inotify_inode_queue_event(inode, mask, 0, NULL);
+	inotify_inode_queue_event(inode, mask, 0, NULL, NULL);
 }
 
 /*
@@ -187,7 +190,7 @@ static inline void fsnotify_xattr(struct
 		mask |= IN_ISDIR;
 
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
-	inotify_inode_queue_event(inode, mask, 0, NULL);
+	inotify_inode_queue_event(inode, mask, 0, NULL, NULL);
 }
 
 /*
@@ -234,7 +237,7 @@ static inline void fsnotify_change(struc
 	if (in_mask) {
 		if (S_ISDIR(inode->i_mode))
 			in_mask |= IN_ISDIR;
-		inotify_inode_queue_event(inode, in_mask, 0, NULL);
+		inotify_inode_queue_event(inode, in_mask, 0, NULL, NULL);
 		inotify_dentry_parent_queue_event(dentry, in_mask, 0,
 						  dentry->d_name.name);
 	}
diff --git a/include/linux/inotify.h b/include/linux/inotify.h
index 68b6e01..e7899e7 100644
--- a/include/linux/inotify.h
+++ b/include/linux/inotify.h
@@ -91,7 +91,7 @@ struct inotify_watch {
 
 struct inotify_operations {
 	void (*handle_event)(struct inotify_watch *, u32, u32, u32,
-			     const char *);
+			     const char *, struct inode *);
 	void (*destroy_watch)(struct inotify_watch *);
 };
 
@@ -102,7 +102,7 @@ #ifdef CONFIG_INOTIFY
 extern void inotify_d_instantiate(struct dentry *, struct inode *);
 extern void inotify_d_move(struct dentry *);
 extern void inotify_inode_queue_event(struct inode *, __u32, __u32,
-				      const char *);
+				      const char *, struct inode *);
 extern void inotify_dentry_parent_queue_event(struct dentry *, __u32, __u32,
 					      const char *);
 extern void inotify_unmount_inodes(struct list_head *);
@@ -134,7 +134,8 @@ static inline void inotify_d_move(struct
 
 static inline void inotify_inode_queue_event(struct inode *inode,
 					     __u32 mask, __u32 cookie,
-					     const char *filename)
+					     const char *filename,
+					     struct inode *n_inode)
 {
 }
 
-- 
1.3.0

