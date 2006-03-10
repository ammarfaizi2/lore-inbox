Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752154AbWCJVaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbWCJVaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 16:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWCJVaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 16:30:10 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:4223 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1752154AbWCJVaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 16:30:08 -0500
In-Reply-To: <20060310130416.04ecb543.rdunlap@xenotime.net>
References: <Pine.LNX.4.44.0603100906020.29294-100000@gate.crashing.org> <20060310130416.04ecb543.rdunlap@xenotime.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <85D0E388-6E9A-4DCF-BA33-72B982782FAD@kernel.crashing.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] PCI: Add pci_assign_resource_fixed -- allow fixed address assignments
Date: Fri, 10 Mar 2006 15:30:27 -0600
To: "Randy.Dunlap" <rdunlap@xenotime.net>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 10, 2006, at 3:04 PM, Randy.Dunlap wrote:

> On Fri, 10 Mar 2006 09:06:32 -0600 (CST) Kumar Gala wrote:
>
>> On some embedded systems the PCI address for hotplug devices are  
>> not only
>> known a priori but are required to be at a given PCI address for  
>> other
>> master in the system to be able to access.
>>
>> An example of such a system would be an FPGA which is setup from  
>> user space
>> after the system has booted.  The FPGA may be access by DSPs in  
>> the system
>> and those DSPs expect the FPGA at a fixed PCI address.
>>
>> Added pci_assign_resource_fixed() as a way to allow assignment of  
>> the PCI
>> devices's BARs at fixed PCI addresses.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>>
>> ---
>> commit 45d4a23317c459865ec740c80b6e2a2ad9f53fd3
>> tree 432b5e41ef5f231dd57eb1a98f103239c62d63a0
>> parent 8176dee014ec6ad1039b8c0075c9c1d02147c2c8
>> author Kumar Gala <galak@kernel.crashing.org> Thu, 09 Mar 2006  
>> 12:34:25 -0600
>> committer Kumar Gala <galak@kernel.crashing.org> Thu, 09 Mar 2006  
>> 12:34:25 -0600
>>
>>  drivers/pci/pci.c       |    1 +
>>  drivers/pci/setup-res.c |   35 +++++++++++++++++++++++++++++++++++
>>  include/linux/pci.h     |    1 +
>>  3 files changed, 37 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index d2d1879..2557e86 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -935,6 +935,7 @@ EXPORT_SYMBOL_GPL(pci_intx);
>>  EXPORT_SYMBOL(pci_set_dma_mask);
>>  EXPORT_SYMBOL(pci_set_consistent_dma_mask);
>>  EXPORT_SYMBOL(pci_assign_resource);
>> +EXPORT_SYMBOL(pci_assign_resource_fixed);
>>  EXPORT_SYMBOL(pci_find_parent_resource);
>>
>>  EXPORT_SYMBOL(pci_set_power_state);
>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>> index ea9277b..f485958 100644
>> --- a/drivers/pci/setup-res.c
>> +++ b/drivers/pci/setup-res.c
>> @@ -155,6 +155,41 @@ int pci_assign_resource(struct pci_dev *
>>  	return ret;
>>  }
>>
>> +int pci_assign_resource_fixed(struct pci_dev *dev, int resno)
>> +{
>> +	struct pci_bus *bus = dev->bus;
>> +	struct resource *res = dev->resource + resno;
>> +	unsigned int type_mask;
>> +	int i, ret = -EBUSY;
>> +
>> +	type_mask = IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH;
>
> If type_mask must match (as in comment below), should it be a
> parameter instead of hard-coded here?  Does this match your FPGA
> resource?  It may not match my <hypothetical> resource.

I was trying to ensure an exact match between the bus and device  
resource types.  I figured if you were calling this API you should be  
able to ensure that the resource types match exactly.

>> +	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
>> +		struct resource *r = bus->resource[i];
>> +		if (!r)
>> +			continue;
>> +
>> +		/* type_mask must match */
>> +		if ((res->flags ^ r->flags) & type_mask)
>> +			continue;
>> +
>> +		ret = request_resource(r, res);
>> +
>> +		if (ret == 0)
>> +			break;
>> +	}
>> +
>> +	if (ret) {
>> +		printk(KERN_ERR "PCI: Failed to allocate %s resource #%d:%lx@% 
>> lx for %s\n",
>> +		       res->flags & IORESOURCE_IO ? "I/O" : "mem",
>> +		       resno, res->end - res->start + 1, res->start, pci_name 
>> (dev));
>> +	} else if (resno < PCI_BRIDGE_RESOURCES) {
>> +		pci_update_resource(dev, res, resno);
>> +	}
>
> braces not needed.

Fair, need to go find where I stole this from and possibly fix extra  
braces there as well.

>
>> +
>> +	return ret;
>> +}
>> +
>
>
> ---
> ~Randy
> Please use an email client that implements proper (compliant)  
> threading.
> (You know who you are.)

