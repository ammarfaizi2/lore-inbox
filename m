Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVBWVB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVBWVB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVBWVBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:01:55 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:2715 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261577AbVBWVAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:00:15 -0500
Date: Wed, 23 Feb 2005 21:58:53 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jdmason@us.ibm.com,
       rich@phekda.gotadsl.co.uk, jgarzik@pobox.com
Subject: [patch 2.6.11-rc4-mm1 1/2] r8169: IRQ races during change of mtu
Message-ID: <20050223205853.GA30109@electric-eye.fr.zoreil.com>
References: <20050222234810.GA17303@electric-eye.fr.zoreil.com> <20050222172935.30e43270.akpm@osdl.org> <20050223085921.GA22268@electric-eye.fr.zoreil.com> <20050223010948.6f2aa542.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223010948.6f2aa542.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ races during change of mtu
- NAPI poll must be enabled prior to IRQ activation or the IRQ handler
  will not know what to do with an incoming packet;
- rtl8169_down() needs to try twice to sync with the IRQ handler when
  it is not issued under !netif_running() protection.

Both changes make it safe to request a change of mtu on a live device.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN drivers/net/r8169.c~r8169-450 drivers/net/r8169.c
--- a/drivers/net/r8169.c~r8169-450	2005-02-23 21:35:21.112521942 +0100
+++ b/drivers/net/r8169.c	2005-02-23 21:35:21.117521120 +0100
@@ -1648,10 +1648,10 @@ static int rtl8169_change_mtu(struct net
 	if (ret < 0)
 		goto out;
 
-	rtl8169_hw_start(dev);
-
 	netif_poll_enable(dev);
 
+	rtl8169_hw_start(dev);
+
 	rtl8169_request_timer(dev);
 
 out:
@@ -2352,6 +2352,7 @@ static void rtl8169_down(struct net_devi
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
 	void __iomem *ioaddr = tp->mmio_addr;
+	unsigned int poll_locked = 0;
 
 	rtl8169_delete_timer(dev);
 
@@ -2359,6 +2360,7 @@ static void rtl8169_down(struct net_devi
 
 	flush_scheduled_work();
 
+core_down:
 	spin_lock_irq(&tp->lock);
 
 	/* Stop the chip's Tx and Rx DMA processes. */
@@ -2375,11 +2377,28 @@ static void rtl8169_down(struct net_devi
 
 	synchronize_irq(dev->irq);
 
-	netif_poll_disable(dev);
+	if (!poll_locked) {
+		netif_poll_disable(dev);
+		poll_locked++;
+	}
 
 	/* Give a racing hard_start_xmit a few cycles to complete. */
 	synchronize_kernel();
 
+	/*
+	 * And now for the 50k$ question: are IRQ disabled or not ?
+	 *
+	 * Two paths lead here:
+	 * 1) dev->close
+	 *    -> netif_running() is available to sync the current code and the
+	 *       IRQ handler. See rtl8169_interrupt for details.
+	 * 2) dev->change_mtu
+	 *    -> rtl8169_poll can not be issued again and re-enable the
+	 *       interruptions. Let's simply issue the IRQ down sequence again.
+	 */
+	if (RTL_R16(IntrMask))
+		goto core_down;
+
 	rtl8169_tx_clear(tp);
 
 	rtl8169_rx_clear(tp);

_
