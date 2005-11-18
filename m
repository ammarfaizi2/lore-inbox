Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVKROwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVKROwO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 09:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVKROwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 09:52:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34708 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750746AbVKROwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 09:52:13 -0500
Date: Fri, 18 Nov 2005 14:52:03 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>
Subject: [PATCH] device-mapper: mirror log bitset fix
Message-ID: <20051118145203.GI11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Neil Brown <neilb@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linux bitset operators (test_bit, set_bit etc) work on arrays of 
"unsigned long".  dm-log uses such bitsets but treats them as 
arrays of uint32_t, only allocating and zeroing a multiple of 4 bytes 
(as 'clean_bits' is a uint32_t).

The patch below fixes this problem.  

The problem is specific to 64-bit big endian machines such as s390x or
ppc-64 and can prevent pvmove terminating.


In the simplest case, if "region_count" were (say) 30, then
bitset_size (below) would be 4 and bitset_uint32_count would be 1.
Thus the memory for this butset, after allocation and zeroing would
be
   0 0 0 0 X X X X 
On a bigendian 64bit machine, bit 0 for this bitset is in the 8th
byte! (and every bit that dm-log would use would be in the X area).

   0 0 0 0 X X X X 
                 ^
                 here

which hasn't been cleared properly.

As the dm-raid1 code only syncs and counts regions which have a 0 in
the 'sync_bits' bitset, and only finishes when it has counted high
enough, a large number of 1's among those 'X's will cause the sync to
not complete.

It is worth noting that the code uses the same bitsets for in-memory
and on-disk logs.  As these bitsets are host-endian and host-sized,
this means that they cannot safely be moved between computers with
different architectures.  


Signed-off-by: Neil Brown <neilb@suse.de>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14-rc2/drivers/md/dm-log.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/md/dm-log.c	2005-09-28 18:31:54.000000000 +0100
+++ linux-2.6.14-rc2/drivers/md/dm-log.c	2005-09-28 18:32:53.000000000 +0100
@@ -333,10 +333,10 @@
 	lc->sync = sync;
 
 	/*
-	 * Work out how many words we need to hold the bitset.
+	 * Work out how many "unsigned long"s we need to hold the bitset.
 	 */
 	bitset_size = dm_round_up(region_count,
-				  sizeof(*lc->clean_bits) << BYTE_SHIFT);
+				  sizeof(unsigned long) << BYTE_SHIFT);
 	bitset_size >>= BYTE_SHIFT;
 
 	lc->bitset_uint32_count = bitset_size / 4;
