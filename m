Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752008AbWCJCFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbWCJCFU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 21:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbWCJCFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 21:05:20 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:62394 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1752008AbWCJCFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 21:05:18 -0500
Date: Thu, 9 Mar 2006 21:10:10 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
Message-ID: <20060310021009.GA2506@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Grant Grundler <grundler@parisc-linux.org>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@atrey.karlin.mff.cuni.cz
References: <44070B62.3070608@jp.fujitsu.com> <20060302155056.GB28895@flint.arm.linux.org.uk> <20060302172436.GC22711@colo.lackof.org> <20060302193441.GG28895@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302193441.GG28895@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 07:34:41PM +0000, Russell King wrote:
> On Thu, Mar 02, 2006 at 10:24:36AM -0700, Grant Grundler wrote:
> > On Thu, Mar 02, 2006 at 03:50:57PM +0000, Russell King wrote:
> > > I've been wondering whether this "no_ioport" flag is the correct approach,
> > > or whether it's adding to complexity when it isn't really required.
> > 
> > I think it's the simplest solution to allowing a driver
> > to indicate which resources it wants to use. It solves
> > the problem of I/O Port resource allocation sufficiently
> > well.
> 
> I have another question (brought up by someone working on a series of
> ARM machines which make heavy use of MMIO.)
> 
> Why isn't pci_enable_device_bars() sufficient - why do we have to
> have another interface to say "we don't want BARs XXX" ?
> 
> Let's say that we have a device driver which does this sequence (with,
> of course, error checking):
> 
> 	pci_enable_device_bars(dev, 1<<1);
> 	pci_request_regions(dev);
> 
> (a) should PCI remember that only BAR 1 has been requested to be enabled,
>     and as such shouldn't pci_request_regions() ignore BAR 0?
> 
> (b) should the PCI driver pass into pci_request_regions() (or even
>     pci_request_regions_bars()) a bitmask of the BARs it wants to have
>     requested, and similarly for pci_release_regions().
> 
> Basically, if BAR0 hasn't been enabled, has pci_request_regions() got
> any business requesting it from the resource tree?

I understand the point you're making, but I think this misrepresents what
is actually happening.  From my understanding of the spec, it's not possible
to disable individual bars (with the exception of the expansion ROM).  Rather
there is one bit for IO enable and one bit for IOMMU enable.  Therefore, we
can enable or disable all I/O ports, but there's really no in between.  If
the device uses even one I/O port, it's still a huge loss because of the
potential bridge window dependency.  Also, if a device has several I/O ports
but the driver only wants to use one, all of the others must still be
assigned.

Thanks,
Adam
