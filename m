Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267862AbTBVJTf>; Sat, 22 Feb 2003 04:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267865AbTBVJTf>; Sat, 22 Feb 2003 04:19:35 -0500
Received: from angband.namesys.com ([212.16.7.85]:25476 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267862AbTBVJTV>; Sat, 22 Feb 2003 04:19:21 -0500
Date: Sat, 22 Feb 2003 12:29:28 +0300
From: Oleg Drokin <green@namesys.com>
To: Andrew Morton <akpm@digeo.com>, mason@suse.com, sam@vilain.net,
       vs@namesys.com, nikita@namesys.com, trond.myklebust@fys.uio.no,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4 iget5_locked port attempt to 2.4
Message-ID: <20030222122928.A13085@namesys.com>
References: <20030220175309.A23616@namesys.com> <20030220154924.7171cbd7.akpm@digeo.com> <20030221220341.A9325@namesys.com> <20030221200440.GA23699@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221200440.GA23699@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Feb 21, 2003 at 03:04:40PM -0500, Jan Harkes wrote:
> > Ok, here is my simple attempt. I just took a patch from early 2.5
> > days by jaharkes@cs.cmu.edu ;)
> Nice to see that it is being considered for a backport to 2.4, that
> would allow me to get rid of the lock around the call to iget4.

That's because we do not want to use this kind of lock in iget for reiserfs ;)

> Why didn't you take the final version that was sent to Linus? It was

I did. I extracted these patches from bitkeeper.

> against 2.5.14, but should be pretty close for 2.4.x. You can find

Still there were lots of differences in coda and especially nfs.

> it at http://delft.aura.cs.cmu.edu/icreate/, both broken up in small
> steps, and as one big patch.

They should be the same as those accepted by Linus, no?

> > Coda changes are not tested, but look correct.
> Those Coda changes are not correct as we really need to use iget4 (or
> in the new code, iget5_locked). That patch looks like it won't even
> compile, coda_inocmp is simply removed while it is still used by the two

It compiles. At least I checked that and it compiled for me.

> calls to iget4 that you didn't replace with iget5_locked. Let alone
Hm?
Probably I sent wron patch.

> adding the inode initializer. I also don't know why you are adding an
> unused local variable to coda_replace_fid.

Ah, stupid me.
That was previous version of the patch without some rejects applied manually by me.
Look at this version below ;)
Sorry.

Bye,
    Oleg

===== Documentation/filesystems/Locking 1.7 vs edited =====
--- 1.7/Documentation/filesystems/Locking	Thu Dec 19 05:34:24 2002
+++ edited/Documentation/filesystems/Locking	Fri Feb 21 14:19:38 2003
@@ -114,7 +114,7 @@
 remount_fs:	yes	yes	maybe		(see below)
 umount_begin:	yes	no	maybe		(see below)
 
-->read_inode() is not a method - it's a callback used in iget()/iget4().
+->read_inode() is not a method - it's a callback used in iget().
 rules for mount_sem are not too nice - it is going to die and be replaced
 by better scheme anyway.
 
===== fs/Makefile 1.16 vs edited =====
--- 1.16/fs/Makefile	Thu Sep 12 04:00:00 2002
+++ edited/fs/Makefile	Fri Feb 21 14:24:21 2003
@@ -7,7 +7,7 @@
 
 O_TARGET := fs.o
 
-export-objs :=	filesystems.o open.o dcache.o buffer.o
+export-objs :=	filesystems.o open.o dcache.o buffer.o inode.o
 mod-subdirs :=	nls
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
===== fs/inode.c 1.36 vs edited =====
--- 1.36/fs/inode.c	Thu Aug 29 07:02:23 2002
+++ edited/fs/inode.c	Fri Feb 21 14:20:46 2003
@@ -17,6 +17,7 @@
 #include <linux/swapctl.h>
 #include <linux/prefetch.h>
 #include <linux/locks.h>
