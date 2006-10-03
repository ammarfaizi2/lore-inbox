Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030622AbWJCWYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030622AbWJCWYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWJCWYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:24:07 -0400
Received: from hu-out-0506.google.com ([72.14.214.232]:13080 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030622AbWJCWYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:24:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=eywMXdOskuUTYL+hlVBK0k0ct+6Mqfs5KOnml5N7+ZAuf1IVzx6wCXj+6Nvy65jN6tzHLIsvhy6sHvm9RTslYbdNEMOhcGqxPCd1Zp8Qa/eg1OcPi+jIDIMX4iC4AUI0F4YNopZR00UA6JBRodnteXsf4DiYJ3txPRQcd2sxOFY=
Date: Tue, 3 Oct 2006 22:23:45 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: linux-kernel@vger.kernel.org
Cc: arjan@infradead.org, matthew@wil.cx, alan@lxorguk.ukuu.org.uk,
       jeff@garzik.org, akpm@osdl.org, rdunlap@xenotime.net, gregkh@suse.de
Subject: [RFC PATCH] move e1000 to pci_request_irq
Message-ID: <20061003222345.GI2785@slug>
References: <20061003220732.GE2785@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003220732.GE2785@slug>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This proof-of-concept patch converts the e1000 driver to use the
pci_request_irq() function.

Please note that I'm not submitting the driver changes, they're there
only for illustration purposes. I'll CC the appropriate maintainers
when/if an API is agreed upon.

Regards,
Frederik 


diff --git a/drivers/net/e1000/e1000_ethtool.c b/drivers/net/e1000/e1000_ethtool.c
index 778ede3..8b7be73 100644
Index: 2.6.18-mm3/drivers/net/e1000/e1000_ethtool.c
===================================================================
--- 2.6.18-mm3.orig/drivers/net/e1000/e1000_ethtool.c
+++ 2.6.18-mm3/drivers/net/e1000/e1000_ethtool.c
@@ -899,17 +899,16 @@ e1000_intr_test(struct e1000_adapter *ad
 {
 	struct net_device *netdev = adapter->netdev;
 	uint32_t mask, i=0, shared_int = TRUE;
-	uint32_t irq = adapter->pdev->irq;
 
 	*data = 0;
 
 	/* NOTE: we don't test MSI interrupts here, yet */
 	/* Hook up test interrupt handler just for this test */
-	if (!request_irq(irq, &e1000_test_intr, IRQF_PROBE_SHARED,
-			 netdev->name, netdev))
+	if (!pci_request_irq(adapter->pdev, &e1000_test_intr, IRQF_PROBE_SHARED,
+			    netdev->name))
 		shared_int = FALSE;
-	else if (request_irq(irq, &e1000_test_intr, IRQF_SHARED,
-			      netdev->name, netdev)) {
+	else if (pci_request_irq(adapter->pdev, &e1000_test_intr, IRQF_SHARED,
+		 		 netdev->name)) {
 		*data = 1;
 		return -1;
 	}
@@ -986,7 +985,7 @@ e1000_intr_test(struct e1000_adapter *ad
 	msleep(10);
 
 	/* Unhook test interrupt handler */
-	free_irq(irq, netdev);
+	pci_free_irq(adapter->pdev);
 
 	return *data;
 }
Index: 2.6.18-mm3/drivers/net/e1000/e1000_main.c
===================================================================
--- 2.6.18-mm3.orig/drivers/net/e1000/e1000_main.c
+++ 2.6.18-mm3/drivers/net/e1000/e1000_main.c
@@ -296,19 +296,13 @@ static int e1000_request_irq(struct e100
 	if (adapter->have_msi)
 		flags &= ~IRQF_SHARED;
 #endif
-	if ((err = request_irq(adapter->pdev->irq, &e1000_intr, flags,
-	                       netdev->name, netdev)))
-		DPRINTK(PROBE, ERR,
-		        "Unable to allocate interrupt Error: %d\n", err);
-
+	err = pci_request_irq(adapter->pdev, &e1000_intr, flags, netdev->name);
 	return err;
 }
 
 static void e1000_free_irq(struct e1000_adapter *adapter)
 {
-	struct net_device *netdev = adapter->netdev;
-
-	free_irq(adapter->pdev->irq, netdev);
+	pci_free_irq(adapter->pdev);
 
 #ifdef CONFIG_PCI_MSI
 	if (adapter->have_msi)
