Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbUB2S2j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 13:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUB2S2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 13:28:39 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:11268 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262097AbUB2S2X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 13:28:23 -0500
To: "Nick Warne" <nick@ukfsn.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 - 8139too timeout debug info
References: <4041D3B9.24667.2D4E3207@localhost>
	<4041E38F.31264.2D8C0D2E@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 01 Mar 2004 03:28:07 +0900
In-Reply-To: <4041E38F.31264.2D8C0D2E@localhost>
Message-ID: <87d67x91vs.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

"Nick Warne" <nick@ukfsn.org> writes:

> > Thanks. Umm.. strange, already NAPI reverted.
> > Does these patches change the behavior?
> > 
> > debug + revert01 + revert02 + revert03
> 
> **BINGO**
> 
> Excellent.  patch03 has stopped the timeouts.  I have just tested.  I 
> moved (via ftp) a 30MB file from network -> eth0, and at the same 
> time downloaded a 30MB file (via httpd) from the Internet -> eth1.
> 
> I was getting 10Mbs internal, and 30Kbs external (as expected).  NO 
> TIMEOUTS :) :)
> 
> Before, just the internal FTP timed out in 5 seconds.
> 
> dmesg is basically very quiet:
> 
> http://www.linicks.net/8139too_debug/bingo.txt
> 
> > after
> > 
> > debug + revert01 + revert02 + revert03 + revert04
> 
> I haven't applied patch04.
> 
> I will continue to run the debug kernel.

Ok, thanks for debugging. Looks like this problem is not 8139too.
And same problem should happen with the old driver (probably, it appear
with "max_interrupt_work=1").

Umm... I guess this problem is miss config of Edge/Level-Trigger or
something.  Sorry, I don't know detail.


Jeff, I think CONFIG_8139TOO_NAPI is useful for now.
What do you think of these? Any idea?

