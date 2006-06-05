Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932378AbWFEBas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWFEBas (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWFEBas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:30:48 -0400
Received: from ns2.suse.de ([195.135.220.15]:55957 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932374AbWFEBar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:30:47 -0400
From: Neil Brown <neilb@suse.de>
To: jblunck@suse.de
Date: Mon, 5 Jun 2006 11:30:22 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17539.35118.103025.716435@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
        viro@zeniv.linux.org.uk, dgc@sgi.com, balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries list (2nd version)
In-Reply-To: message from jblunck@suse.de on Thursday June 1
References: <20060601095125.773684000@hasse.suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday June 1, jblunck@suse.de wrote:
> This patch series is an updated version of my original patches.
> 
> This is an attempt to have per-superblock unused dentry lists. Since dentries
> are lazy-removed from the unused list, one big list doesn't scale very good
> wrt systems with a hugh dentry cache. The dcache shrinkers spend a long time
> traversing the list under the dcache spinlock.
> 
> The patches introduce an additional list_head per superblock holding only the
> dentries of the specific superblock. The next dentry can be found quickly so
> the shrinkers don't need to hold the dcache lock for long.
> 
> One nice side-effect: the "busy inodes after unmount" race is fixed because
> prune_dcache() is getting the s_umount lock before it starts working on the
> superblock's dentries.
> 
> Comments?

I'm wondering if we need to be as intrusive as this patch is, though
I'm not 100% certain of the details of the performance problems that
you are fixing, so I could be wrong...

It seems to me that the 'real' problem is that prune_dcache is used in
two very different circumstances.

Firstly, it is used by shrink_dcache_memory where we simply want to
free the 'n' oldest entries.  We don't care which filesystem they
belong to.

Secondly, it is used by shrink_dcache_parent and shrink_dcache_anon
when we want to free some specific dentries.   This is done by moving
those dentries to the 'old' end of the list and then calling
prune_dcache.

I understand that this is where problem is because the selected
dentries don't stay at the end of the list very long in some
circumstances. In particular, other filesystems' dentries get mixed
in. 

You have addressed this by having multiple unused lists so the
dentries of other filesystems don't get mixed in.

It seems to me that an alternate approach would be:

  - get select_parent and shrink_dcache_anon to move the selected
    dentries on to some new list.
  - pass this list to prune_dcache
  - splice any remainder back on to the global list when finished.

This would remove the noise from other filesystems that is causing the
problems, without creating the need to try to shrink multiple lists in
parallel which - due to significantly different sizes - seems to be a
problem. 

Following is a patch to try to spell out more clearly what I mean.  It
compiles, but has not been tested (or even very thoroughly reviewed).

Would this address the problem that you are measuring?

NeilBrown

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/dcache.c |   56 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff ./fs/dcache.c~current~ ./fs/dcache.c
--- ./fs/dcache.c~current~	2006-06-05 11:07:53.000000000 +1000
+++ ./fs/dcache.c	2006-06-05 11:29:20.000000000 +1000
@@ -383,8 +383,8 @@ static void prune_one_dentry(struct dent
 /**
  * prune_dcache - shrink the dcache
  * @count: number of entries to try and free
- * @sb: if given, ignore dentries for other superblocks
- *         which are being unmounted.
+ * @list: If given, remove from this list instead of
+ *        from dentry_unused.
  *
  * Shrink the dcache. This is done when we need
  * more memory, or simply when we need to unmount
@@ -393,11 +393,23 @@ static void prune_one_dentry(struct dent
  *
  * This function may fail to free any resources if
  * all the dentries are in use.
+ *
+ * Any dentries that were not removed due to the @count
+ * limit will be splice on to the end of dentry_unused,
+ * so they should already be founded in dentry_stat.nr_unused.
  */
  
-static void prune_dcache(int count, struct super_block *sb)
+static void prune_dcache(int count, struct list_head *list)
 {
+	int have_list = list != NULL;
+	struct list_head alt_head;
 	spin_lock(&dcache_lock);
+	if (list == NULL) {
+		/* use the dentry_unused list */
+		list_add(&alt_head, &dentry_unused);
+		list_del_init(&dentry_unused);
+		list = &alt_head;
+	}
 	for (; count ; count--) {
 		struct dentry *dentry;
 		struct list_head *tmp;
@@ -405,23 +417,11 @@ static void prune_dcache(int count, stru
 
 		cond_resched_lock(&dcache_lock);
 
-		tmp = dentry_unused.prev;
-		if (unlikely(sb)) {
-			/* Try to find a dentry for this sb, but don't try
-			 * too hard, if they aren't near the tail they will
-			 * be moved down again soon
-			 */
-			int skip = count;
-			while (skip && tmp != &dentry_unused &&
-			    list_entry(tmp, struct dentry, d_lru)->d_sb != sb) {
-				skip--;
-				tmp = tmp->prev;
-			}
-		}
-		if (tmp == &dentry_unused)
+		tmp = list->prev;
+		if (tmp == list)
 			break;
 		list_del_init(tmp);
-		prefetch(dentry_unused.prev);
+		prefetch(list->prev);
  		dentry_stat.nr_unused--;
 		dentry = list_entry(tmp, struct dentry, d_lru);
 
@@ -454,7 +454,7 @@ static void prune_dcache(int count, stru
 		 * If this dentry is for "my" filesystem, then I can prune it
 		 * without taking the s_umount lock (I already hold it).
 		 */
-		if (sb && dentry->d_sb == sb) {
+		if (have_list) {
 			prune_one_dentry(dentry);
 			continue;
 		}
@@ -489,6 +489,8 @@ static void prune_dcache(int count, stru
 		 */
 		break;
 	}
+	/* split any remaining entries back onto dentry_unused */
+	list_splice(list, dentry_unused.prev);
 	spin_unlock(&dcache_lock);
 }
 
@@ -607,7 +609,7 @@ positive:
 
 /*
  * Search the dentry child list for the specified parent,
- * and move any unused dentries to the end of the unused
+ * and move any unused dentries to the end of a new unused
  * list for prune_dcache(). We descend to the next level
  * whenever the d_subdirs list is non-empty and continue
  * searching.
@@ -619,7 +621,7 @@ positive:
  * drop the lock and return early due to latency
  * constraints.
  */
-static int select_parent(struct dentry * parent)
+static int select_parent(struct dentry * parent, struct list_head *new)
 {
 	struct dentry *this_parent = parent;
 	struct list_head *next;
@@ -643,7 +645,7 @@ resume:
 		 * of the unused list for prune_dcache
 		 */
 		if (!atomic_read(&dentry->d_count)) {
-			list_add_tail(&dentry->d_lru, &dentry_unused);
+			list_add_tail(&dentry->d_lru, new);
 			dentry_stat.nr_unused++;
 			found++;
 		}
@@ -687,9 +689,10 @@ out:
 void shrink_dcache_parent(struct dentry * parent)
 {
 	int found;
+	LIST_HEAD(list);
 
-	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found, parent->d_sb);
+	while ((found = select_parent(parent, &list)) != 0)
+		prune_dcache(found, &list);
 }
 
 /**
@@ -708,6 +711,7 @@ void shrink_dcache_anon(struct super_blo
 	struct hlist_head *head = &sb->s_anon;
 	int found;
 	do {
+		LIST_HEAD(list);
 		found = 0;
 		spin_lock(&dcache_lock);
 		hlist_for_each(lp, head) {
@@ -722,13 +726,13 @@ void shrink_dcache_anon(struct super_blo
 			 * of the unused list for prune_dcache
 			 */
 			if (!atomic_read(&this->d_count)) {
-				list_add_tail(&this->d_lru, &dentry_unused);
+				list_add_tail(&this->d_lru, &list);
 				dentry_stat.nr_unused++;
 				found++;
 			}
 		}
 		spin_unlock(&dcache_lock);
-		prune_dcache(found, sb);
+		prune_dcache(found, &list);
 	} while(found);
 }
 
