Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWDCDl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWDCDl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 23:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWDCDl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 23:41:56 -0400
Received: from cantor.suse.de ([195.135.220.2]:31402 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964816AbWDCDlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 23:41:55 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 3 Apr 2006 13:40:01 +1000
Message-Id: <1060403034001.28030@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org
Cc: Jan Blunck <jblunck@suse.de>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: olh@suse.de
Cc: bsingharora@gmail.com
Subject: [PATCH] Fix dcache race during umount
References: <20060403133804.27986.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think we finally have consensus on this patch.  However please speak
up if we don't :-)

Patch is against 2.6.16-mm2

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

I believe this race was first found by Kirill Korotaev.

Cc: Jan Blunck <jblunck@suse.de>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: olh@suse.de
Cc: bsingharora@gmail.com

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/dcache.c            |   41 ++++++++++++++++++++++++++++-------------
 ./fs/super.c             |    2 +-
 ./include/linux/dcache.h |    2 +-
 3 files changed, 30 insertions(+), 15 deletions(-)

diff ./fs/dcache.c~current~ ./fs/dcache.c
--- ./fs/dcache.c~current~	2006-04-03 12:21:49.000000000 +1000
+++ ./fs/dcache.c	2006-04-03 12:21:55.000000000 +1000
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
@@ -419,15 +421,27 @@ static void prune_dcache(int count)
  			spin_unlock(&dentry->d_lock);
 			continue;
 		}
-		/* If the dentry was recently referenced, don't free it. */
-		if (dentry->d_flags & DCACHE_REFERENCED) {
-			dentry->d_flags &= ~DCACHE_REFERENCED;
- 			list_add(&dentry->d_lru, &dentry_unused);
- 			dentry_stat.nr_unused++;
- 			spin_unlock(&dentry->d_lock);
-			continue;
+		if (!(dentry->d_flags & DCACHE_REFERENCED) &&
+		    (!sb || dentry->d_sb == sb)) {
+			if (sb) {
+				prune_one_dentry(dentry);
+				continue;
+			}
+			/* Need to avoid race with generic_shutdown_super */
+			if (down_read_trylock(&dentry->d_sb->s_umount) &&
+			    dentry->d_sb->s_root != NULL) {
+				prune_one_dentry(dentry);
+				up_read(&dentry->d_sb->s_umount);
+				continue;
+			}
 		}
-		prune_one_dentry(dentry);
+		/* The dentry was recently referenced, or the filesystem
+		 * is being unmounted, so don't free it. */
+
+		dentry->d_flags &= ~DCACHE_REFERENCED;
+		list_add(&dentry->d_lru, &dentry_unused);
+		dentry_stat.nr_unused++;
+		spin_unlock(&dentry->d_lock);
 	}
 	spin_unlock(&dcache_lock);
 }
@@ -630,7 +644,7 @@ void shrink_dcache_parent(struct dentry 
 	int found;
 
 	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found);
+		prune_dcache(found, parent->d_sb);
 }
 
 /**
@@ -643,9 +657,10 @@ void shrink_dcache_parent(struct dentry 
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
@@ -668,7 +683,7 @@ void shrink_dcache_anon(struct hlist_hea
 			}
 		}
 		spin_unlock(&dcache_lock);
-		prune_dcache(found);
+		prune_dcache(found, sb);
 	} while(found);
 }
 
@@ -689,7 +704,7 @@ static int shrink_dcache_memory(int nr, 
 	if (nr) {
 		if (!(gfp_mask & __GFP_FS))
 			return -1;
-		prune_dcache(nr);
+		prune_dcache(nr, NULL);
 	}
 	return (dentry_stat.nr_unused / 100) * sysctl_vfs_cache_pressure;
 }

diff ./fs/super.c~current~ ./fs/super.c
--- ./fs/super.c~current~	2006-04-03 12:21:49.000000000 +1000
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
--- ./include/linux/dcache.h~current~	2006-04-03 12:21:49.000000000 +1000
+++ ./include/linux/dcache.h	2006-04-03 12:21:55.000000000 +1000
@@ -217,7 +217,7 @@ extern struct dentry * d_alloc_anon(stru
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
-extern void shrink_dcache_anon(struct hlist_head *);
+extern void shrink_dcache_anon(struct super_block *);
 extern int d_invalidate(struct dentry *);
 
 /* only used at mount-time */
