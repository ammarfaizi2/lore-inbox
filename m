Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVBNShZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVBNShZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 13:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVBNShZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 13:37:25 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:65521 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261516AbVBNShS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 13:37:18 -0500
Date: Mon, 14 Feb 2005 18:36:43 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrea Arcangeli <andrea@suse.de>
cc: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [RFC] Changing COW detection to be memory hotplug friendly
In-Reply-To: <20050214174158.GE13712@opteron.random>
Message-ID: <Pine.LNX.4.61.0502141815320.9608@goblin.wat.veritas.com>
References: <20050203035605.C981A7046E@sv1.valinux.co.jp> 
    <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com> 
    <Pine.LNX.4.61.0502081549320.2203@goblin.wat.veritas.com> 
    <20050210190521.GN18573@opteron.random> 
    <Pine.LNX.4.61.0502101953190.6194@goblin.wat.veritas.com> 
    <20050210204025.GS18573@opteron.random> 
    <Pine.LNX.4.61.0502110710150.5866@goblin.wat.veritas.com> 
    <20050211085239.GD18573@opteron.random> 
    <Pine.LNX.4.61.0502111258310.7808@goblin.wat.veritas.com> 
    <20050214174158.GE13712@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2005, Andrea Arcangeli wrote:
> > By the way, while we're talking of remove_exclusive_swap_page:
> > a more functional issue I sometimes wonder about, why don't we
> > remove_exclusive_swap_page on write fault?  Keeping the swap slot
> > is valuable if read fault, but once the page is dirtied, wouldn't
> > it usually be better to free that slot and allocate another later?
> 
> Avoiding swap fragmentation is one reason to leave it allocated. So you
> can swapin/swapout/swapin/swapout always in the same place on disk as
> long as there's plenty of swap still available. I'm not sure how much
> speedup this provides, but certainly it makes sense.

I rather thought it would tend to increase swap fragmentation: that
the next time (if) this page has to be written out to swap, the disk
has to seek back to some ancient position to write this page, when
the rest of the cluster being written is more likely to come from a
recently allocated block of contiguous swap pages (though if many of
them are being rewritten rather than newly allocated, they'll all be
all over the disk, no contiguity at all).

Of course, freeing as soon as dirty does leave a hole behind, which
tends towards swap fragmentation: but I thought the swap allocator
tried for contiguous clusters before it fell back on isolated pages
(I haven't checked, and akpm has changes to swap allocation in -mm).

Hmm, I think you're thinking of the overall fragmentation of swap,
and are correct about that; whereas I'm saying "fragmentation"
when what I'm really concerned about is increased seeking.

But only research would tell the true story.  I suspect the change
from 2.4's linear vma scanning to 2.6's rmap against the bottom of
LRU may have changed the rules for swap layout strategy.

Hugh
