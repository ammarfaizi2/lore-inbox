Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965383AbWJCHUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965383AbWJCHUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 03:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965432AbWJCHUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 03:20:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:63391 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965383AbWJCHUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 03:20:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=ZxnmeiRnz0BYTD0FqmxdAdp8mLpJbXtTauzdvE0j/UFeY5UBOtxcOCL9BF8gIEfu28a2e09CPO/cP6jEWkBnYJ0Rzx/AXuuBirN2IhFEGU5Ar5XAtDfE2SRa/PjnKGmEE57K5C7cMtWrBk16JFQCxDh9TyCo4TghsPzxjeioOHw=
Date: Tue, 3 Oct 2006 07:17:33 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Dave Airlie <airlied@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC PATCH] move drm to pci_request_irq
Message-ID: <20061003071733.GA2785@slug>
References: <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org> <1159755141.2891.434.camel@laptopd505.fenrus.org> <20061002200048.GC3003@slug> <20061002201229.GF3003@slug> <21d7e9970610021654j6f443feay67a11121d1d8a716@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970610021654j6f443feay67a11121d1d8a716@mail.gmail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 09:54:07AM +1000, Dave Airlie wrote:
> On 10/3/06, Frederik Deweerdt <deweerdt@free.fr> wrote:
> >Hi,
> >
> >This proof-of-concept patch converts the drm driver to use the
> >pci_request_irq() function.
> 
> NAK.
> Wow nice CC'list and no DRM maintainer in sight :-)
:), this was just meant as an illustration of the needed modifications
to use pci_request_irq.
> 
> This will break framebuffer drivers, the DRM is not a proper PCI
> device driver as we don't have PCI device sharing, take a look at the
> gpu-2.6.git tree on kernel.org for the "correct" solution, which needs
> more attention before merging..
I'll look, thanks,
Frederik
> 
> Dave.
> >
> >Regards,
> >Frederik
> >
> >
> >
> >diff --git a/drivers/char/drm/drm_drv.c b/drivers/char/drm/drm_drv.c
> >index b366c5b..5b000cd 100644
> >--- a/drivers/char/drm/drm_drv.c
> >+++ b/drivers/char/drm/drm_drv.c
> >@@ -234,6 +234,8 @@ int drm_lastclose(drm_device_t * dev)
> >        }
> >        mutex_unlock(&dev->struct_mutex);
> >
> >+       pci_set_drvdata(dev, NULL);
> >+
> >        DRM_DEBUG("lastclose completed\n");
> >        return 0;
> > }
> >diff --git a/drivers/char/drm/drm_irq.c b/drivers/char/drm/drm_irq.c
> >index 4553a3a..5dd12cb 100644
> >--- a/drivers/char/drm/drm_irq.c
> >+++ b/drivers/char/drm/drm_irq.c
> >@@ -132,8 +132,10 @@ static int drm_irq_install(drm_device_t
> >        if (drm_core_check_feature(dev, DRIVER_IRQ_SHARED))
> >                sh_flags = IRQF_SHARED;
> >
> >-       ret = request_irq(dev->irq, dev->driver->irq_handler,
> >-                         sh_flags, dev->devname, dev);
> >+       pci_set_drvdata(dev->pdev, dev);
> >+
> >+       ret = pci_request_irq(dev->pdev, dev->driver->irq_handler,
> >+                         sh_flags, dev->devname);
> >        if (ret < 0) {
> >                mutex_lock(&dev->struct_mutex);
> >                dev->irq_enabled = 0;
> >@@ -173,7 +175,7 @@ int drm_irq_uninstall(drm_device_t * dev
> >
> >        dev->driver->irq_uninstall(dev);
> >
> >-       free_irq(dev->irq, dev);
> >+       pci_free_irq(dev->pdev);
> >
> >        return 0;
> > }
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
