Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWFTFWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWFTFWH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWFTFWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:22:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964932AbWFTFWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:22:04 -0400
Date: Mon, 19 Jun 2006 22:22:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 03/20] chardev: GPIO for SCx200 & PC-8736x: add
 platforn_device for use w dev_dbg
Message-Id: <20060619222201.4689bfb3.akpm@osdl.org>
In-Reply-To: <44944904.9050302@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<44944904.9050302@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 12:25:08 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> 3/20. patch.platform-dev-2
> 
> Add a platform-device to scx200_gpio, and use its struct device dev
> member (ie: devp) in dev_dbg() once.
> 
> There are 2 alternatives here (Im soliciting guidance/commentary):
> 
> - use isa_device, if/when its added to the kernel.
> 
> - alter scx200.c to EXPORT_GPL its private devp so that both
> scx200_gpio, and the (to be added) nsc_gpio module can use it.
> Since the available devp is in 'grandparent', this seems like
> too much 'action at a distance'.
> 
> 
> @@ -121,12 +126,20 @@ static int __init scx200_gpio_init(void)
>  	int rc, i;
>  	dev_t dev = MKDEV(major, 0);
>  
> -	printk(KERN_DEBUG NAME ": NatSemi SCx200 GPIO Driver\n");
> -
>  	if (!scx200_gpio_present()) {
>  		printk(KERN_ERR NAME ": no SCx200 gpio present\n");
>  		return -ENODEV;
>  	}
> +
> +	/* support dev_dbg() with pdev->dev */
> +	pdev = platform_device_alloc(DEVNAME, 0);
> +	if (!pdev)
> +		return -ENODEV;

-ENOMEM would be more accurate.

> +	rc = platform_device_add(pdev);
> +	if (rc)
> +		goto undo_platform_device_add;

If the platform_device_add() didn't work, I don't think we need to undo it?

>  	if (major)
>  		rc = register_chrdev_region(dev, num_devs, "scx200_gpio");
>  	else {
> @@ -134,29 +147,31 @@ static int __init scx200_gpio_init(void)
>  		major = MAJOR(dev);
>  	}
>  	if (rc < 0) {
> -		printk(KERN_ERR NAME ": SCx200 chrdev_region: %d\n", rc);
> -		return rc;
> +		dev_err(&pdev->dev, "SCx200 chrdev_region err: %d\n", rc);
> +		goto undo_platform_device_add;
>  	}
>  	scx200_devices = kzalloc(num_devs * sizeof(struct cdev), GFP_KERNEL);
>  	if (!scx200_devices) {
>  		rc = -ENOMEM;
> -		goto fail_malloc;
> +		goto undo_chrdev_region;
>  	}
>  	for (i = 0; i < num_devs; i++) {
>  		struct cdev *cdev = &scx200_devices[i];
>  		cdev_init(cdev, &scx200_gpio_fops);
>  		cdev->owner = THIS_MODULE;
> -		cdev->ops = &scx200_gpio_fops;
>  		rc = cdev_add(cdev, MKDEV(major, i), 1);
> -		/* Fail gracefully if need be */
> +		/* tolerate 'minor' errors */
>  		if (rc)
> -			printk(KERN_ERR NAME "Error %d on minor %d", rc, i);
> +			dev_err(&pdev->dev, "Error %d on minor %d", rc, i);
>  	}
>  
> -	return 0;		/* succeed */
> +	return 0; /* succeed */
>  
> -fail_malloc:
> -	unregister_chrdev_region(dev, num_devs);
> +undo_chrdev_region:
> +        unregister_chrdev_region(dev, num_devs);

needs a tab.

> +undo_platform_device_add:
> +	platform_device_put(pdev);
> +	kfree(pdev);		/* undo platform_device_alloc */
>  	return rc;
>  }
>  
> @@ -164,6 +179,9 @@ static void __exit scx200_gpio_cleanup(v
>  {
>  	kfree(scx200_devices);
>  	unregister_chrdev_region(MKDEV(major, 0), num_devs);
> +	platform_device_put(pdev);
> +	platform_device_unregister(pdev);
> +	/* kfree(pdev); */
>  }

