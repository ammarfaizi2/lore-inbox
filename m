Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTFHPmy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 11:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTFHPmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 11:42:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:65217 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262011AbTFHPmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 11:42:51 -0400
Date: Sun, 8 Jun 2003 17:56:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.70-mm6: ethertap.c doesn't compile
Message-ID: <20030608155623.GG16164@fs.tum.de>
References: <20030607151440.6982d8c6.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607151440.6982d8c6.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got the following compile error in 2.5.70-mm6:

<--  snip  -->

...
  CC      drivers/net/ethertap.o
drivers/net/ethertap.c: In function `ethertap_rx':
drivers/net/ethertap.c:295: structure has no member named `protocol'
drivers/net/ethertap.c:300: structure has no member named `receive_queue'
drivers/net/ethertap.c:307: structure has no member named `receive_queue'
drivers/net/ethertap.c: In function `ethertap_close':
drivers/net/ethertap.c:323: structure has no member named `socket'
make[2]: *** [drivers/net/ethertap.o] Error 1

<--   snip  -->

The patch below fixes the compilation.



cu
Adrian

--- linux-2.5.70-mm6/drivers/net/ethertap.c.old	2003-06-08 17:48:57.000000000 +0200
+++ linux-2.5.70-mm6/drivers/net/ethertap.c	2003-06-08 17:49:53.000000000 +0200
@@ -292,19 +292,19 @@
 
 static void ethertap_rx(struct sock *sk, int len)
 {
-	struct net_device *dev = tap_map[sk->protocol];
+	struct net_device *dev = tap_map[sk->sk_protocol];
 	struct sk_buff *skb;
 
 	if (dev==NULL) {
 		printk(KERN_CRIT "ethertap: bad unit!\n");
-		skb_queue_purge(&sk->receive_queue);
+		skb_queue_purge(&sk->sk_receive_queue);
 		return;
 	}
 
 	if (ethertap_debug > 3)
 		printk("%s: ethertap_rx()\n", dev->name);
 
-	while ((skb = skb_dequeue(&sk->receive_queue)) != NULL)
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL)
 		ethertap_rx_skb(skb, dev);
 }
 
@@ -320,7 +320,7 @@
 
 	if (sk) {
 		lp->nl = NULL;
-		sock_release(sk->socket);
+		sock_release(sk->sk_socket);
 	}
 
 	return 0;
