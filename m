Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUFSUXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUFSUXM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUFSUXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:23:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59399 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264658AbUFSUWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:22:52 -0400
Date: Sat, 19 Jun 2004 21:22:46 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Proposal for new generic device API: dma_get_required_mask()
Message-ID: <20040619212246.B8063@flint.arm.linux.org.uk>
Mail-Followup-To: Krzysztof Halasa <khc@pm.waw.pl>,
	James Bottomley <James.Bottomley@steeleye.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <1087481331.2210.27.camel@mulgrave> <m33c4tsnex.fsf@defiant.pm.waw.pl> <20040618102120.A29213@flint.arm.linux.org.uk> <m3brjg7994.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3brjg7994.fsf@defiant.pm.waw.pl>; from khc@pm.waw.pl on Sat, Jun 19, 2004 at 01:10:31AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 01:10:31AM +0200, Krzysztof Halasa wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> writes:
> > Good idea, except for the fact that we have drivers merged which have
> > real masks like 0x0fefffff.  It _really is_ a mask and not a number
> > of bits.
> 
> Which drivers do you mean? And which platforms support it?

The SA1111 device and associated sub-device drivers.  Basically, Intel
has a "no fix" errata where one of the address bits gets incorrectly
routed to the SDRAM "auto precharge" address bit.  This address bit
must be zero, otherwise the SDRAM accesses are messed up.

However, because SDRAM is accessed by "row" and "column" addresses,
the physical address bit which corresponds to the "auto precharge"
signal varies according to the size of SDRAM.

This is what the following table is about:

static u32 sa1111_dma_mask[] = {
        ~0,
        ~(1 << 20),
        ~(1 << 23),
        ~(1 << 24),
        ~(1 << 25),
        ~(1 << 20),
        ~(1 << 20),
        0,
};

for each setting of the SDRAM row/column address multiplexer, we have
to ensure that a certain DMA address bit is zero.  Note, however,
that the problem address bit does not correspond to the highest
addressable bit.  You may have a 32MB SDRAM but need to ensure that
physical bit 20 is always zero - IOW you can only DMA from even MB
addresses and not odd MB addresses.

Hence, this ends up with DMA masks such as the example in my previous
mail.

And yes, this chip is popular, in use, and this quirk is not difficult
to cleanly work around given our existing API.

Hence why changing from "dma mask" to "number of bits" breaks existing
drivers.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
