Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316063AbSEJQK4>; Fri, 10 May 2002 12:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316058AbSEJQJq>; Fri, 10 May 2002 12:09:46 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:6028 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S316059AbSEJQIf>; Fri, 10 May 2002 12:08:35 -0400
Date: Fri, 10 May 2002 12:08:34 -0400
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com
Subject: [PATCH] iget_locked [6/6]
Message-ID: <20020510160833.GG18065@ravel.coda.cs.cmu.edu>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@math.psu.edu>, trond.myklebust@fys.uio.no,
	reiserfs-dev@namesys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As of the previous patch the inode_hashtable doesn't really need to be
indexed by i_ino anymore, the only reason we still have to keep the
hashvalue and i_ino identical is because of insert_inode_hash.

Here we simply add an argument to insert_inode_hash. If at some point a
FS specific getattr method is implemented it will be possible to
completely remove all uses of i_ino in the VFS.

======

diff -urN iget_locked-5/fs/adfs/inode.c iget_locked-6/fs/adfs/inode.c
--- iget_locked-5/fs/adfs/inode.c	Mon Apr 22 23:04:15 2002
+++ iget_locked-6/fs/adfs/inode.c	Fri May 10 10:34:58 2002
@@ -284,7 +284,7 @@
 		ADFS_I(inode)->mmu_private = inode->i_size;
 	}
 
-	insert_inode_hash(inode);
+	insert_inode_hash(inode, inode->i_ino);
 
 out:
 	return inode;
diff -urN iget_locked-5/fs/affs/inode.c iget_locked-6/fs/affs/inode.c
--- iget_locked-5/fs/affs/inode.c	Mon Apr 22 23:04:15 2002
+++ iget_locked-6/fs/affs/inode.c	Fri May 10 10:34:58 2002
@@ -345,7 +345,7 @@
 	AFFS_I(inode)->i_extcnt = 1;
 	AFFS_I(inode)->i_ext_last = ~1;
 
-	insert_inode_hash(inode);
+	insert_inode_hash(inode, inode->i_ino);
 
 	return inode;
 
diff -urN iget_locked-5/fs/bfs/dir.c iget_locked-6/fs/bfs/dir.c
--- iget_locked-5/fs/bfs/dir.c	Wed May  1 00:27:34 2002
+++ iget_locked-6/fs/bfs/dir.c	Fri May 10 10:34:58 2002
@@ -110,7 +110,7 @@
 	BFS_I(inode)->i_dsk_ino = ino;
 	BFS_I(inode)->i_sblock = 0;
 	BFS_I(inode)->i_eblock = 0;
-	insert_inode_hash(inode);
+	insert_inode_hash(inode, inode->i_ino);
         mark_inode_dirty(inode);
 	dump_imap("create",s);
 
diff -urN iget_locked-5/fs/coda/cnode.c iget_locked-6/fs/coda/cnode.c
--- iget_locked-5/fs/coda/cnode.c	Fri May 10 10:34:32 2002
+++ iget_locked-6/fs/coda/cnode.c	Fri May 10 10:34:58 2002
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
+	insert_inode_hash(inode, hash);
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
 
diff -urN iget_locked-5/fs/cramfs/inode.c iget_locked-6/fs/cramfs/inode.c
--- iget_locked-5/fs/cramfs/inode.c	Wed May  1 00:27:34 2002
+++ iget_locked-6/fs/cramfs/inode.c	Fri May 10 10:34:58 2002
@@ -55,7 +55,7 @@
 		   but it's the best we can do without reading the directory
 	           contents.  1 yields the right result in GNU find, even
 		   without -noleaf option. */
