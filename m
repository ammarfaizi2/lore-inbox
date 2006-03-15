Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWCODRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWCODRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 22:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWCODRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 22:17:21 -0500
Received: from metis.starhub.net.sg ([203.117.3.21]:57613 "EHLO
	metis.starhub.net.sg") by vger.kernel.org with ESMTP
	id S1751162AbWCODRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 22:17:21 -0500
X-SBRS: 3.5
X-HAT: Message received through Sender Group RELAYLIST,Policy $RELAYED applied.
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Date: Wed, 15 Mar 2006 11:08:27 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Fix irda-usb use after use
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: dag@brattli.net
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060315030827.GA10207@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't read from free'd memory after calling netif_rx().
docopy is used as a boolean (0 and 1) so unsigned int is sufficient.

Coverity bug #928

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>
 
--- linux-2.6/drivers/net/irda/irda-usb.c~	2006-03-15 10:05:35.000000000 +0800
+++ linux-2.6/drivers/net/irda/irda-usb.c	2006-03-15 11:06:01.000000000 +0800
@@ -740,7 +740,7 @@
 	struct sk_buff *newskb;
 	struct sk_buff *dataskb;
 	struct urb *next_urb;
-	int		docopy;
+	unsigned int len, docopy;
 
 	IRDA_DEBUG(2, "%s(), len=%d\n", __FUNCTION__, urb->actual_length);
 	
@@ -851,10 +851,11 @@
 	dataskb->dev = self->netdev;
 	dataskb->mac.raw  = dataskb->data;
 	dataskb->protocol = htons(ETH_P_IRDA);
+	len = dataskb->len;
 	netif_rx(dataskb);
 
 	/* Keep stats up to date */
-	self->stats.rx_bytes += dataskb->len;
+	self->stats.rx_bytes += len;
 	self->stats.rx_packets++;
 	self->netdev->last_rx = jiffies;
 
-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }
