Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263370AbRFEVTY>; Tue, 5 Jun 2001 17:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbRFEVTP>; Tue, 5 Jun 2001 17:19:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63180 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263365AbRFEVS7>;
	Tue, 5 Jun 2001 17:18:59 -0400
Date: Tue, 5 Jun 2001 17:18:57 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more fs/super.c cleanups (5)
Message-ID: <Pine.GSO.4.21.0106051705030.4799-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chunk 5:
	* we put vfsmounts into hash, keyed by pair dentry/vfsmount of
mountpoint. attach_mnt() and detach_mnt() do the obvious thing.
	* follow_down() and friends do lookup in that hash, instead of
traversing ->d_vfsmnt. It kills scalability problem with many parallel
trees (if you remember, that's what was planned from the very beginning;
d_vfsmount was a "it works for now" sort of thing).
	* d_vfsmnt is gone. In its place we have a counter - how many
things are mounted on that dentry. That (along with the above) covers all
uses of d_vfsmnt. First of all, d_mountoint() is easier (->d_mounted != 0
instead of !list_empty()). Besides, struct dentry became smaller.
	* we allocate vfsmounts from the cache of their own now.

OK, that's probably it for 6-pre1. It Works Here(tm), it had been done with
equivalent transformations and I hope that chunks are small enough to be
easy to verify.  Next part changes mount_sem locking (internal to fs/super.c),
so I'd rather keep it separate.

Please, apply.
								Al

diff -urN S6-pre1-graft_tree/fs/autofs4/expire.c S6-pre1-mntcache/fs/autofs4/expire.c
--- S6-pre1-graft_tree/fs/autofs4/expire.c	Sat Apr 28 02:12:56 2001
+++ S6-pre1-mntcache/fs/autofs4/expire.c	Tue Jun  5 08:18:04 2001
@@ -66,19 +66,11 @@
    non-busy mounts */
 static int check_vfsmnt(struct vfsmount *mnt, struct dentry *dentry)
 {
-	int ret = 0;
-	struct list_head *tmp;
-
-	list_for_each(tmp, &dentry->d_vfsmnt) {
-		struct vfsmount *vfs = list_entry(tmp, struct vfsmount, 
-						  mnt_clash);
-		DPRINTK(("check_vfsmnt: mnt=%p, dentry=%p, tmp=%p, vfs=%p\n",
-			 mnt, dentry, tmp, vfs));
-		if (vfs->mnt_parent != mnt || /* don't care about busy-ness of other namespaces */
-		    !is_vfsmnt_tree_busy(vfs))
-			ret++;
-	}
+	int ret = dentry->d_mounted;
+	struct vfsmount *vfs = lookup_mnt(mnt, dentry);
 
+	if (vfs && is_vfsmnt_tree_busy(vfs))
+		ret--;
 	DPRINTK(("check_vfsmnt: ret=%d\n", ret));
 	return ret;
 }
diff -urN S6-pre1-graft_tree/fs/dcache.c S6-pre1-mntcache/fs/dcache.c
--- S6-pre1-graft_tree/fs/dcache.c	Fri May 25 21:51:12 2001
+++ S6-pre1-mntcache/fs/dcache.c	Tue Jun  5 08:18:04 2001
@@ -616,7 +616,7 @@
 	dentry->d_name.hash = name->hash;
 	dentry->d_op = NULL;
 	dentry->d_fsdata = NULL;
-	INIT_LIST_HEAD(&dentry->d_vfsmnt);
+	dentry->d_mounted = 0;
 	INIT_LIST_HEAD(&dentry->d_hash);
 	INIT_LIST_HEAD(&dentry->d_lru);
 	INIT_LIST_HEAD(&dentry->d_subdirs);
@@ -1283,6 +1283,7 @@
 
 	dcache_init(mempages);
 	inode_init(mempages);
+	mnt_init(mempages);
 	bdev_cache_init();
 	cdev_cache_init();
 }
