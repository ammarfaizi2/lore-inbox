Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161167AbWJDPFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbWJDPFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161169AbWJDPFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:05:38 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:63406 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161167AbWJDPFg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:05:36 -0400
Subject: Re: [PATCH] tpm: fix error handling
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061004141644.GA30669@havoc.gtf.org>
References: <20061004141644.GA30669@havoc.gtf.org>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 08:04:06 -0700
Message-Id: <1159974246.6876.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ack'ed-by: Kylene Hall <kjhall@us.ibm.com>

On Wed, 2006-10-04 at 10:16 -0400, Jeff Garzik wrote:
> - handle sysfs error
> - handle driver model errors
> - de-obfuscate platform_device_register_simple() call, which included an
>   assignment in between two function calls, in the same C statement.
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> ---
> 
>  drivers/char/tpm/tpm.c       |    9 ++++++++-
>  drivers/char/tpm/tpm_atmel.c |   10 +++++-----
>  drivers/char/tpm/tpm_nsc.c   |    6 ++++--
>  3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.c b/drivers/char/tpm/tpm.c
> index a082a2e..6ad2d3b 100644
> --- a/drivers/char/tpm/tpm.c
> +++ b/drivers/char/tpm/tpm.c
> @@ -1153,7 +1153,14 @@ #define DEVNAME_SIZE 7
>  
>  	spin_unlock(&driver_lock);
>  
> -	sysfs_create_group(&dev->kobj, chip->vendor.attr_group);
> +	if (sysfs_create_group(&dev->kobj, chip->vendor.attr_group)) {
> +		list_del(&chip->list);
> +		put_device(dev);
> +		clear_bit(chip->dev_num, dev_mask);
> +		kfree(chip);
> +		kfree(devname);
> +		return NULL;
> +	}
>  
>  	chip->bios_dir = tpm_bios_log_setup(devname);
>  
> diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
> index ad8ffe4..1ab0896 100644
> --- a/drivers/char/tpm/tpm_atmel.c
> +++ b/drivers/char/tpm/tpm_atmel.c
> @@ -184,7 +184,9 @@ static int __init init_atmel(void)
>  	unsigned long base;
>  	struct  tpm_chip *chip;
>  
> -	driver_register(&atml_drv);
> +	rc = driver_register(&atml_drv);
> +	if (rc)
> +		return rc;
>  
>  	if ((iobase = atmel_get_base_addr(&base, &region_size)) == NULL) {
>  		rc = -ENODEV;
> @@ -195,10 +197,8 @@ static int __init init_atmel(void)
>  	    (atmel_request_region
>  	     (tpm_atmel.base, region_size, "tpm_atmel0") == NULL) ? 0 : 1;
>  
> -
> -	if (IS_ERR
> -	    (pdev =
> -	     platform_device_register_simple("tpm_atmel", -1, NULL, 0))) {
> +	pdev = platform_device_register_simple("tpm_atmel", -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
>  		rc = PTR_ERR(pdev);
>  		goto err_rel_reg;
>  	}
> diff --git a/drivers/char/tpm/tpm_nsc.c b/drivers/char/tpm/tpm_nsc.c
> index 26287aa..608f730 100644
> --- a/drivers/char/tpm/tpm_nsc.c
> +++ b/drivers/char/tpm/tpm_nsc.c
> @@ -284,7 +284,7 @@ static struct device_driver nsc_drv = {
>  static int __init init_nsc(void)
>  {
>  	int rc = 0;
> -	int lo, hi;
> +	int lo, hi, err;
>  	int nscAddrBase = TPM_ADDR;
>  	struct tpm_chip *chip;
>  	unsigned long base;
> @@ -297,7 +297,9 @@ static int __init init_nsc(void)
>  			return -ENODEV;
>  	}
>  
> -	driver_register(&nsc_drv);
> +	err = driver_register(&nsc_drv);
> +	if (err)
> +		return err;
>  
>  	hi = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_HI);
>  	lo = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_LO);

