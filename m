Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbVCDLZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbVCDLZp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262880AbVCDLX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:23:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:38618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262824AbVCDLV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:21:26 -0500
Date: Fri, 4 Mar 2005 03:20:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: yjf@stanford.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net,
       jfs-discussion@www-124.southbury.usf.ibm.com, reiser@namesys.com,
       mc@cs.stanford.edu
Subject: Re: [MC] [CHECKER] Do ext2, jfs and reiserfs respect mount -o
 sync/dirsync option?
Message-Id: <20050304032025.119ce69e.akpm@osdl.org>
In-Reply-To: <20050304102726.GS14495@marowsky-bree.de>
References: <20050304011141.5ff037dc.akpm@osdl.org>
	<Pine.GSO.4.44.0503040136010.9975-100000@elaine24.Stanford.EDU>
	<20050304102726.GS14495@marowsky-bree.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree <lmb@suse.de> wrote:
>
> On 2005-03-04T01:44:06, Junfeng Yang <yjf@stanford.edu> wrote:
> 
> > > That would be a bug.  Please send the e2fsck output.
> > 
> > Here is the trace
> > 
> > 1. file system is made with sbin/mkfs.ext2 -F -b 1024 /dev/hda9 60
> > and  mounted with -o sync,dirsync
> > 
> > 1.  operations FiSC did:
> > 
> > creat(/mnt/sbd0/0001)
> > write(/mnt/sbd0/0001)
> > rename(/mnt/sbd0/0001, /mnt/sbd0/0002)
> > mkdir(/mnt/sbd0/0003)
> > 
> > 2.  FiSC "crashed" the test machine  after mkdir returns.  Crashed
> > disk image can be downloaded at: http://fisc.stanford.edu/bug2/crash.img.bz2
> 
> I've run into similar issues. For example, a "touch foo" also isn't
> synchronous with -o sync, but stays entirely in the cache. Andrea tells
> me this is expected behaviour, so I've given up on this one...
> 

Why is that expected behaviour?  I have vague memories which agree with
that, but I cannot remember the reasoning.

>From a quick parse, ext2 seems to be full of MS_SYNCHRONOUS holes, and
there might be some O_SYNC ones there as well.

Problem is, it's subtle because we try to defer I/O until the last stage,
to avoid doing extra I/O.

So this wild scattergun patch probably does extra work and possibly extra
I/O all over the place, but I'd be interested if Junfeng could give it a
quick test.   It's against 2.6.11.

A real patch would take some painstaking work.


diff -puN fs/ext2/balloc.c~ext2-sync-fix fs/ext2/balloc.c
--- 25/fs/ext2/balloc.c~ext2-sync-fix	2005-03-04 02:49:00.000000000 -0800
+++ 25-akpm/fs/ext2/balloc.c	2005-03-04 02:49:00.000000000 -0800
@@ -139,8 +139,9 @@ static void release_blocks(struct super_
 	}
 }
 
-static int group_reserve_blocks(struct ext2_sb_info *sbi, int group_no,
-	struct ext2_group_desc *desc, struct buffer_head *bh, int count)
+static int group_reserve_blocks(struct super_block *sb,
+	struct ext2_sb_info *sbi, int group_no, struct ext2_group_desc *desc,
+	struct buffer_head *bh, int count)
 {
 	unsigned free_blocks;
 
@@ -154,6 +155,8 @@ static int group_reserve_blocks(struct e
 	desc->bg_free_blocks_count = cpu_to_le16(free_blocks - count);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
 	mark_buffer_dirty(bh);
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bh);
 	return count;
 }
 
@@ -170,6 +173,8 @@ static void group_release_blocks(struct 
 		spin_unlock(sb_bgl_lock(sbi, group_no));
 		sb->s_dirt = 1;
 		mark_buffer_dirty(bh);
+		if (sb->s_flags & MS_SYNCHRONOUS)
+			sync_dirty_buffer(bh);
 	}
 }
 
@@ -377,7 +382,7 @@ int ext2_new_block(struct inode *inode, 
 		goto io_error;
 	}
 
