Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261702AbTCQO6Q>; Mon, 17 Mar 2003 09:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbTCQO6Q>; Mon, 17 Mar 2003 09:58:16 -0500
Received: from hera.cwi.nl ([192.16.191.8]:22698 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261702AbTCQO6N>;
	Mon, 17 Mar 2003 09:58:13 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 17 Mar 2003 16:09:05 +0100 (MET)
Message-Id: <UTC200303171509.h2HF95N15581.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] fix affs/super.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mounting a non-affs filesystem as affs crashes the kernel.
The reason is the
	sbi = kmalloc(sizeof(struct affs_sb_info), GFP_KERNEL);
	memset(sbi, 0, sizeof(*AFFS_SB));
where the second sizeof is 1, so that sbi is not zeroed at all.
(No doubt we need kzmalloc or so.)

The patch below also does a little random polishing nearby.

Andries

-----
diff -u --recursive --new-file -X /linux/dontdiff a/fs/affs/super.c b/fs/affs/super.c
--- a/fs/affs/super.c	Thu Jan  2 14:32:11 2003
+++ b/fs/affs/super.c	Mon Mar 17 15:57:43 2003
@@ -52,8 +52,7 @@
 	}
 
 	affs_brelse(sbi->s_bmap_bh);
-	if (sbi->s_prefix)
-		kfree(sbi->s_prefix);
+	kfree(sbi->s_prefix);
 	kfree(sbi->s_bitmap);
 	affs_brelse(sbi->s_root_bh);
 	kfree(sbi);
@@ -145,8 +144,9 @@
 };
 
 static int
-parse_options(char *options, uid_t *uid, gid_t *gid, int *mode, int *reserved, s32 *root,
-		int *blocksize, char **prefix, char *volume, unsigned long *mount_opts)
+parse_options(char *options, uid_t *uid, gid_t *gid, int *mode, int *reserved,
+	      s32 *root, int *blocksize, char **prefix, char *volume,
+	      unsigned long *mount_opts)
 {
 	char	*this_char, *value, *optn;
 	int	 f;
@@ -291,7 +291,8 @@
 	int			 reserved;
 	unsigned long		 mount_flags;
 
-	pr_debug("AFFS: read_super(%s)\n",data ? (const char *)data : "no options");
+	pr_debug("AFFS: read_super(%s)\n",
+		 data ? (const char *)data : "no options");
 
 	sb->s_magic             = AFFS_SUPER_MAGIC;
 	sb->s_op                = &affs_sops;
@@ -300,7 +301,8 @@
 	if (!sbi)
 		return -ENOMEM;
 	sb->s_fs_info = sbi;
-	memset(sbi, 0, sizeof(*AFFS_SB));
+	memset(sbi, 0, sizeof(struct affs_sb_info));
+
 	init_MUTEX(&sbi->s_bmlock);
 
 	if (!parse_options(data,&uid,&gid,&i,&reserved,&root_block,
@@ -366,7 +368,7 @@
 			    be32_to_cpu(AFFS_ROOT_TAIL(sb, root_bh)->stype) == ST_ROOT) {
 				sbi->s_hashsize    = blocksize / 4 - 56;
 				sbi->s_root_block += num_bm;
-				key                        = 1;
+				key = 1;
 				goto got_root;
 			}
 			affs_brelse(root_bh);
@@ -457,32 +459,28 @@
 	/* N.B. after this point s_root_bh must be released */
 
 	if (affs_init_bitmap(sb))
-		goto out_error;
+		goto out_error1;
 
 	/* set up enough so that it can read an inode */
 
 	root_inode = iget(sb, root_block);
 	sb->s_root = d_alloc_root(root_inode);
-	if (!sb->s_root) {
-		printk(KERN_ERR "AFFS: Get root inode failed\n");
-		goto out_error;
-	}
+	if (!sb->s_root)
+		goto out_error2;
 	sb->s_root->d_op = &affs_dentry_operations;
 
-	pr_debug("AFFS: s_flags=%lX\n",sb->s_flags);
+	pr_debug("AFFS: s_flags=%lX\n", sb->s_flags);
 	return 0;
 
-	/*
-	 * Begin the cascaded cleanup ...
-	 */
-out_error:
+out_error2:
+	printk(KERN_ERR "AFFS: Get root inode failed\n");
 	if (root_inode)
 		iput(root_inode);
-	if (sbi->s_bitmap)
-		kfree(sbi->s_bitmap);
+out_error1:
+	kfree(sbi->s_bitmap);
+out_error:
 	affs_brelse(root_bh);
-	if (sbi->s_prefix)
-		kfree(sbi->s_prefix);
+	kfree(sbi->s_prefix);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
 	return -EINVAL;
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/amigaffs.h b/include/linux/amigaffs.h
--- a/include/linux/amigaffs.h	Wed Jan  1 23:54:28 2003
+++ b/include/linux/amigaffs.h	Mon Mar 17 15:09:36 2003
@@ -73,7 +73,7 @@
 affs_brelse(struct buffer_head *bh)
 {
 	if (bh)
-		pr_debug("affs_brelse: %ld\n", bh->b_blocknr);
+		pr_debug("affs_brelse: %lld\n", (long long) bh->b_blocknr);
 	brelse(bh);
 }
 
