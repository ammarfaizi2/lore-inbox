Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWJDToT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWJDToT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWJDToT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:44:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:18732 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750938AbWJDToS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:44:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=fQiQmtREh0V4/8had94VgHrqWtHUrvMpVBZik8aLWtTnae1L8BhE3Ti3M/WxjhStciJanNflLAL+IPex+WMrSkbVzQdTFScVmF8lbw7bp7bcrjlc/jRD5VQCCLBUIJX5ji+JqZP64WU+WUCeBQQ+ucjgDwz7bT4ILm9ESElBMOY=
Date: Wed, 4 Oct 2006 19:43:57 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: linux-kernel@vger.kernel.org
Cc: arjan@infradead.org, matthew@wil.cx, alan@lxorguk.ukuu.org.uk,
       jeff@garzik.org, akpm@osdl.org, rdunlap@xenotime.net, gregkh@suse.de
Subject: [RFC PATCH] move aic7xxx to pci_request_irq
Message-ID: <20061004194357.GB352@slug>
References: <20061004193229.GA352@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004193229.GA352@slug>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This proof-of-concept patch converts the aic7xxx driver to use the
pci_request_irq() function.

Please note that I'm not submitting the driver changes, they're there
only for illustration purposes. I'll CC the appropriate maintainers
when/if an API is agreed upon.

Regards,
Frederik



diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.h b/drivers/scsi/aic7xxx/aic7xxx_osm.h
index 86ea7ac..24f70bc 100644
 drivers/scsi/aic7xxx/aic7xxx_osm.h     |    1 -
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |   13 -------------
 drivers/scsi/aic7xxx/aic7xxx_pci.c     |   18 ++++++++++++------
 3 files changed, 12 insertions(+), 20 deletions(-)

Index: 2.6.18-mm3/drivers/scsi/aic7xxx/aic7xxx_osm.h
===================================================================
--- 2.6.18-mm3.orig/drivers/scsi/aic7xxx/aic7xxx_osm.h
+++ 2.6.18-mm3/drivers/scsi/aic7xxx/aic7xxx_osm.h
@@ -561,7 +561,6 @@ static inline void	ahc_linux_eisa_exit(v
 int			 ahc_linux_pci_init(void);
 void			 ahc_linux_pci_exit(void);
 int			 ahc_pci_map_registers(struct ahc_softc *ahc);
-int			 ahc_pci_map_int(struct ahc_softc *ahc);
 
 static __inline uint32_t ahc_pci_read_config(ahc_dev_softc_t pci,
 					     int reg, int width);
Index: 2.6.18-mm3/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
===================================================================
--- 2.6.18-mm3.orig/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
+++ 2.6.18-mm3/drivers/scsi/aic7xxx/aic7xxx_osm_pci.c
@@ -368,16 +368,3 @@ ahc_pci_map_registers(struct ahc_softc *
 	return (error);
 }
 
-int
-ahc_pci_map_int(struct ahc_softc *ahc)
-{
-	int error;
-
-	error = request_irq(ahc->dev_softc->irq, ahc_linux_isr,
-			    IRQF_SHARED, "aic7xxx", ahc);
-	if (error == 0)
-		ahc->platform_data->irq = ahc->dev_softc->irq;
-	
-	return (-error);
-}
-
Index: 2.6.18-mm3/drivers/scsi/aic7xxx/aic7xxx_pci.c
===================================================================
--- 2.6.18-mm3.orig/drivers/scsi/aic7xxx/aic7xxx_pci.c
+++ 2.6.18-mm3/drivers/scsi/aic7xxx/aic7xxx_pci.c
@@ -968,13 +968,19 @@ ahc_pci_config(struct ahc_softc *ahc, st
 
 	/*
 	 * Allow interrupts now that we are completely setup.
-	 */
-	error = ahc_pci_map_int(ahc);
-	if (error != 0)
-		return (error);
+	 *
+	 * Note: pci_request_irq return value is negated due to aic7xxx
+	 * error handling style
+	 */
+	error = -pci_request_irq(ahc->dev_softc, ahc_linux_isr,
+				 0, "aic7xxx");
+
+	if (!error) {
+		ahc->platform_data->irq = ahc->dev_softc->irq;
+		ahc->init_level++;
+	}
 
-	ahc->init_level++;
-	return (0);
+	return error;
 }
 
 /*
