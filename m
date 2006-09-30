Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWI3MLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWI3MLL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 08:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWI3MLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 08:11:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:49642 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750926AbWI3MLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 08:11:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=mkAkhoi+8M5pGUadY0QS5Zge1oXYAwemEbYvCgma01bPLBEHtYLi0tyoOlIHQLKGqB0LXu1M/cvWdyDN8reltAnPBF4uAXbP/i/Y5D0bu5T0/UodOVxRVRS0306/YabiE3SsyNcX5CGzoDRXIwuTgO9S1W1mBQyS3SLBJW5y0kI=
Date: Sat, 30 Sep 2006 14:09:46 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, "J.A. Magall??n" <jamagallon@ono.com>,
       Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: [-mm patch] aic7xxx: check irq validity (was Re: 2.6.18-mm2)
Message-ID: <20060930140946.GA1195@slug>
References: <20060928014623.ccc9b885.akpm@osdl.org> <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org> <1159550143.13029.36.camel@localhost.localdomain> <20060929235054.GB2020@slug> <1159573404.13029.96.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159573404.13029.96.camel@localhost.localdomain>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 12:43:24AM +0100, Alan Cox wrote:
> Ar Gwe, 2006-09-29 am 23:50 +0000, ysgrifennodd Frederik Deweerdt:
> > Does this patch makes sense in that case? If yes, I'll put up a patch
> > for the remaining cases in the drivers/scsi/aic7xxx/ directory.
> > Also, aic7xxx's coding style would put parenthesis around the returned
> > value, should I follow it?
> 
> Yes - but perhaps with a warning message so users know why ?
> 
> As to coding style - kernel style is unbracketed so I wouldnt worry
> about either.
> 
Thanks for the advices. 

The following patch checks whenever the irq is valid before issuing a
request_irq() for AIC7XXX and AIC79XX. An error message is displayed to
let the user know what went wrong.

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
index 2001fe8..8279122 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
@@ -132,6 +132,11 @@ ahd_linux_pci_dev_probe(struct pci_dev *
 	char		*name;
 	int		 error;
 
+	if (!pdev->irq) {
+		printk(KERN_WARNING "aic79xx: No irq line set\n");
+		return -ENODEV;
+	}
+
 	pci = pdev;
 	entry = ahd_find_pci_device(pci);
 	if (entry == NULL)
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
index ea5687d..ca61cdb 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
@@ -185,6 +185,11 @@ ahc_linux_pci_dev_probe(struct pci_dev *
 	int		 error;
 	struct device	*dev = &pdev->dev;
 
+	if (!pdev->irq) {
+		printk(KERN_WARNING "aic7xxx: No irq line set\n");
+		return -ENODEV;
+	}
+
 	pci = pdev;
 	entry = ahc_find_pci_device(pci);
 	if (entry == NULL)
