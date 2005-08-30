Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVH3RJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVH3RJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVH3RJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:09:55 -0400
Received: from hera.kernel.org ([209.128.68.125]:55195 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932212AbVH3RJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:09:54 -0400
Date: Tue, 30 Aug 2005 12:07:05 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Mackerras <paulus@samba.org>, Dan Malek <dan@embeddededge.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, Pantelis Antoniou <panto@intracom.gr>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
Message-ID: <20050830150705.GA6140@dmt.cnet>
References: <20050830024840.GA5381@dmt.cnet> <4313D4D6.7080108@pobox.com> <20050830035338.GA5755@dmt.cnet> <17171.57693.981385.165290@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17171.57693.981385.165290@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, Jeff,

On Tue, Aug 30, 2005 at 02:32:29PM +1000, Paul Mackerras wrote:
> Marcelo Tosatti writes:
> 
> > The memory map structure which contains device configuration/registers
> > is _always_ directly mapped with pte's (the 8xx is a chip with builtin
> > UART/network/etc functionality).
> > 
> > I don't think there is a need to use read/write acessors.

Bullshit, yep :) 

> Generally on PowerPC you need to use at least the eieio instruction to
> prevent reordering of the loads and stores to the device.  It's
> possible that 8xx is sufficiently in-order that you get away without
> putting in barrier instructions (eieio or sync), but it's not good
> practice to omit them.

On 8xx, guarded mappings seem to ensure synchronous operation of
load/store instructions.

Since the internal memory map is guarded, eieio is redudant (ie thats
why it gets away without explicit barriers now).

>From MPC860UM.pdf: 5.2.5.2.1 eieio Behavior

The purpose of eieio is to prevent loads and stores from executing
speculatively when appropriate. This might be desirable for a FIFO,
where performing a read or write changes the FIFO's data. This should
not be done unless it is certain that the instruction will be completed
and not cancelled. The same function as eieio can be accomplished by
defining a memory space as having the guarded attribute in the MMU, in
which case, the eieio instruction is redundant. However, eieio could be
useful in the rare event that a region where speculative accesses are
not allowed lies in the middle of a non-guarded page.

There is nothing which prevents compiler reordering though, as Jeff
notes.

> You can use accessors such as in_be32 and in_le32 in this situation,
> when you have a kernel virtual address that is already mapped to the
> device.

Do you think it would be worth to have lighterweight versions of
in_be32/in_le32 functions (without eieio and isync) ? Would avoid the
increase in code size and consequently cache footprint.

The IMMAP is referenced directly _all over_ the 8xx core code, must be
fixed.

> There are multiple reasons:
>
> * Easier reviewing.  One cannot easily distinguish between writing to
> normal kernel virtual memory and "magic" memory that produces magicaly
> side effects such as initiating DMA of a net packet.
> 
> * Compiler safety.  As the code is written now, you have no guarantees
> that the compiler won't combine two stores to the same location, etc.
> Accessor macros are a convenient place to add compiler barriers or
> 'volatile' notations that the MPC8xx code lacks.
>
> * Maintainable.  foo_read[bwl] or foo_read{8,16,32} are preferred
> because that's the way other bus accessors look like -- yes even
> embedded SoC buses benefit from these code patterns.  You want your
> driver to look like other drivers as much as possible.
>
> * Convenience.  The accessors can be a zero overhead memory read/write
> at a minimum.  But they can also be convenient places to use special
> memory read/write instructions that specify uncached memop, compiler
> barriers, memory barriers, etc.
