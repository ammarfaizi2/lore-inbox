Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVEXWKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVEXWKu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVEXWKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:10:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43251 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262202AbVEXWKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:10:40 -0400
Date: Tue, 24 May 2005 18:10:38 -0400
From: "George G. Davis" <gdavis@mvista.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] net: Add netconsole support to cs89x0 driver
Message-ID: <20050524221038.GR438@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I've compile tested this on linux-2.6.12-rc4-git8 and tested kgdboe on
"Some Random (ARM) V6 Processor" using a linux-2.6.10 based kernel. Please
apply. TIA!

--
Regards,
George

Add netconsole support to cs89x0 driver

Signed-off-by: George G. Davis <gdavis@mvista.com>

 cs89x0.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+)

Index: linux-2.6.12-rc4-git8/drivers/net/cs89x0.c
===================================================================
--- linux-2.6.12-rc4-git8.orig/drivers/net/cs89x0.c
+++ linux-2.6.12-rc4-git8/drivers/net/cs89x0.c
@@ -404,6 +404,19 @@
 	return -1;
 }
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+/*
+ * Polling receive - used by netconsole and other diagnostic tools
+ * to allow network i/o with interrupts disabled.
+ */
+static void cs89x0_poll_controller(struct net_device *dev)
+{
+	disable_irq(dev->irq);
+	net_interrupt(dev->irq, dev, NULL);
+	enable_irq(dev->irq);
+}
+#endif
+
 /* This is the real probe routine.  Linux has a history of friendly device
    probes on the ISA bus.  A good device probes avoids doing writes, and
    verifies that the correct device exists and functions.
@@ -731,6 +744,9 @@
 	dev->get_stats		= net_get_stats;
 	dev->set_multicast_list = set_multicast_list;
 	dev->set_mac_address 	= set_mac_address;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller	= cs89x0_poll_controller;
+#endif
 
 	printk("\n");
 	if (net_debug)