+#include <linux/module.h>
 
 /*
  * New inode.c implementation.
@@ -783,7 +784,32 @@
  * by hand after calling find_inode now! This simplifies iunique and won't
  * add any additional branch in the common code.
  */
-static struct inode * find_inode(struct super_block * sb, unsigned long ino, struct list_head *head, find_inode_t find_actor, void *opaque)
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
@@ -799,8 +825,6 @@
 			continue;
 		if (inode->i_sb != sb)
 			continue;
-		if (find_actor && !find_actor(inode, ino, opaque))
-			continue;
 		break;
 	}
 	return inode;
@@ -832,13 +856,28 @@
 	return inode;
 }
 
+void unlock_new_inode(struct inode *inode)
+{
+	/*
+	 * This is special!  We do not need the spinlock
+	 * when clearing I_LOCK, because we're guaranteed
+	 * that nobody else tries to do anything about the
+	 * state of the inode when it is locked, as we
+	 * just created it (so there can be no old holders
+	 * that haven't tested I_LOCK).
+	 */
+	inode->i_state &= ~(I_LOCK|I_NEW);
+	wake_up(&inode->i_wait);
+}
+
+
 /*
  * This is called without the inode lock held.. Be careful.
  *
  * We no longer cache the sb_flags in i_flags - see fs.h
  *	-- rmk@arm.uk.linux.org
  */
