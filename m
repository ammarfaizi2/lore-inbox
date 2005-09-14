Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbVINNxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbVINNxZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbVINNxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:53:25 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:23558 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S965211AbVINNxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:53:24 -0400
Date: Wed, 14 Sep 2005 09:52:42 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org
Cc: torvalds@osdl.org, akpm@osdl.org, ink@jurassic.park.msu.ru, kaos@sgi.com,
       greg@kroah.com, davem@davemloft.net, rmk+lkml@arm.linux.org.uk,
       matthew@wil.cx, grundler@parisc-linux.org, ambx1@neo.rr.com
Subject: [patch 2.6.14-rc1] pci: only call pci_restore_bars at boot
Message-ID: <09142005095242.32027@bilbo.tuxdriver.com>
In-Reply-To: <20050727141942.GB22686@tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Certain (SGI?) ia64 boxes object to having their PCI BARs
restored unless absolutely necessary. This patch restricts calling
pci_restore_bars from pci_set_power_state unless the current state
is PCI_UNKNOWN, the actual (i.e. physical) state of the device is
PCI_D3hot, and the device indicates that it will lose its configuration
when transitioning to PCI_D0.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
Many thanks to Keith Owens <kaos@sgi.com> for a) narrowing-down the
problem; and, b) quickly testing the fix and reporting the results.

 drivers/pci/pci.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -309,17 +309,25 @@ pci_set_power_state(struct pci_dev *dev,
 
 	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
 
-	/* If we're in D3, force entire word to 0.
+	/* If we're (effectively) in D3, force entire word to 0.
 	 * This doesn't affect PME_Status, disables PME_En, and
 	 * sets PowerState to 0.
 	 */
-	if (dev->current_state >= PCI_D3hot) {
-		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
+	switch (dev->current_state) {
+	case PCI_UNKNOWN: /* Boot-up */
+		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
+		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
 			need_restore = 1;
+		/* Fall-through: force to D0 */
+	case PCI_D3hot:
+	case PCI_D3cold:
+	case PCI_POWER_ERROR:
 		pmcsr = 0;
-	} else {
+		break;
+	default:
 		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
 		pmcsr |= state;
+		break;
 	}
 
 	/* enter specified state */
