Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262688AbUBZDhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbUBZDWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:22:30 -0500
Received: from palrel11.hp.com ([156.153.255.246]:5023 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262661AbUBZDVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:21:21 -0500
Date: Wed, 25 Feb 2004 19:21:16 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] txqueue_empty
Message-ID: <20040226032116.GP32263@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_txqueue_empty.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] optimise irda_device_txqueue_empty by making inline


diff -Nru a/include/net/irda/irda_device.h b/include/net/irda/irda_device.h
--- a/include/net/irda/irda_device.h	Mon Feb 23 11:00:44 2004
+++ b/include/net/irda/irda_device.h	Mon Feb 23 11:00:44 2004
@@ -45,6 +45,7 @@
 #include <linux/skbuff.h>		/* struct sk_buff */
 #include <linux/irda.h>
 
+#include <net/pkt_sched.h>
 #include <net/irda/irda.h>
 #include <net/irda/qos.h>		/* struct qos_info */
 #include <net/irda/irqueue.h>		/* irda_queue_t */
@@ -219,7 +220,10 @@
 int  irda_device_is_receiving(struct net_device *dev);
 
 /* Interface for internal use */
-int  irda_device_txqueue_empty(struct net_device *dev);
+static inline int irda_device_txqueue_empty(const struct net_device *dev)
+{
+	return (skb_queue_len(&dev->qdisc->q) == 0);
+}
 int  irda_device_set_raw_mode(struct net_device* self, int status);
 int  irda_device_set_dtr_rts(struct net_device *dev, int dtr, int rts);
 int  irda_device_change_speed(struct net_device *dev, __u32 speed);
diff -Nru a/net/irda/irda_device.c b/net/irda/irda_device.c
--- a/net/irda/irda_device.c	Mon Feb 23 11:00:44 2004
+++ b/net/irda/irda_device.c	Mon Feb 23 11:00:44 2004
@@ -47,8 +47,6 @@
 #include <asm/dma.h>
 #include <asm/io.h>
 
-#include <net/pkt_sched.h>
-
 #include <net/irda/irda_device.h>
 #include <net/irda/irlap.h>
 #include <net/irda/timer.h>
@@ -403,22 +401,6 @@
 struct net_device *alloc_irdadev(int sizeof_priv)
 {
 	return alloc_netdev(sizeof_priv, "irda%d", irda_device_setup);
-}
-
-
-/*
- * Function irda_device_txqueue_empty (dev)
- *
- *    Check if there is still some frames in the transmit queue for this
- *    device. Maybe we should use: q->q.qlen == 0.
- *
- */
-int irda_device_txqueue_empty(struct net_device *dev)
-{
-	if (skb_queue_len(&dev->qdisc->q))
-		return FALSE;
-
-	return TRUE;
 }
 
 /*
