Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316131AbSEJVm4>; Fri, 10 May 2002 17:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316133AbSEJVm4>; Fri, 10 May 2002 17:42:56 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:28301 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S316131AbSEJVmx>; Fri, 10 May 2002 17:42:53 -0400
Date: Fri, 10 May 2002 17:42:51 -0400
To: Alexander Viro <viro@math.psu.edu>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iget_locked [6a/6] (2nd version of the 6th patch) 
Message-ID: <20020510214251.GA25394@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020510160741.GD18065@ravel.coda.cs.cmu.edu> <Pine.GSO.4.21.0205101557380.19226-100000@weyl.math.psu.edu> <20020510160719.GB18065@ravel.coda.cs.cmu.edu> <Pine.GSO.4.21.0205101550290.19226-100000@weyl.math.psu.edu> <20020510203658.GA23583@ravel.coda.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or a -6a that replaces the existing -6.

- Cleaned up the error handling when 'set' fails in get_new_inode
- Removed unused read_inode functions from Coda, Reiser and NFS.
- Avoid hashing the Coda control inode.
- Added comments to the find_inode_fast and get_new_inode_fast
  functions.
- Added __insert_inode_hash instead of changing insert_inode_hash
  prototype.

Jan

This patch replaces the previous iget_locked [6/6] patch.


diff -urN iget_locked-5/fs/coda/cnode.c iget_locked-6a/fs/coda/cnode.c
--- iget_locked-5/fs/coda/cnode.c	Fri May 10 10:34:32 2002
+++ iget_locked-6a/fs/coda/cnode.c	Fri May 10 17:20:49 2002
@@ -74,16 +74,17 @@
 	struct inode *inode;
 	struct coda_inode_info *cii;
 	struct coda_sb_info *sbi = coda_sbp(sb);
-	ino_t ino = coda_f2i(fid);
+	unsigned long hash = coda_f2i(fid);
 
-	inode = iget5_locked(sb, ino, coda_test_inode, coda_set_inode, fid);
+	inode = iget5_locked(sb, hash, coda_test_inode, coda_set_inode, fid);
 
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
 	if (inode->i_state & I_NEW) {
 		cii = ITOC(inode);
-		inode->i_ino = ino;
+		/* we still need to set i_ino for things like stat(2) */
+		inode->i_ino = hash;
 		list_add(&cii->c_cilist, &sbi->sbi_cihead);
 		unlock_new_inode(inode);
 	}
