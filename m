Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSHJAzz>; Fri, 9 Aug 2002 20:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSHJAzx>; Fri, 9 Aug 2002 20:55:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19474 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316434AbSHJAzV>;
	Fri, 9 Aug 2002 20:55:21 -0400
Message-ID: <3D5464CF.DCD510D6@zip.com.au>
Date: Fri, 09 Aug 2002 17:56:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 4/12] tunable ext3 commit interval
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The patch from Stephen Tweedie allows users to modify the journal
commit interval for the ext3 filesystem.

The commit interval is normally five seconds.  For portable computers
with spun-down drives it is advantageous to be able to increase the
commit interval.

There may also be advantages in decreasing the commit interval for
specialised applications such as heavily-loaded NFS servers which are
using synchronous exports.

The laptop users will also need to increase the pdflush periodic
writeback interval (/proc/sys/vm/dirty_writeback_centisecs), because
the `kupdate' activity also forces a commit.

To specify the commit interval, use

	mount -o commit=30 /dev/hda1 /mnt/whatever

or
	mount -o remount,commit=30 /dev/hda1

The commit interval is specified in units of seconds.



 super.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions, 1 deletion

--- 2.5.30/fs/ext3/super.c~ext3-commit-interval	Fri Aug  9 17:36:40 2002
+++ 2.5.30-akpm/fs/ext3/super.c	Fri Aug  9 17:36:41 2002
@@ -696,6 +696,11 @@ static int parse_options (char * options
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
@@ -1260,6 +1265,22 @@ out_fail:
 	return -EINVAL;
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
@@ -1294,7 +1315,7 @@ static journal_t *ext3_get_journal(struc
 		printk(KERN_ERR "EXT3-fs: Could not load journal inode\n");
 		iput(journal_inode);
 	}
-	
+	ext3_init_journal_params(EXT3_SB(sb), journal);
 	return journal;
 }
 
@@ -1371,6 +1392,7 @@ static journal_t *ext3_get_dev_journal(s
 		goto out_journal;
 	}
 	EXT3_SB(sb)->journal_bdev = bdev;
+	ext3_init_journal_params(EXT3_SB(sb), journal);
 	return journal;
 out_journal:
 	journal_destroy(journal);
@@ -1667,6 +1689,8 @@ int ext3_remount (struct super_block * s
 
 	es = sbi->s_es;
 
+	ext3_init_journal_params(sbi, sbi->s_journal);
+	
 	if ((*flags & MS_RDONLY) != (sb->s_flags & MS_RDONLY)) {
 		if (sbi->s_mount_opt & EXT3_MOUNT_ABORT)
 			return -EROFS;

.
