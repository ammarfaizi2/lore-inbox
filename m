Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752162AbWCJHt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbWCJHt2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 02:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbWCJHt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 02:49:28 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14857 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752162AbWCJHt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 02:49:28 -0500
Date: Fri, 10 Mar 2006 07:49:05 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Adam Belay <ambx1@neo.rr.com>, Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
Message-ID: <20060310074905.GA23474@flint.arm.linux.org.uk>
Mail-Followup-To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Adam Belay <ambx1@neo.rr.com>,
	Grant Grundler <grundler@parisc-linux.org>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@atrey.karlin.mff.cuni.cz
References: <44070B62.3070608@jp.fujitsu.com> <20060302155056.GB28895@flint.arm.linux.org.uk> <20060302172436.GC22711@colo.lackof.org> <20060302193441.GG28895@flint.arm.linux.org.uk> <20060310021009.GA2506@neo.rr.com> <4410FC41.2020101@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4410FC41.2020101@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 01:10:41PM +0900, Kenji Kaneshige wrote:
> Adam Belay wrote:
> >On Thu, Mar 02, 2006 at 07:34:41PM +0000, Russell King wrote:
> >>Why isn't pci_enable_device_bars() sufficient - why do we have to
> >>have another interface to say "we don't want BARs XXX" ?
> >>
> >>Let's say that we have a device driver which does this sequence (with,
> >>of course, error checking):
> >>
> >>	pci_enable_device_bars(dev, 1<<1);
> >>	pci_request_regions(dev);
> >>
> >>(a) should PCI remember that only BAR 1 has been requested to be enabled,
> >>   and as such shouldn't pci_request_regions() ignore BAR 0?
> >>
> >>(b) should the PCI driver pass into pci_request_regions() (or even
> >>   pci_request_regions_bars()) a bitmask of the BARs it wants to have
> >>   requested, and similarly for pci_release_regions().
> >>
> >>Basically, if BAR0 hasn't been enabled, has pci_request_regions() got
> >>any business requesting it from the resource tree?
> >
> >
> >I understand the point you're making, but I think this misrepresents what
> >is actually happening.  From my understanding of the spec, it's not 
> >possible
> >to disable individual bars (with the exception of the expansion ROM).  
> >Rather
> >there is one bit for IO enable and one bit for IOMMU enable.  Therefore, we
> >can enable or disable all I/O ports, but there's really no in between.  If
> >the device uses even one I/O port, it's still a huge loss because of the
> >potential bridge window dependency.  Also, if a device has several I/O 
> >ports
> >but the driver only wants to use one, all of the others must still be
> >assigned.
> >
> 
> I see. I think you are right.
> 
> In addition to the fact that there is one bit for IO enable and one
> bit for MMIO enable, I think we should not enable I/O port (or MMIO)
> of the device if not all the I/O port (or MMIO) regions are assigned
> to the device because we must build a consistent address mapping
> before enabling it.
> 
> It seems that using pci_enable_device_bars() is not a good idea.
> If there is no objection, I'll design and implement take6 again.

TBH, I don't think that your original approach is any better.  Maybe
Adam has a better idea how to solve this problem?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
