Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268816AbTBZQjY>; Wed, 26 Feb 2003 11:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268817AbTBZQjY>; Wed, 26 Feb 2003 11:39:24 -0500
Received: from ns.suse.de ([213.95.15.193]:44814 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268816AbTBZQit>;
	Wed, 26 Feb 2003 11:38:49 -0500
Date: Wed, 26 Feb 2003 17:49:05 +0100
From: Andi Kleen <ak@suse.de>
To: lse-tech@lse.sourceforge.net, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] New dcache / inode hash tuning patch
Message-ID: <20030226164904.GA21342@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unlike the previous version this one should actually compile.

The purpose of the patch is to address the excessive cache misses
observed on some boxes when accessing the dcache hash table.
For that it uses single pointer hash bucket heads and reduces 
the hash table sizes to values more likely to fit into cache.

In addition it saves tons of memory. 

Hash table sizes still experimental. If it should perform badly
at first please tweak D_NUMBUCKETS and I_NUMBUCKETS. I suspect
D_* could be increased, while I_* could be decreased actually.

Thanks a lot to Paul McKenney for review.

Patch for 2.5.63.

Changes compared to the last version.
- Should really compile now (last version had missing and wrong hunks
from last minute changes)
- Replace wmb with smp_wmb to make uniprocessor faster.
- Replace max_dentries RCU race loop breaker with Brent's algorithm.
This is untested because I don't know how to reproduce the race it fixes.
But in theory it should work better than the old code.
- Fix bug in find_inode_* to not leak memory (thanks Paul for noticing
that)
- Some other minor changes requested by Paul.
- Other minor cleanups

Todo: 
- Check if a better hash function for the dcache can be designed
- Verify the current hash table sizes under various workloads
- Add CONFIG_SMALL for small systems.

Please test, especially on big machines.

-Andi


diff -burpN -X ../KDIFX linux/fs/dcache.c linux-2.5.63-work/fs/dcache.c
--- linux/fs/dcache.c	2003-02-21 12:13:53.000000000 +0100
+++ linux-2.5.63-work/fs/dcache.c	2003-02-26 13:52:33.000000000 +0100
@@ -41,23 +41,24 @@ static kmem_cache_t *dentry_cache; 
  *
  * This hash-function tries to avoid losing too many bits of hash
  * information, yet avoid using a prime hash-size or similar.
+ *
+ * AK: using a prime hash with a prime near some power-of-two would be 
+ * likely better. Any hash guru interested? Same for the inode hash.
+ *
+ * We probably should have CONFIG_SMALL and CONFIG_LARGE for this.
+ * Don't scale it by memory size, otherwise big systems are eaten
+ * by the cache misses.
+ * 
+ * Sizes need to be power-of-two for now.
  */
-#define D_HASHBITS     d_hash_shift
-#define D_HASHMASK     d_hash_mask
+#define D_NUMBUCKETS	(16*1024) 	/* 64K RAM on a 32bit machine */
+#define D_HASHBITS      13              /* = log2(D_NUMBUCKETS) */
+#define D_HASHMASK      (D_NUMBUCKETS-1)
 
-static unsigned int d_hash_mask;
-static unsigned int d_hash_shift;
-static struct list_head *dentry_hashtable;
+static struct hlist_head *dentry_hashtable;
 static LIST_HEAD(dentry_unused);
-static int max_dentries;
 static void * hashtable_end;
 
