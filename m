Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264181AbUDGVht (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264168AbUDGVht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:37:49 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38314
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264181AbUDGVfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:35:53 -0400
Date: Wed, 7 Apr 2004 23:35:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040407213551.GM26888@dualathlon.random>
References: <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <20040406202548.GI2234@dualathlon.random> <20040407060330.GB26888@dualathlon.random> <20040407064629.GA31338@elte.hu> <20040407072349.GC26888@dualathlon.random> <20040407082350.GB32140@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407082350.GB32140@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 10:23:50AM +0200, Ingo Molnar wrote:
> thanks for the testing! It will be interesting to see.

The overhead of the __flush_tlb_global+__flush_tlb in the irq handler is
nothing like -17%.

But I tried again with the real full 4:4 patch applied (after two runs
with __flush_tlb_global+flush_tlb) and there I get _again_ the very same
double digit slowdown compared to 3:1, this is 100% reproducible, no
matter how I mix the memory, this is not a measurement error and you
should be able to reproduce just fine.

I don't really think this can be related to the page coloring, the
concidence would be too huge, the double digit slowdown is always
measurable as soon as I enable 4:4 and it goes away as soon as I disable
it.  There seems some more overhead in the 4:4 switch that isn't
accounted by just the tlb flush in the irq of a 3:1 kernel, or maybe the
simple fact you're sharing the same piece of address space disables some
cpu optimization in hardware (I mean, tlb flushes in mmaps 
don't necessairly destroy everything, a true mm_switch has to instead
because the pgd changes).  But don't ask me more about this, I'm just
reporting to you the accurate measurements of a double digit slowdown in
pure cpu computations with 4:4 and I now verified for you that it's not
a measurements error.

BTW, people doing number crunching with 4:4 may also want to try to
recompile with HZ=100 and try to measure any difference, to see if they
also see what I've measured with 4:4 (assuming they work heavily on
chunks of memory in cache-size chunks at time, which is the most
efficient of processing the data if your algorithms allows you to do it
btw).

Please try the HINT yourself too, the 4:4 measurements are definitely
100% reproducible for me.

See the "verification" results here (they should be visible in a few
minutes):

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/misc/31-44-100-1000/for-ingo.png

the 2.6.5-rc4-1000-flush is a run with the flush_tlb_global +
flush_tlb with 3:1, there's little slowdown for pure number crunching
with 1000 irqs per second (I run it twice and it was the same).

And then 2.6.5-rc4-4:4-1000-2 is another run with 4:4 after another
reboot and another kernel recompile, different memory mixed etc... (i.e.
no page coloring involved, I run it twice and it was the same, the error
across the different runs is around 3-4%, it's quite high, but
definitely nothing like a double digit percent error, also see how close
is the 3:1+flush_tlb curve to the pure 3:1). It doesn't matter how I run
the thing, it keeps giving the same double digit slowdown result for 4:4
and almost no slowdown for the flush_tlb. Again my theory is that the
cr3 dummy write is autodetected by the smart cpus and it doesn't account
for the true 4:4 overhead that is a truly mm_switch. See also my email
to Manfred on why it's worthless to use the same 4th level pgtable for
all processes on x86-64.

Also note that the HINT is written exactly to see the whole picture
about the hardware including l2 caches, so it's not likely that the most
important piece of the curve is going to be just garbage, obviously
there are errors due page coloring, but on x86 they're nothing like -17%
and the measurements are reproducible, so my numbers I posted are
correct and reproducible as far as I can tell.
