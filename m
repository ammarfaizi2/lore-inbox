Return-Path: <linux-kernel-owner+w=401wt.eu-S937391AbWLKSB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937391AbWLKSB1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937402AbWLKSB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:01:27 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:35720 "EHLO
	localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S937391AbWLKSB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:01:26 -0500
To: Jeff Garzik <jeff@garzik.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-embedded@ozlabs.org
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH] [FS_ENET] OF-related update for FEC and SCC MAC's
Date: Mon, 11 Dec 2006 21:00:49 +0300
Message-Id: <20061211180048.17991.59030.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Updated direct resource pass with ioremap call, make it grant proper IRQ
mapping, stuff incompatible with the new approach were respectively put  under 
#ifndef CONFIG_PPC_MERGE.
---

 drivers/net/fs_enet/mac-fec.c |   13 +++++++++----
 drivers/net/fs_enet/mac-scc.c |    6 ++++--
 drivers/net/phy/fixed.c       |    2 +-
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
index c2c5fd4..474d6d7 100644
--- a/drivers/net/fs_enet/mac-fec.c
+++ b/drivers/net/fs_enet/mac-fec.c
@@ -104,9 +104,9 @@ static int do_pd_setup(struct fs_enet_pr
 	fep->interrupt = platform_get_irq_byname(pdev,"interrupt");
 	if (fep->interrupt < 0)
 		return -EINVAL;
-	
+
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	fep->fec.fecp =(void*)r->start;
+	fep->fec.fecp = (void *)ioremap(r->start, r->end - r->start + 1);
 
 	if(fep->fec.fecp == NULL)
 		return -EINVAL;
@@ -319,11 +319,14 @@ #endif
 	 * Clear any outstanding interrupt.
 	 */
 	FW(fecp, ievent, 0xffc0);
+#ifndef CONFIG_PPC_MERGE
 	FW(fecp, ivec, (fep->interrupt / 2) << 29);
-	
+#else
+	FW(fecp, ivec, (irq_map[fep->interrupt].hwirq / 2) << 29);
+#endif
 
 	/*
-	 * adjust to speed (only for DUET & RMII) 
+	 * adjust to speed (only for DUET & RMII)
 	 */
 #ifdef CONFIG_DUET
 	if (fpi->use_rmii) {
@@ -418,6 +421,7 @@ static void stop(struct net_device *dev)
 
 static void pre_request_irq(struct net_device *dev, int irq)
 {
+#ifndef CONFIG_PPC_MERGE
 	immap_t *immap = fs_enet_immap;
 	u32 siel;
 
@@ -431,6 +435,7 @@ static void pre_request_irq(struct net_d
 			siel &= ~(0x80000000 >> (irq & ~1));
 		out_be32(&immap->im_siu_conf.sc_siel, siel);
 	}
+#endif
 }
 
 static void post_free_irq(struct net_device *dev, int irq)
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index 95ec587..62057f4 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -121,13 +121,13 @@ static int do_pd_setup(struct fs_enet_pr
 		return -EINVAL;
 
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	fep->scc.sccp = (void *)r->start;
+	fep->scc.sccp = (void *)ioremap(r->start, r->end - r->start + 1);
 
 	if (fep->scc.sccp == NULL)
 		return -EINVAL;
 
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pram");
-	fep->scc.ep = (void *)r->start;
+	fep->scc.ep = (void *)ioremap(r->start, r->end - r->start + 1);
 
 	if (fep->scc.ep == NULL)
 		return -EINVAL;
@@ -397,6 +397,7 @@ static void stop(struct net_device *dev)
 
 static void pre_request_irq(struct net_device *dev, int irq)
 {
+#ifndef CONFIG_PPC_MERGE
 	immap_t *immap = fs_enet_immap;
 	u32 siel;
 
@@ -410,6 +411,7 @@ static void pre_request_irq(struct net_d
 			siel &= ~(0x80000000 >> (irq & ~1));
 		out_be32(&immap->im_siu_conf.sc_siel, siel);
 	}
+#endif
 }
 
 static void post_free_irq(struct net_device *dev, int irq)
diff --git a/drivers/net/phy/fixed.c b/drivers/net/phy/fixed.c
index 096d4a1..8613539 100644
--- a/drivers/net/phy/fixed.c
+++ b/drivers/net/phy/fixed.c
@@ -349,7 +349,7 @@ #ifdef CONFIG_FIXED_MII_100_FDX
 	fixed_mdio_register_device(0, 100, 1);
 #endif
 
-#ifdef CONFIX_FIXED_MII_10_FDX
+#ifdef CONFIG_FIXED_MII_10_FDX
 	fixed_mdio_register_device(0, 10, 1);
 #endif
 	return 0;
