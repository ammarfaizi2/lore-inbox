Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266677AbUHYAlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266677AbUHYAlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 20:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUHYAlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 20:41:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32958 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266677AbUHYAkx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 20:40:53 -0400
Message-ID: <412BE006.8040606@pobox.com>
Date: Tue, 24 Aug 2004 20:40:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bjorn.helgaas@hp.com, Ralf Baechle <ralf@linux-mips.org>,
       Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ioc3-eth.c: add missing pci_enable_device()
References: <200408242225.i7OMPGLQ029847@hera.kernel.org>
In-Reply-To: <200408242225.i7OMPGLQ029847@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1843.1.74, 2004/08/24 11:21:53-07:00, bjorn.helgaas@hp.com
> 
> 	[PATCH] ioc3-eth.c: add missing pci_enable_device()
> 	
> 	Add pci_enable_device()/pci_disable_device().  In the past, drivers often
> 	worked without this, but it is now required in order to route PCI interrupts
> 	correctly.
> 	
> 	Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> 
> 
>  ioc3-eth.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
> 
> 
> diff -Nru a/drivers/net/ioc3-eth.c b/drivers/net/ioc3-eth.c
> --- a/drivers/net/ioc3-eth.c	2004-08-24 15:25:26 -07:00
> +++ b/drivers/net/ioc3-eth.c	2004-08-24 15:25:26 -07:00
> @@ -1172,9 +1172,14 @@
>  	u32 vendor, model, rev;
>  	int err;
>  
> +	if (pci_enable_device(pdev))
> +		return -ENODEV;
> +
>  	dev = alloc_etherdev(sizeof(struct ioc3_private));
> -	if (!dev)
> -		return -ENOMEM;
> +	if (!dev) {
> +		err = -ENOMEM;
> +		goto out_disable;
> +	}
>  
>  	err = pci_request_regions(pdev, "ioc3");
>  	if (err)
> @@ -1269,6 +1274,8 @@
>  	pci_release_regions(pdev);
>  out_free:
>  	free_netdev(dev);
> +out_disable:
> +	pci_disable_device(pdev);
>  	return err;
>  }
>  
> @@ -1282,6 +1289,7 @@
>  	iounmap(ioc3);
>  	pci_release_regions(pdev);
>  	free_netdev(dev);
> +	pci_disable_device(pdev);


I don't see a "signed-off-by" line from Ralf.  I noticed you never 
bothered to send this patch to me.  Did you send it to Ralf either?

ioc3 is _very_ strange device and not fully compliant to the PCI spec.

I would appreciate more review and testing before these patches go in, 
particularly against net drivers.  pci_enable_device() is NOT just a 
simple cleanup:

* each driver may (though unlikely) manage its PCI_COMMAND bits and/or 
resources in a special way.  IDE driver is an example of where 
pci_enable_device() _cannot_ be used.

* like ioc3, the hardware may be weird

* you must consider the case of two drivers for the same hardware VERY 
carefully.  Consider:

1) (DRV A) modprobe
2) (DRV A) pci_enable_device()
3) (DRV A) starts operation

4) (DRV B) modprobe
5) (DRV B) pci_enable_device()
6) (DRV B) pci_request_regions() or request_region() fails (since driver 
A owns the resources)
7) (DRV B) pci_disable_device()

8) (DRV A) fails miserably, because you just disabled IO/MEM bits from 
an _active_ driver.  BOOM.


Not all cleanups are created equal.  Proceed with caution.

	Jeff


