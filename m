Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSIZNv6>; Thu, 26 Sep 2002 09:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbSIZNue>; Thu, 26 Sep 2002 09:50:34 -0400
Received: from pc-62-31-66-34-ed.blueyonder.co.uk ([62.31.66.34]:21379 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261290AbSIZNu3>; Thu, 26 Sep 2002 09:50:29 -0400
Date: Thu, 26 Sep 2002 14:55:32 +0100
Message-Id: <200209261355.g8QDtWh17010@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 6/7] 2.4.20-pre4/ext3: jbd commit interval tuning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow an arbitrary commit interval to be set when mounting or remounting
a filesystem.

Note that if this is greater than the system bdflush interval, then the
regular sync()s will beat the commit timer and you won't get longer
commit timeouts.

--- linux-2.4-ext3merge/fs/ext3/super.c.=K0005=.orig	Thu Sep 26 12:25:37 2002
+++ linux-2.4-ext3merge/fs/ext3/super.c	Thu Sep 26 12:25:37 2002
@@ -646,6 +646,11 @@
 				*mount_options &= ~EXT3_MOUNT_DATA_FLAGS;
 				*mount_options |= data_opt;
 			}
+		} else if (!strcmp (this_char, "commit")) {
+			unsigned long v;
+			if (want_numeric(value, "commit", &v))
+				return 0;
+			sbi->s_commit_interval = (HZ * v);
 		} else {
 			printk (KERN_ERR 
 				"EXT3-fs: Unrecognized mount option %s\n",
@@ -1228,6 +1233,22 @@
 	return NULL;
 }
 
+/*
+ * Setup any per-fs journal parameters now.  We'll do this both on
+ * initial mount, once the journal has been initialised but before we've
+ * done any recovery; and again on any subsequent remount. 
+ */
+static void ext3_init_journal_params(struct ext3_sb_info *sbi, 
+				     journal_t *journal)
+{
+	if (sbi->s_commit_interval)
+		journal->j_commit_interval = sbi->s_commit_interval;
+	/* We could also set up an ext3-specific default for the commit
+	 * interval here, but for now we'll just fall back to the jbd
+	 * default. */
+}
+
+
 static journal_t *ext3_get_journal(struct super_block *sb, int journal_inum)
 {
 	struct inode *journal_inode;
@@ -1262,7 +1283,7 @@
 		printk(KERN_ERR "EXT3-fs: Could not load journal inode\n");
 		iput(journal_inode);
 	}
-	
+	ext3_init_journal_params(EXT3_SB(sb), journal);
 	return journal;
 }
 
@@ -1340,6 +1361,7 @@
 		goto out_journal;
 	}
 	EXT3_SB(sb)->journal_bdev = bdev;
+	ext3_init_journal_params(EXT3_SB(sb), journal);
 	return journal;
 out_journal:
 	journal_destroy(journal);
@@ -1637,6 +1659,8 @@
 
 	es = sbi->s_es;
 
+	ext3_init_journal_params(sbi, sbi->s_journal);
+	
 	if ((*flags & MS_RDONLY) != (sb->s_flags & MS_RDONLY)) {
 		if (sbi->s_mount_opt & EXT3_MOUNT_ABORT)
 			return -EROFS;
