Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266764AbUHIRTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266764AbUHIRTI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266769AbUHIRTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:19:08 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:50868 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266764AbUHIRS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:18:57 -0400
Subject: Re: [PATCH] ibmasm: add missing pci_enable_device()
From: Max Asbock <masbock@us.ibm.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200408041532.55146.bjorn.helgaas@hp.com>
References: <200408041532.55146.bjorn.helgaas@hp.com>
Content-Type: text/plain
Message-Id: <1092071925.3711.17.camel@w-amax>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 09 Aug 2004 10:18:45 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested this on the hardware. It works fine.
Is there any reason we shouldn't use dev_err() for the pci_enable error
message like in the other messages?

regards,
max

On Wed, 2004-08-04 at 14:32, Bjorn Helgaas wrote:
> I don't have this hardware, so this has not been tested.
> 
> 
> Add pci_enable_device()/pci_disable_device().  In the past, drivers
> often worked without this, but it is now required in order to route
> PCI interrupts correctly.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> ===== drivers/misc/ibmasm/module.c 1.2 vs edited =====
> --- 1.2/drivers/misc/ibmasm/module.c	2004-05-14 06:00:50 -06:00
> +++ edited/drivers/misc/ibmasm/module.c	2004-08-04 13:15:46 -06:00
> @@ -62,10 +62,17 @@
>  	int result = -ENOMEM;
>  	struct service_processor *sp;
>  
> +	if (pci_enable_device(pdev)) {
> +		printk(KERN_ERR "%s: can't enable PCI device at %s\n",
> +			DRIVER_NAME, pci_name(pdev));
> +		return -ENODEV;
> +	}
> +
>  	sp = kmalloc(sizeof(struct service_processor), GFP_KERNEL);
>  	if (sp == NULL) {
>  		dev_err(&pdev->dev, "Failed to allocate memory\n");
> -		return result;
> +		result = -ENOMEM;
> +		goto error_kmalloc;
>  	}
>  	memset(sp, 0, sizeof(struct service_processor));
>  
> @@ -148,6 +155,8 @@
>  	ibmasm_event_buffer_exit(sp);
>  error_eventbuffer:
>  	kfree(sp);
> +error_kmalloc:
> +	pci_disable_device(pdev);
>  
>  	return result;
>  }
> @@ -166,6 +175,7 @@
>  	iounmap(sp->base_address);
>  	ibmasm_event_buffer_exit(sp);
>  	kfree(sp);
> +	pci_disable_device(pdev);
>  }
>  
>  static struct pci_device_id ibmasm_pci_table[] =
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

