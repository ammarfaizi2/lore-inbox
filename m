Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbRG3TXe>; Mon, 30 Jul 2001 15:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267591AbRG3TXY>; Mon, 30 Jul 2001 15:23:24 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:14048 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S267484AbRG3TXP>; Mon, 30 Jul 2001 15:23:15 -0400
Message-Id: <4.3.1.0.20010730121828.05eaf310@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Mon, 30 Jul 2001 12:24:08 -0700
To: linux-kernel@vger.kernel.org
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: [PATCH] netif_rx from non interrupt context
Cc: davem@redhat.com, andrea@suse.de, torvalds@transmeta.com,
        kuznet@ms2.inr.ac.ru
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Folks,

Generic function for the net drivers that call netif_rx from non interrupt context.
And TUN/TAP driver patch.

--- linux/include/linux/netdevice.h.old Mon Jul 30 11:37:27 2001
+++ linux/include/linux/netdevice.h     Mon Jul 30 11:48:32 2001
@@ -563,6 +563,19 @@
  
  extern int             netdev_nit;
  
+
+/* 
+ * netif_rx_ni -       post buffer to the network code from _non interrupt_ context.
+ *                     see net/core/dev.c for netif_rx description.
+ */
+static inline int netif_rx_ni(struct sk_buff *skb)
+{
+       int err = netif_rx(skb);
+       if (softirq_pending(smp_processor_id()))
+               do_softirq();
+       return err;
+}
+

--- linux/drivers/net/tun.c.old Mon Jun 11 19:15:27 2001
+++ linux/drivers/net/tun.c     Mon Jul 30 11:49:01 2001
@@ -218,7 +218,7 @@
         if (tun->flags & TUN_NOCHECKSUM)
                 skb->ip_summed = CHECKSUM_UNNECESSARY;
   
-       netif_rx(skb);
+       netif_rx_ni(skb);
     
         tun->stats.rx_packets++;
         tun->stats.rx_bytes += len;


Thanks
Max

Maksim Krasnyanskiy	
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net