diff -urN S6-pre1-graft_tree/fs/namei.c S6-pre1-mntcache/fs/namei.c
--- S6-pre1-graft_tree/fs/namei.c	Fri May 25 21:51:14 2001
+++ S6-pre1-mntcache/fs/namei.c	Tue Jun  5 08:18:04 2001
@@ -351,22 +351,17 @@
 
 static inline int __follow_down(struct vfsmount **mnt, struct dentry **dentry)
 {
-	struct list_head *p;
+	struct vfsmount *mounted;
+
 	spin_lock(&dcache_lock);
-	p = (*dentry)->d_vfsmnt.next;
-	while (p != &(*dentry)->d_vfsmnt) {
-		struct vfsmount *tmp;
-		tmp = list_entry(p, struct vfsmount, mnt_clash);
-		if (tmp->mnt_parent == *mnt) {
-			*mnt = mntget(tmp);
-			spin_unlock(&dcache_lock);
-			mntput(tmp->mnt_parent);
-			/* tmp holds the mountpoint, so... */
-			dput(*dentry);
-			*dentry = dget(tmp->mnt_root);
-			return 1;
-		}
-		p = p->next;
+	mounted = lookup_mnt(*mnt, *dentry);
+	if (mounted) {
+		*mnt = mntget(mounted);
+		spin_unlock(&dcache_lock);
+		dput(*dentry);
+		mntput(mounted->mnt_parent);
+		*dentry = dget(mounted->mnt_root);
+		return 1;
 	}
 	spin_unlock(&dcache_lock);
 	return 0;
diff -urN S6-pre1-graft_tree/fs/super.c S6-pre1-mntcache/fs/super.c
--- S6-pre1-graft_tree/fs/super.c	Tue Jun  5 08:17:28 2001
+++ S6-pre1-mntcache/fs/super.c	Tue Jun  5 08:18:04 2001
@@ -281,13 +281,25 @@
 
 static LIST_HEAD(vfsmntlist);
 
+static struct list_head *mount_hashtable;
+static int hash_mask, hash_bits;
+static kmem_cache_t *mnt_cache; 
+
+static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
+{
+	unsigned long tmp = ((unsigned long) mnt / L1_CACHE_BYTES);
+	tmp += ((unsigned long) dentry / L1_CACHE_BYTES);
+	tmp = tmp + (tmp >> hash_mask);
+	return tmp & hash_bits;
+}
+
 struct vfsmount *alloc_vfsmnt(void)
 {
-	struct vfsmount *mnt = kmalloc(sizeof(struct vfsmount), GFP_KERNEL); 
+	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL); 
 	if (mnt) {
 		memset(mnt, 0, sizeof(struct vfsmount));
 		atomic_set(&mnt->mnt_count,1);
-		INIT_LIST_HEAD(&mnt->mnt_clash);
+		INIT_LIST_HEAD(&mnt->mnt_hash);
 		INIT_LIST_HEAD(&mnt->mnt_child);
 		INIT_LIST_HEAD(&mnt->mnt_mounts);
 		INIT_LIST_HEAD(&mnt->mnt_list);
@@ -296,6 +308,24 @@
 	return mnt;
 }
 
+struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct list_head * head = mount_hashtable + hash(mnt, dentry);
+	struct list_head * tmp = head;
+	struct vfsmount *p;
+
+	for (;;) {
+		tmp = tmp->next;
+		p = NULL;
+		if (tmp == head)
+			break;
+		p = list_entry(tmp, struct vfsmount, mnt_hash);
+		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry)
+			break;
+	}
+	return p;
+}
+
 static void detach_mnt(struct vfsmount *mnt, struct nameidata *old_nd)
 {
 	old_nd->dentry = mnt->mnt_mountpoint;
@@ -303,15 +333,17 @@
 	mnt->mnt_parent = mnt;
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	list_del_init(&mnt->mnt_child);
-	list_del_init(&mnt->mnt_clash);
+	list_del_init(&mnt->mnt_hash);
+	old_nd->dentry->d_mounted--;
 }
 
 static void attach_mnt(struct vfsmount *mnt, struct nameidata *nd)
 {
 	mnt->mnt_parent = mntget(nd->mnt);
 	mnt->mnt_mountpoint = dget(nd->dentry);
-	list_add(&mnt->mnt_clash, &nd->dentry->d_vfsmnt);
+	list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
 	list_add(&mnt->mnt_child, &nd->mnt->mnt_mounts);
+	nd->dentry->d_mounted++;
 }
 
 /**
@@ -458,7 +490,7 @@
 	spin_unlock(&dcache_lock);
 	if (mnt->mnt_devname)
 		kfree(mnt->mnt_devname);
-	kfree(mnt);
+	kmem_cache_free(mnt_cache, mnt);
 	kill_super(sb);
 }
 
@@ -998,13 +1030,13 @@
 
 	dev = get_unnamed_dev();
 	if (!dev) {
-		kfree(mnt);
+		kmem_cache_free(mnt_cache, mnt);
 		return ERR_PTR(-EMFILE);
 	}
 	sb = read_super(dev, NULL, type, 0, NULL, 0);
 	if (!sb) {
 		put_unnamed_dev(dev);
-		kfree(mnt);
+		kmem_cache_free(mnt_cache, mnt);
 		return ERR_PTR(-EINVAL);
 	}
 	mnt->mnt_sb = sb;
@@ -1282,7 +1314,7 @@
 	if (IS_ERR(sb)) {
 		if (mnt->mnt_devname)
 			kfree(mnt->mnt_devname);
-		kfree(mnt);
+		kmem_cache_free(mnt_cache, mnt);
 		goto fs_out;
 	}
 
@@ -1798,3 +1830,51 @@
 }
 
 #endif
+
+void __init mnt_init(unsigned long mempages)
+{
+	struct list_head *d;
+	unsigned long order;
+	unsigned int nr_hash;
+	int i;
+
+	mnt_cache = kmem_cache_create("mnt_cache", sizeof(struct vfsmount),
+					0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (!mnt_cache)
+		panic("Cannot create vfsmount cache");
+
+	mempages >>= (16 - PAGE_SHIFT);
+	mempages *= sizeof(struct list_head);
+	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
+		;
+
+	do {
+		unsigned long tmp;
+
+		nr_hash = (1UL << order) * PAGE_SIZE /
+			sizeof(struct list_head);
+		hash_mask = (nr_hash - 1);
+
+		tmp = nr_hash;
+		hash_bits = 0;
+		while ((tmp >>= 1UL) != 0UL)
+			hash_bits++;
+
+		mount_hashtable = (struct list_head *)
+			__get_free_pages(GFP_ATOMIC, order);
+	} while (mount_hashtable == NULL && --order >= 0);
+
+	printk("Mount-cache hash table entries: %d (order: %ld, %ld bytes)\n",
+			nr_hash, order, (PAGE_SIZE << order));
+
+	if (!mount_hashtable)
+		panic("Failed to allocate mount hash table\n");
+
+	d = mount_hashtable;
+	i = nr_hash;
+	do {
+		INIT_LIST_HEAD(d);
+		d++;
+		i--;
+	} while (i);
+}
diff -urN S6-pre1-graft_tree/include/linux/dcache.h S6-pre1-mntcache/include/linux/dcache.h
--- S6-pre1-graft_tree/include/linux/dcache.h	Thu May 31 16:02:00 2001
+++ S6-pre1-mntcache/include/linux/dcache.h	Tue Jun  5 08:18:05 2001
@@ -68,12 +68,12 @@
 	unsigned int d_flags;
 	struct inode  * d_inode;	/* Where the name belongs to - NULL is negative */
 	struct dentry * d_parent;	/* parent directory */
