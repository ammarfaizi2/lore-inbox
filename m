Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVBKNVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVBKNVb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 08:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVBKNVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 08:21:31 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:40621 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262124AbVBKNVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 08:21:22 -0500
Date: Fri, 11 Feb 2005 13:20:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrea Arcangeli <andrea@suse.de>
cc: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [RFC] Changing COW detection to be memory hotplug friendly
In-Reply-To: <20050211085239.GD18573@opteron.random>
Message-ID: <Pine.LNX.4.61.0502111258310.7808@goblin.wat.veritas.com>
References: <20050203035605.C981A7046E@sv1.valinux.co.jp> 
    <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com> 
    <Pine.LNX.4.61.0502081549320.2203@goblin.wat.veritas.com> 
    <20050210190521.GN18573@opteron.random> 
    <Pine.LNX.4.61.0502101953190.6194@goblin.wat.veritas.com> 
    <20050210204025.GS18573@opteron.random> 
    <Pine.LNX.4.61.0502110710150.5866@goblin.wat.veritas.com> 
    <20050211085239.GD18573@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2005, Andrea Arcangeli wrote:
> 
> Ok, I'm quite convinced it's correct now. The only thing that can make
> mapcount go up without the lock on the page without userspace
> intervention (and userspace intervention would make it an undefined
> behaviour like in my example with fork), was the swapin, and you covered
> it by moving the unlock after page_add_anon_rmap (so mapcount changes
> atomically with the page_swapcount there too). Swapoff was already doing
> it under the page lock.

Thanks a lot for thinking it through, yes, that's how it is.

(For a while I felt nervous about moving that unlock_page below
the arch-defined flush_icache_page; but then realized that since it's
already done with page_table spinlock, PG_locked cannot be an issue.)

> Then we should use the mapcount/swapcount in remove_exclusive_swap_page
> too.

Originally I thought so, but later wasn't so sure.  There might be
somewhere which stabilizes PageSwapCache by incrementing page_count,
rechecks it, waits to get lock_page, then assumes still PageSwapCache?
(Though it's hard to see why it would need to make such an assumption,
and in the equivalent file case would have to allow for truncation.)

It just needs a wider audit than the simpler can_share_swap_page case,
and can be done independently later on.

By the way, while we're talking of remove_exclusive_swap_page:
a more functional issue I sometimes wonder about, why don't we
remove_exclusive_swap_page on write fault?  Keeping the swap slot
is valuable if read fault, but once the page is dirtied, wouldn't
it usually be better to free that slot and allocate another later?

But I'm always scared of making such changes to swapping, because
I cannot imagine a good enough range of swap performance tests.

Hugh
