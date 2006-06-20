Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWFTKgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWFTKgQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWFTKgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:36:16 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:5830
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S964790AbWFTKgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:36:15 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: Linux 2.6.17.1
Date: Tue, 20 Jun 2006 12:35:19 +0200
User-Agent: KMail/1.9.1
References: <20060620101350.GE23467@sequoia.sous-sol.org>
In-Reply-To: <20060620101350.GE23467@sequoia.sous-sol.org>
Cc: stable@kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606201235.19811.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 12:13, Chris Wright wrote:
> We (the -stable team) are announcing the release of the 2.6.17.1 kernel.

Please consider inclusion of the following patch into 2.6.17.2:

It fixes a possible crash. Might be triggerable in networks with
heavy traffic. I only saw it once so far, though.

--

Place the Init-vs-IRQ workaround before any card register
access, because we might not have the wireless core mapped
at all times in init. So this will result in a Machine Check
caused by a bus error.

Signed-off-by: Michael Buesch <mb@bu3sch.de>

Index: tmp/drivers/net/wireless/bcm43xx/bcm43xx_main.c
===================================================================
--- tmp.orig/drivers/net/wireless/bcm43xx/bcm43xx_main.c	2006-06-18 18:51:48.000000000 +0200
+++ tmp/drivers/net/wireless/bcm43xx/bcm43xx_main.c	2006-06-18 19:02:19.000000000 +0200
@@ -1870,6 +1870,15 @@
 
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
@@ -1891,20 +1900,11 @@
 
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
Greetings Michael.
