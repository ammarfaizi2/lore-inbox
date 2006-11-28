Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935967AbWK1Rjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935967AbWK1Rjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 12:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935966AbWK1Rjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 12:39:47 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:57753 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S935965AbWK1Rjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 12:39:45 -0500
X-AuditID: d80ac21c-a0d6fbb00000557e-c1-456c7461a791 
Date: Tue, 28 Nov 2006 17:40:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Mingming Cao <cmm@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: [PATCH 1/6] ext2 balloc: fix _with_rsv freeze
In-Reply-To: <Pine.LNX.4.64.0611281659190.29701@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0611281739140.29701@blonde.wat.veritas.com>
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
X-OriginalArrivalTime: 28 Nov 2006 17:39:44.0936 (UTC) FILETIME=[3137C280:01C71314]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After several days of testing ext2 with reservations, it got caught inside
ext2_try_to_allocate_with_rsv: alloc_new_reservation repeatedly succeeding
on the window [12cff,12d0e], ext2_try_to_allocate repeatedly failing to
find the free block guaranteed to be included (unless there's contention).

Fix the range to find_next_usable_block's memscan: the scan from "here"
(0xcfe) up to (but excluding) "maxblocks" (0xd0e) needs to scan 3 bytes
not 2 (the relevant bytes of bitmap in this case being f7 df ff - none
00, but the premature cutoff implying that the last was found 00).

Is this a problem for mainline ext2?  No, because the "size" in its memscan
is always EXT2_BLOCKS_PER_GROUP(sb), which mkfs.ext2 requires to be a
multiple of 8.  Is this a problem for ext3 or ext4?  No, because they have
an additional extN_test_allocatable test which rescues them from the error.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
But the bigger question is, why does the my_rsv case come here to
find_next_usable_block at all?  Doesn't its 64-bit boundary limit, and its
memscan, blithely ignore what the reservation prepared?  It's messy too,
the complement of the memscan being that "i < 7" loop over in
ext2_try_to_allocate.  I think this ought to be cleaned up,
in ext2+reservations and ext3 and ext4.

 fs/ext2/balloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 2.6.19-rc6-mm2/fs/ext2/balloc.c	2006-11-24 08:18:02.000000000 +0000
+++ linux/fs/ext2/balloc.c	2006-11-27 19:28:41.000000000 +0000
@@ -570,7 +570,7 @@ find_next_usable_block(int start, struct
 		here = 0;
 
 	p = ((char *)bh->b_data) + (here >> 3);
-	r = memscan(p, 0, (maxblocks - here + 7) >> 3);
+	r = memscan(p, 0, ((maxblocks + 7) >> 3) - (here >> 3));
 	next = (r - ((char *)bh->b_data)) << 3;
 
 	if (next < maxblocks && next >= here)
