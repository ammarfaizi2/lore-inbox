Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWGLQ1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWGLQ1F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWGLQ1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:27:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:55991 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750988AbWGLQ1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:27:03 -0400
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>,
       Greg KH <greg@kroah.com>, Tom Long Nguyen <tom.l.nguyen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI-Express AER implemetation: AER core and aerdriver
References: <1152688203.28493.214.camel@ymzhang-perf.sh.intel.com>
	<1152688565.28493.218.camel@ymzhang-perf.sh.intel.com>
	<1152688926.28493.223.camel@ymzhang-perf.sh.intel.com>
	<1152689546.28493.232.camel@ymzhang-perf.sh.intel.com>
	<1152691570.28493.250.camel@ymzhang-perf.sh.intel.com>
From: Andi Kleen <ak@suse.de>
Date: 12 Jul 2006 18:26:56 +0200
In-Reply-To: <1152691570.28493.250.camel@ymzhang-perf.sh.intel.com>
Message-ID: <p73k66in60f.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zhang, Yanmin" <yanmin_zhang@linux.intel.com> writes:

> With Arjan's comments, I changed EXPORT_SYMBOL to EXPORT_SYMBOL_GPL.
> Sorry for flooding your emailbox again. :)

This means that non GPL drivers will reimplement these functions 
on their own (which is possible, just ugly) The fallout of them getting that wrong
might be significant.

I would change it back. _GPL should be only for core services, not
for generic driver interfaces.

> --- linux-2.6.17/drivers/pci/pcie/aer/aerdrv_core.c	1970-01-01 08:00:00.000000000 +0800
> +++ linux-2.6.17_aer/drivers/pci/pcie/aer/aerdrv_core.c	2006-07-12 15:47:38.000000000 +0800
> @@ -0,0 +1,737 @@
> +/*
> + * Copyright (C) 2006 Intel
> + *	Tom Long Nguyen (tom.l.nguyen@intel.com)
> + *	Zhang Yanmin (yanmin.zhang@intel.com)

Comment describing what the file does missing. At least one paragraph
of design rationale would be good 

> +
> +config PCIEAER
> +	tristate "Root Port Advanced Error Reporting support"
> +	depends on PCIEPORTBUS 
> +	default y
> +	help
> +	  This enables Root Port Advanced Error Reporting (AER) driver
> +	  support. Error reporting messages sent to Root Port will be
> +	  handled by PCI Express AER driver.

I hope it's clear from the context this is PCI-E specific?

> --- linux-2.6.17/drivers/pci/pcie/aer/Makefile	1970-01-01 08:00:00.000000000 +0800
> +++ linux-2.6.17_aer/drivers/pci/pcie/aer/Makefile	2006-06-22 16:46:29.000000000 +0800
> @@ -0,0 +1,10 @@
> +#
> +# Makefile for PCI-Express Root Port Advanced Error Reporting Driver
> +#
> +
> +obj-$(CONFIG_PCIEAER)		+= aerdriver.o
> +aerdrv_acpi-$(CONFIG_ACPI)	+= aerdrv_acpi.o
> +
> +aerdriver-objs		:= aerdrv_errprint.o aerdrv_core.o aerdrv.o
> +aerdriver-objs		+= $(aerdrv_acpi-y)
> +
> --- linux-2.6.17/drivers/pci/pcie/Kconfig	2006-06-22 16:26:43.000000000 +0800
> +++ linux-2.6.17_aer/drivers/pci/pcie/Kconfig	2006-06-22 16:46:29.000000000 +0800
> @@ -34,3 +34,4 @@ config HOTPLUG_PCI_PCIE_POLL_EVENT_MODE
>  	   
>  	  When in doubt, say N.
>  
> +source "drivers/pci/pcie/aer/Kconfig"
> --- linux-2.6.17/drivers/pci/pcie/Makefile	2006-06-22 16:26:43.000000000 +0800
> +++ linux-2.6.17_aer/drivers/pci/pcie/Makefile	2006-06-22 16:46:29.000000000 +0800
> @@ -5,3 +5,6 @@
>  pcieportdrv-y			:= portdrv_core.o portdrv_pci.o portdrv_bus.o
>  
>  obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
> +
> +# Build PCI Express AER if needed
> +obj-$(CONFIG_PCIEAER)		+= aer/
> --- linux-2.6.17/drivers/pci/pcie/aer/aerdrv_errprint.c	1970-01-01 08:00:00.000000000 +0800
> +++ linux-2.6.17_aer/drivers/pci/pcie/aer/aerdrv_errprint.c	2006-06-22 16:46:29.000000000 +0800
> @@ -0,0 +1,216 @@
> +/*
> + * Copyright (C) 2006 Intel
> + *	Tom Long Nguyen (tom.l.nguyen@intel.com)
> + *	Zhang Yanmin (yanmin.zhang@intel.com)
> + *

Comment what the code does missing.

At least one paragraph of design rationale would be good.

> +	"Unknown Error Bit 22  ",	/* Bit Position 22	*/
> +	"Unknown Error Bit 23  ", 	/* Bit Position 23	*/
> +	"Unknown Error Bit 24  ",	/* Bit Position 24	*/
> +	"Unknown Error Bit 25  ", 	/* Bit Position 25	*/
> +	"Unknown Error Bit 26  ", 	/* Bit Position 26 	*/
> +	"Unknown Error Bit 27  ",	/* Bit Position 27	*/
> +	"Unknown Error Bit 28  ",	/* Bit Position 28	*/
> +	"Unknown Error Bit 29  ", 	/* Bit Position 29	*/
> +	"Unknown Error Bit 30  ", 	/* Bit Position 30 	*/
> +	"Unknown Error Bit 31  "	/* Bit Position 31	*/

Make all the unknown error bits a NULL and use a sprintf in the 
decoder instead.

Similar for the following arrays.
> +void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> +{
> +	char * errmsg;
> +	int err_layer, agent;
> +
> +	printk(KERN_ERR "+------ PCI-Express Device Error ------+\n");
> +	printk(KERN_ERR "Error Severity\t\t: %s\n",
> +		aer_error_severity_string[info->severity]);
> +
> +	if ( info->status == 0) {
> +                printk(KERN_ERR "PCIE Bus Error type\t: (Unaccessible)\n");

KERN_ERR? THis means it will appear on consoles, won't it?
And surely not all these errors are fatal enough to need user attention
immediately and I bet there will be some devices who report these
errors unnecessarily. I would use a lower log level.

Also I would suggest you add something in the documentation
on what the messages mean exactly and how to decode them. I'm sure that will be a FAQ.

-Andi
