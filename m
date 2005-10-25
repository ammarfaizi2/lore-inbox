Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVJYUVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVJYUVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 16:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVJYUVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 16:21:45 -0400
Received: from main.gmane.org ([80.91.229.2]:16778 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932342AbVJYUVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 16:21:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [PATCH 6 of 6] tpm: move infineon driver off pci_dev
Date: Tue, 25 Oct 2005 22:17:30 +0200
Message-ID: <pan.2005.10.25.20.17.26.57688@free.fr>
References: <1130253738.4839.65.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cac94-1-81-57-151-96.fbx.proxad.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

nice to see that the tpm framework was cleanned.

Le Tue, 25 Oct 2005 10:22:18 -0500, Kylene Jo Hall a écrit :

> ---
> 
> --- linux-2.6.14-rc4/drivers/char/tpm/tpm_infineon.c	2005-10-19 17:03:52.000000000 -0500
> +++ linux-2.6.13-tpm/drivers/char/tpm/tpm_infineon.c	2005-10-21 13:07:24.000000000 -0500
> @@ -14,6 +14,7 @@
>   * License.
>   */
>  
> +#include <acpi/acpi_bus.h>
Why is it needed ?



> -/* These values will be filled after PnP-call */
> +/* These values will be filled after ACPI-call */
Why not keep PnP ?


> -MODULE_DEVICE_TABLE(pnp, tpm_pnp_tbl);
>  
Why removing that ?
This will allow hotplug and udev to auto load the module.


> +
> +	/* read IO-ports from ACPI */
> +	TPM_INF_ADDR = (pnp_port_start(dev, 0) & 0xff);
> +	TPM_INF_DATA = ((TPM_INF_ADDR + 1) & 0xff);
No need to set mask, this is already done by pnp_port_start.
And I'll keep PNP instead of ACPI.


> +	tpm_inf.base = pnp_port_start(dev, 1);
Can't you be coherent ?
why not using tpm_inf.addr
or TPM_INF_BASE ?



> +	dev_info(&dev->dev, "Found %s with ID %s\n",
> +		 dev->name, dev_id->id);
> +	if (!((tpm_inf.base >> 8) & 0xff))
> +		tpm_inf.base = 0;
>  
>  	/* Make sure, we have received valid config ports */
You should also do :
pnp_port_flags(device, 0) & IORESOURCE_DISABLED) in order to check the
resources.


> +	.probe = tpm_inf_acpi_probe,
> +	.remove = tpm_inf_remove,
Not coherent : acpi vs nothing.
Again prefer pnp instead of acpi.


Matthieu

