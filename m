Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWJBShv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWJBShv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWJBShv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:37:51 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:9169 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S964826AbWJBShu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:37:50 -0400
Date: Mon, 2 Oct 2006 12:37:49 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC PATCH] move drm to pci_request_irq
Message-ID: <20061002183749.GO16272@parisc-linux.org>
References: <20060929235054.GB2020@slug> <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org> <1159755141.2891.434.camel@laptopd505.fenrus.org> <20061002200048.GC3003@slug> <20061002201229.GF3003@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002201229.GF3003@slug>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 08:12:29PM +0000, Frederik Deweerdt wrote:
>  
> +	pci_set_drvdata(dev, NULL);
> +
>  	DRM_DEBUG("lastclose completed\n");

Not necessary.  pci_devs are allocated initialised to 0.

> @@ -132,8 +132,10 @@ static int drm_irq_install(drm_device_t 
>  	if (drm_core_check_feature(dev, DRIVER_IRQ_SHARED))
>  		sh_flags = IRQF_SHARED;
>  
> -	ret = request_irq(dev->irq, dev->driver->irq_handler,
> -			  sh_flags, dev->devname, dev);
> +	pci_set_drvdata(dev->pdev, dev);
> +
> +	ret = pci_request_irq(dev->pdev, dev->driver->irq_handler,
> +			  sh_flags, dev->devname);

This seems like the wrong place to be setting the pci_drvdata.  It
should probably be done in each driver.  But then, requesting the IRQ
should also be done by each driver.  You've dragged us into the "wow,
what a mess DRI is" black hole here, I'm afraid.

