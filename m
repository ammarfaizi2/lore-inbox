Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135946AbREABTO>; Mon, 30 Apr 2001 21:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135957AbREABS4>; Mon, 30 Apr 2001 21:18:56 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:13830
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S135946AbREABSj>; Mon, 30 Apr 2001 21:18:39 -0400
Date: Mon, 30 Apr 2001 21:18:01 -0400
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] yet another knfsd-reiserfs patch
Message-ID: <1037730000.988679881@tiny>
In-Reply-To: <244320000.988037114@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, April 23, 2001 10:45:14 AM -0400 Chris Mason <mason@suse.com> wrote:

> 
> Hi guys,
> 
> This patch is not meant to replace Neil Brown's knfsd ops stuff, the 
> goal was to whip up something that had a chance of getting into 2.4.x,
> and that might be usable by the AFS guys too.  Neil's patch tries to 
> address a bunch of things that I didn't, and looks better for the
> long run.
>

Ok, here it is updated to 2.4.4.  The only change was to adapt to the usage
of comp_short_keys in reiserfs_iget under 2.4.4.

-chris

diff -Nru a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
--- a/fs/nfsd/nfsfh.c	Sun Apr 29 18:01:04 2001
+++ b/fs/nfsd/nfsfh.c	Sun Apr 29 18:01:04 2001
@@ -116,40 +116,12 @@
 	return error;
 }
 
