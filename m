Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbUCJWvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUCJWvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:51:38 -0500
Received: from smtpq2.home.nl ([213.51.128.197]:57306 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S262672AbUCJWtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:49:16 -0500
Message-ID: <404F9B4B.5050803@keyaccess.nl>
Date: Wed, 10 Mar 2004 23:48:43 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 8139too Interframe Gap Time
Content-Type: multipart/mixed;
 boundary="------------010803070408030202000600"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010803070408030202000600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

in drivers/net/8139too.c, we have:

    /* Check this value: the documentation for IFG contradicts ifself. */
    RTL_W32 (TxConfig, rtl8139_tx_config);

I see that in older versions of the documentation there indeed were some
contradictions but the current version 1.4:

ftp://210.51.181.211/cn/nic/rtl8139abcd8130810xseries/rtl8139cspec_1.4.pdf

clears it up and it seems 8139too guessed wrong. I have verified that
realtek's own windows 9x driver agrees with the documentation.

No equipment to actually measure the IFG and no difference in network
behaviour shows up on a good 100Mbit-FD switch connected LAN, but it
does on an el-cheapo 10Mbit-HD hub connected LAN. Without attached
patch the packet and collision counters are basically the same; with
patch, the latter is only some 70% of the former. Hurray!

Rene.



--------------010803070408030202000600
Content-Type: text/plain;
 name="linux-2.6.4-rc2-mm1_8139too-IFG.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.4-rc2-mm1_8139too-IFG.diff"

--- linux-2.6.4-rc2-mm1/drivers/net/8139too.c.orig	2004-03-10 21:01:08.000000000 +0100
+++ linux-2.6.4-rc2-mm1/drivers/net/8139too.c	2004-03-10 21:01:14.000000000 +0100
@@ -383,8 +383,14 @@
 
 /* Bits in TxConfig. */
 enum tx_config_bits {
-	TxIFG1 = (1 << 25),	/* Interframe Gap Time */
-	TxIFG0 = (1 << 24),	/* Enabling these bits violates IEEE 802.3 */
+
+        /* Interframe Gap Time. Only TxIFG96 doesn't violate IEEE 802.3 */
+        TxIFGShift = 24,
+        TxIFG84 = (0 << TxIFGShift),    /* 8.4us / 840ns (10 / 100Mbps) */
+        TxIFG88 = (1 << TxIFGShift),    /* 8.8us / 880ns (10 / 100Mbps) */
+        TxIFG92 = (2 << TxIFGShift),    /* 9.2us / 920ns (10 / 100Mbps) */
+        TxIFG96 = (3 << TxIFGShift),    /* 9.6us / 960ns (10 / 100Mbps) */
+
 	TxLoopBack = (1 << 18) | (1 << 17), /* enable loopback test mode */
 	TxCRC = (1 << 16),	/* DISABLE appending CRC to end of Tx packets */
 	TxClearAbt = (1 << 0),	/* Clear abort (WO) */
@@ -716,7 +722,7 @@
 #endif
 
 static const unsigned int rtl8139_tx_config =
-	(TX_DMA_BURST << TxDMAShift) | (TX_RETRY << TxRetryShift);
+	TxIFG96 | (TX_DMA_BURST << TxDMAShift) | (TX_RETRY << TxRetryShift);
 
 static void __rtl8139_cleanup_dev (struct net_device *dev)
 {
@@ -1393,8 +1399,6 @@
 
 	tp->rx_config = rtl8139_rx_config | AcceptBroadcast | AcceptMyPhys;
 	RTL_W32 (RxConfig, tp->rx_config);
-
-	/* Check this value: the documentation for IFG contradicts ifself. */
 	RTL_W32 (TxConfig, rtl8139_tx_config);
 
 	tp->cur_rx = 0;

--------------010803070408030202000600--

