Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbTGCW6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 18:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbTGCW43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:56:29 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:16780 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265489AbTGCWwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:52:36 -0400
Date: Thu, 3 Jul 2003 18:41:09 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP Fixes for 2.5.74
Message-ID: <20030703184109.GB31086@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN a/drivers/pnp/interface.c b/drivers/pnp/interface.c
--- a/drivers/pnp/interface.c	2003-07-03 00:24:32.000000000 +0000
+++ b/drivers/pnp/interface.c	2003-07-02 23:44:01.000000000 +0000
@@ -259,7 +259,10 @@
 	for (i = 0; i < PNP_MAX_PORT; i++) {
 		if (pnp_port_valid(dev, i)) {
 			pnp_printf(buffer,"io");
-			pnp_printf(buffer," 0x%lx-0x%lx \n",
+			if (pnp_port_flags(dev, i) & IORESOURCE_DISABLED)
+				pnp_printf(buffer," disabled\n");
+			else
+				pnp_printf(buffer," 0x%lx-0x%lx\n",
 						pnp_port_start(dev, i),
 						pnp_port_end(dev, i));
 		}
@@ -267,7 +270,10 @@
 	for (i = 0; i < PNP_MAX_MEM; i++) {
 		if (pnp_mem_valid(dev, i)) {
 			pnp_printf(buffer,"mem");
-			pnp_printf(buffer," 0x%lx-0x%lx \n",
+			if (pnp_mem_flags(dev, i) & IORESOURCE_DISABLED)
+				pnp_printf(buffer," disabled\n");
+			else
+				pnp_printf(buffer," 0x%lx-0x%lx\n",
 						pnp_mem_start(dev, i),
 						pnp_mem_end(dev, i));
 		}
@@ -275,13 +281,21 @@
 	for (i = 0; i < PNP_MAX_IRQ; i++) {
 		if (pnp_irq_valid(dev, i)) {
 			pnp_printf(buffer,"irq");
-			pnp_printf(buffer," %ld \n", pnp_irq(dev, i));
+			if (pnp_irq_flags(dev, i) & IORESOURCE_DISABLED)
+				pnp_printf(buffer," disabled\n");
+			else
+				pnp_printf(buffer," %ld\n",
+						pnp_irq(dev, i));
 		}
 	}
 	for (i = 0; i < PNP_MAX_DMA; i++) {
 		if (pnp_dma_valid(dev, i)) {
 			pnp_printf(buffer,"dma");
-			pnp_printf(buffer," %ld \n", pnp_dma(dev, i));
+			if (pnp_dma_flags(dev, i) & IORESOURCE_DISABLED)
+				pnp_printf(buffer," disabled\n");
+			else
+				pnp_printf(buffer," %ld\n",
+						pnp_dma(dev, i));
 		}
 	}
 	ret = (buffer->curr - buf);
diff -urN a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	2003-07-03 00:24:32.000000000 +0000
+++ b/drivers/pnp/manager.c	2003-07-02 23:43:10.000000000 +0000
@@ -40,6 +40,9 @@
 	if (!(dev->res.port_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
+	if (!rule->size)
+		return 1; /* skip disabled resource requests */
+
 	start = &dev->res.port_resource[idx].start;
 	end = &dev->res.port_resource[idx].end;
 	flags = &dev->res.port_resource[idx].flags;
@@ -76,6 +79,9 @@
 	if (!(dev->res.mem_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
+	if (!rule->size)
+		return 1; /* skip disabled resource requests */
+
 	start = &dev->res.mem_resource[idx].start;
 	end = &dev->res.mem_resource[idx].end;
 	flags = &dev->res.mem_resource[idx].flags;
@@ -128,6 +134,9 @@
 	if (!(dev->res.irq_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
+	if (!rule->map)
+		return 1; /* skip disabled resource requests */
+
 	start = &dev->res.irq_resource[idx].start;
 	end = &dev->res.irq_resource[idx].end;
 	flags = &dev->res.irq_resource[idx].flags;
@@ -168,6 +177,9 @@
 	if (!(dev->res.dma_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
+	if (!rule->map)
+		return 1; /* skip disabled resource requests */
+
 	start = &dev->res.dma_resource[idx].start;
 	end = &dev->res.dma_resource[idx].end;
 	flags = &dev->res.dma_resource[idx].flags;
diff -urN a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	2003-07-03 00:24:32.000000000 +0000
+++ b/drivers/pnp/resource.c	2003-07-02 22:31:48.000000000 +0000
@@ -286,6 +286,8 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_PORT; tmp++) {
 			if (tdev->res.port_resource[tmp].flags & IORESOURCE_IO) {
+				if (pnp_port_flags(dev, tmp) & IORESOURCE_DISABLED)
+					continue;
 				tport = &tdev->res.port_resource[tmp].start;
 				tend = &tdev->res.port_resource[tmp].end;
 				if (ranged_conflict(port,end,tport,tend))
@@ -340,6 +342,8 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_MEM; tmp++) {
 			if (tdev->res.mem_resource[tmp].flags & IORESOURCE_MEM) {
+				if (pnp_mem_flags(dev, tmp) & IORESOURCE_DISABLED)
+					continue;
 				taddr = &tdev->res.mem_resource[tmp].start;
 				tend = &tdev->res.mem_resource[tmp].end;
 				if (ranged_conflict(addr,end,taddr,tend))
@@ -409,6 +413,8 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_IRQ; tmp++) {
 			if (tdev->res.irq_resource[tmp].flags & IORESOURCE_IRQ) {
+				if (pnp_irq_flags(dev, tmp) & IORESOURCE_DISABLED)
+					continue;
 				if ((tdev->res.irq_resource[tmp].start == *irq))
 					return 0;
 			}
@@ -462,6 +468,8 @@
 			continue;
 		for (tmp = 0; tmp < PNP_MAX_DMA; tmp++) {
 			if (tdev->res.dma_resource[tmp].flags & IORESOURCE_DMA) {
+				if (pnp_dma_flags(dev, tmp) & IORESOURCE_DISABLED)
+					continue;
 				if ((tdev->res.dma_resource[tmp].start == *dma))
 					return 0;
 			}
diff -urN a/drivers/pnp/support.c b/drivers/pnp/support.c
--- a/drivers/pnp/support.c	2003-07-03 00:24:32.000000000 +0000
+++ b/drivers/pnp/support.c	2003-07-02 22:31:48.000000000 +0000
@@ -68,9 +68,13 @@
 	int i = 0;
 	while ((res->irq_resource[i].flags & IORESOURCE_IRQ) && i < PNP_MAX_IRQ) i++;
 	if (i < PNP_MAX_IRQ) {
+		res->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
+		if (irq == -1) {
+			res->irq_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
 		res->irq_resource[i].start =
 		res->irq_resource[i].end = (unsigned long) irq;
-		res->irq_resource[i].flags = IORESOURCE_IRQ;  // Also clears _UNSET flag
 	}
 }
 
@@ -79,9 +83,13 @@
 	int i = 0;
 	while ((res->dma_resource[i].flags & IORESOURCE_DMA) && i < PNP_MAX_DMA) i++;
 	if (i < PNP_MAX_DMA) {
+		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
+		if (dma == -1) {
+			res->dma_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
 		res->dma_resource[i].start =
 		res->dma_resource[i].end = (unsigned long) dma;
-		res->dma_resource[i].flags = IORESOURCE_DMA;  // Also clears _UNSET flag
 	}
 }
 
@@ -90,9 +98,13 @@
 	int i = 0;
 	while ((res->port_resource[i].flags & IORESOURCE_IO) && i < PNP_MAX_PORT) i++;
 	if (i < PNP_MAX_PORT) {
+		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
+		if (len <= 0 || (io + len -1) >= 0x10003) {
+			res->port_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
 		res->port_resource[i].start = (unsigned long) io;
 		res->port_resource[i].end = (unsigned long)(io + len - 1);
-		res->port_resource[i].flags = IORESOURCE_IO;  // Also clears _UNSET flag
 	}
 }
 
@@ -101,9 +113,13 @@
 	int i = 0;
 	while ((res->mem_resource[i].flags & IORESOURCE_MEM) && i < PNP_MAX_MEM) i++;
 	if (i < PNP_MAX_MEM) {
+		res->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
+		if (len <= 0) {
+			res->mem_resource[i].flags |= IORESOURCE_DISABLED;
+			return;
+		}
 		res->mem_resource[i].start = (unsigned long) mem;
 		res->mem_resource[i].end = (unsigned long)(mem + len - 1);
-		res->mem_resource[i].flags = IORESOURCE_MEM;  // Also clears _UNSET flag
 	}
 }

--- a/include/linux/ioport.h	2003-07-02 20:42:17.000000000 +0000
+++ b/include/linux/ioport.h	2003-07-02 22:31:48.000000000 +0000
@@ -43,6 +43,7 @@
 #define IORESOURCE_SHADOWABLE	0x00010000
 #define IORESOURCE_BUS_HAS_VGA	0x00080000
 
+#define IORESOURCE_DISABLED	0x10000000
 #define IORESOURCE_UNSET	0x20000000
 #define IORESOURCE_AUTO		0x40000000
 #define IORESOURCE_BUSY		0x80000000	/* Driver has marked this resource busy */
