Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbUBYWyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUBYWvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:51:51 -0500
Received: from smtp.instant802.com ([66.93.138.219]:10145 "EHLO
	mail-gateway.instant802.com") by vger.kernel.org with ESMTP
	id S261589AbUBYWr6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:47:58 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH 2.4.26-pre1] Allow ebtables module to change protocol in netif_receive_skb
Date: Wed, 25 Feb 2004 14:47:41 -0800
Message-ID: <AC8C1F46CD753F4AAC8F890E35A9EB461C670B@webmail.instant802.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.4.26-pre1] Allow ebtables module to change protocol in netif_receive_skb
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

--- linux-2.4.26-pre1.orig/net/core/dev.c	2004-02-25
04:16:33.000000000 -0800
+++ linux-2.4.26-pre1/net/core/dev.c	2004-02-25 06:42:05.000000000
-0800
@@ -1462,7 +1462,7 @@
 {
 	struct packet_type *ptype, *pt_prev;
 	int ret = NET_RX_DROP;
-	unsigned short type = skb->protocol;
+	unsigned short type;
 
 	if (skb->stamp.tv_sec == 0)
 		do_gettimeofday(&skb->stamp);
@@ -1507,6 +1507,7 @@
 	}
 #endif
 
+	type = skb->protocol;
 	for (ptype=ptype_base[ntohs(type)&15];ptype;ptype=ptype->next) {
 		if (ptype->type == type &&
 		    (!ptype->dev || ptype->dev == skb->dev)) {
