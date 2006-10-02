Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965353AbWJBTIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965353AbWJBTIp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965355AbWJBTIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:08:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:6695 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965353AbWJBTIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:08:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Gq+GKZo0+rUQhrQml28ZB+PfLn5J3TfLvv00xDE3cW73mumUjrs5Vj2kg9a+5nMdfsZudMj57hMIkR9XaBXd5wTqrVVhI2wY07PncZvViiW9AnMpu3mXJSCAZtAHChnlIsz8TV7cX4SD0UQ0r62IW3ZpwTDmTvRC/e0rkYC/EFA=
Date: Mon, 2 Oct 2006 21:07:18 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC PATCH] move drm to pci_request_irq
Message-ID: <20061002210718.GI3003@slug>
References: <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org> <1159755141.2891.434.camel@laptopd505.fenrus.org> <20061002200048.GC3003@slug> <20061002201229.GF3003@slug> <20061002183749.GO16272@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002183749.GO16272@parisc-linux.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 12:37:49PM -0600, Matthew Wilcox wrote:
> On Mon, Oct 02, 2006 at 08:12:29PM +0000, Frederik Deweerdt wrote:
> >  
> > +	pci_set_drvdata(dev, NULL);
> > +
> >  	DRM_DEBUG("lastclose completed\n");
> 
> Not necessary.  pci_devs are allocated initialised to 0.
Actually, this is the exit path, I felt like it could be safer if it was
set to NULL before freeing it.
> 
> > @@ -132,8 +132,10 @@ static int drm_irq_install(drm_device_t 
> >  	if (drm_core_check_feature(dev, DRIVER_IRQ_SHARED))
> >  		sh_flags = IRQF_SHARED;
> >  
> > -	ret = request_irq(dev->irq, dev->driver->irq_handler,
> > -			  sh_flags, dev->devname, dev);
> > +	pci_set_drvdata(dev->pdev, dev);
> > +
> > +	ret = pci_request_irq(dev->pdev, dev->driver->irq_handler,
> > +			  sh_flags, dev->devname);
> 
> This seems like the wrong place to be setting the pci_drvdata.  It
> should probably be done in each driver.  But then, requesting the IRQ
> should also be done by each driver.  You've dragged us into the "wow,
> what a mess DRI is" black hole here, I'm afraid.
I must admit that I had no idea where to initialize it. Do you have a
better place in mind?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
