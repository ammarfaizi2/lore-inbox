Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261335AbTCGDjp>; Thu, 6 Mar 2003 22:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbTCGDjp>; Thu, 6 Mar 2003 22:39:45 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:60809 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S261335AbTCGDjn>;
	Thu, 6 Mar 2003 22:39:43 -0500
Date: Thu, 6 Mar 2003 22:52:44 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] PnP/ALSA - Manual Resource Setting Updates (2/3)
Message-ID: <20030306225244.GA28436@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaroslav,

This patch updates the manual resource setting code to allow for partial manual 
setting of resources as needed by ALSA.

I would appreciate any comments.

Thanks,
Adam


diff -urN a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	Mon Feb 24 19:05:46 2003
+++ b/drivers/pnp/manager.c	Thu Mar  6 15:16:30 2003
@@ -532,6 +532,39 @@
 	return error;
 }

+static void pnp_process_manual_resources(struct pnp_resource_table * ctab, struct pnp_resource_table * ntab)
+{
+	int idx;
+	for (idx = 0; idx < PNP_MAX_IRQ; idx++) {
+		if (ntab->irq_resource[idx].flags & IORESOURCE_AUTO)
+			continue;
+		ctab->irq_resource[idx].start = ntab->irq_resource[idx].start;
+		ctab->irq_resource[idx].end = ntab->irq_resource[idx].end;
+		ctab->irq_resource[idx].flags = ntab->irq_resource[idx].flags;
+	}
+	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
+		if (ntab->dma_resource[idx].flags & IORESOURCE_AUTO)
+			continue;
+		ctab->dma_resource[idx].start = ntab->dma_resource[idx].start;
+		ctab->dma_resource[idx].end = ntab->dma_resource[idx].end;
+		ctab->dma_resource[idx].flags = ntab->dma_resource[idx].flags;
+	}
+	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
+		if (ntab->port_resource[idx].flags & IORESOURCE_AUTO)
+			continue;
+		ctab->port_resource[idx].start = ntab->port_resource[idx].start;
+		ctab->port_resource[idx].end = ntab->port_resource[idx].end;
+		ctab->port_resource[idx].flags = ntab->port_resource[idx].flags;
+	}
+	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
+		if (ntab->irq_resource[idx].flags & IORESOURCE_AUTO)
+			continue;
+		ctab->irq_resource[idx].start = ntab->mem_resource[idx].start;
+		ctab->irq_resource[idx].end = ntab->mem_resource[idx].end;
+		ctab->irq_resource[idx].flags = ntab->mem_resource[idx].flags;
+	}
+}
+
 /**
  * pnp_manual_config_dev - Disables Auto Config and Manually sets the resource table
  * @dev: pointer to the desired device
@@ -554,7 +587,7 @@
 	*bak = dev->res;
 
 	spin_lock(&pnp_lock);
-	dev->res = *res;
+	pnp_process_manual_resources(&dev->res, res);
 	if (!(mode & PNP_CONFIG_FORCE)) {
 		for (i = 0; i < PNP_MAX_PORT; i++) {
 			if(pnp_check_port(dev,i))
@@ -681,7 +714,7 @@
 		return -1;
 	}
 	dev->active = 0; /* just in case the protocol doesn't do this */
-	pnp_dbg("the device '%s' has been disabled.", dev->dev.bus_id);
+	pnp_dbg("res: the device '%s' has been disabled.", dev->dev.bus_id);
 	return 0;
 }
 
diff -urN a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Mon Feb 24 19:05:34 2003
+++ b/drivers/pnp/resource.c	Wed Mar  5 21:33:00 2003
@@ -558,25 +558,25 @@
 		table->irq_resource[idx].name = NULL;
 		table->irq_resource[idx].start = -1;
 		table->irq_resource[idx].end = -1;
-		table->irq_resource[idx].flags = 0;
+		table->irq_resource[idx].flags = IORESOURCE_AUTO;
 	}
 	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
 		table->dma_resource[idx].name = NULL;
 		table->dma_resource[idx].start = -1;
 		table->dma_resource[idx].end = -1;
-		table->dma_resource[idx].flags = 0;
+		table->dma_resource[idx].flags = IORESOURCE_AUTO;
 	}
 	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
 		table->port_resource[idx].name = NULL;
 		table->port_resource[idx].start = 0;
 		table->port_resource[idx].end = 0;
-		table->port_resource[idx].flags = 0;
+		table->port_resource[idx].flags = IORESOURCE_AUTO;
 	}
 	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
 		table->mem_resource[idx].name = NULL;
 		table->mem_resource[idx].start = 0;
 		table->mem_resource[idx].end = 0;
-		table->mem_resource[idx].flags = 0;
+		table->mem_resource[idx].flags = IORESOURCE_AUTO;
 	}
 }
 
