Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265739AbTIFBZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265762AbTIFBZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:25:39 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:44227 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S265739AbTIFBZX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:25:23 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 2.4.23-pre3 ACPI fixes series (2/3)
Date: Fri, 5 Sep 2003 21:25:17 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FD1D@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.4.23-pre3 ACPI fixes series (2/3)
Thread-Index: AcN0DZvJ4GTl8vW8SQ69tLHJ8jispgAB7h3Q
From: "Brown, Len" <len.brown@intel.com>
To: "Andrew de Quincey" <adq_dvb@lidskialf.net>,
       "Jeff Garzik" <jgarzik@pobox.com>
Cc: <torvalds@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>, "linux-acpi" <linux-acpi@intel.com>
X-OriginalArrivalTime: 06 Sep 2003 01:25:18.0616 (UTC) FILETIME=[BB8C1180:01C37415]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew,

I pulled this one into the acpi patch when I got back from vacation
earlier this week.  Should be tested with the rest for a few days and if
all goes well pushed mid next week.

Cheers,
-Len

> -----Original Message-----
> From: Andrew de Quincey [mailto:adq_dvb@lidskialf.net] 
> Sent: Friday, September 05, 2003 8:16 PM
> To: Jeff Garzik
> Cc: torvalds@osdl.org; lkml; 
> acpi-devel@lists.sourceforge.net; linux-acpi
> Subject: [PATCH] 2.4.23-pre3 ACPI fixes series (2/3)
> 
> 
> This patch retries IRQ programming with an extended IRQ 
> resource descriptor
> if using a standard IRQ descriptor fails.
> 
> 
> --- linux-2.4.23-pre3.picmode/drivers/acpi/pci_link.c	
> 2003-09-05 23:54:45.522947816 +0100
> +++ linux-2.4.23-pre3.extirq/drivers/acpi/pci_link.c	
> 2003-09-05 23:54:59.945755216 +0100
> @@ -290,7 +290,8 @@
>  	struct acpi_buffer	buffer = {sizeof(resource)+1, 
> &resource};
>  	int			i = 0;
>  	int			valid = 0;
> -
> +	int			resource_type = 0;
> +   
>  	ACPI_FUNCTION_TRACE("acpi_pci_link_set");
>  
>  	if (!link || !irq)
> @@ -312,13 +313,24 @@
>  			return_VALUE(-EINVAL);
>  		}
>  	}
> + 
> +	/* If IRQ<=15, first try with a "normal" IRQ 
> descriptor. If that fails, try with
> +	 * an extended one */
> +	if (irq <= 15) {
> +		resource_type = ACPI_RSTYPE_IRQ;
> +	} else {
> +		resource_type = ACPI_RSTYPE_EXT_IRQ;
> +	}
> +
> +retry_programming:
>     
>  	memset(&resource, 0, sizeof(resource));
>  
>  	/* NOTE: PCI interrupts are always level / active_low / 
> shared. But not all
>  	   interrupts > 15 are PCI interrupts. Rely on the ACPI 
> IRQ definition for 
>  	   parameters */
> -	if (irq <= 15) {	
> +	switch(resource_type) {
> +	case ACPI_RSTYPE_IRQ:
>  		resource.res.id = ACPI_RSTYPE_IRQ;
>  		resource.res.length = sizeof(struct acpi_resource);
>  		resource.res.data.irq.edge_level = link->irq.edge_level;
> @@ -326,8 +338,9 @@
>  		resource.res.data.irq.shared_exclusive = ACPI_SHARED;
>  		resource.res.data.irq.number_of_interrupts = 1;
>  		resource.res.data.irq.interrupts[0] = irq;
> -	}
> -	else {
> +		break;
> +	 
> +	case ACPI_RSTYPE_EXT_IRQ:
>  		resource.res.id = ACPI_RSTYPE_EXT_IRQ;
>  		resource.res.length = sizeof(struct acpi_resource);
>  		
> resource.res.data.extended_irq.producer_consumer = ACPI_CONSUMER;
> @@ -337,11 +350,21 @@
>  		resource.res.data.extended_irq.number_of_interrupts = 1;
>  		resource.res.data.extended_irq.interrupts[0] = irq;
>  		/* ignore resource_source, it's optional */
> +		break;
>  	}
>  	resource.end.id = ACPI_RSTYPE_END_TAG;
>  
>  	/* Attempt to set the resource */
>  	status = acpi_set_current_resources(link->handle, &buffer);
> +   
> +	/* if we failed and IRQ <= 15, try again with an 
> extended descriptor */
> +	if (ACPI_FAILURE(status) && (resource_type == 
> ACPI_RSTYPE_IRQ)) {
> +                resource_type = ACPI_RSTYPE_EXT_IRQ;
> +                printk(PREFIX "Retrying with extended IRQ 
> descriptor\n");
> +                goto retry_programming;
> +	}
> +
> +	/* check for total failure */
>  	if (ACPI_FAILURE(status)) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error 
> evaluating _SRS\n"));
>  		return_VALUE(-ENODEV);
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
