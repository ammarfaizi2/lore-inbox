Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265167AbTFEU6B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbTFEUtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:49:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:38069 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264864AbTFEUrA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:47:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10548468773655@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.70
In-Reply-To: <10548468772648@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 5 Jun 2003 14:01:17 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1313, 2003/06/05 12:03:52-07:00, greg@kroah.com

[PATCH] PCI: fix up previous fusion driver pci changes

This makes the driver build properly now, and removes a direct access
of the pci_devices variable.


 drivers/message/fusion/linux_compat.h |    7 ++-----
 drivers/message/fusion/mptbase.c      |    2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)


diff -Nru a/drivers/message/fusion/linux_compat.h b/drivers/message/fusion/linux_compat.h
--- a/drivers/message/fusion/linux_compat.h	Thu Jun  5 13:53:01 2003
+++ b/drivers/message/fusion/linux_compat.h	Thu Jun  5 13:53:01 2003
@@ -147,9 +147,7 @@
 
 
 /* PCI/driver subsystem { */
-#ifndef pci_for_each_dev
-#define pci_for_each_dev(dev)		for((dev)=pci_devices; (dev)!=NULL; (dev)=(dev)->next)
-#define pci_peek_next_dev(dev)		((dev)->next ? (dev)->next : NULL)
+#if 0	/* FIXME Don't know what to use to check for the proper kernel version */
 #define DEVICE_COUNT_RESOURCE           6
 #define PCI_BASEADDR_FLAGS(idx)         base_address[idx]
 #define PCI_BASEADDR_START(idx)         base_address[idx] & ~0xFUL
@@ -169,11 +167,10 @@
 	(4 - size); \
 })
 #else
-#define pci_peek_next_dev(dev)		((dev) != pci_dev_g(&pci_devices) ? pci_dev_g((dev)->global_list.next) : NULL)
 #define PCI_BASEADDR_FLAGS(idx)         resource[idx].flags
 #define PCI_BASEADDR_START(idx)         resource[idx].start
 #define PCI_BASEADDR_SIZE(dev,idx)      (dev)->resource[idx].end - (dev)->resource[idx].start + 1
-#endif		/* } ifndef pci_for_each_dev */
+#endif		/* } ifndef 0 */
 
 
 /* Compatability for the 2.3.x PCI DMA API. */
diff -Nru a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
--- a/drivers/message/fusion/mptbase.c	Thu Jun  5 13:53:01 2003
+++ b/drivers/message/fusion/mptbase.c	Thu Jun  5 13:53:01 2003
@@ -1184,7 +1184,7 @@
 		 * Do some kind of look ahead here...
 		 */
 		if (pdev->devfn & 1) {
-			pdev2 = pci_peek_next_dev(pdev);
+			pdev2 = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev);
 			if (pdev2 && (pdev2->vendor == 0x1000) &&
 			    (PCI_SLOT(pdev2->devfn) == PCI_SLOT(pdev->devfn)) &&
 			    (pdev2->device == pdev->device) &&

