Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWIDMbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWIDMbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWIDMbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:31:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19158 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964851AbWIDMba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:31:30 -0400
Message-ID: <44FC1C90.200@redhat.com>
Date: Mon, 04 Sep 2006 14:31:12 +0200
From: Milan Broz <mbroz@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: [PATCH] fix creating zero sized bio mempools in low memory system
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the very low memory systems is in the init_bio call
scale parameter set to zero and it leads to creating
zero sized mempool.

This patch prevents pool_entries parameter become zero,
so the created pool have at least 1 entry.

Mempool with 0 entries lead to incorrect behaviour 
of mempool_free. (Alloc requests are not waken up
and system stalls in mempool_alloc->ioschedule). 


Signed-off-by: Milan Broz <mbroz@redhat.com>

Index: linux-2.6.18-rc6/fs/bio.c
===================================================================
--- linux-2.6.18-rc6.orig/fs/bio.c
+++ linux-2.6.18-rc6/fs/bio.c
@@ -1142,7 +1142,7 @@ static int biovec_create_pools(struct bi
 		struct biovec_slab *bp = bvec_slabs + i;
 		mempool_t **bvp = bs->bvec_pools + i;
 
-		if (i >= scale)
+		if (pool_entries > 1 && i >= scale)
 			pool_entries >>= 1;
 
 		*bvp = mempool_create_slab_pool(pool_entries, bp->slab);



-- 
VGER BF report: U 0.493705
