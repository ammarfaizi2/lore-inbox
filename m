Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUAGXHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUAGXHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:07:20 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:12468 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262130AbUAGXHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:07:18 -0500
Date: Wed, 7 Jan 2004 15:07:12 -0800
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Matthew Wilcox <willy@debian.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, jeremy@sgi.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040107230712.GB6837@sgi.com>
Mail-Followup-To: Grant Grundler <grundler@parisc-linux.org>,
	Matthew Wilcox <willy@debian.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	jeremy@sgi.com
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk> <20040107222142.GB14951@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107222142.GB14951@colo.lackof.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 03:21:42PM -0700, Grant Grundler wrote:
> > How about always setting the bit in readb() and having a readb_ordered()
> > which doesn't set the bit in the transaction?
> 
> I was under the impression the driver can't control RO for
> each transaction though. The PCI-X device controls which
> transactions set RO "signal" in the PCI-X command on read-return.
> The Read-Return is a seperate transaction from the Read-Request.

My understanding is that you need both.  And if we used the
pci_enable_relaxed() routine, we'd have to add a check to readX() for it
so that we don't accidentally set the RO bit in the transaction when the
command word has it clear.

> If anyone has data that specific devices are "smart" and set/clear
> RO appropriately, it would be safe to enable RO for them.

I don't know of any that do it automatically...

> On HP ZX1, the "Allow Relaxed Ordering" is only implemented for outbound
> DMA/PIO Writes *while they pass through the ZX1 chip*. Ie RO bit settings
> don't explicitly apply since we aren't talking about PCI-X bus transactions
> even though the system chipset needs to honor PCI-X rules.

So this wouldn't be helpful for your chipset then.

> > That way, drivers which
> > call pci_set_relaxed() have the responsibility to verify they're not
> > relying on these semantics and use readb_ordered() in any places that
> > they are.
> 
> if new variants of readb() are ok, then yours sounds better.
> 
> But I wasn't too keen on introducing readb variants to solve what
> looks like a DMA flushing problem. I've come to the conclusion
> that systems which implement (and enable) RO for inbound DMA are
> effectively not coherent. The data the CPU expects to be visible is not.

Ahh... that's a bit of a stretch of the definition of non-coherence I
think, but it might be close enough to use the sync semantics.

> DMA-mapping.txt already has support (pci_dma_sync_xx() or
> pci_dma_unmap_xx()) to deal with common forms off non-coherence and
> syncronize caches for streaming mappings but not for consistent
> mappings.  DMA-ABI.txt (2.6 only) has a method to handle non-coherent

Right, that's another option--adding a pci_sync_consistent() call.

> systems and I have to reread/study it to see if the provided interface
> is sufficient for the case of relaxed ordering.  Jesse, have you
> looked at this already?

All of them are pretty easy enough to do...  so I see our options as one
of the following:

  1) add pcix_enable_relaxed() and read_relaxed() (read() would always be
     ordered)
  2) add pcix_enable_relaxed() and read_ordered() (read() would be
     relaxed after the pcix_enable_relaxed() call)
  3) add pcix_enable_relaxed() and pci_sync_consistent() (read() would
     be relaxed after the pcix_enable_relaxed() call)

Thanks,
Jesse
