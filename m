Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316066AbSEJQJG>; Fri, 10 May 2002 12:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316064AbSEJQIl>; Fri, 10 May 2002 12:08:41 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:65163 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S316054AbSEJQHV>; Fri, 10 May 2002 12:07:21 -0400
Date: Fri, 10 May 2002 12:07:19 -0400
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>,
        trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com
Subject: [PATCH] iget_locked [1/6]
Message-ID: <20020510160719.GB18065@ravel.coda.cs.cmu.edu>
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

Hi Linus,

Here is a series of 6 patches that started off as fixing a race in
iget4, but ended up as a merge of the XFS icreate functionality, removal
of the 'reiserfs specific hack' and reduces the VFS dependency on i_ino.

It has seen some discussion on linux-fsdevel.

It removes iget4 and the read_inode2 callback, adds an argument to the
interface of insert_inode_hash and introduces new functions iget_locked,
iget5_locked and unlock_new_inode.

The main difference between iget_locked and iget is that iget_locked
returns a locked inode and leaves it up the the filesystem to deal with
the final initialization of the inode. Once all filesystems are
converted to use iget_locked, the read_inode callback can be removed as
well.

Jan

Patches start off against 2.5.15.

Fix a race in iget4. The fs specific data that is used to find an inode
should be initialized while still holding the inode lock.

It adds a 'set' callback function that should be a non-blocking FS
provided function that initializes the private parts of the inode so
that the 'test' callback function can correctly match new inodes.

Touches all filesystems that use iget4 (Coda/NFS/ReiserFS).

======

diff -urN orig/fs/coda/cnode.c iget_locked-1/fs/coda/cnode.c
--- orig/fs/coda/cnode.c	Wed Apr 24 21:39:46 2002
+++ iget_locked-1/fs/coda/cnode.c	Fri May 10 10:32:03 2002
@@ -25,11 +25,6 @@
 	return 1;
 }
 
-static int coda_inocmp(struct inode *inode, unsigned long ino, void *opaque)
-{
-	return (coda_fideq((ViceFid *)opaque, &(ITOC(inode)->c_fid)));
-}
-
 static struct inode_operations coda_symlink_inode_operations = {
 	readlink:	page_readlink,
 	follow_link:	page_follow_link,
@@ -55,27 +50,35 @@
                 init_special_inode(inode, inode->i_mode, attr->va_rdev);
 }
 
