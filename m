Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUBYWvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbUBYWvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:51:11 -0500
Received: from smtp.instant802.com ([66.93.138.219]:15265 "EHLO
	mail-gateway.instant802.com") by vger.kernel.org with ESMTP
	id S261622AbUBYWtr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:49:47 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH 2.6.3-bk7] Allow ebtables module to change protocol in netif_receive_skb
Date: Wed, 25 Feb 2004 14:49:32 -0800
Message-ID: <AC8C1F46CD753F4AAC8F890E35A9EB461C670C@webmail.instant802.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.3-bk7] Allow ebtables module to change protocol in netif_receive_skb
Thread-Index: AcP7H8r7liQMqexhSF+8GCI1T/Fy6gA0P82A
From: "Simon Barber" <simon@instant802.com>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Cc: "Bart De Schuymer" <bdschuym@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently skb->protocol is read before the bridge is called, even though
it's not used until after. Hence if an ebtables module changes the
protocol of a frame the wrong protocol is interpreted.

Simon Barber

--- linux-2.6.3-bk7.orig/net/core/dev.c	2004-02-25 04:19:07.000000000
-0800
+++ linux-2.6.3-bk7/net/core/dev.c	2004-02-25 06:42:11.000000000
-0800
@@ -1725,7 +1725,7 @@
 {
 	struct packet_type *ptype, *pt_prev;
 	int ret = NET_RX_DROP;
-	unsigned short type = skb->protocol;
+	unsigned short type;
 
 	if (!skb->stamp.tv_sec)
 		do_gettimeofday(&skb->stamp);
@@ -1759,6 +1759,7 @@
 	if (__handle_bridge(skb, &pt_prev, &ret))
 		goto out;
 
+	type = skb->protocol;
 	list_for_each_entry_rcu(ptype, &ptype_base[ntohs(type)&15],
list) {
 		if (ptype->type == type &&
 		    (!ptype->dev || ptype->dev == skb->dev)) {
