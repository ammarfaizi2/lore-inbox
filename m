Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262625AbSJDRO5>; Fri, 4 Oct 2002 13:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262645AbSJDROn>; Fri, 4 Oct 2002 13:14:43 -0400
Received: from [198.149.18.6] ([198.149.18.6]:19850 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262625AbSJDRNK>;
	Fri, 4 Oct 2002 13:13:10 -0400
Date: Fri, 4 Oct 2002 20:33:10 -0400
From: Christoph Hellwig <hch@sgi.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][4th RESENT] kill dentry<->fh conversation code duplication
Message-ID: <20021004203310.D9813@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all filesystems that have custom operations for filehandle
to dentry and vice versa conversation duplicate the code to get
a dentry for a given inode.  That's about 20 lines of code each time
and XFS introduces even more duplicates.

In 2.5 we have a function, d_alloc_anon to do that and this patches
adds it to 2.3 aswell.  The implementation is exactly the same as
the old code and thus very different from 2.5, which has additional
intrusive infrastructure for better NFS handling.


diff -uNr -Xdontdiff -p linux-2.4.20-pre4/fs/dcache.c linux/fs/dcache.c
--- linux-2.4.20-pre4/fs/dcache.c	Sat Aug 17 14:54:38 2002
+++ linux/fs/dcache.c	Tue Aug 20 11:39:48 2002
@@ -242,24 +242,22 @@ struct dentry * dget_locked(struct dentr
 
 struct dentry * d_find_alias(struct inode *inode)
 {
-	struct list_head *head, *next, *tmp;
-	struct dentry *alias;
+	struct dentry *dentry;
+	struct list_head *p;
 
 	spin_lock(&dcache_lock);
-	head = &inode->i_dentry;
-	next = inode->i_dentry.next;
-	while (next != head) {
-		tmp = next;
-		next = tmp->next;
-		alias = list_entry(tmp, struct dentry, d_alias);
-		if (!list_empty(&alias->d_hash)) {
-			__dget_locked(alias);
-			spin_unlock(&dcache_lock);
-			return alias;
-		}
+	list_for_each(p, &inode->i_dentry) {
+		dentry = list_entry(p, struct dentry, d_alias);
+		if (!list_empty(&dentry->d_hash))
+			goto found;
 	}
 	spin_unlock(&dcache_lock);
 	return NULL;
+
+found:
+	__dget_locked(dentry);
+	spin_unlock(&dcache_lock);
+	return dentry;
 }
 
 /*
@@ -659,6 +657,53 @@ void d_instantiate(struct dentry *entry,
 }
 
 /**
+ * d_alloc_anon - allocate an anonymous dentry
+ * @inode: inode to allocate the dentry for
+ *
+ * This is similar to d_alloc_root.  It is used by filesystems when
+ * creating a dentry for a given inode, often in the process of 
+ * mapping a filehandle to a dentry.  The returned dentry may be
+ * anonymous, or may have a full name (if the inode was already
+ * in the cache).  The file system may need to make further
+ * efforts to connect this dentry into the dcache properly.
+ *
+ * When called on a directory inode, we must ensure that
+ * the inode only ever has one dentry.  If a dentry is
+ * found, that is returned instead of allocating a new one.
+ *
+ * On successful return, the reference to the inode has been transferred
+ * to the dentry.  If %NULL is returned (indicating kmalloc failure),
+ * the reference on the inode has not been released.
+ */
+
+struct dentry * d_alloc_anon(struct inode *inode)
+{
+	struct dentry *dentry;
+	struct list_head *p;
+
+	/* Try to find a dentry.  If possible, get a well-connected one. */
+	spin_lock(&dcache_lock);
+	list_for_each(p, &inode->i_dentry) {
+		dentry = list_entry(p, struct dentry, d_alias);
+		if (!(dentry->d_flags & DCACHE_NFSD_DISCONNECTED))
+			goto found;
+	}
+	spin_unlock(&dcache_lock);
+
+	/* Didn't find dentry.  Create anonymous dcache entry. */
+	dentry = d_alloc_root(inode);
+	if (dentry)
+		dentry->d_flags |= DCACHE_NFSD_DISCONNECTED;
+	return dentry;
+
+found:
+	dget_locked(dentry);
+	spin_unlock(&dcache_lock);
+	iput(inode);
+	return dentry;
+}
+
+/**
  * d_alloc_root - allocate root dentry
  * @root_inode: inode to allocate the root for
  *
diff -uNr -Xdontdiff -p linux-2.4.20-pre4/fs/fat/inode.c linux/fs/fat/inode.c
--- linux-2.4.20-pre4/fs/fat/inode.c	Tue Aug  6 11:30:30 2002
+++ linux/fs/fat/inode.c	Tue Aug 20 11:39:48 2002
@@ -430,7 +430,6 @@ struct dentry *fat_fh_to_dentry(struct s
 				int len, int fhtype, int parent)
 {
 	struct inode *inode = NULL;
-	struct list_head *lp;
 	struct dentry *result;
 
 	if (fhtype != 3)
@@ -477,33 +476,14 @@ struct dentry *fat_fh_to_dentry(struct s
 	if (!inode)
 		return ERR_PTR(-ESTALE);
 
-	
-	/* now to find a dentry.
-	 * If possible, get a well-connected one
-	 *
-	 * Given the way that we found the inode, it *MUST* be
-	 * well-connected, but it is easiest to just copy the
-	 * code.
-	 */
-	spin_lock(&dcache_lock);
-	for (lp = inode->i_dentry.next; lp != &inode->i_dentry ; lp=lp->next) {
-		result = list_entry(lp,struct dentry, d_alias);
-		if (! (result->d_flags & DCACHE_NFSD_DISCONNECTED)) {
-			dget_locked(result);
-			result->d_vfs_flags |= DCACHE_REFERENCED;
-			spin_unlock(&dcache_lock);
-			iput(inode);
-			return result;
-		}
-	}
-	spin_unlock(&dcache_lock);
-	result = d_alloc_root(inode);
+
+	result = d_alloc_anon(inode);
 	if (result == NULL) {
 		iput(inode);
 		return ERR_PTR(-ENOMEM);
 	}
 	result->d_op = sb->s_root->d_op;
-	result->d_flags |= DCACHE_NFSD_DISCONNECTED;
+	result->d_vfs_flags |= DCACHE_REFERENCED;
 	return result;
 
 		
diff -uNr -Xdontdiff -p linux-2.4.20-pre4/fs/nfsd/nfsfh.c linux/fs/nfsd/nfsfh.c
--- linux-2.4.20-pre4/fs/nfsd/nfsfh.c	Tue Aug 13 15:56:00 2002
+++ linux/fs/nfsd/nfsfh.c	Tue Aug 20 11:39:48 2002
@@ -135,7 +135,6 @@ static struct dentry *nfsd_iget(struct s
 	 * of 0 means "accept any"
 	 */
 	struct inode *inode;
-	struct list_head *lp;
 	struct dentry *result;
 	if (ino == 0)
 		return ERR_PTR(-ESTALE);
@@ -155,27 +154,14 @@ static struct dentry *nfsd_iget(struct s
 		iput(inode);
 		return ERR_PTR(-ESTALE);
 	}
-	/* now to find a dentry.
-	 * If possible, get a well-connected one
-	 */
-	spin_lock(&dcache_lock);
-	for (lp = inode->i_dentry.next; lp != &inode->i_dentry ; lp=lp->next) {
-		result = list_entry(lp,struct dentry, d_alias);
-		if (! (result->d_flags & DCACHE_NFSD_DISCONNECTED)) {
-			dget_locked(result);
-			result->d_vfs_flags |= DCACHE_REFERENCED;
-			spin_unlock(&dcache_lock);
-			iput(inode);
-			return result;
-		}
-	}
-	spin_unlock(&dcache_lock);
-	result = d_alloc_root(inode);
+
+
+	result = d_alloc_anon(inode);
 	if (result == NULL) {
 		iput(inode);
 		return ERR_PTR(-ENOMEM);
 	}
-	result->d_flags |= DCACHE_NFSD_DISCONNECTED;
+	result->d_vfs_flags |= DCACHE_REFERENCED;
 	return result;
 }
 
diff -uNr -Xdontdiff -p linux-2.4.20-pre4/fs/reiserfs/inode.c linux/fs/reiserfs/inode.c
--- linux-2.4.20-pre4/fs/reiserfs/inode.c	Tue Aug 13 15:56:01 2002
+++ linux/fs/reiserfs/inode.c	Tue Aug 20 11:39:48 2002
@@ -1229,7 +1229,6 @@ struct dentry *reiserfs_fh_to_dentry(str
 				     int len, int fhtype, int parent) {
     struct cpu_key key ;
     struct inode *inode = NULL ;
-    struct list_head *lp;
     struct dentry *result;
 
     /* fhtype happens to reflect the number of u32s encoded.
@@ -1281,27 +1280,12 @@ out:
     if (!inode)
         return ERR_PTR(-ESTALE) ;
 
-    /* now to find a dentry.
-     * If possible, get a well-connected one
-     */
-    spin_lock(&dcache_lock);
-    for (lp = inode->i_dentry.next; lp != &inode->i_dentry ; lp=lp->next) {
-	    result = list_entry(lp,struct dentry, d_alias);
-	    if (! (result->d_flags & DCACHE_NFSD_DISCONNECTED)) {
-		    dget_locked(result);
-		    result->d_vfs_flags |= DCACHE_REFERENCED;
-		    spin_unlock(&dcache_lock);
-		    iput(inode);
-		    return result;
-	    }
-    }
-    spin_unlock(&dcache_lock);
-    result = d_alloc_root(inode);
+    result = d_alloc_anon(inode);
     if (result == NULL) {
 	    iput(inode);
 	    return ERR_PTR(-ENOMEM);
     }
-    result->d_flags |= DCACHE_NFSD_DISCONNECTED;
+    result->d_vfs_flags |= DCACHE_REFERENCED;
     return result;
 
 }
diff -uNr -Xdontdiff -p linux-2.4.20-pre4/include/linux/dcache.h linux/include/linux/dcache.h
--- linux-2.4.20-pre4/include/linux/dcache.h	Tue Aug  6 11:30:41 2002
+++ linux/include/linux/dcache.h	Tue Aug 20 15:26:38 2002
@@ -165,6 +165,7 @@ extern void d_delete(struct dentry *);
 
 /* allocate/de-allocate */
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
+extern struct dentry * d_alloc_anon(struct inode *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
 extern int d_invalidate(struct dentry *);
diff -uNr -Xdontdiff -p linux-2.4.20-pre4/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.4.20-pre4/kernel/ksyms.c	Tue Aug 13 15:56:05 2002
+++ linux/kernel/ksyms.c	Sun Aug 25 19:32:04 2002
@@ -162,6 +162,7 @@ EXPORT_SYMBOL(d_invalidate);	/* May be i
 EXPORT_SYMBOL(d_move);
 EXPORT_SYMBOL(d_instantiate);
 EXPORT_SYMBOL(d_alloc);
+EXPORT_SYMBOL(d_alloc_anon);
 EXPORT_SYMBOL(d_lookup);
 EXPORT_SYMBOL(__d_path);
 EXPORT_SYMBOL(mark_buffer_dirty);
