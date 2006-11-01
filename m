Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946262AbWKAFgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946262AbWKAFgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946146AbWKAFgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:36:15 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:10695 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946111AbWKAFfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:35:15 -0500
Message-Id: <20061101053531.548174000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:45 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 05/61] sky2: MSI test race and message
Content-Disposition: inline; filename=sky2-msi-test-race-and-message.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Stephen Hemminger <shemminger@osdl.org>

Make sure and do PCI reads after writes in the MSI test setup code.

Some motherboards don't implement MSI correctly. The driver handles this
but the warning is too verbose and overly cautious.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/net/sky2.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.18.1.orig/drivers/net/sky2.c
+++ linux-2.6.18.1/drivers/net/sky2.c
@@ -3208,6 +3208,8 @@ static int __devinit sky2_test_msi(struc
 	struct pci_dev *pdev = hw->pdev;
 	int err;
 
+	init_waitqueue_head (&hw->msi_wait);
+
 	sky2_write32(hw, B0_IMSK, Y2_IS_IRQ_SW);
 
 	err = request_irq(pdev->irq, sky2_test_intr, IRQF_SHARED, DRV_NAME, hw);
@@ -3217,18 +3219,15 @@ static int __devinit sky2_test_msi(struc
 		return err;
 	}
 
-	init_waitqueue_head (&hw->msi_wait);
-
 	sky2_write8(hw, B0_CTST, CS_ST_SW_IRQ);
-	wmb();
+	sky2_read8(hw, B0_CTST);
 
 	wait_event_timeout(hw->msi_wait, hw->msi_detected, HZ/10);
 
 	if (!hw->msi_detected) {
 		/* MSI test failed, go back to INTx mode */
-		printk(KERN_WARNING PFX "%s: No interrupt was generated using MSI, "
-		       "switching to INTx mode. Please report this failure to "
-		       "the PCI maintainer and include system chipset information.\n",
+		printk(KERN_INFO PFX "%s: No interrupt generated using MSI, "
+		       "switching to INTx mode.\n",
 		       pci_name(pdev));
 
 		err = -EOPNOTSUPP;
@@ -3236,6 +3235,7 @@ static int __devinit sky2_test_msi(struc
 	}
 
 	sky2_write32(hw, B0_IMSK, 0);
+	sky2_read32(hw, B0_IMSK);
 
 	free_irq(pdev->irq, hw);
 

--
