Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbTIFB1j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTIFB1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:27:39 -0400
Received: from fmr09.intel.com ([192.52.57.35]:51695 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S263158AbTIFB1e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:27:34 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 2.4.23-pre3 ACPI fixes series (3/3)
Date: Fri, 5 Sep 2003 21:27:27 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FD1E@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.4.23-pre3 ACPI fixes series (3/3)
Thread-Index: AcN0DeAJmMIScmD2Txm7JTyCRt10nQAB+o+w
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew de Quincey" <adq_dvb@lidskialf.net>,
       "Jeff Garzik" <jgarzik@pobox.com>
Cc: <torvalds@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>, "linux-acpi" <linux-acpi@intel.com>
X-OriginalArrivalTime: 06 Sep 2003 01:27:29.0553 (UTC) FILETIME=[09977810:01C37416]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This also was pulled into the acpi patch earlier this week -- sorry I
didn't mention it to you earlier -- e-mail list latency has been
horrible lately.

Thanks,
-Len

> -----Original Message-----
> From: Andrew de Quincey [mailto:adq_dvb@lidskialf.net] 
> Sent: Friday, September 05, 2003 8:16 PM
> To: Jeff Garzik
> Cc: torvalds@osdl.org; lkml; 
> acpi-devel@lists.sourceforge.net; linux-acpi
> Subject: [PATCH] 2.4.23-pre3 ACPI fixes series (3/3)
> 
> 
> This patch is actually a patch by "Jun Nakajima" 
> <jun.nakajima@intel.com>
> When setting an IRQ link device, it checks if the value 
> returned by _CRS is 0. 
> If so, it assumes everything went OK. This fixes problems on 
> MANY VIA bioses.
> It seems to be a standard-ish way of saying "the _CRS IRQ 
> setting cannot be read".
> 
> 
> --- linux-2.4.23-pre3.extirq/drivers/acpi/pci_link.c	
> 2003-09-05 23:54:59.945755216 +0100
> +++ linux-2.4.23-pre3.null_crs/drivers/acpi/pci_link.c	
> 2003-09-05 23:57:39.782456344 +0100
> @@ -277,6 +277,32 @@
>  
>  
>  static int
> +acpi_pci_link_try_get_current (
> +	struct acpi_pci_link *link,
> +	int irq)
> +{
> +	int result;
> +
> +	ACPI_FUNCTION_TRACE("acpi_pci_link_try_get_current");
> +   
> +	result = acpi_pci_link_get_current(link);
> +	if (result && link->irq.active) 
> +	{
> +		return_VALUE(result);
> +	}
> +
> +	if (!link->irq.active) 
> +	{
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "No active IRQ 
> resource found\n"));
> +		printk(KERN_WARNING "_CRS returns NULL! Using 
> IRQ %d for device (%s [%s]).\n", irq, 
> acpi_device_name(link->device), acpi_device_bid(link->device));
> +		link->irq.active = irq;
> +	}
> +   
> +	return 0;
> +}
> +
> +
> +static int
>  acpi_pci_link_set (
>  	struct acpi_pci_link	*link,
>  	int			irq)
> @@ -382,7 +408,7 @@
>  	}
>  
>  	/* Make sure the active IRQ is the one we requested. */
> -	result = acpi_pci_link_get_current(link);
> +	result = acpi_pci_link_try_get_current(link, irq);
>  	if (result) {
>  		return_VALUE(result);
>  	}
> @@ -600,10 +626,6 @@
>  		else
>  			printk(" %d", link->irq.possible[i]);
>  	}
> -	if (!link->irq.active)
> -		printk(", disabled");
> -	else if (!found)
> -		printk(", enabled at IRQ %d", link->irq.active);
>  	printk(")\n");
>  
>  	/* TBD: Acquire/release lock */
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