-		insert_inode_hash(inode);
+		insert_inode_hash(inode, inode->i_ino);
 		if (S_ISREG(inode->i_mode)) {
 			inode->i_fop = &generic_ro_fops;
 			inode->i_data.a_ops = &cramfs_aops;
diff -urN iget_locked-5/fs/ext2/ialloc.c iget_locked-6/fs/ext2/ialloc.c
--- iget_locked-5/fs/ext2/ialloc.c	Mon Apr 22 23:04:15 2002
+++ iget_locked-6/fs/ext2/ialloc.c	Fri May 10 10:34:58 2002
@@ -405,7 +405,7 @@
 	if (ei->i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
 	inode->i_generation = EXT2_SB(sb)->s_next_generation++;
-	insert_inode_hash(inode);
+	insert_inode_hash(inode, inode->i_ino);
 	mark_inode_dirty(inode);
 
 	unlock_super (sb);
diff -urN iget_locked-5/fs/ext3/ialloc.c iget_locked-6/fs/ext3/ialloc.c
--- iget_locked-5/fs/ext3/ialloc.c	Mon Apr 22 23:04:15 2002
+++ iget_locked-6/fs/ext3/ialloc.c	Fri May 10 10:34:58 2002
@@ -508,7 +508,7 @@
 		inode->i_flags |= S_SYNC;
 	if (IS_SYNC(inode))
 		handle->h_sync = 1;
-	insert_inode_hash(inode);
+	insert_inode_hash(inode, inode->i_ino);
 	inode->i_generation = sb->u.ext3_sb.s_next_generation++;
 
 	ei->i_state = EXT3_STATE_NEW;
diff -urN iget_locked-5/fs/fat/inode.c iget_locked-6/fs/fat/inode.c
--- iget_locked-5/fs/fat/inode.c	Fri May 10 10:30:06 2002
+++ iget_locked-6/fs/fat/inode.c	Fri May 10 10:34:59 2002
@@ -143,7 +143,7 @@
 		goto out;
 	}
 	fat_attach(inode, ino);
-	insert_inode_hash(inode);
+	insert_inode_hash(inode, inode->i_ino);
 out:
 	return inode;
 }
@@ -896,7 +896,7 @@
 	if (error < 0)
 		goto out_fail;
 	error = -ENOMEM;
-	insert_inode_hash(root_inode);
+	insert_inode_hash(root_inode, root_inode->i_ino);
 	sb->s_root = d_alloc_root(root_inode);
 	if (!sb->s_root) {
 		printk("FAT: get root inode failed\n");
diff -urN iget_locked-5/fs/inode.c iget_locked-6/fs/inode.c
--- iget_locked-5/fs/inode.c	Fri May 10 10:34:32 2002
+++ iget_locked-6/fs/inode.c	Fri May 10 10:34:59 2002
@@ -627,9 +627,9 @@
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
@@ -695,9 +695,9 @@
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
@@ -746,16 +746,17 @@
 /**
  *	insert_inode_hash - hash an inode
  *	@inode: unhashed inode
+ *	@hashval: unsigned long persistent object identifier
  *
  *	Add an inode to the inode hash for this superblock. If the inode
  *	has no superblock it is added to a separate anonymous chain.
  */
  
-void insert_inode_hash(struct inode *inode)
+void insert_inode_hash(struct inode *inode, unsigned long hashval)
 {
 	struct list_head *head = &anon_hash_chain;
 	if (inode->i_sb)
-		head = inode_hashtable + hash(inode->i_sb, inode->i_ino);
+		head = inode_hashtable + hash(inode->i_sb, hashval);
 	spin_lock(&inode_lock);
 	list_add(&inode->i_hash, head);
 	spin_unlock(&inode_lock);
diff -urN iget_locked-5/fs/jffs/inode-v23.c iget_locked-6/fs/jffs/inode-v23.c
--- iget_locked-5/fs/jffs/inode-v23.c	Wed May  1 00:27:35 2002
+++ iget_locked-6/fs/jffs/inode-v23.c	Fri May 10 10:34:59 2002
@@ -374,7 +374,7 @@
 	f = jffs_find_file(c, raw_inode->ino);
 
 	inode->u.generic_ip = (void *)f;
-	insert_inode_hash(inode);
+	insert_inode_hash(inode, inode->i_ino);
 
 	return inode;
 }
diff -urN iget_locked-5/fs/jffs2/fs.c iget_locked-6/fs/jffs2/fs.c
--- iget_locked-5/fs/jffs2/fs.c	Wed Apr 24 18:28:43 2002
+++ iget_locked-6/fs/jffs2/fs.c	Fri May 10 10:34:59 2002
@@ -390,7 +390,7 @@
 	inode->i_blocks = 0;
 	inode->i_size = 0;
 
-	insert_inode_hash(inode);
+	insert_inode_hash(inode, inode->i_ino);
 
 	return inode;
 }
