Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273909AbTHFCqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 22:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274723AbTHFCqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 22:46:12 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:17537 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S273909AbTHFCp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 22:45:58 -0400
Date: Tue, 5 Aug 2003 22:14:15 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP Updates for 2.6.0-test2
Message-ID: <20030805221415.GB13275@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/08/05	ambx1@neo.rr.com	1.1107
#   [PNP] Handle unset resources properly
# 
#   This patch is similar to the disabled resource patch in that it
#   avoids direct numeric comparisons with data in unset resource
#   structures.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	Tue Aug  5 21:25:12 2003
+++ b/drivers/pnp/manager.c	Tue Aug  5 21:25:12 2003
@@ -45,7 +45,8 @@
 	flags = &dev->res.port_resource[idx].flags;
 
 	/* set the initial values */
-	*flags = *flags | rule->flags | IORESOURCE_IO;
+	*flags |= rule->flags | IORESOURCE_IO;
+	*flags &=  ~IORESOURCE_UNSET;
 
 	if (!rule->size) {
 		*flags |= IORESOURCE_DISABLED;
@@ -87,7 +88,8 @@
 	flags = &dev->res.mem_resource[idx].flags;
 
 	/* set the initial values */
-	*flags = *flags | rule->flags | IORESOURCE_MEM;
+	*flags |= rule->flags | IORESOURCE_MEM;
+	*flags &=  ~IORESOURCE_UNSET;
 
 	/* convert pnp flags to standard Linux flags */
 	if (!(rule->flags & IORESOURCE_MEM_WRITEABLE))
@@ -145,7 +147,8 @@
 	flags = &dev->res.irq_resource[idx].flags;
 
 	/* set the initial values */
-	*flags = *flags | rule->flags | IORESOURCE_IRQ;
+	*flags |= rule->flags | IORESOURCE_IRQ;
+	*flags &=  ~IORESOURCE_UNSET;
 
 	if (!rule->map) {
 		*flags |= IORESOURCE_DISABLED;
@@ -190,7 +193,8 @@
 	flags = &dev->res.dma_resource[idx].flags;
 
 	/* set the initial values */
-	*flags = *flags | rule->flags | IORESOURCE_DMA;
+	*flags |= rule->flags | IORESOURCE_DMA;
+	*flags &=  ~IORESOURCE_UNSET;
 
 	if (!rule->map) {
 		*flags |= IORESOURCE_DISABLED;
@@ -219,25 +223,25 @@
 		table->irq_resource[idx].name = NULL;
 		table->irq_resource[idx].start = -1;
 		table->irq_resource[idx].end = -1;
-		table->irq_resource[idx].flags = IORESOURCE_AUTO;
+		table->irq_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
 		table->dma_resource[idx].name = NULL;
 		table->dma_resource[idx].start = -1;
 		table->dma_resource[idx].end = -1;
-		table->dma_resource[idx].flags = IORESOURCE_AUTO;
+		table->dma_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
 		table->port_resource[idx].name = NULL;
 		table->port_resource[idx].start = 0;
 		table->port_resource[idx].end = 0;
-		table->port_resource[idx].flags = IORESOURCE_AUTO;
+		table->port_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
 		table->mem_resource[idx].name = NULL;
 		table->mem_resource[idx].start = 0;
 		table->mem_resource[idx].end = 0;
-		table->mem_resource[idx].flags = IORESOURCE_AUTO;
+		table->mem_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 }
 
@@ -254,28 +258,28 @@
 			continue;
 		res->irq_resource[idx].start = -1;
 		res->irq_resource[idx].end = -1;
-		res->irq_resource[idx].flags = IORESOURCE_AUTO;
+		res->irq_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_DMA; idx++) {
 		if (!(res->dma_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
 		res->dma_resource[idx].start = -1;
 		res->dma_resource[idx].end = -1;
-		res->dma_resource[idx].flags = IORESOURCE_AUTO;
+		res->dma_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_PORT; idx++) {
 		if (!(res->port_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
 		res->port_resource[idx].start = 0;
 		res->port_resource[idx].end = 0;
-		res->port_resource[idx].flags = IORESOURCE_AUTO;
+		res->port_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 	for (idx = 0; idx < PNP_MAX_MEM; idx++) {
 		if (!(res->mem_resource[idx].flags & IORESOURCE_AUTO))
 			continue;
 		res->mem_resource[idx].start = 0;
 		res->mem_resource[idx].end = 0;
-		res->mem_resource[idx].flags = IORESOURCE_AUTO;
+		res->mem_resource[idx].flags = IORESOURCE_AUTO | IORESOURCE_UNSET;
 	}
 }
 
diff -Nru a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Tue Aug  5 21:25:12 2003
+++ b/drivers/pnp/resource.c	Tue Aug  5 21:25:12 2003
@@ -252,7 +252,7 @@
 	end = &dev->res.port_resource[idx].end;
 
 	/* if the resource doesn't exist, don't complain about it */
-	if (dev->res.port_resource[idx].start == 0)
+	if (dev->res.port_resource[idx].flags & IORESOURCE_UNSET)
 		return 1;
 
 	/* check if the resource is already in use, skip if the
@@ -308,7 +308,7 @@
 	end = &dev->res.mem_resource[idx].end;
 
 	/* if the resource doesn't exist, don't complain about it */
-	if (dev->res.mem_resource[idx].start == 0)
+	if (dev->res.mem_resource[idx].flags & IORESOURCE_UNSET)
 		return 1;
 
 	/* check if the resource is already in use, skip if the
@@ -367,7 +367,7 @@
 	unsigned long * irq = &dev->res.irq_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
-	if (dev->res.irq_resource[idx].start == -1)
+	if (dev->res.irq_resource[idx].flags & IORESOURCE_UNSET)
 		return 1;
 
 	/* check if the resource is valid */
@@ -431,7 +431,7 @@
 	unsigned long * dma = &dev->res.dma_resource[idx].start;
 
 	/* if the resource doesn't exist, don't complain about it */
-	if (dev->res.dma_resource[idx].start == -1)
+	if (dev->res.dma_resource[idx].flags & IORESOURCE_UNSET)
 		return 1;
 
 	/* check if the resource is valid */
