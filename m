Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWEQWPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWEQWPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWEQWMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:12:44 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:20864 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751244AbWEQWMS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:18 -0400
Message-Id: <20060517221351.578107000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:02 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       git-commits-head@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Craig Brind <craigbrind@gmail.com>, Roger Luethi <rl@hellgate.ch>,
       Jeff Garzik <jeff@garzik.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 02/22] [PATCH] via-rhine: zero pad short packets on Rhine I ethernet cards
Content-Disposition: inline; filename=via-rhine-zero-pad-short-packets-on-rhine-i-ethernet-cards.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

[PATCH] via-rhine: zero pad short packets on Rhine I ethernet cards

Fixes Rhine I cards disclosing fragments of previously transmitted frames
in new transmissions.

Before transmission, any socket buffer (skb) shorter than the ethernet
minimum length of 60 bytes was zero-padded.  On Rhine I cards the data can
later be copied into an aligned transmission buffer without copying this
padding.  This resulted in the transmission of the frame with the extra
bytes beyond the provided content leaking the previous contents of this
buffer on to the network.

Now zero-padding is repeated in the local aligned buffer if one is used.

Following a suggestion from the via-rhine maintainer, no attempt is made
here to avoid the duplicated effort of padding the skb if it is known that
an aligned buffer will definitely be used.  This is to make the change
"obviously correct" and allow it to be applied to a stable kernel if
necessary.  There is no change to the flow of control and the changes are
only to the Rhine I code path.

The patch has run on an in-service Rhine-I host without incident.  Frames
shorter than 60 bytes are now correctly zero-padded when captured on a
separate host.  I see no unusual stats reported by ifconfig, and no unusual
log messages.

Signed-off-by: Craig Brind <craigbrind@gmail.com>
Signed-off-by: Roger Luethi <rl@hellgate.ch>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/net/via-rhine.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.16.16.orig/drivers/net/via-rhine.c
+++ linux-2.6.16.16/drivers/net/via-rhine.c
@@ -129,6 +129,7 @@
 	- Massive clean-up
 	- Rewrite PHY, media handling (remove options, full_duplex, backoff)
 	- Fix Tx engine race for good
+	- Craig Brind: Zero padded aligned buffers for short packets.
 
 */
 
@@ -1306,7 +1307,12 @@ static int rhine_start_tx(struct sk_buff
 			rp->stats.tx_dropped++;
 			return 0;
 		}
+
+		/* Padding is not copied and so must be redone. */
 		skb_copy_and_csum_dev(skb, rp->tx_buf[entry]);
+		if (skb->len < ETH_ZLEN)
+			memset(rp->tx_buf[entry] + skb->len, 0,
+			       ETH_ZLEN - skb->len);
 		rp->tx_skbuff_dma[entry] = 0;
 		rp->tx_ring[entry].addr = cpu_to_le32(rp->tx_bufs_dma +
 						      (rp->tx_buf[entry] -

--
