Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbWIFXDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWIFXDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbWIFXDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:03:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:34509 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965127AbWIFXDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:03:12 -0400
Date: Wed, 6 Sep 2006 15:57:47 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, kobras@linux.de, agk@redhat.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 31/37] dm: Fix deadlock under high i/o load in raid1 setup.
Message-ID: <20060906225747.GF15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-fix-deadlock-under-high-i-o-load-in-raid1-setup.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Daniel Kobras <kobras@linux.de>

On an nForce4-equipped machine with two SATA disk in raid1 setup using dmraid,
we experienced frequent deadlock of the system under high i/o load.  'cat
/dev/zero > ~/zero' was the most reliable way to reproduce them: Randomly
after a few GB, 'cp' would be left in 'D' state along with kjournald and
kmirrord.  The functions cp and kjournald were blocked in did vary, but
kmirrord's wchan always pointed to 'mempool_alloc()'.  We've seen this pattern
on 2.6.15 and 2.6.17 kernels.  http://lkml.org/lkml/2005/4/20/142 indicates
that this problem has been around even before.

So much for the facts, here's my interpretation: mempool_alloc() first tries
to atomically allocate the requested memory, or falls back to hand out
preallocated chunks from the mempool.  If both fail, it puts the calling
process (kmirrord in this case) on a private waitqueue until somebody refills
the pool.  Where the only 'somebody' is kmirrord itself, so we have a
deadlock.

I worked around this problem by falling back to a (blocking) kmalloc when
before kmirrord would have ended up on the waitqueue.  This defeats part of
the benefits of using the mempool, but at least keeps the system running.  And
it could be done with a two-line change.  Note that mempool_alloc() clears the
GFP_NOIO flag internally, and only uses it to decide whether to wait or return
an error if immediate allocation fails, so the attached patch doesn't change
behaviour in the non-deadlocking case.  Path is against current git
(2.6.18-rc4), but should apply to earlier versions as well.  I've tested on
2.6.15, where this patch makes the difference between random lockup and a
stable system.

Signed-off-by: Daniel Kobras <kobras@linux.de>
Acked-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/md/dm-raid1.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.17.11.orig/drivers/md/dm-raid1.c
+++ linux-2.6.17.11/drivers/md/dm-raid1.c
@@ -253,7 +253,9 @@ static struct region *__rh_alloc(struct 
 	struct region *reg, *nreg;
 
 	read_unlock(&rh->hash_lock);
-	nreg = mempool_alloc(rh->region_pool, GFP_NOIO);
+	nreg = mempool_alloc(rh->region_pool, GFP_ATOMIC);
+	if (unlikely(!nreg))
+		nreg = kmalloc(sizeof(struct region), GFP_NOIO);
 	nreg->state = rh->log->type->in_sync(rh->log, region, 1) ?
 		RH_CLEAN : RH_NOSYNC;
 	nreg->rh = rh;

--
