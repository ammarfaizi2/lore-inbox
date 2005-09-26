Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751585AbVIZMRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbVIZMRc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbVIZMRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:17:32 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:49241 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751508AbVIZMRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:17:31 -0400
Message-ID: <4337E76B.1090003@sw.ru>
Date: Mon, 26 Sep 2005 16:19:55 +0400
From: Konstantin Khorenko <khorenko@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniele Venzano <webvenza@libero.it>
CC: Vasily Averin <vvs@sw.ru>, Stanislav Protassov <st@sw.com.sg>,
       Ollie Lho <ollie@sis.com.tw>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [patch netdrvr sis900] net: come alive after temporary memory shortage
Content-Type: multipart/mixed;
 boundary="------------050703040908030103060204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050703040908030103060204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Patch solves following problems:
1) Forgotten counter incrementation in sis900_rx() in case
     it doesn't get memory for skb, that leads to whole interface failure.
     Problem is accompanied with messages:
    eth0: Memory squeeze,deferring packet.
    eth0: NULL pointer encountered in Rx ring, skipping
2) If counter cur_rx overflows and there'll be temporary memory problems
     buffer can't be recreated later, when memory IS avaliable.
3) Limit the work in handler to prevent the endless packets processing if
     new packets are generated faster then handled.

Signed-off-by: Konstantin Khorenko <khorenko@sw.ru>
Signed-off-by: Vasily Averin <vvs@sw.ru>

-----------------------------------

We had a customer that complains about the problem with network card
that is supported by sis900 driver.
Problem description: at random time card suddenly stops working and only
reboot makes it back to work.
Non-working is accomplished with massages in /var/log/messages:
    eth0: Memory squeeze,deferring packet.
    eth0: NULL pointer encountered in Rx ring, skipping
    eth0: NULL pointer encountered in Rx ring, skipping
    eth0: NULL pointer encountered in Rx ring, skipping
(till reboot)

We discover that his problem is already known:
http://www.ussg.iu.edu/hypermail/linux/kernel/0407.3/0566.html
http://www.kernelnewbies.org/documents/kdoc/sis900/problems.html

Nevertheless it isn't fixed till now, so we tried to fix.

(1) Function sis900_rx().
During normal execution dirty_rx < cur_rx is ALWAYS true.
Let's assume, we are short of memory.

	unsigned int entry = sis_priv->cur_rx % NUM_RX_DESC;
	...
	while (rx_status & OWN) {
		...
		if (some error check) {
			...
		} else {
5. Next func call, after previous one we have rx_skbuff[cur_rx%] == NULL,
      which means rx_skbuff[entry] == NULL

			if (sis_priv->rx_skbuff[entry] == NULL) {
				printk(KERN_INFO "%s: NULL pointer "
					"encountered in Rx ring, skipping\n",
					net_dev->name);
6. Print and exit while() loop.
				break;
			 }
			...
1. fail here. -->	if ((skb = dev_alloc_skb(RX_BUF_SIZE)) == NULL) {
				...
				printk(KERN_INFO "%s: Memory squeeze,"
				       "deferring packet.\n",
				       net_dev->name);
-->				sis_priv->rx_skbuff[entry] = NULL;
2. now sis_priv->rx_skbuff[cur_rx%] == NULL
				...
				break;
3. and we are exiting while () not incrementing cur_rx!
			}
			...
		} // of else
		sis_priv->cur_rx++;
		entry = sis_priv->cur_rx % NUM_RX_DESC;
		...
	} //of while

4. we refill all buffers rx_skbuff[entry], where entry < cur_rx.
      rx_skbuff[cur_rx%] == NULL before and AFTER loop

	for (; sis_priv->cur_rx > sis_priv->dirty_rx; sis_priv->dirty_rx++) {
		entry = sis_priv->dirty_rx % NUM_RX_DESC;
		if (sis_priv->rx_skbuff[entry] == NULL) {
			...
			sis_priv->rx_skbuff[entry] = skb;
			...
		}
	}

No matter how many times func is called cur_rx won't be incremented, and
thus
rx_skbuff[cur_rx%] will be NULL forever, which results neverending
printings and packets drops.
------

