Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSEaI3D>; Fri, 31 May 2002 04:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSEaI3C>; Fri, 31 May 2002 04:29:02 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:21481 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315204AbSEaI27>;
	Fri, 31 May 2002 04:28:59 -0400
Date: Fri, 31 May 2002 11:28:06 +0300
From: Dan Aloni <da-x@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] dcache.{c,h} cleanup
Message-ID: <20020531082806.GA4053@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/dcache.h:
 + change __inline__ to inline
 + use list_del_init() instead of list_del() + INIT_LIST_HEAD()
 + remove #define for obsolete shrink_dcache()
 + remove obsolete forward declaration of struct zone_struct.

fs/dcache.c:
 + use d_unhashed() instead of list_empty(&dentry->d_hash) 
 + document d_free().
 + renamed dentry_iput() to d_iput(), for naming and prefix consistency.
 + added d_release() in order to refactor dput() and prune_one_dentry(). 
 + modified dput() to use d_release().
 + modified prune_one_dentry() to use d_release().


--- 2.5.19/include/linux/dcache.h	Thu May 30 22:35:11 2002
+++ 2.5.19/include/linux/dcache.h	Fri May 31 09:12:33 2002
@@ -44,19 +44,19 @@
 #define init_name_hash()		0
 
 /* partial hash update function. Assume roughly 4 bits per character */
-static __inline__ unsigned long partial_name_hash(unsigned long c, unsigned long prevhash)
+static inline unsigned long partial_name_hash(unsigned long c, unsigned long prevhash)
 {
 	return (prevhash + (c << 4) + (c >> 4)) * 11;
 }
 
 /* Finally: cut down the number of bits to a int value (and try to avoid losing bits) */
-static __inline__ unsigned long end_name_hash(unsigned long hash)
+static inline unsigned long end_name_hash(unsigned long hash)
 {
 	return (unsigned int) hash;
 }
 
 /* Compute the hash for a name string. */
-static __inline__ unsigned int full_name_hash(const unsigned char * name, unsigned int len)
+static inline unsigned int full_name_hash(const unsigned char * name, unsigned int len)
 {
 	unsigned long hash = init_name_hash();
 	while (len--)
@@ -153,15 +153,14 @@
  * timeouts or autofs deletes).
  */
 
-static __inline__ void d_drop(struct dentry * dentry)
+static inline void d_drop(struct dentry * dentry)
 {
 	spin_lock(&dcache_lock);
-	list_del(&dentry->d_hash);
-	INIT_LIST_HEAD(&dentry->d_hash);
+	list_del_init(&dentry->d_hash);
 	spin_unlock(&dcache_lock);
 }
 
-static __inline__ int dname_external(struct dentry *d)
+static inline int dname_external(struct dentry *d)
 {
 	return d->d_name.name != d->d_iname; 
 }
@@ -181,8 +180,6 @@
 extern void shrink_dcache_anon(struct list_head *);
 extern int d_invalidate(struct dentry *);
 
-#define shrink_dcache() prune_dcache(0)
-struct zone_struct;
 /* dcache memory management */
 extern int shrink_dcache_memory(int, unsigned int);
 extern void prune_dcache(int);
@@ -220,7 +217,7 @@
  * The entry was actually filled in earlier during d_alloc().
  */
  
