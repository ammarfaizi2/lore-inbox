Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbUB2H6x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbUB2H6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:58:53 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:48394 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262011AbUB2H6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:58:47 -0500
To: "Nick Warne" <nick@ukfsn.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 - 8139too timeout debug info
References: <403F7EEF.4124.2432E62F@localhost>
	<4040E258.29625.299F47FC@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 29 Feb 2004 16:58:37 +0900
In-Reply-To: <4040E258.29625.299F47FC@localhost>
Message-ID: <87vflqtiz6.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

"Nick Warne" <nick@ukfsn.org> writes:

> Thanks for your help.  I have hell of a trouble doing this, as soon 
> as any network load happens, the box becomes unresponsive during 
> timeouts - but hopefully I have caught the info required.

Umm.. Looks like chip registers is normal, but TX/RX interrupt doesn't
happen. (BTW, there isn't rtl8139_open on debuginfo.txt. Was it already
scrolled?)

The following patch (incremental patch) is some part reverts to
2.6.2. Is behavior changed?

Please try 8139too-revert01.patch, and 8139too-revert02.patch.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=8139too-revert01.patch

---

 drivers/net/8139too.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff -puN drivers/net/8139too.c~8139too-revert01 drivers/net/8139too.c
--- linux-2.6.3/drivers/net/8139too.c~8139too-revert01	2004-02-29 16:05:54.000000000 +0900
+++ linux-2.6.3-hirofumi/drivers/net/8139too.c	2004-02-29 16:29:41.000000000 +0900
@@ -2043,12 +2043,10 @@ static int rtl8139_rx(struct net_device 
 			skb_put (skb, pkt_size);
 
 			skb->protocol = eth_type_trans (skb, dev);
-
+			netif_rx (skb);
 			dev->last_rx = jiffies;
 			tp->stats.rx_bytes += pkt_size;
 			tp->stats.rx_packets++;
-
-			netif_receive_skb (skb);
 		} else {
 			if (net_ratelimit()) 
 				printk (KERN_WARNING
@@ -2204,11 +2202,10 @@ static irqreturn_t rtl8139_interrupt (in
 
 	/* Receive packets are processed by poll routine.
 	   If not running start it now. */
-	if (status & RxAckBits){
-		if (netif_rx_schedule_prep(dev)) {
-			RTL_W16_F (IntrMask, rtl8139_norx_intr_mask);
-			__netif_rx_schedule (dev);
-		}
+	if (status & RxAckBits) {
+		RTL_W16_F(IntrMask, rtl8139_norx_intr_mask);
+		rtl8139_rx(dev, tp, dev->weight);
+		RTL_W16_F(IntrMask, rtl8139_intr_mask);
 	}
 
 	/* Check uncommon events with one test. */

_

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=8139too-revert02.patch

---

 drivers/net/8139too.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/net/8139too.c~8139too-revert02 drivers/net/8139too.c
--- linux-2.6.3/drivers/net/8139too.c~8139too-revert02	2004-02-29 16:30:14.000000000 +0900
+++ linux-2.6.3-hirofumi/drivers/net/8139too.c	2004-02-29 16:33:35.000000000 +0900
@@ -1374,6 +1374,7 @@ static int rtl8139_open (struct net_devi
 
 	rtl8139_start_thread(dev);
 
+	printk("%s: revert02\n", dev->name);
 	spin_lock_irq(&tp->lock);
 	RTL8139_DUMP(dev);
 	spin_unlock_irq(&tp->lock);
@@ -2202,11 +2203,8 @@ static irqreturn_t rtl8139_interrupt (in
 
 	/* Receive packets are processed by poll routine.
 	   If not running start it now. */
-	if (status & RxAckBits) {
-		RTL_W16_F(IntrMask, rtl8139_norx_intr_mask);
+	if (status & RxAckBits)
 		rtl8139_rx(dev, tp, dev->weight);
-		RTL_W16_F(IntrMask, rtl8139_intr_mask);
-	}
 
 	/* Check uncommon events with one test. */
 	if (unlikely(status & (PCIErr | PCSTimeout | RxUnderrun | RxErr)))

_

--=-=-=--