-	group_alloc = group_reserve_blocks(sbi, group_no, desc,
+	group_alloc = group_reserve_blocks(sb, sbi, group_no, desc,
 					gdp_bh, es_alloc);
 	if (group_alloc) {
 		ret_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
@@ -413,7 +418,7 @@ retry:
 		desc = ext2_get_group_desc(sb, group_no, &gdp_bh);
 		if (!desc)
 			goto io_error;
-		group_alloc = group_reserve_blocks(sbi, group_no, desc,
+		group_alloc = group_reserve_blocks(sb, sbi, group_no, desc,
 						gdp_bh, es_alloc);
 	}
 	if (!group_alloc) {
diff -puN fs/ext2/ialloc.c~ext2-sync-fix fs/ext2/ialloc.c
--- 25/fs/ext2/ialloc.c~ext2-sync-fix	2005-03-04 02:49:00.000000000 -0800
+++ 25-akpm/fs/ext2/ialloc.c	2005-03-04 02:54:13.000000000 -0800
@@ -86,6 +86,8 @@ static void ext2_release_inode(struct su
 		percpu_counter_dec(&EXT2_SB(sb)->s_dirs_counter);
 	sb->s_dirt = 1;
 	mark_buffer_dirty(bh);
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bh);
 }
 
 /*
@@ -563,6 +565,8 @@ got:
 
 	sb->s_dirt = 1;
 	mark_buffer_dirty(bh2);
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(bh2);
 	inode->i_uid = current->fsuid;
 	if (test_opt (sb, GRPID))
 		inode->i_gid = dir->i_gid;
@@ -614,7 +618,7 @@ got:
 		DQUOT_FREE_INODE(inode);
 		goto fail2;
 	}
-	mark_inode_dirty(inode);
+	ext2_mark_inode_dirty(inode);
 	ext2_debug("allocating inode %lu\n", inode->i_ino);
 	ext2_preread_inode(inode);
 	return inode;
diff -puN fs/ext2/super.c~ext2-sync-fix fs/ext2/super.c
--- 25/fs/ext2/super.c~ext2-sync-fix	2005-03-04 02:49:00.000000000 -0800
+++ 25-akpm/fs/ext2/super.c	2005-03-04 02:49:00.000000000 -0800
@@ -1097,6 +1097,8 @@ static ssize_t ext2_quota_write(struct s
 		set_buffer_uptodate(bh);
 		mark_buffer_dirty(bh);
 		unlock_buffer(bh);
+		if (sb->s_flags & MS_SYNCHRONOUS)
+			sync_dirty_buffer(bh);
 		brelse(bh);
 		offset = 0;
 		towrite -= tocopy;
@@ -1110,8 +1112,8 @@ out:
 		i_size_write(inode, off+len-towrite);
 	inode->i_version++;
 	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
-	mark_inode_dirty(inode);
 	up(&inode->i_sem);
+	ext2_mark_inode_dirty(inode);
 	return len - towrite;
 }
 
diff -puN fs/ext2/xattr.c~ext2-sync-fix fs/ext2/xattr.c
--- 25/fs/ext2/xattr.c~ext2-sync-fix	2005-03-04 02:49:00.000000000 -0800
+++ 25-akpm/fs/ext2/xattr.c	2005-03-04 02:49:00.000000000 -0800
@@ -348,6 +348,8 @@ static void ext2_xattr_update_super_bloc
 	sb->s_dirt = 1;
 	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	unlock_super(sb);
+	if (sb->s_flags & MS_SYNCHRONOUS)
+		sync_dirty_buffer(EXT2_SB(sb)->s_sbh);
 }
 
 /*
diff -puN fs/ext2/dir.c~ext2-sync-fix fs/ext2/dir.c
--- 25/fs/ext2/dir.c~ext2-sync-fix	2005-03-04 02:49:00.000000000 -0800
+++ 25-akpm/fs/ext2/dir.c	2005-03-04 02:49:00.000000000 -0800
@@ -428,7 +428,7 @@ void ext2_set_link(struct inode *dir, st
 	ext2_put_page(page);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
-	mark_inode_dirty(dir);
+	ext2_mark_inode_dirty(dir);
 }
 
 /*
@@ -518,7 +518,7 @@ got_it:
 	err = ext2_commit_chunk(page, from, to);
 	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
 	EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
-	mark_inode_dirty(dir);
+	ext2_mark_inode_dirty(dir);
 	/* OFFSET_CACHE */
 out_put:
 	ext2_put_page(page);
@@ -566,7 +566,7 @@ int ext2_delete_entry (struct ext2_dir_e
 	err = ext2_commit_chunk(page, from, to);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
 	EXT2_I(inode)->i_flags &= ~EXT2_BTREE_FL;
-	mark_inode_dirty(inode);
+	ext2_mark_inode_dirty(inode);
 out:
 	ext2_put_page(page);
 	return err;
diff -puN fs/ext2/inode.c~ext2-sync-fix fs/ext2/inode.c
--- 25/fs/ext2/inode.c~ext2-sync-fix	2005-03-04 02:49:00.000000000 -0800
+++ 25-akpm/fs/ext2/inode.c	2005-03-04 02:49:00.000000000 -0800
@@ -41,6 +41,17 @@ MODULE_LICENSE("GPL");
 static int ext2_update_inode(struct inode * inode, int do_sync);
 
 /*
+ * dirty an ext2 inode and sync it if needed
+ */
+int ext2_mark_inode_dirty(struct inode *inode)
+{
+	mark_inode_dirty(inode);
+	if (inode_needs_sync(inode))
+		return ext2_update_inode(inode, 1);
+	return 0;
+}
+
+/*
  * Test whether an inode is a fast symlink.
  */
 static inline int ext2_inode_is_fast_symlink(struct inode *inode)
@@ -60,8 +71,7 @@ void ext2_delete_inode (struct inode * i
 	if (is_bad_inode(inode))
 		goto no_delete;
 	EXT2_I(inode)->i_dtime	= get_seconds();
-	mark_inode_dirty(inode);
-	ext2_update_inode(inode, inode_needs_sync(inode));
+	ext2_mark_inode_dirty(inode);
 
 	inode->i_size = 0;
 	if (inode->i_blocks)
diff -puN fs/ext2/acl.c~ext2-sync-fix fs/ext2/acl.c
diff -puN fs/ext2/ioctl.c~ext2-sync-fix fs/ext2/ioctl.c
--- 25/fs/ext2/ioctl.c~ext2-sync-fix	2005-03-04 02:49:00.000000000 -0800
+++ 25-akpm/fs/ext2/ioctl.c	2005-03-04 02:49:00.000000000 -0800
@@ -60,7 +60,7 @@ int ext2_ioctl (struct inode * inode, st
 
 		ext2_set_inode_flags(inode);
 		inode->i_ctime = CURRENT_TIME_SEC;
-		mark_inode_dirty(inode);
+		ext2_mark_inode_dirty(inode);
 		return 0;
 	}
 	case EXT2_IOC_GETVERSION:
@@ -73,7 +73,7 @@ int ext2_ioctl (struct inode * inode, st
 		if (get_user(inode->i_generation, (int __user *) arg))
 			return -EFAULT;	
 		inode->i_ctime = CURRENT_TIME_SEC;
-		mark_inode_dirty(inode);
+		ext2_mark_inode_dirty(inode);
 		return 0;
 	default:
 		return -ENOTTY;
diff -puN fs/ext2/namei.c~ext2-sync-fix fs/ext2/namei.c
--- 25/fs/ext2/namei.c~ext2-sync-fix	2005-03-04 02:49:00.000000000 -0800
+++ 25-akpm/fs/ext2/namei.c	2005-03-04 02:55:15.000000000 -0800
@@ -132,7 +132,7 @@ static int ext2_create (struct inode * d
 			inode->i_mapping->a_ops = &ext2_nobh_aops;
 		else
 			inode->i_mapping->a_ops = &ext2_aops;
-		mark_inode_dirty(inode);
+		ext2_mark_inode_dirty(inode);
 		err = ext2_add_nondir(dentry, inode);
 	}
 	return err;
@@ -153,7 +153,7 @@ static int ext2_mknod (struct inode * di
 #ifdef CONFIG_EXT2_FS_XATTR
 		inode->i_op = &ext2_special_inode_operations;
 #endif
-		mark_inode_dirty(inode);
+		ext2_mark_inode_dirty(inode);
 		err = ext2_add_nondir(dentry, inode);
 	}
 	return err;
@@ -191,7 +191,7 @@ static int ext2_symlink (struct inode * 
 		memcpy((char*)(EXT2_I(inode)->i_data),symname,l);
 		inode->i_size = l-1;
 	}
-	mark_inode_dirty(inode);
+	ext2_mark_inode_dirty(inode);
 
 	err = ext2_add_nondir(dentry, inode);
 out:
diff -puN fs/ext2/ext2.h~ext2-sync-fix fs/ext2/ext2.h
--- 25/fs/ext2/ext2.h~ext2-sync-fix	2005-03-04 02:49:00.000000000 -0800
+++ 25-akpm/fs/ext2/ext2.h	2005-03-04 02:49:00.000000000 -0800
@@ -116,6 +116,7 @@ extern unsigned long ext2_count_free (st
 /* inode.c */
 extern void ext2_read_inode (struct inode *);
 extern int ext2_write_inode (struct inode *, int);
+int ext2_mark_inode_dirty(struct inode *inode);
 extern void ext2_delete_inode (struct inode *);
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
_

