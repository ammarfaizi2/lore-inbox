Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUFWWJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUFWWJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUFWWJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:09:15 -0400
Received: from siaag1ai.mx.compuserve.com ([149.174.40.24]:4479 "EHLO
	siaag1ai.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S261984AbUFWWG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:06:58 -0400
Date: Wed, 23 Jun 2004 18:00:46 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH] Trivial loopback optimization for 2.6.7
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200406231803_MC3-1-854F-EC5E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for the network loopback driver:

1: Removes unnecessary include with misleading comment.

2: Optimizes device stats update in the transmit routine
(saves 2 loads, one add, one increment per packet sent.)

Why is there no stats counting in the TSO code in
emulate_large_send_offload()?


Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 267.0/drivers/net/loopback.c        2004-06-21 16:09:45.000000000 -0400
+++ 267.1/drivers/net/loopback.c        2004-06-21 16:16:20.000000000 -0400
@@ -51,7 +51,6 @@
 #include <linux/skbuff.h>
 #include <net/sock.h>
 #include <net/checksum.h>
-#include <linux/if_ether.h>    /* For the statistics structure. */
 #include <linux/if_arp.h>      /* For ARPHRD_ETHER */
 #include <linux/ip.h>
 #include <linux/tcp.h>
@@ -143,10 +142,14 @@ static int loopback_xmit(struct sk_buff 
 
        dev->last_rx = jiffies;
        if (likely(stats)) {
-               stats->rx_bytes+=skb->len;
-               stats->tx_bytes+=skb->len;
-               stats->rx_packets++;
-               stats->tx_packets++;
+               /*
+                * Transmit/receive stats are identical;
+                * rx_packets is first in struct.
+                */
+               stats->tx_packets = ++stats->rx_packets;
+
+               stats->rx_bytes += skb->len;
+               stats->tx_bytes = stats->rx_bytes;
        }
 
        netif_rx(skb);

