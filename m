Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263288AbTC0QkE>; Thu, 27 Mar 2003 11:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263290AbTC0QkD>; Thu, 27 Mar 2003 11:40:03 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:59916 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263288AbTC0Qj7>; Thu, 27 Mar 2003 11:39:59 -0500
Date: Thu, 27 Mar 2003 16:51:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] d_alloc_anon for 2.4.21-pre6
Message-ID: <20030327165112.A2395@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Mar 26, 2003 at 09:08:42PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[$BIGNUM repost since August 2002, still zero feedback]

The rewritten 2.5 nfsd export handling introduce a funcion,
d_alloc_anon, to get an dentry for a given inode, either taking
a well-connected one or allocating a new one.

In 2.4 we have the functionality that it does in 2.4 duplicated over
nfsd and all filesystems having their own fh_to_dentry method, and
XFS needs even more instances of this for other handle to dentry
conversations.

This patch adds d_alloc_anon with exactly the same API as in 2.5, but
the 2.4ish functionality instead to the kernel and switches nfsd, fat
and reiserfs over to it.


--- 1.22/fs/dcache.c	Thu Jan 23 10:55:22 2003
+++ edited/fs/dcache.c	Thu Mar 27 10:22:35 2003
@@ -659,6 +659,53 @@
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
===== fs/fat/inode.c 1.13 vs edited =====
--- 1.13/fs/fat/inode.c	Thu Apr  4 21:31:14 2002
+++ edited/fs/fat/inode.c	Thu Mar 27 10:22:35 2003
@@ -430,7 +430,6 @@
 				int len, int fhtype, int parent)
 {
 	struct inode *inode = NULL;
-	struct list_head *lp;
 	struct dentry *result;
 
 	if (fhtype != 3)
@@ -477,33 +476,14 @@
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
 
 		
===== fs/nfsd/nfsfh.c 1.18 vs edited =====
--- 1.18/fs/nfsd/nfsfh.c	Mon Dec 16 17:50:09 2002
+++ edited/fs/nfsd/nfsfh.c	Thu Mar 27 10:22:35 2003
@@ -135,7 +135,6 @@
 	 * of 0 means "accept any"
 	 */
 	struct inode *inode;
-	struct list_head *lp;
 	struct dentry *result;
 	if (ino == 0)
 		return ERR_PTR(-ESTALE);
@@ -155,27 +154,14 @@
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
 
===== fs/reiserfs/inode.c 1.42 vs edited =====
--- 1.42/fs/reiserfs/inode.c	Thu Feb 13 07:42:42 2003
+++ edited/fs/reiserfs/inode.c	Thu Mar 27 10:22:35 2003
@@ -1249,7 +1249,6 @@
 				     int len, int fhtype, int parent) {
     struct cpu_key key ;
     struct inode *inode = NULL ;
-    struct list_head *lp;
     struct dentry *result;
 
     /* fhtype happens to reflect the number of u32s encoded.
@@ -1301,27 +1300,12 @@
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
===== include/linux/dcache.h 1.12 vs edited =====
--- 1.12/include/linux/dcache.h	Sat Aug  3 18:39:21 2002
+++ edited/include/linux/dcache.h	Thu Mar 27 15:42:26 2003
@@ -165,6 +165,7 @@
 
 /* allocate/de-allocate */
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
+extern struct dentry * d_alloc_anon(struct inode *);
 extern void shrink_dcache_sb(struct super_block *);
 extern void shrink_dcache_parent(struct dentry *);
 extern int d_invalidate(struct dentry *);
===== kernel/ksyms.c 1.67 vs edited =====
--- 1.67/kernel/ksyms.c	Tue Oct  1 14:34:41 2002
+++ edited/kernel/ksyms.c	Thu Mar 27 10:22:36 2003
@@ -164,6 +164,7 @@
 EXPORT_SYMBOL(d_move);
 EXPORT_SYMBOL(d_instantiate);
 EXPORT_SYMBOL(d_alloc);
+EXPORT_SYMBOL(d_alloc_anon);
 EXPORT_SYMBOL(d_lookup);
 EXPORT_SYMBOL(__d_path);
 EXPORT_SYMBOL(mark_buffer_dirty);
