Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUCPLlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 06:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbUCPLlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 06:41:21 -0500
Received: from news.indigo-avs.com ([194.200.210.131]:58527 "EHLO
	oban.indigo-avs.com") by vger.kernel.org with ESMTP id S261453AbUCPLlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 06:41:18 -0500
Date: Tue, 16 Mar 2004 11:41:10 +0000
From: Yves Rutschle <y.rutschle@indigovision.com>
To: "Andrey V. Savochkin" <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] eepro100.c alignment
Message-ID: <20040316114110.GA32157@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Two small changes to the eepro100 driver; the first one uses
the proper rx_align function instead of aligning by hand, so
one can change the alignment of packets consistently
throughout the driver in one place only.

The second is more questionable: rx_align in 2.6.4 seems to
deliberately align everything on half-words, at least on
ARM. Ideally I gues we'd want to detect the best alignment
value to use.

Cheers,
Y.
PS. CC me to answers, I'm not subscribed to lkml.


--- linux-2.6.2.orig/drivers/net/eepro100.c     Wed Feb  4 03:44:04 2004
+++ linux-2.6.4/drivers/net/eepro100.c  Mon Mar 15 15:46:37 2004
@@ -1828,7 +1857,7 @@ speedo_rx(struct net_device *dev)
                        if (pkt_len < rx_copybreak
                                && (skb = dev_alloc_skb(pkt_len + 2)) != 0) {
                                skb->dev = dev;
-                               skb_reserve(skb, 2);    /* Align IP on 16 byte boundaries */
+                               rx_align(skb);  /* Align IP on 16 byte boundaries */
                                /* 'skb_put()' points to the start of sk_buff data area. */
                                pci_dma_sync_single(sp->pdev, sp->rx_ring_dma[entry],
                                        sizeof(struct RxFD) + pkt_len, PCI_DMA_FROMDEVICE);


--- linux-2.6.2.orig/drivers/net/eepro100.c     Wed Feb  4 03:44:04 2004
+++ linux-2.6.4/drivers/net/eepro100.c  Mon Mar 15 15:46:37 2004
@@ -44,7 +44,7 @@ static int rxdmacount /* = 0 */;
 #if defined(__ia64__) || defined(__alpha__) || defined(__sparc__) || defined(__mips__) || \
        defined(__arm__)
   /* align rx buffers to 2 bytes so that IP header is aligned */
-# define rx_align(skb)         skb_reserve((skb), 2)
+# define rx_align(skb)         skb_reserve((skb), 0)
 # define RxFD_ALIGNMENT                __attribute__ ((aligned (2), packed))
 #else
 # define rx_align(skb)

