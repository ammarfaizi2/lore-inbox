Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWDTDZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWDTDZJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 23:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDTDZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 23:25:09 -0400
Received: from sensoria.com ([82.165.244.97]:37057 "EHLO webmail.sensoria.com")
	by vger.kernel.org with ESMTP id S1750719AbWDTDZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 23:25:03 -0400
Reply-To: <dustin@sensoria.com>
From: "Dustin McIntire" <dustin@sensoria.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] net driver: Add support for SMSC LAN911x line of ethernet chips
Date: Wed, 19 Apr 2006 20:24:51 -0700
Organization: Sensoria
Message-ID: <001b01c66429$fdbd82d0$0a67020a@dustinlaptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcZip2dfMRyDiAljTDylbqyJxETYkgBgMlaw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
In-Reply-To: <20060417221345.29f16809.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The patch was badly wordwrapped.  Please fix and resend.
> 

OK, I've fixed the wrapping and removed the CONFIG_ARM restriction.  I've also did my
best to modify the C style to conform to the comments. 

I noticed that the patch is getting ignored by majordomo due to its size >100K. 
Should it be broken up somehow to allow posting to the lists?


Signed-off-by: Dustin McIntire <dustin@sensoria.com>

diff -rNup linux-2.6.16.1.orig/drivers/net/Kconfig linux-2.6.16.1/drivers/net/Kconfig
--- linux-2.6.16.1.orig/drivers/net/Kconfig	2006-03-27 22:49:02.000000000 -0800
+++ linux-2.6.16.1/drivers/net/Kconfig	2006-04-18 09:25:23.000000000 -0700
@@ -865,6 +865,22 @@ config DM9000
 	  <file:Documentation/networking/net-modules.txt>.  The module will be
 	  called dm9000.
 
+config SMC911X
+	tristate "SMSC LAN911[5678] support"
+	select CRC32
+	select MII
+	depends on NET_ETHERNET
+	help
+	  This is a driver for SMSC's LAN911x series of Ethernet chipsets
+	  including the new LAN9115, LAN9116, LAN9117, and LAN9118.
+	  Say Y if you want it compiled into the kernel, 
+	  and read the Ethernet-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>.
+
+	  This driver is also available as a module. The module will be 
+	  called smc911x.  If you want to compile it as a module, say M 
+	  here and read <file:Documentation/modules.txt>
+
 config NET_VENDOR_RACAL
 	bool "Racal-Interlan (Micom) NI cards"
 	depends on NET_ETHERNET && ISA
diff -rNup linux-2.6.16.1.orig/drivers/net/Makefile linux-2.6.16.1/drivers/net/Makefile
--- linux-2.6.16.1.orig/drivers/net/Makefile	2006-03-27 22:49:02.000000000 -0800
+++ linux-2.6.16.1/drivers/net/Makefile	2006-04-18 09:23:05.000000000 -0700
@@ -193,6 +193,7 @@ obj-$(CONFIG_AMD8111_ETH) += amd8111e.o
 obj-$(CONFIG_IBMVETH) += ibmveth.o
 obj-$(CONFIG_S2IO) += s2io.o
 obj-$(CONFIG_SMC91X) += smc91x.o
+obj-$(CONFIG_SMC911X) += smc911x.o
 obj-$(CONFIG_DM9000) += dm9000.o
 obj-$(CONFIG_FEC_8XX) += fec_8xx/
 
