Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263961AbTH1Min (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 08:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbTH1Min
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 08:38:43 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:41624 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S263961AbTH1Mil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 08:38:41 -0400
Date: Thu, 28 Aug 2003 14:38:37 +0200
From: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Netconsole debugging tool for 2.6
Message-ID: <20030828123837.GA6933@gareth.mathematik.tu-chemnitz.de>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030811085508.GH31810@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811085508.GH31810@waste.org>
User-Agent: Mutt/1.4.1i
X-Spam-Score: -4.5 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19sM2y-0002XY-00*GaKFcryVgP2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 03:55:08AM -0500 or thereabouts, Matt Mackall wrote:
...
> I've also added support for a third NIC (TLAN). Accepting patches for
> other cards (only about 10 lines of code each).
...


With the patch below netconsole works with the ne2k-pci driver.
The patch applies on 2.6.0-test4.
Tested with my RealTek RTL-8029 card.

Are you interested on code cleanup patches etc. for netconsole too?


Steffen


--- vanilla-2.6.0-test4/drivers/net/ne2k-pci.c	Fri Aug 22 23:53:07 2003
+++ linux-2.6.0-test4-sk/drivers/net/ne2k-pci.c	Sat Aug 23 11:04:36 2003
@@ -167,6 +167,7 @@ MODULE_DEVICE_TABLE(pci, ne2k_pci_tbl);
 static int ne2k_pci_open(struct net_device *dev);
 static int ne2k_pci_close(struct net_device *dev);
 
+static void poll_ne2k_pci(struct net_device *dev);
 static void ne2k_pci_reset_8390(struct net_device *dev);
 static void ne2k_pci_get_8390_hdr(struct net_device *dev, struct e8390_pkt_hdr *hdr,
 			  int ring_page);
@@ -362,6 +363,10 @@ static int __devinit ne2k_pci_init_one (
 	dev->open = &ne2k_pci_open;
 	dev->stop = &ne2k_pci_close;
 	dev->do_ioctl = &netdev_ioctl;
+#ifdef HAVE_POLL_CONTROLLER
+	dev->poll_controller = &poll_ne2k_pci;
+#endif
+
 	NS8390_init(dev, 0);
 
 	i = register_netdev(dev);
@@ -436,6 +441,23 @@ static void ne2k_pci_reset_8390(struct n
 		}
 	outb(ENISR_RESET, NE_BASE + EN0_ISR);	/* Ack intr. */
 }
+
+#ifdef HAVE_POLL_CONTROLLER
+
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+
+static void poll_ne2k_pci (struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	ei_interrupt (dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+
+#endif
 
 /* Grab the 8390 specific header. Similar to the block_input routine, but
    we don't need to be concerned with ring wrap as the header will be at
