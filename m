Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUFWW0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUFWW0p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUFWWXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:23:19 -0400
Received: from holomorphy.com ([207.189.100.168]:46213 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263204AbUFWWWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:22:24 -0400
Date: Wed, 23 Jun 2004 15:22:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oom]: [1/4] add __GFP_WIRED to pinned allocations
Message-ID: <20040623222221.GE1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com> <0406231407.ZaHbZa1aIbIbKbZa3aHbLb3aYa2a3a5aWaIbWaKb2aYaKb4a4aHbIb3aLb5aHb2a342@holomorphy.com> <20040623150546.4f66f941.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623150546.4f66f941.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> +#define __GFP_WIRED	0x8000	/* pinned */

On Wed, Jun 23, 2004 at 03:05:46PM -0700, Andrew Morton wrote:
> This would be a nice thing to keep track of.
> Isn't it the case that reclaimable slab pages (dentry, inode, mbcache,
> dquot) should not be accounted as wired memory?  Could perhaps use
> SLAB_RECLAIM_ACCOUNT for that.
> It would need to be overridden for, say, sysfs inodes and dentries, but
> they're about to become reclaimable anyway so no prob.
> It would need to be overridden for, say, ramfs dentries and inodes though.
> rd.c's blockdev pagecache pages are wired.

It's difficult to come up with comprehensible semantic refinements.
The trick with slab is whole slabs are frequently pinned by active
references, so there's quite a bit of squishiness there even after
SLAB_RECLAIM_ACCOUNT is figured out. A counter in the slab header for
references is plausibly precise, but appears to too invasive to ever
put into place. A less invasive refinement may be to clear_page_wired()
for empty slab pages.

Thanks for spotting rd.c's blkdev pagecache; that's a bogon in my
patches.

Also, I should mention this concept is based on code seen in RHEL3,
which uses a __GFP_WIRED flag, albeit for a different purpose (it
appears to be centered around removing dirty ramfs pagecache from
the LRU lists(s) as opposed to accounting for OOM-related reasons).


-- wli

Index: linux-2.6.7/drivers/block/rd.c
===================================================================
--- linux-2.6.7.orig/drivers/block/rd.c	2004-06-16 05:19:37.000000000 +0000
+++ linux-2.6.7/drivers/block/rd.c	2004-06-23 22:16:45.000000000 +0000
@@ -378,7 +378,7 @@
 		 */
 		gfp_mask = mapping_gfp_mask(mapping);
 		gfp_mask &= ~(__GFP_FS|__GFP_IO);
-		gfp_mask |= __GFP_HIGH;
+		gfp_mask |= __GFP_HIGH|__GFP_WIRED;
 		mapping_set_gfp_mask(mapping, gfp_mask);
 	}
 