diff -urN iget_locked-5/fs/jfs/namei.c iget_locked-6/fs/jfs/namei.c
--- iget_locked-5/fs/jfs/namei.c	Wed May  1 00:27:35 2002
+++ iget_locked-6/fs/jfs/namei.c	Fri May 10 10:34:59 2002
@@ -133,7 +133,7 @@
 	ip->i_fop = &jfs_file_operations;
 	ip->i_mapping->a_ops = &jfs_aops;
 
-	insert_inode_hash(ip);
+	insert_inode_hash(ip, ip->i_ino);
 	mark_inode_dirty(ip);
 	d_instantiate(dentry, ip);
 
@@ -257,7 +257,7 @@
 	ip->i_mapping->a_ops = &jfs_aops;
 	ip->i_mapping->gfp_mask = GFP_NOFS;
 
-	insert_inode_hash(ip);
+	insert_inode_hash(ip, ip->i_ino);
 	mark_inode_dirty(ip);
 	d_instantiate(dentry, ip);
 
@@ -991,7 +991,7 @@
 	}
 	dip->i_version = ++event;
 
-	insert_inode_hash(ip);
+	insert_inode_hash(ip, ip->i_ino);
 	mark_inode_dirty(ip);
 	d_instantiate(dentry, ip);
 
@@ -1353,7 +1353,7 @@
 
 	init_special_inode(ip, ip->i_mode, rdev);
 
-	insert_inode_hash(ip);
+	insert_inode_hash(ip, ip->i_ino);
 	mark_inode_dirty(ip);
 	d_instantiate(dentry, ip);
 
diff -urN iget_locked-5/fs/minix/bitmap.c iget_locked-6/fs/minix/bitmap.c
--- iget_locked-5/fs/minix/bitmap.c	Mon Apr 22 23:04:17 2002
+++ iget_locked-6/fs/minix/bitmap.c	Fri May 10 10:35:00 2002
@@ -252,7 +252,7 @@
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_blocks = inode->i_blksize = 0;
 	memset(&minix_i(inode)->u, 0, sizeof(minix_i(inode)->u));
-	insert_inode_hash(inode);
+	insert_inode_hash(inode, inode->i_ino);
 	mark_inode_dirty(inode);
 
 	*error = 0;
diff -urN iget_locked-5/fs/ncpfs/inode.c iget_locked-6/fs/ncpfs/inode.c
--- iget_locked-5/fs/ncpfs/inode.c	Mon Apr 22 23:04:17 2002
+++ iget_locked-6/fs/ncpfs/inode.c	Fri May 10 10:35:02 2002
@@ -281,7 +281,7 @@
 			inode->i_data.a_ops = &ncp_symlink_aops;
 #endif
 		}
-		insert_inode_hash(inode);
+		insert_inode_hash(inode, inode->i_ino);
 	} else
 		printk(KERN_ERR "ncp_iget: iget failed!\n");
 	return inode;
diff -urN iget_locked-5/fs/nfs/inode.c iget_locked-6/fs/nfs/inode.c
--- iget_locked-5/fs/nfs/inode.c	Fri May 10 10:34:32 2002
+++ iget_locked-6/fs/nfs/inode.c	Fri May 10 10:35:02 2002
@@ -652,7 +652,7 @@
 		fattr:	fattr
 	};
 	struct inode *inode = NULL;
-	unsigned long ino;
+	unsigned long hash;
 
 	if ((fattr->valid & NFS_ATTR_FATTR) == 0)
 		goto out_no_inode;
@@ -662,9 +662,9 @@
 		goto out_no_inode;
 	}
 
-	ino = nfs_fattr_to_ino_t(fattr);
+	hash = nfs_fattr_to_ino_t(fattr);
 
-	if (!(inode = iget5_locked(sb, ino, nfs_find_actor, nfs_init_locked, &desc)))
+	if (!(inode = iget5_locked(sb, hash, nfs_find_actor, nfs_init_locked, &desc)))
 		goto out_no_inode;
 
 	if (inode->i_state & I_NEW) {
@@ -672,7 +672,9 @@
 		loff_t		new_isize;
 		time_t		new_atime;
 
-		inode->i_ino = ino;
+		/* We set i_ino for the few things that still rely on it,
+		 * such as stat(2) */
+		inode->i_ino = hash;
 
 		/* We can't support UPDATE_ATIME(), since the server will reset it */
 		inode->i_flags |= S_NOATIME;
diff -urN iget_locked-5/fs/reiserfs/inode.c iget_locked-6/fs/reiserfs/inode.c
--- iget_locked-5/fs/reiserfs/inode.c	Fri May 10 10:34:32 2002
+++ iget_locked-6/fs/reiserfs/inode.c	Fri May 10 10:35:02 2002
@@ -1642,7 +1642,7 @@
 	return NULL;
     }
 
