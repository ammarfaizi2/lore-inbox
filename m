Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267095AbUBMQfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267100AbUBMQfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:35:46 -0500
Received: from ida.rowland.org ([192.131.102.52]:6148 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S267095AbUBMQfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:35:38 -0500
Date: Fri, 13 Feb 2004 11:35:36 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Ingo Oeser <ioe-lkml@rameria.de>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: (as189) Fix incorrect Appletalk DDP multicast address
In-Reply-To: <200402131102.30325.ioe-lkml@rameria.de>
Message-ID: <Pine.LNX.4.44L0.0402131133040.922-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004, Ingo Oeser wrote:

> Hi Alan,

> While you are at it: can't it be const? Then nobody would try to write
> to it and the compiler can optimize it away, if it is beneficial.

That's perfectly correct.  Here's a revised patch.

Alan Stern


===== net/appletalk/aarp.c 1.9 vs edited =====
--- 1.9/net/appletalk/aarp.c	Fri Sep 12 07:49:01 2003
+++ edited/net/appletalk/aarp.c	Thu Feb 12 10:54:49 2004
@@ -39,6 +39,9 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
+unsigned char const atalk_eth_multicast[ETH_ALEN] =
+			{ 0x09, 0x00, 0x07, 0xFF, 0xFF, 0xFF };
+
 int sysctl_aarp_expiry_time = AARP_EXPIRY_TIME;
 int sysctl_aarp_tick_time = AARP_TICK_TIME;
 int sysctl_aarp_retransmit_limit = AARP_RETRANSMIT_LIMIT;
@@ -100,8 +103,6 @@
  */
 static void __aarp_send_query(struct aarp_entry *a)
 {
-	static unsigned char aarp_eth_multicast[ETH_ALEN] =
-					{ 0x09, 0x00, 0x07, 0xFF, 0xFF, 0xFF };
 	struct net_device *dev = a->dev;
 	struct elapaarp *eah;
 	int len = dev->hard_header_len + sizeof(*eah) + aarp_dl->header_length;
@@ -143,7 +144,7 @@
 	eah->pa_dst_node = a->target_addr.s_node;
 
 	/* Send it */
-	aarp_dl->request(aarp_dl, skb, aarp_eth_multicast);
+	aarp_dl->request(aarp_dl, skb, atalk_eth_multicast);
 	/* Update the sending count */
 	a->xmit_count++;
 	a->last_sent = jiffies;
@@ -204,8 +205,6 @@
 	struct elapaarp *eah;
 	int len = dev->hard_header_len + sizeof(*eah) + aarp_dl->header_length;
 	struct sk_buff *skb = alloc_skb(len, GFP_ATOMIC);
-	static unsigned char aarp_eth_multicast[ETH_ALEN] =
-					{ 0x09, 0x00, 0x07, 0xFF, 0xFF, 0xFF };
 
 	if (!skb)
 		return;
@@ -237,7 +236,7 @@
 	eah->pa_dst_node = us->s_node;
 
 	/* Send it */
-	aarp_dl->request(aarp_dl, skb, aarp_eth_multicast);
+	aarp_dl->request(aarp_dl, skb, atalk_eth_multicast);
 }
 
 /*
@@ -536,8 +535,6 @@
 int aarp_send_ddp(struct net_device *dev, struct sk_buff *skb,
 		  struct atalk_addr *sa, void *hwaddr)
 {
-	static char ddp_eth_multicast[ETH_ALEN] =
-		{ 0x09, 0x00, 0x07, 0xFF, 0xFF, 0xFF };
 	int hash;
 	struct aarp_entry *a;
 
@@ -599,7 +596,7 @@
 	/* Do we have a resolved entry? */
 	if (sa->s_node == ATADDR_BCAST) {
 		/* Send it */
-		ddp_dl->request(ddp_dl, skb, ddp_eth_multicast);
+		ddp_dl->request(ddp_dl, skb, atalk_eth_multicast);
 		goto sent;
 	}
 
===== net/appletalk/ddp.c 1.21 vs edited =====
--- 1.21/net/appletalk/ddp.c	Fri Feb  6 07:40:37 2004
+++ edited/net/appletalk/ddp.c	Thu Feb 12 10:55:41 2004
@@ -71,6 +71,8 @@
 extern void atalk_register_sysctl(void);
 extern void atalk_unregister_sysctl(void);
 
+extern unsigned char atalk_eth_multicast[ETH_ALEN];
+
 struct datalink_proto *ddp_dl, *aarp_dl;
 static struct proto_ops atalk_dgram_ops;
 
@@ -675,7 +677,6 @@
 /* Device configuration ioctl calls */
 static int atif_ioctl(int cmd, void *arg)
 {
-	static char aarp_mcast[6] = { 0x09, 0x00, 0x00, 0xFF, 0xFF, 0xFF };
 	struct ifreq atreq;
 	struct atalk_netrange *nr;
 	struct sockaddr_at *sa;
@@ -794,7 +795,7 @@
 						atrtr_create(&rtdef, dev);
 					}
 			}
-			dev_mc_add(dev, aarp_mcast, 6, 1);
+			dev_mc_add(dev, atalk_eth_multicast, 6, 1);
 			return 0;
 
 		case SIOCGIFADDR:

