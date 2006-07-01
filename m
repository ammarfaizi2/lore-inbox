Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWGAJbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWGAJbn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 05:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWGAJbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 05:31:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54456 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932484AbWGAJbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 05:31:41 -0400
Date: Sat, 1 Jul 2006 02:30:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexandre.Bounine@tundra.com, tie-fei.zang@freescale.com,
       Xin-Xin.Yang@freescale.com
Subject: Re: [PATCH] [2.6.17]   Add tsi108 Ethernet device driver support
Message-Id: <20060701023054.d1ff56cd.akpm@osdl.org>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306C0358D@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306C0358D@zch01exm40.ap.freescale.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 12:00:40 +0800
Zang Roy-r61911 <tie-fei.zang@freescale.com> wrote:

> This patch adds a net device driver and configuration options for
> Tundra Semiconductor Tsi108 integrated dual port Gigabit 
> Ethernet controller

Your patch forgot to include these:

> +#include <asm/tsi108_irq.h>
> +#include <asm/tsi108.h>

Why would a net driver have files in include/asm/?




Have some comments-via-diff, mainly trivial:


From: Andrew Morton <akpm@osdl.org>

- Nuke the typedef

- Reduce exorbitant inlining.

- possible bug: tsi108_open() does request_irq() as its first operation. 
  The IRQ handler can run immediately.  Is it ready for that?

- Use setup_irq().

- Unneeded casts of void*

- alloc_etherdev() already zeroes the memory.

- why are tsi108_prv_data.regs and .phyregs volatile?  They shouldn't be.

- What's this?

	data->regs = (u32)ioremap(einfo->regs, 0x400);	/*FIX ME */
	data->phyregs = (u32)ioremap(einfo->phyregs, 0x400); 	/*FIX ME */

- Use DEFINE_SPINLOCK()

- Use free_netdev(), not kfree() (Is this right?)

- Use mod_timer()

- tsi108_init_phy() has a 10-millisecond busywait in it, seemingly
  needlessly.  Convert to msleep().

- tsi108_init_phy() has multiple potentially infinite wait loops.  Add
  timeouts.

- Random coding-style cleanups.





Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/net/tsi108_eth.c |  295 ++++++++++++++++++-------------------
 1 file changed, 145 insertions(+), 150 deletions(-)

diff -puN drivers/net/tsi108_eth.c~add-tsi108-ethernet-device-driver-support-tidy drivers/net/tsi108_eth.c
--- a/drivers/net/tsi108_eth.c~add-tsi108-ethernet-device-driver-support-tidy
+++ a/drivers/net/tsi108_eth.c
@@ -44,15 +44,16 @@
 #include <linux/crc32.h>
 #include <linux/mii.h>
 #include <linux/device.h>
-#include <asm/system.h>
-#include <asm/io.h>
 #include <linux/pci.h>
 #include <linux/rtnetlink.h>
 #include <linux/timer.h>
 #include <linux/platform_device.h>
 
+#include <asm/system.h>
+#include <asm/io.h>
 #include <asm/tsi108_irq.h>
 #include <asm/tsi108.h>
+
 #include "tsi108_eth.h"
 
 #undef DEBUG
@@ -85,7 +86,7 @@ typedef struct sk_buff sk_buff;
 static int tsi108_init_one(struct platform_device *pdev);
 static int tsi108_ether_remove(struct platform_device *pdev);
 
