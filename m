Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWHIQoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWHIQoZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWHIQoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:44:25 -0400
Received: from antares.tat.physik.uni-tuebingen.de ([134.2.170.62]:12240 "EHLO
	antares.tat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S1751017AbWHIQoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:44:24 -0400
Date: Wed, 9 Aug 2006 18:44:21 +0200
From: Daniel Kobras <kobras@linux.de>
To: dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dm: Fix deadlock under high i/o load in raid1 setup.
Message-ID: <20060809164421.GC9984@antares.tat.physik.uni-tuebingen.de>
Mail-Followup-To: Daniel Kobras <kobras@linux.de>, dm-devel@redhat.com,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement private fallback if immediate allocation from mempool fails.
Standard mempool_alloc() fallback can yield a deadlock when only the
calling process is able to refill the pool. In out-of-memory situations,
instead of waiting for itself, kmirrord now waits for someone else to
free some space, using a standard blocking allocation.

Signed-off-by: Daniel Kobras <kobras@linux.de>
---
[Resending with Cc to l-k. First attempt apparently hasn't made it through to 
dm-devel.]

Hi!

On an nForce4-equipped machine with two SATA disk in raid1 setup using
dmraid, we experienced frequent deadlock of the system under high i/o
load. 'cat /dev/zero > ~/zero' was the most reliable way to reproduce
them: Randomly after a few GB, 'cp' would be left in 'D' state along
with kjournald and kmirrord. The functions cp and kjournald were blocked
in did vary, but kmirrord's wchan always pointed to 'mempool_alloc()'.
We've seen this pattern on 2.6.15 and 2.6.17 kernels.
http://lkml.org/lkml/2005/4/20/142 indicates that this problem has been
around even before.

So much for the facts, here's my interpretation: mempool_alloc() first
tries to atomically allocate the requested memory, or falls back to hand
out preallocated chunks from the mempool. If both fail, it puts the
calling process (kmirrord in this case) on a private waitqueue until
somebody refills the pool. Where the only 'somebody' is kmirrord itself,
so we have a deadlock.

I worked around this problem by falling back to a (blocking) kmalloc
when before kmirrord would have ended up on the waitqueue. This defeats
part of the benefits of using the mempool, but at least keeps the system
running. And it could be done with a two-line change. Note that
mempool_alloc() clears the GFP_NOIO flag internally, and only uses it to
decide whether to wait or return an error if immediate allocation fails,
so the attached patch doesn't change behaviour in the non-deadlocking case.
Path is against current git (2.6.18-rc4), but should apply to earlier
versions as well. I've tested on 2.6.15, where this patch makes the
difference between random lockup and a stable system.

Regards,

Daniel.

diff -r dcc321d1340a -r d52bb3a14d60 drivers/md/dm-raid1.c
--- a/drivers/md/dm-raid1.c	Sun Aug 06 19:00:05 2006 +0000
+++ b/drivers/md/dm-raid1.c	Mon Aug 07 23:16:44 2006 +0200
@@ -255,7 +255,9 @@ static struct region *__rh_alloc(struct 
 	struct region *reg, *nreg;
 
 	read_unlock(&rh->hash_lock);
-	nreg = mempool_alloc(rh->region_pool, GFP_NOIO);
+	nreg = mempool_alloc(rh->region_pool, GFP_ATOMIC);
+	if (unlikely(!nreg))
+		nreg = kmalloc(sizeof(struct region), GFP_NOIO);
 	nreg->state = rh->log->type->in_sync(rh->log, region, 1) ?
 		RH_CLEAN : RH_NOSYNC;
 	nreg->rh = rh;

