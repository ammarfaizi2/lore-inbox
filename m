Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758792AbWK2EPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758792AbWK2EPw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 23:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758776AbWK2EPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 23:15:50 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:39647 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1758789AbWK2EPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 23:15:47 -0500
Subject: [PATCH 12/12] ext3 balloc: fix _with_rsv freeze
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>
Cc: Mel Gorman <mel@skynet.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611281739140.29701@blonde.wat.veritas.com>
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
	 <1164073652.20900.34.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611210508270.22957@blonde.wat.veritas.com>
	 <1164156193.3804.48.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611281659190.29701@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611281739140.29701@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 28 Nov 2006 20:15:41 -0800
Message-Id: <1164773741.4341.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


------------------------------------------------------
Subject: ext2 balloc: fix _with_rsv freeze
From: Hugh Dickins <hugh@veritas.com>

After several days of testing ext2 with reservations, it got caught inside
ext2_try_to_allocate_with_rsv: alloc_new_reservation repeatedly succeeding on
the window [12cff,12d0e], ext2_try_to_allocate repeatedly failing to find the
free block guaranteed to be included (unless there's contention).

Fix the range to find_next_usable_block's memscan: the scan from "here"
(0xcfe) up to (but excluding) "maxblocks" (0xd0e) needs to scan 3 bytes not 2
(the relevant bytes of bitmap in this case being f7 df ff - none 00, but the
premature cutoff implying that the last was found 00).

Is this a problem for mainline ext2?  No, because the "size" in its memscan is
always EXT2_BLOCKS_PER_GROUP(sb), which mkfs.ext2 requires to be a multiple of
8.  Is this a problem for ext3 or ext4?  No, because they have an additional
extN_test_allocatable test which rescues them from the error.

--------------------------------------------------

Sync up a reservation fix from ext2 in ext4
Signed-off-by: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.19-rc5-cmm/fs/ext4/balloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/ext4/balloc.c~ext4-balloc-fix-_with_rsv-freeze fs/ext4/balloc.c
--- linux-2.6.19-rc5/fs/ext4/balloc.c~ext4-balloc-fix-_with_rsv-freeze	2006-11-28 19:37:12.000000000 -0800
+++ linux-2.6.19-rc5-cmm/fs/ext4/balloc.c	2006-11-28 19:37:12.000000000 -0800
@@ -747,7 +747,7 @@ find_next_usable_block(ext4_grpblk_t sta
 		here = 0;
 
 	p = ((char *)bh->b_data) + (here >> 3);
-	r = memscan(p, 0, (maxblocks - here + 7) >> 3);
+	r = memscan(p, 0, ((maxblocks + 7) >> 3 - (here >> 3));
 	next = (r - ((char *)bh->b_data)) << 3;
 
 	if (next < maxblocks && next >= start && ext4_test_allocatable(next, bh))

_


