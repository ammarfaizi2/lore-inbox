Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVJZVUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVJZVUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 17:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbVJZVUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 17:20:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52431 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964935AbVJZVUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 17:20:17 -0400
Date: Wed, 26 Oct 2005 22:20:17 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Laurent riffard <laurent.riffard@free.fr>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC patch 1/3] remove pci_driver.owner and .name fields
Message-ID: <20051026212017.GT7992@ftp.linux.org.uk>
References: <20051026204802.123045000@antares.localdomain> <20051026204909.179264000@antares.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051026204909.179264000@antares.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 10:48:03PM +0200, Laurent riffard wrote:
> --- linux-2.6-stable.orig/drivers/ide/setup-pci.c
> +++ linux-2.6-stable/drivers/ide/setup-pci.c
> @@ -787,8 +787,9 @@
>  static LIST_HEAD(ide_pci_drivers);
>  
>  /*
> - *	ide_register_pci_driver		-	attach IDE driver
> + *	__ide_register_pci_driver	-	attach IDE driver
>   *	@driver: pci driver
> + *	@module: owner module of the driver
>   *
>   *	Registers a driver with the IDE layer. The IDE layer arranges that
>   *	boot time setup is done in the expected device order and then 
> @@ -801,15 +802,16 @@
>   *	Returns are the same as for pci_register_driver
>   */
>  
> -int ide_pci_register_driver(struct pci_driver *driver)
> +int __ide_pci_register_driver(struct pci_driver *driver, struct module *module)
>  {
>  	if(!pre_init)
> -		return pci_module_init(driver);
> +		return __pci_register_driver(driver, module);
> +	driver->driver.owner = module;
>  	list_add_tail(&driver->node, &ide_pci_drivers);
>  	return 0;
>  }
>  
> -EXPORT_SYMBOL_GPL(ide_pci_register_driver);
> +EXPORT_SYMBOL_GPL(__ide_pci_register_driver);

Not enough - you have to deal with pci_register_driver() call later in
the same file.  Replace with __pci_register_driver(d, d->driver.owner)...