8139too-config-napi.patch      - add CONFIG_8139TOO_NAPI
                                 (dirty #ifdef, the cleanup may be needed)
8139too-useful-txtimeout.patch - more debug info for rtl8139_tx_timeout()

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=8139too-config-napi.patch


[PATCH] 8139too: add CONFIG_8139TOO_NAPI

This patch adds the CONFIG_8139TOO_NAPI.


---

 drivers/net/8139too.c |  102 ++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/Kconfig   |    4 +
 2 files changed, 102 insertions(+), 4 deletions(-)

diff -puN drivers/net/8139too.c~8139too-config-napi drivers/net/8139too.c
--- linux-2.6.4-rc1/drivers/net/8139too.c~8139too-config-napi	2004-03-01 01:46:55.000000000 +0900
+++ linux-2.6.4-rc1-hirofumi/drivers/net/8139too.c	2004-03-01 02:54:46.000000000 +0900
@@ -159,6 +159,11 @@
 static int media[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 static int full_duplex[MAX_UNITS] = {-1, -1, -1, -1, -1, -1, -1, -1};
 
+#ifndef CONFIG_8139TOO_NAPI
+/* Maximum events (Rx packets, etc.) to handle at each interrupt. */
+static int max_interrupt_work = 20;
+#endif
+
 /* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
    The RTL chips use a 64 element hash table based on the Ethernet CRC.  */
 static int multicast_filter_limit = 32;
@@ -592,6 +597,10 @@ MODULE_AUTHOR ("Jeff Garzik <jgarzik@pob
 MODULE_DESCRIPTION ("RealTek RTL-8139 Fast Ethernet driver");
 MODULE_LICENSE("GPL");
 
+#ifndef CONFIG_8139TOO_NAPI
+MODULE_PARM (max_interrupt_work, "i");
+MODULE_PARM_DESC (max_interrupt_work, "8139too maximum events handled per interrupt");
+#endif
 MODULE_PARM (multicast_filter_limit, "i");
 MODULE_PARM (media, "1-" __MODULE_STRING(MAX_UNITS) "i");
 MODULE_PARM (full_duplex, "1-" __MODULE_STRING(MAX_UNITS) "i");
@@ -611,7 +620,9 @@ static void rtl8139_tx_timeout (struct n
 static void rtl8139_init_ring (struct net_device *dev);
 static int rtl8139_start_xmit (struct sk_buff *skb,
 			       struct net_device *dev);
+#ifdef CONFIG_8139TOO_NAPI
 static int rtl8139_poll(struct net_device *dev, int *budget);
+#endif
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void rtl8139_poll_controller(struct net_device *dev);
 #endif
@@ -983,8 +994,10 @@ static int __devinit rtl8139_init_one (s
 	/* The Rtl8139-specific entries in the device structure. */
 	dev->open = rtl8139_open;
 	dev->hard_start_xmit = rtl8139_start_xmit;
+#ifdef CONFIG_8139TOO_NAPI
 	dev->poll = rtl8139_poll;
 	dev->weight = 64;
+#endif
 	dev->stop = rtl8139_close;
 	dev->get_stats = rtl8139_get_stats;
 	dev->set_multicast_list = rtl8139_set_rx_mode;
@@ -1938,7 +1951,10 @@ static int rtl8139_rx(struct net_device 
 		 RTL_R16 (RxBufAddr),
 		 RTL_R16 (RxBufPtr), RTL_R8 (ChipCmd));
 
-	while (netif_running(dev) && received < budget 
+	while (netif_running(dev)
+#ifdef CONFIG_8139TOO_NAPI
+	       && received < budget
+#endif
 	       && (RTL_R8 (ChipCmd) & RxBufEmpty) == 0) {
 		u32 ring_offset = cur_rx % RX_BUF_LEN;
 		u32 rx_status;
@@ -2009,8 +2025,11 @@ static int rtl8139_rx(struct net_device 
 			dev->last_rx = jiffies;
 			tp->stats.rx_bytes += pkt_size;
 			tp->stats.rx_packets++;
-
+#ifdef CONFIG_8139TOO_NAPI
 			netif_receive_skb (skb);
+#else
+			netif_rx (skb);
+#endif
 		} else {
 			if (net_ratelimit()) 
 				printk (KERN_WARNING
@@ -2088,6 +2107,7 @@ static void rtl8139_weird_interrupt (str
 	}
 }
 
+#ifdef CONFIG_8139TOO_NAPI
 static int rtl8139_poll(struct net_device *dev, int *budget)
 {
 	struct rtl8139_private *tp = dev->priv;
@@ -2138,13 +2158,13 @@ static irqreturn_t rtl8139_interrupt (in
 	status = RTL_R16 (IntrStatus);
 
 	/* shared irq? */
-	if (unlikely((status & rtl8139_intr_mask) == 0)) 
+	if (unlikely((status & rtl8139_intr_mask) == 0))
 		goto out;
 
 	handled = 1;
 
 	/* h/w no longer present (hotplug?) or major error, bail */
-	if (unlikely(status == 0xFFFF)) 
+	if (unlikely(status == 0xFFFF))
 		goto out;
 
 	/* close possible race's with dev_close */
@@ -2188,6 +2208,80 @@ static irqreturn_t rtl8139_interrupt (in
 		 dev->name, RTL_R16 (IntrStatus));
 	return IRQ_RETVAL(handled);
 }
+#else /* !CONFIG_8139TOO_NAPI */
+static irqreturn_t rtl8139_interrupt (int irq, void *dev_instance,
+			       struct pt_regs *regs)
+{
+	struct net_device *dev = (struct net_device *) dev_instance;
+	struct rtl8139_private *tp = dev->priv;
+	int boguscnt = max_interrupt_work;
+	void *ioaddr = tp->mmio_addr;
+	u16 status, ackstat;
+	int link_changed = 0; /* avoid bogus "uninit" warning */
+	int handled = 0;
+
+	spin_lock (&tp->lock);
+
+	do {
+		status = RTL_R16 (IntrStatus);
+
+		/* shared irq? */
+		if (unlikely((status & rtl8139_intr_mask) == 0))
+			goto out;
+
+		handled = 1;
+
+		/* h/w no longer present (hotplug?) or major error, bail */
+		if (unlikely(status == 0xFFFF))
+			goto out;
+
+		/* close possible race's with dev_close */
+		if (unlikely(!netif_running(dev))) {
+			RTL_W16 (IntrMask, 0);
+			goto out;
+		}
+
+		/* Acknowledge all of the current interrupt sources ASAP, but
+		   an first get an additional status bit from CSCR. */
+		if (unlikely(status & RxUnderrun))
+			link_changed = RTL_R16 (CSCR) & CSCR_LinkChangeBit;
+
+		ackstat = status & ~(RxAckBits | TxErr);
+		if (ackstat)
+			RTL_W16 (IntrStatus, ackstat);
+
+		if (status & RxAckBits)
+			rtl8139_rx (dev, tp, 0);
+
+		/* Check uncommon events with one test. */
+		if (unlikely(status & (PCIErr|PCSTimeout|RxUnderrun|RxErr)))
+			rtl8139_weird_interrupt (dev, tp, ioaddr,
+						 status, link_changed);
+
+		if (status & (TxOK | TxErr)) {
+			rtl8139_tx_interrupt (dev, tp, ioaddr);
+			if (status & TxErr)
+				RTL_W16 (IntrStatus, TxErr);
+		}
+
+		boguscnt--;
+	} while (boguscnt > 0);
+ out:
+	if (boguscnt <= 0) {
+		printk (KERN_WARNING "%s: Too much work at interrupt, "
+			"IntrStatus=0x%4.4x.\n", dev->name, status);
+
+		/* Clear all interrupt sources. */
+		RTL_W16 (IntrStatus, 0xffff);
+	}
+
+	spin_unlock (&tp->lock);
+
+	DPRINTK ("%s: exiting interrupt, intr_status=%#4.4x.\n",
+		 dev->name, RTL_R16 (IntrStatus));
+	return IRQ_RETVAL(handled);
+}
+#endif /* !CONFIG_8139TOO_NAPI */
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
 /*
diff -puN drivers/net/Kconfig~8139too-config-napi drivers/net/Kconfig
--- linux-2.6.4-rc1/drivers/net/Kconfig~8139too-config-napi	2004-03-01 01:46:55.000000000 +0900
+++ linux-2.6.4-rc1-hirofumi/drivers/net/Kconfig	2004-03-01 01:46:55.000000000 +0900
@@ -1543,6 +1543,10 @@ config 8139TOO
 	  To compile this driver as a module, choose M here: the module
 	  will be called 8139too.  This is recommended.
 
+config 8139TOO_NAPI
+	bool "Use Rx Polling (NAPI)"
+	depends on 8139TOO
+
 config 8139TOO_PIO
 	bool "Use PIO instead of MMIO"
 	default y

_

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=8139too-useful-txtimeout.patch


[PATCH] 8139too: more useful debug info for tx_timeout

	/* disable Tx ASAP, if not already */
	tmp8 = RTL_R8 (ChipCmd);
	if (tmp8 & CmdTxEnb)
		RTL_W8 (ChipCmd, CmdRxEnb);

The above will clear the Tx Descs. So, this prints the debugging info
before rtl8139_tx_timeout() does it. And IntrStatus etc. also prints
anytime for the debug.


---

 drivers/net/8139too.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff -puN drivers/net/8139too.c~8139too-useful-txtimeout drivers/net/8139too.c
--- linux-2.6.4-rc1/drivers/net/8139too.c~8139too-useful-txtimeout	2004-03-01 02:54:54.000000000 +0900
+++ linux-2.6.4-rc1-hirofumi/drivers/net/8139too.c	2004-03-01 02:54:54.000000000 +0900
@@ -1686,11 +1686,19 @@ static void rtl8139_tx_timeout (struct n
 	u8 tmp8;
 	unsigned long flags;
 
-	DPRINTK ("%s: Transmit timeout, status %2.2x %4.4x "
-		 "media %2.2x.\n", dev->name,
-		 RTL_R8 (ChipCmd),
-		 RTL_R16 (IntrStatus),
-		 RTL_R8 (MediaStatus));
+	spin_lock(&tp->rx_lock);
+	printk (KERN_DEBUG "%s: Transmit timeout, status %2.2x %4.4x %4.4x "
+		"media %2.2x.\n", dev->name, RTL_R8 (ChipCmd),
+		RTL_R16(IntrStatus), RTL_R16(IntrMask), RTL_R8(MediaStatus));
+	/* Emit info to figure out what went wrong. */
+	printk (KERN_DEBUG "%s: Tx queue start entry %ld  dirty entry %ld.\n",
+		dev->name, tp->cur_tx, tp->dirty_tx);
+	for (i = 0; i < NUM_TX_DESC; i++)
+		printk (KERN_DEBUG "%s:  Tx descriptor %d is %8.8lx.%s\n",
+			dev->name, i, RTL_R32 (TxStatus0 + (i * 4)),
+			i == tp->dirty_tx % NUM_TX_DESC ?
+				" (queue head)" : "");
+	spin_unlock(&tp->rx_lock);
 
 	tp->xstats.tx_timeouts++;
 
@@ -1703,15 +1711,6 @@ static void rtl8139_tx_timeout (struct n
 	/* Disable interrupts by clearing the interrupt mask. */
 	RTL_W16 (IntrMask, 0x0000);
 
-	/* Emit info to figure out what went wrong. */
-	printk (KERN_DEBUG "%s: Tx queue start entry %ld  dirty entry %ld.\n",
-		dev->name, tp->cur_tx, tp->dirty_tx);
-	for (i = 0; i < NUM_TX_DESC; i++)
-		printk (KERN_DEBUG "%s:  Tx descriptor %d is %8.8lx.%s\n",
-			dev->name, i, RTL_R32 (TxStatus0 + (i * 4)),
-			i == tp->dirty_tx % NUM_TX_DESC ?
-				" (queue head)" : "");
-
 	/* Stop a shared interrupt from scavenging while we are. */
 	spin_lock_irqsave (&tp->lock, flags);
 	rtl8139_tx_clear (tp);
@@ -1723,7 +1722,6 @@ static void rtl8139_tx_timeout (struct n
 		netif_wake_queue (dev);
 	}
 	spin_unlock(&tp->rx_lock);
-	
 }
 
 

_

--=-=-=--
