Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266470AbUA3FNJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266524AbUA3FNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:13:08 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:50308 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266470AbUA3FLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:11:24 -0500
Date: Thu, 29 Jan 2004 23:56:13 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.2-rc2
Message-ID: <20040129235613.GC12308@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040129235304.GA12308@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129235304.GA12308@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reorganizes resource flags to ensure that manual resource settings
are properly recognized.  This fix is necessary for many ALSA drivers.  It also
prevents comparisons between unset resource structures.  The bug was discovered 
by Rene Herman <rene.herman@keyaccess.nl>, who also wrote an initial version of 
this patch.  I made further improvements to ensure that the pnp subsystem was
compatible with this initial change.

diff -urN a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
--- a/drivers/pnp/isapnp/core.c	2004-01-09 06:59:43.000000000 +0000
+++ b/drivers/pnp/isapnp/core.c	2004-01-17 21:46:00.000000000 +0000
@@ -1039,17 +1039,17 @@
 
 	isapnp_cfg_begin(dev->card->number, dev->number);
 	dev->active = 1;
-	for (tmp = 0; tmp < PNP_MAX_PORT && res->port_resource[tmp].flags & IORESOURCE_IO; tmp++)
+	for (tmp = 0; tmp < PNP_MAX_PORT && (res->port_resource[tmp].flags & (IORESOURCE_IO | IORESOURCE_UNSET)) == IORESOURCE_IO; tmp++)
 		isapnp_write_word(ISAPNP_CFG_PORT+(tmp<<1), res->port_resource[tmp].start);
-	for (tmp = 0; tmp < PNP_MAX_IRQ && res->irq_resource[tmp].flags & IORESOURCE_IRQ; tmp++) {
+	for (tmp = 0; tmp < PNP_MAX_IRQ && (res->irq_resource[tmp].flags & (IORESOURCE_IRQ | IORESOURCE_UNSET)) == IORESOURCE_IRQ; tmp++) {
 		int irq = res->irq_resource[tmp].start;
 		if (irq == 2)
 			irq = 9;
 		isapnp_write_byte(ISAPNP_CFG_IRQ+(tmp<<1), irq);
 	}
-	for (tmp = 0; tmp < PNP_MAX_DMA && res->dma_resource[tmp].flags & IORESOURCE_DMA; tmp++)
+	for (tmp = 0; tmp < PNP_MAX_DMA && (res->dma_resource[tmp].flags & (IORESOURCE_DMA | IORESOURCE_UNSET)) == IORESOURCE_DMA; tmp++)
 		isapnp_write_byte(ISAPNP_CFG_DMA+tmp, res->dma_resource[tmp].start);
-	for (tmp = 0; tmp < PNP_MAX_MEM && res->mem_resource[tmp].flags & IORESOURCE_MEM; tmp++)
+	for (tmp = 0; tmp < PNP_MAX_MEM && (res->mem_resource[tmp].flags & (IORESOURCE_MEM | IORESOURCE_UNSET)) == IORESOURCE_MEM; tmp++)
 		isapnp_write_word(ISAPNP_CFG_MEM+(tmp<<2), (res->mem_resource[tmp].start >> 8) & 0xffff);
 	/* FIXME: We aren't handling 32bit mems properly here */
 	isapnp_activate(dev->number);
diff -urN a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	2004-01-09 07:00:04.000000000 +0000
+++ b/drivers/pnp/manager.c	2004-01-17 21:45:05.000000000 +0000
@@ -223,25 +223,25 @@
 		table->irq_resource[idx].name = NULL;
 		table->irq_resource[idx].start = -1;
 		table->irq_resource[idx].end = -1;
-		table->irq_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
+		table->irq_resource[idx].flags = IORESOURCE_IRQ | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
 		table->dma_resource[idx].name = NULL;
 		table->dma_resource[idx].start = -1;
 		table->dma_resource[idx].end = -1;
-		table->dma_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
+		table->dma_resource[idx].flags = IORESOURCE_DMA | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
 		table->port_resource[idx].name = NULL;
 		table->port_resource[idx].start = 0;
 		table->port_resource[idx].end = 0;
-		table->port_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
+		table->port_resource[idx].flags = IORESOURCE_IO | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
 		table->mem_resource[idx].name = NULL;
 		table->mem_resource[idx].start = 0;
 		table->mem_resource[idx].end = 0;
-		table->mem_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
+		table->mem_resource[idx].flags = IORESOURCE_MEM | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 }
 
@@ -258,28 +258,28 @@
 			continue;
 		res->irq_resource[idx].start = -1;
 		res->irq_resource[idx].end = -1;
