Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262966AbVHERlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbVHERlk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbVHERlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:41:39 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:64474 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S262966AbVHERli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:41:38 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Marcel Selhorst <selhorst@crypto.rub.de>
Subject: Re: [PATCH] tpm_infineon: Support for new TPM 1.2 and PNPACPI
Date: Fri, 5 Aug 2005 11:41:34 -0600
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kylene Jo Hall <kjhall@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>
References: <42F1EE69.4000108@crypto.rub.de>
In-Reply-To: <42F1EE69.4000108@crypto.rub.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508051141.34121.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 August 2005 4:31 am, Marcel Selhorst wrote:
> This patch includes support for the new Infineon Trusted Platform Module
> SLB 9635 TT 1.2 and does further include ACPI-support for both chip versions
> (SLD 9630 TT 1.1 and SLB9635 TT 1.2). Since the ioports and configuration
> registers are not correctly set on some machines, the configuration is now
> done via PNPACPI, which reads out the correct values out of the DSDT-table.
> Note that you have to have CONFIG_PNP, CONFIG_ACPI_BUS and CONFIG_PNPACPI
> enabled to run this driver (assuming that mainbaords including a TPM do have
> the need for ACPI anyway).

> +++ linux-new/drivers/char/tpm/tpm_infineon.c	2005-08-04 12:19:47.000000000 +0200
> ...
> +#include <acpi/acpi_bus.h>

You shouldn't need acpi_bus.h anymore, since you're using PNP.

> +/* These values will be filled after ACPI-call */

You're not using ACPI anymore.

> +static const struct pnp_device_id tpm_pnp_tbl[] = {
> +	/* Infineon TPMs */
> +	{"IFX0101", 0},
> +	{"IFX0102", 0},
> +	{"", 0}
> +};

I get the impression from other drivers (though I admit it's out
of my area), that in general, you should use MODULE_DEVICE_TABLE()
to export this table.

> +static int __devinit tpm_inf_acpi_probe(struct pnp_dev *dev,
> +					const struct pnp_device_id *dev_id)

Should be tpm_inf_pnp_probe() or similar.

> +	TPM_INF_ADDR = (pnp_port_start(dev, 0) & 0xff);

Thanks for using PNP and getting rid of the usage of
TPM_ADDR.  Now if we could just get the atml and nsc
folks to do the same thing, we could nuke both TPM_ADDR
and TPM_SUPERIO_ADDR.

>  static int __devinit tpm_inf_probe(struct pci_dev *pci_dev,
>  				   const struct pci_device_id *pci_id)
>  {
> @@ -353,64 +384,99 @@ static int __devinit tpm_inf_probe(struc
>  	int vendorid[2];
>  	int version[2];
>  	int productid[2];
> +	char chipname[20];
> 
>  	if (pci_enable_device(pci_dev))
>  		return -EIO;

Usually people just return what pci_enable_device() returned.

>  	dev_info(&pci_dev->dev, "LPC-bus found at 0x%x\n", pci_id->device);
> 
> +	/* read IO-ports from ACPI */
> +	pnp_register_driver(&tpm_inf_pnp);
> +	pnp_unregister_driver(&tpm_inf_pnp);

This is kind of a weird mixture of a PCI device & driver (the
LPC bus?) and a PNP device & driver (the TPM device).  Can there
be things other than the TPM on the LPC bus?  Should the LPC
part be split into a separate driver somehow?

I see "LPC" in the atml and nsc drivers as well -- is it
conceivable that the TPMs and LPCs could be mixed-and-matched
someday?  If so, you'd definitely want to split the LPC and
TPM drivers.

> +	switch ((productid[0] << 8) | productid[1]) {
> +	case 6:
> +		sprintf(chipname, " (SLD 9630 TT 1.1)");
> +		break;
> +	case 11:
> +		sprintf(chipname, " (SLB 9635 TT 1.2)");
> +		break;
> +	default:
> +		sprintf(chipname, " (unknown chip)");
> +		break;
> +	}
> +	chipname[19] = 0;

Just use "snprintf(chipname, sizeof(chipname), ...)", which null-
terminates the string for you.
