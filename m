Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935966AbWK1RmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935966AbWK1RmY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 12:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935976AbWK1RmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 12:42:24 -0500
Received: from excu-mxob-2.symantec.com ([198.6.49.23]:3748 "EHLO
	excu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S935966AbWK1RmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 12:42:22 -0500
X-AuditID: c6063117-a2490bb000005266-a4-456c74fd8003 
Date: Tue, 28 Nov 2006 17:42:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Mingming Cao <cmm@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: [PATCH 4/6] ext2 balloc: fix off-by-one against grp_goal
In-Reply-To: <Pine.LNX.4.64.0611281659190.29701@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0611281741490.29701@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org>  <20061114184919.GA16020@skynet.ie>
  <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com> 
 <20061114113120.d4c22b02.akpm@osdl.org>  <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
  <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com> 
 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com> 
 <20061115232228.afaf42f2.akpm@osdl.org>  <1163666960.4310.40.camel@localhost.localdomain>
  <20061116011351.1401a00f.akpm@osdl.org>  <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
  <20061116132724.1882b122.akpm@osdl.org>  <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
  <1164073652.20900.34.camel@dyn9047017103.beaverton.ibm.com> 
 <Pine.LNX.4.64.0611210508270.22957@blonde.wat.veritas.com>
 <1164156193.3804.48.camel@dyn9047017103.beaverton.ibm.com>
 <Pine.LNX.4.64.0611281659190.29701@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Nov 2006 17:42:21.0050 (UTC) FILETIME=[8E44DDA0:01C71314]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grp_goal 0 is a genuine goal (unlike -1),
so ext2_try_to_allocate_with_rsv should treat it as such.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/ext2/balloc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 2.6.19-rc6-mm2/fs/ext2/balloc.c	2006-11-24 08:18:02.000000000 +0000
+++ linux/fs/ext2/balloc.c	2006-11-27 19:28:41.000000000 +0000
@@ -1053,7 +1053,7 @@ ext2_try_to_allocate_with_rsv(struct sup
 	}
 	/*
 	 * grp_goal is a group relative block number (if there is a goal)
-	 * 0 < grp_goal < EXT2_BLOCKS_PER_GROUP(sb)
+	 * 0 <= grp_goal < EXT2_BLOCKS_PER_GROUP(sb)
 	 * first block is a filesystem wide block number
 	 * first block is the block number of the first block in this group
 	 */
@@ -1089,7 +1089,7 @@ ext2_try_to_allocate_with_rsv(struct sup
 			if (!goal_in_my_reservation(&my_rsv->rsv_window,
 							grp_goal, group, sb))
 				grp_goal = -1;
-		} else if (grp_goal > 0) {
+		} else if (grp_goal >= 0) {
 			int curr = my_rsv->rsv_end -
 					(grp_goal + group_first_block) + 1;
 
