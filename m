Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266310AbSKGDQm>; Wed, 6 Nov 2002 22:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266311AbSKGDQm>; Wed, 6 Nov 2002 22:16:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:12247 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266310AbSKGDQk>;
	Wed, 6 Nov 2002 22:16:40 -0500
Message-ID: <3DC9DCA1.F3AFC34A@digeo.com>
Date: Wed, 06 Nov 2002 19:23:13 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [patch] ext3 inode accounting fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2002 03:23:13.0366 (UTC) FILETIME=[0142FF60:01C2860D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ext3 in the 2.5.46 kernel is double-counting inodes in the per-blockgroup
accounting structures.  When a blockgroup fills up this triggers a
consistency check and the filesystem is remounted read-only.

There is no data loss, but all ext3 filesystems which have been mounted
read/write under the 2.5.46 kernel will have incorrect accounting.   They
must be fixed with a fsck.  If this is not done, the filesystem will
be remounted read-only at some time in the future - when a blockgroup
runs out of inodes and the consistency check detects the error.

Step 1: patch the 2.5.46 kernel with the below fix

Step 2: reboot into the new kernel, forcing a fsck against all ext3
        filesystems.

Alternatively, wait for 2.5.47 and then fsck all filesystems.  The problem
only manifests if all of a blockgroup's inodes are consumed, and that is
rare.


--- 25/fs/ext3/ialloc.c~ext3-inodes-count-fix	Wed Nov  6 16:16:55 2002
+++ 25-akpm/fs/ext3/ialloc.c	Wed Nov  6 16:24:20 2002
@@ -227,11 +227,6 @@ static int find_group_dir(struct super_b
 	}
 	if (!best_desc)
 		return -1;
-	best_desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(best_desc->bg_free_inodes_count) - 1);
-	best_desc->bg_used_dirs_count =
-		cpu_to_le16(le16_to_cpu(best_desc->bg_used_dirs_count) + 1);
-	mark_buffer_dirty(best_bh);
 	return best_group;
 }
 
@@ -355,14 +350,7 @@ fallback:
 	}
 
 	return -1;
-
 found:
-	desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
-	desc->bg_used_dirs_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) + 1);
-	sbi->s_dir_count++;
-	mark_buffer_dirty(bh);
 	return group;
 }
 
@@ -410,9 +398,6 @@ static int find_group_other(struct super
 	return -1;
 
 found:
-	desc->bg_free_inodes_count =
-		cpu_to_le16(le16_to_cpu(desc->bg_free_inodes_count) - 1);
-	mark_buffer_dirty(bh);
 	return group;
 }
 
@@ -521,9 +506,11 @@ repeat:
 	if (err) goto fail;
 	gdp->bg_free_inodes_count =
 		cpu_to_le16(le16_to_cpu(gdp->bg_free_inodes_count) - 1);
-	if (S_ISDIR(mode))
+	if (S_ISDIR(mode)) {
 		gdp->bg_used_dirs_count =
 			cpu_to_le16(le16_to_cpu(gdp->bg_used_dirs_count) + 1);
+		EXT3_SB(sb)->s_dir_count++;
+	}
 	BUFFER_TRACE(bh2, "call ext3_journal_dirty_metadata");
 	err = ext3_journal_dirty_metadata(handle, bh2);
 	if (err) goto fail;

_
