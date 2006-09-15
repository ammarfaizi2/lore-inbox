Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWIONtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWIONtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWIONtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:49:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44745 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751449AbWIONtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:49:15 -0400
Subject: [PATCH] mxser: PCI refcounts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:12:58 +0100
Message-Id: <1158329578.29932.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to pci ref counts for mxser when handling PCI devices. Use
pci_get_device and drop the reference when we finish and unload.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/char/mxser.c linux-2.6.18-rc6-mm1/drivers/char/mxser.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/char/mxser.c	2006-09-11 17:00:09.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/char/mxser.c	2006-09-14 16:14:52.000000000 +0100
@@ -538,6 +538,7 @@
 			if (pdev != NULL) {	/* PCI */
 				release_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2));
 				release_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3));
+				pci_dev_put(pdev);
 			} else {
 				release_region(mxsercfg[i].ioaddr[0], 8 * mxsercfg[i].ports);
 				release_region(mxsercfg[i].vector, 1);
@@ -862,9 +865,9 @@
 	index = 0;
 	b = 0;
 	while (b < n) {
-		pdev = pci_find_device(mxser_pcibrds[b].vendor,
+		pdev = pci_get_device(mxser_pcibrds[b].vendor,
 				mxser_pcibrds[b].device, pdev);
-			if (pdev == NULL) {
+		if (pdev == NULL) {
 			b++;
 			continue;
 		}
@@ -916,6 +919,9 @@
 			if (mxser_initbrd(m, &hwconf) < 0)
 				continue;
 			m++;
+			/* Keep an extra reference if we succeeded. It will
+			   be returned at unload time */
+			pci_dev_get(pdev);
 		}
 	}
 #endif

