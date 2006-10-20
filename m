Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWJTWfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWJTWfb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWJTWfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:35:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030368AbWJTWf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:35:28 -0400
Date: Fri, 20 Oct 2006 15:32:44 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] netpoll: use device xmit directly
Message-ID: <20061020153244.6fcde6f5@dxpl.pdx.osdl.net>
In-Reply-To: <20061020.140149.125893169.davem@davemloft.net>
References: <20061020084015.5c559326@localhost.localdomain>
	<20061020.134209.85688168.davem@davemloft.net>
	<20061020134826.75dd1cba@freekitty>
	<20061020.140149.125893169.davem@davemloft.net>
X-Mailer: Sylpheed-Claws 2.5.3 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For most normal sends, the netpoll code was using the dev->hard_start_xmit
directly. If it got busy, it would process later, but this code path uses
dev_queue_xmit() and that code would send the skb through NIT and other
stuff that netpoll doesn't want.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- netpoll.orig/net/core/netpoll.c
+++ netpoll/net/core/netpoll.c
@@ -51,17 +51,28 @@ static atomic_t trapped;
 static void zap_completion_queue(void);
 static void arp_reply(struct sk_buff *skb);
 
+static void queue_process(void *);
+static DECLARE_WORK(send_queue, queue_process, NULL);
+
 static void queue_process(void *p)
 {
 	struct sk_buff *skb;
 
-	while ((skb = skb_dequeue(&netpoll_txq)))
-		dev_queue_xmit(skb);
+	while ((skb = skb_dequeue(&netpoll_txq))) {
+		struct net_device *dev = skb->dev;
+		netif_tx_lock_bh(dev);
+		if (netif_queue_stopped(dev) ||
+		    dev->hard_start_xmit(skb, dev) != NETDEV_TX_OK) {
+			skb_queue_head(&netpoll_txq, skb);
+			netif_tx_unlock_bh(dev);
 
+			schedule_delayed_work(&send_queue, 1);
+			break;
+		}
+		netif_tx_unlock_bh(dev);
+	}
 }
 
-static DECLARE_WORK(send_queue, queue_process, NULL);
-
 void netpoll_queue(struct sk_buff *skb)
 {
 	skb_queue_tail(&netpoll_txq, skb);
