Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWDDBHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWDDBHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 21:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWDDBHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 21:07:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:12522 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964939AbWDDBHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 21:07:02 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 4 Apr 2006 11:05:06 +1000
Message-Id: <1060404010506.27391@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org
Cc: Jan Blunck <jblunck@suse.de>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Olaf Hering <olh@suse.de>
Cc: Balbir Singh <balbir@in.ibm.com>
Subject: [PATCH] Fix dcache race during umount
References: <20060404110351.27364.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying again after some useful comments from Balbir.
Note: the change to prune_dcache looks quite different now.

NeilBrown

### Comments for Changeset

The race is that the shrink_dcache_memory shrinker could get called
while a filesystem is being unmounted, and could try to prune
a dentry belonging to that filesystem.

If it does, then it will call in to iput on the inode while the
dentry is no longer able to be found by the umounting process.  If
iput takes a while, generic_shutdown_super could get all the way
though shrink_dcache_parent and shrink_dcache_anon and
invalidate_inodes without ever waiting on this particular inode.

Eventually the superblock gets freed anyway and if the iput tried to
touch it (which some filesystems certainly do), it will lose.  The
promised "Self-destruct in 5 seconds" doesn't lead to a nice day.

The race is closed by holding s_umount while calling prune_one_dentry
on someone else's dentry.  As a down_read_trylock is used,
shrink_dcache_memory will no longer try to prune the dentry of a
filesystem that is being unmounted, and unmount will not be able to
start until any such active prune_one_dentry completes.

This requires that prune_dcache *knows* which filesystem (if any) it
is doing the prune on behalf of so that it can be careful of other
filesystems.  shrink_dcache_memory isn't called it on behalf of any
filesystem, and so is careful of everything.

shrink_dcache_anon is now passed a super_block rather than the s_anon
list out of the superblock, so it can get the s_anon list itself, and
can pass the superblock down to prune_dcache.

If prune_dcache finds a dentry that it cannot free, it leaves it where
it is (at the tail of the list) and exits, on the assumption that some
other thread will be removing that dentry soon.  To try to make sure
that some work gets done, a limited number of dnetries which are
untouchable are skipped over while choosing the dentry to work on.

I believe this race was first found by Kirill Korotaev.

Cc: Jan Blunck <jblunck@suse.de>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Olaf Hering <olh@suse.de>
Cc: Balbir Singh <balbir@in.ibm.com>

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/dcache.c            |   62 ++++++++++++++++++++++++++++++++++++++++++-----
 ./fs/super.c             |    2 -
 ./include/linux/dcache.h |    2 -
 3 files changed, 58 insertions(+), 8 deletions(-)

