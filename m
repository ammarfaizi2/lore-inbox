Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266236AbSKGAS1>; Wed, 6 Nov 2002 19:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266237AbSKGAS1>; Wed, 6 Nov 2002 19:18:27 -0500
Received: from packet.digeo.com ([12.110.80.53]:56530 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266236AbSKGAS0>;
	Wed, 6 Nov 2002 19:18:26 -0500
Message-ID: <3DC9B2D9.1081249C@digeo.com>
Date: Wed, 06 Nov 2002 16:24:57 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Maciej Babinski <maciej@imsa.edu>, Jens Axboe <axboe@suse.de>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46 ext3 errors
References: <20021106075406.GC1137@suse.de> <20021106175542.A8364@imsa.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2002 00:24:58.0206 (UTC) FILETIME=[1A7317E0:01C285F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Babinski wrote:
> 
> I got this same error while running "seq 1000000|xargs touch"
> in an otherwise empty directory. It got as far as about 20,000
> files before the filesystem was remounted ro.
> 

Looks like we had some overeager cut-n-paste in the Orlov
conversion.

The per-blockgroup inode and directory accounting is being
double-accounted for, and we're not journalling the updates...

This should fix it up, but it is untested.


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
