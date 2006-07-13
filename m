Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWGMBn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWGMBn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 21:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWGMBn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 21:43:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16319 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932488AbWGMBn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 21:43:57 -0400
Date: Wed, 12 Jul 2006 18:43:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH] tpm: Add force device probe option
Message-Id: <20060712184353.48cbf49c.akpm@osdl.org>
In-Reply-To: <1152738273.5347.37.camel@localhost.localdomain>
References: <1152738273.5347.37.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 14:04:33 -0700
Kylene Jo Hall <kjhall@us.ibm.com> wrote:

> Some machine manufacturers are not sticking to the TCG specifications
> and including an ACPI DSDT entry for the TPM which allows PNP discovery
> of the device.

Well that sucks.

>  This patch adds a force option that will allow users to
> load the driver if they know there machine has a chip but it is not
> being discovered by the normal processes.
> 

>  
> +static int __devinit tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
> +				      const struct pnp_device_id *pnp_id)
> +{
> +	unsigned long start, len;
> +	start = pnp_mem_start(pnp_dev, 0);
> +	len = pnp_mem_len(pnp_dev, 0);

All these starts, ends and lens are now wrong - they should be changed to
resource_size_t.  But there's no rush on that - please add it to the todo
list.

> +static int force = 0;

The `= 0' here is unneeded.  It's also undesirable, since it adds to the size
of vmlinux on-disk.

> +module_param(force, bool, 0444);
> +MODULE_PARM_DESC(force, "Force device probe rather than using ACPI entry");
>  static int __init init_tis(void)
>  {
> +	int rc;
> +
> +	if (force) {
> +		driver_register(&tis_drv);

driver_register() can fail and the driver should check for and handle the
failure.

This mistake happens literally thousands of times and we're trying to fix
it up at present.  An updated patch would be appreciated, please.

> -	pnp_unregister_driver(&tis_pnp_driver);
> +	if (force) {
> +		platform_device_unregister(pdev);
> +		driver_unregister(&tis_drv);
> +	}
> +	else 

	} else


