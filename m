Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbUDGGqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 02:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbUDGGqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 02:46:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52172 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263742AbUDGGqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 02:46:14 -0400
Date: Wed, 7 Apr 2004 08:46:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040407064629.GA31338@elte.hu>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <20040406202548.GI2234@dualathlon.random> <20040407060330.GB26888@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407060330.GB26888@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> > I'm using DOUBLE. However I won't post the quips, I draw the graph
> > showing the performance for every working set, that gives a better
> > picture of what is going on w.r.t. memory bandwidth/caches/tlb.
> 
> Here we go:
> 
> 	http://www.kernel.org/pub/linux/kernel/people/andrea/misc/31-44-100-1000/31-44-100-1000.html
> 
> the global quips you posted indeed had no way to account for the part
> of the curve where 4:4 badly hurts. details in the above url.

Firstly, most of the first (full) chart supports my measurements. 

There's the portion of the chart at around 500k working set that is at
issue, which area you've magnified so helpfully [ ;-) ].

That area of the curve is quite suspect at first sight. With a TLB flush
every 1 msec [*], for a 'double digit' slowdown to happen it means the
effect of the TLB flush has to be on the order of 100-200 usecs. This is
near impossible, the dTLB+iTLB on your CPU is only 64+64. This means
that a simple mmap() or a context-switch done by a number-cruncher
(which does a TLB flush too) would have a 100-200 usecs secondary cost -
this has never been seen or reported before!

but it is well-known that most complex numeric benchmarks are extremely
sensitive to the layout of pages - e.g. my dTLB-sensitive benchmark is
so sensitive that i easily get runs that are 2 times faster on 4:4 than
on 3:1, and the 'results' are extremely stable and repeatable on the
same kernel!

to eliminate layout effects, could you do another curve? Plain -aa4 (no
4:4 patch) but a __flush_tlb() added before and after do_IRQ(), in
arch/i386/kernel/irq.c? This should simulate much of the TLB flushing
effect of 4:4 on -aa4, without any of the other layout changes in the
kernel. [it's not a full simulation of all effects of 4:4, but it should
simulate the TLB flush effect quite well.]

once the kernel image layout has been stabilized via the __flush_tlb()
thing, the way to stabilize user-space layout is to static link the
benchmark and boot it via init=/bin/DOUBLE. This ensures that the
placement of the physical pages is constant. Doing the test 'fresh after
bootup' is not good enough.

	Ingo

[*] a nitpick: you keep saying '2000 tlb flushes per second'. This is
    misleading, there's one flush of the userspace TLBs every 1 msec
    (i.e. 1000 per second), and one flush of the kernel TLBs - but
    the kernel TLBs are small at this point, especially with 4MB pages.
