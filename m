Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315964AbSETNK7>; Mon, 20 May 2002 09:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315974AbSETNK6>; Mon, 20 May 2002 09:10:58 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:49825 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S315964AbSETNKw>; Mon, 20 May 2002 09:10:52 -0400
Date: Mon, 20 May 2002 09:10:51 -0400
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.16 iget_locked [5/6]
Message-ID: <20020520131051.GD13865@ravel.coda.cs.cmu.edu>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020520130005.GA13816@ravel.coda.cs.cmu.edu> <20020520130435.GA13865@ravel.coda.cs.cmu.edu> <20020520130535.GB13865@ravel.coda.cs.cmu.edu> <20020520130906.GC13865@ravel.coda.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch starts taking i_ino dependencies out of the VFS. The FS
provided test and set callbacks become responsible for testing and
setting inode->i_ino.

Because most filesystems are based on 32-bit unique inode numbers
several functions are duplicated to keep iget_locked as a fast path. We
can avoid unnecessary pointer dereferences and function calls for this
specific case.


diff -urN iget_locked-4/Documentation/filesystems/porting iget_locked-5/Documentation/filesystems/porting
--- iget_locked-4/Documentation/filesystems/porting	Sun May 19 18:12:14 2002
+++ iget_locked-5/Documentation/filesystems/porting	Sun May 19 18:15:11 2002
@@ -175,8 +175,10 @@
 called so the file system still has to finalize the initialization. Once
 the inode is initialized it must be unlocked by calling unlock_new_inode().
 
-There is also a simpler iget_locked function that just takes the
-superblock and inode number as arguments.
+The filesystem is responsible for setting (and possibly testing) i_ino
+when appropriate. There is also a simpler iget_locked function that
+just takes the superblock and inode number as arguments and does the
+test and set for you.
 
 e.g.
        inode = iget_locked(sb, ino);
diff -urN iget_locked-4/fs/coda/cnode.c iget_locked-5/fs/coda/cnode.c
--- iget_locked-4/fs/coda/cnode.c	Sun May 19 18:07:01 2002
+++ iget_locked-5/fs/coda/cnode.c	Sun May 19 18:15:11 2002
@@ -83,6 +83,7 @@
 
 	if (inode->i_state & I_NEW) {
 		cii = ITOC(inode);
+		inode->i_ino = ino;
 		list_add(&cii->c_cilist, &sbi->sbi_cihead);
 		unlock_new_inode(inode);
 	}
diff -urN iget_locked-4/fs/inode.c iget_locked-5/fs/inode.c
--- iget_locked-4/fs/inode.c	Sun May 19 18:11:28 2002
+++ iget_locked-5/fs/inode.c	Sun May 19 18:21:19 2002
@@ -453,7 +453,32 @@
  * by hand after calling find_inode now! This simplifies iunique and won't
  * add any additional branch in the common code.
  */
-static struct inode * find_inode(struct super_block * sb, unsigned long ino, struct list_head *head, int (*test)(struct inode *, void *), void *data)
+static struct inode * find_inode(struct super_block * sb, struct list_head *head, int (*test)(struct inode *, void *), void *data)
+{
+	struct list_head *tmp;
+	struct inode * inode;
+
+	tmp = head;
+	for (;;) {
+		tmp = tmp->next;
+		inode = NULL;
+		if (tmp == head)
+			break;
+		inode = list_entry(tmp, struct inode, i_hash);
+		if (inode->i_sb != sb)
+			continue;
+		if (!test(inode, data))
+			continue;
+		break;
+	}
+	return inode;
+}
+
+/*
+ * find_inode_fast is the fast path version of find_inode, see the comment at
+ * iget_locked for details.
+ */
+static struct inode * find_inode_fast(struct super_block * sb, struct list_head *head, unsigned long ino)
 {
 	struct list_head *tmp;
 	struct inode * inode;
@@ -469,8 +494,6 @@
 			continue;
 		if (inode->i_sb != sb)
 			continue;
-		if (test && !test(inode, data))
-			continue;
 		break;
 	}
 	return inode;
