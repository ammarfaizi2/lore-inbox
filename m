Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUFYDK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUFYDK7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 23:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUFYDK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 23:10:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9125
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266183AbUFYDK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 23:10:56 -0400
Date: Fri, 25 Jun 2004 05:11:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com, tiwai@suse.de,
       ak@suse.de, ak@muc.de, tripperda@nvidia.com, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040625031101.GH30687@dualathlon.random>
References: <20040624164258.1a1beea3.ak@suse.de> <s5hy8mdgfzj.wl@alsa2.suse.de> <20040624152946.GK30687@dualathlon.random> <40DAF7DF.9020501@yahoo.com.au> <20040624165200.GM30687@dualathlon.random> <20040624165629.GG21066@holomorphy.com> <20040624145441.181425c8.akpm@osdl.org> <20040624151130.4a444973.akpm@osdl.org> <20040624230919.GB30687@dualathlon.random> <40DB7D25.1090207@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40DB7D25.1090207@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 11:17:25AM +1000, Nick Piggin wrote:
> It can easily be modified if required though. Is there a need to be
> tuning these different things? This is probably where we should hold

I did tune them differently in 2.4 mainline at least.  256 ratio for dma
and 32 ratio for lowmem, the lowmem is already quite critical in most
machines with >2G of ram so ratio should be lower than dma.  for example
on 64bit you want the 16M of dma to be completely reserved only on
machines with >4G of ram. The 256 dma ratio applies fine to 64bit archs,
and the 32 never applies to 64bit archs and it only applies to the
highmem boxes.

the 256 and 32 numbers aren't random, they're calculated this way:

	4096M of 64bit platform / 16M = 256
	32G of 32bit platform / 1G = 32

That means with my 2.4 algorithm any 64bit machine with >4G has its
whole dma zone reserved to __GFP_DMA.

and at the same time any 32bit machine with 32G of ram doesn't allow
anything but GFP_KERNEL to go in lowmem, this is fundamental.

Now you may very well argue about the numbers not being perfect and this
is still a bit hardcoded with the highmem issues in mind, but it would
be possible to generalize it even more and I do see a benefit in not
having a fixed number for both issues, and to get a bit more of
flexibility that the 2.4 has over the 2.6 one.
