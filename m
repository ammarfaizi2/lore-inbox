Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVKZJW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVKZJW7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 04:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVKZJW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 04:22:59 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:45105 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750728AbVKZJW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 04:22:58 -0500
Message-ID: <438829AF.8060101@sw.ru>
Date: Sat, 26 Nov 2005 12:23:59 +0300
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
CC: Konstantin Khorenko <khorenko@sw.ru>, netdev@oss.sgi.com,
       Daniele Venzano <venza@brownhat.org>
Subject: [PATCH 2.4] sis900: come alive after temporary memory shortage
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030704030101010201050307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030704030101010201050307
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Marcelo,

I would like to inform you that unfortunately the committed patch is wrong
http://www.kernel.org/git/?p=linux/kernel/git/marcelo/linux-2.4.git;a=commit;h=ecf3337f76eaa94c5a771308d184dc248b74b725

+	int rx_work_limit =
+		(sis_priv->dirty_rx - sis_priv->cur_rx) % NUM_RX_DESC;

when dirty_rx = cur_rx it computes limit=0, but should be NUM_RX_DESC

Could you please drop the wrong patch and use a new one based on the version
approved by Daniele Venzano and Jeff Garzik
http://www.kernel.org/git/?p=linux/kernel/git/jgarzik/netdev-2.6.git;a=commitdiff_plain;h=7380a78a973a8109c13cb0e47617c456b6f6e1f5;hp=b2795f596932286ef12dc08857960d654f577405

Thank you,
	Vasily Averin
SWSoft Linux kernel Team

  sis900: come alive after temporary memory shortage

  1) Forgotten counter incrementation in sis900_rx() in case
       it doesn't get memory for skb, that leads to whole interface failure.
       Problem is accompanied with messages:
      eth0: Memory squeeze,deferring packet.
      eth0: NULL pointer encountered in Rx ring, skipping

  2) If counter cur_rx overflows and there'll be temporary memory problems
       buffer can't be recreated later, when memory IS available.

  3) Limit the work in handler to prevent the endless packets processing
     if new packets are generated faster then handled.

  Signed-off-by: Konstantin Khorenko <khorenko@sw.ru>
  Signed-off-by: Vasily Averin <vvs@sw.ru>
---

--------------030704030101010201050307
Content-Type: text/plain;
 name="diff-drv-sis900-20051126"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-drv-sis900-20051126"

--- a/drivers/net/sis900.c	2005-11-26 10:54:33.000000000 +0300
+++ b/drivers/net/sis900.c	2005-11-26 11:30:17.000000000 +0300
@@ -1613,15 +1613,20 @@ static int sis900_rx(struct net_device *
 	long ioaddr = net_dev->base_addr;
 	unsigned int entry = sis_priv->cur_rx % NUM_RX_DESC;
 	u32 rx_status = sis_priv->rx_ring[entry].cmdsts;
+	int rx_work_limit;
 
 	if (sis900_debug > 3)
 		printk(KERN_INFO "sis900_rx, cur_rx:%4.4d, dirty_rx:%4.4d "
 		       "status:0x%8.8x\n",
 		       sis_priv->cur_rx, sis_priv->dirty_rx, rx_status);
+	rx_work_limit = sis_priv->dirty_rx + NUM_RX_DESC - sis_priv->cur_rx;
 
 	while (rx_status & OWN) {
 		unsigned int rx_size;
 
+		if (--rx_work_limit < 0)
+			break;
+
 		rx_size = (rx_status & DSIZE) - CRC_SIZE;
 
 		if (rx_status & (ABORT|OVERRUN|TOOLONG|RUNT|RXISERR|CRCERR|FAERR)) {
@@ -1648,9 +1653,11 @@ static int sis900_rx(struct net_device *
 			   some unknow bugs, it is possible that
 			   we are working on NULL sk_buff :-( */
 			if (sis_priv->rx_skbuff[entry] == NULL) {
-				printk(KERN_INFO "%s: NULL pointer " 
-				       "encountered in Rx ring, skipping\n",
-				       net_dev->name);
+				printk(KERN_WARNING "%s: NULL pointer "
+					"encountered in Rx ring\n"
+					"cur_rx:%4.4d, dirty_rx:%4.4d\n",
+					net_dev->name, sis_priv->cur_rx,
+					sis_priv->dirty_rx);
 				break;
 			}
 
@@ -1688,6 +1695,7 @@ static int sis900_rx(struct net_device *
 				sis_priv->rx_ring[entry].cmdsts = 0;
 				sis_priv->rx_ring[entry].bufptr = 0;
 				sis_priv->stats.rx_dropped++;
+				sis_priv->cur_rx++;
 				break;
 			}
 			skb->dev = net_dev;
@@ -1705,7 +1713,7 @@ static int sis900_rx(struct net_device *
 
 	/* refill the Rx buffer, what if the rate of refilling is slower than 
 	   consuming ?? */
-	for (;sis_priv->cur_rx - sis_priv->dirty_rx > 0; sis_priv->dirty_rx++) {
+	for (; sis_priv->cur_rx != sis_priv->dirty_rx; sis_priv->dirty_rx++) {
 		struct sk_buff *skb;
 
 		entry = sis_priv->dirty_rx % NUM_RX_DESC;

--------------030704030101010201050307--