-static inline int is_bucket(void * addr)
-{
-	return ((addr < (void *)dentry_hashtable)
-			|| (addr > hashtable_end) ? 0 : 1);
-}	
-
 /* Statistics gathering. */
 struct dentry_stat_t dentry_stat = {
 	.age_limit = 45,
@@ -292,6 +293,7 @@ struct dentry * d_find_alias(struct inod
 	while (next != head) {
 		tmp = next;
 		next = tmp->next;
+		prefetch(next);
 		alias = list_entry(tmp, struct dentry, d_alias);
  		if (!d_unhashed(alias)) {
 			if (alias->d_flags & DCACHE_DISCONNECTED)
@@ -378,6 +380,7 @@ static void prune_dcache(int count)
 		if (tmp == &dentry_unused)
 			break;
 		list_del_init(tmp);
+		prefetch(dentry_unused.prev);
  		dentry_stat.nr_unused--;
 		dentry = list_entry(tmp, struct dentry, d_lru);
 
@@ -603,15 +606,15 @@ void shrink_dcache_parent(struct dentry 
  * done under dcache_lock.
  *
  */
-void shrink_dcache_anon(struct list_head *head)
+void shrink_dcache_anon(struct hlist_head *head)
 {
-	struct list_head *lp;
+	struct hlist_node *lp;
 	int found;
 	do {
 		found = 0;
 		spin_lock(&dcache_lock);
-		list_for_each(lp, head) {
-			struct dentry *this = list_entry(lp, struct dentry, d_hash);
+		hlist_for_each(lp, head) {
+			struct dentry *this = hlist_entry(lp, struct dentry, d_hash);
 			list_del(&this->d_lru);
 
 			/* don't add non zero d_count dentries 
@@ -727,7 +730,7 @@ struct dentry * d_alloc(struct dentry * 
 	dentry->d_mounted = 0;
 	dentry->d_cookie = NULL;
 	dentry->d_bucket = NULL;
-	INIT_LIST_HEAD(&dentry->d_hash);
+	INIT_HLIST_NODE(&dentry->d_hash);
 	INIT_LIST_HEAD(&dentry->d_lru);
 	INIT_LIST_HEAD(&dentry->d_subdirs);
 	INIT_LIST_HEAD(&dentry->d_alias);
@@ -797,7 +800,7 @@ struct dentry * d_alloc_root(struct inod
 	return res;
 }
 
-static inline struct list_head * d_hash(struct dentry * parent, unsigned long hash)
+static inline struct hlist_head * d_hash(struct dentry * parent, unsigned long hash)
 {
 	hash += (unsigned long) parent / L1_CACHE_BYTES;
 	hash = hash ^ (hash >> D_HASHBITS);
@@ -860,7 +863,7 @@ struct dentry * d_alloc_anon(struct inod
 			res->d_flags |= DCACHE_DISCONNECTED;
 			res->d_vfs_flags &= ~DCACHE_UNHASHED;
 			list_add(&res->d_alias, &inode->i_dentry);
-			list_add(&res->d_hash, &inode->i_sb->s_anon);
+			hlist_add_head(&res->d_hash, &inode->i_sb->s_anon);
 			spin_unlock(&res->d_lock);
 		}
 		inode = NULL; /* don't drop reference */
@@ -947,21 +950,23 @@ struct dentry * d_lookup(struct dentry *
 	unsigned int len = name->len;
 	unsigned int hash = name->hash;
 	const unsigned char *str = name->name;
-	struct list_head *head = d_hash(parent,hash);
+	struct hlist_head *head = d_hash(parent,hash);
 	struct dentry *found = NULL;
-	struct list_head *tmp;
-	int lookup_count = 0;
+	struct hlist_node *node;
+	int loop_count = 0;
+	struct dentry *loop_marker = NULL;
 
 	rcu_read_lock();
 	
-	/* lookup is terminated when flow reaches any bucket head */
-	for(tmp = head->next; !is_bucket(tmp); tmp = tmp->next) {
+	hlist_for_each (node, head) { 
 		struct dentry *dentry; 
 		unsigned long move_count;
 		struct qstr * qstr;
 		
+		prefetch(node->next);
+
 		smp_read_barrier_depends();
-		dentry = list_entry(tmp, struct dentry, d_hash);
+		dentry = hlist_entry(node, struct dentry, d_hash);
 
 		/* if lookup ends up in a different bucket 
 		 * due to concurrent rename, fail it
@@ -969,11 +974,28 @@ struct dentry * d_lookup(struct dentry *
 		if (unlikely(dentry->d_bucket != head))
 			break;
 
-		/* to avoid race if dentry keep coming back to original
-		 * bucket due to double moves
+		/* to avoid a race if the dentry keeps coming back to the 
+		 * original bucket due to double moves. Check for a cycle
+		 * in each power of two. It could be still a false
+		 * positive due to memory reuse, so also recheck
+		 * again using an exclusive lock. This should happen
+		 * only in exceptional cases. Recursion is bounded to 
+		 * one because the race cannot occur with dcache lock
+		 * hold.
+		 *
+		 * UNTESTED CURRENTLY AS I CANNOT REPRODUCE THIS RACE!
 		 */
-		if (unlikely(++lookup_count > max_dentries))
-			break;
+		if (unlikely(loop_count & (loop_count - 1))) {
+			if (unlikely(dentry == loop_marker)) { 
+				rcu_read_unlock();
+				spin_lock(&dcache_lock);
+				dentry = d_lookup(parent, name);		
+				spin_unlock(&dcache_lock);
+				return dentry;
+			}
+			loop_marker = dentry; 
+		}
+		loop_count++;
 
 		/*
 		 * We must take a snapshot of d_move_count followed by
@@ -1031,7 +1053,8 @@ int d_validate(struct dentry *dentry, st
 	unsigned long dent_addr = (unsigned long) dentry;
 	unsigned long min_addr = PAGE_OFFSET;
 	unsigned long align_mask = 0x0F;
-	struct list_head *base, *lhp;
+	struct hlist_head *base;
+	struct hlist_node *lhp;
 
 	if (dent_addr < min_addr)
 		goto out;
@@ -1047,12 +1070,13 @@ int d_validate(struct dentry *dentry, st
 		goto out;
 
 	spin_lock(&dcache_lock);
-	lhp = base = d_hash(dparent, dentry->d_name.hash);
-	while ((lhp = lhp->next) != base) {
+	base = d_hash(dparent, dentry->d_name.hash);
+	hlist_for_each(lhp,base) { 
+		prefetch(lhp->next);
 		/* read_barrier_depends() not required for d_hash list
 		 * as it is parsed under dcache_lock
 		 */
-		if (dentry == list_entry(lhp, struct dentry, d_hash)) {
+		if (dentry == hlist_entry(lhp, struct dentry, d_hash)) {
 			dget(dentry);
 			spin_unlock(&dcache_lock);
 			return 1;
@@ -1113,12 +1137,11 @@ void d_delete(struct dentry * dentry)
  
 void d_rehash(struct dentry * entry)
 {
-	struct list_head *list = d_hash(entry->d_parent, entry->d_name.hash);
+	struct hlist_head *list = d_hash(entry->d_parent, entry->d_name.hash);
 	spin_lock(&dcache_lock);
- 	if (!list_empty(&entry->d_hash) && !d_unhashed(entry)) BUG();
  	entry->d_vfs_flags &= ~DCACHE_UNHASHED;
 	entry->d_bucket = list;
- 	list_add_rcu(&entry->d_hash, list);
+ 	hlist_add_head_rcu(&entry->d_hash, list);
 	spin_unlock(&dcache_lock);
 }
 
@@ -1171,10 +1194,6 @@ static inline void switch_names(struct d
  * We could be nicer about the deleted file, and let it show
  * up under the name it got deleted rather than the name that
  * deleted it.
- *
- * Careful with the hash switch. The hash switch depends on
- * the fact that any list-entry can be a head of the list.
- * Think about it.
  */
  
 /**
@@ -1197,8 +1216,8 @@ void d_move(struct dentry * dentry, stru
 	/* Move the dentry to the target hash queue, if on different bucket */
 	if (dentry->d_bucket != target->d_bucket) {
 		dentry->d_bucket = target->d_bucket;
-		list_del_rcu(&dentry->d_hash);
-		list_add_rcu(&dentry->d_hash, &target->d_hash);
+		hlist_del_rcu(&dentry->d_hash);
+		hlist_add_head_rcu(&dentry->d_hash, target->d_bucket);
 	}
 
 	/* Unhash the target: dput() will then get rid of it */
@@ -1281,6 +1300,7 @@ static char * __d_path( struct dentry *d
 			continue;
 		}
 		parent = dentry->d_parent;
+		prefetch(parent);
 		namelen = dentry->d_name.len;
 		buflen -= namelen + 1;
 		if (buflen < 0)
@@ -1500,9 +1520,6 @@ out:
 
 static void __init dcache_init(unsigned long mempages)
 {
-	struct list_head *d;
-	unsigned long order;
-	unsigned int nr_hash;
 	int i;
 
 	/* 
@@ -1521,49 +1538,17 @@ static void __init dcache_init(unsigned 
 	if (!dentry_cache)
 		panic("Cannot create dentry cache");
 	
-	/* approximate maximum number of dentries in one hash bucket */
-	max_dentries = (mempages * (PAGE_SIZE / sizeof(struct dentry)));
-
 	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
 
-#if PAGE_SHIFT < 13
-	mempages >>= (13 - PAGE_SHIFT);
-#endif
-	mempages *= sizeof(struct list_head);
-	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
-		;
-
-	do {
-		unsigned long tmp;
-
-		nr_hash = (1UL << order) * PAGE_SIZE /
-			sizeof(struct list_head);
-		d_hash_mask = (nr_hash - 1);
-
-		tmp = nr_hash;
-		d_hash_shift = 0;
-		while ((tmp >>= 1UL) != 0UL)
-			d_hash_shift++;
-
-		dentry_hashtable = (struct list_head *)
-			__get_free_pages(GFP_ATOMIC, order);
-	} while (dentry_hashtable == NULL && --order >= 0);
-
-	printk(KERN_INFO "Dentry cache hash table entries: %d (order: %ld, %ld bytes)\n",
-			nr_hash, order, (PAGE_SIZE << order));
-
+	dentry_hashtable = (struct hlist_head *)
+		__get_free_pages(GFP_ATOMIC, 
+			 get_order(D_NUMBUCKETS * sizeof(struct hlist_head)));
 	if (!dentry_hashtable)
 		panic("Failed to allocate dcache hash table\n");
 
-	hashtable_end = dentry_hashtable + nr_hash;
-
-	d = dentry_hashtable;
-	i = nr_hash;
-	do {
-		INIT_LIST_HEAD(d);
-		d++;
-		i--;
-	} while (i);
+	for (i = 0; i < D_NUMBUCKETS; i++) 
+		INIT_HLIST_HEAD(&dentry_hashtable[i]);
+	hashtable_end = dentry_hashtable + i; 
 }
 
 /* SLAB cache for __getname() consumers */
diff -burpN -X ../KDIFX linux/fs/fs-writeback.c linux-2.5.63-work/fs/fs-writeback.c
--- linux/fs/fs-writeback.c	2003-02-10 19:39:17.000000000 +0100
+++ linux-2.5.63-work/fs/fs-writeback.c	2003-02-26 13:53:13.000000000 +0100
@@ -90,7 +90,7 @@ void __mark_inode_dirty(struct inode *in
 		 * Only add valid (hashed) inodes to the superblock's
 		 * dirty list.  Add blockdev inodes as well.
 		 */
-		if (list_empty(&inode->i_hash) && !S_ISBLK(inode->i_mode))
+		if (hnode_empty(&inode->i_hash) && !S_ISBLK(inode->i_mode))
 			goto out;
 
 		/*
diff -burpN -X ../KDIFX linux/fs/hugetlbfs/inode.c linux-2.5.63-work/fs/hugetlbfs/inode.c
--- linux/fs/hugetlbfs/inode.c	2003-02-15 10:37:04.000000000 +0100
+++ linux-2.5.63-work/fs/hugetlbfs/inode.c	2003-02-26 13:54:11.000000000 +0100
@@ -189,7 +189,7 @@ void truncate_hugepages(struct address_s
 
 static void hugetlbfs_delete_inode(struct inode *inode)
 {
-	list_del_init(&inode->i_hash);
+	hlist_del_init(&inode->i_hash);
 	list_del_init(&inode->i_list);
 	inode->i_state |= I_FREEING;
 	inodes_stat.nr_inodes--;
@@ -208,7 +208,7 @@ static void hugetlbfs_forget_inode(struc
 {
 	struct super_block *super_block = inode->i_sb;
 
-	if (list_empty(&inode->i_hash))
+	if (hnode_empty(&inode->i_hash))
 		goto out_truncate;
 
 	if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
@@ -223,7 +223,7 @@ static void hugetlbfs_forget_inode(struc
 
 	/* write_inode_now() ? */
 	inodes_stat.nr_unused--;
-	list_del_init(&inode->i_hash);
+	hlist_del_init(&inode->i_hash);
 out_truncate:
 	list_del_init(&inode->i_list);
 	inode->i_state |= I_FREEING;
diff -burpN -X ../KDIFX linux/fs/inode.c linux-2.5.63-work/fs/inode.c
--- linux/fs/inode.c	2003-02-10 19:39:00.000000000 +0100
+++ linux-2.5.63-work/fs/inode.c	2003-02-26 13:16:49.000000000 +0100
@@ -49,11 +49,9 @@
  * Inode lookup is no longer as critical as it used to be:
  * most of the lookups are going to be through the dcache.
  */
-#define I_HASHBITS	i_hash_shift
-#define I_HASHMASK	i_hash_mask
-
-static unsigned int i_hash_mask;
-static unsigned int i_hash_shift;
+#define I_NUMBUCKETS	(8*1024)
+#define I_HASHBITS	12	/* = log2(I_NUMBUCKETS) */ 
+#define I_HASHMASK	(I_NUMBUCKETS-1)
 
 /*
  * Each inode can be on two separate lists. One is
@@ -69,8 +67,8 @@ static unsigned int i_hash_shift;
 
 LIST_HEAD(inode_in_use);
 LIST_HEAD(inode_unused);
-static struct list_head *inode_hashtable;
-static LIST_HEAD(anon_hash_chain); /* for inodes with NULL i_sb */
+static struct hlist_head *inode_hashtable;
+static HLIST_HEAD(anon_hash_chain); /* for inodes with NULL i_sb */
 
 /*
  * A simple spinlock to protect the list manipulations.
@@ -162,7 +160,7 @@ void destroy_inode(struct inode *inode) 
 void inode_init_once(struct inode *inode)
 {
 	memset(inode, 0, sizeof(*inode));
-	INIT_LIST_HEAD(&inode->i_hash);
+	INIT_HLIST_NODE(&inode->i_hash);
 	INIT_LIST_HEAD(&inode->i_data.clean_pages);
 	INIT_LIST_HEAD(&inode->i_data.dirty_pages);
 	INIT_LIST_HEAD(&inode->i_data.locked_pages);
@@ -284,7 +282,7 @@ static int invalidate_list(struct list_h
 			continue;
 		invalidate_inode_buffers(inode);
 		if (!atomic_read(&inode->i_count)) {
-			list_del_init(&inode->i_hash);
+			hlist_del_init(&inode->i_hash);
 			list_del(&inode->i_list);
 			list_add(&inode->i_list, dispose);
 			inode->i_state |= I_FREEING;
@@ -422,7 +420,7 @@ static void prune_icache(int nr_to_scan)
 			if (!can_unuse(inode))
 				continue;
 		}
-		list_del_init(&inode->i_hash);
+		hlist_del_init(&inode->i_hash);
 		list_move(&inode->i_list, &freeable);
 		inode->i_state |= I_FREEING;
 		nr_pruned++;
@@ -460,50 +458,42 @@ static int shrink_icache_memory(int nr, 
  * by hand after calling find_inode now! This simplifies iunique and won't
  * add any additional branch in the common code.
  */
-static struct inode * find_inode(struct super_block * sb, struct list_head *head, int (*test)(struct inode *, void *), void *data)
+static struct inode * find_inode(struct super_block * sb, struct hlist_head *head, int (*test)(struct inode *, void *), void *data)
 {
-	struct list_head *tmp;
+	struct hlist_node *node;
 	struct inode * inode;
 
-	tmp = head;
-	for (;;) {
-		tmp = tmp->next;
-		inode = NULL;
-		if (tmp == head)
-			break;
-		inode = list_entry(tmp, struct inode, i_hash);
+	hlist_for_each (node, head) { 
+		prefetch(node->next);
+		inode = hlist_entry(node, struct inode, i_hash);
 		if (inode->i_sb != sb)
 			continue;
 		if (!test(inode, data))
 			continue;
 		break;
 	}
-	return inode;
+	return node ? inode : NULL;
 }
 
 /*
  * find_inode_fast is the fast path version of find_inode, see the comment at
  * iget_locked for details.
  */
-static struct inode * find_inode_fast(struct super_block * sb, struct list_head *head, unsigned long ino)
+static struct inode * find_inode_fast(struct super_block * sb, struct hlist_head *head, unsigned long ino)
 {
-	struct list_head *tmp;
+	struct hlist_node *node;
 	struct inode * inode;
 
-	tmp = head;
-	for (;;) {
-		tmp = tmp->next;
-		inode = NULL;
-		if (tmp == head)
-			break;
-		inode = list_entry(tmp, struct inode, i_hash);
+	hlist_for_each (node, head) {
+		prefetch(node->next);
+		inode = list_entry(node, struct inode, i_hash);
 		if (inode->i_ino != ino)
 			continue;
 		if (inode->i_sb != sb)
 			continue;
 		break;
 	}
-	return inode;
+	return node ? inode : NULL;
 }
 
 /**
@@ -553,7 +543,7 @@ EXPORT_SYMBOL(unlock_new_inode);
  * We no longer cache the sb_flags in i_flags - see fs.h
  *	-- rmk@arm.uk.linux.org
  */
-static struct inode * get_new_inode(struct super_block *sb, struct list_head *head, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
+static struct inode * get_new_inode(struct super_block *sb, struct hlist_head *head, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
 {
 	struct inode * inode;
 
@@ -570,7 +560,7 @@ static struct inode * get_new_inode(stru
 
 			inodes_stat.nr_inodes++;
 			list_add(&inode->i_list, &inode_in_use);
-			list_add(&inode->i_hash, head);
+			hlist_add_head(&inode->i_hash, head);
 			inode->i_state = I_LOCK|I_NEW;
 			spin_unlock(&inode_lock);
 
@@ -603,7 +593,7 @@ set_failed:
  * get_new_inode_fast is the fast path version of get_new_inode, see the
  * comment at iget_locked for details.
  */
-static struct inode * get_new_inode_fast(struct super_block *sb, struct list_head *head, unsigned long ino)
+static struct inode * get_new_inode_fast(struct super_block *sb, struct hlist_head *head, unsigned long ino)
 {
 	struct inode * inode;
 
@@ -618,7 +608,7 @@ static struct inode * get_new_inode_fast
 			inode->i_ino = ino;
 			inodes_stat.nr_inodes++;
 			list_add(&inode->i_list, &inode_in_use);
-			list_add(&inode->i_hash, head);
+			hlist_add_head(&inode->i_hash, head);
 			inode->i_state = I_LOCK|I_NEW;
 			spin_unlock(&inode_lock);
 
@@ -670,7 +660,7 @@ ino_t iunique(struct super_block *sb, in
 {
 	static ino_t counter = 0;
 	struct inode *inode;
-	struct list_head * head;
+	struct hlist_head * head;
 	ino_t res;
 	spin_lock(&inode_lock);
 retry:
@@ -724,7 +714,7 @@ struct inode *igrab(struct inode *inode)
  * Note, @test is called with the inode_lock held, so can't sleep.
  */
 static inline struct inode *ifind(struct super_block *sb,
-		struct list_head *head, int (*test)(struct inode *, void *),
+		struct hlist_head *head, int (*test)(struct inode *, void *),
 		void *data)
 {
 	struct inode *inode;
@@ -756,7 +746,7 @@ static inline struct inode *ifind(struct
  * Otherwise NULL is returned.
  */
 static inline struct inode *ifind_fast(struct super_block *sb,
-		struct list_head *head, unsigned long ino)
+		struct hlist_head *head, unsigned long ino)
 {
 	struct inode *inode;
 
@@ -794,7 +784,7 @@ static inline struct inode *ifind_fast(s
 struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
 		int (*test)(struct inode *, void *), void *data)
 {
-	struct list_head *head = inode_hashtable + hash(sb, hashval);
+	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
 
 	return ifind(sb, head, test, data);
 }
@@ -816,7 +806,7 @@ EXPORT_SYMBOL(ilookup5);
  */
 struct inode *ilookup(struct super_block *sb, unsigned long ino)
 {
-	struct list_head *head = inode_hashtable + hash(sb, ino);
+	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 
 	return ifind_fast(sb, head, ino);
 }
@@ -848,7 +838,7 @@ struct inode *iget5_locked(struct super_
 		int (*test)(struct inode *, void *),
 		int (*set)(struct inode *, void *), void *data)
 {
-	struct list_head *head = inode_hashtable + hash(sb, hashval);
+	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
 	struct inode *inode;
 
 	inode = ifind(sb, head, test, data);
@@ -881,7 +871,7 @@ EXPORT_SYMBOL(iget5_locked);
  */
 struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 {
-	struct list_head *head = inode_hashtable + hash(sb, ino);
+	struct hlist_head *head = inode_hashtable + hash(sb, ino);
 	struct inode *inode;
 
 	inode = ifind_fast(sb, head, ino);
@@ -907,11 +897,11 @@ EXPORT_SYMBOL(iget_locked);
  
 void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 {
-	struct list_head *head = &anon_hash_chain;
+	struct hlist_head *head = &anon_hash_chain;
 	if (inode->i_sb)
 		head = inode_hashtable + hash(inode->i_sb, hashval);
 	spin_lock(&inode_lock);
-	list_add(&inode->i_hash, head);
+	hlist_add_head(&inode->i_hash, head);
 	spin_unlock(&inode_lock);
 }
 
@@ -925,7 +915,7 @@ void __insert_inode_hash(struct inode *i
 void remove_inode_hash(struct inode *inode)
 {
 	spin_lock(&inode_lock);
-	list_del_init(&inode->i_hash);
+	hlist_del_init(&inode->i_hash);
 	spin_unlock(&inode_lock);
 }
 
@@ -933,7 +923,7 @@ void generic_delete_inode(struct inode *
 {
 	struct super_operations *op = inode->i_sb->s_op;
 
-	list_del_init(&inode->i_hash);
+	hlist_del_init(&inode->i_hash);
 	list_del_init(&inode->i_list);
 	inode->i_state|=I_FREEING;
 	inodes_stat.nr_inodes--;
@@ -962,7 +952,7 @@ static void generic_forget_inode(struct 
 {
 	struct super_block *sb = inode->i_sb;
 
-	if (!list_empty(&inode->i_hash)) {
+	if (!hnode_empty(&inode->i_hash)) {
 		if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
 			list_del(&inode->i_list);
 			list_add(&inode->i_list, &inode_unused);
@@ -974,7 +964,7 @@ static void generic_forget_inode(struct 
 		write_inode_now(inode, 1);
 		spin_lock(&inode_lock);
 		inodes_stat.nr_unused--;
-		list_del_init(&inode->i_hash);
+		hlist_del_init(&inode->i_hash);
 	}
 	list_del_init(&inode->i_list);
 	inode->i_state|=I_FREEING;
@@ -1220,48 +1210,18 @@ void wake_up_inode(struct inode *inode)
  */
 void __init inode_init(unsigned long mempages)
 {
-	struct list_head *head;
-	unsigned long order;
-	unsigned int nr_hash;
 	int i;
-
 	for (i = 0; i < ARRAY_SIZE(i_wait_queue_heads); i++)
 		init_waitqueue_head(&i_wait_queue_heads[i].wqh);
 
-	mempages >>= (14 - PAGE_SHIFT);
-	mempages *= sizeof(struct list_head);
-	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
-		;
-
-	do {
-		unsigned long tmp;
-
-		nr_hash = (1UL << order) * PAGE_SIZE /
-			sizeof(struct list_head);
-		i_hash_mask = (nr_hash - 1);
-
-		tmp = nr_hash;
-		i_hash_shift = 0;
-		while ((tmp >>= 1UL) != 0UL)
-			i_hash_shift++;
-
-		inode_hashtable = (struct list_head *)
-			__get_free_pages(GFP_ATOMIC, order);
-	} while (inode_hashtable == NULL && --order >= 0);
-
-	printk("Inode-cache hash table entries: %d (order: %ld, %ld bytes)\n",
-			nr_hash, order, (PAGE_SIZE << order));
-
+	inode_hashtable = (struct hlist_head *)
+		__get_free_pages(GFP_ATOMIC, 
+		     get_order(I_NUMBUCKETS*sizeof(struct hlist_head))); 
 	if (!inode_hashtable)
 		panic("Failed to allocate inode hash table\n");
 
-	head = inode_hashtable;
-	i = nr_hash;
-	do {
-		INIT_LIST_HEAD(head);
-		head++;
-		i--;
-	} while (i);
+	for (i = 0; i < I_NUMBUCKETS; i++)
+		INIT_HLIST_HEAD(&inode_hashtable[i]);
 
 	/* inode slab cache */
 	inode_cachep = kmem_cache_create("inode_cache", sizeof(struct inode),
diff -burpN -X ../KDIFX linux/fs/super.c linux-2.5.63-work/fs/super.c
--- linux/fs/super.c	2003-02-10 19:38:30.000000000 +0100
+++ linux-2.5.63-work/fs/super.c	2003-02-26 13:51:33.000000000 +0100
@@ -63,7 +63,7 @@ static struct super_block *alloc_super(v
 		INIT_LIST_HEAD(&s->s_io);
 		INIT_LIST_HEAD(&s->s_files);
 		INIT_LIST_HEAD(&s->s_instances);
-		INIT_LIST_HEAD(&s->s_anon);
+		INIT_HLIST_HEAD(&s->s_anon);
 		init_rwsem(&s->s_umount);
 		sema_init(&s->s_lock, 1);
 		down_write(&s->s_umount);
diff -burpN -X ../KDIFX linux/include/linux/dcache.h linux-2.5.63-work/include/linux/dcache.h
--- linux/include/linux/dcache.h	2003-02-21 12:13:54.000000000 +0100
+++ linux-2.5.63-work/include/linux/dcache.h	2003-02-26 13:16:27.000000000 +0100
@@ -80,8 +80,8 @@ struct dentry {
 	unsigned long d_move_count;	/* to indicated moved dentry while lockless lookup */
 	struct inode  * d_inode;	/* Where the name belongs to - NULL is negative */
 	struct dentry * d_parent;	/* parent directory */
-	struct list_head * d_bucket;	/* lookup hash bucket */
-	struct list_head d_hash;	/* lookup hash list */
+	struct hlist_head * d_bucket;	/* lookup hash bucket */
+	struct hlist_node d_hash;	/* lookup hash list */
 	struct list_head d_lru;		/* LRU list */
 	struct list_head d_child;	/* child of parent list */
 	struct list_head d_subdirs;	/* our children */
@@ -171,7 +171,7 @@ extern rwlock_t dparent_lock;
 static __inline__ void __d_drop(struct dentry * dentry)
 {
 	dentry->d_vfs_flags |= DCACHE_UNHASHED;
-	list_del_rcu(&dentry->d_hash);
+	hlist_del_rcu(&dentry->d_hash);
 }
 
 static __inline__ void d_drop(struct dentry * dentry)
@@ -198,7 +198,7 @@ extern struct dentry * d_alloc_anon(stru
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
-extern void shrink_dcache_anon(struct list_head *);
+extern void shrink_dcache_anon(struct hlist_head *);
 extern int d_invalidate(struct dentry *);
 
 /* only used at mount-time */
diff -burpN -X ../KDIFX linux/include/linux/fs.h linux-2.5.63-work/include/linux/fs.h
--- linux/include/linux/fs.h	2003-02-26 12:55:30.000000000 +0100
+++ linux-2.5.63-work/include/linux/fs.h	2003-02-26 13:16:27.000000000 +0100
@@ -353,7 +353,7 @@ struct block_device {
 };
 
 struct inode {
-	struct list_head	i_hash;
+	struct hlist_node	i_hash;
 	struct list_head	i_list;
 	struct list_head	i_dentry;
 	unsigned long		i_ino;
@@ -601,7 +601,7 @@ struct super_block {
 
 	struct list_head	s_dirty;	/* dirty inodes */
 	struct list_head	s_io;		/* parked for writeback */
-	struct list_head	s_anon;		/* anonymous dentries for (nfs) exporting */
+	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
 	struct list_head	s_files;
 
 	struct block_device	*s_bdev;
diff -burpN -X ../KDIFX linux/include/linux/list.h linux-2.5.63-work/include/linux/list.h
--- linux/include/linux/list.h	2003-02-10 19:37:56.000000000 +0100
+++ linux-2.5.63-work/include/linux/list.h	2003-02-26 13:19:48.000000000 +0100
@@ -319,6 +319,95 @@ static inline void list_splice_init(stru
 	for (pos = (head)->next, n = pos->next; pos != (head); \
 		pos = n, ({ read_barrier_depends(); 0;}), n = pos->next)
 
+/* 
+ * Double linked lists with a single pointer list head. 
+ * Mostly useful for hash tables where the two pointer list head is 
+ * too wasteful.
+ * You lose the ability to access the tail in O(1).
+ */ 
+
+struct hlist_head { 
+	struct hlist_node *first; 
+}; 
+
+struct hlist_node { 
+	struct hlist_node *next, **pprev; 
+}; 
+
+#define HLIST_HEAD_INIT { first: NULL } 
+#define HLIST_HEAD(name) struct hlist_head name = {  first: NULL }
+#define INIT_HLIST_HEAD(ptr) ((ptr)->first = NULL) 
+#define INIT_HLIST_NODE(ptr) ((ptr)->next = NULL, (ptr)->pprev = NULL)
+
+/* This is really misnamed */
+static __inline__ int hnode_empty(struct hlist_node *h) 
+{ 
+	return h->pprev==0;
+} 
+
+static __inline__ int hlist_empty(struct hlist_head *h) 
+{ 
+	return !h->first;
+} 
+
+static __inline__ void hlist_del(struct hlist_node *n) 
+{
+	/* The if could be avoided by a common dummy pprev target. */
+	if (!n->pprev) 
+		return; 
+	*(n->pprev) = n->next;  
+	if (n->next) 
+		n->next->pprev = n->pprev;
+}  
+
+#define hlist_del_rcu hlist_del  /* list_del_rcu is identical too? */
+
+static __inline__ void hlist_del_init(struct hlist_node *n) 
+{
+	/* The if could be avoided by a common dummy pprev target. */
+	if (!n->pprev) 
+		return; 
+	*(n->pprev) = n->next;  
+	if (n->next) 
+		n->next->pprev = n->pprev;
+	INIT_HLIST_NODE(n);
+}  
+
+static __inline__ void hlist_add_head(struct hlist_node *n, struct hlist_head *h) 
+{ 
+	n->next = h->first; 
+	if (h->first) 
+		h->first->pprev = &n->next;
+	h->first = n; 
+	n->pprev = &h->first; 
+} 
+
+static __inline__ void hlist_add_head_rcu(struct hlist_node *n, struct hlist_head *h) 
+{ 
+	n->next = h->first;
+	n->pprev = &h->first; 
+	smp_wmb();
+	if (h->first) 
+		h->first->pprev = &n->next;
+	h->first = n; 
+} 
+
+/* next must be != NULL */
+static __inline__ void hlist_add_before(struct hlist_node *n, struct hlist_node *next)
+{
+	n->pprev = next->pprev;
+	n->next = next; 
+	next->pprev = &n->next; 
+	*(n->pprev) = n;
+}
+
+#define hlist_entry(ptr, type, member) container_of(ptr,type,member)
+
+/* Cannot easily do prefetch unfortunately */
+#define hlist_for_each(pos, head) \
+	for (pos = (head)->first; pos; \
+	     pos = pos->next) 
+
 #else
 #warning "don't include kernel headers in userspace"
 #endif /* __KERNEL__ */
