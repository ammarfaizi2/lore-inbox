Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262660AbTCPMLE>; Sun, 16 Mar 2003 07:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262661AbTCPMLE>; Sun, 16 Mar 2003 07:11:04 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:52240 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262660AbTCPMK5>; Sun, 16 Mar 2003 07:10:57 -0500
Date: Sun, 16 Mar 2003 13:21:34 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: 2.5.64-mm8
In-Reply-To: <20030316024239.484f8bda.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303161318590.12110-100000@serv>
References: <20030316024239.484f8bda.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 16 Mar 2003, Andrew Morton wrote:

> +affs-lock_kernel-fix.patch
> 
>  Missing an unlock_kernel().  (Why didn't any of the checkers notice this?)

Could you replace this the patch below?
It removes the kernel lock completely and also fixes a bitmap corruption.

bye, Roman

--- linux/fs/affs/Changes	18 May 2002 12:58:27 -0000	1.1.1.2
+++ linux/fs/affs/Changes	16 Mar 2003 00:35:30 -0000
@@ -28,6 +28,11 @@ Known bugs:
 
 Please direct bug reports to: zippel@linux-m68k.org
 
+Version 3.20
+------------
+- kill kernel lock
+- fix for a possible bitmap corruption
+
 Version 3.19
 ------------
 
--- linux/fs/affs/bitmap.c	25 May 2002 16:20:39 -0000	1.1.1.8
+++ linux/fs/affs/bitmap.c	16 Mar 2003 00:35:31 -0000
@@ -185,6 +185,8 @@ find_bmap:
 	/* search for the next bmap buffer with free bits */
 	i = sbi->s_bmap_count;
 	do {
+		if (--i < 0)
+			goto err_full;
 		bmap++;
 		bm++;
 		if (bmap < sbi->s_bmap_count)
@@ -192,8 +194,6 @@ find_bmap:
 		/* restart search at zero */
 		bmap = 0;
 		bm = sbi->s_bitmap;
-		if (--i <= 0)
-			goto err_full;
 	} while (!bm->bm_free);
 	blk = bmap * sbi->s_bmap_bits;
 
@@ -216,8 +216,8 @@ find_bmap_bit:
 	mask = ~0UL << (bit & 31);
 	blk &= ~31UL;
 
-	tmp = be32_to_cpu(*data) & mask;
-	if (tmp)
+	tmp = be32_to_cpu(*data);
+	if (tmp & mask)
 		goto find_bit;
 
 	/* scan the rest of the buffer */
@@ -230,10 +230,11 @@ find_bmap_bit:
 			goto find_bmap;
 	} while (!(tmp = *data));
 	tmp = be32_to_cpu(tmp);
+	mask = ~0;
 
 find_bit:
 	/* finally look for a free bit in the word */
-	bit = ffs(tmp) - 1;
+	bit = ffs(tmp & mask) - 1;
 	blk += bit + sbi->s_reserved;
 	mask2 = mask = 1 << (bit & 31);
 	AFFS_I(inode)->i_lastalloc = blk;
@@ -266,8 +267,8 @@ err_bh_read:
 	sbi->s_bmap_bh = NULL;
 	sbi->s_last_bmap = ~0;
 err_full:
-	pr_debug("failed\n");
 	up(&sbi->s_bmlock);
+	pr_debug("failed\n");
 	return 0;
 }
 
--- linux/fs/affs/dir.c	11 Nov 2002 18:56:16 -0000	1.1.1.6
+++ linux/fs/affs/dir.c	16 Mar 2003 00:35:31 -0000
@@ -65,8 +65,6 @@ affs_readdir(struct file *filp, void *di
 	int			 stored;
 	int			 res;
 
-	lock_kernel();
-	
 	pr_debug("AFFS: readdir(ino=%lu,f_pos=%lx)\n",inode->i_ino,(unsigned long)filp->f_pos);
 
 	stored = 0;
@@ -162,7 +160,6 @@ readdir_out:
 	affs_brelse(dir_bh);
 	affs_brelse(fh_bh);
 	affs_unlock_dir(inode);
-	unlock_kernel();
 	pr_debug("AFFS: readdir()=%d\n", stored);
 	return res;
 }
