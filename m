Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265623AbUAGWVq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 17:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265647AbUAGWVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 17:21:46 -0500
Received: from colo.lackof.org ([198.49.126.79]:15757 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S265623AbUAGWVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 17:21:44 -0500
Date: Wed, 7 Jan 2004 15:21:42 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Jesse Barnes <jbarnes@sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, jeremy@sgi.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040107222142.GB14951@colo.lackof.org>
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 07:02:06PM +0000, Matthew Wilcox wrote:
> So we want a pci_set_relaxed() macro / function() to set this bit
> (otherwise dozens of drivers will start to try to set the bit themselves,
> badly).  If this bit *isn't* set, setting the bit in the transaction will have
> no effect, right?

I think that's correct if the platform chipset ignores RO signal
by default. I'm not real comfortable with that assumption though.
I want the driver to advertise to PCI services the intent to use
RO capability.

> How about always setting the bit in readb() and having a readb_ordered()
> which doesn't set the bit in the transaction?

I was under the impression the driver can't control RO for
each transaction though. The PCI-X device controls which
transactions set RO "signal" in the PCI-X command on read-return.
The Read-Return is a seperate transaction from the Read-Request.

If anyone has data that specific devices are "smart" and set/clear
RO appropriately, it would be safe to enable RO for them.

On HP ZX1, the "Allow Relaxed Ordering" is only implemented for outbound
DMA/PIO Writes *while they pass through the ZX1 chip*. Ie RO bit settings
don't explicitly apply since we aren't talking about PCI-X bus transactions
even though the system chipset needs to honor PCI-X rules.

> That way, drivers which
> call pci_set_relaxed() have the responsibility to verify they're not
> relying on these semantics and use readb_ordered() in any places that
> they are.

if new variants of readb() are ok, then yours sounds better.

But I wasn't too keen on introducing readb variants to solve what
looks like a DMA flushing problem. I've come to the conclusion
that systems which implement (and enable) RO for inbound DMA are
effectively not coherent. The data the CPU expects to be visible is not.

DMA-mapping.txt already has support (pci_dma_sync_xx() or pci_dma_unmap_xx())
to deal with common forms off non-coherence and syncronize caches
for streaming mappings but not for consistent mappings.
DMA-ABI.txt (2.6 only) has a method to handle non-coherent systems and
I have to reread/study it to see if the provided interface is sufficient
for the case of relaxed ordering.  Jesse, have you looked at this already?

hth,
grant

> No doubt you're going to smack this idea down by telling me what SN2
> firmware currently does ...
> 
> -- 
> "Next the statesmen will invent cheap lies, putting the blame upon 
> the nation that is attacked, and every man will be glad of those
> conscience-soothing falsities, and will diligently study them, and refuse
> to examine any refutations of them; and thus he will by and by convince 
> himself that the war is just, and will thank God for the better sleep 
> he enjoys after this process of grotesque self-deception." -- Mark Twain
