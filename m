Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315961AbSETNFv>; Mon, 20 May 2002 09:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315974AbSETNFu>; Mon, 20 May 2002 09:05:50 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:47009 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S315961AbSETNFg>; Mon, 20 May 2002 09:05:36 -0400
Date: Mon, 20 May 2002 09:05:35 -0400
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.16 iget_locked [3/6]
Message-ID: <20020520130535.GB13865@ravel.coda.cs.cmu.edu>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020520130005.GA13816@ravel.coda.cs.cmu.edu> <20020520130435.GA13865@ravel.coda.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert existing filesystems (Coda/NFS/ReiserFS) that currently use
iget4 to iget5_locked.


diff -urN iget_locked-2/fs/coda/cnode.c iget_locked-3/fs/coda/cnode.c
--- iget_locked-2/fs/coda/cnode.c	Sun May 19 17:55:27 2002
+++ iget_locked-3/fs/coda/cnode.c	Sun May 19 18:07:01 2002
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
@@ -156,8 +165,9 @@
 {
 	int error = -ENOMEM;
 
-	*inode = iget(sb, CTL_INO);
-	if ( *inode ) {
+	*inode = new_inode(sb);
+	if (*inode) {
+		(*inode)->i_ino = CTL_INO;
 		(*inode)->i_op = &coda_ioctl_inode_operations;
 		(*inode)->i_fop = &coda_ioctl_operations;
 		(*inode)->i_mode = 0444;
diff -urN iget_locked-2/fs/coda/inode.c iget_locked-3/fs/coda/inode.c
--- iget_locked-2/fs/coda/inode.c	Wed Apr 24 21:39:46 2002
+++ iget_locked-3/fs/coda/inode.c	Sun May 19 18:08:40 2002
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
@@ -227,18 +225,6 @@
 
 	printk("Coda: Bye bye.\n");
 	kfree(sbi);
-}
-
-/* all filling in of inodes postponed until lookup */
-static void coda_read_inode(struct inode *inode)
-{
-	struct coda_sb_info *sbi = coda_sbp(inode->i_sb);
-	struct coda_inode_info *cii;
-
-        if (!sbi) BUG();
-
-	cii = ITOC(inode);
-	list_add(&cii->c_cilist, &sbi->sbi_cihead);
 }
 
 static void coda_clear_inode(struct inode *inode)
diff -urN iget_locked-2/fs/nfs/inode.c iget_locked-3/fs/nfs/inode.c
--- iget_locked-2/fs/nfs/inode.c	Sun May 19 17:55:27 2002
+++ iget_locked-3/fs/nfs/inode.c	Sun May 19 18:09:14 2002
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
@@ -664,16 +653,15 @@
 
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
@@ -721,6 +709,8 @@
 		NFS_ATTRTIMEO(inode) = NFS_MINATTRTIMEO(inode);
 		NFS_ATTRTIMEO_UPDATE(inode) = jiffies;
 		memset(NFS_COOKIEVERF(inode), 0, sizeof(NFS_COOKIEVERF(inode)));
+
+		unlock_new_inode(inode);
 	} else
 		nfs_refresh_inode(inode, fattr);
 	dprintk("NFS: __nfs_fhget(%s/%Ld ct=%d)\n",
@@ -1241,7 +1231,7 @@
 	nfsi = (struct nfs_inode *)kmem_cache_alloc(nfs_inode_cachep, SLAB_KERNEL);
 	if (!nfsi)
 		return NULL;
-	nfsi->flags = NFS_INO_NEW;
+	nfsi->flags = 0;
 	nfsi->mm_cred = NULL;
 	return &nfsi->vfs_inode;
 }
diff -urN iget_locked-2/fs/reiserfs/inode.c iget_locked-3/fs/reiserfs/inode.c
--- iget_locked-2/fs/reiserfs/inode.c	Sun May 19 17:55:27 2002
+++ iget_locked-3/fs/reiserfs/inode.c	Sun May 19 18:10:06 2002
@@ -33,7 +33,7 @@
     lock_kernel() ; 
 
     /* The = 0 happens when we abort creating a new inode for some reason like lack of space.. */
-    if (INODE_PKEY(inode)->k_objectid != 0) { /* also handles bad_inode case */
+    if (!(inode->i_state & I_NEW) && INODE_PKEY(inode)->k_objectid != 0) { /* also handles bad_inode case */
 	down (&inode->i_sem); 
 
 	journal_begin(&th, inode->i_sb, jbegin_count) ;
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
@@ -1140,26 +1135,20 @@
 
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
@@ -1173,7 +1162,7 @@
     /* look for the object's stat data */
     retval = search_item (inode->i_sb, &key, &path_to_sd);
     if (retval == IO_ERROR) {
-	reiserfs_warning ("vs-13070: reiserfs_read_inode2: "
+	reiserfs_warning ("vs-13070: reiserfs_read_locked_inode: "
                     "i/o failure occurred trying to find stat data of %K\n",
                     &key);
 	reiserfs_make_bad_inode(inode) ;
@@ -1205,7 +1194,7 @@
        during mount (fs/reiserfs/super.c:finish_unfinished()). */
     if( ( inode -> i_nlink == 0 ) && 
 	! REISERFS_SB(inode -> i_sb) -> s_is_unlinked_ok ) {
-	    reiserfs_warning( "vs-13075: reiserfs_read_inode2: "
+	    reiserfs_warning( "vs-13075: reiserfs_read_locked_inode: "
 			      "dead inode read from disk %K. "
 			      "This is likely to be race with knfsd. Ignore\n", 
 			      &key );
@@ -1217,12 +1206,12 @@
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
@@ -1230,7 +1219,7 @@
  */
 int reiserfs_find_actor( struct inode *inode, void *opaque )
 {
-    struct reiserfs_iget4_args *args;
+    struct reiserfs_iget_args *args;
 
     args = opaque;
     /* args is already in CPU order */
@@ -1240,13 +1229,18 @@
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
--- iget_locked-2/fs/reiserfs/super.c	Sun May 19 17:55:27 2002
+++ iget_locked-3/fs/reiserfs/super.c	Sun May 19 18:10:31 2002
@@ -484,8 +484,6 @@
 {
   alloc_inode: reiserfs_alloc_inode,
   destroy_inode: reiserfs_destroy_inode,
-  read_inode: reiserfs_read_inode,
-  read_inode2: reiserfs_read_inode2,
   write_inode: reiserfs_write_inode,
   dirty_inode: reiserfs_dirty_inode,
   delete_inode: reiserfs_delete_inode,
@@ -1007,7 +1005,7 @@
     int old_format = 0;
     unsigned long blocks;
     int jinit_done = 0 ;
-    struct reiserfs_iget4_args args ;
+    struct reiserfs_iget_args args ;
     struct reiserfs_super_block * rs;
     char *jdev_name;
     struct reiserfs_sb_info *sbi;
@@ -1070,10 +1068,15 @@
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
--- iget_locked-2/include/linux/fs.h	Sun May 19 18:02:05 2002
+++ iget_locked-3/include/linux/fs.h	Sun May 19 18:04:27 2002
@@ -1215,7 +1215,14 @@
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
+++ iget_locked-3/include/linux/nfs_fs.h	Sun May 19 18:04:27 2002
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
--- iget_locked-2/include/linux/reiserfs_fs.h	Sun May 19 17:55:27 2002
+++ iget_locked-3/include/linux/reiserfs_fs.h	Sun May 19 18:10:42 2002
@@ -1564,7 +1564,7 @@
 #define B_I_POS_UNFM_POINTER(bh,ih,pos) le32_to_cpu(*(((unp_t *)B_I_PITEM(bh,ih)) + (pos)))
 #define PUT_B_I_POS_UNFM_POINTER(bh,ih,pos, val) do {*(((unp_t *)B_I_PITEM(bh,ih)) + (pos)) = cpu_to_le32(val); } while (0)
 
-struct reiserfs_iget4_args {
+struct reiserfs_iget_args {
     __u32 objectid ;
 } ;
 
@@ -1818,8 +1818,7 @@
 
 /* inode.c */
 
-void reiserfs_read_inode (struct inode * inode) ;
-void reiserfs_read_inode2(struct inode * inode, void *p) ;
+void reiserfs_read_locked_inode(struct inode * inode, struct reiserfs_iget_args *args) ;
 int reiserfs_find_actor(struct inode * inode, void *p) ;
 int reiserfs_init_locked_inode(struct inode * inode, void *p) ;
 void reiserfs_delete_inode (struct inode * inode);
