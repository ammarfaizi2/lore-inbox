Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbSKBRRC>; Sat, 2 Nov 2002 12:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSKBRRC>; Sat, 2 Nov 2002 12:17:02 -0500
Received: from mail.scram.de ([195.226.127.117]:11465 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S261306AbSKBRRA>;
	Sat, 2 Nov 2002 12:17:00 -0500
Date: Sat, 2 Nov 2002 18:17:28 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Jeff Garzik <jgarzik@pobox.com>, <phillim2@comcast.net>
Subject: [PATH] Token Ring Updates
Message-ID: <Pine.LNX.4.44.0211021814440.18761-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch changes the following in tr.c

o adds support for IPv6 over Token Ring
o fixes a bug where packets with 2 byte RIF fields are displayed
  incorrectly by tcpdump et al.

--jochen

--- linux-2.5.45.orig/net/802/tr.c	2002-10-31 01:41:54.000000000 +0100
+++ linux-2.5.45/net/802/tr.c	2002-11-02 18:02:13.000000000 +0100
@@ -91,10 +91,10 @@
 	int hdr_len;

 	/*
-	 * Add the 802.2 SNAP header if IP as the IPv4 code calls
+	 * Add the 802.2 SNAP header if IP as the IPv4/IPv6 code calls
 	 * dev->hard_header directly.
 	 */
-	if (type == ETH_P_IP || type == ETH_P_ARP)
+	if (type == ETH_P_IP || type == ETH_P_IPV6 || type == ETH_P_ARP)
 	{
 		struct trllc *trllc=(struct trllc *)(trh+1);

@@ -216,6 +216,7 @@

 	if (trllc->dsap == EXTENDED_SAP &&
 	    (trllc->ethertype == ntohs(ETH_P_IP) ||
+	     trllc->ethertype == ntohs(ETH_P_IPV6) ||
 	     trllc->ethertype == ntohs(ETH_P_ARP)))
 	{
 		skb_pull(skb, sizeof(struct trllc));
@@ -323,6 +324,7 @@
 {
 	int i;
 	unsigned int hash, rii_p = 0;
+	unsigned rif = 0;
 	rif_cache entry;


@@ -334,6 +336,7 @@

        	if(trh->saddr[0] & TR_RII)
 	{
+		rif = 1;
 		trh->saddr[0]&=0x7f;
 		if (((ntohs(trh->rcf) & TR_RCF_LEN_MASK) >> 8) > 2)
 		{
@@ -380,7 +383,6 @@
 			entry->rcf = trh->rcf & htons((unsigned short)~TR_RCF_BROADCAST_MASK);
 			memcpy(&(entry->rseg[0]),&(trh->rseg[0]),8*sizeof(unsigned short));
 			entry->local_ring = 0;
-			trh->saddr[0]|=TR_RII; /* put the routing indicator back for tcpdump */
 		}
 		else
 		{
@@ -407,6 +409,8 @@
 		    }
            	entry->last_used=jiffies;
 	}
+	if (rif)
+		trh->saddr[0]|=TR_RII; /* put the routing indicator back for tcpdump */
 	spin_unlock_bh(&rif_lock);
 }


