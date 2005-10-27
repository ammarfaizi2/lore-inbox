Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbVJ0VdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbVJ0VdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbVJ0VdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:33:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932646AbVJ0VdY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:33:24 -0400
Date: Thu, 27 Oct 2005 14:33:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcel Selhorst <selhorst@crypto.rub.de>
Cc: linux-kernel@vger.kernel.org, castet.matthieu@free.fr, kjhall@us.ibm.com
Subject: Re: [PATCH] Infineon TPM: move infineon driver off pci_dev
Message-Id: <20051027143332.08269850.akpm@osdl.org>
In-Reply-To: <4360B889.1010502@crypto.rub.de>
References: <435FB8A5.803@crypto.rub.de>
	<435FBFC4.5060508@free.fr>
	<4360B889.1010502@crypto.rub.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Selhorst <selhorst@crypto.rub.de> wrote:
>
> @@ -489,67 +464,51 @@ static int __devinit tpm_inf_probe(struc
>  			 "product id %02x%02x"
>  			 "%s\n",
>  			 TPM_INF_ADDR,
> -			 tpm_inf.base,
> +			 TPM_INF_BASE,
>  			 version[0], version[1],
>  			 vendorid[0], vendorid[1],
>  			 productid[0], productid[1], chipname);
> 
> -		rc = tpm_register_hardware(&pci_dev->dev, &tpm_inf);
> -		if (rc < 0)
> -			goto error;
> +		rc = tpm_register_hardware(&dev->dev, &tpm_inf);
> +		if (rc < 0) {
> +			release_region(tpm_inf.base, TPM_INF_PORT_LEN);
> +			return -ENODEV;
> +		}
>  		return 0;
>  	} else {
> -		dev_info(&pci_dev->dev, "No Infineon TPM found!\n");
> -error:
> -		pnp_unregister_driver(&tpm_inf_pnp);
> -error2:
> -		pci_disable_device(pci_dev);
> -		pnp_registered = 0;
> +		dev_info(&dev->dev, "No Infineon TPM found!\n");
>  		return -ENODEV;
>  	}
>  }

This final return will leak the I/O region from request_region().

To reduce the chance of this happening again, please send a followup patch
which prevents this function from having `return' statements sprinkled all
over it.  An example would be drivers/net/8139cp.c:cp_init_one(), thanks.

If for some reason the leak is deliberate then a comment is needed.
