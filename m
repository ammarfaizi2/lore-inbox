Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbTAJS20>; Fri, 10 Jan 2003 13:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbTAJS1j>; Fri, 10 Jan 2003 13:27:39 -0500
Received: from [193.158.237.250] ([193.158.237.250]:30344 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265800AbTAJS0d>; Fri, 10 Jan 2003 13:26:33 -0500
Date: Fri, 10 Jan 2003 19:35:10 +0100
Message-Id: <200301101835.h0AIZA704332@mail.intergenia.de>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: [PATCH] 2.5.55 fix etherleak in 8390.c [rescued]
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is the fix which went in 2.4.21-pre3-ac2, rediffed against 2.5.55

	Rudmer

--- linux-2.5.55/drivers/net/8390.c.orig	2003-01-10 16:23:44.000000000 +0100
+++ linux-2.5.55/drivers/net/8390.c	2003-01-10 16:23:00.000000000 +0100
@@ -270,6 +270,7 @@
 	struct ei_device *ei_local = (struct ei_device *) dev->priv;
 	int length, send_length, output_page;
 	unsigned long flags;
+	char scratch[ETH_ZLEN];
 
 	length = skb->len;
 
@@ -341,7 +342,15 @@
 	 * trigger the send later, upon receiving a Tx done interrupt.
 	 */
 
-	ei_block_output(dev, length, skb->data, output_page);
+	if (length == send_length)
+		ei_block_output(dev, length, skb->data, output_page);
+	else
+	{
+		memset(scratch, 0, ETH_ZLEN);
+		memcpy(scratch, skb->data, skb->len);
+		ei_block_output(dev, ETH_ZLEN, scratch, output_page);
+	}
+
 	if (! ei_local->txing) 
 	{
 		ei_local->txing = 1;
@@ -373,7 +382,14 @@
 	 * reasonable hardware if you only use one Tx buffer.
 	 */
 
-	ei_block_output(dev, length, skb->data, ei_local->tx_start_page);
+	if(length == send_length)
+		ei_block_output(dev, length, skb->data, ei_local->tx_start_page);
+	else
+	{
+		memset(scratch, 0, ETH_ZLEN);
+		memcpy(scratch, skb->data, skb->len);
+		ei_block_output(dev, ETH_ZLEN, scratch, ei_local->tx_start_page);
+	}
 	ei_local->txing = 1;
 	NS8390_trigger_send(dev, send_length, ei_local->tx_start_page);
 	dev->trans_start = jiffies;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

