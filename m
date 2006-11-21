Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030618AbWKUBgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030618AbWKUBgL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 20:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030633AbWKUBgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 20:36:10 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:58271 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030618AbWKUBgI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 20:36:08 -0500
Subject: Re: Boot failure with ext2 and initrds
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611202031370.5912@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061114184919.GA16020@skynet.ie>
	 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	 <20061114113120.d4c22b02.akpm@osdl.org>
	 <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
	 <20061115232228.afaf42f2.akpm@osdl.org>
	 <1163666960.4310.40.camel@localhost.localdomain>
	 <20061116011351.1401a00f.akpm@osdl.org>
	 <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
	 <20061116132724.1882b122.akpm@osdl.org>
	 <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611202031370.5912@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 20 Nov 2006 17:36:01 -0800
Message-Id: <1164072961.20900.22.camel@dyn9047017103.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-20 at 20:54 +0000, Hugh Dickins wrote:
> Not found anything relevant, but I keep noticing these lines
> in ext2_try_to_allocate_with_rsv(), ext3 and ext4 similar:
> 
> 		} else if (grp_goal > 0 &&
> 				(my_rsv->rsv_end - grp_goal + 1) < *count)
> 			try_to_extend_reservation(my_rsv, sb,
> 					*count-my_rsv->rsv_end + grp_goal - 1);
> 
> They're wrong, a no-op in most groups, aren't they?  rsv_end is an
> absolute block number, whereas grp_goal is group-relative, so the
> calculation ought to bring in group_first_block?  Or I'm confused.
> 

You are right, thanks. Here are two patches, to fix this bug in ext3/4
and ext2 correspondingly.


Signed-Off-By: Mingming Cao <cmm@us.ibm.com>

---

 linux-2.6.19-rc5-cmm/fs/ext3/balloc.c |   12 ++++++++----
 linux-2.6.19-rc5-cmm/fs/ext4/balloc.c |   12 ++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff -puN fs/ext3/balloc.c~ext34_extend_reservation_window_fix fs/ext3/balloc.c
--- linux-2.6.19-rc5/fs/ext3/balloc.c~ext34_extend_reservation_window_fix	2006-11-20 15:58:11.000000000 -0800
+++ linux-2.6.19-rc5-cmm/fs/ext3/balloc.c	2006-11-20 15:58:11.000000000 -0800
@@ -1307,10 +1307,14 @@ ext3_try_to_allocate_with_rsv(struct sup
 			if (!goal_in_my_reservation(&my_rsv->rsv_window,
 							grp_goal, group, sb))
 				grp_goal = -1;
-		} else if (grp_goal > 0 &&
-			  (my_rsv->rsv_end-grp_goal+1) < *count)
-			try_to_extend_reservation(my_rsv, sb,
-					*count-my_rsv->rsv_end + grp_goal - 1);
+		} else if (grp_goal > 0) {
+			int curr = my_rsv->rsv_end -
+					(grp_goal + group_first_block) + 1;
+
+			if (curr < *count)
+				try_to_extend_reservation(my_rsv, sb,
+							*count - curr);
+			}
 
 		if ((my_rsv->rsv_start > group_last_block) ||
 				(my_rsv->rsv_end < group_first_block)) {
diff -puN fs/ext4/balloc.c~ext34_extend_reservation_window_fix fs/ext4/balloc.c
--- linux-2.6.19-rc5/fs/ext4/balloc.c~ext34_extend_reservation_window_fix	2006-11-20 15:58:11.000000000 -0800
+++ linux-2.6.19-rc5-cmm/fs/ext4/balloc.c	2006-11-20 15:58:11.000000000 -0800
@@ -1324,10 +1324,14 @@ ext4_try_to_allocate_with_rsv(struct sup
 			if (!goal_in_my_reservation(&my_rsv->rsv_window,
 							grp_goal, group, sb))
 				grp_goal = -1;
-		} else if (grp_goal > 0 &&
-			  (my_rsv->rsv_end-grp_goal+1) < *count)
-			try_to_extend_reservation(my_rsv, sb,
-					*count-my_rsv->rsv_end + grp_goal - 1);
+		} else if (grp_goal > 0) {
+			int curr = my_rsv->rsv_end -
+					(grp_goal + group_first_block) + 1;
+
+			if (curr < *count)
+				try_to_extend_reservation(my_rsv, sb,
+							*count - curr);
+			}
 
 		if ((my_rsv->rsv_start > group_last_block) ||
 				(my_rsv->rsv_end < group_first_block)) {


Sync up ext2 with ext3/4 for the extend reservation window bug.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>



---

 linux-2.6.19-rc5-cmm/fs/ext2/balloc.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff -puN fs/ext2/balloc.c~ext2_reservation_extend_window_fix fs/ext2/balloc.c
--- linux-2.6.19-rc5/fs/ext2/balloc.c~ext2_reservation_extend_window_fix	2006-11-20 16:05:36.000000000 -0800
+++ linux-2.6.19-rc5-cmm/fs/ext2/balloc.c	2006-11-20 16:05:36.000000000 -0800
@@ -1091,10 +1091,14 @@ ext2_try_to_allocate_with_rsv(struct sup
 			if (!goal_in_my_reservation(&my_rsv->rsv_window,
 							grp_goal, group, sb))
 				grp_goal = -1;
-		} else if (grp_goal > 0 &&
-				(my_rsv->rsv_end - grp_goal + 1) < *count)
-			try_to_extend_reservation(my_rsv, sb,
-					*count-my_rsv->rsv_end + grp_goal - 1);
+		} else if (grp_goal > 0) {
+			int curr = my_rsv->rsv_end -
+					(grp_goal + group_first_block) + 1;
+
+			if (curr < *count)
+				try_to_extend_reservation(my_rsv, sb,
+							*count - curr);
+			}
 
 		if ((my_rsv->rsv_start >=
 			group_first_block + EXT2_BLOCKS_PER_GROUP(sb))

_


