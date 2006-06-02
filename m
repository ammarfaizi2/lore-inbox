Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWFBTVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWFBTVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWFBTVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:21:40 -0400
Received: from barracuda.s2io.com ([72.1.205.138]:25500 "EHLO
	barracuda.mail.s2io.com") by vger.kernel.org with ESMTP
	id S1751443AbWFBTVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:21:39 -0400
X-ASG-Debug-ID: 1149276098-16569-10-0
X-Barracuda-URL: http://72.1.205.138:8000/cgi-bin/mark.cgi
Date: Fri, 2 Jun 2006 15:21:37 -0400 (EDT)
From: Ravinandan Arakali <Ravinandan.Arakali@neterion.com>
To: linux-kernel@vger.kernel.org
cc: netdev@vger.kernel.org, leonid.grossman@neterion.com,
       ananda.raju@neterion.com, rapuru.sriram@neterion.com,
       ravinandan.arakali@neterion.com
X-ASG-Orig-Subj: [PATCH 2.6.16.18] MSI: Proposed fix for MSI/MSI-X load failure
Subject: [PATCH 2.6.16.18] MSI: Proposed fix for MSI/MSI-X load failure
Message-ID: <Pine.GSO.4.10.10606021518500.9289-100000@guinness>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.13979
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch suggests a fix for the MSI/MSI-X load failure.

Please review the patch.

Symptoms:
When a driver is loaded with MSI followed by MSI-X, the load fails indicating 
that the MSI vector is still active. And vice versa.

Suspected rootcause:
This happens inspite of driver calling free_irq() followed by 
pci_disable_msi/pci_disable_msix. This appears to be a kernel bug 
wherein the pci_disable_msi and pci_disable_msix calls do not 
clear/unpopulate the msi_desc data structure that was populated 
by pci_enable_msi/pci_enable_msix.

Proposed fix:
Free the MSI vector in pci_disable_msi and all allocated MSI-X vectors 
in pci_disable_msix.

Testing:
The fix has been tested on IA64 platforms with Neterion's Xframe driver.

Signed-off-by: Ravinandan Arakali <ravinandan.arakali@neterion.com>
---

diff -urpN old/drivers/pci/msi.c new/drivers/pci/msi.c
--- old/drivers/pci/msi.c	2006-05-31 19:02:19.000000000 -0700
+++ new/drivers/pci/msi.c	2006-05-31 19:02:39.000000000 -0700
@@ -779,6 +779,7 @@ void pci_disable_msi(struct pci_dev* dev
 		nr_released_vectors++;
 		default_vector = entry->msi_attrib.default_vector;
 		spin_unlock_irqrestore(&msi_lock, flags);
+		msi_free_vector(dev, dev->irq, 1);
 		/* Restore dev->irq to its default pin-assertion vector */
 		dev->irq = default_vector;
 		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
@@ -1046,6 +1047,7 @@ void pci_disable_msix(struct pci_dev* de
 
 		}
 	}
+	msi_remove_pci_irq_vectors(dev);
 }
 
 /**

