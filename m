Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWBPEij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWBPEij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 23:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWBPEij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 23:38:39 -0500
Received: from xenotime.net ([66.160.160.81]:60087 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932469AbWBPEii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 23:38:38 -0500
Date: Wed, 15 Feb 2006 20:39:29 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Marcel Selhorst <selhorst@crypto.rub.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, castet.matthieu@free.fr,
       kjhall@us.ibm.com
Subject: Re: [PATCH] Infineon TPM: IO-port leakage fix, WTX-bugfix
Message-Id: <20060215203929.52ac2197.rdunlap@xenotime.net>
In-Reply-To: <43F33013.4020305@crypto.rub.de>
References: <43F33013.4020305@crypto.rub.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2006 14:43:47 +0100 Marcel Selhorst wrote:

> Dear all,
> 
> this patch fixes IO-port leakage from request_region in case of error during TPM
> initialization, adds more pnp-verification and fixes a WTX-bug.
> 
> Best regards,
> Marcel Selhorst
> 
> Signed-off-by: Marcel Selhorst <selhorst@crypto.rub.de>
> ---
> 
> --- linux-2.6.16-rc2/drivers/char/tpm/tpm_infineon.c.old	2006-02-08
> 11:45:09.000000000 +0100

Those 2 lines ^^^^^ should have been one line.  Email client strikes again.

> +++ linux-2.6.16-rc2/drivers/char/tpm/tpm_infineon.c	2006-02-15 13:32:00.000000000 +0100
> @@ -471,14 +484,21 @@ static int __devinit tpm_inf_pnp_probe(s
> 
>  		rc = tpm_register_hardware(&dev->dev, &tpm_inf);
>  		if (rc < 0) {
> -			release_region(tpm_inf.base, TPM_INF_PORT_LEN);
> -			return -ENODEV;
> +			rc = -ENODEV;
> +			goto err_release_region;
>  		}
>  		return 0;
>  	} else {
> -		dev_info(&dev->dev, "No Infineon TPM found!\n");
> -		return -ENODEV;
> +		rc = -ENODEV;
> +		goto err_release_region;
>  	}
> +
> +err_release_region:
> +release_region(tpm_inf.base, TPM_INF_PORT_LEN);
> +release_region(TPM_INF_ADDR, TPM_INF_ADDR_LEN);
> +
> +err_last:
> +return rc;
>  }

The release_region() calls and return should be indented one tab stop.
(email client again??)

---
~Randy
