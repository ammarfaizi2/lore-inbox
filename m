Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVFOXIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVFOXIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 19:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVFOXIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 19:08:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27010 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261655AbVFOW7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:59:13 -0400
Date: Wed, 15 Jun 2005 15:59:05 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Reiner Sailer <sailer@us.ibm.com>, serue@us.ibm.com
Subject: Re: [PATCH] 1 of 5 IMA: necessary tpm changes
Message-ID: <20050615225905.GF9153@shell0.pdx.osdl.net>
References: <1118845007.7037.24.camel@localhost.localdomain> <1118856627.7037.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118856627.7037.68.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kylene Jo Hall (kjhall@us.ibm.com) wrote:
> On Wed, 2005-06-15 at 09:16 -0500, Kylene Jo Hall wrote:
> > This patch applies against linux-2.6.12-rc6-mm1 and provides the
> > internal kernel interface for use by IMA or anything else in the kernel
> > which would like to use TPM commands.  It also moves the TPM driver up
> > in the initialization process to accomodate the early initialization
> > requirements of IMA.
> 
> This patch adds the lock that was missing in the tpm_chip_lookup
> function the previous patch.
> 
> Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
> ---
> --- linux-2.6.12-rc4/drivers/char/tpm/tpm.c.orig	2005-05-17 14:15:53.000000000 -0500
> +++ linux-2.6.12-rc4/drivers/char/tpm/tpm.c	2005-05-17 14:18:56.000000000 -0500
> @@ -50,15 +50,40 @@ static void user_reader_timeout(unsigned
>  }
>  
>  /*
> + * This function should be used by other kernel subsystems attempting to use the tpm through the tpm_transmit interface.
> + * A call to this function will return the chip structure corresponding to the TPM you are looking for that can then be sent with your command to tpm_transmit.
> + * Passing 0 as the argument corresponds to /dev/tpm0 and thus the first and probably primary TPM on the system.  Passing 1 corresponds to /dev/tpm1 and the next TPM discovered.  If a TPM with the given chip_num does not exist NULL will be returned.  
> + */

kernel-doc style comments please.  also, the interface seems a bit odd,
can probing order ever change?  Would you want a better identifier?

> +struct tpm_chip* tpm_chip_lookup(int chip_num)
> +{
> +
> --- linux-2.6.12-rc3-ima/drivers/char/tpm/tpm.h	2005-04-20 19:03:13.000000000 -0500
> +++ linux-2.6.12-rc3-ima/drivers/char/tpm/tpm.h	2005-05-02 14:08:44.000000000 -0500
> @@ -91,3 +91,8 @@ extern ssize_t tpm_read(struct file *, c
>  extern void __devexit tpm_remove(struct pci_dev *);
>  extern int tpm_pm_suspend(struct pci_dev *, pm_message_t);
>  extern int tpm_pm_resume(struct pci_dev *);
> +
> +/* internal kernel interface */
> +extern ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
> +			    size_t bufsiz);
> +extern struct tpm_chip *tpm_chip_lookup(int chip_num);

extern in not needed.

> --- linux-2.6.12-rc3-ima/drivers/char/tpm/tpm_atmel.c	2005-04-20 19:03:13.000000000 -0500
> +++ linux-2.6.12-rc3-ima/drivers/char/tpm/tpm_atmel.c	2005-05-02 14:06:35.000000000 -0500
> @@ -207,7 +207,11 @@ static void __exit cleanup_atmel(void)
>  	pci_unregister_driver(&atmel_pci_driver);
>  }
>  
> +#ifdef MODULE
>  module_init(init_atmel);
> +#else
> +fs_initcall(init_atmel);
> +#endif
>  module_exit(cleanup_atmel);

this is unnecssary.  just use fs_initcall unconditionally.

> --- linux-2.6.12-rc3-ima/drivers/char/tpm/tpm_nsc.c	2005-04-20 19:03:13.000000000 -0500
> +++ linux-2.6.12-rc3-ima/drivers/char/tpm/tpm_nsc.c	2005-05-02 14:09:34.000000000 -0500
> @@ -364,7 +364,11 @@ static void __exit cleanup_nsc(void)
>  	pci_unregister_driver(&nsc_pci_driver);
>  }
>  
> +#ifdef MODULE
>  module_init(init_nsc);
> +#else
> +fs_initcall(init_nsc);
> +#endif
>  module_exit(cleanup_nsc);

same here.

