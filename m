Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWHRRj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWHRRj6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWHRRj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:39:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27061 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751434AbWHRRj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:39:57 -0400
Message-ID: <44E5FB5D.60403@redhat.com>
Date: Fri, 18 Aug 2006 12:39:41 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Mingming Cao <cmm@us.ibm.com>
CC: sho@tnes.nec.co.jp, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH] fix ext3 mounts at 16T
References: <20060818181516sho@rifu.tnes.nec.co.jp> <44E5F9F0.6030805@us.ibm.com>
In-Reply-To: <44E5F9F0.6030805@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao wrote:

> Yes, this isn't being addressed in the current 2.6.18-rc4 kernel. I 
> think this is better than casting to unsigned long long:
> 
> -     if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
> +     if ((my_rsv->rsv_start > group_first_block - 1 + EXT3_BLOCKS_PER_GROUP(sb))

And there are a few more of these.  The patch I currently have in my stack follows.
(personally I think
	last = first + (count - 1)
is clearer than
	last = first - 1 + count
but that's just my opinion...)

Thanks,

-Eric

Signed-off-by: Eric Sandeen <esandeen@redhat.com>

Index: linux-2.6.17/fs/ext3/balloc.c
===================================================================
--- linux-2.6.17.orig/fs/ext3/balloc.c
+++ linux-2.6.17/fs/ext3/balloc.c
@@ -168,7 +168,7 @@ goal_in_my_reservation(struct ext3_reser
 	ext3_fsblk_t group_first_block, group_last_block;
 
 	group_first_block = ext3_group_first_block_no(sb, group);
-	group_last_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
+	group_last_block = group_first_block + (EXT3_BLOCKS_PER_GROUP(sb) - 1);
 
 	if ((rsv->_rsv_start > group_last_block) ||
 	    (rsv->_rsv_end < group_first_block))
@@ -897,7 +897,7 @@ static int alloc_new_reservation(struct 
 	spinlock_t *rsv_lock = &EXT3_SB(sb)->s_rsv_window_lock;
 
 	group_first_block = ext3_group_first_block_no(sb, group);
-	group_end_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
+	group_end_block = group_first_block + (EXT3_BLOCKS_PER_GROUP(sb) - 1);
 
 	if (grp_goal < 0)
 		start_block = group_first_block;
@@ -1132,7 +1132,7 @@ ext3_try_to_allocate_with_rsv(struct sup
 			try_to_extend_reservation(my_rsv, sb,
 					*count-my_rsv->rsv_end + grp_goal - 1);
 
-		if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
+		if ((my_rsv->rsv_start > group_first_block + (EXT3_BLOCKS_PER_GROUP(sb) - 1))
 		    || (my_rsv->rsv_end < group_first_block))
 			BUG();
 		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, grp_goal,


