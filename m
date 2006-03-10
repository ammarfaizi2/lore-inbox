Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWCJMB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWCJMB5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 07:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWCJMB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 07:01:57 -0500
Received: from cantor.suse.de ([195.135.220.2]:46038 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750710AbWCJMB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 07:01:56 -0500
From: Neil Brown <neilb@suse.de>
To: Jan Blunck <jblunck@suse.de>
Date: Fri, 10 Mar 2006 22:51:08 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17425.26668.678359.918399@cse.unsw.edu.au>
Cc: Kirill Korotaev <dev@openvz.org>, akpm@osdl.org, viro@zeniv.linux.org.uk,
       olh@suse.de, bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory() race (3rd updated patch)]
In-Reply-To: message from Jan Blunck on Friday March 10
References: <20060309165833.GK4243@hasse.suse.de>
	<441060D2.6090800@openvz.org>
	<17425.2594.967505.22336@cse.unsw.edu.au>
	<441138B7.9060809@sw.ru>
	<20060310105950.GL4243@hasse.suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 10, jblunck@suse.de wrote:
> On Fri, Mar 10, Kirill Korotaev wrote:
> 
> > >I really think that we need to stop prune_one_dentry from being called
> > >on dentries for a filesystem that is being unmounted.  With that code
> > >currently in -git, that means passing a 'struct super_block *' into
> > >prune_dcache so that it ignores any filesystem with ->s_root==NULL
> > >unless that filesystem is the filesystem that was passed.
> > Can try...
> > 
> 
> Can not ... because of down_read(s_umount) before checking s_root :(

Sorry, I don't follow your logic.  Could you elaborate a bit please?

> 
> So what do we do now?
> 
>  1. always get the reference counting right outside of dcache_lock

This is possible, but I think it is a very intrusive patch.

> 
>  2. hack around with different paths for prune_dcache() when called from
>     shrink_dcache_memory() and shrink_dcache_parent()

I don't think the paths are very different.

The following patch is against 2.6.16-rc5-git14, is based on yours,
and avoids calling prune_one_dentry at inconvenient times.

Differences:
  - use waitqueue_active to decide whether to call wake_up
  - pass a 'struct super_block *' to prune_dcache when appropriate,
    and do not try to prune dentries for any other filesystem
    which has ->s_root == NULL
  - pass sb to shink_dcache_anon instead of &sb->s_anon.
  - Don't return a value from  wait_on_prunes
  - Call wait_on_prunes *before* shrink_dcache_{anon,parent}

I am fairly sure that this will do the right thing.

NeilBrown



Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/dcache.c            |   25 ++++++++++++++++++-------
 ./fs/super.c             |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
 ./include/linux/dcache.h |    2 +-
 ./include/linux/fs.h     |    3 +++
 4 files changed, 68 insertions(+), 9 deletions(-)

diff ./fs/dcache.c~current~ ./fs/dcache.c
--- ./fs/dcache.c~current~	2006-03-10 22:24:03.000000000 +1100
+++ ./fs/dcache.c	2006-03-10 22:39:07.000000000 +1100
@@ -361,20 +361,28 @@ restart:
  * This requires that the LRU list has already been
  * removed.
  * Called with dcache_lock, drops it and then regains.
+ *
+ * Wakes up any pending waiters (see wait_on_prunes()) if the
+ * dentry's filesystem is being umounted.
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
+	if (waitqueue_active(&sb->s_wait_prunes))
+		wake_up(&sb->s_wait_prunes);
 }
 
 /**
@@ -390,7 +398,7 @@ static inline void prune_one_dentry(stru
  * all the dentries are in use.
  */
  
