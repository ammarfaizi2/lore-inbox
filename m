Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVH2W3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVH2W3Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 18:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVH2W2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 18:28:44 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:49543 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751374AbVH2W2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 18:28:34 -0400
Date: Tue, 30 Aug 2005 00:27:42 +0200
Message-Id: <200508292227.j7TMRgNY020033@wscnet.wsc.cz>
In-reply-to: <200508292220.j7TMKbNC019793@wscnet.wsc.cz>
Subject: [PATCH 7/7] arch: pci_find_device remove (sparc64/kernel/ebus.c)
From: Jiri Slaby <jirislaby@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, davem@davemloft.net,
       ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz, anton@samba.org,
       sparclinux@vger.kernel.org, ultralinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Generated in 2.6.13-rc6-mm2 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 ebus.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/sparc64/kernel/ebus.c b/arch/sparc64/kernel/ebus.c
--- a/arch/sparc64/kernel/ebus.c
+++ b/arch/sparc64/kernel/ebus.c
@@ -527,19 +527,13 @@ static struct pci_dev *find_next_ebus(st
 {
 	struct pci_dev *pdev = start;
 
-	do {
-		pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
-		if (pdev &&
-		    (pdev->device == PCI_DEVICE_ID_SUN_EBUS ||
-		     pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS))
+	while (pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev))
+		if (pdev->device == PCI_DEVICE_ID_SUN_EBUS ||
+			pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS)
 			break;
-	} while (pdev != NULL);
-
-	if (pdev && (pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS))
-		*is_rio_p = 1;
-	else
-		*is_rio_p = 0;
 
+	*is_rio_p = !!(pdev && (pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS));
+	
 	return pdev;
 }
 
@@ -637,6 +631,7 @@ void __init ebus_init(void)
 		ebus->is_rio = is_rio;
 		++num_ebus;
 	}
+	pci_dev_put(pdev); /* XXX for the case, when ebusnd is 0, is it OK? */
 
 #ifdef CONFIG_SUN_AUXIO
 	auxio_probe();
