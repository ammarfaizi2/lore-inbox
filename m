Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWGFP3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWGFP3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWGFP3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:29:12 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:26845 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030341AbWGFP3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:29:09 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: ACPIPNP and too large IO resources
Date: Thu, 6 Jul 2006 09:29:04 -0600
User-Agent: KMail/1.8.3
Cc: drzeus-list@drzeus.cx, len.brown@intel.com, linux-kernel@vger.kernel.org,
       ambx1@neo.rr.com, shaohua.li@intel.com, castet.matthieu@free.fr,
       linux-acpi@vger.kernel.org, uwe.bugla@gmx.de
References: <44AB608F.1060903@drzeus.cx> <200607051536.30771.bjorn.helgaas@hp.com> <20060705151803.5841e91d.akpm@osdl.org>
In-Reply-To: <20060705151803.5841e91d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607060929.04787.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 July 2006 16:18, Andrew Morton wrote:
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > You recently proposed pushing it:
> >     http://marc.theaimsgroup.com/?l=linux-acpi&m=115119275408021&w=2
> > Len initially nacked it, but I think the outcome of the discussion
> > is that Shaohua doesn't object to this patch.  He probably would
> > still like to blacklist PNP0A03, but that's an additional step we
> > don't have to take at the same time.
> 
> OK, well let's please push this up the priority list and work out what want
> to do.  If Len's now OK with merging it then I think all lights are green?

My opinion is that we don't need to blacklist PNP0A03 unless
we discover a problem.  

Len, Shaohua, can you ack this?

> pnpacpi-reject-acpi_producer-resources.patch:
> 
> From: matthieu castet <castet.matthieu@free.fr>
> 
> A patch in -mm kernel correct the parsing of "address resources" of pnpacpi. 
> Before we assumed it was memory only, but it could be also IO.
> 
> But this change show an hidden bug : some resources could be producer type
> that are not handled by pnp layer.  So we should ignore the producer
> resources.
> 
> This patch fixes bug 6292 (http://bugzilla.kernel.org/show_bug.cgi?id=6292).
> Some devices like PNP0A03 have 0xd00-0xffff and 0x0-0xcf7 as IO producer 
> resources.
> 
> Before correcting "address resources" parsing, it was seen as memory and was
> harmless, because nobody tried to reserve this memory range as it should be
> IO.
> 
> With the correction it become IO resources, and make failed all others device
> that want to register IO in this range and use pnp layer (like a ISA sound
> card).
> 
> The solution is to ignore producer resources
> 
> Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
> Signed-off-by: Uwe Bugla <uwe.bugla@gmx.de>
> Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Cc: Adam Belay <ambx1@neo.rr.com>
> Cc: "Brown, Len" <len.brown@intel.com>
> 
> akpm: previously nacked, as per comment #26.  But am hanging onto it until the
> thing gets fixed for real.
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/pnp/pnpacpi/rsparser.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff -puN drivers/pnp/pnpacpi/rsparser.c~pnpacpi-reject-acpi_producer-resources drivers/pnp/pnpacpi/rsparser.c
> --- a/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-reject-acpi_producer-resources
> +++ a/drivers/pnp/pnpacpi/rsparser.c
> @@ -173,6 +173,9 @@ pnpacpi_parse_allocated_address_space(st
>  		return;
>  	}
>  
> +	if (p->producer_consumer == ACPI_PRODUCER)
> +		return;
> +
>  	if (p->resource_type == ACPI_MEMORY_RANGE)
>  		pnpacpi_parse_allocated_memresource(res_table,
>  				p->minimum, p->address_length);
> @@ -252,9 +255,14 @@ static acpi_status pnpacpi_allocated_res
>  		break;
>  
>  	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
> +		if (res->data.ext_address64.producer_consumer == ACPI_PRODUCER)
> +			return AE_OK;
>  		break;
>  
>  	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> +		if (res->data.extended_irq.producer_consumer == ACPI_PRODUCER)
> +			return AE_OK;
> +
>  		for (i = 0; i < res->data.extended_irq.interrupt_count; i++) {
>  			pnpacpi_parse_allocated_irqresource(res_table,
>  				res->data.extended_irq.interrupts[i],
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
