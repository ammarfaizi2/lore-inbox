Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264466AbTCXWfr>; Mon, 24 Mar 2003 17:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264471AbTCXWfr>; Mon, 24 Mar 2003 17:35:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:57504 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264466AbTCXWfp>;
	Mon, 24 Mar 2003 17:35:45 -0500
Date: Mon, 24 Mar 2003 16:51:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block/inode allocation for EXT3
Message-Id: <20030324165117.74608c18.akpm@digeo.com>
In-Reply-To: <m3llz490ii.fsf@lexa.home.net>
References: <20030323040439.7a432edb.akpm@digeo.com>
	<m3llz490ii.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2003 22:46:33.0640 (UTC) FILETIME=[380F5280:01C2F257]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> 
> hi!
> 
> this time, concurrent block/inode allocation for EXT3 against 2.5.65.

the balloc.c part looks OK.  But we do need to be atomic against
b_committed_data as well.

I'm not sure whether it's legal to mix nonatomic ext2_test_bit() with the
atomic test and set operations.  I'll find that out, but it'll be OK for the
while.

You seem to have lost the b_committed_data assertion.  Was there a reason for
that?


--- 25/fs/ext3/balloc.c~ext3-concurrent-block-allocation-1	Mon Mar 24 16:01:22 2003
+++ 25-akpm/fs/ext3/balloc.c	Mon Mar 24 16:46:45 2003
@@ -232,7 +232,8 @@ do_more:
 		BUFFER_TRACE(bitmap_bh, "clear in b_committed_data");
 		J_ASSERT_BH(bitmap_bh,
 				bh2jh(bitmap_bh)->b_committed_data != NULL);
-		ext3_set_bit(bit + i, bh2jh(bitmap_bh)->b_committed_data);
+		ext3_set_bit_atomic(&EXT3_SB(sb)->s_bgi[group].bg_balloc_lock,
+				bit + i, bh2jh(bitmap_bh)->b_committed_data);
 	}
 
 	spin_lock(&EXT3_SB(sb)->s_bgi[block_group].bg_balloc_lock);
@@ -428,7 +429,7 @@ ext3_new_block(handle_t *handle, struct 
 	struct buffer_head *gdp_bh;		/* bh2 */
 	int group_no;				/* i */
 	int ret_block;				/* j */
-	int bit;				/* k */
+	int bgi;				/* blockgroup iteration index */
 	int target_block;			/* tmp */
 	int fatal = 0, err;
 	int performed_allocation = 0;
@@ -478,8 +479,8 @@ ext3_new_block(handle_t *handle, struct 
 		bitmap_bh = read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
 			goto io_error;	
-		ret_block = ext3_try_to_allocate(sb, handle, group_no, bitmap_bh,
-						ret_block, &fatal);
+		ret_block = ext3_try_to_allocate(sb, handle, group_no,
+					bitmap_bh, ret_block, &fatal);
 		if (fatal)
 			goto out;
 		if (ret_block >= 0)
@@ -491,7 +492,7 @@ ext3_new_block(handle_t *handle, struct 
 	 * i and gdp correctly point to the last group visited.
 	 */
 repeat:
-	for (bit = 0; bit < EXT3_SB(sb)->s_groups_count; bit++) {
+	for (bgi = 0; bgi < EXT3_SB(sb)->s_groups_count; bgi++) {
 		group_no++;
 		if (group_no >= EXT3_SB(sb)->s_groups_count)
 			group_no = 0;
@@ -567,6 +568,10 @@ allocated:
 		}
 	}
 #endif
+	if (buffer_jbd(bitmap_bh) && bh2jh(bitmap_bh)->b_committed_data)
+		J_ASSERT_BH(bitmap_bh,
+			!ext3_test_bit(ret_block,
+					bh2jh(bitmap_bh)->b_committed_data));
 	ext3_debug("found bit %d\n", ret_block);
 
 	/* ret_block was blockgroup-relative.  Now it becomes fs-relative */

_

