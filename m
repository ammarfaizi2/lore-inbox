Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316056AbSEJQJO>; Fri, 10 May 2002 12:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316062AbSEJQI0>; Fri, 10 May 2002 12:08:26 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:2188 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S316059AbSEJQHm>; Fri, 10 May 2002 12:07:42 -0400
Date: Fri, 10 May 2002 12:07:41 -0400
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com
Subject: [PATCH] iget_locked [3/6]
Message-ID: <20020510160741.GD18065@ravel.coda.cs.cmu.edu>
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


Convert existing filesystems (Coda/NFS/ReiserFS) that currently use
iget4 to use iget5_locked.

======

diff -urN iget_locked-2/fs/coda/cnode.c iget_locked-3/fs/coda/cnode.c
--- iget_locked-2/fs/coda/cnode.c	Fri May 10 10:32:03 2002
+++ iget_locked-3/fs/coda/cnode.c	Fri May 10 10:33:31 2002
@@ -72,13 +72,21 @@
 			 struct coda_vattr * attr)
 {
 	struct inode *inode;
+	struct coda_inode_info *cii;
+	struct coda_sb_info *sbi = coda_sbp(sb);
 	ino_t ino = coda_f2i(fid);
 
-	inode = iget4(sb, ino, coda_test_inode, coda_set_inode, fid);
+	inode = iget5_locked(sb, ino, coda_test_inode, coda_set_inode, fid);
 
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
+	if (inode->i_state & I_NEW) {
+		cii = ITOC(inode);
+		list_add(&cii->c_cilist, &sbi->sbi_cihead);
+		unlock_new_inode(inode);
+	}
+
 	/* always replace the attributes, type might have changed */
 	coda_fill_inode(inode, attr);
 	return inode;
@@ -141,12 +149,13 @@
 	}
 
 	nr = coda_f2i(fid);
-	inode = iget4(sb, nr, coda_test_inode, coda_fail_inode, fid);
-	if ( !inode ) {
-		printk("coda_fid_to_inode: null from iget, sb %p, nr %ld.\n",
-		       sb, (long)nr);
+	inode = iget5_locked(sb, nr, coda_test_inode, coda_fail_inode, fid);
+	if ( !inode )
 		return NULL;
-	}
+
+	/* we should never see newly created inodes because we intentionally
+	 * fail in the initialization callback */
+	BUG_ON(inode->i_state & I_NEW);
 
 	return inode;
 }
