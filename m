Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUAORU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 12:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265217AbUAORU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 12:20:27 -0500
Received: from fmr02.intel.com ([192.55.52.25]:25802 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S265213AbUAORUP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 12:20:15 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [patch] 2.6.1-mm3 acpi frees free irq0
Date: Thu, 15 Jan 2004 12:19:24 -0500
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC89CC@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] 2.6.1-mm3 acpi frees free irq0
Thread-Index: AcPbd+XOYKRzG7B3Th2qDyvuV6PN+gAE0kyQ
From: "Brown, Len" <len.brown@intel.com>
To: "Jes Sorensen" <jes@trained-monkey.org>, <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>,
       "Jesse Barnes" <jbarnes@sgi.com>
X-OriginalArrivalTime: 15 Jan 2004 17:19:26.0170 (UTC) FILETIME=[B9DCD3A0:01C3DB8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The primary failure is that the SCI was not found, and the secondary
symptom is that we failed to handle that error properly -- which you've
patched.

Can you tell me more about the primary failure?
Was the SCI found in other releases?

Thanks,
-Len

> -----Original Message-----
> From: Jes Sorensen [mailto:jes@trained-monkey.org] 
> Sent: Thursday, January 15, 2004 9:57 AM
> To: akpm@osdl.org
> Cc: linux-kernel@vger.kernel.org; 
> acpi-devel@lists.sourceforge.net; Brown, Len; Jesse Barnes
> Subject: [patch] 2.6.1-mm3 acpi frees free irq0
> 
> 
> Hi,
> 
> There is a bug in the ACPI code found in 2.6.1-mm3 where if it can't
> find the interrupt source for the ACPI System Control 
> Interrupt Handler,
> it end up trying to free irq 0.
> 
> Included patch fixes the problem.
> 
> Cheers,
> Jes
> 
> --- linux-2.6.1-mm3/drivers/acpi/osl.c~	Wed Jan 14 05:00:25 2004
> +++ linux-2.6.1-mm3/drivers/acpi/osl.c	Thu Jan 15 06:43:28 2004
> @@ -257,13 +257,13 @@
>  		return AE_OK;
>  	}
>  #endif
> -	acpi_irq_irq = irq;
>  	acpi_irq_handler = handler;
>  	acpi_irq_context = context;
>  	if (request_irq(irq, acpi_irq, SA_SHIRQ, "acpi", acpi_irq)) {
>  		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation 
> failed\n", irq);
>  		return AE_NOT_ACQUIRED;
>  	}
> +	acpi_irq_irq = irq;
>  
>  	return AE_OK;
>  }
> @@ -271,12 +271,13 @@
>  acpi_status
>  acpi_os_remove_interrupt_handler(u32 irq, OSD_HANDLER handler)
>  {
> -	if (acpi_irq_handler) {
> +	if (irq) {
>  #if defined(CONFIG_IA64) || defined(CONFIG_PCI_USE_VECTOR)
>  		irq = acpi_irq_to_vector(irq);
>  #endif
>  		free_irq(irq, acpi_irq);
>  		acpi_irq_handler = NULL;
> +		acpi_irq_irq = 0;
>  	}
>  
>  	return AE_OK;
> 
