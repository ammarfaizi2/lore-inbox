Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVLALdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVLALdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 06:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVLALdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 06:33:40 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:4015 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932154AbVLALdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 06:33:40 -0500
Date: Thu, 1 Dec 2005 19:40:52 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, christoph@lameter.com, riel@redhat.com,
       a.p.zijlstra@chello.nl, npiggin@suse.de, andrea@suse.de,
       marcelo.tosatti@cyclades.com, magnus.damm@gmail.com
Subject: Re: [PATCH 01/12] vm: kswapd incmin
Message-ID: <20051201114052.GA6011@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	christoph@lameter.com, riel@redhat.com, a.p.zijlstra@chello.nl,
	npiggin@suse.de, andrea@suse.de, marcelo.tosatti@cyclades.com,
	magnus.damm@gmail.com
References: <20051201101810.837245000@localhost.localdomain> <20051201101918.396239000@localhost.localdomain> <20051201023330.3dd9c48f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201023330.3dd9c48f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 02:33:30AM -0800, Andrew Morton wrote:
> I spat this back a while ago.  See the changelog (below) for the logic
> which you're removing.
>
> This change appears to go back to performing reclaim in the highmem->lowmem
> direction.  Page reclaim might go all lumpy again.
> 
> Shouldn't first_low_zone be initialised to ZONE_HIGHMEM (or pgdat->nr_zones
> - 1) rather than to 0, or something?  I don't understand why we're passing
> zero as the classzone_idx into zone_watermark_ok() in the first go around
> the loop.

Sorry to note that I'm mainly taking its zone-range --> zones-under-watermark
cleanups. The scan order is reverted back to DMA->HighMem in
mm-balance-zone-aging-in-kswapd-reclaim.patch, and the first_low_zone logic is
also replaced with a quite different one there.

My thinking is that the overall reclaim-for-watermark should be weakened and
just do minimal watermark-safeguard work, so that it will not be a major force
of imbalance.

Assume there are three zones. The dynamics goes something like:

HighMem exhausted --> reclaim from it --> become more aged --> reclaim the
other two zones for aging

DMA reclaimed --> age leaps ahead --> reclaim Normal zone for aging, while
HighMem is being reclaimed for watermark

In the kswapd path, if there are N rounds of reclaim-for-watermark with
all_zones_ok=0, there could be N+1 rounds of reclaim-for-aging with the
additional 1 time of all_zones_ok=1. With this the force of balance outperforms
the force of imbalance.

In the direct path, there are 10 rounds of aging before unconditionally reclaim
from all zones, that's pretty much force of balance.

In summary:
- HighMem zone is normally first exhausted and mostly reclaimed for watermark.
- DMA zone is now mainly reclaimed for aging.
- Normal zone will be mostly reclaimed for aging, sometimes for watermark.
 
Thanks,
Wu