(2) The same function sis900_rx().

	for (; sis_priv->cur_rx > sis_priv->dirty_rx; sis_priv->dirty_rx++) {
		entry = sis_priv->dirty_rx % NUM_RX_DESC;
		if (sis_priv->rx_skbuff[entry] == NULL) {
			...skb = dev_alloc_skb(RX_BUF_SIZE)...
			...
			sis_priv->rx_skbuff[entry] = skb;
			...
		}
	}

Assume cur_rx is overflowed in previous while() loop execution, but
dirty_rx is NOT and we really need buffer refilling.
Comparison sis_priv->cur_rx > sis_priv->dirty_rx will fail and buffers
won't be refilled.
----------

(3) The same function sis900_rx().
Assume whole buffer is filled, there is no memory shortage problem and
network card receives packets faster then kernel process them in this
sis900_rx() function in while (rx_status & OWN) loop - execution control
won't leave the loop.
sis900_rx() is called in interrupt handler, it's not good idea to `do
"too much" work here` (sentence from sources :) )

----------
Hope, you'll check this changes and find them usefull. :)
Kernels with patches compile but untested.
This patch is against mainstream 2.6.13.1 kernel.

-- 
Best regards,

Konstantin Khorenko,
SWsoft, Inc.


--------------050703040908030103060204
Content-Type: text/plain;
 name="diff-sis900-2.6.13.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-sis900-2.6.13.1"

--- ./drivers/net/sis900.c.sis900	2005-08-29 03:41:01.000000000 +0400
+++ ./drivers/net/sis900.c	2005-09-19 14:34:42.000000000 +0400
@@ -1696,6 +1696,14 @@ static int sis900_rx(struct net_device *
 	long ioaddr = net_dev->base_addr;
 	unsigned int entry = sis_priv->cur_rx % NUM_RX_DESC;
 	u32 rx_status = sis_priv->rx_ring[entry].cmdsts;
+	/*
+	 * If cur > dirty, then limit = NUM_RX_DESC - cur + dirty =
+	 *				NUM_RX_DESC + (dirty - cur)
+	 * If cur < dirty (cur overflowed, dirty - not), then
+	 *			limit = dirty - cur
+	 */
+	int rx_work_limit =
+		(sis_priv->dirty_rx - sis_priv->cur_rx) % NUM_RX_DESC;
 
 	if (netif_msg_rx_status(sis_priv))
 		printk(KERN_DEBUG "sis900_rx, cur_rx:%4.4d, dirty_rx:%4.4d "
@@ -1705,6 +1713,8 @@ static int sis900_rx(struct net_device *
 	while (rx_status & OWN) {
 		unsigned int rx_size;
 
+		if (--rx_work_limit < 0)
+			break;
 		rx_size = (rx_status & DSIZE) - CRC_SIZE;
 
 		if (rx_status & (ABORT|OVERRUN|TOOLONG|RUNT|RXISERR|CRCERR|FAERR)) {
@@ -1770,6 +1780,7 @@ static int sis900_rx(struct net_device *
 				sis_priv->rx_ring[entry].cmdsts = 0;
 				sis_priv->rx_ring[entry].bufptr = 0;
 				sis_priv->stats.rx_dropped++;
+				sis_priv->cur_rx++;
 				break;
 			}
 			skb->dev = net_dev;
@@ -1787,7 +1798,7 @@ static int sis900_rx(struct net_device *
 
 	/* refill the Rx buffer, what if the rate of refilling is slower
 	 * than consuming ?? */
-	for (;sis_priv->cur_rx - sis_priv->dirty_rx > 0; sis_priv->dirty_rx++) {
+	for (; sis_priv->cur_rx != sis_priv->dirty_rx; sis_priv->dirty_rx++) {
 		struct sk_buff *skb;
 
 		entry = sis_priv->dirty_rx % NUM_RX_DESC;
#
# Patch solves following problems:
# 1) Forgotten counter incrementation in sis900_rx() in case
#    it doesn't get memory for skb, that leads to whole interface failure.
#    Problem is accompanied with messages:
#   eth0: Memory squeeze,deferring packet.
#   eth0: NULL pointer encountered in Rx ring, skipping
# 2) If counter cur_rx overflows and there'll be temporary memory problems
#    buffer can't be recreated later, when memory IS avaliable.
# 3) Limit the work in handler to prevent the endless packets processing if
#    new packets are generated faster then handled.
#
# Signed-off-by: Konstantin Khorenko <khorenko@sw.ru>
# Signed-off-by: Vasily Averin <vvs@sw.ru>


--------------050703040908030103060204--

