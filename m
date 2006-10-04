Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWJDTpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWJDTpU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWJDTpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:45:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:63277 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750945AbWJDTpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:45:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=G/1tTsSyY4sZjttr0zazGQ2WuDVDrLBlcnnr/ZK63ayJsSDlz0iKooN6MtY0uy/kGgw9KjJInevVOCnh+dHQ0Pq8M/HTKLXmE6fcjgu3PWCvsNicIFyLjt9102eOfSVvuS8i7mx4rcmM+1R4pJfJO1+B77x/Vkqgh3bhE06xT1E=
Date: Wed, 4 Oct 2006 19:44:55 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: linux-kernel@vger.kernel.org
Cc: arjan@infradead.org, matthew@wil.cx, alan@lxorguk.ukuu.org.uk,
       jeff@garzik.org, akpm@osdl.org, rdunlap@xenotime.net, gregkh@suse.de
Subject: [RFC PATCH] move aic79xx to pci_request_irq
Message-ID: <20061004194455.GC352@slug>
References: <20061004193229.GA352@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004193229.GA352@slug>
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
 drivers/scsi/aic7xxx/aic79xx_osm.h     |    1 -
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c |   13 -------------
 drivers/scsi/aic7xxx/aic79xx_pci.c     |   12 ++++++++++--
 3 files changed, 10 insertions(+), 16 deletions(-)

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
+				 0, "aic79xx");
+	if (!error) {
+		ahd->platform_data->irq = ahd->dev_softc->irq;
 		ahd->init_level++;
+	}
+
 	return error;
 }
 
