Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWJWTEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWJWTEt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWJWTEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:04:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48549 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965062AbWJWTEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:04:47 -0400
Date: Mon, 23 Oct 2006 12:02:45 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] netpoll: move drop hook inline
Message-ID: <20061023120245.0699aa69@dxpl.pdx.osdl.net>
In-Reply-To: <20061023115337.1f636ffb@dxpl.pdx.osdl.net>
References: <20061020134826.75dd1cba@freekitty>
	<20061020.140149.125893169.davem@davemloft.net>
	<20061020153027.3bed8c86@dxpl.pdx.osdl.net>
	<20061022.204220.78710782.davem@davemloft.net>
	<20061023115337.1f636ffb@dxpl.pdx.osdl.net>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than have separate drop callback hook, just put
the logic inline in netpoll.  The code is cleaner and netconsole
is the only user of netpoll.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- netpoll.orig/drivers/net/netconsole.c
+++ netpoll/drivers/net/netconsole.c
@@ -60,7 +60,6 @@ static struct netpoll np = {
 	.local_port = 6665,
 	.remote_port = 6666,
 	.remote_mac = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
-	.drop = netpoll_queue,
 };
 static int configured = 0;
 
--- netpoll.orig/include/linux/netpoll.h
+++ netpoll/include/linux/netpoll.h
@@ -18,7 +18,6 @@ struct netpoll {
 	struct net_device *dev;
 	char dev_name[16], *name;
 	void (*rx_hook)(struct netpoll *, int, char *, int);
-	void (*drop)(struct sk_buff *skb);
 	u32 local_ip, remote_ip;
 	u16 local_port, remote_port;
 	unsigned char local_mac[6], remote_mac[6];
--- netpoll.orig/net/core/netpoll.c
+++ netpoll/net/core/netpoll.c
@@ -91,13 +91,6 @@ static void queue_purge(struct net_devic
 	spin_unlock_irqrestore(&netpoll_txq.lock, flags);
 }
 
-void netpoll_queue(struct sk_buff *skb)
-{
-	skb_queue_tail(&netpoll_txq, skb);
-
-	schedule_work(&send_queue);
-}
-
 static int checksum_udp(struct sk_buff *skb, struct udphdr *uh,
 			     unsigned short ulen, u32 saddr, u32 daddr)
 {
@@ -282,10 +275,10 @@ static void netpoll_send_skb(struct netp
 		udelay(50);
 	} while (--tries > 0);
 
-	if (np->drop)
-		np->drop(skb);
-	else
-		__kfree_skb(skb);
+	/* if transmitter is busy, try send later. */
+	skb_queue_tail(&netpoll_txq, skb);
+
+	schedule_work(&send_queue);
 }
 
 void netpoll_send_udp(struct netpoll *np, const char *msg, int len)
@@ -784,4 +777,3 @@ EXPORT_SYMBOL(netpoll_setup);
 EXPORT_SYMBOL(netpoll_cleanup);
 EXPORT_SYMBOL(netpoll_send_udp);
 EXPORT_SYMBOL(netpoll_poll);
-EXPORT_SYMBOL(netpoll_queue);
