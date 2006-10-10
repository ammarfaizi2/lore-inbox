Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWJJNiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWJJNiT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWJJNiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:38:19 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:30440 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1750762AbWJJNiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:38:18 -0400
From: Matthew Wilcox <matthew@wil.cx>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] [PCI] Prevent user config space access during power state transitions
Reply-To: Matthew Wilcox <matthew@wil.cx>
Date: Tue, 10 Oct 2006 07:38:17 -0600
Message-Id: <1160487497203-git-send-email-matthew@wil.cx>
X-Mailer: git-send-email 1.4.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Section 5.3 of PCI Bus Power Management 1.2 states:

  There is a minimum recovery time requirement of 200 µs between when
  a function is programmed from D2 to D0 and when the function can be
  next accessed as a target (including PCI configuration accesses). If
  an access is attempted in violation of the specified minimum recovery
  time, undefined system behavior may result.

We have to prevent the user running lspci during this time, and
fortunately we already have the pci_block_user_cfg_access() API to
do this.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
---
 drivers/pci/pci.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a544997..1bb059a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -366,6 +366,11 @@ pci_set_power_state(struct pci_dev *dev,
 		break;
 	}
 
+	/* We have to prevent accesses to config space while transitioning
+	 * between power states
+	 */
+	pci_block_user_cfg_access(dev);
+
 	/* enter specified state */
 	pci_write_config_word(dev, pm + PCI_PM_CTRL, pmcsr);
 
@@ -383,6 +388,9 @@ pci_set_power_state(struct pci_dev *dev,
 	if (platform_pci_set_power_state)
 		platform_pci_set_power_state(dev, state);
 
+	/* Should be safe to allow userspace access to the device again now */
+	pci_unblock_user_cfg_access(dev);
+
 	dev->current_state = state;
 
 	/* According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
-- 
1.4.1.1

