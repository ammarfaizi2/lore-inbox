Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262262AbREXU2U>; Thu, 24 May 2001 16:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262263AbREXU2K>; Thu, 24 May 2001 16:28:10 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:40694 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262262AbREXU16>; Thu, 24 May 2001 16:27:58 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105242026.f4OKQkiP015006@webber.adilger.int>
Subject: Re: O_TRUNC problem on a full filesystem
In-Reply-To: <20010524191518.A7952@redhat.com> "from Stephen C. Tweedie at May
 24, 2001 07:15:18 pm"
To: "Stephen C. Tweedie" <sct@redhat.com>
Date: Thu, 24 May 2001 14:26:46 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Andrew Morton <andrewm@uow.edu.au>, Manas Garg <mls@chakpak.net>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen writes:
> On Thu, May 24, 2001 at 11:24:10AM -0600, Andreas Dilger wrote:
> > How have you done the ext3 preallocation code? 
> 
> Preallocation is currently disabled in ext3.  Eventually I'll probably
> get it going by adding a journal prepare-commit callback to allow the
> filesystem to flush preallocation before committing.

Yes, it is disabled in 2.2 ext3, but if Andrew is complaining about the
blocks not being freed in 2.4 ext3, I assume he re-enabled it somehow...

> > One way to do it would be
> > to only mark the blocks as used in the in-memory copy of the block bitmap
> > and not write that to disk (we keep 2 copies of the block bitmap, IIRC).
> 
> Indeed; I'd need to keep 3 copies to make that work.  The state
> machine just gets even uglier.  :-)  I thought about it and I might
> still end up going that route.
> 
> > Did you ever benchmark ext2 with and without preallocation to see if it
> > made any difference?  No point in doing extra work if there is no benefit.
> 
> The point is not just performance, but also cpu cost (which
> preallocation definitely wins on)

Yes, currently this is one thing that ext2/ext3 still have over XFS and
reiserfs - lower CPU usage.  If you ever see benchmarks on slower CPU
systems, ext2 does very well, and XFS does quite poorly.  The only bad
spot is the large directory handling, and I think Daniel's indexed dir
code handles that very well, because it doesn't need continual balancing
and re-packing of the directory entries.

I even realized that if you have a (formerly) huge directory, with lots
of empty blocks this even speeds up searches for non-existent entries,
sort of like a negative dentry.

> and on fragmentation if you have multiple writers in the same directory.

Yes, of course this is also hard to notice in benchmarks, but a good
feature in real life to keep file reads more within device read-ahead.

When I was thinking about the current preallocation code in conjunction
with the block goal searching code, I realized that we are normally
looking through the bitmap for at least 8 contiguous blocks, and then
back-searching for up to 7 additional contiguous blocks.  We _should_ do
block preallocation immediately at this point for up to 14 more blocks,
because we already know they are contiguous.  Something like the following
(untested) patch:

Cheers, Andreas
=========================================================================
diff -u -u -r1.4 balloc.c
--- fs/ext3/balloc.c	2001/05/21 17:00:17	1.4
+++ fs/ext3/balloc.c	2001/05/24 20:17:02
@@ -509,7 +509,11 @@
 	int bitmap_nr;
 	struct super_block * sb;
 	struct ext3_group_desc * gdp;
-	struct ext3_super_block * es;
+	struct ext3_super_block *es = EXT3_SB(sb)->s_es;
+#ifdef EXT3_PREALLOCATE
+	int prealloc_goal = es->s_prealloc_blocks ?
+		es->s_prealloc_blocks : EXT2_DEFAULT_PREALLOC_BLOCKS;
+#endif
 #ifdef EXT3FS_DEBUG
 	static int goal_hits = 0, goal_attempts = 0;
 #endif
@@ -521,7 +526,6 @@
 	}
 
 	lock_super (sb);
-	es = sb->u.ext3_sb.s_es;
 	if (le32_to_cpu(es->s_free_blocks_count) <=
 			le32_to_cpu(es->s_r_blocks_count) &&
 	    ((sb->u.ext3_sb.s_resuid != current->fsuid) &&
@@ -614,7 +618,9 @@
 		k < 7 && j > 0 && ext3_test_allocatable(j - 1, bh);
 		k++, j--)
 		;
-	
+#ifdef EXT3_PREALLOCATE
+	prealloc_goal += k;
+#endif
 got_block:
 
 	ext3_debug ("using block group %d(%d)\n", i, gdp->bg_free_blocks_count);
@@ -673,11 +679,7 @@
 	 */
 	/* Writer: ->i_prealloc* */
 	if (prealloc_count && !*prealloc_count) {
-		int	prealloc_goal;
 		unsigned long next_block = tmp + 1;
-
-		prealloc_goal = es->s_prealloc_blocks ?
-			es->s_prealloc_blocks : EXT3_DEFAULT_PREALLOC_BLOCKS;
 
 		*prealloc_block = next_block;
 		/* Writer: end */
 
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
