Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTIVTmG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263090AbTIVTmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:42:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:41691 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263056AbTIVTmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:42:01 -0400
Date: Mon, 22 Sep 2003 12:22:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: khc@pm.waw.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5-mm4: wanxl doesn't compile with gcc 2.95
Message-Id: <20030922122215.4f7da13e.akpm@osdl.org>
In-Reply-To: <20030922191049.GC6325@fs.tum.de>
References: <20030922013548.6e5a5dcf.akpm@osdl.org>
	<20030922191049.GC6325@fs.tum.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> I'm getting the following compile error with gcc 2.95:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/net/wan/wanxl.o
> drivers/net/wan/wanxl.c: In function `pci_map_single_debug':
> drivers/net/wan/wanxl.c:128: warning: unsigned int format, different type arg (arg 3)
> drivers/net/wan/wanxl.c: In function `wanxl_tx_intr':
> drivers/net/wan/wanxl.c:185: parse error before `struct'


 25-akpm/drivers/net/wan/wanxl.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff -puN drivers/net/wan/wanxl.c~wanxl-build-fix drivers/net/wan/wanxl.c
--- 25/drivers/net/wan/wanxl.c~wanxl-build-fix	Mon Sep 22 12:18:36 2003
+++ 25-akpm/drivers/net/wan/wanxl.c	Mon Sep 22 12:21:30 2003
@@ -125,7 +125,8 @@ static inline dma_addr_t pci_map_single_
 	dma_addr_t addr = pci_map_single(pdev, ptr, size, direction);
 	if (addr + size > 0x100000000LL)
 		printk(KERN_CRIT "wanXL %s: pci_map_single() returned memory"
-		       " at 0x%X!\n", card_name(pdev), addr);
+			" at 0x%LX!\n",
+			card_name(pdev), (unsigned long long)addr);
 	return addr;
 }
 
@@ -180,8 +181,7 @@ static inline void wanxl_cable_intr(port
 static inline void wanxl_tx_intr(port_t *port)
 {
 	while (1) {
-                desc_t *desc;
-		desc = &get_status(port)->tx_descs[port->tx_in];
+                desc_t *desc = &get_status(port)->tx_descs[port->tx_in];
 		struct sk_buff *skb = port->tx_skbs[port->tx_in];
 
 		switch (desc->stat) {
@@ -290,12 +290,13 @@ static irqreturn_t wanxl_intr(int irq, v
 
 static int wanxl_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	desc_t *desc;
 	hdlc_device *hdlc = dev_to_hdlc(dev);
         port_t *port = hdlc_to_port(hdlc);
 
         spin_lock(&port->lock);
 
-	desc_t *desc = &get_status(port)->tx_descs[port->tx_out];
+	desc = &get_status(port)->tx_descs[port->tx_out];
         if (desc->stat != PACKET_EMPTY) {
                 /* should never happen - previous xmit should stop queue */
 #ifdef DEBUG_PKT

_

