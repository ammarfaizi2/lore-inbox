Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264202AbUEHJYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbUEHJYY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 05:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264201AbUEHJYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 05:24:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:8888 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264200AbUEHJXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 05:23:40 -0400
Date: Sat, 8 May 2004 02:23:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: manfred@colorfullife.com, davej@redhat.com, torvalds@osdl.org,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-Id: <20040508022304.17779635.akpm@osdl.org>
In-Reply-To: <20040508012357.3559fb6e.akpm@osdl.org>
References: <20040506200027.GC26679@redhat.com>
	<20040506150944.126bb409.akpm@osdl.org>
	<409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> There are a couple of things I don't understand in the dentry name handling:
> 
>  a) How come switch_names does a memcpy of d_iname even if the name might
>     not be in there?

OK, just in case the target dentry was internal.

>  b) Why does d_alloc() resize the storage for the out-of-line name to the
>     next multiple of 16?

No reason I can see.

>  c) Why is it that when we generate an out-of-line name we allocate a
>     complete new qstr rather than just storage for the name?  The dentry has
>     a whole qstr just sitting there doing nothing, and from a quick squizz
>     it seems that we could simply remove dentry.d_qstr, make
>     dentry.d_name.name point at the kmalloced name and not allocate all the
>     other parts of the qstr?

Great idea!  Here be another patch.




When dentries are given an external name we currently allocate an entire qstr
for the external name.

This isn't needed.  We can use the internal qstr and kmalloc only the string
itself.  This saves 12 bytes from externally-allocated names and 4 bytes from
the dentry itself.

The saving of 4 bytes from the dentry doesn't actually decrease the dentry's
storage requirements, but it makes four more bytes available for internal
names, taking the internal/external ratio from 89% up to 93% on my 1.5M files.


---

 25-akpm/fs/dcache.c            |   94 +++++++++++++++++++++--------------------
 25-akpm/include/linux/dcache.h |    8 +--
 2 files changed, 53 insertions(+), 49 deletions(-)

