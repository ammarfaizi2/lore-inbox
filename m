Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVLNGJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVLNGJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 01:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVLNGJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 01:09:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28110 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750725AbVLNGJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 01:09:16 -0500
Date: Tue, 13 Dec 2005 22:08:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, stelian@popies.net, malattia@linux.it
Subject: Re: [PATCH] Sonypi: convert to the new platform device interface
Message-Id: <20051213220853.6e620c59.akpm@osdl.org>
In-Reply-To: <200512140041.16711.dtor_core@ameritech.net>
References: <200512140041.16711.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> Sonypi: convert to the new platform device interface
> 
> Do not use platform_device_register_simple() as it is going away,
> implement ->probe() and -remove() functions so manual binding and
> unbinding will work with this driver.
> 
> ...
>
>  	return 0;
> +
> + err_unregister_jogdev:
> +	input_unregister_device(jog_dev);
> +	/* Set to NULL so we don't free it again below */
> +	jog_dev = NULL;
> + err_free_keydev:
> +	input_free_device(key_dev);
> +	sonypi_device.input_key_dev = NULL;
> + err_free_jogdev:
> +	input_unregister_device(jog_dev);
> +	sonypi_device.input_jog_dev = NULL;
> +
> +	return error;
>  }

The error unwinding here is mucked up - err_free_jogdev will unregister a
not-registered device.

> +static int __devinit sonypi_probe(struct platform_device *dev)

And I have my doubts about this function too.

> +{
> +	const struct sonypi_ioport_list *ioport_list;
> +	const struct sonypi_irq_list *irq_list;
> +	struct pci_dev *pcidev;
> +	int error;
>  
>  	spin_lock_init(&sonypi_device.fifo_lock);
>  	sonypi_device.fifo = kfifo_alloc(SONYPI_BUF_SIZE, GFP_KERNEL,
>  					 &sonypi_device.fifo_lock);
>  	if (IS_ERR(sonypi_device.fifo)) {
>  		printk(KERN_ERR "sonypi: kfifo_alloc failed\n");
> -		ret = PTR_ERR(sonypi_device.fifo);
> -		goto out_fifo;
> +		return PTR_ERR(sonypi_device.fifo);
>  	}
>  
>  	init_waitqueue_head(&sonypi_device.fifo_proc_list);
>  	init_MUTEX(&sonypi_device.lock);
>  	sonypi_device.bluetooth_power = -1;
>  
> +	if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
> +				     PCI_DEVICE_ID_INTEL_82371AB_3, NULL)))
> +		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE1;
> +	else if ((pcidev = pci_get_device(PCI_VENDOR_ID_INTEL,
> +					  PCI_DEVICE_ID_INTEL_ICH6_1, NULL)))
> +		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE3;
> +	else
> +		sonypi_device.model = SONYPI_DEVICE_MODEL_TYPE2;
> +
>  	if (pcidev && pci_enable_device(pcidev)) {
>  		printk(KERN_ERR "sonypi: pci_enable_device failed\n");
> -		ret = -EIO;
> -		goto out_pcienable;
> -	}
> -
> -	if (minor != -1)
> -		sonypi_misc_device.minor = minor;
> -	if ((ret = misc_register(&sonypi_misc_device))) {
> -		printk(KERN_ERR "sonypi: misc_register failed\n");
> -		goto out_miscreg;
> +		error = -EIO;
> +		goto err_free_fifo;

err_free_fifo doesn't do pci_dev_put().  So if we have a pci_device but
pci_enabe_device() failed we leak a refcount I think.

Anyway, please triple-check all that error path code, resend?