-		res->irq_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
+		res->irq_resource[idx].flags = IORESOURCE_IRQ | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
 		if (!(res->dma_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
 		res->dma_resource[idx].start = -1;
 		res->dma_resource[idx].end = -1;
-		res->dma_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
+		res->dma_resource[idx].flags = IORESOURCE_DMA | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
 		if (!(res->port_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
 		res->port_resource[idx].start = 0;
 		res->port_resource[idx].end = 0;
-		res->port_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
+		res->port_resource[idx].flags = IORESOURCE_IO | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
 		if (!(res->mem_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
 		res->mem_resource[idx].start = 0;
 		res->mem_resource[idx].end = 0;
-		res->mem_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
+		res->mem_resource[idx].flags = IORESOURCE_MEM | IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 }
 
@@ -550,7 +550,7 @@
 {
 	if (resource == NULL)
 		return;
-	resource->flags &= ~IORESOURCE_AUTO;
+	resource->flags &= ~(IORESOURCE_AUTO | IORESOURCE_UNSET);
 	resource->start = start;
 	resource->end = start + size - 1;
 }
diff -urN a/drivers/pnp/pnpbios/rsparser.c b/drivers/pnp/pnpbios/rsparser.c
--- a/drivers/pnp/pnpbios/rsparser.c	2004-01-09 06:59:26.000000000 +0000
+++ b/drivers/pnp/pnpbios/rsparser.c	2004-01-17 21:45:05.000000000 +0000
@@ -49,7 +49,7 @@
 pnpbios_parse_allocated_irqresource(struct pnp_resource_table * res, int irq)
 {
 	int i = 0;
-	while ((res->irq_resource[i].flags & IORESOURCE_IRQ) && i < PNP_MAX_IRQ) i++;
+	while (!(res->irq_resource[i].flags & IORESOURCE_UNSET) && i < PNP_MAX_IRQ) i++;
 	if (i < PNP_MAX_IRQ) {
 		res->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
 		if (irq == -1) {
@@ -65,7 +65,7 @@
 pnpbios_parse_allocated_dmaresource(struct pnp_resource_table * res, int dma)
 {
 	int i = 0;
-	while ((res->dma_resource[i].flags & IORESOURCE_DMA) && i < PNP_MAX_DMA) i++;
+	while (!(res->dma_resource[i].flags & IORESOURCE_UNSET) && i < PNP_MAX_DMA) i++;
 	if (i < PNP_MAX_DMA) {
 		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
 		if (dma == -1) {
@@ -81,7 +81,7 @@
 pnpbios_parse_allocated_ioresource(struct pnp_resource_table * res, int io, int len)
 {
 	int i = 0;
-	while ((res->port_resource[i].flags & IORESOURCE_IO) && i < PNP_MAX_PORT) i++;
+	while (!(res->port_resource[i].flags & IORESOURCE_UNSET) && i < PNP_MAX_PORT) i++;
 	if (i < PNP_MAX_PORT) {
 		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
 		if (len <= 0 || (io + len -1) >= 0x10003) {
@@ -97,7 +97,7 @@
 pnpbios_parse_allocated_memresource(struct pnp_resource_table * res, int mem, int len)
 {
 	int i = 0;
-	while ((res->mem_resource[i].flags & IORESOURCE_MEM) && i < PNP_MAX_MEM) i++;
+	while (!(res->mem_resource[i].flags & IORESOURCE_UNSET) && i < PNP_MAX_MEM) i++;
 	if (i < PNP_MAX_MEM) {
 		res->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
 		if (len <= 0) {
diff -urN a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	2004-01-09 06:59:44.000000000 +0000
+++ b/drivers/pnp/resource.c	2004-01-17 21:45:05.000000000 +0000
@@ -241,6 +241,9 @@
  (*(enda) >= *(startb) && *(enda) <= *(endb)) || \
  (*(starta) < *(startb) && *(enda) > *(endb)))
 
+#define cannot_compare(flags) \
+((flags) & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
+
 int pnp_check_port(struct pnp_dev * dev, int idx)
 {
 	int tmp;
@@ -250,7 +253,7 @@
 	end = &dev->res.port_resource[idx].end;
 
 	/* if the resource doesn't exist, don't complain about it */
-	if (dev->res.port_resource[idx].flags & IORESOURCE_UNSET)
+	if (cannot_compare(dev->res.port_resource[idx].flags))
 		return 1;
 
 	/* check if the resource is already in use, skip if the
@@ -284,7 +287,7 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_PORT; tmp++) {
 			if (tdev->res.port_resource[tmp].flags & IORESOURCE_IO) {
-				if (pnp_port_flags(dev, tmp) & IORESOURCE_DISABLED)
+				if (cannot_compare(tdev->res.port_resource[tmp].flags))
 					continue;
 				tport = &tdev->res.port_resource[tmp].start;
 				tend = &tdev->res.port_resource[tmp].end;
@@ -306,7 +309,7 @@
 	end = &dev->res.mem_resource[idx].end;
 
 	/* if the resource doesn't exist, don't complain about it */
-	if (dev->res.mem_resource[idx].flags & IORESOURCE_UNSET)
+	if (cannot_compare(dev->res.mem_resource[idx].flags))
 		return 1;
 
 	/* check if the resource is already in use, skip if the
@@ -340,7 +343,7 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
 			if (tdev->res.mem_resource[tmp].flags & IORESOURCE_MEM) {
-				if (pnp_mem_flags(dev, tmp) & IORESOURCE_DISABLED)
+				if (cannot_compare(tdev->res.mem_resource[tmp].flags))
 					continue;
 				taddr = &tdev->res.mem_resource[tmp].start;
 				tend = &tdev->res.mem_resource[tmp].end;
@@ -365,7 +368,7 @@
 	unsigned long * irq = &dev->res.irq_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
-	if (dev->res.irq_resource[idx].flags & IORESOURCE_UNSET)
+	if (cannot_compare(dev->res.irq_resource[idx].flags))
 		return 1;
 
 	/* check if the resource is valid */
@@ -411,7 +414,7 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
 			if (tdev->res.irq_resource[tmp].flags & IORESOURCE_IRQ) {
-				if (pnp_irq_flags(dev, tmp) & IORESOURCE_DISABLED)
+				if (cannot_compare(tdev->res.irq_resource[tmp].flags))
 					continue;
 				if ((tdev->res.irq_resource[tmp].start == *irq))
 					return 0;
@@ -429,7 +432,7 @@
 	unsigned long * dma = &dev->res.dma_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
-	if (dev->res.dma_resource[idx].flags & IORESOURCE_UNSET)
+	if (cannot_compare(dev->res.dma_resource[idx].flags))
 		return 1;
 
 	/* check if the resource is valid */
@@ -464,7 +467,7 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
 			if (tdev->res.dma_resource[tmp].flags & IORESOURCE_DMA) {
-				if (pnp_dma_flags(dev, tmp) & IORESOURCE_DISABLED)
+				if (cannot_compare(tdev->res.dma_resource[tmp].flags))
 					continue;
 				if ((tdev->res.dma_resource[tmp].start == *dma))
 					return 0;
diff -urN a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	2004-01-09 07:00:12.000000000 +0000
+++ b/include/linux/pnp.h	2004-01-17 21:46:00.000000000 +0000
@@ -33,7 +33,9 @@
 #define pnp_port_start(dev,bar)   ((dev)->res.port_resource[(bar)].start)
 #define pnp_port_end(dev,bar)     ((dev)->res.port_resource[(bar)].end)
 #define pnp_port_flags(dev,bar)   ((dev)->res.port_resource[(bar)].flags)
-#define pnp_port_valid(dev,bar)   (pnp_port_flags((dev),(bar)) & IORESOURCE_IO)
+#define pnp_port_valid(dev,bar) \
+	((pnp_port_flags((dev),(bar)) & (IORESOURCE_IO | IORESOURCE_UNSET)) \
+		== IORESOURCE_IO)
 #define pnp_port_len(dev,bar) \
 	((pnp_port_start((dev),(bar)) == 0 &&	\
 	  pnp_port_end((dev),(bar)) ==		\
@@ -45,7 +47,9 @@
 #define pnp_mem_start(dev,bar)   ((dev)->res.mem_resource[(bar)].start)
 #define pnp_mem_end(dev,bar)     ((dev)->res.mem_resource[(bar)].end)
 #define pnp_mem_flags(dev,bar)   ((dev)->res.mem_resource[(bar)].flags)
-#define pnp_mem_valid(dev,bar)   (pnp_mem_flags((dev),(bar)) & IORESOURCE_MEM)
+#define pnp_mem_valid(dev,bar) \
+	((pnp_mem_flags((dev),(bar)) & (IORESOURCE_MEM | IORESOURCE_UNSET)) \
+		== IORESOURCE_MEM)
 #define pnp_mem_len(dev,bar) \
 	((pnp_mem_start((dev),(bar)) == 0 &&	\
 	  pnp_mem_end((dev),(bar)) ==		\
@@ -56,11 +60,15 @@
 
 #define pnp_irq(dev,bar)	 ((dev)->res.irq_resource[(bar)].start)
 #define pnp_irq_flags(dev,bar)	 ((dev)->res.irq_resource[(bar)].flags)
-#define pnp_irq_valid(dev,bar)   (pnp_irq_flags((dev),(bar)) & IORESOURCE_IRQ)
+#define pnp_irq_valid(dev,bar) \
+	((pnp_irq_flags((dev),(bar)) & (IORESOURCE_IRQ | IORESOURCE_UNSET)) \
+		== IORESOURCE_IRQ)
 
 #define pnp_dma(dev,bar)	 ((dev)->res.dma_resource[(bar)].start)
 #define pnp_dma_flags(dev,bar)	 ((dev)->res.dma_resource[(bar)].flags)
-#define pnp_dma_valid(dev,bar)   (pnp_dma_flags((dev),(bar)) & IORESOURCE_DMA)
+#define pnp_dma_valid(dev,bar) \
+	((pnp_dma_flags((dev),(bar)) & (IORESOURCE_DMA | IORESOURCE_UNSET)) \
+		== IORESOURCE_DMA)
 
 #define PNP_PORT_FLAG_16BITADDR	(1<<0)
 #define PNP_PORT_FLAG_FIXED	(1<<1)
