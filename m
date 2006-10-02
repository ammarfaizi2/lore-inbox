Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbWJBSIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbWJBSIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWJBSIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:08:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:43619 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965214AbWJBSIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:08:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=ba2ssgdlJSkGi2ow0DuPKmVkYODTmkKGerDgUtsXPzA0ZWYTVhDfxPj2SlChMdZ4cjstuVFxvXS4fr7OARxXFJRgT7rUjHvS7KUdfDm6YR9q75iS6SlT585ERYrwxxM72KloTWv0zV1LtqQzjm4f9mTnQmxtyreDIJxhQx+pnYM=
Date: Mon, 2 Oct 2006 20:07:03 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: [RFC PATCH] move aic7xxx to pci_request_irq
Message-ID: <20061002200703.GD3003@slug>
References: <1159550143.13029.36.camel@localhost.localdomain> <20060929235054.GB2020@slug> <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org> <1159755141.2891.434.camel@laptopd505.fenrus.org> <20061002200048.GC3003@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002200048.GC3003@slug>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This proof-of-concept patch converts the aic7xxx drivers to use the
pci_request_irq() function.

Regards,
Frederik


diff --git a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
index 2001fe8..c934f30 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
@@ -341,12 +341,12 @@ ahd_pci_map_int(struct ahd_softc *ahd)
 {
 	int error;
 
-	error = request_irq(ahd->dev_softc->irq, ahd_linux_isr,
-			    IRQF_SHARED, "aic79xx", ahd);
+	error = pci_request_irq(ahd->dev_softc, ahd_linux_isr,
+			    IRQF_SHARED, "aic79xx");
 	if (!error)
 		ahd->platform_data->irq = ahd->dev_softc->irq;
 	
-	return (-error);
+	return error;
 }
 
 void
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
index ea5687d..d5c402e 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
@@ -368,16 +368,14 @@ ahc_pci_map_registers(struct ahc_softc *
 	return (error);
 }
 
-int
-ahc_pci_map_int(struct ahc_softc *ahc)
+int ahc_pci_map_int(struct ahc_softc *ahc)
 {
 	int error;
 
-	error = request_irq(ahc->dev_softc->irq, ahc_linux_isr,
-			    IRQF_SHARED, "aic7xxx", ahc);
+	error = pci_request_irq(ahc->dev_softc, ahc_linux_isr, IRQF_SHARED,
+			    	"aic7xxx");
 	if (error == 0)
 		ahc->platform_data->irq = ahc->dev_softc->irq;
-	
-	return (-error);
-}
 
+	return error;
+}
