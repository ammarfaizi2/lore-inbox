Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWE1Num@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWE1Num (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 09:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWE1Nul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 09:50:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:56766 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750768AbWE1Nuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 09:50:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=Z3PJBIvIetL9+wJfAx/YHqlFtJOMsFpatTcdh+ixeUGyOVH/+FV8OBHH3r+NDxiCEFnIvuQaSRNodZfLvtB2arY2o9xDAgzDdU5LFGqvCAqJ7mneE+6zPcGoCCBBeTWVQ9/JW+BocQXusr/h6E51K23mJn60F0jp4sxt+kWPUPA=
Message-ID: <4479AAB8.9010509@gmail.com>
Date: Sun, 28 May 2006 15:50:25 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] HPT3xx: switch to using pci_get_slot()
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com> <446A55D6.90507@ru.mvista.com> <446ED8A3.6030702@ru.mvista.com> <4478CD3D.6010409@ru.mvista.com> <4478E104.7040200@ru.mvista.com>
In-Reply-To: <4478E104.7040200@ru.mvista.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sergei Shtylyov napsal(a):
>    Switch to using pci_get_slot() to get to the function 1 of HPT36x/374
> chips -- there's no need for the driver itself to walk the list of the
> PCI devices, and it also forgets to check the bus number of the device
> found.
It's better, but you missed to call pci_dev_put() in some __exit function.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> 
> ------------------------------------------------------------------------
> 
> Index: linus/drivers/ide/pci/hpt366.c
> ===================================================================
> --- linus.orig/drivers/ide/pci/hpt366.c
> +++ linus/drivers/ide/pci/hpt366.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/ide/pci/hpt366.c		Version 0.44	May 20, 2006
> + * linux/drivers/ide/pci/hpt366.c		Version 0.45	May 27, 2006
>   *
>   * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
>   * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
> @@ -79,6 +79,7 @@
>   * - prefix the driver startup messages with the real chip name
>   * - claim the extra 240 bytes of I/O space for all chips
>   * - optimize the rate masking/filtering and the drive list lookup code
> + * - use pci_get_slot() to get to the function 1 of HPT36x/374
>   *		<source@mvista.com>
>   *
>   */
> @@ -1412,24 +1413,24 @@ static void __devinit init_iops_hpt366(i
>  
>  static int __devinit init_setup_hpt374(struct pci_dev *dev, ide_pci_device_t *d)
>  {
> -	struct pci_dev *findev = NULL;
> +	struct pci_dev *dev2;
>  
>  	if (PCI_FUNC(dev->devfn) & 1)
>  		return -ENODEV;
>  
> -	while ((findev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
> -		if ((findev->vendor == dev->vendor) &&
> -		    (findev->device == dev->device) &&
> -		    ((findev->devfn - dev->devfn) == 1) &&
> -		    (PCI_FUNC(findev->devfn) & 1)) {
> -			if (findev->irq != dev->irq) {
> -				/* FIXME: we need a core pci_set_interrupt() */
> -				findev->irq = dev->irq;
> -				printk(KERN_WARNING "%s: pci-config space interrupt "
> -					"fixed.\n", d->name);
> -			}
> -			return ide_setup_pci_devices(dev, findev, d);
> +	if ((dev2 = pci_get_slot(dev->bus, dev->devfn + 1)) != NULL) {
> +		int ret;
> +
> +		if (dev2->irq != dev->irq) {
> +			/* FIXME: we need a core pci_set_interrupt() */
> +			dev2->irq = dev->irq;
> +			printk(KERN_WARNING "%s: PCI config space interrupt "
> +			       "fixed.\n", d->name);
>  		}
> +		ret = ide_setup_pci_devices(dev, dev2, d);
> +		if (ret < 0)
> +			pci_dev_put(dev2);
> +		return ret;
>  	}
>  	return ide_setup_pci_device(dev, d);
>  }
> @@ -1487,8 +1488,8 @@ static int __devinit init_setup_hpt302(s
>  
>  static int __devinit init_setup_hpt366(struct pci_dev *dev, ide_pci_device_t *d)
>  {
> -	struct pci_dev *findev = NULL;
> -	u8 rev = 0, pin1 = 0, pin2 = 0;
> +	struct pci_dev *dev2;
> +	u8 rev = 0;
>  	static char   *chipset_names[] = { "HPT366", "HPT366",  "HPT368",
>  					   "HPT370", "HPT370A", "HPT372",
>  					   "HPT372N" };
> @@ -1508,21 +1509,21 @@ static int __devinit init_setup_hpt366(s
>  
>  	d->channels = 1;
>  
> -	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin1);
> -	while ((findev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, findev)) != NULL) {
> -		if ((findev->vendor == dev->vendor) &&
> -		    (findev->device == dev->device) &&
> -		    ((findev->devfn - dev->devfn) == 1) &&
> -		    (PCI_FUNC(findev->devfn) & 1)) {
> -			pci_read_config_byte(findev, PCI_INTERRUPT_PIN, &pin2);
> -			if ((pin1 != pin2) && (dev->irq == findev->irq)) {
> -				d->bootable = ON_BOARD;
> -				printk("%s: onboard version of chipset, "
> -					"pin1=%d pin2=%d\n", d->name,
> -					pin1, pin2);
> -			}
> -			return ide_setup_pci_devices(dev, findev, d);
> +	if ((dev2 = pci_get_slot(dev->bus, dev->devfn + 1)) != NULL) {
> +	  	u8  pin1 = 0, pin2 = 0;
> +		int ret;
> +
> +		pci_read_config_byte(dev,  PCI_INTERRUPT_PIN, &pin1);
> +		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin2);
> +		if (pin1 != pin2 && dev->irq == dev2->irq) {
> +			d->bootable = ON_BOARD;
> +			printk("%s: onboard version of chipset, pin1=%d pin2=%d\n",
> +			       d->name, pin1, pin2);
>  		}
> +		ret = ide_setup_pci_devices(dev, dev2, d);
> +		if (ret < 0)
> +			pci_dev_put(dev2);
> +		return ret;
>  	}
>  init_single:
>  	return ide_setup_pci_device(dev, d);
> 


- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEeaq4MsxVwznUen4RAgeRAKDFZZWKIOW1kEOOnsMPRmsNBGc0AQCfWM1f
v7Ub4sGcHL0nCGJ6dhoj4g0=
=e7BC
-----END PGP SIGNATURE-----
