Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWIJUCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWIJUCW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 16:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWIJUCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 16:02:22 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:55277 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S964836AbWIJUCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 16:02:21 -0400
In-Reply-To: <200609101018.06930.jbarnes@virtuousgeek.org>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com> <45028F87.7040603@garzik.org> <20060909.030854.78720744.davem@davemloft.net> <200609101018.06930.jbarnes@virtuousgeek.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D680AFCF-11EC-48AD-BBC2-B92521DF442A@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, jeff@garzik.org, paulus@samba.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Sun, 10 Sep 2006 22:01:20 +0200
To: Jesse Barnes <jbarnes@virtuousgeek.org>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> As (I think) BenH mentioned in another email, the normal way Linux
>>> handles these interfaces is for the primary API (readX, writeX) to
>>> be strongly ordered, strongly coherent, etc.  And then there is a
>>> relaxed version without barriers and syncs, for the smart guys who
>>> know what they're doing
>>
>> Indeed, I think that is the way to handle this.
>
> Well why didn't you guys mention this when mmiowb() went in?
>
> I agree that having a relaxed PIO ordering version of writeX makes  
> sense
> (jejb convinced me of this on irc the other day).  But what to name  
> it?
> We already have readX_relaxed, but that's for PIO vs. DMA ordering,  
> not
> PIO vs. PIO.  To distinguish from that case maybe writeX_weak or
> writeX_nobarrier would make sense?

Why not just keep writel() etc. for *both* purposes; the address cookie
it gets as input can distinguish between the required behaviours for
different kinds of I/Os; it will have to be setup by the arch-specific
__ioremap() or similar.  And then there could be a  
pci_map_mmio_relaxed()
that, when a driver uses it, means "this driver requires only PCI
ordering rules for its MMIO, not x86 rules", so the driver promises to
do wmb()'s for DMA ordering and the mmiowb() [or whatever they become --
pci_mem_to_dma_barrier() and pci_cpu_to_cpu_barrier() or whatever] etc.

Archs that don't see the point in doing (much) faster and scalable I/O,
or just don't want to bother, can have this pci_map_mmio() just call
their x86-ordering ioremap() stuff.

The impact on architectures is minimal; they all need to implement this
new mapping function, but can just default it if they don't (yet) want
to take advantage of it.  Archs that do care need to use the I/O cookie
as an actual cookie, not directly as a CPU address to write to, and then
use the proper ordering stuff for the kind of ordering the cookie says
is needed for this I/O range.

The impact on device drivers is even more minimal; drivers don't have to
change; and if they don't, they get x86 I/O ordering semantics.  Drivers
that do want to be faster on other architectures, and have been  
converted
for it (and most interesting ones have), just need to change the  
ioremap()
of their MMIO space to the new API.

I hope this way everyone can be happy -- no one is forced to change,  
only
one new API is introduced.


Segher