-static void prune_dcache(int count)
+static void prune_dcache(int count, struct super_block *sb)
 {
 	spin_lock(&dcache_lock);
 	for (; count ; count--) {
@@ -417,8 +425,10 @@ static void prune_dcache(int count)
  			spin_unlock(&dentry->d_lock);
 			continue;
 		}
-		/* If the dentry was recently referenced, don't free it. */
-		if (dentry->d_flags & DCACHE_REFERENCED) {
+		/* If the dentry was recently referenced, or is for
+		 * a unmounting filesystem, don't free it. */
+		if ((dentry->d_flags & DCACHE_REFERENCED) ||
+		    (dentry->d_sb != sb && dentry->d_sb->s_root == NULL)) {
 			dentry->d_flags &= ~DCACHE_REFERENCED;
  			list_add(&dentry->d_lru, &dentry_unused);
  			dentry_stat.nr_unused++;
@@ -635,7 +645,7 @@ void shrink_dcache_parent(struct dentry 
 	int found;
 
 	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found);
+		prune_dcache(found, parent->d_sb);
 }
 
 /**
@@ -648,8 +658,9 @@ void shrink_dcache_parent(struct dentry 
  * done under dcache_lock.
  *
  */
-void shrink_dcache_anon(struct hlist_head *head)
+void shrink_dcache_anon(struct super_block *sb)
 {
+	struct hlist_head = &sb->s_anon;
 	struct hlist_node *lp;
 	int found;
 	do {
@@ -673,7 +684,7 @@ void shrink_dcache_anon(struct hlist_hea
 			}
 		}
 		spin_unlock(&dcache_lock);
-		prune_dcache(found);
+		prune_dcache(found, sb);
 	} while(found);
 }
 
@@ -694,7 +705,7 @@ static int shrink_dcache_memory(int nr, 
 	if (nr) {
 		if (!(gfp_mask & __GFP_FS))
 			return -1;
-		prune_dcache(nr);
+		prune_dcache(nr, NULL);
 	}
 	return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
 }

diff ./fs/super.c~current~ ./fs/super.c
--- ./fs/super.c~current~	2006-03-10 22:24:03.000000000 +1100
+++ ./fs/super.c	2006-03-10 22:37:14.000000000 +1100
@@ -80,6 +80,8 @@ static struct super_block *alloc_super(v
 		sema_init(&s->s_dquot.dqio_sem, 1);
 		sema_init(&s->s_dquot.dqonoff_sem, 1);
 		init_rwsem(&s->s_dquot.dqptr_sem);
+		s->s_prunes = 0;
+		init_waitqueue_head(&s->s_wait_prunes);
 		init_waitqueue_head(&s->s_wait_unfrozen);
 		s->s_maxbytes = MAX_NON_LFS;
 		s->dq_op = sb_dquot_ops;
@@ -213,6 +215,40 @@ static int grab_super(struct super_block
 	return 0;
 }
 
+/*
+ * A special version of wait_event(!sb->s_prunes) which takes the dcache_lock
+ * when checking the condition.
+ *
+ * While we are waiting for pruned dentries to iput() their inode, the
+ * sb->s_prunes count is non-zero. Since the s_prunes counter is modified
+ * by prune_one_dentry() under dcache_lock, either the reference count on the
+ * parent dentry is wrong (and therefore it isn't on the lru-list yet) and we
+ * are waiting because s_prunes != 0 or the reference count is correct (and the
+ * parent dentry might be found by select_parent()) and the s_prunes == 0.
+ */
+static void wait_on_prunes(struct super_block *sb)
+{
+	DEFINE_WAIT(wait);
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
+		spin_lock(&dcache_lock);
+	}
+	spin_unlock(&dcache_lock);
+	finish_wait(&sb->s_wait_prunes, &wait);
+}
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
@@ -230,8 +266,17 @@ void generic_shutdown_super(struct super
 
 	if (root) {
 		sb->s_root = NULL;
+
+		wait_on_prunes(sb);
+		/* At this point no dentries in this filesystem will be
+		 * in the process of being pruned by shrink_dcache_memory
+		 * (or anyone else), so no dentries should have external
+		 * references, so shrink_dcache_anon and
+		 * shrink_dcache_parent should find and free them all
+		 */
+		shrink_dcache_anon(sb);
 		shrink_dcache_parent(root);
-		shrink_dcache_anon(&sb->s_anon);
+
 		dput(root);
 		fsync_super(sb);
 		lock_super(sb);

diff ./include/linux/dcache.h~current~ ./include/linux/dcache.h
--- ./include/linux/dcache.h~current~	2006-03-10 22:37:37.000000000 +1100
+++ ./include/linux/dcache.h	2006-03-10 22:37:55.000000000 +1100
@@ -215,7 +215,7 @@ extern struct dentry * d_alloc_anon(stru
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
-extern void shrink_dcache_anon(struct hlist_head *);
+extern void shrink_dcache_anon(struct super_block *);
 extern int d_invalidate(struct dentry *);
 
 /* only used at mount-time */

diff ./include/linux/fs.h~current~ ./include/linux/fs.h
--- ./include/linux/fs.h~current~	2006-03-10 22:24:03.000000000 +1100
+++ ./include/linux/fs.h	2006-03-10 22:24:03.000000000 +1100
@@ -836,6 +836,9 @@ struct super_block {
 	struct list_head	s_instances;
 	struct quota_info	s_dquot;	/* Diskquota specific options */
 
+	unsigned int		s_prunes;	/* protected by dcache_lock */
+	wait_queue_head_t	s_wait_prunes;
+
 	int			s_frozen;
 	wait_queue_head_t	s_wait_unfrozen;
 
