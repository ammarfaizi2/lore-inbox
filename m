Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVAEROy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVAEROy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVAEROt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:14:49 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:38601 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261848AbVAERON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:14:13 -0500
Subject: Re: dmesg: PCI interrupts are no longer routed
	automatically.........
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-os@analogic.com
Cc: David Vrabel <dvrabel@cantab.net>, aryix <aryix@softhome.net>,
       lug-list@lugmen.org.ar, Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501050640430.12879@chaos.analogic.com>
References: <20041229095559.5ebfc4d4@sophia>
	 <1104862721.1846.49.camel@eeyore>
	 <Pine.LNX.4.61.0501041342070.5445@chaos.analogic.com>
	 <1104867678.1846.80.camel@eeyore>
	 <Pine.LNX.4.61.0501041447420.5310@chaos.analogic.com>
	 <41DBB5F6.6070801@cantab.net>
	 <Pine.LNX.4.61.0501050640430.12879@chaos.analogic.com>
Content-Type: text/plain
Date: Wed, 05 Jan 2005 10:13:56 -0700
Message-Id: <1104945236.4046.25.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-05 at 07:06 -0500, linux-os wrote:
> The temporary work-around is....
>  	pci_enable_device(pdev);
>  	save_irq = pdev->irq;
>  	pci_disable_device(pdev);	// Turn back off.
> 
>  	init_bars(....);
>  	request_irq(save_irq,...)	// Put ISR in place
> 
>  	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x08);
>  	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
>  	pci_set_dma_mask(pdev, 0x00000000ffffffffULL);
>  	pci_set_drvdata(pdev, NULL);
>  	pci_set_power_state(pdev, 0);
>  	pci_set_master(pdev);
>  	pci_set_mwi(pdev);
>  	pci_write_config_dword(pdev, PCI_COMMAND, PCI_CONFIG);
> 
>  	.... configure chip-specific stuff, clear interrupts, etc.
>  	pci_enable_device(dev);

So prior to 2.6.10, you did something like this?

	request_irq(pdev->irq, ...);
	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x08);
	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
	...
	pci_enable_device(pdev);

What sort of interrupts does the device generate before it's
enabled?  I can't find anything in the PCI spec that actually
prohibits interrupts before the driver starts up the device,
but it does seem strange.

You wouldn't want your ISR mucking around with a half-initialized
device, so does it have to check a "device_configured" flag
or something?


