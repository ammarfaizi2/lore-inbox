Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbVKISh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbVKISh6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 13:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbVKISh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 13:37:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:11677 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751489AbVKISh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 13:37:56 -0500
Date: Wed, 9 Nov 2005 10:36:30 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [patch 01/11] prism54 : Fix frame length
Message-ID: <20051109183630.GB3670@kroah.com>
References: <20051109182205.294803000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="prism54_frame_size.patch"
In-Reply-To: <20051109183614.GA3670@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger While <simrw@sim-basis.de>

prism54 is leaking information when passing transmits to the firmware.
There is no requirement to adjust the length to >= ETH_ZLEN.
Just pass the skb length (after possible adjustment).

Signed-off-by: Roger While <simrw@sim-basis.de>
Acked-by: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/net/wireless/prism54/islpci_eth.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- linux-2.6.14.1.orig/drivers/net/wireless/prism54/islpci_eth.c
+++ linux-2.6.14.1/drivers/net/wireless/prism54/islpci_eth.c
@@ -97,12 +97,6 @@ islpci_eth_transmit(struct sk_buff *skb,
 	/* lock the driver code */
 	spin_lock_irqsave(&priv->slock, flags);
 
-	/* determine the amount of fragments needed to store the frame */
-
-	frame_size = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
-	if (init_wds)
-		frame_size += 6;
-
 	/* check whether the destination queue has enough fragments for the frame */
 	curr_frag = le32_to_cpu(cb->driver_curr_frag[ISL38XX_CB_TX_DATA_LQ]);
 	if (unlikely(curr_frag - priv->free_data_tx >= ISL38XX_CB_TX_QSIZE)) {
@@ -213,6 +207,7 @@ islpci_eth_transmit(struct sk_buff *skb,
 	/* store the skb address for future freeing  */
 	priv->data_low_tx[index] = skb;
 	/* set the proper fragment start address and size information */
+	frame_size = skb->len;
 	fragment->size = cpu_to_le16(frame_size);
 	fragment->flags = cpu_to_le16(0);	/* set to 1 if more fragments */
 	fragment->address = cpu_to_le32(pci_map_address);

--