diff ./fs/dcache.c~current~ ./fs/dcache.c
--- ./fs/dcache.c~current~	2006-04-04 08:31:25.000000000 +1000
+++ ./fs/dcache.c	2006-04-04 10:58:14.000000000 +1000
@@ -382,6 +382,8 @@ static inline void prune_one_dentry(stru
 /**
  * prune_dcache - shrink the dcache
  * @count: number of entries to try and free
+ * @sb: if given, ignore dentries for other superblocks
+ *         which are being unmounted.
  *
  * Shrink the dcache. This is done when we need
  * more memory, or simply when we need to unmount
@@ -392,7 +394,7 @@ static inline void prune_one_dentry(stru
  * all the dentries are in use.
  */
  
-static void prune_dcache(int count)
+static void prune_dcache(int count, struct super_block *sb)
 {
 	spin_lock(&dcache_lock);
 	for (; count ; count--) {
@@ -402,6 +404,19 @@ static void prune_dcache(int count)
 		cond_resched_lock(&dcache_lock);
 
 		tmp = dentry_unused.prev;
+		if (unlikely(sb)) {
+			/* Try to find a dentry for this sb, but don't try
+			 * too hard, if they aren't near the tail they will
+			 * be moved down again soon
+			 */
+			int skip = count;
+			while (skip &&
+			       tmp != &dentry_unused &&
+			       list_entry(tmp, struct dentry, d_lru)->d_sb != sb) {
+				skip--;
+				tmp = tmp->prev;
+			}
+		}
 		if (tmp == &dentry_unused)
 			break;
 		list_del_init(tmp);
@@ -427,7 +442,41 @@ static void prune_dcache(int count)
  			spin_unlock(&dentry->d_lock);
 			continue;
 		}
-		prune_one_dentry(dentry);
+		/*
+		 * If the dentry is not DCACHED_REFERENCED, it is time
+		 * to remove it from the dcache, provided the super block is
+		 * NULL (which means we are trying to reclaim memory)
+		 * or this dentry belongs to the same super block that
+		 * we want to shrink.
+		 */
+		/*
+		 * If this dentry is for "my" filesystem, then I can
+		 * prune it without taking the s_umount lock (I already hold it).
+		 */
+		if (sb && dentry->d_sb == sb) {
+			prune_one_dentry(dentry);
+			continue;
+		}
+		/* ...otherwise we need to be sure this filesystem isn't being
+		 * unmounted, otherwise we could race with generic_shutdown_super,
+		 * and end up holding a reference to an inode while the
+		 * filesystem is unmounted.
+		 * So we try to get s_umount, and make sure s_root isn't NULL
+		 */
+		if (down_read_trylock(&dentry->d_sb->s_umount)) {
+			if (dentry->d_sb->s_root != NULL) {
+				prune_one_dentry(dentry);
+				up_read(&dentry->d_sb->s_umount);
+				continue;
+			}
+			up_read(&dentry->d_sb->s_umount);
+		}
+		spin_unlock(&dentry->d_lock);
+		/* Cannot remove the first dentry, and it isn't appropriate
+		 * to move it to the head of the list, so give up, and try
+		 * later
+		 */
+		break;
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -630,7 +679,7 @@ void shrink_dcache_parent(struct dentry 
 	int found;
 
 	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found);
+		prune_dcache(found, parent->d_sb);
 }
 
 /**
@@ -643,9 +692,10 @@ void shrink_dcache_parent(struct dentry 
  * done under dcache_lock.
  *
  */
-void shrink_dcache_anon(struct hlist_head *head)
+void shrink_dcache_anon(struct super_block *sb)
 {
 	struct hlist_node *lp;
+	struct hlist_head *head = &sb->s_anon;
 	int found;
 	do {
 		found = 0;
@@ -668,7 +718,7 @@ void shrink_dcache_anon(struct hlist_hea
 			}
 		}
 		spin_unlock(&dcache_lock);
-		prune_dcache(found);
+		prune_dcache(found, sb);
 	} while(found);
 }
 
@@ -689,7 +739,7 @@ static int shrink_dcache_memory(int nr, 
 	if (nr) {
 		if (!(gfp_mask & __GFP_FS))
 			return -1;
-		prune_dcache(nr);
+		prune_dcache(nr, NULL);
 	}
 	return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
 }

diff ./fs/super.c~current~ ./fs/super.c
--- ./fs/super.c~current~	2006-04-04 08:31:25.000000000 +1000
+++ ./fs/super.c	2006-04-03 12:21:55.000000000 +1000
@@ -231,7 +231,7 @@ void generic_shutdown_super(struct super
 	if (root) {
 		sb->s_root = NULL;
 		shrink_dcache_parent(root);
-		shrink_dcache_anon(&sb->s_anon);
+		shrink_dcache_anon(sb);
 		dput(root);
 		fsync_super(sb);
 		lock_super(sb);

diff ./include/linux/dcache.h~current~ ./include/linux/dcache.h
--- ./include/linux/dcache.h~current~	2006-04-04 08:31:25.000000000 +1000
+++ ./include/linux/dcache.h	2006-04-03 12:21:55.000000000 +1000
@@ -217,7 +217,7 @@ extern struct dentry * d_alloc_anon(stru
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
-extern void shrink_dcache_anon(struct hlist_head *);
+extern void shrink_dcache_anon(struct super_block *);
 extern int d_invalidate(struct dentry *);
 
 /* only used at mount-time */