diff -puN include/linux/dcache.h~dentry-qstr-consolidation include/linux/dcache.h
--- 25/include/linux/dcache.h~dentry-qstr-consolidation	2004-05-08 02:16:19.700418088 -0700
+++ 25-akpm/include/linux/dcache.h	2004-05-08 02:16:19.706417176 -0700
@@ -29,10 +29,9 @@ struct vfsmount;
  * saves "metadata" about the string (ie length and the hash).
  */
 struct qstr {
-	const unsigned char * name;
+	const unsigned char *name;
 	unsigned int len;
 	unsigned int hash;
-	char name_str[0];
 };
 
 struct dentry_stat_t {
@@ -94,7 +93,6 @@ struct dentry {
  	struct rcu_head d_rcu;
 	struct dcookie_struct * d_cookie; /* cookie, if any */
 	unsigned long d_move_count;	/* to indicated moved dentry while lockless lookup */
-	struct qstr * d_qstr;		/* quick str ptr used in lockless lookup and concurrent d_move */
 	struct dentry * d_parent;	/* parent directory */
 	struct qstr d_name;
 	struct hlist_node d_hash;	/* lookup hash list */	
@@ -184,9 +182,9 @@ static inline void d_drop(struct dentry 
 	spin_unlock(&dcache_lock);
 }
 
-static inline int dname_external(struct dentry *d)
+static inline int dname_external(struct dentry *dentry)
 {
-	return d->d_name.name != d->d_iname; 
+	return dentry->d_name.name != dentry->d_iname;
 }
 
 /*
diff -puN fs/dcache.c~dentry-qstr-consolidation fs/dcache.c
--- 25/fs/dcache.c~dentry-qstr-consolidation	2004-05-08 02:16:19.702417784 -0700
+++ 25-akpm/fs/dcache.c	2004-05-08 02:16:19.709416720 -0700
@@ -73,9 +73,8 @@ static void d_callback(void *arg)
 {
 	struct dentry * dentry = (struct dentry *)arg;
 
-	if (dname_external(dentry)) {
-		kfree(dentry->d_qstr);
-	}
+	if (dname_external(dentry))
+		kfree(dentry->d_name.name);
 	kmem_cache_free(dentry_cache, dentry); 
 }
 
@@ -682,34 +681,30 @@ static int shrink_dcache_memory(int nr, 
  * copied and the copy passed in may be reused after this call.
  */
  
-struct dentry * d_alloc(struct dentry * parent, const struct qstr *name)
+struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 {
-	char * str;
 	struct dentry *dentry;
-	struct qstr * qstr;
+	char *dname;
 
 	dentry = kmem_cache_alloc(dentry_cache, GFP_KERNEL); 
 	if (!dentry)
 		return NULL;
 
 	if (name->len > DNAME_INLINE_LEN-1) {
-		qstr = kmalloc(sizeof(*qstr) + name->len + 1, GFP_KERNEL);
-		if (!qstr) {
+		dname = kmalloc(name->len + 1, GFP_KERNEL);
+		if (!dname) {
 			kmem_cache_free(dentry_cache, dentry); 
 			return NULL;
 		}
-		qstr->name = qstr->name_str;
-		qstr->len = name->len;
-		qstr->hash = name->hash;
-		dentry->d_qstr = qstr;
-		str = qstr->name_str;
 	} else  {
-		dentry->d_qstr = &dentry->d_name;
-		str = dentry->d_iname;
+		dname = dentry->d_iname;
 	}	
+	dentry->d_name.name = dname;
 
-	memcpy(str, name->name, name->len);
-	str[name->len] = 0;
+	dentry->d_name.len = name->len;
+	dentry->d_name.hash = name->hash;
+	memcpy(dname, name->name, name->len);
+	dname[name->len] = 0;
 
 	atomic_set(&dentry->d_count, 1);
 	dentry->d_vfs_flags = DCACHE_UNHASHED;
@@ -719,9 +714,6 @@ struct dentry * d_alloc(struct dentry * 
 	dentry->d_parent = NULL;
 	dentry->d_move_count = 0;
 	dentry->d_sb = NULL;
-	dentry->d_name.name = str;
-	dentry->d_name.len = name->len;
-	dentry->d_name.hash = name->hash;
 	dentry->d_op = NULL;
 	dentry->d_fsdata = NULL;
 	dentry->d_mounted = 0;
@@ -788,7 +780,8 @@ struct dentry * d_alloc_root(struct inod
 	struct dentry *res = NULL;
 
 	if (root_inode) {
-		static const struct qstr name = { .name = "/", .len = 1, .hash = 0 };
+		static const struct qstr name = { .name = "/", .len = 1 };
+
 		res = d_alloc(NULL, &name);
 		if (res) {
 			res->d_sb = root_inode->i_sb;
@@ -829,7 +822,7 @@ static inline struct hlist_head *d_hash(
 
 struct dentry * d_alloc_anon(struct inode *inode)
 {
-	static const struct qstr anonstring = { "", 0, 0};
+	static const struct qstr anonstring = { .name = "" };
 	struct dentry *tmp;
 	struct dentry *res;
 
@@ -1003,7 +996,7 @@ struct dentry * __d_lookup(struct dentry
 		if (dentry->d_parent != parent)
 			continue;
 
-		qstr = dentry->d_qstr;
+		qstr = &dentry->d_name;
 		smp_read_barrier_depends();
 		if (parent->d_op && parent->d_op->d_compare) {
 			if (parent->d_op->d_compare(parent, qstr, name))
@@ -1145,28 +1138,40 @@ void d_rehash(struct dentry * entry)
  * then no longer matches the actual (corrupted) string of the target.
  * The hash value has to match the hash queue that the dentry is on..
  */
-static inline void switch_names(struct dentry * dentry, struct dentry * target)
+static inline void switch_names(struct dentry *dentry, struct dentry *target)
 {
-	const unsigned char *old_name, *new_name;
-	struct qstr *old_qstr, *new_qstr;
-
-	memcpy(dentry->d_iname, target->d_iname, DNAME_INLINE_LEN); 
-	old_qstr = target->d_qstr;
-	old_name = target->d_name.name;
-	new_qstr = dentry->d_qstr;
-	new_name = dentry->d_name.name;
-	if (old_name == target->d_iname) {
-		old_name = dentry->d_iname;
-		old_qstr = &dentry->d_name;
-	}
-	if (new_name == dentry->d_iname) {
-		new_name = target->d_iname;
-		new_qstr = &target->d_name;
-	}
-	target->d_name.name = new_name;
-	dentry->d_name.name = old_name;
-	target->d_qstr = new_qstr;
-	dentry->d_qstr = old_qstr;
+	if (dname_external(target)) {
+		if (dname_external(dentry)) {
+			/*
+			 * Both external: swap the pointers
+			 */
+			do_switch(target->d_name.name, dentry->d_name.name);
+		} else {
+			/*
+			 * dentry:internal, target:external.  Steal target's
+			 * storage and make target internal.
+			 */
+			dentry->d_name.name = target->d_name.name;
+			target->d_name.name = target->d_iname;
+		}
+	} else {
+		if (dname_external(dentry)) {
+			/*
+			 * dentry:external, target:internal.  Give dentry's
+			 * storage to target and make dentry internal
+			 */
+			memcpy(dentry->d_iname, target->d_name.name,
+					target->d_name.len + 1);
+			target->d_name.name = dentry->d_name.name;
+			dentry->d_name.name = dentry->d_iname;
+		} else {
+			/*
+			 * Both are internal.  Just copy target to dentry
+			 */
+			memcpy(dentry->d_iname, target->d_name.name,
+					target->d_name.len + 1);
+		}
+	}
 }
 
 /*
@@ -1342,6 +1347,7 @@ char * d_path(struct dentry *dentry, str
 	char *res;
 	struct vfsmount *rootmnt;
 	struct dentry *root;
+
 	read_lock(&current->fs->lock);
 	rootmnt = mntget(current->fs->rootmnt);
 	root = dget(current->fs->root);

_

