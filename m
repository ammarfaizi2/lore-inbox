Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUAPDVD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 22:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbUAPDVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 22:21:03 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:24430 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265246AbUAPDU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 22:20:58 -0500
Date: Thu, 15 Jan 2004 19:19:14 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Grant Grundler <iod00d@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] readX_relaxed interface
Message-ID: <20040116031914.GE374259@sgi.com>
References: <20040115204913.GA8172@sgi.com> <20040115221640.GA11283@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115221640.GA11283@cup.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 02:16:40PM -0800, Grant Grundler wrote:
> On Thu, Jan 15, 2004 at 12:49:13PM -0800, Jesse Barnes wrote:
> > Based on the PIO ordering disucssion, I've come up with the following
> > patch.  It has the potential to help any platform that has seperate PIO
> > and DMA channels, and allows them to be reorderd wrt each other.
> 
> This is only significant for DMA writes (inbound) vs. PIO Read returns.

Correct.

> The ZX1 platforms have reordering enabled for outbound DMA (vs PIO
> writes) since last summer.

The SGI NUMA platforms do this also.  This is always safe, at least
in real life systems, I think (though someone will now undoubtedly
come up with an example where it isn't), as long as CPU updates to
memory made by the CPU prior to issuing the PIO are coherent by the
time the device sees the PIO.  If not, then you need some sort of
cache writeback, which is already provided for in APIs.

> Outside the context of PCI-X Relaxed Ordering, this violates PCI
> ordering rules. Any patches to drivers *using* the new readb()
> variants in effect work around this violation. I"m ok with that - just
> want it to be clear.

I would put it a different way.  We are currently conforming to
PCI ordering rules using a relatively expensive sw/hw workaround
in the SN versions of readX().
These readX_relaxed() variants allow us to speed up drivers in
cases where DMA write and PIO read ordering is unnecessary or
taken care of some other way (maybe a previous readX call).

So with this patch, we're providing a fast PIO read that violates
PCI ordering rules, to be used only when the ordering rules are
unnecessary.

Btw, in certain situations, this can cut what would be a 50us or
longer PIO read down to about 1us, which is why we're pushing this.

> PCI-X support will need a different interface
> (eg pcix_enable_relaxed_ordering()) to support
> it's form of "Relaxed Ordering".

Right.


Thanks for the reviews.

jeremy
