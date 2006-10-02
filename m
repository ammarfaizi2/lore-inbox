Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbWJBXyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbWJBXyK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 19:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965534AbWJBXyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 19:54:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:11276 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965117AbWJBXyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 19:54:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ecbp3/slqoKZN9id4LwmkiqmDIaEyB42OG+W9yBdWKRciFs22Ichn2HlPw9IaIE2+/CipsIZHcO1hgIQc6IYF2Jhp/XTHnG/qa3J4yZhkb+RSuEvGwOP7OFQQK7HeDnttKUKMryHPCjXsRWke762Vg/KsmWw0eoHVwzZFl6kckg=
Message-ID: <21d7e9970610021654j6f443feay67a11121d1d8a716@mail.gmail.com>
Date: Tue, 3 Oct 2006 09:54:07 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Frederik Deweerdt" <deweerdt@free.fr>
Subject: Re: [RFC PATCH] move drm to pci_request_irq
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Matthew Wilcox" <matthew@wil.cx>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Andrew Morton" <akpm@osdl.org>,
       "Jeff Garzik" <jeff@garzik.org>
In-Reply-To: <20061002201229.GF3003@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1159550143.13029.36.camel@localhost.localdomain>
	 <1159573404.13029.96.camel@localhost.localdomain>
	 <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org>
	 <20061001142807.GD16272@parisc-linux.org>
	 <1159729523.2891.408.camel@laptopd505.fenrus.org>
	 <20061001193616.GF16272@parisc-linux.org>
	 <1159755141.2891.434.camel@laptopd505.fenrus.org>
	 <20061002200048.GC3003@slug> <20061002201229.GF3003@slug>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/06, Frederik Deweerdt <deweerdt@free.fr> wrote:
> Hi,
>
> This proof-of-concept patch converts the drm driver to use the
> pci_request_irq() function.

NAK.
Wow nice CC'list and no DRM maintainer in sight :-)

This will break framebuffer drivers, the DRM is not a proper PCI
device driver as we don't have PCI device sharing, take a look at the
gpu-2.6.git tree on kernel.org for the "correct" solution, which needs
more attention before merging..

Dave.
>
> Regards,
> Frederik
>
>
>
> diff --git a/drivers/char/drm/drm_drv.c b/drivers/char/drm/drm_drv.c
> index b366c5b..5b000cd 100644
> --- a/drivers/char/drm/drm_drv.c
> +++ b/drivers/char/drm/drm_drv.c
> @@ -234,6 +234,8 @@ int drm_lastclose(drm_device_t * dev)
>         }
>         mutex_unlock(&dev->struct_mutex);
>
> +       pci_set_drvdata(dev, NULL);
> +
>         DRM_DEBUG("lastclose completed\n");
>         return 0;
>  }
> diff --git a/drivers/char/drm/drm_irq.c b/drivers/char/drm/drm_irq.c
> index 4553a3a..5dd12cb 100644
> --- a/drivers/char/drm/drm_irq.c
> +++ b/drivers/char/drm/drm_irq.c
> @@ -132,8 +132,10 @@ static int drm_irq_install(drm_device_t
>         if (drm_core_check_feature(dev, DRIVER_IRQ_SHARED))
>                 sh_flags = IRQF_SHARED;
>
> -       ret = request_irq(dev->irq, dev->driver->irq_handler,
> -                         sh_flags, dev->devname, dev);
> +       pci_set_drvdata(dev->pdev, dev);
> +
> +       ret = pci_request_irq(dev->pdev, dev->driver->irq_handler,
> +                         sh_flags, dev->devname);
>         if (ret < 0) {
>                 mutex_lock(&dev->struct_mutex);
>                 dev->irq_enabled = 0;
> @@ -173,7 +175,7 @@ int drm_irq_uninstall(drm_device_t * dev
>
>         dev->driver->irq_uninstall(dev);
>
> -       free_irq(dev->irq, dev);
> +       pci_free_irq(dev->pdev);
>
>         return 0;
>  }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
