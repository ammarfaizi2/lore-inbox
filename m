Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161276AbWF0UQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161276AbWF0UQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWF0UQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:16:32 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:42880 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161275AbWF0UQa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:16:30 -0400
Message-Id: <20060627201358.197578000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:14 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, Greg KH <gregkh@suse.de>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Michael Buesch <mb@bu3sch.de>
Subject: [PATCH 14/25] bcm43xx: init fix for possible Machine Check
Content-Disposition: inline; filename=bcm43xx-init-fix-for-possible-machine-check.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Michael Buesch <mb@bu3sch.de>

Place the Init-vs-IRQ workaround before any card register
access, because we might not have the wireless core mapped
at all times in init. So this will result in a Machine Check
caused by a bus error.

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/net/wireless/bcm43xx/bcm43xx_main.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

--- linux-2.6.17.1.orig/drivers/net/wireless/bcm43xx/bcm43xx_main.c
+++ linux-2.6.17.1/drivers/net/wireless/bcm43xx/bcm43xx_main.c
@@ -1870,6 +1870,15 @@ static irqreturn_t bcm43xx_interrupt_han
 
 	spin_lock(&bcm->_lock);
 
+	/* Only accept IRQs, if we are initialized properly.
+	 * This avoids an RX race while initializing.
+	 * We should probably not enable IRQs before we are initialized
+	 * completely, but some careful work is needed to fix this. I think it
+	 * is best to stay with this cheap workaround for now... .
+	 */
+	if (unlikely(!bcm->initialized))
+		goto out;
+
 	reason = bcm43xx_read32(bcm, BCM43xx_MMIO_GEN_IRQ_REASON);
 	if (reason == 0xffffffff) {
 		/* irq not for us (shared irq) */
@@ -1891,20 +1900,11 @@ static irqreturn_t bcm43xx_interrupt_han
 
 	bcm43xx_interrupt_ack(bcm, reason);
 
-	/* Only accept IRQs, if we are initialized properly.
-	 * This avoids an RX race while initializing.
-	 * We should probably not enable IRQs before we are initialized
-	 * completely, but some careful work is needed to fix this. I think it
-	 * is best to stay with this cheap workaround for now... .
-	 */
-	if (likely(bcm->initialized)) {
-		/* disable all IRQs. They are enabled again in the bottom half. */
-		bcm->irq_savedstate = bcm43xx_interrupt_disable(bcm, BCM43xx_IRQ_ALL);
-		/* save the reason code and call our bottom half. */
-		bcm->irq_reason = reason;
-		tasklet_schedule(&bcm->isr_tasklet);
-	}
-
+	/* disable all IRQs. They are enabled again in the bottom half. */
+	bcm->irq_savedstate = bcm43xx_interrupt_disable(bcm, BCM43xx_IRQ_ALL);
+	/* save the reason code and call our bottom half. */
+	bcm->irq_reason = reason;
+	tasklet_schedule(&bcm->isr_tasklet);
 out:
 	mmiowb();
 	spin_unlock(&bcm->_lock);

--
