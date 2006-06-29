Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWF2ULR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWF2ULR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWF2ULR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:11:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:18066 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932396AbWF2ULP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:11:15 -0400
Date: Thu, 29 Jun 2006 15:11:13 -0500
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       netdev@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 2/2]: e1000 disable device on PCI error
Message-ID: <20060629201113.GB29526@austin.ibm.com>
References: <20060629200644.GA29526@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629200644.GA29526@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Same as last patch, but for the e1000 gigabit card.

A recent patch in -mm3 titled 
 "gregkh-pci-pci-don-t-enable-device-if-already-enabled.patch"
causes pci_enable_device() to be a no-op if the kernel thinks
that the device is already enabled.  This change breaks the
PCI error recovery mechanism in the e1000 device driver, since, 
after PCI slot reset, the card is no longer enabled. This is 
a trivial fix for this problem. Tested.

Please submit uptream.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/net/e1000/e1000_main.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.17-mm3/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.17-mm3.orig/drivers/net/e1000/e1000_main.c	2006-06-27 12:30:02.000000000 -0500
+++ linux-2.6.17-mm3/drivers/net/e1000/e1000_main.c	2006-06-29 14:52:29.000000000 -0500
@@ -4640,6 +4640,7 @@ static pci_ers_result_t e1000_io_error_d
 
 	if (netif_running(netdev))
 		e1000_down(adapter);
+	pci_disable_device(pdev);
 
 	/* Request a slot slot reset. */
 	return PCI_ERS_RESULT_NEED_RESET;
