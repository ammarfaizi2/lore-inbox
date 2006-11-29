Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758904AbWK2WqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758904AbWK2WqV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758905AbWK2WqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:46:21 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:8178 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1758904AbWK2WqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:46:20 -0500
Message-ID: <456E0DAF.90507@myri.com>
Date: Wed, 29 Nov 2006 17:46:07 -0500
From: Loic Prylli <loic@myri.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: mask/unmasking while servicing MSI(-X) unnecessary?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



While looking into using MSI-X for our myri10ge driver, we have seen
that the msi(x) code (driver/pci/msi.c) masks the MSI(-X) vector while
servicing an interrupt. We are not sure why this masking is needed (for
instance no such thing is done for "edge IOAPIC" interrupts). There
seems to be already several mechanisms each individually protecting
against "loosing an interrupt" without masking:
- the "x86" architecture is able to queue 2 interrupt messages. That
guarantees an interrupt handler will always start after the last MSI
received (even in the case of a big burst of MSI messages).
- Even if there wasn't that interrupt queuing, ack_APIC_irq() could be
moved in the ack() method. Then things would work without masking even
on a hypothetical platform where a new interrupt is completely ignored
(with no IRR-like register) while servicing the same vector (anyway
since this "msi" code is already tied to "x86" architecture
specificities, that hypothetical platform might not be relevant).
- Almost every driver/device have their own way of acknowledging
interrupts anyway, which also by itself makes the masking/unmasking
unnecessary.
- The masking by itself is racy unless the driver interrupt handler
starts by making sure the masking request has reached the device with
some kind of MMIO-read. Such a MMIO-read is normally the kind of costly
requests you are happy to get rid of in the MSI model.

So if it is not useful, it might be better to avoid that systematic
mask/unmask pair. This masking has a small but measurable performance
impact for our device/driver combo.

Would you agree to suppress that masking (sample patch following)? Or
otherwise, is there is a possibility of making it optional on a
per-device basis.

Thanks for any comment!


Loic Prylli
Myricom, Inc.

[PATCH] Don't mask the interrupt vector while servicing a MSI interrupt.


Signed-off-by: Loic Prylli <loic@myri.com>


---

 drivers/pci/msi.c |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)

98e9a27091c3ccdc8a8a72cea9ab9086fb258af3
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a83c1f5..af446e3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -200,19 +200,12 @@ static void shutdown_msi_irq(unsigned in
 	spin_unlock_irqrestore(&msi_lock, flags);
 }
 
-static void end_msi_irq_wo_maskbit(unsigned int vector)
+static void end_msi_irq(unsigned int vector)
 {
 	move_native_irq(vector);
 	ack_APIC_irq();
 }
 
-static void end_msi_irq_w_maskbit(unsigned int vector)
-{
-	move_native_irq(vector);
-	unmask_MSI_irq(vector);
-	ack_APIC_irq();
-}
-
 static void do_nothing(unsigned int vector)
 {
 }
@@ -227,8 +220,8 @@ static struct hw_interrupt_type msix_irq
 	.shutdown	= shutdown_msi_irq,
 	.enable		= unmask_MSI_irq,
 	.disable	= mask_MSI_irq,
-	.ack		= mask_MSI_irq,
-	.end		= end_msi_irq_w_maskbit,
+	.ack		= do_nothing,
+	.end		= end_msi_irq,
 	.set_affinity	= set_msi_affinity
 };
 
@@ -243,8 +236,8 @@ static struct hw_interrupt_type msi_irq_
 	.shutdown	= shutdown_msi_irq,
 	.enable		= unmask_MSI_irq,
 	.disable	= mask_MSI_irq,
-	.ack		= mask_MSI_irq,
-	.end		= end_msi_irq_w_maskbit,
+	.ack		= do_nothing,
+	.end		= end_msi_irq,
 	.set_affinity	= set_msi_affinity
 };
 
@@ -260,7 +253,7 @@ static struct hw_interrupt_type msi_irq_
 	.enable		= do_nothing,
 	.disable	= do_nothing,
 	.ack		= do_nothing,
-	.end		= end_msi_irq_wo_maskbit,
+	.end		= end_msi_irq,
 	.set_affinity	= set_msi_affinity
 };
 
-- 
1.3.2




