Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbUAZUcO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 15:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUAZUcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 15:32:14 -0500
Received: from fmr04.intel.com ([143.183.121.6]:34966 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S264604AbUAZUcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 15:32:12 -0500
Subject: Re: [patch] 2.6.1-mm3 acpi frees free irq0
From: Len Brown <len.brown@intel.com>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <16390.43574.867869.286685@gargle.gargle.HOWL>
References: <16390.43574.867869.286685@gargle.gargle.HOWL>
Content-Type: text/plain
Organization: 
Message-Id: <1075149023.2484.4.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Jan 2004 15:30:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Accepted.

thanks,
-Len

On Thu, 2004-01-15 at 09:56, Jes Sorensen wrote:
> Hi,
> 
> There is a bug in the ACPI code found in 2.6.1-mm3 where if it can't
> find the interrupt source for the ACPI System Control Interrupt Handler,
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
>  		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation failed\n", irq);
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

