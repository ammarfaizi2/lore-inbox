Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWDJR7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWDJR7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWDJR7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:59:46 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:64451 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932068AbWDJR71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:59:27 -0400
Subject: [RFC][PATCH 2/3] ext3 percpu counter read fix to suppport more
	than 2**31 free blocks
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: kiran@scalex86.org, Laurent Vivier <Laurent.Vivier@bull.net>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 10 Apr 2006 10:59:25 -0700
Message-Id: <1144691965.3964.55.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2/3] - Currently percpu_counter_read_positive() always return 1
if the counter(singed type) is negative. This leads the ext3 always get
free blocks as 1 if there are more than 2**31 free blocks, thus prevent
non-root users to write(file creation) to the filesystem. This patch
fixed this by using percpu_counter_read() instead.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>
---

 linux-2.6.16-cmm/fs/ext3/balloc.c |    2 +-
 linux-2.6.16-cmm/fs/ext3/ialloc.c |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff -puN fs/ext3/balloc.c~ext3_16tb_free_blks_counter_read_fix fs/ext3/balloc.c
--- linux-2.6.16/fs/ext3/balloc.c~ext3_16tb_free_blks_counter_read_fix	2006-04-02 11:50:06.000000000 -0700
+++ linux-2.6.16-cmm/fs/ext3/balloc.c	2006-04-02 11:50:06.000000000 -0700
@@ -1168,7 +1168,7 @@ static int ext3_has_free_blocks(struct e
 {
 	unsigned long free_blocks, root_blocks;
 
-	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	free_blocks = (unsigned long)percpu_counter_read(&sbi->s_freeblocks_counter);
 	root_blocks = le32_to_cpu(sbi->s_es->s_r_blocks_count);
 	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
 		sbi->s_resuid != current->fsuid &&
diff -puN fs/ext3/ialloc.c~ext3_16tb_free_blks_counter_read_fix fs/ext3/ialloc.c
--- linux-2.6.16/fs/ext3/ialloc.c~ext3_16tb_free_blks_counter_read_fix	2006-04-02 11:50:06.000000000 -0700
+++ linux-2.6.16-cmm/fs/ext3/ialloc.c	2006-04-02 11:50:06.000000000 -0700
@@ -202,12 +202,12 @@ error_return:
 static int find_group_dir(struct super_block *sb, struct inode *parent)
 {
 	int ngroups = EXT3_SB(sb)->s_groups_count;
-	int freei, avefreei;
+	unsigned long freei, avefreei;
 	struct ext3_group_desc *desc, *best_desc = NULL;
 	struct buffer_head *bh;
 	int group, best_group = -1;
 
-	freei = percpu_counter_read_positive(&EXT3_SB(sb)->s_freeinodes_counter);
+	freei = (unsigned long)percpu_counter_read(&EXT3_SB(sb)->s_freeinodes_counter);
 	avefreei = freei / ngroups;
 
 	for (group = 0; group < ngroups; group++) {
@@ -261,7 +261,7 @@ static int find_group_orlov(struct super
 	struct ext3_super_block *es = sbi->s_es;
 	int ngroups = sbi->s_groups_count;
 	int inodes_per_group = EXT3_INODES_PER_GROUP(sb);
-	int freei, avefreei;
+	unsigned long freei, avefreei;
 	unsigned long freeb, avefreeb;
 	int blocks_per_dir, ndirs;
 	int max_debt, max_dirs, min_blocks, min_inodes;
@@ -269,9 +269,9 @@ static int find_group_orlov(struct super
 	struct ext3_group_desc *desc;
 	struct buffer_head *bh;
 
-	freei = percpu_counter_read_positive(&sbi->s_freeinodes_counter);
+	freei = (unsigned long)percpu_counter_read(&sbi->s_freeinodes_counter);
 	avefreei = freei / ngroups;
-	freeb = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	freeb = (unsigned long)percpu_counter_read(&sbi->s_freeblocks_counter);
 	avefreeb = freeb / ngroups;
 	ndirs = percpu_counter_read_positive(&sbi->s_dirs_counter);
 
diff -puN -L ext3_16tb_freeblks_counter_mod_fix.patch /dev/null /dev/null

_


