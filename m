Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWFRRGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWFRRGd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 13:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWFRRGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 13:06:33 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:48526
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932261AbWFRRGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 13:06:32 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Greg KH <gregkh@suse.de>
Subject: Re: Linux v2.6.17
Date: Sun, 18 Jun 2006 19:05:10 +0200
User-Agent: KMail/1.9.1
References: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org> <200606181254.13600.mb@bu3sch.de> <44958391.6050800@tomt.net>
In-Reply-To: <44958391.6050800@tomt.net>
Cc: Andre Tomt <andre@tomt.net>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, bcm43xx-dev@lists.berlios.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606181905.11277.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 June 2006 18:47, Andre Tomt wrote:
> Michael Buesch wrote:
> > On Sunday 18 June 2006 03:59, Linus Torvalds wrote:
> >> Not a lot of changes since the last -rc, the bulk is actually some 
> >> last-minute MIPS updates and s390 futex changes, the rest tend to be 
> >> various very small fixes that trickled in over the last week.
> > 
> > D'oh, please queue the following patch for -stable, Greg. ;)
> 
> I'm unable to apply it on top a clean 2.6.17 using patch -p1 < mailfile.
> 
> Hunk #2 FAILED at 1900.
> 1 out of 2 hunks FAILED -- saving rejects to file 
> drivers/net/wireless/bcm43xx/bcm43xx_main.c.rej

Ok, I'm sorry. The patch was from wireless-dev.
Here's the adjusted patch:

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
