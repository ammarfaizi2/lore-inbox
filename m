Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965398AbWH2Vja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965398AbWH2Vja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 17:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965423AbWH2Vja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 17:39:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29618 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965398AbWH2Vj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 17:39:29 -0400
Message-ID: <44F4B3FF.90601@sandeen.net>
Date: Tue, 29 Aug 2006 16:39:11 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [PATCH] ext3 should use uint for internal inode containers
References: <44EE015E.8040904@redhat.com>
In-Reply-To: <44EE015E.8040904@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Talking to sct, he'd prefer to see ext3 continue to use only uints for 
inode number containers which are internal to the filesystem, since the 
filesystem itself can only do 32-bit inode numbers (on-disk format 
restriction), and uint is always 32, while ulong is sometimes 64.  
So, this patch bumps the unsigned longs from 
ext3-inode-numbers-are-unsigned-long.patch back down to unsigned ints.

(this patch applies over that one)

Thanks,

-Eric

Signed-off-by: Eric Sandeen <esandeen@redhat.com>

diff -u a/fs/ext3/ialloc.c linux-2.6.17/fs/ext3/ialloc.c
--- a/fs/ext3/ialloc.c
+++ linux-2.6.17/fs/ext3/ialloc.c
@@ -202,7 +202,7 @@
 static int find_group_dir(struct super_block *sb, struct inode *parent)
 {
 	int ngroups = EXT3_SB(sb)->s_groups_count;
-	unsigned long freei, avefreei;
+	unsigned int freei, avefreei;
 	struct ext3_group_desc *desc, *best_desc = NULL;
 	struct buffer_head *bh;
 	int group, best_group = -1;
@@ -261,10 +261,10 @@
 	struct ext3_super_block *es = sbi->s_es;
 	int ngroups = sbi->s_groups_count;
 	int inodes_per_group = EXT3_INODES_PER_GROUP(sb);
-	unsigned long freei, avefreei;
+	unsigned int freei, avefreei;
 	ext3_fsblk_t freeb, avefreeb;
 	ext3_fsblk_t blocks_per_dir;
-	unsigned long ndirs;
+	unsigned int ndirs;
 	int max_debt, max_dirs, min_inodes;
 	ext3_grpblk_t min_blocks;
 	int group = -1, i;
diff -u a/fs/ext3/super.c linux-2.6.17/fs/ext3/super.c
--- a/fs/ext3/super.c
+++ linux-2.6.17/fs/ext3/super.c
@@ -45,7 +45,7 @@
 static int ext3_load_journal(struct super_block *, struct ext3_super_block *,
 			     unsigned long journal_devnum);
 static int ext3_create_journal(struct super_block *, struct ext3_super_block *,
-			       unsigned long);
+			       unsigned int);
 static void ext3_commit_super (struct super_block * sb,
 			       struct ext3_super_block * es,
 			       int sync);
@@ -711,7 +711,7 @@
 }
 
 static int parse_options (char *options, struct super_block *sb,
-			  unsigned long *inum, unsigned long *journal_devnum,
+			  unsigned int *inum, unsigned long *journal_devnum,
 			  ext3_fsblk_t *n_blocks_count, int is_remount)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
@@ -1353,7 +1353,7 @@
 	ext3_fsblk_t sb_block = get_sb_block(&data);
 	ext3_fsblk_t logic_sb_block;
 	unsigned long offset = 0;
-	unsigned long journal_inum = 0;
+	unsigned int journal_inum = 0;
 	unsigned long journal_devnum = 0;
 	unsigned long def_mount_opts;
 	struct inode *root;
@@ -1803,7 +1803,7 @@
 }
 
 static journal_t *ext3_get_journal(struct super_block *sb,
-				   unsigned long journal_inum)
+				   unsigned int journal_inum)
 {
 	struct inode *journal_inode;
 	journal_t *journal;
@@ -1938,7 +1938,7 @@
 			     unsigned long journal_devnum)
 {
 	journal_t *journal;
-	unsigned long journal_inum = le32_to_cpu(es->s_journal_inum);
+	unsigned int journal_inum = le32_to_cpu(es->s_journal_inum);
 	dev_t journal_dev;
 	int err = 0;
 	int really_read_only;
@@ -2024,7 +2024,7 @@
 
 static int ext3_create_journal(struct super_block * sb,
 			       struct ext3_super_block * es,
-			       unsigned long journal_inum)
+			       unsigned int journal_inum)
 {
 	journal_t *journal;
 
@@ -2037,7 +2037,7 @@
 	if (!(journal = ext3_get_journal(sb, journal_inum)))
 		return -EINVAL;
 
-	printk(KERN_INFO "EXT3-fs: creating new journal on inode %lu\n",
+	printk(KERN_INFO "EXT3-fs: creating new journal on inode %u\n",
 	       journal_inum);
 
 	if (journal_create(journal)) {


