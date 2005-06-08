Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVFHFwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVFHFwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 01:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVFHFwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 01:52:23 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:35212 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262110AbVFHFwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 01:52:17 -0400
Date: Tue, 7 Jun 2005 22:52:10 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][4/5] RapidIO support: ppc32
Message-ID: <20050607225210.A28898@cox.net>
References: <11180976151080@foobar.com> <3648449bcd3a154bcf9b92930f74f3d9@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3648449bcd3a154bcf9b92930f74f3d9@freescale.com>; from kumar.gala@freescale.com on Tue, Jun 07, 2005 at 11:43:26PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 11:43:26PM -0500, Kumar Gala wrote:
> Two questions:
> 1. how well does will all of this handle > 32-bit phys addr?

It does and it doesn't handle > 32-bit phys addr. It depends on which
configuration you are talking about.  If you are talking about I/O
>32-bit, it's no problem.  If you are talking about handling DMA >32-bit,
then we need to handle a 64-bit DMA addr in the ppc32 implementations and
also extend the arch messaging interface to let callers know when an
implementation can handle high DMA (system memory >4GB). This is all
pretty easy to handle once we need to support such a processor. So
far, nothing is available publicly. :)

For RIO MMIO purposes (which is functionality I'm working on now),
it has the similar issues that PCI memory space has on processors with
I/O above 4GB.  However, on RIO our resources hold a bus address since
a physical address doesn't make sense since address spaces our per-device.
If we ever support a 66-bit address space device on 32-bit processor, we
might need a u64 resource.

> 2. can we make any of this a platform driver?

Hrm, so you would rather see RIO host bridges look like a driver
on another "bus"?  I have seen them as a component just like PCI
host bridges.  That is, they are instantiated by arch-code and
then initialized by a subsys initcall. This does mean that we
will be enumerating much later (during driver initcalls), but
it might be a better model if we ever see a rumored PCIE->RIO
bridge. Supporting that as a RIO master port would require driver
time init of the RIO fabric. There's some ordering issues that we'd
have to see about working out. None of this is needed right now,
though.
 
> I would prefer if we could have the memory offsets and irq's not be 
> straight from the #define's

I think this and #2 are separate issues. We can pass the mpc85xx
rio init code some parameters to abstract things to different
parts. This is similar to how we init different SoC's PCI host
bridges with some common code on PPC32 (marvell, 85xx, etc). 

I was just looking at doing this to support RIO on the 8548. At
the time I wrote this 85xx support there wasn't any info on the
8548 available, but it's an easy thing to extend.

-Matt
