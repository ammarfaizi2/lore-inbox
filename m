Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751895AbWCIN7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbWCIN7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 08:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWCIN7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 08:59:47 -0500
Received: from ns1.suse.de ([195.135.220.2]:51689 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751895AbWCIN7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 08:59:46 -0500
Date: Thu, 9 Mar 2006 14:59:44 +0100
From: Jan Blunck <jblunck@suse.de>
To: akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: olh@suse.de, neilb@suse.de, dev@openvz.org, bsingharora@gmail.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (2nd updated patch)
Message-ID: <20060309135943.GG4243@hasse.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is an updated version of the patch which adresses some issues that came
up during discussion.

Although sb->s_prunes usually is zero, I'm testing it now before calling
wake_up(). Besides that, the shrink_dcache_parent() is only waiting for prunes
if we are called through generic_shutdown_super() when sb->s_root is NULL.
Recently updated the comments to be more verbose about the goals of the
modification.

Original patch description:

Kirill Korotaev <dev@sw.ru> discovered a race between shrink_dcache_parent()
and shrink_dcache_memory() which leads to "Busy inodes after unmount".
When unmounting a file system shrink_dcache_parent() is racing against a
possible shrink_dcache_memory(). This might lead to the situation that
shrink_dcache_parent() is returning too early. In this situation the
super_block is destroyed before shrink_dcache_memory() could put the inode.

This patch fixes the problem through introducing a prunes counter which is
incremented when a dentry is pruned but the corresponding inoded isn't put
yet.When the prunes counter is not null, shrink_dcache_parent() is waiting and
restarting its work.

Signed-off-by: Jan Blunck <jblunck@suse.de>

--H8ygTp4AXg6deix2
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="umount-prune_one_dentry-fix.diff"

---

 fs/dcache.c        |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/super.c         |    4 ++-
 include/linux/fs.h |    3 ++
 3 files changed, 69 insertions(+), 4 deletions(-)

Index: linux-2.6/fs/dcache.c
===================================================================
--- linux-2.6.orig/fs/dcache.c
+++ linux-2.6/fs/dcache.c
@@ -364,17 +364,22 @@ restart:
  */
 static inline void prune_one_dentry(struct dentry * dentry)
 {
+	struct super_block *sb = dentry->d_sb;
 	struct dentry * parent;
 
 	__d_drop(dentry);
 	list_del(&dentry->d_u.d_child);
 	dentry_stat.nr_dentry--;	/* For d_free, below */
+	sb->s_prunes++;
 	dentry_iput(dentry);
 	parent = dentry->d_parent;
 	d_free(dentry);
 	if (parent != dentry)
 		dput(parent);
 	spin_lock(&dcache_lock);
+	sb->s_prunes--;
+	if (likely(!sb->s_prunes))
+		wake_up(&sb->s_wait_prunes);
 }
 
 /**
@@ -623,19 +628,74 @@ out:
 	return found;
 }
 
+/*
+ * A special version of wait_event(!sb->s_prunes) which takes the dcache_lock
+ * when checking the condition and gives feedback if we have waited for
+ * remaining prunes.
+ *
+ * While we are waiting for pruned dentries to iput() their inode, the
+ * sb->s_prunes count is none zero. Since the s_prunes counter is modified
+ * by prune_one_dentry() under dcache_lock, either the reference count on the
+ * parent dentry is wrong (and therefore it isn't on the lru-list yet) and we
+ * are waiting because s_prunes != 0 or the reference count is correct (and the
+ * parent dentry might be found by select_parent()) and the s_prunes == 0. This
+ * is the reason for that we have to restart loop on select_parent() and
+ * prune_dcache() as long as we are waiting on pruned dentries here (see the
+ * usage of wait_on_prunes() in shrink_dcache_parent()). This is not
+ * live-locking because we only call wait_on_prunes() if we are umounting the
+ * filesystem (sb->s_root == NULL), therefore noone is having a reference to
+ * the vfsmount structure anymore and hence shouldn't have a reference to a
+ * dentry.
+ */
+static int wait_on_prunes(struct super_block *sb)
+{
+	DEFINE_WAIT(wait);
+	int prunes_remaining = 0;
+
+#ifdef DCACHE_DEBUG
+	printk(KERN_DEBUG "%s: waiting for %d prunes\n", __FUNCTION__,
+	       sb->s_prunes);
+#endif
+
+	spin_lock(&dcache_lock);
+	for (;;) {
+		prepare_to_wait(&sb->s_wait_prunes, &wait,
+				TASK_UNINTERRUPTIBLE);
+		if (!sb->s_prunes)
+			break;
+		spin_unlock(&dcache_lock);
+		schedule();
+		prunes_remaining = 1;
+		spin_lock(&dcache_lock);
+	}
+	spin_unlock(&dcache_lock);
+	finish_wait(&sb->s_wait_prunes, &wait);
+	return prunes_remaining;
+}
+
 /**
  * shrink_dcache_parent - prune dcache
  * @parent: parent of entries to prune
  *
  * Prune the dcache to remove unused children of the parent dentry.
+ *
+ * If we have waited for a pruned dentry which parent wasn't unhashed yet,
+ * the parent will end up on the lru-list. Therefore, if we are called from
+ * generic_shutdown_super() during umount of a filesystem, we need to run
+ * select_parent() again after we waited for pruned dentries in
+ * wait_on_prunes().
+ *
+ * NOTE: Also read the comment on wait_on_prunes() above.
  */
- 
 void shrink_dcache_parent(struct dentry * parent)
 {
 	int found;
+	struct super_block *sb = parent->d_sb;
 
-	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found);
+	do {
+		while ((found = select_parent(parent)) != 0)
+			prune_dcache(found);
+	} while(!sb->s_root && wait_on_prunes(sb));
 }
 
 /**
Index: linux-2.6/fs/super.c
===================================================================
--- linux-2.6.orig/fs/super.c
+++ linux-2.6/fs/super.c
@@ -80,6 +80,8 @@ static struct super_block *alloc_super(v
 		sema_init(&s->s_dquot.dqio_sem, 1);
 		sema_init(&s->s_dquot.dqonoff_sem, 1);
 		init_rwsem(&s->s_dquot.dqptr_sem);
+		s->s_prunes = 0;
+		init_waitqueue_head(&s->s_wait_prunes);
 		init_waitqueue_head(&s->s_wait_unfrozen);
 		s->s_maxbytes = MAX_NON_LFS;
 		s->dq_op = sb_dquot_ops;
@@ -230,8 +232,8 @@ void generic_shutdown_super(struct super
 
 	if (root) {
 		sb->s_root = NULL;
-		shrink_dcache_parent(root);
 		shrink_dcache_anon(&sb->s_anon);
+		shrink_dcache_parent(root);
 		dput(root);
 		fsync_super(sb);
 		lock_super(sb);
Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h
+++ linux-2.6/include/linux/fs.h
@@ -836,6 +836,9 @@ struct super_block {
 	struct list_head	s_instances;
 	struct quota_info	s_dquot;	/* Diskquota specific options */
 
+	unsigned int		s_prunes;	/* protected by dcache_lock */
+	wait_queue_head_t	s_wait_prunes;
+
 	int			s_frozen;
 	wait_queue_head_t	s_wait_unfrozen;
 

--H8ygTp4AXg6deix2--
