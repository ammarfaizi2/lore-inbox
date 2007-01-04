Return-Path: <linux-kernel-owner+w=401wt.eu-S965040AbXADRTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbXADRTw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbXADRTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:19:51 -0500
Received: from hera.kernel.org ([140.211.167.34]:42201 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965040AbXADRTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:19:50 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: John Keller <jpk@sgi.com>
Subject: Re: [PATCH 1/1] - Altix: ACPI _PRT support
Date: Thu, 4 Jan 2007 12:19:12 -0500
User-Agent: KMail/1.9.5
Cc: linux-acpi@vger.kernel.org, ayoung@agi.com, jes@sgi.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20061222175004.1603.74655.sendpatchset@attica.americas.sgi.com>
In-Reply-To: <20061222175004.1603.74655.sendpatchset@attica.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701041219.12225.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.

thanks,
-Len

On Friday 22 December 2006 12:50, John Keller wrote:
> Provide ACPI _PRT support for SN Altix systems.
> 
> The SN Altix platform does not conform to the 
> IOSAPIC IRQ routing model, so a new acpi_irq_model
> (ACPI_IRQ_MODEL_PLATFORM) has been defined. The SN
> platform specific code sets acpi_irq_model to
> this new value, and keys off of it in acpi_register_gsi()
> to avoid the iosapic code path.
> 
> Signed-off-by: John Keller <jpk@sgi.com>
> ---
> 
> To avoid future regression/backward compatibilty issues
> when _PRT support is added to our PROM, we'd like to
> see this pushed into 2.6.20, if at all possible.
> 
> 
>  arch/ia64/kernel/acpi.c            |    3 +++
>  arch/ia64/sn/kernel/io_acpi_init.c |    3 +++
>  drivers/acpi/bus.c                 |    3 +++
>  include/linux/acpi.h               |    1 +
>  4 files changed, 10 insertions(+)
> 
> 
> Index: linux/arch/ia64/kernel/acpi.c
> ===================================================================
> --- linux.orig/arch/ia64/kernel/acpi.c	2006-10-24 02:38:54.000000000 -0500
> +++ linux/arch/ia64/kernel/acpi.c	2006-12-22 10:54:36.930343639 -0600
> @@ -590,6 +590,9 @@ void __init acpi_numa_arch_fixup(void)
>   */
>  int acpi_register_gsi(u32 gsi, int triggering, int polarity)
>  {
> +	if (acpi_irq_model == ACPI_IRQ_MODEL_PLATFORM)
> +		return gsi;
> +
>  	if (has_8259 && gsi < 16)
>  		return isa_irq_to_vector(gsi);
>  
> Index: linux/arch/ia64/sn/kernel/io_acpi_init.c
> ===================================================================
> --- linux.orig/arch/ia64/sn/kernel/io_acpi_init.c	2006-12-21 00:51:59.000000000 -0600
> +++ linux/arch/ia64/sn/kernel/io_acpi_init.c	2006-12-22 10:53:45.504213484 -0600
> @@ -223,6 +223,9 @@ sn_io_acpi_init(void)
>  	u64 result;
>  	s64 status;
>  
> +	/* SN Altix does not follow the IOSAPIC IRQ routing model */
> +	acpi_irq_model = ACPI_IRQ_MODEL_PLATFORM;
> +
>  	acpi_bus_register_driver(&acpi_sn_hubdev_driver);
>  	status = sal_ioif_init(&result);
>  	if (status || result)
> Index: linux/drivers/acpi/bus.c
> ===================================================================
> --- linux.orig/drivers/acpi/bus.c	2006-08-28 20:40:10.000000000 -0500
> +++ linux/drivers/acpi/bus.c	2006-12-22 10:52:32.155474439 -0600
> @@ -561,6 +561,9 @@ static int __init acpi_bus_init_irq(void
>  	case ACPI_IRQ_MODEL_IOSAPIC:
>  		message = "IOSAPIC";
>  		break;
> +	case ACPI_IRQ_MODEL_PLATFORM:
> +		message = "platform specific model";
> +		break;
>  	default:
>  		printk(KERN_WARNING PREFIX "Unknown interrupt routing model\n");
>  		return -ENODEV;
> Index: linux/include/linux/acpi.h
> ===================================================================
> --- linux.orig/include/linux/acpi.h	2006-10-24 02:38:54.000000000 -0500
> +++ linux/include/linux/acpi.h	2006-12-22 10:52:53.337997675 -0600
> @@ -47,6 +47,7 @@ enum acpi_irq_model_id {
>  	ACPI_IRQ_MODEL_PIC = 0,
>  	ACPI_IRQ_MODEL_IOAPIC,
>  	ACPI_IRQ_MODEL_IOSAPIC,
> +	ACPI_IRQ_MODEL_PLATFORM,
>  	ACPI_IRQ_MODEL_COUNT
>  };
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
