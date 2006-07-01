Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWGANGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWGANGr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 09:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWGANGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 09:06:46 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:59108 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751133AbWGANGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 09:06:46 -0400
Message-ID: <44A67346.5030705@myri.com>
Date: Sat, 01 Jul 2006 09:06:14 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Reuben Farrelly <reuben-lkml@reub.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.17-mm5
References: <20060701033524.3c478698.akpm@osdl.org>	<44A657B8.7040702@reub.net> <20060701045100.88c4eadc.akpm@osdl.org> <44A66B17.50008@reub.net>
In-Reply-To: <44A66B17.50008@reub.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly wrote:
>>
>> It oopsed here:
>>
>> static
>> int pci_msi_supported(struct pci_dev * dev)
>> {
>>     struct pci_dev *pdev;
>>
>>     if (!pci_msi_enable || !dev || dev->no_msi)
>>         return -1;
>>
>>     /* find root complex for our device */
>>     pdev = dev;
>>     while (pdev->bus && pdev->bus->self)
>>         pdev = pdev->bus->self;
>>
>>     /* check its bus flags */
>>     if (pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
>>         return -1;
>>
>>     return 0;
>> }
>>
>> pdev->subordinate is NULL.
>>
>
>> You may find that this gets things going again:
>>
>> --- a/drivers/pci/msi.c~a
>> +++ a/drivers/pci/msi.c
>> @@ -913,6 +913,9 @@ int pci_msi_supported(struct pci_dev * d
>>      while (pdev->bus && pdev->bus->self)
>>          pdev = pdev->bus->self;
>>  
>> +    if (!pdev->subordinate)
>> +        return -1;
>> +
>>      /* check its bus flags */
>>      if (pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
>>          return -1;
>> _
> Yes it does.

I was not expecting a root chipset without subordinate bus... Maybe we
should store the NO_MSI flags in the device itself instead of in its
subordinate bus (I would have to rework all my patches then). After all,
we don't inherit bus flags anymore, and I don't see why bus flags would
have been chosen initially except to help flags inheritance.
I am still convinced that checking to root chipset (bus) flags only is a
good idea since the root chipset is where MSI are translated from PCI
messages into DMA (we don't care about MSI support in the bridges
between the chipset and the devices since they only forward PCI messages).

Brice