-static __inline__ void d_add(struct dentry * entry, struct inode * inode)
+static inline void d_add(struct dentry * entry, struct inode * inode)
 {
 	d_instantiate(entry, inode);
 	d_rehash(entry);
@@ -254,7 +251,7 @@
  *	and call dget_locked() instead of dget().
  */
  
-static __inline__ struct dentry * dget(struct dentry *dentry)
+static inline struct dentry * dget(struct dentry *dentry)
 {
 	if (dentry) {
 		if (!atomic_read(&dentry->d_count))
@@ -273,14 +270,14 @@
  *	Returns true if the dentry passed is not currently hashed.
  */
  
-static __inline__ int d_unhashed(struct dentry *dentry)
+static inline int d_unhashed(struct dentry *dentry)
 {
 	return list_empty(&dentry->d_hash);
 }
 
 extern void dput(struct dentry *);
 
-static __inline__ int d_mountpoint(struct dentry *dentry)
+static inline int d_mountpoint(struct dentry *dentry)
 {
 	return dentry->d_mounted;
 }




--- 2.5.19/fs/dcache.c	Thu May 30 22:35:37 2002
+++ 2.5.19/fs/dcache.c	Fri May 31 09:12:16 2002
@@ -53,7 +53,13 @@
 /* Statistics gathering. */
 struct dentry_stat_t dentry_stat = {0, 0, 45, 0,};
 
-/* no dcache_lock, please */
+/*
+ * Frees the dentry. Calls the filesystem d_release() if defined. 
+ * Frees the dentry name and the dentry from the kmem_cache.
+ *
+ * Call restrictions: dcache_lock not helded.
+ * Return state: 'dentry' is invalid.
+ */
 static inline void d_free(struct dentry *dentry)
 {
 	if (dentry->d_op && dentry->d_op->d_release)
@@ -67,9 +73,11 @@
 /*
  * Release the dentry's inode, using the filesystem
  * d_iput() operation if defined.
- * Called with dcache_lock held, drops it.
+ *
+ * Call restrictions: dcache_lock held.
+ * Return state; dcache_lock not held.
  */
-static inline void dentry_iput(struct dentry * dentry)
+static inline void d_iput(struct dentry * dentry)
 {
 	struct inode *inode = dentry->d_inode;
 	if (inode) {
@@ -84,6 +92,30 @@
 		spin_unlock(&dcache_lock);
 }
 
+/*
+ * Releases a dentry - unlink from parent, free the inode, 
+ * free the entry, and return the parent.
+ * This requires that the LRU list has already been removed.
+ *
+ * Call restrictions: dcache_lock held.
+ * Return state; dcache_lock not held.
+ */
+static inline struct dentry *d_release(struct dentry *dentry)
+{
+	struct dentry *parent;
+
+	list_del_init(&dentry->d_hash);
+	list_del(&dentry->d_child);
+
+	/* drops the lock, at that point nobody can reach this dentry */
+	d_iput(dentry);
+
+	parent = dentry->d_parent;
+	d_free(dentry);
+
+	return parent;
+}
+
 /* 
  * This is dput
  *
@@ -115,6 +147,8 @@
 
 void dput(struct dentry *dentry)
 {
+	struct dentry *parent;
+
 	if (!dentry)
 		return;
 
@@ -130,31 +164,23 @@
 	 */
 	if (dentry->d_op && dentry->d_op->d_delete) {
 		if (dentry->d_op->d_delete(dentry))
-			goto unhash_it;
+			goto kill_it;
 	}
 	/* Unreachable? Get rid of it */
-	if (list_empty(&dentry->d_hash))
+	if (d_unhashed(dentry))
 		goto kill_it;
 	list_add(&dentry->d_lru, &dentry_unused);
 	dentry_stat.nr_unused++;
 	spin_unlock(&dcache_lock);
 	return;
 
-unhash_it:
-	list_del_init(&dentry->d_hash);
+kill_it:
+	parent = d_release(dentry);
+	if (dentry == parent) 
+		return;
 
-kill_it: {
-		struct dentry *parent;
-		list_del(&dentry->d_child);
-		/* drops the lock, at that point nobody can reach this dentry */
-		dentry_iput(dentry);
-		parent = dentry->d_parent;
-		d_free(dentry);
-		if (dentry == parent)
-			return;
-		dentry = parent;
-		goto repeat;
-	}
+	dentry = parent;
+	goto repeat;
 }
 
 /**
@@ -175,7 +201,7 @@
 	 * If it's already been dropped, return OK.
 	 */
 	spin_lock(&dcache_lock);
-	if (list_empty(&dentry->d_hash)) {
+	if (d_unhashed(dentry)) {
 		spin_unlock(&dcache_lock);
 		return 0;
 	}
@@ -253,7 +279,7 @@
 		tmp = next;
 		next = tmp->next;
 		alias = list_entry(tmp, struct dentry, d_alias);
-		if (!list_empty(&alias->d_hash)) {
+		if (!d_unhashed(alias)) {
 			if (alias->d_flags & DCACHE_DISCONNECTED)
 				discon_alias = alias;
 			else {
@@ -302,11 +328,7 @@
 {
 	struct dentry * parent;
 
-	list_del_init(&dentry->d_hash);
-	list_del(&dentry->d_child);
-	dentry_iput(dentry);
-	parent = dentry->d_parent;
-	d_free(dentry);
+	parent = d_release(dentry);
 	if (parent != dentry)
 		dput(parent);
 	spin_lock(&dcache_lock);
@@ -589,7 +611,7 @@
 	 * Nasty deadlock avoidance.
 	 *
 	 * ext2_new_block->getblk->GFP->shrink_dcache_memory->prune_dcache->
-	 * prune_one_dentry->dput->dentry_iput->iput->inode->i_sb->s_op->
+	 * prune_one_dentry->dput->d_iput->iput->inode->i_sb->s_op->
 	 * put_inode->ext2_discard_prealloc->ext2_free_blocks->lock_super->
 	 * DEADLOCK.
 	 *
@@ -960,7 +982,7 @@
 	 */
 	spin_lock(&dcache_lock);
 	if (atomic_read(&dentry->d_count) == 1) {
-		dentry_iput(dentry);
+		d_iput(dentry);
 		return;
 	}
 	spin_unlock(&dcache_lock);
@@ -982,7 +1004,7 @@
 void d_rehash(struct dentry * entry)
 {
 	struct list_head *list = d_hash(entry->d_parent, entry->d_name.hash);
-	if (!list_empty(&entry->d_hash)) BUG();
+	if (!d_unhashed(entry)) BUG();
 	spin_lock(&dcache_lock);
 	list_add(&entry->d_hash, list);
 	spin_unlock(&dcache_lock);
@@ -1106,7 +1128,7 @@
 
 	*--end = '\0';
 	buflen--;
-	if (!IS_ROOT(dentry) && list_empty(&dentry->d_hash)) {
+	if (!IS_ROOT(dentry) && d_unhashed(dentry)) {
 		buflen -= 10;
 		end -= 10;
 		memcpy(end, " (deleted)", 10);
@@ -1189,7 +1211,7 @@
 	error = -ENOENT;
 	/* Has the current directory has been unlinked? */
 	spin_lock(&dcache_lock);
-	if (pwd->d_parent == pwd || !list_empty(&pwd->d_hash)) {
+	if (pwd->d_parent == pwd || !d_unhashed(pwd)) {
 		unsigned long len;
 		char * cwd;
 



-- 
Dan Aloni
da-x@gmx.net
