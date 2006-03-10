Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWCJEMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWCJEMW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 23:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWCJEMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 23:12:22 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:62342 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932107AbWCJEMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 23:12:21 -0500
Message-ID: <4410FC41.2020101@jp.fujitsu.com>
Date: Fri, 10 Mar 2006 13:10:41 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
References: <44070B62.3070608@jp.fujitsu.com> <20060302155056.GB28895@flint.arm.linux.org.uk> <20060302172436.GC22711@colo.lackof.org> <20060302193441.GG28895@flint.arm.linux.org.uk> <20060310021009.GA2506@neo.rr.com>
In-Reply-To: <20060310021009.GA2506@neo.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:
> On Thu, Mar 02, 2006 at 07:34:41PM +0000, Russell King wrote:
> 
>>On Thu, Mar 02, 2006 at 10:24:36AM -0700, Grant Grundler wrote:
>>
>>>On Thu, Mar 02, 2006 at 03:50:57PM +0000, Russell King wrote:
>>>
>>>>I've been wondering whether this "no_ioport" flag is the correct approach,
>>>>or whether it's adding to complexity when it isn't really required.
>>>
>>>I think it's the simplest solution to allowing a driver
>>>to indicate which resources it wants to use. It solves
>>>the problem of I/O Port resource allocation sufficiently
>>>well.
>>
>>I have another question (brought up by someone working on a series of
>>ARM machines which make heavy use of MMIO.)
>>
>>Why isn't pci_enable_device_bars() sufficient - why do we have to
>>have another interface to say "we don't want BARs XXX" ?
>>
>>Let's say that we have a device driver which does this sequence (with,
>>of course, error checking):
>>
>>	pci_enable_device_bars(dev, 1<<1);
>>	pci_request_regions(dev);
>>
>>(a) should PCI remember that only BAR 1 has been requested to be enabled,
>>    and as such shouldn't pci_request_regions() ignore BAR 0?
>>
>>(b) should the PCI driver pass into pci_request_regions() (or even
>>    pci_request_regions_bars()) a bitmask of the BARs it wants to have
>>    requested, and similarly for pci_release_regions().
>>
>>Basically, if BAR0 hasn't been enabled, has pci_request_regions() got
>>any business requesting it from the resource tree?
> 
> 
> I understand the point you're making, but I think this misrepresents what
> is actually happening.  From my understanding of the spec, it's not possible
> to disable individual bars (with the exception of the expansion ROM).  Rather
> there is one bit for IO enable and one bit for IOMMU enable.  Therefore, we
> can enable or disable all I/O ports, but there's really no in between.  If
> the device uses even one I/O port, it's still a huge loss because of the
> potential bridge window dependency.  Also, if a device has several I/O ports
> but the driver only wants to use one, all of the others must still be
> assigned.
> 

I see. I think you are right.

In addition to the fact that there is one bit for IO enable and one
bit for MMIO enable, I think we should not enable I/O port (or MMIO)
of the device if not all the I/O port (or MMIO) regions are assigned
to the device because we must build a consistent address mapping
before enabling it.

It seems that using pci_enable_device_bars() is not a good idea.
If there is no objection, I'll design and implement take6 again.

Any comments?

Thanks,
Kenji Kaneshige
