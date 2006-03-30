Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWC3Vju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWC3Vju (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWC3Vjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:39:49 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:52714 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750987AbWC3Vjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:39:48 -0500
Date: Thu, 30 Mar 2006 15:39:28 -0600
To: john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org
Subject: [PATCH]: e1000: prevent statistics from getting garbled during reset.
Message-ID: <20060330213928.GQ2172@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please review, sign-off/ack, and forward upstream.
--linas

[PATCH]: e1000: prevent statistics from getting garbled during reset.

If a PCI bus error/fault triggers a PCI bus reset, attempts to get the
ethernet packet count statistics from the hardware will fail, returning
garbage data upstream.  This patch skips statistics data collection
if the PCI device is not on the bus. 

This patch presumes that an earlier patch,
[PATCH] PCI Error Recovery: e1000 network device driver
has already been applied.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/e1000/e1000_main.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6.16-git6/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.16-git6.orig/drivers/net/e1000/e1000_main.c	2006-03-30 14:42:33.000000000 -0600
+++ linux-2.6.16-git6/drivers/net/e1000/e1000_main.c	2006-03-30 14:44:52.000000000 -0600
@@ -3069,13 +3069,17 @@ void
 e1000_update_stats(struct e1000_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
+	struct pci_dev *pdev = adapter->pdev;
 	unsigned long flags;
 	uint16_t phy_tmp;
 
 #define PHY_IDLE_ERROR_COUNT_MASK 0x00FF
 
-	/* Prevent stats update while adapter is being reset */
-	if (adapter->link_speed == 0)
+	/* Prevent stats update while adapter is being reset, or if
+	 * the pci connection is down. */
+	if ((adapter->link_speed == 0) ||
+       ((pdev->error_state != 0) &&
+	    (pdev->error_state != pci_channel_io_normal)))
 		return;
 
 	spin_lock_irqsave(&adapter->stats_lock, flags);
