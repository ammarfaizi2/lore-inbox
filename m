Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTJFVQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 17:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTJFVQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 17:16:13 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:17619 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261758AbTJFVQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 17:16:09 -0400
From: Thomas Elsen <rivy@rivy.org>
To: rjwalsh@durables.org, wangdi@clusterfs.com, akpm@osdl.org
Subject: [PATCH][2.6-test6-mm4]8139too poll controller
Date: Mon, 6 Oct 2003 23:15:58 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310062315.58397.rivy@rivy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds poll-controller functionality to the 8139too driver. It has 
been tested with kgdb-over-ethernet.

Thomas


--- 8139too.c.orig	2003-10-06 22:56:03.000000000 +0200
+++ 8139too.c	2003-10-06 22:48:08.000000000 +0200
@@ -618,6 +618,10 @@
 static void rtl8139_hw_start (struct net_device *dev);
 static struct ethtool_ops rtl8139_ethtool_ops;

+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void rtl8139_rx_poll (struct net_device *dev);
+#endif
+
 #ifdef USE_IO_OPS

 #define RTL_R8(reg)		inb (((unsigned long)ioaddr) + (reg))
@@ -970,6 +974,10 @@
 	dev->tx_timeout = rtl8139_tx_timeout;
 	dev->watchdog_timeo = TX_TIMEOUT;

+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = rtl8139_rx_poll;
+#endif
+
 	/* note: the hardware is not capable of sg/csum/highdma, however
 	 * through the use of skb_copy_and_csum_dev we enable these
 	 * features
@@ -2388,6 +2396,15 @@
 	return &tp->stats;
 }

+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void rtl8139_rx_poll (struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	rtl8139_interrupt(dev->irq, (void *)dev, 0);
+	enable_irq(dev->irq);
+}
+#endif
+
 /* Set or clear the multicast filter for this adaptor.
    This routine is not state sensitive and need not be SMP locked. */
 

