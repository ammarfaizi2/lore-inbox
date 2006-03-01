Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWCASni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWCASni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWCASni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:43:38 -0500
Received: from mx1.suse.de ([195.135.220.2]:60612 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932089AbWCASnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:43:37 -0500
Date: Wed, 1 Mar 2006 19:43:35 +0100
From: Jan Blunck <jblunck@suse.de>
To: akpm@osdl.org
Cc: dev@sw.ru, linux-kernel@vger.kernel.org
Subject: [PATCH,RESUBMIT] Fix shrink_dcache_parent() against shrink_dcache_memory() race
Message-ID: <20060301184335.GD31712@hasse.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

---

--WplhKdTI2c8ulnbP
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="umount-prune_one_dentry-fix.diff"


 fs/dcache.c        |   38 ++++++++++++++++++++++++++++++++++++++
 fs/super.c         |    4 +++-
 include/linux/fs.h |    3 +++
 3 files changed, 44 insertions(+), 1 deletion(-)

Index: linux-2.6/fs/dcache.c
===================================================================
--- linux-2.6.orig/fs/dcache.c
+++ linux-2.6/fs/dcache.c
@@ -364,17 +364,21 @@ restart:
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
+	wake_up(&sb->s_wait_prunes);
 }
 
 /**
@@ -623,6 +627,36 @@ out:
 	return found;
 }
 
+static int wait_on_prunes(struct super_block *sb)
+{
+	DEFINE_WAIT(wait);
+
+	spin_lock(&dcache_lock);
+	if (!sb->s_prunes) {
+		spin_unlock(&dcache_lock);
+		return 0;
+	}
+
+#ifdef DCACHE_DEBUG
+	printk(KERN_DEBUG "%s: waiting for %d prunes\n", __FUNCTION__,
+	       sb->s_prunes);
+#endif
+
+	while (1) {
+		prepare_to_wait(&sb->s_wait_prunes, &wait,
+				TASK_UNINTERRUPTIBLE);
+		if (!sb->s_prunes)
+			break;
+		spin_unlock(&dcache_lock);
+		schedule();
+		spin_lock(&dcache_lock);
+	}
+
+	finish_wait(&sb->s_wait_prunes, &wait);
+	spin_unlock(&dcache_lock);
+	return 1;
+}
+
 /**
  * shrink_dcache_parent - prune dcache
  * @parent: parent of entries to prune
@@ -634,8 +668,12 @@ void shrink_dcache_parent(struct dentry 
 {
 	int found;
 
+ again:
 	while ((found = select_parent(parent)) != 0)
 		prune_dcache(found);
+
+	if (wait_on_prunes(parent->d_sb))
+		goto again;
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
@@ -835,6 +835,9 @@ struct super_block {
 	struct list_head	s_instances;
 	struct quota_info	s_dquot;	/* Diskquota specific options */
 
+	unsigned int		s_prunes;	/* protected by dcache_lock */
+	wait_queue_head_t	s_wait_prunes;
+
 	int			s_frozen;
 	wait_queue_head_t	s_wait_unfrozen;
 

--WplhKdTI2c8ulnbP--