@@ -156,11 +165,12 @@
 {
 	int error = -ENOMEM;
 
-	*inode = iget(sb, CTL_INO);
-	if ( *inode ) {
+	*inode = iget_locked(sb, CTL_INO);
+	if ( *inode && ((*inode)->i_state & I_NEW) ) {
 		(*inode)->i_op = &coda_ioctl_inode_operations;
 		(*inode)->i_fop = &coda_ioctl_operations;
 		(*inode)->i_mode = 0444;
+		unlock_new_inode(*inode);
 		error = 0;
 	}
 
diff -urN iget_locked-2/fs/coda/inode.c iget_locked-3/fs/coda/inode.c
--- iget_locked-2/fs/coda/inode.c	Wed Apr 24 21:39:46 2002
+++ iget_locked-3/fs/coda/inode.c	Fri May 10 10:33:31 2002
@@ -229,16 +229,9 @@
 	kfree(sbi);
 }
 
-/* all filling in of inodes postponed until lookup */
 static void coda_read_inode(struct inode *inode)
 {
-	struct coda_sb_info *sbi = coda_sbp(inode->i_sb);
-	struct coda_inode_info *cii;
-
-        if (!sbi) BUG();
-
-	cii = ITOC(inode);
-	list_add(&cii->c_cilist, &sbi->sbi_cihead);
+	make_bad_inode(inode);
 }
 
 static void coda_clear_inode(struct inode *inode)
diff -urN iget_locked-2/fs/nfs/inode.c iget_locked-3/fs/nfs/inode.c
--- iget_locked-2/fs/nfs/inode.c	Fri May 10 10:32:03 2002
+++ iget_locked-3/fs/nfs/inode.c	Fri May 10 10:33:31 2002
@@ -664,16 +664,15 @@
 
 	ino = nfs_fattr_to_ino_t(fattr);
 
-	if (!(inode = iget4(sb, ino, nfs_find_actor, nfs_init_locked, &desc)))
+	if (!(inode = iget5_locked(sb, ino, nfs_find_actor, nfs_init_locked, &desc)))
 		goto out_no_inode;
 
-	if (NFS_NEW(inode)) {
+	if (inode->i_state & I_NEW) {
 		__u64		new_size, new_mtime;
 		loff_t		new_isize;
 		time_t		new_atime;
 
 		/* We can't support UPDATE_ATIME(), since the server will reset it */
-		NFS_FLAGS(inode) &= ~NFS_INO_NEW;
 		inode->i_flags |= S_NOATIME;
 		inode->i_mode = fattr->mode;
 		/* Why so? Because we want revalidate for devices/FIFOs, and
@@ -721,6 +720,8 @@
 		NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
 		NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
 		memset(NFS_COOKIEVERF(inode), 0, sizeof(NFS_COOKIEVERF(inode)));
+
+		unlock_new_inode(inode);
 	} else
 		nfs_refresh_inode(inode, fattr);
 	dprintk("NFS: __nfs_fhget(%s/%Ld ct=%d)\n",
@@ -1241,7 +1242,7 @@
 	nfsi = (struct nfs_inode *)kmem_cache_alloc(nfs_inode_cachep, SLAB_KERNEL);
 	if (!nfsi)
 		return NULL;
-	nfsi->flags = NFS_INO_NEW;
+	nfsi->flags = 0;
 	nfsi->mm_cred = NULL;
 	return &nfsi->vfs_inode;
 }
diff -urN iget_locked-2/fs/reiserfs/inode.c iget_locked-3/fs/reiserfs/inode.c
--- iget_locked-2/fs/reiserfs/inode.c	Fri May 10 10:32:03 2002
+++ iget_locked-3/fs/reiserfs/inode.c	Fri May 10 10:33:31 2002
@@ -33,7 +33,7 @@
     lock_kernel() ; 
 
     /* The = 0 happens when we abort creating a new inode for some reason like lack of space.. */
-    if (INODE_PKEY(inode)->k_objectid != 0) { /* also handles bad_inode case */
+    if (!(inode->i_state & I_NEW) && INODE_PKEY(inode)->k_objectid != 0) { /* also handles bad_inode case */
 	down (&inode->i_sem); 
 
 	journal_begin(&th, inode->i_sb, jbegin_count) ;
@@ -1140,26 +1140,20 @@
 
 int reiserfs_init_locked_inode (struct inode * inode, void *p)
 {
-    struct reiserfs_iget4_args *args = (struct reiserfs_iget4_args *)p ;
+    struct reiserfs_iget_args *args = (struct reiserfs_iget_args *)p ;
     INODE_PKEY(inode)->k_dir_id = cpu_to_le32(args->objectid);
     return 0;
 }
 
 /* looks for stat data in the tree, and fills up the fields of in-core
    inode stat data fields */
-void reiserfs_read_inode2 (struct inode * inode, void *p)
+void reiserfs_read_locked_inode (struct inode * inode, struct reiserfs_iget_args *args)
 {
     INITIALIZE_PATH (path_to_sd);
     struct cpu_key key;
-    struct reiserfs_iget4_args *args = (struct reiserfs_iget4_args *)p ;
     unsigned long dirino;
     int retval;
 
-    if (!p) {
-	reiserfs_make_bad_inode(inode) ;
-	return;
-    }
-
     dirino = args->objectid ;
 
     /* set version 1, version 2 could be used too, because stat data
@@ -1217,12 +1211,12 @@
 }
 
 /**
- * reiserfs_find_actor() - "find actor" reiserfs supplies to iget4().
+ * reiserfs_find_actor() - "find actor" reiserfs supplies to iget5_locked().
  *
  * @inode:    inode from hash table to check
- * @opaque:   "cookie" passed to iget4(). This is &reiserfs_iget4_args.
+ * @opaque:   "cookie" passed to iget5_locked(). This is &reiserfs_iget_args.
  *
- * This function is called by iget4() to distinguish reiserfs inodes
+ * This function is called by iget5_locked() to distinguish reiserfs inodes
  * having the same inode numbers. Such inodes can only exist due to some
  * error condition. One of them should be bad. Inodes with identical
  * inode numbers (objectids) are distinguished by parent directory ids.
@@ -1230,7 +1224,7 @@
  */
 int reiserfs_find_actor( struct inode *inode, void *opaque )
 {
-    struct reiserfs_iget4_args *args;
+    struct reiserfs_iget_args *args;
 
     args = opaque;
     /* args is already in CPU order */
@@ -1240,13 +1234,18 @@
 struct inode * reiserfs_iget (struct super_block * s, const struct cpu_key * key)
 {
     struct inode * inode;
-    struct reiserfs_iget4_args args ;
+    struct reiserfs_iget_args args ;
 
     args.objectid = key->on_disk_key.k_dir_id ;
-    inode = iget4 (s, key->on_disk_key.k_objectid, 
+    inode = iget5_locked (s, key->on_disk_key.k_objectid, 
 		   reiserfs_find_actor, reiserfs_init_locked_inode, (void *)(&args));
     if (!inode) 
 	return ERR_PTR(-ENOMEM) ;
+
+    if (inode->i_state & I_NEW) {
+	reiserfs_read_locked_inode(inode, &args);
+	unlock_new_inode(inode);
+    }
 
     if (comp_short_keys (INODE_PKEY (inode), key) || is_bad_inode (inode)) {
 	/* either due to i/o error or a stale NFS handle */
diff -urN iget_locked-2/fs/reiserfs/super.c iget_locked-3/fs/reiserfs/super.c
--- iget_locked-2/fs/reiserfs/super.c	Fri May 10 10:32:03 2002
+++ iget_locked-3/fs/reiserfs/super.c	Fri May 10 10:33:31 2002
@@ -485,7 +485,6 @@
   alloc_inode: reiserfs_alloc_inode,
   destroy_inode: reiserfs_destroy_inode,
   read_inode: reiserfs_read_inode,
-  read_inode2: reiserfs_read_inode2,
   write_inode: reiserfs_write_inode,
   dirty_inode: reiserfs_dirty_inode,
   delete_inode: reiserfs_delete_inode,
@@ -1007,7 +1006,7 @@
     int old_format = 0;
     unsigned long blocks;
     int jinit_done = 0 ;
-    struct reiserfs_iget4_args args ;
+    struct reiserfs_iget_args args ;
     struct reiserfs_super_block * rs;
     char *jdev_name;
     struct reiserfs_sb_info *sbi;
@@ -1070,10 +1069,15 @@
 	s->s_flags |= MS_RDONLY ;
     }
     args.objectid = REISERFS_ROOT_PARENT_OBJECTID ;
-    root_inode = iget4 (s, REISERFS_ROOT_OBJECTID, reiserfs_find_actor, reiserfs_init_locked_inode, (void *)(&args));
+    root_inode = iget5_locked (s, REISERFS_ROOT_OBJECTID, reiserfs_find_actor, reiserfs_init_locked_inode, (void *)(&args));
     if (!root_inode) {
 	printk ("reiserfs_fill_super: get root inode failed\n");
 	goto error;
+    }
+
+    if (root_inode->i_state & I_NEW) {
+	reiserfs_read_locked_inode(root_inode, &args);
+	unlock_new_inode(root_inode);
     }
 
     s->s_root = d_alloc_root(root_inode);  
diff -urN iget_locked-2/include/linux/fs.h iget_locked-3/include/linux/fs.h
--- iget_locked-2/include/linux/fs.h	Fri May 10 10:33:12 2002
+++ iget_locked-3/include/linux/fs.h	Fri May 10 10:33:31 2002
@@ -1248,7 +1248,14 @@
 extern struct inode * iget4(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
 static inline struct inode *iget(struct super_block *sb, unsigned long ino)
 {
-	return iget4(sb, ino, NULL, NULL, NULL);
+	struct inode *inode = iget_locked(sb, ino);
+	
+	if (inode && (inode->i_state & I_NEW)) {
+		sb->s_op->read_inode(inode);
+		unlock_new_inode(inode);
+	}
+
+	return inode;
 }
 
 extern void __iget(struct inode * inode);
diff -urN iget_locked-2/include/linux/nfs_fs.h iget_locked-3/include/linux/nfs_fs.h
--- iget_locked-2/include/linux/nfs_fs.h	Sun May  5 15:09:15 2002
+++ iget_locked-3/include/linux/nfs_fs.h	Fri May 10 10:45:56 2002
@@ -170,7 +170,6 @@
 #define NFS_INO_REVALIDATING	0x0004		/* revalidating attrs */
 #define NFS_IS_SNAPSHOT		0x0010		/* a snapshot file */
 #define NFS_INO_FLUSH		0x0020		/* inode is due for flushing */
-#define NFS_INO_NEW		0x0040		/* hadn't been filled yet */
 
 static inline struct nfs_inode *NFS_I(struct inode *inode)
 {
@@ -208,7 +207,6 @@
 #define NFS_FLAGS(inode)		(NFS_I(inode)->flags)
 #define NFS_REVALIDATING(inode)		(NFS_FLAGS(inode) & NFS_INO_REVALIDATING)
 #define NFS_STALE(inode)		(NFS_FLAGS(inode) & NFS_INO_STALE)
-#define NFS_NEW(inode)			(NFS_FLAGS(inode) & NFS_INO_NEW)
 
 #define NFS_FILEID(inode)		(NFS_I(inode)->fileid)
 
diff -urN iget_locked-2/include/linux/reiserfs_fs.h iget_locked-3/include/linux/reiserfs_fs.h
--- iget_locked-2/include/linux/reiserfs_fs.h	Fri May 10 10:32:04 2002
+++ iget_locked-3/include/linux/reiserfs_fs.h	Fri May 10 10:33:31 2002
@@ -1564,7 +1564,7 @@
 #define B_I_POS_UNFM_POINTER(bh,ih,pos) le32_to_cpu(*(((unp_t *)B_I_PITEM(bh,ih)) + (pos)))
 #define PUT_B_I_POS_UNFM_POINTER(bh,ih,pos, val) do {*(((unp_t *)B_I_PITEM(bh,ih)) + (pos)) = cpu_to_le32(val); } while (0)
 
-struct reiserfs_iget4_args {
+struct reiserfs_iget_args {
     __u32 objectid ;
 } ;
 
@@ -1819,7 +1819,7 @@
 /* inode.c */
 
 void reiserfs_read_inode (struct inode * inode) ;
-void reiserfs_read_inode2(struct inode * inode, void *p) ;
+void reiserfs_read_locked_inode(struct inode * inode, struct reiserfs_iget_args *args) ;
 int reiserfs_find_actor(struct inode * inode, void *p) ;
 int reiserfs_init_locked_inode(struct inode * inode, void *p) ;
 void reiserfs_delete_inode (struct inode * inode);
