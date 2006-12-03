Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757365AbWLCVnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365AbWLCVnI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 16:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760109AbWLCVnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 16:43:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757365AbWLCVnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 16:43:05 -0500
Date: Sun, 3 Dec 2006 13:26:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: minyard@acm.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Carol Hebert <cah@us.ibm.com>
Subject: Re: [Patch 1/12] IPMI: Fix device model name
Message-Id: <20061203132602.07a271de.akpm@osdl.org>
In-Reply-To: <20061202042053.GA30214@localdomain>
References: <20061202042053.GA30214@localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 22:20:53 -0600
Corey Minyard <minyard@acm.org> wrote:

> 
> This patch adds the product id to the driver model platform device
> name, in addition to the device id.  The IPMI spec does not require
> that individual BMCs in a system have unique devices IDs, but it
> does require that the product id/device id combination be unique.
> 
> This also removes a redundant check and cleans up error handling
> when the sysfs registration fails.
> 
> Signed-off-by: Corey Minyard <minyard@acm.org>
> Cc: Carol Hebert <cah@us.ibm.com>
> 
> Index: linux-2.6.19/drivers/char/ipmi/ipmi_msghandler.c
> ===================================================================
> --- linux-2.6.19.orig/drivers/char/ipmi/ipmi_msghandler.c
> +++ linux-2.6.19/drivers/char/ipmi/ipmi_msghandler.c
> @@ -1817,13 +1817,12 @@ static int __find_bmc_prod_dev_id(struct
>  	struct bmc_device *bmc = dev_get_drvdata(dev);
>  
>  	return (bmc->id.product_id == id->product_id
> -		&& bmc->id.product_id == id->product_id
>  		&& bmc->id.device_id == id->device_id);
>  }
>  
>  static struct bmc_device *ipmi_find_bmc_prod_dev_id(
>  	struct device_driver *drv,
> -	unsigned char product_id, unsigned char device_id)
> +	unsigned int product_id, unsigned char device_id)
>  {
>  	struct prod_dev_id id = {
>  		.product_id = product_id,
> @@ -1940,6 +1939,9 @@ static ssize_t guid_show(struct device *
>  
>  static void remove_files(struct bmc_device *bmc)
>  {
> +	if (!bmc->dev)
> +		return;
> +
>  	device_remove_file(&bmc->dev->dev,
>  			   &bmc->device_id_attr);
>  	device_remove_file(&bmc->dev->dev,
> @@ -1973,7 +1975,8 @@ cleanup_bmc_device(struct kref *ref)
>  	bmc = container_of(ref, struct bmc_device, refcount);
>  
>  	remove_files(bmc);
> -	platform_device_unregister(bmc->dev);
> +	if (bmc->dev)
> +		platform_device_unregister(bmc->dev);

platform_device_unregister(NULL) appears to be legal.

>  	kfree(bmc);
>  }
>  
> @@ -1990,6 +1993,7 @@ static void ipmi_bmc_unregister(ipmi_smi
>  
>  	mutex_lock(&ipmidriver_mutex);
>  	kref_put(&bmc->refcount, cleanup_bmc_device);
> +	intf->bmc = NULL;
>  	mutex_unlock(&ipmidriver_mutex);
>  }
>  
> ...
>
>  	} else {
> -		bmc->dev = platform_device_alloc("ipmi_bmc",
> -						 bmc->id.device_id);
> +		char name[14];
> +		unsigned char orig_dev_id = bmc->id.device_id;
> +		int warn_printed = 0;
> +
> +		snprintf(name, sizeof(name),
> +			 "ipmi_bmc.%4.4x", bmc->id.product_id);
> +
> +		while (ipmi_find_bmc_prod_dev_id(&ipmidriver,
> +						 bmc->id.product_id,
> +						 bmc->id.device_id))
> +		{

The brace should be on the previous line.

> +			if (!warn_printed) {
> +				printk(KERN_WARNING PFX
> +				       "This machine has two different BMCs"
> +				       " with the same product id and device"
> +				       " id.  This is an error in the"
> +				       " firmware, but incrementing the"
> +				       " device id to work around the problem."
> +				       " Prod ID = 0x%x, Dev ID = 0x%x\n",
> +				       bmc->id.product_id, bmc->id.device_id);
> +				warn_printed = 1;

Perhaps warn_printed should be static


