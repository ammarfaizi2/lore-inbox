Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268027AbTBMMKd>; Thu, 13 Feb 2003 07:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268029AbTBMMKd>; Thu, 13 Feb 2003 07:10:33 -0500
Received: from mail.ut.caldera.com ([216.250.130.2]:4819 "EHLO
	mail.ut.caldera.com") by vger.kernel.org with ESMTP
	id <S268027AbTBMMK3>; Thu, 13 Feb 2003 07:10:29 -0500
Message-Id: <3.0.32.20030213175200.006cf7cc@indus.asia.caldera.com>
X-Mailer: Windows Eudora Pro Version 3.0 (32)
Date: Thu, 13 Feb 2003 17:52:06 +0500
To: davem@redhat.com, ak@muc.de
From: Ashish Kalra <ashishk@caldera.com>
Subject: EtherLeak generic fix - for feedback & testing.
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, akpm@zip.com.au,
       jgarzik@mandrakesoft.com, linux-net@vger.kernel.org, ashishk@sco.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a kernel-2.4.13 patch for a "generic" fix for the Etherleak security
issue and it works without making modifications to network device drivers. 

The recommended fix for the Etherleak security issue, is to do the padding
in the network drivers and that requires modifications of the affected
drivers. This fix is a link-layer hook to do the padding, hence there is
no need for modifying network drivers.

Ashish Kalra.
The SCO group

Here is the patch :

diff -Naur -X patches/dontdiff linux-2.4.13/drivers/net/net_init.c
linux-2.4.13-eleak/drivers/net/net_init.c
--- linux-2.4.13/drivers/net/net_init.c	Thu Dec 13 17:15:39 2001
+++ linux-2.4.13-eleak/drivers/net/net_init.c	Thu Feb 13 14:36:34 2003
@@ -414,6 +414,9 @@
 
 #endif /* CONFIG_HIPPI */
 
+extern int (*netif_xmit_hook)(struct sk_buff *);
+extern int etherleak_fix(struct sk_buff *);
+
 void ether_setup(struct net_device *dev)
 {
 	/* Fill in the fields of the device structure with ethernet-generic values.
@@ -437,6 +440,10 @@
 
 	/* New-style flags. */
 	dev->flags		= IFF_BROADCAST|IFF_MULTICAST;
+
+	/* TBD: xmit_hook should ideally be part of "net_device" struct */
+	netif_xmit_hook = etherleak_fix;
+
 }
 EXPORT_SYMBOL(ether_setup);
 
diff -Naur -X patches/dontdiff linux-2.4.13/net/core/dev.c
linux-2.4.13-eleak/net/core/dev.c
--- linux-2.4.13/net/core/dev.c	Sat Oct 13 02:51:18 2001
+++ linux-2.4.13-eleak/net/core/dev.c	Thu Feb 13 14:37:36 2003
@@ -949,6 +949,9 @@
 #else
 #define illegal_highdma(dev, skb)	(0)
 #endif
+ 
+/* TBD: xmit_hook ideally should be part of "net_device" */
+int (*netif_xmit_hook)(struct sk_buff *) = 0;
 
 /**
  *	dev_queue_xmit - transmit a buffer
@@ -997,8 +1000,13 @@
 			return -ENOMEM;
 	}
 
+	if ((netif_xmit_hook) && (netif_xmit_hook)(skb)) {
+		;
+	}
+
 	/* Grab device queue */
 	spin_lock_bh(&dev->queue_lock);
+
 	q = dev->qdisc;
 	if (q->enqueue) {
 		int ret = q->enqueue(skb, q);
diff -Naur -X patches/dontdiff linux-2.4.13/net/ethernet/eth.c
linux-2.4.13-eleak/net/ethernet/eth.c
--- linux-2.4.13/net/ethernet/eth.c	Sat Mar  3 00:32:15 2001
+++ linux-2.4.13-eleak/net/ethernet/eth.c	Thu Feb 13 15:30:27 2003
@@ -237,3 +237,32 @@
 {
 	memcpy(((u8*)hh->hh_data) + 2, haddr, dev->addr_len);
 }
+
+/* 
+ * RFCs 894 & 1042, require that the data field should be padded with
+ * octects of zero to meet the Ethernet minimum frame size. The padding is
+ * not part of the IP packet and should not be included in the total length
+ * field of the IP header, it is simply part of link-layer.
+ * This is a generic fix for this "EtherLeak", short Ethernet frame padding
+ * information leakage issue. 
+ * Just try to pad without re-allocating and copying skbuff's to minimize
+ * performance impact, skbuff has additional space allocated by most
protocols
+ * and also due to cacheline size alignment adjustments. It would have been
+ * easier if linux supported chained data-buffers like BSD mbuf's or
+ * STREAMs mblk's   - ashishk@sco.com
+ */
+
+int etherleak_fix(struct sk_buff *skb)
+{
+	int frame_len = skb->len, pad_length = ETH_ZLEN-frame_len;
+
+	if ( (skb->dev->type == ARPHRD_ETHER) && (frame_len < ETH_ZLEN) ) {
+		if ((skb->tail + pad_length) > skb->end)
+			printk(KERN_ALERT "Potential Etherleak security issue detected. Contact
your Network device driver vendor for patch\n"); 
+		else
+			memset( skb_put(skb, pad_length), 0, pad_length);
+	}
+	return 1;
+}
+
+


