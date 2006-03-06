Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWCFBj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWCFBj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 20:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWCFBj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 20:39:59 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:27080 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751506AbWCFBj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 20:39:58 -0500
Message-ID: <440B9290.7090104@jp.fujitsu.com>
Date: Mon, 06 Mar 2006 10:38:24 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
References: <44070B62.3070608@jp.fujitsu.com> <20060302155056.GB28895@flint.arm.linux.org.uk> <20060302172436.GC22711@colo.lackof.org> <20060302193441.GG28895@flint.arm.linux.org.uk> <4407B564.7000303@jp.fujitsu.com> <4407E936.3070606@jp.fujitsu.com>
In-Reply-To: <4407E936.3070606@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If there are no objections to the pci_enable_device_bars()
approach for PCI legacy ioport free drivers, I'd start to
reimplement the patches based on this approach.
Does anybody have any objections?

The summary of changes in this approach is as follows:

    - Add new field 'bars_enabled' into struct pci_dev to
      remember which BARs already enabled. This new field
      is initialized at pci_enable_device_bars() time and
      cleared pci_disable_device() time.

    - Change pci_request_regions()/pci_release_regions() to
      requests only the BARs which have already been enabled.

    - For converting drivers to legacy I/O port free, change
      drivers to use pci_enable_device_bars() instead of
      pci_enable_device() in order not to enable ioport regions.
      The helper routine to make proper BAR mask from the specified
      resource type would be very helpful (please see the sample
      patche attached in the previous e-mail below).

Thanks,
Kenji Kaneshige