--- linux/fs/affs/inode.c	18 Nov 2002 18:46:35 -0000	1.1.1.10
+++ linux/fs/affs/inode.c	16 Mar 2003 00:35:31 -0000
@@ -195,11 +195,9 @@ affs_write_inode(struct inode *inode, in
 	if (!inode->i_nlink)
 		// possibly free block
 		return;
-	lock_kernel();
 	bh = affs_bread(sb, inode->i_ino);
 	if (!bh) {
 		affs_error(sb,"write_inode","Cannot read block %lu",inode->i_ino);
-		unlock_kernel();
 		return;
 	}
 	tail = AFFS_TAIL(sb, bh);
@@ -227,7 +225,7 @@ affs_write_inode(struct inode *inode, in
 	affs_fix_checksum(sb, bh);
 	mark_buffer_dirty_inode(bh, inode);
 	affs_brelse(bh);
-	unlock_kernel();
+	affs_free_prealloc(inode);
 }
 
 int
@@ -236,8 +234,6 @@ affs_notify_change(struct dentry *dentry
 	struct inode *inode = dentry->d_inode;
 	int error;
 
-	lock_kernel();
-
 	pr_debug("AFFS: notify_change(%lu,0x%x)\n",inode->i_ino,attr->ia_valid);
 
 	error = inode_change_ok(inode,attr);
@@ -257,7 +253,6 @@ affs_notify_change(struct dentry *dentry
 	if (!error && (attr->ia_valid & ATTR_MODE))
 		mode_to_prot(inode);
 out:
-	unlock_kernel();
 	return error;
 }
 
@@ -265,15 +260,13 @@ void
 affs_put_inode(struct inode *inode)
 {
 	pr_debug("AFFS: put_inode(ino=%lu, nlink=%u)\n", inode->i_ino, inode->i_nlink);
-	lock_kernel();
 	affs_free_prealloc(inode);
 	if (atomic_read(&inode->i_count) == 1) {
+		down(&inode->i_sem);
 		if (inode->i_size != AFFS_I(inode)->mmu_private)
 			affs_truncate(inode);
-		//if (inode->i_nlink)
-		//	affs_clear_inode(inode);
+		up(&inode->i_sem);
 	}
-	unlock_kernel();
 }
 
 void
@@ -284,9 +277,7 @@ affs_delete_inode(struct inode *inode)
 	if (S_ISREG(inode->i_mode))
 		affs_truncate(inode);
 	clear_inode(inode);
-	lock_kernel();
 	affs_free_block(inode->i_sb, inode->i_ino);
-	unlock_kernel();
 }
 
 void
--- linux/fs/affs/namei.c	11 Nov 2002 18:56:17 -0000	1.1.1.8
+++ linux/fs/affs/namei.c	16 Mar 2003 00:35:31 -0000
@@ -218,12 +218,10 @@ affs_lookup(struct inode *dir, struct de
 
 	pr_debug("AFFS: lookup(\"%.*s\")\n",(int)dentry->d_name.len,dentry->d_name.name);
 
-	lock_kernel();
 	affs_lock_dir(dir);
 	bh = affs_find_entry(dir, dentry);
 	affs_unlock_dir(dir);
 	if (IS_ERR(bh)) {
-		unlock_kernel();
 		return ERR_PTR(PTR_ERR(bh));
 	}
 	if (bh) {
@@ -240,12 +238,10 @@ affs_lookup(struct inode *dir, struct de
 		affs_brelse(bh);
 		inode = iget(sb, ino);
 		if (!inode) {
-			unlock_kernel();
 			return ERR_PTR(-EACCES);
 		}
 	}
 	dentry->d_op = AFFS_SB(sb)->s_flags & SF_INTL ? &affs_intl_dentry_operations : &affs_dentry_operations;
-	unlock_kernel();
 	d_add(dentry, inode);
 	return NULL;
 }
@@ -253,17 +249,10 @@ affs_lookup(struct inode *dir, struct de
 int
 affs_unlink(struct inode *dir, struct dentry *dentry)
 {
-	int res;
 	pr_debug("AFFS: unlink(dir=%d, \"%.*s\")\n", (u32)dir->i_ino,
 		 (int)dentry->d_name.len, dentry->d_name.name);
 
-	if (!dentry->d_inode)
-		return -ENOENT;
-
-	lock_kernel();
-	res = affs_remove_header(dentry);
-	unlock_kernel();
-	return res;
+	return affs_remove_header(dentry);
 }
 
 int
@@ -276,12 +265,9 @@ affs_create(struct inode *dir, struct de
 	pr_debug("AFFS: create(%lu,\"%.*s\",0%o)\n",dir->i_ino,(int)dentry->d_name.len,
 		 dentry->d_name.name,mode);
 
-	lock_kernel();
 	inode = affs_new_inode(dir);
-	if (!inode) {
-		unlock_kernel();
+	if (!inode)
 		return -ENOSPC;
-	}
 
 	inode->i_mode = mode;
 	mode_to_prot(inode);
@@ -294,10 +280,8 @@ affs_create(struct inode *dir, struct de
 	if (error) {
 		inode->i_nlink = 0;
 		iput(inode);
-		unlock_kernel();
 		return error;
 	}
-	unlock_kernel();
 	return 0;
 }
 
@@ -310,12 +294,9 @@ affs_mkdir(struct inode *dir, struct den
 	pr_debug("AFFS: mkdir(%lu,\"%.*s\",0%o)\n",dir->i_ino,
 		 (int)dentry->d_name.len,dentry->d_name.name,mode);
 
-	lock_kernel();
 	inode = affs_new_inode(dir);
-	if (!inode) {
-		unlock_kernel();
+	if (!inode)
 		return -ENOSPC;
-	}
 
 	inode->i_mode = S_IFDIR | mode;
 	mode_to_prot(inode);
@@ -328,10 +309,8 @@ affs_mkdir(struct inode *dir, struct den
 		inode->i_nlink = 0;
 		mark_inode_dirty(inode);
 		iput(inode);
-		unlock_kernel();
 		return error;
 	}
-	unlock_kernel();
 	return 0;
 }
 
@@ -357,14 +336,10 @@ affs_symlink(struct inode *dir, struct d
 	pr_debug("AFFS: symlink(%lu,\"%.*s\" -> \"%s\")\n",dir->i_ino,
 		 (int)dentry->d_name.len,dentry->d_name.name,symname);
 
-	lock_kernel();
 	maxlen = AFFS_SB(sb)->s_hashsize * sizeof(u32) - 1;
-	error = -ENOSPC;
 	inode  = affs_new_inode(dir);
-	if (!inode) {
-		unlock_kernel();
+	if (!inode)
 		return -ENOSPC;
-	}
 
 	inode->i_op = &affs_symlink_inode_operations;
 	inode->i_data.a_ops = &affs_symlink_aops;
@@ -410,7 +385,6 @@ affs_symlink(struct inode *dir, struct d
 	error = affs_add_entry(dir, inode, dentry, ST_SOFTLINK);
 	if (error)
 		goto err;
-	unlock_kernel();
 
 	return 0;
 
@@ -418,7 +392,6 @@ err:
 	inode->i_nlink = 0;
 	mark_inode_dirty(inode);
 	iput(inode);
-	unlock_kernel();
 	return error;
 }
 
@@ -426,23 +399,11 @@ int
 affs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = old_dentry->d_inode;
-	int error;
 
 	pr_debug("AFFS: link(%u, %u, \"%.*s\")\n", (u32)inode->i_ino, (u32)dir->i_ino,
 		 (int)dentry->d_name.len,dentry->d_name.name);
 
-	lock_kernel();
-	error = affs_add_entry(dir, inode, dentry, ST_LINKFILE);
-	if (error) {
-		/* WTF??? */
-		inode->i_nlink = 0;
-		mark_inode_dirty(inode);
-		iput(inode);
-		unlock_kernel();
-		return error;
-	}
-	unlock_kernel();
-	return 0;
+	return affs_add_entry(dir, inode, dentry, ST_LINKFILE);
 }
 
 int
@@ -453,21 +414,19 @@ affs_rename(struct inode *old_dir, struc
 	struct buffer_head *bh = NULL;
 	int retval;
 
-	lock_kernel();
 	pr_debug("AFFS: rename(old=%u,\"%*s\" to new=%u,\"%*s\")\n",
 		 (u32)old_dir->i_ino, (int)old_dentry->d_name.len, old_dentry->d_name.name,
 		 (u32)new_dir->i_ino, (int)new_dentry->d_name.len, new_dentry->d_name.name);
 
-	if ((retval = affs_check_name(new_dentry->d_name.name,new_dentry->d_name.len)))
-		goto done;
+	retval = affs_check_name(new_dentry->d_name.name,new_dentry->d_name.len);
+	if (retval)
+		return retval;
 
 	/* Unlink destination if it already exists */
 	if (new_dentry->d_inode) {
 		retval = affs_remove_header(new_dentry);
-		if (retval) {
-			unlock_kernel();
+		if (retval)
 			return retval;
-		}
 	}
 
 	retval = -EIO;
@@ -493,6 +452,5 @@ affs_rename(struct inode *old_dir, struc
 done:
 	mark_buffer_dirty_inode(bh, retval ? old_dir : new_dir);
 	affs_brelse(bh);
-	unlock_kernel();
 	return retval;
 }
--- linux/fs/affs/super.c	27 Jan 2003 21:03:20 -0000	1.1.1.15
+++ linux/fs/affs/super.c	16 Mar 2003 00:35:31 -0000
@@ -40,7 +40,6 @@ static void
 affs_put_super(struct super_block *sb)
 {
 	struct affs_sb_info *sbi = AFFS_SB(sb);
-	lock_kernel();
 	pr_debug("AFFS: put_super()\n");
 
 	if (!(sb->s_flags & MS_RDONLY)) {
@@ -58,7 +57,6 @@ affs_put_super(struct super_block *sb)
 	affs_brelse(sbi->s_root_bh);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
-	unlock_kernel();
 	return;
 }
 
@@ -67,7 +65,7 @@ affs_write_super(struct super_block *sb)
 {
 	int clean = 2;
 	struct affs_sb_info *sbi = AFFS_SB(sb);
-	lock_kernel();
+
 	if (!(sb->s_flags & MS_RDONLY)) {
 		//	if (sbi->s_bitmap[i].bm_bh) {
 		//		if (buffer_dirty(sbi->s_bitmap[i].bm_bh)) {
@@ -81,7 +79,7 @@ affs_write_super(struct super_block *sb)
 	} else
 		sb->s_dirt = 0;
 
-	unlock_kernel();
+	pr_debug("AFFS: write_super() at %lu, clean=%d\n", get_seconds(), clean);
 }
 
 static kmem_cache_t * affs_inode_cachep;
--- linux/fs/affs/symlink.c	11 Nov 2002 18:56:17 -0000	1.1.1.5
+++ linux/fs/affs/symlink.c	16 Mar 2003 00:35:31 -0000
@@ -32,9 +32,7 @@ static int affs_symlink_readpage(struct 
 	pr_debug("AFFS: follow_link(ino=%lu)\n",inode->i_ino);
 
 	err = -EIO;
-	lock_kernel();
 	bh = affs_bread(inode->i_sb, inode->i_ino);
-	unlock_kernel();
 	if (!bh)
 		goto fail;
 	i  = 0;
@@ -63,9 +61,7 @@ static int affs_symlink_readpage(struct 
 		j++;
 	}
 	link[i] = '\0';
-	lock_kernel();
 	affs_brelse(bh);
-	unlock_kernel();
 	SetPageUptodate(page);
 	kunmap(page);
 	unlock_page(page);