+static int coda_test_inode(struct inode *inode, void *data)
+{
+	ViceFid *fid = (ViceFid *)data;
+	return coda_fideq(&(ITOC(inode)->c_fid), fid);
+}
+
+static int coda_set_inode(struct inode *inode, void *data)
+{
+	ViceFid *fid = (ViceFid *)data;
+	ITOC(inode)->c_fid = *fid;
+	return 0;
+}
+
+static int coda_fail_inode(struct inode *inode, void *data)
+{
+	return -1;
+}
+
 struct inode * coda_iget(struct super_block * sb, ViceFid * fid,
 			 struct coda_vattr * attr)
 {
 	struct inode *inode;
-	struct coda_inode_info *cii;
 	ino_t ino = coda_f2i(fid);
 
-	inode = iget4(sb, ino, coda_inocmp, fid);
+	inode = iget4(sb, ino, coda_test_inode, coda_set_inode, fid);
 
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	/* check if the inode is already initialized */
-	cii = ITOC(inode);
-	if (coda_isnullfid(&cii->c_fid))
-		/* new, empty inode found... initializing */
-		cii->c_fid = *fid;
-
-	/* we shouldnt see inode collisions anymore */
-	if (!coda_fideq(fid, &cii->c_fid)) BUG();
-
 	/* always replace the attributes, type might have changed */
 	coda_fill_inode(inode, attr);
 	return inode;
@@ -131,7 +134,6 @@
 {
 	ino_t nr;
 	struct inode *inode;
-	struct coda_inode_info *cii;
 
 	if ( !sb ) {
 		printk("coda_fid_to_inode: no sb!\n");
@@ -139,43 +141,29 @@
 	}
 
 	nr = coda_f2i(fid);
-	inode = iget4(sb, nr, coda_inocmp, fid);
+	inode = iget4(sb, nr, coda_test_inode, coda_fail_inode, fid);
 	if ( !inode ) {
 		printk("coda_fid_to_inode: null from iget, sb %p, nr %ld.\n",
 		       sb, (long)nr);
 		return NULL;
 	}
 
-	cii = ITOC(inode);
-
-	/* The inode could already be purged due to memory pressure */
-	if (coda_isnullfid(&cii->c_fid)) {
-		inode->i_nlink = 0;
-		iput(inode);
-		return NULL;
-	}
-
-	/* we shouldn't see inode collisions anymore */
-	if ( !coda_fideq(fid, &cii->c_fid) ) BUG();
-
-        return inode;
+	return inode;
 }
 
 /* the CONTROL inode is made without asking attributes from Venus */
 int coda_cnode_makectl(struct inode **inode, struct super_block *sb)
 {
-    int error = 0;
+	int error = -ENOMEM;
+
+	*inode = iget(sb, CTL_INO);
+	if ( *inode ) {
+		(*inode)->i_op = &coda_ioctl_inode_operations;
+		(*inode)->i_fop = &coda_ioctl_operations;
+		(*inode)->i_mode = 0444;
+		error = 0;
+	}
 
-    *inode = iget(sb, CTL_INO);
-    if ( *inode ) {
-	(*inode)->i_op = &coda_ioctl_inode_operations;
-	(*inode)->i_fop = &coda_ioctl_operations;
-	(*inode)->i_mode = 0444;
-	error = 0;
-    } else { 
-	error = -ENOMEM;
-    }
-    
-    return error;
+	return error;
 }
 
diff -urN orig/fs/inode.c iget_locked-1/fs/inode.c
--- orig/fs/inode.c	Wed May  1 00:27:35 2002
+++ iget_locked-1/fs/inode.c	Fri May 10 10:32:03 2002
@@ -452,7 +452,7 @@
  * by hand after calling find_inode now! This simplifies iunique and won't
  * add any additional branch in the common code.
  */
-static struct inode * find_inode(struct super_block * sb, unsigned long ino, struct list_head *head, find_inode_t find_actor, void *opaque)
+static struct inode * find_inode(struct super_block * sb, unsigned long ino, struct list_head *head, int (*test)(struct inode *, void *), void *data)
 {
 	struct list_head *tmp;
 	struct inode * inode;
@@ -468,7 +468,7 @@
 			continue;
 		if (inode->i_sb != sb)
 			continue;
-		if (find_actor && !find_actor(inode, ino, opaque))
+		if (test && !test(inode, data))
 			continue;
 		break;
 	}
@@ -507,9 +507,10 @@
  * We no longer cache the sb_flags in i_flags - see fs.h
  *	-- rmk@arm.uk.linux.org
  */
-static struct inode * get_new_inode(struct super_block *sb, unsigned long ino, struct list_head *head, find_inode_t find_actor, void *opaque)
+static struct inode * get_new_inode(struct super_block *sb, unsigned long ino, struct list_head *head, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
 {
 	struct inode * inode;
+	int err = 0;
 
 	inode = alloc_inode(sb);
 	if (inode) {
@@ -517,22 +518,31 @@
 
 		spin_lock(&inode_lock);
 		/* We released the lock, so.. */
-		old = find_inode(sb, ino, head, find_actor, opaque);
+		old = find_inode(sb, ino, head, test, data);
 		if (!old) {
-			inodes_stat.nr_inodes++;
-			list_add(&inode->i_list, &inode_in_use);
-			list_add(&inode->i_hash, head);
 			inode->i_ino = ino;
-			inode->i_state = I_LOCK;
+			if (set)
+				err = set(inode, data);
+			if (!err) {
+				inodes_stat.nr_inodes++;
+				list_add(&inode->i_list, &inode_in_use);
+				list_add(&inode->i_hash, head);
+				inode->i_state = I_LOCK;
+			}
 			spin_unlock(&inode_lock);
 
+			if (err) {
+				destroy_inode(inode);
+				return NULL;
+			}
+
 			/* reiserfs specific hack right here.  We don't
 			** want this to last, and are looking for VFS changes
 			** that will allow us to get rid of it.
 			** -- mason@suse.com 
 			*/
 			if (sb->s_op->read_inode2) {
-				sb->s_op->read_inode2(inode, opaque) ;
+				sb->s_op->read_inode2(inode, data) ;
 			} else {
 				sb->s_op->read_inode(inode);
 			}
@@ -628,13 +638,13 @@
 }
 
 
-struct inode *iget4(struct super_block *sb, unsigned long ino, find_inode_t find_actor, void *opaque)
+struct inode *iget4(struct super_block *sb, unsigned long ino, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
 {
 	struct list_head * head = inode_hashtable + hash(sb,ino);
 	struct inode * inode;
 
 	spin_lock(&inode_lock);
-	inode = find_inode(sb, ino, head, find_actor, opaque);
+	inode = find_inode(sb, ino, head, test, data);
 	if (inode) {
 		__iget(inode);
 		spin_unlock(&inode_lock);
@@ -647,7 +657,7 @@
 	 * get_new_inode() will do the right thing, re-trying the search
 	 * in case it had to block at any point.
 	 */
-	return get_new_inode(sb, ino, head, find_actor, opaque);
+	return get_new_inode(sb, ino, head, test, set, data);
 }
 
 /**
diff -urN orig/fs/nfs/inode.c iget_locked-1/fs/nfs/inode.c
--- orig/fs/nfs/inode.c	Wed May  1 00:27:35 2002
+++ iget_locked-1/fs/nfs/inode.c	Fri May 10 10:32:03 2002
@@ -592,7 +592,7 @@
  * i_ino.
  */
 static int
-nfs_find_actor(struct inode *inode, unsigned long ino, void *opaque)
+nfs_find_actor(struct inode *inode, void *opaque)
 {
 	struct nfs_find_desc	*desc = (struct nfs_find_desc *)opaque;
 	struct nfs_fh		*fh = desc->fh;
@@ -610,6 +610,18 @@
 	return 1;
 }
 
+static int
+nfs_init_locked(struct inode *inode, void *opaque)
+{
+	struct nfs_find_desc	*desc = (struct nfs_find_desc *)opaque;
+	struct nfs_fh		*fh = desc->fh;
+	struct nfs_fattr	*fattr = desc->fattr;
+
+	NFS_FILEID(inode) = fattr->fileid;
+	memcpy(NFS_FH(inode), fh, sizeof(struct nfs_fh));
+	return 0;
+}
+
 /*
  * This is our own version of iget that looks up inodes by file handle
  * instead of inode number.  We use this technique instead of using
@@ -652,7 +664,7 @@
 
 	ino = nfs_fattr_to_ino_t(fattr);
 
-	if (!(inode = iget4(sb, ino, nfs_find_actor, &desc)))
+	if (!(inode = iget4(sb, ino, nfs_find_actor, nfs_init_locked, &desc)))
 		goto out_no_inode;
 
 	if (NFS_NEW(inode)) {
@@ -662,8 +674,6 @@
 
 		/* We can't support UPDATE_ATIME(), since the server will reset it */
 		NFS_FLAGS(inode) &= ~NFS_INO_NEW;
-		NFS_FILEID(inode) = fattr->fileid;
-		memcpy(NFS_FH(inode), fh, sizeof(struct nfs_fh));
 		inode->i_flags |= S_NOATIME;
 		inode->i_mode = fattr->mode;
 		/* Why so? Because we want revalidate for devices/FIFOs, and
diff -urN orig/fs/reiserfs/inode.c iget_locked-1/fs/reiserfs/inode.c
--- orig/fs/reiserfs/inode.c	Fri May 10 10:30:07 2002
+++ iget_locked-1/fs/reiserfs/inode.c	Fri May 10 10:32:03 2002
@@ -1138,6 +1138,13 @@
 // evolved as the prototype did
 //
 
+int reiserfs_init_locked_inode (struct inode * inode, void *p)
+{
+    struct reiserfs_iget4_args *args = (struct reiserfs_iget4_args *)p ;
+    INODE_PKEY(inode)->k_dir_id = cpu_to_le32(args->objectid);
+    return 0;
+}
+
 /* looks for stat data in the tree, and fills up the fields of in-core
    inode stat data fields */
 void reiserfs_read_inode2 (struct inode * inode, void *p)
@@ -1213,7 +1220,6 @@
  * reiserfs_find_actor() - "find actor" reiserfs supplies to iget4().
  *
  * @inode:    inode from hash table to check
- * @inode_no: inode number we are looking for
  * @opaque:   "cookie" passed to iget4(). This is &reiserfs_iget4_args.
  *
  * This function is called by iget4() to distinguish reiserfs inodes
@@ -1222,8 +1228,7 @@
  * inode numbers (objectids) are distinguished by parent directory ids.
  *
  */
-static int reiserfs_find_actor( struct inode *inode, 
-				unsigned long inode_no, void *opaque )
+int reiserfs_find_actor( struct inode *inode, void *opaque )
 {
     struct reiserfs_iget4_args *args;
 
@@ -1239,7 +1244,7 @@
 
     args.objectid = key->on_disk_key.k_dir_id ;
     inode = iget4 (s, key->on_disk_key.k_objectid, 
-		   reiserfs_find_actor, (void *)(&args));
+		   reiserfs_find_actor, reiserfs_init_locked_inode, (void *)(&args));
     if (!inode) 
 	return ERR_PTR(-ENOMEM) ;
 
diff -urN orig/fs/reiserfs/super.c iget_locked-1/fs/reiserfs/super.c
--- orig/fs/reiserfs/super.c	Fri May 10 10:30:07 2002
+++ iget_locked-1/fs/reiserfs/super.c	Fri May 10 10:32:03 2002
@@ -1070,7 +1070,7 @@
 	s->s_flags |= MS_RDONLY ;
     }
     args.objectid = REISERFS_ROOT_PARENT_OBJECTID ;
-    root_inode = iget4 (s, REISERFS_ROOT_OBJECTID, 0, (void *)(&args));
+    root_inode = iget4 (s, REISERFS_ROOT_OBJECTID, reiserfs_find_actor, reiserfs_init_locked_inode, (void *)(&args));
     if (!root_inode) {
 	printk ("reiserfs_fill_super: get root inode failed\n");
 	goto error;
diff -urN orig/include/linux/fs.h iget_locked-1/include/linux/fs.h
--- orig/include/linux/fs.h	Sat May  4 19:25:53 2002
+++ iget_locked-1/include/linux/fs.h	Fri May 10 10:32:04 2002
@@ -1240,11 +1240,10 @@
 extern struct inode * igrab(struct inode *);
 extern ino_t iunique(struct super_block *, ino_t);
 
-typedef int (*find_inode_t)(struct inode *, unsigned long, void *);
-extern struct inode * iget4(struct super_block *, unsigned long, find_inode_t, void *);
+extern struct inode * iget4(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
 static inline struct inode *iget(struct super_block *sb, unsigned long ino)
 {
-	return iget4(sb, ino, NULL, NULL);
+	return iget4(sb, ino, NULL, NULL, NULL);
 }
 
 extern void __iget(struct inode * inode);
diff -urN orig/include/linux/reiserfs_fs.h iget_locked-1/include/linux/reiserfs_fs.h
--- orig/include/linux/reiserfs_fs.h	Fri May 10 10:30:08 2002
+++ iget_locked-1/include/linux/reiserfs_fs.h	Fri May 10 10:32:04 2002
@@ -1820,6 +1820,8 @@
 
 void reiserfs_read_inode (struct inode * inode) ;
 void reiserfs_read_inode2(struct inode * inode, void *p) ;
+int reiserfs_find_actor(struct inode * inode, void *p) ;
+int reiserfs_init_locked_inode(struct inode * inode, void *p) ;
 void reiserfs_delete_inode (struct inode * inode);
 void reiserfs_write_inode (struct inode * inode, int) ;
 struct dentry *reiserfs_get_dentry(struct super_block *, void *) ;
