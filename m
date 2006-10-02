Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbWJBSN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbWJBSN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbWJBSN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:13:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:48755 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965210AbWJBSNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:13:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=opPdKZiGhMjrZwehPZvuBpWZJUTh95aKJFp9ETtghjV/OFU2cIicibXnTtTlg9zlJflcp98e+IZZYMv+NiX7L6IdTzodxiho45SSZF0+/oyDURBOHiUHAizrf12UXb3z9OcfAkgAFHzW12m/jMFXCCT8jouGrFjrr4ZLImc7M28=
Date: Mon, 2 Oct 2006 20:12:29 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: [RFC PATCH] move drm to pci_request_irq
Message-ID: <20061002201229.GF3003@slug>
References: <1159550143.13029.36.camel@localhost.localdomain> <20060929235054.GB2020@slug> <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org> <1159755141.2891.434.camel@laptopd505.fenrus.org> <20061002200048.GC3003@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002200048.GC3003@slug>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This proof-of-concept patch converts the drm driver to use the
pci_request_irq() function.

Regards,
Frederik



diff --git a/drivers/char/drm/drm_drv.c b/drivers/char/drm/drm_drv.c
index b366c5b..5b000cd 100644
--- a/drivers/char/drm/drm_drv.c
+++ b/drivers/char/drm/drm_drv.c
@@ -234,6 +234,8 @@ int drm_lastclose(drm_device_t * dev)
 	}
 	mutex_unlock(&dev->struct_mutex);
 
+	pci_set_drvdata(dev, NULL);
+
 	DRM_DEBUG("lastclose completed\n");
 	return 0;
 }
diff --git a/drivers/char/drm/drm_irq.c b/drivers/char/drm/drm_irq.c
index 4553a3a..5dd12cb 100644
--- a/drivers/char/drm/drm_irq.c
+++ b/drivers/char/drm/drm_irq.c
@@ -132,8 +132,10 @@ static int drm_irq_install(drm_device_t 
 	if (drm_core_check_feature(dev, DRIVER_IRQ_SHARED))
 		sh_flags = IRQF_SHARED;
 
-	ret = request_irq(dev->irq, dev->driver->irq_handler,
-			  sh_flags, dev->devname, dev);
+	pci_set_drvdata(dev->pdev, dev);
+
+	ret = pci_request_irq(dev->pdev, dev->driver->irq_handler,
+			  sh_flags, dev->devname);
 	if (ret < 0) {
 		mutex_lock(&dev->struct_mutex);
 		dev->irq_enabled = 0;
@@ -173,7 +175,7 @@ int drm_irq_uninstall(drm_device_t * dev
 
 	dev->driver->irq_uninstall(dev);
 
-	free_irq(dev->irq, dev);
+	pci_free_irq(dev->pdev);
 
 	return 0;
 }
