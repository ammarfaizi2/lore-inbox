Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUDPFgb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 01:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUDPFgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 01:36:31 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:26026 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S262347AbUDPFgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 01:36:24 -0400
Message-ID: <407F6CC8.1060903@stanford.edu>
Date: Thu, 15 Apr 2004 22:19:04 -0700
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       shuchen@realtek.com.tw
Subject: r8169 excessive PHY reset
Content-Type: multipart/mixed;
 boundary="------------020206070400060601020304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020206070400060601020304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On my r8169 (Really 8110S, I think -- it's a MSI K8T Neo-FIS2R, running x86_64), 
if I unplug the network cable and reconnect it, the link stays down and the 
driver starts resetting the PHY at an absurd rate (many times per second).

Strangely enough, simply removing all the PHY reset code fixes it.  Is there any 
reason for this code?  (The other end of my link is e1000, and I'm using 1000Mbps.)

Patch against 2.6.5-mm5 (attached because my mailer will mangle it otherwise).

--Andy

Please CC me b/c i'm not subscribed.

--------------020206070400060601020304
Content-Type: text/plain;
 name="r8169fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="r8169fix.patch"

--- ./drivers/net/r8169.c.orig	2004-04-15 22:08:07.962654280 -0700
+++ ./drivers/net/r8169.c	2004-04-15 22:09:22.101383480 -0700
@@ -98,7 +98,6 @@
 
 #define RTL_MIN_IO_SIZE 0x80
 #define RTL8169_TX_TIMEOUT	(6*HZ)
-#define RTL8169_PHY_TIMEOUT	(HZ) 
 
 /* write/read MMIO register */
 #define RTL_W8(reg, val8)	writeb ((val8), ioaddr + (reg))
@@ -323,7 +322,6 @@
 	dma_addr_t RxPhyAddr;
 	struct sk_buff *Rx_skbuff[NUM_RX_DESC];	/* Rx data buffers */
 	struct sk_buff *Tx_skbuff[NUM_TX_DESC];	/* Index of Transmit data buffer */
-	struct timer_list timer;
 	unsigned long phy_link_down_cnt;
 	u16 cp_cmd;
 };
@@ -568,90 +566,6 @@
 	mdio_write(ioaddr, 31, 0x0000); //w 31 2 0 0
 }
 
-static void rtl8169_hw_phy_reset(struct net_device *dev)
-{
-	struct rtl8169_private *tp = dev->priv;
-	void *ioaddr = tp->mmio_addr;
-	int i, val;
-
-	printk(KERN_WARNING PFX "%s: Reset RTL8169s PHY\n", dev->name);
-
-	val = (mdio_read(ioaddr, 0) | 0x8000) & 0xffff;
-	mdio_write(ioaddr, 0, val);
-
-	for (i = 50; i >= 0; i--) {
-		if (!(mdio_read(ioaddr, 0) & 0x8000))
-			break;
-		udelay(100); /* Gross */
-	}
-
-	if (i < 0) {
-		printk(KERN_WARNING PFX "%s: no PHY Reset ack. Giving up.\n",
-		       dev->name);
-	}
-}
-
-static void rtl8169_phy_timer(unsigned long __opaque)
-{
-	struct net_device *dev = (struct net_device *)__opaque;
-	struct rtl8169_private *tp = dev->priv;
-	struct timer_list *timer = &tp->timer;
-	void *ioaddr = tp->mmio_addr;
-
-	assert(tp->mac_version > RTL_GIGA_MAC_VER_B);
-	assert(tp->phy_version < RTL_GIGA_PHY_VER_G);
-
-	if (RTL_R8(PHYstatus) & LinkStatus)
-		tp->phy_link_down_cnt = 0;
-	else {
-		tp->phy_link_down_cnt++;
-		if (tp->phy_link_down_cnt >= 12) {
-			int reg;
-
-			// If link on 1000, perform phy reset.
-			reg = mdio_read(ioaddr, PHY_1000_CTRL_REG);
-			if (reg & PHY_Cap_1000_Full) 
-				rtl8169_hw_phy_reset(dev);
-
-			tp->phy_link_down_cnt = 0;
-		}
-	}
-
-	mod_timer(timer, RTL8169_PHY_TIMEOUT);
-}
-
-static inline void rtl8169_delete_timer(struct net_device *dev)
-{
-	struct rtl8169_private *tp = dev->priv;
-	struct timer_list *timer = &tp->timer;
-
-	if ((tp->mac_version <= RTL_GIGA_MAC_VER_B) ||
-	    (tp->phy_version >= RTL_GIGA_PHY_VER_G))
-		return;
-
-	del_timer_sync(timer);
-
-	tp->phy_link_down_cnt = 0;
-}
-
-static inline void rtl8169_request_timer(struct net_device *dev)
-{
-	struct rtl8169_private *tp = dev->priv;
-	struct timer_list *timer = &tp->timer;
-
-	if ((tp->mac_version <= RTL_GIGA_MAC_VER_B) ||
-	    (tp->phy_version >= RTL_GIGA_PHY_VER_G))
-		return;
-
-	tp->phy_link_down_cnt = 0;
-
-	init_timer(timer);
-	timer->expires = jiffies + RTL8169_PHY_TIMEOUT;
-	timer->data = (unsigned long)(dev);
-	timer->function = rtl8169_phy_timer;
-	add_timer(timer);
-}
-
 static int __devinit
 rtl8169_init_board(struct pci_dev *pdev, struct net_device **dev_out,
 		   void **ioaddr_out)
@@ -1074,8 +988,6 @@
 		goto err_free_rx;
 
 	rtl8169_hw_start(dev);
-
-	rtl8169_request_timer(dev);
 out:
 	return retval;
 
@@ -1587,8 +1499,6 @@
 
 	netif_stop_queue(dev);
 
-	rtl8169_delete_timer(dev);
-
 	spin_lock_irq(&tp->lock);
 
 	/* Stop the chip's Tx and Rx DMA processes. */

--------------020206070400060601020304--
