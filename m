Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUB1RmW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 12:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUB1RmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 12:42:22 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:17679 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261884AbUB1RmL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 12:42:11 -0500
To: "Nick Warne" <nick@ukfsn.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 - 8139too timeout debug info
References: <403F7EEF.4124.2432E62F@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 29 Feb 2004 02:41:27 +0900
In-Reply-To: <403F7EEF.4124.2432E62F@localhost>
Message-ID: <87znb3t83c.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

"Nick Warne" <nick@ukfsn.org> writes:

> Firstly, I am starting a fresh thread here, as I have subscribed to 
> the lkml now so I can reply in a timely manner, and also the other 
> thread was broke as I was replying 'off-list' - sorry about that.
> 
> OK, to recap.  With 2.6.3 I get timeouts with 8139too under network 
> load (any load).  I have never had any problems with these _same_ two 
> cards under any other kernel version over the last 3 years.
> 
> If I use the 8139too.c from 2.6.2, and build 2.6.3 with it, all works 
> fine (I am running this version right now).

Interesting.

Please try the attached patch for debugging. After this problem
happen, send the all output of dmesg, all .config, and "cat /proc/interrupts".

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=8139too-debug.patch

---

 drivers/net/8139too.c |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+)

diff -puN drivers/net/8139too.c~8139too-debug drivers/net/8139too.c
--- linux-2.6.3/drivers/net/8139too.c~8139too-debug	2004-02-29 02:33:44.000000000 +0900
+++ linux-2.6.3-hirofumi/drivers/net/8139too.c	2004-02-29 02:37:45.000000000 +0900
@@ -718,6 +718,25 @@ static const unsigned int rtl8139_rx_con
 static const unsigned int rtl8139_tx_config =
 	(TX_DMA_BURST << TxDMAShift) | (TX_RETRY << TxRetryShift);
 
