Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274162AbRI3Ufs>; Sun, 30 Sep 2001 16:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274161AbRI3Ufa>; Sun, 30 Sep 2001 16:35:30 -0400
Received: from colorfullife.com ([216.156.138.34]:62987 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S274102AbRI3UfO>;
	Sun, 30 Sep 2001 16:35:14 -0400
Message-ID: <3BB78212.FB3973E0@colorfullife.com>
Date: Sun, 30 Sep 2001 22:35:30 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Oliver Seemann <oseemann@cs.tu-berlin.de>,
        jgarzik@mandrakesoft.com
Subject: Re: rtl8139 nic dies with load (2.4.10, kt266)
In-Reply-To: <3BB742FB.86AB06A5@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------D2278F100E73CCD2AE484C66"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D2278F100E73CCD2AE484C66
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

New patch:
* deadlock in error handling fixed.
* error handling didn't restart the chip properly.

Could you try it?
It should now recover properly from the frame errors.

--
	Manfred
--------------D2278F100E73CCD2AE484C66
Content-Type: text/plain; charset=us-ascii;
 name="patch-8139-rx_start"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-8139-rx_start"

--- 2.4/drivers/net/8139too.c	Sun Sep 23 21:20:35 2001
+++ build-2.4/drivers/net/8139too.c	Sun Sep 30 22:31:02 2001
@@ -618,6 +618,7 @@
 static struct net_device_stats *rtl8139_get_stats (struct net_device *dev);
 static inline u32 ether_crc (int length, unsigned char *data);
 static void rtl8139_set_rx_mode (struct net_device *dev);
+static void __set_rx_mode (struct net_device *dev);
 static void rtl8139_hw_start (struct net_device *dev);
 
 #ifdef USE_IO_OPS
@@ -1844,8 +1845,8 @@
 			    struct rtl8139_private *tp, void *ioaddr)
 {
 	u8 tmp8;
-	int tmp_work = 1000;
-
+	int tmp_work;
+    
 	DPRINTK ("%s: Ethernet frame had errors, status %8.8x.\n",
 	         dev->name, rx_status);
 	if (rx_status & RxTooLong) {
@@ -1860,33 +1861,62 @@
 		tp->stats.rx_length_errors++;
 	if (rx_status & RxCRCErr)
 		tp->stats.rx_crc_errors++;
+
 	/* Reset the receiver, based on RealTek recommendation. (Bug?) */
-	tp->cur_rx = 0;
 
 	/* disable receive */
-	RTL_W8 (ChipCmd, CmdTxEnb);
-
-	/* A.C.: Reset the multicast list. */
-	rtl8139_set_rx_mode (dev);
-
-	/* XXX potentially temporary hack to
-	 * restart hung receiver */
+	RTL_W8_F (ChipCmd, CmdTxEnb);
+	tmp_work = 200;
 	while (--tmp_work > 0) {
-		barrier();
+		udelay(1);
+		tmp8 = RTL_R8 (ChipCmd);
+		if (!(tmp8 & CmdRxEnb))
+			break;
+	}
+	if (tmp_work <= 0)
+		printk (KERN_WARNING PFX "rx stop wait too long\n");
+	/* restart receive */
+	tmp_work = 200;
+	while (--tmp_work > 0) {
+		RTL_W8_F (ChipCmd, CmdRxEnb | CmdTxEnb);
+		udelay(1);
 		tmp8 = RTL_R8 (ChipCmd);
 		if ((tmp8 & CmdRxEnb) && (tmp8 & CmdTxEnb))
 			break;
-		RTL_W8 (ChipCmd, CmdRxEnb | CmdTxEnb);
 	}
-
-	/* G.S.: Re-enable receiver */
-	/* XXX temporary hack to work around receiver hang */
-	rtl8139_set_rx_mode (dev);
-
 	if (tmp_work <= 0)
 		printk (KERN_WARNING PFX "tx/rx enable wait too long\n");
-}
 
+	/* and reinitialize all rx related registers */
+	{	/* I have no idea what I'm doing, just copied
+		 * from rtl8139_hw_start.
+		 *	Manfred Spraul
+		 */
+		RTL_W8_F (Cfg9346, Cfg9346_Unlock);
+		/* Must enable Tx/Rx before setting transfer thresholds! */
+		RTL_W8 (ChipCmd, CmdRxEnb | CmdTxEnb);
+
+		tp->rx_config = rtl8139_rx_config | AcceptBroadcast | AcceptMyPhys;
+		RTL_W32 (RxConfig, tp->rx_config);
+		tp->cur_rx = 0;
+
+		if (tp->chipset >= CH_8139B) {
+			/* disable magic packet scanning, which is enabled
+			 * when PM is enabled in Config1 */
+			RTL_W8 (Config3, RTL_R8 (Config3) & ~(1<<5));
+		}
+
+		DPRINTK("init buffer addresses\n");
+
+		/* Lock Config[01234] and BMCR register writes */
+		RTL_W8 (Cfg9346, Cfg9346_Lock);
+
+		/* init Rx ring buffer DMA address */
+		RTL_W32_F (RxBuf, tp->rx_ring_dma);
+	}
+	/* A.C.: Reset the multicast list. */
+	__set_rx_mode (dev);
+}
 
 static void rtl8139_rx_interrupt (struct net_device *dev,
 				  struct rtl8139_private *tp, void *ioaddr)
@@ -2309,11 +2339,10 @@
 }
 
 
-static void rtl8139_set_rx_mode (struct net_device *dev)
+static void __set_rx_mode (struct net_device *dev)
 {
 	struct rtl8139_private *tp = dev->priv;
 	void *ioaddr = tp->mmio_addr;
-	unsigned long flags;
 	u32 mc_filter[2];	/* Multicast hash filter */
 	int i, rx_mode;
 	u32 tmp;
@@ -2350,22 +2379,28 @@
 		}
 	}
 
-	spin_lock_irqsave (&tp->lock, flags);
-
 	/* We can safely update without stopping the chip. */
 	tmp = rtl8139_rx_config | rx_mode;
 	if (tp->rx_config != tmp) {
-		RTL_W32 (RxConfig, tmp);
+		RTL_W32_F (RxConfig, tmp);
 		tp->rx_config = tmp;
 	}
 	RTL_W32_F (MAR0 + 0, mc_filter[0]);
 	RTL_W32_F (MAR0 + 4, mc_filter[1]);
 
-	spin_unlock_irqrestore (&tp->lock, flags);
 
 	DPRINTK ("EXIT\n");
 }
 
+static void rtl8139_set_rx_mode (struct net_device *dev)
+{
+	unsigned long flags;
+	struct rtl8139_private *tp = dev->priv;
+
+	spin_lock_irqsave (&tp->lock, flags);
+	__set_rx_mode(dev);
+	spin_unlock_irqrestore (&tp->lock, flags);
+}
 
 #ifdef CONFIG_PM
 

--------------D2278F100E73CCD2AE484C66--

