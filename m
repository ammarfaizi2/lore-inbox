Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbTHZU5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbTHZU5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:57:52 -0400
Received: from smtp4.hy.skanova.net ([195.67.199.133]:63972 "EHLO
	smtp4.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261918AbTHZU5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:57:50 -0400
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Netconsole debugging tool for 2.6
References: <20030811085508.GH31810@waste.org>
From: Peter Osterlund <petero2@telia.com>
Date: 26 Aug 2003 22:57:28 +0200
In-Reply-To: <20030811085508.GH31810@waste.org>
Message-ID: <m2vfsk16iv.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> I've decided to take a stab at resurrecting Ingo's netconsole patch.
> 
> For those who missed it the first time around (for 2.4.10), this
> module is a "serial console over networks" which lets you catch kernel
> messages, oopses and so on that can't be caught by syslog.
...
> I've also added support for a third NIC (TLAN). Accepting patches for
> other cards (only about 10 lines of code each).

It works fine on my computer with the patch below. The only problem is
that it taints the kernel because of missing module license information.

Netconsole support for the 8139too NIC.


 linux-petero/Documentation/networking/netlogging.txt |    1 
 linux-petero/drivers/net/8139too.c                   |   22 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff -puN Documentation/networking/netlogging.txt~netconsole-8139too Documentation/networking/netlogging.txt
--- linux/Documentation/networking/netlogging.txt~netconsole-8139too	2003-08-26 22:21:43.000000000 +0200
+++ linux-petero/Documentation/networking/netlogging.txt	2003-08-26 22:21:43.000000000 +0200
@@ -52,3 +52,4 @@ Currently supported network drivers:
  eepro100
  tulip
  tlan
+ 8139too
diff -puN drivers/net/8139too.c~netconsole-8139too drivers/net/8139too.c
--- linux/drivers/net/8139too.c~netconsole-8139too	2003-08-26 22:22:06.000000000 +0200
+++ linux-petero/drivers/net/8139too.c	2003-08-26 22:26:46.000000000 +0200
@@ -625,6 +625,7 @@ static struct net_device_stats *rtl8139_
 static void rtl8139_set_rx_mode (struct net_device *dev);
 static void __set_rx_mode (struct net_device *dev);
 static void rtl8139_hw_start (struct net_device *dev);
+static void poll_8139 (struct net_device *dev);
 
 #ifdef USE_IO_OPS
 
@@ -973,6 +974,9 @@ static int __devinit rtl8139_init_one (s
 	dev->do_ioctl = netdev_ioctl;
 	dev->tx_timeout = rtl8139_tx_timeout;
 	dev->watchdog_timeo = TX_TIMEOUT;
+#ifdef HAVE_POLL_CONTROLLER
+	dev->poll_controller = &poll_8139;
+#endif
 
 	/* note: the hardware is not capable of sg/csum/highdma, however
 	 * through the use of skb_copy_and_csum_dev we enable these
@@ -2596,6 +2600,24 @@ static int rtl8139_resume (struct pci_de
 
 #endif /* CONFIG_PM */
 
+#ifdef HAVE_POLL_CONTROLLER
+
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+
+static void poll_8139 (struct net_device *dev)
+{
+       disable_irq(dev->irq);
+       rtl8139_interrupt (dev->irq, dev, NULL);
+       enable_irq(dev->irq);
+}
+
+#endif
+
+
 
 static struct pci_driver rtl8139_pci_driver = {
 	.name		= DRV_NAME,

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