-typedef struct {
+struct tsi108_prv_data {
 	volatile u32 regs;	/* Base of normal regs */
 	volatile u32 phyregs;	/* Base of register bank used for PHY access */
 	int phy;		/* Index of PHY for this interface */
@@ -154,7 +155,7 @@ typedef struct {
 	unsigned long tx_pause_drop;	/* Add to tx_aborted_errors */
 
 	unsigned long mc_hash[16];
-} tsi108_prv_data;
+};
 
 /* Structure for a device driver */
 
@@ -168,9 +169,9 @@ static struct platform_driver tsi_eth_dr
 
 static void tsi108_timed_checker(unsigned long dev_ptr);
 
-static void dump_eth_one(net_device * dev)
+static void dump_eth_one(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 
 	printk("Dumping %s...\n", dev->name);
 	printk("intstat %x intmask %x phy_ok %d"
@@ -198,9 +199,9 @@ static void dump_eth_one(net_device * de
  * interfaces, so this can't be made interface-specific.
  */
 
-static spinlock_t phy_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(phy_lock);
 
-static inline u16 tsi108_read_mii(tsi108_prv_data * data, int reg, int *status)
+static u16 tsi108_read_mii(struct tsi108_prv_data *data, int reg, int *status)
 {
 	int i;
 	u16 ret;
@@ -235,7 +236,7 @@ static inline u16 tsi108_read_mii(tsi108
 	return ret;
 }
 
-static inline void tsi108_write_mii(tsi108_prv_data * data, int reg, u16 val)
+static void tsi108_write_mii(struct tsi108_prv_data *data, int reg, u16 val)
 {
 	TSI108_ETH_WRITE_PHYREG(TSI108_MAC_MII_ADDR,
 				(data->phy << TSI108_MAC_MII_ADDR_PHY) |
@@ -247,7 +248,8 @@ static inline void tsi108_write_mii(tsi1
 	       TSI108_MAC_MII_IND_BUSY) ;
 }
 
-static inline void tsi108_write_tbi(tsi108_prv_data * data, int reg, u16 val)
+static inline void tsi108_write_tbi(struct tsi108_prv_data *data,
+					int reg, u16 val)
 {
 
 	TSI108_ETH_WRITE_REG(TSI108_MAC_MII_ADDR,
@@ -261,9 +263,9 @@ static inline void tsi108_write_tbi(tsi1
 	       TSI108_MAC_MII_IND_BUSY) ;
 }
 
-static void tsi108_check_phy(net_device * dev)
+static void tsi108_check_phy(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	u16 sumstat;
 	u32 mac_cfg2_reg, portctrl_reg;
 	u32 fdx_flag = 0, reg_update = 0;
@@ -291,79 +293,76 @@ static void tsi108_check_phy(net_device 
 		goto out;
 	}
 
-	{
-		mac_cfg2_reg = TSI108_ETH_READ_REG(TSI108_MAC_CFG2);
-		portctrl_reg = TSI108_ETH_READ_REG(TSI108_EC_PORTCTRL);
-
-		sumstat = tsi108_read_mii(data, PHY_SUM_STAT, NULL);
-
-		switch (sumstat & PHY_SUM_STAT_SPEED_MASK) {
-		case PHY_SUM_STAT_1000T_FD:
-			fdx_flag++;
-		case PHY_SUM_STAT_1000T_HD:
-			if (data->speed != 1000) {
-				mac_cfg2_reg &= ~TSI108_MAC_CFG2_IFACE_MASK;
-				mac_cfg2_reg |= TSI108_MAC_CFG2_GIG;
-				portctrl_reg &= ~TSI108_EC_PORTCTRL_NOGIG;
-				data->speed = 1000;
-				reg_update++;
-			}
-			break;
-		case PHY_SUM_STAT_100TX_FD:
-			fdx_flag++;
-		case PHY_SUM_STAT_100TX_HD:
-			if (data->speed != 100) {
-				mac_cfg2_reg &= ~TSI108_MAC_CFG2_IFACE_MASK;
-				mac_cfg2_reg |= TSI108_MAC_CFG2_NOGIG;
-				portctrl_reg |= TSI108_EC_PORTCTRL_NOGIG;
-				data->speed = 100;
-				reg_update++;
-			}
-			break;
+	mac_cfg2_reg = TSI108_ETH_READ_REG(TSI108_MAC_CFG2);
+	portctrl_reg = TSI108_ETH_READ_REG(TSI108_EC_PORTCTRL);
 
-		case PHY_SUM_STAT_10T_FD:
-			fdx_flag++;
-		case PHY_SUM_STAT_10T_HD:
-			if (data->speed != 10) {
-				mac_cfg2_reg &= ~TSI108_MAC_CFG2_IFACE_MASK;
-				mac_cfg2_reg |= TSI108_MAC_CFG2_NOGIG;
-				portctrl_reg |= TSI108_EC_PORTCTRL_NOGIG;
-				data->speed = 10;
-				reg_update++;
-			}
-			break;
+	sumstat = tsi108_read_mii(data, PHY_SUM_STAT, NULL);
 
-		default:
-			if (net_ratelimit())
-				printk(KERN_ERR "PHY reported invalid speed,"
-				       KERN_ERR " summary status %x\n",
-				       sumstat);
-			goto out;
+	switch (sumstat & PHY_SUM_STAT_SPEED_MASK) {
+	case PHY_SUM_STAT_1000T_FD:
+		fdx_flag++;
+	case PHY_SUM_STAT_1000T_HD:
+		if (data->speed != 1000) {
+			mac_cfg2_reg &= ~TSI108_MAC_CFG2_IFACE_MASK;
+			mac_cfg2_reg |= TSI108_MAC_CFG2_GIG;
+			portctrl_reg &= ~TSI108_EC_PORTCTRL_NOGIG;
+			data->speed = 1000;
+			reg_update++;
 		}
+		break;
+	case PHY_SUM_STAT_100TX_FD:
+		fdx_flag++;
+	case PHY_SUM_STAT_100TX_HD:
+		if (data->speed != 100) {
+			mac_cfg2_reg &= ~TSI108_MAC_CFG2_IFACE_MASK;
+			mac_cfg2_reg |= TSI108_MAC_CFG2_NOGIG;
+			portctrl_reg |= TSI108_EC_PORTCTRL_NOGIG;
+			data->speed = 100;
+			reg_update++;
+		}
+		break;
 
-		if (fdx_flag || (sumstat & PHY_SUM_STAT_FULLDUPLEX)) {
-			if (data->duplex != 2) {
-				mac_cfg2_reg |= TSI108_MAC_CFG2_FULLDUPLEX;
-				portctrl_reg &= ~TSI108_EC_PORTCTRL_HALFDUPLEX;
-				data->duplex = 2;
-				reg_update++;
-			}
-		} else {
-			if (data->duplex != 1) {
-				mac_cfg2_reg &= ~TSI108_MAC_CFG2_FULLDUPLEX;
-				portctrl_reg |= TSI108_EC_PORTCTRL_HALFDUPLEX;
-				data->duplex = 1;
-				reg_update++;
-			}
+	case PHY_SUM_STAT_10T_FD:
+		fdx_flag++;
+	case PHY_SUM_STAT_10T_HD:
+		if (data->speed != 10) {
+			mac_cfg2_reg &= ~TSI108_MAC_CFG2_IFACE_MASK;
+			mac_cfg2_reg |= TSI108_MAC_CFG2_NOGIG;
+			portctrl_reg |= TSI108_EC_PORTCTRL_NOGIG;
+			data->speed = 10;
+			reg_update++;
 		}
+		break;
 
-		if (reg_update) {
-			TSI108_ETH_WRITE_REG(TSI108_MAC_CFG2, mac_cfg2_reg);
-			mb();
-			TSI108_ETH_WRITE_REG(TSI108_EC_PORTCTRL, portctrl_reg);
-			mb();
+	default:
+		if (net_ratelimit())
+			printk(KERN_ERR "PHY reported invalid speed,"
+			       KERN_ERR " summary status %x\n",
+			       sumstat);
+		goto out;
+	}
+
+	if (fdx_flag || (sumstat & PHY_SUM_STAT_FULLDUPLEX)) {
+		if (data->duplex != 2) {
+			mac_cfg2_reg |= TSI108_MAC_CFG2_FULLDUPLEX;
+			portctrl_reg &= ~TSI108_EC_PORTCTRL_HALFDUPLEX;
+			data->duplex = 2;
+			reg_update++;
 		}
+	} else {
+		if (data->duplex != 1) {
+			mac_cfg2_reg &= ~TSI108_MAC_CFG2_FULLDUPLEX;
+			portctrl_reg |= TSI108_EC_PORTCTRL_HALFDUPLEX;
+			data->duplex = 1;
+			reg_update++;
+		}
+	}
 
+	if (reg_update) {
+		TSI108_ETH_WRITE_REG(TSI108_MAC_CFG2, mac_cfg2_reg);
+		mb();
+		TSI108_ETH_WRITE_REG(TSI108_EC_PORTCTRL, portctrl_reg);
+		mb();
 	}
 
 	if (data->link_up == 0) {
@@ -397,9 +396,9 @@ tsi108_stat_carry_one(int carry, int car
 		*upper += carry_shift;
 }
 
-static void tsi108_stat_carry(net_device * dev)
+static void tsi108_stat_carry(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	u32 carry1, carry2;
 
 	spin_lock_irq(&data->misclock);
@@ -477,7 +476,7 @@ static void tsi108_stat_carry(net_device
  * data->misclock must be held.
  */
 static inline unsigned long
-tsi108_read_stat(tsi108_prv_data * data, int reg, int carry_bit,
+tsi108_read_stat(struct tsi108_prv_data * data, int reg, int carry_bit,
 		 int carry_shift, unsigned long *upper)
 {
 	int carryreg;
@@ -509,11 +508,11 @@ tsi108_read_stat(tsi108_prv_data * data,
 	return val;
 }
 
-static struct net_device_stats *tsi108_get_stats(net_device * dev)
+static struct net_device_stats *tsi108_get_stats(net_device *dev)
 {
 	unsigned long excol;
 
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	spin_lock_irq(&data->misclock);
 
 	data->tmpstats.rx_packets =
@@ -619,7 +618,7 @@ static struct net_device_stats *tsi108_g
 	return &data->tmpstats;
 }
 
-static void tsi108_restart_rx(tsi108_prv_data * data, net_device * dev)
+static void tsi108_restart_rx(struct tsi108_prv_data * data, net_device *dev)
 {
 	TSI108_ETH_WRITE_REG(TSI108_EC_RXQ_PTRHIGH,
 			     TSI108_EC_RXQ_PTRHIGH_VALID);
@@ -629,7 +628,7 @@ static void tsi108_restart_rx(tsi108_prv
 			     | TSI108_EC_RXCTRL_QUEUE0);
 }
 
-static void tsi108_restart_tx(tsi108_prv_data * data)
+static void tsi108_restart_tx(struct tsi108_prv_data * data)
 {
 	TSI108_ETH_WRITE_REG(TSI108_EC_TXQ_PTRHIGH,
 			     TSI108_EC_TXQ_PTRHIGH_VALID);
@@ -642,9 +641,9 @@ static void tsi108_restart_tx(tsi108_prv
 /* txlock must be held by caller, with IRQs disabled, and
  * with permission to re-enable them when the lock is dropped.
  */
-static void tsi108_check_for_completed_tx(net_device * dev)
+static void tsi108_check_for_completed_tx(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	int tx;
 	struct sk_buff *skb;
 	int release = 0;
@@ -671,16 +670,15 @@ static void tsi108_check_for_completed_t
 	}
 
 	if (release) {
-
 		if (netif_queue_stopped(dev)
 		    && is_valid_ether_addr(dev->dev_addr) && data->link_up)
 			netif_wake_queue(dev);
 	}
 }
 
-static int tsi108_send_packet(sk_buff * skb, net_device * dev)
+static int tsi108_send_packet(sk_buff * skb, net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	int frags = skb_shinfo(skb)->nr_frags + 1;
 	int i;
 #ifdef FIXME_SG_CSUM_NOT_TESTED	/* FIXME: Not supported now. */
@@ -735,8 +733,7 @@ static int tsi108_send_packet(sk_buff * 
 		 */
 
 		if ((tx % TSI108_TX_INT_FREQ == 0) &&
-		    ((TSI108_TXRING_LEN - data->txfree) >= TSI108_TX_INT_FREQ)
-		    )
+		    ((TSI108_TXRING_LEN - data->txfree) >= TSI108_TX_INT_FREQ))
 			misc = TSI108_TX_INT;
 
 		data->txskbs[tx] = skb;
@@ -787,9 +784,9 @@ static int tsi108_send_packet(sk_buff * 
 	return 0;
 }
 
-static int tsi108_check_for_completed_rx(net_device * dev, int budget)
+static int tsi108_check_for_completed_rx(net_device *dev, int budget)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	int done = 0;
 
 	while (data->rxfree && done != budget) {
@@ -838,9 +835,9 @@ static int tsi108_check_for_completed_rx
 	return done;
 }
 
-static int tsi108_refill_rx(net_device * dev, int budget)
+static int tsi108_refill_rx(net_device *dev, int budget)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	int done = 0;
 
 	while (data->rxfree != TSI108_RXRING_LEN && done != budget) {
@@ -851,7 +848,7 @@ static int tsi108_refill_rx(net_device *
 		if (!skb)
 			break;
 
-		skb_reserve(skb, 2);	/* Align the data on a 4-byte boundary. */
+		skb_reserve(skb, 2); /* Align the data on a 4-byte boundary. */
 
 		data->rxring[rx].buf0 = virt_to_phys(skb->data);
 
@@ -878,9 +875,9 @@ static int tsi108_refill_rx(net_device *
 	return done;
 }
 
-static int tsi108_poll(net_device * dev, int *budget)
+static int tsi108_poll(net_device *dev, int *budget)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	u32 estat = TSI108_ETH_READ_REG(TSI108_EC_RXESTAT);
 	u32 intstat = TSI108_ETH_READ_REG(TSI108_EC_INTSTAT);
 	int total_budget = min(*budget, dev->quota);
@@ -959,9 +956,9 @@ static int tsi108_poll(net_device * dev,
 	return 1;
 }
 
-static void tsi108_rx_int(net_device * dev)
+static void tsi108_rx_int(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 
 	/* A race could cause dev to already be scheduled, so it's not an
 	 * error if that happens (and interrupts shouldn't be re-masked,
@@ -1025,9 +1022,9 @@ static void tsi108_rx_int(net_device * d
  * This is called once per second (by default) from the thread.
  */
 
-static void tsi108_check_rxring(net_device * dev)
+static void tsi108_check_rxring(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 
 	/* A poll is scheduled, as opposed to caling tsi108_refill_rx
 	 * directly, so as to keep the receive path single-threaded
@@ -1038,9 +1035,9 @@ static void tsi108_check_rxring(net_devi
 		tsi108_rx_int(dev);
 }
 
-static void tsi108_tx_int(net_device * dev)
+static void tsi108_tx_int(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	u32 estat = TSI108_ETH_READ_REG(TSI108_EC_TXESTAT);
 
 	mb();
@@ -1064,9 +1061,9 @@ static void tsi108_tx_int(net_device * d
 	}
 }
 
-static irqreturn_t tsi108_irq_one(net_device * dev)
+static irqreturn_t tsi108_irq_one(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	u32 stat = TSI108_ETH_READ_REG(TSI108_EC_INTSTAT);
 
 	if (!(stat & TSI108_INT_ANY))
@@ -1101,12 +1098,12 @@ static irqreturn_t tsi108_irq(int irq, v
 	if ((IRQ_TSI108_GIGE0 != irq) && (IRQ_TSI108_GIGE1 != irq))
 		return IRQ_NONE;	/* Not our interrupt */
 
-	return tsi108_irq_one((struct net_device *)dev_id);
+	return tsi108_irq_one(dev_id);
 }
 
-static void tsi108_stop_ethernet(net_device * dev)
+static void tsi108_stop_ethernet(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 
 	/* Disable all TX and RX queues ... */
 	TSI108_ETH_WRITE_REG(TSI108_EC_TXCTRL, 0);
@@ -1120,7 +1117,7 @@ static void tsi108_stop_ethernet(net_dev
 	       TSI108_EC_RXSTAT_ACTIVE) ;
 }
 
-static void tsi108_reset_ether(tsi108_prv_data * data)
+static void tsi108_reset_ether(struct tsi108_prv_data * data)
 {
 	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG1, TSI108_MAC_CFG1_SOFTRST);
 	udelay(100);
@@ -1158,10 +1155,9 @@ static void tsi108_reset_ether(tsi108_pr
 			     TSI108_MAC_MII_MGMT_CLK);
 }
 
-static int tsi108_get_mac(net_device * dev)
+static int tsi108_get_mac(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
-
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	u32 word1 = TSI108_ETH_READ_REG(TSI108_MAC_ADDR1);
 	u32 word2 = TSI108_ETH_READ_REG(TSI108_MAC_ADDR2);
 
@@ -1203,9 +1199,9 @@ static int tsi108_get_mac(net_device * d
 	return 0;
 }
 
-static int tsi108_set_mac(net_device * dev, void *addr)
+static int tsi108_set_mac(net_device *dev, void *addr)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	u32 word1, word2;
 	int i;
 
@@ -1235,9 +1231,9 @@ static int tsi108_set_mac(net_device * d
 }
 
 /* Protected by dev->xmit_lock. */
-static void tsi108_set_rx_mode(net_device * dev)
+static void tsi108_set_rx_mode(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	u32 rxcfg = TSI108_ETH_READ_REG(TSI108_EC_RXCFG);
 
 	if (dev->flags & IFF_PROMISC) {
@@ -1294,9 +1290,9 @@ static void tsi108_set_rx_mode(net_devic
 	TSI108_ETH_WRITE_REG(TSI108_EC_RXCFG, rxcfg);
 }
 
-static void tsi108_init_phy(net_device * dev)
+static void tsi108_init_phy(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	u32 i = 0;
 	u16 phyVal = 0;
 
@@ -1304,7 +1300,8 @@ static void tsi108_init_phy(net_device *
 
 	tsi108_write_mii(data, PHY_CTRL, PHY_CTRL_RESET);
 	mb();
-	while (tsi108_read_mii(data, PHY_CTRL, NULL) & PHY_CTRL_RESET) ;
+	while (tsi108_read_mii(data, PHY_CTRL, NULL) & PHY_CTRL_RESET)
+		;
 
 #if (TSI108_PHY_TYPE == PHY_BCM54XX)	/* Broadcom BCM54xx PHY */
 	tsi108_write_mii(data, 0x09, 0x0300);
@@ -1317,7 +1314,8 @@ static void tsi108_init_phy(net_device *
 			 PHY_CTRL,
 			 PHY_CTRL_AUTONEG_EN | PHY_CTRL_AUTONEG_START);
 	mb();
-	while (tsi108_read_mii(data, PHY_CTRL, NULL) & PHY_CTRL_AUTONEG_START) ;
+	while (tsi108_read_mii(data, PHY_CTRL, NULL) & PHY_CTRL_AUTONEG_START)
+		;
 
 	/* Set G/MII mode and receive clock select in TBI control #2.  The
 	 * second port won't work if this isn't done, even though we don't
@@ -1338,7 +1336,9 @@ static void tsi108_init_phy(net_device *
 			data->link_up = 0;
 			break;
 		}
-		mdelay(10);
+		spin_unlock_irq(&phy_lock);
+		msleep(10);
+		spin_lock_irq(&phy_lock);
 	}
 
 	printk(KERN_DEBUG "PHY_STAT reg contains %08x\n", phyVal);
@@ -1348,7 +1348,7 @@ static void tsi108_init_phy(net_device *
 
 static void tsi108_kill_phy(struct net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 
 	spin_lock_irq(&phy_lock);
 	tsi108_write_mii(data, PHY_CTRL, PHY_CTRL_POWERDOWN);
@@ -1359,7 +1359,7 @@ static void tsi108_kill_phy(struct net_d
 static int tsi108_open(struct net_device *dev)
 {
 	int i;
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	unsigned int rxring_size = TSI108_RXRING_LEN * sizeof(rx_desc);
 	unsigned int txring_size = TSI108_TXRING_LEN * sizeof(tx_desc);
 
@@ -1447,11 +1447,8 @@ static int tsi108_open(struct net_device
 	TSI108_ETH_WRITE_REG(TSI108_EC_TXQ_PTRLOW, data->txdma);
 	tsi108_init_phy(dev);
 
-	init_timer(&data->timer);
-	data->timer.expires = jiffies + 1;
-	data->timer.data = (unsigned long)dev;
-	data->timer.function = &tsi108_timed_checker;	/* timer handler */
-	add_timer(&data->timer);
+	setup_timer(&data->timer, tsi108_timed_checker, (unsigned long)dev);
+	mod_timer(&data->timer, jiffies + 1);
 
 	tsi108_restart_rx(data, dev);
 
@@ -1470,9 +1467,9 @@ static int tsi108_open(struct net_device
 	return 0;
 }
 
-static int tsi108_close(net_device * dev)
+static int tsi108_close(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 
 	netif_stop_queue(dev);
 
@@ -1521,9 +1518,9 @@ static int tsi108_close(net_device * dev
 	return 0;
 }
 
-static void tsi108_init_mac(net_device * dev)
+static void tsi108_init_mac(net_device *dev)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 
 	TSI108_ETH_WRITE_REG(TSI108_MAC_CFG2, TSI108_MAC_CFG2_DFLT_PREAMBLE |
 			     TSI108_MAC_CFG2_PADCRC);
@@ -1562,31 +1559,31 @@ static void tsi108_init_mac(net_device *
 	TSI108_ETH_WRITE_REG(TSI108_EC_TXQ_CFG, TSI108_EC_TXQ_CFG_DESC_INT |
 			     TSI108_EC_TXQ_CFG_EOQ_OWN_INT |
 			     TSI108_EC_TXQ_CFG_WSWP | (TSI108_PBM_PORT <<
-						       TSI108_EC_TXQ_CFG_SFNPORT));
+						TSI108_EC_TXQ_CFG_SFNPORT));
 
 	TSI108_ETH_WRITE_REG(TSI108_EC_RXQ_CFG, TSI108_EC_RXQ_CFG_DESC_INT |
 			     TSI108_EC_RXQ_CFG_EOQ_OWN_INT |
 			     TSI108_EC_RXQ_CFG_WSWP | (TSI108_PBM_PORT <<
-						       TSI108_EC_RXQ_CFG_SFNPORT));
+						TSI108_EC_RXQ_CFG_SFNPORT));
 
 	TSI108_ETH_WRITE_REG(TSI108_EC_TXQ_BUFCFG,
 			     TSI108_EC_TXQ_BUFCFG_BURST256 |
 			     TSI108_EC_TXQ_BUFCFG_BSWP | (TSI108_PBM_PORT <<
-							  TSI108_EC_TXQ_BUFCFG_SFNPORT));
+						TSI108_EC_TXQ_BUFCFG_SFNPORT));
 
 	TSI108_ETH_WRITE_REG(TSI108_EC_RXQ_BUFCFG,
 			     TSI108_EC_RXQ_BUFCFG_BURST256 |
 			     TSI108_EC_RXQ_BUFCFG_BSWP | (TSI108_PBM_PORT <<
-							  TSI108_EC_RXQ_BUFCFG_SFNPORT));
+						TSI108_EC_RXQ_BUFCFG_SFNPORT));
 
 	TSI108_ETH_WRITE_REG(TSI108_EC_INTMASK, ~0);
 }
 
-static int tsi108_ioctl(net_device * dev, struct ifreq *rq, int cmd)
+static int tsi108_ioctl(net_device *dev, struct ifreq *rq, int cmd)
 {
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 	struct mii_ioctl_data *mii_data =
-	    (struct mii_ioctl_data *)&rq->ifr_data;
+			(struct mii_ioctl_data *)&rq->ifr_data;
 	int ret;
 
 	switch (cmd) {
@@ -1613,11 +1610,11 @@ static int
 tsi108_init_one(struct platform_device *pdev)
 {
 	struct net_device *dev = NULL;
-	tsi108_prv_data *data = NULL;
+	struct tsi108_prv_data *data = NULL;
 	hw_info *einfo;
 	int ret;
 
-	einfo = ( hw_info *) pdev->dev.platform_data;
+	einfo = pdev->dev.platform_data;
 
 	if (NULL == einfo) {
 		printk(KERN_ERR "tsi-eth %d: Missing additional data!\n",
@@ -1627,7 +1624,7 @@ tsi108_init_one(struct platform_device *
 
 	/* Create an ethernet device instance */
 
-	dev = alloc_etherdev(sizeof(tsi108_prv_data));
+	dev = alloc_etherdev(sizeof(struct tsi108_prv_data));
 	if (!dev) {
 		printk("tsi108_eth: Could not allocate a device structure\n");
 		return -ENOMEM;
@@ -1635,7 +1632,6 @@ tsi108_init_one(struct platform_device *
 
 	printk("tsi108_eth%d: probe...\n", pdev->id);
 	data = netdev_priv(dev);
-	memset(data, 0, sizeof(tsi108_prv_data));
 
 	DBG("tsi108_eth%d: regs:phyresgs:phy:irq_num=0x%x:0x%x:0x%x:0x%x\n",
 			pdev->id, einfo->regs, einfo->phyregs,
@@ -1653,7 +1649,7 @@ tsi108_init_one(struct platform_device *
 	dev->get_stats = tsi108_get_stats;
 	dev->poll = tsi108_poll;
 	dev->do_ioctl = tsi108_ioctl;
-	dev->weight = 64;	/* 64 is more suitable for GigE interface - klai */
+	dev->weight = 64;  /* 64 is more suitable for GigE interface - klai */
 
 	/* Apparently, the Linux networking code won't use scatter-gather
 	 * if the hardware doesn't do checksums.  However, it's faster
@@ -1683,7 +1679,7 @@ tsi108_init_one(struct platform_device *
 	tsi108_init_mac(dev);
 	ret = register_netdev(dev);
 	if (ret < 0) {
-		kfree(dev);
+		free_netdev(dev);
 		return ret;
 	}
 
@@ -1708,12 +1704,11 @@ tsi108_init_one(struct platform_device *
 static void tsi108_timed_checker(unsigned long dev_ptr)
 {
 	struct net_device *dev = (struct net_device *)dev_ptr;
-	tsi108_prv_data *data = netdev_priv(dev);
+	struct tsi108_prv_data *data = netdev_priv(dev);
 
 	tsi108_check_phy(dev);
 	tsi108_check_rxring(dev);
-	data->timer.expires = jiffies + CHECK_PHY_INTERVAL;
-	add_timer(&data->timer);
+	mod_timer(&data->timer, jiffies + CHECK_PHY_INTERVAL);
 }
 
 static int tsi108_ether_init(void)
@@ -1731,7 +1726,7 @@ static int tsi108_ether_init(void)
 static int tsi108_ether_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
-	tsi108_prv_data *priv = netdev_priv(dev);
+	struct tsi108_prv_data *priv = netdev_priv(dev);
 
 	unregister_netdev(dev);
 	tsi108_stop_ethernet(dev);
_

