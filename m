Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUFXSH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUFXSH6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 14:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266840AbUFXSH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 14:07:58 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59878
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266837AbUFXSHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 14:07:51 -0400
Date: Thu, 24 Jun 2004 20:07:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Takashi Iwai <tiwai@suse.de>,
       Andi Kleen <ak@suse.de>, ak@muc.de, tripperda@nvidia.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624180756.GS30687@dualathlon.random>
References: <20040623234644.GC38425@colin2.muc.de> <s5hhdt1i4yc.wl@alsa2.suse.de> <20040624112900.GE16727@wotan.suse.de> <s5h4qp1hvk0.wl@alsa2.suse.de> <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624173927.GQ30687@dualathlon.random> <20040624175331.GI21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624175331.GI21066@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 10:53:31AM -0700, William Lee Irwin III wrote:
> On Thu, Jun 24, 2004 at 07:39:27PM +0200, Andrea Arcangeli wrote:
> > I looked more into it and you can leave it turned off since it's not
> > going to work.
> > it's all in functions of z->pages_* and those are _global_ for all the
> > zones, and in turn they're absolutely meaningless.
> > the algorithm has nothing in common with lowmem_reverse_ratio, the
> > effect has a tinybit of similarity but the incremntal min thing is so
> > weak and so bad that it will either not help or it'll waste tons of
> > memory. Furthemore you cannot set a sysctl value that works for all
> > machines. The whole thing should be dropped and replaced with the fine
> > production quality lowmem_reserve_ratio in 2.4.26+
> > (the only broken thing of lowmem_reserve_ratio is that it cannot be
> > tuned, not even at boottime, a recompile is needed, but that's fixable
> > to tune it at boot time, and in theory at runtime too, but the point is
> > that no dyanmic tuning is required with it)
> > Please focus on this code of 2.4:
> 
> There is mention of discrimination between pinned and unpinned
> allocations not being possible; I can arrange this for more
> comprehensive coverage if desired. Would you like this to be arranged,
> and if so, how would you like that to interact with the fallback
> heuristics?

how do you handle swapoff and mlock then? anonymous memory is pinned w/o
swap. You've relocate the stuff during the mlock or swapoff to obey to
the pin limits to make this work right, and it sounds quite complicated
and it would hurt mlock performance a lot too (some big app uses mlock
to pagein w/o page faults tons of stuff).

Note that the "pinned" thing in theory makes *perfect* sense, but it
only makes sense on _top_ of lowmem_zone_reserve_ratio, it's not an
alternative.

When the page is pinned you obey to the "lowmem_zone_reserve_ratio" when
it's _not_ pinned then you absolutely ignore the
lowmem_zone_reseve_ratio and you go with the watermarks[curr_zone_idx]
instead of the class_idx.

But in practice I doubt it worth it since I doubt you want to relocate
pagecache and anonymous memory during swapoff/mlock.