+#define RTL8139_DUMP(dev) do {						\
+	printk("%s: %s: run %d, stop %d\n", dev->name, __FUNCTION__,	\
+	       netif_running(dev), netif_queue_stopped(dev));		\
+	rtl8139_dump(dev->priv);					\
+} while(0)
+
+static void rtl8139_dump(struct rtl8139_private *tp)
+{
+	void *ioaddr = tp->mmio_addr;
+	int i;
+
+	for (i = 0; i < tp->regs_len; i++) {
+		if (i && (i % 16) == 0)
+			printk("\n");
+		printk("%02x ", RTL_R8(i));
+	}
+	printk("\n");
+}
+
 static void __rtl8139_cleanup_dev (struct net_device *dev)
 {
 	struct rtl8139_private *tp;
@@ -1355,6 +1374,10 @@ static int rtl8139_open (struct net_devi
 
 	rtl8139_start_thread(dev);
 
+	spin_lock_irq(&tp->lock);
+	RTL8139_DUMP(dev);
+	spin_unlock_irq(&tp->lock);
+
 	return 0;
 }
 
@@ -1673,6 +1696,11 @@ static void rtl8139_tx_timeout (struct n
 	u8 tmp8;
 	unsigned long flags;
 
+	printk("%s: irq %d\n", __FUNCTION__, irqs_disabled());
+	spin_lock_irq(&tp->lock);
+	RTL8139_DUMP(dev);
+	spin_unlock_irq(&tp->lock);
+
 	DPRINTK ("%s: Transmit timeout, status %2.2x %4.4x "
 		 "media %2.2x.\n", dev->name,
 		 RTL_R8 (ChipCmd),
@@ -1737,6 +1765,12 @@ static int rtl8139_start_xmit (struct sk
 	}
 
 	spin_lock_irq(&tp->lock);
+	{
+		u32 txstatus = RTL_R32(TxStatus0 + (entry * sizeof(u32)));
+		if (!(txstatus & TxStatOK) && (txstatus & TxUnderrun))
+			printk("8139too: durning re-transmit (%08x)\n",
+			       txstatus);
+	}
 	RTL_W32_F (TxStatus0 + (entry * sizeof (u32)),
 		   tp->tx_flag | max(len, (unsigned int)ETH_ZLEN));
 
@@ -1780,6 +1814,7 @@ static void rtl8139_tx_interrupt (struct
 
 		/* Note: TxCarrierLost is always asserted at 100mbps. */
 		if (txstatus & (TxOutOfWindow | TxAborted)) {
+			RTL8139_DUMP(dev);
 			/* There was an major error, log it. */
 			if (netif_msg_tx_err(tp))
 				printk(KERN_DEBUG "%s: Transmit error, Tx status %8.8x.\n",
@@ -1836,6 +1871,9 @@ static void rtl8139_rx_err (u32 rx_statu
 #ifdef CONFIG_8139_OLD_RX_RESET
 	int tmp_work;
 #endif
+	spin_lock_irq(&tp->lock);
+	RTL8139_DUMP(dev);
+	spin_unlock_irq(&tp->lock);
 
 	if (netif_msg_rx_err (tp)) 
 		printk(KERN_DEBUG "%s: Ethernet frame had errors, status %8.8x.\n",
@@ -2061,6 +2099,8 @@ static void rtl8139_weird_interrupt (str
 	assert (tp != NULL);
 	assert (ioaddr != NULL);
 
+	RTL8139_DUMP(dev);
+
 	/* Update the error count. */
 	tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
 	RTL_W32 (RxMissed, 0);
@@ -2209,6 +2249,10 @@ static int rtl8139_close (struct net_dev
 	int ret = 0;
 	unsigned long flags;
 
+	spin_lock_irq(&tp->lock);
+	RTL8139_DUMP(dev);
+	spin_unlock_irq(&tp->lock);
+
 	netif_stop_queue (dev);
 
 	if (tp->thr_pid >= 0) {
@@ -2271,6 +2315,7 @@ static void rtl8139_get_wol(struct net_d
 	void *ioaddr = np->mmio_addr;
 
 	spin_lock_irq(&np->lock);
+	RTL8139_DUMP(dev);
 	if (rtl_chip_info[np->chipset].flags & HasLWake) {
 		u8 cfg3 = RTL_R8 (Config3);
 		u8 cfg5 = RTL_R8 (Config5);
@@ -2314,6 +2359,7 @@ static int rtl8139_set_wol(struct net_de
 		return -EINVAL;
 
 	spin_lock_irq(&np->lock);
+	RTL8139_DUMP(dev);
 	cfg3 = RTL_R8 (Config3) & ~(Cfg3_LinkUp | Cfg3_Magic);
 	if (wol->wolopts & WAKE_PHY)
 		cfg3 |= Cfg3_LinkUp;
@@ -2352,6 +2398,7 @@ static int rtl8139_get_settings(struct n
 {
 	struct rtl8139_private *np = dev->priv;
 	spin_lock_irq(&np->lock);
+	RTL8139_DUMP(dev);
 	mii_ethtool_gset(&np->mii, cmd);
 	spin_unlock_irq(&np->lock);
 	return 0;
@@ -2362,6 +2409,7 @@ static int rtl8139_set_settings(struct n
 	struct rtl8139_private *np = dev->priv;
 	int rc;
 	spin_lock_irq(&np->lock);
+	RTL8139_DUMP(dev);
 	rc = mii_ethtool_sset(&np->mii, cmd);
 	spin_unlock_irq(&np->lock);
 	return rc;
@@ -2370,12 +2418,14 @@ static int rtl8139_set_settings(struct n
 static int rtl8139_nway_reset(struct net_device *dev)
 {
 	struct rtl8139_private *np = dev->priv;
+	RTL8139_DUMP(dev);
 	return mii_nway_restart(&np->mii);
 }
 
 static u32 rtl8139_get_link(struct net_device *dev)
 {
 	struct rtl8139_private *np = dev->priv;
+	RTL8139_DUMP(dev);
 	return mii_link_ok(&np->mii);
 }
 
@@ -2409,6 +2459,7 @@ static void rtl8139_get_regs(struct net_
 	regs->version = RTL_REGS_VER;
 
 	spin_lock_irq(&np->lock);
+	RTL8139_DUMP(dev);
 	memcpy_fromio(regbuf, np->mmio_addr, regs->len);
 	spin_unlock_irq(&np->lock);
 }
@@ -2554,6 +2605,10 @@ static int rtl8139_suspend (struct pci_d
 	void *ioaddr = tp->mmio_addr;
 	unsigned long flags;
 
+	spin_lock_irqsave (&tp->lock, flags);
+	RTL8139_DUMP(dev);
+	spin_unlock_irqrestore (&tp->lock, flags);
+
 	if (!netif_running (dev))
 		return 0;
 
@@ -2583,6 +2638,7 @@ static int rtl8139_resume (struct pci_de
 	struct net_device *dev = pci_get_drvdata (pdev);
 	struct rtl8139_private *tp = dev->priv;
 
+	RTL8139_DUMP(dev);
 	if (!netif_running (dev))
 		return 0;
 	pci_restore_state (pdev, tp->pci_state);

_

--=-=-=--