-/* this should be provided by each filesystem in an nfsd_operations interface as
- * iget isn't really the right interface
- */
-static struct dentry *nfsd_iget(struct super_block *sb, unsigned long ino, __u32 generation)
+static struct dentry *dentry_from_inode(struct inode *inode) 
 {
-
-	/* iget isn't really right if the inode is currently unallocated!!
-	 * This should really all be done inside each filesystem
-	 *
-	 * ext2fs' read_inode has been strengthed to return a bad_inode if the inode
-	 *   had been deleted.
-	 *
-	 * Currently we don't know the generation for parent directory, so a generation
-	 * of 0 means "accept any"
-	 */
-	struct inode *inode;
 	struct list_head *lp;
 	struct dentry *result;
-	inode = iget(sb, ino);
-	if (is_bad_inode(inode)
-	    || (generation && inode->i_generation != generation)
-		) {
-		/* we didn't find the right inode.. */
-		dprintk("fh_verify: Inode %lu, Bad count: %d %d or version  %u %u\n",
-			inode->i_ino,
-			inode->i_nlink, atomic_read(&inode->i_count),
-			inode->i_generation,
-			generation);
-
-		iput(inode);
-		return ERR_PTR(-ESTALE);
-	}
-	/* now to find a dentry.
-	 * If possible, get a well-connected one
+	/*
+	 * If possible, get a well-connected dentry
 	 */
 	spin_lock(&dcache_lock);
 	for (lp = inode->i_dentry.next; lp != &inode->i_dentry ; lp=lp->next) {
@@ -172,6 +144,92 @@
 	return result;
 }
 
+static struct inode *__inode_from_fh(struct super_block *sb, int ino,
+                                    int generation) 
+{
+	struct inode *inode ;
+
+	inode = iget(sb, ino);
+	if (is_bad_inode(inode)
+	    || (generation && inode->i_generation != generation)
+		) {
+		/* we didn't find the right inode.. */
+		dprintk("fh_verify: Inode %lu, Bad count: %d %d or version  %u %u\n",
+			inode->i_ino,
+			inode->i_nlink, atomic_read(&inode->i_count),
+			inode->i_generation,
+			generation);
+
+		iput(inode);
+		return ERR_PTR(-ESTALE);
+	}
+	return inode ;
+}
+
+static struct inode *inode_from_fh(struct super_block *sb, 
+                                               __u32 *datap,
+                                               int len)
+{
+	if (sb->s_op->inode_from_fh)
+		return sb->s_op->inode_from_fh(sb, datap, len) ;
+	return __inode_from_fh(sb, datap[0], datap[1]) ;
+}
+
+static struct inode *parent_from_fh(struct super_block *sb, 
+                                               __u32 *datap,
+                                               int len)
+{
+	if (sb->s_op->parent_from_fh)
+		return sb->s_op->parent_from_fh(sb, datap, len) ;
+
+	if (len >= 3)
+		return __inode_from_fh(sb, datap[2], 0) ;
+	return ERR_PTR(-ESTALE);
+}
+
+/* 
+ * two iget funcs, one for inode, and one for parent directory
+ *
+ * this should be provided by each filesystem in an nfsd_operations interface as
+ * iget isn't really the right interface
+ *
+ * If the filesystem doesn't provide funcs to get inodes from datap,
+ * it must be: inum, generation, dir inum.  Length of 2 means the 
+ * dir inum isn't there.
+ *
+ * iget isn't really right if the inode is currently unallocated!!
+ * This should really all be done inside each filesystem
+ *
+ * ext2fs' read_inode has been strengthed to return a bad_inode if the inode
+ *   had been deleted.
+ *
+ * Currently we don't know the generation for parent directory, so a generation
+ * of 0 means "accept any"
+ */
+static struct dentry *nfsd_iget(struct super_block *sb, __u32 *datap, int len)
+{
+
+	struct inode *inode;
+
+	inode = inode_from_fh(sb, datap, len) ;
+	if (IS_ERR(inode)) {
+	    return ERR_PTR(PTR_ERR(inode)) ;    
+	}	
+	return dentry_from_inode(inode) ;
+}
+
+static struct dentry *nfsd_parent_iget(struct super_block *sb, __u32 *datap, 
+                                       int len)
+{
+	struct inode *inode;
+
+	inode = parent_from_fh(sb, datap, len) ;
+	if (IS_ERR(inode))  {
+	    return ERR_PTR(PTR_ERR(inode)) ;    
+	}	
+	return dentry_from_inode(inode) ;
+}
+
 /* this routine links an IS_ROOT dentry into the dcache tree.  It gains "parent"
  * as a parent and "name" as a name
  * It should possibly go in dcache.c
@@ -339,9 +397,13 @@
  * We use nfsd_iget and if that doesn't return a suitably connected dentry,
  * we try to find the parent, and the parent of that and so-on until a
  * connection if made.
+ *
+ * If the filesystem doesn't provide funcs to get inodes from datap,
+ * it must be: inum, generation, dir inum.  Length of 2 means the 
+ * dir inum isn't there.
  */
 static struct dentry *
-find_fh_dentry(struct super_block *sb, ino_t ino, int generation, ino_t dirino, int needpath)
+find_fh_dentry(struct super_block *sb, __u32 *datap, int len, int needpath)
 {
 	struct dentry *dentry, *result = NULL;
 	struct dentry *tmp;
@@ -361,7 +423,7 @@
 	 */
  retry:
 	down(&sb->s_nfsd_free_path_sem);
-	result = nfsd_iget(sb, ino, generation);
+	result = nfsd_iget(sb, datap, len) ;
 	if (IS_ERR(result)
 	    || !(result->d_flags & DCACHE_NFSD_DISCONNECTED)
 	    || (!S_ISDIR(result->d_inode->i_mode) && ! needpath)) {
@@ -378,37 +440,36 @@
 	/* It's a directory, or we are required to confirm the file's
 	 * location in the tree.
 	 */
-	dprintk("nfs_fh: need to look harder for %d/%ld\n",sb->s_dev,ino);
+	dprintk("nfs_fh: need to look harder for %d/%ld\n",sb->s_dev,result->d_inode->i_ino);
 
 	found = 0;
 	if (!S_ISDIR(result->d_inode->i_mode)) {
 		nfsdstats.fh_nocache_nondir++;
-		if (dirino == 0)
-			goto err_result; /* don't know how to find parent */
-		else {
-			/* need to iget dirino and make sure this inode is in that directory */
-			dentry = nfsd_iget(sb, dirino, 0);
-			err = PTR_ERR(dentry);
-			if (IS_ERR(dentry))
-				goto err_result;
-			err = -ESTALE;
-			if (!dentry->d_inode
-			    || !S_ISDIR(dentry->d_inode->i_mode)) {
-				goto err_dentry;
-			}
-			if (!(dentry->d_flags & DCACHE_NFSD_DISCONNECTED))
-				found = 1;
-			tmp = splice(result, dentry);
-			err = PTR_ERR(tmp);
-			if (IS_ERR(tmp))
-				goto err_dentry;
-			if (tmp != result) {
-				/* it is safe to just use tmp instead, but we must discard result first */
-				d_drop(result);
-				dput(result);
-				result = tmp;
-				/* If !found, then this is really wierd, but it shouldn't hurt */
-			}
+		/* need to iget dirino and make sure this inode is in that 
+		 * directory .  nfsd_parent_iget returns -ESTALE when the
+		 * parent directory inum wasn't provided
+		 */
+		dentry = nfsd_parent_iget(sb, datap, len) ;
+		err = PTR_ERR(dentry);
+		if (IS_ERR(dentry))
+			goto err_result;
+		err = -ESTALE;
+		if (!dentry->d_inode
+		    || !S_ISDIR(dentry->d_inode->i_mode)) {
+			goto err_dentry;
+		}
+		if (!(dentry->d_flags & DCACHE_NFSD_DISCONNECTED))
+			found = 1;
+		tmp = splice(result, dentry);
+		err = PTR_ERR(tmp);
+		if (IS_ERR(tmp))
+			goto err_dentry;
+		if (tmp != result) {
+			/* it is safe to just use tmp instead, but we must discard result first */
+			d_drop(result);
+			dput(result);
+			result = tmp;
+			/* If !found, then this is really wierd, but it shouldn't hurt */
 		}
 	} else {
 		nfsdstats.fh_nocache_dir++;
@@ -577,24 +638,36 @@
 			case 1:
 				if ((data_left-=2)<0) goto out;
 				dentry = find_fh_dentry(exp->ex_dentry->d_inode->i_sb,
-							datap[0], datap[1],
-							0,
+							datap, 2,
 							!(exp->ex_flags & NFSEXP_NOSUBTREECHECK));
 				break;
 			case 2:
+				/* NOTE, I'm overloading case 2 right now
+				 * for both completely filesystem controlled
+				 * and the standard filehandle.  This means
+				 * we might be using more than 3 ints in
+				 * datap, and data_left might not be correct
+				 * after this call.
+				 *
+				 * This looks ok right now, but needs to be
+				 * fixed long term.  It also means that
+				 * if the FS stores things differently than
+				 * the defaults, it can't use length < 4.
+				 */
 				if ((data_left-=3)<0) goto out;
 				dentry = find_fh_dentry(exp->ex_dentry->d_inode->i_sb,
-							datap[0], datap[1],
-							datap[2],
+							datap, 3 + data_left,
 							!(exp->ex_flags & NFSEXP_NOSUBTREECHECK));
 				break;
 			default: goto out;
 			}
 		} else {
-
+			__u32 tmp[3] ;
+			tmp[0] = fh->ofh_ino ;
+			tmp[1] = fh->ofh_generation ;
+			tmp[2] = fh->ofh_dirino ;
 			dentry = find_fh_dentry(exp->ex_dentry->d_inode->i_sb,
-						fh->ofh_ino, fh->ofh_generation,
-						fh->ofh_dirino,
+						tmp, 3,
 						!(exp->ex_flags & NFSEXP_NOSUBTREECHECK));
 		}
 		if (IS_ERR(dentry)) {
@@ -703,9 +776,18 @@
 		      __u32 **datapp, int maxsize)
 {
 	__u32 *datap= *datapp;
+	struct super_block *sb = dentry->d_inode->i_sb ;
+
 	if (dentry == exp->ex_dentry)
 		return 0;
-	/* if super_operations provides dentry_to_fh lookup, should use that */
+
+	/* use the provided FS provide func to fill the handle */
+	if (sb->s_op->fill_fh) {
+		int used ; 
+		used = sb->s_op->fill_fh(dentry, datap, maxsize/sizeof(__u32)) ;
+		*datapp = datap + used ;
+		return 2 ;
+	}
 	
 	*datap++ = ino_t_to_u32(dentry->d_inode->i_ino);
 	*datap++ = dentry->d_inode->i_generation;
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Sun Apr 29 18:01:04 2001
+++ b/fs/reiserfs/inode.c	Sun Apr 29 18:01:04 2001
@@ -1163,7 +1163,7 @@
 	return;
     }
     if (retval != ITEM_FOUND) {
-	reiserfs_warning ("vs-13042: reiserfs_read_inode2: %K not found\n", &key);
+	/* a stale NFS handle can trigger this without it being an error */
 	pathrelse (&path_to_sd);
 	make_bad_inode(inode) ;
 	return;
@@ -1185,21 +1185,76 @@
     if (!inode) 
       return inode ;
 
-    if (is_bad_inode (inode)) {
-	reiserfs_warning ("vs-13048: reiserfs_iget: "
-			  "bad_inode. Stat data of (%lu %lu) not found\n",
-			  key->on_disk_key.k_dir_id, key->on_disk_key.k_objectid);
-	iput (inode);
-	inode = 0;
-    } else if (comp_short_keys (INODE_PKEY (inode), key)) {
-	reiserfs_warning ("vs-13049: reiserfs_iget: "
-			  "Looking for (%lu %lu), found inode of (%lu %lu)\n",
-			  key->on_disk_key.k_dir_id, key->on_disk_key.k_objectid,
-			  INODE_PKEY (inode)->k_dir_id, INODE_PKEY (inode)->k_objectid);
+    if (comp_short_keys (INODE_PKEY (inode), key) || is_bad_inode (inode)) {
+	/* either due to i/o error or a stale NFS handle */
 	iput (inode);
 	inode = 0;
     }
     return inode;
+}
+
+struct inode *reiserfs_inode_from_fh(struct super_block *sb, __u32 *data,
+                                     int len) {
+    struct cpu_key key ;
+    struct inode *inode = NULL ;
+
+    if (len < 2) 
+	goto out ;
+
+    /* this works for handles from old kernels because the default
+    ** reiserfs generation number is the packing locality.
+    */
+    key.on_disk_key.k_objectid = data[0] ;
+    key.on_disk_key.k_dir_id = data[1] ;
+    inode = reiserfs_iget(sb, &key) ;
+
+out:
+    if (!inode)
+        return ERR_PTR(-ESTALE) ;
+    return inode ;
+}
+
+struct inode *reiserfs_parent_from_fh(struct super_block *sb, __u32 *data,
+                                     int len) {
+    struct cpu_key key ;
+    struct inode *inode ;
+
+    /* 
+    ** Make sure the handle was long enough to store the parent directory
+    ** information.  This also handles the case where an old 
+    ** kernel (no filehandle interface) setup this filehandle, they use
+    ** a length of 3.  Either way, we don't have enough info to find the
+    ** directory.
+    */
+    if (len < 4) 
+        return ERR_PTR(-ESTALE) ;
+
+    key.on_disk_key.k_objectid = data[2] ;
+    key.on_disk_key.k_dir_id = data[3] ;
+    inode = reiserfs_iget(sb, &key) ;
+
+    if (!inode)
+        return ERR_PTR(-ESTALE) ;
+    return inode ;
+}
+
+int reiserfs_fill_fh(struct dentry *dentry, __u32 *data, int maxlen) {
+    struct inode *inode = dentry->d_inode ;
+
+    if (maxlen < 2)
+        return -ENOMEM ;
+
+    data[0] = inode->i_ino ;
+    data[1] = le32_to_cpu(INODE_PKEY (inode)->k_dir_id) ;
+
+    /* no room for directory info? return what we've stored so far */
+    if (maxlen < 4)
+        return 2 ;
+
+    inode = dentry->d_parent->d_inode ;
+    data[2] = inode->i_ino ;
+    data[3] = le32_to_cpu(INODE_PKEY (inode)->k_dir_id) ;
+    return 4; 
 }
 
 
diff -Nru a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Sun Apr 29 18:01:04 2001
+++ b/fs/reiserfs/super.c	Sun Apr 29 18:01:04 2001
@@ -148,7 +148,9 @@
   unlockfs: reiserfs_unlockfs,
   statfs: reiserfs_statfs,
   remount_fs: reiserfs_remount,
-
+  fill_fh: reiserfs_fill_fh,
+  inode_from_fh: reiserfs_inode_from_fh,
+  parent_from_fh: reiserfs_parent_from_fh,
 };
 
 /* this was (ext2)parse_options */
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Sun Apr 29 18:01:04 2001
+++ b/include/linux/fs.h	Sun Apr 29 18:01:04 2001
@@ -820,6 +820,9 @@
 	int (*remount_fs) (struct super_block *, int *, char *);
 	void (*clear_inode) (struct inode *);
 	void (*umount_begin) (struct super_block *);
+	int (*fill_fh) (struct dentry *, __u32 *fh, int size);
+	struct inode * (*inode_from_fh) (struct super_block *, __u32 *, int);
+	struct inode * (*parent_from_fh) (struct super_block *, __u32 *, int);
 };
 
 /* Inode state bits.. */
diff -Nru a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
--- a/include/linux/reiserfs_fs.h	Sun Apr 29 18:01:04 2001
+++ b/include/linux/reiserfs_fs.h	Sun Apr 29 18:01:04 2001
@@ -1806,6 +1806,11 @@
 extern int reiserfs_notify_change(struct dentry * dentry, struct iattr * attr);
 void reiserfs_write_inode (struct inode * inode, int) ;
 
+/* nfs support funcs */
+int reiserfs_fill_fh(struct dentry *, __u32 *fh, int size);
+struct inode *reiserfs_inode_from_fh(struct super_block *, __u32 *, int);
+struct inode *reiserfs_parent_from_fh(struct super_block *, __u32 *, int);
+
 /* we don't mark inodes dirty, we just log them */
 void reiserfs_dirty_inode (struct inode * inode) ;
 

