Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271572AbRIHQda>; Sat, 8 Sep 2001 12:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271326AbRIHQdM>; Sat, 8 Sep 2001 12:33:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16644 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S271276AbRIHQc5>; Sat, 8 Sep 2001 12:32:57 -0400
Date: Sat, 8 Sep 2001 18:33:12 +0200
From: Jan Kara <jack@suse.cz>
To: viro@math.psu.edu
Cc: vs@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Freeing inode
Message-ID: <20010908183312.A11286@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010907193935.A5166@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010907193935.A5166@atrey.karlin.mff.cuni.cz>; from jack@ucw.cz on Fri, Sep 07, 2001 at 07:39:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  I was thinking a bit about the problem and marking inode bad. I think
in the case when user is over quota marking inode as bad in not clean wrt
the filesystem so I've chosen a different solution. I've created a new flag
S_NOQUOTA which says that inode shouldn't be counted to quota (actually
we already have such inodes - quota files). This way I solved the problem
and as a bonus I got rid of testing whether inode isn't quotafiles :).
  Any comments or ideas?

								Honza

PS: The patch is attached.

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="freeinode.diff"

diff -r -u -X /home/jack/.kerndiffexclude linux-2.4.10-pre4/fs/dquot.c linux-2.4.10-pre4-fix/fs/dquot.c
--- linux-2.4.10-pre4/fs/dquot.c	Tue Sep  4 12:13:23 2001
+++ linux-2.4.10-pre4-fix/fs/dquot.c	Sat Sep  8 17:50:19 2001
@@ -627,27 +627,11 @@
 	return dquot;
 }
 
