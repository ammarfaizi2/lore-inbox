Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267379AbUGNNTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267379AbUGNNTP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 09:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUGNNTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 09:19:15 -0400
Received: from gprs214-226.eurotel.cz ([160.218.214.226]:36480 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267379AbUGNNTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 09:19:09 -0400
Date: Wed, 14 Jul 2004 15:15:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: ext3: bump mount count on journal replay
Message-ID: <20040714131525.GA1369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Currently, you get fsck "just to be sure" once every ~30 clean
mounts or ~30 hard shutdowns. I believe that hard shutdown is way more
likely to cause some disk corruption, so it would make sense to fsck
more often when system is hit by hard shutdown.

What about this patch?
								Pavel

--- clean.amd/fs/ext3/super.c	2004-06-22 12:38:25.000000000 +0200
+++ linux/fs/ext3/super.c	2004-07-07 22:50:26.000000000 +0200
@@ -919,7 +919,7 @@
 }
 
 static int ext3_setup_super(struct super_block *sb, struct ext3_super_block *es,
-			    int read_only)
+			    int read_only, int mount_cost)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	int res = 0;
@@ -960,7 +961,7 @@
 	if (!(__s16) le16_to_cpu(es->s_max_mnt_count))
 		es->s_max_mnt_count =
 			(__s16) cpu_to_le16(EXT3_DFL_MAX_MNT_COUNT);
-	es->s_mnt_count=cpu_to_le16(le16_to_cpu(es->s_mnt_count) + 1);
+	es->s_mnt_count=cpu_to_le16(le16_to_cpu(es->s_mnt_count) + mount_cost);
 	es->s_mtime = cpu_to_le32(get_seconds());
 	ext3_update_dynamic_rev(sb);
 	EXT3_SET_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_RECOVER);
@@ -1214,7 +1215,7 @@
 	int hblock;
 	int db_count;
 	int i;
-	int needs_recovery;
+	int needs_recovery, mount_cost = 1;
 
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -1484,9 +1485,11 @@
 	 * root first: it may be modified in the journal!
 	 */
 	if (!test_opt(sb, NOLOAD) &&
-	    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL)) {
-		if (ext3_load_journal(sb, es))
-			goto failed_mount2;
+	    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL)) { {
+		    mount_cost = 5;
+		    if (ext3_load_journal(sb, es))
+			    goto failed_mount2;
+	    }
 	} else if (journal_inum) {
 		if (ext3_create_journal(sb, es, journal_inum))
 			goto failed_mount2;
@@ -1543,7 +1546,7 @@
 		goto failed_mount3;
 	}
 
-	ext3_setup_super (sb, es, sb->s_flags & MS_RDONLY);
+	ext3_setup_super (sb, es, sb->s_flags & MS_RDONLY, mount_cost);
 	/*
 	 * akpm: core read_super() calls in here with the superblock locked.
 	 * That deadlocks, because orphan cleanup needs to lock the superblock
@@ -2069,7 +2072,7 @@
 			 */
 			ext3_clear_journal_err(sb, es);
 			sbi->s_mount_state = le16_to_cpu(es->s_state);
-			if (!ext3_setup_super (sb, es, 0))
+			if (!ext3_setup_super (sb, es, 0, 1))
 				sb->s_flags &= ~MS_RDONLY;
 		}
 	}
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