@@ -124,6 +125,7 @@
 		      struct ViceFid *newfid)
 {
 	struct coda_inode_info *cii;
+	unsigned long hash = coda_f2i(newfid);
 	
 	cii = ITOC(inode);
 
@@ -134,23 +136,22 @@
 	/* XXX we probably need to hold some lock here! */
 	remove_inode_hash(inode);
 	cii->c_fid = *newfid;
-	inode->i_ino = coda_f2i(newfid);
-	insert_inode_hash(inode);
+	inode->i_ino = hash;
+	__insert_inode_hash(inode, hash);
 }
 
 /* convert a fid to an inode. */
 struct inode *coda_fid_to_inode(ViceFid *fid, struct super_block *sb) 
 {
-	ino_t nr;
 	struct inode *inode;
+	unsigned long hash = coda_f2i(fid);
 
 	if ( !sb ) {
 		printk("coda_fid_to_inode: no sb!\n");
 		return NULL;
 	}
 
-	nr = coda_f2i(fid);
-	inode = iget5_locked(sb, nr, coda_test_inode, coda_fail_inode, fid);
+	inode = iget5_locked(sb, hash, coda_test_inode, coda_fail_inode, fid);
 	if ( !inode )
 		return NULL;
 
@@ -166,8 +167,9 @@
 {
 	int error = -ENOMEM;
 
-	*inode = iget_locked(sb, CTL_INO);
-	if ( *inode && ((*inode)->i_state & I_NEW) ) {
+	*inode = new_inode(sb);
+	if (*inode) {
+		(*inode)->i_ino = CTL_INO;
 		(*inode)->i_op = &coda_ioctl_inode_operations;
 		(*inode)->i_fop = &coda_ioctl_operations;
 		(*inode)->i_mode = 0444;
diff -urN iget_locked-5/fs/coda/inode.c iget_locked-6a/fs/coda/inode.c
--- iget_locked-5/fs/coda/inode.c	Fri May 10 10:33:31 2002
+++ iget_locked-6a/fs/coda/inode.c	Fri May 10 17:03:24 2002
@@ -33,7 +33,6 @@
 #include <linux/coda_cache.h>
 
 /* VFS super_block ops */
-static void coda_read_inode(struct inode *);
 static void coda_clear_inode(struct inode *);
 static void coda_put_super(struct super_block *);
 static int coda_statfs(struct super_block *sb, struct statfs *buf);
@@ -92,7 +91,6 @@
 {
 	alloc_inode:	coda_alloc_inode,
 	destroy_inode:	coda_destroy_inode,
-	read_inode:	coda_read_inode,
 	clear_inode:	coda_clear_inode,
 	put_super:	coda_put_super,
 	statfs:		coda_statfs,
@@ -227,11 +225,6 @@
 
 	printk("Coda: Bye bye.\n");
 	kfree(sbi);
-}
-
-static void coda_read_inode(struct inode *inode)
-{
-	make_bad_inode(inode);
 }
 
 static void coda_clear_inode(struct inode *inode)
diff -urN iget_locked-5/fs/inode.c iget_locked-6a/fs/inode.c
--- iget_locked-5/fs/inode.c	Fri May 10 10:34:32 2002
+++ iget_locked-6a/fs/inode.c	Fri May 10 17:11:49 2002
@@ -474,6 +474,10 @@
 	return inode;
 }
 
+/*
+ * find_inode_fast is the fast path version of find_inode, see the comment at
+ * iget_locked for details.
+ */
 static struct inode * find_inode_fast(struct super_block * sb, struct list_head *head, unsigned long ino)
 {
 	struct list_head *tmp;
@@ -554,19 +558,14 @@
 		/* We released the lock, so.. */
 		old = find_inode(sb, head, test, data);
 		if (!old) {
-			int err = set(inode, data);
-			if (!err) {
-				inodes_stat.nr_inodes++;
-				list_add(&inode->i_list, &inode_in_use);
-				list_add(&inode->i_hash, head);
-				inode->i_state = I_LOCK|I_NEW;
-			}
-			spin_unlock(&inode_lock);
+			if (set(inode, data) != 0)
+				goto set_failed;
 
-			if (err) {
-				destroy_inode(inode);
-				return NULL;
-			}
+			inodes_stat.nr_inodes++;
+			list_add(&inode->i_list, &inode_in_use);
+			list_add(&inode->i_hash, head);
+			inode->i_state = I_LOCK|I_NEW;
+			spin_unlock(&inode_lock);
 
 			/* Return the locked inode with I_NEW set, the
 			 * caller is responsible for filling in the contents
@@ -586,8 +585,17 @@
 		wait_on_inode(inode);
 	}
 	return inode;
+
+set_failed:
+	spin_unlock(&inode_lock);
+	destroy_inode(inode);
+	return NULL;
 }
 
+/*
+ * get_new_inode_fast is the fast path version of get_new_inode, see the
+ * comment at iget_locked for details.
+ */
 static struct inode * get_new_inode_fast(struct super_block *sb, struct list_head *head, unsigned long ino)
 {
 	struct inode * inode;
@@ -627,9 +635,9 @@
 	return inode;
 }
 
-static inline unsigned long hash(struct super_block *sb, unsigned long i_ino)
+static inline unsigned long hash(struct super_block *sb, unsigned long hashval)
 {
-	unsigned long tmp = i_ino + ((unsigned long) sb / L1_CACHE_BYTES);
+	unsigned long tmp = hashval + ((unsigned long) sb / L1_CACHE_BYTES);
 	tmp = tmp + (tmp >> I_HASHBITS);
 	return tmp & I_HASHMASK;
 }
@@ -695,9 +703,9 @@
  * the filesystem gets back a new locked and hashed inode and gets
  * to fill it in before unlocking it via unlock_new_inode().
  */
-struct inode *iget5_locked(struct super_block *sb, unsigned long ino, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
+struct inode *iget5_locked(struct super_block *sb, unsigned long hashval, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
 {
-	struct list_head * head = inode_hashtable + hash(sb,ino);
+	struct list_head * head = inode_hashtable + hash(sb, hashval);
 	struct inode * inode;
 
 	spin_lock(&inode_lock);
@@ -717,9 +725,16 @@
 	return get_new_inode(sb, head, test, set, data);
 }
 
+/*
+ * Because most filesystems are based on 32-bit unique inode numbers some
+ * functions are duplicated to keep iget_locked as a fast path. We can avoid
+ * unnecessary pointer dereferences and function calls for this specific
+ * case. The duplicated functions (find_inode_fast and get_new_inode_fast)
+ * have the same pre- and post-conditions as their original counterparts.
+ */
 struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 {
-	struct list_head * head = inode_hashtable + hash(sb,ino);
+	struct list_head * head = inode_hashtable + hash(sb, ino);
 	struct inode * inode;
 
 	spin_lock(&inode_lock);
@@ -744,18 +759,18 @@
 EXPORT_SYMBOL(unlock_new_inode);
 
 /**
- *	insert_inode_hash - hash an inode
+ *	__insert_inode_hash - hash an inode
  *	@inode: unhashed inode
  *
  *	Add an inode to the inode hash for this superblock. If the inode
  *	has no superblock it is added to a separate anonymous chain.
  */
  
-void insert_inode_hash(struct inode *inode)
+void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 {
 	struct list_head *head = &anon_hash_chain;
 	if (inode->i_sb)
-		head = inode_hashtable + hash(inode->i_sb, inode->i_ino);
+		head = inode_hashtable + hash(inode->i_sb, hashval);
 	spin_lock(&inode_lock);
 	list_add(&inode->i_hash, head);
 	spin_unlock(&inode_lock);
diff -urN iget_locked-5/fs/nfs/inode.c iget_locked-6a/fs/nfs/inode.c
--- iget_locked-5/fs/nfs/inode.c	Fri May 10 10:34:32 2002
+++ iget_locked-6a/fs/nfs/inode.c	Fri May 10 17:13:02 2002
@@ -47,7 +47,6 @@
 
 static struct inode *nfs_alloc_inode(struct super_block *sb);
 static void nfs_destroy_inode(struct inode *);
-static void nfs_read_inode(struct inode *);
 static void nfs_write_inode(struct inode *,int);
 static void nfs_delete_inode(struct inode *);
 static void nfs_put_super(struct super_block *);
@@ -59,7 +58,6 @@
 static struct super_operations nfs_sops = { 
 	alloc_inode:	nfs_alloc_inode,
 	destroy_inode:	nfs_destroy_inode,
-	read_inode:	nfs_read_inode,
 	write_inode:	nfs_write_inode,
 	delete_inode:	nfs_delete_inode,
 	put_super:	nfs_put_super,
@@ -98,15 +96,6 @@
 	return nfs_fileid_to_ino_t(fattr->fileid);
 }
 
-/*
- * The "read_inode" function doesn't actually do anything:
- * the real data is filled in later in nfs_fhget.
- */
-static void
-nfs_read_inode(struct inode * inode)
-{
-}
-
 static void
 nfs_write_inode(struct inode *inode, int sync)
 {
@@ -652,7 +641,7 @@
 		fattr:	fattr
 	};
 	struct inode *inode = NULL;
-	unsigned long ino;
+	unsigned long hash;
 
 	if ((fattr->valid & NFS_ATTR_FATTR) == 0)
 		goto out_no_inode;
@@ -662,9 +651,9 @@
 		goto out_no_inode;
 	}
 
-	ino = nfs_fattr_to_ino_t(fattr);
+	hash = nfs_fattr_to_ino_t(fattr);
 
-	if (!(inode = iget5_locked(sb, ino, nfs_find_actor, nfs_init_locked, &desc)))
+	if (!(inode = iget5_locked(sb, hash, nfs_find_actor, nfs_init_locked, &desc)))
 		goto out_no_inode;
 
 	if (inode->i_state & I_NEW) {
@@ -672,7 +661,9 @@
 		loff_t		new_isize;
 		time_t		new_atime;
 
-		inode->i_ino = ino;
+		/* We set i_ino for the few things that still rely on it,
+		 * such as stat(2) */
+		inode->i_ino = hash;
 
 		/* We can't support UPDATE_ATIME(), since the server will reset it */
 		inode->i_flags |= S_NOATIME;
diff -urN iget_locked-5/fs/reiserfs/inode.c iget_locked-6a/fs/reiserfs/inode.c
--- iget_locked-5/fs/reiserfs/inode.c	Fri May 10 10:34:32 2002
+++ iget_locked-6a/fs/reiserfs/inode.c	Fri May 10 17:13:57 2002
@@ -886,7 +886,7 @@
 // item version directly
 //
 
-// called by read_inode
+// called by read_locked_inode
 static void init_inode (struct inode * inode, struct path * path)
 {
     struct buffer_head * bh;
@@ -1117,7 +1117,7 @@
     return;
 }
 
-/* reiserfs_read_inode2 is called to read the inode off disk, and it
+/* reiserfs_read_locked_inode is called to read the inode off disk, and it
 ** does a make_bad_inode when things go wrong.  But, we need to make sure
 ** and clear the key in the private portion of the inode, otherwise a
 ** corresponding iput might try to delete whatever object the inode last
@@ -1128,11 +1128,6 @@
     make_bad_inode(inode);
 }
 
-void reiserfs_read_inode(struct inode *inode) {
-    reiserfs_make_bad_inode(inode) ;
-}
-
-
 //
 // initially this function was derived from minix or ext2's analog and
 // evolved as the prototype did
@@ -1168,7 +1163,7 @@
     /* look for the object's stat data */
     retval = search_item (inode->i_sb, &key, &path_to_sd);
     if (retval == IO_ERROR) {
-	reiserfs_warning ("vs-13070: reiserfs_read_inode2: "
+	reiserfs_warning ("vs-13070: reiserfs_read_locked_inode: "
                     "i/o failure occurred trying to find stat data of %K\n",
                     &key);
 	reiserfs_make_bad_inode(inode) ;
@@ -1200,7 +1195,7 @@
        during mount (fs/reiserfs/super.c:finish_unfinished()). */
     if( ( inode -> i_nlink == 0 ) && 
 	! REISERFS_SB(inode -> i_sb) -> s_is_unlinked_ok ) {
-	    reiserfs_warning( "vs-13075: reiserfs_read_inode2: "
+	    reiserfs_warning( "vs-13075: reiserfs_read_locked_inode: "
 			      "dead inode read from disk %K. "
 			      "This is likely to be race with knfsd. Ignore\n", 
 			      &key );
diff -urN iget_locked-5/fs/reiserfs/super.c iget_locked-6a/fs/reiserfs/super.c
--- iget_locked-5/fs/reiserfs/super.c	Fri May 10 10:34:32 2002
+++ iget_locked-6a/fs/reiserfs/super.c	Fri May 10 17:14:11 2002
@@ -484,7 +484,6 @@
 {
   alloc_inode: reiserfs_alloc_inode,
   destroy_inode: reiserfs_destroy_inode,
-  read_inode: reiserfs_read_inode,
   write_inode: reiserfs_write_inode,
   dirty_inode: reiserfs_dirty_inode,
   delete_inode: reiserfs_delete_inode,
diff -urN iget_locked-5/include/linux/fs.h iget_locked-6a/include/linux/fs.h
--- iget_locked-5/include/linux/fs.h	Fri May 10 10:34:17 2002
+++ iget_locked-6a/include/linux/fs.h	Fri May 10 17:15:24 2002
@@ -1254,8 +1254,13 @@
 extern void clear_inode(struct inode *);
 extern struct inode *new_inode(struct super_block *);
 extern void remove_suid(struct dentry *);
-extern void insert_inode_hash(struct inode *);
+
+extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 extern void remove_inode_hash(struct inode *);
+static inline void insert_inode_hash(struct inode *inode) {
+	__insert_inode_hash(inode, inode->i_ino);
+}
+
 extern struct file * get_empty_filp(void);
 extern void file_move(struct file *f, struct list_head *list);
 extern void ll_rw_block(int, int, struct buffer_head * bh[]);
diff -urN iget_locked-5/include/linux/reiserfs_fs.h iget_locked-6a/include/linux/reiserfs_fs.h
--- iget_locked-5/include/linux/reiserfs_fs.h	Fri May 10 10:47:00 2002
+++ iget_locked-6a/include/linux/reiserfs_fs.h	Fri May 10 17:15:38 2002
@@ -1819,7 +1819,6 @@
 
 /* inode.c */
 
-void reiserfs_read_inode (struct inode * inode) ;
 void reiserfs_read_locked_inode(struct inode * inode, struct reiserfs_iget_args *args) ;
 int reiserfs_find_actor(struct inode * inode, void *p) ;
 int reiserfs_init_locked_inode(struct inode * inode, void *p) ;
diff -urN iget_locked-5/kernel/ksyms.c iget_locked-6a/kernel/ksyms.c
--- iget_locked-5/kernel/ksyms.c	Fri May 10 10:34:17 2002
+++ iget_locked-6a/kernel/ksyms.c	Fri May 10 17:15:47 2002
@@ -536,7 +536,7 @@
 EXPORT_SYMBOL(init_special_inode);
 EXPORT_SYMBOL(__get_hash_table);
 EXPORT_SYMBOL(new_inode);
-EXPORT_SYMBOL(insert_inode_hash);
+EXPORT_SYMBOL(__insert_inode_hash);
 EXPORT_SYMBOL(remove_inode_hash);
 EXPORT_SYMBOL(buffer_insert_list);
 EXPORT_SYMBOL(make_bad_inode);
