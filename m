Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbULPWvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbULPWvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbULPWuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:50:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:45750 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262062AbULPWsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:48:15 -0500
Date: Thu, 16 Dec 2004 14:48:03 -0800
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, sailer@watson.ibm.com,
       leendert@watson.ibm.com, emilyr@us.ibm.com, toml@us.ibm.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement --updated version
Message-ID: <20041216224803.GA10542@kroah.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com> <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 04:37:34PM -0600, Kylene Hall wrote:
> +config TCG_TPM
> +	tristate "TPM Hardware Support"
> +	depends on EXPERIMENTAL
> +	---help---
> +	  If you have a TPM security chip in your system, which
> +	  implements the Trusted Computing Group's specification,
> +	  say Yes and it will be accessible from within Linux. To 
> +	  compile this driver as a module, choose M here; the module 
> +	  will be called tpm. For more information see 
> +	  www.trustedcomputinggroup.org. A implementation of the 
> +	  Trusted Software Stack (TSS), the userspace enablement piece 
> +	  of the specification, can be obtained at 
> +	  http://sourceforge.net/projects/trousers
> +	  If unsure, say N.

What happened to the "if built as a module..." text?

> +
> +config TCG_NSC
> +	tristate "National Semiconductor TPM Interface"
> +	depends on TCG_TPM
> +
> +config TCG_ATMEL
> +	tristate "Atmel TPM Interface"
> +	depends on TCG_TPM

Please provide help text for these options.

> +/*
> + * Vendor specific TPMs will have a unique name and probe function.
> + * Those fields should be populated prior to calling this function in
> + * tpm_<specific>.c's module init function.
> + */
> +int register_tpm_driver(struct pci_driver *drv)
> +{
> +	drv->id_table = tpm_pci_tbl;
> +	drv->remove = __devexit_p(tpm_remove);
> +	drv->suspend = tpm_pm_suspend;
> +	drv->resume = tpm_pm_resume;
> +
> +	return pci_register_driver(drv);
> +}
> +
> +EXPORT_SYMBOL(register_tpm_driver);

Why not EXPORT_SYMBOL_GPL()?  Based on the content of these drivers, I'd
feel better if they all were that way, but that's just me :)

Actually, why even have this function at all?  It's not needed, just
export the suspend, resume, and remove functions, and you are set.

Also, don't say that other drivers really support the other pci devices,
when they do not.  The MODULE_DEVICE_TABLE() stuff needs to be in the
driver that actually supports that hardware.  Otherwise all of the
hotplug functionality will not work properly.

> +
> +void unregister_tpm_driver(struct pci_driver *drv)
> +{
> +	pci_unregister_driver(drv);
> +}
> +
> +EXPORT_SYMBOL(unregister_tpm_driver);

Um, why even have such a function?


> +EXPORT_SYMBOL(register_tpm_hardware);

EXPORT_SYMBOL_GPL() (same goes for all of these exported symbols...)

> diff -uprN linux-2.6.9/drivers/char/tpm.h linux-2.6.9-tpm/drivers/char/tpm.h
> --- linux-2.6.9/drivers/char/tpm.h	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9-tpm/drivers/char/tpm.h	2004-12-16 17:16:50.000000000 -0600
> +extern void tpm_time_expired(unsigned long);
> +extern int rdx(int);
> +extern void wrx(int, int);

Please use better names for these functions.  That's very cryptic for a
global symbol.

> +extern int lpc_bus_init(struct pci_dev *, u16);

No "tpm"?

> +extern int register_tpm_driver(struct pci_driver *);
> +extern void unregister_tpm_driver(struct pci_driver *);
> +extern int register_tpm_hardware(struct pci_dev *, struct tpm_chip_ops *,
> +				 u16);

Try putting "tpm" first here, for these functions, so the namespace is sane.

thanks,

greg k-h
