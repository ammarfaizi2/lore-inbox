Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTI1UoQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 16:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbTI1UoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 16:44:16 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:29205 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S262720AbTI1UoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 16:44:14 -0400
Date: Sun, 28 Sep 2003 14:55:23 +0200
Message-Id: <200309281255.h8SCtNJg005528@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 309] Macintosh 8390 Ethernet update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac8390: Update for netdevice/8390 core changes in 2.5.8

--- linux-2.6.0-test6/drivers/net/mac8390.c	Tue Jul 29 18:18:58 2003
+++ linux-m68k-2.6.0-test6/drivers/net/mac8390.c	Fri Sep 19 14:21:17 2003
@@ -442,14 +442,14 @@
                ei_status.tx_start_page = CABLETRON_TX_START_PG;
                ei_status.rx_start_page = CABLETRON_RX_START_PG;
                ei_status.stop_page = CABLETRON_RX_STOP_PG;
-               dev->rmem_start = dev->mem_start;
-               dev->rmem_end = dev->mem_start + CABLETRON_RX_STOP_PG*256;
+               ei_status.rmem_start = dev->mem_start;
+               ei_status.rmem_end = dev->mem_start + CABLETRON_RX_STOP_PG*256;
 	} else {
                ei_status.tx_start_page = WD_START_PG;
                ei_status.rx_start_page = WD_START_PG + TX_PAGES;
                ei_status.stop_page = (dev->mem_end - dev->mem_start)/256;
-               dev->rmem_start = dev->mem_start + TX_PAGES*256;
-               dev->rmem_end = dev->mem_end;
+               ei_status.rmem_start = dev->mem_start + TX_PAGES*256;
+               ei_status.rmem_end = dev->mem_end;
 	}
 	
 	/* Fill in model-specific information and functions */
@@ -621,12 +621,12 @@
 	unsigned long xfer_base = ring_offset - (WD_START_PG<<8);
 	unsigned long xfer_start = xfer_base + dev->mem_start;
 
-	if (xfer_start + count > dev->rmem_end) {
+	if (xfer_start + count > ei_status.rmem_end) {
 		/* We must wrap the input move. */
-		int semi_count = dev->rmem_end - xfer_start;
+		int semi_count = ei_status.rmem_end - xfer_start;
 		memcpy_fromio(skb->data, (char *)dev->mem_start + xfer_base, semi_count);
 		count -= semi_count;
-		memcpy_toio(skb->data + semi_count, (char *)dev->rmem_start, count);
+		memcpy_toio(skb->data + semi_count, (char *)ei_status.rmem_start, count);
 	} else {
 		memcpy_fromio(skb->data, (char *)dev->mem_start + xfer_base, count);
 	}
@@ -657,15 +657,16 @@
 
 	/* Note the offset math is done in card memory space which is word
 	   per long onto our space. */
-	 
-	if (xfer_start + count > dev->rmem_end) 
+
+	if (xfer_start + count > ei_status.rmem_end)
 	{
 		/* We must wrap the input move. */
-		int semi_count = dev->rmem_end - xfer_start;
+		int semi_count = ei_status.rmem_end - xfer_start;
 		dayna_memcpy_fromcard(dev, skb->data, xfer_base, semi_count);
 		count -= semi_count;
-		dayna_memcpy_fromcard(dev, skb->data + semi_count, 
-			dev->rmem_start - dev->mem_start, count);
+		dayna_memcpy_fromcard(dev, skb->data + semi_count,
+				      ei_status.rmem_start - dev->mem_start,
+				      count);
 	}
 	else
 	{
@@ -697,15 +698,15 @@
 	unsigned long xfer_base = ring_offset - (WD_START_PG<<8);
 	unsigned long xfer_start = xfer_base+dev->mem_start;
 
-	if (xfer_start + count > dev->rmem_end)
+	if (xfer_start + count > ei_status.rmem_end)
 	{
 		/* We must wrap the input move. */
-		int semi_count = dev->rmem_end - xfer_start;
+		int semi_count = ei_status.rmem_end - xfer_start;
 		word_memcpy_fromcard(skb->data, (char *)dev->mem_start +
 			xfer_base, semi_count);
 		count -= semi_count;
 		word_memcpy_fromcard(skb->data + semi_count,
-			(char *)dev->rmem_start, count);
+				     (char *)ei_status.rmem_start, count);
 	}
 	else
 	{

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
