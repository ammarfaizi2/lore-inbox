Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbTAJPXC>; Fri, 10 Jan 2003 10:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbTAJPWl>; Fri, 10 Jan 2003 10:22:41 -0500
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:49412 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S265201AbTAJPVN>;
	Fri, 10 Jan 2003 10:21:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
Message-Id: <200301101626.44204@gandalf>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Subject: [PATCH] 2.5.55 fix etherleak in 8390.c
Date: Fri, 10 Jan 2003 16:29:55 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