-	struct list_head d_vfsmnt;
 	struct list_head d_hash;	/* lookup hash list */
 	struct list_head d_lru;		/* d_count = 0 LRU list */
 	struct list_head d_child;	/* child of parent list */
 	struct list_head d_subdirs;	/* our children */
 	struct list_head d_alias;	/* inode alias list */
+	int d_mounted;
 	struct qstr d_name;
 	unsigned long d_time;		/* used by d_revalidate */
 	struct dentry_operations  *d_op;
@@ -265,9 +265,10 @@
 
 static __inline__ int d_mountpoint(struct dentry *dentry)
 {
-	return !list_empty(&dentry->d_vfsmnt);
+	return dentry->d_mounted;
 }
 
+extern struct vfsmount *lookup_mnt(struct vfsmount *, struct dentry *);
 #endif /* __KERNEL__ */
 
 #endif	/* __LINUX_DCACHE_H */
diff -urN S6-pre1-graft_tree/include/linux/fs.h S6-pre1-mntcache/include/linux/fs.h
--- S6-pre1-graft_tree/include/linux/fs.h	Thu May 31 17:38:38 2001
+++ S6-pre1-mntcache/include/linux/fs.h	Tue Jun  5 08:18:06 2001
@@ -204,6 +204,7 @@
 
 extern void buffer_init(unsigned long);
 extern void inode_init(unsigned long);
+extern void mnt_init(unsigned long);
 
 /* bh state bits */
 #define BH_Uptodate	0	/* 1 if the buffer contains valid data */
diff -urN S6-pre1-graft_tree/include/linux/mount.h S6-pre1-mntcache/include/linux/mount.h
--- S6-pre1-graft_tree/include/linux/mount.h	Fri May 25 21:51:15 2001
+++ S6-pre1-mntcache/include/linux/mount.h	Tue Jun  5 08:18:06 2001
@@ -14,12 +14,11 @@
 
 struct vfsmount
 {
+	struct list_head mnt_hash;
+	struct vfsmount *mnt_parent;	/* fs we are mounted on */
 	struct dentry *mnt_mountpoint;	/* dentry of mountpoint */
 	struct dentry *mnt_root;	/* root of the mounted tree */
-	struct vfsmount *mnt_parent;	/* fs we are mounted on */
 	struct list_head mnt_instances;	/* other vfsmounts of the same fs */
-	struct list_head mnt_clash;	/* those who are mounted on (other */
-					/* instances) of the same dentry */
 	struct super_block *mnt_sb;	/* pointer to superblock */
 	struct list_head mnt_mounts;	/* list of children, anchored here */
 	struct list_head mnt_child;	/* and going through their mnt_child */
diff -urN S6-pre1-graft_tree/kernel/ksyms.c S6-pre1-mntcache/kernel/ksyms.c
--- S6-pre1-graft_tree/kernel/ksyms.c	Tue Jun  5 06:21:52 2001
+++ S6-pre1-mntcache/kernel/ksyms.c	Tue Jun  5 08:18:06 2001
@@ -140,6 +140,7 @@
 EXPORT_SYMBOL(force_delete);
 EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(follow_down);
+EXPORT_SYMBOL(lookup_mnt);
 EXPORT_SYMBOL(path_init);
 EXPORT_SYMBOL(path_walk);
 EXPORT_SYMBOL(path_release);

