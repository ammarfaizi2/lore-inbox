Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWFAPKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWFAPKm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWFAPKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:10:41 -0400
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:55764 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S1030193AbWFAPKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:10:38 -0400
Date: Thu, 1 Jun 2006 11:10:37 -0400
From: Amy Griffis <amy.griffis@hp.com>
To: linux-kernel@vger.kernel.org
Cc: John McCutchan <john@johnmccutchan.com>, Robert Love <rlove@rlove.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/5] inotify: allow watch removal from event handler
Message-ID: <20060601151037.GB2214@zk3.dec.com>
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

Allow callers to remove watches from their event handler via
inotify_remove_watch_locked().  This functionality can be used to
achieve IN_ONESHOT-like functionality for a subset of events in the
mask.

Signed-off-by: Amy Griffis <amy.griffis@hp.com>

---

 fs/inotify.c            |   23 ++++++++++++++---------
 include/linux/inotify.h |    7 +++++++
 2 files changed, 21 insertions(+), 9 deletions(-)

3c6aadc67eed3796ce0b3fdbf7b47ce1469a0123
diff --git a/fs/inotify.c b/fs/inotify.c
index 8477c4f..723836a 100644
--- a/fs/inotify.c
+++ b/fs/inotify.c
@@ -207,7 +207,7 @@ static struct inotify_watch *inode_find_
 }
 
 /*
- * remove_watch_no_event - remove_watch() without the IN_IGNORED event.
+ * remove_watch_no_event - remove watch without the IN_IGNORED event.
  *
  * Callers must hold both inode->inotify_mutex and ih->mutex.
  */
@@ -223,17 +223,22 @@ static void remove_watch_no_event(struct
 	idr_remove(&ih->idr, watch->wd);
 }
 
-/*
- * remove_watch - Remove a watch from both the handle and the inode.  Sends
- * the IN_IGNORED event signifying that the inode is no longer watched.
+/**
+ * inotify_remove_watch_locked - Remove a watch from both the handle and the
+ * inode.  Sends the IN_IGNORED event signifying that the inode is no longer
+ * watched.  May be invoked from a caller's event handler.
+ * @ih: inotify handle associated with watch
+ * @watch: watch to remove
  *
  * Callers must hold both inode->inotify_mutex and ih->mutex.
  */
-static void remove_watch(struct inotify_watch *watch, struct inotify_handle *ih)
+void inotify_remove_watch_locked(struct inotify_handle *ih,
+				 struct inotify_watch *watch)
 {
 	remove_watch_no_event(watch, ih);
 	ih->in_ops->handle_event(watch, watch->wd, IN_IGNORED, 0, NULL, NULL);
 }
+EXPORT_SYMBOL_GPL(inotify_remove_watch_locked);
 
 /* Kernel API for producing events */
 
@@ -378,7 +383,7 @@ void inotify_unmount_inodes(struct list_
 
 		need_iput_tmp = need_iput;
 		need_iput = NULL;
-		/* In case the remove_watch() drops a reference. */
+		/* In case inotify_remove_watch_locked() drops a reference. */
 		if (inode != need_iput_tmp)
 			__iget(inode);
 		else
@@ -411,7 +416,7 @@ void inotify_unmount_inodes(struct list_
 			mutex_lock(&ih->mutex);
 			ih->in_ops->handle_event(watch, watch->wd, IN_UNMOUNT, 0,
 						 NULL, NULL);
-			remove_watch(watch, ih);
+			inotify_remove_watch_locked(ih, watch);
 			mutex_unlock(&ih->mutex);
 		}
 		mutex_unlock(&inode->inotify_mutex);
@@ -434,7 +439,7 @@ void inotify_inode_is_dead(struct inode 
 	list_for_each_entry_safe(watch, next, &inode->inotify_watches, i_list) {
 		struct inotify_handle *ih = watch->ih;
 		mutex_lock(&ih->mutex);
-		remove_watch(watch, ih);
+		inotify_remove_watch_locked(ih, watch);
 		mutex_unlock(&ih->mutex);
 	}
 	mutex_unlock(&inode->inotify_mutex);
@@ -687,7 +692,7 @@ int inotify_rm_wd(struct inotify_handle 
 
 	/* make sure that we did not race */
 	if (likely(idr_find(&ih->idr, wd) == watch))
-		remove_watch(watch, ih);
+		inotify_remove_watch_locked(ih, watch);
 
 	mutex_unlock(&ih->mutex);
 	mutex_unlock(&inode->inotify_mutex);
diff --git a/include/linux/inotify.h b/include/linux/inotify.h
index e7e7fb7..d4f48c6 100644
--- a/include/linux/inotify.h
+++ b/include/linux/inotify.h
@@ -122,6 +122,8 @@ extern __s32 inotify_add_watch(struct in
 			       struct inode *, __u32);
 extern int inotify_rm_watch(struct inotify_handle *, struct inotify_watch *);
 extern int inotify_rm_wd(struct inotify_handle *, __u32);
+extern void inotify_remove_watch_locked(struct inotify_handle *,
+					struct inotify_watch *);
 extern void get_inotify_watch(struct inotify_watch *);
 extern void put_inotify_watch(struct inotify_watch *);
 
@@ -205,6 +207,11 @@ static inline int inotify_rm_wd(struct i
 	return -EOPNOTSUPP;
 }
 
+static inline void inotify_remove_watch_locked(struct inotify_handle *ih,
+					       struct inotify_watch *watch)
+{
+}
+
 static inline void get_inotify_watch(struct inotify_watch *watch)
 {
 }
-- 
1.3.0

