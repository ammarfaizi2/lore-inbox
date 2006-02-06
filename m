Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWBFDE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWBFDE3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 22:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWBFDE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 22:04:29 -0500
Received: from hera.kernel.org ([140.211.167.34]:1485 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750898AbWBFDE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 22:04:28 -0500
Date: Sun, 5 Feb 2006 19:05:07 -0600
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [VM PATCH] rotate_reclaimable_page fails frequently
Message-ID: <20060206010506.GA30318@dmt.cnet>
References: <20060205150259.1549.qmail@web33007.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205150259.1549.qmail@web33007.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shantanu,

On Sun, Feb 05, 2006 at 07:02:59AM -0800, Shantanu Goel wrote:
> Hi,
> 
> It seems rotate_reclaimable_page fails most of the
> time due the page not being on the LRU when kswapd
> calls writepage().  The filesystem in my tests is
> ext3.  The attached patch against 2.6.16-rc2 moves the
> page to the LRU before calling writepage().  Below are
> results for a write test with:
> 
> dd if=/dev/zero of=test bs=1024k count=1024

I guess that big issue here is that the pgrotate logic is completly
useless for common cases (and no one stepped up to fix it, here's a
chance).

You had to modify the default dirty limits to watch writeout happen via
the VM reclaim path. Usually most writeout happens via pdflush and the
dirty limits at the write() path.

Surely the question you raise about why writeback ends before the
shrinker adds such pages back to LRU is important, but getting pgrotate
to _work at all_ for common scenarios is broader and more crucial.

Marking PG_writeback pages as PG_rotated once they're chosen candidates
for eviction increases the number of rotated pages dramatically, but
that does not necessarily increase performance (I was unable to see any
performance increase under the limited testing I've done, even though
the pgrotated numbers were _way_ higher).

Another issue is that increasing the number of rotated pages increases
lru_lock contention, which might not be an advantage for certain
workloads.

So, any change in this area needs careful study under a varied,
meaningful set of workloads and configurations (which has not been
happening very often).

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5a61080..26319eb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -447,8 +447,14 @@ static int shrink_list(struct list_head 
 		if (page_mapped(page) || PageSwapCache(page))
 			sc->nr_scanned++;
 
-		if (PageWriteback(page))
+		if (PageWriteback(page)) {
+			/* mark writeback, candidate for eviction pages as 
+			 * PG_reclaim to free them immediately once they're 
+			 * laundered.
+			 */
+			SetPageReclaim(page);
 			goto keep_locked;
+		}
 
 		referenced = page_referenced(page, 1);
 		/* In active use or really unfreeable?  Activate it. */

