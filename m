Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWHOXw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWHOXw2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 19:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWHOXw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 19:52:28 -0400
Received: from khc.piap.pl ([195.187.100.11]:13522 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750700AbWHOXw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 19:52:28 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] WAN: fix C101 card carrier handling
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 16 Aug 2006 01:52:23 +0200
Message-ID: <m3ejvhftfs.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

One of my recent changes broke C101 carrier handling, this patch
fixes it. Also fixes an old TX underrun checking bug.

2.6.18 material. Please apply.
Thanks.

Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>

diff --git a/drivers/net/wan/c101.c b/drivers/net/wan/c101.c
index 435e91e..6b63b35 100644
--- a/drivers/net/wan/c101.c
+++ b/drivers/net/wan/c101.c
@@ -118,7 +118,7 @@ #include "hd6457x.c"
 
 static inline void set_carrier(port_t *port)
 {
-	if (!sca_in(MSCI1_OFFSET + ST3, port) & ST3_DCD)
+	if (!(sca_in(MSCI1_OFFSET + ST3, port) & ST3_DCD))
 		netif_carrier_on(port_to_dev(port));
 	else
 		netif_carrier_off(port_to_dev(port));
@@ -127,10 +127,10 @@ static inline void set_carrier(port_t *p
 
 static void sca_msci_intr(port_t *port)
 {
-	u8 stat = sca_in(MSCI1_OFFSET + ST1, port); /* read MSCI ST1 status */
+	u8 stat = sca_in(MSCI0_OFFSET + ST1, port); /* read MSCI ST1 status */
 
-	/* Reset MSCI TX underrun status bit */
-	sca_out(stat & ST1_UDRN, MSCI0_OFFSET + ST1, port);
+	/* Reset MSCI TX underrun and CDCD (ignored) status bit */
+	sca_out(stat & (ST1_UDRN | ST1_CDCD), MSCI0_OFFSET + ST1, port);
 
 	if (stat & ST1_UDRN) {
 		struct net_device_stats *stats = hdlc_stats(port_to_dev(port));
@@ -138,6 +138,7 @@ static void sca_msci_intr(port_t *port)
 		stats->tx_fifo_errors++;
 	}
 
+	stat = sca_in(MSCI1_OFFSET + ST1, port); /* read MSCI1 ST1 status */
 	/* Reset MSCI CDCD status bit - uses ch#2 DCD input */
 	sca_out(stat & ST1_CDCD, MSCI1_OFFSET + ST1, port);
 
