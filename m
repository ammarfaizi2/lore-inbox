Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750794AbWFEIgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWFEIgu (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWFEIg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:36:29 -0400
Received: from peabody.ximian.com ([130.57.169.10]:28302 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1750771AbWFEIgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:36:25 -0400
Subject: [PATCH 7/9] PCI PM: handle PMCSR more carefully
From: Adam Belay <abelay@novell.com>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Type: text/plain
Date: Mon, 05 Jun 2006 04:46:13 -0400
Message-Id: <1149497174.7831.161.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes __pci_set_power_state() such that it only modifies
the power state byte in PMCSR.   Otherwise a PME event might
accidentally be cleared (when entering a state greater than D0), or
PME_En might be cleared (when returning to D0) despite the device driver
intending to leave it enabled in D0.

Signed-off-by: Adam Belay <abelay@novell.com>

---
 pm.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff -urN a/drivers/pci/pm.c b/drivers/pci/pm.c
--- a/drivers/pci/pm.c	2006-06-04 02:41:21.000000000 -0400
+++ b/drivers/pci/pm.c	2006-06-04 03:39:20.000000000 -0400
@@ -114,23 +114,9 @@
 static void __pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	struct pci_dev_pm *pm = dev->pm;
-	u16 pmcsr;
-
-	pci_read_config_word(dev, pm->pm_offset + PCI_PM_CTRL, &pmcsr);
-
-	/* If we're (effectively) in D3, force entire word to 0.
-	 * This doesn't affect PME_Status, disables PME_En, and
-	 * sets PowerState to 0.
-	 */
-	if (dev->current_state == PCI_D3) {
-		pmcsr = 0;
-	} else {
-		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
-		pmcsr |= state;
-	}
 
 	/* enter specified state */
-	pci_write_config_word(dev, pm->pm_offset + PCI_PM_CTRL, pmcsr);
+	pci_write_config_byte(dev, pm->pm_offset + PCI_PM_CTRL, state);
 
 	/* Mandatory power management transition delays */
 	/* see PCI PM 1.1 5.6.1 table 18 */


