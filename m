Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbUDHWTT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUDHWTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:19:19 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:20679
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262840AbUDHWTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:19:17 -0400
Date: Fri, 9 Apr 2004 00:19:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040408221915.GV31667@dualathlon.random>
References: <20040406192549.GA14869@elte.hu> <12640000.1081378705@flay> <20040407230140.GT26888@dualathlon.random> <29510000.1081380104@flay> <20040407231806.GV26888@dualathlon.random> <33900000.1081380891@flay> <20040408001845.GX26888@dualathlon.random> <1479132704.1081405456@[10.10.2.4]> <20040408215946.GU31667@dualathlon.random> <29690000.1081462791@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29690000.1081462791@flay>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 03:19:51PM -0700, Martin J. Bligh wrote:
> --On Thursday, April 08, 2004 23:59:46 +0200 Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > On Wed, Apr 07, 2004 at 11:24:16PM -0700, Martin J. Bligh wrote:
> >> Instead of fiddling with tuning knobs, I'd prefer to just do the UKVA
> >> idea I've proposed before, and let each process have their own pagetables
> >> mapped permanently ;-)
> > 
> > that will have you pay for pte-highmem even in non-highmem machines.
> > I'm always been against your above idea ;) It can speedup mmap a bit for
> > some uncommon case but I believe your slowdown comes from the page faults after
> > exeve and startup not from mmap with the kernel compile, and worst of
> > all for non-highmem too (no sysctl or tuning knob can save you then).
> > Amittedly some mmap intensive workload can get a slight speedup compared
> > to pte-highmem but I don't think it's common and it has the potential of
> > slowing down the page faults especially in short lived tasks even w/o
> > highmem.
> 
> You mean the page-faults for the pagetable mappings themselves? I wouldn't
> have thought that'd make an impact - at least I don't see how it could be
> worse than pte_highmem. And as we could make it conditional on highmem

it's worse because you pay for it even with lowmem.

as for your question for why the overhead is lower on 1/2G boxes, that
as well is because the probability of the page going into highmem is
much lower.

> anyway (or even CONFIG_64GB, I'm pretty sure 4GB machines don't need it),
> I don't think it matters (ie you'd just turn it on instead of pte_highmem).

1 single smp kernel with CONFIG64G and ptehighmem=y covers 99% of the
x86 smp hardware in the market, from 32M of ram to 32G of ram both
included and always at the 99% of peak possible performance of the
hardware, that's really nice IMHO, I don't like design solutions that
requires different kernel image every few gigs of ram you add to the
machine unless real big gains can be demonstrated.  One can recompile
and tune as usual, but we should prefer generic design solutions to
dedicated ones unless they really make an huge difference. Running a
CONFIG64G with ptehighmem=y on a 512M box may be say 0.1% slower than a
nohighmem-noptehighmem, Ingo posted the exact PAE vs non-PAE slowdown a
few days ago, it's non significant.

> But you're right, we do need to take that into consideration.

Best really would be to benchmark it, for it I definitely like your
kernel compile -j benchmark for it (but with mem=800m ;).

> > What I found attractive was the persistent kmap in userspace, but that
> > idea breaks with threading, and Andrew found another way that is to make
> > the page fault interruptible so it doesn't seem very worthwhile anymore
> > even w/o threading.
> 
> Yeah, I've given up on that one ;-) The main use for it was pagetables
> anyway, and we can do that without the threading problems.

agreed ;)
