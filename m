Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293457AbSCKBnJ>; Sun, 10 Mar 2002 20:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293458AbSCKBm7>; Sun, 10 Mar 2002 20:42:59 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25785 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293457AbSCKBm5>;
	Sun, 10 Mar 2002 20:42:57 -0500
Date: Sun, 10 Mar 2002 17:39:35 -0800 (PST)
Message-Id: <20020310.173935.74819813.davem@redhat.com>
To: beezly@beezly.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sun GEM card looses TX on x86 32bit PCI
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1015792619.1801.4.camel@monkey>
In-Reply-To: <1015792619.1801.4.camel@monkey>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   From: Beezly <beezly@beezly.org.uk>
   Date: 10 Mar 2002 20:36:59 +0000

   Unfortunately not. I've just applied these changes and recompiled, but
   I'm suffering exactly the same problem.
   
   This is what I have this time when the card has stopped receiving;

Please add this patch on top of what you have.  I still want the
kernel logs from the failure case that I asked for an hour ago
though, I really need to know if systems seeing this problem have
Pause enabled on the link or not.

--- drivers/net/sungem.c.~1~	Sun Mar 10 00:12:34 2002
+++ drivers/net/sungem.c	Sun Mar 10 17:29:33 2002
@@ -299,19 +299,39 @@
 			gp->dev->name, rxmac_stat);
 
 	if (rxmac_stat & MAC_RXSTAT_OFLW) {
-		u32 smac = readl(gp->regs + MAC_SMACHINE);
+		int limit;
 
-		printk(KERN_ERR "%s: RX MAC fifo overflow smac[%08x].\n",
-		       dev->name, smac);
 		gp->net_stats.rx_over_errors++;
 		gp->net_stats.rx_fifo_errors++;
 
-		if (((smac >> 24) & 0x7) == 0x7) {
-			/* Due to a bug, the chip is hung in this case
-			 * and a full reset is necessary.
-			 */
+		/* Reset the RX MAC then re-enable it. */
+		writel(MAC_RXRST_CMD, gp->regs + MAC_RXRST);
+		for (limit = 0; limit < 5000; limit++) {
+			if (!(readl(gp->regs + MAC_RXRST) & MAC_RXRST_CMD))
+				break;
+			udelay(10);
+		}
+		if (limit == 5000) {
+			printk(KERN_ERR "%s: RX MAC will not reset, resetting whole "
+			       "chip.\n", dev->name);
 			ret = 1;
+			goto out;
 		}
+
+		writel(0, gp->regs + MAC_RXCFG);
+		for (limit = 0; limit < 5000; limit++) {
+			if (!(readl(gp->regs + MAC_RXCFG) & MAC_RXCFG_ENAB))
+				break;
+			udelay(10);
+		}
+		if (limit == 5000) {
+			printk(KERN_ERR "%s: RX MAC will not disable, resetting whole "
+			       "chip.\n", dev->name);
+			ret = 1;
+			goto out;
+		}
+
+		writel(gp->mac_rx_cfg | MAC_RXCFG_ENAB, gp->regs + MAC_RXCFG);
 	}
 
 	if (rxmac_stat & MAC_RXSTAT_ACE)
@@ -323,6 +343,7 @@
 	if (rxmac_stat & MAC_RXSTAT_LCE)
 		gp->net_stats.rx_length_errors += 0x10000;
 
+out:
 	/* We do not track MAC_RXSTAT_FCE and MAC_RXSTAT_VCE
 	 * events.
 	 */
@@ -1830,7 +1851,6 @@
 static void gem_init_mac(struct gem *gp)
 {
 	unsigned char *e = &gp->dev->dev_addr[0];
-	u32 rxcfg;
 
 	if (gp->pdev->vendor == PCI_VENDOR_ID_SUN &&
 	    gp->pdev->device == PCI_DEVICE_ID_SUN_GEM)
@@ -1870,7 +1890,7 @@
 	writel(0, gp->regs + MAC_AF21MSK);
 	writel(0, gp->regs + MAC_AF0MSK);
 
-	rxcfg = gem_setup_multicast(gp);
+	gp->mac_rx_cfg = gem_setup_multicast(gp);
 
 	writel(0, gp->regs + MAC_NCOLL);
 	writel(0, gp->regs + MAC_FASUCC);
@@ -1888,7 +1908,7 @@
 	 * them once a link is established.
 	 */
 	writel(0, gp->regs + MAC_TXCFG);
-	writel(rxcfg, gp->regs + MAC_RXCFG);
+	writel(gp->mac_rx_cfg, gp->regs + MAC_RXCFG);
 	writel(0, gp->regs + MAC_MCCFG);
 	writel(0, gp->regs + MAC_XIFCFG);
 
@@ -2441,7 +2461,7 @@
 	netif_stop_queue(dev);
 
 	rxcfg = readl(gp->regs + MAC_RXCFG);
-	rxcfg_new = gem_setup_multicast(gp);
+	gp->mac_rx_cfg = rxcfg_new = gem_setup_multicast(gp);
 	
 	writel(rxcfg & ~MAC_RXCFG_ENAB, gp->regs + MAC_RXCFG);
 	while (readl(gp->regs + MAC_RXCFG) & MAC_RXCFG_ENAB) {
