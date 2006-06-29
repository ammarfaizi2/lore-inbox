Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWF2UGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWF2UGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWF2UGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:06:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:51592 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932385AbWF2UGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:06:47 -0400
Date: Thu, 29 Jun 2006 15:06:44 -0500
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       netdev@vger.kernel.org, akpm@osdl.org
Subject: Subject: [PATCH 1/2]: e100 disable device on PCI error
Message-ID: <20060629200644.GA29526@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A recent patch in -mm3 titled 
  "gregkh-pci-pci-don-t-enable-device-if-already-enabled.patch"
causes pci_enable_device() to be a no-op if the kernel thinks
that the device is already enabled.  This change breaks the
PCI error recovery mechanism in the e100 device driver, since, 
after PCI slot reset, the card is no longer enabled. This is 
a trivial fix for this problem. Tested.

Please submit uptream.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/e100.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.17-mm3/drivers/net/e100.c
===================================================================
--- linux-2.6.17-mm3.orig/drivers/net/e100.c	2006-06-27 11:39:08.000000000 -0500
+++ linux-2.6.17-mm3/drivers/net/e100.c	2006-06-29 14:18:40.000000000 -0500
@@ -2742,6 +2742,7 @@ static pci_ers_result_t e100_io_error_de
 	/* Detach; put netif into state similar to hotplug unplug. */
 	netif_poll_enable(netdev);
 	netif_device_detach(netdev);
+	pci_disable_device(pdev);
 
 	/* Request a slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