@@ -523,10 +546,9 @@
  * We no longer cache the sb_flags in i_flags - see fs.h
  *	-- rmk@arm.uk.linux.org
  */
-static struct inode * get_new_inode(struct super_block *sb, unsigned long ino, struct list_head *head, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
+static struct inode * get_new_inode(struct super_block *sb, struct list_head *head, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
 {
 	struct inode * inode;
-	int err = 0;
 
 	inode = alloc_inode(sb);
 	if (inode) {
@@ -534,10 +556,9 @@
 
 		spin_lock(&inode_lock);
 		/* We released the lock, so.. */
-		old = find_inode(sb, ino, head, test, data);
+		old = find_inode(sb, head, test, data);
 		if (!old) {
-			inode->i_ino = ino;
-			if (set && set(inode, data))
+			if (set(inode, data))
 				goto set_failed;
 
 			inodes_stat.nr_inodes++;
@@ -571,6 +592,49 @@
 	return NULL;
 }
 
+/*
+ * get_new_inode_fast is the fast path version of get_new_inode, see the
+ * comment at iget_locked for details.
+ */
+static struct inode * get_new_inode_fast(struct super_block *sb, struct list_head *head, unsigned long ino)
+{
+	struct inode * inode;
+
+	inode = alloc_inode(sb);
+	if (inode) {
+		struct inode * old;
+
+		spin_lock(&inode_lock);
+		/* We released the lock, so.. */
+		old = find_inode_fast(sb, head, ino);
+		if (!old) {
+			inode->i_ino = ino;
+			inodes_stat.nr_inodes++;
+			list_add(&inode->i_list, &inode_in_use);
+			list_add(&inode->i_hash, head);
+			inode->i_state = I_LOCK|I_NEW;
+			spin_unlock(&inode_lock);
+
+			/* Return the locked inode with I_NEW set, the
+			 * caller is responsible for filling in the contents
+			 */
+			return inode;
+		}
+
+		/*
+		 * Uhhuh, somebody else created the same inode under
+		 * us. Use the old inode instead of the one we just
+		 * allocated.
+		 */
+		__iget(old);
+		spin_unlock(&inode_lock);
+		destroy_inode(inode);
+		inode = old;
+		wait_on_inode(inode);
+	}
+	return inode;
+}
+
 static inline unsigned long hash(struct super_block *sb, unsigned long i_ino)
 {
 	unsigned long tmp = i_ino + ((unsigned long) sb / L1_CACHE_BYTES);
@@ -605,7 +669,8 @@
 retry:
 	if (counter > max_reserved) {
 		head = inode_hashtable + hash(sb,counter);
-		inode = find_inode(sb, res = counter++, head, NULL, NULL);
+		res = counter++;
+		inode = find_inode_fast(sb, head, res);
 		if (!inode) {
 			spin_unlock(&inode_lock);
 			return res;
@@ -644,7 +709,7 @@
 	struct inode * inode;
 
 	spin_lock(&inode_lock);
-	inode = find_inode(sb, ino, head, test, data);
+	inode = find_inode(sb, head, test, data);
 	if (inode) {
 		__iget(inode);
 		spin_unlock(&inode_lock);
@@ -657,12 +722,36 @@
 	 * get_new_inode() will do the right thing, re-trying the search
 	 * in case it had to block at any point.
 	 */
-	return get_new_inode(sb, ino, head, test, set, data);
+	return get_new_inode(sb, head, test, set, data);
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
-	return iget5_locked(sb, ino, NULL, NULL, NULL);
+	struct list_head * head = inode_hashtable + hash(sb, ino);
+	struct inode * inode;
+
+	spin_lock(&inode_lock);
+	inode = find_inode_fast(sb, head, ino);
+	if (inode) {
+		__iget(inode);
+		spin_unlock(&inode_lock);
+		wait_on_inode(inode);
+		return inode;
+	}
+	spin_unlock(&inode_lock);
+
+	/*
+	 * get_new_inode_fast() will do the right thing, re-trying the search
+	 * in case it had to block at any point.
+	 */
+	return get_new_inode_fast(sb, head, ino);
 }
 
 EXPORT_SYMBOL(iget5_locked);
diff -urN iget_locked-4/fs/nfs/inode.c iget_locked-5/fs/nfs/inode.c
--- iget_locked-4/fs/nfs/inode.c	Sun May 19 18:09:14 2002
+++ iget_locked-5/fs/nfs/inode.c	Sun May 19 18:15:11 2002
@@ -661,6 +661,8 @@
 		loff_t		new_isize;
 		time_t		new_atime;
 
+		inode->i_ino = ino;
+
 		/* We can't support UPDATE_ATIME(), since the server will reset it */
 		inode->i_flags |= S_NOATIME;
 		inode->i_mode = fattr->mode;
diff -urN iget_locked-4/fs/reiserfs/inode.c iget_locked-5/fs/reiserfs/inode.c
--- iget_locked-4/fs/reiserfs/inode.c	Sun May 19 18:10:06 2002
+++ iget_locked-5/fs/reiserfs/inode.c	Sun May 19 18:15:11 2002
@@ -1136,7 +1136,8 @@
 int reiserfs_init_locked_inode (struct inode * inode, void *p)
 {
     struct reiserfs_iget_args *args = (struct reiserfs_iget_args *)p ;
-    INODE_PKEY(inode)->k_dir_id = cpu_to_le32(args->objectid);
+    inode->i_ino = args->objectid;
+    INODE_PKEY(inode)->k_dir_id = cpu_to_le32(args->dirid);
     return 0;
 }
 
@@ -1149,7 +1150,7 @@
     unsigned long dirino;
     int retval;
 
-    dirino = args->objectid ;
+    dirino = args->dirid ;
 
     /* set version 1, version 2 could be used too, because stat data
        key is the same in both versions */
@@ -1223,7 +1224,8 @@
 
     args = opaque;
     /* args is already in CPU order */
-    return le32_to_cpu(INODE_PKEY(inode)->k_dir_id) == args -> objectid;
+    return (inode->i_ino == args->objectid) &&
+	(le32_to_cpu(INODE_PKEY(inode)->k_dir_id) == args->dirid);
 }
 
 struct inode * reiserfs_iget (struct super_block * s, const struct cpu_key * key)
@@ -1231,7 +1233,8 @@
     struct inode * inode;
     struct reiserfs_iget_args args ;
 
-    args.objectid = key->on_disk_key.k_dir_id ;
+    args.objectid = key->on_disk_key.k_objectid ;
+    args.dirid = key->on_disk_key.k_dir_id ;
     inode = iget5_locked (s, key->on_disk_key.k_objectid, 
 		   reiserfs_find_actor, reiserfs_init_locked_inode, (void *)(&args));
     if (!inode) 
diff -urN iget_locked-4/fs/reiserfs/super.c iget_locked-5/fs/reiserfs/super.c
--- iget_locked-4/fs/reiserfs/super.c	Sun May 19 18:10:31 2002
+++ iget_locked-5/fs/reiserfs/super.c	Sun May 19 18:15:11 2002
@@ -1067,7 +1067,8 @@
         printk("clm-7000: Detected readonly device, marking FS readonly\n") ;
 	s->s_flags |= MS_RDONLY ;
     }
-    args.objectid = REISERFS_ROOT_PARENT_OBJECTID ;
+    args.objectid = REISERFS_ROOT_OBJECTID ;
+    args.dirid = REISERFS_ROOT_PARENT_OBJECTID ;
     root_inode = iget5_locked (s, REISERFS_ROOT_OBJECTID, reiserfs_find_actor, reiserfs_init_locked_inode, (void *)(&args));
     if (!root_inode) {
 	printk ("reiserfs_fill_super: get root inode failed\n");
diff -urN iget_locked-4/include/linux/reiserfs_fs.h iget_locked-5/include/linux/reiserfs_fs.h
--- iget_locked-4/include/linux/reiserfs_fs.h	Sun May 19 18:10:42 2002
+++ iget_locked-5/include/linux/reiserfs_fs.h	Sun May 19 18:15:11 2002
@@ -1566,6 +1566,7 @@
 
 struct reiserfs_iget_args {
     __u32 objectid ;
+    __u32 dirid ;
 } ;
 
 /***************************************************************************/
