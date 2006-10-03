Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030606AbWJCWTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030606AbWJCWTi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030607AbWJCWTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:19:38 -0400
Received: from hu-out-0506.google.com ([72.14.214.230]:50708 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030606AbWJCWTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:19:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=qrqLWtPlOJOTycMvvJVAWy/oizPHBSGX/KA8/1KcRJOX+nTjd1vbSxDY3D0RqNoJyTx1xAg4B6DDK7Hp/bdFATiaxekQwf8sl13rG4L24FBmTLX3cIQIrPFOCvVbeEbgV6MWutjlurzD3zhG/WUKbbn46YrM6PrG1DypH78lkc8=
Date: Tue, 3 Oct 2006 22:19:17 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: linux-kernel@vger.kernel.org
Cc: arjan@infradead.org, matthew@wil.cx, alan@lxorguk.ukuu.org.uk,
       jeff@garzik.org, akpm@osdl.org, rdunlap@xenotime.net, gregkh@suse.de
Subject: [RFC PATCH] move aic79xx to pci_request_irq
Message-ID: <20061003221917.GG2785@slug>
References: <20061003220732.GE2785@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003220732.GE2785@slug>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This proof-of-concept patch converts the aic79xx driver to use the
pci_request_irq() function.

Please note that I'm not submitting the driver changes, they're there
only for illustration purposes. I'll CC the appropriate maintainers
when/if an API is agreed upon.

Regards,
Frederik 


diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.h b/drivers/scsi/aic7xxx/aic79xx_osm.h
index 448c39c..67897d4 100644
Index: 2.6.18-mm3/drivers/scsi/aic7xxx/aic79xx_osm.h
===================================================================
--- 2.6.18-mm3.orig/drivers/scsi/aic7xxx/aic79xx_osm.h
+++ 2.6.18-mm3/drivers/scsi/aic7xxx/aic79xx_osm.h
@@ -594,7 +594,6 @@ void ahd_power_state_change(struct ahd_s
 int			 ahd_linux_pci_init(void);
 void			 ahd_linux_pci_exit(void);
 int			 ahd_pci_map_registers(struct ahd_softc *ahd);
-int			 ahd_pci_map_int(struct ahd_softc *ahd);
 
 static __inline uint32_t ahd_pci_read_config(ahd_dev_softc_t pci,
 					     int reg, int width);
Index: 2.6.18-mm3/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
===================================================================
--- 2.6.18-mm3.orig/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
+++ 2.6.18-mm3/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
@@ -336,19 +336,6 @@ ahd_pci_map_registers(struct ahd_softc *
 	return (error);
 }
 
-int
-ahd_pci_map_int(struct ahd_softc *ahd)
-{
-	int error;
-
-	error = request_irq(ahd->dev_softc->irq, ahd_linux_isr,
-			    IRQF_SHARED, "aic79xx", ahd);
-	if (!error)
-		ahd->platform_data->irq = ahd->dev_softc->irq;
-	
-	return (-error);
-}
-
 void
 ahd_power_state_change(struct ahd_softc *ahd, ahd_power_state new_state)
 {
Index: 2.6.18-mm3/drivers/scsi/aic7xxx/aic79xx_pci.c
===================================================================
--- 2.6.18-mm3.orig/drivers/scsi/aic7xxx/aic79xx_pci.c
+++ 2.6.18-mm3/drivers/scsi/aic7xxx/aic79xx_pci.c
@@ -376,10 +376,18 @@ ahd_pci_config(struct ahd_softc *ahd, st
 
 	/*
 	 * Allow interrupts now that we are completely setup.
+	 *
+	 * Note: pci_request_irq return value is negated due to aic79xx
+	 * error handling style
 	 */
-	error = ahd_pci_map_int(ahd);
-	if (!error)
+
+	error = -pci_request_irq(ahd->dev_softc, ahd_linux_isr,
+				 IRQF_SHARED, "aic79xx");
+	if (!error) {
+		ahd->platform_data->irq = ahd->dev_softc->irq;
 		ahd->init_level++;
+	}
+
 	return error;
 }
 
