Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUCXRHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 12:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUCXRHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 12:07:51 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32155
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263777AbUCXRHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 12:07:49 -0500
Date: Wed, 24 Mar 2004 18:08:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040324170841.GT2065@dualathlon.random>
References: <20040320123009.GC9009@dualathlon.random> <2696050000.1079798196@[10.10.2.4]> <20040320161905.GT9009@dualathlon.random> <2924080000.1079886632@[10.10.2.4]> <20040321235207.GC3649@dualathlon.random> <1684742704.1079970781@[10.10.2.4]> <20040324061957.GB2065@dualathlon.random> <24560000.1080143798@[10.10.2.4]> <20040324162116.GQ2065@dualathlon.random> <35130000.1080146145@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35130000.1080146145@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 08:35:46AM -0800, Martin J. Bligh wrote:
> > here it's not the fastest (though a 0.03 difference should be in the
> > error range with an unlimited -j)
> >
> > overall I think for the fast path we can conclude they're at least
> > equally fast.
> 
> Yup, I think they're all within the noise level between anon_mm and anon_vma,
> though both are faster than partial by something at lease statistically
> significant (though maybe not even enough to care about for these 
> workloads).

they are, and those workloads aren't anonymous memory intensive that's
why the difference is not significant (see the benchmark I posted a few
days ago comparing anon_vma with mainline, the boost is huge on a 1G
box, on a 64bit multi-gigabox the boost will be even bigger, close to
100% speedup infact).

> Yeah, it does 5 passes, and throws away the fastest and slowest. So it's
> only 3 it's calculating off ... I think you just got lucky with a 0.0% ;-)

I guess so ;)

> > it's one of the -mm patches probably that boosts those bits (the
> > cost page_add_rmap and the page faults should be the same with both
> > anon-vma and anonmm). as for the regression, the pgd_alloc slowdown is
> > the unslabify one from andrew that releases 8 bytes per page in 32bit
> > archs and 16 bytes per page in 64bit archs.
> 
> OK, great ... thanks for the info. I think I'd happily pay that cost in
> pgd_alloc for the space gain - kernbench & SDET are about as bad as it

that's Andrew's point too and I cannot agree more ;)

> gets on pgd_alloc, so that seems like a good tradeoff.

pgd_alloc is the fork path, so yes it's a very good tradeoff (really I
didn't check if any memory is being wasted by the bigger allocations,
but that is solvable even without the slab and without page->list by
just chaining the pages like poll does).

However Wli suggested that we shouldn't stop using the slab for those
minuscle allocations, and that the slab should not use the lists
instead. You may want to ask Wli for details. For now I enjoy the
36bytes page_t ;)

> > My current page_t is now 36 bytes (compared to 48bytes of 2.4) in 32bit
> > archs, and 56bytes on 64bit archs (hope I counted right this time, Hugh
> > says I'm counting wrong the page_t, methinks we were looking different
> > source trees instead but maybe I was really counting wrong ;).
> 
> IIRC, with PAE etc on, mainline is 44 bytes. So if we saved 8 from Andrew's

nitpick, it's not PAE but highmem that makes it worse (even with PAE off).

> change, and 4 from objrmap, I'd be hoping for 32?

I giveup counting, I used the compiler this time, and yes it's 32bytes
for every page_t of 2.6-aa compared to 48bytes of 2.4.
