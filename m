Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWCaACO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWCaACO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWCaACO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:02:14 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:9612 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751158AbWCaACN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:02:13 -0500
Date: Thu, 30 Mar 2006 18:02:08 -0600
To: john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH]: e1000: prevent statistics from getting garbled during reset.
Message-ID: <20060331000208.GS2172@austin.ibm.com>
References: <20060330213928.GQ2172@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330213928.GQ2172@austin.ibm.com>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 03:39:28PM -0600, Linas Vepstas wrote:
> 
> Please review, sign-off/ack, and forward upstream.
> --linas

Per feedback, here's a slightly more human-readable version.
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
 drivers/net/e1000/e1000_main.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.16-git6/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.16-git6.orig/drivers/net/e1000/e1000_main.c	2006-03-30 17:51:37.924162779 -0600
+++ linux-2.6.16-git6/drivers/net/e1000/e1000_main.c	2006-03-30 17:54:07.659188391 -0600
@@ -3069,14 +3069,18 @@ void
 e1000_update_stats(struct e1000_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
+	struct pci_dev *pdev = adapter->pdev;
 	unsigned long flags;
 	uint16_t phy_tmp;
 
 #define PHY_IDLE_ERROR_COUNT_MASK 0x00FF
 
-	/* Prevent stats update while adapter is being reset */
+	/* Prevent stats update while adapter is being reset,
+	 * or if the pci connection is down. */
 	if (adapter->link_speed == 0)
 		return;
+   if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
+		return;
 
 	spin_lock_irqsave(&adapter->stats_lock, flags);
 
