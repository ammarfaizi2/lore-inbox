Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWFQNV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWFQNV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 09:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWFQNV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 09:21:26 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:50106
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751577AbWFQNV0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 09:21:26 -0400
From: Michael Buesch <mb@bu3sch.de>
To: linville@tuxdriver.com
Subject: [PATCH 2.6.17 fix] bcm43xx: workaround init_board vs. IRQ race
Date: Sat, 17 Jun 2006 15:19:05 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606171519.05893.mb@bu3sch.de>
Cc: bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Please try to push this for 2.6.17, as it is a crash fix.

--

Place the Init-vs-IRQ workaround before any card register
access, because we might not have the wireless core mapped
at all times in init. So this will result in a Machine Check
caused by a bus error.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

Index: wireless-2.6/drivers/net/wireless/bcm43xx/bcm43xx_main.c
===================================================================
--- wireless-2.6.orig/drivers/net/wireless/bcm43xx/bcm43xx_main.c	2006-06-17 15:06:38.000000000 +0200
+++ wireless-2.6/drivers/net/wireless/bcm43xx/bcm43xx_main.c	2006-06-17 15:17:49.000000000 +0200
@@ -1885,6 +1885,15 @@
 
 	spin_lock(&bcm->irq_lock);
 
+	/* Only accept IRQs, if we are initialized properly.
+	 * This avoids an RX race while initializing.
+	 * We should probably not enable IRQs before we are initialized
+	 * completely, but some careful work is needed to fix this. I think it
+	 * is best to stay with this cheap workaround for now... .
+	 */
+	if (unlikely(bcm43xx_status(bcm) != BCM43xx_STAT_INITIALIZED))
+		goto out;
+
 	reason = bcm43xx_read32(bcm, BCM43xx_MMIO_GEN_IRQ_REASON);
 	if (reason == 0xffffffff) {
 		/* irq not for us (shared irq) */
@@ -1906,19 +1915,11 @@
 
 	bcm43xx_interrupt_ack(bcm, reason);
 
-	/* Only accept IRQs, if we are initialized properly.
-	 * This avoids an RX race while initializing.
-	 * We should probably not enable IRQs before we are initialized
-	 * completely, but some careful work is needed to fix this. I think it
-	 * is best to stay with this cheap workaround for now... .
-	 */
-	if (likely(bcm43xx_status(bcm) == BCM43xx_STAT_INITIALIZED)) {
-		/* disable all IRQs. They are enabled again in the bottom half. */
-		bcm->irq_savedstate = bcm43xx_interrupt_disable(bcm, BCM43xx_IRQ_ALL);
-		/* save the reason code and call our bottom half. */
-		bcm->irq_reason = reason;
-		tasklet_schedule(&bcm->isr_tasklet);
-	}
+	/* disable all IRQs. They are enabled again in the bottom half. */
+	bcm->irq_savedstate = bcm43xx_interrupt_disable(bcm, BCM43xx_IRQ_ALL);
+	/* save the reason code and call our bottom half. */
+	bcm->irq_reason = reason;
+	tasklet_schedule(&bcm->isr_tasklet);
 
 out:
 	mmiowb();
