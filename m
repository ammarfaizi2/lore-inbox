Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVKEPzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVKEPzf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 10:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbVKEPzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 10:55:35 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:40361
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932081AbVKEPze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 10:55:34 -0500
Subject: Re: [PATCH] new driver synclink_gt
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051105003653.1966d5c7.akpm@osdl.org>
References: <1130962689.5289.8.camel@deimos.microgate.com>
	 <20051105003653.1966d5c7.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 05 Nov 2005 09:55:20 -0600
Message-Id: <1131206120.2899.52.camel@x2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-05 at 00:36 -0800, Andrew Morton wrote:
> There's not much point in presenting it as a patch-per-file, really - we
> need all four patches to have a buildable driver, so it may as well be a
> single patch

OK, the view on this seems to change frequently
and depends on who you are talking to, so I'm
never sure which way to go on a particular day.

My preference was to have a single patch, but the
view that patches absolutely must be broken into
tiny pieces even if the pieces make no sense
on their own seems to pop up a lot.

> - Tx (at least) appears to DMA straight out of kmalloced memory.  If I
>   read it right, it needs to use the PCI DMA API fully - pci_map_single()
>   and friends.   <checks>  Maybe I misread it.

DMA memory (descriptors and data buffers for the rings)
are allocated with pci_alloc_consistent().

> - It seems to be both a tty driver and a net driver, or something.  Can
>   you please describe the hardware?

Yes, it is both a tty and net (generic hdlc) driver. The hardware
is synchronous and asynchronous and can be used for normal async tty,
hdlc tty, or hdlc networking.

> - Be aware that the tty ldisc APIs were redone in -mm, so this driver
>   probably won't compile in -mm and fixups will be needed sometime.

Crap

> eww.  Please just open-code these.

These are left over from a vain attempt to decouple the
driver from the kernel API change du jour (as per
your previous comment). I will remove them.

> None of these initialisations to zero are needed.

OK

> MODULE_PARM_DESCs needed, please.

OK

> typedefs are unpopular in new code.

hmmmm, if that is the latest style then I'll change it.

> That makes the driver harder to follow, but I guess as long as it's
> followed religiously then it can make working on the driver more reliable.

It enforces proper endian handling, field access,
and bit positions. As you say, it is more reliable.
It also makes the code more readable for me.

> Please use the
> 	.field = value,
> form here.

OK

> Is silent droppage on overflow OK?

There is no return code in the API to indicate error.
The caller should monitor the write room before calling.
There is really nothing this function can do if too
much data is blindly pushed at it.

> Unneeded cast from void* (through the whole file, please).

OK

> whitespace funnies.

I read them every Sunday. Ha.
I'll fix it.

> The handling of bh_running seems vague.

It is done so if the handler is already running,
no attempt is made to schedule or run it again.

> Many ISRs are designed to special-case an irq-pending value of 0xffffffff
> so they gracefully handle device unplug.  I guess this device doesn't come
> in cardbus (yet), but maybe the same handling is needed for PCI hotplug.

There probably will be a cardbus version.
The definition of that register does not guarantee that
0xffffffff won't happen in normal operation.
But I can add a check to a different register as a
hardware present check similar to the synclink_cs
driver for the 16-bit PCMCIA card.

> del_timer_sync() needed here - otherwise the timer handler could still be
> in progress.

OK

> This happens so often that it's worth creating a new function for it. 
> Ditto get_signals().

hmmm, I want to ponder that some and review how often it is used
I've always though that get_signals_locked() type wrappers
were ugly, but if it saves significant code size it make sense.

> kfree(NULL) is legal.

OK

> > 	pbufs = (unsigned int)info->bufs_dma_addr;
> 
> No, it shouldn't put a dma_addr_t into an unsigned int.  dma_addr_t is
> sometimes 64-bit on 32-bit machines.  Basically, it should remain opaque.

This is the 32 bit physical bus address passed to the hardware
in the descriptor. The hardware DMA engine does not handle
64 bit addresses. The type should be changed to _u32 though.

> The irq_flags seems a bit obfuscated.  WHy not just remove it and hard-code
> SA_SHIRQ?

This one driver will (hopefully) handle all the variants of
this family which may or may not share the same flag settings.
Future kernel changes may add or remove more flags which may
or may not apply to a particular variant.

I would prefer to leave it in place now rather than
having to add it back in later to accommodate such changes.

> <attention fades>
> 
> Boy, it's a big driver...

It does a lot, but I've worked to reduce the size as much
as possible. It is an improvement over the original synclink
driver, which is a little crufty after being dragged through
the kernel over the last 8 years.
 
--
Paul Fulghum
Microgate Systems, Ltd.

