Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbUKIONU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbUKIONU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbUKIONU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:13:20 -0500
Received: from colino.net ([213.41.131.56]:6910 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261452AbUKIONG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:13:06 -0500
Date: Tue, 9 Nov 2004 15:11:54 +0100
From: Colin Leroy <colin.lkml@colino.net>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: [(broken) PATCH] Sungem and wake_on_lan
Message-ID: <20041109151154.43c897dd.colin.lkml@colino.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs142.2 (GTK+ 2.4.0; i686-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm trying to implement wake_on_lan in sungem. I did it by mimicking the
Darwin AppleGMACEthernet driver. 
I have some problems with it; not only it doesn't work (pinging the
target machine does not wake it up, nor does ether-wake.c), but also the
normal resume crashes instead of working - before powering screen up,
so no log available...

My laptop has a BCM5221 PHY, I suppose it supports WOL but did not
check. Anyway it shouldn't crash on normal resume, as Darwin's driver
doesn't seem to have special cases depending on PHYs.

Before putting the laptop to sleep, I issue a 'sudo ethtool -s eth0 wol p'
to enable gp->wake_on_lan.

Here's the patch, in case anyone (BenH, David Miller ? :)) has an idea
about something i do wrong. 
Thanks,
-- 
Colin

diff -ur /tmp/linux-2.6.9/drivers/net/sungem.c drivers/net/sungem.c
--- /tmp/linux-2.6.9/drivers/net/sungem.c	2004-10-18 23:55:28.000000000 +0200
+++ drivers/net/sungem.c	2004-11-09 14:40:04.000000000 +0100
@@ -2132,7 +2132,29 @@
 	writel(mifcfg, gp->regs + MIF_CFG);
 
 	if (gp->wake_on_lan) {
-		/* Setup wake-on-lan */
+		u32 val_wake_up;
+		u32 xif_cfg = readl(gp->regs + MAC_XIFCFG);
+		unsigned char *e = &gp->dev->dev_addr[0];
+
+		/* set these bits for multicast filtering */
+		writel(MAC_RXCFG_HFE|MAC_RXCFG_SFCS|MAC_RXCFG_ENAB, gp->regs + MAC_RXCFG);
+
+		/* write our MAC address */
+		writel((e[0] << 8) | e[1], gp->regs + MAC_WOL_MAGIC2);
+		writel((e[2] << 8) | e[3], gp->regs + MAC_WOL_MAGIC1);
+		writel((e[4] << 8) | e[5], gp->regs + MAC_WOL_MAGIC0);
+
+		/* write the pattern match count */
+		writel(PAT_MATCH_M | PAT_MATCH_N, gp->regs + PAT_MATCH_CFG);
+		
+		/* enable WOL */
+		val_wake_up = WOL_ENABLE;
+		if (!(xif_cfg & MAC_XIFCFG_GMII))
+			val_wake_up |= WOL_MODE_MII;
+		writel(val_wake_up, gp->regs + WOL_CSR_CFG);
+
+		/* sleep a bit, just to be sure */
+		msleep(10);
 	} else {
 		writel(0, gp->regs + MAC_RXCFG);
 		(void)readl(gp->regs + MAC_RXCFG);
@@ -2159,7 +2181,7 @@
 	}
 
 	if (found_mii_phy(gp) && gp->phy_mii.def->ops->suspend)
-		gp->phy_mii.def->ops->suspend(&gp->phy_mii, 0 /* wake on lan options */);
+		gp->phy_mii.def->ops->suspend(&gp->phy_mii, gp->wake_on_lan);
 
 	if (!gp->wake_on_lan) {
 		/* According to Apple, we must set the MDIO pins to this begnign
@@ -2622,13 +2644,30 @@
 	struct gem *gp = dev->priv;
 	return gp->msg_enable;
 }
-  
+
 static void gem_set_msglevel(struct net_device *dev, u32 value)
 {
 	struct gem *gp = dev->priv;
 	gp->msg_enable = value;
 }
-  
+
+static void gem_get_wol (struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct gem *gp = dev->priv;
+	wol->wolopts   = 0; 
+	/* let's say we support this, altough I don't know what it is */
+	wol->supported = WAKE_PHY|WAKE_UCAST;
+	if (gp->wake_on_lan == 1)
+		wol->wolopts = wol->supported;
+}
+
+static int gem_set_wol (struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct gem *gp = dev->priv;
+	gp->wake_on_lan = (wol->wolopts != 0);
+	return 0;
+}
+
 static struct ethtool_ops gem_ethtool_ops = {
 	.get_drvinfo		= gem_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
@@ -2637,6 +2676,8 @@
 	.nway_reset		= gem_nway_reset,
 	.get_msglevel		= gem_get_msglevel,
 	.set_msglevel		= gem_set_msglevel,
+	.get_wol		= gem_get_wol,
+	.set_wol		= gem_set_wol,
 };
 
 static int gem_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
diff -ur /tmp/linux-2.6.9/drivers/net/sungem.h drivers/net/sungem.h
--- /tmp/linux-2.6.9/drivers/net/sungem.h	2004-10-18 23:54:32.000000000 +0200
+++ drivers/net/sungem.h	2004-11-09 10:10:46.000000000 +0100
@@ -276,6 +276,9 @@
  */
 
 /* MAC Registers */
+#define MAC_WOL_MAGIC0	0x3000UL	/* six address bytes		*/
+#define MAC_WOL_MAGIC1	0x3004UL	
+#define MAC_WOL_MAGIC2	0x3008UL
 #define MAC_TXRST	0x6000UL	/* TX MAC Software Reset Command*/
 #define MAC_RXRST	0x6004UL	/* RX MAC Software Reset Command*/
 #define MAC_SNDPAUSE	0x6008UL	/* Send Pause Command Register	*/
@@ -750,6 +753,16 @@
 #define PCS_SCTRL_TXZ	0x0000c000	/* PLL input to Serialink	*/
 #define PCS_SCTRL_TXP	0x00030000	/* PLL input to Serialink	*/
 
+/* Pattern Match Count register. */
+#define PAT_MATCH_CFG	0x300CUL
+#define PAT_MATCH_N	0x0010UL
+#define PAT_MATCH_M	0x0000UL 	/* Darwin source notes (0<<8) !?*/
+
+/* Wake on Lan CSR Register */
+#define WOL_CSR_CFG	0x3010UL
+#define WOL_ENABLE	0x0001UL
+#define WOL_MODE_MII	0x0002UL
+
 /* Shared Output Select Register.  For test and debug, allows multiplexing
  * test outputs into the PROM address pins.  Set to zero for normal
  * operation.