-/* Check whether this inode is quota file */
-static inline int is_quotafile(struct inode *inode)
-{
-	int cnt;
-	struct quota_mount_options *dqopt = sb_dqopt(inode->i_sb);
-	struct file **files;
-
-	if (!dqopt)
-		return 0;
-	files = dqopt->files;
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if (files[cnt] && files[cnt]->f_dentry->d_inode == inode)
-			return 1;
-	return 0;
-}
-
 static int dqinit_needed(struct inode *inode, short type)
 {
 	int cnt;
 
-	if (is_quotafile(inode))
+	if (IS_NOQUOTA(inode))
 		return 0;
 	if (type != -1)
 		return inode->i_dquot[type] == NODQUOT;
@@ -675,7 +659,6 @@
 		if (filp->f_mode & FMODE_WRITE && dqinit_needed(inode, type)) {
 			file_list_unlock();
 			sb->dq_op->initialize(inode, type);
-			inode->i_flags |= S_QUOTA;
 			/* As we may have blocked we had better restart... */
 			goto restart;
 		}
@@ -1017,8 +1000,7 @@
 	short cnt;
 
 	lock_kernel();
-	/* We don't want to have quotas on quota files - nasty deadlocks possible */
-	if (is_quotafile(inode)) {
+	if (IS_NOQUOTA(inode)) {
 		unlock_kernel();
 		return;
 	}
@@ -1472,7 +1454,9 @@
 	error = -EINVAL;
 	if (inode->i_size == 0 || !check_quotafile_size(inode->i_size))
 		goto out_f;
-	dquot_drop(inode);	/* We don't want quota on quota files */
+	/* We don't want quota on quota files */
+	dquot_drop(inode);
+	inode->i_flags |= S_NOQUOTA;
 
 	set_enable_flags(dqopt, type);
 	dqopt->files[type] = f;
diff -r -u -X /home/jack/.kerndiffexclude linux-2.4.10-pre4/fs/ext2/ialloc.c linux-2.4.10-pre4-fix/fs/ext2/ialloc.c
--- linux-2.4.10-pre4/fs/ext2/ialloc.c	Fri Jul 27 20:41:20 2001
+++ linux-2.4.10-pre4-fix/fs/ext2/ialloc.c	Sat Sep  8 16:59:26 2001
@@ -194,9 +194,11 @@
 	 * Note: we must free any quota before locking the superblock,
 	 * as writing the quota to disk may need the lock as well.
 	 */
-	DQUOT_INIT(inode);
-	DQUOT_FREE_INODE(sb, inode);
-	DQUOT_DROP(inode);
+	if (!is_bad_inode(inode)) {
+		/* Quota is already initialized in iput() */
+	    	DQUOT_FREE_INODE(sb, inode);
+		DQUOT_DROP(inode);
+	}
 
 	lock_super (sb);
 	es = sb->u.ext2_sb.s_es;
@@ -453,7 +455,8 @@
 
 	unlock_super (sb);
 	if(DQUOT_ALLOC_INODE(sb, inode)) {
-		sb->dq_op->drop(inode);
+		DQUOT_DROP(inode);
+		inode->i_flags |= S_NOQUOTA;
 		inode->i_nlink = 0;
 		iput(inode);
 		return ERR_PTR(-EDQUOT);
@@ -463,6 +466,7 @@
 
 fail:
 	unlock_super(sb);
+	make_bad_inode(inode);
 	iput(inode);
 	return ERR_PTR(err);
 }
diff -r -u -X /home/jack/.kerndiffexclude linux-2.4.10-pre4/fs/inode.c linux-2.4.10-pre4-fix/fs/inode.c
--- linux-2.4.10-pre4/fs/inode.c	Tue Sep  4 12:13:23 2001
+++ linux-2.4.10-pre4-fix/fs/inode.c	Sat Sep  8 16:02:16 2001
@@ -513,8 +513,7 @@
 	if (inode->i_state & I_CLEAR)
 		BUG();
 	wait_on_inode(inode);
-	if (IS_QUOTAINIT(inode))
-		DQUOT_DROP(inode);
+	DQUOT_DROP(inode);
 	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->clear_inode)
 		inode->i_sb->s_op->clear_inode(inode);
 	if (inode->i_bdev) {
@@ -1049,7 +1048,8 @@
 
 			if (op && op->delete_inode) {
 				void (*delete)(struct inode *) = op->delete_inode;
-				DQUOT_INIT(inode);
+				if (!is_bad_inode(inode))
+					DQUOT_INIT(inode);
 				/* s_op->delete_inode internally recalls clear_inode() */
 				delete(inode);
 			} else
diff -r -u -X /home/jack/.kerndiffexclude linux-2.4.10-pre4/include/linux/fs.h linux-2.4.10-pre4-fix/include/linux/fs.h
--- linux-2.4.10-pre4/include/linux/fs.h	Fri Sep  7 23:36:04 2001
+++ linux-2.4.10-pre4-fix/include/linux/fs.h	Sat Sep  8 16:31:57 2001
@@ -129,6 +129,7 @@
 #define S_APPEND	8	/* Append-only file */
 #define S_IMMUTABLE	16	/* Immutable file */
 #define S_DEAD		32	/* removed, but still open directory */
+#define S_NOQUOTA	64	/* Inode is not counted to quota */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -153,6 +154,7 @@
 #define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
 
 #define IS_QUOTAINIT(inode)	((inode)->i_flags & S_QUOTA)
+#define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
 #define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
 #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
 #define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
diff -r -u -X /home/jack/.kerndiffexclude linux-2.4.10-pre4/include/linux/quotaops.h linux-2.4.10-pre4-fix/include/linux/quotaops.h
--- linux-2.4.10-pre4/include/linux/quotaops.h	Fri Sep  7 23:39:55 2001
+++ linux-2.4.10-pre4-fix/include/linux/quotaops.h	Sat Sep  8 17:09:29 2001
@@ -37,8 +37,10 @@
  */
 static __inline__ void DQUOT_INIT(struct inode *inode)
 {
-	if (inode->i_sb && inode->i_sb->dq_op)
-		inode->i_sb->dq_op->initialize(inode, -1);
+	if (!IS_NOQUOTA(inode)) {
+		if (inode->i_sb && inode->i_sb->dq_op)
+			inode->i_sb->dq_op->initialize(inode, -1);
+	}
 }
 
 static __inline__ void DQUOT_DROP(struct inode *inode)
@@ -70,7 +72,7 @@
 static __inline__ int DQUOT_ALLOC_INODE(struct super_block *sb, struct inode *inode)
 {
 	if (sb->dq_op) {
-		sb->dq_op->initialize (inode, -1);
+		DQUOT_INIT(inode);
 		if (sb->dq_op->alloc_inode (inode, 1))
 			return 1;
 	}
@@ -94,8 +96,8 @@
 {
 	int error = -EDQUOT;
 
-	if (dentry->d_inode->i_sb->dq_op) {
-		dentry->d_inode->i_sb->dq_op->initialize(dentry->d_inode, -1);
+	if (dentry->d_inode->i_sb->dq_op && !IS_NOQUOTA(dentry->d_inode)) {
+		DQUOT_INIT(dentry->d_inode);
 		error = dentry->d_inode->i_sb->dq_op->transfer(dentry, iattr);
 	} else {
 		error = notify_change(dentry, iattr);

--4Ckj6UjgE2iN1+kY--
