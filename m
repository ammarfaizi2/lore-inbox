Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266624AbUGPVHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266624AbUGPVHf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 17:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUGPVHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 17:07:32 -0400
Received: from gprs214-186.eurotel.cz ([160.218.214.186]:55682 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266624AbUGPVHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 17:07:07 -0400
Date: Fri, 16 Jul 2004 23:06:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: ext3: bump mount count on journal replay
Message-ID: <20040716210649.GA15428@elf.ucw.cz>
References: <20040714131525.GA1369@elf.ucw.cz> <20040714200554.GR23346@schnapps.adilger.int> <20040714203258.GC25802@elf.ucw.cz> <20040716204135.GG6770@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040716204135.GG6770@schnapps.adilger.int>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > AFAICS, this just means that if you have an ext3 filesystem
> > > (i.e. has_journal) that you will fsck 5x as often, not so great.  You
> > > should instead check for INCOMPAT_RECOVER instead of HAS_JOURNAL.
> > 
> > Oops, you are right. Updated patch is attached.
> 
> No patch was attached.

Sorry, here it is:

--- clean/fs/ext3/super.c	2004-06-22 12:36:30.000000000 +0200
+++ linux/fs/ext3/super.c	2004-07-14 22:32:20.000000000 +0200
@@ -919,7 +919,7 @@
 }
 
 static int ext3_setup_super(struct super_block *sb, struct ext3_super_block *es,
-			    int read_only)
+			    int read_only, int mount_cost)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	int res = 0;
@@ -960,7 +960,7 @@
 	if (!(__s16) le16_to_cpu(es->s_max_mnt_count))
 		es->s_max_mnt_count =
 			(__s16) cpu_to_le16(EXT3_DFL_MAX_MNT_COUNT);
-	es->s_mnt_count=cpu_to_le16(le16_to_cpu(es->s_mnt_count) + 1);
+	es->s_mnt_count=cpu_to_le16(le16_to_cpu(es->s_mnt_count) + mount_cost);
 	es->s_mtime = cpu_to_le32(get_seconds());
 	ext3_update_dynamic_rev(sb);
 	EXT3_SET_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_RECOVER);
@@ -1214,7 +1214,7 @@
 	int hblock;
 	int db_count;
 	int i;
-	int needs_recovery;
+	int needs_recovery, mount_cost = 1;
 
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -1478,6 +1478,8 @@
 	needs_recovery = (es->s_last_orphan != 0 ||
 			  EXT3_HAS_INCOMPAT_FEATURE(sb,
 				    EXT3_FEATURE_INCOMPAT_RECOVER));
+	if (needs_recovery)
+		    mount_cost = 5;
 
 	/*
 	 * The first inode we look at is the journal inode.  Don't try
@@ -1485,8 +1487,8 @@
 	 */
 	if (!test_opt(sb, NOLOAD) &&
 	    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL)) {
-		if (ext3_load_journal(sb, es))
-			goto failed_mount2;
+		    if (ext3_load_journal(sb, es))
+			    goto failed_mount2;
 	} else if (journal_inum) {
 		if (ext3_create_journal(sb, es, journal_inum))
 			goto failed_mount2;
@@ -1543,7 +1545,7 @@
 		goto failed_mount3;
 	}
 
-	ext3_setup_super (sb, es, sb->s_flags & MS_RDONLY);
+	ext3_setup_super (sb, es, sb->s_flags & MS_RDONLY, mount_cost);
 	/*
 	 * akpm: core read_super() calls in here with the superblock locked.
 	 * That deadlocks, because orphan cleanup needs to lock the superblock
@@ -2069,7 +2071,7 @@
 			 */
 			ext3_clear_journal_err(sb, es);
 			sbi->s_mount_state = le16_to_cpu(es->s_state);
-			if (!ext3_setup_super (sb, es, 0))
+			if (!ext3_setup_super (sb, es, 0, 1))
 				sb->s_flags &= ~MS_RDONLY;
 		}
 	}


> > > Instead, you could change this to only increment the mount count after
> > > a clean unmount 20% of the time (randomly).  Since most people bitch
> > > about the full fsck anyways this is probably the better choice than
> > > increasing the frequency of checks and forcing the users to change the
> > > check interval to get the old behaviour.
> > 
> > Nice hack.... would that be acceptable?
> 
> It's OK by me.  I don't think you'll get complaints from users if it is
> checked less often (there is still the time-based check).

Hmmm... I guess that using get_random_bytes is pretty easy. Completely
untested diff (have to sleep now):

--- clean/fs/ext3/super.c	2004-06-22 12:36:30.000000000 +0200
+++ linux/fs/ext3/super.c	2004-07-16 23:05:30.000000000 +0200
@@ -919,7 +919,7 @@
 }
 
 static int ext3_setup_super(struct super_block *sb, struct ext3_super_block *es,
-			    int read_only)
+			    int read_only, int mount_cost)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	int res = 0;
@@ -960,7 +960,7 @@
 	if (!(__s16) le16_to_cpu(es->s_max_mnt_count))
 		es->s_max_mnt_count =
 			(__s16) cpu_to_le16(EXT3_DFL_MAX_MNT_COUNT);
-	es->s_mnt_count=cpu_to_le16(le16_to_cpu(es->s_mnt_count) + 1);
+	es->s_mnt_count=cpu_to_le16(le16_to_cpu(es->s_mnt_count) + mount_cost);
 	es->s_mtime = cpu_to_le32(get_seconds());
 	ext3_update_dynamic_rev(sb);
 	EXT3_SET_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_RECOVER);
@@ -1214,7 +1214,11 @@
 	int hblock;
 	int db_count;
 	int i;
-	int needs_recovery;
+	int needs_recovery, mount_cost;
+	unsigned char random;
+
+	get_random_bytes(&random, 1);
+	mount_cost = (random < 60);
 
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -1478,6 +1482,8 @@
 	needs_recovery = (es->s_last_orphan != 0 ||
 			  EXT3_HAS_INCOMPAT_FEATURE(sb,
 				    EXT3_FEATURE_INCOMPAT_RECOVER));
+	if (needs_recovery)
+		    mount_cost = 1;
 
 	/*
 	 * The first inode we look at is the journal inode.  Don't try
@@ -1485,8 +1491,8 @@
 	 */
 	if (!test_opt(sb, NOLOAD) &&
 	    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL)) {
-		if (ext3_load_journal(sb, es))
-			goto failed_mount2;
+		    if (ext3_load_journal(sb, es))
+			    goto failed_mount2;
 	} else if (journal_inum) {
 		if (ext3_create_journal(sb, es, journal_inum))
 			goto failed_mount2;
@@ -1543,7 +1549,7 @@
 		goto failed_mount3;
 	}
 
-	ext3_setup_super (sb, es, sb->s_flags & MS_RDONLY);
+	ext3_setup_super (sb, es, sb->s_flags & MS_RDONLY, mount_cost);
 	/*
 	 * akpm: core read_super() calls in here with the superblock locked.
 	 * That deadlocks, because orphan cleanup needs to lock the superblock
@@ -2069,7 +2075,7 @@
 			 */
 			ext3_clear_journal_err(sb, es);
 			sbi->s_mount_state = le16_to_cpu(es->s_state);
-			if (!ext3_setup_super (sb, es, 0))
+			if (!ext3_setup_super (sb, es, 0, 1))
 				sb->s_flags &= ~MS_RDONLY;
 		}
 	}

								Pavel



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
