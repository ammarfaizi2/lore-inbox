Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286947AbRL1RnK>; Fri, 28 Dec 2001 12:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286938AbRL1RnC>; Fri, 28 Dec 2001 12:43:02 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:1466 "EHLO gin")
	by vger.kernel.org with ESMTP id <S286945AbRL1Rmu>;
	Fri, 28 Dec 2001 12:42:50 -0500
Date: Fri, 28 Dec 2001 18:42:44 +0100
To: linux-kernel@vger.kernel.org
Cc: reiserfs-dev@namesys.com, torvalds@transmeta.com
Subject: [PATCH] reiserfs oneliner
Message-ID: <20011228174244.GD20899@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes an assignment in super.c in reiserfs that caused deadlock
when mounting my reiser-filesystems.

the original code looks like this:

    size = block_size(s->s_dev);
    sb_set_blocksize(s, size);

    /* read block (64-th 1k block), which can contain reiserfs super block */
    if (read_super_block (s, REISERFS_DISK_OFFSET_IN_BYTES)) {
	// try old format (undistributed bitmap, super block in 8-th 1k block of a device)
	sb_set_blocksize(s, size);
	if (read_super_block (s, REISERFS_OLD_DISK_OFFSET_IN_BYTES)) 
	    goto error;
	else
	    old_format = 1;
    }
    s->s_blocksize = size;

If read_super_block() changes the blocksize in the superblock it shouldn't
be restored again, should it?

With the following patch i can mount my reiserfs:es without deadlock.

--- linux-2.5.2-pre3/fs/reiserfs/super.c	Fri Dec 28 09:03:32 2001
+++ linux-2.5.2-pre3-lvmfix-reiserfix/fs/reiserfs/super.c	Fri Dec 28 18:19:49 2001
@@ -637,7 +637,6 @@
 	else
 	    old_format = 1;
     }
-    s->s_blocksize = size;
 
     s->u.reiserfs_sb.s_mount_state = SB_REISERFS_STATE(s);
     s->u.reiserfs_sb.s_mount_state = REISERFS_VALID_FS ;