-    insert_inode_hash (inode);
+    insert_inode_hash (inode, inode->i_ino);
     // we do not mark inode dirty: on disk content matches to the
     // in-core one
     reiserfs_check_path(&path_to_key) ;
diff -urN iget_locked-5/fs/smbfs/inode.c iget_locked-6/fs/smbfs/inode.c
--- iget_locked-5/fs/smbfs/inode.c	Wed May  1 00:27:36 2002
+++ iget_locked-6/fs/smbfs/inode.c	Fri May 10 10:35:02 2002
@@ -130,7 +130,7 @@
 		result->i_op = &smb_dir_inode_operations;
 		result->i_fop = &smb_dir_operations;
 	}
-	insert_inode_hash(result);
+	insert_inode_hash(result, result->i_ino);
 	return result;
 }
 
diff -urN iget_locked-5/fs/sysv/ialloc.c iget_locked-6/fs/sysv/ialloc.c
--- iget_locked-5/fs/sysv/ialloc.c	Wed May  1 00:27:36 2002
+++ iget_locked-6/fs/sysv/ialloc.c	Fri May 10 10:35:02 2002
@@ -172,7 +172,7 @@
 	inode->i_blocks = inode->i_blksize = 0;
 	memset(SYSV_I(inode)->i_data, 0, sizeof(SYSV_I(inode)->i_data));
 	SYSV_I(inode)->i_dir_start_lookup = 0;
-	insert_inode_hash(inode);
+	insert_inode_hash(inode, inode->i_ino);
 	mark_inode_dirty(inode);
 
 	inode->i_mode = mode;		/* for sysv_write_inode() */
diff -urN iget_locked-5/fs/udf/ialloc.c iget_locked-6/fs/udf/ialloc.c
--- iget_locked-5/fs/udf/ialloc.c	Tue Mar 19 21:02:11 2002
+++ iget_locked-6/fs/udf/ialloc.c	Fri May 10 10:35:02 2002
@@ -153,7 +153,7 @@
 	UDF_I_UMTIME(inode) = UDF_I_UCTIME(inode) =
 		UDF_I_UCRTIME(inode) = CURRENT_UTIME;
 	UDF_I_NEW_INODE(inode) = 1;
-	insert_inode_hash(inode);
+	insert_inode_hash(inode, inode->i_ino);
 	mark_inode_dirty(inode);
 
 	unlock_super(sb);
diff -urN iget_locked-5/fs/ufs/ialloc.c iget_locked-6/fs/ufs/ialloc.c
--- iget_locked-5/fs/ufs/ialloc.c	Thu Feb 28 22:27:25 2002
+++ iget_locked-6/fs/ufs/ialloc.c	Fri May 10 10:35:02 2002
@@ -271,7 +271,7 @@
 	ufsi->i_oeftflag = 0;
 	memset(&ufsi->i_u1, 0, sizeof(ufsi->i_u1));
 
-	insert_inode_hash(inode);
+	insert_inode_hash(inode, inode->i_ino);
 	mark_inode_dirty(inode);
 
 	unlock_super (sb);
diff -urN iget_locked-5/include/linux/fs.h iget_locked-6/include/linux/fs.h
--- iget_locked-5/include/linux/fs.h	Fri May 10 10:34:17 2002
+++ iget_locked-6/include/linux/fs.h	Fri May 10 10:44:13 2002
@@ -1254,7 +1254,7 @@
 extern void clear_inode(struct inode *);
 extern struct inode *new_inode(struct super_block *);
 extern void remove_suid(struct dentry *);
-extern void insert_inode_hash(struct inode *);
+extern void insert_inode_hash(struct inode *, unsigned long);
 extern void remove_inode_hash(struct inode *);
 extern struct file * get_empty_filp(void);
 extern void file_move(struct file *f, struct list_head *list);