-static struct inode * get_new_inode(struct super_block *sb, unsigned long ino, struct list_head *head, find_inode_t find_actor, void *opaque)
+static struct inode * get_new_inode(struct super_block *sb, struct list_head *head, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
 {
 	struct inode * inode;
 
@@ -848,37 +887,68 @@
 
 		spin_lock(&inode_lock);
 		/* We released the lock, so.. */
-		old = find_inode(sb, ino, head, find_actor, opaque);
+		old = find_inode(sb, head, test, data);
 		if (!old) {
+			if (set(inode, data))
+				goto set_failed;
+
 			inodes_stat.nr_inodes++;
 			list_add(&inode->i_list, &inode_in_use);
 			list_add(&inode->i_hash, head);
-			inode->i_ino = ino;
-			inode->i_state = I_LOCK;
+			inode->i_state = I_LOCK|I_NEW;
 			spin_unlock(&inode_lock);
 
-			/* reiserfs specific hack right here.  We don't
-			** want this to last, and are looking for VFS changes
-			** that will allow us to get rid of it.
-			** -- mason@suse.com 
-			*/
-			if (sb->s_op->read_inode2) {
-				sb->s_op->read_inode2(inode, opaque) ;
-			} else {
-				sb->s_op->read_inode(inode);
-			}
-
-			/*
-			 * This is special!  We do not need the spinlock
-			 * when clearing I_LOCK, because we're guaranteed
-			 * that nobody else tries to do anything about the
-			 * state of the inode when it is locked, as we
-			 * just created it (so there can be no old holders
-			 * that haven't tested I_LOCK).
+			/* Return the locked inode with I_NEW set, the
+			 * caller is responsible for filling in the contents
 			 */
-			inode->i_state &= ~I_LOCK;
-			wake_up(&inode->i_wait);
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
 
+set_failed:
+	spin_unlock(&inode_lock);
+	destroy_inode(inode);
+	return NULL;
+}
+
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
 			return inode;
 		}
 
@@ -896,9 +966,9 @@
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
@@ -930,7 +1000,8 @@
 retry:
 	if (counter > max_reserved) {
 		head = inode_hashtable + hash(sb,counter);
-		inode = find_inode(sb, res = counter++, head, NULL, NULL);
+		res = counter++;
+		inode = find_inode_fast(sb, head, res);
 		if (!inode) {
 			spin_unlock(&inode_lock);
 			return res;
@@ -958,14 +1029,18 @@
 	return inode;
 }
 
-
-struct inode *iget4(struct super_block *sb, unsigned long ino, find_inode_t find_actor, void *opaque)
+/*
+ * This is iget without the read_inode portion of get_new_inode
+ * the filesystem gets back a new locked and hashed inode and gets
+ * to fill it in before unlocking it via unlock_new_inode().
+ */
+struct inode *iget5_locked(struct super_block *sb, unsigned long hashval, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *data)
 {
-	struct list_head * head = inode_hashtable + hash(sb,ino);
+	struct list_head * head = inode_hashtable + hash(sb, hashval);
 	struct inode * inode;
 
 	spin_lock(&inode_lock);
-	inode = find_inode(sb, ino, head, find_actor, opaque);
+	inode = find_inode(sb, head, test, data);
 	if (inode) {
 		__iget(inode);
 		spin_unlock(&inode_lock);
@@ -978,22 +1053,57 @@
 	 * get_new_inode() will do the right thing, re-trying the search
 	 * in case it had to block at any point.
 	 */
-	return get_new_inode(sb, ino, head, find_actor, opaque);
+	return get_new_inode(sb, head, test, set, data);
 }
 
+/*
+ * Because most filesystems are based on 32-bit unique inode numbers some
+ * functions are duplicated to keep iget_locked as a fast path. We can avoid
+ * unnecessary pointer dereferences and function calls for this specific
+ * case. The duplicated functions (find_inode_fast and get_new_inode_fast)
+ * have the same pre- and post-conditions as their original counterparts.
+ */
+struct inode *iget_locked(struct super_block *sb, unsigned long ino)
+{
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
+}
+
+EXPORT_SYMBOL(iget5_locked);
+EXPORT_SYMBOL(iget_locked);
+EXPORT_SYMBOL(unlock_new_inode);
+
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
===== fs/coda/cnode.c 1.8 vs edited =====
--- 1.8/fs/coda/cnode.c	Wed May 29 19:20:33 2002
+++ edited/fs/coda/cnode.c	Fri Feb 21 18:35:03 2003
@@ -27,11 +27,6 @@
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
@@ -62,29 +57,46 @@
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
 	struct coda_inode_info *cii;
-	ino_t ino = coda_f2i(fid);
 	struct coda_sb_info *sbi = coda_sbp(sb);
+	unsigned long hash = coda_f2i(fid);
 
-	down(&sbi->sbi_iget4_mutex);
-	inode = iget4(sb, ino, coda_inocmp, fid);
+	inode = iget5_locked(sb, hash, coda_test_inode, coda_set_inode, fid);
 
 	if ( !inode ) { 
-		CDEBUG(D_CNODE, "coda_iget: no inode\n");
-		up(&sbi->sbi_iget4_mutex);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* check if the inode is already initialized */
-	cii = ITOC(inode);
-	if (coda_isnullfid(&cii->c_fid))
-		/* new, empty inode found... initializing */
-		cii->c_fid = *fid;
-	up(&sbi->sbi_iget4_mutex);
+	if (inode->i_state & I_NEW) {
+		cii = ITOC(inode);
+		/* we still need to set i_ino for things like stat(2) */
+		inode->i_ino = hash;
+		list_add(&cii->c_cilist, &sbi->sbi_cihead);
+		unlock_new_inode(inode);
+	}
+
 
 	/* always replace the attributes, type might have changed */
 	coda_fill_inode(inode, attr);
@@ -129,6 +141,7 @@
 		      struct ViceFid *newfid)
 {
 	struct coda_inode_info *cii;
+	unsigned long hash = coda_f2i(newfid);
 	
 	cii = ITOC(inode);
 
@@ -139,17 +152,16 @@
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
+	
 	struct inode *inode;
-	struct coda_inode_info *cii;
-	struct coda_sb_info *sbi;
+	unsigned long hash = coda_f2i(fid);
 
 	if ( !sb ) {
 		printk("coda_fid_to_inode: no sb!\n");
@@ -158,47 +170,29 @@
 
 	CDEBUG(D_INODE, "%s\n", coda_f2s(fid));
 
-	sbi = coda_sbp(sb);
-	nr = coda_f2i(fid);
-	down(&sbi->sbi_iget4_mutex);
-	inode = iget4(sb, nr, coda_inocmp, fid);
-	if ( !inode ) {
-		printk("coda_fid_to_inode: null from iget, sb %p, nr %ld.\n",
-		       sb, (long)nr);
-		goto out_unlock;
-	}
-
-	cii = ITOC(inode);
+	inode = iget5_locked(sb, hash, coda_test_inode, coda_fail_inode, fid);
+	if ( !inode )
+		return NULL;
 
-	/* The inode could already be purged due to memory pressure */
-	if (coda_isnullfid(&cii->c_fid)) {
-		inode->i_nlink = 0;
-		iput(inode);
-		goto out_unlock;
-	}
+	/* we should never see newly created inodes because we intentionally
+	 * fail in the initialization callback */
+	BUG_ON(inode->i_state & I_NEW);
 
         CDEBUG(D_INODE, "found %ld\n", inode->i_ino);
-	up(&sbi->sbi_iget4_mutex);
 	return inode;
-
-out_unlock:
-	up(&sbi->sbi_iget4_mutex);
-	return NULL;
 }
 
 /* the CONTROL inode is made without asking attributes from Venus */
 int coda_cnode_makectl(struct inode **inode, struct super_block *sb)
 {
-	int error = 0;
+	int error = -ENOMEM;
 
 	*inode = iget(sb, CTL_INO);
-	if ( *inode ) {
+	if (*inode) {
 		(*inode)->i_op = &coda_ioctl_inode_operations;
 		(*inode)->i_fop = &coda_ioctl_operations;
 		(*inode)->i_mode = 0444;
 		error = 0;
-	} else { 
-		error = -ENOMEM;
 	}
     
 	return error;
===== fs/coda/inode.c 1.9 vs edited =====
--- 1.9/fs/coda/inode.c	Wed May 29 19:17:41 2002
+++ edited/fs/coda/inode.c	Fri Feb 21 18:35:58 2003
@@ -34,7 +34,6 @@
 
 /* VFS super_block ops */
 static struct super_block *coda_read_super(struct super_block *, void *, int);
-static void coda_read_inode(struct inode *);
 static void coda_clear_inode(struct inode *);
 static void coda_put_super(struct super_block *);
 static int coda_statfs(struct super_block *sb, struct statfs *buf);
@@ -42,7 +41,6 @@
 /* exported operations */
 struct super_operations coda_super_operations =
 {
-	read_inode:	coda_read_inode,
 	clear_inode:	coda_clear_inode,
 	put_super:	coda_put_super,
 	statfs:		coda_statfs,
@@ -179,24 +177,6 @@
 
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
-	if (!coda_isnullfid(&cii->c_fid)) {
-            printk("coda_read_inode: initialized inode");
-            return;
-        }
-
-	cii->c_mapcount = 0;
-	list_add(&cii->c_cilist, &sbi->sbi_cihead);
 }
 
 static void coda_clear_inode(struct inode *inode)
===== fs/nfs/inode.c 1.18 vs edited =====
--- 1.18/fs/nfs/inode.c	Thu Aug 15 05:05:32 2002
+++ edited/fs/nfs/inode.c	Fri Feb 21 14:44:06 2003
@@ -45,7 +45,6 @@
 void nfs_zap_caches(struct inode *);
 static void nfs_invalidate_inode(struct inode *);
 
-static void nfs_read_inode(struct inode *);
 static void nfs_write_inode(struct inode *,int);
 static void nfs_delete_inode(struct inode *);
 static void nfs_put_super(struct super_block *);
@@ -55,7 +54,6 @@
 static int  nfs_show_options(struct seq_file *, struct vfsmount *);
 
 static struct super_operations nfs_sops = { 
-	read_inode:	nfs_read_inode,
 	write_inode:	nfs_write_inode,
 	delete_inode:	nfs_delete_inode,
 	put_super:	nfs_put_super,
@@ -634,7 +632,7 @@
 	 * do this once. (We don't allow inodes to change types.)
 	 */
 	if (inode->i_mode == 0) {
-		NFS_FILEID(inode) = fattr->fileid;
+//		NFS_FILEID(inode) = fattr->fileid;
 		inode->i_mode = fattr->mode;
 		/* Why so? Because we want revalidate for devices/FIFOs, and
 		 * that's precisely what we have in nfs_file_inode_operations.
@@ -650,9 +648,9 @@
 			inode->i_op = &nfs_symlink_inode_operations;
 		else
 			init_special_inode(inode, inode->i_mode, fattr->rdev);
-		memcpy(&inode->u.nfs_i.fh, fh, sizeof(inode->u.nfs_i.fh));
+//		memcpy(&inode->u.nfs_i.fh, fh, sizeof(inode->u.nfs_i.fh));
 	}
-	nfs_refresh_inode(inode, fattr);
+//	nfs_refresh_inode(inode, fattr);
 }
 
 struct nfs_find_desc {
@@ -667,7 +665,7 @@
  * i_ino.
  */
 static int
-nfs_find_actor(struct inode *inode, unsigned long ino, void *opaque)
+nfs_find_actor(struct inode *inode, void *opaque)
 {
 	struct nfs_find_desc	*desc = (struct nfs_find_desc *)opaque;
 	struct nfs_fh		*fh = desc->fh;
@@ -685,6 +683,18 @@
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
@@ -712,7 +722,7 @@
 {
 	struct nfs_find_desc desc = { fh, fattr };
 	struct inode *inode = NULL;
-	unsigned long ino;
+	unsigned long hash;
 
 	if ((fattr->valid & NFS_ATTR_FATTR) == 0)
 		goto out_no_inode;
@@ -722,12 +732,17 @@
 		goto out_no_inode;
 	}
 
-	ino = nfs_fattr_to_ino_t(fattr);
+	hash = nfs_fattr_to_ino_t(fattr);
 
-	if (!(inode = iget4(sb, ino, nfs_find_actor, &desc)))
+	if (!(inode = iget5_locked(sb, hash, nfs_find_actor, nfs_init_locked, &desc)))
 		goto out_no_inode;
 
-	nfs_fill_inode(inode, fh, fattr);
+        if (inode->i_state & I_NEW) {
+		inode->i_ino = hash;
+		nfs_fill_inode(inode, fh, fattr);
+		unlock_new_inode(inode);
+	} else
+		nfs_refresh_inode(inode, fattr);
 	dprintk("NFS: __nfs_fhget(%x/%Ld ct=%d)\n",
 		inode->i_dev, (long long)NFS_FILEID(inode),
 		atomic_read(&inode->i_count));
===== fs/reiserfs/inode.c 1.42 vs edited =====
--- 1.42/fs/reiserfs/inode.c	Thu Feb 13 15:42:42 2003
+++ edited/fs/reiserfs/inode.c	Fri Feb 21 14:29:42 2003
@@ -30,7 +30,7 @@
     lock_kernel() ; 
 
     /* The = 0 happens when we abort creating a new inode for some reason like lack of space.. */
-    if (INODE_PKEY(inode)->k_objectid != 0) { /* also handles bad_inode case */
+    if (!(inode->i_state & I_NEW) && INODE_PKEY(inode)->k_objectid != 0) { /* also handles bad_inode case */
 	down (&inode->i_sem); 
 
 	journal_begin(&th, inode->i_sb, jbegin_count) ;
@@ -887,7 +887,7 @@
 // item version directly
 //
 
-// called by read_inode
+// called by read_locked_inode
 static void init_inode (struct inode * inode, struct path * path)
 {
     struct buffer_head * bh;
@@ -1127,27 +1127,24 @@
     make_bad_inode(inode);
 }
 
-void reiserfs_read_inode(struct inode *inode) {
-    reiserfs_make_bad_inode(inode) ;
+int reiserfs_init_locked_inode (struct inode * inode, void *p)
+{
+    struct reiserfs_iget_args *args = (struct reiserfs_iget_args *)p ;
+    inode->i_ino = args->objectid;
+    INODE_PKEY(inode)->k_dir_id = cpu_to_le32(args->dirid);
+    return 0;
 }
 
-
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
-    dirino = args->objectid ;
+    dirino = args->dirid ;
 
     /* set version 1, version 2 could be used too, because stat data
        key is the same in both versions */
@@ -1160,7 +1157,7 @@
     /* look for the object's stat data */
     retval = search_item (inode->i_sb, &key, &path_to_sd);
     if (retval == IO_ERROR) {
-	reiserfs_warning ("vs-13070: reiserfs_read_inode2: "
+	reiserfs_warning ("vs-13070: reiserfs_read_locked_inode: "
                     "i/o failure occurred trying to find stat data of %K\n",
                     &key);
 	reiserfs_make_bad_inode(inode) ;
@@ -1192,7 +1189,7 @@
        during mount (fs/reiserfs/super.c:finish_unfinished()). */
     if( ( inode -> i_nlink == 0 ) && 
 	! inode -> i_sb -> u.reiserfs_sb.s_is_unlinked_ok ) {
-	    reiserfs_warning( "vs-13075: reiserfs_read_inode2: "
+	    reiserfs_warning( "vs-13075: reiserfs_read_locked_inode: "
 			      "dead inode read from disk %K. "
 			      "This is likely to be race with knfsd. Ignore\n", 
 			      &key );
@@ -1204,38 +1201,43 @@
 }
 
 /**
- * reiserfs_find_actor() - "find actor" reiserfs supplies to iget4().
+ * reiserfs_find_actor() - "find actor" reiserfs supplies to iget5_locked().
  *
  * @inode:    inode from hash table to check
- * @inode_no: inode number we are looking for
- * @opaque:   "cookie" passed to iget4(). This is &reiserfs_iget4_args.
+ * @opaque:   "cookie" passed to iget5_locked(). This is &reiserfs_iget_args.
  *
- * This function is called by iget4() to distinguish reiserfs inodes
+ * This function is called by iget5_locked() to distinguish reiserfs inodes
  * having the same inode numbers. Such inodes can only exist due to some
  * error condition. One of them should be bad. Inodes with identical
  * inode numbers (objectids) are distinguished by parent directory ids.
  *
  */
-static int reiserfs_find_actor( struct inode *inode, 
-				unsigned long inode_no, void *opaque )
+int reiserfs_find_actor( struct inode *inode, void *opaque )
 {
-    struct reiserfs_iget4_args *args;
+    struct reiserfs_iget_args *args;
 
     args = opaque;
     /* args is already in CPU order */
-    return le32_to_cpu(INODE_PKEY(inode)->k_dir_id) == args -> objectid;
+    return (inode->i_ino == args->objectid) &&
+	(le32_to_cpu(INODE_PKEY(inode)->k_dir_id) == args->dirid);
 }
 
 struct inode * reiserfs_iget (struct super_block * s, const struct cpu_key * key)
 {
     struct inode * inode;
-    struct reiserfs_iget4_args args ;
+    struct reiserfs_iget_args args ;
 
-    args.objectid = key->on_disk_key.k_dir_id ;
-    inode = iget4 (s, key->on_disk_key.k_objectid, 
-		   reiserfs_find_actor, (void *)(&args));
+    args.objectid = key->on_disk_key.k_objectid ;
+    args.dirid = key->on_disk_key.k_dir_id ;
+    inode = iget5_locked (s, key->on_disk_key.k_objectid, 
+		   reiserfs_find_actor, reiserfs_init_locked_inode, (void *)(&args));
     if (!inode) 
 	return ERR_PTR(-ENOMEM) ;
+
+    if (inode->i_state & I_NEW) {
+	reiserfs_read_locked_inode(inode, &args);
+	unlock_new_inode(inode);
+    }
 
     if (comp_short_keys (INODE_PKEY (inode), key) || is_bad_inode (inode)) {
 	/* either due to i/o error or a stale NFS handle */
===== fs/reiserfs/super.c 1.27 vs edited =====
--- 1.27/fs/reiserfs/super.c	Wed Oct 30 19:42:36 2002
+++ edited/fs/reiserfs/super.c	Fri Feb 21 14:28:06 2003
@@ -381,8 +381,6 @@
 
 struct super_operations reiserfs_sops = 
 {
-  read_inode: reiserfs_read_inode,
-  read_inode2: reiserfs_read_inode2,
   write_inode: reiserfs_write_inode,
   dirty_inode: reiserfs_dirty_inode,
   delete_inode: reiserfs_delete_inode,
@@ -1117,7 +1115,7 @@
     int old_format = 0;
     unsigned long blocks;
     int jinit_done = 0 ;
-    struct reiserfs_iget4_args args ;
+    struct reiserfs_iget_args args ;
     int old_magic;
     struct reiserfs_super_block * rs;
 
@@ -1194,11 +1192,17 @@
         printk("clm-7000: Detected readonly device, marking FS readonly\n") ;
 	s->s_flags |= MS_RDONLY ;
     }
-    args.objectid = REISERFS_ROOT_PARENT_OBJECTID ;
-    root_inode = iget4 (s, REISERFS_ROOT_OBJECTID, 0, (void *)(&args));
+    args.objectid = REISERFS_ROOT_OBJECTID ;
+    args.dirid = REISERFS_ROOT_PARENT_OBJECTID ;
+    root_inode = iget5_locked (s, REISERFS_ROOT_OBJECTID, reiserfs_find_actor, reiserfs_init_locked_inode, (void *)(&args));
     if (!root_inode) {
 	printk ("reiserfs_read_super: get root inode failed\n");
 	goto error;
+    }
+ 
+    if (root_inode->i_state & I_NEW) {
+	reiserfs_read_locked_inode(root_inode, &args);
+	unlock_new_inode(root_inode);
     }
 
     s->s_root = d_alloc_root(root_inode);  
===== include/linux/fs.h 1.74 vs edited =====
--- 1.74/include/linux/fs.h	Sat Jan  4 06:09:16 2003
+++ edited/include/linux/fs.h	Fri Feb 21 15:18:40 2003
@@ -885,13 +885,6 @@
 
 	void (*read_inode) (struct inode *);
   
-  	/* reiserfs kludge.  reiserfs needs 64 bits of information to
-    	** find an inode.  We are using the read_inode2 call to get
-   	** that information.  We don't like this, and are waiting on some
-   	** VFS changes for the real solution.
-   	** iget4 calls read_inode2, iff it is defined
-   	*/
-    	void (*read_inode2) (struct inode *, void *) ;
    	void (*dirty_inode) (struct inode *);
 	void (*write_inode) (struct inode *, int);
 	void (*put_inode) (struct inode *);
@@ -940,6 +933,7 @@
 #define I_LOCK			8
 #define I_FREEING		16
 #define I_CLEAR			32
+#define I_NEW			64
 
 #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
 
@@ -1378,19 +1372,32 @@
 extern struct inode * igrab(struct inode *);
 extern ino_t iunique(struct super_block *, ino_t);
 
-typedef int (*find_inode_t)(struct inode *, unsigned long, void *);
-extern struct inode * iget4(struct super_block *, unsigned long, find_inode_t, void *);
+extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
+extern struct inode * iget_locked(struct super_block *, unsigned long);
+extern void unlock_new_inode(struct inode *);
+
 static inline struct inode *iget(struct super_block *sb, unsigned long ino)
 {
-	return iget4(sb, ino, NULL, NULL);
+	struct inode *inode = iget_locked(sb, ino);
+
+	if (inode && (inode->i_state & I_NEW)) {
+		sb->s_op->read_inode(inode);
+		unlock_new_inode(inode);
+	}
+
+	return inode;
 }
 
 extern void clear_inode(struct inode *);
 extern struct inode *new_inode(struct super_block *sb);
 extern void remove_suid(struct inode *inode);
 
-extern void insert_inode_hash(struct inode *);
+extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 extern void remove_inode_hash(struct inode *);
+static inline void insert_inode_hash(struct inode *inode) {
+	__insert_inode_hash(inode, inode->i_ino);
+}
+
 extern struct file * get_empty_filp(void);
 extern void file_move(struct file *f, struct list_head *list);
 extern struct buffer_head * get_hash_table(kdev_t, int, int);
===== include/linux/reiserfs_fs.h 1.26 vs edited =====
--- 1.26/include/linux/reiserfs_fs.h	Mon Jan 20 13:19:30 2003
+++ edited/include/linux/reiserfs_fs.h	Fri Feb 21 15:20:00 2003
@@ -1478,8 +1478,9 @@
 #define B_I_POS_UNFM_POINTER(bh,ih,pos) le32_to_cpu(*(((unp_t *)B_I_PITEM(bh,ih)) + (pos)))
 #define PUT_B_I_POS_UNFM_POINTER(bh,ih,pos, val) do {*(((unp_t *)B_I_PITEM(bh,ih)) + (pos)) = cpu_to_le32(val); } while (0)
 
-struct reiserfs_iget4_args {
+struct reiserfs_iget_args {
     __u32 objectid ;
+    __u32 dirid ;
 } ;
 
 /***************************************************************************/
@@ -1730,8 +1731,9 @@
 
 /* inode.c */
 
-void reiserfs_read_inode (struct inode * inode) ;
-void reiserfs_read_inode2(struct inode * inode, void *p) ;
+void reiserfs_read_locked_inode(struct inode * inode, struct reiserfs_iget_args *args) ;
+int reiserfs_find_actor(struct inode * inode, void *p) ;
+int reiserfs_init_locked_inode(struct inode * inode, void *p) ;
 void reiserfs_delete_inode (struct inode * inode);
 void reiserfs_write_inode (struct inode * inode, int) ;
 struct dentry *reiserfs_fh_to_dentry(struct super_block *sb, __u32 *data,
===== kernel/ksyms.c 1.67 vs edited =====
--- 1.67/kernel/ksyms.c	Tue Oct  1 22:34:41 2002
+++ edited/kernel/ksyms.c	Fri Feb 21 14:19:50 2003
@@ -140,7 +140,6 @@
 EXPORT_SYMBOL(fget);
 EXPORT_SYMBOL(igrab);
 EXPORT_SYMBOL(iunique);
-EXPORT_SYMBOL(iget4);
 EXPORT_SYMBOL(iput);
 EXPORT_SYMBOL(inode_init_once);
 EXPORT_SYMBOL(force_delete);
@@ -528,7 +527,7 @@
 EXPORT_SYMBOL(read_ahead);
 EXPORT_SYMBOL(get_hash_table);
 EXPORT_SYMBOL(new_inode);
-EXPORT_SYMBOL(insert_inode_hash);
+EXPORT_SYMBOL(__insert_inode_hash);
 EXPORT_SYMBOL(remove_inode_hash);
 EXPORT_SYMBOL(buffer_insert_list);
 EXPORT_SYMBOL(make_bad_inode);
