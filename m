Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbWEXHEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbWEXHEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWEXHEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:04:34 -0400
Received: from havoc.gtf.org ([69.61.125.42]:41871 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932615AbWEXHEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:04:33 -0400
Date: Wed, 24 May 2006 03:04:32 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20060524070432.GA11207@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/sky2.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

Stephen Hemminger:
      sky2: fix jumbo packet support

diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index 60779eb..9591096 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -979,6 +979,7 @@ static int sky2_rx_start(struct sky2_por
 	struct sky2_hw *hw = sky2->hw;
 	unsigned rxq = rxqaddr[sky2->port];
 	int i;
+	unsigned thresh;
 
 	sky2->rx_put = sky2->rx_next = 0;
 	sky2_qset(hw, rxq);
@@ -1003,9 +1004,21 @@ static int sky2_rx_start(struct sky2_por
 		sky2_rx_add(sky2, re->mapaddr);
 	}
 
- 	/* Truncate oversize frames */
- 	sky2_write16(hw, SK_REG(sky2->port, RX_GMF_TR_THR), sky2->rx_bufsize - 8);
- 	sky2_write32(hw, SK_REG(sky2->port, RX_GMF_CTRL_T), RX_TRUNC_ON);
+
+	/*
+	 * The receiver hangs if it receives frames larger than the
+	 * packet buffer. As a workaround, truncate oversize frames, but
+	 * the register is limited to 9 bits, so if you do frames > 2052
+	 * you better get the MTU right!
+	 */
+	thresh = (sky2->rx_bufsize - 8) / sizeof(u32);
+	if (thresh > 0x1ff)
+		sky2_write32(hw, SK_REG(sky2->port, RX_GMF_CTRL_T), RX_TRUNC_OFF);
+	else {
+		sky2_write16(hw, SK_REG(sky2->port, RX_GMF_TR_THR), thresh);
+		sky2_write32(hw, SK_REG(sky2->port, RX_GMF_CTRL_T), RX_TRUNC_ON);
+	}
+
 
 	/* Tell chip about available buffers */
 	sky2_write16(hw, Y2_QADDR(rxq, PREF_UNIT_PUT_IDX), sky2->rx_put);
