Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269270AbUI3N2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269270AbUI3N2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 09:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbUI3N2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 09:28:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43928 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269273AbUI3NYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 09:24:44 -0400
Date: Thu, 30 Sep 2004 14:23:55 +0100
Message-Id: <200409301323.i8UDNt3D004802@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       ext2-devel@lists.sourceforge.net
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 8/10]: ext3 online resize: remove s_debts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s_debts is currently not used by ext3 (it is created, destroyed and
checked but never set).  Remove it for now.

Resurrecting this will require adding it back in changed form.  In
existing form it's already unsafe wrt. byte-tearing as it performs
unlocked byte increment/decrement on words which may be being accessed
simultaneously on other CPUs.  It is also the only in-memory dynamic
table which needs to be extended by online-resize, so locking it will
require care.

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc2-mm4/fs/ext3/ialloc.c.=K0007=.orig
+++ linux-2.6.9-rc2-mm4/fs/ext3/ialloc.c
@@ -320,8 +320,6 @@ static int find_group_orlov(struct super
 		desc = ext3_get_group_desc (sb, group, &bh);
 		if (!desc || !desc->bg_free_inodes_count)
 			continue;
-		if (sbi->s_debts[group] >= max_debt)
-			continue;
 		if (le16_to_cpu(desc->bg_used_dirs_count) >= max_dirs)
 			continue;
 		if (le16_to_cpu(desc->bg_free_inodes_count) < min_inodes)
--- linux-2.6.9-rc2-mm4/fs/ext3/super.c.=K0007=.orig
+++ linux-2.6.9-rc2-mm4/fs/ext3/super.c
@@ -400,7 +400,6 @@ void ext3_put_super (struct super_block 
 	for (i = 0; i < sbi->s_gdb_count; i++)
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
-	kfree(sbi->s_debts);
 	brelse(sbi->s_sbh);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++) {
@@ -1460,13 +1459,6 @@ static int ext3_fill_super (struct super
 		printk (KERN_ERR "EXT3-fs: not enough memory\n");
 		goto failed_mount;
 	}
-	sbi->s_debts = kmalloc(sbi->s_groups_count * sizeof(u8),
-			GFP_KERNEL);
-	if (!sbi->s_debts) {
-		printk("EXT3-fs: not enough memory to allocate s_bgi\n");
-		goto failed_mount2;
-	}
-	memset(sbi->s_debts, 0,  sbi->s_groups_count * sizeof(u8));
 
 	percpu_counter_init(&sbi->s_freeblocks_counter);
 	percpu_counter_init(&sbi->s_freeinodes_counter);
@@ -1618,7 +1610,6 @@ static int ext3_fill_super (struct super
 failed_mount3:
 	journal_destroy(sbi->s_journal);
 failed_mount2:
-	kfree(sbi->s_debts);
 	for (i = 0; i < db_count; i++)
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
--- linux-2.6.9-rc2-mm4/include/linux/ext3_fs_sb.h.=K0007=.orig
+++ linux-2.6.9-rc2-mm4/include/linux/ext3_fs_sb.h
@@ -54,7 +54,6 @@ struct ext3_sb_info {
 	u32 s_next_generation;
 	u32 s_hash_seed[4];
 	int s_def_hash_version;
-        u8 *s_debts;
 	struct percpu_counter s_freeblocks_counter;
 	struct percpu_counter s_freeinodes_counter;
 	struct percpu_counter s_dirs_counter;
