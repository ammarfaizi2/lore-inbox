Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265486AbTGCXBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 19:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265522AbTGCWzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 18:55:31 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:17548 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S265516AbTGCWxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 18:53:21 -0400
Date: Thu, 3 Jul 2003 18:41:56 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.5.74
Message-ID: <20030703184156.GC31086@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030703184109.GB31086@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703184109.GB31086@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN a/drivers/pnp/manager.c b/drivers/pnp/manager.c
--- a/drivers/pnp/manager.c	2003-07-03 00:55:25.000000000 +0000
+++ b/drivers/pnp/manager.c	2003-07-03 01:07:17.000000000 +0000
@@ -40,17 +40,20 @@
 	if (!(dev->res.port_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
-	if (!rule->size)
-		return 1; /* skip disabled resource requests */
-
 	start = &dev->res.port_resource[idx].start;
 	end = &dev->res.port_resource[idx].end;
 	flags = &dev->res.port_resource[idx].flags;
 
 	/* set the initial values */
+	*flags = *flags | rule->flags | IORESOURCE_IO;
+
+	if (!rule->size) {
+		*flags |= IORESOURCE_DISABLED;
+		return 1; /* skip disabled resource requests */
+	}
+
 	*start = rule->min;
 	*end = *start + rule->size - 1;
-	*flags = *flags | rule->flags | IORESOURCE_IO;
 
 	/* run through until pnp_check_port is happy */
 	while (!pnp_check_port(dev, idx)) {
@@ -79,16 +82,11 @@
 	if (!(dev->res.mem_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
-	if (!rule->size)
-		return 1; /* skip disabled resource requests */
-
 	start = &dev->res.mem_resource[idx].start;
 	end = &dev->res.mem_resource[idx].end;
 	flags = &dev->res.mem_resource[idx].flags;
 
 	/* set the initial values */
-	*start = rule->min;
-	*end = *start + rule->size -1;
 	*flags = *flags | rule->flags | IORESOURCE_MEM;
 
 	/* convert pnp flags to standard Linux flags */
@@ -101,6 +99,14 @@
 	if (rule->flags & IORESOURCE_MEM_SHADOWABLE)
 		*flags |= IORESOURCE_SHADOWABLE;
 
+	if (!rule->size) {
+		*flags |= IORESOURCE_DISABLED;
+		return 1; /* skip disabled resource requests */
+	}
+
+	*start = rule->min;
+	*end = *start + rule->size -1;
+
 	/* run through until pnp_check_mem is happy */
 	while (!pnp_check_mem(dev, idx)) {
 		*start += rule->align;
@@ -134,9 +140,6 @@
 	if (!(dev->res.irq_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
-	if (!rule->map)
-		return 1; /* skip disabled resource requests */
-
 	start = &dev->res.irq_resource[idx].start;
 	end = &dev->res.irq_resource[idx].end;
 	flags = &dev->res.irq_resource[idx].flags;
@@ -144,6 +147,11 @@
 	/* set the initial values */
 	*flags = *flags | rule->flags | IORESOURCE_IRQ;
 
+	if (!rule->map) {
+		*flags |= IORESOURCE_DISABLED;
+		return 1; /* skip disabled resource requests */
+	}
+
 	for (i = 0; i < 16; i++) {
 		if(rule->map & (1<<xtab[i])) {
 			*start = *end = xtab[i];
@@ -177,9 +185,6 @@
 	if (!(dev->res.dma_resource[idx].flags & IORESOURCE_AUTO))
 		return 1;
 
-	if (!rule->map)
-		return 1; /* skip disabled resource requests */
-
 	start = &dev->res.dma_resource[idx].start;
 	end = &dev->res.dma_resource[idx].end;
 	flags = &dev->res.dma_resource[idx].flags;
@@ -187,6 +192,11 @@
 	/* set the initial values */
 	*flags = *flags | rule->flags | IORESOURCE_DMA;
 
+	if (!rule->map) {
+		*flags |= IORESOURCE_DISABLED;
+		return 1; /* skip disabled resource requests */
+	}
+
 	for (i = 0; i < 8; i++) {
 		if(rule->map & (1<<xtab[i])) {
 			*start = *end = xtab[i];
