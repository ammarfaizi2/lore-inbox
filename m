Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVBNVlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVBNVlx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 16:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVBNVlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 16:41:53 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42254
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261563AbVBNVlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 16:41:51 -0500
Date: Mon, 14 Feb 2005 22:41:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [RFC] Changing COW detection to be memory hotplug friendly
Message-ID: <20050214214148.GM13712@opteron.random>
References: <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com> <Pine.LNX.4.61.0502081549320.2203@goblin.wat.veritas.com> <20050210190521.GN18573@opteron.random> <Pine.LNX.4.61.0502101953190.6194@goblin.wat.veritas.com> <20050210204025.GS18573@opteron.random> <Pine.LNX.4.61.0502110710150.5866@goblin.wat.veritas.com> <20050211085239.GD18573@opteron.random> <Pine.LNX.4.61.0502111258310.7808@goblin.wat.veritas.com> <20050214174158.GE13712@opteron.random> <Pine.LNX.4.61.0502141815320.9608@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502141815320.9608@goblin.wat.veritas.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 06:36:43PM +0000, Hugh Dickins wrote:
> On Mon, 14 Feb 2005, Andrea Arcangeli wrote:
> > > By the way, while we're talking of remove_exclusive_swap_page:
> > > a more functional issue I sometimes wonder about, why don't we
> > > remove_exclusive_swap_page on write fault?  Keeping the swap slot
> > > is valuable if read fault, but once the page is dirtied, wouldn't
> > > it usually be better to free that slot and allocate another later?
> > 
> > Avoiding swap fragmentation is one reason to leave it allocated. So you
> > can swapin/swapout/swapin/swapout always in the same place on disk as
> > long as there's plenty of swap still available. I'm not sure how much
> > speedup this provides, but certainly it makes sense.
> 
> I rather thought it would tend to increase swap fragmentation: that
> the next time (if) this page has to be written out to swap, the disk
> has to seek back to some ancient position to write this page, when
> the rest of the cluster being written is more likely to come from a
> recently allocated block of contiguous swap pages (though if many of
> them are being rewritten rather than newly allocated, they'll all be
> all over the disk, no contiguity at all).
> 
> Of course, freeing as soon as dirty does leave a hole behind, which
> tends towards swap fragmentation: but I thought the swap allocator
> tried for contiguous clusters before it fell back on isolated pages
> (I haven't checked, and akpm has changes to swap allocation in -mm).
> 
> Hmm, I think you're thinking of the overall fragmentation of swap,
> and are correct about that; whereas I'm saying "fragmentation"
> when what I'm really concerned about is increased seeking.

Swapouts aren't the problem. The swapins with physical readahead are the
ones that benefits from the reduced overall fragmentation. Or at least
this was the case in 2.4, you're right something might be different now
that we don't follow a swapout virtual address space order anymore (but
there is probably still some localization effect during the ->nopage
faults).