diff -rNup linux-2.6.16.1.orig/drivers/net/smc911x.c linux-2.6.16.1/drivers/net/smc911x.c
--- linux-2.6.16.1.orig/drivers/net/smc911x.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16.1/drivers/net/smc911x.c	2006-04-18 09:45:22.000000000 -0700
@@ -0,0 +1,2307 @@
+/*
+ * smc911x.c
+ * This is a driver for SMSC's LAN911{5,6,7,8} single-chip Ethernet devices.
+ *
+ * Copyright (C) 2005 Sensoria Corp
+ *	   Derived from the unified SMC91x driver by Nicolas Pitre
+ *	   and the smsc911x.c reference driver by SMSC 
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Arguments:
+ *	 watchdog  = TX watchdog timeout
+ *	 tx_fifo_kb = Size of TX FIFO in KB
+ *
+ * History:
+ *	  04/16/05	Dustin McIntire		 Initial version
+ */
+static const char version[] =
+	 "smc911x.c: v1.0 04-16-2005 by Dustin McIntire <dustin@sensoria.com>\n";
+
+/* Debugging options */
+#define ENABLE_SMC_DEBUG_RX		0
+#define ENABLE_SMC_DEBUG_TX		0
+#define ENABLE_SMC_DEBUG_DMA		0
+#define ENABLE_SMC_DEBUG_PKTS		0
+#define ENABLE_SMC_DEBUG_MISC		0
+#define ENABLE_SMC_DEBUG_FUNC		0
+
+#define SMC_DEBUG_RX		((ENABLE_SMC_DEBUG_RX	? 1 : 0) << 0)
+#define SMC_DEBUG_TX		((ENABLE_SMC_DEBUG_TX	? 1 : 0) << 1)
+#define SMC_DEBUG_DMA		((ENABLE_SMC_DEBUG_DMA	? 1 : 0) << 2)
+#define SMC_DEBUG_PKTS		((ENABLE_SMC_DEBUG_PKTS ? 1 : 0) << 3)
+#define SMC_DEBUG_MISC		((ENABLE_SMC_DEBUG_MISC ? 1 : 0) << 4)
+#define SMC_DEBUG_FUNC		((ENABLE_SMC_DEBUG_FUNC ? 1 : 0) << 5)
+
+#ifndef SMC_DEBUG
+#define SMC_DEBUG	 ( SMC_DEBUG_RX	  | \
+			   SMC_DEBUG_TX	  | \
+			   SMC_DEBUG_DMA  | \
+			   SMC_DEBUG_PKTS | \
+			   SMC_DEBUG_MISC | \
+			   SMC_DEBUG_FUNC   \
+			 )
+#endif
+
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/crc32.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/ethtool.h>
+#include <linux/mii.h>
+#include <linux/workqueue.h>
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+
+#include "smc911x.h"
+
+/*
+ * Transmit timeout, default 5 seconds.
+ */
+static int watchdog = 5000;
+module_param(watchdog, int, 0400);
+MODULE_PARM_DESC(watchdog, "transmit timeout in milliseconds");
+
+static int tx_fifo_kb=8;
+module_param(tx_fifo_kb, int, 0400);
+MODULE_PARM_DESC(tx_fifo_kb,"transmit FIFO size in KB (1<x<15)(default=8)");
+
+MODULE_LICENSE("GPL");
+
+/*
+ * The internal workings of the driver.  If you are changing anything
+ * here with the SMC stuff, you should have the datasheet and know
+ * what you are doing.
+ */
+#define CARDNAME "smc911x"
+
+/*
+ * Use power-down feature of the chip
+ */
+#define POWER_DOWN		 1
+
+
+/* store this information for the driver.. */
+struct smc911x_local {
+	/*
+	 * If I have to wait until the DMA is finished and ready to reload a
+	 * packet, I will store the skbuff here. Then, the DMA will send it 
+	 * out and free it.
+	 */
+	struct sk_buff *pending_tx_skb;
+
+	/*
+	 * these are things that the kernel wants me to keep, so users
+	 * can find out semi-useless statistics of how well the card is
+	 * performing
+	 */
+	struct net_device_stats stats;
+
+	/* version/revision of the SMC911x chip */
+	u16 version;
+	u16 revision;
+
+	/* FIFO sizes */
+	int tx_fifo_kb;
+	int tx_fifo_size;
+	int rx_fifo_size;
+	int afc_cfg;
+
+	/* Contains the current active receive/phy mode */
+	int ctl_rfduplx;
+	int ctl_rspeed;
+
+	u32 msg_enable;
+	u32 phy_type;
+	struct mii_if_info mii;
+
+	/* work queue */
+	struct work_struct phy_configure;
+	int work_pending;
+
+	int tx_throttle;
+	spinlock_t lock;
+
+#ifdef SMC_USE_DMA
+	/* DMA needs the physical address of the chip */
+	u_long physaddr;
+	int rxdma;
+	int txdma;
+	int rxdma_active;
+	int txdma_active;
+	struct sk_buff *current_rx_skb;
+	struct sk_buff *current_tx_skb;
+	struct device *dev;
+#endif
+};
+
+#if SMC_DEBUG > 0
+#define DBG(n, args...)				 \
+	do {					 \
+		if (SMC_DEBUG & (n))		 \
+			printk(args);		 \
+	} while (0)
+
+#define PRINTK(args...)   printk(args)
+#else
+#define DBG(n, args...)   do { } while (0)
+#define PRINTK(args...)   printk(KERN_DEBUG args)
+#endif
+
+#if SMC_DEBUG_PKTS > 0
+static void PRINT_PKT(u_char *buf, int length)
+{
+	int i;
+	int remainder;
+	int lines;
+
+	lines = length / 16;
+	remainder = length % 16;
+
+	for (i = 0; i < lines ; i ++) {
+		int cur;
+		for (cur = 0; cur < 8; cur++) {
+			u_char a, b;
+			a = *buf++;
+			b = *buf++;
+			printk("%02x%02x ", a, b);
+		}
+		printk("\n");
+	}
+	for (i = 0; i < remainder/2 ; i++) {
+		u_char a, b;
+		a = *buf++;
+		b = *buf++;
+		printk("%02x%02x ", a, b);
+	}
+	printk("\n");
+}
+#else
+#define PRINT_PKT(x...)  do { } while (0)
+#endif
+
+
+/* this enables an interrupt in the interrupt mask register */
+#define SMC_ENABLE_INT(x) do {				\
+	unsigned int  __mask;				\
+	unsigned long __flags;				\
+	spin_lock_irqsave(&lp->lock, __flags);		\
+	__mask = SMC_GET_INT_EN();			\
+	__mask |= (x);					\
+	SMC_SET_INT_EN(__mask);				\
+	spin_unlock_irqrestore(&lp->lock, __flags);	\
+} while (0)
+
+/* this disables an interrupt from the interrupt mask register */
+#define SMC_DISABLE_INT(x) do {				\
+	unsigned int  __mask;				\
+	unsigned long __flags;				\
+	spin_lock_irqsave(&lp->lock, __flags);		\
+	__mask = SMC_GET_INT_EN();			\
+	__mask &= ~(x);					\
+	SMC_SET_INT_EN(__mask);				\
+	spin_unlock_irqrestore(&lp->lock, __flags);	\
+} while (0)
+
+/*
+ * this does a soft reset on the device
+ */
+static void smc911x_reset(struct net_device *dev)
+{
+	unsigned long ioaddr = dev->base_addr;
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned int reg, timeout=0, resets=1;
+	unsigned long flags;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+	/*	 Take out of PM setting first */
+	if ((SMC_GET_PMT_CTRL() & PMT_CTRL_READY_) == 0) {
+		/* Write to the bytetest will take out of powerdown */
+		SMC_SET_BYTE_TEST(0);	  
+		timeout=10;
+		do {
+			udelay(10);
+			reg = SMC_GET_PMT_CTRL() & PMT_CTRL_READY_;
+		} while ( timeout-- && !reg);
+		if (timeout == 0) {
+			PRINTK("%s: smc911x_reset timeout waiting for PM restore\n", dev->name);
+			return;
+		}
+	}
+
+	/* Disable all interrupts */
+	spin_lock_irqsave(&lp->lock, flags);
+	SMC_SET_INT_EN(0);
+	spin_unlock_irqrestore(&lp->lock, flags);
+
+	while (resets--) {
+		SMC_SET_HW_CFG(HW_CFG_SRST_);
+		timeout=10;
+		do {
+			udelay(10);
+			reg = SMC_GET_HW_CFG();
+			/* If chip indicates reset timeout then try again */
+			if (reg & HW_CFG_SRST_TO_) {
+				PRINTK("%s: chip reset timeout, retrying...\n", dev->name);
+				resets++;
+				break;
+			}
+		} while ( timeout-- && (reg & HW_CFG_SRST_));
+	}
+	if (timeout == 0) {
+		PRINTK("%s: smc911x_reset timeout waiting for reset\n", dev->name);
+		return;
+	}
+
+	/* make sure EEPROM has finished loading before setting GPIO_CFG */
+	timeout=1000;
+	while ( timeout-- && (SMC_GET_E2P_CMD() & E2P_CMD_EPC_BUSY_)) {
+		udelay(10);
+	}
+	if (timeout == 0){
+		PRINTK("%s: smc911x_reset timeout waiting for EEPROM busy\n", dev->name);
+		return;
+	}
+
+	/* Initialize interrupts */
+	SMC_SET_INT_EN(0);
+	SMC_ACK_INT(-1);
+
+	/* Reset the FIFO level and flow control settings */
+	SMC_SET_HW_CFG((lp->tx_fifo_kb & 0xF) << 16);
+//TODO: Figure out what appropriate pause time is
+	SMC_SET_FLOW(FLOW_FCPT_ | FLOW_FCEN_);
+	SMC_SET_AFC_CFG(lp->afc_cfg);
+
+
+	/* Set to LED outputs */
+	SMC_SET_GPIO_CFG(0x70070000);
+
+	/* 
+	 * Deassert IRQ for 1*10us for edge type interrupts
+	 * and drive IRQ pin push-pull 
+	 */
+	SMC_SET_IRQ_CFG( (1 << 24) | INT_CFG_IRQ_EN_ | INT_CFG_IRQ_TYPE_ );
+
+	/* clear anything saved */
+	if (lp->pending_tx_skb != NULL) {
+		dev_kfree_skb (lp->pending_tx_skb);
+		lp->pending_tx_skb = NULL;
+		lp->stats.tx_errors++;
+		lp->stats.tx_aborted_errors++;
+	}
+}
+
+/*
+ * Enable Interrupts, Receive, and Transmit
+ */
+static void smc911x_enable(struct net_device *dev)
+{
+	unsigned long ioaddr = dev->base_addr;
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned mask, cfg, cr;
+	unsigned long flags;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+	SMC_SET_MAC_ADDR(dev->dev_addr);
+
+	/* Enable TX */
+	cfg = SMC_GET_HW_CFG();
+	cfg &= HW_CFG_TX_FIF_SZ_ | 0xFFF;
+	cfg |= HW_CFG_SF_;
+	SMC_SET_HW_CFG(cfg);
+	SMC_SET_FIFO_TDA(0xFF);
+	/* Update TX stats on every 64 packets received or every 1 sec */
+	SMC_SET_FIFO_TSL(64);
+	SMC_SET_GPT_CFG(GPT_CFG_TIMER_EN_ | 10000);
+
+	spin_lock_irqsave(&lp->lock, flags);
+	SMC_GET_MAC_CR(cr);
+	cr |= MAC_CR_TXEN_ | MAC_CR_HBDIS_;
+	SMC_SET_MAC_CR(cr);
+	SMC_SET_TX_CFG(TX_CFG_TX_ON_);
+	spin_unlock_irqrestore(&lp->lock, flags);
+
+	/* Add 2 byte padding to start of packets */
+	SMC_SET_RX_CFG((2<<8) & RX_CFG_RXDOFF_);
+
+	/* Turn on receiver and enable RX */
+	if (cr & MAC_CR_RXEN_)
+		DBG(SMC_DEBUG_RX, "%s: Receiver already enabled\n", dev->name);
+
+	spin_lock_irqsave(&lp->lock, flags);
+	SMC_SET_MAC_CR( cr | MAC_CR_RXEN_ );
+	spin_unlock_irqrestore(&lp->lock, flags);
+
+	/* Interrupt on every received packet */
+	SMC_SET_FIFO_RSA(0x01);
+	SMC_SET_FIFO_RSL(0x00);
+
+	/* now, enable interrupts */
+	mask = INT_EN_TDFA_EN_ | INT_EN_TSFL_EN_ | INT_EN_RSFL_EN_ | 
+		INT_EN_GPT_INT_EN_ | INT_EN_RXDFH_INT_EN_ | INT_EN_RXE_EN_ | 
+		INT_EN_PHY_INT_EN_;
+	if (IS_REV_A(lp->revision))
+		mask|=INT_EN_RDFL_EN_;
+	else {
+		mask|=INT_EN_RDFO_EN_;
+	}
+	SMC_ENABLE_INT(mask);
+}
+
+/*
+ * this puts the device in an inactive state
+ */
+static void smc911x_shutdown(struct net_device *dev)
+{
+	unsigned long ioaddr = dev->base_addr;
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned cr;
+	unsigned long flags;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", CARDNAME, __FUNCTION__);
+
+	/* Disable IRQ's */
+	SMC_SET_INT_EN(0);
+
+	/* Turn of Rx and TX */
+	spin_lock_irqsave(&lp->lock, flags);
+	SMC_GET_MAC_CR(cr);
+	cr &= ~(MAC_CR_TXEN_ | MAC_CR_RXEN_ | MAC_CR_HBDIS_);
+	SMC_SET_MAC_CR(cr);
+	SMC_SET_TX_CFG(TX_CFG_STOP_TX_);
+	spin_unlock_irqrestore(&lp->lock, flags);
+}
+
+static inline void smc911x_drop_pkt(struct net_device *dev)
+{ 
+	unsigned long ioaddr = dev->base_addr;
+	unsigned int fifo_count, timeout, reg;
+
+	DBG(SMC_DEBUG_FUNC | SMC_DEBUG_RX, "%s: --> %s\n", CARDNAME, __FUNCTION__);
+	fifo_count = SMC_GET_RX_FIFO_INF() & 0xFFFF; 
+	if (fifo_count <= 4) {
+		/* Manually dump the packet data */
+		while (fifo_count--)
+			SMC_GET_RX_FIFO();
+	} else	 {
+		/* Fast forward through the bad packet */
+		SMC_SET_RX_DP_CTRL(RX_DP_CTRL_FFWD_BUSY_);
+		timeout=50;
+		do {
+			udelay(10);
+			reg = SMC_GET_RX_DP_CTRL() & RX_DP_CTRL_FFWD_BUSY_;
+		} while ( timeout-- && reg);
+		if (timeout == 0) {
+			PRINTK("%s: timeout waiting for RX fast forward\n", dev->name);
+		}
+	}
+}
+
+/*
+ * This is the procedure to handle the receipt of a packet.
+ * It should be called after checking for packet presence in
+ * the RX status FIFO.	 It must be called with the spin lock 
+ * already held.
+ */
+static inline void	 smc911x_rcv(struct net_device *dev)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned long ioaddr = dev->base_addr;
+	unsigned int pkt_len, status;
+	struct sk_buff *skb;
+	unsigned char *data;
+
+	DBG(SMC_DEBUG_FUNC | SMC_DEBUG_RX, "%s: --> %s\n", 
+		dev->name, __FUNCTION__);
+	status = SMC_GET_RX_STS_FIFO();
+	DBG(SMC_DEBUG_RX, "%s: Rx pkt len %d status 0x%08x \n", 
+		dev->name, (status & 0x3fff0000) >> 16, status & 0xc000ffff);
+	pkt_len = (status & RX_STS_PKT_LEN_) >> 16;
+	if (status & RX_STS_ES_) { 
+		/* Deal with a bad packet */
+		lp->stats.rx_errors++;
+		if (status & RX_STS_CRC_ERR_) 
+			lp->stats.rx_crc_errors++;
+		else {
+			if (status & RX_STS_LEN_ERR_)
+				lp->stats.rx_length_errors++;
+			if (status & RX_STS_MCAST_) 
+				lp->stats.multicast++;
+		}
+		/* Remove the bad packet data from the RX FIFO */
+		smc911x_drop_pkt(dev);
+	} else {
+		/* Receive a valid packet */
+		/* Alloc a buffer with extra room for DMA alignment */
+		skb=dev_alloc_skb(pkt_len+32);
+		if (unlikely(skb == NULL)) {
+			PRINTK( "%s: Low memory, rcvd packet dropped.\n",
+				dev->name);
+			lp->stats.rx_dropped++;
+			smc911x_drop_pkt(dev);
+			return;
+		}
+		/* Align IP header to 32 bits 
+		 * Note that the device is configured to add a 2
+		 * byte padding to the packet start, so we really 
+		 * want to write to the orignal data pointer */
+		data = skb->data;
+		skb_reserve(skb, 2);
+		skb_put(skb,pkt_len-4);
+#ifdef SMC_USE_DMA
+		{
+		unsigned int fifo;
+		/* Lower the FIFO threshold if possible */
+		fifo = SMC_GET_FIFO_INT();
+		if (fifo & 0xFF) fifo--;
+		DBG(SMC_DEBUG_RX, "%s: Setting RX stat FIFO threshold to %d\n",
+			dev->name, fifo & 0xff);
+		SMC_SET_FIFO_INT(fifo);
+		/* Setup RX DMA */
+		SMC_SET_RX_CFG(RX_CFG_RX_END_ALGN16_ | ((2<<8) & RX_CFG_RXDOFF_));
+		lp->rxdma_active = 1;
+		lp->current_rx_skb = skb;
+		SMC_PULL_DATA(data, (pkt_len+2+15) & ~15);
+		/* Packet processing deferred to DMA RX interrupt */
+		}
+#else
+		SMC_SET_RX_CFG(RX_CFG_RX_END_ALGN4_ | ((2<<8) & RX_CFG_RXDOFF_));
+		SMC_PULL_DATA(data, pkt_len+2+3);
+
+		DBG(SMC_DEBUG_PKTS, "%s: Received packet\n", dev->name,);
+		PRINT_PKT(data, ((pkt_len - 4) <= 64) ? pkt_len - 4 : 64);
+		dev->last_rx = jiffies;
+		skb->dev = dev;
+		skb->protocol = eth_type_trans(skb, dev);
+		netif_rx(skb);
+		lp->stats.rx_packets++;
+		lp->stats.rx_bytes += pkt_len-4;
+#endif
+	}
+}
+
+/*
+ * This is called to actually send a packet to the chip.
+ */
+static void smc911x_hardware_send_pkt(struct net_device *dev)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned long ioaddr = dev->base_addr;
+	struct sk_buff *skb;
+	unsigned int cmdA, cmdB, len;
+	unsigned char *buf;
+	unsigned long flags;
+
+	DBG(SMC_DEBUG_FUNC | SMC_DEBUG_TX, "%s: --> %s\n", dev->name, __FUNCTION__);
+	BUG_ON(lp->pending_tx_skb == NULL);
+
+	skb = lp->pending_tx_skb;
+	lp->pending_tx_skb = NULL;
+
+	/* cmdA {25:24] data alignment [20:16] start offset [10:0] buffer length */ 
+	/* cmdB {31:16] pkt tag [10:0] length */ 
+#ifdef SMC_USE_DMA
+	/* 16 byte buffer alignment mode */
+	buf = (char*)((u32)(skb->data) & ~0xF);
+	len = (skb->len + 0xF + ((u32)skb->data & 0xF)) & ~0xF; 
+	cmdA = (1<<24) | (((u32)skb->data & 0xF)<<16) |
+			TX_CMD_A_INT_FIRST_SEG_ | TX_CMD_A_INT_LAST_SEG_ |
+			skb->len;
+#else
+	buf = (char*)((u32)skb->data & ~0x3);
+	len = (skb->len + 3 + ((u32)skb->data & 3)) & ~0x3; 
+	cmdA = (((u32)skb->data & 0x3) << 16) |
+			TX_CMD_A_INT_FIRST_SEG_ | TX_CMD_A_INT_LAST_SEG_ |
+			skb->len;
+#endif
+	/* tag is packet length so we can use this in stats update later */ 
+	cmdB = (skb->len  << 16) | (skb->len & 0x7FF);
+ 
+	DBG(SMC_DEBUG_TX, "%s: TX PKT LENGTH 0x%04x (%d) BUF 0x%p CMDA 0x%08x CMDB 0x%08x\n",
+		 dev->name, len, len, buf, cmdA, cmdB);
+	SMC_SET_TX_FIFO(cmdA);
+	SMC_SET_TX_FIFO(cmdB);
+
+	DBG(SMC_DEBUG_PKTS, "%s: Transmitted packet\n", dev->name);
+	PRINT_PKT(buf, len <= 64 ? len : 64);
+
+	/* Send pkt via PIO or DMA */
+#ifdef SMC_USE_DMA
+	lp->current_tx_skb = skb;
+	SMC_PUSH_DATA(buf, len);
+	/* DMA complete IRQ will free buffer and set jiffies */
+#else
+	SMC_PUSH_DATA(buf, len);
+	dev->trans_start = jiffies;
+	dev_kfree_skb(skb);
+#endif
+	spin_lock_irqsave(&lp->lock, flags);
+	if (!lp->tx_throttle) {
+		netif_wake_queue(dev);
+	}
+	spin_unlock_irqrestore(&lp->lock, flags);
+	SMC_ENABLE_INT(INT_EN_TDFA_EN_ | INT_EN_TSFL_EN_);
+}
+
+/*
+ * Since I am not sure if I will have enough room in the chip's ram
+ * to store the packet, I call this routine which either sends it
+ * now, or set the card to generates an interrupt when ready
+ * for the packet.
+ */
+static int smc911x_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned long ioaddr = dev->base_addr;
+	unsigned int free;
+	unsigned long flags;
+
+	DBG(SMC_DEBUG_FUNC | SMC_DEBUG_TX, "%s: --> %s\n", 
+		dev->name, __FUNCTION__);
+
+	BUG_ON(lp->pending_tx_skb != NULL);
+
+	free = SMC_GET_TX_FIFO_INF() & TX_FIFO_INF_TDFREE_;
+	DBG(SMC_DEBUG_TX, "%s: TX free space %d\n", dev->name, free);
+
+	/* Turn off the flow when running out of space in FIFO */
+	if (free <= SMC911X_TX_FIFO_LOW_THRESHOLD) {
+		DBG(SMC_DEBUG_TX, "%s: Disabling data flow due to low FIFO space (%d)\n", 
+			dev->name, free);
+		spin_lock_irqsave(&lp->lock, flags);
+		/* Reenable when at least 1 packet of size MTU present */
+		SMC_SET_FIFO_TDA((SMC911X_TX_FIFO_LOW_THRESHOLD)/64);
+		lp->tx_throttle = 1;
+		netif_stop_queue(dev);
+		spin_unlock_irqrestore(&lp->lock, flags);
+	}
+
+	/* Drop packets when we run out of space in TX FIFO 
+	 * Account for overhead required for:
+	 * 
+	 *	  Tx command words			 8 bytes 
+	 *	  Start offset				 15 bytes
+	 *	  End padding				 15 bytes
+	 */	 
+	if (unlikely(free < (skb->len + 8 + 15 + 15))) {
+		printk("%s: No Tx free space %d < %d\n", 
+			dev->name, free, skb->len);
+		lp->pending_tx_skb = NULL;
+		lp->stats.tx_errors++;
+		lp->stats.tx_dropped++;
+		dev_kfree_skb(skb);
+		return 0;
+	}
+	
+#ifdef SMC_USE_DMA
+	{
+		/* If the DMA is already running then defer this packet Tx until
+		 * the DMA IRQ starts it 
+		 */
+		spin_lock_irqsave(&lp->lock, flags);
+		if (lp->txdma_active) {
+			DBG(SMC_DEBUG_TX | SMC_DEBUG_DMA, "%s: Tx DMA running, deferring packet\n", dev->name);
+			lp->pending_tx_skb = skb;
+			netif_stop_queue(dev);
+			spin_unlock_irqrestore(&lp->lock, flags);
+			return 0;
+		} else {
+			DBG(SMC_DEBUG_TX | SMC_DEBUG_DMA, "%s: Activating Tx DMA\n", dev->name);
+			lp->txdma_active = 1;
+		}
+		spin_unlock_irqrestore(&lp->lock, flags);
+	}
+#endif
+	lp->pending_tx_skb = skb;
+	smc911x_hardware_send_pkt(dev);
+
+	return 0;
+}
+
+/*
+ * This handles a TX status interrupt, which is only called when:
+ * - a TX error occurred, or
+ * - TX of a packet completed.
+ */
+static void smc911x_tx(struct net_device *dev)
+{
+	unsigned long ioaddr = dev->base_addr;
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned int tx_status;
+
+	DBG(SMC_DEBUG_FUNC | SMC_DEBUG_TX, "%s: --> %s\n", 
+		dev->name, __FUNCTION__);
+
+	/* Collect the TX status */
+	while (((SMC_GET_TX_FIFO_INF() & TX_FIFO_INF_TSUSED_) >> 16) != 0) {
+		DBG(SMC_DEBUG_TX, "%s: Tx stat FIFO used 0x%04x\n", 
+			dev->name, 
+			(SMC_GET_TX_FIFO_INF() & TX_FIFO_INF_TSUSED_) >> 16);
+		tx_status = SMC_GET_TX_STS_FIFO();
+		lp->stats.tx_packets++;
+		lp->stats.tx_bytes+=tx_status>>16;
+		DBG(SMC_DEBUG_TX, "%s: Tx FIFO tag 0x%04x status 0x%04x\n", 
+			dev->name, (tx_status & 0xffff0000) >> 16, 
+			tx_status & 0x0000ffff);
+		/* count Tx errors, but ignore lost carrier errors when in 
+		 * full-duplex mode */
+		if ((tx_status & TX_STS_ES_) && !(lp->ctl_rfduplx && 
+		    !(tx_status & 0x00000306))) {
+			lp->stats.tx_errors++;
+		}
+		if (tx_status & TX_STS_MANY_COLL_) {
+			lp->stats.collisions+=16;
+			lp->stats.tx_aborted_errors++;
+		} else {
+			lp->stats.collisions+=(tx_status & TX_STS_COLL_CNT_) >> 3;
+		}
+		/* carrier error only has meaning for half-duplex communication */
+		if ((tx_status & (TX_STS_LOC_ | TX_STS_NO_CARR_)) && 
+		    !lp->ctl_rfduplx) {
+			lp->stats.tx_carrier_errors++;
+		}	 
+		if (tx_status & TX_STS_LATE_COLL_) {
+			lp->stats.collisions++;
+			lp->stats.tx_aborted_errors++;
+		}
+	}
+}
+
+
+/*---PHY CONTROL AND CONFIGURATION-----------------------------------------*/
+/*
+ * Reads a register from the MII Management serial interface
+ */
+
+static int smc911x_phy_read(struct net_device *dev, int phyaddr, int phyreg)
+{
+	unsigned long ioaddr = dev->base_addr;
+	unsigned int phydata;
+
+	SMC_GET_MII(phyreg, phyaddr, phydata);
+
+	DBG(SMC_DEBUG_MISC, "%s: phyaddr=0x%x, phyreg=0x%02x, phydata=0x%04x\n",
+		__FUNCTION__, phyaddr, phyreg, phydata);
+	return phydata;
+}
+
+
+/*
+ * Writes a register to the MII Management serial interface
+ */
+static void smc911x_phy_write(struct net_device *dev, int phyaddr, int phyreg,
+			int phydata)
+{
+	unsigned long ioaddr = dev->base_addr;
+
+	DBG(SMC_DEBUG_MISC, "%s: phyaddr=0x%x, phyreg=0x%x, phydata=0x%x\n",
+		__FUNCTION__, phyaddr, phyreg, phydata);
+
+	SMC_SET_MII(phyreg, phyaddr, phydata);
+}
+
+/*
+ * Finds and reports the PHY address (115 and 117 have external
+ * PHY interface 118 has internal only
+ */
+static void smc911x_phy_detect(struct net_device *dev)
+{
+	unsigned long ioaddr = dev->base_addr;
+	struct smc911x_local *lp = netdev_priv(dev);
+	int phyaddr;
+	unsigned int cfg, id1, id2;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+	lp->phy_type = 0;
+
+	/*
+	 * Scan all 32 PHY addresses if necessary, starting at
+	 * PHY#1 to PHY#31, and then PHY#0 last.
+	 */
+	switch(lp->version) {
+		case 0x115:
+		case 0x117:
+			cfg = SMC_GET_HW_CFG(); 
+			if (cfg & HW_CFG_EXT_PHY_DET_) {
+				cfg &= ~HW_CFG_PHY_CLK_SEL_;
+				cfg |= HW_CFG_PHY_CLK_SEL_CLK_DIS_;
+				SMC_SET_HW_CFG(cfg);
+				udelay(10); /* Wait for clocks to stop */
+
+				cfg |= HW_CFG_EXT_PHY_EN_;
+				SMC_SET_HW_CFG(cfg);
+				udelay(10); /* Wait for clocks to stop */
+
+				cfg &= ~HW_CFG_PHY_CLK_SEL_;
+				cfg |= HW_CFG_PHY_CLK_SEL_EXT_PHY_;
+				SMC_SET_HW_CFG(cfg);
+				udelay(10); /* Wait for clocks to stop */
+
+				cfg |= HW_CFG_SMI_SEL_;
+				SMC_SET_HW_CFG(cfg);
+
+				for (phyaddr = 1; phyaddr < 32; ++phyaddr) {
+
+					/* Read the PHY identifiers */
+					SMC_GET_PHY_ID1(phyaddr & 31, id1);
+					SMC_GET_PHY_ID2(phyaddr & 31, id2);
+
+					/* Make sure it is a valid identifier */
+					if (id1 != 0x0000 && id1 != 0xffff && 
+					    id1 != 0x8000 && id2 != 0x0000 && 
+					    id2 != 0xffff && id2 != 0x8000) {
+						/* Save the PHY's address */
+						lp->mii.phy_id = phyaddr & 31;
+						lp->phy_type = id1 << 16 | id2;
+						break;
+					}
+				}
+			}
+		default:
+			/* Internal media only */
+			SMC_GET_PHY_ID1(1, id1);
+			SMC_GET_PHY_ID2(1, id2);
+			/* Save the PHY's address */
+			lp->mii.phy_id = 1;
+			lp->phy_type = id1 << 16 | id2;
+	}
+
+	DBG(SMC_DEBUG_MISC, "%s: phy_id1=0x%x, phy_id2=0x%x phyaddr=0x%d\n",
+		dev->name, id1, id2, lp->mii.phy_id);
+}
+
+/*
+ * Sets the PHY to a configuration as determined by the user.
+ * Called with spin_lock held.
+ */
+static int smc911x_phy_fixed(struct net_device *dev)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned long ioaddr = dev->base_addr;
+	int phyaddr = lp->mii.phy_id;
+	int bmcr;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+	/* Enter Link Disable state */
+	SMC_GET_PHY_BMCR(phyaddr, bmcr);
+	bmcr |= BMCR_PDOWN;
+	SMC_SET_PHY_BMCR(phyaddr, bmcr);
+
+	/*
+	 * Set our fixed capabilities
+	 * Disable auto-negotiation
+	 */
+	bmcr &= ~BMCR_ANENABLE;
+	if (lp->ctl_rfduplx)
+		bmcr |= BMCR_FULLDPLX;
+
+	if (lp->ctl_rspeed == 100)
+		bmcr |= BMCR_SPEED100;
+
+	/* Write our capabilities to the phy control register */
+	SMC_SET_PHY_BMCR(phyaddr, bmcr);
+
+	/* Re-Configure the Receive/Phy Control register */
+	bmcr &= ~BMCR_PDOWN;
+	SMC_SET_PHY_BMCR(phyaddr, bmcr);
+
+	return 1;
+}
+
+/*
+ * smc911x_phy_reset - reset the phy
+ * @dev: net device
+ * @phy: phy address
+ *
+ * Issue a software reset for the specified PHY and
+ * wait up to 100ms for the reset to complete.	 We should
+ * not access the PHY for 50ms after issuing the reset.
+ *
+ * The time to wait appears to be dependent on the PHY.
+ *
+ */
+static int smc911x_phy_reset(struct net_device *dev, int phy)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned long ioaddr = dev->base_addr;
+	int timeout;
+	unsigned long flags;
+	unsigned int reg;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s()\n", dev->name, __FUNCTION__);
+
+	spin_lock_irqsave(&lp->lock, flags);
+	reg = SMC_GET_PMT_CTRL();
+	reg &= ~0xfffff030;
+	reg |= PMT_CTRL_PHY_RST_;
+	SMC_SET_PMT_CTRL(reg);
+	spin_unlock_irqrestore(&lp->lock, flags);
+	for (timeout = 2; timeout; timeout--) {
+		msleep(50);
+		spin_lock_irqsave(&lp->lock, flags);
+		reg = SMC_GET_PMT_CTRL();
+		spin_unlock_irqrestore(&lp->lock, flags);
+		if (!(reg & PMT_CTRL_PHY_RST_)) {
+			/* extra delay required because the phy may 
+			 * not be completed with its reset
+			 * when PHY_BCR_RESET_ is cleared. 256us 
+			 * should suffice, but use 500us to be safe
+			 */
+			udelay(500);
+		break;
+		}
+	}
+
+	return reg & PMT_CTRL_PHY_RST_;
+}
+
+/*
+ * smc911x_phy_powerdown - powerdown phy
+ * @dev: net device
+ * @phy: phy address
+ *
+ * Power down the specified PHY
+ */
+static void smc911x_phy_powerdown(struct net_device *dev, int phy)
+{
+	unsigned long ioaddr = dev->base_addr;
+	unsigned int bmcr;
+
+	/* Enter Link Disable state */
+	SMC_GET_PHY_BMCR(phy, bmcr);
+	bmcr |= BMCR_PDOWN;
+	SMC_SET_PHY_BMCR(phy, bmcr);
+}
+
+/*
+ * smc911x_phy_check_media - check the media status and adjust BMCR
+ * @dev: net device
+ * @init: set true for initialisation
+ *
+ * Select duplex mode depending on negotiation state.	This
+ * also updates our carrier state.
+ */
+static void smc911x_phy_check_media(struct net_device *dev, int init)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned long ioaddr = dev->base_addr;
+	int phyaddr = lp->mii.phy_id;
+	unsigned int bmcr, cr;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+	if (mii_check_media(&lp->mii, netif_msg_link(lp), init)) {
+		/* duplex state has changed */
+		SMC_GET_PHY_BMCR(phyaddr, bmcr);
+		SMC_GET_MAC_CR(cr);
+		if (lp->mii.full_duplex) {
+			DBG(SMC_DEBUG_MISC, "%s: Configuring for full-duplex mode\n", dev->name);
+			bmcr |= BMCR_FULLDPLX;
+			cr |= MAC_CR_RCVOWN_;
+		} else {
+			DBG(SMC_DEBUG_MISC, "%s: Configuring for half-duplex mode\n", dev->name);
+			bmcr &= ~BMCR_FULLDPLX;
+			cr &= ~MAC_CR_RCVOWN_;
+		}
+		SMC_SET_PHY_BMCR(phyaddr, bmcr);
+		SMC_SET_MAC_CR(cr);
+	}
+}
+
+/*
+ * Configures the specified PHY through the MII management interface
+ * using Autonegotiation.
+ * Calls smc911x_phy_fixed() if the user has requested a certain config.
+ * If RPC ANEG bit is set, the media selection is dependent purely on
+ * the selection by the MII (either in the MII BMCR reg or the result
+ * of autonegotiation.)  If the RPC ANEG bit is cleared, the selection
+ * is controlled by the RPC SPEED and RPC DPLX bits.
+ */
+static void smc911x_phy_configure(void *data)
+{
+	struct net_device *dev = data;
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned long ioaddr = dev->base_addr;
+	int phyaddr = lp->mii.phy_id;
+	int my_phy_caps; /* My PHY capabilities */
+	int my_ad_caps; /* My Advertised capabilities */
+	int status;
+	unsigned long flags;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s()\n", dev->name, __FUNCTION__);
+
+	/*
+	 * We should not be called if phy_type is zero.
+	 */
+	if (lp->phy_type == 0)
+		 goto smc911x_phy_configure_exit;
+
+	if (smc911x_phy_reset(dev, phyaddr)) {
+		printk("%s: PHY reset timed out\n", dev->name);
+		goto smc911x_phy_configure_exit;
+	}
+	spin_lock_irqsave(&lp->lock, flags);
+
+	/*
+	 * Enable PHY Interrupts (for register 18)
+	 * Interrupts listed here are enabled
+	 */
+	SMC_SET_PHY_INT_MASK(phyaddr, PHY_INT_MASK_ENERGY_ON_ |
+		 PHY_INT_MASK_ANEG_COMP_ | PHY_INT_MASK_REMOTE_FAULT_ |
+		 PHY_INT_MASK_LINK_DOWN_);
+
+	/* If the user requested no auto neg, then go set his request */
+	if (lp->mii.force_media) {
+		smc911x_phy_fixed(dev);
+		goto smc911x_phy_configure_exit;
+	}
+
+	/* Copy our capabilities from MII_BMSR to MII_ADVERTISE */
+	SMC_GET_PHY_BMSR(phyaddr, my_phy_caps);
+	if (!(my_phy_caps & BMSR_ANEGCAPABLE)) {
+		printk(KERN_INFO "Auto negotiation NOT supported\n");
+		smc911x_phy_fixed(dev);
+		goto smc911x_phy_configure_exit;
+	}
+
+	/* CSMA capable w/ both pauses */
+	my_ad_caps = ADVERTISE_CSMA | ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM;
+
+	if (my_phy_caps & BMSR_100BASE4)
+		my_ad_caps |= ADVERTISE_100BASE4;
+	if (my_phy_caps & BMSR_100FULL)
+		my_ad_caps |= ADVERTISE_100FULL;
+	if (my_phy_caps & BMSR_100HALF)
+		my_ad_caps |= ADVERTISE_100HALF;
+	if (my_phy_caps & BMSR_10FULL)
+		my_ad_caps |= ADVERTISE_10FULL;
+	if (my_phy_caps & BMSR_10HALF)
+		my_ad_caps |= ADVERTISE_10HALF;
+
+	/* Disable capabilities not selected by our user */
+	if (lp->ctl_rspeed != 100)
+		my_ad_caps &= ~(ADVERTISE_100BASE4|ADVERTISE_100FULL|ADVERTISE_100HALF);
+
+	 if (!lp->ctl_rfduplx)
+		my_ad_caps &= ~(ADVERTISE_100FULL|ADVERTISE_10FULL);
+
+	/* Update our Auto-Neg Advertisement Register */
+	SMC_SET_PHY_MII_ADV(phyaddr, my_ad_caps);
+	lp->mii.advertising = my_ad_caps;
+
+	/*
+	 * Read the register back.	 Without this, it appears that when
+	 * auto-negotiation is restarted, sometimes it isn't ready and
+	 * the link does not come up.
+	 */
+	udelay(10);
+	SMC_GET_PHY_MII_ADV(phyaddr, status);
+
+	DBG(SMC_DEBUG_MISC, "%s: phy caps=0x%04x\n", dev->name, my_phy_caps);
+	DBG(SMC_DEBUG_MISC, "%s: phy advertised caps=0x%04x\n", dev->name, my_ad_caps);
+
+	/* Restart auto-negotiation process in order to advertise my caps */
+	SMC_SET_PHY_BMCR(phyaddr, BMCR_ANENABLE | BMCR_ANRESTART);
+
+	smc911x_phy_check_media(dev, 1);
+
+smc911x_phy_configure_exit:
+	spin_unlock_irqrestore(&lp->lock, flags);
+	lp->work_pending = 0;
+}
+
+/*
+ * smc911x_phy_interrupt
+ *
+ * Purpose:  Handle interrupts relating to PHY register 18. This is
+ *	 called from the "hard" interrupt handler under our private spinlock.
+ */
+static void smc911x_phy_interrupt(struct net_device *dev)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned long ioaddr = dev->base_addr;
+	int phyaddr = lp->mii.phy_id;
+	int status;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+	if (lp->phy_type == 0)
+		return;
+
+	smc911x_phy_check_media(dev, 0);
+	/* read to clear status bits */
+	SMC_GET_PHY_INT_SRC(phyaddr,status);
+	DBG(SMC_DEBUG_MISC, "%s: PHY interrupt status 0x%04x\n", 
+		dev->name, status & 0xffff);
+	DBG(SMC_DEBUG_MISC, "%s: AFC_CFG 0x%08x\n", 
+		dev->name, SMC_GET_AFC_CFG());
+}
+
+/*--- END PHY CONTROL AND CONFIGURATION-------------------------------------*/
+
+/*
+ * This is the main routine of the driver, to handle the device when
+ * it needs some attention.
+ */
+static irqreturn_t smc911x_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct net_device *dev = dev_id;
+	unsigned long ioaddr = dev->base_addr;
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned int status, mask, timeout;
+	unsigned int rx_overrun=0, cr, pkts;
+	unsigned long flags;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+	spin_lock_irqsave(&lp->lock, flags);
+
+	/* Spurious interrupt check */
+	if ((SMC_GET_IRQ_CFG() & (INT_CFG_IRQ_INT_ | INT_CFG_IRQ_EN_)) !=
+		(INT_CFG_IRQ_INT_ | INT_CFG_IRQ_EN_)) {
+		return IRQ_NONE;
+	}
+
+	mask = SMC_GET_INT_EN();
+	SMC_SET_INT_EN(0);
+
+	/* set a timeout value, so I don't stay here forever */
+	timeout = 8;
+
+
+	do {
+		status = SMC_GET_INT();
+
+		DBG(SMC_DEBUG_MISC, "%s: INT 0x%08x MASK 0x%08x OUTSIDE MASK 0x%08x\n",
+			dev->name, status, mask, status & ~mask);
+
+		status &= mask;
+		if (!status)
+			break;
+
+		/* Handle SW interrupt condition */
+		if (status & INT_STS_SW_INT_) {
+			SMC_ACK_INT(INT_STS_SW_INT_);
+			mask &= ~INT_EN_SW_INT_EN_;
+		}
+		/* Handle various error conditions */
+		if (status & INT_STS_RXE_) {
+			SMC_ACK_INT(INT_STS_RXE_);
+			lp->stats.rx_errors++;
+		} 
+		if (status & INT_STS_RXDFH_INT_) {
+			SMC_ACK_INT(INT_STS_RXDFH_INT_);
+			lp->stats.rx_dropped+=SMC_GET_RX_DROP();
+		 }
+		/* Undocumented interrupt-what is the right thing to do here? */
+		if (status & INT_STS_RXDF_INT_) {
+			SMC_ACK_INT(INT_STS_RXDF_INT_);
+		}
+
+		/* Rx Data FIFO exceeds set level */
+		if (status & INT_STS_RDFL_) {
+			if (IS_REV_A(lp->revision)) {
+				rx_overrun=1;
+				SMC_GET_MAC_CR(cr);
+				cr &= ~MAC_CR_RXEN_;
+				SMC_SET_MAC_CR(cr);
+				DBG(SMC_DEBUG_RX, "%s: RX overrun\n", dev->name);
+				lp->stats.rx_errors++;
+				lp->stats.rx_fifo_errors++;
+			}
+			SMC_ACK_INT(INT_STS_RDFL_);
+		}
+		if (status & INT_STS_RDFO_) {
+			if (!IS_REV_A(lp->revision)) {
+				SMC_GET_MAC_CR(cr);
+				cr &= ~MAC_CR_RXEN_;
+				SMC_SET_MAC_CR(cr);
+				rx_overrun=1;
+				DBG(SMC_DEBUG_RX, "%s: RX overrun\n", dev->name);
+				lp->stats.rx_errors++;
+				lp->stats.rx_fifo_errors++;
+			}
+			SMC_ACK_INT(INT_STS_RDFO_);
+		}
+		/* Handle receive condition */
+		if ((status & INT_STS_RSFL_) || rx_overrun) {
+			unsigned int fifo;
+			DBG(SMC_DEBUG_RX, "%s: RX irq\n", dev->name);
+			fifo = SMC_GET_RX_FIFO_INF(); 
+			pkts = (fifo & RX_FIFO_INF_RXSUSED_) >> 16; 
+			DBG(SMC_DEBUG_RX, "%s: Rx FIFO pkts %d, bytes %d\n", 
+				dev->name, pkts, fifo & 0xFFFF );
+			if (pkts != 0) {
+#ifdef SMC_USE_DMA
+				unsigned int fifo;
+				if (lp->rxdma_active){
+					DBG(SMC_DEBUG_RX | SMC_DEBUG_DMA, 
+						"%s: RX DMA active\n", dev->name);
+					/* The DMA is already running so up the IRQ threshold */
+					fifo = SMC_GET_FIFO_INT() & ~0xFF;
+					fifo |= pkts & 0xFF;
+					DBG(SMC_DEBUG_RX, 
+						"%s: Setting RX stat FIFO threshold to %d\n",
+						dev->name, fifo & 0xff);
+					SMC_SET_FIFO_INT(fifo);
+				} else
+#endif
+				smc911x_rcv(dev);
+			}
+			SMC_ACK_INT(INT_STS_RSFL_);
+		}
+		/* Handle transmit FIFO available */
+		if (status & INT_STS_TDFA_) {
+			DBG(SMC_DEBUG_TX, "%s: TX data FIFO space available irq\n", dev->name);
+			SMC_SET_FIFO_TDA(0xFF);
+			lp->tx_throttle = 0;
+#ifdef SMC_USE_DMA
+			if (!lp->txdma_active)
+#endif
+				netif_wake_queue(dev);
+			SMC_ACK_INT(INT_STS_TDFA_);
+		}
+		/* Handle transmit done condition */
+#if 1
+		if (status & (INT_STS_TSFL_ | INT_STS_GPT_INT_)) {
+			DBG(SMC_DEBUG_TX | SMC_DEBUG_MISC, 
+				"%s: Tx stat FIFO limit (%d) /GPT irq\n", 
+				dev->name, (SMC_GET_FIFO_INT() & 0x00ff0000) >> 16);
+			smc911x_tx(dev);
+			SMC_SET_GPT_CFG(GPT_CFG_TIMER_EN_ | 10000);
+			SMC_ACK_INT(INT_STS_TSFL_);
+			SMC_ACK_INT(INT_STS_TSFL_ | INT_STS_GPT_INT_);
+		}
+#else
+		if (status & INT_STS_TSFL_) {
+			DBG(SMC_DEBUG_TX, "%s: TX status FIFO limit (%d) irq \n", dev->name, );
+			smc911x_tx(dev);
+			SMC_ACK_INT(INT_STS_TSFL_);
+		}
+
+		if (status & INT_STS_GPT_INT_) {
+			DBG(SMC_DEBUG_RX, "%s: IRQ_CFG 0x%08x FIFO_INT 0x%08x RX_CFG 0x%08x\n", 
+				dev->name, 
+				SMC_GET_IRQ_CFG(), 
+				SMC_GET_FIFO_INT(), 
+				SMC_GET_RX_CFG());
+			DBG(SMC_DEBUG_RX, "%s: Rx Stat FIFO Used 0x%02x "
+				"Data FIFO Used 0x%04x Stat FIFO 0x%08x\n",
+				dev->name, 
+				(SMC_GET_RX_FIFO_INF() & 0x00ff0000) >> 16, 
+				SMC_GET_RX_FIFO_INF() & 0xffff, 
+				SMC_GET_RX_STS_FIFO_PEEK());
+			SMC_SET_GPT_CFG(GPT_CFG_TIMER_EN_ | 10000);
+			SMC_ACK_INT(INT_STS_GPT_INT_);
+		}
+#endif
+
+		/* Handle PHY interupt condition */
+		if (status & INT_STS_PHY_INT_) {
+			DBG(SMC_DEBUG_MISC, "%s: PHY irq\n", dev->name);
+			smc911x_phy_interrupt(dev);
+			SMC_ACK_INT(INT_STS_PHY_INT_);
+		}
+	} while (--timeout);
+
+	/* restore mask state */
+	SMC_SET_INT_EN(mask);
+
+	DBG(SMC_DEBUG_MISC, "%s: Interrupt done (%d loops)\n", 
+		dev->name, 8-timeout);
+
+	spin_unlock_irqrestore(&lp->lock, flags);
+
+	DBG(3, "%s: Interrupt done (%d loops)\n", dev->name, 8-timeout);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef SMC_USE_DMA
+static void
+smc911x_tx_dma_irq(int dma, void *data, struct pt_regs *regs)
+{
+	struct net_device *dev = (struct net_device *)data;
+	struct smc911x_local *lp = netdev_priv(dev);
+	struct sk_buff *skb = lp->current_tx_skb;
+	unsigned long flags;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+	DBG(SMC_DEBUG_TX | SMC_DEBUG_DMA, "%s: TX DMA irq handler\n", dev->name);
+	/* Clear the DMA interrupt sources */
+	SMC_DMA_ACK_IRQ(dev, dma);
+	BUG_ON(skb == NULL);
+	dma_unmap_single(NULL, tx_dmabuf, tx_dmalen, DMA_TO_DEVICE);
+	dev->trans_start = jiffies;
+	dev_kfree_skb_irq(skb);
+	lp->current_tx_skb = NULL;
+	if (lp->pending_tx_skb != NULL)
+		smc911x_hardware_send_pkt(dev);
+	else {
+		DBG(SMC_DEBUG_TX | SMC_DEBUG_DMA, 
+			"%s: No pending Tx packets. DMA disabled\n", dev->name);
+		spin_lock_irqsave(&lp->lock, flags);
+		lp->txdma_active = 0;
+		if (!lp->tx_throttle) {
+			netif_wake_queue(dev);
+		}
+		spin_unlock_irqrestore(&lp->lock, flags);
+	}
+
+	DBG(SMC_DEBUG_TX | SMC_DEBUG_DMA, 
+		"%s: TX DMA irq completed\n", dev->name);
+}
+static void
+smc911x_rx_dma_irq(int dma, void *data, struct pt_regs *regs)
+{
+	struct net_device *dev = (struct net_device *)data;
+	unsigned long ioaddr = dev->base_addr;
+	struct smc911x_local *lp = netdev_priv(dev);
+	struct sk_buff *skb = lp->current_rx_skb;
+	unsigned long flags;
+	unsigned int pkts;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+	DBG(SMC_DEBUG_RX | SMC_DEBUG_DMA, "%s: RX DMA irq handler\n", dev->name);
+	/* Clear the DMA interrupt sources */
+	SMC_DMA_ACK_IRQ(dev, dma);
+	dma_unmap_single(NULL, rx_dmabuf, rx_dmalen, DMA_FROM_DEVICE);
+	BUG_ON(skb == NULL);
+	lp->current_rx_skb = NULL;
+	PRINT_PKT(skb->data, skb->len);
+	dev->last_rx = jiffies;
+	skb->dev = dev;
+	skb->protocol = eth_type_trans(skb, dev);
+	netif_rx(skb);
+	lp->stats.rx_packets++;
+	lp->stats.rx_bytes += skb->len;
+
+	spin_lock_irqsave(&lp->lock, flags);
+	pkts = (SMC_GET_RX_FIFO_INF() & RX_FIFO_INF_RXSUSED_) >> 16; 
+	if (pkts != 0) {
+		smc911x_rcv(dev);
+	}else {
+		lp->rxdma_active = 0;
+	}
+	spin_unlock_irqrestore(&lp->lock, flags);
+	DBG(SMC_DEBUG_RX | SMC_DEBUG_DMA, 
+		"%s: RX DMA irq completed. DMA RX FIFO PKTS %d\n", 
+		dev->name, pkts);
+}
+#endif	 /* SMC_USE_DMA */
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/*
+ * Polling receive - used by netconsole and other diagnostic tools
+ * to allow network i/o with interrupts disabled.
+ */
+static void smc911x_poll_controller(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	smc911x_interrupt(dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+#endif
+
+/* Our watchdog timed out. Called by the networking layer */
+static void smc911x_timeout(struct net_device *dev)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned long ioaddr = dev->base_addr;
+	int status, mask;
+	unsigned long flags;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+	spin_lock_irqsave(&lp->lock, flags);
+	status = SMC_GET_INT();
+	mask = SMC_GET_INT_EN();
+	spin_unlock_irqrestore(&lp->lock, flags);
+	DBG(SMC_DEBUG_MISC, "%s: INT 0x%02x MASK 0x%02x \n",
+		dev->name, status, mask);
+
+	/* Dump the current TX FIFO contents and restart */
+	mask = SMC_GET_TX_CFG(); 
+	SMC_SET_TX_CFG(mask | TX_CFG_TXS_DUMP_ | TX_CFG_TXD_DUMP_); 
+	/*
+	 * Reconfiguring the PHY doesn't seem like a bad idea here, but
+	 * smc911x_phy_configure() calls msleep() which calls schedule_timeout()
+	 * which calls schedule().	 Hence we use a work queue.
+	 */
+	if (lp->phy_type != 0) {
+		if (schedule_work(&lp->phy_configure)) {
+			lp->work_pending = 1;
+		}
+	}
+
+	/* We can accept TX packets again */
+	dev->trans_start = jiffies;
+	netif_wake_queue(dev);
+}
+
+/*
+ * This routine will, depending on the values passed to it,
+ * either make it accept multicast packets, go into
+ * promiscuous mode (for TCPDUMP and cousins) or accept
+ * a select set of multicast packets
+ */
+static void smc911x_set_multicast_list(struct net_device *dev)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned long ioaddr = dev->base_addr;
+	unsigned int multicast_table[2];
+	unsigned int mcr, update_multicast = 0;
+	unsigned long flags;
+	/* table for flipping the order of 5 bits */
+	static const unsigned char invert5[] = 
+		{0x00, 0x10, 0x08, 0x18, 0x04, 0x14, 0x0C, 0x1C,
+		 0x02, 0x12, 0x0A, 0x1A, 0x06, 0x16, 0x0E, 0x1E,
+		 0x01, 0x11, 0x09, 0x19, 0x05, 0x15, 0x0D, 0x1D,
+		 0x03, 0x13, 0x0B, 0x1B, 0x07, 0x17, 0x0F, 0x1F};
+
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+	spin_lock_irqsave(&lp->lock, flags);
+	SMC_GET_MAC_CR(mcr);
+	spin_unlock_irqrestore(&lp->lock, flags);
+
+	if (dev->flags & IFF_PROMISC) {
+
+		DBG(SMC_DEBUG_MISC, "%s: RCR_PRMS\n", dev->name);
+		mcr |= MAC_CR_PRMS_;
+	}
+	/*
+	 * Here, I am setting this to accept all multicast packets.
+	 * I don't need to zero the multicast table, because the flag is
+	 * checked before the table is
+	 */
+	else if (dev->flags & IFF_ALLMULTI || dev->mc_count > 16) {
+		DBG(SMC_DEBUG_MISC, "%s: RCR_ALMUL\n", dev->name);
+		mcr |= MAC_CR_MCPAS_;
+	}
+
+	/*
+	 * This sets the internal hardware table to filter out unwanted
+	 * multicast packets before they take up memory.
+	 *
+	 * The SMC chip uses a hash table where the high 6 bits of the CRC of
+	 * address are the offset into the table.	If that bit is 1, then the
+	 * multicast packet is accepted.  Otherwise, it's dropped silently.
+	 *
+	 * To use the 6 bits as an offset into the table, the high 1 bit is
+	 * the number of the 32 bit register, while the low 5 bits are the bit
+	 * within that register.
+	 */
+	else if (dev->mc_count)  {
+		int i;
+		struct dev_mc_list *cur_addr;
+
+		/* Set the Hash perfec mode */
+		mcr |= MAC_CR_HPFILT_;
+
+		/* start with a table of all zeros: reject all */
+		memset(multicast_table, 0, sizeof(multicast_table));
+
+		cur_addr = dev->mc_list;
+		for (i = 0; i < dev->mc_count; i++, cur_addr = cur_addr->next) {
+			int position;
+
+			/* do we have a pointer here? */
+			if (!cur_addr)
+				break;
+			/* make sure this is a multicast address -
+				shouldn't this be a given if we have it here ? */
+			if (!(*cur_addr->dmi_addr & 1))
+				 continue;
+
+			/* only use the low order bits */
+			position = crc32_le(~0, cur_addr->dmi_addr, 6) & 0x3f;
+
+			/* do some messy swapping to put the bit in the right spot */
+			multicast_table[invert5[position&0x1F]&0x1] |=
+				(1<<invert5[(position>>1)&0x1F]);
+		}
+
+		/* be sure I get rid of flags I might have set */
+		mcr &= ~(MAC_CR_PRMS_ | MAC_CR_MCPAS_);
+
+		/* now, the table can be loaded into the chipset */
+		update_multicast = 1;
+	} else	 {
+		DBG(SMC_DEBUG_MISC, "%s: ~(MAC_CR_PRMS_|MAC_CR_MCPAS_)\n", 
+			dev->name);
+		mcr &= ~(MAC_CR_PRMS_ | MAC_CR_MCPAS_);
+
+		/*
+		 * since I'm disabling all multicast entirely, I need to
+		 * clear the multicast list
+		 */
+		memset(multicast_table, 0, sizeof(multicast_table));
+		update_multicast = 1;
+	}
+
+	spin_lock_irqsave(&lp->lock, flags);
+	SMC_SET_MAC_CR(mcr);
+	if (update_multicast) {
+		DBG(SMC_DEBUG_MISC, 
+			"%s: update mcast hash table 0x%08x 0x%08x\n", 
+			dev->name, multicast_table[0], multicast_table[1]);
+		SMC_SET_HASHL(multicast_table[0]);
+		SMC_SET_HASHH(multicast_table[1]);
+	}
+	spin_unlock_irqrestore(&lp->lock, flags);
+}
+
+
+/*
+ * Open and Initialize the board
+ *
+ * Set up everything, reset the card, etc..
+ */
+static int
+smc911x_open(struct net_device *dev)
+{
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+	/*
+	 * Check that the address is valid.  If its not, refuse
+	 * to bring the device up.	 The user must specify an
+	 * address using ifconfig eth0 hw ether xx:xx:xx:xx:xx:xx
+	 */
+	if (!is_valid_ether_addr(dev->dev_addr)) {
+		PRINTK("%s: no valid ethernet hw addr\n", __FUNCTION__);
+		return -EINVAL;
+	}
+
+	/* reset the hardware */
+	smc911x_reset(dev);
+
+	/* Configure the PHY, initialize the link state */
+	smc911x_phy_configure(dev);
+
+	/* Turn on Tx + Rx */
+	smc911x_enable(dev);
+
+	netif_start_queue(dev);
+
+	return 0;
+}
+
+/*
+ * smc911x_close
+ *
+ * this makes the board clean up everything that it can
+ * and not talk to the outside world.	 Caused by
+ * an 'ifconfig ethX down'
+ */
+static int smc911x_close(struct net_device *dev)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+	netif_stop_queue(dev);
+	netif_carrier_off(dev);
+
+	/* clear everything */
+	smc911x_shutdown(dev);
+
+	if (lp->phy_type != 0) {
+		/* We need to ensure that no calls to
+		 * smc911x_phy_configure are pending.
+
+		 * flush_scheduled_work() cannot be called because we
+		 * are running with the netlink semaphore held (from
+		 * devinet_ioctl()) and the pending work queue
+		 * contains linkwatch_event() (scheduled by
+		 * netif_carrier_off() above). linkwatch_event() also
+		 * wants the netlink semaphore.
+		 */
+		while (lp->work_pending)
+			schedule();
+		smc911x_phy_powerdown(dev, lp->mii.phy_id);
+	}
+
+	if (lp->pending_tx_skb) {
+		dev_kfree_skb(lp->pending_tx_skb);
+		lp->pending_tx_skb = NULL;
+	}
+
+	return 0;
+}
+
+/*
+ * Get the current statistics.
+ * This may be called with the card open or closed.
+ */
+static struct net_device_stats *smc911x_query_statistics(struct net_device *dev)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+
+	return &lp->stats;
+}
+
+/*
+ * Ethtool support
+ */
+static int
+smc911x_ethtool_getsettings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned long ioaddr = dev->base_addr;
+	int ret, status;
+	unsigned long flags;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+	cmd->maxtxpkt = 1;
+	cmd->maxrxpkt = 1;
+
+	if (lp->phy_type != 0) {
+		spin_lock_irqsave(&lp->lock, flags);
+		ret = mii_ethtool_gset(&lp->mii, cmd);
+		spin_unlock_irqrestore(&lp->lock, flags);
+	} else {
+		cmd->supported = SUPPORTED_10baseT_Half |
+				SUPPORTED_10baseT_Full |
+				SUPPORTED_TP | SUPPORTED_AUI;
+
+		if (lp->ctl_rspeed == 10)
+			cmd->speed = SPEED_10;
+		else if (lp->ctl_rspeed == 100)
+			cmd->speed = SPEED_100;
+
+		cmd->autoneg = AUTONEG_DISABLE;
+		if (lp->mii.phy_id==1)
+			cmd->transceiver = XCVR_INTERNAL;
+		else
+			cmd->transceiver = XCVR_EXTERNAL;
+		cmd->port = 0;
+		SMC_GET_PHY_SPECIAL(lp->mii.phy_id, status);
+		cmd->duplex = 
+			(status & (PHY_SPECIAL_SPD_10FULL_ | PHY_SPECIAL_SPD_100FULL_)) ? 
+				DUPLEX_FULL : DUPLEX_HALF;
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static int
+smc911x_ethtool_setsettings(struct net_device *dev, struct ethtool_cmd *cmd)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	int ret;
+	unsigned long flags;
+
+	if (lp->phy_type != 0) {
+		spin_lock_irqsave(&lp->lock, flags);
+		ret = mii_ethtool_sset(&lp->mii, cmd);
+		spin_unlock_irqrestore(&lp->lock, flags);
+	} else {
+		if (cmd->autoneg != AUTONEG_DISABLE ||
+			cmd->speed != SPEED_10 ||
+			(cmd->duplex != DUPLEX_HALF && cmd->duplex != DUPLEX_FULL) ||
+			(cmd->port != PORT_TP && cmd->port != PORT_AUI))
+			return -EINVAL;
+
+		lp->ctl_rfduplx = cmd->duplex == DUPLEX_FULL;
+
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static void
+smc911x_ethtool_getdrvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
+{
+	strncpy(info->driver, CARDNAME, sizeof(info->driver));
+	strncpy(info->version, version, sizeof(info->version));
+	strncpy(info->bus_info, dev->class_dev.dev->bus_id, sizeof(info->bus_info));
+}
+
+static int smc911x_ethtool_nwayreset(struct net_device *dev)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	int ret = -EINVAL;
+	unsigned long flags;
+
+	if (lp->phy_type != 0) {
+		spin_lock_irqsave(&lp->lock, flags);
+		ret = mii_nway_restart(&lp->mii);
+		spin_unlock_irqrestore(&lp->lock, flags);
+	}
+
+	return ret;
+}
+
+static u32 smc911x_ethtool_getmsglevel(struct net_device *dev)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	return lp->msg_enable;
+}
+
+static void smc911x_ethtool_setmsglevel(struct net_device *dev, u32 level)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	lp->msg_enable = level;
+}
+
+static int smc911x_ethtool_getregslen(struct net_device *dev)
+{
+	/* System regs + MAC regs + PHY regs */
+	return (((E2P_CMD - ID_REV)/4 + 1) + 
+			(WUCSR - MAC_CR)+1 + 32) * sizeof(u32); 
+}
+
+static void smc911x_ethtool_getregs(struct net_device *dev, 
+										 struct ethtool_regs* regs, void *buf)
+{
+	unsigned long ioaddr = dev->base_addr;
+	struct smc911x_local *lp = netdev_priv(dev);
+	unsigned long flags;
+	u32 reg,i,j=0;
+	u32 *data = (u32*)buf;
+
+	regs->version = lp->version;
+	for(i=ID_REV;i<=E2P_CMD;i+=4) {
+		data[j++] = SMC_inl(ioaddr,i);	   
+	}
+	for(i=MAC_CR;i<=WUCSR;i++) {
+		spin_lock_irqsave(&lp->lock, flags);
+		SMC_GET_MAC_CSR(i, reg);
+		spin_unlock_irqrestore(&lp->lock, flags);
+		data[j++] = reg;	 
+	}
+	for(i=0;i<=31;i++) {
+		spin_lock_irqsave(&lp->lock, flags);
+		SMC_GET_MII(i, lp->mii.phy_id, reg);
+		spin_unlock_irqrestore(&lp->lock, flags);
+		data[j++] = reg & 0xFFFF;	  
+	}
+}
+
+static int smc911x_ethtool_wait_eeprom_ready(struct net_device *dev)
+{
+	unsigned long ioaddr = dev->base_addr;
+	unsigned int timeout;
+	int e2p_cmd;
+
+	e2p_cmd = SMC_GET_E2P_CMD();
+	for(timeout=10;(e2p_cmd & E2P_CMD_EPC_BUSY_) && timeout; timeout--) {
+		if (e2p_cmd & E2P_CMD_EPC_TIMEOUT_) {
+			PRINTK("%s: %s timeout waiting for EEPROM to respond\n", 
+				dev->name, __FUNCTION__);
+			return -EFAULT;
+		} 
+		mdelay(1);
+		e2p_cmd = SMC_GET_E2P_CMD();
+	}
+	if (timeout == 0) {
+		PRINTK("%s: %s timeout waiting for EEPROM CMD not busy\n", 
+			dev->name, __FUNCTION__);
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static inline int smc911x_ethtool_write_eeprom_cmd(struct net_device *dev, 
+													int cmd, int addr)
+{
+	unsigned long ioaddr = dev->base_addr;
+	int ret;
+
+	if ((ret = smc911x_ethtool_wait_eeprom_ready(dev))!=0) 
+		return ret;
+	SMC_SET_E2P_CMD(E2P_CMD_EPC_BUSY_ | 
+		((cmd) & (0x7<<28)) | 
+		((addr) & 0xFF));
+	return 0;
+}
+
+static inline int smc911x_ethtool_read_eeprom_byte(struct net_device *dev, 
+													u8 *data)
+{
+	unsigned long ioaddr = dev->base_addr;
+	int ret;
+
+	if ((ret = smc911x_ethtool_wait_eeprom_ready(dev))!=0) 
+		return ret;
+	*data = SMC_GET_E2P_DATA();
+	return 0;
+}
+
+static inline int smc911x_ethtool_write_eeprom_byte(struct net_device *dev, 
+													 u8 data)
+{
+	unsigned long ioaddr = dev->base_addr;
+	int ret;
+
+	if ((ret = smc911x_ethtool_wait_eeprom_ready(dev))!=0) 
+		return ret;
+	SMC_SET_E2P_DATA(data);
+	return 0;
+}
+
+static int smc911x_ethtool_geteeprom(struct net_device *dev, 
+									  struct ethtool_eeprom *eeprom, u8 *data)
+{
+	u8 eebuf[SMC911X_EEPROM_LEN];
+	int i, ret;
+
+	for(i=0;i<SMC911X_EEPROM_LEN;i++) {
+		if ((ret=smc911x_ethtool_write_eeprom_cmd(dev, E2P_CMD_EPC_CMD_READ_, i ))!=0)
+			return ret;
+		if ((ret=smc911x_ethtool_read_eeprom_byte(dev, &eebuf[i]))!=0)
+			return ret;
+		}
+	memcpy(data, eebuf+eeprom->offset, eeprom->len);
+	return 0;	 
+}
+
+static int smc911x_ethtool_seteeprom(struct net_device *dev, 
+									   struct ethtool_eeprom *eeprom, u8 *data)
+{
+	int i, ret;
+
+	/* Enable erase */
+	if ((ret=smc911x_ethtool_write_eeprom_cmd(dev, E2P_CMD_EPC_CMD_EWEN_, 0 ))!=0)
+		return ret;
+	for(i=eeprom->offset;i<(eeprom->offset+eeprom->len);i++) {
+		/* erase byte */
+		if ((ret=smc911x_ethtool_write_eeprom_cmd(dev, E2P_CMD_EPC_CMD_ERASE_, i ))!=0)
+			return ret;
+		/* write byte */
+		if ((ret=smc911x_ethtool_write_eeprom_byte(dev, *data))!=0)
+			 return ret;
+		if ((ret=smc911x_ethtool_write_eeprom_cmd(dev, E2P_CMD_EPC_CMD_WRITE_, i ))!=0)
+			return ret;
+		}
+	 return 0;
+}
+
+static int smc911x_ethtool_geteeprom_len(struct net_device *dev)
+{
+	 return SMC911X_EEPROM_LEN;
+}
+
+static struct ethtool_ops smc911x_ethtool_ops = {
+	.get_settings	 = smc911x_ethtool_getsettings,
+	.set_settings	 = smc911x_ethtool_setsettings,
+	.get_drvinfo	 = smc911x_ethtool_getdrvinfo,
+	.get_msglevel	 = smc911x_ethtool_getmsglevel,
+	.set_msglevel	 = smc911x_ethtool_setmsglevel,
+	.nway_reset = smc911x_ethtool_nwayreset,
+	.get_link	 = ethtool_op_get_link,
+	.get_regs_len	 = smc911x_ethtool_getregslen,
+	.get_regs	 = smc911x_ethtool_getregs,
+	.get_eeprom_len = smc911x_ethtool_geteeprom_len,
+	.get_eeprom = smc911x_ethtool_geteeprom,
+	.set_eeprom = smc911x_ethtool_seteeprom,
+};
+
+/*
+ * smc911x_findirq
+ *
+ * This routine has a simple purpose -- make the SMC chip generate an
+ * interrupt, so an auto-detect routine can detect it, and find the IRQ,
+ */
+static int __init smc911x_findirq(unsigned long ioaddr)
+{
+	int timeout = 20;
+	unsigned long cookie;
+
+	DBG(SMC_DEBUG_FUNC, "--> %s\n", __FUNCTION__);
+
+	cookie = probe_irq_on();
+
+	/*
+	 * Force a SW interrupt
+	 */
+
+	SMC_SET_INT_EN(INT_EN_SW_INT_EN_);
+
+	/*
+	 * Wait until positive that the interrupt has been generated
+	 */
+	do {
+		int int_status;
+		udelay(10);
+		int_status = SMC_GET_INT_EN();
+		if (int_status & INT_EN_SW_INT_EN_)
+			 break;		/* got the interrupt */
+	} while (--timeout);
+
+	/*
+	 * there is really nothing that I can do here if timeout fails,
+	 * as autoirq_report will return a 0 anyway, which is what I
+	 * want in this case.	 Plus, the clean up is needed in both
+	 * cases.
+	 */
+
+	/* and disable all interrupts again */
+	SMC_SET_INT_EN(0);
+
+	/* and return what I found */
+	return probe_irq_off(cookie);
+}
+
+/*
+ * Function: smc911x_probe(unsigned long ioaddr)
+ *
+ * Purpose:
+ *	 Tests to see if a given ioaddr points to an SMC911x chip.
+ *	 Returns a 0 on success
+ *
+ * Algorithm:
+ *	 (1) see if the endian word is OK
+ *	 (1) see if I recognize the chip ID in the appropriate register
+ *
+ * Here I do typical initialization tasks.
+ *
+ * o  Initialize the structure if needed
+ * o  print out my vanity message if not done so already
+ * o  print out what type of hardware is detected
+ * o  print out the ethernet address
+ * o  find the IRQ
+ * o  set up my private data
+ * o  configure the dev structure with my subroutines
+ * o  actually GRAB the irq.
+ * o  GRAB the region
+ */
+static int __init smc911x_probe(struct net_device *dev, unsigned long ioaddr)
+{
+	struct smc911x_local *lp = netdev_priv(dev);
+	int i, retval;
+	unsigned int val, chip_id, revision;
+	const char *version_string;
+
+	DBG(SMC_DEBUG_FUNC, "%s: --> %s\n", dev->name, __FUNCTION__);
+
+	/* First, see if the endian word is recognized */
+	val = SMC_GET_BYTE_TEST();
+	DBG(SMC_DEBUG_MISC, "%s: endian probe returned 0x%04x\n", CARDNAME, val);
+	if (val != 0x87654321) {
+		printk(KERN_ERR "Invalid chip endian 0x08%x\n",val);
+		retval = -ENODEV;
+		goto err_out;
+	}
+
+	/*
+	 * check if the revision register is something that I
+	 * recognize.	These might need to be added to later,
+	 * as future revisions could be added.
+	 */
+	chip_id = SMC_GET_PN();
+	DBG(SMC_DEBUG_MISC, "%s: id probe returned 0x%04x\n", CARDNAME, chip_id);
+	for(i=0;chip_ids[i].id != 0; i++) {
+		if (chip_ids[i].id == chip_id) break;
+	}
+	if (!chip_ids[i].id) {
+		printk(KERN_ERR "Unknown chip ID %04x\n", chip_id);
+		retval = -ENODEV;
+		goto err_out;
+	}
+	version_string = chip_ids[i].name;
+
+	revision = SMC_GET_REV();
+	DBG(SMC_DEBUG_MISC, "%s: revision = 0x%04x\n", CARDNAME, revision);
+
+	/* At this point I'll assume that the chip is an SMC911x. */
+	DBG(SMC_DEBUG_MISC, "%s: Found a %s\n", CARDNAME, chip_ids[i].name);
+
+	/* Validate the TX FIFO size requested */
+	if ((tx_fifo_kb < 2) || (tx_fifo_kb > 14)) {
+		printk(KERN_ERR "Invalid TX FIFO size requested %d\n", tx_fifo_kb);
+		retval = -EINVAL;
+		goto err_out;
+	}
+		 
+	/* fill in some of the fields */
+	dev->base_addr = ioaddr;
+	lp->version = chip_ids[i].id;
+	lp->revision = revision;
+	lp->tx_fifo_kb = tx_fifo_kb;
+	/* Reverse calculate the RX FIFO size from the TX */
+	lp->tx_fifo_size=(lp->tx_fifo_kb<<10) - 512;
+	lp->rx_fifo_size= ((0x4000 - 512 - lp->tx_fifo_size) / 16) * 15;
+
+	/* Set the automatic flow control values */
+	switch(lp->tx_fifo_kb) {
+		/*	 
+		 *	 AFC_HI is about ((Rx Data Fifo Size)*2/3)/64
+		 *	 AFC_LO is AFC_HI/2
+		 *	 BACK_DUR is about 5uS*(AFC_LO) rounded down
+		 */
+		case 2:/* 13440 Rx Data Fifo Size */
+			lp->afc_cfg=0x008C46AF;break;
+		case 3:/* 12480 Rx Data Fifo Size */
+			lp->afc_cfg=0x0082419F;break;
+		case 4:/* 11520 Rx Data Fifo Size */
+			lp->afc_cfg=0x00783C9F;break;
+		case 5:/* 10560 Rx Data Fifo Size */
+			lp->afc_cfg=0x006E374F;break;
+		case 6:/* 9600 Rx Data Fifo Size */
+			lp->afc_cfg=0x0064328F;break;
+		case 7:/* 8640 Rx Data Fifo Size */
+			lp->afc_cfg=0x005A2D7F;break;
+		case 8:/* 7680 Rx Data Fifo Size */
+			lp->afc_cfg=0x0050287F;break;
+		case 9:/* 6720 Rx Data Fifo Size */
+			lp->afc_cfg=0x0046236F;break;
+		case 10:/* 5760 Rx Data Fifo Size */
+			lp->afc_cfg=0x003C1E6F;break;
+		case 11:/* 4800 Rx Data Fifo Size */
+			lp->afc_cfg=0x0032195F;break;
+		/*	 
+		 *	 AFC_HI is ~1520 bytes less than RX Data Fifo Size
+		 *	 AFC_LO is AFC_HI/2
+		 *	 BACK_DUR is about 5uS*(AFC_LO) rounded down
+		 */
+		case 12:/* 3840 Rx Data Fifo Size */
+			lp->afc_cfg=0x0024124F;break;
+		case 13:/* 2880 Rx Data Fifo Size */
+			lp->afc_cfg=0x0015073F;break;
+		case 14:/* 1920 Rx Data Fifo Size */
+			lp->afc_cfg=0x0006032F;break;
+		 default:
+			 PRINTK("%s: ERROR -- no AFC_CFG setting found", 
+				dev->name);
+			 break;
+	}
+
+	DBG(SMC_DEBUG_MISC | SMC_DEBUG_TX | SMC_DEBUG_RX, 
+		"%s: tx_fifo %d rx_fifo %d afc_cfg 0x%08x\n", CARDNAME, 
+		lp->tx_fifo_size, lp->rx_fifo_size, lp->afc_cfg);
+
+	spin_lock_init(&lp->lock);
+
+	/* Get the MAC address */
+	SMC_GET_MAC_ADDR(dev->dev_addr);
+
+	/* now, reset the chip, and put it into a known state */
+	smc911x_reset(dev);
+
+	/*
+	 * If dev->irq is 0, then the device has to be banged on to see
+	 * what the IRQ is.
+	 *
+	 * Specifying an IRQ is done with the assumption that the user knows
+	 * what (s)he is doing.  No checking is done!!!!
+	 */
+	if (dev->irq < 1) {
+		int trials;
+
+		trials = 3;
+		while (trials--) {
+			dev->irq = smc911x_findirq(ioaddr);
+			if (dev->irq)
+				break;
+			/* kick the card and try again */
+			smc911x_reset(dev);
+		}
+	}
+	if (dev->irq == 0) {
+		printk("%s: Couldn't autodetect your IRQ. Use irq=xx.\n",
+			dev->name);
+		retval = -ENODEV;
+		goto err_out;
+	}
+	dev->irq = irq_canonicalize(dev->irq);
+
+	/* Fill in the fields of the device structure with ethernet values. */
+	ether_setup(dev);
+
+	dev->open = smc911x_open;
+	dev->stop = smc911x_close;
+	dev->hard_start_xmit = smc911x_hard_start_xmit;
+	dev->tx_timeout = smc911x_timeout;
+	dev->watchdog_timeo = msecs_to_jiffies(watchdog);
+	dev->get_stats = smc911x_query_statistics;
+	dev->set_multicast_list = smc911x_set_multicast_list;
+	dev->ethtool_ops = &smc911x_ethtool_ops;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = smc911x_poll_controller;
+#endif
+
+	INIT_WORK(&lp->phy_configure, smc911x_phy_configure, dev);
+	lp->mii.phy_id_mask = 0x1f;
+	lp->mii.reg_num_mask = 0x1f;
+	lp->mii.force_media = 0;
+	lp->mii.full_duplex = 0;
+	lp->mii.dev = dev;
+	lp->mii.mdio_read = smc911x_phy_read;
+	lp->mii.mdio_write = smc911x_phy_write;
+
+	/*
+	 * Locate the phy, if any.
+	 */
+	smc911x_phy_detect(dev);
+
+	/* Set default parameters */
+	lp->msg_enable = NETIF_MSG_LINK;
+	lp->ctl_rfduplx = 1;
+	lp->ctl_rspeed = 100;
+
+	/* Grab the IRQ */
+	retval = request_irq(dev->irq, &smc911x_interrupt, SA_SHIRQ, dev->name, dev);
+	if (retval)
+		goto err_out;
+
+	set_irq_type(dev->irq, IRQT_FALLING);
+
+#ifdef SMC_USE_DMA
+	lp->rxdma = SMC_DMA_REQUEST(dev, smc911x_rx_dma_irq);
+	lp->txdma = SMC_DMA_REQUEST(dev, smc911x_tx_dma_irq);
+	lp->rxdma_active = 0;
+	lp->txdma_active = 0;
+	dev->dma = lp->rxdma;
+#endif
+
+	retval = register_netdev(dev);
+	if (retval == 0) {
+		/* now, print out the card info, in a short format.. */
+		printk("%s: %s (rev %d) at %#lx IRQ %d",
+			dev->name, version_string, lp->revision,
+			dev->base_addr, dev->irq);
+
+#ifdef SMC_USE_DMA
+		if (lp->rxdma != -1)
+			printk(" RXDMA %d ", lp->rxdma);
+
+		if (lp->txdma != -1)
+			printk("TXDMA %d", lp->txdma);
+#endif
+		printk("\n");
+		if (!is_valid_ether_addr(dev->dev_addr)) {
+			printk("%s: Invalid ethernet MAC address. Please "
+					"set using ifconfig\n", dev->name);
+		} else {
+			/* Print the Ethernet address */
+			printk("%s: Ethernet addr: ", dev->name);
+			for (i = 0; i < 5; i++)
+				printk("%2.2x:", dev->dev_addr[i]);
+			printk("%2.2x\n", dev->dev_addr[5]);
+		}
+
+		if (lp->phy_type == 0) {
+			PRINTK("%s: No PHY found\n", dev->name);
+		} else if ((lp->phy_type & ~0xff) == LAN911X_INTERNAL_PHY_ID) {
+			PRINTK("%s: LAN911x Internal PHY\n", dev->name);
+		} else {
+			PRINTK("%s: External PHY 0x%08x\n", dev->name, lp->phy_type);
+		}
+	}
+	
+err_out:
+#ifdef SMC_USE_DMA
+	if (retval) {
+		if (lp->rxdma != -1) {
+			SMC_DMA_FREE(dev, lp->rxdma);
+		}
+		if (lp->txdma != -1) {
+			SMC_DMA_FREE(dev, lp->txdma);
+		}
+	}
+#endif
+	return retval;
+}
+
+/*
+ * smc911x_init(void)
+ *
+ *	  Output:
+ *	 0 --> there is a device
+ *	 anything else, error
+ */
+static int smc911x_drv_probe(struct platform_device *pdev)
+{
+	struct net_device *ndev;
+	struct resource *res;
+	unsigned int *addr;
+	int ret;
+
+	DBG(SMC_DEBUG_FUNC, "--> %s\n",  __FUNCTION__);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/*
+	 * Request the regions.
+	 */
+	if (!request_mem_region(res->start, SMC911X_IO_EXTENT, CARDNAME)) {
+		 ret = -EBUSY;
+		 goto out;
+	}
+
+	ndev = alloc_etherdev(sizeof(struct smc911x_local));
+	if (!ndev) {
+		printk("%s: could not allocate device.\n", CARDNAME);
+		ret = -ENOMEM;
+		goto release_1;
+	}
+	SET_MODULE_OWNER(ndev);
+	SET_NETDEV_DEV(ndev, &pdev->dev);
+
+	ndev->dma = (unsigned char)-1;
+	ndev->irq = platform_get_irq(pdev, 0);
+
+	addr = ioremap(res->start, SMC911X_IO_EXTENT);
+	if (!addr) {
+		ret = -ENOMEM;
+		goto release_both;
+	}
+
+	platform_set_drvdata(pdev, ndev);
+	ret = smc911x_probe(ndev, (unsigned long)addr);
+	if (ret != 0) {
+		platform_set_drvdata(pdev, NULL);
+		iounmap(addr);
+release_both:
+		free_netdev(ndev);
+release_1:
+		release_mem_region(res->start, SMC911X_IO_EXTENT);
+out:
+		printk("%s: not found (%d).\n", CARDNAME, ret);
+	}
+#ifdef SMC_USE_DMA
+	else {
+		struct smc911x_local *lp = netdev_priv(ndev);
+		lp->physaddr = res->start;
+		lp->dev = &pdev->dev;
+	}
+#endif
+
+	return ret;
+}
+
+static int smc911x_drv_remove(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct resource *res;
+
+	DBG(SMC_DEBUG_FUNC, "--> %s\n", __FUNCTION__);
+	platform_set_drvdata(pdev, NULL);
+
+	unregister_netdev(ndev);
+
+	free_irq(ndev->irq, ndev);
+
+#ifdef SMC_USE_DMA
+	{
+		struct smc911x_local *lp = netdev_priv(ndev);
+		if (lp->rxdma != -1) {
+			SMC_DMA_FREE(dev, lp->rxdma);
+		}
+		if (lp->txdma != -1) {
+			SMC_DMA_FREE(dev, lp->txdma);
+		}
+	}
+#endif
+	iounmap((void *)ndev->base_addr);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, SMC911X_IO_EXTENT);
+
+	free_netdev(ndev);
+	return 0;
+}
+
+static int smc911x_drv_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct net_device *ndev = platform_get_drvdata(dev);
+	unsigned long ioaddr = ndev->base_addr;
+
+	DBG(SMC_DEBUG_FUNC, "--> %s\n", __FUNCTION__);
+	if (ndev) {
+		if (netif_running(ndev)) {
+			netif_device_detach(ndev);
+			smc911x_shutdown(ndev);
+#if POWER_DOWN
+			/* Set D2 - Energy detect only setting */
+			SMC_SET_PMT_CTRL(2<<12);
+#endif
+		}
+	}
+	return 0;
+}
+
+static int smc911x_drv_resume(struct platform_device *dev)
+{
+	struct net_device *ndev = platform_get_drvdata(dev);
+
+	DBG(SMC_DEBUG_FUNC, "--> %s\n", __FUNCTION__);
+	if (ndev) {
+		struct smc911x_local *lp = netdev_priv(ndev);
+
+		if (netif_running(ndev)) {
+			smc911x_reset(ndev);
+			smc911x_enable(ndev);
+			if (lp->phy_type != 0)
+				smc911x_phy_configure(ndev);
+			netif_device_attach(ndev);
+		}
+	}
+	return 0;
+}
+
+static struct platform_driver smc911x_driver = {
+	.probe		 = smc911x_drv_probe,
+	.remove	 = smc911x_drv_remove,
+	.suspend	 = smc911x_drv_suspend,
+	.resume	 = smc911x_drv_resume,
+	.driver	 = {
+		.name	 = CARDNAME,
+	},
+};
+ 
+static int __init smc911x_init(void)
+{
+	return platform_driver_register(&smc911x_driver);
+}
+
+static void __exit smc911x_cleanup(void)
+{
+	platform_driver_unregister(&smc911x_driver);
+}
+
+module_init(smc911x_init);
+module_exit(smc911x_cleanup);
diff -rNup linux-2.6.16.1.orig/drivers/net/smc911x.h linux-2.6.16.1/drivers/net/smc911x.h
--- linux-2.6.16.1.orig/drivers/net/smc911x.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16.1/drivers/net/smc911x.h	2006-04-18 10:02:26.000000000 -0700
@@ -0,0 +1,835 @@
+/*------------------------------------------------------------------------
+ . smc911x.h - macros for SMSC's LAN911{5,6,7,8} single-chip Ethernet device.
+ .
+ . Copyright (C) 2005 Sensoria Corp.
+ . Derived from the unified SMC91x driver by Nicolas Pitre
+ .
+ . This program is free software; you can redistribute it and/or modify
+ . it under the terms of the GNU General Public License as published by
+ . the Free Software Foundation; either version 2 of the License, or
+ . (at your option) any later version.
+ .
+ . This program is distributed in the hope that it will be useful,
+ . but WITHOUT ANY WARRANTY; without even the implied warranty of
+ . MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ . GNU General Public License for more details.
+ .
+ . You should have received a copy of the GNU General Public License
+ . along with this program; if not, write to the Free Software
+ . Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ .
+ . Information contained in this file was obtained from the LAN9118
+ . manual from SMC.  To get a copy, if you really want one, you can find
+ . information under www.smsc.com.
+ .
+ . Authors
+ .	 Dustin McIntire		 <dustin@sensoria.com>
+ .
+ ---------------------------------------------------------------------------*/
+#ifndef _SMC911X_H_
+#define _SMC911X_H_
+
+/*
+ * Use the DMA feature on PXA chips
+ */
+#ifdef CONFIG_ARCH_PXA
+  #define SMC_USE_PXA_DMA	1
+  #define SMC_USE_16BIT		0
+  #define SMC_USE_32BIT		1
+#endif
+
+
+/*
+ * Define the bus width specific IO macros
+ */
+
+#if	SMC_USE_16BIT
+#define SMC_inb(a, r)			 readb((a) + (r))
+#define SMC_inw(a, r)			 readw((a) + (r))
+#define SMC_inl(a, r)			 ((SMC_inw(a, r) & 0xFFFF)+(SMC_inw(a+2, r)<<16))
+#define SMC_outb(v, a, r)		 writeb(v, (a) + (r))
+#define SMC_outw(v, a, r)		 writew(v, (a) + (r))
+#define SMC_outl(v, a, r) 			 \
+	do{					 \
+		 writel(v & 0xFFFF, (a) + (r));	 \
+		 writel(v >> 16, (a) + (r) + 2); \
+	 } while (0)
+#define SMC_insl(a, r, p, l)	 readsw((short*)((a) + (r)), p, l*2)
+#define SMC_outsl(a, r, p, l)	 writesw((short*)((a) + (r)), p, l*2)
+
+#elif	SMC_USE_32BIT
+#define SMC_inb(a, r)		 readb((a) + (r))
+#define SMC_inw(a, r)		 readw((a) + (r))
+#define SMC_inl(a, r)		 readl((a) + (r))
+#define SMC_outb(v, a, r)	 writeb(v, (a) + (r))
+#define SMC_outl(v, a, r)	 writel(v, (a) + (r))
+#define SMC_insl(a, r, p, l)	 readsl((int*)((a) + (r)), p, l)
+#define SMC_outsl(a, r, p, l)	 writesl((int*)((a) + (r)), p, l)
+
+#endif /* SMC_USE_16BIT */
+
+
+
+#if	 SMC_USE_PXA_DMA
+#define SMC_USE_DMA
+
+/* 
+ * Define the request and free functions 
+ * These are unfortunately architecture specific as no generic allocation
+ * mechanism exits
+ */
+#define SMC_DMA_REQUEST(dev, handler) \
+	 pxa_request_dma(dev->name, DMA_PRIO_LOW, handler, dev)	   
+
+#define SMC_DMA_FREE(dev, dma) \
+	 pxa_free_dma(dma)
+
+#define SMC_DMA_ACK_IRQ(dev, dma)					\
+{									\
+	if (DCSR(dma) & DCSR_BUSERR) {					\
+		printk("%s: DMA %d bus error!\n", dev->name, dma);	\
+	}								\
+	DCSR(dma) = DCSR_STARTINTR|DCSR_ENDINTR|DCSR_BUSERR;		\
+}
+
+/*
+ * Use a DMA for RX and TX packets.
+ */
+#include <linux/dma-mapping.h>
+#include <asm/dma.h>
+#include <asm/arch/pxa-regs.h>
+
+static dma_addr_t rx_dmabuf, tx_dmabuf;
+static int rx_dmalen, tx_dmalen;
+ 
+#ifdef SMC_insl
+#undef SMC_insl
+#define SMC_insl(a, r, p, l) \
+	smc_pxa_dma_insl(lp->dev, a, lp->physaddr, r, lp->rxdma, p, l)
+
+static inline void
+smc_pxa_dma_insl(struct device *dev, u_long ioaddr, u_long physaddr, 
+		int reg, int dma, u_char *buf, int len)
+{
+	/* 64 bit alignment is required for memory to memory DMA */
+	if ((long)buf & 4) {
+		*((u32 *)buf) = SMC_inl(ioaddr, reg);
+		buf += 4;
+		len--;
+	}
+
+	len *= 4;
+	rx_dmabuf = dma_map_single(dev, buf, len, DMA_FROM_DEVICE);
+	rx_dmalen = len;
+	DCSR(dma) = DCSR_NODESC;
+	DTADR(dma) = rx_dmabuf;
+	DSADR(dma) = physaddr + reg;
+	DCMD(dma) = (DCMD_INCTRGADDR | DCMD_BURST32 |
+		DCMD_WIDTH4 | DCMD_ENDIRQEN | (DCMD_LENGTH & rx_dmalen));
+	DCSR(dma) = DCSR_NODESC | DCSR_RUN;
+}
+#endif
+
+#ifdef SMC_insw
+#undef SMC_insw
+#define SMC_insw(a, r, p, l) \
+	smc_pxa_dma_insw(lp->dev, a, lp->physaddr, r, lp->rxdma, p, l)
+
+static inline void
+smc_pxa_dma_insw(struct device *dev, u_long ioaddr, u_long physaddr, 
+		int reg, int dma, u_char *buf, int len)
+{
+	/* 64 bit alignment is required for memory to memory DMA */
+	while ((long)buf & 6) {
+		*((u16 *)buf) = SMC_inw(ioaddr, reg);
+		buf += 2;
+		len--;
+	}
+
+	len *= 2;
+	rx_dmabuf = dma_map_single(dev, buf, len, DMA_FROM_DEVICE);
+	rx_dmalen = len;
+	DCSR(dma) = DCSR_NODESC;
+	DTADR(dma) = rx_dmabuf;
+	DSADR(dma) = physaddr + reg;
+	DCMD(dma) = (DCMD_INCTRGADDR | DCMD_BURST32 |
+		DCMD_WIDTH2 | DCMD_ENDIRQEN | (DCMD_LENGTH & rx_dmalen));
+	DCSR(dma) = DCSR_NODESC | DCSR_RUN;
+}
+#endif
+
+#ifdef SMC_outsl
+#undef SMC_outsl
+#define SMC_outsl(a, r, p, l) \
+	 smc_pxa_dma_outsl(lp->dev, a, lp->physaddr, r, lp->txdma, p, l)
+
+static inline void
+smc_pxa_dma_outsl(struct device *dev, u_long ioaddr, u_long physaddr, 
+		int reg, int dma, u_char *buf, int len)
+{
+	/* 64 bit alignment is required for memory to memory DMA */
+	if ((long)buf & 4) {
+		SMC_outl(*((u32 *)buf), ioaddr, reg);
+		buf += 4;
+		len--;
+	}
+
+	len *= 4;
+	tx_dmabuf = dma_map_single(dev, buf, len, DMA_TO_DEVICE);
+	tx_dmalen = len;
+	DCSR(dma) = DCSR_NODESC;
+	DSADR(dma) = tx_dmabuf;
+	DTADR(dma) = physaddr + reg;
+	DCMD(dma) = (DCMD_INCSRCADDR | DCMD_BURST32 |
+		DCMD_WIDTH4 | DCMD_ENDIRQEN | (DCMD_LENGTH & tx_dmalen));
+	DCSR(dma) = DCSR_NODESC | DCSR_RUN;
+}
+#endif
+
+#ifdef SMC_outsw
+#undef SMC_outsw
+#define SMC_outsw(a, r, p, l) \
+	smc_pxa_dma_outsw(lp->dev, a, lp->physaddr, r, lp->txdma, p, l)
+
+static inline void
+smc_pxa_dma_outsw(struct device *dev, u_long ioaddr, u_long physaddr, 
+		  int reg, int dma, u_char *buf, int len)
+{
+	/* 64 bit alignment is required for memory to memory DMA */
+	while ((long)buf & 6) {
+		SMC_outw(*((u16 *)buf), ioaddr, reg);
+		buf += 2;
+		len--;
+	}
+
+	len *= 2;
+	tx_dmabuf = dma_map_single(dev, buf, len, DMA_TO_DEVICE);
+	tx_dmalen = len;
+	DCSR(dma) = DCSR_NODESC;
+	DSADR(dma) = tx_dmabuf;
+	DTADR(dma) = physaddr + reg;
+	DCMD(dma) = (DCMD_INCSRCADDR | DCMD_BURST32 |
+		DCMD_WIDTH2 | DCMD_ENDIRQEN | (DCMD_LENGTH & tx_dmalen));
+	DCSR(dma) = DCSR_NODESC | DCSR_RUN;
+}
+#endif
+
+#endif	 /* SMC_USE_PXA_DMA */
+
+
+/* Chip Parameters and Register Definitions */
+
+#define SMC911X_TX_FIFO_LOW_THRESHOLD	(1536*2)
+
+#define SMC911X_IO_EXTENT	 0x100
+
+#define SMC911X_EEPROM_LEN	 7
+
+/* Below are the register offsets and bit definitions
+ * of the Lan911x memory space
+ */
+#define RX_DATA_FIFO		 (0x00)
+
+#define TX_DATA_FIFO		 (0x20)
+#define	TX_CMD_A_INT_ON_COMP_		(0x80000000)
+#define	TX_CMD_A_INT_BUF_END_ALGN_	(0x03000000)
+#define	TX_CMD_A_INT_4_BYTE_ALGN_	(0x00000000)
+#define	TX_CMD_A_INT_16_BYTE_ALGN_	(0x01000000)
+#define	TX_CMD_A_INT_32_BYTE_ALGN_	(0x02000000)
+#define	TX_CMD_A_INT_DATA_OFFSET_	(0x001F0000)
+#define	TX_CMD_A_INT_FIRST_SEG_		(0x00002000)
+#define	TX_CMD_A_INT_LAST_SEG_		(0x00001000)
+#define	TX_CMD_A_BUF_SIZE_		(0x000007FF)
+#define	TX_CMD_B_PKT_TAG_		(0xFFFF0000)
+#define	TX_CMD_B_ADD_CRC_DISABLE_	(0x00002000)
+#define	TX_CMD_B_DISABLE_PADDING_	(0x00001000)
+#define	TX_CMD_B_PKT_BYTE_LENGTH_	(0x000007FF)
+
+#define RX_STATUS_FIFO		(0x40)
+#define	RX_STS_PKT_LEN_			(0x3FFF0000)
+#define	RX_STS_ES_			(0x00008000)
+#define	RX_STS_BCST_			(0x00002000)
+#define	RX_STS_LEN_ERR_			(0x00001000)
+#define	RX_STS_RUNT_ERR_		(0x00000800)
+#define	RX_STS_MCAST_			(0x00000400)
+#define	RX_STS_TOO_LONG_		(0x00000080)
+#define	RX_STS_COLL_			(0x00000040)
+#define	RX_STS_ETH_TYPE_		(0x00000020)
+#define	RX_STS_WDOG_TMT_		(0x00000010)
+#define	RX_STS_MII_ERR_			(0x00000008)
+#define	RX_STS_DRIBBLING_		(0x00000004)
+#define	RX_STS_CRC_ERR_			(0x00000002)
+#define RX_STATUS_FIFO_PEEK 	(0x44)
+#define TX_STATUS_FIFO		(0x48)
+#define	TX_STS_TAG_			(0xFFFF0000)
+#define	TX_STS_ES_			(0x00008000)
+#define	TX_STS_LOC_			(0x00000800)
+#define	TX_STS_NO_CARR_			(0x00000400)
+#define	TX_STS_LATE_COLL_		(0x00000200)
+#define	TX_STS_MANY_COLL_		(0x00000100)
+#define	TX_STS_COLL_CNT_		(0x00000078)
+#define	TX_STS_MANY_DEFER_		(0x00000004)
+#define	TX_STS_UNDERRUN_		(0x00000002)
+#define	TX_STS_DEFERRED_		(0x00000001)
+#define TX_STATUS_FIFO_PEEK	(0x4C)
+#define ID_REV			(0x50)
+#define	ID_REV_CHIP_ID_			(0xFFFF0000)  /* RO */
+#define	ID_REV_REV_ID_			(0x0000FFFF)  /* RO */
+
+#define INT_CFG			(0x54)
+#define	INT_CFG_INT_DEAS_		(0xFF000000)  /* R/W */
+#define	INT_CFG_INT_DEAS_CLR_		(0x00004000)
+#define	INT_CFG_INT_DEAS_STS_		(0x00002000)
+#define	INT_CFG_IRQ_INT_		(0x00001000)  /* RO */
+#define	INT_CFG_IRQ_EN_			(0x00000100)  /* R/W */
+#define	INT_CFG_IRQ_POL_		(0x00000010)  /* R/W Not Affected by SW Reset */
+#define	INT_CFG_IRQ_TYPE_		(0x00000001)  /* R/W Not Affected by SW Reset */
+
+#define INT_STS			(0x58)
+#define	INT_STS_SW_INT_			(0x80000000)  /* R/WC */
+#define	INT_STS_TXSTOP_INT_		(0x02000000)  /* R/WC */
+#define	INT_STS_RXSTOP_INT_		(0x01000000)  /* R/WC */
+#define	INT_STS_RXDFH_INT_		(0x00800000)  /* R/WC */
+#define	INT_STS_RXDF_INT_		(0x00400000)  /* R/WC */
+#define	INT_STS_TX_IOC_			(0x00200000)  /* R/WC */
+#define	INT_STS_RXD_INT_		(0x00100000)  /* R/WC */
+#define	INT_STS_GPT_INT_		(0x00080000)  /* R/WC */
+#define	INT_STS_PHY_INT_		(0x00040000)  /* RO */
+#define	INT_STS_PME_INT_		(0x00020000)  /* R/WC */
+#define	INT_STS_TXSO_			(0x00010000)  /* R/WC */
+#define	INT_STS_RWT_			(0x00008000)  /* R/WC */
+#define	INT_STS_RXE_			(0x00004000)  /* R/WC */
+#define	INT_STS_TXE_			(0x00002000)  /* R/WC */
+//#define	INT_STS_ERX_		(0x00001000)  /* R/WC */
+#define	INT_STS_TDFU_			(0x00000800)  /* R/WC */
+#define	INT_STS_TDFO_			(0x00000400)  /* R/WC */
+#define	INT_STS_TDFA_			(0x00000200)  /* R/WC */
+#define	INT_STS_TSFF_			(0x00000100)  /* R/WC */
+#define	INT_STS_TSFL_			(0x00000080)  /* R/WC */
+//#define	INT_STS_RXDF_		(0x00000040)  /* R/WC */
+#define	INT_STS_RDFO_			(0x00000040)  /* R/WC */
+#define	INT_STS_RDFL_			(0x00000020)  /* R/WC */
+#define	INT_STS_RSFF_			(0x00000010)  /* R/WC */
+#define	INT_STS_RSFL_			(0x00000008)  /* R/WC */
+#define	INT_STS_GPIO2_INT_		(0x00000004)  /* R/WC */
+#define	INT_STS_GPIO1_INT_		(0x00000002)  /* R/WC */
+#define	INT_STS_GPIO0_INT_		(0x00000001)  /* R/WC */
+
+#define INT_EN			(0x5C)
+#define	INT_EN_SW_INT_EN_		(0x80000000)  /* R/W */
+#define	INT_EN_TXSTOP_INT_EN_		(0x02000000)  /* R/W */
+#define	INT_EN_RXSTOP_INT_EN_		(0x01000000)  /* R/W */
+#define	INT_EN_RXDFH_INT_EN_		(0x00800000)  /* R/W */
+//#define	INT_EN_RXDF_INT_EN_		(0x00400000)  /* R/W */
+#define	INT_EN_TIOC_INT_EN_		(0x00200000)  /* R/W */
+#define	INT_EN_RXD_INT_EN_		(0x00100000)  /* R/W */
+#define	INT_EN_GPT_INT_EN_		(0x00080000)  /* R/W */
+#define	INT_EN_PHY_INT_EN_		(0x00040000)  /* R/W */
+#define	INT_EN_PME_INT_EN_		(0x00020000)  /* R/W */
+#define	INT_EN_TXSO_EN_			(0x00010000)  /* R/W */
+#define	INT_EN_RWT_EN_			(0x00008000)  /* R/W */
+#define	INT_EN_RXE_EN_			(0x00004000)  /* R/W */
+#define	INT_EN_TXE_EN_			(0x00002000)  /* R/W */
+//#define	INT_EN_ERX_EN_			(0x00001000)  /* R/W */
+#define	INT_EN_TDFU_EN_			(0x00000800)  /* R/W */
+#define	INT_EN_TDFO_EN_			(0x00000400)  /* R/W */
+#define	INT_EN_TDFA_EN_			(0x00000200)  /* R/W */
+#define	INT_EN_TSFF_EN_			(0x00000100)  /* R/W */
+#define	INT_EN_TSFL_EN_			(0x00000080)  /* R/W */
+//#define	INT_EN_RXDF_EN_			(0x00000040)  /* R/W */
+#define	INT_EN_RDFO_EN_			(0x00000040)  /* R/W */
+#define	INT_EN_RDFL_EN_			(0x00000020)  /* R/W */
+#define	INT_EN_RSFF_EN_			(0x00000010)  /* R/W */
+#define	INT_EN_RSFL_EN_			(0x00000008)  /* R/W */
+#define	INT_EN_GPIO2_INT_		(0x00000004)  /* R/W */
+#define	INT_EN_GPIO1_INT_		(0x00000002)  /* R/W */
+#define	INT_EN_GPIO0_INT_		(0x00000001)  /* R/W */
+
+#define BYTE_TEST		(0x64)
+#define FIFO_INT		(0x68)
+#define	FIFO_INT_TX_AVAIL_LEVEL_	(0xFF000000)  /* R/W */
+#define	FIFO_INT_TX_STS_LEVEL_		(0x00FF0000)  /* R/W */
+#define	FIFO_INT_RX_AVAIL_LEVEL_	(0x0000FF00)  /* R/W */
+#define	FIFO_INT_RX_STS_LEVEL_		(0x000000FF)  /* R/W */
+
+#define RX_CFG			(0x6C)
+#define	RX_CFG_RX_END_ALGN_		(0xC0000000)  /* R/W */
+#define		RX_CFG_RX_END_ALGN4_		(0x00000000)  /* R/W */
+#define		RX_CFG_RX_END_ALGN16_		(0x40000000)  /* R/W */
+#define		RX_CFG_RX_END_ALGN32_		(0x80000000)  /* R/W */
+#define	RX_CFG_RX_DMA_CNT_		(0x0FFF0000)  /* R/W */
+#define	RX_CFG_RX_DUMP_			(0x00008000)  /* R/W */
+#define	RX_CFG_RXDOFF_			(0x00001F00)  /* R/W */
+//#define	RX_CFG_RXBAD_			(0x00000001)  /* R/W */
+
+#define TX_CFG			(0x70)
+//#define	TX_CFG_TX_DMA_LVL_		(0xE0000000)	 /* R/W */
+//#define	TX_CFG_TX_DMA_CNT_		(0x0FFF0000)	 /* R/W Self Clearing */
+#define	TX_CFG_TXS_DUMP_		(0x00008000)  /* Self Clearing */
+#define	TX_CFG_TXD_DUMP_		(0x00004000)  /* Self Clearing */
+#define	TX_CFG_TXSAO_			(0x00000004)  /* R/W */
+#define	TX_CFG_TX_ON_			(0x00000002)  /* R/W */
+#define	TX_CFG_STOP_TX_			(0x00000001)  /* Self Clearing */
+
+#define HW_CFG			(0x74)
+#define	HW_CFG_TTM_			(0x00200000)  /* R/W */
+#define	HW_CFG_SF_			(0x00100000)  /* R/W */
+#define	HW_CFG_TX_FIF_SZ_		(0x000F0000)  /* R/W */
+#define	HW_CFG_TR_			(0x00003000)  /* R/W */
+#define	HW_CFG_PHY_CLK_SEL_		(0x00000060)  /* R/W */
+#define		 HW_CFG_PHY_CLK_SEL_INT_PHY_ 	(0x00000000) /* R/W */
+#define		 HW_CFG_PHY_CLK_SEL_EXT_PHY_ 	(0x00000020) /* R/W */
+#define		 HW_CFG_PHY_CLK_SEL_CLK_DIS_ 	(0x00000040) /* R/W */
+#define	HW_CFG_SMI_SEL_			(0x00000010)  /* R/W */
+#define	HW_CFG_EXT_PHY_DET_		(0x00000008)  /* RO */
+#define	HW_CFG_EXT_PHY_EN_		(0x00000004)  /* R/W */
+#define	HW_CFG_32_16_BIT_MODE_		(0x00000004)  /* RO */
+#define	HW_CFG_SRST_TO_			(0x00000002)  /* RO */
+#define	HW_CFG_SRST_			(0x00000001)  /* Self Clearing */
+
+#define RX_DP_CTRL		(0x78)
+#define	RX_DP_CTRL_RX_FFWD_		(0x80000000)  /* R/W */
+#define	RX_DP_CTRL_FFWD_BUSY_		(0x80000000)  /* RO */
+
+#define RX_FIFO_INF		(0x7C)
+#define	 RX_FIFO_INF_RXSUSED_		(0x00FF0000)  /* RO */
+#define	 RX_FIFO_INF_RXDUSED_		(0x0000FFFF)  /* RO */
+
+#define TX_FIFO_INF		(0x80)
+#define	TX_FIFO_INF_TSUSED_		(0x00FF0000)  /* RO */
+#define	TX_FIFO_INF_TDFREE_		(0x0000FFFF)  /* RO */
+
+#define PMT_CTRL		(0x84)
+#define	PMT_CTRL_PM_MODE_		(0x00003000)  /* Self Clearing */
+#define	PMT_CTRL_PHY_RST_		(0x00000400)  /* Self Clearing */
+#define	PMT_CTRL_WOL_EN_		(0x00000200)  /* R/W */
+#define	PMT_CTRL_ED_EN_			(0x00000100)  /* R/W */
+#define	PMT_CTRL_PME_TYPE_		(0x00000040)  /* R/W Not Affected by SW Reset */
+#define	PMT_CTRL_WUPS_			(0x00000030)  /* R/WC */
+#define		PMT_CTRL_WUPS_NOWAKE_		(0x00000000)  /* R/WC */
+#define		PMT_CTRL_WUPS_ED_		(0x00000010)  /* R/WC */
+#define		PMT_CTRL_WUPS_WOL_		(0x00000020)  /* R/WC */
+#define		PMT_CTRL_WUPS_MULTI_		(0x00000030)  /* R/WC */
+#define	PMT_CTRL_PME_IND_		(0x00000008)  /* R/W */
+#define	PMT_CTRL_PME_POL_		(0x00000004)  /* R/W */
+#define	PMT_CTRL_PME_EN_		(0x00000002)  /* R/W Not Affected by SW Reset */
+#define	PMT_CTRL_READY_			(0x00000001)  /* RO */
+
+#define GPIO_CFG		(0x88)
+#define	GPIO_CFG_LED3_EN_		(0x40000000)  /* R/W */
+#define	GPIO_CFG_LED2_EN_		(0x20000000)  /* R/W */
+#define	GPIO_CFG_LED1_EN_		(0x10000000)  /* R/W */
+#define	GPIO_CFG_GPIO2_INT_POL_		(0x04000000)  /* R/W */
+#define	GPIO_CFG_GPIO1_INT_POL_		(0x02000000)  /* R/W */
+#define	GPIO_CFG_GPIO0_INT_POL_		(0x01000000)  /* R/W */
+#define	GPIO_CFG_EEPR_EN_		(0x00700000)  /* R/W */
+#define	GPIO_CFG_GPIOBUF2_		(0x00040000)  /* R/W */
+#define	GPIO_CFG_GPIOBUF1_		(0x00020000)  /* R/W */
+#define	GPIO_CFG_GPIOBUF0_		(0x00010000)  /* R/W */
+#define	GPIO_CFG_GPIODIR2_		(0x00000400)  /* R/W */
+#define	GPIO_CFG_GPIODIR1_		(0x00000200)  /* R/W */
+#define	GPIO_CFG_GPIODIR0_		(0x00000100)  /* R/W */
+#define	GPIO_CFG_GPIOD4_		(0x00000010)  /* R/W */
+#define	GPIO_CFG_GPIOD3_		(0x00000008)  /* R/W */
+#define	GPIO_CFG_GPIOD2_		(0x00000004)  /* R/W */
+#define	GPIO_CFG_GPIOD1_		(0x00000002)  /* R/W */
+#define	GPIO_CFG_GPIOD0_		(0x00000001)  /* R/W */
+
+#define GPT_CFG			(0x8C)
+#define	GPT_CFG_TIMER_EN_		(0x20000000)  /* R/W */
+#define	GPT_CFG_GPT_LOAD_		(0x0000FFFF)  /* R/W */
+
+#define GPT_CNT			(0x90)
+#define	GPT_CNT_GPT_CNT_		(0x0000FFFF)  /* RO */
+
+#define ENDIAN			(0x98)
+#define FREE_RUN		(0x9C)
+#define RX_DROP			(0xA0)
+#define MAC_CSR_CMD		(0xA4)
+#define	 MAC_CSR_CMD_CSR_BUSY_		(0x80000000)  /* Self Clearing */
+#define	 MAC_CSR_CMD_R_NOT_W_		(0x40000000)  /* R/W */
+#define	 MAC_CSR_CMD_CSR_ADDR_		(0x000000FF)  /* R/W */
+
+#define MAC_CSR_DATA		(0xA8)
+#define AFC_CFG			(0xAC)
+#define		AFC_CFG_AFC_HI_			(0x00FF0000)  /* R/W */
+#define		AFC_CFG_AFC_LO_			(0x0000FF00)  /* R/W */
+#define		AFC_CFG_BACK_DUR_		(0x000000F0)  /* R/W */
+#define		AFC_CFG_FCMULT_			(0x00000008)  /* R/W */
+#define		AFC_CFG_FCBRD_			(0x00000004)  /* R/W */
+#define		AFC_CFG_FCADD_			(0x00000002)  /* R/W */
+#define		AFC_CFG_FCANY_			(0x00000001)  /* R/W */
+
+#define E2P_CMD			(0xB0)
+#define	E2P_CMD_EPC_BUSY_		(0x80000000)  /* Self Clearing */
+#define	E2P_CMD_EPC_CMD_			(0x70000000)  /* R/W */
+#define		E2P_CMD_EPC_CMD_READ_		(0x00000000)  /* R/W */
+#define		E2P_CMD_EPC_CMD_EWDS_		(0x10000000)  /* R/W */
+#define		E2P_CMD_EPC_CMD_EWEN_		(0x20000000)  /* R/W */
+#define		E2P_CMD_EPC_CMD_WRITE_		(0x30000000)  /* R/W */
+#define		E2P_CMD_EPC_CMD_WRAL_		(0x40000000)  /* R/W */
+#define		E2P_CMD_EPC_CMD_ERASE_		(0x50000000)  /* R/W */
+#define		E2P_CMD_EPC_CMD_ERAL_		(0x60000000)  /* R/W */
+#define		E2P_CMD_EPC_CMD_RELOAD_		(0x70000000)  /* R/W */
+#define	E2P_CMD_EPC_TIMEOUT_		(0x00000200)  /* RO */
+#define	E2P_CMD_MAC_ADDR_LOADED_	(0x00000100)  /* RO */
+#define	E2P_CMD_EPC_ADDR_		(0x000000FF)  /* R/W */
+
+#define E2P_DATA		(0xB4)
+#define	E2P_DATA_EEPROM_DATA_		(0x000000FF)  /* R/W */
+/* end of LAN register offsets and bit definitions */
+
+/*
+ ****************************************************************************
+ ****************************************************************************
+ * MAC Control and Status Register (Indirect Address)
+ * Offset (through the MAC_CSR CMD and DATA port)
+ ****************************************************************************
+ ****************************************************************************
+ *
+ */
+#define MAC_CR			(0x01)  /* R/W */
+
+/* MAC_CR - MAC Control Register */
+#define MAC_CR_RXALL_			(0x80000000)
+// TODO: delete this bit? It is not described in the data sheet.
+#define MAC_CR_HBDIS_			(0x10000000)
+#define MAC_CR_RCVOWN_			(0x00800000)
+#define MAC_CR_LOOPBK_			(0x00200000)
+#define MAC_CR_FDPX_			(0x00100000)
+#define MAC_CR_MCPAS_			(0x00080000)
+#define MAC_CR_PRMS_			(0x00040000)
+#define MAC_CR_INVFILT_			(0x00020000)
+#define MAC_CR_PASSBAD_			(0x00010000)
+#define MAC_CR_HFILT_			(0x00008000)
+#define MAC_CR_HPFILT_			(0x00002000)
+#define MAC_CR_LCOLL_			(0x00001000)
+#define MAC_CR_BCAST_			(0x00000800)
+#define MAC_CR_DISRTY_			(0x00000400)
+#define MAC_CR_PADSTR_			(0x00000100)
+#define MAC_CR_BOLMT_MASK_		(0x000000C0)
+#define MAC_CR_DFCHK_			(0x00000020)
+#define MAC_CR_TXEN_			(0x00000008)
+#define MAC_CR_RXEN_			(0x00000004)
+
+#define ADDRH			(0x02)	  /* R/W mask 0x0000FFFFUL */
+#define ADDRL			(0x03)	  /* R/W mask 0xFFFFFFFFUL */
+#define HASHH			(0x04)	  /* R/W */
+#define HASHL			(0x05)	  /* R/W */
+
+#define MII_ACC			(0x06)	  /* R/W */
+#define MII_ACC_PHY_ADDR_		(0x0000F800)
+#define MII_ACC_MIIRINDA_		(0x000007C0)
+#define MII_ACC_MII_WRITE_		(0x00000002)
+#define MII_ACC_MII_BUSY_		(0x00000001)
+
+#define MII_DATA		(0x07)	  /* R/W mask 0x0000FFFFUL */
+
+#define FLOW			(0x08)	  /* R/W */
+#define FLOW_FCPT_			(0xFFFF0000)
+#define FLOW_FCPASS_			(0x00000004)
+#define FLOW_FCEN_			(0x00000002)
+#define FLOW_FCBSY_			(0x00000001)
+
+#define VLAN1			(0x09)	  /* R/W mask 0x0000FFFFUL */
+#define VLAN1_VTI1_			(0x0000ffff)
+
+#define VLAN2			(0x0A)	  /* R/W mask 0x0000FFFFUL */
+#define VLAN2_VTI2_			(0x0000ffff)
+
+#define WUFF			(0x0B)	  /* WO */
+
+#define WUCSR			(0x0C)	  /* R/W */
+#define WUCSR_GUE_			(0x00000200)
+#define WUCSR_WUFR_			(0x00000040)
+#define WUCSR_MPR_			(0x00000020)
+#define WUCSR_WAKE_EN_			(0x00000004)
+#define WUCSR_MPEN_			(0x00000002)
+
+/*
+ ****************************************************************************
+ * Chip Specific MII Defines
+ ****************************************************************************
+ *
+ * Phy register offsets and bit definitions
+ *
+ */
+
+#define PHY_MODE_CTRL_STS	((u32)17)	/* Mode Control/Status Register */
+//#define MODE_CTRL_STS_FASTRIP_	  ((u16)0x4000)
+#define MODE_CTRL_STS_EDPWRDOWN_	 ((u16)0x2000)
+//#define MODE_CTRL_STS_LOWSQEN_	   ((u16)0x0800)
+//#define MODE_CTRL_STS_MDPREBP_	   ((u16)0x0400)
+//#define MODE_CTRL_STS_FARLOOPBACK_  ((u16)0x0200)
+//#define MODE_CTRL_STS_FASTEST_	   ((u16)0x0100)
+//#define MODE_CTRL_STS_REFCLKEN_	   ((u16)0x0010)
+//#define MODE_CTRL_STS_PHYADBP_	   ((u16)0x0008)
+//#define MODE_CTRL_STS_FORCE_G_LINK_ ((u16)0x0004)
+#define MODE_CTRL_STS_ENERGYON_	 	((u16)0x0002)
+
+#define PHY_INT_SRC			((u32)29)
+#define PHY_INT_SRC_ENERGY_ON_			((u16)0x0080)
+#define PHY_INT_SRC_ANEG_COMP_			((u16)0x0040)
+#define PHY_INT_SRC_REMOTE_FAULT_		((u16)0x0020)
+#define PHY_INT_SRC_LINK_DOWN_			((u16)0x0010)
+#define PHY_INT_SRC_ANEG_LP_ACK_		((u16)0x0008)
+#define PHY_INT_SRC_PAR_DET_FAULT_		((u16)0x0004)
+#define PHY_INT_SRC_ANEG_PGRX_			((u16)0x0002)
+
+#define PHY_INT_MASK			((u32)30)
+#define PHY_INT_MASK_ENERGY_ON_			((u16)0x0080)
+#define PHY_INT_MASK_ANEG_COMP_			((u16)0x0040)
+#define PHY_INT_MASK_REMOTE_FAULT_		((u16)0x0020)
+#define PHY_INT_MASK_LINK_DOWN_			((u16)0x0010)
+#define PHY_INT_MASK_ANEG_LP_ACK_		((u16)0x0008)
+#define PHY_INT_MASK_PAR_DET_FAULT_		((u16)0x0004)
+#define PHY_INT_MASK_ANEG_PGRX_			((u16)0x0002)
+
+#define PHY_SPECIAL			((u32)31)
+#define PHY_SPECIAL_ANEG_DONE_			((u16)0x1000)
+#define PHY_SPECIAL_RES_			((u16)0x0040)
+#define PHY_SPECIAL_RES_MASK_			((u16)0x0FE1)
+#define PHY_SPECIAL_SPD_			((u16)0x001C)
+#define PHY_SPECIAL_SPD_10HALF_			((u16)0x0004)
+#define PHY_SPECIAL_SPD_10FULL_			((u16)0x0014)
+#define PHY_SPECIAL_SPD_100HALF_		((u16)0x0008)
+#define PHY_SPECIAL_SPD_100FULL_		((u16)0x0018)
+
+#define LAN911X_INTERNAL_PHY_ID		(0x0007C000)
+
+/* Chip ID values */
+#define CHIP_9115	0x115
+#define CHIP_9116	0x116
+#define CHIP_9117	0x117
+#define CHIP_9118	0x118
+
+struct chip_id {
+	u16 id;
+	char *name;
+};
+ 
+static const struct chip_id chip_ids[] =  {
+	{ CHIP_9115, "LAN9115" },
+	{ CHIP_9116, "LAN9116" },
+	{ CHIP_9117, "LAN9117" },
+	{ CHIP_9118, "LAN9118" },
+	{ 0, NULL },
+};
+
+#define IS_REV_A(x)	((x & 0xFFFF)==0)
+
+/*
+ * Macros to abstract register access according to the data bus
+ * capabilities.  Please use those and not the in/out primitives.
+ */
+/* FIFO read/write macros */
+#define SMC_PUSH_DATA(p, l)	SMC_outsl( ioaddr, TX_DATA_FIFO, p, (l) >> 2 )
+#define SMC_PULL_DATA(p, l)	SMC_insl ( ioaddr, RX_DATA_FIFO, p, (l) >> 2 )
+#define SMC_SET_TX_FIFO(x) 	SMC_outl( x, ioaddr, TX_DATA_FIFO )
+#define SMC_GET_RX_FIFO()	SMC_inl( ioaddr, RX_DATA_FIFO )
+
+
+/* I/O mapped register read/write macros */
+#define SMC_GET_TX_STS_FIFO()		SMC_inl( ioaddr, TX_STATUS_FIFO )
+#define SMC_GET_RX_STS_FIFO()		SMC_inl( ioaddr, RX_STATUS_FIFO )
+#define SMC_GET_RX_STS_FIFO_PEEK()	SMC_inl( ioaddr, RX_STATUS_FIFO_PEEK )
+#define SMC_GET_PN()			(SMC_inl( ioaddr, ID_REV ) >> 16)
+#define SMC_GET_REV()			(SMC_inl( ioaddr, ID_REV ) & 0xFFFF)
+#define SMC_GET_IRQ_CFG()		SMC_inl( ioaddr, INT_CFG )
+#define SMC_SET_IRQ_CFG(x)		SMC_outl( x, ioaddr, INT_CFG )
+#define SMC_GET_INT()			SMC_inl( ioaddr, INT_STS )
+#define SMC_ACK_INT(x)			SMC_outl( x, ioaddr, INT_STS )
+#define SMC_GET_INT_EN()		SMC_inl( ioaddr, INT_EN )
+#define SMC_SET_INT_EN(x)		SMC_outl( x, ioaddr, INT_EN )
+#define SMC_GET_BYTE_TEST()		SMC_inl( ioaddr, BYTE_TEST )
+#define SMC_SET_BYTE_TEST(x)		SMC_outl( x, ioaddr, BYTE_TEST )
+#define SMC_GET_FIFO_INT()		SMC_inl( ioaddr, FIFO_INT )
+#define SMC_SET_FIFO_INT(x)		SMC_outl( x, ioaddr, FIFO_INT )
+#define SMC_SET_FIFO_TDA(x)					\
+	do {							\
+		unsigned long __flags;				\
+		int __mask;					\
+		local_irq_save(__flags);			\
+		__mask = SMC_GET_FIFO_INT() & ~(0xFF<<24);	\
+		SMC_SET_FIFO_INT( __mask | (x)<<24 );		\
+		local_irq_restore(__flags);			\
+	} while (0)
+#define SMC_SET_FIFO_TSL(x)					\
+	do {							\
+		unsigned long __flags;				\
+		int __mask;					\
+		local_irq_save(__flags);			\
+		__mask = SMC_GET_FIFO_INT() & ~(0xFF<<16);	\
+		SMC_SET_FIFO_INT( __mask | (((x) & 0xFF)<<16));	\
+		local_irq_restore(__flags);			\
+	} while (0)
+#define SMC_SET_FIFO_RSA(x)					\
+	do {							\
+		unsigned long __flags;				\
+		int __mask;					\
+		local_irq_save(__flags);			\
+		__mask = SMC_GET_FIFO_INT() & ~(0xFF<<8);	\
+		SMC_SET_FIFO_INT( __mask | (((x) & 0xFF)<<8));	\
+		local_irq_restore(__flags);			\
+	} while (0)
+#define SMC_SET_FIFO_RSL(x)					\
+	do {							\
+		unsigned long __flags;				\
+		int __mask;					\
+		local_irq_save(__flags);			\
+		__mask = SMC_GET_FIFO_INT() & ~0xFF;		\
+		SMC_SET_FIFO_INT( __mask | ((x) & 0xFF));	\
+		local_irq_restore(__flags);			\
+	} while (0)
+#define SMC_GET_RX_CFG()		SMC_inl( ioaddr, RX_CFG )
+#define SMC_SET_RX_CFG(x)		SMC_outl( x, ioaddr, RX_CFG )
+#define SMC_GET_TX_CFG()		SMC_inl( ioaddr, TX_CFG )
+#define SMC_SET_TX_CFG(x)		SMC_outl( x, ioaddr, TX_CFG )
+#define SMC_GET_HW_CFG()		SMC_inl( ioaddr, HW_CFG )
+#define SMC_SET_HW_CFG(x)		SMC_outl( x, ioaddr, HW_CFG )
+#define SMC_GET_RX_DP_CTRL()		SMC_inl( ioaddr, RX_DP_CTRL )
+#define SMC_SET_RX_DP_CTRL(x)		SMC_outl( x, ioaddr, RX_DP_CTRL )
+#define SMC_GET_PMT_CTRL()		SMC_inl( ioaddr, PMT_CTRL )
+#define SMC_SET_PMT_CTRL(x)		SMC_outl( x, ioaddr, PMT_CTRL )
+#define SMC_GET_GPIO_CFG()		SMC_inl( ioaddr, GPIO_CFG )
+#define SMC_SET_GPIO_CFG(x)		SMC_outl( x, ioaddr, GPIO_CFG )
+#define SMC_GET_RX_FIFO_INF()		SMC_inl( ioaddr, RX_FIFO_INF )
+#define SMC_SET_RX_FIFO_INF(x)		SMC_outl( x, ioaddr, RX_FIFO_INF )
+#define SMC_GET_TX_FIFO_INF()		SMC_inl( ioaddr, TX_FIFO_INF )
+#define SMC_SET_TX_FIFO_INF(x)		SMC_outl( x, ioaddr, TX_FIFO_INF )
+#define SMC_GET_GPT_CFG()		SMC_inl( ioaddr, GPT_CFG )
+#define SMC_SET_GPT_CFG(x)		SMC_outl( x, ioaddr, GPT_CFG )
+#define SMC_GET_RX_DROP()		SMC_inl( ioaddr, RX_DROP )
+#define SMC_SET_RX_DROP(x)		SMC_outl( x, ioaddr, RX_DROP )
+#define SMC_GET_MAC_CMD()		SMC_inl( ioaddr, MAC_CSR_CMD )
+#define SMC_SET_MAC_CMD(x)		SMC_outl( x, ioaddr, MAC_CSR_CMD )
+#define SMC_GET_MAC_DATA()		SMC_inl( ioaddr, MAC_CSR_DATA )
+#define SMC_SET_MAC_DATA(x)		SMC_outl( x, ioaddr, MAC_CSR_DATA )
+#define SMC_GET_AFC_CFG()		SMC_inl( ioaddr, AFC_CFG )
+#define SMC_SET_AFC_CFG(x)		SMC_outl( x, ioaddr, AFC_CFG )
+#define SMC_GET_E2P_CMD()		SMC_inl( ioaddr, E2P_CMD )
+#define SMC_SET_E2P_CMD(x)		SMC_outl( x, ioaddr, E2P_CMD )
+#define SMC_GET_E2P_DATA()		SMC_inl( ioaddr, E2P_DATA )
+#define SMC_SET_E2P_DATA(x)		SMC_outl( x, ioaddr, E2P_DATA )
+
+/* MAC register read/write macros */
+#define SMC_GET_MAC_CSR(a,v)						\
+	do {								\
+		while (SMC_GET_MAC_CMD() & MAC_CSR_CMD_CSR_BUSY_);	\
+		SMC_SET_MAC_CMD(MAC_CSR_CMD_CSR_BUSY_ |			\
+			MAC_CSR_CMD_R_NOT_W_ | (a) );			\
+		while (SMC_GET_MAC_CMD() & MAC_CSR_CMD_CSR_BUSY_);	\
+		v = SMC_GET_MAC_DATA();					\
+	} while (0)
+#define SMC_SET_MAC_CSR(a,v)						\
+	do {								\
+		while (SMC_GET_MAC_CMD() & MAC_CSR_CMD_CSR_BUSY_);	\
+		SMC_SET_MAC_DATA(v);					\
+		SMC_SET_MAC_CMD(MAC_CSR_CMD_CSR_BUSY_ | (a) );		\
+		while (SMC_GET_MAC_CMD() & MAC_CSR_CMD_CSR_BUSY_);	\
+	} while (0)
+#define SMC_GET_MAC_CR(x)	SMC_GET_MAC_CSR( MAC_CR, x )
+#define SMC_SET_MAC_CR(x)	SMC_SET_MAC_CSR( MAC_CR, x )
+#define SMC_GET_ADDRH(x)	SMC_GET_MAC_CSR( ADDRH, x )
+#define SMC_SET_ADDRH(x)	SMC_SET_MAC_CSR( ADDRH, x )
+#define SMC_GET_ADDRL(x)	SMC_GET_MAC_CSR( ADDRL, x )
+#define SMC_SET_ADDRL(x)	SMC_SET_MAC_CSR( ADDRL, x )
+#define SMC_GET_HASHH(x)	SMC_GET_MAC_CSR( HASHH, x )
+#define SMC_SET_HASHH(x)	SMC_SET_MAC_CSR( HASHH, x )
+#define SMC_GET_HASHL(x)	SMC_GET_MAC_CSR( HASHL, x )
+#define SMC_SET_HASHL(x)	SMC_SET_MAC_CSR( HASHL, x )
+#define SMC_GET_MII_ACC(x)	SMC_GET_MAC_CSR( MII_ACC, x )
+#define SMC_SET_MII_ACC(x)	SMC_SET_MAC_CSR( MII_ACC, x )
+#define SMC_GET_MII_DATA(x)	SMC_GET_MAC_CSR( MII_DATA, x )
+#define SMC_SET_MII_DATA(x)	SMC_SET_MAC_CSR( MII_DATA, x )
+#define SMC_GET_FLOW(x)		SMC_GET_MAC_CSR( FLOW, x )
+#define SMC_SET_FLOW(x)		SMC_SET_MAC_CSR( FLOW, x )
+#define SMC_GET_VLAN1(x)	SMC_GET_MAC_CSR( VLAN1, x )
+#define SMC_SET_VLAN1(x)	SMC_SET_MAC_CSR( VLAN1, x )
+#define SMC_GET_VLAN2(x)	SMC_GET_MAC_CSR( VLAN2, x )
+#define SMC_SET_VLAN2(x)	SMC_SET_MAC_CSR( VLAN2, x )
+#define SMC_SET_WUFF(x)		SMC_SET_MAC_CSR( WUFF, x )
+#define SMC_GET_WUCSR(x)	SMC_GET_MAC_CSR( WUCSR, x )
+#define SMC_SET_WUCSR(x)	SMC_SET_MAC_CSR( WUCSR, x )
+
+/* PHY register read/write macros */
+#define SMC_GET_MII(a,phy,v)					\
+	do {							\
+		u32 __v;					\
+		do {						\
+			SMC_GET_MII_ACC(__v);			\
+		} while ( __v & MII_ACC_MII_BUSY_ );		\
+		SMC_SET_MII_ACC( ((phy)<<11) | ((a)<<6) |	\
+			MII_ACC_MII_BUSY_);			\
+		do {						\
+			SMC_GET_MII_ACC(__v);			\
+		} while ( __v & MII_ACC_MII_BUSY_ );		\
+		SMC_GET_MII_DATA(v);				\
+	} while (0)
+#define SMC_SET_MII(a,phy,v)					\
+	do {							\
+		u32 __v;					\
+		do {						\
+			SMC_GET_MII_ACC(__v);			\
+		} while ( __v & MII_ACC_MII_BUSY_ );		\
+		SMC_SET_MII_DATA(v);				\
+		SMC_SET_MII_ACC( ((phy)<<11) | ((a)<<6) |	\
+			MII_ACC_MII_BUSY_	 |		\
+			MII_ACC_MII_WRITE_  );			\
+		do {						\
+			SMC_GET_MII_ACC(__v);			\
+		} while ( __v & MII_ACC_MII_BUSY_ );		\
+	} while (0)
+#define SMC_GET_PHY_BMCR(phy,x)		SMC_GET_MII( MII_BMCR, phy, x )
+#define SMC_SET_PHY_BMCR(phy,x)		SMC_SET_MII( MII_BMCR, phy, x )
+#define SMC_GET_PHY_BMSR(phy,x)		SMC_GET_MII( MII_BMSR, phy, x )
+#define SMC_GET_PHY_ID1(phy,x)		SMC_GET_MII( MII_PHYSID1, phy, x )
+#define SMC_GET_PHY_ID2(phy,x)		SMC_GET_MII( MII_PHYSID2, phy, x )
+#define SMC_GET_PHY_MII_ADV(phy,x)	SMC_GET_MII( MII_ADVERTISE, phy, x )
+#define SMC_SET_PHY_MII_ADV(phy,x)	SMC_SET_MII( MII_ADVERTISE, phy, x )
+#define SMC_GET_PHY_MII_LPA(phy,x)	SMC_GET_MII( MII_LPA, phy, x )
+#define SMC_SET_PHY_MII_LPA(phy,x)	SMC_SET_MII( MII_LPA, phy, x )
+#define SMC_GET_PHY_CTRL_STS(phy,x)	SMC_GET_MII( PHY_MODE_CTRL_STS, phy, x )
+#define SMC_SET_PHY_CTRL_STS(phy,x)	SMC_SET_MII( PHY_MODE_CTRL_STS, phy, x )
+#define SMC_GET_PHY_INT_SRC(phy,x)	SMC_GET_MII( PHY_INT_SRC, phy, x )
+#define SMC_SET_PHY_INT_SRC(phy,x)	SMC_SET_MII( PHY_INT_SRC, phy, x )
+#define SMC_GET_PHY_INT_MASK(phy,x)	SMC_GET_MII( PHY_INT_MASK, phy, x )
+#define SMC_SET_PHY_INT_MASK(phy,x)	SMC_SET_MII( PHY_INT_MASK, phy, x )
+#define SMC_GET_PHY_SPECIAL(phy,x)	SMC_GET_MII( PHY_SPECIAL, phy, x )
+
+
+
+/* Misc read/write macros */
+
+#ifndef SMC_GET_MAC_ADDR
+#define SMC_GET_MAC_ADDR(addr)					\
+	do {							\
+		unsigned int __v;				\
+								\
+		SMC_GET_MAC_CSR(ADDRL, __v);			\
+		addr[0] = __v; addr[1] = __v >> 8;		\
+		addr[2] = __v >> 16; addr[3] = __v >> 24;	\
+		SMC_GET_MAC_CSR(ADDRH, __v);			\
+		addr[4] = __v; addr[5] = __v >> 8;		\
+	} while (0)
+#endif
+
+#define SMC_SET_MAC_ADDR(addr)					\
+	do {							\
+		 SMC_SET_MAC_CSR(ADDRL,				\
+				 addr[0] |			\
+				(addr[1] << 8) |		\
+				(addr[2] << 16) |		\
+				(addr[3] << 24));		\
+		 SMC_SET_MAC_CSR(ADDRH, addr[4]|(addr[5] << 8));\
+	} while (0)
+
+
+#define SMC_WRITE_EEPROM_CMD(cmd, addr)					\
+	do {								\
+		while (SMC_GET_E2P_CMD() & MAC_CSR_CMD_CSR_BUSY_);	\
+		SMC_SET_MAC_CMD(MAC_CSR_CMD_R_NOT_W_ | a );		\
+		while (SMC_GET_MAC_CMD() & MAC_CSR_CMD_CSR_BUSY_);	\
+	} while (0)
+
+#endif	 /* _SMC911X_H_ */




