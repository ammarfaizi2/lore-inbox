Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUFXSaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUFXSaI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 14:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbUFXSaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 14:30:07 -0400
Received: from holomorphy.com ([207.189.100.168]:40843 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264542AbUFXS3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 14:29:49 -0400
Date: Thu, 24 Jun 2004 11:29:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
       Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624182917.GK21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
	Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
	discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624173927.GQ30687@dualathlon.random> <20040624175331.GI21066@holomorphy.com> <20040624180756.GS30687@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624180756.GS30687@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 08:07:56PM +0200, Andrea Arcangeli wrote:
> how do you handle swapoff and mlock then? anonymous memory is pinned w/o
> swap. You've relocate the stuff during the mlock or swapoff to obey to
> the pin limits to make this work right, and it sounds quite complicated
> and it would hurt mlock performance a lot too (some big app uses mlock
> to pagein w/o page faults tons of stuff).

I don't have a predetermined answer to this. I can take suggestions
(e.g. page migration) for a preferred implementation of how pinned
userspace is to be handled, or refrain from discriminating between
pinned and unpinned allocations as desired. Another possibility would
be ignoring the mlocked status of userspace pages in situations where
cross-zone migration would be considered necessary.


On Thu, Jun 24, 2004 at 08:07:56PM +0200, Andrea Arcangeli wrote:
> Note that the "pinned" thing in theory makes *perfect* sense, but it
> only makes sense on _top_ of lowmem_zone_reserve_ratio, it's not an
> alternative.
> When the page is pinned you obey to the "lowmem_zone_reserve_ratio" when
> it's _not_ pinned then you absolutely ignore the
> lowmem_zone_reseve_ratio and you go with the watermarks[curr_zone_idx]
> instead of the class_idx.
> But in practice I doubt it worth it since I doubt you want to relocate
> pagecache and anonymous memory during swapoff/mlock.

I suspect that if it's worth it to migrate userspace memory between
zones, it's only worthwhile to do so during page reclamation. The first
idea that occurs to me is checking for how plentiful memory in upper
zones is when a pinned userspace page in a lower zone is found on the
LRU, and then migrating it as an alternative to outright eviction or
ignoring its pinned status.

I didn't actually think of it as an alternative, but as just feeding
your algorithm the more precise information the comment implied it
wanted. I'm basically just looking to get things as solid as possible,
so I'm not wedded to a particular solution. If it's too unclear how to
handle the situation when pinned allocations can be distinguished, I
can just port the 2.4 fallback discouraging algorithm without extensions.


-- wli
