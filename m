Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbTIVATG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTIVATG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:19:06 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:15757 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262723AbTIVASg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:18:36 -0400
Date: Sun, 21 Sep 2003 20:11:33 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.0-test5
Message-ID: <20030921201133.GE24897@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030921200935.GB24897@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030921200935.GB24897@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/09/21	ambx1@neo.rr.com	1.1357
# [PNP] remove DMA 0 restrictions
# 
# The original argument for blocking DMA 0 was to avoid conflicts with
# "memory refresh"  but such configurations are only found on very old
# 8-bit systems that are likely not supported by the linux kernel. 
# This patch allows dma 0 to be assigned to PnP devices by default.  If
# for whatever reason dma 0 cannot be used, one can avoid allocating it
# by setting the pnp_reserve_dma= kernel parameter.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
--- a/drivers/pnp/quirks.c	Sun Sep 21 19:45:59 2003
+++ b/drivers/pnp/quirks.c	Sun Sep 21 19:45:59 2003
@@ -111,28 +111,6 @@
 	return;
 }
 
-extern int pnp_allow_dma0;
-static void quirk_opl3sax_resources(struct pnp_dev *dev)
-{
-	/* This really isn't a device quirk but isapnp core code
-	 * doesn't allow a DMA channel of 0, afflicted card is an
-	 * OPL3Sax where x=4.
-	 */
-	struct pnp_option *res;
-	int max;
-	res = dev->dependent;
-	max = 0;
-	for (; res; res = res->next) {
-		if (res->dma->map > max)
-			max = res->dma->map;
-	}
-	if (max == 1 && pnp_allow_dma0 == -1) {
-		printk(KERN_INFO "pnp: opl3sa4 quirk: Allowing dma 0.\n");
-		pnp_allow_dma0 = 1;
-	}
-	return;
-}
-
 /*
  *  PnP Quirks
  *  Cards or devices that need some tweaking due to incomplete resource info
@@ -153,7 +131,6 @@
 	{ "CTL0043", quirk_sb16audio_resources },
 	{ "CTL0044", quirk_sb16audio_resources },
 	{ "CTL0045", quirk_sb16audio_resources },
-	{ "YMH0021", quirk_opl3sax_resources },
 	{ "" }
 };
 
@@ -170,4 +147,3 @@
 		i++;
 	}
 }
-
diff -Nru a/drivers/pnp/resource.c b/drivers/pnp/resource.c
--- a/drivers/pnp/resource.c	Sun Sep 21 19:45:59 2003
+++ b/drivers/pnp/resource.c	Sun Sep 21 19:45:59 2003
@@ -21,8 +21,6 @@
 #include <linux/pnp.h>
 #include "base.h"
 
-int pnp_allow_dma0 = -1;		        /* allow dma 0 during auto activation:
-						 * -1=off (:default), 0=off (set by user), 1=on */
 int pnp_skip_pci_scan;				/* skip PCI resource scanning */
 int pnp_reserve_irq[16] = { [0 ... 15] = -1 };	/* reserve (don't use) some IRQ */
 int pnp_reserve_dma[8] = { [0 ... 7] = -1 };	/* reserve (don't use) some DMA */
@@ -426,7 +424,7 @@
 
 int pnp_check_dma(struct pnp_dev * dev, int idx)
 {
-	int tmp, mindma = 1;
+	int tmp;
 	struct pnp_dev *tdev;
 	unsigned long * dma = &dev->res.dma_resource[idx].start;
 
@@ -435,9 +433,7 @@
 		return 1;
 
 	/* check if the resource is valid */
-	if (pnp_allow_dma0 == 1)
-		mindma = 0;
-	if (*dma < mindma || *dma == 4 || *dma > 7)
+	if (*dma < 0 || *dma == 4 || *dma > 7)
 		return 0;
 
 	/* check if the resource is reserved */
@@ -487,16 +483,6 @@
 EXPORT_SYMBOL(pnp_register_port_resource);
 EXPORT_SYMBOL(pnp_register_mem_resource);
 
-
-/* format is: allowdma0 */
-
-static int __init pnp_allowdma0(char *str)
-{
-        pnp_allow_dma0 = 1;
-	return 1;
-}
-
-__setup("allowdma0", pnp_allowdma0);
 
 /* format is: pnp_reserve_irq=irq1[,irq2] .... */
 
