Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTIVWpr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 18:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbTIVWpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 18:45:47 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:13718 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261932AbTIVWpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 18:45:41 -0400
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5-mm4: wanxl doesn't compile with gcc 2.95
References: <20030922013548.6e5a5dcf.akpm@osdl.org>
	<20030922191049.GC6325@fs.tum.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 23 Sep 2003 00:42:03 +0200
In-Reply-To: <20030922191049.GC6325@fs.tum.de>
Message-ID: <m3fzioigxw.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

Adrian Bunk <bunk@fs.tum.de> writes:

> make[3]: *** [drivers/net/wan/wanxl.o] Error 1
> 
> <--  snip  -->
> 
> For gcc 2.95, all variable declarations must be at the beginning.

Sure, though it seems I keep overlooking things like this.

Does the following patch fix it?
Thanks.
-- 
Krzysztof Halasa, B*FH

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=wanxl-2.6-0.46-0.47.patch

--- linux-2.6.orig/drivers/net/wan/wanxl.c	2003-09-23 00:18:19.000000000 +0200
+++ linux-2.6/drivers/net/wan/wanxl.c	2003-09-23 00:33:34.000000000 +0200
@@ -31,7 +31,7 @@
 
 #include "wanxl.h"
 
-static const char* version = "wanXL serial card driver version: 0.46";
+static const char* version = "wanXL serial card driver version: 0.47";
 
 #define PLX_CTL_RESET   0x40000000 /* adapter reset */
 
@@ -125,7 +125,7 @@
 	dma_addr_t addr = pci_map_single(pdev, ptr, size, direction);
 	if (addr + size > 0x100000000LL)
 		printk(KERN_CRIT "wanXL %s: pci_map_single() returned memory"
-		       " at 0x%X!\n", card_name(pdev), addr);
+		       " at 0x%LX!\n", card_name(pdev), (u64)addr);
 	return addr;
 }
 
@@ -180,8 +180,7 @@
 static inline void wanxl_tx_intr(port_t *port)
 {
 	while (1) {
-                desc_t *desc;
-		desc = &get_status(port)->tx_descs[port->tx_in];
+                desc_t *desc = &get_status(port)->tx_descs[port->tx_in];
 		struct sk_buff *skb = port->tx_skbs[port->tx_in];
 
 		switch (desc->stat) {
@@ -292,10 +291,11 @@
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
         port_t *port = hdlc_to_port(hdlc);
+	desc_t *desc;
 
         spin_lock(&port->lock);
 
-	desc_t *desc = &get_status(port)->tx_descs[port->tx_out];
+	desc = &get_status(port)->tx_descs[port->tx_out];
         if (desc->stat != PACKET_EMPTY) {
                 /* should never happen - previous xmit should stop queue */
 #ifdef DEBUG_PKT
@@ -578,6 +578,14 @@
 	u8 *mem;		/* memory virtual base addr */
 	int i, ports, alloc_size;
 
+#ifndef MODULE
+	static int printed_version;
+	if (!printed_version) {
+		printed_version++;
+		printk(KERN_INFO "%s\n", version);
+	}
+#endif
+
 	i = pci_enable_device(pdev);
 	if (i)
 		return i;
@@ -628,7 +636,7 @@
 
 #ifdef DEBUG_PCI
 	printk(KERN_DEBUG "wanXL %s: pci_alloc_consistent() returned memory"
-	       " at 0x%X\n", card_name(pdev), card->status_address);
+	       " at 0x%LX\n", card_name(pdev), (u64)card->status_address);
 #endif
 
 	/* FIXME when PCI/DMA subsystems are fixed.

--=-=-=--
