Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266633AbUHDDBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUHDDBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 23:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUHDDBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 23:01:03 -0400
Received: from fmr06.intel.com ([134.134.136.7]:34246 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266633AbUHDC7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:59:39 -0400
Subject: Re: [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
From: Len Brown <len.brown@intel.com>
To: Nathan Bryant <nbryant@optonline.net>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Shaohua Li <shaohua.li@intel.com>,
       Stefan =?ISO-8859-1?Q?D=F6singer?= <stefandoesinger@gmx.at>
In-Reply-To: <41103F22.4090303@optonline.net>
References: <41103F22.4090303@optonline.net>
Content-Type: text/plain
Organization: 
Message-Id: <1091588367.2297.49.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 Aug 2004 22:59:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well done Nathan!

On Tue, 2004-08-03 at 21:42, Nathan Bryant wrote:
> This patch should fix multiple user-visible problems with the ACPI IRQ
> routing after S3 resume:
> 
> "irq x: nobody cared"
> "my interrupts are gone"

I was under the (apparently false) impression that devices would
call eg. pci_enable_device() upon .resume, which would bubble down
to pcibios_enable_irq()/acpi_pci_irq_enable() which would handle this.

But not all do this this, and
for those that do, the link->irq.setonboot test in
acpi_pci_link_allocate would prevent the hardware from being
reprogrammed anyway -- so I guess I hadn't thought this path through.

And so I think we do need this patch for chipsets that clear
the IRQ routers upon suspend.  Indeed, it is likely that
we'd have this problem in S4 in addition to S3, yes?

> diff -Nru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> --- a/drivers/acpi/pci_link.c	2004-08-03 19:41:29 -04:00
> +++ b/drivers/acpi/pci_link.c	2004-08-03 19:41:29 -04:00
> @@ -29,6 +29,7 @@
>   *	   for IRQ management (e.g. start()->_SRS).
>   */
>  
> +#include <linux/sysdev.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -84,6 +85,8 @@
>  	struct acpi_pci_link_irq irq;
>  };
>  
> +static int acpi_pci_link_resume (struct acpi_pci_link *link);
> +

This declaration isn't necessary b/c the definition (below)
is above where the function is first used, yes?

>  static struct {
>  	int			count;
>  	struct list_head	entries;
> @@ -695,6 +698,42 @@
>  
> 
>  static int
> +acpi_pci_link_resume (
> +	struct acpi_pci_link	*link)
> +{
> +	ACPI_FUNCTION_TRACE("acpi_pci_link_resume");
> +	
> +	if (link->irq.active && link->irq.setonboot)

I think that before this change, irq.setonboot was a NOP
and a candidate for being deleted.  However, it does seem
to have a use here, where we want to re-program only those
links that were programmed.  ("setonboot" would probably
be better called "initialized" or "programmed").

Since irq.active is set for all links from probe time
whether or not we program them, it isn't sufficient,
as we've found from experience that it is a bad idea
to program links that are not explicitly requested
by actual devices -- so I agree we need setonboot here.

> +		return_VALUE(acpi_pci_link_set(link, link->irq.active));
> +	else
> +		return_VALUE(0);
> +}
> +
> +
> +static int
> +irqrouter_resume(
> +	struct sys_device *dev)
> +{
> +	struct list_head        *node = NULL;
> +	struct acpi_pci_link    *link = NULL;
> +
> +	ACPI_FUNCTION_TRACE("irqrouter_resume");
> +
> +	list_for_each(node, &acpi_link.entries) {
> +
> +		link = list_entry(node, struct acpi_pci_link, node);
> +		if (!link) {
> +			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
> +			continue;
> +		}
> +
> +		acpi_pci_link_resume(link);
> +	}
> +	return_VALUE(0);
> +}
> +
> +
> +static int
>  acpi_pci_link_remove (
>  	struct acpi_device	*device,
>  	int			type)
> @@ -786,11 +825,42 @@
>  __setup("acpi_irq_balance", acpi_irq_balance_set);
>  
> 
> +static struct sysdev_class irqrouter_sysdev_class = {
> +        set_kset_name("irqrouter"),
> +        .resume = irqrouter_resume,
> +};
> +
> +
> +static struct sys_device device_irqrouter = {
> +	.id     = 0,
> +	.cls    = &irqrouter_sysdev_class,
> +};
> +
> +
> +static int __init irqrouter_init_sysfs(void)
> +{
> +	int error;
> +
> +	ACPI_FUNCTION_TRACE("irqrouter_init_sysfs");
> +
> +	if (acpi_disabled || acpi_noirq)
> +		return_VALUE(0);
> +
> +        error = sysdev_class_register(&irqrouter_sysdev_class);
> +        if (!error)
> +        	error = sysdev_register(&device_irqrouter);
> +
> +        return_VALUE(error);
> +}                                        
> +
> +device_initcall(irqrouter_init_sysfs);
> +
> +
>  static int __init acpi_pci_link_init (void)
>  {
>  	ACPI_FUNCTION_TRACE("acpi_pci_link_init");
>  
> -	if (acpi_pci_disabled)
> +	if (acpi_disabled || acpi_noirq)

I think that testing acpi_noirq is sufficient here.

>  		return_VALUE(0);
>  
>  	acpi_link.count = 0;
> @@ -798,7 +868,7 @@
>  
>  	if (acpi_bus_register_driver(&acpi_pci_link_driver) < 0)
>  		return_VALUE(-ENODEV);
> -
> +		
>  	return_VALUE(0);
>  }
>  

