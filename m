Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSETNMF>; Mon, 20 May 2002 09:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315974AbSETNME>; Mon, 20 May 2002 09:12:04 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:50593 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S315971AbSETNMA>; Mon, 20 May 2002 09:12:00 -0400
Date: Mon, 20 May 2002 09:11:59 -0400
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.16 iget_locked [6/6]
Message-ID: <20020520131158.GE13865@ravel.coda.cs.cmu.edu>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020520130005.GA13816@ravel.coda.cs.cmu.edu> <20020520130435.GA13865@ravel.coda.cs.cmu.edu> <20020520130535.GB13865@ravel.coda.cs.cmu.edu> <20020520130906.GC13865@ravel.coda.cs.cmu.edu> <20020520131051.GD13865@ravel.coda.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As of the last patch the inode_hashtable doesn't really need to be
indexed by i_ino anymore, the only reason we still have to keep the
hashvalue and i_ino identical is because of insert_inode_hash.

If at some point a FS specific getattr method is implemented it will be
possible to completely remove any use of i_ino by the VFS.


diff -urN iget_locked-5/fs/coda/cnode.c iget_locked-6/fs/coda/cnode.c
--- iget_locked-5/fs/coda/cnode.c	Sun May 19 18:15:11 2002
+++ iget_locked-6/fs/coda/cnode.c	Sun May 19 18:22:08 2002
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
 
diff -urN iget_locked-5/fs/inode.c iget_locked-6/fs/inode.c
--- iget_locked-5/fs/inode.c	Sun May 19 18:21:19 2002
+++ iget_locked-6/fs/inode.c	Sun May 19 18:29:06 2002
@@ -635,9 +635,9 @@
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
@@ -703,9 +703,9 @@
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
@@ -759,18 +759,20 @@
 EXPORT_SYMBOL(unlock_new_inode);
 
 /**
- *	insert_inode_hash - hash an inode
+ *	__insert_inode_hash - hash an inode
  *	@inode: unhashed inode
+ *	@hashval: unsigned long value used to locate this object in the
+ *		inode_hashtable.
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
diff -urN iget_locked-5/fs/nfs/inode.c iget_locked-6/fs/nfs/inode.c
--- iget_locked-5/fs/nfs/inode.c	Sun May 19 18:15:11 2002
+++ iget_locked-6/fs/nfs/inode.c	Sun May 19 18:24:12 2002
@@ -641,7 +641,7 @@
 		fattr:	fattr
 	};
 	struct inode *inode = NULL;
-	unsigned long ino;
+	unsigned long hash;
 
 	if ((fattr->valid & NFS_ATTR_FATTR) == 0)
 		goto out_no_inode;
@@ -651,9 +651,9 @@
 		goto out_no_inode;
 	}
 
-	ino = nfs_fattr_to_ino_t(fattr);
+	hash = nfs_fattr_to_ino_t(fattr);
 
-	if (!(inode = iget5_locked(sb, ino, nfs_find_actor, nfs_init_locked, &desc)))
+	if (!(inode = iget5_locked(sb, hash, nfs_find_actor, nfs_init_locked, &desc)))
 		goto out_no_inode;
 
 	if (inode->i_state & I_NEW) {
@@ -661,7 +661,9 @@
 		loff_t		new_isize;
 		time_t		new_atime;
 
-		inode->i_ino = ino;
+		/* We set i_ino for the few things that still rely on it,
+		 * such as stat(2) */
+		inode->i_ino = hash;
 
 		/* We can't support UPDATE_ATIME(), since the server will reset it */
 		inode->i_flags |= S_NOATIME;
diff -urN iget_locked-5/include/linux/fs.h iget_locked-6/include/linux/fs.h
--- iget_locked-5/include/linux/fs.h	Sun May 19 18:11:28 2002
+++ iget_locked-6/include/linux/fs.h	Sun May 19 18:22:20 2002
@@ -1221,8 +1221,13 @@
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
diff -urN iget_locked-5/kernel/ksyms.c iget_locked-6/kernel/ksyms.c
--- iget_locked-5/kernel/ksyms.c	Sun May 19 18:11:28 2002
+++ iget_locked-6/kernel/ksyms.c	Sun May 19 18:22:22 2002
@@ -537,7 +537,7 @@
 EXPORT_SYMBOL(init_special_inode);
 EXPORT_SYMBOL(__get_hash_table);
 EXPORT_SYMBOL(new_inode);
-EXPORT_SYMBOL(insert_inode_hash);
+EXPORT_SYMBOL(__insert_inode_hash);
 EXPORT_SYMBOL(remove_inode_hash);
 EXPORT_SYMBOL(buffer_insert_list);
 EXPORT_SYMBOL(make_bad_inode);
