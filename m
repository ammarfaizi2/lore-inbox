Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758267AbWK2WDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758267AbWK2WDz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758287AbWK2WDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:03:51 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:57556 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758275AbWK2WDo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:03:44 -0500
Message-Id: <20061129220430.360678000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:21 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Larry Finger <Larry.Finger@lwfinger.net>,
       netdev@vger.kernel.org, mb@bu3sch.de, greg@kroah.com,
       "John W. Linville" <linville@tuxdriver.com>
Subject: [patch 10/23] bcm43xx: Drain TX status before starting IRQs
Content-Disposition: inline; filename=bcm43xx-drain-tx-status-before-starting-irqs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Michael Buesch <mb@bu3sch.de>

Drain the Microcode TX-status-FIFO before we enable IRQs.
This is required, because the FIFO may still have entries left
from a previous run. Those would immediately fire after enabling
IRQs and would lead to an oops in the DMA TXstatus handling code.

Cc: "John W. Linville" <linville@tuxdriver.com>
Signed-off-by: Michael Buesch <mb@bu3sch.de>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/net/wireless/bcm43xx/bcm43xx_main.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- linux-2.6.18.4.orig/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ linux-2.6.18.4/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -1463,6 +1463,23 @@ static void handle_irq_transmit_status(s
 	}
 }
 
+static void drain_txstatus_queue(struct bcm43xx_private *bcm)
+{
+	u32 dummy;
+
+	if (bcm->current_core->rev < 5)
+		return;
+	/* Read all entries from the microcode TXstatus FIFO
+	 * and throw them away.
+	 */
+	while (1) {
+		dummy = bcm43xx_read32(bcm, BCM43xx_MMIO_XMITSTAT_0);
+		if (!dummy)
+			break;
+		dummy = bcm43xx_read32(bcm, BCM43xx_MMIO_XMITSTAT_1);
+	}
+}
+
 static void bcm43xx_generate_noise_sample(struct bcm43xx_private *bcm)
 {
 	bcm43xx_shm_write16(bcm, BCM43xx_SHM_SHARED, 0x408, 0x7F7F);
@@ -3517,6 +3534,7 @@ int bcm43xx_select_wireless_core(struct 
 	bcm43xx_macfilter_clear(bcm, BCM43xx_MACFILTER_ASSOC);
 	bcm43xx_macfilter_set(bcm, BCM43xx_MACFILTER_SELF, (u8 *)(bcm->net_dev->dev_addr));
 	bcm43xx_security_init(bcm);
+	drain_txstatus_queue(bcm);
 	ieee80211softmac_start(bcm->net_dev);
 
 	/* Let's go! Be careful after enabling the IRQs.

--
