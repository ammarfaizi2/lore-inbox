Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbUDORZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUDORZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:25:01 -0400
Received: from mail.kroah.org ([65.200.24.183]:15022 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263100AbUDORYD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:24:03 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and PCI Hotplug update for 2.6.6-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1082049825348@kroah.com>
Date: Thu, 15 Apr 2004 10:23:46 -0700
Message-Id: <1082049826312@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1692.3.10, 2004/03/31 14:57:52-08:00, dsaxena@plexity.net

[PATCH] PCI: Allow arch-specific pci_set_dma_mask and friends

The patch provides the ability for architectures to have custom
implementations of pci_set_dma_mask() and friends (dac_set_dma_mask
and set_consistent_dma_mask). The reason I need this is b/c I have
a chipset (Intel ARM IXP425) that has a broken PCI interface that
only allows PCI dma to/from the bottom 64MB of system memory.  To get
around this limitation, I trap a custom dma-mapping implementation that
bounces buffers outside the 64MB window. At device discover time, my
custom platform_notify() function gets called and it sets the dma_mask
to (64MB-1) and in ARM's dma-mapping code, I check for dma_mask != 0xffffffff
and if that is true, I call the special bounce helpers. This works great
except that certain drivers (e100, ide-pci) call pci_set_dma_mask()
with 0xffffffff and the generic implementation only allows for the
architecture-defined pci_dma_supported() to return true or false. There
is no method for the architecture to tell the PCI layer "I can't set
the mask to 0xffffffff, but I can set it to this other value" and there
is no way to pass that back to the driver. What this means is that if
I have pci_set_dma_supported() return failure on full 32-bit DMA, the
driver will not initialize the card; however, if I return true,
pci_set_dma_mask() will set the dma mask to full 32-bits and I can no
longer trap and will have buffers that are not dma-able and cause
PCI master aborts.  Both of those are not acceptable.  IMHO, the
driver shouldn't care if the architecture has to bounce DMA outside of
64MB and since this is not something most architectures have to worry
about, the easiest way to get around the issue is by allowing custom
pci_set_dma_mask() for arches that need it but keeping the generic
implementation for those that do not.  In my case, it simply returns
0 to the driver but keeps the device mask set to 64MB-1 so I can trap.


 drivers/pci/pci.c |    5 +++++
 1 files changed, 5 insertions(+)


diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Thu Apr 15 10:04:10 2004
+++ b/drivers/pci/pci.c	Thu Apr 15 10:04:10 2004
@@ -700,6 +700,10 @@
 	}
 }
 
+#ifndef HAVE_ARCH_PCI_SET_DMA_MASK
+/*
+ * These can be overridden by arch-specific implementations
+ */
 int
 pci_set_dma_mask(struct pci_dev *dev, u64 mask)
 {
@@ -732,6 +736,7 @@
 
 	return 0;
 }
+#endif
      
 static int __devinit pci_init(void)
 {

