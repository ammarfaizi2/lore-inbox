Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVJQHz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVJQHz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 03:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVJQHz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 03:55:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28586 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932152AbVJQHz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 03:55:57 -0400
Date: Mon, 17 Oct 2005 00:55:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: stefanr@s5r6.in-berlin.de, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
Message-Id: <20051017005515.755decb6.akpm@osdl.org>
In-Reply-To: <20051015202944.GA10463@plato.virtuousgeek.org>
References: <20051015185502.GA9940@plato.virtuousgeek.org>
	<43515ADA.6050102@s5r6.in-berlin.de>
	<20051015202944.GA10463@plato.virtuousgeek.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
>
> diff -X linux-2.6.14-rc2/Documentation/dontdiff -Naur linux-2.6.14-rc2.orig/drivers/ieee1394/ohci1394.c linux-2.6.14-rc2/drivers/ieee1394/ohci1394.c
> --- linux-2.6.14-rc2.orig/drivers/ieee1394/ohci1394.c	2005-09-19 20:00:41.000000000 -0700
> +++ linux-2.6.14-rc2/drivers/ieee1394/ohci1394.c	2005-10-15 12:55:08.000000000 -0700
> @@ -169,6 +169,10 @@
>  module_param(phys_dma, int, 0644);
>  MODULE_PARM_DESC(phys_dma, "Enable physical dma (default = 1).");
>  
> +static int toshiba __initdata = 0;
> +module_param(toshiba, bool, 0);
> +MODULE_PARM_DESC(toshiba, "Toshiba Legacy-Free BIOS workaround (default=0).");
> +
>  static void dma_trm_tasklet(unsigned long data);
>  static void dma_trm_reset(struct dma_trm_ctx *d);
>  
> @@ -3222,14 +3226,28 @@
>  	struct hpsb_host *host;
>  	struct ti_ohci *ohci;	/* shortcut to currently handled device */
>  	unsigned long ohci_base;
> +	u16  toshiba_data;
>  
>  	if (version_printed++ == 0)
>  		PRINT_G(KERN_INFO, "%s", version);
>  
> +	if (toshiba) {
> +		dev->current_state = 4;
> +		pci_read_config_word(dev, PCI_CACHE_LINE_SIZE, &toshiba_data);
> +	}
> +
>          if (pci_enable_device(dev))
>  		FAIL(-ENXIO, "Failed to enable OHCI hardware");
>          pci_set_master(dev);
>  
> +	if (toshiba) {
> +		mdelay(10);
> +		pci_write_config_word(dev, PCI_CACHE_LINE_SIZE, toshiba_data);
> +		pci_write_config_word(dev, PCI_INTERRUPT_LINE, dev->irq);
> +		pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, pci_resource_start(dev, 0));
> +		pci_write_config_dword(dev, PCI_BASE_ADDRESS_1, pci_resource_start(dev, 1));
> + 	}
> +
>  	host = hpsb_alloc_host(&ohci1394_driver, sizeof(struct ti_ohci), &dev->dev);
>  	if (!host) FAIL(-ENOMEM, "Failed to allocate host structure");

It would be really really preferable if we could find some automatic way of
doing this.  Is it possible to use DMI matching, like
arch/i386/kernel/acpi/sleep.c:acpisleep_dmi_table ?

