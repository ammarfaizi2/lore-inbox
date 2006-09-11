Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWIKW5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWIKW5o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWIKW5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:57:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:40628 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932307AbWIKW5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:57:43 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <4505DB10.7080807@pobox.com>
References: <1157947414.31071.386.camel@localhost.localdomain>
	 <200609111139.35344.jbarnes@virtuousgeek.org>
	 <1158011129.3879.69.camel@localhost.localdomain>
	 <4505DB10.7080807@pobox.com>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 08:56:34 +1000
Message-Id: <1158015394.3879.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 17:54 -0400, Jeff Garzik wrote:
> Benjamin Herrenschmidt wrote:
> > Ah ? What about the comment in e1000 saying that it needs a wmb()
> > between descriptor updates in memory and the mmio to kick them ? That
> > would typically be a memory_to_io_wb(). Or are your MMIOs ordered cs.
> > your cacheable stores ?
> 
> That's likely just following existing practice found in many network 
> drivers.  The following two design patterns have been copied across a 
> great many network drivers:

Well, I was mentioning that one specifically because this comment:

        /* Force memory writes to complete before letting h/w
         * know there are new descriptors to fetch.  (Only
         * applicable for weak-ordered memory model archs,
         * such as IA-64). */

Which made me ask wether, ia64 was or was not ordering memory store
followed by MMIO store, that is does ia64 -current- accessors provide
rule #2 (memory W + MMIO W) currently or not and would it benefit from
not having to provide it with my new partially relaxed accessors ?

> 1) When in a loop, reading through a DMA ring, put an "rmb()" at the top 
> of the loop, to ensure that the compiler does not optimize out all 
> memory loads after the first.

and rmb is heavy handed for a compiler barrier :) what you might need on
some platforms is an rmb between the MMIO read of whatever status/index
register and the following memory reads of descriptors, and you may want
an rmb in case where it matters if the chip has been changing a value
behind your back (which it generally doesn't) but that's pretty much
it.... 

> 2) Use "wmb()" to ensure that just-written-to memory is visible to a PCI 
> device that will be reading said memory region via DMA.

That will definitely help on PowerPC with our current accessors which
are mostly ordered except for that rule #2 I mentioned above.

> I don't claim that either of these is correct, just that's existing 
> practice, perhaps in some case perpetuated by my own arch ignorance.

No worries :) That's also why I'm trying to describe precisely what
semantics are provided by the MMIO accessors with real world examples in
a way that is not arch dependant. The 4 "rules" I've listed in the first
part are precisely what should be needed for drivers, then I list the
accessors and what rules they are guaranteed to comply with, then I list
the barriers allowing to implement those ordering rules when the
accessors don't.

> So, in a perfect world where I was designing my own API, I would create 
> two new API functions:
> 
> prepare_to_read_dma_memory()
> 	and
> make_memory_writes_visible_to_dmaing_devices()
>
> and leave the existing APIs untouched.  Those are the two fundamental 
> operations that are needed.

Well, the argument currently is to make writel and readl imply the above
barriers by making them fully ordered (and slow on some platforms) and
so also provide more weakly ordered routines along with barriers for
people who know what they do. The above 2 barriers are what I've called
io_to_memory_rb() and memory_to_io_wb() (actually,
prepare_to_read_dma_memory() by itself doesn't really make much sense.
It does in conjunction with an MMIO read to flush DMA buffers, in which
case the barrier provides an ordering guarantee that the memory reads
will only be performed after the MMIO read has fully completed).

Ben.


