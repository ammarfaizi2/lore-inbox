Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbULBQVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbULBQVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbULBQVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:21:24 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:61610 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261658AbULBQVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:21:21 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix DAC960 hang in 2.6.10-rc2
Date: Thu, 2 Dec 2004 09:21:15 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7D0rBzgJp+lo/ym"
Message-Id: <200412020921.15925.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_7D0rBzgJp+lo/ym
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The DAC960 driver looks at PCI_Device->irq before calling
pci_enable_device(), which means it requests the wrong IRQ
and hangs.  The attached patch fixes it.

--Boundary-00=_7D0rBzgJp+lo/ym
Content-Type: text/x-diff;
  charset="us-ascii";
  name="DAC960-irq-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="DAC960-irq-fix"

Don't look at PCI_Device->irq until *after* calling pci_enable_device().

Thanks to Johannes Rommel for reporting the problem and testing the fix.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/block/DAC960.c 1.74 vs edited =====
--- 1.74/drivers/block/DAC960.c	2004-10-05 13:57:21 -06:00
+++ edited/drivers/block/DAC960.c	2004-11-29 10:12:07 -07:00
@@ -2678,7 +2678,7 @@
   DAC960_Controller_T *Controller = NULL;
   unsigned char DeviceFunction = PCI_Device->devfn;
   unsigned char ErrorStatus, Parameter0, Parameter1;
-  unsigned int IRQ_Channel = PCI_Device->irq;
+  unsigned int IRQ_Channel;
   void __iomem *BaseAddress;
   int i;
 
@@ -2958,6 +2958,7 @@
   /*
      Acquire shared access to the IRQ Channel.
   */
+  IRQ_Channel = PCI_Device->irq;
   if (request_irq(IRQ_Channel, InterruptHandler, SA_SHIRQ,
 		      Controller->FullModelName, Controller) < 0)
   {

--Boundary-00=_7D0rBzgJp+lo/ym--