Kenji Kaneshige wrote:
> Kenji Kaneshige wrote:
> 
>> Russell King wrote:
> 
> 
> (snip.)
> 
>>>
>>> (a) should PCI remember that only BAR 1 has been requested to be 
>>> enabled,
>>>     and as such shouldn't pci_request_regions() ignore BAR 0?
>>>
>>> (b) should the PCI driver pass into pci_request_regions() (or even
>>>     pci_request_regions_bars()) a bitmask of the BARs it wants to have
>>>     requested, and similarly for pci_release_regions().
>>>
>>> Basically, if BAR0 hasn't been enabled, has pci_request_regions() got
>>> any business requesting it from the resource tree?
>>>
>>
> 
> (snip.)
> 
>>
>> The (a) option doesn't have this kind of problem. But it looks a little
>> strange to me that we use pci_enable_device_bars() at probe time while
>> we use pci_enable_device() at resume time, though I might be too anxious.
>>
> 
> I noticed this is not a problem. All we need to do is just replacing
> pci_enable_device() with pci_enable_device_bars() in pci_default_resume().
> Sorry for the noise.
> 
> BTW, I'm attaching the sample patch which implements option (a), though
> I've not tested it at all. It looks good to me. How does it looks?
> 
> Thanks,
> Kenji Kaneshige
> 
> 
> ---
> drivers/pci/pci-driver.c |    3 ++-
> drivers/pci/pci.c        |   30 +++++++++++++++++++++++-------
> include/linux/pci.h      |   12 ++++++++++++
> 3 files changed, 37 insertions(+), 8 deletions(-)
> 
> Index: linux-2.6.16-rc5-mm1/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-2.6.16-rc5-mm1.orig/drivers/pci/pci-driver.c    2006-03-01 
> 13:56:04.000000000 +0900
> +++ linux-2.6.16-rc5-mm1/drivers/pci/pci-driver.c    2006-03-03 
> 14:39:57.000000000 +0900
> @@ -294,7 +294,8 @@
>     pci_restore_state(pci_dev);
>     /* if the device was enabled before suspend, reenable */
>     if (pci_dev->is_enabled)
> -        retval = pci_enable_device(pci_dev);
> +        retval = pci_enable_device_bars(pci_dev,
> +                        pci_dev->bars_enabled);
>     /* if the device was busmaster before the suspend, make it busmaster 
> again */
>     if (pci_dev->is_busmaster)
>         pci_set_master(pci_dev);
> Index: linux-2.6.16-rc5-mm1/drivers/pci/pci.c
> ===================================================================
> --- linux-2.6.16-rc5-mm1.orig/drivers/pci/pci.c    2006-03-01 
> 13:56:04.000000000 +0900
> +++ linux-2.6.16-rc5-mm1/drivers/pci/pci.c    2006-03-03 
> 15:46:12.000000000 +0900
> @@ -493,6 +493,9 @@
>     err = pcibios_enable_device(dev, bars);
>     if (err < 0)
>         return err;
> +    pci_fixup_device(pci_fixup_enable, dev);
> +    dev->is_enabled = 1;
> +    dev->bars_enabled = bars;
>     return 0;
> }
> 
> @@ -510,8 +513,6 @@
>     int err = pci_enable_device_bars(dev, (1 << PCI_NUM_RESOURCES) - 1);
>     if (err)
>         return err;
> -    pci_fixup_device(pci_fixup_enable, dev);
> -    dev->is_enabled = 1;
>     return 0;
> }
> 
> @@ -546,6 +547,7 @@
> 
>     pcibios_disable_device(dev);
>     dev->is_enabled = 0;
> +    dev->bars_enabled = 0;
> }
> 
> /**
> @@ -628,6 +630,12 @@
> {
>     if (pci_resource_len(pdev, bar) == 0)
>         return;
> +    if (pdev->bars_enabled & (1 << bar)) {
> +        dev_warn(&pdev->dev,
> +             "Trying to release region #%d that is not enabled\n",
> +             bar);
> +        return;
> +    }
>     if (pci_resource_flags(pdev, bar) & IORESOURCE_IO)
>         release_region(pci_resource_start(pdev, bar),
>                 pci_resource_len(pdev, bar));
> @@ -654,7 +662,12 @@
> {
>     if (pci_resource_len(pdev, bar) == 0)
>         return 0;
> -       
> +    if (pdev->bars_enabled & (1 << bar)) {
> +        dev_warn(&pdev->dev,
> +             "Trying to request region #%d that is not enabled\n",
> +             bar);
> +        goto err_out;
> +    }
>     if (pci_resource_flags(pdev, bar) & IORESOURCE_IO) {
>         if (!request_region(pci_resource_start(pdev, bar),
>                 pci_resource_len(pdev, bar), res_name))
> @@ -692,7 +705,8 @@
>     int i;
>     
>     for (i = 0; i < 6; i++)
> -        pci_release_region(pdev, i);
> +        if (pdev->bars_enabled & (1 << i))
> +            pci_release_region(pdev, i);
> }
> 
> /**
> @@ -713,13 +727,15 @@
>     int i;
>     
>     for (i = 0; i < 6; i++)
> -        if(pci_request_region(pdev, i, res_name))
> -            goto err_out;
> +        if (pdev->bars_enabled & (1 << i))
> +            if(pci_request_region(pdev, i, res_name))
> +                goto err_out;
>     return 0;
> 
> err_out:
>     while(--i >= 0)
> -        pci_release_region(pdev, i);
> +        if (pdev->bars_enabled & (1 << i))
> +            pci_release_region(pdev, i);
>        
>     return -EBUSY;
> }
> Index: linux-2.6.16-rc5-mm1/include/linux/pci.h
> ===================================================================
> --- linux-2.6.16-rc5-mm1.orig/include/linux/pci.h    2006-03-01 
> 13:56:06.000000000 +0900
> +++ linux-2.6.16-rc5-mm1/include/linux/pci.h    2006-03-03 
> 15:31:58.000000000 +0900
> @@ -169,6 +169,7 @@
>     struct bin_attribute *rom_attr; /* attribute descriptor for sysfs 
> ROM entry */
>     int rom_attr_enabled;        /* has display of the rom attribute 
> been enabled? */
>     struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file 
> for resources */
> +    int    bars_enabled;        /* BARs enabled */
> };
> 
> #define pci_dev_g(n) list_entry(n, struct pci_dev, global_list)
> @@ -732,6 +733,17 @@
> }
> #endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
> 
> +/*
> + * This helper routine makes bar mask from the type of resource.
> + */
> +static inline int pci_select_bars(struct pci_dev *dev, unsigned long 
> flags)
> +{
> +    int i, bars = 0;
> +    for (i = 0; i < PCI_NUM_RESOURCES; i++)
> +        if (pci_resource_flags(dev, i) & flags)
> +            bars |= (1 << i);
> +    return bars;
> +}
> 
> /*
>  *  The world is not perfect and supplies us with broken PCI devices.
> 

