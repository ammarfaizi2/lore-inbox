Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWF1UGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWF1UGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWF1UGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:06:12 -0400
Received: from mail.gmx.de ([213.165.64.21]:50137 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751204AbWF1UGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:06:11 -0400
X-Authenticated: #704063
Subject: [Patch] SKB leak in drivers/isdn/i4l/isdn_x25iface.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: eis@baty.hanse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 28 Jun 2006 22:06:07 +0200
Message-Id: <1151525167.26804.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

coverity spotted this leak (id #613), when
we are not configured, we return without
freeing the allocated skb.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git11/drivers/isdn/i4l/isdn_x25iface.c.orig	2006-06-28 22:02:38.000000000 +0200
+++ linux-2.6.17-git11/drivers/isdn/i4l/isdn_x25iface.c	2006-06-28 22:03:02.000000000 +0200
@@ -208,7 +208,7 @@ static int isdn_x25iface_receive(struct 
  */
 static int isdn_x25iface_connect_ind(struct concap_proto *cprot)
 {
-	struct sk_buff * skb = dev_alloc_skb(1);
+	struct sk_buff * skb;
 	enum wan_states *state_p 
 	  = &( ( (ix25_pdata_t*) (cprot->proto_data) ) -> state);
 	IX25DEBUG( "isdn_x25iface_connect_ind %s \n"
@@ -220,6 +220,8 @@ static int isdn_x25iface_connect_ind(str
 		return -1;
 	}
 	*state_p = WAN_CONNECTED;
+
+	skb = dev_alloc_skb(1);
 	if( skb ){
 		*( skb_put(skb, 1) ) = 0x01;
 		skb->protocol = x25_type_trans(skb, cprot->net_dev);


