Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUAIXQG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 18:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264508AbUAIXQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 18:16:06 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:28491 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264505AbUAIXQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 18:16:02 -0500
Date: Fri, 9 Jan 2004 15:15:46 -0800
To: Jeremy Higdon <jeremy@sgi.com>, Grant Grundler <grundler@parisc-linux.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       James.Bottomley@steeleye.com, Christoph Hellwig <hch@verein.lst.de>,
       ralf@oss.sgi.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040109231546.GA1359@sgi.com>
Mail-Followup-To: Jeremy Higdon <jeremy@sgi.com>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	James.Bottomley@steeleye.com, Christoph Hellwig <hch@verein.lst.de>,
	ralf@oss.sgi.com
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk> <20040107222142.GB14951@colo.lackof.org> <20040107230712.GB6837@sgi.com> <20040108063829.GC22317@colo.lackof.org> <20040108173655.GA11168@sgi.com> <20040108184406.GA29210@colo.lackof.org> <20040109071347.GB343099@sgi.com> <20040109195147.GA32690@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109195147.GA32690@sgi.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 11:51:47AM -0800, Jesse Barnes wrote:
> On Thu, Jan 08, 2004 at 11:13:47PM -0800, Jeremy Higdon wrote:
> > In theory, such a distinction would be useful for any platform that
> > uses separate paths for PIO read responses and DMA writes.  Perhaps
> > there is only one platform that has that feature?

Let me clarify this a bit more (and remember to Cc Ralf and Christoph
this time): there are two types of ordering we're worried about here,
DMA vs. other DMA ordering and DMA vs. PIO ordering.

Some platforms allow DMA buffers to arrive at their destination out of
order when a barrier bit is unset.  SGI machines using Bridge (or Bridge
variant like sn2 or Origin) chips are implemented this way, so if a DMA
transaction from a device to system memory doesn't have the barrier bit
set it's allowed to pass other non-barriered DMA.

PIOs are another matter.  SGI machines using the above chips enforce
_no_ ordering whatsoever between DMA and PIO traffic.  That is, a PIO
read response can 'pass' a DMA write (even a barriered one) and get to
the requesting CPU before the DMA is in the coherence domain.  So in
effect, all PIOs on SGI boxes are 'relaxed' by default.  For sn2, we've
implemented a special sn_dma_flush() function that we use following a
PIO read in our read() and in() routines so that the driver can be
assured that any DMA that it thinks is done actually is.  I'm not sure
this workaround is possible on Origin machines, so certain devices may
be open to data corruption depending on how they interact with the host
system.  Our next I/O chip will implement PIO vs. DMA ordering as a
seperate address space.

Given the above, a new read_relaxed() routine or an ioremap_relaxed()
routine seem like the best solution for us.  Neither is invasive at all
for current drivers (i.e. existing stuff will 'just work'), but it does
add complexity to the API.  Adding a pci_enable_relaxed() routine is a
completely seperate issue since it will be a noop on our platform (and
it probably silly to implement until we have real hardware that needs
it).

Anyway, thanks for your patience.  I probably made a mistake trying to
tie this proposal to the PCI-X spec since I'm only guessing at how such
hardware might behave...

Thanks,
Jesse
