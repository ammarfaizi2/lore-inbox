Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTDDBaR (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 20:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTDDBaR (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 20:30:17 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:56571
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263617AbTDDBaF (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 20:30:05 -0500
Date: Thu, 3 Apr 2003 20:37:04 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] smp_call_function needs mb() - oopsable
In-Reply-To: <Pine.LNX.4.44.0304030937360.27631-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.50.0304031951180.30262-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0304030937360.27631-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, Linus Torvalds wrote:

> On Thu, 3 Apr 2003, Zwane Mwaikambo wrote:
> >
> > I have a 3 Processor Pentium 133 system w/ 512k external cache which is 
> > oopsing reliably in the exact same location.
> 
> Whee. What a piece of "interesting hardware".

Yep, it appears to have PCI bus funnies too..

> I really think that your patch is a bit questionable. The wmb() on the 
> sender side looks correct as-is, and to me it looks like it is the 
> _receiver_ side that might need a read-barrier before it reads 
> call_data(). 

I'm compiling with rmb before the APIC EOI, which is after the local 
variable assignments (i'll post the results in a bit, slow build box).

> I really thought that the interrupt should be a serializing event, but I 
> can't find that in the intel databooks (they make "iret" a serializing 
> instruction, but not _taking_ an interrupt, unless I missed something).
> 
> Can you check if you get the right behaviour if you have a read barrier in 
> the receive path? I actually think we need a full mb() on _both_ paths, 
> since the current wmb() only guarantees that writes will be seen "in 
> order wrt other writes", and while the IPI generation really _is_ a write 
> in itself, I wonder if the Intel CPU's might not consider it something 
> special..

I haven't actually seen anything mentioning writing to ICR 
having a serializing side effect. However the forced read around write 
with family < P6 (CONFIG_X86_GOOD_APIC) in Linux should ensure that no 
reads or writes pass the APIC/ICR write due to the xchg, however wether 
'implied' lock ensures that it's treated the same as implicit lock i don't 
know.

> I'm not opposed to your patch per se, but I really do believe that it is 
> potentially wrong. If we have no serialization on the read side, your 
> patch might not actually fully plug the real bug, only hide it. I'd like 
> to know if a read barrier on the read side (without the full barrier on 
> the write side) is sufficient. It _should_ be (but see my worry about the 
> APIC write maybe being considered "outside the scope" of the normal cache 
> coherency protocols).

Wouldn't APIC writes be then treated differently on a P4 (which uses the 
system bus) and the P5/P6 which has it's own serial bus? Imo we should not 
rely on APIC loads/stores which is why i added an rmb after the APIC EOI 
for the rmb in smp_call_function_interrupt test.

	Zwane
-- 
function.linuxpower.ca
