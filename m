Return-Path: <linux-kernel-owner+w=401wt.eu-S1423061AbWLUTpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423061AbWLUTpu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423062AbWLUTpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:45:50 -0500
Received: from brick.kernel.dk ([62.242.22.158]:21471 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423061AbWLUTpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:45:49 -0500
Date: Thu, 21 Dec 2006 20:47:41 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: performance regression from block merge
Message-ID: <20061221194741.GH17199@kernel.dk>
References: <20061221112540.e4ba58bc.akpm@osdl.org> <20061221193549.GF17199@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221193549.GF17199@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21 2006, Jens Axboe wrote:
> On Thu, Dec 21 2006, Andrew Morton wrote:
> > 
> > Jens, elapsed time for `mke2fs /dev/hdc5' with the anticipatory scheduler
> > (at least) has gone from nine seconds to sixty as a result of the recent
> > block merge.
> 
> About when? I'll double check and test here, I'm assuming you mean since
> 2.6.19?

Auch, brown paper bag time, I spotted an obvious typo in the recent
merge. Does this fix it? It should be safe to kill the ->special check,
but lets leave that for another time.

diff --git a/block/elevator.c b/block/elevator.c
index 62c7a30..536be74 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -82,7 +82,7 @@ inline int elv_rq_merge_ok(struct reques
 	/*
 	 * must be same device and not a special request
 	 */
-	if (rq->rq_disk != bio->bi_bdev->bd_disk || !rq->special)
+	if (rq->rq_disk != bio->bi_bdev->bd_disk || rq->special)
 		return 0;
 
 	if (!elv_iosched_allow_merge(rq, bio))

-- 
Jens Axboe

