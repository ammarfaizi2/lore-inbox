Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbVI1VxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbVI1VxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVI1VxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:53:19 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:30213 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751016AbVI1VxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:53:02 -0400
Date: Wed, 28 Sep 2005 17:50:51 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Cc: gregkh@suse.de
Subject: [patch 2.6.14-rc2] pci: cleanup need_restore switch statement
Message-ID: <09282005175051.10635@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the need_restore switch statement in
pci_set_power_state(). This makes it more safe by explicitly handling
all the PCI power states instead of handling them as the default
case. It also reads a little better IMHO.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/pci/pci.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -314,19 +314,19 @@ pci_set_power_state(struct pci_dev *dev,
 	 * sets PowerState to 0.
 	 */
 	switch (dev->current_state) {
+	case PCI_D0:
+	case PCI_D1:
+	case PCI_D2:
+		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
+		pmcsr |= state;
+		break;
 	case PCI_UNKNOWN: /* Boot-up */
 		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
 		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
 			need_restore = 1;
 		/* Fall-through: force to D0 */
-	case PCI_D3hot:
-	case PCI_D3cold:
-	case PCI_POWER_ERROR:
-		pmcsr = 0;
-		break;
 	default:
-		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
-		pmcsr |= state;
+		pmcsr = 0;
 		break;
 	}
 
